-- URLs now take type text
-- not null all checked
-- no abbrevations in names
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

CREATE TABLE icd_9_cm (
  icd_9_cm_id int PRIMARY KEY NOT NULL,
  code text NOT NULL
);

CREATE TABLE icd_10_cm (
  icd_10_cm_id int PRIMARY KEY NOT NULL,
  code text NOT NULL
);

CREATE TABLE disorder (
  disorder_id int PRIMARY KEY NOT NULL,
  name text NOT NULL,
  disorder_category_id int REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_subcategory_id int REFERENCES disorder_subcategory (disorder_subcategory_id) ON UPDATE CASCADE ON DELETE CASCADE,
  icd_9_cm int REFERENCES icd_9_cm ON UPDATE CASCADE ON DELETE CASCADE,
  icd_10_cm int REFERENCES icd_10_cm ON UPDATE CASCADE ON DELETE CASCADE,
  CHECK (((disorder_category_id IS NULL) AND (disorder_subcategory_id IS NOT NULL)) OR ((disorder_category_id IS NULL) AND (disorder_subcategory_id IS NOT NULL)))
);

CREATE TABLE disorder_reference (
  disorder_reference_id int PRIMARY KEY NOT NULL,
  title text NOT NULL
);

CREATE TABLE sign_symptom (
  sign_symptom_id int PRIMARY KEY NOT NULL,
  name text NOT NULL,
  underlying_behavior text, -- exist empty fillings
  disorder_reference_id int NOT NULL REFERENCES disorder_reference (disorder_reference_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE disorder_sign_symptom (
  disorder_id int NOT NULL REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (disorder_id, sign_symptom_id)
);

CREATE TABLE author (
  author_id int PRIMARY KEY NOT NULL NOT NULL,
  first_initial text CHECK (char_length(first_initial) = 1), -- surname is the most important one, initials can be null
  middle_initial text CHECK (char_length(middle_initial) = 1),
  surname text NOT NULL
);

CREATE TABLE disorder_reference_author (
  disorder_reference_id int NOT NULL REFERENCES disorder_reference (disorder_reference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  author_id int NOT NULL REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (disorder_reference_id, author_id),
  rank int,
  UNIQUE (disorder_reference_id, rank)
);

CREATE TABLE neutral_construct (
  neutral_construct_id int PRIMARY KEY NOT NULL,
  name text NOT NULL
);

-- neutral_contruct is not null, but in the many-to-many relationships, it can be null, thus it is not specified NOT NULL in the following relationship table
CREATE TABLE sign_symptom_neutral_construct (
  sign_symptom_id int REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  neutral_construct_id int REFERENCES neutral_construct (neutral_construct_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (sign_symptom_id, neutral_construct_id)
);

CREATE TABLE sign_symptom_example (
  sign_symptom_example_id int PRIMARY KEY NOT NULL,
  name text NOT NULL
);

CREATE TABLE sign_symptom_with_example (
  sign_symptom_id int NOT NULL REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_example_id int NOT NULL REFERENCES sign_symptom_example (sign_symptom_example_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (sign_symptom_id, sign_symptom_example_id)
);

CREATE TABLE assessment_reference (
  assessment_reference_id int PRIMARY KEY NOT NULL,
  title text NOT NULL,
  link text, -- possible empty verified
  pub_med_id int -- possible empty verified
);

-- possible empty authors in references
-- possible many authors for the same references
CREATE TABLE assessment_reference_author (
  assessment_reference_id int REFERENCES assessment_reference (assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE,
  author_id int REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (assessment_reference_id, author_id),
  rank int
);

CREATE TABLE questionnaire (
  questionnaire_id int PRIMARY KEY NOT NULL,
  title text NOT NULL,
  link text, -- possible empty verified
  description text, -- possible empty verified
  abbreviation text, -- possible empty verified
  age_max int, -- possible empty verified
  age_min int, -- possible empty verified
  number_of_questions int, -- possible empty verified
  minutes_to_complete int, -- possible empty verified
  license_id int NOT NULL,
  assessment_reference_id int REFERENCES assessment_reference (assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE -- possible empty verified
);

-- same question about empty in ManyToMany relationship
CREATE TABLE questionnaire_disorder (
  questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (questionnaire_id, disorder_id)
);

-- same
CREATE TABLE questionnaire_disorder_category (
  questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (questionnaire_id, disorder_category_id)
);

-- langauge will lead to an auto return of the line, thus I use language_source
CREATE TABLE language_source (
  language_source_id int PRIMARY KEY NOT NULL
);

-- not sure about NOT NULL rules here
CREATE TABLE questionnaire_language_source (
  questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  language_source_id int REFERENCES language_source (language_source_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (questionnaire_id, language_source_id)
);

-- same, possible empty
CREATE TABLE questionnaire_sign_symptom (
  questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (questionnaire_id, sign_symptom_id)
);

CREATE TABLE respondent (
  respondent_id int PRIMARY KEY NOT NULL
);

CREATE TABLE questionnaire_respondent (
  respondent_id int NOT NULL REFERENCES respondent (respondent_id) ON UPDATE CASCADE ON DELETE CASCADE,
  -- there is only one empty but highlighted in yellow, I assume it should be filled
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (respondent_id, questionnaire_id)
);

CREATE TABLE subject (
  subject_id int PRIMARY KEY NOT NULL
);

CREATE TABLE questionnaire_subject (
  subject_id int NOT NULL REFERENCES subject (subject_id) ON UPDATE CASCADE ON DELETE CASCADE,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (subject_id, questionnaire_id)
);

-- possible empty verified
-- should we allow multiple authors with the same rank for a given questionnaire? if yes, then that's fine
-- if no, then add UNIQUE (questionnaire_id, rank)
-- Verified: for a given questionnaire, there are multiple authors
CREATE TABLE questionnaire_author (
  author_id int REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (author_id, questionnaire_id),
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
  guide_type_id int NOT NULL REFERENCES guide_type (guide_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_reference_id int REFERENCES guide_reference (guide_reference_id) ON UPDATE CASCADE ON DELETE CASCADE
  -- this column is empty
);

--??? How can I specify ...in the following two ManytoMany relationships?
-- CHECK ((disorder_category_id IS NULL AND disorder_subcategory_id IS NOT NULL) OR (disorder_category_id IS NULL AND disorder_category_id IS NOT NULL))
CREATE TABLE guide_disorder (
  disorder_id int REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (disorder_id, guide_id)
);

CREATE TABLE guide_disorder_category (
  disorder_category_id int REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (disorder_category_id, guide_id)
);

CREATE TABLE resource_people_audience (
  audience_id int PRIMARY KEY NOT NULL,
  person text NOT NULL
);

-- SAME, possible empty in ManyToMany relationship
CREATE TABLE guide_audience (
  audience_id int REFERENCES resource_people_audience (audience_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (audience_id, guide_id)
);

-- SAME, possible empty in ManyToMany relationship
-- possible many authors for the same references
CREATE TABLE guide_author (
  author_id int REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (author_id, guide_id),
  rank int
);

CREATE TABLE response_type (
  response_type_id int PRIMARY KEY NOT NULL NOT NULL,
  type text NOT NULL,
  response_type_definition text NOT NULL
);

CREATE TABLE response_option (
  response_option_id int PRIMARY KEY NOT NULL NOT NULL,
  option_context text NOT NULL
);

CREATE TABLE question (
  question_id int PRIMARY KEY NOT NULL,
  questionnaire_id int NOT NULL REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  paper_instruction_preamble text, -- possible empty verified
  digital_instruction_preamble text, -- possible empty verified
  paper_instruction text, -- possible empty verified
  digital_instruction text, -- possible empty verified
  question_context text NOT NULL,
  response_type_id int NOT NULL REFERENCES response_type (response_type_id) ON UPDATE CASCADE ON DELETE CASCADE,
  response_option_id int REFERENCES response_option (response_option_id) ON UPDATE CASCADE ON DELETE CASCADE
  -- possible empty verified
);

CREATE TABLE task (
  task_id int PRIMARY KEY NOT NULL NOT NULL,
  name text NOT NULL,
  description text, -- one empty verified, maybe it should be filled and then change to NOT NULL
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
  description text,
  intervention_index int REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE accommodation (
  accommodation_id int PRIMARY KEY NOT NULL NOT NULL,
  name text NOT NULL,
  description text,
  accommodation_index int REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE technology (
  technology_id int PRIMARY KEY,
  name text,
  description text,
  link text
);

CREATE TABLE disorder_intervention (
  intervention_id int REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (intervention_id, disorder_id)
);

CREATE TABLE disorder_accommodation (
  accommodation_id int REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (accommodation_id, disorder_id)
);

CREATE TABLE disorder_technology (
  technology_id int REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_id int REFERENCES disorder (disorder_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (technology_id, disorder_id)
);

CREATE TABLE disorder_category_intervention (
  intervention_id int REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (intervention_id, disorder_category_id)
);

CREATE TABLE disorder_category_accommodation (
  accommodation_id int REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (accommodation_id, disorder_category_id)
);

CREATE TABLE disorder_category_technology (
  technology_id int REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  disorder_category_id int REFERENCES disorder_category (disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (technology_id, disorder_category_id)
);

CREATE TABLE sign_symptom_intervention (
  intervention_id int REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (intervention_id, sign_symptom_id)
);

CREATE TABLE sign_symptom_accommodation (
  accommodation_id int REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (accommodation_id, sign_symptom_id)
);

CREATE TABLE sign_symptom_technology (
  technology_id int REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  sign_symptom_id int REFERENCES sign_symptom (sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (technology_id, sign_symptom_id)
);

CREATE TABLE guide_intervention (
  intervention_id int REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (intervention_id, guide_id)
);

CREATE TABLE guide_accommodation (
  accommodation_id int REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (accommodation_id, guide_id)
);

CREATE TABLE guide_technology (
  technology_id int REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (technology_id, guide_id)
);

CREATE TABLE research_evidence (
  research_evidence_id int PRIMARY KEY,
  context text NOT NULL
);

CREATE TABLE intervention_research_evidence (
  intervention_id int REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  research_evidence_id int REFERENCES research_evidence (research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (intervention_id, research_evidence_id)
);

CREATE TABLE accommodation_research_evidence (
  accommodation_id int REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  research_evidence_id int REFERENCES research_evidence (research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (accommodation_id, research_evidence_id)
);

CREATE TABLE technology_research_evidence (
  technology_id int REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  research_evidence_id int REFERENCES research_evidence (research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (technology_id, research_evidence_id)
);

CREATE TABLE behaviour_intervention (
  intervention_id int REFERENCES intervention (intervention_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (intervention_id, behaviour_id)
);

CREATE TABLE behaviour_accommodation (
  accommodation_id int REFERENCES accommodation (accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (accommodation_id, behaviour_id)
);

CREATE TABLE behaviour_technology (
  technology_id int REFERENCES technology (technology_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (technology_id, behaviour_id)
);

CREATE TABLE behaviour_guide (
  guide_id int REFERENCES guide (guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (guide_id, behaviour_id)
);

CREATE TABLE behaviour_questionnaire (
  questionnaire_id int REFERENCES questionnaire (questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE,
  behaviour_id int REFERENCES state_domain_behaviour (behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (questionnaire_id, behaviour_id)
);

