#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=radvd
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/radvd-project/radvd --single-branch; cd radvd; git checkout f2de4764559; cd ..
./build.sh
mv *.deb "$WORKDIR"
