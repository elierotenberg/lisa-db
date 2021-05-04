import { Directus, PartialItem } from "@directus/sdk";

import { Collections } from "../../directus";

// Directus instance is a singleton
let _directus: null | Promise<Directus<Collections>> = null;

export const getDirectusFromEnv = async (): Promise<Directus<Collections>> => {
  if (!_directus) {
    const LISA_DB_API_HOST = process.env.LISA_DB_API_HOST;
    const LISA_DB_API_TOKEN = process.env.LISA_DB_API_TOKEN;
    const directus = new Directus<Collections>(LISA_DB_API_HOST);

    _directus = directus.auth.static(LISA_DB_API_TOKEN).then(() => directus);
  }

  return await _directus;
};

export const extractData = <T>({ data }: { readonly data: T }): T => data;

export const asNonPartial = <T>(data: PartialItem<T>): T => data as T;

export const asNonPartialMany = <T>({
  data,
}: {
  readonly data: PartialItem<T>[];
}): T[] => extractData({ data }).map(asNonPartial);
