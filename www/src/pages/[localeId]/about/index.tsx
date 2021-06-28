import { FunctionComponent, Fragment } from "react";
import { Flex, Image, Text, Box, Heading, Link } from "@chakra-ui/react";

import { lorem } from "../../../lib/MockData";
import Footer from "../../../components/Shell/Footer";
import TopBar from "../../../components/Shell/TopBar/TopBar";

const AboutPage: FunctionComponent = () => {
  return (
    <Fragment>
      <TopBar />

      <Flex
        height="100vh"
        justifyContent="center"
        alignItems="center"
        align="center"
        justifyItems="space-around"
        flexDirection="column"
      >
        <Box>
          <Link href="/en/about/approach" color="gray.400">
            {` `}
            Approach
          </Link>
          <Link href="/en/about/behavior" color="gray.400">
            {` `}
            Behavior
          </Link>
          <Link href="/en/about/history" color="gray.400">
            {` `}
            History
          </Link>
          <Link href="/en/about/team" color="gray.400">
            {` `}
            Team
          </Link>
        </Box>
        <Box display="block">
          <Image
            width="max-content"
            height="max-content"
            marginBottom="20"
            src="https://picsum.photos/seed/picsum/1000/300"
          />
        </Box>

        <Box textAlign="center" display="block">
          <Heading as="h1" size="3xl" marginBottom="5">
            About Us
          </Heading>
        </Box>

        <Box width="80%" display="block">
          {` `}
          <Text justifyContent="center" align="justify">
            {lorem(2500)}
          </Text>
        </Box>
      </Flex>

      <Footer />
    </Fragment>
  );
};

// http://localhost:4290/en/about

export default AboutPage;
