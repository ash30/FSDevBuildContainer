echo "-- BUILDING libks --"
cd /usr/src/libs/libks  
cmake . -DCMAKE_INSTALL_PREFIX=/usr -DWITH_LIBBACKTRACE=1 
make install

echo "-- BUILDING sofia-sip --"
cd /usr/src/libs/sofia-sip
./bootstrap.sh 
./configure CFLAGS="-g -ggdb" --with-pic --with-glib=no --without-doxygen --disable-stun --prefix=/usr
make -j`nproc --all` 
make install

echo "-- BUILDING spandsp --"
cd /usr/src/libs/spandsp 
git checkout 0d2e6ac 
./bootstrap.sh 
./configure CFLAGS="-g -ggdb" --with-pic --prefix=/usr 
make -j`nproc --all` 
make install

echo "-- BUILDING signalwire-c --"
cd /usr/src/libs/signalwire-c 
PKG_CONFIG_PATH=/usr/lib/pkgconfig cmake . -DCMAKE_INSTALL_PREFIX=/usr 
make install
