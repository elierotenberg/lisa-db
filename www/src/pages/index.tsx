import { FunctionComponent, Fragment } from "react";
import { Flex, Box, Heading, Text, Image } from "@chakra-ui/react";

import { SideBar } from "../components/Shell/SideBar/SideBar";
import Footer from "../components/Shell/Footer";
import { SearchBar } from "../components/Search/SearchBar";
import TopBar from "../components/Shell/TopBar/TopBar";

const IndexPage: FunctionComponent = () => {
  return (
    <Fragment>
      <TopBar />

      <Flex
        height="100vh"
        justifyContent="center"
        alignItems="center"
        align="center"
        justifyItems="space-between"
      >
        <Box justifyContent="space-between">
          <Box textAlign="center">
            <Heading as="h1" size="4xl" padding="25">
              Welcome to L.I.S.A. DataBase
            </Heading>
            <Text color="gray.400">
              Research-validated instructions to empower young generation
            </Text>
          </Box>

          <Flex justifyContent="space-between">
            <Box paddingTop="7" w="80%" m="auto">
              <SearchBar />
            </Box>
            <Box paddingTop="7">
              <SideBar />
            </Box>
          </Flex>

          <Box paddingTop="7">
            Reserved: Slogan or logos of partner organization
          </Box>

          <Flex height="container" justifyContent="space-between">
            <Image
              src="logo.png"
              fallbackSrc="https://via.placeholder.com/150"
            />
            <Image
              src="logo.png"
              fallbackSrc="https://via.placeholder.com/150"
            />
            <Image
              src="logo.png"
              fallbackSrc="https://via.placeholder.com/150"
            />
          </Flex>
          <Flex
            height="container"
            justifyContent="space-between"
            paddingTop="7"
          >
            <Image
              src="logo.png"
              fallbackSrc="https://via.placeholder.com/150"
            />
            <Image
              src="logo.png"
              fallbackSrc="https://via.placeholder.com/150"
            />
            <Image
              src="logo.png"
              fallbackSrc="https://via.placeholder.com/150"
            />
          </Flex>
        </Box>
      </Flex>

      <Footer />
    </Fragment>
  );
};

export default IndexPage;
