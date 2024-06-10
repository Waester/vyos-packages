#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=openvpn-otp
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/evgeny-gridasov/openvpn-otp -b master --single-branch
./build-openvpn-otp.sh
mv *.deb "$WORKDIR"
