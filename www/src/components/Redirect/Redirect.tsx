import { useRouter } from "next/router";
import React, {
  Fragment,
  FunctionComponent,
  ReactNode,
  useEffect,
} from "react";

type RedirectProps = {
  readonly href: string;
  readonly as?: string;
  readonly locale?: string;
  readonly children?: ReactNode;
};

export const Redirect: FunctionComponent<RedirectProps> = ({
  href,
  as,
  locale,
  children,
}) => {
  const { push } = useRouter();

  useEffect(() => {
    push(href, as, { locale });
  }, [href]);

  return <Fragment>{children}</Fragment>;
};
