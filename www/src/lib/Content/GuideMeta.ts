import * as t from "typed-assert";

export type GuideMeta = {
  readonly kind: "guide";
  readonly guide_id: string;
  readonly locale: string;
  readonly slug: string;
  readonly name: string;
  readonly abstract: string;
  readonly authors: {
    readonly person_id: string;
  }[];
  readonly curators: { readonly person_id: string }[];
  readonly domains: { readonly domain_id: string }[];
  readonly audiences: string[];
  readonly source: {
    readonly institution_id: string;
    readonly locale: string;
    readonly name: string;
    readonly href: string;
  };
};

export const parseGuideMeta = (input: unknown): GuideMeta => {
  t.isRecord(input);
  const meta = input as GuideMeta;
  const {
    kind,
    guide_id,
    locale,
    slug,
    name,
    abstract,
    authors,
    curators,
    domains,
    audiences,
    source,
  } = meta;

  t.isExactly(kind, "guide");
  t.isString(guide_id);
  t.isString(locale);
  t.isString(slug);
  t.isString(name);
  t.isString(abstract);
  t.isArrayOfType(authors, t.isRecord);
  for (const author of authors) {
    t.isString(author.person_id);
  }
  t.isArrayOfType(curators, t.isRecord);
  for (const curator of curators) {
    t.isString(curator.person_id);
  }
  t.isArrayOfType(domains, t.isRecord);
  for (const domain of domains) {
    t.isString(domain.domain_id);
  }
  t.isArrayOfType(audiences, t.isString);
  t.isRecord(source);
  t.isString(source.institution_id);
  t.isString(source.locale);
  t.isString(source.name);

  return meta;
};
