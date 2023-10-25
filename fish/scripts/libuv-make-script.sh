#!/bin/bash
sudo apt-get install -y make build-essential autoconf automake libtool

git clone https://github.com/libuv/libuv.git & cd libuv

sh autogen.sh
./configure
make
make check
make install