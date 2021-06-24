#!/bin/bash

psql -h localhost -p 8056 -d lisa-db-dev-db -U lisa-db-dev-user -f data/pg/production/directus.pgdump.sql
