#!/bin/bash

set -x

DEST=~/db_backups
DB_HOST="localhost"
DB_PORT=33306
DB_USER="root"
DB_NAME="bms"
BUCKET_SUBDIR=""

mkdir -p $DEST

nice mysqldump -h $DB_HOST --port $DB_PORT -u $DB_USER --defaults-extra-file=/etc/mysql/mysqlpassword.cnf --quick --ignore-table=$DB_NAME.telescope_entries --single-transaction --opt $DB_NAME | gzip > "$DEST"/dbbackup.gz

~/s3/mc cp $DEST/dbbackup.gz backup/g2-backup-dbs/$BUCKET_SUBDIR/dbbackup.gz

~/s3/mc rm --force --recursive --older-than 60d backup/g2-backup-dbs/$BUCKET_SUBDIR/

rm -rf ~/db_backups/
