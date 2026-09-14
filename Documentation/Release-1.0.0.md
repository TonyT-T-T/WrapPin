# WrapPin 1.0.0

WrapPin 1.0.0 is the first stable release of this unofficial, community-maintained Roam Control fork. It combines the upstream location-simulation workflow with Simplified Chinese localization, connection hardening, diagnostics, independent WrapPin branding and dedicated light/dark icons.

## Download

- File: `WrapPin-1.0.0-build1.ipa`
- Version: `1.0.0` Build `1`
- Minimum system: iOS 27.0
- Architecture: arm64
- Signing: unsigned; sign with SideStore or your own Apple development identity
- SHA-256: `de371230f51cf16f2309926bc5c504eb67dbdd3640ca30b35d02aedc741f19d6`

## Highlights

- Simplified Chinese interface, pairing guidance, connection recovery and documentation.
- Fixed-location and simulated walking-route workflows.
- More reliable long-running pairing and LocalDevVPN endpoint selection.
- Clearer connection state, diagnostics and recovery instructions.
- Complete WrapPin naming across the app, Xcode project, native bridge, configuration and documentation.
- Separate light and dark iOS app icons.

## Verification

- Native Rust bridge built for arm64 iPhone and arm64 Apple Silicon simulator.
- Localization coverage and 33 native failure-classification checks passed.
- Unsigned Release build completed successfully.
- IPA payload, app identity, version, architecture, privacy manifest and legal notices were verified.

The final 1.0.0 package still needs one physical-device installation check before it should be described as fully device-accepted. Earlier candidates passed physical-device installation and core usage testing.

## Licence and attribution

WrapPin is not an official upstream edition. It preserves the required copyright notice and upstream attribution. Current source is available under the PolyForm Noncommercial License 1.0.0; bundled third-party components retain their own licences.
