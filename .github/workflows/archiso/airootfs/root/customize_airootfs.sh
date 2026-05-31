#!/usr/bin/env bash
set -e

# Patch archiso initcpio hook to use originium.sfs instead of airootfs.sfs
sed -i 's/airootfs\.sfs/originium.sfs/g' /usr/lib/initcpio/hooks/archiso || true
sed -i 's/airootfs\.sha512/originium.sha512/g' /usr/lib/initcpio/hooks/archiso || true

# Hide unwanted apps
rm -f /usr/share/applications/{bssh,bvnc,avahi-discover,qv4l2,qvidcap,stoken-gui,stoken-gui-small,org.gnome.Extensions,org.gnome.TextEditor,lstopo}.desktop || true

# Compile schemas to ensure MoreWaita and app folders apply
glib-compile-schemas /usr/share/glib-2.0/schemas || true

# Generate all UTF-8 locales
sed -i 's/^#\(.*UTF-8.*\)/\1/' /etc/locale.gen || true
sed -i '/@/s/^/#/' /etc/locale.gen || true
locale-gen

# Enable GDM and NetworkManager
systemctl enable gdm NetworkManager
systemctl set-default graphical.target

# Create arch user for Live session if missing, and enable auto-login
useradd -m -G wheel -s /bin/bash arch || true
passwd -d arch || true
mkdir -p /etc/gdm
cat << 'EOF' > /etc/gdm/custom.conf
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=arch
EOF

# Rebuild initramfs so the patched hook is included!
mkinitcpio -P
