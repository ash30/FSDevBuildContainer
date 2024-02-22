cd /usr/src/freeswitch
./bootstrap.sh -j
./configure
bear -- make -j`nproc` && make install
cp compile_commands.json /tmp/

