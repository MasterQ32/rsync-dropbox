#!/bin/sh

set -e

docker build -t ikskuh/sshfs .

docker run \
    --rm \
    --name sshdemo \
    -p 127.0.0.1:222:22/tcp \
    -v "$(pwd)/test/data:/data:rw" \
    -v "$(pwd)/test/config:/config:ro" \
    ikskuh/sshfs
