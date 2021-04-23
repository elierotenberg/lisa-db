import { ServerInfo } from "@directus/sdk";
import { GetStaticProps } from "next";
import { FunctionComponent } from "react";

import { getDirectusFromEnv } from "../lib/Directus";

type IndexPageProps = {
  readonly info: ServerInfo;
};

const IndexPage: FunctionComponent<IndexPageProps> = ({ info }) => (
  <div>{JSON.stringify(info)}</div>
);

export const getStaticProps: GetStaticProps<IndexPageProps> = async () => {
  const directus = await getDirectusFromEnv();
  const info = await directus.server.info();
  return {
    props: {
      info,
    },
  };
};

export default IndexPage;
