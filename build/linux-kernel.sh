#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=linux-kernel
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE

KERNEL_VER=$(cat ../../data/defaults.json | jq -r .kernel_version)
gpg2 --locate-keys torvalds@kernel.org gregkh@kernel.org
curl -OL https://www.kernel.org/pub/linux/kernel/v5.x/linux-${KERNEL_VER}.tar.xz
curl -OL https://www.kernel.org/pub/linux/kernel/v5.x/linux-${KERNEL_VER}.tar.sign
xz -cd linux-${KERNEL_VER}.tar.xz | gpg2 --verify linux-${KERNEL_VER}.tar.sign -
if [ $? -ne 0 ]; then
    exit 1
fi
tar xf linux-${KERNEL_VER}.tar.xz
ln -s linux-${KERNEL_VER} linux

git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git -b 20201218 --single-branch
git clone https://salsa.debian.org/debian/wireguard-linux-compat.git -b debian/1.0.20201112-1_bpo10+1 --single-branch
git clone https://github.com/accel-ppp/accel-ppp.git --single-branch; cd accel-ppp; git checkout 0b4ef9862c65bf; cd ..

./build-kernel.sh
./build-wireguard-modules.sh
./build-accel-ppp.sh
./build-intel-qat.sh
./build-intel-ice.py
./build-driver-realtek-r8152.py
./build-linux-firmware.sh

mv *.deb "$WORKDIR"
