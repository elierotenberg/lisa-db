import { List, ListItem, Text } from "@chakra-ui/layout";
import { Container } from "@chakra-ui/react";
import { GetStaticPaths, GetStaticProps } from "next";
import Link from "next/link";
import React, { FunctionComponent } from "react";
import { isRecord, isString } from "typed-assert";
import { resolveAllConcurrent } from "typed-utilities";

import { LisaDomainLocale, Locale } from "../../../../directus";
import {
  asNonPartial,
  asNonPartialMany,
  getDirectusFromEnv,
} from "../../../lib/Directus";

type DomainIndexPageStaticProps = {
  readonly locale: Locale;
  readonly domainLocales: LisaDomainLocale[];
};

const DomainIndexPage: FunctionComponent<DomainIndexPageStaticProps> = ({
  locale,
  domainLocales,
}) => (
  <Container>
    <Text>{locale.name}</Text>
    <List>
      {domainLocales.map(({ domain_id: domainId, name }) => (
        <ListItem key={domainId}>
          <Link href={`/${locale.locale_id}/domain/${domainId}`}>{name}</Link>
        </ListItem>
      ))}
    </List>
  </Container>
);

export const getStaticProps: GetStaticProps<DomainIndexPageStaticProps> = async ({
  params,
}) => {
  isRecord(params);
  const { localeId } = params;
  isString(localeId);
  const directus = await getDirectusFromEnv();

  const [locale, domainLocales] = await resolveAllConcurrent([
    directus.items(`locale`).readOne(localeId).then(asNonPartial),
    directus
      .items(`lisa_domain_locale`)
      .readMany({
        filter: {
          locale_id: localeId,
        },
      })
      .then(asNonPartialMany),
  ]);

  return {
    props: {
      locale,
      domainLocales,
    },
  };
};

export const getStaticPaths: GetStaticPaths = async () => {
  const directus = await getDirectusFromEnv();

  const locales = await directus
    .items(`locale`)
    .readMany()
    .then(asNonPartialMany);

  return {
    paths: locales.map(({ locale_id: localeId }) => ({
      params: {
        localeId,
      },
    })),
    fallback: false,
  };
};

export default DomainIndexPage;
