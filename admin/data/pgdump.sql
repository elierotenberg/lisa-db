-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accommodation; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.accommodation (
    accommodation_id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public.accommodation OWNER TO "lisa-db-dev-user";

--
-- Name: accommodation_research_evidence; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.accommodation_research_evidence (
    accommodation_id integer NOT NULL,
    research_evidence_id integer NOT NULL
);


ALTER TABLE public.accommodation_research_evidence OWNER TO "lisa-db-dev-user";

--
-- Name: alias; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.alias (
    alias_id integer NOT NULL,
    task_id integer,
    name text NOT NULL
);


ALTER TABLE public.alias OWNER TO "lisa-db-dev-user";

--
-- Name: assessment_reference; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.assessment_reference (
    assessment_reference_id integer NOT NULL,
    title text NOT NULL,
    link text,
    pub_med_id integer
);


ALTER TABLE public.assessment_reference OWNER TO "lisa-db-dev-user";

--
-- Name: assessment_reference_author; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.assessment_reference_author (
    assessment_reference_id integer NOT NULL,
    author_first_initial text NOT NULL,
    author_middle_initial text NOT NULL,
    author_surname text NOT NULL,
    rank integer
);


ALTER TABLE public.assessment_reference_author OWNER TO "lisa-db-dev-user";

--
-- Name: author; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.author (
    first_initial text NOT NULL,
    middle_initial text NOT NULL,
    surname text NOT NULL,
    CONSTRAINT author_first_initial_check CHECK ((char_length(first_initial) = 1)),
    CONSTRAINT author_middle_initial_check CHECK (((char_length(middle_initial) = 0) OR (char_length(middle_initial) = 1)))
);


ALTER TABLE public.author OWNER TO "lisa-db-dev-user";

--
-- Name: behaviour_accommodation; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.behaviour_accommodation (
    accommodation_id integer NOT NULL,
    behaviour_id integer NOT NULL
);


ALTER TABLE public.behaviour_accommodation OWNER TO "lisa-db-dev-user";

--
-- Name: behaviour_guide; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.behaviour_guide (
    guide_id integer NOT NULL,
    behaviour_id integer NOT NULL
);


ALTER TABLE public.behaviour_guide OWNER TO "lisa-db-dev-user";

--
-- Name: behaviour_intervention; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.behaviour_intervention (
    intervention_id integer NOT NULL,
    behaviour_id integer NOT NULL
);


ALTER TABLE public.behaviour_intervention OWNER TO "lisa-db-dev-user";

--
-- Name: behaviour_questionnaire; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.behaviour_questionnaire (
    questionnaire_id integer NOT NULL,
    behaviour_id integer NOT NULL
);


ALTER TABLE public.behaviour_questionnaire OWNER TO "lisa-db-dev-user";

--
-- Name: behaviour_technology; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.behaviour_technology (
    technology_id integer NOT NULL,
    behaviour_id integer NOT NULL
);


ALTER TABLE public.behaviour_technology OWNER TO "lisa-db-dev-user";

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) NOT NULL,
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text
);


ALTER TABLE public.directus_activity OWNER TO "lisa-db-dev-user";

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json
);


ALTER TABLE public.directus_collections OWNER TO "lisa-db-dev-user";

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    "group" integer,
    translations json,
    note text
);


ALTER TABLE public.directus_fields OWNER TO "lisa-db-dev-user";

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize integer,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO "lisa-db-dev-user";

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO "lisa-db-dev-user";

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO "lisa-db-dev-user";

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    "limit" integer
);


ALTER TABLE public.directus_permissions OWNER TO "lisa-db-dev-user";

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    filters json,
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer
);


ALTER TABLE public.directus_presets OWNER TO "lisa-db-dev-user";

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO "lisa-db-dev-user";

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO "lisa-db-dev-user";

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    module_list json,
    collection_list json,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO "lisa-db-dev-user";

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO "lisa-db-dev-user";

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(10) DEFAULT '#00C897'::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text
);


ALTER TABLE public.directus_settings OWNER TO "lisa-db-dev-user";

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128) NOT NULL,
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(8) DEFAULT 'en-US'::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255)
);


ALTER TABLE public.directus_users OWNER TO "lisa-db-dev-user";

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url text,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections text
);


ALTER TABLE public.directus_webhooks OWNER TO "lisa-db-dev-user";

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa-db-dev-user
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO "lisa-db-dev-user";

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa-db-dev-user
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: disorder; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder (
    disorder_id integer NOT NULL,
    name text NOT NULL,
    disorder_category_id integer,
    disorder_subcategory_id integer,
    icd_9_cm text,
    icd_10_cm text,
    CONSTRAINT disorder_check CHECK (((disorder_category_id IS NOT NULL) OR (disorder_subcategory_id IS NOT NULL)))
);


ALTER TABLE public.disorder OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_accommodation; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_accommodation (
    accommodation_id integer NOT NULL,
    disorder_id integer NOT NULL
);


