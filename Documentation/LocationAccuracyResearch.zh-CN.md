# 模拟位置精度调研

调研分支：`codex/location-accuracy-research`，基于 `main` 的 `4ef99d1`。本文件记录静态代码检查和真机复现方案；目前没有可量化的真机误差样本，不能据此认定根因。

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

`CLLocationManager.desiredAccuracy = kCLLocationAccuracyBest` 用于 WrapPin 获取**真实当前位置**，并不设置开发者模拟坐标的精度。仅提高这一配置不能解释固定位置偏差。

## 真机复现与判别

在同一台 iPhone、同一 iOS 版本上，选一个已知经纬度，依次用“直接输入坐标、搜索结果、地图点选”启动固定位置；随后测试短距离步行和驾车路线。每次记录：WrapPin 显示或复制的原始坐标、接收端 `CLLocation.coordinate`、`horizontalAccuracy`、`timestamp`、`sourceInformation?.isSimulatedBySoftware`、目标 App 的定位精度权限、前后台状态与截图。位置和配对数据仅保存在本地测试记录，不放进公开 issue 或遥测。

用 `CLLocation.distance(from:)` 计算原始坐标与接收坐标之间的米数，并保存连续至少 30 次回调的最大值、平均值及时间间隔。分别在中国大陆和其他地区选取测试点；若引用第三方地图经纬度，先确认其坐标系，不能把不同坐标系直接相减。

判别顺序：

1. **手输坐标即偏**：先查接收端原始定位回调、系统模拟链路和目标 App 处理；不要先改地图搜索。
2. **手输准确，搜索或点选偏**：查地点数据、地图点转坐标、坐标来源和标记显示。
3. **原始回调准确，地图蓝点偏**：查目标 App 地图呈现、缓存、定位融合或它是否采用该次回调；不能用蓝点推断注入精度。
4. **固定位置准确，路线偏**：记录规划路线首末点与用户选择点的距离，并测量每次路线坐标更新。
5. **开始准确，随后漂移**：检查会话是否持续、重连或恢复真实位置的时点，以及目标 App 是否出现非模拟来源回调。

## 结论边界与下一步

静态检查只能说明应用当前未对固定位置坐标主动降精度；不能证明 iOS 已按该坐标向所有 App 报告，也不能证明中国大陆地图偏移的原因。先拿到一组“输入坐标 → 原始定位回调”的真机样本，再决定修选点、路线算法、会话稳定性或仅调整用户说明。不要在没有定位来源证据时加入统一偏移补偿。

参考：[Apple MapProxy 坐标转换](https://developer.apple.com/documentation/mapkit/mapproxy/convert%28_%3Afrom%3A%29)、[CLLocation.horizontalAccuracy](https://developer.apple.com/documentation/corelocation/cllocation/horizontalaccuracy)、[CLLocation.sourceInformation](https://developer.apple.com/documentation/corelocation/cllocation/sourceinformation)。
