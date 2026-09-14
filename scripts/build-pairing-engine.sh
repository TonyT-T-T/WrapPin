#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
PROJECT_ROOT="${SCRIPT_DIR:h}"
PACKAGE_DIR="${PROJECT_ROOT}/Native/WrapPinPairingFFI"
BUILD_DIR="${TMPDIR:-/tmp}/wrappin-pairing-build"
OUTPUT_DIR="${PROJECT_ROOT}/Frameworks/WrapPinPairingFFI.xcframework"
LOCAL_TOOLCHAIN_ROOT="${PROJECT_ROOT:h:h}/.toolchains"

if [[ -x "${LOCAL_TOOLCHAIN_ROOT}/cargo/bin/cargo" ]]; then
    CARGO_BIN="${LOCAL_TOOLCHAIN_ROOT}/cargo/bin/cargo"
    export CARGO_HOME="${LOCAL_TOOLCHAIN_ROOT}/cargo"
    export RUSTUP_HOME="${LOCAL_TOOLCHAIN_ROOT}/rustup"
elif command -v cargo >/dev/null 2>&1; then
    CARGO_BIN="$(command -v cargo)"
else
    print -u2 "Rust is required. Install rustup, then run this script again."
    exit 1
fi

if [[ -z "${DEVELOPER_DIR:-}" ]]; then
    DEVELOPER_DIR="$(xcode-select -p)"
fi
export DEVELOPER_DIR
export CARGO_TARGET_DIR="${BUILD_DIR}/target"

mkdir -p "${BUILD_DIR}" "${PROJECT_ROOT}/Frameworks"

"${CARGO_BIN}" build \
    --manifest-path "${PACKAGE_DIR}/Cargo.toml" \
    --release \
    --target aarch64-apple-ios

"${CARGO_BIN}" build \
    --manifest-path "${PACKAGE_DIR}/Cargo.toml" \
    --release \
    --target aarch64-apple-ios-sim

if [[ -e "${OUTPUT_DIR}" ]]; then
    print -u2 "${OUTPUT_DIR} already exists. Move it aside before rebuilding."
    exit 1
fi

"${DEVELOPER_DIR}/usr/bin/xcodebuild" -create-xcframework \
    -library "${CARGO_TARGET_DIR}/aarch64-apple-ios/release/libwrappin_pairing_ffi.a" \
    -headers "${PACKAGE_DIR}/include" \
    -library "${CARGO_TARGET_DIR}/aarch64-apple-ios-sim/release/libwrappin_pairing_ffi.a" \
    -headers "${PACKAGE_DIR}/include" \
    -output "${OUTPUT_DIR}"

print "Built ${OUTPUT_DIR}"
