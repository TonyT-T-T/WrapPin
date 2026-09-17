# WrapPin 1.0.6

## 中文

WrapPin 1.0.6（Build 9）主要改善 SideStore 重签环境下的本机配对与后台定位稳定性。

### 构建信息

- 文件：`WrapPin-1.0.6-build9.ipa`
- 版本：`1.0.6` Build `9`
- 最低系统：iOS 27.0
- 架构：arm64
- 签名：未签名，需使用 SideStore 或自己的 Apple 开发者身份签名
- SHA-256：`3ac594075b005162bcd3bd7521400b5d96cceeb7db046882060c0f1bc3a0d499`

### 更新内容

- 配对不再依赖易受 SideStore 重签 Bundle ID 影响的 `BGTaskScheduler` 注册。
- 切换到系统设置完成本机配对时，改用系统短期后台任务保持配对流程。
- 定位会话直接启动原生定位引擎，不再因后台任务标识不匹配而阻止启动。
- 允许定位权限后，活跃的模拟定位会使用 Core Location 保持后台活跃。
- “连接检测”新增后台会话状态，可显示等待授权、正常接收、权限拒绝或暂时不可用。
- 拒绝定位权限时，前台模拟仍可启动，但会明确提示切换 App 后不保证持续。

### 验证

- Xcode Release Archive 构建通过。
- 中英文本地化、33 条原生定位错误分类和后台会话生命周期检查通过。
- IPA 结构、版本、arm64 架构、未签名状态、后台定位模式、隐私清单和许可资源已校验。
- 已完成 SideStore 真机基本测试，未发现明显问题；仍欢迎实际遇到过配对失败的设备继续反馈。

### 已知边界

- 本版没有修改地图选点、经纬度、固定位置或步行路线的坐标算法。
- 本版不声称解决之前观察到的步行路线或中国大陆地图位置偏移。

## English

WrapPin 1.0.6 (Build 9) improves on-device pairing and background location reliability in SideStore re-signing environments.

### Build information

- File: `WrapPin-1.0.6-build9.ipa`
- Version: `1.0.6` Build `9`
- Minimum system: iOS 27.0
- Architecture: arm64
- Signing: unsigned; sign with SideStore or your own Apple developer identity
- SHA-256: `3ac594075b005162bcd3bd7521400b5d96cceeb7db046882060c0f1bc3a0d499`

### Changes

- Removes the `BGTaskScheduler` registration dependency that could fail after SideStore changed the runtime bundle identifier.
- Uses a short system background assertion while the user switches to Settings to complete on-device pairing.
- Starts the native location session directly instead of gating startup on a bundle-sensitive background-task identifier.
- Uses Core Location as a background keep-alive while a simulation is active and Location access is allowed.
- Adds a Background Session row to Connection Health for authorization, delivery and availability states.
- Keeps foreground simulation available when Location access is denied while explaining that background continuity is unavailable.

### Validation

- Xcode Release Archive succeeded.
- English and Simplified Chinese localization, 33 native location failure classifications and background-session lifecycle checks passed.
- IPA structure, version, arm64 architecture, unsigned state, background location mode, privacy manifest and legal resources were verified.
- Basic SideStore physical-device testing found no major problem; feedback from devices that previously encountered pairing failures remains welcome.

### Known boundaries

- This release does not change map selection, coordinates, fixed-location or walking-route coordinate algorithms.
- It does not claim to fix the previously observed walking-route or mainland-China map offset.
