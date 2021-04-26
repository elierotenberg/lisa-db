import { useMemo } from "react";
import { contents } from "../content/db";
import { Contents } from "../lib/Content/Content";
import { useLocale } from "./useLocale";

export const useLocaleContents = (): Contents => {
  const locale = useLocale();
  const localeContents = useMemo(
    (): Contents => ({
      domains: contents.domains.filter(
        (domain) => domain.meta.locale === locale
      ),
      guides: contents.guides.filter((guide) => guide.meta.locale === locale),
      institutions: contents.institutions.filter(
        (institution) => institution.meta.locale === locale
      ),
      persons: contents.persons.filter(
        (person) => person.meta.locale === locale
      ),
    }),
    [locale]
  );

  return localeContents;
};
