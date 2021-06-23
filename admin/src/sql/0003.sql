BEGIN;

ALTER TABLE lisa_domain_guide_locale
  ADD COLUMN lisa_domain_guide_id uuid REFERENCES lisa_domain_guide (lisa_domain_guide_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_domain_guide_locale
SET
  lisa_domain_guide_id = (
    SELECT
      lisa_domain_guide_id
    FROM
      lisa_domain_guide
    WHERE
      lisa_domain_guide_locale.lisa_guide_id = lisa_domain_guide.lisa_guide_id
      AND lisa_domain_guide_locale.domain_id = lisa_domain_guide.domain_id);

ALTER TABLE lisa_domain_guide_locale
  ALTER COLUMN lisa_domain_guide_id SET NOT NULL,
  DROP COLUMN lisa_guide_id,
  DROP COLUMN domain_id;

ALTER TABLE lisa_domain_locale_author
  ADD COLUMN lisa_domain_locale_id uuid REFERENCES lisa_domain_locale (lisa_domain_locale_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_domain_locale_author
SET
  lisa_domain_locale_id = (
    SELECT
      lisa_domain_locale_id
    FROM
      lisa_domain_locale
    WHERE
      lisa_domain_locale_author.locale_id = lisa_domain_locale.locale_id
      AND lisa_domain_locale_author.domain_id = lisa_domain_locale.domain_id);

ALTER TABLE lisa_domain_locale_author
  ALTER COLUMN lisa_domain_locale_id SET NOT NULL,
  DROP COLUMN locale_id,
  DROP COLUMN domain_id;

ALTER TABLE lisa_guide_locale_author
  ADD COLUMN lisa_guide_locale_id uuid REFERENCES lisa_guide_locale (lisa_guide_locale_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_guide_locale_author
SET
  lisa_guide_locale_id = (
    SELECT
      lisa_guide_locale_id
    FROM
      lisa_guide_locale
    WHERE
      lisa_guide_locale_author.locale_id = lisa_guide_locale.locale_id
      AND lisa_guide_locale_author.lisa_guide_id = lisa_guide_locale.lisa_guide_id);

ALTER TABLE lisa_guide_locale_author
  ALTER COLUMN lisa_guide_locale_id SET NOT NULL,
  DROP COLUMN locale_id,
  DROP COLUMN lisa_guide_id;

ALTER TABLE lisa_domain_category_locale_author
  ADD COLUMN lisa_domain_category_locale_id uuid REFERENCES lisa_domain_category_locale (lisa_domain_category_locale_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_domain_category_locale_author
SET
  lisa_domain_category_locale_id = (
    SELECT
      lisa_domain_category_locale_id
    FROM
      lisa_domain_category_locale
    WHERE
      lisa_domain_category_locale_author.locale_id = lisa_domain_category_locale.locale_id
      AND lisa_domain_category_locale_author.domain_category_id = lisa_domain_category_locale.domain_category_id);

ALTER TABLE lisa_domain_category_locale_author
  ALTER COLUMN lisa_domain_category_locale_id SET NOT NULL,
  DROP COLUMN locale_id,
  DROP COLUMN domain_category_id;

ALTER TABLE lisa_static_content_locale_version
  ADD COLUMN lisa_static_content_locale_id uuid REFERENCES lisa_static_content_locale (lisa_static_content_locale_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_static_content_locale_version
SET
  lisa_static_content_locale_id = (
    SELECT
      lisa_static_content_locale_id
    FROM
      lisa_static_content_locale
    WHERE
      lisa_static_content_locale_version.static_content_id = lisa_static_content_locale.static_content_id
      AND lisa_static_content_locale_version.locale_id = lisa_static_content_locale.locale_id);

ALTER TABLE lisa_static_content_locale_version
  ALTER COLUMN lisa_static_content_locale_id SET NOT NULL,
  DROP COLUMN static_content_id,
  DROP COLUMN locale_id;

ALTER TABLE lisa_guide_locale_version
  ADD COLUMN lisa_guide_locale_id uuid REFERENCES lisa_guide_locale (lisa_guide_locale_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_guide_locale_version
SET
  lisa_guide_locale_id = (
    SELECT
      lisa_guide_locale_id
    FROM
      lisa_guide_locale
    WHERE
      lisa_guide_locale_version.lisa_guide_id = lisa_guide_locale.lisa_guide_id
      AND lisa_guide_locale_version.locale_id = lisa_guide_locale.locale_id);

ALTER TABLE lisa_guide_locale_version
  ALTER COLUMN lisa_guide_locale_id SET NOT NULL,
  DROP COLUMN lisa_guide_id,
  DROP COLUMN locale_id;

ALTER TABLE lisa_domain_locale_version
  ADD COLUMN lisa_domain_locale_id uuid REFERENCES lisa_domain_locale (lisa_domain_locale_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_domain_locale_version
SET
  lisa_domain_locale_id = (
    SELECT
      lisa_domain_locale_id
    FROM
      lisa_domain_locale
    WHERE
      lisa_domain_locale_version.domain_id = lisa_domain_locale.domain_id
      AND lisa_domain_locale_version.locale_id = lisa_domain_locale.locale_id);

ALTER TABLE lisa_domain_locale_version
  ALTER COLUMN lisa_domain_locale_id SET NOT NULL,
  DROP COLUMN domain_id,
  DROP COLUMN locale_id;

ALTER TABLE lisa_domain_category_locale_version
  ADD COLUMN lisa_domain_category_locale_id uuid REFERENCES lisa_domain_category_locale (lisa_domain_category_locale_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  lisa_domain_category_locale_version
SET
  lisa_domain_category_locale_id = (
    SELECT
      lisa_domain_category_locale_id
    FROM
      lisa_domain_category_locale
    WHERE
      lisa_domain_category_locale_version.domain_category_id = lisa_domain_category_locale.domain_category_id
      AND lisa_domain_category_locale_version.locale_id = lisa_domain_category_locale.locale_id);

ALTER TABLE lisa_domain_category_locale_version
  ALTER COLUMN lisa_domain_category_locale_id SET NOT NULL,
  DROP COLUMN domain_category_id,
  DROP COLUMN locale_id;

ALTER TABLE guide_author
  ADD COLUMN author_id uuid REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  guide_author
SET
  author_id = (
    SELECT
      author_id
    FROM
      author
    WHERE
      guide_author.author_first_initial = author.first_initial
      AND guide_author.author_middle_initial = author.middle_initial
      AND guide_author.author_surname = author.surname);

ALTER TABLE guide_author
  ALTER COLUMN author_id SET NOT NULL,
  DROP COLUMN author_first_initial,
  DROP COLUMN author_middle_initial,
  DROP COLUMN author_surname;

ALTER TABLE questionnaire_author
  ADD COLUMN author_id uuid REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  questionnaire_author
SET
  author_id = (
    SELECT
      author_id
    FROM
      author
    WHERE
      questionnaire_author.author_first_initial = author.first_initial
      AND questionnaire_author.author_middle_initial = author.middle_initial
      AND questionnaire_author.author_surname = author.surname);

ALTER TABLE questionnaire_author
  ALTER COLUMN author_id SET NOT NULL,
  DROP COLUMN author_first_initial,
  DROP COLUMN author_middle_initial,
  DROP COLUMN author_surname;

ALTER TABLE assessment_reference_author
  ADD COLUMN author_id uuid REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  assessment_reference_author
SET
  author_id = (
    SELECT
      author_id
    FROM
      author
    WHERE
      assessment_reference_author.author_first_initial = author.first_initial
      AND assessment_reference_author.author_middle_initial = author.middle_initial
      AND assessment_reference_author.author_surname = author.surname);

ALTER TABLE assessment_reference_author
  ALTER COLUMN author_id SET NOT NULL,
  DROP COLUMN author_first_initial,
  DROP COLUMN author_middle_initial,
  DROP COLUMN author_surname;

ALTER TABLE disorder_reference_author
  ADD COLUMN author_id uuid REFERENCES author (author_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE
  disorder_reference_author
SET
  author_id = (
    SELECT
      author_id
    FROM
      author
    WHERE
      disorder_reference_author.author_first_initial = author.first_initial
      AND disorder_reference_author.author_middle_initial = author.middle_initial
      AND disorder_reference_author.author_surname = author.surname);

ALTER TABLE disorder_reference_author
  ALTER COLUMN author_id SET NOT NULL,
  DROP COLUMN author_first_initial,
  DROP COLUMN author_middle_initial,
  DROP COLUMN author_surname;

COMMIT;

