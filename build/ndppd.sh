#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=ndppd
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/ndppd -b debian/0.2.5-6 --single-branch
./build.sh
mv *.deb "$WORKDIR"
