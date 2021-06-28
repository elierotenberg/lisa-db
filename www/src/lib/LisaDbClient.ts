import { createClient, LisaDb } from "@lisa-db/sdk";
import { z } from "zod";

// Directus instance is a singleton
let _sdk: null | Promise<LisaDb> = null;

export const getLisaDbClientFromEnv = (): Promise<LisaDb> => {
  if (_sdk) {
    return _sdk;
  }
  const LISA_DB_API_HOST = z.string().parse(process.env.LISA_DB_API_HOST);
  const LISA_DB_API_TOKEN = z.string().parse(process.env.LISA_DB_API_TOKEN);

  _sdk = createClient(LISA_DB_API_HOST, LISA_DB_API_TOKEN);

  return _sdk;
};
