import * as t from "typed-assert";
import { ComponentType } from "react";
import { GuideMeta } from "./GuideMeta";
import { DomainMeta } from "./DomainMeta";
import { InstitutionMeta } from "./InstitutionMeta";
import { PersonMeta } from "./PersonMeta";

export type ContentMeta = DomainMeta | GuideMeta | InstitutionMeta | PersonMeta;

export type ContentFile<ContentT extends ContentMeta> = {
  readonly file: string;
  readonly raw: string;
  readonly meta: ContentT;
};

export type Content<Meta extends ContentMeta> = {
  readonly meta: Meta;
  readonly raw: string;
  readonly Mdx: ComponentType;
};

export type Contents = {
  readonly domains: Content<DomainMeta>[];
  readonly guides: Content<GuideMeta>[];
  readonly institutions: Content<InstitutionMeta>[];
  readonly persons: Content<PersonMeta>[];
};

export const getTitle = (content: ContentMeta): string =>
  content.kind === "domain"
    ? content.name
    : content.kind === "guide"
    ? content.name
    : content.kind === "institution"
    ? content.name
    : content.kind === "person"
    ? content.name
    : "";

export const filterContentsByLocale = (
  contents: Contents,
  locale: string
): Contents => ({
  domains: contents.domains.filter((domain) => domain.meta.locale === locale),
  guides: contents.guides.filter((guide) => guide.meta.locale === locale),
  institutions: contents.institutions.filter(
    (instution) => instution.meta.locale === locale
  ),
  persons: contents.persons.filter((person) => person.meta.locale === locale),
});

export const find = {
  domain: {
    byId: (contents: Contents, domainId: string): null | Content<DomainMeta> =>
      contents.domains.find((domain) => domain.meta.domain_id === domainId) ??
      null,

    bySlug: (contents: Contents, slug: string): null | Content<DomainMeta> =>
      contents.domains.find((domain) => domain.meta.slug === slug) ?? null,

    relatedGuides: (
      contents: Contents,
      domainId: string
    ): Content<GuideMeta>[] =>
      contents.guides.filter((guide) =>
        guide.meta.domains.some(
          (guideDomain) => guideDomain.domain_id === domainId
        )
      ),

    alternateLocale: (
      contents: Contents,
      domainId: string,
      locale: string
    ): null | Content<DomainMeta> =>
      contents.domains.find(
        (domainAlternateLocale) =>
          domainAlternateLocale.meta.domain_id === domainId &&
          domainAlternateLocale.meta.locale === locale
      ) ?? null,
  },
  guide: {
    byId: (contents: Contents, guideId: string): null | Content<GuideMeta> =>
      contents.guides.find((guide) => guide.meta.guide_id === guideId) ?? null,

    bySlug: (contents: Contents, slug: string): null | Content<GuideMeta> =>
      contents.guides.find((guide) => guide.meta.slug === slug) ?? null,

    relatedDomains: (
      contents: Contents,
      guideId: string
    ): Content<DomainMeta>[] => {
      const guide = find.guide.byId(contents, guideId);
      t.isNotNull(guide);
      return guide.meta.domains
        .map((domain) => find.domain.byId(contents, domain.domain_id))
        .filter(t.check(t.isNotNull));
    },

    authors: (contents: Contents, guideId: string): Content<PersonMeta>[] => {
      const guide = find.guide.byId(contents, guideId);
      t.isNotNull(guide);
      return guide.meta.authors
        .map((author) => find.person.byId(contents, author.person_id))
        .filter(t.check(t.isNotNull));
    },

    curators: (contents: Contents, guideId: string): Content<PersonMeta>[] => {
      const guide = find.guide.byId(contents, guideId);
      t.isNotNull(guide);
      return guide.meta.curators
        .map((author) => find.person.byId(contents, author.person_id))
        .filter(t.check(t.isNotNull));
    },

    alternateLocale: (
      contents: Contents,
      guideId: string,
      locale: string
    ): null | Content<GuideMeta> =>
      contents.guides.find(
        (guide) =>
          guide.meta.guide_id === guideId && guide.meta.locale === locale
      ) ?? null,
  },

  institution: {
    byId: (
      contents: Contents,
      institutionId: string
    ): null | Content<InstitutionMeta> =>
      contents.institutions.find(
        (instituion) => instituion.meta.institution_id === institutionId
      ) ?? null,

    bySlug: (
      contents: Contents,
      slug: string
    ): null | Content<InstitutionMeta> =>
      contents.institutions.find(
        (institution) => institution.meta.slug === slug
      ) ?? null,

    relatedPersons: (
      contents: Contents,
      institutionId: string
    ): Content<PersonMeta>[] =>
      contents.persons.filter((person) =>
        person.meta.institutions.some(
          (institution) => institution.institution_id === institutionId
        )
      ),

    alternateLocale: (
      contents: Contents,
      institutionId: string,
      locale: string
    ): null | Content<InstitutionMeta> =>
      contents.institutions.find(
        (institution) =>
          institution.meta.institution_id === institutionId &&
          institution.meta.locale === locale
      ) ?? null,
  },

  person: {
    byId: (contents: Contents, personId: string): null | Content<PersonMeta> =>
      contents.persons.find((person) => person.meta.person_id === personId) ??
      null,

    bySlug: (contents: Contents, slug: string): null | Content<PersonMeta> =>
      contents.persons.find((person) => person.meta.slug === slug) ?? null,

    relatedInstitutions: (
      contents: Contents,
      personId: string
    ): Content<InstitutionMeta>[] => {
      const person = find.person.byId(contents, personId);
      t.isNotNull(person);
      return person.meta.institutions
        .map((instituion) =>
          find.institution.byId(contents, instituion.institution_id)
        )
        .filter(t.check(t.isNotNull));
    },

    relatedGuides: (
      contents: Contents,
      personId: string
    ): Content<GuideMeta>[] =>
      contents.guides.filter(
        (guide) =>
          guide.meta.authors.some((author) => author.person_id === personId) ||
          guide.meta.curators.some((curator) => curator.person_id === personId)
      ),

    alternateLocale: (
      contents: Contents,
      personId: string,
      locale: string
    ): null | Content<PersonMeta> =>
      contents.persons.find(
        (person) =>
          person.meta.person_id === personId && person.meta.locale === locale
      ) ?? null,
  },
};