ALTER TABLE public.disorder_accommodation OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_category; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_category (
    disorder_category_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.disorder_category OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_category_accommodation; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_category_accommodation (
    accommodation_id integer NOT NULL,
    disorder_category_id integer NOT NULL
);


ALTER TABLE public.disorder_category_accommodation OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_category_intervention; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_category_intervention (
    intervention_id integer NOT NULL,
    disorder_category_id integer NOT NULL
);


ALTER TABLE public.disorder_category_intervention OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_category_technology; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_category_technology (
    technology_id integer NOT NULL,
    disorder_category_id integer NOT NULL
);


ALTER TABLE public.disorder_category_technology OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_intervention; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_intervention (
    intervention_id integer NOT NULL,
    disorder_id integer NOT NULL
);


ALTER TABLE public.disorder_intervention OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_reference; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_reference (
    disorder_reference_id integer NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.disorder_reference OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_reference_author; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_reference_author (
    disorder_reference_id integer NOT NULL,
    author_first_initial text NOT NULL,
    author_middle_initial text NOT NULL,
    author_surname text NOT NULL,
    rank integer
);


ALTER TABLE public.disorder_reference_author OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_sign_symptom; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_sign_symptom (
    disorder_id integer NOT NULL,
    sign_symptom_id integer NOT NULL
);


ALTER TABLE public.disorder_sign_symptom OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_subcategory; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_subcategory (
    disorder_subcategory_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.disorder_subcategory OWNER TO "lisa-db-dev-user";

--
-- Name: disorder_technology; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.disorder_technology (
    technology_id integer NOT NULL,
    disorder_id integer NOT NULL
);


ALTER TABLE public.disorder_technology OWNER TO "lisa-db-dev-user";

--
-- Name: guide; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide (
    guide_id integer NOT NULL,
    title text NOT NULL,
    link text NOT NULL,
    publisher text NOT NULL,
    guide_reference_id integer
);


ALTER TABLE public.guide OWNER TO "lisa-db-dev-user";

--
-- Name: guide_accommodation; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_accommodation (
    accommodation_id integer NOT NULL,
    guide_id integer NOT NULL
);


ALTER TABLE public.guide_accommodation OWNER TO "lisa-db-dev-user";

--
-- Name: guide_audience; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_audience (
    audience_id integer NOT NULL,
    guide_id integer NOT NULL
);


ALTER TABLE public.guide_audience OWNER TO "lisa-db-dev-user";

--
-- Name: guide_author; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_author (
    author_first_initial text NOT NULL,
    author_middle_initial text NOT NULL,
    author_surname text NOT NULL,
    guide_id integer NOT NULL,
    rank integer
);


ALTER TABLE public.guide_author OWNER TO "lisa-db-dev-user";

--
-- Name: guide_disorder; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_disorder (
    disorder_id integer NOT NULL,
    guide_id integer NOT NULL
);


ALTER TABLE public.guide_disorder OWNER TO "lisa-db-dev-user";

--
-- Name: guide_disorder_category; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_disorder_category (
    disorder_category_id integer NOT NULL,
    guide_id integer NOT NULL
);


ALTER TABLE public.guide_disorder_category OWNER TO "lisa-db-dev-user";

--
-- Name: guide_guide_type; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_guide_type (
    guide_type_id integer NOT NULL,
    guide_id integer NOT NULL
);


ALTER TABLE public.guide_guide_type OWNER TO "lisa-db-dev-user";

--
-- Name: guide_intervention; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_intervention (
    intervention_id integer NOT NULL,
    guide_id integer NOT NULL
);


ALTER TABLE public.guide_intervention OWNER TO "lisa-db-dev-user";

--
-- Name: guide_reference; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_reference (
    guide_reference_id integer NOT NULL,
    title text,
    link text,
    pub_med_id integer
);


ALTER TABLE public.guide_reference OWNER TO "lisa-db-dev-user";

--
-- Name: guide_technology; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_technology (
    technology_id integer NOT NULL,
    guide_id integer NOT NULL
);


ALTER TABLE public.guide_technology OWNER TO "lisa-db-dev-user";

--
-- Name: guide_type; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.guide_type (
    guide_type_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.guide_type OWNER TO "lisa-db-dev-user";

--
-- Name: intervention; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.intervention (
    intervention_id integer NOT NULL,
    name text,
    description text
);


ALTER TABLE public.intervention OWNER TO "lisa-db-dev-user";

--
-- Name: intervention_research_evidence; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.intervention_research_evidence (
    intervention_id integer NOT NULL,
    research_evidence_id integer NOT NULL
);


ALTER TABLE public.intervention_research_evidence OWNER TO "lisa-db-dev-user";

--
-- Name: language_source; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.language_source (
    language_source_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.language_source OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_domain; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_domain (
    domain_id text NOT NULL
);


ALTER TABLE public.lisa_domain OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_domain_locale; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_domain_locale (
    domain_id text NOT NULL,
    locale_id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.lisa_domain_locale OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_guide; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_guide (
    lisa_guide_id text NOT NULL
);


ALTER TABLE public.lisa_guide OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_guide_locale; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_guide_locale (
    lisa_guide_id text NOT NULL,
    locale_id text NOT NULL,
    name text,
    description text
);


ALTER TABLE public.lisa_guide_locale OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_subdomain; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_subdomain (
    subdomain_id text NOT NULL,
    domain_id text NOT NULL
);


ALTER TABLE public.lisa_subdomain OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_subdomain_guide; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_subdomain_guide (
    subdomain_id text NOT NULL,
    lisa_guide_id text NOT NULL,
    rank integer NOT NULL
);


ALTER TABLE public.lisa_subdomain_guide OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_subdomain_guide_locale; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_subdomain_guide_locale (
    rank integer NOT NULL,
    locale_id text NOT NULL
);


ALTER TABLE public.lisa_subdomain_guide_locale OWNER TO "lisa-db-dev-user";

--
-- Name: lisa_subdomain_locale; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.lisa_subdomain_locale (
    subdomain_id text NOT NULL,
    locale_id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.lisa_subdomain_locale OWNER TO "lisa-db-dev-user";

--
-- Name: locale; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.locale (
    locale_id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.locale OWNER TO "lisa-db-dev-user";

--
-- Name: neutral_construct; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.neutral_construct (
    name text NOT NULL
);


ALTER TABLE public.neutral_construct OWNER TO "lisa-db-dev-user";

--
-- Name: question; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.question (
    question_id integer NOT NULL,
    questionnaire_id integer,
    paper_instruction_preamble text,
    digital_instruction_preamble text,
    paper_instruction text,
    digital_instruction text,
    question_context text NOT NULL,
    response_option text
);


ALTER TABLE public.question OWNER TO "lisa-db-dev-user";

--
-- Name: question_response_type; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.question_response_type (
    response_type_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.question_response_type OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire (
    questionnaire_id integer NOT NULL,
    title text NOT NULL,
    link text,
    description text,
    abbreviation text,
    age_max integer,
    age_min integer,
    number_of_questions integer,
    minutes_to_complete integer,
    license_id integer NOT NULL,
    language_source_id integer NOT NULL
);


ALTER TABLE public.questionnaire OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_assessment_reference; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_assessment_reference (
    assessment_reference_id integer NOT NULL,
    questionnaire_id integer NOT NULL
);


ALTER TABLE public.questionnaire_assessment_reference OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_author; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_author (
    author_first_initial text NOT NULL,
    author_middle_initial text NOT NULL,
    author_surname text NOT NULL,
    questionnaire_id integer NOT NULL,
    rank integer
);


ALTER TABLE public.questionnaire_author OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_disorder; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_disorder (
    questionnaire_id integer NOT NULL,
    disorder_id integer NOT NULL
);


ALTER TABLE public.questionnaire_disorder OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_disorder_category; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_disorder_category (
    questionnaire_id integer NOT NULL,
    disorder_category_id integer NOT NULL
);


ALTER TABLE public.questionnaire_disorder_category OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_language_not_mhdb; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_language_not_mhdb (
    questionnaire_id integer NOT NULL,
    language_source_id integer NOT NULL
);


ALTER TABLE public.questionnaire_language_not_mhdb OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_respondent; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_respondent (
    respondent_id integer NOT NULL,
    questionnaire_id integer NOT NULL
);


ALTER TABLE public.questionnaire_respondent OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_sign_symptom; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_sign_symptom (
    questionnaire_id integer NOT NULL,
    sign_symptom_id integer NOT NULL
);


ALTER TABLE public.questionnaire_sign_symptom OWNER TO "lisa-db-dev-user";

--
-- Name: questionnaire_subject; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.questionnaire_subject (
    subject_id integer NOT NULL,
    questionnaire_id integer NOT NULL
);


ALTER TABLE public.questionnaire_subject OWNER TO "lisa-db-dev-user";

--
-- Name: research_evidence; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.research_evidence (
    research_evidence_id integer NOT NULL,
    context text NOT NULL
);


ALTER TABLE public.research_evidence OWNER TO "lisa-db-dev-user";

--
-- Name: resource_people_audience; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.resource_people_audience (
    audience_id integer NOT NULL,
    person text NOT NULL
);


ALTER TABLE public.resource_people_audience OWNER TO "lisa-db-dev-user";

--
-- Name: response_type; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.response_type (
    response_type_id integer NOT NULL,
    type text NOT NULL,
    response_type_definition text NOT NULL
);


ALTER TABLE public.response_type OWNER TO "lisa-db-dev-user";

--
-- Name: sign_symptom; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.sign_symptom (
    sign_symptom_id integer NOT NULL,
    name text NOT NULL,
    underlying_behavior text,
    disorder_reference_id integer NOT NULL
);


ALTER TABLE public.sign_symptom OWNER TO "lisa-db-dev-user";

--
-- Name: sign_symptom_accommodation; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.sign_symptom_accommodation (
    accommodation_id integer NOT NULL,
    sign_symptom_id integer NOT NULL
);


ALTER TABLE public.sign_symptom_accommodation OWNER TO "lisa-db-dev-user";

--
-- Name: sign_symptom_example; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.sign_symptom_example (
    sign_symptom_example_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.sign_symptom_example OWNER TO "lisa-db-dev-user";

--
-- Name: sign_symptom_intervention; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.sign_symptom_intervention (
    intervention_id integer NOT NULL,
    sign_symptom_id integer NOT NULL
);


ALTER TABLE public.sign_symptom_intervention OWNER TO "lisa-db-dev-user";

--
-- Name: sign_symptom_neutral_construct; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.sign_symptom_neutral_construct (
    sign_symptom_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.sign_symptom_neutral_construct OWNER TO "lisa-db-dev-user";

--
-- Name: sign_symptom_technology; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.sign_symptom_technology (
    technology_id integer NOT NULL,
    sign_symptom_id integer NOT NULL
);


ALTER TABLE public.sign_symptom_technology OWNER TO "lisa-db-dev-user";

--
-- Name: sign_symptom_with_example; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.sign_symptom_with_example (
    sign_symptom_id integer NOT NULL,
    sign_symptom_example_id integer NOT NULL
);


ALTER TABLE public.sign_symptom_with_example OWNER TO "lisa-db-dev-user";

--
-- Name: state_domain_behaviour; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.state_domain_behaviour (
    behaviour_id integer NOT NULL,
    behaviour text NOT NULL
);


ALTER TABLE public.state_domain_behaviour OWNER TO "lisa-db-dev-user";

--
-- Name: task; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.task (
    task_id integer NOT NULL,
    name text NOT NULL,
    description text,
    assessment_reference_id integer NOT NULL
);


ALTER TABLE public.task OWNER TO "lisa-db-dev-user";

--
-- Name: technology; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.technology (
    technology_id integer NOT NULL,
    name text,
    description text,
    link text
);


ALTER TABLE public.technology OWNER TO "lisa-db-dev-user";

--
-- Name: technology_research_evidence; Type: TABLE; Schema: public; Owner: lisa-db-dev-user
--

CREATE TABLE public.technology_research_evidence (
    technology_id integer NOT NULL,
    research_evidence_id integer NOT NULL
);


ALTER TABLE public.technology_research_evidence OWNER TO "lisa-db-dev-user";

--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: accommodation; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.accommodation (accommodation_id, name, description) FROM stdin;
\.


--
-- Data for Name: accommodation_research_evidence; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.accommodation_research_evidence (accommodation_id, research_evidence_id) FROM stdin;
\.


--
-- Data for Name: alias; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.alias (alias_id, task_id, name) FROM stdin;
\.


--
-- Data for Name: assessment_reference; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.assessment_reference (assessment_reference_id, title, link, pub_med_id) FROM stdin;
\.


--
-- Data for Name: assessment_reference_author; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.assessment_reference_author (assessment_reference_id, author_first_initial, author_middle_initial, author_surname, rank) FROM stdin;
\.


--
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.author (first_initial, middle_initial, surname) FROM stdin;
\.


--
-- Data for Name: behaviour_accommodation; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.behaviour_accommodation (accommodation_id, behaviour_id) FROM stdin;
\.


--
-- Data for Name: behaviour_guide; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.behaviour_guide (guide_id, behaviour_id) FROM stdin;
\.


--
-- Data for Name: behaviour_intervention; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.behaviour_intervention (intervention_id, behaviour_id) FROM stdin;
\.


--
-- Data for Name: behaviour_questionnaire; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.behaviour_questionnaire (questionnaire_id, behaviour_id) FROM stdin;
\.


--
-- Data for Name: behaviour_technology; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.behaviour_technology (technology_id, behaviour_id) FROM stdin;
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) FROM stdin;
1	authenticate	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:26.089651+00	::ffff:192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_users	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	\N
2	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.663517+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_roles	0ee264f6-f91d-4df0-bd11-da49504ebb68	\N
3	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	1	\N
4	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	2	\N
5	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	3	\N
6	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	4	\N
7	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	5	\N
8	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	6	\N
9	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	7	\N
10	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	8	\N
11	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	9	\N
12	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	10	\N
13	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:40.748223+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	11	\N
14	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:45.457723+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	accommodation	\N
15	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:45.530685+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	12	\N
16	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:46.570618+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	accommodation_research_evidence	\N
17	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:46.642521+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	13	\N
18	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:47.503807+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	alias	\N
19	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:47.563746+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	14	\N
20	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:48.460381+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	assessment_reference	\N
21	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:48.533413+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	15	\N
22	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:49.638753+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	assessment_reference_author	\N
23	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:49.713634+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	16	\N
24	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:50.872008+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	author	\N
25	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:50.928089+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	17	\N
26	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:54.537803+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	behaviour_accommodation	\N
27	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:54.596384+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	18	\N
28	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:55.77035+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	behaviour_guide	\N
29	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:55.849517+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	19	\N
30	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:56.794102+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	behaviour_intervention	\N
31	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:56.86619+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	20	\N
32	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:57.859993+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	behaviour_questionnaire	\N
33	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:56:57.931966+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	21	\N
34	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:00.33237+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	behaviour_technology	\N
35	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:00.394835+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	22	\N
36	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:01.248455+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder	\N
37	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:01.311082+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	23	\N
38	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:02.40497+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_accommodation	\N
39	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:02.475108+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	24	\N
40	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:03.427452+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_category	\N
41	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:03.494405+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	25	\N
42	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:04.890874+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_category_accommodation	\N
43	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:04.96205+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	26	\N
44	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:06.698928+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_category_intervention	\N
45	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:06.764525+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	27	\N
46	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:07.869395+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_category_technology	\N
47	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:07.941142+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	28	\N
48	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:08.992404+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_intervention	\N
49	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:09.065886+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	29	\N
50	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:10.017232+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_reference	\N
51	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:10.082899+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	30	\N
52	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:11.003734+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_reference_author	\N
53	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:11.082267+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	31	\N
54	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:12.881942+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_sign_symptom	\N
55	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:12.944069+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	32	\N
56	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:13.907266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_subcategory	\N
57	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:13.98791+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	33	\N
58	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:15.158553+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	disorder_technology	\N
59	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:15.234441+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	34	\N
60	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:16.216828+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide	\N
61	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:16.278092+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	35	\N
62	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:18.645915+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_accommodation	\N
63	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:18.717249+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	36	\N
64	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:20.631048+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_audience	\N
65	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:20.69771+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	37	\N
66	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:21.591926+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_author	\N
67	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:21.668877+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	38	\N
68	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:22.746482+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_disorder	\N
69	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:22.814628+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	39	\N
70	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:23.711783+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_disorder_category	\N
71	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:23.784119+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	40	\N
72	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:24.927055+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_guide_type	\N
73	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:24.997996+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	41	\N
74	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:26.727467+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_intervention	\N
75	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:26.798252+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	42	\N
76	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:27.668209+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_reference	\N
77	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:27.72893+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	43	\N
78	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:28.946289+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_technology	\N
79	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:28.997484+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	44	\N
80	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:29.942872+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	guide_type	\N
81	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:30.016349+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	45	\N
82	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:33.264056+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	intervention	\N
83	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:33.337433+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	46	\N
84	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:34.224937+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	intervention_research_evidence	\N
85	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:34.331534+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	47	\N
86	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:35.383009+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	language_source	\N
87	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:35.448706+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	48	\N
88	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:36.291504+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_domain	\N
89	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:36.366286+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	49	\N
90	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:37.241148+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_domain_locale	\N
91	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:37.314911+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	50	\N
92	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:38.35392+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_guide	\N
93	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:38.430478+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	51	\N
94	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:41.750187+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_guide_locale	\N
95	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:41.803359+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	52	\N
96	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:43.963132+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_subdomain	\N
97	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:44.026848+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	53	\N
98	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:44.957026+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_subdomain_guide	\N
99	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:45.024337+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	54	\N
100	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:46.073413+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_subdomain_guide_locale	\N
101	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:46.147041+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	55	\N
102	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:47.215007+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	lisa_subdomain_locale	\N
103	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:47.280755+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	56	\N
104	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:48.656628+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	locale	\N
105	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:48.723758+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	57	\N
106	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:51.623053+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	neutral_construct	\N
107	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:51.696276+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	58	\N
108	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:53.31243+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	question	\N
109	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:53.411303+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	59	\N
110	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:54.649785+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	question_response_type	\N
111	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:54.725266+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	60	\N
112	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:55.732716+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire	\N
113	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:55.803643+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	61	\N
114	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:58.019253+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_assessment_reference	\N
115	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:58.085586+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	62	\N
116	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:59.198457+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_author	\N
117	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:57:59.272608+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	63	\N
118	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:00.585419+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_disorder	\N
119	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:00.667525+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	64	\N
120	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:02.465877+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_disorder_category	\N
121	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:02.53619+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	65	\N
122	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:03.532888+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_language_not_mhdb	\N
123	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:03.598407+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	66	\N
124	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:04.776951+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_respondent	\N
125	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:04.846531+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	67	\N
126	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:05.743757+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_sign_symptom	\N
127	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:05.812356+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	68	\N
128	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:08.19885+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	research_evidence	\N
129	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:08.261725+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	69	\N
130	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:09.40579+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	questionnaire_subject	\N
131	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:09.478668+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	70	\N
132	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:11.405201+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	resource_people_audience	\N
133	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:11.478055+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	71	\N
134	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:12.338361+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	response_type	\N
135	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:12.418871+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	72	\N
136	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:13.502397+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	sign_symptom	\N
137	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:13.575451+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	73	\N
138	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:14.587056+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	sign_symptom_accommodation	\N
139	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:14.65616+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	74	\N
140	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:15.668348+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	sign_symptom_example	\N
141	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:15.732939+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	75	\N
142	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:16.824875+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	sign_symptom_intervention	\N
143	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:16.893547+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	76	\N
144	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:17.825274+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	sign_symptom_neutral_construct	\N
145	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:17.897617+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	77	\N
146	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:21.054552+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	sign_symptom_technology	\N
147	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:21.115333+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	78	\N
148	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:22.521423+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	sign_symptom_with_example	\N
149	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:22.59255+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	79	\N
150	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:23.784528+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	state_domain_behaviour	\N
151	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:23.846385+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	80	\N
152	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:25.388094+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	task	\N
153	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:25.448988+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	81	\N
154	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:26.489543+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	technology	\N
155	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:26.558956+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	82	\N
156	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:28.079131+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_collections	technology_research_evidence	\N
157	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:58:28.148759+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_permissions	83	\N
158	create	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 06:59:09.729809+00	192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_users	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	\N
159	authenticate	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-15 14:00:49.741342+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_users	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	\N
160	authenticate	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-15 14:00:56.002068+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_users	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	\N
161	authenticate	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-15 14:01:01.911098+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_users	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	\N
162	authenticate	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-15 14:01:08.654703+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_users	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	\N
163	authenticate	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 14:01:31.821942+00	::ffff:192.168.224.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_users	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	\N
164	update	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-15 14:01:42.951279+00	192.168.224.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0	directus_users	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields) FROM stdin;
accommodation	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
accommodation_research_evidence	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
alias	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
assessment_reference	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
assessment_reference_author	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
author	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
behaviour_accommodation	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
behaviour_guide	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
behaviour_intervention	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
behaviour_questionnaire	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
behaviour_technology	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_accommodation	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_category	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_category_accommodation	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_category_intervention	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_category_technology	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_intervention	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_reference	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_reference_author	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_sign_symptom	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_subcategory	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
disorder_technology	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_accommodation	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_audience	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_author	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_disorder	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_disorder_category	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_guide_type	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_intervention	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_reference	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_technology	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
guide_type	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
intervention	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
intervention_research_evidence	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
language_source	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_domain	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_domain_locale	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_guide	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_guide_locale	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_subdomain	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_subdomain_guide	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_subdomain_guide_locale	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
lisa_subdomain_locale	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
locale	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
neutral_construct	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
question	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
question_response_type	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_assessment_reference	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_author	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_disorder	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_disorder_category	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_language_not_mhdb	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_respondent	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_sign_symptom	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
research_evidence	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
questionnaire_subject	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
resource_people_audience	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
response_type	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
sign_symptom	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
sign_symptom_accommodation	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
sign_symptom_example	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
sign_symptom_intervention	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
sign_symptom_neutral_construct	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
sign_symptom_technology	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
sign_symptom_with_example	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
state_domain_behaviour	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
task	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
technology	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
technology_research_evidence	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) FROM stdin;
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2021-06-15 06:56:19.824769+00
20201029A	Remove System Relations	2021-06-15 06:56:19.835585+00
20201029B	Remove System Collections	2021-06-15 06:56:19.842472+00
20201029C	Remove System Fields	2021-06-15 06:56:19.858847+00
20201105A	Add Cascade System Relations	2021-06-15 06:56:20.064705+00
20201105B	Change Webhook URL Type	2021-06-15 06:56:20.097932+00
20210225A	Add Relations Sort Field	2021-06-15 06:56:20.111983+00
20210304A	Remove Locked Fields	2021-06-15 06:56:20.124904+00
20210312A	Webhooks Collections Text	2021-06-15 06:56:20.149019+00
20210331A	Add Refresh Interval	2021-06-15 06:56:20.173885+00
20210415A	Make Filesize Nullable	2021-06-15 06:56:20.207615+00
20210416A	Add Collections Accountability	2021-06-15 06:56:20.221677+00
20210422A	Remove Files Interface	2021-06-15 06:56:20.226632+00
20210506A	Rename Interfaces	2021-06-15 06:56:20.266377+00
20210510A	Restructure Relations	2021-06-15 06:56:20.373657+00
20210518A	Add Foreign Key Constraints	2021-06-15 06:56:20.392178+00
20210519A	Add System Fk Triggers	2021-06-15 06:56:20.492657+00
20210521A	Add Collections Icon Color	2021-06-15 06:56:20.505056+00
20210608A	Add Deep Clone Config	2021-06-15 06:56:20.517469+00
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields, "limit") FROM stdin;
1	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_files	create	{}	\N	\N	*	\N
2	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_files	read	{}	\N	\N	*	\N
3	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_files	update	{}	\N	\N	*	\N
4	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_files	delete	{}	\N	\N	*	\N
5	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_folders	create	{}	\N	\N	*	\N
6	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_folders	read	{}	\N	\N	*	\N
7	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_folders	update	{}	\N	\N	*	\N
8	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_folders	delete	{}	\N	\N	\N	\N
9	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_users	read	{}	\N	\N	*	\N
10	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_users	update	{"id":{"_eq":"$CURRENT_USER"}}	\N	\N	first_name,last_name,email,password,location,title,description,avatar,language,theme	\N
11	0ee264f6-f91d-4df0-bd11-da49504ebb68	directus_roles	read	{}	\N	\N	*	\N
12	0ee264f6-f91d-4df0-bd11-da49504ebb68	accommodation	read	\N	\N	\N	*	\N
13	0ee264f6-f91d-4df0-bd11-da49504ebb68	accommodation_research_evidence	read	\N	\N	\N	*	\N
14	0ee264f6-f91d-4df0-bd11-da49504ebb68	alias	read	\N	\N	\N	*	\N
15	0ee264f6-f91d-4df0-bd11-da49504ebb68	assessment_reference	read	\N	\N	\N	*	\N
16	0ee264f6-f91d-4df0-bd11-da49504ebb68	assessment_reference_author	read	\N	\N	\N	*	\N
17	0ee264f6-f91d-4df0-bd11-da49504ebb68	author	read	\N	\N	\N	*	\N
18	0ee264f6-f91d-4df0-bd11-da49504ebb68	behaviour_accommodation	read	\N	\N	\N	*	\N
19	0ee264f6-f91d-4df0-bd11-da49504ebb68	behaviour_guide	read	\N	\N	\N	*	\N
20	0ee264f6-f91d-4df0-bd11-da49504ebb68	behaviour_intervention	read	\N	\N	\N	*	\N
21	0ee264f6-f91d-4df0-bd11-da49504ebb68	behaviour_questionnaire	read	\N	\N	\N	*	\N
22	0ee264f6-f91d-4df0-bd11-da49504ebb68	behaviour_technology	read	\N	\N	\N	*	\N
23	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder	read	\N	\N	\N	*	\N
24	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_accommodation	read	\N	\N	\N	*	\N
25	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_category	read	\N	\N	\N	*	\N
26	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_category_accommodation	read	\N	\N	\N	*	\N
27	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_category_intervention	read	\N	\N	\N	*	\N
28	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_category_technology	read	\N	\N	\N	*	\N
29	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_intervention	read	\N	\N	\N	*	\N
30	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_reference	read	\N	\N	\N	*	\N
31	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_reference_author	read	\N	\N	\N	*	\N
32	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_sign_symptom	read	\N	\N	\N	*	\N
33	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_subcategory	read	\N	\N	\N	*	\N
34	0ee264f6-f91d-4df0-bd11-da49504ebb68	disorder_technology	read	\N	\N	\N	*	\N
35	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide	read	\N	\N	\N	*	\N
36	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_accommodation	read	\N	\N	\N	*	\N
37	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_audience	read	\N	\N	\N	*	\N
38	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_author	read	\N	\N	\N	*	\N
39	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_disorder	read	\N	\N	\N	*	\N
40	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_disorder_category	read	\N	\N	\N	*	\N
41	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_guide_type	read	\N	\N	\N	*	\N
42	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_intervention	read	\N	\N	\N	*	\N
43	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_reference	read	\N	\N	\N	*	\N
44	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_technology	read	\N	\N	\N	*	\N
45	0ee264f6-f91d-4df0-bd11-da49504ebb68	guide_type	read	\N	\N	\N	*	\N
46	0ee264f6-f91d-4df0-bd11-da49504ebb68	intervention	read	\N	\N	\N	*	\N
47	0ee264f6-f91d-4df0-bd11-da49504ebb68	intervention_research_evidence	read	\N	\N	\N	*	\N
48	0ee264f6-f91d-4df0-bd11-da49504ebb68	language_source	read	\N	\N	\N	*	\N
49	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_domain	read	\N	\N	\N	*	\N
50	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_domain_locale	read	\N	\N	\N	*	\N
51	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_guide	read	\N	\N	\N	*	\N
52	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_guide_locale	read	\N	\N	\N	*	\N
53	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_subdomain	read	\N	\N	\N	*	\N
54	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_subdomain_guide	read	\N	\N	\N	*	\N
55	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_subdomain_guide_locale	read	\N	\N	\N	*	\N
56	0ee264f6-f91d-4df0-bd11-da49504ebb68	lisa_subdomain_locale	read	\N	\N	\N	*	\N
57	0ee264f6-f91d-4df0-bd11-da49504ebb68	locale	read	\N	\N	\N	*	\N
58	0ee264f6-f91d-4df0-bd11-da49504ebb68	neutral_construct	read	\N	\N	\N	*	\N
59	0ee264f6-f91d-4df0-bd11-da49504ebb68	question	read	\N	\N	\N	*	\N
60	0ee264f6-f91d-4df0-bd11-da49504ebb68	question_response_type	read	\N	\N	\N	*	\N
61	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire	read	\N	\N	\N	*	\N
62	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_assessment_reference	read	\N	\N	\N	*	\N
63	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_author	read	\N	\N	\N	*	\N
64	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_disorder	read	\N	\N	\N	*	\N
65	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_disorder_category	read	\N	\N	\N	*	\N
66	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_language_not_mhdb	read	\N	\N	\N	*	\N
67	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_respondent	read	\N	\N	\N	*	\N
68	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_sign_symptom	read	\N	\N	\N	*	\N
69	0ee264f6-f91d-4df0-bd11-da49504ebb68	research_evidence	read	\N	\N	\N	*	\N
70	0ee264f6-f91d-4df0-bd11-da49504ebb68	questionnaire_subject	read	\N	\N	\N	*	\N
71	0ee264f6-f91d-4df0-bd11-da49504ebb68	resource_people_audience	read	\N	\N	\N	*	\N
72	0ee264f6-f91d-4df0-bd11-da49504ebb68	response_type	read	\N	\N	\N	*	\N
73	0ee264f6-f91d-4df0-bd11-da49504ebb68	sign_symptom	read	\N	\N	\N	*	\N
74	0ee264f6-f91d-4df0-bd11-da49504ebb68	sign_symptom_accommodation	read	\N	\N	\N	*	\N
75	0ee264f6-f91d-4df0-bd11-da49504ebb68	sign_symptom_example	read	\N	\N	\N	*	\N
76	0ee264f6-f91d-4df0-bd11-da49504ebb68	sign_symptom_intervention	read	\N	\N	\N	*	\N
77	0ee264f6-f91d-4df0-bd11-da49504ebb68	sign_symptom_neutral_construct	read	\N	\N	\N	*	\N
78	0ee264f6-f91d-4df0-bd11-da49504ebb68	sign_symptom_technology	read	\N	\N	\N	*	\N
79	0ee264f6-f91d-4df0-bd11-da49504ebb68	sign_symptom_with_example	read	\N	\N	\N	*	\N
80	0ee264f6-f91d-4df0-bd11-da49504ebb68	state_domain_behaviour	read	\N	\N	\N	*	\N
81	0ee264f6-f91d-4df0-bd11-da49504ebb68	task	read	\N	\N	\N	*	\N
82	0ee264f6-f91d-4df0-bd11-da49504ebb68	technology	read	\N	\N	\N	*	\N
83	0ee264f6-f91d-4df0-bd11-da49504ebb68	technology_research_evidence	read	\N	\N	\N	*	\N
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, filters, layout, layout_query, layout_options, refresh_interval) FROM stdin;
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) FROM stdin;
36a8a942-db80-4dda-9b6a-cccfb00054a0	Admin	supervised_user_circle	\N	\N	f	\N	\N	t	t
0ee264f6-f91d-4df0-bd11-da49504ebb68	WWW	supervised_user_circle	\N	\N	f	\N	\N	f	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent) FROM stdin;
Nd8i3TxVxINCk8_5jXXG0msdSljT_d-no1k9I7rzVqM0vZj_l4DAqTyq4a1opJAw	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-22 06:56:26.075+00	::ffff:192.168.192.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0
bJ30e-GWNPTjdiGEG3f8ztc2hGAs8h3ka_u2prt0qQKTWPLjOCOAhF6mr5FJNYxJ	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-22 14:00:49.732+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)
vMc-2FBgnUb_y31xhYo1KsUGrQ_gm2JamnnYoeCe9BBP5BT2V5Pf1itEUAfob3LN	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-22 14:00:55.992+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)
9aE4Dac7VBUaPEvAuXfpuBkbE5tN08azKrZj5PhDj5grzgQubAr9ika2PioWQPWF	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-22 14:01:01.897+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)
I7gMpsCSWQZPP61sEydv0v9SfS-af7YAp5NfRY1oiGPzJkgCatOiN_MbkCIoXKwV	129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	2021-06-22 14:01:08.648+00	::ffff:192.168.224.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)
Z69aGv7RcCBzd93BGv1TcxQRs76e5jEQIXoOfpHbc4F0WzQhP6nPkDQ0rYLunbBu	33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	2021-06-22 14:01:31.813+00	::ffff:192.168.224.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page) FROM stdin;
129a5a2e-6d77-4f2b-92e4-ad4a8b62bb65	WWW	LISA DB	www-dev@lisa-db.ifea.education	$argon2i$v=19$m=4096,t=3,p=1$kd4+fgY/pApYaY7KRRRdYQ$Q3yHo6mbToSFw94kq12FpdGC9jFzlmFgzrIP2/njbwY	\N	\N	\N	\N	\N	en-US	auto	\N	active	0ee264f6-f91d-4df0-bd11-da49504ebb68	\N	2021-06-15 14:01:08.672+00	\N
33e7a79b-8db2-4af8-a9d0-b78af5a2acb6	\N	\N	dev@lisa-db.ifea.education	$argon2i$v=19$m=4096,t=3,p=1$G1cysmCcfWLhW4uGvFARaQ$Oej1KGZjE7IvSNRw6hKUUBL5tavq/oLNmUIB9KFHjNA	\N	\N	\N	\N	\N	en-US	auto	\N	active	36a8a942-db80-4dda-9b6a-cccfb00054a0	\N	2021-06-15 14:01:43.498+00	/users
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections) FROM stdin;
\.


