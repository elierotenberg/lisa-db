import { useRouter } from "next/router";
import { matchLocale } from "../lib/Locales";

export const useLocale = (): string => {
  const { asPath } = useRouter();
  return matchLocale(asPath);
};
