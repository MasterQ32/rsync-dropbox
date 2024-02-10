#!/bin/sh
ssh-keygen -A
exec /usr/sbin/sshd \
    -D \
    -e \
    -f "/sshd_config" \
    "$@"
