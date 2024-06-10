#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=strongswan
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/strongswan.git -b debian/5.9.11-2 --single-branch
./build.sh
mv *.deb "$WORKDIR"

cd strongswan
git reset --hard; git clean -df
./configure --enable-python-eggs
cd src/libcharon/plugins/vici/python/; make
python3 setup.py --command-packages=stdeb.command bdist_deb
mv deb_dist/*.deb "$WORKDIR"
