import {
  Container,
  Heading,
  HStack,
  Input,
  InputGroup,
  Text,
  VStack,
} from "@chakra-ui/react";
import React, { FunctionComponent } from "react";
import { useLocale } from "../../hooks/useLocale";
import { useTranslation } from "../../hooks/useTranslation";
import { to } from "../../lib/Paths";
import { LocaleSwitch } from "../LocaleSwitch/LocaleSwitch";
import { NavLink } from "../NavLink/NavLink";

type MainNavBarProps = {
  readonly searchQuery: string;
  readonly setSearchQuery: (update: (searchQuery: string) => string) => void;
};

export const MainNavBar: FunctionComponent<MainNavBarProps> = ({
  searchQuery,
  setSearchQuery,
}) => {
  const locale = useLocale();
  const lisaDbLabel = useTranslation("lisa_db");
  const lisaDbHeadlineLabel = useTranslation("lisa_db_headline");
  const searchOnLisaDbLabel = useTranslation("search_lisa_db");
  const guidesLabel = useTranslation("guides");
  const domainsLabel = useTranslation("domains");
  const teachersLabel = useTranslation("audiences", "teachers");
  const familiesLabel = useTranslation("audiences", "families");
  return (
    <Container alignItems="center" justifyContent="center" my="1em">
      <VStack spacing={2}>
        <LocaleSwitch />
        <NavLink
          href={to.home(locale)}
          textDecoration="none"
          _hover={{ textDecoration: "none" }}
        >
          <Heading as="h1" size="3xl">
            {lisaDbLabel}
          </Heading>
        </NavLink>
        <Text as="em">{lisaDbHeadlineLabel}</Text>
        <InputGroup size="md">
          <Input
            placeholder={searchOnLisaDbLabel}
            value={searchQuery}
            onChange={(event) => setSearchQuery(() => event.target.value)}
          />
        </InputGroup>
        <HStack spacing={4}>
          <NavLink href={to.guides(locale)}>{guidesLabel}</NavLink>
          <NavLink href={to.domains(locale)}>{domainsLabel}</NavLink>
          <NavLink href={to.audience(locale, "teachers")}>
            {teachersLabel}
          </NavLink>
          <NavLink href={to.audience(locale, "families")}>
            {familiesLabel}
          </NavLink>
        </HStack>
      </VStack>
    </Container>
  );
};
