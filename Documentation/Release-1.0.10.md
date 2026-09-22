# WrapPin 1.0.10（Build 30）

## 中文

固定位置模拟现在可以在 **GCJ-02** 和 **WGS84** 两种坐标处理方式之间切换，适用于地图选点和手动输入坐标。如果显示位置有偏差，可在同一地点换另一种方式尝试。国内地点优先建议 GCJ-02，其他地点优先建议 WGS84；这是初始建议，并非准确性保证。

步行和驾车路线预览加入明确的关闭按钮，收紧卡片上下留白与速度开关布局。地图顶部控件继续使用原有材质外观。打开 WrapPin 时会查询 GitHub 最新公开版本，有新版时显示可关闭的提醒；设置页仍可手动检查。连接检测中的原始定位回调工具可帮助调查坐标偏差。

### 下载与验证

- 文件：`WrapPin-1.0.10-build30.ipa`
- 最低系统：iOS 27.0；架构：arm64；Bundle ID：`com.suversal.wrappin`
- 签名：未签名，需要由 SideStore 或自己的开发者身份签名安装；建议覆盖安装旧版。
- SHA-256：`f0b152dd54ec110f45ef206cb4fb910da44afb1794701c3890a9e7c27d0d84e2`
- 本地化、原生错误分类、后台会话、隧道策略、坐标模式与路线恢复检查通过。Release Archive、IPA 完整性、包内版本和 Bundle ID、arm64 架构、未签名状态、隐私清单及许可证资源均已核对。
- 用户已在先前测试包中试过两种坐标模式；Build 30 本身尚未完成独立的 iPhone 安装和路线卡片视觉验收。

### 已知边界

两种坐标模式都不能保证每个地点或第三方 App 的显示位置准确。路线模拟仍按自身路线数据更新坐标；第三方 App 也可能识别软件模拟位置。开发者位置模拟不会改变 Apple Watch 地区功能、eSIM、运营商或卫星功能资格。Shadowrocket 在蜂窝网络下仍可能无法提供所需的设备连接。

## English

WrapPin 1.0.10 lets users switch fixed-location simulation between GCJ-02 and WGS84 coordinate handling for map selections and manually entered coordinates. The regional recommendation is a starting point, not an accuracy guarantee. Walking and driving previews have a close button and tighter sizing. The map controls retain their previous material appearance. WrapPin checks the latest public GitHub release when opened and shows a dismissible update notice. Connection Health includes a raw location callback probe for investigating offsets.

The unsigned `WrapPin-1.0.10-build30.ipa` requires iOS 27.0 or later and has SHA-256 `f0b152dd54ec110f45ef206cb4fb910da44afb1794701c3890a9e7c27d0d84e2`. Source checks, Release Archive and IPA identity/integrity checks passed. Earlier test packages were exercised for coordinate modes; Build 30 itself has not yet been independently installed or visually checked on an iPhone. Neither coordinate mode guarantees accurate display everywhere or acceptance by third-party apps.
