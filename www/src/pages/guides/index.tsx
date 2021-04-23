import { PartialItem } from "@directus/sdk";
import { GetStaticProps } from "next";
import { FunctionComponent } from "react";

import { Guide } from "../../../directus";
import { getDirectusFromEnv } from "../../lib/Directus";

type GuidesIndexPageProps = {
  readonly guides: PartialItem<Guide>[];
};

const GuidesIndexPage: FunctionComponent<GuidesIndexPageProps> = ({
  guides,
}) => <div>{JSON.stringify(guides, null, 2)}</div>;

export const getStaticProps: GetStaticProps<GuidesIndexPageProps> = async () => {
  const directus = await getDirectusFromEnv();

  return {
    props: {
      guides: (await directus.items(`guides`).readMany()).data,
    },
  };
};

export default GuidesIndexPage;
