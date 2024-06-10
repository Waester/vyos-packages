#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=hostap
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/wpa -b debian/2%2.10-7 --single-branch
git clone git://w1.fi/srv/git/hostap.git --single-branch; cd hostap; git checkout b704dc72ef824dfdd96674b90179b274d1d38105; cd ..
./build.sh
mv *.deb "$WORKDIR"
