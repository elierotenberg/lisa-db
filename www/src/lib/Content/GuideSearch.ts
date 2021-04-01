import Fuse from "fuse.js";
import { Content, Contents } from "./Content";
import { GuideMeta } from "./GuideMeta";

type GuideSearch = {
  guide: Content<GuideMeta>;
  relatedDomainNames: string[];
};

export const fuseOptions: Fuse.IFuseOptions<GuideSearch> = {
  includeScore: true,
  keys: [
    {
      name: "guide.raw",
      weight: 0.01,
    },
    {
      name: "guide.meta.name",
      weight: 1,
    },
    {
      name: "relatedDomainNames",
      weight: 0.3,
    },
  ],
};

export const getGuideSearch = (
  guide: Content<GuideMeta>,
  contents: Contents
): GuideSearch => {
  return {
    guide,
    relatedDomainNames: contents.domains
      .filter((domain) =>
        guide.meta.domains
          .map((domain) => domain.domain_id)
          .includes(domain.meta.domain_id)
      )
      .map((domain) => domain.meta.name),
  };
};
