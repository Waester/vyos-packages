#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=pmacct
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/pmacct.git -b debian/1.7.7-1 --single-branch; cd pmacct
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; sudo apt-get remove git -y; ../build.py
cd ..
mv *.deb "$WORKDIR"
