import { Chance } from "chance";

import { GuideLocale } from "./Models";

export const lorem = (length: number): string => {
  let value = ``;
  while (value.length < length) {
    value += `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n`;
  }
  return value.slice(0, length - 1);
};

const chance = new Chance(280147921757644);

export type MockDatabase = {
  readonly locales: { readonly localeId: string }[];
  readonly domainCategories: {
    readonly domainCategoryId: string;
    readonly domains: {
      readonly domainId: string;
      readonly guides: {
        readonly guideId: string;
        readonly guideLocales: (GuideLocale & {
          readonly guideLocaleAuthors: {
            readonly authorId: string;
          }[];
        })[];
      }[];
    }[];
  }[];
  readonly authors: {
    readonly authorId: string;
    readonly firstName: string;
    readonly lastName: string;
    readonly portraitHref: string;
  }[];
};

const mockDatabase = (): MockDatabase => {
  const locales: MockDatabase["locales"] = [
    { localeId: `en` },
    { localeId: `fr` },
    { localeId: `pt` },
  ];
  const authors: MockDatabase["authors"] = new Array(
    chance.integer({ min: 5, max: 10 }),
  )
    .fill(null)
    .map((_, key) => ({
      authorId: `author-${key}`,
      firstName: chance.first(),
      lastName: chance.last(),
      portraitHref: chance.url(),
    }));

  const domainCategories: MockDatabase["domainCategories"] = [
    `cognition`,
    `behavior`,
  ].map((domainCategoryId) => ({
    domainCategoryId,
    domains: [`${domainCategoryId}-1`, `${domainCategoryId}-2`].map(
      (
        domainId,
      ): MockDatabase["domainCategories"][number]["domains"][number] => ({
        domainId,
        guides: [`${domainId}-1`, `${domainId}-2`].map((guideId) => ({
          guideId,
          guideLocales: locales.map(
            ({
              localeId,
            }): MockDatabase["domainCategories"][number]["domains"][number]["guides"][number]["guideLocales"][number] => ({
              guideId,
              localeId,
              title: `Title for ${guideId}-${localeId}`,
              body: `Body for ${guideId}-${localeId}`,
              guideLocaleAuthors: chance
                .pickset(authors)
                .map(({ authorId }) => ({ authorId })),
            }),
          ),
        })),
      }),
    ),
  }));
  return {
    authors,
    domainCategories,
    locales,
  };
};

export const mockedDatabase = mockDatabase();
