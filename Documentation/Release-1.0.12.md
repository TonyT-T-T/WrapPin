# WrapPin 1.0.12（Build 32）

## 中文

本版修复步行和驾车路线模拟未应用当前坐标模式的问题。选择 GCJ-02 校正或 WGS84 原值后，路线起点、移动过程、终点、返程以及中断恢复都会继续使用同一模式。MapKit 原始路线仅用于规划、显示和进度计算，只有发送给 iPhone 的模拟坐标会执行转换，避免路线预览产生二次偏移。

### 下载与验证

- 文件：`WrapPin-1.0.12-build32.ipa`
- 最低系统：iOS 27.0；架构：arm64；Bundle ID：`com.suversal.wrappin`
- 签名：未签名，需要由 SideStore 或自己的开发者身份签名安装；建议覆盖安装旧版。
- SHA-256：`6f700a8ce62b2e03e31bb4217d45971b4972b3f62dae8df134091232fc9d9999`
- 坐标模式和路线恢复检查、本地化、后台定位生命周期、错误分类、Release Archive 以及 IPA 身份/完整性检查均已通过。
- 同一功能代码已通过 Build 32 本地测试包的真机验收；正式 IPA 在更新版本元数据后重新构建并完成包级校验。

### 已知边界

GCJ-02/WGS84 的选择仍取决于地图点位来源和所在地区，本版不保证所有第三方 App 都会接受软件模拟位置，也不改变 Shadowrocket/LocalDevVPN 的设备通道条件。

## English

WrapPin 1.0.12 applies the selected GCJ-02 correction or unchanged WGS84 mode to walking and driving simulations. The same mode now covers the route start, movement updates, destination, return trip, and interrupted-session recovery. MapKit route geometry remains unchanged for planning and display; only coordinates sent through LocationSimulation are transformed.

The unsigned `WrapPin-1.0.12-build32.ipa` requires iOS 27.0 or later and has SHA-256 `6f700a8ce62b2e03e31bb4217d45971b4972b3f62dae8df134091232fc9d9999`. The same feature code passed physical-device testing in the local Build 32 test package. The formal IPA was rebuilt with the 1.0.12 version metadata and passed archive, identity, integrity, architecture, unsigned-state, localization, recovery, and lifecycle checks.
