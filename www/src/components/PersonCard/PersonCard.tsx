import { Avatar, HStack, VStack, Tag, StackProps } from "@chakra-ui/react";
import React, { FunctionComponent } from "react";
import { useLocale } from "../../hooks/useLocale";
import { useLocaleContents } from "../../hooks/useLocaleContents";
import { Content, find } from "../../lib/Content/Content";
import { PersonMeta } from "../../lib/Content/PersonMeta";
import { to } from "../../lib/Paths";
import { NavLink } from "../NavLink/NavLink";

type PersonCardProps = StackProps & {
  readonly person: Content<PersonMeta>;
};

export const PersonCard: FunctionComponent<PersonCardProps> = ({
  person,
  ...props
}) => {
  const locale = useLocale();
  const localeContents = useLocaleContents();
  return (
    <HStack alignItems="center" spacing={4} {...props}>
      <Avatar name={person.meta.name} src={person.meta.picture_href} />
      <VStack alignItems="stretch">
        <NavLink href={to.person(locale, person.meta.slug)}>
          {person.meta.name}
        </NavLink>
        <HStack>
          {find.person
            .relatedInstitutions(localeContents, person.meta.person_id)
            .map((institution) => (
              <Tag key={institution.meta.institution_id} size="sm">
                <NavLink href={to.institution(locale, institution.meta.slug)}>
                  {institution.meta.name}
                </NavLink>
              </Tag>
            ))}
        </HStack>
      </VStack>
    </HStack>
  );
};
