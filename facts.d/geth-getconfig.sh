#!/bin/bash

# Ethereum seems not to be properly installed
if [ ! -f /lib/systemd/system/geth.service ]; then
    echo -e "{}"
    exit 0
fi

ETH_PID=$(pidof eth)

# Ethereum seems not to be running
if [ -z $ETH_PID ]; then
    echo -e "{}"
    exit 0
fi
DATADIR=$(grep datadir /lib/systemd/system/geth.service |cut --delimiter '"' --fields 2)
IPC="ipc:$(find $DATADIR -name geth.ipc)"

NODE_INFO=$(geth --exec "admin.nodeInfo" attach $IPC)
ETH=$(geth --exec "eth" attach $IPC)

echo -e "{\n  ethPid: $ETH_PID,\n nodeInfo: $NODE_INFO,\n  eth: $ETH\n}"