--
-- Data for Name: disorder; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder (disorder_id, name, disorder_category_id, disorder_subcategory_id, icd_9_cm, icd_10_cm) FROM stdin;
\.


--
-- Data for Name: disorder_accommodation; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_accommodation (accommodation_id, disorder_id) FROM stdin;
\.


--
-- Data for Name: disorder_category; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_category (disorder_category_id, name) FROM stdin;
\.


--
-- Data for Name: disorder_category_accommodation; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_category_accommodation (accommodation_id, disorder_category_id) FROM stdin;
\.


--
-- Data for Name: disorder_category_intervention; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_category_intervention (intervention_id, disorder_category_id) FROM stdin;
\.


--
-- Data for Name: disorder_category_technology; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_category_technology (technology_id, disorder_category_id) FROM stdin;
\.


--
-- Data for Name: disorder_intervention; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_intervention (intervention_id, disorder_id) FROM stdin;
\.


--
-- Data for Name: disorder_reference; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_reference (disorder_reference_id, title) FROM stdin;
\.


--
-- Data for Name: disorder_reference_author; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_reference_author (disorder_reference_id, author_first_initial, author_middle_initial, author_surname, rank) FROM stdin;
\.


--
-- Data for Name: disorder_sign_symptom; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_sign_symptom (disorder_id, sign_symptom_id) FROM stdin;
\.


