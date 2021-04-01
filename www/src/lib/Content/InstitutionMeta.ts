import * as t from "typed-assert";

export type InstitutionMeta = {
  readonly kind: "institution";
  readonly slug: string;
  readonly institution_id: string;
  readonly locale: string;
  readonly name: string;
  readonly href: string;
};

export const parseInstitutionMeta = (input: unknown): InstitutionMeta => {
  t.isRecord(input);
  const contentInstitution = input as InstitutionMeta;
  const { kind, slug, institution_id, locale, name, href } = contentInstitution;

  t.isExactly(kind, "institution");
  t.isString(slug);
  t.isString(institution_id);
  t.isString(locale);
  t.isString(name);
  t.isString(href);

  return contentInstitution;
};
