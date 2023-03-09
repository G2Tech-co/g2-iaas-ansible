#!/bin/bash

set -x

DIR=$(date -I)
DEST=~/db_backups/$DIR
DB_HOST="localhost"
DB_PORT=33306
DB_USER="root"
DB_NAME="bms"

mkdir $DEST

nice mysqldump -h $DB_HOST --port $DB_PORT -u $DB_USER -p "mysql_password" --quick --lock-tables=false --ignore-table=telescope_entries --single-transaction --opt $DB_NAME | gzip > "$DEST"/dbbackup.gz

ls -ltrh ~/db_backups/ | tail -n 1 | awk '{print $9}' | xargs rm -rf
