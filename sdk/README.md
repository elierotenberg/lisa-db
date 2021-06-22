## @lisa-db/sdk

This package exports a JavaScript / TypeScript client to interact with LISA DB.

It is a simple wrapper around `@directus/sdk` using types generated from the dynamic OpenAPI spec using `directus-typescript-gen`.

### Installation

`npm i @lisa-db/sdk`

### Updating the spec and types

- start the local Directus instance from the `admin` package using `npm run docker`
- generate types using `npm run directus-typescript-gen` from this package

### Running tests

- start the local Directus instance from the `admin` package using `npm run docker`
- `npm run test`