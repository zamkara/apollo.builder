FROM ghcr.io/apollo-linux/apollo-nvidia:latest as builder

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git sudo && \
    useradd -m builder && \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sudo -u builder bash -c ' \
      cd /tmp && \
      git clone https://aur.archlinux.org/bootupd.git && \
      cd bootupd && \
      makepkg -si --noconfirm \
    ' && \
    # Verify bootupd installation
    which bootupctl && \
    ls -lah /usr/libexec/bootupd /usr/bin/bootupctl /usr/lib/bootupd/

# Copy final image from base
FROM ghcr.io/apollo-linux/apollo-nvidia:latest

# Copy bootupd binaries and libraries from builder stage
COPY --from=builder /usr/libexec/bootupd /usr/libexec/bootupd
COPY --from=builder /usr/bin/bootupctl /usr/bin/bootupctl
COPY --from=builder /usr/lib/bootupd /usr/lib/bootupd
COPY --from=builder /usr/lib/systemd/system/bootloader-update.service /usr/lib/systemd/system/

# Verify bootupd is available and set proper permissions
RUN chmod +x /usr/libexec/bootupd /usr/bin/bootupctl && \
    bootupctl --version && \
    echo "✓ bootupd successfully installed"
