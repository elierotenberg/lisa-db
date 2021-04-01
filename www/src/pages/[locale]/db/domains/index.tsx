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

const DomainIndexPage: FunctionComponent = () => {
  const locale = useLocale();
  const domains = useTranslation("domains");
  const localeContents = useLocaleContents();

  return (
    <Fragment>
      <Head>
        <title>{domains}</title>
      </Head>
      <VStack alignItems="stretch" spacing={4}>
        <Heading as="h2" size="md">
          {domains}
        </Heading>
        <VStack as="ul" alignItems="stretch" spacing={2} pl={4}>
          {localeContents.domains.map((domain) => (
            <NavLink
              key={domain.meta.domain_id}
              href={to.domain(locale, domain.meta.slug)}
            >
              <Heading as="h3" size="sm">
                {domain.meta.name}
              </Heading>
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

export default DomainIndexPage;