--
-- Data for Name: disorder_subcategory; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_subcategory (disorder_subcategory_id, name) FROM stdin;
\.


--
-- Data for Name: disorder_technology; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.disorder_technology (technology_id, disorder_id) FROM stdin;
\.


--
-- Data for Name: guide; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide (guide_id, title, link, publisher, guide_reference_id) FROM stdin;
\.


--
-- Data for Name: guide_accommodation; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_accommodation (accommodation_id, guide_id) FROM stdin;
\.


--
-- Data for Name: guide_audience; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_audience (audience_id, guide_id) FROM stdin;
\.


--
-- Data for Name: guide_author; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_author (author_first_initial, author_middle_initial, author_surname, guide_id, rank) FROM stdin;
\.


--
-- Data for Name: guide_disorder; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_disorder (disorder_id, guide_id) FROM stdin;
\.


--
-- Data for Name: guide_disorder_category; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_disorder_category (disorder_category_id, guide_id) FROM stdin;
\.


--
-- Data for Name: guide_guide_type; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_guide_type (guide_type_id, guide_id) FROM stdin;
\.


--
-- Data for Name: guide_intervention; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_intervention (intervention_id, guide_id) FROM stdin;
\.


--
-- Data for Name: guide_reference; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_reference (guide_reference_id, title, link, pub_med_id) FROM stdin;
\.


