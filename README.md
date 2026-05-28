# ark linux

this is not a new distribution. there is no grandiose vision, nor is there aggressive branding.
**ark linux** is literally just **vanilla arch linux** wrapped within an immutable container architecture (oci/bootc). that is the only difference.

if you appreciate vanilla arch linux but desire the smart atomic updates of immutable operating systems without the fear of system breakage, ark linux is the perfect vessel. there is no bloatware, no custom themes, just arch linux rendered immune to update failures.

## key features
- **100% pure arch linux**: utilises `docker.io/archlinux:latest` directly as the base image without third-party repositories.
- **immutable & atomic**: read-only file system with delta updates. should an update fail, you simply roll back via the grub menu.
- **smart updater**: a lightweight, rust & gtk4-based updater application (`alga`) that automatically detects the os state.
- **nvidia ready**: automatically provides a variant pre-configured with proprietary nvidia drivers.
- **production ready**: as this pulls directly from official arch linux, this is not a work-in-progress or pre-release. it is stable and ready for daily use.

## installation
manual arch linux terminal installation is no longer required.
1. download the latest installer iso from the **releases** page.
2. flash to a usb drive and boot your machine (if prompted for a live login, use user: `ark`, password: `arklinux`).
3. you will be greeted by a rust-based gui installer that seamlessly deploys *ark linux* in minutes.

## zero-maintenance architecture
as ark linux is not a separate distribution, updates are pulled directly from the official arch linux mirrors via github actions every sunday. the base image is automatically built and pushed to the github container registry.
your local machine simply pulls the delta layers, updates quietly in the background without interrupting your workflow, and applies the changes upon the next reboot.
