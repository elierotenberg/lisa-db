import { FunctionComponent, Fragment } from "react";
import { Flex, Text, Box, Heading, Link } from "@chakra-ui/react";

import { lorem } from "../../../lib/MockData";
import Footer from "../../../components/Shell/Footer";
import TopBar from "../../../components/Shell/TopBar/TopBar";

const ApproachPage: FunctionComponent = () => {
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
        <Box textAlign="center" display="block">
          <Heading as="h1" size="4xl" marginBottom="5">
            Approach
          </Heading>
          <Text>{lorem(150)}</Text>
        </Box>
      </Flex>

      <Footer />
    </Fragment>
  );
};

export default ApproachPage;
