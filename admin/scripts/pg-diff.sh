#!/bin/bash


dump_schema() {
  CONTAINER_NAME="lisa-db-postgres-$1"
  docker exec -i $CONTAINER_NAME pg_dump -T 'directus_*' -p $2 -U lisa-db-dev-user lisa-db-dev-db -s -Ox
}

mkdir -p tmp/pg-diff

cd tmp/pg-diff
dump_schema "dump" 8056 > dump.sql
dump_schema "scratch" 8057 > scratch.sql
dump_schema "migrate" 8058 > migrate.sql
# Schemas can now be compared using diff tools (e.g. "Compare Selected" in VS Code)

# Also run apgdiff
apgdiff dump.sql scratch.sql > dump-scratch-apgdiff.sql
apgdiff scratch.sql migrate.sql > scratch-migrate-apgdiff.sql
apgdiff migrate.sql dump.sql > migrate-dump-apgdiff.sql