--
-- Data for Name: guide_technology; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_technology (technology_id, guide_id) FROM stdin;
\.


--
-- Data for Name: guide_type; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.guide_type (guide_type_id, name) FROM stdin;
\.


--
-- Data for Name: intervention; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.intervention (intervention_id, name, description) FROM stdin;
\.


--
-- Data for Name: intervention_research_evidence; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.intervention_research_evidence (intervention_id, research_evidence_id) FROM stdin;
\.


--
-- Data for Name: language_source; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.language_source (language_source_id, name) FROM stdin;
\.


--
-- Data for Name: lisa_domain; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_domain (domain_id) FROM stdin;
\.


--
-- Data for Name: lisa_domain_locale; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_domain_locale (domain_id, locale_id, name, description) FROM stdin;
\.


--
-- Data for Name: lisa_guide; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_guide (lisa_guide_id) FROM stdin;
\.


--
-- Data for Name: lisa_guide_locale; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_guide_locale (lisa_guide_id, locale_id, name, description) FROM stdin;
\.


--
-- Data for Name: lisa_subdomain; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_subdomain (subdomain_id, domain_id) FROM stdin;
\.


--
-- Data for Name: lisa_subdomain_guide; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_subdomain_guide (subdomain_id, lisa_guide_id, rank) FROM stdin;
\.


--
-- Data for Name: lisa_subdomain_guide_locale; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_subdomain_guide_locale (rank, locale_id) FROM stdin;
\.


--
-- Data for Name: lisa_subdomain_locale; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.lisa_subdomain_locale (subdomain_id, locale_id, name, description) FROM stdin;
\.


--
-- Data for Name: locale; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.locale (locale_id, name) FROM stdin;
\.


--
-- Data for Name: neutral_construct; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.neutral_construct (name) FROM stdin;
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.question (question_id, questionnaire_id, paper_instruction_preamble, digital_instruction_preamble, paper_instruction, digital_instruction, question_context, response_option) FROM stdin;
\.


--
-- Data for Name: question_response_type; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.question_response_type (response_type_id, question_id) FROM stdin;
\.


--
-- Data for Name: questionnaire; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire (questionnaire_id, title, link, description, abbreviation, age_max, age_min, number_of_questions, minutes_to_complete, license_id, language_source_id) FROM stdin;
\.


--
-- Data for Name: questionnaire_assessment_reference; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_assessment_reference (assessment_reference_id, questionnaire_id) FROM stdin;
\.


--
-- Data for Name: questionnaire_author; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_author (author_first_initial, author_middle_initial, author_surname, questionnaire_id, rank) FROM stdin;
\.


--
-- Data for Name: questionnaire_disorder; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_disorder (questionnaire_id, disorder_id) FROM stdin;
\.


--
-- Data for Name: questionnaire_disorder_category; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_disorder_category (questionnaire_id, disorder_category_id) FROM stdin;
\.


--
-- Data for Name: questionnaire_language_not_mhdb; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_language_not_mhdb (questionnaire_id, language_source_id) FROM stdin;
\.


--
-- Data for Name: questionnaire_respondent; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_respondent (respondent_id, questionnaire_id) FROM stdin;
\.


--
-- Data for Name: questionnaire_sign_symptom; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_sign_symptom (questionnaire_id, sign_symptom_id) FROM stdin;
\.


--
-- Data for Name: questionnaire_subject; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.questionnaire_subject (subject_id, questionnaire_id) FROM stdin;
\.


--
-- Data for Name: research_evidence; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.research_evidence (research_evidence_id, context) FROM stdin;
\.


--
-- Data for Name: resource_people_audience; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.resource_people_audience (audience_id, person) FROM stdin;
\.


--
-- Data for Name: response_type; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.response_type (response_type_id, type, response_type_definition) FROM stdin;
\.


--
-- Data for Name: sign_symptom; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.sign_symptom (sign_symptom_id, name, underlying_behavior, disorder_reference_id) FROM stdin;
\.


--
-- Data for Name: sign_symptom_accommodation; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.sign_symptom_accommodation (accommodation_id, sign_symptom_id) FROM stdin;
\.


--
-- Data for Name: sign_symptom_example; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.sign_symptom_example (sign_symptom_example_id, name) FROM stdin;
\.


--
-- Data for Name: sign_symptom_intervention; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.sign_symptom_intervention (intervention_id, sign_symptom_id) FROM stdin;
\.


--
-- Data for Name: sign_symptom_neutral_construct; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.sign_symptom_neutral_construct (sign_symptom_id, name) FROM stdin;
\.


--
-- Data for Name: sign_symptom_technology; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.sign_symptom_technology (technology_id, sign_symptom_id) FROM stdin;
\.


--
-- Data for Name: sign_symptom_with_example; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.sign_symptom_with_example (sign_symptom_id, sign_symptom_example_id) FROM stdin;
\.


--
-- Data for Name: state_domain_behaviour; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.state_domain_behaviour (behaviour_id, behaviour) FROM stdin;
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.task (task_id, name, description, assessment_reference_id) FROM stdin;
\.


--
-- Data for Name: technology; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.technology (technology_id, name, description, link) FROM stdin;
\.


--
-- Data for Name: technology_research_evidence; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.technology_research_evidence (technology_id, research_evidence_id) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 164, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 83, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 1, false);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: accommodation accommodation_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.accommodation
    ADD CONSTRAINT accommodation_pkey PRIMARY KEY (accommodation_id);


--
-- Name: accommodation_research_evidence accommodation_research_evidence_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.accommodation_research_evidence
    ADD CONSTRAINT accommodation_research_evidence_pkey PRIMARY KEY (accommodation_id, research_evidence_id);


--
-- Name: alias alias_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.alias
    ADD CONSTRAINT alias_pkey PRIMARY KEY (alias_id);


--
-- Name: assessment_reference_author assessment_reference_author_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.assessment_reference_author
    ADD CONSTRAINT assessment_reference_author_pkey PRIMARY KEY (assessment_reference_id, author_first_initial, author_middle_initial, author_surname);


--
-- Name: assessment_reference assessment_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.assessment_reference
    ADD CONSTRAINT assessment_reference_pkey PRIMARY KEY (assessment_reference_id);


--
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (first_initial, middle_initial, surname);


--
-- Name: behaviour_accommodation behaviour_accommodation_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_accommodation
    ADD CONSTRAINT behaviour_accommodation_pkey PRIMARY KEY (accommodation_id, behaviour_id);


--
-- Name: behaviour_guide behaviour_guide_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_guide
    ADD CONSTRAINT behaviour_guide_pkey PRIMARY KEY (guide_id, behaviour_id);


--
-- Name: behaviour_intervention behaviour_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_intervention
    ADD CONSTRAINT behaviour_intervention_pkey PRIMARY KEY (intervention_id, behaviour_id);


