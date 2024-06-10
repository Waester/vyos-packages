#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=dropbear
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/dropbear.git -b debian/2022.83-1+deb12u1 --single-branch; cd dropbear
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; cd ..; ./build.sh
mv *.deb "$WORKDIR"
