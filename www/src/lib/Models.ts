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
export type DomainLocaleVersion = {
  readonly domainCategoryId: string;
  readonly domainLocaleVersionId: string;
  readonly domainId: string;
  readonly localeId: string;
  readonly name: string;
  readonly contentMarkdown: string;
};
export type DomainCategoryLocaleVersion = {
  readonly domainCategoryId: string;
  readonly localeId: string;
  readonly domainCategoryLocaleVersionId: string;
  readonly name: string;
  readonly contentMarkdown: string;
};
