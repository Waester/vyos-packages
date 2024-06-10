#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=keepalived
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/pkg-keepalived.git -b debian/1%2.2.8-1 --single-branch; cd pkg-keepalived
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; ../build.py
cd ..
mv *.deb "$WORKDIR"
