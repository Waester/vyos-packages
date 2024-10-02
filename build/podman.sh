#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=podman
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/containers/podman -b v4.9.5 --single-branch
./build.sh
mv *.deb "$WORKDIR"
