import { GetStaticPaths, GetStaticProps } from "next";
import { FunctionComponent, Fragment } from "react";
import {
  Flex,
  Text,
  Box,
  Heading,
  Divider,
  ListItem,
  UnorderedList,
  Link,
} from "@chakra-ui/react";

import Footer from "../../../../../../../../components/Shell/Footer";
import TopBar from "../../../../../../../../components/Shell/TopBar/TopBar";
import { lorem, mockedDatabase } from "../../../../../../../../lib/MockData";
import {
  GuideLocale,
  GuideLocaleAuthor,
} from "../../../../../../../../lib/Models";
import { assertNotVoid, assertString } from "../../../../../../../../lib/utils";
import { SideBar } from "../../../../../../../../components/Shell/SideBar/SideBar";
import { SearchBar } from "../../../../../../../../components/Search/SearchBar";

type GuidePageStaticProps = {
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
  readonly guideId: string;
  readonly guideLocale: GuideLocale;
  readonly guideLocaleAuthors: GuideLocaleAuthor[];
};

const GuidePage: FunctionComponent<GuidePageStaticProps> = (props) => {
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
              Cognition{` `}
            </Heading>
          </Box>
          <Box padding="10">
            <SideBar />
          </Box>
        </Flex>
        <Flex>
          <Box>
            {` `}
            <Text justifyContent="center" align="justify" w="90%" ml="10">
              {` `}
              {lorem(1500)}
            </Text>
            <Box w="80%" m="auto" p="1">
              <Divider />
            </Box>
            <Text justifyContent="center" align="justify" w="90%" ml="10">
              {` `}
              {lorem(1500)}
            </Text>
            <Box w="80%" m="auto" p="1">
              <Divider />
            </Box>
            <Text justifyContent="center" align="justify" w="90%" ml="10">
              {` `}
              {lorem(1500)}
            </Text>
            <Box w="80%" m="auto" p="1">
              <Divider />
            </Box>
          </Box>
        </Flex>
      </Box>

      <Box>
        <Heading as="h2" size="lg" w="100%" m="auto" padding="10">
          Explore its subdomains :
        </Heading>
      </Box>
      <Box w="90%" m="auto">
        <UnorderedList>
          <Link>
            <ListItem>Attention</ListItem>
          </Link>
          <Link>
            <ListItem>Planning and Organization</ListItem>
          </Link>
          <Link>
            <ListItem>Memory</ListItem>
          </Link>
          <Link>
            <ListItem>Abstract Learning</ListItem>
          </Link>
          <Link>
            <ListItem>Thnking Speed</ListItem>
          </Link>
        </UnorderedList>
      </Box>
      <Box w="80%" m="auto" p="1">
        <Divider />
      </Box>
      {JSON.stringify(props, null, 2)}
      <Footer />
    </Fragment>
  );
};

export const getStaticProps: GetStaticProps<GuidePageStaticProps> = async ({
  params,
}) => {
  assertNotVoid(params);

  const localeId = params.localeId;
  assertString(localeId);
  const domainCategoryId = params.domainCategoryId;
  assertString(domainCategoryId);
  const domainId = params.domainId;
  assertString(domainId);
  const guideId = params.guideId;
  assertString(guideId);

  const guideLocale = mockedDatabase.domainCategories
    .flatMap(({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideId, guideLocales }) =>
          guideLocales.map(({ localeId, guideLocaleAuthors, title, body }) => ({
            localeId,
            domainCategoryId,
            domainId,
            guideId,
            guideLocaleAuthors,
            title,
            body,
          })),
        ),
      ),
    )
    .find(
      (guideLocale) =>
        guideLocale.localeId === localeId &&
        guideLocale.domainCategoryId === domainCategoryId &&
        guideLocale.domainId === domainId &&
        guideLocale.guideId === guideId,
    );

  assertNotVoid(guideLocale);

  const guideLocaleAuthors: GuideLocaleAuthor[] =
    guideLocale.guideLocaleAuthors.map(({ authorId }) => {
      const author = mockedDatabase.authors.find(
        (author) => author.authorId === authorId,
      );
      assertNotVoid(author);
      return author;
    });

  return {
    props: {
      localeId,
      domainCategoryId,
      domainId,
      guideId,
      guideLocale,
      guideLocaleAuthors,
    },
  };
};
// http://localhost:4290/en/domain-category/cognition/domain/cognition-1/guide/cognition-1-1
export const getStaticPaths: GetStaticPaths<{
  readonly localeId: string;
  readonly domainCategoryId: string;
  readonly domainId: string;
  readonly guideId: string;
}> = async () => ({
  paths: mockedDatabase.domainCategories.flatMap(
    ({ domainCategoryId, domains }) =>
      domains.flatMap(({ domainId, guides }) =>
        guides.flatMap(({ guideId, guideLocales }) =>
          guideLocales.map(({ localeId }) => ({
            params: {
              localeId,
              domainCategoryId,
              domainId,
              guideId,
            },
          })),
        ),
      ),
  ),
  fallback: false,
});

export default GuidePage;
