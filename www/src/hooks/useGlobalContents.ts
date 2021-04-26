import { contents } from "../content/db";
import { Contents } from "../lib/Content/Content";

export const useGlobalContents = (): Contents => contents;
