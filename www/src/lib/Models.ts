export type Guide = {
  readonly guideId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
};

export type GuideLocale = {
  readonly guideId: string;
  readonly localeId: string;
  readonly title: string;
  readonly body: string;
};

export type GuideLocaleAuthor = {
  readonly authorId: string;
  readonly firstName: string;
  readonly lastName: string;
  readonly portraitHref: string;
};

export type Domain = {
  readonly domainId: string;
  readonly domainCategoryId: string;
};
export type DomainLocale = {
  readonly domainId: string;
  readonly localeId: string;
  readonly title: string;
  readonly body: string;
};
export type DomainCategoryLocale = {
  readonly domainCategory: string;
  readonly localeId: string;
  readonly title: string;
  readonly body: string;
};
