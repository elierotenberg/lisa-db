import { promises } from "fs";
import { join } from "path";

import { mapAsyncConcurrent } from "typed-utilities";

export const SPREADSHEETS = {
  resources: "1LeLlrsvBWMYTTIXTVtkynmBzzb0Uzi1OwpRLfyRAwzM",
  states: "11OkIWLwZYi9xkpuFODAKXQZHEFeMvYCQ8BTfIBKm0Z8",
  disorders: "13a0w3ouXq5sFCa0fBsg9xhWx67RGJJJqLjD_Oy1c3b0",
  assessments: "1VUf3XnieYThY8OA6JWtpNP4zI2xa9xak9LXuyH_PaoE",
} as const;

type SpreadSheetKey = keyof typeof SPREADSHEETS;

export type SpreadSheetJson = Record<SpreadSheetKey, unknown>;

export const loadSpreadSheetsFromJson = async (
  inFolder: string,
): Promise<SpreadSheetJson> => {
  const json = await mapAsyncConcurrent(
    Object.keys(SPREADSHEETS) as readonly SpreadSheetKey[],
    async (key) =>
      [
        key,
        JSON.parse(
          await promises.readFile(join(inFolder, `${key}.json`), {
            encoding: "utf8",
          }),
        ) as unknown,
      ] as const,
  );
  return json.reduce(
    (obj, [key, value]) => ({ ...obj, [key]: value }),
    {} as SpreadSheetJson,
  );
};