--
-- Name: behaviour_questionnaire behaviour_questionnaire_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_questionnaire
    ADD CONSTRAINT behaviour_questionnaire_pkey PRIMARY KEY (questionnaire_id, behaviour_id);


--
-- Name: behaviour_technology behaviour_technology_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_technology
    ADD CONSTRAINT behaviour_technology_pkey PRIMARY KEY (technology_id, behaviour_id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: disorder_accommodation disorder_accommodation_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_accommodation
    ADD CONSTRAINT disorder_accommodation_pkey PRIMARY KEY (accommodation_id, disorder_id);


--
-- Name: disorder_category_accommodation disorder_category_accommodation_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_accommodation
    ADD CONSTRAINT disorder_category_accommodation_pkey PRIMARY KEY (accommodation_id, disorder_category_id);


--
-- Name: disorder_category_intervention disorder_category_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_intervention
    ADD CONSTRAINT disorder_category_intervention_pkey PRIMARY KEY (intervention_id, disorder_category_id);


--
-- Name: disorder_category disorder_category_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category
    ADD CONSTRAINT disorder_category_pkey PRIMARY KEY (disorder_category_id);


--
-- Name: disorder_category_technology disorder_category_technology_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_technology
    ADD CONSTRAINT disorder_category_technology_pkey PRIMARY KEY (technology_id, disorder_category_id);


--
-- Name: disorder_intervention disorder_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_intervention
    ADD CONSTRAINT disorder_intervention_pkey PRIMARY KEY (intervention_id, disorder_id);


--
-- Name: disorder disorder_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder
    ADD CONSTRAINT disorder_pkey PRIMARY KEY (disorder_id);


--
-- Name: disorder_reference_author disorder_reference_author_disorder_reference_id_rank_key; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_reference_author
    ADD CONSTRAINT disorder_reference_author_disorder_reference_id_rank_key UNIQUE (disorder_reference_id, rank);


--
-- Name: disorder_reference_author disorder_reference_author_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_reference_author
    ADD CONSTRAINT disorder_reference_author_pkey PRIMARY KEY (disorder_reference_id, author_first_initial, author_middle_initial, author_surname);


--
-- Name: disorder_reference disorder_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_reference
    ADD CONSTRAINT disorder_reference_pkey PRIMARY KEY (disorder_reference_id);


--
-- Name: disorder_sign_symptom disorder_sign_symptom_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_sign_symptom
    ADD CONSTRAINT disorder_sign_symptom_pkey PRIMARY KEY (disorder_id, sign_symptom_id);


--
-- Name: disorder_subcategory disorder_subcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_subcategory
    ADD CONSTRAINT disorder_subcategory_pkey PRIMARY KEY (disorder_subcategory_id);


--
-- Name: disorder_technology disorder_technology_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_technology
    ADD CONSTRAINT disorder_technology_pkey PRIMARY KEY (technology_id, disorder_id);


--
-- Name: guide_accommodation guide_accommodation_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_accommodation
    ADD CONSTRAINT guide_accommodation_pkey PRIMARY KEY (accommodation_id, guide_id);


--
-- Name: guide_audience guide_audience_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_audience
    ADD CONSTRAINT guide_audience_pkey PRIMARY KEY (audience_id, guide_id);


--
-- Name: guide_author guide_author_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_author
    ADD CONSTRAINT guide_author_pkey PRIMARY KEY (author_first_initial, author_middle_initial, author_surname, guide_id);


--
-- Name: guide_disorder_category guide_disorder_category_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_disorder_category
    ADD CONSTRAINT guide_disorder_category_pkey PRIMARY KEY (disorder_category_id, guide_id);


--
-- Name: guide_disorder guide_disorder_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_disorder
    ADD CONSTRAINT guide_disorder_pkey PRIMARY KEY (disorder_id, guide_id);


--
-- Name: guide_guide_type guide_guide_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_guide_type
    ADD CONSTRAINT guide_guide_type_pkey PRIMARY KEY (guide_type_id, guide_id);


--
-- Name: guide_intervention guide_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_intervention
    ADD CONSTRAINT guide_intervention_pkey PRIMARY KEY (intervention_id, guide_id);


--
-- Name: guide guide_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide
    ADD CONSTRAINT guide_pkey PRIMARY KEY (guide_id);


--
-- Name: guide_reference guide_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_reference
    ADD CONSTRAINT guide_reference_pkey PRIMARY KEY (guide_reference_id);


--
-- Name: guide_technology guide_technology_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_technology
    ADD CONSTRAINT guide_technology_pkey PRIMARY KEY (technology_id, guide_id);


--
-- Name: guide_type guide_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_type
    ADD CONSTRAINT guide_type_pkey PRIMARY KEY (guide_type_id);


--
-- Name: intervention intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT intervention_pkey PRIMARY KEY (intervention_id);


--
-- Name: intervention_research_evidence intervention_research_evidence_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.intervention_research_evidence
    ADD CONSTRAINT intervention_research_evidence_pkey PRIMARY KEY (intervention_id, research_evidence_id);


--
-- Name: language_source language_source_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.language_source
    ADD CONSTRAINT language_source_pkey PRIMARY KEY (language_source_id);


--
-- Name: lisa_domain_locale lisa_domain_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_domain_locale
    ADD CONSTRAINT lisa_domain_locale_pkey PRIMARY KEY (domain_id, locale_id);


--
-- Name: lisa_domain lisa_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_domain
    ADD CONSTRAINT lisa_domain_pkey PRIMARY KEY (domain_id);


--
-- Name: lisa_guide_locale lisa_guide_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_guide_locale
    ADD CONSTRAINT lisa_guide_locale_pkey PRIMARY KEY (lisa_guide_id, locale_id);


--
-- Name: lisa_guide lisa_guide_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_guide
    ADD CONSTRAINT lisa_guide_pkey PRIMARY KEY (lisa_guide_id);


--
-- Name: lisa_subdomain_guide lisa_subdomain_guide_lisa_guide_id_rank_key; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide
    ADD CONSTRAINT lisa_subdomain_guide_lisa_guide_id_rank_key UNIQUE (lisa_guide_id, rank);


--
-- Name: lisa_subdomain_guide_locale lisa_subdomain_guide_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide_locale
    ADD CONSTRAINT lisa_subdomain_guide_locale_pkey PRIMARY KEY (rank, locale_id);


--
-- Name: lisa_subdomain_guide lisa_subdomain_guide_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide
    ADD CONSTRAINT lisa_subdomain_guide_pkey PRIMARY KEY (subdomain_id, lisa_guide_id);


--
-- Name: lisa_subdomain_guide lisa_subdomain_guide_rank_key; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide
    ADD CONSTRAINT lisa_subdomain_guide_rank_key UNIQUE (rank);


--
-- Name: lisa_subdomain_locale lisa_subdomain_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_locale
    ADD CONSTRAINT lisa_subdomain_locale_pkey PRIMARY KEY (subdomain_id, locale_id);


--
-- Name: lisa_subdomain lisa_subdomain_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain
    ADD CONSTRAINT lisa_subdomain_pkey PRIMARY KEY (subdomain_id);


--
-- Name: locale locale_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.locale
    ADD CONSTRAINT locale_pkey PRIMARY KEY (locale_id);


--
-- Name: neutral_construct neutral_construct_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.neutral_construct
    ADD CONSTRAINT neutral_construct_pkey PRIMARY KEY (name);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);


--
-- Name: question_response_type question_response_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.question_response_type
    ADD CONSTRAINT question_response_type_pkey PRIMARY KEY (response_type_id, question_id);


--
-- Name: questionnaire_assessment_reference questionnaire_assessment_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_assessment_reference
    ADD CONSTRAINT questionnaire_assessment_reference_pkey PRIMARY KEY (assessment_reference_id, questionnaire_id);


--
-- Name: questionnaire_author questionnaire_author_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_author
    ADD CONSTRAINT questionnaire_author_pkey PRIMARY KEY (author_first_initial, author_middle_initial, author_surname, questionnaire_id);


--
-- Name: questionnaire_disorder_category questionnaire_disorder_category_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_disorder_category
    ADD CONSTRAINT questionnaire_disorder_category_pkey PRIMARY KEY (questionnaire_id, disorder_category_id);


--
-- Name: questionnaire_disorder questionnaire_disorder_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_disorder
    ADD CONSTRAINT questionnaire_disorder_pkey PRIMARY KEY (questionnaire_id, disorder_id);


--
-- Name: questionnaire_language_not_mhdb questionnaire_language_not_mhdb_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_language_not_mhdb
    ADD CONSTRAINT questionnaire_language_not_mhdb_pkey PRIMARY KEY (questionnaire_id, language_source_id);


--
-- Name: questionnaire questionnaire_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire
    ADD CONSTRAINT questionnaire_pkey PRIMARY KEY (questionnaire_id);


--
-- Name: questionnaire_respondent questionnaire_respondent_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_respondent
    ADD CONSTRAINT questionnaire_respondent_pkey PRIMARY KEY (respondent_id, questionnaire_id);


--
-- Name: questionnaire_sign_symptom questionnaire_sign_symptom_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_sign_symptom
    ADD CONSTRAINT questionnaire_sign_symptom_pkey PRIMARY KEY (questionnaire_id, sign_symptom_id);


--
-- Name: questionnaire_subject questionnaire_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_subject
    ADD CONSTRAINT questionnaire_subject_pkey PRIMARY KEY (subject_id, questionnaire_id);


--
-- Name: research_evidence research_evidence_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.research_evidence
    ADD CONSTRAINT research_evidence_pkey PRIMARY KEY (research_evidence_id);


--
-- Name: resource_people_audience resource_people_audience_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.resource_people_audience
    ADD CONSTRAINT resource_people_audience_pkey PRIMARY KEY (audience_id);


--
-- Name: response_type response_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.response_type
    ADD CONSTRAINT response_type_pkey PRIMARY KEY (response_type_id);


