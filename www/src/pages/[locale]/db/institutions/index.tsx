import { Heading, VStack } from "@chakra-ui/react";
import { GetStaticPaths, GetStaticProps } from "next";
import Head from "next/head";
import React, { Fragment, FunctionComponent } from "react";
import { NavLink } from "../../../../components/NavLink/NavLink";
import { useLocale } from "../../../../hooks/useLocale";
import { useLocaleContents } from "../../../../hooks/useLocaleContents";
import { useTranslation } from "../../../../hooks/useTranslation";
import { locales } from "../../../../lib/Locales";
import { to } from "../../../../lib/Paths";

const InstitutionsIndexPage: FunctionComponent = () => {
  const institutionsLabel = useTranslation("institutions");
  const locale = useLocale();
  const localeContents = useLocaleContents();

  return (
    <Fragment>
      <Head>
        <title>{institutionsLabel}</title>
      </Head>
      <VStack alignItems="stretch">
        <Heading as="h2">{institutionsLabel}</Heading>
        <VStack as="ul" alignItems="stretch" pl={4}>
          {localeContents.institutions.map((institution) => (
            <NavLink
              key={institution.meta.institution_id}
              href={to.institution(locale, institution.meta.slug)}
            >
              {institution.meta.name}
            </NavLink>
          ))}
        </VStack>
      </VStack>
    </Fragment>
  );
};

export const getStaticProps: GetStaticProps = async () => ({ props: {} });

export const getStaticPaths: GetStaticPaths = async () => ({
  paths: locales.map((locale) => ({ params: { locale } })),
  fallback: false,
});

export default InstitutionsIndexPage;
