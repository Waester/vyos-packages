#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=telegraf
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/influxdata/telegraf.git -b v1.28.3 --single-branch
./build.sh
mv telegraf/build/dist/*.deb "$WORKDIR"
