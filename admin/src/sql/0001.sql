BEGIN;

CREATE TABLE locale (
  locale_id text NOT NULL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE lisa_domain (
  domain_id text NOT NULL PRIMARY KEY
);

CREATE TABLE lisa_subdomain (
  subdomain_id text NOT NULL PRIMARY KEY,
  domain_id text NOT NULL REFERENCES lisa_domain (domain_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE lisa_guide (
  lisa_guide_id text NOT NULL PRIMARY KEY
);

CREATE TABLE lisa_domain_locale (
  domain_id text NOT NULL REFERENCES lisa_domain (domain_id) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (domain_id, locale_id),
  name text NOT NULL,
  description text NOT NULL
);

CREATE TABLE lisa_subdomain_locale (
  subdomain_id text NOT NULL REFERENCES lisa_subdomain (subdomain_id) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (subdomain_id, locale_id),
  name text NOT NULL,
  description text NOT NULL
);

CREATE TABLE lisa_guide_locale (
  lisa_guide_id text REFERENCES lisa_guide (lisa_guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (lisa_guide_id, locale_id),
  name text,
  description text
);

CREATE TABLE lisa_subdomain_guide (
  subdomain_id text REFERENCES lisa_subdomain (subdomain_id) ON UPDATE CASCADE ON DELETE CASCADE,
  lisa_guide_id text REFERENCES lisa_guide (lisa_guide_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (subdomain_id, lisa_guide_id),
  rank int NOT NULL UNIQUE,
  UNIQUE (lisa_guide_id, rank)
);

CREATE TABLE lisa_subdomain_guide_locale (
  rank int NOT NULL REFERENCES lisa_subdomain_guide (rank) ON UPDATE CASCADE ON DELETE CASCADE,
  locale_id text NOT NULL REFERENCES locale (locale_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (rank, locale_id)
);

COMMIT;

