import * as t from "typed-assert";
import { PersonMeta } from "./PersonMeta";

export type GrammaticalGender = "masculine" | "feminine";

export function isGrammaticalGender(
  input: unknown
): asserts input is GrammaticalGender {
  t.isOneOf(input, ["masculine", "feminine"]);
}

export const combineGrammaticalGenders = (
  persons: PersonMeta[]
): "only_masculine" | "only_feminine" | "mixed" => {
  if (persons.every((person) => person.grammatical_gender === "masculine")) {
    return "only_masculine";
  }
  if (persons.every((person) => person.grammatical_gender === "feminine")) {
    return "only_feminine";
  }
  return "mixed";
};
