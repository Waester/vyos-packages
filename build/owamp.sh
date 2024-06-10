#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=owamp
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/perfsonar/owamp -b v4.4.6 --single-branch; cd owamp
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; cd ..; DEB_BUILD_PROFILES=nocheck ./build.sh
mv *.deb "$WORKDIR"
