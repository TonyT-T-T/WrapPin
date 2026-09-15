# WrapPin 1.0.5

## 中文

WrapPin 1.0.5（Build 6）改善了国内外地图选点的地址解析与历史记录体验。

### 构建信息

- 文件：`WrapPin-1.0.5-build6.ipa`
- 版本：`1.0.5` Build `6`
- 最低系统：iOS 27.0
- 架构：arm64
- 签名：未签名，需使用 SideStore 或自己的 Apple 开发者身份签名
- SHA-256：`723fb61fe08ce9cb7fa99b98875838c3a2770cc61470bd4e9a97efe8728df00b`

### 更新内容

- 使用当前系统语言请求 Apple 地图反向地理编码。
- 针对短暂网络错误和空结果自动重试一次。
- 地址解析期间禁止收藏、路线预览和启动定位，避免临时文案被保存。
- Apple 地图无法返回可读地址时，显示精确经纬度而不是笼统的“从地图选择”。
- 选择旧的未解析收藏或历史记录时自动重新查询，同时保留用户自定义的收藏名称。
- 补充 SideStore 从 iPhone“文件”App 导入 IPA 的安装说明。
- 建议直接覆盖安装，以保留本地设置、收藏、历史和配对记录。

### 验证

- Xcode Release Archive 构建通过。
- 中英文本地化和原生定位错误分类检查通过。
- IPA 结构、版本、arm64 架构、未签名状态、隐私清单和许可资源已校验。
- 地址解析优化已通过 SideStore 真机测试。

## English

WrapPin 1.0.5 (Build 6) improves readable address resolution for map selections worldwide and makes saved-location recovery more reliable.

### Build information

- File: `WrapPin-1.0.5-build6.ipa`
- Version: `1.0.5` Build `6`
- Minimum system: iOS 27.0
- Architecture: arm64
- Signing: unsigned; sign with SideStore or your own Apple developer identity
- SHA-256: `723fb61fe08ce9cb7fa99b98875838c3a2770cc61470bd4e9a97efe8728df00b`

### Changes

- Requests Apple Maps reverse geocoding in the current system locale.
- Retries once after a transient failure or empty result.
- Disables favourites, route previews and location start actions until address resolution completes.
- Shows the exact coordinates when Apple Maps cannot provide a readable address.
- Re-resolves older unresolved favourites and history entries while preserving custom favourite names.
- Documents importing the downloaded IPA from the iPhone Files app into SideStore.
- Install over the previous version to preserve local settings, favourites, history and pairing records.

### Validation

- Xcode Release Archive succeeded.
- English and Simplified Chinese localization and native location failure checks passed.
- IPA structure, version, arm64 architecture, unsigned state, privacy manifest and legal resources were verified.
- The address-resolution improvements passed a SideStore physical-device test.
