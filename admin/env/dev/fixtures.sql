BEGIN;

INSERT INTO locale (
  locale_id,
  name)
VALUES (
  'en',
  'English'),
(
  'fr',
  'French');

INSERT INTO lisa_domain (
  domain_id)
VALUES (
  'attention'),
(
  'reading');

INSERT INTO lisa_domain_locale (
  domain_id,
  locale_id,
  name,
  description)
VALUES (
  'attention',
  'en',
  'Attention',
  'Attention is the behavioral and cognitive process of selectively concentrating on a discrete aspect of information, whether considered subjective or objective, while ignoring other perceivable information.'),
(
  'attention',
  'fr',
  'Atention',
  'L''attention est la faculté de l''esprit de se consacrer à un objet : d''utiliser ses capacités à l''observation, l''étude, le jugement d''une chose quelle qu''elle soit,
  ou encore à la pratique d''une action.'),
(
  'reading',
  'en',
  'Reading',
  'Reading is the process of taking in the sense or meaning of letters, symbols, etc., especially by sight or touch.');

COMMIT;

