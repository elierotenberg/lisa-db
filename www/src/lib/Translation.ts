import * as t from "typed-assert";

export const findTranslation = (
  locale: string,
  ctx: unknown,
  ...keys: string[]
): string | null => {
  if (keys.length === 0) {
    if (!t.check(t.isRecord)(ctx)) {
      return null;
    }
    const value = ctx[locale];
    if (typeof value !== "string") {
      return null;
    }
    return value;
  }
  const [head, ...tail] = keys;
  if (!t.check(t.isRecord)(ctx)) {
    return null;
  }
  return findTranslation(locale, ctx[head], ...tail);
};
