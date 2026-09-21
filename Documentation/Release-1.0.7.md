# WrapPin 1.0.7（Build 11）

## 中文

本版新增驾车路线模拟。选定目的地后，可分别预览步行或驾车路线；驾车模式支持设置 5–240 公里/小时的匀速模拟速度，预计用时会随速度变化。模拟过程中可以让地图跟随车辆，或切回整条路线。

### 其他改进

- 中断恢复会保留路线类型和所选速度；旧版步行恢复记录仍可读取。
- 长路线的路线点定位改为二分查找。
- 驾车路线到达后不提供直接反向返回，避免把单行道路段按原路径倒放。
- 更新中英文使用说明、中文界面文案和匿名使用统计的事件说明。

### 下载与验证

- 文件：`WrapPin-1.0.7-build11.ipa`
- 最低系统：iOS 27.0；架构：arm64；Bundle ID：`com.suversal.wrappin`
- 签名：未签名，需由 SideStore 或自己的开发者身份签名安装。
- SHA-256：`070199959d635c1dda049fd2186c8800920dd167648272788a65bc60db2e86fc`
- Release Archive、IPA 结构与资源、中文文案、原生错误分类、后台会话检查，以及新旧路线恢复记录检查已通过。

### 当前边界

驾车模式模拟的是沿 Apple 地图道路路线移动的坐标，不提供真实车辆速度、航向、路况或加减速数据。跨城路线、长时间锁屏与其他 App 中的定位效果尚未完成真机验收。

## English

WrapPin 1.0.7 adds driving route simulation. Preview a walking or driving route, choose a constant driving speed from 5 to 240 km/h, and see the simulated travel time update. During a drive, the map can follow the simulated car or show the whole route.

Interrupted route recovery preserves the mode and speed while remaining compatible with earlier walking records. Long-route point lookup is faster, and driving routes are not reversed at arrival because one-way roads may require a different return path.

The unsigned `WrapPin-1.0.7-build11.ipa` requires iOS 27.0 or later and has SHA-256 `070199959d635c1dda049fd2186c8800920dd167648272788a65bc60db2e86fc`. Archive, package, localization, native error, background-session and route-recovery checks passed. Long-distance and locked-screen driving behavior has not yet been verified on a physical device. The app simulates route coordinates, not vehicle speed, heading or live traffic.
