#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=ddclient
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/ddclient -b debian/3.10.0-3 --single-branch ddclient-debian
git clone https://github.com/ddclient/ddclient -b v3.11.2 --single-branch ddclient-github
./build.sh
mv *.deb "$WORKDIR"
