### Pulling content from production database

- Connect to the production database
- Export data from desired tables (excluding directus\_\* tables except directus_fields)
- Run lisa-db-postgres-dump using `src/sql/scratch.sql`
- Restore data using the production dump
- Recreate necessary users, etc.
- Re-export `data/pgdump.sql`
