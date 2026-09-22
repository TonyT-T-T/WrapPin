# 模拟位置精度调研

调研分支：`codex/location-accuracy-research`，从 `main` 的 `4ef99d1` 创建，现已合入 1.0.9 主分支 `681d119`。用户反馈的核心现象是 **WrapPin 中的位置与 Apple 地图的模拟定位蓝点约相差 1 公里**。现已有苏州中心广场的截图和一组坐标，但仍缺模拟期间的真机原始定位回调，不能最终认定根因。

## 已取得的苏州样本

- 同一时间（18:26）的截图中，WrapPin 显示“模拟定位中”，选中“苏州中心广场，苏州市星港街 167 号”；Apple 地图蓝点显示在其东南方向、金鸡湖西南侧，接近湖滨新天地。两张图使用不同的缩放和中心，不能只凭屏幕像素精确测出米数。
- 用户提供的 `31.316633, 120.677664` 与[高德“苏州中心广场”地点页](https://ditu.amap.com/place/B0FFG1H9ZD)公布的地点、地址和六位小数坐标完全相同。高德说明其坐标为 GCJ-02；这使“选点坐标被当作 WGS84 注入系统”成为**高优先级假设**。
- 随后用户在 Apple 地图搜索这组坐标，19:08 的截图中搜索图钉落在苏州中心广场，蓝点仍在东南侧。同一张地图内的两点确实分开，推翻了“搜索图钉会落在蓝点附近”的原判别预期。但这张截图不显示 WrapPin 会话状态，不能单独证明此刻仍在模拟；搜索结果也是具名地点，可能经过 POI 匹配，无法据此认定 Apple 地图如何解释原始数字。
- 用开源 [EvilTransform 的 WGS84→GCJ-02 近似算法](https://github.com/googollee/eviltransform/blob/master/swift/LocationTransform.swift)做**诊断性推演**：若将 `31.316633, 120.677664` 当作 WGS84 再投到 GCJ-02 地图上，约得到 `31.314555, 120.681940`，即向东约 406 米、向南约 231 米，合计约 467 米。推演方向与蓝点截图吻合，但不是蓝点的实测坐标，也不是生产环境可直接采用的转换依据。
- 用户确认在 WrapPin 中直接输入坐标模拟时也复现相同现象：WrapPin 指向苏州中心，Apple 地图蓝点在其东南侧。这排除了仅由“搜索地点名称选错”造成的解释；此反馈不作为先前反推测试值的验收结果。
- 目前仍无法读取 Apple 地图蓝点的原始经纬度或定位来源。因此不能把这次偏移直接当作已证实的 MapKit 坐标系行为，更不能据此提交全局坐标补偿。

## 优先排查：选点坐标与模拟服务的坐标系

Apple 将 `CLLocationCoordinate2D` 定义为 WGS84 坐标；高德地图使用 GCJ-02。坐标来源与目标服务的坐标系若不一致，同一组数字会表示不同地点。本样本恰好与高德地点坐标相同，但 Apple 没有在这些 API 文档中明确说明中国大陆 MapKit 选点和开发者模拟定位之间是否自动转换。要测出边界上的实际行为，不能只凭约 1 公里的距离判定，也不能对所有中国大陆坐标固定加减一个偏移量。

本样本已经确认比较的是 WrapPin 选点标记与启动模拟后的 Apple 地图蓝点，而不是高德和苹果两张地图的静态标记。需要验证坐标来源，以及 Apple 地图实际收到和显示了什么。

## 先定义问题

请分别记录以下现象，避免把它们混为一种“精度不够”：

1. **选点偏差**：WrapPin 地图上的标记与用户想选的建筑、道路或搜索结果不重合。
2. **固定位置偏差**：接收定位的 App 得到的经纬度与 WrapPin 已选坐标不同。
3. **地图显示偏差**：两个 App 显示的位置不同，但收到的经纬度相同。要确认地图数据、坐标来源与目标 App 自身的处理。
4. **路线偏差或跳动**：路线起点、终点或中途位置偏离预期；分别看路线规划、更新间隔与后台运行。
5. **时间上的漂移**：同一固定坐标启动后，接收定位的 App 随时间显示不同位置。记录每次位置回调的时间、坐标和来源，而不是仅凭蓝点判断。

## 当前代码路径与初步判断

| 环节 | 当前实现 | 待验证点 |
| --- | --- | --- |
| 地图点选 | `HomeView` 用 `MapProxy.convert(point, from: .local)` 获取坐标 | 对照屏幕点击位置、标记和复制坐标；检查不同缩放级别 |
| 搜索和坐标输入 | `MapViewModel` 从 `MKLocalSearch` 取 `item.location.coordinate`，或直接解析输入的经纬度 | 分开测试搜索结果和手输坐标；注明坐标数据来源及坐标系 |
| 固定位置发送 | `LocationTarget` 以 `Double` 保存经纬度，Swift 经 C ABI 传给 Rust `f64`，再调用 `LocationSimulationClient.set` | 代码路径未见主动取整或坐标转换；仍需真机读取接收端坐标确认 |
| 固定位置刷新 | Rust 检查坐标变化，坐标不变时每 4 秒重发一次 | 测量其他 App 实际接收的时间序列、后台持续性与异常中断 |
| 路线起点 | `WalkingRoutePlanner` 默认请求系统当前位置；`WalkingSimulationController` 从路线折线首点开始注入 | 路线规划可能将起点贴到可通行路段，记录启动瞬间的跳变距离 |
| 路线移动 | Swift 每秒按速度推进一次，沿 `MKMapPoint` 折线插值；Rust 每 200 ms 检查目标是否更新 | 高速时每秒可能跨越几十米；测量更新延迟和目标 App 的平滑处理 |
| 路线终点 | 到达时发送最初选择的 `destination.coordinate` | 比较路线折线末点和目的地坐标，留意到达瞬间的跳变 |

`CLLocationManager.desiredAccuracy = kCLLocationAccuracyBest` 用于 WrapPin 获取**真实当前位置**，并不设置开发者模拟坐标的精度。复制坐标时显示的六位小数也不足以解释约 1 公里的偏差；实际注入仍使用未截断的 `Double`。

活跃会话中的“更新位置”先调用 `wp_location_session_update` 把新目标写进 Rust 共享状态，再立即将 Swift UI 阶段标成 `.active(target)`；Rust 工作循环之后才调用 `location.set`。因此卡片显示新地点只证明更新已排队，**不证明系统模拟服务已应用新坐标**；观察 Apple 地图蓝点或独立 Core Location 回调才是验收。

`BackgroundLocationKeepAlive` 中的 `kCLLocationAccuracyKilometer` 容易因“约 1 公里”而被误认为直接原因；它只配置 WrapPin 自己用于后台保活的 Core Location 请求，不参与上表中的 DVT 坐标注入。尚无证据表明把它改成更高精度能消除 Apple 地图蓝点偏移。

## 真机复现与判别

**第一轮继续测苏州中心广场这个固定地点**，使用同一台 iPhone、同一 iOS 版本。保持 WrapPin 固定模拟运行，打开下述内置定位回调读取，优先确认 WrapPin 是否收到 `31.316633, 120.677664`。必要时再用另一款能显示原始 Core Location 坐标的 App 交叉验证。Apple 地图的搜索图钉已确认落在广场，而蓝点在东南侧；重复搜索不再增加关键证据。

下一步优先读取模拟期间另一款 App 收到的原始 Core Location 坐标与定位来源，和 WrapPin 卡片显示的选中坐标对照。若原始回调等于注入坐标而 Apple 地图蓝点仍偏移，重点查 Apple 地图在中国大陆的显示坐标转换；若原始回调不同，则沿 `AppModel.startLocationSession` → `LocalDeviceSessionCoordinator.updateLocation` → Rust 工作循环查实际注入值、系统回执和会话持续性。WrapPin 的 `.active(target)` 只是应用会话状态，不能替代接收端验证。

若第一轮仍不能定位问题，再依次用“直接输入已知 WGS84 坐标、搜索结果、地图点选”启动固定位置，并用能显示原始 Core Location 回调的测试 App 记录 `CLLocation.coordinate`、`horizontalAccuracy`、`timestamp`、`sourceInformation?.isSimulatedBySoftware`、定位精度权限、前后台状态与截图。最后再测短距离步行和驾车路线。位置和配对数据仅保存在本地测试记录，不放进公开 issue 或遥测。

对同一坐标系的输入与接收坐标，可用 `CLLocation.distance(from:)` 计算米数，并保存连续至少 30 次回调的最大值、平均值及时间间隔。若要扩大验证范围，再分别在中国大陆和其他地区选取测试点。

判别顺序：

1. **手输坐标即偏**：先查接收端原始定位回调、系统模拟链路和目标 App 处理；不要先改地图搜索。
2. **手输准确，搜索或点选偏**：查地点数据、地图点转坐标、坐标来源和标记显示。
3. **原始回调准确，地图蓝点偏**：查目标 App 地图呈现、缓存、定位融合或它是否采用该次回调；不能用蓝点推断注入精度。
4. **固定位置准确，路线偏**：记录规划路线首末点与用户选择点的距离，并测量每次路线坐标更新。
5. **开始准确，随后漂移**：检查会话是否持续、重连或恢复真实位置的时点，以及目标 App 是否出现非模拟来源回调。

## 结论边界与下一步

调研分支新增了手动读取入口：先在 WrapPin 保持固定位置模拟，再进入“设置 → 连接检测 → 定位精度调研”，点“读取原始定位回调”。页面同时显示启动读取时的模拟目标、WrapPin 自己收到的最新 Core Location 坐标、水平精度、时间和软件模拟标记；停止读取或离开页面即清除，不写入诊断报告、持久化或遥测。若未收到新回调，不能把旧位置当作本次结果。这个读数来自 WrapPin 进程，仍需与 Apple 地图蓝点对照；它不能直接读取 Apple 地图进程内部的定位值。

本地测试包为 `WrapPin-1.0.9-build20-location-probe.ipa`，SHA-256 为 `86d414f2c4bec3b85beadf888b19374e403c2385108ff5af1aa6740653803d9a`。它从无签名 Release 归档打包，版本和 Build 分别核对为 1.0.9 / 20，ZIP 完整性检查通过；尚未在 SideStore 或真机安装验收，不应视为定位偏差修复版。

若最新回调的数字与模拟目标一致，而 Apple 地图蓝点仍在东南边，可优先调查 Apple 地图的显示和定位来源；若最新回调本身已偏到东南边，则继续沿原生模拟链路与坐标系边界查。两种结果都先记录原始数值，再讨论转换，避免凭截图试错式加偏移。

静态检查只能说明应用当前未对固定位置坐标主动降精度；不能证明 iOS 已按该坐标向所有 App 报告，也不能证明中国大陆地图偏移的原因。先拿到一组“输入坐标 → 原始定位回调”的真机样本，再决定修选点、路线算法、会话稳定性或仅调整用户说明。不要在没有定位来源证据时加入统一偏移补偿。

若接收端数据最终证实坐标系不一致，候选修复应明确区分**用于地图显示的坐标**与**送入系统模拟服务的坐标**，并记录搜索、地图点选、手输坐标和路线各自的来源。转换应发生在经确认的来源边界，不能把所有中国大陆坐标无条件转换；否则已是 WGS84 的手输坐标会被二次偏移。修复验收至少覆盖本次苏州固定点、活跃会话更新、路线点以及中国大陆以外的固定点。

参考：[Apple 坐标定义](https://developer.apple.com/documentation/corelocation/cllocationcoordinate2d)、[Apple MapProxy 坐标转换](https://developer.apple.com/documentation/mapkit/mapproxy/convert%28_%3Afrom%3A%29)、[高德坐标系说明](https://lbs.amap.com/api/javascript-api-v2/guide/transform/convertfrom)、[百度坐标系说明](https://lbsyun.baidu.com/skins/MySkin/resources/iframs/coordinate.html)、[CLLocation.horizontalAccuracy](https://developer.apple.com/documentation/corelocation/cllocation/horizontalaccuracy)、[CLLocation.sourceInformation](https://developer.apple.com/documentation/corelocation/cllocation/sourceinformation)。
