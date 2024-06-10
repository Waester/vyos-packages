#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=vyos-cloud-init
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-cloud-init.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-cloud-init
DEB_BUILD_PROFILES=nocheck ./packages/bddeb
mv *.deb "$WORKDIR"
