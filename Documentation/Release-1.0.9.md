# WrapPin 1.0.9（Build 18）

## 中文

步行路线新增可选的自定义速度：1–12 公里/小时，每次调节 0.5 公里/小时，原来的三档预设仍可使用。预览中的预计用时会随速度更新；意外中断后继续步行时会恢复原速度。需要更快的道路路线时，可选择已有的驾车模式。

设置页主要选项现在都有前置图标，并统一了图标宽度，包括外观、地图、隧道、隐私、版本信息和重置选项。

### 下载与验证

- 文件：`WrapPin-1.0.9-build18.ipa`
- 最低系统：iOS 27.0；架构：arm64；Bundle ID：`com.suversal.wrappin`
- 签名：未签名，需由 SideStore 或自己的开发者身份签名安装；建议覆盖安装旧版。
- SHA-256：`95f5a5977efab2c1cdf447e949a3defb1ecbc4be673294c31b64674f136e2f07`
- 本地化、原生错误分类、后台会话、隧道策略和路线恢复检查通过。Release Archive、IPA 完整性、包内版本与 Bundle ID、arm64 架构、未签名状态、隐私清单及许可证资源均已核对。
- 自定义步行速度已在 Build 16、设置页图标已在 Build 17 的 iPhone 测试包中通过。Build 18 的独立安装验收尚未完成。

### 已知边界

本版不改变固定位置或路线的坐标算法，不能据此认为此前报告的位置偏移已修复。第三方 App 可以自行识别和拒绝软件模拟位置。开发者位置模拟也不会改变 Apple Watch 地区功能、eSIM、运营商或卫星功能资格。Shadowrocket 在蜂窝网络下仍可能无法提供所需的设备连接；遇到此情况请改用 Wi-Fi 或 LocalDevVPN。

## English

WrapPin 1.0.9 adds an optional walking-route speed from 1 to 12 km/h in 0.5 km/h steps, keeps the three presets, and restores a custom speed when resuming an interrupted walk. The main Settings rows now use consistently aligned icons.

The unsigned `WrapPin-1.0.9-build18.ipa` requires iOS 27.0 or later and has SHA-256 `95f5a5977efab2c1cdf447e949a3defb1ecbc4be673294c31b64674f136e2f07`. Localization, native-error, background-session, tunnel-policy and route-recovery checks passed, along with Release Archive and IPA identity/integrity checks. The speed and Settings changes passed physical-iPhone testing in Builds 16 and 17 respectively; Build 18 has not yet been installed independently. This release does not claim to fix coordinate offsets, bypass third-party simulated-location checks, or change regional, carrier or satellite feature eligibility.
