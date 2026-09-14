# 安装与侧载

WrapPin 暂未通过 App Store 或 TestFlight 分发。正式版本以未签名 IPA 的形式发布，需要使用你自己的 Apple 账号签名后安装。

[返回中文首页](../README.zh-CN.md) · [English](Installation.md)

## 准备工作

- 一台运行 iOS 27 或更高版本的实体 iPhone。
- 在“设置 → 隐私与安全性”中开启开发者模式。
- 在 iPhone 上安装 [LocalDevVPN](https://apps.apple.com/app/localdevvpn/id6755608044)。
- 准备 SideStore；也可以在 Mac 上使用 Xcode 和自己的开发者团队编译安装。

## 使用 SideStore 安装

1. 从本仓库对应的 GitHub Release 下载 IPA，不要使用来源不明的网盘或镜像。
2. 在 SideStore 中轻点 **+**，选择下载好的 IPA。
3. 让 SideStore 使用你的 Apple 账号完成签名和安装。
4. 打开 WrapPin，完成首次使用说明和本机配对。
5. 打开 LocalDevVPN 并连接本地隧道，然后再启动模拟定位。

免费 Apple 账号通常需要在七天内刷新侧载 App，并受同时启用的 App 和 App ID 数量限制。这是 Apple 的签名限制，不是 WrapPin 的订阅规则。

更新时可以直接覆盖安装新版 IPA。不要先删除旧版，否则本地设置会一并删除，并可能需要重新配对。

## 使用 Xcode 安装

1. 克隆本仓库，使用 Xcode 27 或更高版本打开 `WrapPin.xcodeproj`。
2. 选择 `WrapPin` target，在 **Signing & Capabilities** 中选择你自己的开发者团队。
3. 连接 iPhone，选择该设备并运行项目。

仓库不会保存 Apple 开发者团队、签名文件或线上统计目标。Xcode 可能在本机记录你选择的团队，请勿提交签名材料或 `Configuration/Local.private.xcconfig`。

模拟器只能检查界面，不能完成实体 iPhone 配对，也不能真正启动模拟定位。

## 校验下载文件

GitHub Release 会提供 IPA 的 SHA-256。下载后可在 Mac 终端运行：

```sh
shasum -a 256 下载的文件名.ipa
```

输出应与对应 Release 页面列出的 SHA-256 完全一致。校验通过只代表文件与发布者上传的版本一致，仍应确认下载来源是本仓库。

安装完成后请继续阅读[使用手册](UserGuide.zh-CN.md)。
