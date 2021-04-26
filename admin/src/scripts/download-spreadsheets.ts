import { join } from "path";

import { Auth } from "googleapis";
import { mapAsyncConcurrent } from "typed-utilities";

import { downloadSpreadsheetToJson } from "../lib/GoogleSheets";
import { SPREADSHEETS } from "../lib/Resources";

export const downloadSpreadSheets = async (
  googleAuth: Auth.OAuth2Client,
  outFolder: string,
): Promise<void> => {
  await mapAsyncConcurrent(
    Object.entries(SPREADSHEETS),
    async ([name, spreadSheetId]) => {
      const outFile = join(outFolder, `${name}.json`);
      const json = await downloadSpreadsheetToJson(
        googleAuth,
        spreadSheetId,
        outFile,
      );
      console.log(`${name}:`);
      console.group();
      for (const [key, value] of Object.entries(json)) {
        if (Array.isArray(value)) {
          console.log(`${key}: ${value.length}`);
        }
      }
      console.groupEnd();
    },
  );
};
