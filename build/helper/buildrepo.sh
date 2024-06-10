#!/bin/bash
set -euo pipefail

PACKAGE=$1
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/$PACKAGE.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd $PACKAGE
eval $(opam env --root=/opt/opam --set-root)
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"; dpkg-buildpackage --build=binary --no-sign --post-clean
