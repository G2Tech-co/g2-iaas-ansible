#!/bin/bash

set -x

DEST=/opt/scripts/db_backups
TARGET="/path/to/backup/directory"
BUCKET_SUBDIR="sub"

mkdir -p $DEST

TIMESTAMP=$(date -Ihours)
nice tar --exclude='./folder' -zcvf "$DEST"/dirbackup-$TIMESTAMP.tar.gz $TARGET

/opt/scripts/s3/mc cp $DEST/dirbackup-$TIMESTAMP.tar.gz backup/backup/backup-dirs/$BUCKET_SUBDIR/

if [ $? -eq 0 ]; then
  echo "directory backup successful"
  FILESIZE=$(stat -c%s "$DEST/dirbackup-$TIMESTAMP.tar.gz")
  MB=$(echo "$FILESIZE" | numfmt --to=iec)
  curl -s --max-time 10 -d "chat_id=-0000000000000&disable_web_page_preview=1&text=directory backup successful $FILESIZE bytes, $MB 💾 " https://api.telegram.org/bot<TOKEN>/sendMessage > /dev/null
else
  echo "Error: directory backup failed"
  curl -s --max-time 10 -d "chat_id=-0000000000000&disable_web_page_preview=1&text=directory backup failed 💾 " https://api.telegram.org/bot<TOKEN>/sendMessage > /dev/null
fi

rm -f ~/db_backups/*
