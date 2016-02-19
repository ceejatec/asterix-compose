#!/bin/sh

docker run --rm --net=image_asterix couchbase \
  couchbase-cli cluster-init \
  -c couchbase1.host \
  --cluster-init-username=Administrator \
  --cluster-init-password=couchbase \
  --cluster-init-ramsize=600 \
  -u admin -p password

docker run --rm --net=image_asterix couchbase \
  couchbase-cli bucket-create \
  -c couchbase1.host \
  --bucket=default \
  --bucket-type=couchbase \
  --bucket-port=11211 \
  --bucket-ramsize=600 \
  --bucket-replica=1 \
  -u Administrator -p couchbase

docker run --rm --net=image_asterix couchbase \
  couchbase-cli server-add \
  -c couchbase1.host \
  -u Administrator -p couchbase \
  --server-add couchbase2.host \
  --server-add-username Administrator \
  --server-add-password couchbase

docker run --rm --net=image_asterix couchbase \
  couchbase-cli rebalance \
  -c couchbase1.host \
  -u Administrator -p couchbase \
  --server-add couchbase3.host \
  --server-add-username Administrator \
  --server-add-password couchbase


