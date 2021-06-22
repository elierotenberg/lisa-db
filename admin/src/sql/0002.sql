BEGIN;

ALTER TABLE lisa_domain RENAME TO lisa_domain_category;

ALTER TABLE lisa_domain_category RENAME COLUMN domain_id TO domain_category_id;

ALTER TABLE lisa_subdomain RENAME TO lisa_domain;

ALTER TABLE lisa_domain RENAME COLUMN domain_id TO domain_category_id;

ALTER TABLE lisa_domain RENAME COLUMN subdomain_id TO domain_id;

ALTER TABLE lisa_domain_locale RENAME TO lisa_domain_category_locale;

ALTER TABLE lisa_domain_category_locale RENAME COLUMN domain_id TO domain_category_id;

ALTER TABLE lisa_domain_category_locale
  DROP CONSTRAINT lisa_domain_locale_pkey,
  DROP COLUMN name,
  DROP COLUMN description,
  ADD CONSTRAINT lisa_domain_locale_category_unique UNIQUE (domain_category_id, locale_id),
  ADD COLUMN lisa_domain_category_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE lisa_subdomain_locale RENAME TO lisa_domain_locale;

ALTER TABLE lisa_domain_locale RENAME COLUMN subdomain_id TO domain_id;

ALTER TABLE lisa_domain_locale
  DROP CONSTRAINT lisa_subdomain_locale_pkey,
  DROP COLUMN name,
  DROP COLUMN description,
  ADD CONSTRAINT lisa_domain_locale_unique UNIQUE (domain_id, locale_id),
  ADD COLUMN lisa_domain_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE lisa_guide_locale
  DROP CONSTRAINT lisa_guide_locale_pkey,
  DROP COLUMN name,
  DROP COLUMN description,
  ADD CONSTRAINT lisa_guide_locale_unique UNIQUE (lisa_guide_id, locale_id),
  ADD COLUMN lisa_guide_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE lisa_subdomain_guide RENAME TO lisa_domain_guide;

ALTER TABLE lisa_domain_guide RENAME COLUMN subdomain_id TO domain_id;

ALTER TABLE lisa_domain_guide
  DROP CONSTRAINT lisa_subdomain_guide_pkey,
  DROP CONSTRAINT lisa_subdomain_guide_lisa_guide_id_rank_key,
  DROP COLUMN rank CASCADE,
  ADD CONSTRAINT lisa_domain_guide_unique UNIQUE (lisa_guide_id, domain_id),
  ADD COLUMN lisa_domain_guide_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE lisa_subdomain_guide_locale RENAME TO lisa_domain_guide_locale;

ALTER TABLE lisa_domain_guide_locale
  DROP CONSTRAINT lisa_subdomain_guide_locale_pkey,
  DROP COLUMN rank,
  ADD COLUMN lisa_domain_guide_locale_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  ADD COLUMN lisa_guide_id text NOT NULL,
  ADD COLUMN domain_id text NOT NULL,
  ADD CONSTRAINT lisa_domain_guide_locale_lisa_domain_guide_fkey FOREIGN KEY (lisa_guide_id, domain_id) REFERENCES lisa_domain_guide (lisa_guide_id, domain_id) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT lisa_doamin_guide_locale_unique UNIQUE (locale_id, lisa_guide_id, domain_id);

CREATE TABLE lisa_static_content (
  static_content_id text NOT NULL PRIMARY KEY
);

