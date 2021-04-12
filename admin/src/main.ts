import { resolve } from "path";

import { Pool } from "pg";
import { isNotNull, isString } from "typed-assert";
import yargs from "yargs";

import { readFromEnv } from "./lib/Config";
import { createGoogleAuth, promptTokens } from "./lib/Google";
import { downloadSpreadSheets } from "./scripts/download-spreadsheets";
import { upsertData } from "./scripts/upsert-data";

if (require.main !== module) {
  console.error("not the main module");
  process.exit(1);
}

const main = async (): Promise<void> => {
  const argv = yargs.argv;
  const command = argv._[0];

  const config = await readFromEnv();
  const dbPool = new Pool({
    host: config.postgres.host,
    port: config.postgres.port,
    user: config.postgres.user,
    database: config.postgres.db,
    password: config.postgres.password,
    application_name: `@lisa-db/admin:cli`,
  });

  try {
    if (command === "tokens") {
      const outFile = argv.outFile;
      isString(outFile);
      await promptTokens(config.googleapis, resolve(process.cwd(), outFile));
      return;
    }
    if (command === "download-spreadsheets") {
      const { outFolder } = argv;
      isString(outFolder);
      isNotNull(config.googleapis.tokensFile);
      const googleAuth = await createGoogleAuth(
        config.googleapis,
        config.googleapis.tokensFile,
      );
      await downloadSpreadSheets(googleAuth, resolve(process.cwd(), outFolder));
      return;
    }
    if (command === "upsert-data") {
      const { inFolder } = argv;
      isString(inFolder);
      const db = await dbPool.connect();
      try {
        await upsertData(db, inFolder);
      } finally {
        db.release();
      }
      return;
    }
    console.error(new TypeError(`Invalid command: ${command}`));
  } finally {
    await dbPool.end();
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
