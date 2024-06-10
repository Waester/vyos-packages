#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=netfilter
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE

git clone https://salsa.debian.org/pkg-netfilter-team/pkg-libnftnl.git -b debian/1.2.6-2 --single-branch; cd pkg-libnftnl
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage -uc -us -tc -b
cd ..

git clone https://salsa.debian.org/pkg-netfilter-team/pkg-nftables.git -b debian/1.0.9-1 --single-branch; cd pkg-nftables
sudo dpkg -i ../libnftnl*.deb; sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; ../build.py
cd ..

mv *.deb "$WORKDIR"