CREATE TABLE lisa_author (
  lisa_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_author_first_name text NOT NULL,
  lisa_author_last_name text NOT NULL
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
  domain_category_id text NOT NULL,
  locale_id text NOT NULL,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (domain_category_id, locale_id, created_at),
  FOREIGN KEY (domain_category_id, locale_id) REFERENCES lisa_domain_category_locale (domain_category_id, locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_domain_locale_version (
  lisa_domain_locale_version_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  domain_id text NOT NULL,
  locale_id text NOT NULL,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (domain_id, locale_id, created_at),
  FOREIGN KEY (domain_id, locale_id) REFERENCES lisa_domain_locale (domain_id, locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_guide_locale_version (
  lisa_guide_locale_version_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_guide_id text NOT NULL,
  locale_id text NOT NULL,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (lisa_guide_id, locale_id, created_at),
  FOREIGN KEY (lisa_guide_id, locale_id) REFERENCES lisa_guide_locale (lisa_guide_id, locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_static_content_locale_version (
  lisa_static_content_locale_version_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  static_content_id text NOT NULL,
  locale_id text NOT NULL,
  created_at timestamp with time zone NOT NULL,
  name text NOT NULL,
  content_markdown text NOT NULL,
  created_by uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE (static_content_id, locale_id, created_at),
  FOREIGN KEY (static_content_id, locale_id) REFERENCES lisa_static_content_locale (static_content_id, locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_domain_category_locale_author (
  lisa_domain_category_locale_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  domain_category_id text NOT NULL,
  locale_id text NOT NULL,
  lisa_author_id uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int,
  UNIQUE (domain_category_id, locale_id, lisa_author_id),
  FOREIGN KEY (domain_category_id, locale_id) REFERENCES lisa_domain_category_locale (domain_category_id, locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_guide_locale_author (
  lisa_guide_locale_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  lisa_guide_id text NOT NULL,
  locale_id text NOT NULL,
  lisa_author_id uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int,
  UNIQUE (lisa_guide_id, locale_id, lisa_author_id),
  FOREIGN KEY (lisa_guide_id, locale_id) REFERENCES lisa_guide_locale (lisa_guide_id, locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_domain_locale_author (
  lisa_domain_locale_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY,
  domain_id text NOT NULL,
  locale_id text NOT NULL,
  lisa_author_id uuid NOT NULL REFERENCES lisa_author (lisa_author_id) ON UPDATE CASCADE ON DELETE CASCADE,
  rank int,
  UNIQUE (domain_id, locale_id, lisa_author_id),
  FOREIGN KEY (domain_id, locale_id) REFERENCES lisa_domain_locale (domain_id, locale_id) ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE disorder_sign_symptom
  DROP CONSTRAINT disorder_sign_symptom_pkey,
  ADD CONSTRAINT disorder_sign_symptom_unique UNIQUE (disorder_id, sign_symptom_id),
  ADD COLUMN disorder_sign_symptom_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE author
  DROP CONSTRAINT author_pkey CASCADE,
  ADD CONSTRAINT author_unique UNIQUE (first_initial, middle_initial, surname),
  ADD COLUMN author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE disorder_reference_author
  DROP CONSTRAINT disorder_reference_author_pkey,
  ADD CONSTRAINT disorder_reference_author_unique UNIQUE (disorder_reference_id, author_first_initial, author_middle_initial, author_surname),
  ADD COLUMN disorder_reference_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE sign_symptom_neutral_construct
  DROP CONSTRAINT sign_symptom_neutral_construct_pkey,
  ADD CONSTRAINT sign_symptom_neutral_construct_unique UNIQUE (sign_symptom_id, name),
  ADD COLUMN sign_symptom_neutral_construct_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE sign_symptom_with_example
  DROP CONSTRAINT sign_symptom_with_example_pkey,
  ADD CONSTRAINT sign_symptom_with_example_unique UNIQUE (sign_symptom_id, sign_symptom_example_id),
  ADD COLUMN sign_symptom_with_example_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE assessment_reference_author
  DROP CONSTRAINT assessment_reference_author_pkey,
  ADD CONSTRAINT assessment_reference_author_unique UNIQUE (assessment_reference_id, author_first_initial, author_middle_initial, author_surname),
  ADD COLUMN assessment_reference_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_language_not_mhdb
  DROP CONSTRAINT questionnaire_language_not_mhdb_pkey,
  ADD CONSTRAINT questionnaire_language_not_mhdb_unique UNIQUE (questionnaire_id, language_source_id),
  ADD COLUMN questionnaire_language_not_mhdb_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_disorder
  DROP CONSTRAINT questionnaire_disorder_pkey,
  ADD CONSTRAINT questionnaire_disorder_unique UNIQUE (questionnaire_id, disorder_id),
  ADD COLUMN questionnaire_disorder_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_disorder_category
  DROP CONSTRAINT questionnaire_disorder_category_pkey,
  ADD CONSTRAINT questionnaire_disorder_category_unique UNIQUE (questionnaire_id, disorder_category_id),
  ADD COLUMN questionnaire_disorder_category_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_sign_symptom
  DROP CONSTRAINT questionnaire_sign_symptom_pkey,
  ADD CONSTRAINT questionnaire_sign_symptom_unique UNIQUE (questionnaire_id, sign_symptom_id),
  ADD COLUMN questionnaire_sign_symptom_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_respondent
  DROP CONSTRAINT questionnaire_respondent_pkey,
  ADD CONSTRAINT questionnaire_respondent_unique UNIQUE (respondent_id, questionnaire_id),
  ADD COLUMN questionnaire_respondent_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_subject
  DROP CONSTRAINT questionnaire_subject_pkey,
  ADD CONSTRAINT questionnaire_subject_unique UNIQUE (subject_id, questionnaire_id),
  ADD COLUMN questionnaire_subject_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_assessment_reference
  DROP CONSTRAINT questionnaire_assessment_reference_pkey,
  ADD CONSTRAINT questionnaire_assessment_reference_unique UNIQUE (assessment_reference_id, questionnaire_id),
  ADD COLUMN questionnaire_assessment_reference_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE questionnaire_author
  DROP CONSTRAINT questionnaire_author_pkey,
  ADD CONSTRAINT questionnaire_author_unique UNIQUE (questionnaire_id, author_first_initial, author_middle_initial, author_surname),
  ADD COLUMN questionnaire_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_guide_type
  DROP CONSTRAINT guide_guide_type_pkey,
  ADD CONSTRAINT guide_guide_type_unique UNIQUE (guide_type_id, guide_id),
  ADD COLUMN guide_guide_type_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_disorder
  DROP CONSTRAINT guide_disorder_pkey,
  ADD CONSTRAINT guide_disorder_unique UNIQUE (disorder_id, guide_id),
  ADD COLUMN guide_disorder_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_disorder_category
  DROP CONSTRAINT guide_disorder_category_pkey,
  ADD CONSTRAINT guide_disorder_category_unique UNIQUE (disorder_category_id, guide_id),
  ADD COLUMN guide_disorder_category_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_audience
  DROP CONSTRAINT guide_audience_pkey,
  ADD CONSTRAINT guide_audience_unique UNIQUE (audience_id, guide_id),
  ADD COLUMN guide_audience_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_author
  DROP CONSTRAINT guide_author_pkey,
  ADD CONSTRAINT guide_author_unique UNIQUE (author_first_initial, author_middle_initial, author_surname, guide_id),
  ADD COLUMN guide_author_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE question_response_type
  DROP CONSTRAINT question_response_type_pkey,
  ADD CONSTRAINT question_response_type_unique UNIQUE (response_type_id, question_id),
  ADD COLUMN question_response_type_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE disorder_intervention
  DROP CONSTRAINT disorder_intervention_pkey,
  ADD CONSTRAINT disorder_intervention_unique UNIQUE (intervention_id, disorder_id),
  ADD COLUMN disorder_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE disorder_accommodation
  DROP CONSTRAINT disorder_accommodation_pkey,
  ADD CONSTRAINT disorder_accommodation_unique UNIQUE (accommodation_id, disorder_id),
  ADD COLUMN disorder_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE disorder_technology
  DROP CONSTRAINT disorder_technology_pkey,
  ADD CONSTRAINT disorder_technology_unique UNIQUE (technology_id, disorder_id),
  ADD COLUMN disorder_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE disorder_category_intervention
  DROP CONSTRAINT disorder_category_intervention_pkey,
  ADD CONSTRAINT disorder_category_intervention_unique UNIQUE (intervention_id, disorder_category_id),
  ADD COLUMN disorder_category_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE disorder_category_accommodation
  DROP CONSTRAINT disorder_category_accommodation_pkey,
  ADD CONSTRAINT disorder_category_accommodation_unique UNIQUE (accommodation_id, disorder_category_id),
  ADD COLUMN disorder_category_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE disorder_category_technology
  DROP CONSTRAINT disorder_category_technology_pkey,
  ADD CONSTRAINT disorder_category_technology_unique UNIQUE (technology_id, disorder_category_id),
  ADD COLUMN disorder_category_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE sign_symptom_intervention
  DROP CONSTRAINT sign_symptom_intervention_pkey,
  ADD CONSTRAINT sign_symptom_intervention_unique UNIQUE (intervention_id, sign_symptom_id),
  ADD COLUMN sign_symptom_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE sign_symptom_accommodation
  DROP CONSTRAINT sign_symptom_accommodation_pkey,
  ADD CONSTRAINT sign_symptom_accommodation_unique UNIQUE (accommodation_id, sign_symptom_id),
  ADD COLUMN sign_symptom_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE sign_symptom_technology
  DROP CONSTRAINT sign_symptom_technology_pkey,
  ADD CONSTRAINT sign_symptom_technology_unique UNIQUE (technology_id, sign_symptom_id),
  ADD COLUMN sign_symptom_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_intervention
  DROP CONSTRAINT guide_intervention_pkey,
  ADD CONSTRAINT guide_intervention_unique UNIQUE (intervention_id, guide_id),
  ADD COLUMN guide_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_accommodation
  DROP CONSTRAINT guide_accommodation_pkey,
  ADD CONSTRAINT guide_accommodation_unique UNIQUE (accommodation_id, guide_id),
  ADD COLUMN guide_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE guide_technology
  DROP CONSTRAINT guide_technology_pkey,
  ADD CONSTRAINT guide_technology_unique UNIQUE (technology_id, guide_id),
  ADD COLUMN guide_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE intervention_research_evidence
  DROP CONSTRAINT intervention_research_evidence_pkey,
  ADD CONSTRAINT intervention_research_evidence_unique UNIQUE (intervention_id, research_evidence_id),
  ADD COLUMN intervention_research_evidence_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE accommodation_research_evidence
  DROP CONSTRAINT accommodation_research_evidence_pkey,
  ADD CONSTRAINT accommodation_research_evidence_unique UNIQUE (accommodation_id, research_evidence_id),
  ADD COLUMN accommodation_research_evidence_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE technology_research_evidence
  DROP CONSTRAINT technology_research_evidence_pkey,
  ADD CONSTRAINT technology_research_evidence_unique UNIQUE (technology_id, research_evidence_id),
  ADD COLUMN technology_research_evidence_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE behaviour_intervention
  DROP CONSTRAINT behaviour_intervention_pkey,
  ADD CONSTRAINT behaviour_intervention_unique UNIQUE (intervention_id, behaviour_id),
  ADD COLUMN behaviour_intervention_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE behaviour_accommodation
  DROP CONSTRAINT behaviour_accommodation_pkey,
  ADD CONSTRAINT behaviour_accommodation_unique UNIQUE (accommodation_id, behaviour_id),
  ADD COLUMN behaviour_accommodation_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE behaviour_technology
  DROP CONSTRAINT behaviour_technology_pkey,
  ADD CONSTRAINT behaviour_technology_unique UNIQUE (technology_id, behaviour_id),
  ADD COLUMN behaviour_technology_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE behaviour_guide
  DROP CONSTRAINT behaviour_guide_pkey,
  ADD CONSTRAINT behaviour_guide_unique UNIQUE (guide_id, behaviour_id),
  ADD COLUMN behaviour_guide_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

ALTER TABLE behaviour_questionnaire
  DROP CONSTRAINT behaviour_questionnaire_pkey,
  ADD CONSTRAINT behaviour_questionnaire_unique UNIQUE (questionnaire_id, behaviour_id),
  ADD COLUMN behaviour_questionnaire_id uuid NOT NULL DEFAULT gen_random_uuid () PRIMARY KEY;

COMMIT;

