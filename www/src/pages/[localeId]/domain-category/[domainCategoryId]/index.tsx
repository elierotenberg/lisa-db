import { GetStaticProps, GetStaticPaths } from "next";
import { FunctionComponent, Fragment } from "react";
import { Flex, Text, Box, Heading } from "@chakra-ui/react";
import { completeDataList } from "@lisa-db/sdk/build/utils";
import { z } from "zod";

import { lorem } from "../../../../lib/MockData";
import { DomainCategoryLocaleVersion } from "../../../../lib/Models";
import Footer from "../../../../components/Shell/Footer";
import TopBar from "../../../../components/Shell/TopBar/TopBar";
import { SideBar } from "../../../../components/Shell/SideBar/SideBar";
import { PreviewCard } from "../../../../components/Content/Preview/PreviewCard";
import { SearchBar } from "../../../../components/Search/SearchBar";
import { getLisaDbClientFromEnv } from "../../../../lib/LisaDbClient";

type DomainPageStaticProps = {
  readonly domainCategoryLocaleVersion: DomainCategoryLocaleVersion;
};

const DomainCategoryPage: FunctionComponent<DomainPageStaticProps> = ({
  domainCategoryLocaleVersion: { name },
}) => {
  return (
    <Fragment>
      <TopBar />
      <Box paddingTop="100" w="80%" m="auto">
        <SearchBar />
      </Box>
      <Flex justifyContent="space-between">
        <Box>
          <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
            {name}
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
      <Footer />
    </Fragment>
  );
};

export const getStaticProps: GetStaticProps<DomainPageStaticProps> = async ({
  params,
}) => {
  const { localeId, domainCategoryId } = z
    .object({
      localeId: z.string(),
      domainCategoryId: z.string(),
    })
    .parse(params);

  const client = await getLisaDbClientFromEnv();

  const [domainCategoryLocale] = await client
    .items(`lisa_domain_category_locale`)
    .readMany({
      filter: {
        locale_id: localeId,
        domain_category_id: domainCategoryId,
      },
      limit: 1,
    })
    .then(completeDataList);

  const [
    {
      content_markdown: contentMarkdown,
      name,
      lisa_domain_category_locale_version_id: domainCategoryLocaleVersionId,
    },
  ] = await client
    .items(`lisa_domain_category_locale_version`)
    .readMany({
      filter: {
        lisa_domain_category_locale_id:
          domainCategoryLocale.lisa_domain_category_locale_id,
      },
    })
    .then(completeDataList)
    .then((domainCategoryLocaleVersions) =>
      domainCategoryLocaleVersions.sort(
        (a, b) =>
          new Date(b.created_at).getTime() - new Date(a.created_at).getTime(),
      ),
    );

  return {
    props: {
      domainCategoryLocaleVersion: {
        domainCategoryId,
        localeId,
        contentMarkdown,
        domainCategoryLocaleVersionId,
        name,
      },
    },
  };
};

// http://localhost:4290/en/domain-category/cognition
export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
}> = async () => {
  const client = await getLisaDbClientFromEnv();
  const domainDomainCategoryLocales = await client
    .items(`lisa_domain_category_locale`)
    .readMany()
    .then(completeDataList);

  return {
    paths: domainDomainCategoryLocales.flatMap(
      ({ domain_category_id: domainCategoryId, locale_id: localeId }) => ({
        params: {
          domainCategoryId: z.string().parse(domainCategoryId),
          localeId: z.string().parse(localeId),
        },
      }),
    ),
    fallback: false,
  };
};

// // http://localhost:4290/en/domain-category/cognition
// export const getStaticPaths: GetStaticPaths<{
//   readonly localeId: string;
//   readonly domainCategoryId: string;
// }> = async () => ({
//   paths: mockedDatabase.domainCategories.flatMap(
//     ({ domainCategoryId, domains }) =>
//       domains.flatMap(({ guides }) =>
//         guides.flatMap(({ guideLocales }) =>
//           guideLocales.map(({ localeId }) => ({
//             params: {
//               localeId,
//               domainCategoryId,
//             },
//           })),
//         ),
//       ),
//   ),
//   fallback: false,
// });

export default DomainCategoryPage;
