import { GetStaticProps, GetStaticPaths } from "next";
import { FunctionComponent, Fragment } from "react";
import { Flex, Text, Box, Heading } from "@chakra-ui/react";

import { mockedDatabase, lorem } from "../../../../lib/MockData";
import { DomainCategoryLocale } from "../../../../lib/Models";
import { assertNotVoid, assertString } from "../../../../lib/utils";
import Footer from "../../../../components/Shell/Footer";
import TopBar from "../../../../components/Shell/TopBar/TopBar";
import { SideBar } from "../../../../components/Shell/SideBar/SideBar";
import { PreviewCard } from "../../../../components/Content/Preview/PreviewCard";
import { SearchBar } from "../../../../components/Search/SearchBar";

type DomainPageStaticProps = {
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainCategoryLocale: DomainCategoryLocale;
};

const DomainCategoryPage: FunctionComponent<DomainPageStaticProps> = (
  props,
) => {
  return (
    <Fragment>
      <TopBar />
      <Box paddingTop="100" w="80%" m="auto">
        <SearchBar />
      </Box>
      <Flex justifyContent="space-between">
        <Box>
          <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
            Popular Guide{` `}
          </Heading>
        </Box>
        <Box padding="10">
          <SideBar />
        </Box>
      </Flex>

      <Flex w="full" alignItems="center" justifyContent="center" wrap="wrap">
        <PreviewCard />
        <PreviewCard />
        <PreviewCard />
        <PreviewCard />
        <PreviewCard />
      </Flex>
      <Box>
        <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
          What is LISA Guide?
        </Heading>
        <Text justifyContent="center" align="justify" w="90%" m="auto">
          {` `}
          {lorem(1150)}
        </Text>
      </Box>
      <Box>
        <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
          How to read LISA Guide?
        </Heading>
      </Box>
      <Box>
        <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
          Accelerators
        </Heading>
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

  const domainCategoryLocales = mockedDatabase.domainCategories
    .flatMap(
      ({
        domainCategoryId,
        domains,
        domainCategoryLocales: domainCategoryLocale,
      }) =>
        domainCategoryLocale.map(({ domainCategory, body, title }) => ({
          localeId,
          title,
          body,
          domainCategory,
          domains,
          domainCategoryId,
        })),
    )
    .find(
      (domainCategoryLocale) =>
        domainCategoryLocale.localeId === localeId &&
        domainCategoryLocale.domainCategoryId === domainCategoryId,
    );
  assertNotVoid(domainCategoryLocales);
  return {
    props: {
      localeId,
      domainCategoryId,
      domainCategoryLocale: domainCategoryLocales,
    },
  };
};

// http://localhost:4290/en/domain-category/cognition
export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
}> = async () => ({
  paths: mockedDatabase.domainCategories.flatMap(
    ({ domainCategoryId, domains }) =>
      domains.flatMap(({ guides }) =>
        guides.flatMap(({ guideLocales }) =>
          guideLocales.map(({ localeId }) => ({
            params: {
              localeId,
              domainCategoryId,
            },
          })),
        ),
      ),
  ),
  fallback: false,
});

export default DomainCategoryPage;
