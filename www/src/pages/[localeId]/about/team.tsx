import { FunctionComponent, Fragment } from "react";
import { Flex, Text, Box, Heading, Link } from "@chakra-ui/react";

import Footer from "../../../components/Shell/Footer";
import TopBar from "../../../components/Shell/TopBar/TopBar";
import { PersonCard } from "../../../components/Content/Person/PersonCard";

const TeamPage: FunctionComponent = () => {
  return (
    <Fragment>
      <TopBar />

      <Box textAlign="center" paddingTop="100">
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
        <Heading as="h1" size="4xl">
          About
        </Heading>
        <Text color="gray.400">Team Collaborator</Text>
      </Box>
      <Flex
        p={50}
        w="full"
        alignItems="center"
        justifyContent="center"
        wrap="wrap"
      >
        <PersonCard />
        <PersonCard />
        <PersonCard />
      </Flex>
      <Flex
        p={50}
        w="full"
        alignItems="center"
        justifyContent="center"
        wrap="wrap"
      >
        <PersonCard />
        <PersonCard />
        <PersonCard />
      </Flex>

      <Footer />
    </Fragment>
  );
};

export default TeamPage;
