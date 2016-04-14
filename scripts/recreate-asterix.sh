#!/bin/bash

scriptdir=`dirname $0`
# This path to docker-compose.yml must be be the ABSOLUTE path on the
# DOCKER HOST, because docker is always invoked in the host context.
docker-compose -f /home/couchbase/docker/app/docker-compose.yml up -d --force-recreate nc1 nc2 nc3 nc4
${scriptdir}/install-asterix.sh /home/couchbase/*.zip

