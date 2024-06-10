#!/bin/bash
set -euo pipefail

PACKAGE=ocserv
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://salsa.debian.org/debian/ocserv/ -b debian/1.1.6-3 --single-branch; cd ocserv
sed -i 's/debhelper-compat (= 13)/debhelper-compat (= 12)/' debian/control
dpkg-buildpackage -uc -us -tc -b
