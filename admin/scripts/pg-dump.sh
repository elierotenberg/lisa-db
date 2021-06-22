#!/bin/sh

docker exec -i $1 pg_dump -p $2 -U lisa-db-dev-user lisa-db-dev-db
