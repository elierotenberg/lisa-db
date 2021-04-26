import { join } from "path";
import { promises } from "fs";

import { pick, resolveAllConcurrent } from "typed-utilities";
import { isNotUndefined } from "typed-assert";

export type Config = {
  readonly postgres: {
    readonly host: string;
    readonly port: number;
    readonly user: string;
    readonly password: string;
    readonly db: string;
  };
  readonly googleapis: {
    readonly redirectUri: string;
    readonly clientId: string;
    readonly clientSecret: string;
    readonly tokensFile: null | string;
  };
};

type PostgresJson = {
  readonly host: string;
  readonly port: number;
  readonly user: string;
  readonly password: string;
  readonly db: string;
};

const readPostgresJson = async (
  postgresJsonFile: string,
): Promise<PostgresJson> => {
  const json = JSON.parse(
    await promises.readFile(postgresJsonFile, { encoding: "utf8" }),
  );
  return json as PostgresJson;
};

type GoogleApisOauthSecretsJson = {
  readonly web: {
    readonly client_id: string;
    readonly client_secret: string;
    readonly redirect_uris: [string];
  };
};

const readGoogleApisOauthSecretsJson = async (
  googleApisOauthSecretsJsonFile: string,
): Promise<GoogleApisOauthSecretsJson> => {
  const json = JSON.parse(
    await promises.readFile(googleApisOauthSecretsJsonFile, {
      encoding: "utf8",
    }),
  );
  return json as GoogleApisOauthSecretsJson;
};

export const readFromEnv = async (): Promise<Config> => {
  const {
    POSTGRES_JSON_FILE,
    GOOGLEAPIS_OAUTH_SECRETS_JSON_FILE,
    GOOGLEAPIS_TOKENS_JSON_FILE,
  } = process.env;
  isNotUndefined(POSTGRES_JSON_FILE);
  isNotUndefined(GOOGLEAPIS_OAUTH_SECRETS_JSON_FILE);
  const [
    postgresJson,
    googleApisOauthSecretsJson,
  ] = await resolveAllConcurrent([
    readPostgresJson(join(process.cwd(), POSTGRES_JSON_FILE)),
    readGoogleApisOauthSecretsJson(
      join(process.cwd(), GOOGLEAPIS_OAUTH_SECRETS_JSON_FILE),
    ),
  ]);
  return {
    postgres: pick(postgresJson, ["host", "port", "user", "password", "db"]),
    googleapis: {
      clientId: googleApisOauthSecretsJson.web.client_id,
      clientSecret: googleApisOauthSecretsJson.web.client_secret,
      redirectUri: googleApisOauthSecretsJson.web.redirect_uris[0],
      tokensFile: GOOGLEAPIS_TOKENS_JSON_FILE
        ? join(process.cwd(), GOOGLEAPIS_TOKENS_JSON_FILE)
        : null,
    },
  };
};
