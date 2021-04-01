import { ExternalLinkIcon } from "@chakra-ui/icons";
import { Heading, VStack } from "@chakra-ui/react";
import { GetStaticPaths, GetStaticProps } from "next";
import Head from "next/head";
import React, { Fragment, FunctionComponent } from "react";
import * as t from "typed-assert";
import { NavLink } from "../../../../components/NavLink/NavLink";
import { PersonCard } from "../../../../components/PersonCard/PersonCard";
import { contents } from "../../../../content/db";
import { useLocaleContents } from "../../../../hooks/useLocaleContents";
import { useTranslation } from "../../../../hooks/useTranslation";
import { find } from "../../../../lib/Content/Content";

type StaticProps = {
  readonly slug: string;
};

const InstitutionSlugPage: FunctionComponent<StaticProps> = ({ slug }) => {
  const relatedPersonsLabel = useTranslation("related_persons");
  const localeContents = useLocaleContents();
  const institution = find.institution.bySlug(localeContents, slug);
  t.isNotNull(institution);

  const relatedPersons = find.institution.relatedPersons(
    localeContents,
    institution.meta.institution_id
  );

  return (
    <Fragment>
      <Head>
        <title>{institution.meta.name}</title>
      </Head>
      <VStack alignItems="stretch" spacing={4}>
        <Heading as="h2" size="lg" textAlign="center">
          <NavLink href={institution.meta.href} isExternal>
            {institution.meta.name} <ExternalLinkIcon />
          </NavLink>
        </Heading>
        <institution.Mdx />
        {relatedPersons.length > 0 && (
          <VStack alignItems="stretch">
            <Heading as="h3" size="md">
              {relatedPersonsLabel}
            </Heading>
            <VStack as="ul" alignItems="stretch" pl={4}>
              {relatedPersons.map((person) => (
                <PersonCard key={person.meta.person_id} person={person} />
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
  const { institutions } = contents;
  return {
    paths: institutions.map((institution) => ({
      params: { slug: institution.meta.slug, locale: institution.meta.locale },
    })),
    fallback: false,
  };
};

export default InstitutionSlugPage;
