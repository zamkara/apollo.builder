#!/bin/bash
set -e

# Update and install dependencies
pacman -Syu --noconfirm archiso rust pkgconf gtk4 libadwaita base-devel git sudo

# Create custom local pacman repository for the ISO
mkdir -p /work/.github/workflows/archiso/custom_repo
cp /work/aur-packages/*.pkg.tar.zst /work/.github/workflows/archiso/custom_repo/
repo-add /work/.github/workflows/archiso/custom_repo/custom.db.tar.gz /work/.github/workflows/archiso/custom_repo/*.pkg.tar.zst

# Build Alga
cd /work/.github/workflows/alga
cargo build --release
mkdir -p ../archiso/airootfs/usr/bin
cp target/release/alga ../archiso/airootfs/usr/bin/alga
cd /work

# Run mkarchiso
mkarchiso -v -w /work/workdir/ -o /work/out/ /work/.github/workflows/archiso/
