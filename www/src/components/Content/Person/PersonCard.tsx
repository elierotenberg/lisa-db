import React, { Fragment, FunctionComponent } from "react";
import {
  chakra,
  Box,
  Image,
  Flex,
  Icon,
  Heading,
  Text,
} from "@chakra-ui/react";
import { MdEmail, MdLocationOn } from "react-icons/md";
import { AiFillGithub } from "react-icons/ai";
import { BsFillBriefcaseFill } from "react-icons/bs";

export const PersonCard: FunctionComponent = () => {
  return (
    <Fragment>
      <Box textAlign="center" paddingTop="100">
        <Heading as="h1" size="4xl">
          About
        </Heading>
        <Text color="gray.400">Team Collaborator</Text>
      </Box>
      {` `}
      <Flex
        p={50}
        w="full"
        alignItems="center"
        justifyContent="center"
        wrap="wrap"
      >
        <Box
          w="sm"
          mx="auto"
          bg="white"
          shadow="lg"
          rounded="lg"
          overflow="hidden"
        >
          <Image
            w="full"
            h={56}
            fit="cover"
            objectPosition="center"
            src="https://www.achievers.com/blog/wp-content/uploads/2020/05/05-27-20.jpg"
            alt="Collaborator photos"
          />
          <Flex alignItems="center" px={6} py={3} bg="gray.900">
            <Icon as={BsFillBriefcaseFill} h={6} w={6} color="white" />
            <Heading
              as="h2"
              mx={3}
              color="white"
              fontWeight="bold"
              fontSize="lg"
            >
              Internet identity (site)
            </Heading>
          </Flex>
          <Box py={4} px={6}>
            <Heading as="h3" fontSize="xl" fontWeight="bold" color="gray">
              Collaborator Name
            </Heading>
            <chakra.p py={2} color="gray.700">
              Full Stack maker & UI / UX Designer , love Video games, Author of
              LISA.
            </chakra.p>
            <Flex alignItems="center" mt={4} color="gray.700">
              <Icon as={AiFillGithub} h={6} w={6} mr={2} />
              <chakra.h1 px={2} fontSize="sm">
                CollaboratorDev_dev
              </chakra.h1>
            </Flex>
            <Flex alignItems="center" mt={4} color="gray.700">
              <Icon as={MdLocationOn} h={6} w={6} mr={2} />
              <chakra.h1 px={2} fontSize="sm">
                Paris, FRANCE
              </chakra.h1>
            </Flex>
            <Flex alignItems="center" mt={4} color="gray.700">
              <Icon as={MdEmail} h={6} w={6} mr={2} />
              <chakra.h1 px={2} fontSize="sm">
                Lisa@example.com
              </chakra.h1>
            </Flex>
          </Box>
        </Box>
      </Flex>
    </Fragment>
  );
};
