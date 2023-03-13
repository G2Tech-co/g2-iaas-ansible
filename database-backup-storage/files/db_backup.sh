#!/bin/bash

set -x

DEST=~/db_backups
DB_HOST="localhost"
DB_PORT=33306
DB_USER="root"
DB_NAME="bms"

mkdir -p $DEST

nice mysqldump -h $DB_HOST --port $DB_PORT -u $DB_USER -p "mysql_password" --quick --ignore-table=telescope_entries --single-transaction --opt $DB_NAME | gzip > "$DEST"/dbbackup.gz

~/s3/mc cp $DEST/dbbackup.gz s3/backup/bms/dbbackup.gz

~/s3/mc rm --older-than 60d s3/backup/bms/

rm -rf ~/db_backups/
