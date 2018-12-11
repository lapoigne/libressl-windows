#!/usr/bin/env bash


libresslver=$1 # libressl-2.8.2.tar.gz
libressldir="${1%.tar.gz}"

cd /
rm -r $libressldir
tar xzf $libresslver
cd $libressldir

CC="i686-w64-mingw32-gcc -static-libgcc" CPPFLAGS=-D__MINGW_USE_VC2005_COMPAT LDFLAGS='-static-libgcc' \
./configure --host=i686-w64-mingw32
make -j4
make -j4 install-exec DESTDIR=`pwd`/stage

# Copy cnf
#cp /usr/i686-w64-mingw32/sys-root/mingw/bin/*.dll `pwd`/stage/usr/local/bin/
cp `pwd`/stage/usr/local/etc/ssl/openssl.cnf `pwd`/stage/usr/local/bin/

# Create archive
cd `pwd`/stage/usr/local/bin/
zip /${libressldir}.zip *
