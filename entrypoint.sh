#!/bin/bash

echo "running entrypoint.sh"

export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

grep -v -e ^lldpd: -e ^${USER_ID}: -e ^1001: /etc/passwd > "$HOME/passwd"
echo "lldpd:x:${USER_ID}:${GROUP_ID}:lldpd user:${HOME}:/sbin/nologin" >> "$HOME/passwd"

export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=${HOME}/passwd
export NSS_WRAPPER_GROUP=/etc/group

chown -R lldpd /run/lldpd $HOME

exec "$@"
