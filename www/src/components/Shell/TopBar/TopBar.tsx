import React, { FunctionComponent } from "react";
import {
  Box,
  Stack,
  Heading,
  Flex,
  Button,
  useDisclosure,
  Text,
} from "@chakra-ui/react";
import { Link } from "react-router-dom";
import { HamburgerIcon } from "@chakra-ui/icons";

const TopBar: FunctionComponent<{
  readonly localeId: localeId;
}> = ({ localeId }) => {
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
    >
      <Flex align="center" mr={5}>
        <Heading as="h1" size="lg">
          L.I.S.A.
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
          <Link to={`/`}> Home</Link>
        </Text>

        <Text>
          <Link to={`/${localeId}/about`}> About</Link>
        </Text>

        <Text>
          <Link to={`/${localeId}/dashboard`}> ChildrenList</Link>
        </Text>
      </Stack>

      <Box
        display={{ base: isOpen ? `block` : `none`, md: `block` }}
        mt={{ base: 4, md: 0 }}
      >
        <Button
          variant="outline"
          _hover={{ bg: `teal.700`, borderColor: `teal.700` }}
        >
          <Link to={`/${localeId}/login`}> Sign In</Link>
        </Button>
        <Button
          variant="outline"
          _hover={{ bg: `teal.700`, borderColor: `teal.700` }}
        >
          <Link to={`/${localeId}/login`}> Sign Up</Link>
        </Button>
      </Box>
    </Flex>
  );
};

export default TopBar;
