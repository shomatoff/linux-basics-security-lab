#!/usr/bin/env bash
# Portfolio sample. Assignment-specific permissions are unsafe outside a lab.
# Explicit opt-in prevents accidental changes after cloning this public repo.
set -Eeuo pipefail
export PATH=/usr/sbin:/usr/bin:/sbin:/bin

if [[ ${LAB_VM_ONLY:-} != yes || $EUID -ne 0 ]]; then
    echo 'Lab VM and root required: LAB_VM_ONLY=yes bash setup_linux.sh' >&2
    exit 1
fi
# shellcheck source=/dev/null
. /etc/os-release
[[ $ID == kali ]] || { echo 'Kali Linux lab VM required.' >&2; exit 1; }

for group in default_users secret_users; do
    getent group "$group" >/dev/null || groupadd "$group"
done

ensure_user() {
    local name=$1 group=$2
    if id "$name" >/dev/null 2>&1; then
        usermod -g "$group" "$name"
    else
        useradd -m -s /bin/bash -g "$group" "$name"
    fi
}

ensure_user user default_users
for name in secret_agent secret_spy secret_boss; do
    ensure_user "$name" secret_users
    home_dir=$(getent passwd "$name" | cut -d: -f6)
    [[ $home_dir == "/home/$name" && -d $home_dir && ! -L $home_dir ]] || exit 1
    chgrp -R secret_users "$home_dir"
    chmod -R g+rwX,o-rwx "$home_dir"
    find "$home_dir" -type d -exec chmod g+s {} +
    chmod 2770 "$home_dir"
    # New files also need group access, not only the current home contents.
    for startup in .profile .bashrc; do
        touch "$home_dir/$startup"
        if ! grep -qx 'umask 0007 # School21 secret_users' "$home_dir/$startup"; then
            sed -i '1i umask 0007 # School21 secret_users' "$home_dir/$startup"
        fi
        chown "$name:secret_users" "$home_dir/$startup"
        chmod 0660 "$home_dir/$startup"
    done
done

# LAB ONLY: the assignment explicitly asks for a world-writable /var.
# This is unsafe on a real server; no child permissions are changed here.
chmod a+rwx /var

DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 sudo
systemctl enable --now apache2
systemctl is-active --quiet apache2

# LAB ONLY: the assignment explicitly asks for passwordless sudo.
sudoers_file=$(mktemp)
trap 'rm -f -- "$sudoers_file"' EXIT
printf '%%default_users ALL=(ALL:ALL) NOPASSWD: ALL\n' >"$sudoers_file"
visudo -cf "$sudoers_file"
install -o root -g root -m 0440 "$sudoers_file" /etc/sudoers.d/99-school21-default-users
visudo -c
