#!/bin/bash

# Requires running the Cloud SQL Proxy on localhost:1234, see https://cloud.google.com/sql/docs/postgres/sql-proxy
# Requires pg client library for current version (e.g. Postgres 13), see https://www.postgresql.org/download/linux/ubuntu/
mkdir -p data/pg/production
pg_dump \
  --data-only \
  --file=data/pg/production/data.pgdump.sql \
  --verbose \
  --format=plain \
  --schema=public \
  --exclude-table=directus_* \
  --no-privileges \
  --no-owner \
  --serializable-deferrable \
  --host=localhost \
  --port=1234 \
  --username=postgres \
  lisa-db
