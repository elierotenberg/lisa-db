import * as t from "typed-assert";
import { GetStaticPaths, GetStaticProps } from "next";
import React, { Fragment, FunctionComponent } from "react";
import Head from "next/head";
import { Heading, VStack, Text, HStack, Tag, Box } from "@chakra-ui/react";
import { ExternalLinkIcon } from "@chakra-ui/icons";
import { contents } from "../../../../content/db";
import { useTranslation } from "../../../../hooks/useTranslation";
import { useLocaleContents } from "../../../../hooks/useLocaleContents";
import { find } from "../../../../lib/Content/Content";
import { combineGrammaticalGenders } from "../../../../lib/Content/GrammaticalGender";
import { PersonCard } from "../../../../components/PersonCard/PersonCard";
import { NavLink } from "../../../../components/NavLink/NavLink";
import { to } from "../../../../lib/Paths";
import { useLocale } from "../../../../hooks/useLocale";

type StaticProps = {
  readonly slug: string;
};

const GuideSlugPage: FunctionComponent<StaticProps> = ({ slug }) => {
  const sourceLabel = useTranslation("source");
  const familiesLabel = useTranslation("audiences", "families");
  const teachersLabel = useTranslation("audiences", "teachers");

  const locale = useLocale();
  const localeContents = useLocaleContents();
  const guide = find.guide.bySlug(localeContents, slug);
  t.isNotNull(guide);

  const relatedDomains = find.guide.relatedDomains(
    localeContents,
    guide.meta.guide_id
  );

  const authors = find.guide.authors(localeContents, guide.meta.guide_id);
  const authorsLabel = useTranslation(
    "authors",
    combineGrammaticalGenders(authors.map((author) => author.meta))
  );

  const curators = find.guide.curators(localeContents, guide.meta.guide_id);
  const curatorsLabel = useTranslation(
    "curators",
    combineGrammaticalGenders(curators.map((curator) => curator.meta))
  );

  return (
    <Fragment>
      <Head>
        <title>{guide.meta.name}</title>
      </Head>
      <VStack alignItems="stretch" spacing={6}>
        <VStack as="section" spacing={4}>
          <Heading as="h2" size="lg" textAlign="center">
            {guide.meta.name}
          </Heading>
          <Text color="gray.500" fontSize="md" textAlign="center">
            {guide.meta.abstract}
          </Text>
          <HStack>
            {relatedDomains.map((domain) => (
              <Tag key={domain.meta.domain_id} size="sm">
                <NavLink href={to.domain(locale, domain.meta.slug)}>
                  {domain.meta.name}
                </NavLink>
              </Tag>
            ))}
            {guide.meta.audiences.includes("families") && (
              <Tag size="sm">
                <NavLink href={to.audience(locale, "families")}>
                  {familiesLabel}
                </NavLink>
              </Tag>
            )}
            {guide.meta.audiences.includes("teachers") && (
              <Tag size="sm">
                <NavLink href={to.audience(locale, "teachers")}>
                  {teachersLabel}
                </NavLink>
              </Tag>
            )}
          </HStack>
          <NavLink href={guide.meta.source.href} isExternal>
            {sourceLabel} <ExternalLinkIcon />
          </NavLink>
        </VStack>
        <VStack as="section" alignItems="stretch">
          <VStack alignItems="stretch">
            <Text as="h3" size="sm">
              {authorsLabel}
            </Text>
            <VStack as="ul" alignItems="stretch" pl={2}>
              {authors.map((author) => (
                <PersonCard
                  as="li"
                  key={author.meta.person_id}
                  person={author}
                />
              ))}
            </VStack>
          </VStack>
          <VStack alignItems="stretch">
            <Text as="h3" size="sm">
              {curatorsLabel}
            </Text>
            <VStack as="ul" alignItems="stretch" pl={2}>
              {curators.map((curator) => (
                <PersonCard
                  as="li"
                  key={curator.meta.person_id}
                  person={curator}
                />
              ))}
            </VStack>
          </VStack>
        </VStack>
        <Box as="section">
          <guide.Mdx />
        </Box>
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
  const { guides } = contents;
  return {
    paths: guides.map((guide) => ({
      params: { slug: guide.meta.slug, locale: guide.meta.locale },
    })),
    fallback: false,
  };
};

export default GuideSlugPage;
