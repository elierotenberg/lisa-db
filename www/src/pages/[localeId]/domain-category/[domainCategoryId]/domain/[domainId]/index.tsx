import { GetStaticProps, GetStaticPaths } from "next";
import { FunctionComponent, Fragment } from "react";
import { Flex, Text, Box, Heading, Link } from "@chakra-ui/react";

import Footer from "../../../../../../components/Shell/Footer";
import TopBar from "../../../../../../components/Shell/TopBar/TopBar";
import { lorem, mockedDatabase } from "../../../../../../lib/MockData";
import { SideBar } from "../../../../../../components/Shell/SideBar/SideBar";
import { SearchBar } from "../../../../../../components/Search/SearchBar";
import { DomainLocale } from "../../../../../../lib/Models";
import { assertNotVoid, assertString } from "../../../../../../lib/utils";
import { PersonPortrait } from "../../../../../../components/Content/Person/PersonPortrait";

type DomainPageStaticProps = {
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
  readonly domainLocale: DomainLocale;
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
  assertNotVoid(params);

  const localeId = params.localeId;
  assertString(localeId);
  const domainCategoryId = params.domainCategoryId;
  assertString(domainCategoryId);
  const domainId = params.domainId;
  assertString(domainId);

  const domainLocale = mockedDatabase.domainCategories
    .flatMap(({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideId, guideLocales }) =>
          guideLocales.map(({ localeId, title, body }) => ({
            localeId,
            domainCategoryId,
            domainId,
            guideId,
            title,
            body,
          })),
        ),
      ),
    )
    .find(
      (domainLocale) =>
        domainLocale.localeId === localeId &&
        domainLocale.domainCategoryId === domainCategoryId &&
        domainLocale.domainId === domainId,
    );

  assertNotVoid(domainLocale);

  return {
    props: {
      localeId,
      domainCategoryId,
      domainId,
      domainLocale,
    },
  };
};

// http://localhost:4290/en/domain-category/cognition/domain/cognition-1
export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
}> = async () => ({
  paths: mockedDatabase.domainCategories.flatMap(
    ({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideLocales }) =>
          guideLocales.map(({ localeId }) => ({
            params: {
              localeId,
              domainCategoryId,
              domainId,
            },
          })),
        ),
      ),
  ),
  fallback: false,
});

export default DomainPage;
