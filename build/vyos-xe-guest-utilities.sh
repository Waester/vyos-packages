#!/bin/bash
set -euo pipefail

PACKAGE=vyos-xe-guest-utilities
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

export PATH=$PATH:/opt/go/bin

# (20240612) Did not have a sagitta branch, using current to build.
git clone https://github.com/vyos/vyos-xe-guest-utilities.git -b current --single-branch; cd vyos-xe-guest-utilities
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage --build=binary --no-sign --post-clean
