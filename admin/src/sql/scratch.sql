BEGIN;

-- URLs now take type text
-- not null all checked
-- no abbrevations in names
-- updated along with Directus import
CREATE TABLE disorder_subcategory (
  disorder_subcategory_id int PRIMARY KEY NOT NULL,
  name text NOT NULL
  -- it doesn't exist a column to indicate the relationship between category and subcategory
);

CREATE TABLE disorder_category (
  disorder_category_id int PRIMARY KEY NOT NULL,
  name text NOT NULL
  -- it doesn't exist a column to indicate the relationship between category and subcategory
);

CREATE TABLE disorder (
  disorder_id int PRIMARY KEY NOT NULL,
  name text NOT NULL,
  disorder_category_id int REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_subcategory_id int REFERENCES disorder_subcategory (disorder_subcategory_id) ON UPDATE CASCADE ON DELETE CASCADE,
  icd_9_cm text,
  icd_10_cm text,
  CHECK ((disorder_category_id IS NOT NULL) OR (disorder_subcategory_id IS NOT NULL))
);

CREATE TABLE disorder_reference (
  disorder_reference_id int PRIMARY KEY NOT NULL,
  title text NOT NULL
);

CREATE TABLE sign_symptom (
  sign_symptom_id int PRIMARY KEY NOT NULL,
  name text NOT NULL,
  underlying_behavior text,
  -- exist empty fillings
  disorder_reference_id int NOT NULL REFERENCES disorder_reference (disorder_reference_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE disorder_sign_symptom (
  disorder_sign_symptom_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  disorder_id int NOT NULL REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (disorder_id, sign_symptom_id)
);

CREATE TABLE author (
  author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  first_initial text NOT NULL CHECK (char_length(first_initial) = 1),
  middle_initial text NOT NULL CHECK (char_length(middle_initial) = 0 OR char_length(middle_initial) = 1),
  surname text NOT NULL,
  UNIQUE (first_initial, middle_initial, surname)
);

CREATE TABLE disorder_reference_author (
  disorder_reference_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  disorder_reference_id int NOT NULL REFERENCES disorder_reference (disorder_reference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  author_id uuid NOT NULL REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int,
  UNIQUE (disorder_reference_id, rank)
);

-- -- neutral_contruct is not null, but in the many-to-many relationships, it can be null, thus it is not specified NOT NULL in the following relationship table
CREATE TABLE neutral_construct (
  name text PRIMARY KEY
);

CREATE TABLE sign_symptom_neutral_construct (
  sign_symptom_neutral_construct_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  name text NOT NULL REFERENCES neutral_construct (name) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (sign_symptom_id, name)
);

CREATE TABLE sign_symptom_example (
  sign_symptom_example_id int PRIMARY KEY NOT NULL,
  name text NOT NULL
);

CREATE TABLE sign_symptom_with_example (
  sign_symptom_with_example_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_example_id int NOT NULL REFERENCES sign_symptom_example (sign_symptom_example_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (sign_symptom_id, sign_symptom_example_id)
);

CREATE TABLE assessment_reference (
  assessment_reference_id int PRIMARY KEY NOT NULL,
  title text NOT NULL,
  link text,
  -- possible empty verified
  pub_med_id int
  -- possible empty verified
);

-- possible empty authors in references
-- possible many authors for the same references
CREATE TABLE assessment_reference_author (
  assessment_reference_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  assessment_reference_id int NOT NULL REFERENCES assessment_reference (assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  author_id uuid NOT NULL REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int
);

CREATE TABLE resource_people_audience (
  audience_id int PRIMARY KEY NOT NULL,
  person text NOT NULL
);

-- langauge will lead to an auto return of the line, thus I use language_source
CREATE TABLE language_source (
  language_source_id int PRIMARY KEY NOT NULL,
  name text NOT NULL
);

CREATE TABLE questionnaire (
  questionnaire_id int PRIMARY KEY NOT NULL,
  title text NOT NULL,
  link text,
  -- possible empty verified
  description text,
  -- possible empty verified
  abbreviation text,
  -- possible empty verified
  age_max int,
  -- possible empty verified
  age_min int,
  -- possible empty verified
  number_of_questions int,
  -- possible empty verified
  minutes_to_complete int,
  -- possible empty verified
  license_id int NOT NULL,
  language_source_id int NOT NULL REFERENCES language_source (language_source_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE questionnaire_language_not_mhdb (
  questionnaire_language_not_mhdb_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  language_source_id int NOT NULL REFERENCES language_source (language_source_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (questionnaire_id, language_source_id)
);

-- same question about empty in ManyToMany relationship
CREATE TABLE questionnaire_disorder (
  questionnaire_disorder_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int NOT NULL REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (questionnaire_id, disorder_id)
);

-- same
CREATE TABLE questionnaire_disorder_category (
  questionnaire_disorder_category_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int NOT NULL REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (questionnaire_id, disorder_category_id)
);

-- -- not sure about NOT NULL rules here
-- CREATE TABLE questionnaire_language_source (
--   questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
--   language_source_id int REFERENCES language_source (language_source_id) ON UPDATE CASCADE ON DELETE CASCADE,
--   PRIMARY KEY (questionnaire_id, language_source_id)
-- );
-- same, possible empty
CREATE TABLE questionnaire_sign_symptom (
  questionnaire_sign_symptom_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (questionnaire_id, sign_symptom_id)
);

CREATE TABLE questionnaire_respondent (
  questionnaire_respondent_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  respondent_id int NOT NULL REFERENCES resource_people_audience (audience_id) ON UPDATE CASCADE ON DELETE CASCADE,
  -- there is only one empty but highlighted in yellow, I assume it should be filled
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (respondent_id, questionnaire_id)
);

CREATE TABLE questionnaire_subject (
  questionnaire_subject_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  subject_id int NOT NULL REFERENCES resource_people_audience (audience_id) ON UPDATE CASCADE ON DELETE CASCADE,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (subject_id, questionnaire_id)
);

CREATE TABLE questionnaire_assessment_reference (
  questionnaire_assessment_reference_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  assessment_reference_id int NOT NULL REFERENCES assessment_reference (assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (assessment_reference_id, questionnaire_id)
);

-- possible empty verified
-- should we allow multiple authors with the same rank for a given questionnaire? if yes, then that's fine
-- if no, then add UNIQUE (questionnaire_id, rank)
-- Verified: for a given questionnaire, there are multiple authors
CREATE TABLE questionnaire_author (
  questionnaire_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  author_id uuid NOT NULL REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int
);

CREATE TABLE guide_type (
  guide_type_id int PRIMARY KEY NOT NULL,
  name text NOT NULL
);

-- THE whole column and its associated worksheet is empty for now.
CREATE TABLE guide_reference (
  guide_reference_id int PRIMARY KEY,
  title text,
  link text,
  pub_med_id int
);

CREATE TABLE guide (
  guide_id int PRIMARY KEY NOT NULL,
  title text NOT NULL,
  link text NOT NULL,
  publisher text NOT NULL,
  guide_reference_id int REFERENCES guide_reference (guide_reference_id) ON UPDATE CASCADE ON DELETE CASCADE
  -- this column is empty
);

CREATE TABLE guide_guide_type (
  guide_guide_type_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  guide_type_id int NOT NULL REFERENCES guide_type (guide_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (guide_type_id, guide_id)
);

--??? How can I specify ...in the following two ManytoMany relationships?
-- CHECK ((disorder_category_id IS NULL AND disorder_subcategory_id IS NOT NULL) OR (disorder_category_id IS NULL AND disorder_category_id IS NOT NULL))
CREATE TABLE guide_disorder (
  guide_disorder_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  disorder_id int NOT NULL REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (disorder_id, guide_id)
);

CREATE TABLE guide_disorder_category (
  guide_disorder_category_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  disorder_category_id int NOT NULL REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (disorder_category_id, guide_id)
);

-- SAME, possible empty in ManyToMany relationship
CREATE TABLE guide_audience (
  guide_audience_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  audience_id int NOT NULL REFERENCES resource_people_audience (audience_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (audience_id, guide_id)
);

-- SAME, possible empty in ManyToMany relationship
-- possible many authors for the same references
CREATE TABLE guide_author (
  guide_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  author_id uuid NOT NULL REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int
);

CREATE TABLE response_type (
  response_type_id int PRIMARY KEY NOT NULL,
  type text NOT NULL,
  response_type_definition text NOT NULL
);

CREATE TABLE question (
  question_id int PRIMARY KEY NOT NULL,
  questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  -- NOT NULL
  paper_instruction_preamble text,
  -- possible empty verified
  digital_instruction_preamble text,
  -- possible empty verified
  paper_instruction text,
  -- possible empty verified
  digital_instruction text,
  -- possible empty verified
  question_context text NOT NULL,
  response_option text
  -- possible empty verified
);

CREATE TABLE question_response_type (
  question_response_type_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  response_type_id int NOT NULL REFERENCES response_type (response_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  question_id int NOT NULL REFERENCES question (question_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (response_type_id, question_id)
);

CREATE TABLE task (
  task_id int PRIMARY KEY NOT NULL,
  name text NOT NULL,
  description text,
  -- one empty verified, maybe it should be filled and then change to NOT NULL
  -- alias_name text, -- possible empty verified
  assessment_reference_id int NOT NULL REFERENCES assessment_reference (assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- ??? I am not sure about the foreign key here. several alias for the same task, foreign key stays in the table of alias, and then linked to task. is it like what I write?
CREATE TABLE alias (
  alias_id int PRIMARY KEY NOT NULL,
  task_id int REFERENCES task (task_id) ON UPDATE CASCADE ON DELETE CASCADE,
  name text NOT NULL
);

CREATE TABLE state_domain_behaviour (
  behaviour_id int PRIMARY KEY NOT NULL,
  behaviour text NOT NULL
);

---The followings are new worksheets, they are all empty now, but most of them should be NOT NULL when Anirudh start to fill them
CREATE TABLE intervention (
  intervention_id int PRIMARY KEY,
  name text,
  description text
);

CREATE TABLE accommodation (
  accommodation_id int PRIMARY KEY NOT NULL,
  name text NOT NULL,
  description text
);

CREATE TABLE technology (
  technology_id int PRIMARY KEY,
  name text,
  description text,
  link text
);

CREATE TABLE disorder_intervention (
  disorder_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  intervention_id int NOT NULL REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int NOT NULL REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (intervention_id, disorder_id)
);

CREATE TABLE disorder_accommodation (
  disorder_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  accommodation_id int NOT NULL REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int NOT NULL REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (accommodation_id, disorder_id)
);

CREATE TABLE disorder_technology (
  disorder_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  technology_id int NOT NULL REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int NOT NULL REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (technology_id, disorder_id)
);

CREATE TABLE disorder_category_intervention (
  disorder_category_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  intervention_id int NOT NULL REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int NOT NULL REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (intervention_id, disorder_category_id)
);

CREATE TABLE disorder_category_accommodation (
  disorder_category_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  accommodation_id int NOT NULL REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int NOT NULL REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (accommodation_id, disorder_category_id)
);

CREATE TABLE disorder_category_technology (
  disorder_category_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  technology_id int NOT NULL REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int NOT NULL REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (technology_id, disorder_category_id)
);

CREATE TABLE sign_symptom_intervention (
  sign_symptom_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  intervention_id int NOT NULL REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (intervention_id, sign_symptom_id)
);

CREATE TABLE sign_symptom_accommodation (
  sign_symptom_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  accommodation_id int NOT NULL REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (accommodation_id, sign_symptom_id)
);

CREATE TABLE sign_symptom_technology (
  sign_symptom_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  technology_id int NOT NULL REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (technology_id, sign_symptom_id)
);

CREATE TABLE guide_intervention (
  guide_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  intervention_id int NOT NULL REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (intervention_id, guide_id)
);

CREATE TABLE guide_accommodation (
  guide_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  accommodation_id int NOT NULL REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (accommodation_id, guide_id)
);

CREATE TABLE guide_technology (
  guide_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  technology_id int NOT NULL REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (technology_id, guide_id)
);

CREATE TABLE research_evidence (
  research_evidence_id int PRIMARY KEY,
  context text NOT NULL
);

CREATE TABLE intervention_research_evidence (
  intervention_research_evidence_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  intervention_id int NOT NULL REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  research_evidence_id int NOT NULL REFERENCES research_evidence (research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (intervention_id, research_evidence_id)
);

CREATE TABLE accommodation_research_evidence (
  accommodation_research_evidence_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  accommodation_id int NOT NULL REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  research_evidence_id int NOT NULL REFERENCES research_evidence (research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (accommodation_id, research_evidence_id)
);

CREATE TABLE technology_research_evidence (
  technology_research_evidence_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  technology_id int NOT NULL REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  research_evidence_id int NOT NULL REFERENCES research_evidence (research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (technology_id, research_evidence_id)
);

CREATE TABLE behaviour_intervention (
  behaviour_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  intervention_id int NOT NULL REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int NOT NULL REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (intervention_id, behaviour_id)
);

CREATE TABLE behaviour_accommodation (
  behaviour_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  accommodation_id int NOT NULL REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int NOT NULL REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (accommodation_id, behaviour_id)
);

CREATE TABLE behaviour_technology (
  behaviour_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  technology_id int NOT NULL REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int NOT NULL REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (technology_id, behaviour_id)
);

CREATE TABLE behaviour_guide (
  behaviour_guide_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  guide_id int NOT NULL REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int NOT NULL REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (guide_id, behaviour_id)
);

CREATE TABLE behaviour_questionnaire (
  behaviour_questionnaire_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int NOT NULL REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (questionnaire_id, behaviour_id)
);

CREATE TABLE locale (
  locale_id text NOT NULL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE lisa_domain_category (
  domain_category_id text NOT NULL PRIMARY KEY
);

CREATE TABLE lisa_domain (
  domain_id text NOT NULL PRIMARY KEY,
  domain_category_id text NOT NULL REFERENCES lisa_domain_category (domain_category_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_guide (
  lisa_guide_id text NOT NULL PRIMARY KEY
);

CREATE TABLE lisa_static_content (
  static_content_id text NOT NULL PRIMARY KEY
);

CREATE TABLE lisa_author (
  lisa_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_author_first_name text NOT NULL,
  lisa_author_last_name text NOT NULL
);

CREATE TABLE lisa_domain_category_locale (
  lisa_domain_category_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  domain_category_id text NOT NULL REFERENCES lisa_domain_category (domain_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (domain_category_id, locale_id)
);

CREATE TABLE lisa_domain_locale (
  lisa_domain_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  domain_id text NOT NULL REFERENCES lisa_domain (domain_id) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (domain_id, locale_id)
);

CREATE TABLE lisa_guide_locale (
  lisa_guide_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_guide_id text NOT NULL REFERENCES lisa_guide (lisa_guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (lisa_guide_id, locale_id)
);

CREATE TABLE lisa_static_content_locale (
  lisa_static_content_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  static_content_id text NOT NULL REFERENCES lisa_static_content (static_content_id) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (static_content_id, locale_id)
);

-- for my understanding, the created_by is the people who technically updated the version, and the ManyToMany table of the author refers to the people who write the article
CREATE TABLE lisa_domain_category_locale_version (
  lisa_domain_category_locale_version_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  lisa_domain_category_locale_id uuid NOT NULL REFERENCES lisa_domain_category_locale (lisa_domain_category_locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_domain_locale_version (
  lisa_domain_locale_version_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  lisa_domain_locale_id uuid NOT NULL REFERENCES lisa_domain_locale (lisa_domain_locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_guide_locale_version (
  lisa_guide_locale_version_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  lisa_guide_locale_id uuid NOT NULL REFERENCES lisa_guide_locale (lisa_guide_locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_static_content_locale_version (
  lisa_static_content_locale_version_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  lisa_static_content_locale_id uuid NOT NULL REFERENCES lisa_static_content_locale (lisa_static_content_locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_domain_category_locale_author (
  lisa_domain_category_locale_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_author_id uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int,
  lisa_domain_category_locale_id uuid NOT NULL REFERENCES lisa_domain_category_locale (lisa_domain_category_locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_guide_locale_author (
  lisa_guide_locale_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_author_id uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int,
  lisa_guide_locale_id uuid NOT NULL REFERENCES lisa_guide_locale (lisa_guide_locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_domain_locale_author (
  lisa_domain_locale_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_author_id uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int,
  lisa_domain_locale_id uuid NOT NULL REFERENCES lisa_domain_locale (lisa_domain_locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_domain_guide (
  lisa_domain_guide_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_guide_id text NOT NULL REFERENCES lisa_guide (lisa_guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  domain_id text NOT NULL REFERENCES lisa_domain (domain_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (lisa_guide_id, domain_id)
);

CREATE TABLE lisa_domain_guide_locale (
  lisa_domain_guide_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  lisa_domain_guide_id uuid NOT NULL REFERENCES lisa_domain_guide (lisa_domain_guide_id) ON UPDATE CASCADE ON DELETE CASCADE
);

COMMIT;

