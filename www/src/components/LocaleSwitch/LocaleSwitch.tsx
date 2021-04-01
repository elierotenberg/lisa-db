import { HStack, StackDivider } from "@chakra-ui/react";
import React, { FunctionComponent } from "react";

import { useRouter } from "next/router";
import translations from "../../content/translations.yml";
import { findTranslation } from "../../lib/Translation";
import { NavLink } from "../NavLink/NavLink";
import { translatePath } from "../../lib/Paths";
import { useGlobalContents } from "../../hooks/useGlobalContents";
import { locales } from "../../lib/Locales";

export const LocaleSwitch: FunctionComponent = () => {
  const contents = useGlobalContents();
  const { asPath } = useRouter();

  const localesMap = locales.map((locale) => ({
    locale,
    href: translatePath(asPath, locale, contents),
    label: findTranslation(locale, translations, "locales"),
  }));

  return (
    <HStack divider={<StackDivider />}>
      {localesMap?.map(({ locale, href, label }) => (
        <NavLink key={locale} href={href} locale={locale}>
          {label}
        </NavLink>
      ))}
    </HStack>
  );
};
