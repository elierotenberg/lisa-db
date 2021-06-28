import { Box, Flex, Text, Avatar, Link } from "@chakra-ui/react";
import React, { FunctionComponent } from "react";

export const PersonPortrait: FunctionComponent = () => {
  return (
    <>
      <Link>
        <Flex m="3">
          <Avatar src="https://cdn4.iconfinder.com/data/icons/panda-2/512/lazy-panda-head-face-avatar-512.png" />
          <Box ml="3">
            <Text fontWeight="bold">
              FirstName Name
              {/* <Badge ml="1" colorScheme="green">
              New
            </Badge> */}
            </Text>
            <Text fontSize="sm">Profession</Text>
          </Box>
        </Flex>
      </Link>
    </>
  );
};
