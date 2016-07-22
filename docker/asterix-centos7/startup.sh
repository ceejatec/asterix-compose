#!/bin/bash

# First, copy any files in /ssh to /home/couchbase/.ssh, changing ownership to
# user couchbase and maintaining permissions
if [ -d /ssh ] && [ "$(ls -A /ssh)" ]
then
    cp -a /ssh/* /home/couchbase/.ssh
fi
cat /usr/sbin/sshconfigbase >> /home/couchbase/.ssh/config
chown -R couchbase:couchbase /home/couchbase/.ssh
chmod 600 /home/couchbase/.ssh/*

# Start sshd (as new, long-running, foreground process)
[[ "$1" == "default" ]] && {
    chown -R couchbase:couchbase /home/couchbase /home/couchbase
    exec /usr/sbin/sshd -D
}

exec "$@"
