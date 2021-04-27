import "react-i18next";

export type Translation = {
  readonly ["lisadb-title"]: string;
  readonly ["lisadb-motto"]: string;
};

declare module "react-i18next" {
  interface Resources {
    readonly en: Translation;
    readonly fr: Translation;
  }
}
