#!/usr/bin/env bash
# Portfolio sample: run only in an expendable Kali lab VM.
# Never commit the generated inventory: it can reveal machine details and ports.
set -Eeuo pipefail
export LC_ALL=C
export PATH=/usr/sbin:/usr/bin:/sbin:/bin

if [[ ${LAB_VM_ONLY:-} != yes || $EUID -ne 0 ]]; then
    echo 'Lab VM and root required: LAB_VM_ONLY=yes bash get_all_info.sh' >&2
    exit 1
fi

output_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
work_dir=$(mktemp -d)
trap 'rm -rf -- "$work_dir"' EXIT

DEBIAN_FRONTEND=noninteractive apt-get install -y cowsay sl >"$work_dir/install.log" 2>&1
{
    printf '=== OS AND KERNEL ===\n'
    uname -a
    cat /etc/os-release
    printf '\n=== INSTALLED PACKAGES ===\n'
    dpkg-query -W -f='${binary:Package}\t${Version}\t${db:Status-Status}\n'
    printf '\n=== RUNNING PROCESSES ===\n'
    ps aux
    printf '\n=== LISTENING PORTS ===\n'
    ss -tulpn
    printf '\n=== COWSAY AND SL INSTALLATION ===\n'
    cat "$work_dir/install.log"
} >"$work_dir/info"

tar -cf "$work_dir/OS_RESULT.tar" -C "$work_dir" info
install -m 0600 "$work_dir/OS_RESULT.tar" "$output_dir/OS_RESULT.tar"
echo 'Lab inventory archive created locally. Keep it private.'
