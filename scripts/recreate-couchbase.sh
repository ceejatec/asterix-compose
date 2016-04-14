#!/bin/bash

scriptdir=`dirname $0`
# This path to docker-compose.yml must be be the ABSOLUTE path on the
# DOCKER HOST, because docker is always invoked in the host context.
docker-compose -f /home/couchbase/docker/app/docker-compose.yml up -d --force-recreate couchbase1.host couchbase2.host couchbase3.host
echo Sleeping until Couchbase initializes...
sleep 7
${scriptdir}/config-couchbase.sh

