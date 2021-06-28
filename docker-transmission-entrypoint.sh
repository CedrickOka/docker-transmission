#!/bin/sh
set -e

## Start transmission daemon
# First arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- transmission-daemon "$@"
fi

exec "$@"
