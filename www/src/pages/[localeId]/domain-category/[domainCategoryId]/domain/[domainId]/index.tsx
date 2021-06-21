import { GetStaticPaths, GetStaticProps } from "next";
import { FunctionComponent } from "react";

import { mockedDatabase } from "../../../../../../lib/MockData";
import { DomainLocale } from "../../../../../../lib/Models";
import { assertNotVoid, assertString } from "../../../../../../lib/utils";

// import NotImplemented from "../../../../about";

// export default NotImplemented;

type DomainPageStaticProps = {
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
  readonly domainLocale: DomainLocale;
};

const DomainPage: FunctionComponent<DomainPageStaticProps> = (props) => (
  <div>{JSON.stringify(props, null, 2)}</div>
);

export const getStaticProps: GetStaticProps<DomainPageStaticProps> = async ({
  params,
}) => {
  assertNotVoid(params);

  const localeId = params.localeId;
  assertString(localeId);
  const domainCategoryId = params.domainCategoryId;
  assertString(domainCategoryId);
  const domainId = params.domainId;
  assertString(domainId);

  const domainLocale = mockedDatabase.domainCategories
    .flatMap(({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideId, guideLocales }) =>
          guideLocales.map(({ localeId, title, body }) => ({
            localeId,
            domainCategoryId,
            domainId,
            guideId,
            title,
            body,
          })),
        ),
      ),
    )
    .find(
      (domainLocale) =>
        domainLocale.localeId === localeId &&
        domainLocale.domainCategoryId === domainCategoryId &&
        domainLocale.domainId === domainId,
    );

  assertNotVoid(domainLocale);

  return {
    props: {
      localeId,
      domainCategoryId,
      domainId,
      domainLocale,
    },
  };
};

// http://localhost:4290/en/domain-category/cognition/domain/cognition-1
export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
}> = async () => ({
  paths: mockedDatabase.domainCategories.flatMap(
    ({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideLocales }) =>
          guideLocales.map(({ localeId }) => ({
            params: {
              localeId,
              domainCategoryId,
              domainId,
            },
          })),
        ),
      ),
  ),
  fallback: false,
});

export default DomainPage;
