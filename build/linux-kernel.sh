#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=linux-kernel
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE

# read the required Kernel version
KERNEL_VER=$(cat ../../data/defaults.toml | tomlq -r .kernel_version)
gpg2 --locate-keys torvalds@kernel.org gregkh@kernel.org
curl -OL https://www.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VER}.tar.xz
curl -OL https://www.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VER}.tar.sign
xz -cd linux-${KERNEL_VER}.tar.xz | gpg2 --verify linux-${KERNEL_VER}.tar.sign -
if [ $? -ne 0 ]; then
    exit 1
fi

# Unpack Kernel source
tar xf linux-${KERNEL_VER}.tar.xz
ln -s linux-${KERNEL_VER} linux
# ... Build Kernel
./build-kernel.sh

git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git -b 20231211 --single-branch
./build-linux-firmware.sh

git clone https://github.com/accel-ppp/accel-ppp.git --single-branch; cd accel-ppp; git checkout 19c36e593d9b; cd ..
./build-accel-ppp.sh

./build-intel-qat.sh
./build-intel-ixgbe.sh
./build-intel-ixgbevf.sh
./build-jool.py

git clone https://github.com/OpenVPN/ovpn-dco -b v0.2.20231117 --single-branch
./build-openvpn-dco.sh

mv *.deb "$WORKDIR"
