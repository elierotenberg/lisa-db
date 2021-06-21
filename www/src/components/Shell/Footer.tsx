import { HStack } from "@chakra-ui/layout";
import React, { FunctionComponent } from "react";
import { Flex, Text } from "@chakra-ui/react";

const Footer: FunctionComponent = () => {
  return (
    <Flex
      bg="teal"
      width="100%"
      justifyContent="center"
      alignItems="center"
      direction="column"
      boxShadow="0 -1px 6px -1px rgba(0, 0, 0, 0.1)"
      padding="4"
    >
      <HStack spacing={8} mb={3}>
        <Text color="gray.400">Privacy</Text>
        <Text color="gray.400">Terms of Use</Text>
      </HStack>
      <Flex width="100%" justifyContent="center" wrap="wrap">
        <Text width="40%" textAlign="center" color="white" fontSize="sm">
          Last Login 03.06.2021 - 11:29 | Data last updated on 03.06.2021 -
          22:00
        </Text>
      </Flex>
    </Flex>
  );
};
export default Footer;
