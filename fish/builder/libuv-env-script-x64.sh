#!/bin/bash
apt-get install -y make build-essential autoconf automake libtool

git clone https://github.com/libuv/libuv.git 
cd libuv

sh autogen.sh
./configure
make
make check
make install

find . -mindepth 1 -maxdepth 1 ! -name '.' ! -name '..' ! -name 'include' ! -name '.libs' -exec rm -r {} +