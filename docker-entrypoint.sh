#!/bin/sh -e

: ${S3_BUCKET:=my-bucket}
: ${S3_ENDPOINT:=https://s3.amazonaws.com}
: ${AWS_ACCESS_KEY_ID=}
: ${AWS_SECRET_ACCESS_KEY=}

echo "bucket:$S3_BUCKET on $S3_ENDPOINT"

exec /usr/bin/s3fs -f "$S3_BUCKET" /srv -ourl="$S3_ENDPOINT" &

echo "> $@" && exec "$@"
