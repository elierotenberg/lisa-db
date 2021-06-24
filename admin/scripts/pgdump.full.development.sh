#!/bin/bash

mkdir -p data/pg/development
docker exec -i lisa-db-postgres-dump pg_dump \
  --format=plain \
  --no-privileges \
  --no-owner \
  --serializable-deferrable \
  --port=8056 \
  --user=lisa-db-dev-user \
  lisa-db-dev-db > data/pg/development/full.pgdump.sql