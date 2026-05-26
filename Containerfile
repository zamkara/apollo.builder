FROM ghcr.io/apollo-linux/apollo-nvidia:latest

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git && \
    git clone https://aur.archlinux.org/bootupd.git /tmp/bootupd && \
    cd /tmp/bootupd && \
    makepkg -si --noconfirm && \
    rm -rf /tmp/bootupd
