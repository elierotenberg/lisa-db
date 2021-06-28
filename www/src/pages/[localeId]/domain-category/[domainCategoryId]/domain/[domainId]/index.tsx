import { GetStaticProps, GetStaticPaths } from "next";
import { FunctionComponent, Fragment } from "react";
import { Flex, Text, Box, Heading, Link } from "@chakra-ui/react";
import { completeDataList } from "@lisa-db/sdk/build/utils";
import { z } from "zod";

import Footer from "../../../../../../components/Shell/Footer";
import TopBar from "../../../../../../components/Shell/TopBar/TopBar";
import { lorem } from "../../../../../../lib/MockData";
import { SideBar } from "../../../../../../components/Shell/SideBar/SideBar";
import { SearchBar } from "../../../../../../components/Search/SearchBar";
import { DomainLocaleVersion } from "../../../../../../lib/Models";
import { PersonPortrait } from "../../../../../../components/Content/Person/PersonPortrait";
import { getLisaDbClientFromEnv } from "../../../../../../lib/LisaDbClient";

type DomainPageStaticProps = {
  readonly domainLocaleVersion: DomainLocaleVersion;
};

const DomainPage: FunctionComponent<DomainPageStaticProps> = (props) => {
  return (
    <Fragment>
      <TopBar />
      <Box paddingTop="100" w="80%" m="auto">
        <SearchBar />
      </Box>
      <Box>
        <Flex justifyContent="space-between">
          <Box>
            <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
              How to help students become more focused?
            </Heading>
          </Box>
          <Box padding="10">
            <SideBar />
          </Box>
        </Flex>
        <Flex w="90%" m="auto" wrap={{ base: `wrap`, md: `wrap`, lg: `unset` }}>
          <Box>
            <PersonPortrait />
          </Box>
          <Box>
            <PersonPortrait />
          </Box>
          <Box>
            <PersonPortrait />
          </Box>
          <Box>
            <PersonPortrait />
          </Box>
          <Box>
            <PersonPortrait />
          </Box>
          <Box>
            <PersonPortrait />
          </Box>
        </Flex>
      </Box>

      <Box>
        <Heading as="h2" size="sm" w="90%" m="auto" color="gray.400">
          Make smaller tasks to facilitate completion.
        </Heading>
        <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
          Examples
        </Heading>
        <Flex>
          <Text justifyContent="center" align="justify" w="80%" ml="10">
            {` `}
            {lorem(4150)}
          </Text>
        </Flex>
      </Box>
      <Box>
        <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
          Similiar Articles:
        </Heading>
        <Box w="95%" m="auto">
          <Link href="/">
            <Text color="blue">
              Lorem ipsum carrots, enhanced undergraduate developer but they do
            </Text>
          </Link>
          <Link href="/">
            <Text color="blue">
              Lorem ipsum carrots, enhanced undergraduate developer but they do
            </Text>
          </Link>
          <Link href="/">
            <Text color="blue">
              Lorem ipsum carrots, enhanced undergraduate developer but they do
            </Text>
          </Link>
          <Link href="/">
            <Text color="blue">
              Lorem ipsum carrots, enhanced undergraduate developer but they do
            </Text>
          </Link>
        </Box>
      </Box>
      {JSON.stringify(props, null, 2)}
      <Footer />
    </Fragment>
  );
};

export const getStaticProps: GetStaticProps<DomainPageStaticProps> = async ({
  params,
}) => {
  const { localeId, domainCategoryId, domainId } = z
    .object({
      localeId: z.string(),
      domainCategoryId: z.string(),
      domainId: z.string(),
    })
    .parse(params);

  const client = await getLisaDbClientFromEnv();

  const [domainLocale] = await client
    .items(`lisa_domain_locale`)
    .readMany({
      filter: {
        domain_id: domainId,
        locale_id: localeId,
      },
      limit: 1,
    })
    .then(completeDataList);

  const [
    {
      content_markdown: contentMarkdown,
      name,
      lisa_domain_locale_version_id: domainLocaleVersionId,
    },
  ] = await client
    .items(`lisa_domain_locale_version`)
    .readMany({
      filter: {
        lisa_domain_locale_id: domainLocale.lisa_domain_locale_id,
      },
    })
    .then(completeDataList)
    .then((domainLocaleVersions) =>
      domainLocaleVersions.sort(
        (a, b) =>
          new Date(b.created_at).getTime() - new Date(a.created_at).getTime(),
      ),
    );

  return {
    props: {
      domainLocaleVersion: {
        contentMarkdown,
        domainCategoryId,
        domainLocaleVersionId,
        domainId,
        localeId,
        name,
      },
    },
  };
};

// http://localhost:4290/en/domain-category/cognition/domain/cognition-1
export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
}> = async () => {
  const client = await getLisaDbClientFromEnv();

  const domains = await client
    .items(`lisa_domain`)
    .readMany()
    .then(completeDataList);

  const domainLocales = await client
    .items(`lisa_domain_locale`)
    .readMany()
    .then(completeDataList);

  return {
    paths: domainLocales.map(({ domain_id: domainId, locale_id: localeId }) => {
      const domain = domains.find((domain) => domain.domain_id === domainId);
      const domainCategoryId = z.string().parse(domain?.domain_category_id);
      return {
        params: {
          localeId: z.string().parse(localeId),
          domainCategoryId,
          domainId: z.string().parse(domainId),
        },
      };
    }),
    fallback: false,
  };
};

export default DomainPage;
