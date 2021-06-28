import React, { FunctionComponent } from "react";
import {
  Box,
  Stack,
  Heading,
  Flex,
  useDisclosure,
  Text,
  Link,
} from "@chakra-ui/react";
import { HamburgerIcon } from "@chakra-ui/icons";

import { LocaleSwitch } from "./LocaleSwitch";

const TopBar: FunctionComponent = () => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  // eslint-disable-next-line @typescript-eslint/explicit-function-return-type
  const MenuToggle = () => (isOpen ? onClose() : onOpen());

  return (
    <Flex
      as="nav"
      align="center"
      justify="space-between"
      wrap="wrap"
      padding={6}
      bg="teal"
      color="white"
      position="fixed"
      width="100%"
      paddingBottom="1.5"
      zIndex="sticky"
    >
      <Flex align="center" mr={5}>
        <Heading as="h1" size="lg">
          <Link href="/"> L.I.S.A.</Link>
        </Heading>
      </Flex>
      <Box display={{ base: `block`, md: `none` }} onClick={MenuToggle}>
        <HamburgerIcon />
      </Box>

      <Stack
        direction={{ base: `column`, md: `row` }}
        display={{ base: isOpen ? `block` : `none`, md: `flex` }}
        width={{ base: `full`, md: `auto` }}
        alignItems="center"
        flexGrow={1}
        mt={{ base: 4, md: 0 }}
      >
        <Text>
          <Link href="/"> Home</Link>
        </Text>

        <Text>
          <Link href="/en/about"> About us</Link>
        </Text>
      </Stack>

      <Box
        display={{ base: isOpen ? `block` : `none`, md: `block` }}
        mt={{ base: 4, md: 0 }}
      >
        <LocaleSwitch />
      </Box>
    </Flex>
  );
};

export default TopBar;
