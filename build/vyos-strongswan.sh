#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=vyos-strongswan
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

apt-get update; apt-get install -y libcurl4-openssl-dev

git clone https://github.com/vyos/vyos-strongswan.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-strongswan
dpkg-buildpackage --build=binary --no-sign

./configure --enable-python-eggs
cd src/libcharon/plugins/vici/python/; make
python3 setup.py --command-packages=stdeb.command bdist_deb

mv deb_dist/*.deb "$WORKDIR"
