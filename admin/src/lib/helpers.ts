import { isOptionOfType, isString, check, isNotNull } from "typed-assert";

const reName = /(?<surname>([\w\s]+)), (?<firstInitial>\w)\.( (?<middleInitial>\w)\.)?/g;

export const extractNames = (
  input: string,
): readonly (readonly [
  firstInitial: string,
  middleInitial: null | string,
  surname: string,
])[] =>
  Array.from(input.matchAll(reName))
    .map(({ groups }) => {
      if (!groups) {
        return null;
      }
      const { surname, firstInitial, middleInitial } = groups;
      try {
        isString(surname);
        isString(firstInitial);
        isOptionOfType(middleInitial, isString);
        return [firstInitial, middleInitial ?? null, surname] as const;
      } catch (error) {
        console.error({ surname, firstInitial, middleInitial }, error);
        throw error;
      }
    })
    .filter(check(isNotNull));
