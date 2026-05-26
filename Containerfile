FROM ghcr.io/apollo-linux/apollo-nvidia:latest

# Install bootupd and required dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm bootupd util-linux openssl grub efibootmgr dosfstools && \
    echo "=== Verifying bootupd installation ===" && \
    which bootupctl && \
    bootupctl --version && \
    which bootupd && \
    ls -lah /usr/libexec/bootupd && \
    ls -lah /usr/bin/bootupctl && \
    test -x /usr/libexec/bootupd && \
    echo "✓ bootupd successfully installed"
