#!/bin/bash

scriptdir=`dirname $0`
docker-compose -f ${scriptdir}/../app/docker-compose.yml up -d --force-recreate couchbase1.host couchbase2.host couchbase3.host
echo Sleeping until Couchbase initializes...
sleep 7
${scriptdir}/config-couchbase.sh

