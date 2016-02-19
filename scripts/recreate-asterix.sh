#!/bin/bash

scriptdir=`dirname $0`
docker-compose -f ${scriptdir}/../app/docker-compose.yml stop nc1 nc2 nc3 nc4
rm -rf ${scriptdir}/../nodes/as*
docker-compose -f ${scriptdir}/../app/docker-compose.yml up -d --force-recreate nc1 nc2 nc3 nc4
${scriptdir}/install-asterix.sh /home/couchbase/*.zip

