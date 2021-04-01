import { VStack, Heading } from "@chakra-ui/react";
import { GetStaticPaths, GetStaticProps } from "next";
import Head from "next/head";
import React, { Fragment, FunctionComponent } from "react";
import { PersonCard } from "../../../../components/PersonCard/PersonCard";
import { useLocaleContents } from "../../../../hooks/useLocaleContents";
import { useTranslation } from "../../../../hooks/useTranslation";
import { locales } from "../../../../lib/Locales";

const PersonsIndexPage: FunctionComponent = () => {
  const personsLabel = useTranslation("persons");
  const localeContents = useLocaleContents();

  return (
    <Fragment>
      <Head>
        <title>{personsLabel}</title>
      </Head>
      <VStack alignItems="stretch" spacing={4}>
        <Heading as="h2" size="md">
          {personsLabel}
        </Heading>
        <VStack as="ul" alignItems="stretch" spacing={2} pl={4}>
          {localeContents.persons.map((person) => (
            <PersonCard key={person.meta.person_id} as="li" person={person} />
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

export default PersonsIndexPage;
