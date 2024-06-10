#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=keepalived
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/acassen/keepalived -b v2.2.8 --single-branch
./build.sh
mv *.deb "$WORKDIR"
