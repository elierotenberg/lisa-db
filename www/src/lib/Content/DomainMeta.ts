import * as t from "typed-assert";

export type DomainMeta = {
  readonly kind: "domain";
  readonly domain_id: string;
  readonly locale: string;
  readonly slug: string;
  readonly name: string;
};

export const parseDomainMeta = (input: unknown): DomainMeta => {
  t.isRecord(input);
  const contentDomain = input as DomainMeta;
  const { kind, domain_id, locale, slug, name } = contentDomain;

  t.isExactly(kind, "domain");
  t.isString(domain_id);
  t.isString(locale);
  t.isString(slug);
  t.isString(name);
  return contentDomain;
};
