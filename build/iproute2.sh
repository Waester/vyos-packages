#!/bin/bash
set -euo pipefail

PACKAGE=iproute2
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://salsa.debian.org/debian/iproute2 -b debian/5.4.0-1_bpo10+1 --single-branch; cd iproute2
dpkg-buildpackage -uc -us -tc -b