--
-- Name: sign_symptom_accommodation sign_symptom_accommodation_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_accommodation
    ADD CONSTRAINT sign_symptom_accommodation_pkey PRIMARY KEY (accommodation_id, sign_symptom_id);


--
-- Name: sign_symptom_example sign_symptom_example_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_example
    ADD CONSTRAINT sign_symptom_example_pkey PRIMARY KEY (sign_symptom_example_id);


--
-- Name: sign_symptom_intervention sign_symptom_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_intervention
    ADD CONSTRAINT sign_symptom_intervention_pkey PRIMARY KEY (intervention_id, sign_symptom_id);


--
-- Name: sign_symptom_neutral_construct sign_symptom_neutral_construct_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_neutral_construct
    ADD CONSTRAINT sign_symptom_neutral_construct_pkey PRIMARY KEY (sign_symptom_id, name);


--
-- Name: sign_symptom sign_symptom_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom
    ADD CONSTRAINT sign_symptom_pkey PRIMARY KEY (sign_symptom_id);


--
-- Name: sign_symptom_technology sign_symptom_technology_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_technology
    ADD CONSTRAINT sign_symptom_technology_pkey PRIMARY KEY (technology_id, sign_symptom_id);


--
-- Name: sign_symptom_with_example sign_symptom_with_example_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_with_example
    ADD CONSTRAINT sign_symptom_with_example_pkey PRIMARY KEY (sign_symptom_id, sign_symptom_example_id);


