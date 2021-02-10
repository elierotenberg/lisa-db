import Head from "next/head";
import { VStack, Heading } from "@chakra-ui/react";
import React, { Fragment, FunctionComponent } from "react";
import { GetStaticPaths, GetStaticProps } from "next";
import { useLocaleContents } from "../../../../hooks/useLocaleContents";
import { useTranslation } from "../../../../hooks/useTranslation";
import { GuideCard } from "../../../../components/GuideCard/GuideCard";
import { locales } from "../../../../lib/Locales";

const AudiencesTeachersPage: FunctionComponent = () => {
  const guidesLabel = useTranslation("guides");
  const teachersLabel = useTranslation("audiences", "teachers");
  const localeContents = useLocaleContents();

  return (
    <Fragment>
      <Head>
        <title>
          {guidesLabel} - {teachersLabel}
        </title>
      </Head>
      <VStack alignItems="stretch" spacing={4}>
        <Heading as="h2" size="md">
          {guidesLabel} - {teachersLabel}
        </Heading>
        <VStack as="ul" alignItems="stretch" spacing={2} pl={4}>
          {localeContents.guides
            .filter((guide) => guide.meta.audiences.includes("teachers"))
            .map((guide) => (
              <GuideCard key={guide.meta.guide_id} as="li" guide={guide} />
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

export default AudiencesTeachersPage;
