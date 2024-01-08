#!/bin/bash

set -x

DEST=~/db_backups
DB_HOST="127.0.0.1"
DB_PORT=3306
DB_USER="user"
DB_PASS="'pass'"
DB_NAME="dbname"
BUCKET_SUBDIR="sub"

mkdir -p $DEST

nice mysqldump -h $DB_HOST --port $DB_PORT -u $DB_USER -p$DB_PASS --ignore-table=$DB_NAME.telescope_entries --single-transaction --opt --skip-lock-tables $DB_NAME | gzip > "$DEST"/dbbackup-$(date -I).gz

~/s3/mc cp $DEST/dbbackup-$(date -I).gz backup/g2-backup-dbs/$BUCKET_SUBDIR/

~/s3/mc rm --force --recursive --older-than 60d backup/g2-backup-dbs/$BUCKET_SUBDIR/

rm -rf ~/db_backups
