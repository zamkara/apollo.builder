FROM ghcr.io/apollo-linux/apollo-nvidia:latest as builder

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git sudo fakeroot binutils && \
    useradd -m builder && \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /tmp
RUN git clone https://aur.archlinux.org/bootupd.git && \
    cd bootupd && \
    sudo -u builder bash -c ' \
      makepkg -s --noconfirm \
    ' && \
    # Extract and verify package contents before installation
    tar -tzf bootupd-*.pkg.tar.zst | head -20 && \
    # Install the built package
    pacman -U --noconfirm bootupd-*.pkg.tar.zst && \
    # Verify installation
    which bootupctl && \
    bootupctl --version && \
    ls -lah /usr/libexec/bootupd /usr/bin/bootupctl && \
    ls -lah /usr/lib/bootupd/ && \
    ls -lah /usr/lib/systemd/system/bootloader-update.service

# Copy final image from base
FROM ghcr.io/apollo-linux/apollo-nvidia:latest

# Copy bootupd binaries and libraries from builder stage
COPY --from=builder /usr/libexec/bootupd /usr/libexec/bootupd
COPY --from=builder /usr/bin/bootupctl /usr/bin/bootupctl
COPY --from=builder /usr/lib/bootupd /usr/lib/bootupd
COPY --from=builder /usr/lib/systemd/system/bootloader-update.service /usr/lib/systemd/system/

# Set proper permissions and verify
RUN chmod +x /usr/libexec/bootupd /usr/bin/bootupctl && \
    ls -lah /usr/libexec/bootupd /usr/bin/bootupctl && \
    bootupctl --version && \
    echo "✓ bootupd successfully installed" && \
    # Verify ostree can find bootupd
    test -x /usr/libexec/bootupd || (echo "ERROR: bootupd not executable" && exit 1)
