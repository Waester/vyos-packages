#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=libnss-tacplus
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

export DEB_CFLAGS_APPEND="-Wno-address -Wno-stringop-truncation"

git clone https://github.com/vyos/libtacplus-map.git -b master --single-branch; cd libtacplus-map
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage -uc -us -tc -b
cd ..

git clone https://github.com/vyos/libpam-tacplus.git -b master --single-branch; cd libpam-tacplus
sudo dpkg -i ../*.deb; sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage -uc -us -tc -b
cd ..

git clone https://github.com/vyos/libnss-tacplus.git -b master --single-branch; cd libnss-tacplus
sudo dpkg -i ../*.deb; sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage -uc -us -tc -b
