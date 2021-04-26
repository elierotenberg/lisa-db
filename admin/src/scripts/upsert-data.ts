/* eslint-disable @typescript-eslint/naming-convention */
import { PoolClient } from "pg";
import {
  check,
  isArray,
  isNotNull,
  isOptionOfType,
  isRecord,
  isString,
} from "typed-assert";

import { loadSpreadSheetsFromJson, SpreadSheetJson } from "../lib/Resources";
import { extractNames } from "../lib/helpers";

// Disorders
export const upsertDisorderSubcategory = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { disorders } = json;
  isRecord(disorders);
  const disorderSubcategoriesJson = disorders["disorder_subcategories"];
  isArray(disorderSubcategoriesJson);
  console.log(
    `Inserting ${disorderSubcategoriesJson.length} rows into disorder_subcategory...`,
  );
  for (const disorderSubcategoryJson of disorderSubcategoriesJson) {
    isRecord(disorderSubcategoryJson);
    const {
      index: disorder_subcategory_id,
      disorder_subcategory: name,
    } = disorderSubcategoryJson;
    isString(disorder_subcategory_id);
    isString(name);
    await db.query({
      name: "upsert_disorder_subcategory",
      text: `
        INSERT INTO disorder_subcategory (
          disorder_subcategory_id,
          name
        ) VALUES (
          $1,
          $2
        ) ON CONFLICT (disorder_subcategory_id) DO UPDATE SET
          name = $2;
    `,
      values: [disorder_subcategory_id, name],
    });
  }
  console.log(
    `${disorderSubcategoriesJson.length} rows inserted into disorder_subcategory.`,
  );
};

export const upsertDisorderCategory = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { disorders } = json;
  isRecord(disorders);
  const disorderCategoriesJson = disorders["disorder_categories"];
  isArray(disorderCategoriesJson);
  console.log(
    `Inserting ${disorderCategoriesJson.length} rows into disorder_category...`,
  );
  for (const disorderCategoryJson of disorderCategoriesJson) {
    isRecord(disorderCategoryJson);
    const {
      index: disorder_category_id,
      disorder_category: name,
    } = disorderCategoryJson;
    isString(disorder_category_id);
    isString(name);
    await db.query({
      name: "upsert_disorder_category",
      text: `
          INSERT INTO disorder_category (
            disorder_category_id,
            name
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (disorder_category_id) DO UPDATE SET
            name = $2;
      `,
      values: [disorder_category_id, name],
    });
  }
  console.log(
    `${disorderCategoriesJson.length} rows inserted into disorder_category.`,
  );
};

export const upsertDisorder = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { disorders } = json;
  isRecord(disorders);
  const disordersJson = disorders["disorders"];
  isArray(disordersJson);
  console.log(`Inserting ${disordersJson.length} rows into disorder...`);
  for (const disorderJson of disordersJson) {
    isRecord(disorderJson);
    const {
      index: disorder_id,
      index_disorder_category: disorder_category_id,
      index_disorder_subcategory: disorder_subcategory_id,
      disorder: name,
      ICD9CM: icd_9_cm,
      ICD10CM: icd_10_cm,
    } = disorderJson;
    isString(disorder_id);
    isString(disorder_category_id);
    isString(disorder_subcategory_id);
    isString(name);
    isOptionOfType(icd_9_cm, isString);
    isOptionOfType(icd_10_cm, isString);
    try {
      await db.query({
        name: "upsert_disorder",
        text: `
            INSERT INTO disorder (
              disorder_id,
              disorder_category_id,
              disorder_subcategory_id,
              name,
              icd_9_cm,
              icd_10_cm
            ) VALUES (
              $1,
              $2,
              $3,
              $4,
              $5,
              $6
            ) ON CONFLICT (disorder_id) DO UPDATE SET
            disorder_category_id = $2,
            disorder_subcategory_id = $3,
            name = $4,
            icd_9_cm = $5,
            icd_10_cm = $6;
        `,
        values: [
          disorder_id,
          disorder_category_id.length > 0 ? disorder_category_id : null,
          disorder_subcategory_id.length > 0 ? disorder_subcategory_id : null,
          name,
          icd_9_cm && icd_9_cm.length > 0 ? icd_9_cm : null,
          icd_10_cm && icd_10_cm.length > 0 ? icd_10_cm : null,
        ],
      });
    } catch (error) {
      console.error(disorderJson);
      throw error;
    }
  }
  console.log(`${disordersJson.length} rows inserted into disorder.`);
};

export const upsertDisorderReference = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { disorders } = json;
  isRecord(disorders);
  const disorderReferencesJson = disorders["references"];
  isArray(disorderReferencesJson);
  console.log(
    `Inserting ${disorderReferencesJson.length} rows into disorder_reference...`,
  );
  for (const disorderReferenceJson of disorderReferencesJson) {
    isRecord(disorderReferenceJson);
    const { index: disorder_reference_id, title } = disorderReferenceJson;
    isString(disorder_reference_id);
    isString(title);
    await db.query({
      name: "upsert_disorder_reference",
      text: `
          INSERT INTO disorder_reference (
            disorder_reference_id,
            title
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (disorder_reference_id) DO UPDATE SET
            title = $2;
      `,
      values: [disorder_reference_id, title],
    });
  }
  console.log(
    `${disorderReferencesJson.length} rows inserted into disorder_reference.`,
  );
};

// thoughts in my attempt:
// split each fillings cell by ","
// put each part (seperated name) into the table of neutral construct
// [there are some fillings with question mark??, should we keep it?]
// if keep it: nothing to do （confirmed to keep it for now）
// if not: use regular expression to replace (/\W\s??//g => '///$&')
// then, like we have done in author, we fill multiple fillings into the sign_symptom_id

export const upsertNeutralConstruct = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { disorders } = json;
  isRecord(disorders);
  const neutralConstructsJson = disorders["signs_symptoms"];
  isArray(neutralConstructsJson);
  console.log(
    `Inserting ${neutralConstructsJson.length} rows into neutral_construct...`,
  );

  for (const neutralConstructJson of neutralConstructsJson) {
    isRecord(neutralConstructJson);
    const {
      ["neutral constructs/states"]: names_string,
      index: sign_symptom_id,
    } = neutralConstructJson;
    isString(sign_symptom_id);
    isOptionOfType(names_string, isString);
    const names = (names_string ?? "")
      .split(",")
      .map((name) => name.trim())
      .map((name) => (name.length > 0 ? name : null))
      .filter(check(isNotNull));
    for (const name of names) {
      await db.query({
        name: "upsert_neutral_construct",
        text: `
          INSERT INTO neutral_construct (
            name
          ) VALUES (
            $1
          ) ON CONFLICT (name) DO NOTHING;
      `,
        values: [name],
      });
      await db.query({
        name: "upsert_sign_symptom_neutral_construct",
        text: `
          INSERT INTO sign_symptom_neutral_construct (
            name,
            sign_symptom_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (sign_symptom_id,name) DO NOTHING;
      `,
        values: [
          name,
          sign_symptom_id && sign_symptom_id.length > 0
            ? parseInt(sign_symptom_id)
            : null,
        ],
      });
    }
  }
  console.log(
    `${neutralConstructsJson.length} rows of neutral_constructs inserted into sign_symptom_neutral_construct ...`,
  );
};

