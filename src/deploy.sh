#!/usr/bin/env bash

set -e

DISTRIBUTION_ID=E2PMLFI4XDDPW
BUCKET_NAME=ajlanghorn.com

hugo -v
aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$BUCKET_NAME
