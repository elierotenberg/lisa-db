import * as t from "typed-assert";
import translations from "../content/translations.yml";
import { findTranslation } from "../lib/Translation";
import { useLocale } from "./useLocale";

export const useTranslation = (...keys: string[]): string => {
  const locale = useLocale();
  const value = findTranslation(locale, translations, ...keys);
  t.isString(value, `Translation key not found: ${keys.join(".")}`);
  return value;
};
