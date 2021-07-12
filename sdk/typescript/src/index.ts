import { AuthCredentials, Directus } from "@directus/sdk";

import { Collections } from "../directus";

export { completeItem as complete, Complete } from "./utils";

export type LisaDbCollections = Collections;

export type LisaDb = Directus<LisaDbCollections>;

export const createClient = async (
  url: string,
  tokenOrCredentials: string | AuthCredentials,
): Promise<LisaDb> => {
  const client = new Directus<LisaDbCollections>(url);

  if (typeof tokenOrCredentials === `string`) {
    await client.auth.static(tokenOrCredentials);
  } else {
    await client.auth.login(tokenOrCredentials);
  }
  return client;
};
