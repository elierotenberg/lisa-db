import React, { FunctionComponent, useMemo } from "react";
import Fuse from "fuse.js";
import { HStack, CircularProgress, VStack } from "@chakra-ui/react";
import { useLocaleContents } from "../../hooks/useLocaleContents";
import { fuseOptions, getGuideSearch } from "../../lib/Content/GuideSearch";
import { GuideCard } from "../GuideCard/GuideCard";

type SearchResultsProps = {
  readonly searchQuery: string;
};

export const SearchResults: FunctionComponent<SearchResultsProps> = ({
  searchQuery,
}) => {
  const contents = useLocaleContents();
  const fuse = useMemo(
    () =>
      new Fuse(
        contents.guides.map((guide) => getGuideSearch(guide, contents)),
        fuseOptions
      ),
    [contents]
  );
  const results = useMemo(
    () =>
      fuse.search(searchQuery).sort((a, b) => (b.score ?? 0) - (a.score ?? 0)),
    [fuse, searchQuery]
  );

  return (
    <VStack spacing={5} alignItems="stretch">
      {results.map(({ item, refIndex, score }) => (
        <HStack key={refIndex}>
          <GuideCard guide={item.guide} flex={1} />
          <CircularProgress
            value={100 * (score ?? 0)}
            size={8}
          ></CircularProgress>
        </HStack>
      ))}
    </VStack>
  );
};
