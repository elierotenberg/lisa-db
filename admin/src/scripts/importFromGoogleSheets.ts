/* eslint-disable @typescript-eslint/naming-convention */
import { Auth, google } from "googleapis";
import { isOptionOfType, isString } from "typed-assert";
import { IDatabase } from "pg-promise";

import { parseSpreadSheet } from "../lib/Google";

const LISA_RESOURCES_SPREADSHEET_ID =
  "1kZuzvZgjqG9i3tQfRNPcF4ZwfMEZuHKIbWnTijAy3QY";

const GUIDES_REFERENCES_RANGE = "references!A:H";

export const importFromGoogleSheets = async (
  googleAuth: Auth.OAuth2Client,
  db: IDatabase<unknown>,
): Promise<void> => {
  const sheets = google.sheets({ version: "v4", auth: googleAuth });

  console.log("Fetching from Google Sheets");

  const guideReferences = await sheets.spreadsheets.values
    .get({
      spreadsheetId: LISA_RESOURCES_SPREADSHEET_ID,
      range: GUIDES_REFERENCES_RANGE,
    })
    .then(({ data }) => {
      const guideReferences = parseSpreadSheet(data);
      return guideReferences.map((guideReference) => {
        const {
          index: guide_reference_id,
          title,
          link,
          PubMedId: pub_med_id,
        } = guideReference;
        isString(guide_reference_id);
        isString(title);
        isString(link);
        isOptionOfType(pub_med_id, isString);
        return {
          guide_reference_id,
          title,
          link,
          pub_med_id: pub_med_id ? parseInt(pub_med_id) : null,
        };
      });
    });

  console.log(`Found ${guideReferences.length} guide_reference items`);

  console.log("Updating database");
  await db.tx((t) =>
    t.batch(
      guideReferences.map(({ guide_reference_id, title, link, pub_med_id }) =>
        t.query(
          `
              INSERT INTO guide_reference (
                guide_reference_id,
                title,
                link,
                pub_med_id
              ) VALUES (
                $1,
                $2,
                $3,
                $4
              ) ON CONFLICT (guide_reference_id) DO UPDATE SET
                title = $2,
                link = $3,
                pub_med_id = $4;
          `,
          [guide_reference_id, title, link, pub_med_id],
        ),
      ),
    ),
  );
  console.log("Database updated");
};
