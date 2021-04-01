import { Heading, HeadingProps } from "@chakra-ui/react";
import React, { FunctionComponent } from "react";
export const SectionTitle: FunctionComponent<HeadingProps> = (props) => (
  <Heading as="h3" size="md" my="0.4em" fontWeight="bold" {...props} />
);
