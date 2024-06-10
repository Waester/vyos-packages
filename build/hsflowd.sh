#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=hsflowd
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/sflow/host-sflow.git -b v2.0.55-1 --single-branch
./build.sh
mv host-sflow/*.deb "$WORKDIR"
