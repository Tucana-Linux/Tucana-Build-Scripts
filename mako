#!/bin/bash

export CFLAGS=-"O2"
export CXXFLAGS="-O2"


PKG_VER=1.2.4
URL=https://files.pythonhosted.org/packages/source/M/Mako/Mako-$PKG_VER.tar.gz
TAR=$(echo $URL | sed -r 's|(.*)/||')
DIR=$(echo $TAR | sed 's|.tar.*||g')
PACKAGE=mako

# Get Package

cd /blfs/builds
wget $URL
tar -xvf $TAR
cd $DIR

# Build


python3 setup.py build




# Install
sudo python3 setup.py install --root="/pkgs/$PACKAGE" --optimize=1
cd /pkgs

cp -rpv /pkgs/$PACKAGE/* /

sudo echo "markupsafe python setuptools" > /pkgs/$PACKAGE/depends
sudo echo "" > /pkgs/$PACKAGE/make-depends
sudo echo "$PKG_VER" > /pkgs/$PACKAGE/version
sudo tar -cvapf $PACKAGE.tar.xz $PACKAGE
sudo cp $PACKAGE.tar.xz /finished


cd /blfs/builds
sudo rm -r $DIR


