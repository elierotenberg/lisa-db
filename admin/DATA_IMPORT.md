### Pulling production data

Production data (content) can be pulled using `scripts/pgdump.data.production.sh`.

Production metadata (directus fields, roles and permissions) can be pulled using `scripts/pgdump.directus.production.sh`.

After pulling new data, run the local container using the "production dump" volumes in `docker-compose.yml`.

Once the server has started and directus is initialized, run `scripts/pgrestore.directus.development.sh`. You may have to recreate the test API client user with the following parameters:

```
    email: `api-client-dev@lisa-db.ifea.education`,
    password: `api-client-dev-password`,
    token: `api-client-dev-token`,
```

You may then run `scripts/pgdump.full.development.sh` to update the development dump, then revert the `docker-compose.yml` file to using the development dump.
