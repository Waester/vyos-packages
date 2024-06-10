#!/bin/bash
set -euo pipefail

PACKAGE=vyos-1x
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-1x.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-1x
sed -i 's/ddclient (>= 3.9.1)/ddclient (>= 3.8.3)/' debian/control
dpkg-buildpackage --build=binary --no-sign --post-clean
