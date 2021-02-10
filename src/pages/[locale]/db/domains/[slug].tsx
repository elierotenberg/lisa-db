import * as t from "typed-assert";
import Head from "next/head";
import { GetStaticPaths, GetStaticProps } from "next";
import React, { Fragment, FunctionComponent } from "react";
import { Heading, VStack } from "@chakra-ui/react";
import { contents } from "../../../../content/db";
import { useLocaleContents } from "../../../../hooks/useLocaleContents";
import { GuideCard } from "../../../../components/GuideCard/GuideCard";
import { useTranslation } from "../../../../hooks/useTranslation";
import { find } from "../../../../lib/Content/Content";

type StaticProps = {
  readonly slug: string;
};

const DomainSlugPage: FunctionComponent<StaticProps> = ({ slug }) => {
  const relatedGuides = useTranslation("related_guides");
  const localeContents = useLocaleContents();
  const domain = find.domain.bySlug(localeContents, slug);
  t.isNotNull(domain);

  return (
    <Fragment>
      <Head>
        <title>{domain.meta.name}</title>
      </Head>
      <VStack alignItems="stretch" spacing={6}>
        <VStack as="section" alignItems="stretch" spacing={2}>
          <Heading as="h2" size="md">
            {domain.meta.name}
          </Heading>
          <domain.Mdx />
        </VStack>
        <VStack as="section" alignItems="stretch" spacing={2}>
          <Heading as="h3" size="sm">
            {relatedGuides}
          </Heading>
          <VStack as="ul" alignItems="stretch" pl={4}>
            {find.domain
              .relatedGuides(localeContents, domain.meta.domain_id)
              .map((guide) => (
                <GuideCard key={guide.meta.guide_id} as="li" guide={guide} />
              ))}
          </VStack>
        </VStack>
      </VStack>
    </Fragment>
  );
};

export const getStaticProps: GetStaticProps<StaticProps> = async ({
  params,
}) => {
  t.isRecord(params);
  const { slug } = params;
  t.isString(slug);
  return { props: { slug } };
};

export const getStaticPaths: GetStaticPaths = async () => {
  const { domains } = contents;
  return {
    paths: domains.map((domain) => ({
      params: { slug: domain.meta.slug, locale: domain.meta.locale },
    })),
    fallback: false,
  };
};

export default DomainSlugPage;
