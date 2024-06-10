#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=dropbear
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/dropbear.git -b debian/2019.78-2 --single-branch
./build.sh
mv *.deb "$WORKDIR"
