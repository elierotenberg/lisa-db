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
    sort_field character varying(64)
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
    filesize integer DEFAULT 0 NOT NULL,
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
    layout_options json
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
    many_primary character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_primary character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(255)
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
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field) FROM stdin;
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
20201028A	Remove Collection Foreign Keys	2021-06-14 08:28:13.9806+00
20201029A	Remove System Relations	2021-06-14 08:28:13.984759+00
20201029B	Remove System Collections	2021-06-14 08:28:13.98909+00
20201029C	Remove System Fields	2021-06-14 08:28:13.999925+00
20201105A	Add Cascade System Relations	2021-06-14 08:28:14.075765+00
20201105B	Change Webhook URL Type	2021-06-14 08:28:14.085273+00
20210225A	Add Relations Sort Field	2021-06-14 08:28:14.094623+00
20210304A	Remove Locked Fields	2021-06-14 08:28:14.100257+00
20210312A	Webhooks Collections Text	2021-06-14 08:28:14.109484+00
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields, "limit") FROM stdin;
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, filters, layout, layout_query, layout_options) FROM stdin;
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) FROM stdin;
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
99e062ce-c6be-47d3-95ab-983e991a0338	Admin	supervised_user_circle	\N	\N	f	\N	\N	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: lisa-db-dev-user
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent) FROM stdin;
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
51759926-d78c-4740-a554-4bb3af5650b5	\N	\N	dev@lisa-db.ifea.education	$argon2i$v=19$m=4096,t=3,p=1$cNdtRTnQeE4QAYr4EiqvPQ$J7ezSvnSGwRwexIIdb9/QReDWDwPrPvYbi5l/W+IPbE	\N	\N	\N	\N	\N	en-US	auto	\N	active	99e062ce-c6be-47d3-95ab-983e991a0338	\N	\N	\N
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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 1, false);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa-db-dev-user
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


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
    ADD CONSTRAINT directus_fields_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_fields(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: lisa-db-dev-user
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE CASCADE ON DELETE SET NULL;


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

