import * as t from "typed-assert";

import { Contents, find } from "./Content/Content";
import { matchLocale } from "./Locales";

export const to = {
  locale: (locale: string): string => `/${locale}`,
  home: (locale: string): string => `${to.locale(locale)}/`,
  domains: (locale: string): string => `${to.locale(locale)}/db/domains`,
  domain: (locale: string, domainSlug: string): string =>
    `${to.locale(locale)}/db/domains/${domainSlug}`,
  guides: (locale: string): string => `${to.locale(locale)}/db/guides`,
  guide: (locale: string, guideSlug: string): string =>
    `${to.locale(locale)}/db/guides/${guideSlug}`,
  audiences: (locale: string): string => `${to.locale(locale)}/db/audiences`,
  audience: (locale: string, audienceSlug: string): string =>
    `${to.locale(locale)}/db/audiences/${audienceSlug}`,
  institutions: (locale: string): string =>
    `${to.locale(locale)}/db/institutions`,
  institution: (locale: string, institutionSlug: string): string =>
    `${to.locale(locale)}/db/institutions/${institutionSlug}`,
  persons: (locale: string): string => `${to.locale(locale)}/db/persons`,
  person: (locale: string, personSlug: string): string =>
    `${to.locale(locale)}/db/persons/${personSlug}`,
};

export const translatePath = (
  asPath: string,
  nextLocale: string,
  contents: Contents
): string => {
  const currentLocale = matchLocale(asPath);

  if (asPath === to.home(currentLocale)) {
    return to.home(nextLocale);
  }

  if (asPath === to.domains(currentLocale)) {
    return to.domains(nextLocale);
  }

  if (asPath.startsWith(to.domain(currentLocale, ""))) {
    const currentLocaleDomainSlug = asPath.slice(
      to.domain(currentLocale, "").length
    );
    const currentLocaleDomain = find.domain.bySlug(
      contents,
      currentLocaleDomainSlug
    );
    t.isNotNull(currentLocaleDomain);
    const nextLocaleDomain = find.domain.alternateLocale(
      contents,
      currentLocaleDomain.meta.domain_id,
      nextLocale
    );
    if (!nextLocaleDomain) {
      return to.domains(nextLocale);
    }
    return to.domain(nextLocale, nextLocaleDomain.meta.slug);
  }

  if (asPath === to.guides(currentLocale)) {
    return to.guides(nextLocale);
  }

  if (asPath.startsWith(to.guide(currentLocale, ""))) {
    const currentLocaleGuideSlug = asPath.slice(
      to.guide(currentLocale, "").length
    );
    const currentLocaleGuide = find.guide.bySlug(
      contents,
      currentLocaleGuideSlug
    );
    t.isNotNull(currentLocaleGuide);
    const nextLocaleGuide = find.guide.alternateLocale(
      contents,
      currentLocaleGuide.meta.guide_id,
      nextLocale
    );
    if (!nextLocaleGuide) {
      return to.guides(nextLocale);
    }
    return to.guide(nextLocale, nextLocaleGuide.meta.slug);
  }

  if (asPath === to.audiences(currentLocale)) {
    return to.audiences(nextLocale);
  }

  if (asPath === to.institutions(currentLocale)) {
    return to.institutions(nextLocale);
  }

  if (asPath.startsWith(to.institution(currentLocale, ""))) {
    const currentLocaleInstitutionSlug = asPath.slice(
      to.institution(currentLocale, "").length
    );
    const currentLocaleInstitution = find.institution.bySlug(
      contents,
      currentLocaleInstitutionSlug
    );
    t.isNotNull(currentLocaleInstitution);
    const nextLocaleInstitution = find.institution.alternateLocale(
      contents,
      currentLocaleInstitution.meta.institution_id,
      nextLocale
    );
    if (!nextLocaleInstitution) {
      return to.institutions(nextLocale);
    }
    return to.institution(nextLocale, nextLocaleInstitution.meta.slug);
  }

  if (asPath === to.persons(currentLocale)) {
    return to.persons(nextLocale);
  }

  if (asPath.startsWith(to.person(currentLocale, ""))) {
    const currentLocalePersonSlug = asPath.slice(
      to.person(currentLocale, "").length
    );
    const currentLocalePerson = find.person.bySlug(
      contents,
      currentLocalePersonSlug
    );
    t.isNotNull(currentLocalePerson);
    const nextLocalePerson = find.person.alternateLocale(
      contents,
      currentLocalePerson.meta.person_id,
      nextLocale
    );
    if (!nextLocalePerson) {
      return to.persons(nextLocale);
    }

    return to.person(nextLocale, nextLocalePerson.meta.slug);
  }

  return to.home(nextLocale);
};
