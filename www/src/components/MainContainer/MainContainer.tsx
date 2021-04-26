import { ContainerProps, Container, Box } from "@chakra-ui/react";
import React, { FunctionComponent } from "react";
import { SearchResults } from "../SearchResults/SearchResults";

type MainContainerProps = ContainerProps & {
  readonly searchQuery: string;
};

export const MainContainer: FunctionComponent<MainContainerProps> = ({
  searchQuery,
  children,
  ...props
}) => {
  return (
    <Container as="main" mb="1em" {...props}>
      <Box display={searchQuery.length === 0 ? "none" : undefined}>
        <SearchResults searchQuery={searchQuery} />
      </Box>
      <Box display={searchQuery.length > 0 ? "none" : undefined}>
        {children}
      </Box>
    </Container>
  );
};
