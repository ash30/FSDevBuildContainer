ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

sync_libks:
	-git clone https://github.com/signalwire/libks _SRC/libks 

sync_sofia:
	-git clone https://github.com/freeswitch/sofia-sip _SRC/sofia-sip

sync_spandsp:
	-git clone https://github.com/freeswitch/spandsp _SRC/spandsp

sync_signalwirec:
	-git clone https://github.com/signalwire/signalwire-c _SRC/signalwire-c

sync_freeswitch:
	-git clone https://github.com/signalwire/freeswitch _SRC/freeswitch

sync: sync_libks sync_sofia sync_spandsp sync_signalwirec sync_freeswitch
	-mkdir _SRC

build:
	docker build -t fs_dev_env:latest .

edit: 
	sed -e "s|%ROOT%|$(ROOT_DIR)/_SRC/freeswitch|" "$(ROOT_DIR)/init.lua" | sed -e "s|%STD_ENV%|$(CC_RESOURCE_DIR)|" > "$(ROOT_DIR)/_SRC/freeswitch/.nvim.lua"
	cd "$(ROOT_DIR)/_SRC/freeswitch"; nvim .

run:
	docker run \
		-v "$(ROOT_DIR)"/_SRC/libks:/usr/src/libs/libks \
		-v "$(ROOT_DIR)"/_SRC/sofia-sip:/usr/src/libs/sofia-sip \
		-v "$(ROOT_DIR)"/_SRC/spandsp:/usr/src/libs/spandsp \
		-v "$(ROOT_DIR)"/_SRC/signalwire-c:/usr/src/libs/signalwire-c \
		-v "$(ROOT_DIR)"/_SRC/freeswitch:/usr/src/freeswitch \
		-it fs_dev_env:latest bash -c 'cd /usr/src; cp /tmp/compile_commands.json /usr/src/freeswitch/; bash'
