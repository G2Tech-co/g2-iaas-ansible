#!/bin/bash

S3_URL="https://s3.eu-central-1.wasabisys.com"

aws s3 --endpoint-url=$S3_URL sync ~/db_backups s3://project_name

# aws s3 --endpoint-url=$S3_URL ls s3://project_name | sort -r | tail -n 1 | awk '{print $4}' | xargs aws s3 --endpoint-url=$S3_URL rm s3://project_name
