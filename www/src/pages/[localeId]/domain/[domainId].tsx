import { Code, Container } from "@chakra-ui/layout";
import { GetStaticPaths, GetStaticProps } from "next";
import { FunctionComponent } from "react";
import { isRecord, isString } from "typed-assert";

import { LisaDomainLocale } from "../../../../directus";
import { getDirectusFromEnv, asNonPartialMany } from "../../../lib/Directus";

type DomainPageStaticProps = {
  readonly domainLocale: LisaDomainLocale;
};

const DomainPage: FunctionComponent<DomainPageStaticProps> = ({
  domainLocale,
}) => (
  <Container>
    <Code>{JSON.stringify(domainLocale, null, 2)}</Code>
  </Container>
);

export const getStaticProps: GetStaticProps<DomainPageStaticProps> = async ({
  params,
}) => {
  isRecord(params);
  const { localeId, domainId } = params;
  isString(localeId);
  isString(domainId);
  const directus = await getDirectusFromEnv();

  const domainLocale = (
    await directus
      .items(`lisa_domain_locale`)
      .readMany({
        filter: {
          domain_id: domainId,
          locale_id: localeId,
        },
      })
      .then(asNonPartialMany)
  )[0];

  return {
    props: {
      domainLocale,
    },
  };
};

export const getStaticPaths: GetStaticPaths = async () => {
  const directus = await getDirectusFromEnv();

  const domainLocales = await directus
    .items(`lisa_domain_locale`)
    .readMany()
    .then(asNonPartialMany);

  return {
    paths: domainLocales.map(
      ({ locale_id: localeId, domain_id: domainId }) => ({
        params: {
          localeId,
          domainId,
        },
      }),
    ),
    fallback: false,
  };
};

export default DomainPage;
