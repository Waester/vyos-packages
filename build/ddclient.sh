#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=ddclient
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://salsa.debian.org/debian/ddclient -b debian/3.11.2-1 --single-branch; cd ddclient
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage -uc -us -tc -b
