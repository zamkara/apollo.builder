#!/usr/bin/env bash
set -e

# Patch archiso initcpio hook to use originium.sfs instead of airootfs.sfs
sed -i 's/airootfs\.sfs/originium.sfs/g' /usr/lib/initcpio/hooks/archiso || true
sed -i 's/airootfs\.sha512/originium.sha512/g' /usr/lib/initcpio/hooks/archiso || true

# Hide unwanted apps
rm -f /usr/share/applications/{bssh,bvnc,avahi-discover,qv4l2,qvidcap,stoken-gui,stoken-gui-small,org.gnome.Extensions,org.gnome.TextEditor,lstopo}.desktop || true

# Compile schemas to ensure MoreWaita and app folders apply
glib-compile-schemas /usr/share/glib-2.0/schemas || true

# Generate only English locale for the Live ISO
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen || true
locale-gen

# Ensure GDM and NetworkManager are enabled
systemctl enable gdm NetworkManager
systemctl set-default graphical.target

# Disable GNOME Initial Setup for the existing ark user
mkdir -p /home/ark/.config
echo "yes" > /home/ark/.config/gnome-initial-setup-done
chown -R 10000:10000 /home/ark

# Rebuild initramfs so the patched hook is included!
mkinitcpio -P
