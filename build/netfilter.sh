#!/bin/bash
set -euo pipefail

PACKAGE=netfilter
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://salsa.debian.org/pkg-netfilter-team/pkg-libnftnl.git -b debian/1.1.7-1 --single-branch; cd pkg-libnftnl
dpkg-buildpackage -uc -us -tc -b
cd ..

git clone https://salsa.debian.org/pkg-netfilter-team/pkg-nftables.git -b debian/0.9.6-1 --single-branch; cd pkg-nftables
sed -i 's/debhelper-compat (= 13)/debhelper-compat (= 12)/' debian/control
dpkg -i ../libnftnl*.deb; dpkg-buildpackage -uc -us -tc -b
cd ..

git clone https://salsa.debian.org/pkg-netfilter-team/pkg-libnetfilter-conntrack.git -b debian/1.0.8-1 --single-branch; cd pkg-libnetfilter-conntrack
dpkg-buildpackage -uc -us -tc -b
cd ..

git clone https://salsa.debian.org/pkg-netfilter-team/pkg-conntrack-tools.git -b debian/1%1.4.6-1 --single-branch; cd pkg-conntrack-tools
dpkg -i ../libnetfilter*.deb; dpkg-buildpackage -uc -us -tc -b
cd ..
