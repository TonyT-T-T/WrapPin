# WrapPin 1.0.0

WrapPin 1.0.0 是这个非官方 Roam Control 社区分支的首个稳定版本，提供完整简体中文界面、连接稳定性优化、诊断能力、独立品牌和深浅色图标。

## 下载与安装

- 安装包：`WrapPin-1.0.0-build1.ipa`
- 版本：`1.0.0`（Build `1`）
- 最低系统：iOS 27.0
- 架构：arm64
- 签名：未签名，请使用 SideStore 或自己的 Apple 开发者身份签名安装
- SHA-256：`de371230f51cf16f2309926bc5c504eb67dbdd3640ca30b35d02aedc741f19d6`

请下载 Assets 中以 `.ipa` 结尾的文件。`Source code (zip)` 和 `Source code (tar.gz)` 是 GitHub 自动生成的源码包，不能直接作为 SideStore 安装包使用。

## 主要更新

- 简体中文界面、配对引导、连接恢复和中文文档。
- 固定位置与模拟步行路线，支持收藏、历史记录和真实位置恢复。
- 优化长时间配对任务和 LocalDevVPN 端点选择。
- 更清晰的连接状态、诊断和恢复提示。
- 工程、Target、Scheme、Bundle ID、URL Scheme、原生桥接和文档统一使用 WrapPin 名称。
- 新增独立的日间与夜间 App 图标。

## 验证情况

- Rust 原生桥接已通过 arm64 iPhone 和 Apple Silicon 模拟器构建。
- 中文覆盖检查和 33 条原生错误分类检查通过。
- 无签名 Release 构建、IPA 结构、版本、架构、隐私清单及许可证资源检查通过。
- 较早候选版本已经完成真机安装和核心功能测试；公开发布后仍建议用最终 1.0.0 IPA 再做一次真机安装确认。

## 许可证与归属

WrapPin 不是上游官方版本。项目保留原作者版权说明与上游归属；当前源码采用 PolyForm Noncommercial License 1.0.0，第三方组件继续遵循各自许可证。

---

# English

WrapPin 1.0.0 is the first stable release of this unofficial, community-maintained Roam Control fork. It adds complete Simplified Chinese localization, connection hardening, diagnostics, independent WrapPin branding, and dedicated light/dark icons.

## Download and install

- Package: `WrapPin-1.0.0-build1.ipa`
- Version: `1.0.0` (Build `1`)
- Minimum OS: iOS 27.0
- Architecture: arm64
- Signing: unsigned; sign with SideStore or your own Apple development identity
- SHA-256: `de371230f51cf16f2309926bc5c504eb67dbdd3640ca30b35d02aedc741f19d6`

Download the file ending in `.ipa` from Assets. GitHub generates `Source code (zip)` and `Source code (tar.gz)` automatically; those source archives cannot be installed with SideStore.

## Highlights

- Simplified Chinese interface, pairing guidance, connection recovery, and documentation.
- Fixed-location and simulated walking-route workflows with favourites, history, and real-location restoration.
- More reliable long-running pairing and LocalDevVPN endpoint selection.
- Clearer connection state, diagnostics, and recovery guidance.
- Consistent WrapPin naming across the project, target, scheme, bundle identifier, URL scheme, native bridge, and documentation.
- Dedicated light and dark app icons.

## Verification

- The Rust bridge builds for arm64 iPhone and Apple Silicon simulator.
- Localization coverage and 33 native failure-classification checks pass.
- The unsigned Release build, IPA structure, version, architecture, privacy manifest, and legal resources were verified.
- Earlier candidates passed physical-device installation and core-flow testing; one final installation check with the public 1.0.0 IPA is still recommended.

## Licence and attribution

WrapPin is not an official upstream edition. It preserves the original copyright notice and upstream attribution. Current source is available under the PolyForm Noncommercial License 1.0.0; third-party components retain their own licences.
