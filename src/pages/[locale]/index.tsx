import React, { Fragment, FunctionComponent } from "react";
import Head from "next/head";
import { GetStaticProps, GetStaticPaths } from "next";
import { locales } from "../../lib/Locales";

const IndexPage: FunctionComponent = () => {
  return (
    <Fragment>
      <Head>
        <title>LISA</title>
      </Head>
    </Fragment>
  );
};
export const getStaticProps: GetStaticProps = async () => ({ props: {} });

export const getStaticPaths: GetStaticPaths = async () => ({
  paths: locales.map((locale) => ({ params: { locale } })),
  fallback: false,
});

export default IndexPage;
