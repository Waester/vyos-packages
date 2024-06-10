#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=ethtool
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://salsa.debian.org/kernel-team/ethtool -b debian/1%6.6-1 --single-branch; cd ethtool
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage -uc -us -tc -b
