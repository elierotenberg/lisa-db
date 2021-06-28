import {
  Drawer,
  DrawerBody,
  DrawerFooter,
  DrawerHeader,
  DrawerOverlay,
  DrawerContent,
  DrawerCloseButton,
  Button,
  useDisclosure,
  Text,
  Link,
} from "@chakra-ui/react";
import React, { FunctionComponent } from "react";

export const SideBar: FunctionComponent = () => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const btnRef = React.useRef();

  return (
    <>
      <Button
        href={btnRef}
        colorScheme="teal"
        placement="right"
        onClick={onOpen}
      >
        Explore
      </Button>
      <Drawer isOpen={isOpen} placement="right" onClose={onClose}>
        <DrawerOverlay />
        <DrawerContent>
          <DrawerCloseButton />
          <DrawerHeader>Explore</DrawerHeader>

          <DrawerBody>
            <Text>
              <Link href="/en/domain-category/cognition/domain/cognition-1/guide/cognition-1-1">
                {` `}
                Guide // cognition
              </Link>
            </Text>
            {` `}
            <Text>
              <Link href="/en/domain-category/cognition/domain/cognition-1">
                {` `}
                domain // cognition
              </Link>
            </Text>
            {` `}
            <Text>
              <Link href="/en/domain-category/cognition">
                {` `}
                Category // Cognition
              </Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
            {` `}
            <Text>
              <Link to="/"> Placeholder</Link>
            </Text>
          </DrawerBody>

          <DrawerFooter>
            {/* <Button variant="outline" mr={3} onClick={onClose}>
              Cancel
            </Button>
            <Button colorScheme="blue">Save</Button> */}
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    </>
  );
};
