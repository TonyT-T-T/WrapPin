# WrapPin releases

## 1.0.2 (Build 3)

- Created: 14 September 2026
- Package: `WrapPin-1.0.2-build3.ipa`
- Build: optimized unsigned Xcode Release Archive, arm64 iPhone executable
- Requires: iOS 27.0 or later
- Xcode: 27.0 (`27A266a`)
- Distribution: unsigned IPA for SideStore or another user-side signing tool
- SHA-256: `68c8fe1d5ec67f8a0e38108775590036bfe38c294880740d532c0267371b5937`
- Replaces: 1.0.1 Build 2, which SideStore rejected with `SideSign.Archive.Error 1`.
- Verification: Xcode Release Archive completed and the IPA payload, version, architecture and unsigned state were checked. Physical-device installation is delegated to the release tester.

See [the 1.0.2 release notes](../Documentation/Release-1.0.2.md) for details.

## 1.0.0 (Build 1)

- Created: 14 September 2026
- Package: `WrapPin-1.0.0-build1.ipa`
- Build: optimized unsigned Release, arm64 iPhone executable
- Requires: iOS 27.0 or later
- Xcode: 27.0 (`27A266a`)
- Distribution: unsigned IPA for SideStore or another user-side signing tool
- SHA-256: `de371230f51cf16f2309926bc5c504eb67dbdd3640ca30b35d02aedc741f19d6`
- Verified: native iPhone and Apple Silicon simulator bridge builds, localization coverage, failure classification, unsigned Release build, IPA payload integrity, version identity, privacy manifest and legal resources.
- Remaining acceptance: install the final 1.0.0 IPA on a physical iPhone before announcing it as fully released.

See [the 1.0.0 release notes](../Documentation/Release-1.0.0.md) for details.
