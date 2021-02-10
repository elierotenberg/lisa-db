import React, { Fragment, FunctionComponent } from "react";
import Head from "next/head";
import { Redirect } from "../components/Redirect/Redirect";
import { to } from "../lib/Paths";
import { defaultLocale } from "../lib/Locales";

const IndexPage: FunctionComponent = () => {
  return (
    <Fragment>
      <Head>
        <title>LISA</title>
      </Head>
      <Redirect href={to.locale(defaultLocale)} />
    </Fragment>
  );
};

export default IndexPage;
