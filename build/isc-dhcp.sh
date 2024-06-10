#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=isc-dhcp
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/isc-dhcp -b debian/4.4.3-P1-4 --single-branch; cd isc-dhcp
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; cd ..; ./build.sh
mv *.deb "$WORKDIR"
