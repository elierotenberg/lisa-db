import { Box, Image, Flex, Heading, Link } from "@chakra-ui/react";
import React, { FunctionComponent } from "react";

export const PreviewCard: FunctionComponent = () => {
  return (
    <>
      <Box
        w="xs"
        mx="auto"
        bg="white"
        shadow="lg"
        rounded="lg"
        overflow="hidden"
      >
        <Link href="/">
          <Image
            w="xs"
            h={56}
            fit="cover"
            objectPosition="center"
            src="https://picsum.photos/seed/picsum/200/200"
            alt="Article Photos"
          />
          <Flex alignItems="center" px={6} py={3} bg="gray.900">
            <Heading
              as="h2"
              mx={3}
              color="white"
              fontWeight="bold"
              fontSize="lg"
            >
              Title of the Article: How to...
            </Heading>
          </Flex>
        </Link>
      </Box>
    </>
  );
};
