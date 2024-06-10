#!/bin/bash
set -euo pipefail

PACKAGE=vyos-xe-guest-utilities
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

apt-get update; apt-get install -y golang

git clone https://github.com/vyos/vyos-xe-guest-utilities.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-xe-guest-utilities
dpkg-buildpackage --build=binary --no-sign --post-clean
