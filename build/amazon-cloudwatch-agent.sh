#!/bin/bash
set -euo pipefail

WORKDIR=$(pwd)
PACKAGE=amazon-cloudwatch-agent
echo build_name=$PACKAGE >> $GITHUB_OUTPUT

ARCH=$(dpkg --print-architecture)
export PATH=$PATH:/opt/go/bin

curl -OL https://go.dev/dl/go1.19.13.linux-$ARCH.tar.gz
rm -rf /opt/go; tar -C /opt -xzf go*.tar.gz

git clone https://github.com/aws/amazon-cloudwatch-agent.git -b v1.247358.0 --single-branch; cd amazon-cloudwatch-agent
sed -i 's/^mv/cp/' Tools/src/create_deb.sh
make build; make package-deb
mv build/private/linux_$ARCH/debian/bin/*.deb "$WORKDIR"
