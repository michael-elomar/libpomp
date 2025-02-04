#! /bin/bash

set -e

export PACKAGE_NAME="libpomp-dev"
export VERSION="1.0.0"

export SRC_ROOT_DIR=$(dirname $(readlink -f ${0}))
export DEB_PACKAGE_ROOT="${SRC_ROOT_DIR}/deb"
export CMAKE_INSTALL_DIR="${DEB_PACKAGE_ROOT}/opt/${PACKAGE_NAME}/usr"
export SYSTEM_INSTALL_DIR="/opt/${PACKAGE_NAME}/usr"

rm -rf $INSTALL_DIR
mkdir -p $CMAKE_INSTALL_DIR

cd "${SRC_ROOT_DIR}"
cmake --preset linux
cmake --build build
cmake --install build

rm -rf ${DEB_PACKAGE_ROOT}/usr/

mkdir -p ${DEB_PACKAGE_ROOT}/usr/include/
mkdir -p ${DEB_PACKAGE_ROOT}/usr/lib
mkdir -p ${DEB_PACKAGE_ROOT}/usr/lib/cmake

cd ${DEB_PACKAGE_ROOT}/usr/include/

ln -s ${SYSTEM_INSTALL_DIR}/include/libpomp.h libpomp.h
ln -s ${SYSTEM_INSTALL_DIR}/include/libpomp.hpp libpomp.hpp
ln -s ${SYSTEM_INSTALL_DIR}/include/libpomp-cxx11.hpp libpomp-cxx11.hpp

cd ${DEB_PACKAGE_ROOT}/usr/lib/

ln -s ${SYSTEM_INSTALL_DIR}/lib/libpomp.so libpomp.so
ln -s ${SYSTEM_INSTALL_DIR}/lib/cmake/pomp cmake/pomp

cd "${SRC_ROOT_DIR}"

dpkg-deb --build deb deb/$PACKAGE_NAME-${VERSION}.deb