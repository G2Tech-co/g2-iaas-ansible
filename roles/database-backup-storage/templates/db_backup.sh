#!/bin/bash

set -x

DEST=/opt/scripts/db_backups/
DB_HOST="127.0.0.1"
DB_PORT=3306
DB_USER="root"
DB_PASS="{{mysql.root_password}}"
DB_NAME="{{mysql.database}}"
BUCKET_SUBDIR="sub"

mkdir -p $DEST

if ! command -v mysqldump > /dev/null 2>&1
then
  echo "mysqldump is required"
  exit 2
fi

nice mysqldump -h $DB_HOST --port $DB_PORT -u $DB_USER -p$DB_PASS --ignore-table=$DB_NAME.telescope_entries --single-transaction --opt --skip-lock-tables $DB_NAME | gzip > "$DEST"/dbbackup-$(date -I).gz

/opt/scripts/s3/mc cp $DEST/dbbackup-$(date -I).gz backup/backup/backup-dbs/$BUCKET_SUBDIR/

if [ $? -eq 0 ]; then
  echo "Database backup successful"
  FILESIZE=$(stat -c%s "$DEST/dbbackup-$(date -I).gz")
  MB=$(echo "$FILESIZE" | numfmt --to=iec)
  curl -s --max-time 10 -d "chat_id=-0000000000000&disable_web_page_preview=1&text=Database backup successful $FILESIZE bytes, $MB 💾 " https://api.telegram.org/bot<TOKEN>/sendMessage > /dev/null
else
  echo "Error: Database backup failed"
  curl -s --max-time 10 -d "chat_id=-0000000000000&disable_web_page_preview=1&text=Database backup failed 💾 " https://api.telegram.org/bot<TOKEN>/sendMessage > /dev/null
fi

rm -f /opt/scripts/db_backups/*
