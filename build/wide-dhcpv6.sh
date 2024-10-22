#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=wide-dhcpv6
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/wide-dhcpv6 -b debian/20080615-23 --single-branch; cd wide-dhcpv6
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; cd ..; ./build.sh
mv *.deb "$WORKDIR"