export const upsertSignSymptom = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { disorders } = json;
  isRecord(disorders);
  const signSymptomsJson = disorders["signs_symptoms"];
  isArray(signSymptomsJson);
  console.log(`Inserting ${signSymptomsJson.length} rows into sign_symptom...`);
  for (const signSymptomJson of signSymptomsJson) {
    isRecord(signSymptomJson);
    const {
      index: sign_symptom_id,
      sign_symptom: name,
      ["underlying_behavior/phrase"]: underlying_behavior,
      index_reference: disorder_reference_id,
      indices_disorder: disorder_ids_string,
      //["neutral constructs/states"]: neutral_construct,
    } = signSymptomJson;
    isString(sign_symptom_id);
    isString(name);
    isOptionOfType(underlying_behavior, isString);
    isString(disorder_reference_id);
    isString(disorder_ids_string);
    const disorder_ids = disorder_ids_string
      .split(",")
      .map((disorder_id) => disorder_id.trim())
      .map((disorder_id) =>
        disorder_id.length > 0 ? parseInt(disorder_id) : null,
      )
      .filter(check(isNotNull));
    await db.query({
      name: "upsert_sign_symptom",
      text: `
          INSERT INTO sign_symptom (
            sign_symptom_id,
            name,
            underlying_behavior,
            disorder_reference_id
          ) VALUES (
            $1,
            $2,
            $3,
            $4
          ) ON CONFLICT (sign_symptom_id) DO UPDATE SET
          name = $2,
          underlying_behavior = $3,
          disorder_reference_id = $4;
      `,
      values: [
        sign_symptom_id,
        name,
        underlying_behavior && underlying_behavior.length > 0
          ? underlying_behavior
          : null,
        disorder_reference_id,
      ],
    });
    for (const disorder_id of disorder_ids) {
      await db.query({
        name: "upsert_sign_symptom_disorder",
        text: `
          INSERT INTO disorder_sign_symptom (
            sign_symptom_id,
            disorder_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (sign_symptom_id, disorder_id) DO NOTHING;
        `,
        values: [sign_symptom_id, disorder_id],
      });
    }
  }
  console.log(
    `${signSymptomsJson.length} rows inserted into sign_symptom, disorder_sign_symptom`,
  );
};

export const upsertSignSymptomExample = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { disorders } = json;
  isRecord(disorders);
  const signSymptomExamplesJson = disorders["examples_signs_symptoms"];
  isArray(signSymptomExamplesJson);
  console.log(
    `Inserting ${signSymptomExamplesJson.length} rows into sign_symptom_example...`,
  );
  for (const signSymptomExampleJson of signSymptomExamplesJson) {
    isRecord(signSymptomExampleJson);
    const {
      index: sign_symptom_example_id,
      example_sign_symptom: name,
      indices_sign_symptom: sign_symptom_ids_string,
    } = signSymptomExampleJson;
    isString(sign_symptom_example_id);
    isString(name);
    isString(sign_symptom_ids_string);
    const sign_symptom_ids = sign_symptom_ids_string
      .split(",")
      .map((sign_symptom_id) => sign_symptom_id.trim())
      .map((sign_symptom_id) =>
        sign_symptom_id.length > 0 ? parseInt(sign_symptom_id) : null,
      )
      .filter(check(isNotNull));
    await db.query({
      name: "upsert_sign_symptom_example",
      text: `
        INSERT INTO sign_symptom_example (
          sign_symptom_example_id,
          name
        ) VALUES (
          $1,
          $2
        ) ON CONFLICT (sign_symptom_example_id) DO UPDATE SET
        name = $2;
    `,
      values: [sign_symptom_example_id, name],
    });
    for (const sign_symptom_id of sign_symptom_ids) {
      await db.query({
        name: "upsert_sign_symptom_with_example",
        text: `
          INSERT INTO sign_symptom_with_example (
            sign_symptom_id,
            sign_symptom_example_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (sign_symptom_id, sign_symptom_example_id) DO NOTHING;
        `,
        values: [sign_symptom_id, sign_symptom_example_id],
      });
    }
  }
  console.log(
    `${signSymptomExamplesJson.length} rows inserted into sign_symptom_example,sign_symptom_with_example `,
  );
};

// Assessment
export const upsertAssessmentReference = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { assessments } = json;
  isRecord(assessments);
  const assessmentReferencesJson = assessments["references"];
  isArray(assessmentReferencesJson);
  console.log(
    `Inserting ${assessmentReferencesJson.length} rows into assessment_reference...`,
  );
  for (const assessmentReferenceJson of assessmentReferencesJson) {
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
        assessment_reference_id ? parseInt(assessment_reference_id) : null,
        title,
        link,
        pub_med_id ? parseInt(pub_med_id) : null,
      ],
    });
  }
  console.log(
    `${assessmentReferencesJson.length} rows inserted into assessment_reference.`,
  );
};

// Resource
export const upsertResourcePeopleAudience = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  isRecord(resources);
  const resourcePeopleAudiencesJson = resources["people"];
  isArray(resourcePeopleAudiencesJson);
  console.log(
    `Inserting ${resourcePeopleAudiencesJson.length} rows into resource_people_audience...`,
  );
  for (const resourcePeopleAudienceJson of resourcePeopleAudiencesJson) {
    isRecord(resourcePeopleAudienceJson);
    const { index: audience_id, person } = resourcePeopleAudienceJson;
    isString(audience_id);
    isString(person);
    await db.query({
      name: "upsert_resource_people_audience",
      text: `
          INSERT INTO resource_people_audience(
            audience_id,
            person
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (audience_id) DO UPDATE SET
          person = $2;
      `,
      values: [audience_id, person],
    });
  }
  console.log(
    `${resourcePeopleAudiencesJson.length} rows inserted into resource_people_audience.`,
  );
};

export const upsertLanguageSource = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  isRecord(resources);
  const languagesourcesJson = resources["languages"];
  isArray(languagesourcesJson);
  console.log(
    `Inserting ${languagesourcesJson.length} rows into language_source...`,
  );
  for (const languagesourceJson of languagesourcesJson) {
    isRecord(languagesourceJson);
    const { index: language_source_id, language: name } = languagesourceJson;
    isString(language_source_id);
    isOptionOfType(name, isString);
    await db.query({
      name: "upsert_language_source",
      text: `
        INSERT INTO language_source (
          language_source_id,
          name
        ) VALUES (
          $1,
          $2
        ) ON CONFLICT (language_source_id) DO UPDATE SET
          name = $2;
    `,
      values: [language_source_id, name],
    });
  }
  console.log(
    `${languagesourcesJson.length} rows inserted into language_source.`,
  );
};

