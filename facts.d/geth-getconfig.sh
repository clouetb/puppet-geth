#!/bin/bash
DATADIR=$(grep datadir /lib/systemd/system/geth.service |cut --delimiter '"' --fields 2)
IPC="ipc:$(find $DATADIR -name geth.ipc)"

function fact {
    geth --exec "$1" attach $IPC
}

nodeInfo=$(fact "admin.nodeInfo")
eth=$(fact "eth")

echo -e " {\n  nodeInfo: $nodeInfo,\n  eth: $eth\n}"
