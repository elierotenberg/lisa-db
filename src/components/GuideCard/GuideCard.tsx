import React, { FunctionComponent, useMemo } from "react";
import {
  StackProps,
  VStack,
  Heading,
  HStack,
  Tag,
  Text,
} from "@chakra-ui/react";
import { Content, find, getTitle } from "../../lib/Content/Content";
import { GuideMeta } from "../../lib/Content/GuideMeta";
import { useLocaleContents } from "../../hooks/useLocaleContents";
import { NavLink } from "../NavLink/NavLink";
import { useTranslation } from "../../hooks/useTranslation";
import { to } from "../../lib/Paths";
import { useLocale } from "../../hooks/useLocale";

type GuideCardProps = Omit<StackProps, "children"> & {
  readonly guide: Content<GuideMeta>;
};

export const GuideCard: FunctionComponent<GuideCardProps> = ({
  guide,
  ...props
}) => {
  const familiesLabel = useTranslation("audiences", "families");
  const teachersLabel = useTranslation("audiences", "teachers");
  const locale = useLocale();
  const localeContents = useLocaleContents();
  const relatedDomains = useMemo(
    () => find.guide.relatedDomains(localeContents, guide.meta.guide_id),
    [guide, localeContents]
  );

  return (
    <VStack {...props} alignItems="flex-start">
      <NavLink href={to.guide(locale, guide.meta.slug)}>
        <Heading as="h3" size="sm">
          {getTitle(guide.meta)}
        </Heading>
      </NavLink>
      <HStack pl={2}>
        {relatedDomains.map((domain) => (
          <Tag key={domain.meta.domain_id} size="sm">
            <NavLink href={to.domain(locale, domain.meta.slug)}>
              {domain.meta.name}
            </NavLink>
          </Tag>
        ))}
        {guide.meta.audiences.includes("families") && (
          <Tag size="sm">
            <NavLink href={to.audience(locale, "families")}>
              {familiesLabel}
            </NavLink>
          </Tag>
        )}
        {guide.meta.audiences.includes("teachers") && (
          <Tag size="sm">
            <NavLink href={to.audience(locale, "teachers")}>
              {teachersLabel}
            </NavLink>
          </Tag>
        )}
      </HStack>
      <Text color="gray.500" fontSize="sm">
        {guide.meta.abstract}
      </Text>
    </VStack>
  );
};
