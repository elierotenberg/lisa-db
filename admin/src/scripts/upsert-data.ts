/* eslint-disable @typescript-eslint/naming-convention */
import { promises } from "fs";
import { join } from "path";

import { PoolClient } from "pg";
import { isArray, isOptionOfType, isRecord, isString } from "typed-assert";
import { mapAsyncConcurrent, resolveAllConcurrent } from "typed-utilities";

export const upsertAssessmentReferences = async (
  db: PoolClient,
  json: Record<string, unknown>,
): Promise<void> => {
  const assessmentReferencesJson = json["references"];
  isArray(assessmentReferencesJson);
  console.log(
    `Inserting ${assessmentReferencesJson.length} rows into assessment_reference...`,
  );
  await mapAsyncConcurrent(
    assessmentReferencesJson,
    async (assessmentReferenceJson) => {
      isRecord(assessmentReferenceJson);
      const {
        index: assessment_reference_id,
        title,
        link,
        PubMedId: pub_med_id,
      } = assessmentReferenceJson;
      isString(assessment_reference_id);
      isString(title);
      isOptionOfType(link, isString);
      isOptionOfType(pub_med_id, isString);
      await db.query({
        name: "upsert_assessment_reference",
        text: `
          INSERT INTO assessment_reference (
            assessment_reference_id,
            title,
            link,
            pub_med_id
          ) VALUES (
            $1,
            $2,
            $3,
            $4
          ) ON CONFLICT (assessment_reference_id) DO UPDATE SET
            title = $2,
            link = $3,
            pub_med_id = $4;
      `,
        values: [
          assessment_reference_id,
          title,
          link,
          pub_med_id ? parseInt(pub_med_id) : null,
        ],
      });
    },
  );
  console.log(
    `${assessmentReferencesJson.length} rows inserted into assessment_reference.`,
  );
};

export const upsertData = async (
  db: PoolClient,
  inFolder: string,
): Promise<void> => {
  const json = JSON.parse(
    await promises.readFile(join(inFolder, "resources.json"), {
      encoding: "utf8",
    }),
  );

  await db.query("BEGIN");

  await resolveAllConcurrent([upsertAssessmentReferences(db, json)]);

  await db.query("COMMIT");
};
