# WrapPin 1.0.11（Build 31）

## 中文

本版只细化路线模拟的速度调节：自定义步行速度从每次 0.5 公里/小时改为每次 0.1 公里/小时，驾车速度从每次 5 公里/小时改为每次 1 公里/小时。步行仍为 1–12 公里/小时，驾车仍为 5–240 公里/小时，默认值、步行预设、路线规划和恢复逻辑均未改变。

### 下载与验证

- 文件：`WrapPin-1.0.11-build31.ipa`
- 最低系统：iOS 27.0；架构：arm64；Bundle ID：`com.suversal.wrappin`
- 签名：未签名，需要由 SideStore 或自己的开发者身份签名安装；建议覆盖安装旧版。
- SHA-256：`dc0c622184d258341c47bd64356a04834a447eaee1231034de9ec082eac1ab45`
- 源码检查、Release Archive、IPA 完整性、包内版本与 Bundle ID、arm64 架构、未签名状态、隐私清单及许可证资源均已核对。
- Build 31 尚未完成独立的 SideStore 安装和真机速度滑杆交互验收。

### 已知边界

本版不修改路线规划、坐标处理或定位连接，也不保证第三方 App 接受软件模拟位置。

## English

WrapPin 1.0.11 changes only the route-speed adjustment increments. Custom walking speed now moves in 0.1 km/h steps instead of 0.5 km/h, and driving speed now moves in 1 km/h steps instead of 5 km/h. The supported ranges, defaults, walking presets, route planning and recovery behavior are unchanged.

The unsigned `WrapPin-1.0.11-build31.ipa` requires iOS 27.0 or later and has SHA-256 `dc0c622184d258341c47bd64356a04834a447eaee1231034de9ec082eac1ab45`. Source checks, Release Archive and IPA identity/integrity checks passed. Build 31 has not yet been independently installed through SideStore or exercised on a physical iPhone. This release does not change route planning, coordinate handling, location connectivity or third-party simulated-location acceptance.
