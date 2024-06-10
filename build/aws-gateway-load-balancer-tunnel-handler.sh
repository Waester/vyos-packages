#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=aws-gateway-load-balancer-tunnel-handler
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

git clone https://github.com/vyos/vyos-build.git -b $(git rev-parse --abbrev-ref HEAD) --single-branch; cd vyos-build/packages/$PACKAGE
git clone https://github.com/aws-samples/aws-gateway-load-balancer-tunnel-handler --single-branch; cd aws-gateway-load-balancer-tunnel-handler; git checkout f78058a; cd ..
sed -i 's/^dpkg-deb --build aws-gwlbtun$/dpkg-deb --build aws-gwlbtun ./' build.sh
./build.sh
mv *.deb "$WORKDIR"
