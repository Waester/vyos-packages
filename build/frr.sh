#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=frr
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/FRRouting/frr.git -b stable/7.5 --single-branch
./build-frr.sh
mv *.deb "$WORKDIR"
