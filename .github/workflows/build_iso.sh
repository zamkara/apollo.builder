#!/bin/bash
set -e

# Update and install dependencies
pacman -Syu --noconfirm archiso base-devel git sudo grub

# Create custom local pacman repository for the ISO
mkdir -p /work/.github/workflows/archiso/custom_repo
cp /work/aur-packages/*.pkg.tar.zst /work/.github/workflows/archiso/custom_repo/
repo-add /work/.github/workflows/archiso/custom_repo/custom.db.tar.gz /work/.github/workflows/archiso/custom_repo/*.pkg.tar.zst

# ISO rootfs is populated by pacman packages from custom_repo

# Run mkarchiso
sed -i 's/airootfs\.sfs/originium.sfs/g' /usr/bin/mkarchiso
sed -i 's/airootfs\.sha512/originium.sha512/g' /usr/bin/mkarchiso
mkarchiso -v -w /work/workdir/ -o /work/out/ /work/.github/workflows/archiso/
