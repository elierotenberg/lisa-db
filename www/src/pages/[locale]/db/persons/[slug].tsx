import * as t from "typed-assert";
import { GetStaticPaths, GetStaticProps } from "next";
import React, { Fragment, FunctionComponent } from "react";
import Head from "next/head";
import { Heading, VStack, Text, Image, HStack, Tag } from "@chakra-ui/react";
import { ExternalLinkIcon } from "@chakra-ui/icons";
import { contents } from "../../../../content/db";
import { useLocaleContents } from "../../../../hooks/useLocaleContents";
import { find } from "../../../../lib/Content/Content";
import { useTranslation } from "../../../../hooks/useTranslation";
import { NavLink } from "../../../../components/NavLink/NavLink";
import { to } from "../../../../lib/Paths";
import { GuideCard } from "../../../../components/GuideCard/GuideCard";
import { useLocale } from "../../../../hooks/useLocale";

type StaticProps = {
  readonly slug: string;
};

const PersonSlugPage: FunctionComponent<StaticProps> = ({ slug }) => {
  const relatedLinksLabel = useTranslation("related_links");
  const relatedGuidesLabel = useTranslation("related_guides");
  const locale = useLocale();
  const localeContents = useLocaleContents();
  const person = find.person.bySlug(localeContents, slug);
  t.isNotNull(person);

  const relatedGuides = find.person.relatedGuides(
    localeContents,
    person.meta.person_id
  );

  return (
    <Fragment>
      <Head>
        <title>{person.meta.name}</title>
      </Head>
      <VStack alignItems="stretch" spacing={6}>
        <VStack alignItems="center">
          <Image
            maxHeight={200}
            alt={person.meta.name}
            src={person.meta.picture_href}
          />
          <Heading as="h2">{person.meta.name}</Heading>
          {person.meta.title && (
            <Text color="gray.500" fontSize="md">
              {person.meta.title}
            </Text>
          )}
          <HStack>
            {find.person
              .relatedInstitutions(localeContents, person.meta.person_id)
              .map((institution) => (
                <Tag key={institution.meta.institution_id} size="sm">
                  <NavLink href={to.institution(locale, institution.meta.slug)}>
                    {institution.meta.name}
                  </NavLink>
                </Tag>
              ))}
          </HStack>
        </VStack>
        <person.Mdx />
        {person.meta.links.length > 0 && (
          <VStack as="section" alignItems="stretch">
            <Heading as="h3" size="md">
              {relatedLinksLabel}
            </Heading>
            <VStack as="ul" alignItems="stretch" pl={4}>
              {person.meta.links.map((link, key) => (
                <NavLink key={key} href={link.href} isExternal>
                  {link.name} <ExternalLinkIcon />
                </NavLink>
              ))}
            </VStack>
          </VStack>
        )}
        {relatedGuides.length > 0 && (
          <VStack as="section" alignItems="stretch">
            <Heading as="h3" size="md">
              {relatedGuidesLabel}
            </Heading>
            <VStack as="ul" alignItems="stretch" pl={4}>
              {relatedGuides.map((guide) => (
                <GuideCard key={guide.meta.guide_id} guide={guide} />
              ))}
            </VStack>
          </VStack>
        )}
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
  const { persons } = contents;
  return {
    paths: persons.map((person) => ({
      params: { slug: person.meta.slug, locale: person.meta.locale },
    })),
    fallback: false,
  };
};

export default PersonSlugPage;
