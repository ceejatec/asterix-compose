#!/bin/sh

docker run --rm --net=app_asterix couchbase \
  couchbase-cli cluster-init \
  -c couchbase1.host \
  --cluster-init-username=Administrator \
  --cluster-init-password=couchbase \
  --cluster-init-ramsize=1000 \
  -u admin -p password
sleep 2

docker run --rm --net=app_asterix couchbase \
  couchbase-cli server-add \
  -c couchbase1.host \
  -u Administrator -p couchbase \
  --server-add couchbase2.host \
  --server-add-username Administrator \
  --server-add-password couchbase
sleep 2

docker run --rm --net=app_asterix couchbase \
  couchbase-cli rebalance \
  -c couchbase1.host \
  -u Administrator -p couchbase \
  --server-add couchbase3.host \
  --server-add-username Administrator \
  --server-add-password couchbase

