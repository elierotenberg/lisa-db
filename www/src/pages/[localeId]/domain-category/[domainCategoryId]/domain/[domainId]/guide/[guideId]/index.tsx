import { GetStaticPaths, GetStaticProps } from "next";
import { FunctionComponent } from "react";

import { mockedDatabase } from "../../../../../../../../lib/MockData";
import {
  GuideLocale,
  GuideLocaleAuthor,
} from "../../../../../../../../lib/Models";
import { assertNotVoid, assertString } from "../../../../../../../../lib/utils";

type GuidePageStaticProps = {
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
  readonly guideId: string;
  readonly guideLocale: GuideLocale;
  readonly guideLocaleAuthors: GuideLocaleAuthor[];
};

const GuidePage: FunctionComponent<GuidePageStaticProps> = (props) => (
  <div>{JSON.stringify(props, null, 2)}</div>
);

export const getStaticProps: GetStaticProps<GuidePageStaticProps> = async ({
  params,
}) => {
  assertNotVoid(params);

  const localeId = params.localeId;
  assertString(localeId);
  const domainCategoryId = params.domainCategoryId;
  assertString(domainCategoryId);
  const domainId = params.domainId;
  assertString(domainId);
  const guideId = params.guideId;
  assertString(guideId);

  const guideLocale = mockedDatabase.domainCategories
    .flatMap(({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideId, guideLocales }) =>
          guideLocales.map(({ localeId, guideLocaleAuthors, title, body }) => ({
            localeId,
            domainCategoryId,
            domainId,
            guideId,
            guideLocaleAuthors,
            title,
            body,
          })),
        ),
      ),
    )
    .find(
      (guideLocale) =>
        guideLocale.localeId === localeId &&
        guideLocale.domainCategoryId === domainCategoryId &&
        guideLocale.domainId === domainId &&
        guideLocale.guideId === guideId,
    );

  assertNotVoid(guideLocale);

  const guideLocaleAuthors: GuideLocaleAuthor[] =
    guideLocale.guideLocaleAuthors.map(({ authorId }) => {
      const author = mockedDatabase.authors.find(
        (author) => author.authorId === authorId,
      );
      assertNotVoid(author);
      return author;
    });

  return {
    props: {
      localeId,
      domainCategoryId,
      domainId,
      guideId,
      guideLocale,
      guideLocaleAuthors,
    },
  };
};

export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
  readonly guideId: string;
}> = async () => ({
  paths: mockedDatabase.domainCategories.flatMap(
    ({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideId, guideLocales }) =>
          guideLocales.map(({ localeId }) => ({
            params: {
              localeId,
              domainCategoryId,
              domainId,
              guideId,
            },
          })),
        ),
      ),
  ),
  fallback: false,
});

export default GuidePage;
