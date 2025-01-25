#!/usr/bin/env bash

set -eu

if sudo test ! -d /boot/EFI/Microsoft; then
    set -x
    sudo cp -a /mnt/win/efi/EFI/Microsoft /boot/EFI/Microsoft
else
    echo "Directory /boot/EFI/Microsoft already exists. Skipping copy."
fi
