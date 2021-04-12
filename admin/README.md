# LISA DB Admin

### Installation

- Clone / fork this repository
- Get `googleapis.oauth.secrets.json` from an administrator and put it in `env/dev`
- Run `npm install`
- Run `npm run dev:cli:tokens` to create your local tokens
  - Run `npm run dev:cli:tokens` every time the tokens expire (an error will be printed to the console when/if this is required)

### Runing the local development environment

- Local development environment includes via docker-compose:
  - Postgres
  - Redis (for Directus cache)
  - Directus itself

Please note that local postgres data is considered volatile and will be deleted every time the environment is re-created.

- Make sure you have Docker (including Docker Compose) installed
- Run `npm run docker`
- Open `http://localhost:8055` in your browser and login using the credentials in `env/dev/directus.env`

### Downloading data from Google Sheets

- After creating your tokens, run `npm run dev:cli:download-spreadsheets`
- This will update files in `data/*.json`

### Upserting data

- After downloading the data, run `npm run dev:cli:upsert-data`
