export const locales = ["en", "fr", "pt"];
export const defaultLocale = "en";

export const matchLocale = (asPath: string): string =>
  locales.find((locale) => asPath.startsWith(`/${locale}`)) ?? defaultLocale;
