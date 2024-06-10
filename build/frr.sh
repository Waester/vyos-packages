#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=frr
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE

git clone https://github.com/CESNET/libyang.git -b v2.1.148 --single-branch; cd libyang
pipx run apkg build -i; find pkg/pkgs -type f -name *.deb -exec mv -t .. {} +
cd ..

git clone https://github.com/rtrlib/rtrlib.git -b v0.8.0 --single-branch; cd rtrlib
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage -uc -us -tc -b
cd ..

git clone https://github.com/FRRouting/frr.git -b stable/9.1 --single-branch; cd frr
sudo dpkg -i ../*.deb; sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; cd ..; ./build-frr.sh

mv *.deb "$WORKDIR"
