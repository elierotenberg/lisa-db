import { promises } from "fs";

import { Auth, google, sheets_v4 } from "googleapis";
import { check, isNotNull, isNotUndefined } from "typed-assert";
import { mapAsyncConcurrent } from "typed-utilities";

export const parseSpreadSheet = (
  value: sheets_v4.Schema$ValueRange,
): Record<string, unknown>[] => {
  isNotNull(value.values);
  isNotUndefined(value.values);
  const [head, ...rows] = value.values as unknown[][];
  return rows.map((row) =>
    head.reduce<Record<string, unknown>>(
      (prev: Record<string, unknown>, label, key) => ({
        ...prev,
        [`${label}`]: row[key],
      }),
      {},
    ),
  );
};

export const downloadSpreadsheetToJson = async (
  googleAuth: Auth.OAuth2Client,
  spreadsheetId: string,
  outFile: string,
): Promise<Record<string, unknown>> => {
  const sheets = google.sheets({ version: "v4", auth: googleAuth });

  const { data: spreadSheet } = await sheets.spreadsheets.get({
    spreadsheetId,
  });

  const items = await mapAsyncConcurrent(
    spreadSheet.sheets ?? [],
    async ({ properties }) => {
      if (!properties?.title) {
        return null;
      }
      const { title } = properties;
      const { data } = await sheets.spreadsheets.values.get({
        spreadsheetId,
        range: title,
      });
      return [title, parseSpreadSheet(data)] as const;
    },
  ).then((items) => items.filter(check(isNotNull)));

  const json = items.reduce<Record<string, unknown>>(
    (json, [key, value]) => ({ ...json, [key]: value }),
    {},
  );

  await promises.writeFile(outFile, JSON.stringify(json, null, 2), {
    encoding: "utf8",
  });

  return json;
};
