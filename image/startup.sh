#!/bin/bash
# Start sshd (as new, long-running, foreground process)
[[ "$1" == "default" ]] && {
    chown -R couchbase:couchbase /home/couchbase /home/couchbase
    exec /usr/sbin/sshd -D
}

exec "$@"
