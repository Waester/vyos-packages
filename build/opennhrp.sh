#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=opennhrp
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://git.code.sf.net/p/opennhrp/code --single-branch opennhrp; cd opennhrp; git checkout 613277f; cd ..
./build.sh
mv *.deb "$WORKDIR"
