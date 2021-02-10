import { Heading, Image, Box, ListItem, UnorderedList } from "@chakra-ui/react";
import { MDXProvider as BaseMdxProvider, Components } from "@mdx-js/react";
import React, { FunctionComponent } from "react";
import { NavLink } from "../NavLink/NavLink";
const components: Components = {
  blockquote: ({ children }) => (
    <Box ml={2} bgColor="gray.100" py={2} px={4}>
      {children}
    </Box>
  ),
  h1: ({ children }) => (
    <Heading as="h1" size="xl" mt={5} mb={3}>
      {children}
    </Heading>
  ),
  h2: ({ children }) => (
    <Heading as="h2" size="lg" mt={5} mb={3}>
      {children}
    </Heading>
  ),
  h3: ({ children }) => (
    <Heading as="h3" size="md" mt={5} mb={3}>
      {children}
    </Heading>
  ),
  h4: ({ children }) => (
    <Heading as="h4" size="sm" mt={5} mb={3}>
      {children}
    </Heading>
  ),
  h5: ({ children }) => (
    <Heading as="h5" size="xs" mt={5} mb={3}>
      {children}
    </Heading>
  ),
  h6: ({ children }) => (
    <Heading as="h6" size="xs" mt={5} mb={3}>
      {children}
    </Heading>
  ),
  img: ({ src, alt }) => (
    <Image d="block" mx="auto" my="0.5em" src={src} alt={alt} />
  ),
  Image: ({ src, alt, maxWidth }) => (
    <Image
      src={src}
      alt={alt}
      d="block"
      mx="auto"
      my="0.5em"
      maxWidth={maxWidth}
    />
  ),
  p: ({ children }) => (
    <Box as="p" my={2}>
      {children}
    </Box>
  ),
  a: ({ href, ...props }) => <NavLink href={href as string} {...props} />,
  ul: (props) => <UnorderedList {...props} />,
  li: (props) => <ListItem {...props} />,
  wrapper: ({ children }) => (
    <Box fontSize="sm" textAlign="justify">
      {children}
    </Box>
  ),
};

export const MdxProvider: FunctionComponent = ({ children }) => (
  <BaseMdxProvider components={components}>{children}</BaseMdxProvider>
);
