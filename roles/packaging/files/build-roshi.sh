#!/usr/bin/env bash
# Build roshi and create debian package
if [ -z $GOPATH ]; then
  echo "GOPATH not found"
  exit 2
fi

ROSHI_SERVER="github.com/soundcloud/roshi/roshi-server"
ROSHI_VERSION=${ROSHI_VERSION-"0.0.2-1"}
ROSHI_PKG=${ROSHI_PKG-"/usr/local"}
go get ${ROSHI_SERVER}

if [ $# -ne 0 ]; then
   echo "Couldn\'t download and build roshi server"
   exit 2
fi

# Create package structure
mkdir ${ROSHI_PKG}/roshi-server_${ROSHI_VERSION}
mkdir -p ${ROSHI_PKG}/roshi-server_${ROSHI_VERSION}/usr/local/sbin
cp ${GOPATH}/bin/roshi-server ${ROSHI_PKG}/roshi-server_${ROSHI_VERSION}/usr/local/sbin/
mkdir ${ROSHI_PKG}/roshi-server_${ROSHI_VERSION}/DEBIAN
cat <<EOF > ${ROSHI_PKG}/roshi-server_${ROSHI_VERSION}/DEBIAN/control 
Package: roshi-server
Version: ${ROSHI_VERSION}
Section: base
Priority: optional
Architecture: amd64
Maintainer: Hecber Cordova <hecber@gmail.com>
Description: Roshi Server
  Soundcloud Roshi Server
EOF

cd ${ROSHI_PKG}/ 
dpkg-deb --build roshi-server_${ROSHI_VERSION}
if [ $# -ne 0 ]; then
   echo "Couldn\'t create deb package"
   exit 2
fi
