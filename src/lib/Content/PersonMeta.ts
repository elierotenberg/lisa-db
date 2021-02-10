import * as t from "typed-assert";
import { GrammaticalGender, isGrammaticalGender } from "./GrammaticalGender";

export type PersonMeta = {
  readonly kind: "person";
  readonly person_id: string;
  readonly locale: string;
  readonly slug: string;
  readonly name: string;
  readonly grammatical_gender: GrammaticalGender;
  readonly picture_href: string;
  readonly links: {
    readonly name: string;
    readonly href: string;
  }[];
  readonly institutions: {
    readonly institution_id: string;
  }[];
  readonly title?: string;
};

export const parsePersonMeta = (input: unknown): PersonMeta => {
  t.isRecord(input);
  const contentPerson = input as PersonMeta;
  const {
    kind,
    person_id,
    locale,
    slug,
    name,
    grammatical_gender,
    picture_href,
    links,
    institutions,
    title,
  } = contentPerson;

  t.isExactly(kind, "person");
  t.isString(person_id);
  t.isString(locale);
  t.isString(slug);
  t.isString(name);
  isGrammaticalGender(grammatical_gender);
  t.isString(picture_href);
  t.isArrayOfType(links, t.isRecord);
  for (const { name, href } of links) {
    t.isString(name);
    t.isString(href);
  }
  t.isArrayOfType(institutions, t.isRecord);
  for (const { institution_id } of institutions) {
    t.isString(institution_id);
  }
  t.isOptionOfType(title, t.isString);

  return contentPerson;
};
