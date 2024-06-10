#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=hostap
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/wpa -b debian/2%2.10-12 --single-branch
git clone git://w1.fi/srv/git/hostap.git --single-branch; cd hostap; git checkout 6b9c86466; cd ..
./build.sh
mv *.deb "$WORKDIR"
