# Changelog

All notable public changes to WrapPin are recorded here.

## [Unreleased]

## [1.0.4] - 2026-09-15

### Changed

- Increased the X profile icon to match the visual scale of the other Community rows.
- Changed the Simplified Chinese X profile label from “follow我” to “关注我”.
- Updated the README with the current feature set, validation status and release progress.

## [1.0.3] - 2026-09-15

### Added

- Added an X profile link to the Community section so users can follow the WrapPin maintainer directly from Settings.

## [1.0.0] - 2026-09-14

First stable WrapPin release, based on Roam Control 0.9.2 Beta 3 and maintained as an unofficial community fork.

### Added

- Complete Simplified Chinese interface, connection guidance, diagnostics and documentation.
- Fixed-location and walking-route simulation with favourites, history, recovery and real-location restoration.
- Dedicated light and dark WrapPin app icons.
- In-app links for GitHub Stars, bug reports and feature requests.

### Improved

- Kept long-running on-device pairing alive while iOS continued-processing tasks remain active.
- Rejected USB and Wi-Fi `169.254.x.x` link-local service addresses and preferred the LocalDevVPN endpoint for saved sessions.
- Added clearer connection stages, endpoint sources, retry guidance and privacy-preserving diagnostics.
- Kept Apple signing identifiers, analytics credentials and other private build values outside the repository.
- Unified the project directory, Xcode project, target, scheme, app, native bridge, bundle identifier, URL scheme, scripts and documentation under the WrapPin name.

### Validation

- Simplified Chinese localization coverage and native failure classification checks pass.
- The native Rust bridge builds for arm64 iPhone and arm64 Apple Silicon simulator.
- Unsigned Release build and IPA integrity checks pass for version `1.0.0` Build `1`.
- Earlier candidates passed physical-device installation and core usage testing; the final 1.0 package should still be installed once before public release.

[Unreleased]: https://github.com/suversal/WrapPin/commits/main
[1.0.4]: https://github.com/suversal/WrapPin/releases/tag/v1.0.4
[1.0.3]: https://github.com/suversal/WrapPin/releases/tag/v1.0.3
[1.0.0]: https://github.com/suversal/WrapPin/releases/tag/v1.0.0
