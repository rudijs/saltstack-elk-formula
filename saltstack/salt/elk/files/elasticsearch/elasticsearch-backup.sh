#!/bin/bash

rm -rf /tmp/es-backup
mkdir -p /tmp/es-backup
chown -R elasticsearch.elasticsearch /tmp/es-backup

curl -XPUT 'http://localhost:9200/_snapshot/dws_backup' -d '{
    "type": "fs",
    "settings": {
        "location": "/tmp/es-backup",
        "compress": true
    }
}'

curl -XPUT "localhost:9200/_snapshot/dws_backup/dws_snapshot?wait_for_completion=true"

ls /tmp/es-backup/*dws_snapshot
if [ $? -ne 0 ]; then
	exit 1
fi

tar -cvzf /var/backups/dws/elasticsearch_snap.tar.gz /tmp/es-backup/*

exit 0
