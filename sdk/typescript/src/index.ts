import { AuthCredentials, Directus } from "@directus/sdk";

import { Collections } from "../directus";

export { completeItem as complete } from "./utils";

export type LisaDb = Directus<Collections>;

export const createClient = async (
  url: string,
  tokenOrCredentials: string | AuthCredentials,
): Promise<LisaDb> => {
  const client = new Directus<Collections>(url);

  if (typeof tokenOrCredentials === `string`) {
    await client.auth.static(tokenOrCredentials);
  } else {
    await client.auth.login(tokenOrCredentials);
  }
  return client;
};