--
-- Name: state_domain_behaviour state_domain_behaviour_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.state_domain_behaviour
    ADD CONSTRAINT state_domain_behaviour_pkey PRIMARY KEY (behaviour_id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (task_id);


--
-- Name: technology technology_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.technology
    ADD CONSTRAINT technology_pkey PRIMARY KEY (technology_id);


--
-- Name: technology_research_evidence technology_research_evidence_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.technology_research_evidence
    ADD CONSTRAINT technology_research_evidence_pkey PRIMARY KEY (technology_id, research_evidence_id);


--
-- Name: accommodation_research_evidence accommodation_research_evidence_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.accommodation_research_evidence
    ADD CONSTRAINT accommodation_research_evidence_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodation(accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: accommodation_research_evidence accommodation_research_evidence_research_evidence_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.accommodation_research_evidence
    ADD CONSTRAINT accommodation_research_evidence_research_evidence_id_fkey FOREIGN KEY (research_evidence_id) REFERENCES public.research_evidence(research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alias alias_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.alias
    ADD CONSTRAINT alias_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.task(task_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: assessment_reference_author assessment_reference_author_assessment_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.assessment_reference_author
    ADD CONSTRAINT assessment_reference_author_assessment_reference_id_fkey FOREIGN KEY (assessment_reference_id) REFERENCES public.assessment_reference(assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: assessment_reference_author assessment_reference_author_author_first_initial_author_mi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.assessment_reference_author
    ADD CONSTRAINT assessment_reference_author_author_first_initial_author_mi_fkey FOREIGN KEY (author_first_initial, author_middle_initial, author_surname) REFERENCES public.author(first_initial, middle_initial, surname) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_accommodation behaviour_accommodation_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_accommodation
    ADD CONSTRAINT behaviour_accommodation_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodation(accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_accommodation behaviour_accommodation_behaviour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_accommodation
    ADD CONSTRAINT behaviour_accommodation_behaviour_id_fkey FOREIGN KEY (behaviour_id) REFERENCES public.state_domain_behaviour(behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_guide behaviour_guide_behaviour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_guide
    ADD CONSTRAINT behaviour_guide_behaviour_id_fkey FOREIGN KEY (behaviour_id) REFERENCES public.state_domain_behaviour(behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_guide behaviour_guide_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_guide
    ADD CONSTRAINT behaviour_guide_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_intervention behaviour_intervention_behaviour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_intervention
    ADD CONSTRAINT behaviour_intervention_behaviour_id_fkey FOREIGN KEY (behaviour_id) REFERENCES public.state_domain_behaviour(behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_intervention behaviour_intervention_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_intervention
    ADD CONSTRAINT behaviour_intervention_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.intervention(intervention_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_questionnaire behaviour_questionnaire_behaviour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_questionnaire
    ADD CONSTRAINT behaviour_questionnaire_behaviour_id_fkey FOREIGN KEY (behaviour_id) REFERENCES public.state_domain_behaviour(behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_questionnaire behaviour_questionnaire_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_questionnaire
    ADD CONSTRAINT behaviour_questionnaire_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_technology behaviour_technology_behaviour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_technology
    ADD CONSTRAINT behaviour_technology_behaviour_id_fkey FOREIGN KEY (behaviour_id) REFERENCES public.state_domain_behaviour(behaviour_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: behaviour_technology behaviour_technology_technology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.behaviour_technology
    ADD CONSTRAINT behaviour_technology_technology_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technology(technology_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_fields directus_fields_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_fields(id);


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: disorder_accommodation disorder_accommodation_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_accommodation
    ADD CONSTRAINT disorder_accommodation_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodation(accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_accommodation disorder_accommodation_disorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_accommodation
    ADD CONSTRAINT disorder_accommodation_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES public.disorder(disorder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_category_accommodation disorder_category_accommodation_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_accommodation
    ADD CONSTRAINT disorder_category_accommodation_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodation(accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_category_accommodation disorder_category_accommodation_disorder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_accommodation
    ADD CONSTRAINT disorder_category_accommodation_disorder_category_id_fkey FOREIGN KEY (disorder_category_id) REFERENCES public.disorder_category(disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_category_intervention disorder_category_intervention_disorder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_intervention
    ADD CONSTRAINT disorder_category_intervention_disorder_category_id_fkey FOREIGN KEY (disorder_category_id) REFERENCES public.disorder_category(disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_category_intervention disorder_category_intervention_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_intervention
    ADD CONSTRAINT disorder_category_intervention_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.intervention(intervention_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_category_technology disorder_category_technology_disorder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_technology
    ADD CONSTRAINT disorder_category_technology_disorder_category_id_fkey FOREIGN KEY (disorder_category_id) REFERENCES public.disorder_category(disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_category_technology disorder_category_technology_technology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_category_technology
    ADD CONSTRAINT disorder_category_technology_technology_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technology(technology_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder disorder_disorder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder
    ADD CONSTRAINT disorder_disorder_category_id_fkey FOREIGN KEY (disorder_category_id) REFERENCES public.disorder_category(disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder disorder_disorder_subcategory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder
    ADD CONSTRAINT disorder_disorder_subcategory_id_fkey FOREIGN KEY (disorder_subcategory_id) REFERENCES public.disorder_subcategory(disorder_subcategory_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_intervention disorder_intervention_disorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_intervention
    ADD CONSTRAINT disorder_intervention_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES public.disorder(disorder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_intervention disorder_intervention_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_intervention
    ADD CONSTRAINT disorder_intervention_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.intervention(intervention_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_reference_author disorder_reference_author_author_first_initial_author_midd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_reference_author
    ADD CONSTRAINT disorder_reference_author_author_first_initial_author_midd_fkey FOREIGN KEY (author_first_initial, author_middle_initial, author_surname) REFERENCES public.author(first_initial, middle_initial, surname) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_reference_author disorder_reference_author_disorder_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_reference_author
    ADD CONSTRAINT disorder_reference_author_disorder_reference_id_fkey FOREIGN KEY (disorder_reference_id) REFERENCES public.disorder_reference(disorder_reference_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_sign_symptom disorder_sign_symptom_disorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_sign_symptom
    ADD CONSTRAINT disorder_sign_symptom_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES public.disorder(disorder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_sign_symptom disorder_sign_symptom_sign_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_sign_symptom
    ADD CONSTRAINT disorder_sign_symptom_sign_symptom_id_fkey FOREIGN KEY (sign_symptom_id) REFERENCES public.sign_symptom(sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_technology disorder_technology_disorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_technology
    ADD CONSTRAINT disorder_technology_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES public.disorder(disorder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: disorder_technology disorder_technology_technology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.disorder_technology
    ADD CONSTRAINT disorder_technology_technology_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technology(technology_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_accommodation guide_accommodation_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_accommodation
    ADD CONSTRAINT guide_accommodation_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodation(accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_accommodation guide_accommodation_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_accommodation
    ADD CONSTRAINT guide_accommodation_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_audience guide_audience_audience_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_audience
    ADD CONSTRAINT guide_audience_audience_id_fkey FOREIGN KEY (audience_id) REFERENCES public.resource_people_audience(audience_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_audience guide_audience_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_audience
    ADD CONSTRAINT guide_audience_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_author guide_author_author_first_initial_author_middle_initial_au_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_author
    ADD CONSTRAINT guide_author_author_first_initial_author_middle_initial_au_fkey FOREIGN KEY (author_first_initial, author_middle_initial, author_surname) REFERENCES public.author(first_initial, middle_initial, surname) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_author guide_author_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_author
    ADD CONSTRAINT guide_author_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_disorder_category guide_disorder_category_disorder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_disorder_category
    ADD CONSTRAINT guide_disorder_category_disorder_category_id_fkey FOREIGN KEY (disorder_category_id) REFERENCES public.disorder_category(disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_disorder_category guide_disorder_category_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_disorder_category
    ADD CONSTRAINT guide_disorder_category_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_disorder guide_disorder_disorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_disorder
    ADD CONSTRAINT guide_disorder_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES public.disorder(disorder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_disorder guide_disorder_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_disorder
    ADD CONSTRAINT guide_disorder_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide guide_guide_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide
    ADD CONSTRAINT guide_guide_reference_id_fkey FOREIGN KEY (guide_reference_id) REFERENCES public.guide_reference(guide_reference_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_guide_type guide_guide_type_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_guide_type
    ADD CONSTRAINT guide_guide_type_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_guide_type guide_guide_type_guide_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_guide_type
    ADD CONSTRAINT guide_guide_type_guide_type_id_fkey FOREIGN KEY (guide_type_id) REFERENCES public.guide_type(guide_type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_intervention guide_intervention_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_intervention
    ADD CONSTRAINT guide_intervention_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_intervention guide_intervention_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_intervention
    ADD CONSTRAINT guide_intervention_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.intervention(intervention_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_technology guide_technology_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_technology
    ADD CONSTRAINT guide_technology_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guide(guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guide_technology guide_technology_technology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.guide_technology
    ADD CONSTRAINT guide_technology_technology_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technology(technology_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: intervention_research_evidence intervention_research_evidence_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.intervention_research_evidence
    ADD CONSTRAINT intervention_research_evidence_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.intervention(intervention_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: intervention_research_evidence intervention_research_evidence_research_evidence_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.intervention_research_evidence
    ADD CONSTRAINT intervention_research_evidence_research_evidence_id_fkey FOREIGN KEY (research_evidence_id) REFERENCES public.research_evidence(research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_domain_locale lisa_domain_locale_domain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_domain_locale
    ADD CONSTRAINT lisa_domain_locale_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES public.lisa_domain(domain_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_domain_locale lisa_domain_locale_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_domain_locale
    ADD CONSTRAINT lisa_domain_locale_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES public.locale(locale_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_guide_locale lisa_guide_locale_lisa_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_guide_locale
    ADD CONSTRAINT lisa_guide_locale_lisa_guide_id_fkey FOREIGN KEY (lisa_guide_id) REFERENCES public.lisa_guide(lisa_guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_guide_locale lisa_guide_locale_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_guide_locale
    ADD CONSTRAINT lisa_guide_locale_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES public.locale(locale_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_subdomain lisa_subdomain_domain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain
    ADD CONSTRAINT lisa_subdomain_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES public.lisa_domain(domain_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_subdomain_guide lisa_subdomain_guide_lisa_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide
    ADD CONSTRAINT lisa_subdomain_guide_lisa_guide_id_fkey FOREIGN KEY (lisa_guide_id) REFERENCES public.lisa_guide(lisa_guide_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_subdomain_guide_locale lisa_subdomain_guide_locale_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide_locale
    ADD CONSTRAINT lisa_subdomain_guide_locale_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES public.locale(locale_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_subdomain_guide_locale lisa_subdomain_guide_locale_rank_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide_locale
    ADD CONSTRAINT lisa_subdomain_guide_locale_rank_fkey FOREIGN KEY (rank) REFERENCES public.lisa_subdomain_guide(rank) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_subdomain_guide lisa_subdomain_guide_subdomain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_guide
    ADD CONSTRAINT lisa_subdomain_guide_subdomain_id_fkey FOREIGN KEY (subdomain_id) REFERENCES public.lisa_subdomain(subdomain_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_subdomain_locale lisa_subdomain_locale_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_locale
    ADD CONSTRAINT lisa_subdomain_locale_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES public.locale(locale_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lisa_subdomain_locale lisa_subdomain_locale_subdomain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.lisa_subdomain_locale
    ADD CONSTRAINT lisa_subdomain_locale_subdomain_id_fkey FOREIGN KEY (subdomain_id) REFERENCES public.lisa_subdomain(subdomain_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: question question_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: question_response_type question_response_type_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.question_response_type
    ADD CONSTRAINT question_response_type_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: question_response_type question_response_type_response_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.question_response_type
    ADD CONSTRAINT question_response_type_response_type_id_fkey FOREIGN KEY (response_type_id) REFERENCES public.response_type(response_type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_assessment_reference questionnaire_assessment_reference_assessment_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_assessment_reference
    ADD CONSTRAINT questionnaire_assessment_reference_assessment_reference_id_fkey FOREIGN KEY (assessment_reference_id) REFERENCES public.assessment_reference(assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_assessment_reference questionnaire_assessment_reference_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_assessment_reference
    ADD CONSTRAINT questionnaire_assessment_reference_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_author questionnaire_author_author_first_initial_author_middle_in_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_author
    ADD CONSTRAINT questionnaire_author_author_first_initial_author_middle_in_fkey FOREIGN KEY (author_first_initial, author_middle_initial, author_surname) REFERENCES public.author(first_initial, middle_initial, surname) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_author questionnaire_author_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_author
    ADD CONSTRAINT questionnaire_author_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_disorder_category questionnaire_disorder_category_disorder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_disorder_category
    ADD CONSTRAINT questionnaire_disorder_category_disorder_category_id_fkey FOREIGN KEY (disorder_category_id) REFERENCES public.disorder_category(disorder_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_disorder_category questionnaire_disorder_category_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_disorder_category
    ADD CONSTRAINT questionnaire_disorder_category_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_disorder questionnaire_disorder_disorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_disorder
    ADD CONSTRAINT questionnaire_disorder_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES public.disorder(disorder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_disorder questionnaire_disorder_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_disorder
    ADD CONSTRAINT questionnaire_disorder_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_language_not_mhdb questionnaire_language_not_mhdb_language_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_language_not_mhdb
    ADD CONSTRAINT questionnaire_language_not_mhdb_language_source_id_fkey FOREIGN KEY (language_source_id) REFERENCES public.language_source(language_source_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_language_not_mhdb questionnaire_language_not_mhdb_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_language_not_mhdb
    ADD CONSTRAINT questionnaire_language_not_mhdb_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire questionnaire_language_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire
    ADD CONSTRAINT questionnaire_language_source_id_fkey FOREIGN KEY (language_source_id) REFERENCES public.language_source(language_source_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_respondent questionnaire_respondent_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_respondent
    ADD CONSTRAINT questionnaire_respondent_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_respondent questionnaire_respondent_respondent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_respondent
    ADD CONSTRAINT questionnaire_respondent_respondent_id_fkey FOREIGN KEY (respondent_id) REFERENCES public.resource_people_audience(audience_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_sign_symptom questionnaire_sign_symptom_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_sign_symptom
    ADD CONSTRAINT questionnaire_sign_symptom_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_sign_symptom questionnaire_sign_symptom_sign_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_sign_symptom
    ADD CONSTRAINT questionnaire_sign_symptom_sign_symptom_id_fkey FOREIGN KEY (sign_symptom_id) REFERENCES public.sign_symptom(sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_subject questionnaire_subject_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_subject
    ADD CONSTRAINT questionnaire_subject_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaire(questionnaire_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questionnaire_subject questionnaire_subject_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.questionnaire_subject
    ADD CONSTRAINT questionnaire_subject_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.resource_people_audience(audience_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_accommodation sign_symptom_accommodation_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_accommodation
    ADD CONSTRAINT sign_symptom_accommodation_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodation(accommodation_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_accommodation sign_symptom_accommodation_sign_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_accommodation
    ADD CONSTRAINT sign_symptom_accommodation_sign_symptom_id_fkey FOREIGN KEY (sign_symptom_id) REFERENCES public.sign_symptom(sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom sign_symptom_disorder_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom
    ADD CONSTRAINT sign_symptom_disorder_reference_id_fkey FOREIGN KEY (disorder_reference_id) REFERENCES public.disorder_reference(disorder_reference_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_intervention sign_symptom_intervention_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_intervention
    ADD CONSTRAINT sign_symptom_intervention_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.intervention(intervention_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_intervention sign_symptom_intervention_sign_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_intervention
    ADD CONSTRAINT sign_symptom_intervention_sign_symptom_id_fkey FOREIGN KEY (sign_symptom_id) REFERENCES public.sign_symptom(sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_neutral_construct sign_symptom_neutral_construct_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_neutral_construct
    ADD CONSTRAINT sign_symptom_neutral_construct_name_fkey FOREIGN KEY (name) REFERENCES public.neutral_construct(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_neutral_construct sign_symptom_neutral_construct_sign_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_neutral_construct
    ADD CONSTRAINT sign_symptom_neutral_construct_sign_symptom_id_fkey FOREIGN KEY (sign_symptom_id) REFERENCES public.sign_symptom(sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_technology sign_symptom_technology_sign_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_technology
    ADD CONSTRAINT sign_symptom_technology_sign_symptom_id_fkey FOREIGN KEY (sign_symptom_id) REFERENCES public.sign_symptom(sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_technology sign_symptom_technology_technology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_technology
    ADD CONSTRAINT sign_symptom_technology_technology_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technology(technology_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_with_example sign_symptom_with_example_sign_symptom_example_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_with_example
    ADD CONSTRAINT sign_symptom_with_example_sign_symptom_example_id_fkey FOREIGN KEY (sign_symptom_example_id) REFERENCES public.sign_symptom_example(sign_symptom_example_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sign_symptom_with_example sign_symptom_with_example_sign_symptom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.sign_symptom_with_example
    ADD CONSTRAINT sign_symptom_with_example_sign_symptom_id_fkey FOREIGN KEY (sign_symptom_id) REFERENCES public.sign_symptom(sign_symptom_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task task_assessment_reference_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_assessment_reference_id_fkey FOREIGN KEY (assessment_reference_id) REFERENCES public.assessment_reference(assessment_reference_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: technology_research_evidence technology_research_evidence_research_evidence_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.technology_research_evidence
    ADD CONSTRAINT technology_research_evidence_research_evidence_id_fkey FOREIGN KEY (research_evidence_id) REFERENCES public.research_evidence(research_evidence_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: technology_research_evidence technology_research_evidence_technology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.technology_research_evidence
    ADD CONSTRAINT technology_research_evidence_technology_id_fkey FOREIGN KEY (technology_id) REFERENCES public.technology(technology_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

