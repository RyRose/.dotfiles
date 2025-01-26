#!/usr/bin/env bash

# Create a temporary directory and store its path
TEMP_DIR=$(mktemp -d)

# Define cleanup function
cleanup() {
    rm -rf "$TEMP_DIR"
}

# Set trap to call cleanup on script exit
trap cleanup EXIT

REPO_ROOT="$(git rev-parse --show-toplevel)"

set -eux

python3 \
    "$REPO_ROOT/utils/vendor/export-ble-infos.py" \
    --system "/mnt/win/c/Windows/System32/config/SYSTEM" \
    --output "${TEMP_DIR}" --verbose

sudo python3 \
    "$REPO_ROOT/utils/bin/copy_bt.py" \
    --src_base "${TEMP_DIR}"

sudo systemctl restart bluetooth
