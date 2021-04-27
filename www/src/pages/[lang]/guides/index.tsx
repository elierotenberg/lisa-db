import { GetStaticProps } from "next";
import { FunctionComponent } from "react";
import { resolveAllConcurrent } from "typed-utilities";

import {
  Guide,
  GuideAudience,
  GuideAuthor,
  GuideGuideType,
  GuideType,
} from "../../../../directus";
import {
  extractDataAsNonPartialMany,
  getDirectusFromEnv,
} from "../../../lib/Directus";

type GuidesIndexPageProps = {
  readonly guides: Guide[];
  readonly guideAudiences: GuideAudience[];
  readonly guideAuthors: GuideAuthor[];
  readonly guideGuideTypes: GuideGuideType[];
  readonly guideTypes: GuideType[];
};

const GuidesIndexPage: FunctionComponent<GuidesIndexPageProps> = ({
  guides,
}) => <pre>{JSON.stringify(guides, null, 2)}</pre>;

export const getStaticProps: GetStaticProps<GuidesIndexPageProps> = async () => {
  const directus = await getDirectusFromEnv();

  const [
    guides,
    guideAudiences,
    guideAuthors,
    guideGuideTypes,
    guideTypes,
  ] = await resolveAllConcurrent([
    directus.items(`guide`).readMany().then(extractDataAsNonPartialMany),
    directus
      .items(`guide_audience`)
      .readMany()
      .then(extractDataAsNonPartialMany),
    directus.items(`guide_author`).readMany().then(extractDataAsNonPartialMany),
    directus
      .items(`guide_guide_type`)
      .readMany()
      .then(extractDataAsNonPartialMany),
    directus.items(`guide_type`).readMany().then(extractDataAsNonPartialMany),
  ]);

  return {
    props: {
      guides,
      guideAudiences,
      guideAuthors,
      guideGuideTypes,
      guideTypes,
    },
  };
};

export default GuidesIndexPage;
