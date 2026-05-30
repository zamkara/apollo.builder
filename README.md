# Ark Linux 🚀

Welcome to the central repository for **Ark Linux**! This repository handles the creation of the Live ISO used to install the system.

**Ark Linux is NOT a separate distribution.** It is simply vanilla Arch Linux delivered as a modern, immutable, container-native OS, leveraging `bootc` and OSTree technologies to provide atomic updates and reliability.

## How It Works
This repository uses `archiso` combined with GitHub Actions to produce a highly customized Live ISO.
When booted, the Live ISO presents a beautiful GNOME desktop that automatically launches the **Ark Wizard (alga)**, our custom GTK4/Rust installer, to write the OS to your disk.

## Building the ISO Locally
If you want to build the Live ISO on your own machine:
1. Ensure you have `podman`, `wget`, `curl`, and `jq` installed on your host.
2. Run the build script:
   ```bash
   sudo bash .github/workflows/build_iso.sh
   ```
   *Note: Building the ISO requires root privileges because it mounts filesystems and uses `mkarchiso`.*
3. The resulting `.iso` file will be placed in the `out/` directory.

## Repository Ecosystem
Ark Linux is split into a modular architecture:
- **[ark.linux](https://github.com/zamkara/ark.linux)** (This repo): Builds the bootable Live ISO.
- **[ark-image](https://github.com/zamkara/ark-image)**: Contains the `Containerfile` that defines the actual OS environment. It publishes the `ghcr.io/zamkara/ark-image` container used by the installer.
- **[alga](https://github.com/zamkara/alga)**: The "Ark Wizard" frontend application (written in Rust/GTK4) that runs on the ISO to perform the installation, and later serves as the system updater.
- **[ark-aur](https://github.com/zamkara/ark-aur)**: Custom package repository hosting pre-compiled AUR packages injected into the system.

## License
MIT License
