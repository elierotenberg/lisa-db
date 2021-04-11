import { join } from "path";

import pgPromise from "pg-promise";
import { isNotNull, isString } from "typed-assert";
import yargs from "yargs";

import { readFromEnv } from "./lib/Config";
import { createGoogleAuth, promptTokens } from "./lib/Google";
import { importFromGoogleSheets } from "./scripts/importFromGoogleSheets";

if (require.main !== module) {
  console.error("not the main module");
  process.exit(1);
}

const main = async (): Promise<void> => {
  const argv = yargs.argv;
  const command = argv._[0];

  const config = await readFromEnv();
  const pgp = pgPromise();

  try {
    if (command === "tokens") {
      const outFile = argv.outFile;
      isString(outFile);
      await promptTokens(config.googleapis, join(process.cwd(), outFile));
    } else if (command === "import-from-google-sheets") {
      isNotNull(config.googleapis.tokensFile);
      const googleAuth = await createGoogleAuth(
        config.googleapis,
        config.googleapis.tokensFile,
      );
      const db = pgp({
        application_name: "@lisa-db/admin",
        host: config.postgres.host,
        port: config.postgres.port,
        user: config.postgres.user,
        password: config.postgres.password,
        database: config.postgres.db,
        idleTimeoutMillis: 100,
      });
      await db.connect();
      await importFromGoogleSheets(googleAuth, db);
    } else {
      console.error(new TypeError(`Invalid command: ${command}`));
    }
  } finally {
    pgp.end();
  }
  process.exit(0);
};

main().catch((error) => {
  console.error(error);
  if (error instanceof AggregateError) {
    for (const inner of error.errors) {
      console.error(inner);
    }
  }
  process.exit(1);
});
