#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=pyhumps
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/nficano/humps.git -b v3.8.0 --single-branch; cd humps
python setup.py --command-packages=stdeb.command bdist_deb
mv deb_dist/*.deb "$WORKDIR"
