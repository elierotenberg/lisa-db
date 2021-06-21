// import NotImplemented from "../../about";

import { GetStaticPaths, GetStaticProps } from "next";
import { FunctionComponent } from "react";

import { mockedDatabase } from "../../../../lib/MockData";
import { DomainCategoryLocale } from "../../../../lib/Models";
import { assertNotVoid, assertString } from "../../../../lib/utils";

// export default NotImplemented;

type DomainPageStaticProps = {
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainCategoryLocale: DomainCategoryLocale;
};

const DomainCategoryPage: FunctionComponent<DomainPageStaticProps> = (
  props,
) => <div>{JSON.stringify(props, null, 2)}</div>;

export const getStaticProps: GetStaticProps<DomainPageStaticProps> = async ({
  params,
}) => {
  assertNotVoid(params);

  const localeId = params.localeId;
  assertString(localeId);
  const domainCategoryId = params.domainCategoryId;
  assertString(domainCategoryId);

  const domainCategoryLocales = mockedDatabase.domainCategories
    .flatMap(
      ({
        domainCategoryId,
        domains,
        domainCategoryLocales: domainCategoryLocale,
      }) =>
        domainCategoryLocale.map(({ domainCategory, body, title }) => ({
          localeId,
          title,
          body,
          domainCategory,
          domains,
          domainCategoryId,
        })),
    )
    .find(
      (domainCategoryLocale) =>
        domainCategoryLocale.localeId === localeId &&
        domainCategoryLocale.domainCategoryId === domainCategoryId,
    );
  assertNotVoid(domainCategoryLocales);
  return {
    props: {
      localeId,
      domainCategoryId,
      domainCategoryLocale: domainCategoryLocales,
    },
  };
};

// http://localhost:4290/en/domain-category/cognition
export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
}> = async () => ({
  paths: mockedDatabase.domainCategories.flatMap(
    ({ domainCategoryId, domains }) =>
      domains.flatMap(({ guides }) =>
        guides.flatMap(({ guideLocales }) =>
          guideLocales.map(({ localeId }) => ({
            params: {
              localeId,
              domainCategoryId,
            },
          })),
        ),
      ),
  ),
  fallback: false,
});

export default DomainCategoryPage;
