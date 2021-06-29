--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.3 (Ubuntu 13.3-1.pgdg20.04+1)

-- Started on 2021-06-29 17:44:52 CEST

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

--
-- TOC entry 3960 (class 0 OID 17283)
-- Dependencies: 204
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: -
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.directus_fields DISABLE TRIGGER ALL;

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) FROM stdin;
99	lisa_domain_category_locale	lisa_domain_category_locale_id	uuid	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
117	lisa_domain_locale_version	lisa_domain_locale_id	\N	select-dropdown-m2o	{"template":"{{domain_id.domain_category_id.domain_category_id}}{{domain_id.domain_id}}{{locale_id.name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
60	domain_locale	title	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
101	lisa_domain_locale_author	lisa_author_id	\N	select-dropdown-m2o	{"template":"{{lisa_author_first_name}}{{lisa_author_last_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
102	lisa_domain_locale_author	lisa_domain_locale_id	\N	select-dropdown-m2o	{"template":"{{domain_id.domain_id}}{{locale_id.locale_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
103	lisa_domain_category_locale_author	lisa_domain_category_locale_author_id	uuid	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
104	lisa_domain_category_locale_author	lisa_author_id	\N	select-dropdown-m2o	{"template":"{{lisa_author_first_name}}{{lisa_author_last_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
86	lisa_domain_category_locale_version	content_markdown	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
108	lisa_author	lisa_author_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
105	lisa_domain_category_locale_author	lisa_domain_category_locale_id	\N	select-dropdown-m2o	{"template":"{{domain_category_id.domain_category_id}}{{locale_id.locale_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
109	lisa_domain	domain_category_id	\N	select-dropdown-m2o	{"template":"{{domain_category_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
55	domain_locale	domain_locale_id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N
61	domain_locale	body	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","removeformat","link","bullist","numlist","blockquote","h1","h2","h3","image","media","hr","code","fullscreen","aligncenter","alignjustify","alignleft","alignnone","alignright","subscript","strikethrough","superscript","unlink","h4","h5","h6","indent","outdent","undo","redo"]}	formatted-value	\N	f	f	\N	full	\N	\N	\N
118	lisa_guide_locale_author	lisa_guide_locale_author_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
81	lisa_domain_category_locale_version	created_by	\N	select-dropdown-m2o	{"template":"{{lisa_author_first_name}}{{lisa_author_last_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
67	lisa_guide	lisa_guide_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
119	lisa_guide_locale_author	lisa_author_id	\N	select-dropdown-m2o	{"template":"{{lisa_author_first_name}}{{lisa_author_last_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
106	lisa_static_content_locale	lisa_static_content_locale_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
95	lisa_static_content_locale_version	created_by	\N	select-dropdown-m2o	{"template":"{{lisa_author_first_name}}{{lisa_author_last_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
96	lisa_static_content_locale_version	lisa_static_content_locale_id	\N	select-dropdown-m2o	{"template":"{{static_content_id.static_content_id}}{{locale_id.name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
107	lisa_static_content_locale_version	lisa_static_content_locale_version_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
92	lisa_static_content_locale	locale_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
91	lisa_static_content_locale	static_content_id	\N	select-dropdown-m2o	{"template":"{{static_content_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
89	lisa_domain_category_locale_version	lisa_domain_category_locale_id	\N	select-dropdown-m2o	{"template":"{{domain_category_id.domain_category_id}}{{locale_id.name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
98	lisa_domain_category_locale	locale_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
110	lisa_domain_locale	domain_id	\N	select-dropdown-m2o	{"template":"{{domain_category_id.domain_category_id}}{{domain_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
111	lisa_domain_locale	locale_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
90	lisa_domain_category_locale_version	created_at	date-created	datetime	\N	\N	\N	t	f	\N	full	\N	\N	\N
112	lisa_domain_locale	lisa_domain_locale_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
87	lisa_domain_category_locale_version	name	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
88	lisa_domain_category_locale_version	lisa_domain_category_locale_version_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
100	lisa_domain_locale_author	lisa_domain_locale_author_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
113	lisa_domain_locale_version	lisa_domain_locale_version_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
120	lisa_guide_locale_author	lisa_guide_locale_id	\N	select-dropdown-m2o	{"template":"{{lisa_guide_id.lisa_guide_id}}{{locale_id.name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
94	lisa_static_content_locale_version	content_markdown	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
115	lisa_domain_locale_version	content_markdown	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
116	lisa_domain_locale_version	created_by	\N	select-dropdown-m2o	{"template":"{{lisa_author_first_name}}{{lisa_author_last_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
97	lisa_domain_category_locale	domain_category_id	\N	select-dropdown-m2o	{"template":"{{domain_category_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
93	lisa_static_content_locale_version	created_at	date-created	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
114	lisa_domain_locale_version	created_at	date-created	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
69	lisa_guide_locale	locale_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
68	lisa_guide_locale	lisa_guide_id	\N	select-dropdown-m2o	{"template":"{{lisa_guide_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
70	lisa_guide_locale	lisa_guide_locale_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
121	lisa_guide_locale_version	lisa_guide_locale_version_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
122	lisa_guide_locale_version	created_at	date-created	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
123	lisa_guide_locale_version	name	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
124	lisa_guide_locale_version	content_markdown	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
125	lisa_guide_locale_version	created_by	\N	select-dropdown-m2o	{"template":"{{lisa_author_first_name}}{{lisa_author_last_name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
126	lisa_guide_locale_version	lisa_guide_locale_id	\N	select-dropdown-m2o	{"template":"{{lisa_guide_id.lisa_guide_id}}{{locale_id.name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
127	lisa_domain_guide	domain_id	\N	select-dropdown-m2o	{"template":"{{domain_category_id.domain_category_id}}{{domain_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
128	lisa_domain_guide	lisa_guide_id	\N	select-dropdown-m2o	{"template":"{{lisa_guide_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
129	lisa_domain_guide	lisa_domain_guide_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
131	lisa_domain_guide_locale	locale_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
132	lisa_domain_guide_locale	lisa_domain_guide_locale_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
133	lisa_domain_guide_locale	lisa_domain_guide_id	\N	select-dropdown-m2o	{"template":"{{domain_id.domain_category_id.domain_category_id}}{{domain_id.domain_id}}{{lisa_guide_id.lisa_guide_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
134	accommodation	accommodation_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
135	accommodation	name	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
136	accommodation	description	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
137	accommodation_research_evidence	accommodation_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
138	accommodation_research_evidence	research_evidence_id	\N	select-dropdown-m2o	{"template":"{{research_evidence_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
139	accommodation_research_evidence	accommodation_research_evidence_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
140	alias	alias_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
141	alias	task_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
142	alias	name	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
143	assessment_reference	assessment_reference_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
144	assessment_reference	title	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
145	assessment_reference	link	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
146	assessment_reference	pub_med_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
147	assessment_reference_author	assessment_reference_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
148	assessment_reference_author	assessment_reference_author_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
149	assessment_reference_author	author_id	\N	select-dropdown-m2o	{"template":"{{first_initial}}{{middle_initial}}{{surname}}"}	\N	\N	f	f	\N	full	\N	\N	\N
150	author	first_initial	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
151	author	author_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
152	behaviour_accommodation	accommodation_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
153	behaviour_accommodation	behaviour_id	\N	select-dropdown-m2o	{"template":"{{behaviour}}"}	\N	\N	f	f	\N	full	\N	\N	\N
154	behaviour_accommodation	behaviour_accommodation_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
155	behaviour_guide	guide_id	\N	select-dropdown-m2o	{"template":"{{guide_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
156	behaviour_guide	behaviour_id	\N	select-dropdown-m2o	{"template":"{{behaviour}}"}	\N	\N	f	f	\N	full	\N	\N	\N
157	behaviour_guide	behaviour_guide_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
158	behaviour_intervention	intervention_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
159	behaviour_intervention	behaviour_id	\N	select-dropdown-m2o	{"template":"{{behaviour}}"}	\N	\N	f	f	\N	full	\N	\N	\N
160	behaviour_intervention	behaviour_intervention_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
161	behaviour_questionnaire	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
162	behaviour_questionnaire	behaviour_id	\N	select-dropdown-m2o	{"template":"{{behaviour}}"}	\N	\N	f	f	\N	full	\N	\N	\N
163	behaviour_questionnaire	behaviour_questionnaire_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
164	behaviour_technology	technology_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
165	behaviour_technology	behaviour_id	\N	select-dropdown-m2o	{"template":"{{behaviour}}"}	\N	\N	f	f	\N	full	\N	\N	\N
166	behaviour_technology	behaviour_technology_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
167	disorder	disorder_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
168	disorder	name	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
169	disorder	disorder_category_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
170	disorder	disorder_subcategory_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
171	disorder	icd_9_cm	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
172	disorder_accommodation	accommodation_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
173	disorder_accommodation	disorder_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
174	disorder_accommodation	disorder_accommodation_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
175	disorder_category	disorder_category_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
176	disorder_category_accommodation	accommodation_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
177	disorder_category_accommodation	disorder_category_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
178	disorder_category_accommodation	disorder_category_accommodation_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
179	disorder_category_intervention	intervention_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
180	disorder_category_intervention	disorder_category_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
181	disorder_category_intervention	disorder_category_intervention_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
182	disorder_category_technology	disorder_category_technology_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
183	disorder_intervention	disorder_intervention_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
184	disorder_intervention	intervention_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
185	disorder_reference	disorder_reference_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
186	disorder_reference_author	disorder_reference_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
187	disorder_reference_author	rank	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
188	disorder_reference_author	disorder_reference_author_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
189	disorder_reference_author	author_id		select-dropdown-m2o	{"template":"{{first_initial}}{{middle_initial}}{{surname}}"}	\N	\N	f	f	\N	full	\N	\N	\N
190	disorder_sign_symptom	disorder_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
191	disorder_sign_symptom	sign_symptom_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
192	disorder_sign_symptom	disorder_sign_symptom_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
193	disorder_technology	disorder_technology_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
194	guide	guide_reference_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
195	guide_accommodation	guide_accommodation_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
196	guide_accommodation	accommodation_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
197	guide_accommodation	guide_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
198	guide_audience	guide_audience_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
199	guide_audience	audience_id	\N	select-dropdown-m2o	{"template":"{{person}}"}	\N	\N	f	f	\N	full	\N	\N	\N
200	guide_audience	guide_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
201	guide_disorder	disorder_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
202	guide_disorder	guide_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
203	guide_disorder	guide_disorder_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
204	guide_disorder_category	disorder_category_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
205	guide_disorder_category	guide_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
206	guide_disorder_category	guide_disorder_category_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
207	guide_guide_type	guide_type_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
208	guide_guide_type	guide_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
209	guide_guide_type	guide_guide_type_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
210	guide_intervention	intervention_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
211	guide_intervention	guide_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
212	guide_intervention	guide_intervention_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
213	guide_reference	guide_reference_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
214	guide_technology	technology_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
215	guide_technology	guide_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
216	guide_technology	guide_technology_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
217	intervention	description	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
218	intervention_research_evidence	intervention_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
219	intervention_research_evidence	research_evidence_id	\N	select-dropdown-m2o	{"template":"{{research_evidence_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
220	intervention_research_evidence	intervention_research_evidence_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
221	question	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
222	question	paper_instruction_preamble	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
223	question	digital_instruction_preamble	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
224	question	paper_instruction	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
225	question	digital_instruction	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
226	question	question_context	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
227	question	response_option	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
228	question_response_type	response_type_id	\N	select-dropdown-m2o	{"template":"{{type}}"}	\N	\N	f	f	\N	full	\N	\N	\N
229	question_response_type	question_id	\N	select-dropdown-m2o	{"template":"{{question_context}}"}	\N	\N	f	f	\N	full	\N	\N	\N
230	questionnaire	description	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
231	questionnaire	license_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
232	questionnaire	language_source_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
233	questionnaire_assessment_reference	assessment_reference_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
234	questionnaire_assessment_reference	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
235	questionnaire_assessment_reference	questionnaire_assessment_reference_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
236	questionnaire_author	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
237	questionnaire_author	questionnaire_author_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
238	questionnaire_author	author_id	\N	select-dropdown-m2o	{"template":"{{first_initial}}{{middle_initial}}{{surname}}"}	\N	\N	f	f	\N	full	\N	\N	\N
239	questionnaire_disorder	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
240	questionnaire_disorder	disorder_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
241	questionnaire_disorder	questionnaire_disorder_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
242	questionnaire_disorder_category	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
243	questionnaire_disorder_category	disorder_category_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
244	questionnaire_disorder_category	questionnaire_disorder_category_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
245	questionnaire_language_not_mhdb	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
246	questionnaire_language_not_mhdb	language_source_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
247	questionnaire_language_not_mhdb	questionnaire_language_not_mhdb_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
248	questionnaire_respondent	respondent_id	\N	select-dropdown-m2o	{"template":"{{person}}"}	\N	\N	f	f	\N	full	\N	\N	\N
249	questionnaire_respondent	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
250	questionnaire_respondent	questionnaire_respondent_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
251	questionnaire_sign_symptom	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
252	questionnaire_sign_symptom	sign_symptom_id	\N	select-dropdown-m2o	{"template":"{{sign_symptom_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
253	questionnaire_sign_symptom	questionnaire_sign_symptom_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
254	questionnaire_subject	questionnaire_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
255	questionnaire_subject	subject_id	\N	select-dropdown-m2o	{"template":"{{person}}"}	\N	\N	f	f	\N	full	\N	\N	\N
256	questionnaire_subject	questionnaire_subject_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
257	research_evidence	research_evidence_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
258	research_evidence	context	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
259	response_type	response_type_definition	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
260	sign_symptom	disorder_reference_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
261	sign_symptom	sign_symptom_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
262	sign_symptom_accommodation	accommodation_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
263	sign_symptom_accommodation	sign_symptom_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
264	sign_symptom_accommodation	sign_symptom_accommodation_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
265	sign_symptom_intervention	intervention_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
266	sign_symptom_intervention	sign_symptom_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
267	sign_symptom_intervention	sign_symptom_intervention_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
268	sign_symptom_neutral_construct	sign_symptom_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
269	sign_symptom_neutral_construct	sign_symptom_neutral_construct_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
270	sign_symptom_technology	technology_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
271	sign_symptom_technology	sign_symptom_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
272	sign_symptom_technology	sign_symptom_technology_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
274	sign_symptom_with_example	sign_symptom_example_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
273	sign_symptom_with_example	sign_symptom_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
275	sign_symptom_with_example	sign_symptom_with_example_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
276	task	description	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
277	task	assessment_reference_id	\N	select-dropdown-m2o	{"template":"{{title}}"}	\N	\N	f	f	\N	full	\N	\N	\N
278	technology	description	\N	input-rich-text-md	\N	\N	\N	f	f	\N	full	\N	\N	\N
279	technology_research_evidence	technology_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	\N	\N	f	f	\N	full	\N	\N	\N
280	technology_research_evidence	research_evidence_id	\N	select-dropdown-m2o	{"template":"{{research_evidence_id}}"}	\N	\N	f	f	\N	full	\N	\N	\N
281	technology_research_evidence	technology_research_evidence_id	uuid	\N	\N	\N	\N	t	f	\N	full	\N	\N	\N
282	lisa_domain_category	domain_category_id	\N	\N	\N	\N	\N	f	f	\N	full	\N	\N	\N
\.


ALTER TABLE public.directus_fields ENABLE TRIGGER ALL;

--
-- TOC entry 3958 (class 0 OID 17251)
-- Dependencies: 201
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.directus_roles DISABLE TRIGGER ALL;

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) FROM stdin;
a6d1ff36-1546-4dae-9df7-ca1ea141bb54	Administrator	verified	Initial administrative role with unrestricted App/API access	\N	f	\N	\N	t	t
e4b1d601-24b6-4f5e-a392-096bb38db3d1	Editor	supervised_user_circle	\N	\N	f	\N	\N	t	t
5621d2ee-1672-4753-a530-de0d7d901a40	API Client	supervised_user_circle	\N	\N	f	\N	\N	f	t
\.


ALTER TABLE public.directus_roles ENABLE TRIGGER ALL;

--
-- TOC entry 3962 (class 0 OID 17361)
-- Dependencies: 210
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.directus_permissions DISABLE TRIGGER ALL;

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields, "limit") FROM stdin;
11	\N	guide	read	\N	\N	\N	*	\N
12	\N	accommodation	read	\N	\N	\N	*	\N
13	\N	accommodation_research_evidence	read	\N	\N	\N	*	\N
14	\N	alias	read	\N	\N	\N	*	\N
15	\N	assessment_reference	read	\N	\N	\N	*	\N
16	\N	assessment_reference_author	read	\N	\N	\N	*	\N
17	\N	author	read	\N	\N	\N	*	\N
18	\N	behaviour_accommodation	read	\N	\N	\N	*	\N
19	\N	behaviour_guide	read	\N	\N	\N	*	\N
20	\N	behaviour_intervention	read	\N	\N	\N	*	\N
21	\N	behaviour_questionnaire	read	\N	\N	\N	*	\N
22	\N	behaviour_technology	read	\N	\N	\N	*	\N
23	\N	disorder	read	\N	\N	\N	*	\N
24	\N	disorder_accommodation	read	\N	\N	\N	*	\N
25	\N	disorder_category	read	\N	\N	\N	*	\N
26	\N	disorder_category_accommodation	read	\N	\N	\N	*	\N
27	\N	disorder_category_intervention	read	\N	\N	\N	*	\N
28	\N	disorder_category_technology	read	\N	\N	\N	*	\N
29	\N	disorder_intervention	read	\N	\N	\N	*	\N
30	\N	disorder_reference	read	\N	\N	\N	*	\N
31	\N	disorder_reference_author	read	\N	\N	\N	*	\N
32	\N	disorder_sign_symptom	read	\N	\N	\N	*	\N
33	\N	disorder_technology	read	\N	\N	\N	*	\N
34	\N	disorder_subcategory	read	\N	\N	\N	*	\N
35	\N	guide_accommodation	read	\N	\N	\N	*	\N
36	\N	guide_author	read	\N	\N	\N	*	\N
37	\N	guide_audience	read	\N	\N	\N	*	\N
38	\N	guide_disorder	read	\N	\N	\N	*	\N
39	\N	guide_audience	read	\N	\N	\N	*	\N
40	\N	guide_disorder_category	read	\N	\N	\N	*	\N
41	\N	guide_guide_type	read	\N	\N	\N	*	\N
42	\N	guide_intervention	read	\N	\N	\N	*	\N
43	\N	guide_reference	read	\N	\N	\N	*	\N
44	\N	guide_technology	read	\N	\N	\N	*	\N
45	\N	guide_type	read	\N	\N	\N	*	\N
46	\N	intervention	read	\N	\N	\N	*	\N
47	\N	intervention_research_evidence	read	\N	\N	\N	*	\N
48	\N	language_source	read	\N	\N	\N	*	\N
49	\N	neutral_construct	read	\N	\N	\N	*	\N
50	\N	neutral_construct	read	\N	\N	\N	*	\N
51	\N	question	read	\N	\N	\N	*	\N
52	\N	question_response_type	read	\N	\N	\N	*	\N
53	\N	questionnaire	read	\N	\N	\N	*	\N
54	\N	questionnaire_assessment_reference	read	\N	\N	\N	*	\N
55	\N	questionnaire_author	read	\N	\N	\N	*	\N
56	\N	questionnaire_disorder_category	read	\N	\N	\N	*	\N
57	\N	questionnaire_disorder	read	\N	\N	\N	*	\N
58	\N	questionnaire_disorder	read	\N	\N	\N	*	\N
59	\N	questionnaire_language_not_mhdb	read	\N	\N	\N	*	\N
60	\N	questionnaire_respondent	read	\N	\N	\N	*	\N
61	\N	questionnaire_sign_symptom	read	\N	\N	\N	*	\N
62	\N	questionnaire_subject	read	\N	\N	\N	*	\N
63	\N	research_evidence	read	\N	\N	\N	*	\N
64	\N	resource_people_audience	read	\N	\N	\N	*	\N
65	\N	response_type	read	\N	\N	\N	*	\N
66	\N	sign_symptom	read	\N	\N	\N	*	\N
67	\N	sign_symptom_accommodation	read	\N	\N	\N	*	\N
68	\N	sign_symptom_example	read	\N	\N	\N	*	\N
69	\N	sign_symptom_intervention	read	\N	\N	\N	*	\N
70	\N	sign_symptom_neutral_construct	read	\N	\N	\N	*	\N
71	\N	sign_symptom_technology	read	\N	\N	\N	*	\N
72	\N	sign_symptom_with_example	read	\N	\N	\N	*	\N
73	\N	state_domain_behaviour	read	\N	\N	\N	*	\N
74	\N	task	read	\N	\N	\N	*	\N
75	\N	technology_research_evidence	read	\N	\N	\N	*	\N
76	\N	technology	read	\N	\N	\N	*	\N
77	\N	technology	read	\N	\N	\N	*	\N
78	5621d2ee-1672-4753-a530-de0d7d901a40	directus_files	create	{}	\N	\N	*	\N
79	5621d2ee-1672-4753-a530-de0d7d901a40	directus_files	read	{}	\N	\N	*	\N
80	5621d2ee-1672-4753-a530-de0d7d901a40	directus_files	update	{}	\N	\N	*	\N
81	5621d2ee-1672-4753-a530-de0d7d901a40	directus_files	delete	{}	\N	\N	*	\N
82	5621d2ee-1672-4753-a530-de0d7d901a40	directus_folders	create	{}	\N	\N	*	\N
83	5621d2ee-1672-4753-a530-de0d7d901a40	directus_folders	read	{}	\N	\N	*	\N
84	5621d2ee-1672-4753-a530-de0d7d901a40	directus_folders	update	{}	\N	\N	*	\N
85	5621d2ee-1672-4753-a530-de0d7d901a40	directus_folders	delete	{}	\N	\N	\N	\N
86	5621d2ee-1672-4753-a530-de0d7d901a40	directus_users	read	{}	\N	\N	*	\N
87	5621d2ee-1672-4753-a530-de0d7d901a40	directus_roles	read	{}	\N	\N	*	\N
88	5621d2ee-1672-4753-a530-de0d7d901a40	accommodation	read	\N	\N	\N	*	\N
89	5621d2ee-1672-4753-a530-de0d7d901a40	accommodation_research_evidence	read	\N	\N	\N	*	\N
90	5621d2ee-1672-4753-a530-de0d7d901a40	alias	read	\N	\N	\N	*	\N
91	5621d2ee-1672-4753-a530-de0d7d901a40	assessment_reference_author	read	\N	\N	\N	*	\N
92	5621d2ee-1672-4753-a530-de0d7d901a40	assessment_reference	read	\N	\N	\N	*	\N
93	5621d2ee-1672-4753-a530-de0d7d901a40	author	read	\N	\N	\N	*	\N
94	5621d2ee-1672-4753-a530-de0d7d901a40	behaviour_accommodation	read	\N	\N	\N	*	\N
95	5621d2ee-1672-4753-a530-de0d7d901a40	behaviour_guide	read	\N	\N	\N	*	\N
96	5621d2ee-1672-4753-a530-de0d7d901a40	behaviour_intervention	read	\N	\N	\N	*	\N
97	5621d2ee-1672-4753-a530-de0d7d901a40	behaviour_questionnaire	read	\N	\N	\N	*	\N
98	5621d2ee-1672-4753-a530-de0d7d901a40	behaviour_technology	read	\N	\N	\N	*	\N
99	5621d2ee-1672-4753-a530-de0d7d901a40	disorder	read	\N	\N	\N	*	\N
100	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_accommodation	read	\N	\N	\N	*	\N
101	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_category	read	\N	\N	\N	*	\N
102	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_category_accommodation	read	\N	\N	\N	*	\N
103	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_category_intervention	read	\N	\N	\N	*	\N
104	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_category_technology	read	\N	\N	\N	*	\N
105	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_reference	read	\N	\N	\N	*	\N
106	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_intervention	read	\N	\N	\N	*	\N
107	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_reference_author	read	\N	\N	\N	*	\N
108	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_sign_symptom	read	\N	\N	\N	*	\N
109	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_subcategory	read	\N	\N	\N	*	\N
110	5621d2ee-1672-4753-a530-de0d7d901a40	disorder_technology	read	\N	\N	\N	*	\N
111	5621d2ee-1672-4753-a530-de0d7d901a40	guide_accommodation	read	\N	\N	\N	*	\N
112	5621d2ee-1672-4753-a530-de0d7d901a40	guide	read	\N	\N	\N	*	\N
113	5621d2ee-1672-4753-a530-de0d7d901a40	guide_author	read	\N	\N	\N	*	\N
114	5621d2ee-1672-4753-a530-de0d7d901a40	guide_audience	read	\N	\N	\N	*	\N
115	5621d2ee-1672-4753-a530-de0d7d901a40	guide_disorder	read	\N	\N	\N	*	\N
116	5621d2ee-1672-4753-a530-de0d7d901a40	guide_disorder_category	read	\N	\N	\N	*	\N
117	5621d2ee-1672-4753-a530-de0d7d901a40	guide_guide_type	read	\N	\N	\N	*	\N
118	5621d2ee-1672-4753-a530-de0d7d901a40	guide_intervention	read	\N	\N	\N	*	\N
124	5621d2ee-1672-4753-a530-de0d7d901a40	neutral_construct	read	\N	\N	\N	*	\N
125	5621d2ee-1672-4753-a530-de0d7d901a40	intervention_research_evidence	read	\N	\N	\N	*	\N
126	5621d2ee-1672-4753-a530-de0d7d901a40	question	read	\N	\N	\N	*	\N
127	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire	read	\N	\N	\N	*	\N
128	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_assessment_reference	read	\N	\N	\N	*	\N
129	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_author	read	\N	\N	\N	*	\N
130	5621d2ee-1672-4753-a530-de0d7d901a40	question_response_type	read	\N	\N	\N	*	\N
119	5621d2ee-1672-4753-a530-de0d7d901a40	guide_reference	read	\N	\N	\N	*	\N
120	5621d2ee-1672-4753-a530-de0d7d901a40	guide_technology	read	\N	\N	\N	*	\N
121	5621d2ee-1672-4753-a530-de0d7d901a40	guide_type	read	\N	\N	\N	*	\N
122	5621d2ee-1672-4753-a530-de0d7d901a40	intervention	read	\N	\N	\N	*	\N
123	5621d2ee-1672-4753-a530-de0d7d901a40	language_source	read	\N	\N	\N	*	\N
131	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_disorder	read	\N	\N	\N	*	\N
132	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_disorder_category	read	\N	\N	\N	*	\N
133	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_language_not_mhdb	read	\N	\N	\N	*	\N
134	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_respondent	read	\N	\N	\N	*	\N
135	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_sign_symptom	read	\N	\N	\N	*	\N
136	5621d2ee-1672-4753-a530-de0d7d901a40	research_evidence	read	\N	\N	\N	*	\N
137	5621d2ee-1672-4753-a530-de0d7d901a40	resource_people_audience	read	\N	\N	\N	*	\N
138	5621d2ee-1672-4753-a530-de0d7d901a40	sign_symptom	read	\N	\N	\N	*	\N
139	5621d2ee-1672-4753-a530-de0d7d901a40	questionnaire_subject	read	\N	\N	\N	*	\N
140	5621d2ee-1672-4753-a530-de0d7d901a40	sign_symptom_accommodation	read	\N	\N	\N	*	\N
141	5621d2ee-1672-4753-a530-de0d7d901a40	sign_symptom_example	read	\N	\N	\N	*	\N
142	5621d2ee-1672-4753-a530-de0d7d901a40	sign_symptom_intervention	read	\N	\N	\N	*	\N
143	5621d2ee-1672-4753-a530-de0d7d901a40	sign_symptom_neutral_construct	read	\N	\N	\N	*	\N
144	5621d2ee-1672-4753-a530-de0d7d901a40	sign_symptom_technology	read	\N	\N	\N	*	\N
145	5621d2ee-1672-4753-a530-de0d7d901a40	response_type	read	\N	\N	\N	*	\N
146	5621d2ee-1672-4753-a530-de0d7d901a40	sign_symptom_with_example	read	\N	\N	\N	*	\N
147	5621d2ee-1672-4753-a530-de0d7d901a40	state_domain_behaviour	read	\N	\N	\N	*	\N
148	5621d2ee-1672-4753-a530-de0d7d901a40	task	read	\N	\N	\N	*	\N
149	5621d2ee-1672-4753-a530-de0d7d901a40	technology	read	\N	\N	\N	*	\N
150	5621d2ee-1672-4753-a530-de0d7d901a40	technology_research_evidence	read	\N	\N	\N	*	\N
152	\N	lisa_author	read	\N	\N	\N	*	\N
153	\N	lisa_domain	read	\N	\N	\N	*	\N
154	\N	lisa_domain_category	read	\N	\N	\N	*	\N
155	\N	lisa_domain_category_locale	read	\N	\N	\N	*	\N
156	\N	lisa_domain_category_locale_author	read	\N	\N	\N	*	\N
157	\N	lisa_domain_category_locale_version	read	\N	\N	\N	*	\N
158	\N	lisa_domain_guide	read	\N	\N	\N	*	\N
159	\N	lisa_domain_guide_locale	read	\N	\N	\N	*	\N
160	\N	lisa_domain_locale	read	\N	\N	\N	*	\N
161	\N	lisa_domain_locale_version	read	\N	\N	\N	*	\N
162	\N	lisa_domain_locale_author	read	\N	\N	\N	*	\N
163	\N	lisa_guide	read	\N	\N	\N	*	\N
164	\N	lisa_guide_locale	read	\N	\N	\N	*	\N
165	\N	lisa_guide_locale_author	read	\N	\N	\N	*	\N
166	\N	lisa_static_content	read	\N	\N	\N	*	\N
167	\N	lisa_guide_locale_version	read	\N	\N	\N	*	\N
168	\N	lisa_static_content_locale	read	\N	\N	\N	*	\N
169	\N	locale	read	\N	\N	\N	*	\N
170	\N	lisa_static_content_locale_version	read	\N	\N	\N	*	\N
171	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_author	read	\N	\N	\N	*	\N
172	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain	read	\N	\N	\N	*	\N
173	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_category	read	\N	\N	\N	*	\N
174	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_category_locale	read	\N	\N	\N	*	\N
175	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_category_locale_author	read	\N	\N	\N	*	\N
176	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_category_locale_version	read	\N	\N	\N	*	\N
177	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_guide	read	\N	\N	\N	*	\N
178	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_guide_locale	read	\N	\N	\N	*	\N
179	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_locale	read	\N	\N	\N	*	\N
180	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_locale_author	read	\N	\N	\N	*	\N
181	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_domain_locale_version	read	\N	\N	\N	*	\N
182	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_guide	read	\N	\N	\N	*	\N
183	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_guide_locale	read	\N	\N	\N	*	\N
184	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_guide_locale_author	read	\N	\N	\N	*	\N
185	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_guide_locale_version	read	\N	\N	\N	*	\N
186	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_static_content	read	\N	\N	\N	*	\N
187	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_static_content_locale	read	\N	\N	\N	*	\N
188	5621d2ee-1672-4753-a530-de0d7d901a40	lisa_static_content_locale_version	read	\N	\N	\N	*	\N
189	5621d2ee-1672-4753-a530-de0d7d901a40	locale	read	\N	\N	\N	*	\N
\.


ALTER TABLE public.directus_permissions ENABLE TRIGGER ALL;

--
-- TOC entry 3968 (class 0 OID 0)
-- Dependencies: 203
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 282, true);


--
-- TOC entry 3969 (class 0 OID 0)
-- Dependencies: 209
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 189, true);


-- Completed on 2021-06-29 17:44:57 CEST

--
-- PostgreSQL database dump complete
--

