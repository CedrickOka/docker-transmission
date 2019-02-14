#!/bin/bash
transmission-daemon -f --username "$RPC_USERNAME" --password "$RPC_PASSWORD" --peerport $PEER_PORT --allowed "$ALLOWED_IP_ADDRESSES" --config-dir "/var/lib/transmission-daemon/info" --logfile "/dev/stdout"
