import { Directus } from "@directus/sdk";

import { Collections } from "../../directus";

// Directus instance is a singleton
let _directus: null | Promise<Directus<Collections>> = null;

export const getDirectusFromEnv = async (): Promise<Directus<Collections>> => {
  if (!_directus) {
    const LISA_DB_API_HOST = process.env.LISA_DB_API_HOST;
    const LISA_DB_API_EMAIL = process.env.LISA_DB_API_EMAIL;
    const LISA_DB_API_PASSWORD = process.env.LISA_DB_API_PASSWORD;
    const directus = new Directus<Collections>(LISA_DB_API_HOST);

    _directus = directus.auth
      .login({ email: LISA_DB_API_EMAIL, password: LISA_DB_API_PASSWORD })
      .then(() => directus);
  }

  return await _directus;
};