// Missing [behaviour/domain/states many to many because it's empty now]
export const upsertQuestionnaire = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { assessments } = json;
  isRecord(assessments);
  const assessmentQuestionnairesJson = assessments["questionnaires"];
  isArray(assessmentQuestionnairesJson);
  console.log(
    `Inserting ${assessmentQuestionnairesJson.length} rows into questionnaire...`,
  );
  for (const assessmentQuestionnaireJson of assessmentQuestionnairesJson) {
    isRecord(assessmentQuestionnaireJson);
    const {
      index: questionnaire_id,
      title,
      link,
      description,
      abbreviation,
      age_max,
      age_min,
      number_of_questions,
      minutes_to_complete,
      index_license: license_id,
      index_language: language_source_id,
      indices_disorder: disorder_ids_string,
      indices_disorder_category: disorder_category_ids_string,
      index_sign_symptom: sign_symptom_ids_string,
      indices_respondent: respondent_ids_string,
      indices_subject: subject_ids_string,
      indices_reference: assessment_reference_ids_string,
      indices_language_not_in_mhdb: language_source_ids_string,
      ["behaviours/states/domains"]: behaviour_ids_string,
    } = assessmentQuestionnaireJson;
    isString(questionnaire_id);
    isString(title);
    isOptionOfType(link, isString);
    isString(description);
    isString(abbreviation);
    isString(age_max);
    isString(age_min);
    isString(number_of_questions);
    isString(minutes_to_complete);
    isString(license_id);
    isString(language_source_id);
    isString(disorder_ids_string);
    const disorder_ids = disorder_ids_string
      .split(",")
      .map((disorder_id) => disorder_id.trim())
      .map((disorder_id) =>
        disorder_id.length > 0 ? parseInt(disorder_id) : null,
      )
      .filter(check(isNotNull));
    isString(disorder_category_ids_string);
    const disorder_category_ids = disorder_category_ids_string
      .split(",")
      .map((disorder_category_id) => disorder_category_id.trim())
      .map((disorder_category_id) =>
        disorder_category_id.length > 0 ? parseInt(disorder_category_id) : null,
      )
      .filter(check(isNotNull));
    isString(sign_symptom_ids_string);
    const sign_symptom_ids = sign_symptom_ids_string
      .split(",")
      .map((sign_symptom_id) => sign_symptom_id.trim())
      .map((sign_symptom_id) =>
        sign_symptom_id.length > 0 ? parseInt(sign_symptom_id) : null,
      )
      .filter(check(isNotNull));
    isString(respondent_ids_string);
    const respondent_ids = respondent_ids_string
      .split(",")
      .map((respondent_id) => respondent_id.trim())
      .map((respondent_id) =>
        respondent_id.length > 0 ? parseInt(respondent_id) : null,
      )
      .filter(check(isNotNull));
    isString(subject_ids_string);
    const subject_ids = subject_ids_string
      .split(",")
      .map((subject_id) => subject_id.trim())
      .map((subject_id) =>
        subject_id.length > 0 ? parseInt(subject_id) : null,
      )
      .filter(check(isNotNull));
    isString(assessment_reference_ids_string);
    const assessment_reference_ids = assessment_reference_ids_string
      .split(",")
      .map((assessment_reference_id) => assessment_reference_id.trim())
      .map((assessment_reference_id) =>
        assessment_reference_id.length > 0
          ? parseInt(assessment_reference_id)
          : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(language_source_ids_string, isString);
    const language_source_ids = (language_source_ids_string ?? "")
      .split(",")
      .map((language_source_id) => language_source_id.trim())
      .map((language_source_id) =>
        language_source_id.length > 0 ? parseInt(language_source_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(behaviour_ids_string, isString);
    const behaviour_ids = (behaviour_ids_string ?? "")
      .split(",")
      .map((behaviour_id) => behaviour_id.trim())
      .map((behaviour_id) =>
        behaviour_id.length > 0 ? parseInt(behaviour_id) : null,
      )
      .filter(check(isNotNull));
    try {
      await db.query({
        name: "upsert_questionnaire",
        text: `
          INSERT INTO questionnaire (
            questionnaire_id,
            title,
            link,
            description,
            abbreviation,
            age_max,
            age_min,
            number_of_questions,
            minutes_to_complete,
            license_id,
            language_source_id
          ) VALUES (
            $1,
            $2,
            $3,
            $4,
            $5,
            $6,
            $7,
            $8,
            $9,
            $10,
            $11
          ) ON CONFLICT (questionnaire_id) DO UPDATE SET
          title = $2,
          link = $3,
          description = $4,
          abbreviation = $5,
          age_max = $6,
          age_min = $7,
          number_of_questions = $8,
          minutes_to_complete = $9,
          license_id = $10,
          language_source_id =$11;
      `,
        values: [
          questionnaire_id,
          title,
          link,
          description,
          abbreviation,
          age_max && age_max.length > 0 ? parseInt(age_max) : null,
          age_min && age_min.length > 0 ? parseInt(age_min) : null,
          number_of_questions && number_of_questions.length > 0
            ? parseInt(number_of_questions)
            : null,
          minutes_to_complete && minutes_to_complete.length > 0
            ? minutes_to_complete
            : null,
          license_id,
          language_source_id,
        ],
      });
      for (const disorder_id of disorder_ids) {
        await db.query({
          name: "upsert_questionnaire_disorder",
          text: `
            INSERT INTO questionnaire_disorder (
              questionnaire_id,
              disorder_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (questionnaire_id, disorder_id) DO NOTHING;
          `,
          values: [questionnaire_id, disorder_id],
        });
      }
      for (const disorder_category_id of disorder_category_ids) {
        await db.query({
          name: "upsert_questionnaire_disorder_category",
          text: `
            INSERT INTO questionnaire_disorder_category (
              questionnaire_id,
              disorder_category_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (questionnaire_id, disorder_category_id) DO NOTHING;
          `,
          values: [questionnaire_id, disorder_category_id],
        });
      }
      for (const sign_symptom_id of sign_symptom_ids) {
        await db.query({
          name: "upsert_questionnaire_sign_symptom",
          text: `
            INSERT INTO questionnaire_sign_symptom (
              sign_symptom_id,
              questionnaire_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (sign_symptom_id, questionnaire_id) DO NOTHING;
          `,
          values: [sign_symptom_id, questionnaire_id],
        });
      }
      for (const respondent_id of respondent_ids) {
        await db.query({
          name: "upsert_questionnaire_respondent",
          text: `
            INSERT INTO questionnaire_respondent (
              questionnaire_id,
              respondent_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (questionnaire_id, respondent_id) DO NOTHING;
          `,
          values: [questionnaire_id, respondent_id],
        });
      }
      for (const subject_id of subject_ids) {
        await db.query({
          name: "upsert_questionnaire_subject",
          text: `
            INSERT INTO questionnaire_subject (
              questionnaire_id,
              subject_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (questionnaire_id, subject_id) DO NOTHING;
          `,
          values: [questionnaire_id, subject_id],
        });
      }
      for (const assessment_reference_id of assessment_reference_ids) {
        await db.query({
          name: "upsert_questionnaire_assessment_reference",
          text: `
            INSERT INTO questionnaire_assessment_reference (
              questionnaire_id,
              assessment_reference_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (questionnaire_id, assessment_reference_id) DO NOTHING;
          `,
          values: [questionnaire_id, assessment_reference_id],
        });
      }
      for (const language_source_id of language_source_ids) {
        await db.query({
          name: "upsert_questionnaire_language_not_mhdb",
          text: `
            INSERT INTO questionnaire_language_not_mhdb (
              questionnaire_id,
              language_source_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (questionnaire_id, language_source_id) DO NOTHING;
          `,
          values: [questionnaire_id, language_source_id],
        });
      }
      for (const behaviour_id of behaviour_ids) {
        await db.query({
          name: "upsert_behaviour_questionnaire",
          text: `
            INSERT INTO behaviour_questionnaire (
              behaviour_id,
              questionnaire_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (behaviour_id, questionnaire_id) DO NOTHING;
          `,
          values: [behaviour_id, questionnaire_id],
        });
      }
    } catch (error) {
      console.error(assessmentQuestionnaireJson);
      throw error;
    }
  }
  console.log(
    `${assessmentQuestionnairesJson.length} rows inserted into quetionnaire;  questionnaire_disorder; questionnaire_disorder_category; questionnaire_sign_symptom; questionnaire_respondent; questionnaire_subject; questionnaire_assessment_reference; questionnaire_language_not_mhdb; behaviour_questionnaire`,
  );
};

// Resources
export const upsertGuideType = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  isRecord(resources);
  const guideTypesJson = resources["guide_types"];
  isArray(guideTypesJson);
  console.log(`Inserting ${guideTypesJson.length} rows into guide_type...`);
  for (const guideTypeJson of guideTypesJson) {
    isRecord(guideTypeJson);
    const { index: guide_type_id, guide_type: name } = guideTypeJson;
    isString(guide_type_id);
    isString(name);
    await db.query({
      name: "upsert_guide_type",
      text: `
          INSERT INTO guide_type (
            guide_type_id,
            name
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (guide_type_id) DO UPDATE SET
            name = $2;
      `,
      values: [guide_type_id, name],
    });
  }
  console.log(`${guideTypesJson.length} rows inserted into guide_type.`);
};

export const upsertGuideReference = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  isRecord(resources);
  const guideReferencesJson = resources["guides_references"];
  isArray(guideReferencesJson);
  console.log(
    `Inserting ${guideReferencesJson.length} rows into guide_reference...`,
  );
  for (const guideReferenceJson of guideReferencesJson) {
    isRecord(guideReferenceJson);
    const {
      index: guide_reference_id,
      title,
      link,
      PubMedID: pub_med_id,
    } = guideReferenceJson;
    isString(guide_reference_id);
    isString(title);
    isOptionOfType(link, isString);
    isOptionOfType(pub_med_id, isString);
    await db.query({
      name: "upsert_guide_reference",
      text: `
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
      values: [
        guide_reference_id,
        title,
        link,
        pub_med_id ? parseInt(pub_med_id) : null,
      ],
    });
  }
  console.log(
    `${guideReferencesJson.length} rows inserted into guide_reference.`,
  );
};

export const upsertGuide = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  isRecord(resources);
  const guidesJson = resources["guides"];
  isArray(guidesJson);
  console.log(`Inserting ${guidesJson.length} rows into guide...`);
  for (const guideJson of guidesJson) {
    isRecord(guideJson);
    const {
      index: guide_id,
      title,
      link,
      publisher,
      indices_guides_references: guide_reference_id,
      indices_guide_type: guide_type_ids_string,
      indices_disorder: disorder_ids_string,
      indices_disorder_category: disorder_category_ids_string,
      indices_audience: audience_ids_string,
      ["behaviours/states/domains"]: behaviour_ids_string,
    } = guideJson;
    isString(guide_id);
    isOptionOfType(title, isString);
    isOptionOfType(link, isString);
    isString(publisher);
    isOptionOfType(guide_reference_id, isString);
    isString(guide_type_ids_string);
    const guide_type_ids = guide_type_ids_string
      .split(",")
      .map((guide_type_id) => guide_type_id.trim())
      .map((guide_type_id) =>
        guide_type_id.length > 0 ? parseInt(guide_type_id) : null,
      )
      .filter(check(isNotNull));
    isString(disorder_ids_string);
    const disorder_ids = disorder_ids_string
      .split(",")
      .map((disorder_id) => disorder_id.trim())
      .map((disorder_id) =>
        disorder_id.length > 0 ? parseInt(disorder_id) : null,
      )
      .filter(check(isNotNull));
    isString(disorder_category_ids_string);
    const disorder_category_ids = disorder_category_ids_string
      .split(",")
      .map((disorder_category_id) => disorder_category_id.trim())
      .map((disorder_category_id) =>
        disorder_category_id.length > 0 ? parseInt(disorder_category_id) : null,
      )
      .filter(check(isNotNull));
    isString(audience_ids_string);
    const audience_ids = audience_ids_string
      .split(",")
      .map((audience_id) => audience_id.trim())
      .map((audience_id) =>
        audience_id.length > 0 ? parseInt(audience_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(behaviour_ids_string, isString);
    const behaviour_ids = (behaviour_ids_string ?? "")
      .split(",")
      .map((behaviour_id) => behaviour_id.trim())
      .map((behaviour_id) =>
        behaviour_id.length > 0 ? parseInt(behaviour_id) : null,
      )
      .filter(check(isNotNull));
    try {
      await db.query({
        name: "upsert_guide",
        text: `
          INSERT INTO guide (
            guide_id,
            title,
            link,
            publisher,
            guide_reference_id
          ) VALUES (
            $1,
            $2,
            $3,
            $4,
            $5
          ) ON CONFLICT (guide_id) DO UPDATE SET
            title = $2,
            link = $3,
            publisher = $4,
            guide_reference_id = $5;
        `,
        values: [
          guide_id,
          title ?? null,
          link ?? null,
          publisher,
          guide_reference_id && guide_reference_id.length > 0
            ? parseInt(guide_reference_id)
            : null,
        ],
      });
      for (const guide_type_id of guide_type_ids) {
        await db.query({
          name: "upsert_guide_guide_type",
          text: `
              INSERT INTO guide_guide_type (
                guide_id,
                guide_type_id
              ) VALUES (
                $1,
                $2
              ) ON CONFLICT (guide_id, guide_type_id) DO NOTHING;
            `,
          values: [guide_id, guide_type_id],
        });
      }
      for (const disorder_id of disorder_ids) {
        await db.query({
          name: "upsert_guide_disorder",
          text: `
              INSERT INTO guide_disorder (
                guide_id,
                disorder_id
              ) VALUES (
                $1,
                $2
              ) ON CONFLICT (guide_id, disorder_id) DO NOTHING;
            `,
          values: [guide_id, disorder_id],
        });
      }
      for (const disorder_category_id of disorder_category_ids) {
        await db.query({
          name: "upsert_guide_disorder_category",
          text: `
            INSERT INTO guide_disorder_category (
              guide_id,
              disorder_category_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (guide_id, disorder_category_id) DO NOTHING;
          `,
          values: [guide_id, disorder_category_id],
        });
      }
      for (const audience_id of audience_ids) {
        await db.query({
          name: "upsert_guide_audience",
          text: `
            INSERT INTO guide_audience (
              guide_id,
              audience_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (guide_id, audience_id) DO NOTHING;
          `,
          values: [guide_id, audience_id],
        });
      }
      for (const behaviour_id of behaviour_ids) {
        await db.query({
          name: "upsert_behaviour_guide",
          text: `
            INSERT INTO behaviour_guide (
              behaviour_id,
              guide_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (behaviour_id, guide_id) DO NOTHING;
          `,
          values: [behaviour_id, guide_id],
        });
      }
    } catch (error) {
      console.error(guideJson);
      throw error;
    }
  }
  console.log(
    `${guidesJson.length} rows inserted into guide;guide_guide_type; guide_disorder; guide_disorder_category; guide_audience; behaviour_guide, `,
  );
};

// Assessment
export const upsertResponseType = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { assessments } = json;
  isRecord(assessments);
  const responseTypesJson = assessments["response_types"];
  isArray(responseTypesJson);
  console.log(
    `Inserting ${responseTypesJson.length} rows into response_types...`,
  );
  for (const responseTypeJson of responseTypesJson) {
    isRecord(responseTypeJson);
    const {
      index: response_type_id,
      response_type: type,
      definition: response_type_definition,
    } = responseTypeJson;
    isString(response_type_id);
    isString(type);
    isString(response_type_definition);
    await db.query({
      name: "upsert_response_type",
      text: `
          INSERT INTO response_type (
            response_type_id,
            type,
            response_type_definition
          ) VALUES (
            $1,
            $2,
            $3
          ) ON CONFLICT (response_type_id) DO UPDATE SET
            type = $2,
            response_type_definition = $3;
      `,
      values: [response_type_id, type, response_type_definition],
    });
  }
  console.log(`${responseTypesJson.length} rows inserted into response_types.`);
};

export const upsertQuestion = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { assessments } = json;
  isRecord(assessments);
  const questionsJson = assessments["questions"];
  isArray(questionsJson);
  console.log(`Inserting ${questionsJson.length} rows into question...`);
  for (const questionJson of questionsJson) {
    isRecord(questionJson);
    const {
      index: question_id,
      index_questionnaire: questionnaire_id,
      paper_instructions_preamble: paper_instruction_preamble,
      digital_instructions_preamble: digital_instruction_preamble,
      paper_instructions: paper_instruction,
      digital_instructions: digital_instruction,
      question: question_context,
      response_options: response_option,
      indices_response_type: response_type_ids_string,
    } = questionJson;
    isString(question_id);
    isString(questionnaire_id);
    isOptionOfType(paper_instruction_preamble, isString);
    isOptionOfType(digital_instruction_preamble, isString);
    isString(paper_instruction);
    isString(digital_instruction);
    isString(question_context);
    isOptionOfType(response_option, isString);
    isString(response_type_ids_string);
    const response_type_ids = response_type_ids_string
      .split(",")
      .map((response_type_id) => response_type_id.trim())
      .map((response_type_id) =>
        response_type_id.length > 0 ? parseInt(response_type_id) : null,
      )
      .filter(check(isNotNull));
    try {
      await db.query({
        name: "upsert_question",
        text: `
          INSERT INTO question (
            question_id,
            questionnaire_id,
            paper_instruction_preamble,
            digital_instruction_preamble,
            paper_instruction,
            digital_instruction,
            question_context,
            response_option
          ) VALUES (
            $1,
            $2,
            $3,
            $4,
            $5,
            $6,
            $7,
            $8
          ) ON CONFLICT (question_id) DO UPDATE SET
            questionnaire_id = $2,
            paper_instruction_preamble = $3,
            digital_instruction_preamble = $4,
            paper_instruction = $5,
            digital_instruction = $6,
            question_context = $7,
            response_option = $8;
      `,
        values: [
          question_id,
          questionnaire_id,
          paper_instruction_preamble,
          digital_instruction_preamble,
          paper_instruction,
          digital_instruction,
          question_context,
          response_option,
        ],
      });
      for (const response_type_id of response_type_ids) {
        await db.query({
          name: "upsert_question_response_type",
          text: `
            INSERT INTO question_response_type (
              response_type_id,
              question_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (response_type_id, question_id) DO NOTHING;
          `,
          values: [response_type_id, question_id],
        });
      }
    } catch (error) {
      console.error(questionJson);
      throw error;
    }
  }
  console.log(
    `${questionsJson.length} rows inserted into question, question_response_type`,
  );
};

// States
export const upsertStateDomainBehaviour = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { states } = json;
  isRecord(states);
  const stateDomainBehavioursJson = states["domains"];
  isArray(stateDomainBehavioursJson);
  console.log(
    `Inserting ${stateDomainBehavioursJson.length} rows into state_domain_behaviour...`,
  );
  for (const stateDomainBehaviourJson of stateDomainBehavioursJson) {
    isRecord(stateDomainBehaviourJson);
    const { index: behaviour_id, domain: behaviour } = stateDomainBehaviourJson;
    isString(behaviour_id);
    isString(behaviour);
    try {
      await db.query({
        name: "upsert_state_domain_behaviour",
        text: `
          INSERT INTO state_domain_behaviour (
            behaviour_id,
            behaviour
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (behaviour_id) DO UPDATE SET
          behaviour = $2;
      `,
        values: [
          behaviour_id && behaviour_id.length > 0 ? behaviour_id : null,
          behaviour,
        ],
      });
    } catch (error) {
      console.error(stateDomainBehaviourJson);
      throw error;
    }
  }
  console.log(
    `${stateDomainBehavioursJson.length} rows inserted into state_domain_behaviour.`,
  );
};

export const upsertIntervention = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  isRecord(resources);
  const interventionsJson = resources["interventions"];
  isArray(interventionsJson);
  console.log(
    `Inserting ${interventionsJson.length} rows into intervention...`,
  );
  for (const interventionJson of interventionsJson) {
    isRecord(interventionJson);
    const {
      index: intervention_id,
      interventions: name,
      intervention_description: description,
      indices_guide: guide_ids_string,
      indices_disorder: disorder_ids_string,
      indices_disorder_category: disorder_category_ids_string,
      ["behaviours/states/domains"]: behaviour_ids_string,
      indices_sign_symptom: sign_symptom_ids_string,
    } = interventionJson;
    isOptionOfType(intervention_id, isString);
    isOptionOfType(name, isString);
    isOptionOfType(description, isString);
    isOptionOfType(guide_ids_string, isString);
    const guide_ids = (guide_ids_string ?? "")
      .split(",")
      .map((guide_id) => guide_id.trim())
      .map((guide_id) => (guide_id.length > 0 ? parseInt(guide_id) : null))
      .filter(check(isNotNull));
    isOptionOfType(disorder_ids_string, isString);
    const disorder_ids = (disorder_ids_string ?? "")
      .split(",")
      .map((disorder_id) => disorder_id.trim())
      .map((disorder_id) =>
        disorder_id.length > 0 ? parseInt(disorder_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(disorder_category_ids_string, isString);
    const disorder_category_ids = (disorder_category_ids_string ?? "")
      .split(",")
      .map((disorder_category_id) => disorder_category_id.trim())
      .map((disorder_category_id) =>
        disorder_category_id.length > 0 ? parseInt(disorder_category_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(behaviour_ids_string, isString);
    const behaviour_ids = (behaviour_ids_string ?? "")
      .split(",")
      .map((behaviour_id) => behaviour_id.trim())
      .map((behaviour_id) =>
        behaviour_id.length > 0 ? parseInt(behaviour_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(sign_symptom_ids_string, isString);
    const sign_symptom_ids = (sign_symptom_ids_string ?? "")
      .split(",")
      .map((sign_symptom_id) => sign_symptom_id.trim())
      .map((sign_symptom_id) =>
        sign_symptom_id.length > 0 ? parseInt(sign_symptom_id) : null,
      )
      .filter(check(isNotNull));
    try {
      await db.query({
        name: "upsert_intervention",
        text: `
        INSERT INTO intervention (
          intervention_id,
          name,
          description
        ) VALUES (
          $1,
          $2,
          $3
        ) ON CONFLICT (intervention_id) DO UPDATE SET
          name = $2,
          description = $3;
        `,
        values: [
          intervention_id && intervention_id.length > 0
            ? intervention_id
            : null,
          name && name.length > 0 ? name : null,
          description && description.length > 0 ? description : null,
        ],
      });

      for (const guide_id of guide_ids) {
        await db.query({
          name: "upsert_guide_intervention",
          text: `
              INSERT INTO guide_intervention (
                guide_id,
                intervention_id
              ) VALUES (
                $1,
                $2
              ) ON CONFLICT (guide_id, intervention_id) DO NOTHING;
            `,
          values: [guide_id, intervention_id],
        });
      }
      for (const disorder_id of disorder_ids) {
        await db.query({
          name: "upsert_disorder_intervention",
          text: `
            INSERT INTO disorder_intervention (
              intervention_id,
              disorder_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (intervention_id, disorder_id) DO NOTHING;
          `,
          values: [intervention_id, disorder_id],
        });
      }
      for (const disorder_category_id of disorder_category_ids) {
        await db.query({
          name: "upsert_disorder_category_intervention",
          text: `
            INSERT INTO disorder_category_intervention (
              intervention_id,
              disorder_category_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (intervention_id, disorder_category_id) DO NOTHING;
          `,
          values: [intervention_id, disorder_category_id],
        });
      }
      for (const behaviour_id of behaviour_ids) {
        await db.query({
          name: "upsert_behaviour_intervention",
          text: `
            INSERT INTO behaviour_intervention (
              behaviour_id,
              intervention_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (behaviour_id, intervention_id) DO NOTHING;
          `,
          values: [behaviour_id, intervention_id],
        });
      }
      for (const sign_symptom_id of sign_symptom_ids) {
        await db.query({
          name: "upsert_sign_symptom_intervention",
          text: `
            INSERT INTO sign_symptom_intervention (
              sign_symptom_id,
              intervention_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (sign_symptom_id, intervention_id) DO NOTHING;
          `,
          values: [sign_symptom_id, intervention_id],
        });
      }
    } catch (error) {
      console.error(interventionJson);
      throw error;
    }
  }
  console.log(
    `${interventionsJson.length} rows inserted into intervention; guide_intervention; disorder_intervention; disorder_category_intervention; behaviour_intervention; sign_symptom_intervention`,
  );
};

export const upsertAccommodation = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  6;
  isRecord(resources);
  const accommodationsJson = resources["Accommodations"];
  isArray(accommodationsJson);
  console.log(
    `Inserting ${accommodationsJson.length} rows into accommodation...`,
  );
  for (const accommodationJson of accommodationsJson) {
    isRecord(accommodationJson);
    const {
      index: accommodation_id,
      accommodations: name,
      accommodation_description: description,
      guide_index: guide_ids_string,
      indices_disorder: disorder_ids_string,
      indices_disorder_category: disorder_category_ids_string,
      ["behaviours/states/domains"]: behaviour_ids_string,
      indices_sign_symptom: sign_symptom_ids_string,
    } = accommodationJson;
    isOptionOfType(accommodation_id, isString);
    isOptionOfType(name, isString);
    isOptionOfType(description, isString);
    isOptionOfType(guide_ids_string, isString);
    const guide_ids = (guide_ids_string ?? "")
      .split(",")
      .map((guide_id) => guide_id.trim())
      .map((guide_id) => (guide_id.length > 0 ? parseInt(guide_id) : null))
      .filter(check(isNotNull));
    isOptionOfType(disorder_ids_string, isString);
    const disorder_ids = (disorder_ids_string ?? "")
      .split(",")
      .map((disorder_id) => disorder_id.trim())
      .map((disorder_id) =>
        disorder_id.length > 0 ? parseInt(disorder_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(disorder_category_ids_string, isString);
    const disorder_category_ids = (disorder_category_ids_string ?? "")
      .split(",")
      .map((disorder_category_id) => disorder_category_id.trim())
      .map((disorder_category_id) =>
        disorder_category_id.length > 0 ? parseInt(disorder_category_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(behaviour_ids_string, isString);
    const behaviour_ids = (behaviour_ids_string ?? "")
      .split(",")
      .map((behaviour_id) => behaviour_id.trim())
      .map((behaviour_id) =>
        behaviour_id.length > 0 ? parseInt(behaviour_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(sign_symptom_ids_string, isString);
    const sign_symptom_ids = (sign_symptom_ids_string ?? "")
      .split(",")
      .map((sign_symptom_id) => sign_symptom_id.trim())
      .map((sign_symptom_id) =>
        sign_symptom_id.length > 0 ? parseInt(sign_symptom_id) : null,
      )
      .filter(check(isNotNull));
    await db.query({
      name: "upsert_accommodation",
      text: `
          INSERT INTO accommodation (
            accommodation_id,
            name,
            description
          ) VALUES (
            $1,
            $2,
            $3
          ) ON CONFLICT (accommodation_id) DO UPDATE SET
            name = $2,
            description = $3;
      `,
      values: [
        accommodation_id && accommodation_id.length > 0
          ? accommodation_id
          : null,
        name && name.length > 0 ? name : null,
        description && description.length > 0 ? description : null,
      ],
    });

    for (const guide_id of guide_ids) {
      await db.query({
        name: "upsert_guide_accommodation",
        text: `
            INSERT INTO guide_accommodation (
              guide_id,
              accommodation_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (guide_id, accommodation_id) DO NOTHING;
          `,
        values: [guide_id, accommodation_id],
      });
    }
    for (const disorder_id of disorder_ids) {
      await db.query({
        name: "upsert_disorder_accommodation",
        text: `
          INSERT INTO disorder_accommodation (
            accommodation_id,
            disorder_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (accommodation_id, disorder_id) DO NOTHING;
        `,
        values: [accommodation_id, disorder_id],
      });
    }
    for (const disorder_category_id of disorder_category_ids) {
      await db.query({
        name: "upsert_disorder_category_accommodation",
        text: `
          INSERT INTO disorder_category_accommodation (
            accommodation_id,
            disorder_category_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (accommodation_id, disorder_category_id) DO NOTHING;
        `,
        values: [accommodation_id, disorder_category_id],
      });
    }
    for (const behaviour_id of behaviour_ids) {
      await db.query({
        name: "upsert_behaviour_accommodation",
        text: `
          INSERT INTO behaviour_accommodation (
            behaviour_id,
            accommodation_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (behaviour_id, accommodation_id) DO NOTHING;
        `,
        values: [behaviour_id, accommodation_id],
      });
    }
    for (const sign_symptom_id of sign_symptom_ids) {
      await db.query({
        name: "upsert_sign_symptom_accommodation",
        text: `
          INSERT INTO sign_symptom_accommodation (
            sign_symptom_id,
            accommodation_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (sign_symptom_id, accommodation_id) DO NOTHING;
        `,
        values: [sign_symptom_id, accommodation_id],
      });
    }
  }
  console.log(
    `${accommodationsJson.length} rows inserted into accommodation; guide_accommodation; disorder_accommodation; disorder_category_accommodation; behaviour_accommodation; sign_symptom_accommodation`,
  );
};

export const upsertTechnology = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { resources } = json;
  isRecord(resources);
  const technologiesJson = resources["Assistive Technologies"];
  isArray(technologiesJson);
  console.log(`Inserting ${technologiesJson.length} rows into technology...`);
  for (const technologyJson of technologiesJson) {
    isRecord(technologyJson);
    const {
      index: technology_id,
      technologies: name,
      technologies_description: description,
      link,
      guide_index: guide_ids_string,
      indices_disorder: disorder_ids_string,
      indices_disorder_category: disorder_category_ids_string,
      ["behaviours/states/domains"]: behaviour_ids_string,
      indices_sign_symptom: sign_symptom_ids_string,
    } = technologyJson;
    isString(technology_id);
    isString(name);
    isOptionOfType(description, isString);
    isOptionOfType(link, isString);
    isOptionOfType(guide_ids_string, isString);
    const guide_ids = (guide_ids_string ?? "")
      .split(",")
      .map((guide_id) => guide_id.trim())
      .map((guide_id) => (guide_id.length > 0 ? parseInt(guide_id) : null))
      .filter(check(isNotNull));
    isOptionOfType(disorder_ids_string, isString);
    const disorder_ids = (disorder_ids_string ?? "")
      .split(",")
      .map((disorder_id) => disorder_id.trim())
      .map((disorder_id) =>
        disorder_id.length > 0 ? parseInt(disorder_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(disorder_category_ids_string, isString);
    const disorder_category_ids = (disorder_category_ids_string ?? "")
      .split(",")
      .map((disorder_category_id) => disorder_category_id.trim())
      .map((disorder_category_id) =>
        disorder_category_id.length > 0 ? parseInt(disorder_category_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(behaviour_ids_string, isString);
    const behaviour_ids = (behaviour_ids_string ?? "")
      .split(",")
      .map((behaviour_id) => behaviour_id.trim())
      .map((behaviour_id) =>
        behaviour_id.length > 0 ? parseInt(behaviour_id) : null,
      )
      .filter(check(isNotNull));
    isOptionOfType(sign_symptom_ids_string, isString);
    const sign_symptom_ids = (sign_symptom_ids_string ?? "")
      .split(",")
      .map((sign_symptom_id) => sign_symptom_id.trim())
      .map((sign_symptom_id) =>
        sign_symptom_id.length > 0 ? parseInt(sign_symptom_id) : null,
      )
      .filter(check(isNotNull));
    await db.query({
      name: "upsert_technology",
      text: `
          INSERT INTO technology (
            technology_id,
            name,
            description,
            link
          ) VALUES (
            $1,
            $2,
            $3,
            $4
          ) ON CONFLICT (technology_id) DO UPDATE SET
            name = $2,
            description = $3,
            link = $4;
      `,
      values: [technology_id, name, description, link],
    });
    for (const guide_id of guide_ids) {
      await db.query({
        name: "upsert_guide_technology",
        text: `
            INSERT INTO guide_technology (
              guide_id,
              technology_id
            ) VALUES (
              $1,
              $2
            ) ON CONFLICT (guide_id, technology_id) DO NOTHING;
          `,
        values: [guide_id, technology_id],
      });
    }
    for (const disorder_id of disorder_ids) {
      await db.query({
        name: "upsert_disorder_technology",
        text: `
          INSERT INTO disorder_technology (
            technology_id,
            disorder_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (technology_id, disorder_id) DO NOTHING;
        `,
        values: [technology_id, disorder_id],
      });
    }
    for (const disorder_category_id of disorder_category_ids) {
      await db.query({
        name: "upsert_disorder_category_technology",
        text: `
          INSERT INTO disorder_category_technology (
            technology_id,
            disorder_category_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (technology_id, disorder_category_id) DO NOTHING;
        `,
        values: [technology_id, disorder_category_id],
      });
    }
    for (const behaviour_id of behaviour_ids) {
      await db.query({
        name: "upsert_behaviour_technology",
        text: `
          INSERT INTO behaviour_technology (
            behaviour_id,
            technology_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (behaviour_id, technology_id) DO NOTHING;
        `,
        values: [behaviour_id, technology_id],
      });
    }
    for (const sign_symptom_id of sign_symptom_ids) {
      await db.query({
        name: "upsert_sign_symptom_technology",
        text: `
          INSERT INTO sign_symptom_technology (
            sign_symptom_id,
            technology_id
          ) VALUES (
            $1,
            $2
          ) ON CONFLICT (sign_symptom_id, technology_id) DO NOTHING;
        `,
        values: [sign_symptom_id, technology_id],
      });
    }
  }
  console.log(
    `${technologiesJson.length} rows inserted into technology; guide_technology; disorder_technology; disorder_category_technology; behaviour_technology; sign_symptom_technology.`,
  );
};

export const upsertAuthor = async (
  db: PoolClient,
  json: SpreadSheetJson,
): Promise<void> => {
  const { assessments } = json;
  isRecord(assessments);
  const assessmentAuthorsJson = assessments["references"];
  isArray(assessmentAuthorsJson);
  console.log(
    `Inserting ${assessmentAuthorsJson.length} rows into authors for assessment_reference...`,
  );

  for (const assessmentAuthorJson of assessmentAuthorsJson) {
    isRecord(assessmentAuthorJson);
    const { authors: authorsInput, index } = assessmentAuthorJson;
    isString(index);
    const authors =
      typeof authorsInput === "string" ? extractNames(authorsInput) : [];
    for (const [first_initial, middle_initial, surname] of authors) {
      await db.query({
        name: "upsert_author",
        text: `
                  INSERT INTO author (
                    first_initial, 
                    middle_initial, 
                    surname
                  ) VALUES (
                    $1,
                    $2,
                    $3
                  ) ON CONFLICT (first_initial,
                    middle_initial,
                    surname) DO NOTHING;
              `,
        values: [first_initial, middle_initial ?? "", surname],
      });
      await db.query({
        name: "upsert_assessment_reference_author",
        text: `
                  INSERT INTO assessment_reference_author (
                    author_first_initial,
                    author_middle_initial,
                    author_surname,
                    assessment_reference_id
                  ) VALUES (
                    $1,
                    $2,
                    $3,
                    $4
                  ) ON CONFLICT (author_first_initial, author_middle_initial, author_surname,
                    assessment_reference_id
                  ) DO NOTHING;
              `,
        values: [
          first_initial,
          middle_initial ?? "",
          surname,
          parseInt(index),
          //index here equivalent to assessment_reference_id,
        ],
      });
    }
  }
  console.log(
    `${assessmentAuthorsJson.length} rows of authors inserted into assessment_reference_author...`,
  );

  const { disorders } = json;
  isRecord(disorders);
  const disorderAuthorsJson = disorders["references"];
  isArray(disorderAuthorsJson);
  console.log(
    `Inserting ${disorderAuthorsJson.length} rows into authors for disorder_reference...`,
  );

  for (const disorderAuthorJson of disorderAuthorsJson) {
    isRecord(disorderAuthorJson);
    const { authors: authorsInput, index } = disorderAuthorJson;
    isString(index);
    const authors =
      typeof authorsInput === "string" ? extractNames(authorsInput) : [];
    for (const [first_initial, middle_initial, surname] of authors) {
      await db.query({
        name: "upsert_author",
        text: `
                  INSERT INTO author (
                    first_initial, 
                    middle_initial, 
                    surname
                  ) VALUES (
                    $1,
                    $2,
                    $3
                  ) ON CONFLICT (first_initial,
                    middle_initial,
                    surname) DO NOTHING;
              `,
        values: [first_initial, middle_initial ?? "", surname],
      });
      await db.query({
        name: "upsert_disorder_reference_author",
        text: `
                  INSERT INTO disorder_reference_author (
                    author_first_initial,
                    author_middle_initial,
                    author_surname,
                    disorder_reference_id
                  ) VALUES (
                    $1,
                    $2,
                    $3,
                    $4
                  ) ON CONFLICT (
                    author_first_initial,
                    author_middle_initial,
                    author_surname,
                    disorder_reference_id
                  ) DO NOTHING;
              `,
        values: [first_initial, middle_initial ?? "", surname, parseInt(index)], //index here equivalent to disorder_reference_id
      });
    }
  }
  console.log(
    `${disorderAuthorsJson.length} rows of authors inserted into assessment_reference_author...`,
  );
  const { resources } = json;
  isRecord(resources);
  const guideAuthorsJson = resources["guides"];
  isArray(guideAuthorsJson);
  console.log(
    `Inserting ${guideAuthorsJson.length} rows into authors for guide_author...`,
  );
  for (const guideAuthorJson of guideAuthorsJson) {
    isRecord(guideAuthorJson);
    const { authors: authorsInput, index } = guideAuthorJson;
    isString(index);
    const authors =
      typeof authorsInput === "string" ? extractNames(authorsInput) : [];
    for (const [first_initial, middle_initial, surname] of authors) {
      await db.query({
        name: "upsert_author",
        text: `
                  INSERT INTO author (
                    first_initial, 
                    middle_initial, 
                    surname
                  ) VALUES (
                    $1,
                    $2,
                    $3
                  ) ON CONFLICT (first_initial,
                    middle_initial,
                    surname) DO NOTHING;
              `,
        values: [first_initial, middle_initial ?? "", surname],
      });
      await db.query({
        name: "upsert_guide_author",
        text: `
                  INSERT INTO guide_author (
                    author_first_initial,
                    author_middle_initial,
                    author_surname,
                    guide_id
                  ) VALUES (
                    $1,
                    $2,
                    $3,
                    $4
                  ) ON CONFLICT (
                    author_first_initial,
                    author_middle_initial,
                    author_surname,
                    guide_id
                  ) DO NOTHING;
              `,
        values: [
          first_initial,
          middle_initial ?? "",
          surname,
          parseInt(index), // index here equivalent to guide_id
        ],
      });
    }
  }
  console.log(
    `${guideAuthorsJson.length} rows of authors inserted into guide_author...`,
  );

  const questionnaireAuthorsJson = assessments["questionnaires"];
  isArray(questionnaireAuthorsJson);
  console.log(
    `Inserting ${questionnaireAuthorsJson.length} rows into authors for questionnaire_author...`,
  );

  for (const questionnaireAuthorJson of questionnaireAuthorsJson) {
    isRecord(questionnaireAuthorJson);
    const { authors: authorsInput, index } = questionnaireAuthorJson;
    isString(index);
    const authors =
      typeof authorsInput === "string" ? extractNames(authorsInput) : [];
    for (const [first_initial, middle_initial, surname] of authors) {
      await db.query({
        name: "upsert_author",
        text: `
                  INSERT INTO author (
                    first_initial, 
                    middle_initial, 
                    surname
                  ) VALUES (
                    $1,
                    $2,
                    $3
                  ) ON CONFLICT (first_initial,
                    middle_initial,
                    surname) DO NOTHING;
              `,
        values: [first_initial, middle_initial ?? "", surname],
      });
      await db.query({
        name: "upsert_questionnaire_author",
        text: `
                  INSERT INTO questionnaire_author (
                    author_first_initial,
                    author_middle_initial,
                    author_surname,
                    questionnaire_id
                  ) VALUES (
                    $1,
                    $2,
                    $3,
                    $4
                  ) ON CONFLICT (author_first_initial, author_middle_initial, author_surname,
                      questionnaire_id
                  ) DO NOTHING;
              `,
        values: [first_initial, middle_initial ?? "", surname, parseInt(index)], //index here equivalent to questionnaire_id
      });
    }
  }
  console.log(
    `${questionnaireAuthorsJson.length} rows of authors inserted into questionnaire_author...`,
  );
};

export const upsertData = async (
  db: PoolClient,
  inFolder: string,
): Promise<void> => {
  const spreadsheets = await loadSpreadSheetsFromJson(inFolder);

  await db.query("BEGIN");
  await upsertDisorderSubcategory(db, spreadsheets);
  await upsertDisorderCategory(db, spreadsheets);
  await upsertDisorder(db, spreadsheets);
  await upsertDisorderReference(db, spreadsheets);
  await upsertSignSymptom(db, spreadsheets);
  await upsertSignSymptomExample(db, spreadsheets);
  await upsertNeutralConstruct(db, spreadsheets);
  await upsertAssessmentReference(db, spreadsheets);
  await upsertResourcePeopleAudience(db, spreadsheets);
  await upsertLanguageSource(db, spreadsheets);
  await upsertQuestionnaire(db, spreadsheets);
  await upsertGuideType(db, spreadsheets);
  await upsertGuideReference(db, spreadsheets);
  await upsertGuide(db, spreadsheets);
  await upsertResponseType(db, spreadsheets);
  await upsertQuestion(db, spreadsheets);
  await upsertStateDomainBehaviour(db, spreadsheets);
  await upsertIntervention(db, spreadsheets);
  await upsertAccommodation(db, spreadsheets);
  await upsertTechnology(db, spreadsheets);
  //await upsertResearchEvidence(db, spreadsheets); (not created)
  await upsertAuthor(db, spreadsheets);
  await db.query("COMMIT");
};
