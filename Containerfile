FROM ghcr.io/apollo-linux/apollo-nvidia:latest as builder

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git sudo && \
    useradd -m builder && \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/builder
RUN git clone https://aur.archlinux.org/bootupd.git && \
    chown -R builder:builder bootupd

WORKDIR /home/builder/bootupd
RUN sudo -u builder makepkg -s --noconfirm && \
    pacman -U --noconfirm *.pkg.tar.zst

# Copy final image from base
FROM ghcr.io/apollo-linux/apollo-nvidia:latest

# Install runtime dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm util-linux openssl grub efibootmgr dosfstools

# Copy bootupd from builder stage
COPY --from=builder /usr/libexec/bootupd /usr/libexec/bootupd
COPY --from=builder /usr/bin/bootupctl /usr/bin/bootupctl
COPY --from=builder /usr/lib/bootupd /usr/lib/bootupd
COPY --from=builder /usr/lib/systemd/system/bootloader-update.service /usr/lib/systemd/system/

# Create symbolic links and ensure bootupd is in standard paths
RUN chmod +x /usr/libexec/bootupd /usr/bin/bootupctl && \
    ln -sf /usr/libexec/bootupd /usr/sbin/bootupd && \
    echo "=== Verifying bootupd installation ===" && \
    bootupctl --version && \
    which bootupctl && \
    which bootupd || echo "Creating bootupd symlink..." && \
    ls -lah /usr/libexec/bootupd && \
    ls -lah /usr/sbin/bootupd && \
    test -x /usr/libexec/bootupd && \
    test -x /usr/sbin/bootupd && \
    echo "✓ bootupd successfully installed"
