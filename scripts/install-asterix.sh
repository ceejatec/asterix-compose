#!/bin/bash -x

# This script assumes the 4-node Docker cluster is up, and has not
# previously had Asterix installed on it
scriptdir=`dirname $0`
rm -rf /home/couchbase/shared/*
cp ${scriptdir}/docker-cluster.xml $* /home/couchbase/shared
docker exec -u couchbase app_nc1_1 mkdir /home/couchbase/managix
docker exec -u couchbase app_nc1_1 unzip -d /home/couchbase/managix /home/couchbase/shared/\*.zip
docker exec -u couchbase app_nc1_1 /home/couchbase/managix/bin/managix configure
docker exec -u couchbase app_nc1_1 /home/couchbase/managix/bin/managix validate
docker exec -u couchbase app_nc1_1 /home/couchbase/managix/bin/managix create -n docker-cluster -c /home/couchbase/shared/docker-cluster.xml 
echo $?

