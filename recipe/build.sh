#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

if [[ ${build_platform} != ${target_platform} ]]; then
    export OPENSSL_DIR="${PREFIX}"
fi

# check licenses
cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

# build statically linked binary with Rust
cargo install --no-track --locked --root ${PREFIX} --path .

# strip debug symbols
"$STRIP" "$PREFIX/bin/${PKG_NAME}"
