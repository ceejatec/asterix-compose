#!/bin/bash -x

# This script assumes the 4-node Docker cluster is up, and has not
# previously had Asterix installed on it
scriptdir=`dirname $0`

docker-compose -f /home/couchbase/docker/app/docker-compose.yml up -d --force-recreate ansible
docker cp $* ansible:/home/couchbase/asterix-server-binary-assembly.zip
docker exec -u couchbase ansible ansible-playbook /home/couchbase/ansible/playbook.yml -i /home/couchbase/ansible/inventory
echo $?

