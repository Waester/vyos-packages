#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=net-snmp
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://salsa.debian.org/debian/net-snmp -b debian/5.9.4+dfsg-1 --single-branch; cd net-snmp 
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; cd ..; ./build.sh
mv *.deb "$WORKDIR"
