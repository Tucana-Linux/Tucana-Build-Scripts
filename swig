#!/bin/bash

export CFLAGS=-"O2"
export CXXFLAGS="-O2"

#HOLD_TUCANA
PKG_VER=4.3.1
URL=https://downloads.sourceforge.net/swig/swig-$PKG_VER.tar.gz
TAR=$(echo $URL | sed -r 's|(.*)/||')
DIR=$(echo $TAR | sed 's|.tar.*||g')
PACKAGE=$(echo $DIR | sed 's|-[^-]*$||g')

# Get Package

cd /blfs/builds
wget $URL
tar -xvf $TAR
cd $DIR

# Build


./configure --prefix=/usr                      \
            --without-javascript               \
            --without-maximum-compile-warnings 

make -j22


# Install
sudo make DESTDIR=/pkgs/$PACKAGE install
sudo make install
cd /pkgs



sudo echo "pcre2" > /pkgs/$PACKAGE/depends
sudo echo "" > /pkgs/$PACKAGE/make-depends
sudo echo "$PKG_VER" > /pkgs/$PACKAGE/version
sudo tar -cvapf $PACKAGE.tar.xz $PACKAGE
sudo cp $PACKAGE.tar.xz /finished


cd /blfs/builds
sudo rm -r $DIR


