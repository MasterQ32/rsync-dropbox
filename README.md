# rsync Drop Box

A small container that allows exposing directories via SSH+rsync.

## Usage:

```sh-session
docker run \
    -p 22:22/tcp \
    -v "$(pwd)/test/data:/data:rw" \
    -v "$(pwd)/test/config:/config:ro" \
    ikskuh/sshfs
```

### Volumes

| Volume Mount Point | Access     | Content                                         |
| ------------------ | ---------- | ----------------------------------------------- |
| `/config`          | read-only  | Must contain the `authorized_keys` files.       |
| `/data`            | read-write | This directory is meant to be accessed via SSH. |

### Ports

| Port | Protocol | Function              |
| ---- | -------- | --------------------- |
| 22   | TCP      | Exposes the SSH port. |

## `authorized_keys`

This file is the authorized keys file for the OpenSSH daemon. The file structure should be configured like this:

```conf
command="/usr/bin/rrsync -munge -wo /data/folder_a" ssh-rsa ${sshkey_a}
command="/usr/bin/rrsync -munge -ro /data/folder_b" ssh-rsa ${sshkey_b}
```

Using `rrsync -wo` restricts `rsync` to only write to the provided folder, while `rrsync -ro` allows only fetching data from the folder.

See more in the [`rrsync` documentation](https://download.samba.org/pub/rsync/rrsync.1).

## Testing

Using the script `test.sh`, you have to create three directories:

```sh-session
[user@host] rsync-dropbox $ mkdir -p test/config test/data
[user@host] rsync-dropbox $ touch test/config/authorized_keys
```

Then add your key + prefix to the `authorized_keys` file and start the container:

```sh-session
[user@host] rsync-dropbox $ docker run \
    --rm \
    -p 127.0.0.1:222:22/tcp \
    -v "$(pwd)/test/data:/data:rw" \
    -v "$(pwd)/test/config:/config:ro" \
    ikskuh/sshfs
```