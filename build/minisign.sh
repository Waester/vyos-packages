#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=minisign
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/jedisct1/minisign -b 0.9 --single-branch
./build-minisign.sh
mv *.deb "$WORKDIR"
