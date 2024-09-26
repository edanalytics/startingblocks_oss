--
-- PostgreSQL database dump
--

-- Dumped from database version 13.12
-- Dumped by pg_dump version 13.7

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
-- Name: dbo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dbo;


ALTER SCHEMA dbo OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actions; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.actions (
    actionid integer NOT NULL,
    actionname character varying(255) NOT NULL,
    actionuri character varying(2048) NOT NULL
);


ALTER TABLE dbo.actions OWNER TO postgres;

--
-- Name: actions_actionid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.actions_actionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.actions_actionid_seq OWNER TO postgres;

--
-- Name: actions_actionid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.actions_actionid_seq OWNED BY dbo.actions.actionid;


--
-- Name: authorizationstrategies; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.authorizationstrategies (
    authorizationstrategyid integer NOT NULL,
    displayname character varying(255) NOT NULL,
    authorizationstrategyname character varying(255) NOT NULL
);


ALTER TABLE dbo.authorizationstrategies OWNER TO postgres;

--
-- Name: authorizationstrategies_authorizationstrategyid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.authorizationstrategies_authorizationstrategyid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.authorizationstrategies_authorizationstrategyid_seq OWNER TO postgres;

--
-- Name: authorizationstrategies_authorizationstrategyid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.authorizationstrategies_authorizationstrategyid_seq OWNED BY dbo.authorizationstrategies.authorizationstrategyid;


--
-- Name: claimsetresourceclaimactionauthorizationstrategyoverrides; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.claimsetresourceclaimactionauthorizationstrategyoverrides (
    claimsetresourceclaimactionauthorizationstrategyoverrideid integer NOT NULL,
    claimsetresourceclaimactionid integer NOT NULL,
    authorizationstrategyid integer NOT NULL
);


ALTER TABLE dbo.claimsetresourceclaimactionauthorizationstrategyoverrides OWNER TO postgres;

--
-- Name: claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq OWNER TO postgres;

--
-- Name: claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq OWNED BY dbo.claimsetresourceclaimactionauthorizationstrategyoverrides.claimsetresourceclaimactionauthorizationstrategyoverrideid;


--
-- Name: claimsetresourceclaimactions; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.claimsetresourceclaimactions (
    claimsetresourceclaimactionid integer NOT NULL,
    claimsetid integer NOT NULL,
    resourceclaimid integer NOT NULL,
    actionid integer NOT NULL,
    validationrulesetnameoverride character varying
);


ALTER TABLE dbo.claimsetresourceclaimactions OWNER TO postgres;

--
-- Name: claimsetresourceclaimactions_claimsetresourceclaimactionid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.claimsetresourceclaimactions_claimsetresourceclaimactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.claimsetresourceclaimactions_claimsetresourceclaimactionid_seq OWNER TO postgres;

--
-- Name: claimsetresourceclaimactions_claimsetresourceclaimactionid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.claimsetresourceclaimactions_claimsetresourceclaimactionid_seq OWNED BY dbo.claimsetresourceclaimactions.claimsetresourceclaimactionid;


--
-- Name: claimsets; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.claimsets (
    claimsetid integer NOT NULL,
    claimsetname character varying(255) NOT NULL,
    isedfipreset boolean DEFAULT false NOT NULL,
    forapplicationuseonly boolean DEFAULT false NOT NULL
);


ALTER TABLE dbo.claimsets OWNER TO postgres;

--
-- Name: claimsets_claimsetid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.claimsets_claimsetid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.claimsets_claimsetid_seq OWNER TO postgres;

--
-- Name: claimsets_claimsetid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.claimsets_claimsetid_seq OWNED BY dbo.claimsets.claimsetid;


--
-- Name: resourceclaimactionauthorizationstrategies; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.resourceclaimactionauthorizationstrategies (
    resourceclaimactionauthorizationstrategyid integer NOT NULL,
    resourceclaimactionid integer NOT NULL,
    authorizationstrategyid integer NOT NULL
);


ALTER TABLE dbo.resourceclaimactionauthorizationstrategies OWNER TO postgres;

--
-- Name: resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq OWNER TO postgres;

--
-- Name: resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq OWNED BY dbo.resourceclaimactionauthorizationstrategies.resourceclaimactionauthorizationstrategyid;


--
-- Name: resourceclaimactions; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.resourceclaimactions (
    resourceclaimactionid integer NOT NULL,
    resourceclaimid integer NOT NULL,
    actionid integer NOT NULL,
    validationrulesetname character varying
);


ALTER TABLE dbo.resourceclaimactions OWNER TO postgres;

--
-- Name: resourceclaimactions_resourceclaimactionid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.resourceclaimactions_resourceclaimactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.resourceclaimactions_resourceclaimactionid_seq OWNER TO postgres;

--
-- Name: resourceclaimactions_resourceclaimactionid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.resourceclaimactions_resourceclaimactionid_seq OWNED BY dbo.resourceclaimactions.resourceclaimactionid;


--
-- Name: resourceclaims; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.resourceclaims (
    resourceclaimid integer NOT NULL,
    resourcename character varying(255) NOT NULL,
    claimname character varying(850) NOT NULL,
    parentresourceclaimid integer
);


ALTER TABLE dbo.resourceclaims OWNER TO postgres;

--
-- Name: resourceclaims_resourceclaimid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.resourceclaims_resourceclaimid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.resourceclaims_resourceclaimid_seq OWNER TO postgres;

--
-- Name: resourceclaims_resourceclaimid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.resourceclaims_resourceclaimid_seq OWNED BY dbo.resourceclaims.resourceclaimid;


--
-- Name: DeployJournal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DeployJournal" (
    schemaversionsid integer NOT NULL,
    scriptname character varying(255) NOT NULL,
    applied timestamp without time zone NOT NULL
);


ALTER TABLE public."DeployJournal" OWNER TO postgres;

--
-- Name: DeployJournal_schemaversionsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DeployJournal_schemaversionsid_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DeployJournal_schemaversionsid_seq" OWNER TO postgres;

--
-- Name: DeployJournal_schemaversionsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DeployJournal_schemaversionsid_seq" OWNED BY public."DeployJournal".schemaversionsid;


--
-- Name: actions actionid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.actions ALTER COLUMN actionid SET DEFAULT nextval('dbo.actions_actionid_seq'::regclass);


--
-- Name: authorizationstrategies authorizationstrategyid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.authorizationstrategies ALTER COLUMN authorizationstrategyid SET DEFAULT nextval('dbo.authorizationstrategies_authorizationstrategyid_seq'::regclass);


--
-- Name: claimsetresourceclaimactionauthorizationstrategyoverrides claimsetresourceclaimactionauthorizationstrategyoverrideid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactionauthorizationstrategyoverrides ALTER COLUMN claimsetresourceclaimactionauthorizationstrategyoverrideid SET DEFAULT nextval('dbo.claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq'::regclass);


--
-- Name: claimsetresourceclaimactions claimsetresourceclaimactionid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactions ALTER COLUMN claimsetresourceclaimactionid SET DEFAULT nextval('dbo.claimsetresourceclaimactions_claimsetresourceclaimactionid_seq'::regclass);


--
-- Name: claimsets claimsetid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsets ALTER COLUMN claimsetid SET DEFAULT nextval('dbo.claimsets_claimsetid_seq'::regclass);


--
-- Name: resourceclaimactionauthorizationstrategies resourceclaimactionauthorizationstrategyid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactionauthorizationstrategies ALTER COLUMN resourceclaimactionauthorizationstrategyid SET DEFAULT nextval('dbo.resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq'::regclass);


--
-- Name: resourceclaimactions resourceclaimactionid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactions ALTER COLUMN resourceclaimactionid SET DEFAULT nextval('dbo.resourceclaimactions_resourceclaimactionid_seq'::regclass);


--
-- Name: resourceclaims resourceclaimid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaims ALTER COLUMN resourceclaimid SET DEFAULT nextval('dbo.resourceclaims_resourceclaimid_seq'::regclass);


--
-- Name: DeployJournal schemaversionsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeployJournal" ALTER COLUMN schemaversionsid SET DEFAULT nextval('public."DeployJournal_schemaversionsid_seq"'::regclass);


--
-- Data for Name: actions; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.actions (actionid, actionname, actionuri) FROM stdin;
1	Create	http://ed-fi.org/odsapi/actions/create
2	Read	http://ed-fi.org/odsapi/actions/read
3	Update	http://ed-fi.org/odsapi/actions/update
4	Delete	http://ed-fi.org/odsapi/actions/delete
5	ReadChanges	http://ed-fi.org/odsapi/actions/readChanges
\.


--
-- Data for Name: authorizationstrategies; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.authorizationstrategies (authorizationstrategyid, displayname, authorizationstrategyname) FROM stdin;
1	No Further Authorization Required	NoFurtherAuthorizationRequired
2	Relationships with Education Organizations and People	RelationshipsWithEdOrgsAndPeople
3	Relationships with Education Organizations only	RelationshipsWithEdOrgsOnly
4	Namespace Based	NamespaceBased
5	Relationships with People only	RelationshipsWithPeopleOnly
6	Relationships with Students only	RelationshipsWithStudentsOnly
7	Relationships with Students only (through StudentEducationOrganizationResponsibilityAssociation)	RelationshipsWithStudentsOnlyThroughResponsibility
8	Ownership Based	OwnershipBased
9	Relationships with Education Organizations and People (including deletes)	RelationshipsWithEdOrgsAndPeopleIncludingDeletes
10	Relationships with Education Organizations only (Inverted)	RelationshipsWithEdOrgsOnlyInverted
11	Relationships with Education Organizations and People (Inverted)	RelationshipsWithEdOrgsAndPeopleInverted
12	Relationships with Students only (through StudentEducationOrganizationResponsibilityAssociation, including deletes)	RelationshipsWithStudentsOnlyThroughResponsibilityIncludingDeletes
\.


--
-- Data for Name: claimsetresourceclaimactionauthorizationstrategyoverrides; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.claimsetresourceclaimactionauthorizationstrategyoverrides (claimsetresourceclaimactionauthorizationstrategyoverrideid, claimsetresourceclaimactionid, authorizationstrategyid) FROM stdin;
1	115	1
2	116	1
3	117	1
4	118	1
5	119	1
6	120	1
7	121	1
8	122	1
9	123	1
10	124	1
11	125	1
12	126	1
13	127	1
14	128	1
15	129	1
16	130	1
17	131	1
18	132	1
19	133	1
20	134	1
21	135	1
22	136	1
36	209	1
37	210	1
38	211	1
39	212	1
40	213	1
41	214	1
42	215	1
43	216	1
44	217	1
45	218	1
46	219	1
47	220	1
48	221	1
66	329	1
67	330	1
68	331	1
69	332	1
70	333	1
71	334	1
72	335	1
73	336	1
74	337	1
75	338	1
76	339	1
77	340	1
78	341	1
79	354	1
80	355	1
81	356	1
82	357	1
83	358	1
84	359	1
85	360	1
86	361	1
87	362	1
88	363	1
89	364	1
90	365	1
91	370	1
92	371	1
93	372	1
94	373	1
95	374	1
96	375	1
97	376	1
98	377	1
110	487	1
111	488	1
\.


--
-- Data for Name: claimsetresourceclaimactions; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.claimsetresourceclaimactions (claimsetresourceclaimactionid, claimsetid, resourceclaimid, actionid, validationrulesetnameoverride) FROM stdin;
1	1	1	2	\N
2	1	5	1	\N
3	1	10	2	\N
4	1	5	4	\N
5	1	10	1	\N
6	1	5	3	\N
7	1	7	1	\N
8	1	6	1	\N
9	1	97	2	\N
10	1	97	1	\N
11	1	2	2	\N
12	1	10	4	\N
13	1	97	4	\N
14	1	5	2	\N
15	1	97	3	\N
16	1	9	4	\N
17	1	6	4	\N
18	1	4	2	\N
19	1	3	2	\N
20	1	10	3	\N
21	1	3	3	\N
22	1	9	1	\N
23	1	7	3	\N
24	1	7	2	\N
25	1	3	4	\N
26	1	6	2	\N
27	1	3	1	\N
28	1	6	3	\N
29	1	9	2	\N
30	1	7	4	\N
31	1	9	3	\N
60	2	8	3	\N
63	2	8	1	\N
67	2	1	2	\N
70	2	8	2	\N
76	2	58	1	\N
77	2	58	2	\N
78	2	58	3	\N
79	2	58	4	\N
80	3	4	2	\N
81	3	50	2	\N
82	3	67	2	\N
83	3	73	2	\N
84	3	172	2	\N
85	3	249	2	\N
86	3	256	2	\N
87	3	263	2	\N
88	3	268	2	\N
89	3	276	2	\N
90	3	279	2	\N
91	3	304	2	\N
92	3	307	2	\N
93	4	14	1	\N
94	4	3	1	\N
95	4	279	2	\N
96	4	1	2	\N
97	4	154	3	\N
98	4	14	3	\N
99	4	14	4	\N
100	4	3	4	\N
101	4	3	2	\N
102	4	14	2	\N
103	4	7	2	\N
104	4	3	3	\N
105	4	7	3	\N
106	4	7	1	\N
107	4	2	2	\N
108	4	154	4	\N
109	4	154	2	\N
110	4	7	4	\N
111	4	154	1	\N
112	5	7	2	\N
113	5	154	2	\N
114	5	279	2	\N
115	6	2	1	\N
116	6	3	1	\N
117	6	4	1	\N
118	6	17	1	\N
119	6	50	1	\N
120	6	56	1	\N
121	6	57	1	\N
122	6	58	1	\N
123	6	67	1	\N
124	6	102	1	\N
125	6	103	1	\N
126	6	104	1	\N
127	6	106	1	\N
128	6	118	1	\N
129	6	154	1	\N
130	6	156	1	\N
131	6	168	1	\N
132	6	172	1	\N
133	6	200	1	\N
134	6	206	1	\N
135	6	242	1	\N
136	6	278	1	\N
137	8	6	4	\N
138	8	10	2	\N
139	8	7	3	\N
140	8	3	2	\N
141	8	6	2	\N
142	8	10	4	\N
143	8	9	2	\N
144	8	7	2	\N
145	8	9	1	\N
146	8	2	2	\N
147	8	10	3	\N
148	8	5	2	\N
149	8	1	2	\N
150	8	9	4	\N
151	8	242	1	\N
152	8	5	1	\N
153	8	9	3	\N
154	8	6	1	\N
155	8	187	2	\N
156	8	7	1	\N
157	8	168	3	\N
158	8	168	2	\N
159	8	6	3	\N
160	8	187	1	\N
161	8	187	4	\N
162	8	3	1	\N
163	8	97	4	\N
164	8	97	3	\N
165	8	97	2	\N
166	8	10	1	\N
167	8	97	1	\N
168	8	3	4	\N
169	8	4	2	\N
170	8	242	2	\N
171	8	7	4	\N
172	8	242	3	\N
173	8	242	4	\N
174	8	187	3	\N
175	8	5	4	\N
176	8	5	3	\N
177	8	3	3	\N
209	9	2	1	\N
210	9	3	1	\N
211	9	4	1	\N
212	9	2	2	\N
213	9	3	2	\N
214	9	4	2	\N
215	9	2	3	\N
216	9	3	3	\N
217	9	4	3	\N
218	9	2	4	\N
219	9	3	4	\N
220	9	4	4	\N
221	9	1	2	\N
222	10	9	1	\N
223	10	9	2	\N
224	10	9	3	\N
225	10	9	4	\N
226	10	14	1	\N
227	10	14	2	\N
228	10	14	3	\N
229	10	14	4	\N
230	10	125	1	\N
231	10	125	2	\N
232	10	125	3	\N
233	10	125	4	\N
234	10	223	1	\N
235	10	223	2	\N
236	10	223	3	\N
237	10	223	4	\N
238	4	192	1	\N
239	4	192	2	\N
244	2	340	1	\N
245	2	340	2	\N
246	2	340	3	\N
247	2	340	4	\N
248	2	340	5	\N
249	11	340	2	\N
250	11	340	5	\N
251	12	340	1	\N
252	12	340	2	\N
253	12	340	3	\N
254	12	340	4	\N
255	13	341	2	\N
256	13	350	1	\N
257	13	350	2	\N
258	13	350	3	\N
259	13	350	4	\N
264	6	374	1	\N
265	14	4	1	\N
266	14	4	2	\N
267	14	4	3	\N
268	14	4	4	\N
269	14	11	1	\N
270	14	11	2	\N
271	14	11	3	\N
272	14	11	4	\N
273	14	76	1	\N
274	14	76	2	\N
275	14	76	3	\N
276	14	76	4	\N
277	14	193	1	\N
278	14	193	2	\N
279	14	193	3	\N
280	14	193	4	\N
281	14	279	1	\N
282	14	279	2	\N
283	14	279	3	\N
284	14	279	4	\N
285	14	304	1	\N
286	14	304	2	\N
287	14	304	3	\N
288	14	304	4	\N
289	14	359	1	\N
290	14	359	2	\N
291	14	359	3	\N
292	14	359	4	\N
293	14	370	1	\N
294	14	370	2	\N
295	14	370	3	\N
296	14	370	4	\N
297	14	374	1	\N
298	14	374	2	\N
299	14	374	3	\N
300	14	374	4	\N
301	14	394	1	\N
302	14	394	2	\N
303	14	394	3	\N
304	14	394	4	\N
305	14	2	2	\N
306	11	1	2	\N
329	11	397	2	\N
330	12	1	1	\N
331	12	1	2	\N
332	12	1	3	\N
333	12	1	4	\N
334	12	2	1	\N
335	12	2	2	\N
336	12	2	3	\N
337	12	2	4	\N
338	12	3	1	\N
339	12	3	2	\N
340	12	3	3	\N
341	12	3	4	\N
342	12	4	1	\N
343	12	4	2	\N
344	12	4	3	\N
345	12	4	4	\N
346	12	5	1	\N
347	12	5	2	\N
348	12	5	3	\N
349	12	5	4	\N
350	12	6	1	\N
351	12	6	2	\N
352	12	6	3	\N
353	12	6	4	\N
354	12	58	1	\N
355	12	58	2	\N
356	12	58	3	\N
357	12	58	4	\N
358	12	7	1	\N
359	12	7	2	\N
360	12	7	3	\N
361	12	7	4	\N
362	12	9	1	\N
363	12	9	2	\N
364	12	9	3	\N
365	12	9	4	\N
366	12	10	1	\N
367	12	10	2	\N
368	12	10	3	\N
369	12	10	4	\N
370	12	11	1	\N
371	12	11	2	\N
372	12	11	3	\N
373	12	11	4	\N
374	12	97	1	\N
375	12	97	2	\N
376	12	97	3	\N
377	12	97	4	\N
423	2	2	1	\N
424	2	2	2	\N
425	2	2	3	\N
426	2	2	4	\N
427	2	2	5	\N
428	2	3	1	\N
429	2	3	2	\N
430	2	3	3	\N
431	2	3	4	\N
432	2	3	5	\N
433	2	4	1	\N
434	2	4	2	\N
435	2	4	3	\N
436	2	4	4	\N
437	2	4	5	\N
440	2	5	1	\N
441	2	5	2	\N
442	2	5	3	\N
443	2	5	4	\N
444	2	5	5	\N
445	2	6	1	\N
446	2	6	2	\N
447	2	6	3	\N
448	2	6	4	\N
449	2	6	5	\N
452	2	7	1	\N
453	2	7	2	\N
454	2	7	3	\N
455	2	7	4	\N
456	2	7	5	\N
457	2	9	1	\N
458	2	9	2	\N
459	2	9	3	\N
460	2	9	4	\N
461	2	9	5	\N
462	2	10	1	\N
463	2	10	2	\N
464	2	10	3	\N
465	2	10	4	\N
466	2	10	5	\N
467	2	11	1	\N
468	2	11	2	\N
469	2	11	3	\N
470	2	11	4	\N
471	2	11	5	\N
472	2	97	1	\N
473	2	97	2	\N
474	2	97	3	\N
475	2	97	4	\N
476	2	97	5	\N
477	11	2	2	\N
478	11	2	5	\N
479	11	3	2	\N
480	11	3	5	\N
481	11	4	2	\N
482	11	4	5	\N
483	11	5	2	\N
484	11	5	5	\N
485	11	6	2	\N
486	11	6	5	\N
487	11	58	2	\N
488	11	58	5	\N
489	11	193	2	\N
490	11	193	5	\N
491	11	7	2	\N
492	11	7	5	\N
493	11	9	2	\N
494	11	9	5	\N
495	11	10	2	\N
496	11	10	5	\N
497	11	97	2	\N
498	11	97	5	\N
499	2	358	1	\N
500	2	358	2	\N
501	2	358	3	\N
502	2	358	4	\N
503	2	358	5	\N
\.


--
-- Data for Name: claimsets; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.claimsets (claimsetid, claimsetname, isedfipreset, forapplicationuseonly) FROM stdin;
1	SIS Vendor	t	f
2	Ed-Fi Sandbox	t	f
3	Roster Vendor	t	f
4	Assessment Vendor	t	f
5	Assessment Read	t	f
6	Bootstrap Descriptors and EdOrgs	t	t
8	District Hosted SIS Vendor	t	f
10	AB Connect	t	f
9	Ed-Fi ODS Admin App	t	t
11	Ed-Fi API Publisher - Reader	t	f
12	Ed-Fi API Publisher - Writer	t	f
13	Finance Vendor	t	f
14	Education Preparation Program	t	f
\.


--
-- Data for Name: resourceclaimactionauthorizationstrategies; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.resourceclaimactionauthorizationstrategies (resourceclaimactionauthorizationstrategyid, resourceclaimactionid, authorizationstrategyid) FROM stdin;
5	21	1
6	17	1
12	8	1
18	20	1
97	98	4
98	99	4
99	100	4
100	101	4
101	102	4
102	103	4
103	104	4
104	105	4
105	106	4
106	107	4
107	108	1
108	109	1
109	110	1
110	111	1
111	112	1
112	113	2
113	114	2
114	115	2
115	116	2
116	117	2
117	118	2
118	118	11
119	119	2
120	119	11
121	120	2
122	120	11
123	121	2
124	121	7
125	122	2
126	122	7
127	123	2
128	123	7
129	124	2
130	124	7
131	125	9
132	125	12
154	147	1
155	148	1
156	149	1
157	150	1
158	151	1
159	152	4
160	153	1
161	154	4
162	155	4
163	156	1
164	157	4
165	158	1
166	159	4
167	160	4
168	161	1
169	162	1
170	163	1
171	164	1
172	165	1
173	166	1
174	167	1
175	168	2
176	169	2
177	170	1
178	171	9
179	172	2
180	173	2
181	174	2
182	175	2
183	176	9
184	177	1
185	178	1
186	179	1
187	180	1
188	181	1
189	182	6
190	183	2
191	184	2
192	185	2
193	186	9
194	187	4
195	188	4
196	189	4
197	190	4
198	191	4
199	192	4
200	193	1
201	194	4
202	195	4
203	196	1
204	197	1
205	198	1
206	199	1
207	200	1
208	201	1
209	202	3
210	203	2
211	204	2
212	205	2
213	206	9
214	207	4
215	208	4
216	209	4
217	210	4
218	211	4
219	212	4
220	213	4
221	214	4
222	215	4
223	216	4
224	217	2
225	218	2
226	219	2
227	220	2
228	221	1
229	222	3
230	223	3
231	224	3
232	225	3
233	226	3
234	227	1
235	228	1
236	229	1
237	230	1
238	231	1
239	232	3
240	233	3
241	234	3
242	235	3
243	236	3
\.


--
-- Data for Name: resourceclaimactions; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.resourceclaimactions (resourceclaimactionid, resourceclaimid, actionid, validationrulesetname) FROM stdin;
8	8	3	\N
17	8	2	\N
20	1	2	\N
21	8	1	\N
98	84	1	\N
99	84	2	\N
100	84	3	\N
101	84	4	\N
102	84	5	\N
103	123	1	\N
104	123	2	\N
105	123	3	\N
106	123	4	\N
107	123	5	\N
108	341	1	\N
109	341	2	\N
110	341	3	\N
111	341	4	\N
112	341	5	\N
113	350	1	\N
114	350	2	\N
115	350	3	\N
116	350	4	\N
117	350	5	\N
118	67	2	\N
119	206	2	\N
120	351	2	\N
121	310	1	\N
122	310	2	\N
123	310	3	\N
124	310	4	\N
125	310	5	\N
147	394	1	\N
148	394	2	\N
149	394	3	\N
150	394	4	\N
151	394	5	\N
152	2	1	\N
153	2	2	\N
154	2	3	\N
155	2	4	\N
156	2	5	\N
157	3	1	\N
158	3	2	\N
159	3	3	\N
160	3	4	\N
161	3	5	\N
162	4	1	\N
163	4	2	\N
164	4	3	\N
165	4	4	\N
166	4	5	\N
167	5	1	\N
168	5	2	\N
169	5	3	\N
170	5	4	\N
171	5	5	\N
172	6	1	\N
173	6	2	\N
174	6	3	\N
175	6	4	\N
176	6	5	\N
177	193	1	\N
178	193	2	\N
179	193	3	\N
180	193	4	\N
181	193	5	\N
182	286	1	\N
183	286	2	\N
184	286	3	\N
185	286	4	\N
186	286	5	\N
187	7	1	\N
188	7	2	\N
189	7	3	\N
190	7	4	\N
191	7	5	\N
192	9	1	\N
193	9	2	\N
194	9	3	\N
195	9	4	\N
196	9	5	\N
197	76	1	\N
198	76	2	\N
199	76	3	\N
200	76	4	\N
201	76	5	\N
202	10	1	\N
203	10	2	\N
204	10	3	\N
205	10	4	\N
206	10	5	\N
207	11	1	\N
208	11	2	\N
209	11	3	\N
210	11	4	\N
211	11	5	\N
212	97	1	\N
213	97	2	\N
214	97	3	\N
215	97	4	\N
216	97	5	\N
217	187	1	\N
218	187	2	\N
219	187	3	\N
220	187	4	\N
221	187	5	\N
222	359	1	\N
223	359	2	\N
224	359	3	\N
225	359	4	\N
226	359	5	\N
227	369	1	\N
228	369	2	\N
229	369	3	\N
230	369	4	\N
231	369	5	\N
232	374	1	\N
233	374	2	\N
234	374	3	\N
235	374	4	\N
236	374	5	\N
\.


--
-- Data for Name: resourceclaims; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.resourceclaims (resourceclaimid, resourcename, claimname, parentresourceclaimid) FROM stdin;
1	types	http://ed-fi.org/ods/identity/claims/domains/edFiTypes	\N
2	systemDescriptors	http://ed-fi.org/ods/identity/claims/domains/systemDescriptors	\N
3	managedDescriptors	http://ed-fi.org/ods/identity/claims/domains/managedDescriptors	\N
4	educationOrganizations	http://ed-fi.org/ods/identity/claims/domains/educationOrganizations	\N
6	relationshipBasedData	http://ed-fi.org/ods/identity/claims/domains/relationshipBasedData	\N
7	assessmentMetadata	http://ed-fi.org/ods/identity/claims/domains/assessmentMetadata	\N
9	educationStandards	http://ed-fi.org/ods/identity/claims/domains/educationStandards	\N
10	primaryRelationships	http://ed-fi.org/ods/identity/claims/domains/primaryRelationships	\N
11	surveyDomain	http://ed-fi.org/ods/identity/claims/domains/surveyDomain	\N
12	absenceEventCategoryDescriptor	http://ed-fi.org/ods/identity/claims/absenceEventCategoryDescriptor	2
13	academicHonorCategoryDescriptor	http://ed-fi.org/ods/identity/claims/academicHonorCategoryDescriptor	2
14	academicSubjectDescriptor	http://ed-fi.org/ods/identity/claims/academicSubjectDescriptor	2
15	academicWeek	http://ed-fi.org/ods/identity/claims/academicWeek	6
16	accommodationDescriptor	http://ed-fi.org/ods/identity/claims/accommodationDescriptor	3
17	accountabilityRating	http://ed-fi.org/ods/identity/claims/accountabilityRating	6
18	accountTypeDescriptor	http://ed-fi.org/ods/identity/claims/accountTypeDescriptor	2
19	achievementCategoryDescriptor	http://ed-fi.org/ods/identity/claims/achievementCategoryDescriptor	2
20	additionalCreditTypeDescriptor	http://ed-fi.org/ods/identity/claims/additionalCreditTypeDescriptor	2
21	addressTypeDescriptor	http://ed-fi.org/ods/identity/claims/addressTypeDescriptor	2
22	administrationEnvironmentDescriptor	http://ed-fi.org/ods/identity/claims/administrationEnvironmentDescriptor	2
23	administrativeFundingControlDescriptor	http://ed-fi.org/ods/identity/claims/administrativeFundingControlDescriptor	2
24	ancestryEthnicOriginDescriptor	http://ed-fi.org/ods/identity/claims/ancestryEthnicOriginDescriptor	2
25	assessment	http://ed-fi.org/ods/identity/claims/assessment	7
26	assessmentCategoryDescriptor	http://ed-fi.org/ods/identity/claims/assessmentCategoryDescriptor	2
27	assessmentIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/assessmentIdentificationSystemDescriptor	2
28	assessmentItem	http://ed-fi.org/ods/identity/claims/assessmentItem	7
29	assessmentItemCategoryDescriptor	http://ed-fi.org/ods/identity/claims/assessmentItemCategoryDescriptor	2
30	assessmentItemResultDescriptor	http://ed-fi.org/ods/identity/claims/assessmentItemResultDescriptor	2
31	assessmentPeriodDescriptor	http://ed-fi.org/ods/identity/claims/assessmentPeriodDescriptor	3
32	assessmentReportingMethodDescriptor	http://ed-fi.org/ods/identity/claims/assessmentReportingMethodDescriptor	3
33	assessmentScoreRangeLearningStandard	http://ed-fi.org/ods/identity/claims/assessmentScoreRangeLearningStandard	7
34	assignmentLateStatusDescriptor	http://ed-fi.org/ods/identity/claims/assignmentLateStatusDescriptor	2
35	attemptStatusDescriptor	http://ed-fi.org/ods/identity/claims/attemptStatusDescriptor	2
36	attendanceEventCategoryDescriptor	http://ed-fi.org/ods/identity/claims/attendanceEventCategoryDescriptor	2
38	barrierToInternetAccessInResidenceDescriptor	http://ed-fi.org/ods/identity/claims/barrierToInternetAccessInResidenceDescriptor	2
39	behaviorDescriptor	http://ed-fi.org/ods/identity/claims/behaviorDescriptor	2
40	bellSchedule	http://ed-fi.org/ods/identity/claims/bellSchedule	6
41	calendar	http://ed-fi.org/ods/identity/claims/calendar	6
42	calendarDate	http://ed-fi.org/ods/identity/claims/calendarDate	6
43	calendarEventDescriptor	http://ed-fi.org/ods/identity/claims/calendarEventDescriptor	2
44	calendarTypeDescriptor	http://ed-fi.org/ods/identity/claims/calendarTypeDescriptor	2
45	careerPathwayDescriptor	http://ed-fi.org/ods/identity/claims/careerPathwayDescriptor	2
46	charterApprovalAgencyTypeDescriptor	http://ed-fi.org/ods/identity/claims/charterApprovalAgencyTypeDescriptor	2
47	charterStatusDescriptor	http://ed-fi.org/ods/identity/claims/charterStatusDescriptor	2
48	chartOfAccount	http://ed-fi.org/ods/identity/claims/chartOfAccount	6
49	citizenshipStatusDescriptor	http://ed-fi.org/ods/identity/claims/citizenshipStatusDescriptor	2
50	classPeriod	http://ed-fi.org/ods/identity/claims/classPeriod	6
51	classroomPositionDescriptor	http://ed-fi.org/ods/identity/claims/classroomPositionDescriptor	2
52	cohort	http://ed-fi.org/ods/identity/claims/cohort	6
53	cohortScopeDescriptor	http://ed-fi.org/ods/identity/claims/cohortScopeDescriptor	2
54	cohortTypeDescriptor	http://ed-fi.org/ods/identity/claims/cohortTypeDescriptor	2
55	cohortYearTypeDescriptor	http://ed-fi.org/ods/identity/claims/cohortYearTypeDescriptor	2
56	communityOrganization	http://ed-fi.org/ods/identity/claims/communityOrganization	4
57	communityProvider	http://ed-fi.org/ods/identity/claims/communityProvider	4
58	communityProviderLicense	http://ed-fi.org/ods/identity/claims/communityProviderLicense	6
59	competencyLevelDescriptor	http://ed-fi.org/ods/identity/claims/competencyLevelDescriptor	2
60	competencyObjective	http://ed-fi.org/ods/identity/claims/competencyObjective	6
61	contact	http://ed-fi.org/ods/identity/claims/contact	5
62	contactTypeDescriptor	http://ed-fi.org/ods/identity/claims/contactTypeDescriptor	2
63	contentClassDescriptor	http://ed-fi.org/ods/identity/claims/contentClassDescriptor	2
64	continuationOfServicesReasonDescriptor	http://ed-fi.org/ods/identity/claims/continuationOfServicesReasonDescriptor	2
65	costRateDescriptor	http://ed-fi.org/ods/identity/claims/costRateDescriptor	2
8	identity	http://ed-fi.org/ods/identity/claims/services/identity	\N
5	people	http://ed-fi.org/ods/identity/claims/domains/people	\N
66	countryDescriptor	http://ed-fi.org/ods/identity/claims/countryDescriptor	2
67	course	http://ed-fi.org/ods/identity/claims/course	6
68	courseAttemptResultDescriptor	http://ed-fi.org/ods/identity/claims/courseAttemptResultDescriptor	2
69	courseDefinedByDescriptor	http://ed-fi.org/ods/identity/claims/courseDefinedByDescriptor	2
70	courseGPAApplicabilityDescriptor	http://ed-fi.org/ods/identity/claims/courseGPAApplicabilityDescriptor	2
71	courseIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/courseIdentificationSystemDescriptor	2
72	courseLevelCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/courseLevelCharacteristicDescriptor	2
73	courseOffering	http://ed-fi.org/ods/identity/claims/courseOffering	6
74	courseRepeatCodeDescriptor	http://ed-fi.org/ods/identity/claims/courseRepeatCodeDescriptor	2
75	courseTranscript	http://ed-fi.org/ods/identity/claims/courseTranscript	6
76	credential	http://ed-fi.org/ods/identity/claims/credential	9
77	credentialFieldDescriptor	http://ed-fi.org/ods/identity/claims/credentialFieldDescriptor	2
78	credentialTypeDescriptor	http://ed-fi.org/ods/identity/claims/credentialTypeDescriptor	2
79	creditCategoryDescriptor	http://ed-fi.org/ods/identity/claims/creditCategoryDescriptor	2
80	creditTypeDescriptor	http://ed-fi.org/ods/identity/claims/creditTypeDescriptor	2
81	cteProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/cteProgramServiceDescriptor	2
82	curriculumUsedDescriptor	http://ed-fi.org/ods/identity/claims/curriculumUsedDescriptor	2
83	deliveryMethodDescriptor	http://ed-fi.org/ods/identity/claims/deliveryMethodDescriptor	2
84	descriptorMapping	http://ed-fi.org/ods/identity/claims/descriptorMapping	6
85	diagnosisDescriptor	http://ed-fi.org/ods/identity/claims/diagnosisDescriptor	2
86	diplomaLevelDescriptor	http://ed-fi.org/ods/identity/claims/diplomaLevelDescriptor	2
87	diplomaTypeDescriptor	http://ed-fi.org/ods/identity/claims/diplomaTypeDescriptor	2
88	disabilityDescriptor	http://ed-fi.org/ods/identity/claims/disabilityDescriptor	2
89	disabilityDesignationDescriptor	http://ed-fi.org/ods/identity/claims/disabilityDesignationDescriptor	2
90	disabilityDeterminationSourceTypeDescriptor	http://ed-fi.org/ods/identity/claims/disabilityDeterminationSourceTypeDescriptor	2
91	disciplineAction	http://ed-fi.org/ods/identity/claims/disciplineAction	6
92	disciplineActionLengthDifferenceReasonDescriptor	http://ed-fi.org/ods/identity/claims/disciplineActionLengthDifferenceReasonDescriptor	2
93	disciplineDescriptor	http://ed-fi.org/ods/identity/claims/disciplineDescriptor	2
94	disciplineIncident	http://ed-fi.org/ods/identity/claims/disciplineIncident	6
95	disciplineIncidentParticipationCodeDescriptor	http://ed-fi.org/ods/identity/claims/disciplineIncidentParticipationCodeDescriptor	2
96	educationalEnvironmentDescriptor	http://ed-fi.org/ods/identity/claims/educationalEnvironmentDescriptor	2
97	educationContent	http://ed-fi.org/ods/identity/claims/educationContent	\N
98	educationOrganizationAssociationTypeDescriptor	http://ed-fi.org/ods/identity/claims/educationOrganizationAssociationTypeDescriptor	2
99	educationOrganizationCategoryDescriptor	http://ed-fi.org/ods/identity/claims/educationOrganizationCategoryDescriptor	2
100	educationOrganizationIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/educationOrganizationIdentificationSystemDescriptor	2
101	educationOrganizationInterventionPrescriptionAssociation	http://ed-fi.org/ods/identity/claims/educationOrganizationInterventionPrescriptionAssociation	6
102	educationOrganizationNetwork	http://ed-fi.org/ods/identity/claims/educationOrganizationNetwork	4
103	educationOrganizationNetworkAssociation	http://ed-fi.org/ods/identity/claims/educationOrganizationNetworkAssociation	6
104	educationOrganizationPeerAssociation	http://ed-fi.org/ods/identity/claims/educationOrganizationPeerAssociation	6
105	educationPlanDescriptor	http://ed-fi.org/ods/identity/claims/educationPlanDescriptor	2
106	educationServiceCenter	http://ed-fi.org/ods/identity/claims/educationServiceCenter	4
107	electronicMailTypeDescriptor	http://ed-fi.org/ods/identity/claims/electronicMailTypeDescriptor	2
108	eligibilityDelayReasonDescriptor	http://ed-fi.org/ods/identity/claims/eligibilityDelayReasonDescriptor	2
109	eligibilityEvaluationTypeDescriptor	http://ed-fi.org/ods/identity/claims/eligibilityEvaluationTypeDescriptor	2
110	employmentStatusDescriptor	http://ed-fi.org/ods/identity/claims/employmentStatusDescriptor	2
111	enrollmentTypeDescriptor	http://ed-fi.org/ods/identity/claims/enrollmentTypeDescriptor	2
112	entryGradeLevelReasonDescriptor	http://ed-fi.org/ods/identity/claims/entryGradeLevelReasonDescriptor	2
113	entryTypeDescriptor	http://ed-fi.org/ods/identity/claims/entryTypeDescriptor	2
114	evaluationDelayReasonDescriptor	http://ed-fi.org/ods/identity/claims/evaluationDelayReasonDescriptor	2
115	evaluationRubricDimension	http://ed-fi.org/ods/identity/claims/evaluationRubricDimension	6
116	eventCircumstanceDescriptor	http://ed-fi.org/ods/identity/claims/eventCircumstanceDescriptor	2
117	exitWithdrawTypeDescriptor	http://ed-fi.org/ods/identity/claims/exitWithdrawTypeDescriptor	2
118	feederSchoolAssociation	http://ed-fi.org/ods/identity/claims/feederSchoolAssociation	6
119	financialCollectionDescriptor	http://ed-fi.org/ods/identity/claims/financialCollectionDescriptor	2
122	grade	http://ed-fi.org/ods/identity/claims/grade	6
123	gradebookEntry	http://ed-fi.org/ods/identity/claims/gradebookEntry	6
124	gradebookEntryTypeDescriptor	http://ed-fi.org/ods/identity/claims/gradebookEntryTypeDescriptor	2
125	gradeLevelDescriptor	http://ed-fi.org/ods/identity/claims/gradeLevelDescriptor	2
126	gradePointAverageTypeDescriptor	http://ed-fi.org/ods/identity/claims/gradePointAverageTypeDescriptor	2
127	gradeTypeDescriptor	http://ed-fi.org/ods/identity/claims/gradeTypeDescriptor	2
128	gradingPeriod	http://ed-fi.org/ods/identity/claims/gradingPeriod	6
129	gradingPeriodDescriptor	http://ed-fi.org/ods/identity/claims/gradingPeriodDescriptor	2
130	graduationPlan	http://ed-fi.org/ods/identity/claims/graduationPlan	6
131	graduationPlanTypeDescriptor	http://ed-fi.org/ods/identity/claims/graduationPlanTypeDescriptor	2
132	gunFreeSchoolsActReportingStatusDescriptor	http://ed-fi.org/ods/identity/claims/gunFreeSchoolsActReportingStatusDescriptor	2
133	homelessPrimaryNighttimeResidenceDescriptor	http://ed-fi.org/ods/identity/claims/homelessPrimaryNighttimeResidenceDescriptor	2
134	homelessProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/homelessProgramServiceDescriptor	2
135	ideaPartDescriptor	http://ed-fi.org/ods/identity/claims/ideaPartDescriptor	2
136	identificationDocumentUseDescriptor	http://ed-fi.org/ods/identity/claims/identificationDocumentUseDescriptor	2
137	incidentLocationDescriptor	http://ed-fi.org/ods/identity/claims/incidentLocationDescriptor	2
138	indicatorDescriptor	http://ed-fi.org/ods/identity/claims/indicatorDescriptor	2
139	indicatorGroupDescriptor	http://ed-fi.org/ods/identity/claims/indicatorGroupDescriptor	2
140	indicatorLevelDescriptor	http://ed-fi.org/ods/identity/claims/indicatorLevelDescriptor	2
141	institutionTelephoneNumberTypeDescriptor	http://ed-fi.org/ods/identity/claims/institutionTelephoneNumberTypeDescriptor	2
142	interactivityStyleDescriptor	http://ed-fi.org/ods/identity/claims/interactivityStyleDescriptor	2
143	internetAccessDescriptor	http://ed-fi.org/ods/identity/claims/internetAccessDescriptor	2
144	internetAccessTypeInResidenceDescriptor	http://ed-fi.org/ods/identity/claims/internetAccessTypeInResidenceDescriptor	2
145	internetPerformanceInResidenceDescriptor	http://ed-fi.org/ods/identity/claims/internetPerformanceInResidenceDescriptor	2
146	intervention	http://ed-fi.org/ods/identity/claims/intervention	6
147	interventionClassDescriptor	http://ed-fi.org/ods/identity/claims/interventionClassDescriptor	2
148	interventionEffectivenessRatingDescriptor	http://ed-fi.org/ods/identity/claims/interventionEffectivenessRatingDescriptor	2
149	interventionPrescription	http://ed-fi.org/ods/identity/claims/interventionPrescription	6
150	interventionStudy	http://ed-fi.org/ods/identity/claims/interventionStudy	6
151	languageDescriptor	http://ed-fi.org/ods/identity/claims/languageDescriptor	2
152	languageInstructionProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/languageInstructionProgramServiceDescriptor	2
153	languageUseDescriptor	http://ed-fi.org/ods/identity/claims/languageUseDescriptor	2
154	learningStandard	http://ed-fi.org/ods/identity/claims/learningStandard	9
155	learningStandardCategoryDescriptor	http://ed-fi.org/ods/identity/claims/learningStandardCategoryDescriptor	2
156	learningStandardEquivalenceAssociation	http://ed-fi.org/ods/identity/claims/learningStandardEquivalenceAssociation	9
157	learningStandardEquivalenceStrengthDescriptor	http://ed-fi.org/ods/identity/claims/learningStandardEquivalenceStrengthDescriptor	2
158	learningStandardScopeDescriptor	http://ed-fi.org/ods/identity/claims/learningStandardScopeDescriptor	2
159	levelOfEducationDescriptor	http://ed-fi.org/ods/identity/claims/levelOfEducationDescriptor	2
160	licenseStatusDescriptor	http://ed-fi.org/ods/identity/claims/licenseStatusDescriptor	2
161	licenseTypeDescriptor	http://ed-fi.org/ods/identity/claims/licenseTypeDescriptor	2
162	limitedEnglishProficiencyDescriptor	http://ed-fi.org/ods/identity/claims/limitedEnglishProficiencyDescriptor	2
163	localAccount	http://ed-fi.org/ods/identity/claims/localAccount	6
164	localActual	http://ed-fi.org/ods/identity/claims/localActual	6
165	localBudget	http://ed-fi.org/ods/identity/claims/localBudget	6
166	localContractedStaff	http://ed-fi.org/ods/identity/claims/localContractedStaff	6
167	localeDescriptor	http://ed-fi.org/ods/identity/claims/localeDescriptor	2
168	localEducationAgency	http://ed-fi.org/ods/identity/claims/localEducationAgency	4
169	localEducationAgencyCategoryDescriptor	http://ed-fi.org/ods/identity/claims/localEducationAgencyCategoryDescriptor	2
170	localEncumbrance	http://ed-fi.org/ods/identity/claims/localEncumbrance	6
171	localPayroll	http://ed-fi.org/ods/identity/claims/localPayroll	6
172	location	http://ed-fi.org/ods/identity/claims/location	6
173	magnetSpecialProgramEmphasisSchoolDescriptor	http://ed-fi.org/ods/identity/claims/magnetSpecialProgramEmphasisSchoolDescriptor	2
174	mediumOfInstructionDescriptor	http://ed-fi.org/ods/identity/claims/mediumOfInstructionDescriptor	2
175	methodCreditEarnedDescriptor	http://ed-fi.org/ods/identity/claims/methodCreditEarnedDescriptor	2
176	migrantEducationProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/migrantEducationProgramServiceDescriptor	2
177	modelEntityDescriptor	http://ed-fi.org/ods/identity/claims/modelEntityDescriptor	2
178	monitoredDescriptor	http://ed-fi.org/ods/identity/claims/monitoredDescriptor	2
179	neglectedOrDelinquentProgramDescriptor	http://ed-fi.org/ods/identity/claims/neglectedOrDelinquentProgramDescriptor	2
180	neglectedOrDelinquentProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/neglectedOrDelinquentProgramServiceDescriptor	2
181	networkPurposeDescriptor	http://ed-fi.org/ods/identity/claims/networkPurposeDescriptor	2
183	objectiveAssessment	http://ed-fi.org/ods/identity/claims/objectiveAssessment	7
184	openStaffPosition	http://ed-fi.org/ods/identity/claims/openStaffPosition	6
185	operationalStatusDescriptor	http://ed-fi.org/ods/identity/claims/operationalStatusDescriptor	2
187	organizationDepartment	http://ed-fi.org/ods/identity/claims/organizationDepartment	4
188	otherNameTypeDescriptor	http://ed-fi.org/ods/identity/claims/otherNameTypeDescriptor	2
189	participationDescriptor	http://ed-fi.org/ods/identity/claims/participationDescriptor	2
190	participationStatusDescriptor	http://ed-fi.org/ods/identity/claims/participationStatusDescriptor	2
191	performanceBaseConversionDescriptor	http://ed-fi.org/ods/identity/claims/performanceBaseConversionDescriptor	2
192	performanceLevelDescriptor	http://ed-fi.org/ods/identity/claims/performanceLevelDescriptor	3
193	person	http://ed-fi.org/ods/identity/claims/person	6
194	personalInformationVerificationDescriptor	http://ed-fi.org/ods/identity/claims/personalInformationVerificationDescriptor	2
195	platformTypeDescriptor	http://ed-fi.org/ods/identity/claims/platformTypeDescriptor	2
196	populationServedDescriptor	http://ed-fi.org/ods/identity/claims/populationServedDescriptor	2
197	postingResultDescriptor	http://ed-fi.org/ods/identity/claims/postingResultDescriptor	2
198	postSecondaryEvent	http://ed-fi.org/ods/identity/claims/postSecondaryEvent	6
199	postSecondaryEventCategoryDescriptor	http://ed-fi.org/ods/identity/claims/postSecondaryEventCategoryDescriptor	2
200	postSecondaryInstitution	http://ed-fi.org/ods/identity/claims/postSecondaryInstitution	4
201	postSecondaryInstitutionLevelDescriptor	http://ed-fi.org/ods/identity/claims/postSecondaryInstitutionLevelDescriptor	2
202	primaryLearningDeviceAccessDescriptor	http://ed-fi.org/ods/identity/claims/primaryLearningDeviceAccessDescriptor	2
203	primaryLearningDeviceAwayFromSchoolDescriptor	http://ed-fi.org/ods/identity/claims/primaryLearningDeviceAwayFromSchoolDescriptor	2
204	primaryLearningDeviceProviderDescriptor	http://ed-fi.org/ods/identity/claims/primaryLearningDeviceProviderDescriptor	2
205	proficiencyDescriptor	http://ed-fi.org/ods/identity/claims/proficiencyDescriptor	2
206	program	http://ed-fi.org/ods/identity/claims/program	6
207	programAssignmentDescriptor	http://ed-fi.org/ods/identity/claims/programAssignmentDescriptor	2
208	programCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/programCharacteristicDescriptor	2
210	programEvaluation	http://ed-fi.org/ods/identity/claims/programEvaluation	6
211	programEvaluationElement	http://ed-fi.org/ods/identity/claims/programEvaluationElement	6
212	programEvaluationObjective	http://ed-fi.org/ods/identity/claims/programEvaluationObjective	6
213	programEvaluationPeriodDescriptor	http://ed-fi.org/ods/identity/claims/programEvaluationPeriodDescriptor	2
214	programEvaluationTypeDescriptor	http://ed-fi.org/ods/identity/claims/programEvaluationTypeDescriptor	2
215	programSponsorDescriptor	http://ed-fi.org/ods/identity/claims/programSponsorDescriptor	2
216	programTypeDescriptor	http://ed-fi.org/ods/identity/claims/programTypeDescriptor	2
217	progressDescriptor	http://ed-fi.org/ods/identity/claims/progressDescriptor	2
218	progressLevelDescriptor	http://ed-fi.org/ods/identity/claims/progressLevelDescriptor	2
220	providerCategoryDescriptor	http://ed-fi.org/ods/identity/claims/providerCategoryDescriptor	2
221	providerProfitabilityDescriptor	http://ed-fi.org/ods/identity/claims/providerProfitabilityDescriptor	2
222	providerStatusDescriptor	http://ed-fi.org/ods/identity/claims/providerStatusDescriptor	2
223	publicationStatusDescriptor	http://ed-fi.org/ods/identity/claims/publicationStatusDescriptor	2
224	questionFormDescriptor	http://ed-fi.org/ods/identity/claims/questionFormDescriptor	2
225	raceDescriptor	http://ed-fi.org/ods/identity/claims/raceDescriptor	2
226	ratingLevelDescriptor	http://ed-fi.org/ods/identity/claims/ratingLevelDescriptor	2
227	reasonExitedDescriptor	http://ed-fi.org/ods/identity/claims/reasonExitedDescriptor	2
229	recognitionTypeDescriptor	http://ed-fi.org/ods/identity/claims/recognitionTypeDescriptor	2
230	relationDescriptor	http://ed-fi.org/ods/identity/claims/relationDescriptor	2
231	repeatIdentifierDescriptor	http://ed-fi.org/ods/identity/claims/repeatIdentifierDescriptor	2
232	reportCard	http://ed-fi.org/ods/identity/claims/reportCard	6
233	reporterDescriptionDescriptor	http://ed-fi.org/ods/identity/claims/reporterDescriptionDescriptor	2
234	reportingTagDescriptor	http://ed-fi.org/ods/identity/claims/reportingTagDescriptor	2
235	residencyStatusDescriptor	http://ed-fi.org/ods/identity/claims/residencyStatusDescriptor	2
236	responseIndicatorDescriptor	http://ed-fi.org/ods/identity/claims/responseIndicatorDescriptor	2
237	responsibilityDescriptor	http://ed-fi.org/ods/identity/claims/responsibilityDescriptor	2
238	restraintEvent	http://ed-fi.org/ods/identity/claims/restraintEvent	6
239	restraintEventReasonDescriptor	http://ed-fi.org/ods/identity/claims/restraintEventReasonDescriptor	2
240	resultDatatypeTypeDescriptor	http://ed-fi.org/ods/identity/claims/resultDatatypeTypeDescriptor	2
241	retestIndicatorDescriptor	http://ed-fi.org/ods/identity/claims/retestIndicatorDescriptor	2
242	school	http://ed-fi.org/ods/identity/claims/school	4
243	schoolCategoryDescriptor	http://ed-fi.org/ods/identity/claims/schoolCategoryDescriptor	2
244	schoolChoiceBasisDescriptor	http://ed-fi.org/ods/identity/claims/schoolChoiceBasisDescriptor	2
245	schoolChoiceImplementStatusDescriptor	http://ed-fi.org/ods/identity/claims/schoolChoiceImplementStatusDescriptor	2
246	schoolFoodServiceProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/schoolFoodServiceProgramServiceDescriptor	2
247	schoolTypeDescriptor	http://ed-fi.org/ods/identity/claims/schoolTypeDescriptor	2
248	schoolYearType	http://ed-fi.org/ods/identity/claims/schoolYearType	1
249	section	http://ed-fi.org/ods/identity/claims/section	6
250	sectionAttendanceTakenEvent	http://ed-fi.org/ods/identity/claims/sectionAttendanceTakenEvent	6
251	sectionCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/sectionCharacteristicDescriptor	2
252	sectionTypeDescriptor	http://ed-fi.org/ods/identity/claims/sectionTypeDescriptor	2
253	separationDescriptor	http://ed-fi.org/ods/identity/claims/separationDescriptor	2
254	separationReasonDescriptor	http://ed-fi.org/ods/identity/claims/separationReasonDescriptor	2
255	serviceDescriptor	http://ed-fi.org/ods/identity/claims/serviceDescriptor	2
256	session	http://ed-fi.org/ods/identity/claims/session	6
257	sexDescriptor	http://ed-fi.org/ods/identity/claims/sexDescriptor	2
259	sourceSystemDescriptor	http://ed-fi.org/ods/identity/claims/sourceSystemDescriptor	2
260	specialEducationExitReasonDescriptor	http://ed-fi.org/ods/identity/claims/specialEducationExitReasonDescriptor	2
261	specialEducationProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/specialEducationProgramServiceDescriptor	2
262	specialEducationSettingDescriptor	http://ed-fi.org/ods/identity/claims/specialEducationSettingDescriptor	2
263	staff	http://ed-fi.org/ods/identity/claims/staff	5
264	staffAbsenceEvent	http://ed-fi.org/ods/identity/claims/staffAbsenceEvent	6
265	staffClassificationDescriptor	http://ed-fi.org/ods/identity/claims/staffClassificationDescriptor	2
266	staffCohortAssociation	http://ed-fi.org/ods/identity/claims/staffCohortAssociation	6
267	staffDisciplineIncidentAssociation	http://ed-fi.org/ods/identity/claims/staffDisciplineIncidentAssociation	6
268	staffEducationOrganizationAssignmentAssociation	http://ed-fi.org/ods/identity/claims/staffEducationOrganizationAssignmentAssociation	10
269	staffEducationOrganizationContactAssociation	http://ed-fi.org/ods/identity/claims/staffEducationOrganizationContactAssociation	6
270	staffEducationOrganizationEmploymentAssociation	http://ed-fi.org/ods/identity/claims/staffEducationOrganizationEmploymentAssociation	10
271	staffIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/staffIdentificationSystemDescriptor	2
272	staffLeave	http://ed-fi.org/ods/identity/claims/staffLeave	6
273	staffLeaveEventCategoryDescriptor	http://ed-fi.org/ods/identity/claims/staffLeaveEventCategoryDescriptor	2
274	staffProgramAssociation	http://ed-fi.org/ods/identity/claims/staffProgramAssociation	6
275	staffSchoolAssociation	http://ed-fi.org/ods/identity/claims/staffSchoolAssociation	6
276	staffSectionAssociation	http://ed-fi.org/ods/identity/claims/staffSectionAssociation	6
277	stateAbbreviationDescriptor	http://ed-fi.org/ods/identity/claims/stateAbbreviationDescriptor	2
278	stateEducationAgency	http://ed-fi.org/ods/identity/claims/stateEducationAgency	4
279	student	http://ed-fi.org/ods/identity/claims/student	5
280	studentAcademicRecord	http://ed-fi.org/ods/identity/claims/studentAcademicRecord	6
281	studentAssessment	http://ed-fi.org/ods/identity/claims/studentAssessment	7
282	studentAssessmentEducationOrganizationAssociation	http://ed-fi.org/ods/identity/claims/studentAssessmentEducationOrganizationAssociation	6
283	studentCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/studentCharacteristicDescriptor	2
284	studentCohortAssociation	http://ed-fi.org/ods/identity/claims/studentCohortAssociation	6
285	studentCompetencyObjective	http://ed-fi.org/ods/identity/claims/studentCompetencyObjective	6
286	studentContactAssociation	http://ed-fi.org/ods/identity/claims/studentContactAssociation	6
287	studentCTEProgramAssociation	http://ed-fi.org/ods/identity/claims/studentCTEProgramAssociation	6
288	studentDisciplineIncidentBehaviorAssociation	http://ed-fi.org/ods/identity/claims/studentDisciplineIncidentBehaviorAssociation	6
289	studentDisciplineIncidentNonOffenderAssociation	http://ed-fi.org/ods/identity/claims/studentDisciplineIncidentNonOffenderAssociation	6
290	studentEducationOrganizationAssociation	http://ed-fi.org/ods/identity/claims/studentEducationOrganizationAssociation	6
291	studentEducationOrganizationResponsibilityAssociation	http://ed-fi.org/ods/identity/claims/studentEducationOrganizationResponsibilityAssociation	6
292	studentGradebookEntry	http://ed-fi.org/ods/identity/claims/studentGradebookEntry	6
293	studentHomelessProgramAssociation	http://ed-fi.org/ods/identity/claims/studentHomelessProgramAssociation	6
294	studentIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/studentIdentificationSystemDescriptor	2
295	studentInterventionAssociation	http://ed-fi.org/ods/identity/claims/studentInterventionAssociation	6
296	studentInterventionAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentInterventionAttendanceEvent	6
297	studentLanguageInstructionProgramAssociation	http://ed-fi.org/ods/identity/claims/studentLanguageInstructionProgramAssociation	6
298	studentMigrantEducationProgramAssociation	http://ed-fi.org/ods/identity/claims/studentMigrantEducationProgramAssociation	6
299	studentNeglectedOrDelinquentProgramAssociation	http://ed-fi.org/ods/identity/claims/studentNeglectedOrDelinquentProgramAssociation	6
300	studentParticipationCodeDescriptor	http://ed-fi.org/ods/identity/claims/studentParticipationCodeDescriptor	2
301	studentProgramAssociation	http://ed-fi.org/ods/identity/claims/studentProgramAssociation	6
302	studentProgramAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentProgramAttendanceEvent	6
303	studentProgramEvaluation	http://ed-fi.org/ods/identity/claims/studentProgramEvaluation	6
304	studentSchoolAssociation	http://ed-fi.org/ods/identity/claims/studentSchoolAssociation	10
305	studentSchoolAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentSchoolAttendanceEvent	6
306	studentSchoolFoodServiceProgramAssociation	http://ed-fi.org/ods/identity/claims/studentSchoolFoodServiceProgramAssociation	6
307	studentSectionAssociation	http://ed-fi.org/ods/identity/claims/studentSectionAssociation	6
308	studentSectionAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentSectionAttendanceEvent	6
309	studentSpecialEducationProgramAssociation	http://ed-fi.org/ods/identity/claims/studentSpecialEducationProgramAssociation	6
310	studentSpecialEducationProgramEligibilityAssociation	http://ed-fi.org/ods/identity/claims/studentSpecialEducationProgramEligibilityAssociation	6
311	studentTitleIPartAProgramAssociation	http://ed-fi.org/ods/identity/claims/studentTitleIPartAProgramAssociation	6
312	submissionStatusDescriptor	http://ed-fi.org/ods/identity/claims/submissionStatusDescriptor	2
313	supporterMilitaryConnectionDescriptor	http://ed-fi.org/ods/identity/claims/supporterMilitaryConnectionDescriptor	2
314	survey	http://ed-fi.org/ods/identity/claims/survey	11
315	surveyCategoryDescriptor	http://ed-fi.org/ods/identity/claims/surveyCategoryDescriptor	2
316	surveyCourseAssociation	http://ed-fi.org/ods/identity/claims/surveyCourseAssociation	6
317	surveyLevelDescriptor	http://ed-fi.org/ods/identity/claims/surveyLevelDescriptor	2
318	surveyProgramAssociation	http://ed-fi.org/ods/identity/claims/surveyProgramAssociation	6
319	surveyQuestion	http://ed-fi.org/ods/identity/claims/surveyQuestion	11
320	surveyQuestionResponse	http://ed-fi.org/ods/identity/claims/surveyQuestionResponse	11
321	surveyResponse	http://ed-fi.org/ods/identity/claims/surveyResponse	11
322	surveyResponseEducationOrganizationTargetAssociation	http://ed-fi.org/ods/identity/claims/surveyResponseEducationOrganizationTargetAssociation	6
323	surveyResponseStaffTargetAssociation	http://ed-fi.org/ods/identity/claims/surveyResponseStaffTargetAssociation	6
324	surveySection	http://ed-fi.org/ods/identity/claims/surveySection	11
325	surveySectionAssociation	http://ed-fi.org/ods/identity/claims/surveySectionAssociation	6
326	surveySectionResponse	http://ed-fi.org/ods/identity/claims/surveySectionResponse	11
327	surveySectionResponseEducationOrganizationTargetAssociation	http://ed-fi.org/ods/identity/claims/surveySectionResponseEducationOrganizationTargetAssociation	6
328	surveySectionResponseStaffTargetAssociation	http://ed-fi.org/ods/identity/claims/surveySectionResponseStaffTargetAssociation	6
329	teachingCredentialBasisDescriptor	http://ed-fi.org/ods/identity/claims/teachingCredentialBasisDescriptor	2
330	teachingCredentialDescriptor	http://ed-fi.org/ods/identity/claims/teachingCredentialDescriptor	2
331	technicalSkillsAssessmentDescriptor	http://ed-fi.org/ods/identity/claims/technicalSkillsAssessmentDescriptor	2
332	telephoneNumberTypeDescriptor	http://ed-fi.org/ods/identity/claims/telephoneNumberTypeDescriptor	2
333	termDescriptor	http://ed-fi.org/ods/identity/claims/termDescriptor	2
334	titleIPartAParticipantDescriptor	http://ed-fi.org/ods/identity/claims/titleIPartAParticipantDescriptor	2
335	titleIPartAProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/titleIPartAProgramServiceDescriptor	2
336	titleIPartASchoolDesignationDescriptor	http://ed-fi.org/ods/identity/claims/titleIPartASchoolDesignationDescriptor	2
337	tribalAffiliationDescriptor	http://ed-fi.org/ods/identity/claims/tribalAffiliationDescriptor	2
338	visaDescriptor	http://ed-fi.org/ods/identity/claims/visaDescriptor	2
339	weaponDescriptor	http://ed-fi.org/ods/identity/claims/weaponDescriptor	2
228	reasonNotTestedDescriptor	http://ed-fi.org/ods/identity/claims/reasonNotTestedDescriptor	3
340	finance	http://ed-fi.org/ods/identity/claims/domains/finance	\N
341	dimensions	http://ed-fi.org/ods/identity/claims/domains/finance/dimensions	340
342	fundDimension	http://ed-fi.org/ods/identity/claims/ed-fi/fundDimension	341
343	programDimension	http://ed-fi.org/ods/identity/claims/ed-fi/programDimension	341
344	functionDimension	http://ed-fi.org/ods/identity/claims/ed-fi/functionDimension	341
345	objectDimension	http://ed-fi.org/ods/identity/claims/ed-fi/objectDimension	341
346	projectDimension	http://ed-fi.org/ods/identity/claims/ed-fi/projectDimension	341
347	operationalUnitDimension	http://ed-fi.org/ods/identity/claims/ed-fi/operationalUnitDimension	341
348	sourceDimension	http://ed-fi.org/ods/identity/claims/ed-fi/sourceDimension	341
349	balanceSheetDimension	http://ed-fi.org/ods/identity/claims/ed-fi/balanceSheetDimension	341
350	locals	http://ed-fi.org/ods/identity/claims/domains/finance/locals	340
351	chartOfAccount	http://ed-fi.org/ods/identity/claims/ed-fi/chartOfAccount	350
352	localAccount	http://ed-fi.org/ods/identity/claims/ed-fi/localAccount	350
353	localBudget	http://ed-fi.org/ods/identity/claims/ed-fi/localBudget	350
354	localActual	http://ed-fi.org/ods/identity/claims/ed-fi/localActual	350
355	localEncumbrance	http://ed-fi.org/ods/identity/claims/ed-fi/localEncumbrance	350
356	localContractedStaff	http://ed-fi.org/ods/identity/claims/ed-fi/localContractedStaff	350
357	localPayroll	http://ed-fi.org/ods/identity/claims/ed-fi/localPayroll	350
358	tpdm	http://ed-fi.org/ods/identity/claims/domains/tpdm	\N
359	performanceEvaluation	http://ed-fi.org/ods/identity/claims/domains/tpdm/performanceEvaluation	358
360	performanceEvaluation	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluation	359
361	evaluation	http://ed-fi.org/ods/identity/claims/tpdm/evaluation	359
362	evaluationObjective	http://ed-fi.org/ods/identity/claims/tpdm/evaluationObjective	359
363	evaluationElement	http://ed-fi.org/ods/identity/claims/tpdm/evaluationElement	359
364	rubricDimension	http://ed-fi.org/ods/identity/claims/tpdm/rubricDimension	359
365	evaluationRating	http://ed-fi.org/ods/identity/claims/tpdm/evaluationRating	359
366	evaluationObjectiveRating	http://ed-fi.org/ods/identity/claims/tpdm/evaluationObjectiveRating	359
367	evaluationElementRating	http://ed-fi.org/ods/identity/claims/tpdm/evaluationElementRating	359
368	performanceEvaluationRating	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluationRating	359
369	noFurtherAuthorizationRequiredData	http://ed-fi.org/ods/identity/claims/domains/tpdm/noFurtherAuthorizationRequiredData	358
370	candidatePreparation	http://ed-fi.org/ods/identity/claims/domains/tpdm/candidatePreparation	369
371	candidateEducatorPreparationProgramAssociation	http://ed-fi.org/ods/identity/claims/tpdm/candidateEducatorPreparationProgramAssociation	370
372	students	http://ed-fi.org/ods/identity/claims/domains/tpdm/students	369
373	financialAid	http://ed-fi.org/ods/identity/claims/tpdm/financialAid	372
374	educatorPreparationProgram	http://ed-fi.org/ods/identity/claims/tpdm/educatorPreparationProgram	358
375	descriptors	http://ed-fi.org/ods/identity/claims/domains/tpdm/descriptors	2
376	accreditationStatusDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/accreditationStatusDescriptor	375
377	aidTypeDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/aidTypeDescriptor	375
378	certificationRouteDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/certificationRouteDescriptor	375
379	coteachingStyleObservedDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/coteachingStyleObservedDescriptor	375
380	credentialStatusDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/credentialStatusDescriptor	375
381	educatorRoleDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/educatorRoleDescriptor	375
382	englishLanguageExamDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/englishLanguageExamDescriptor	375
383	ePPProgramPathwayDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/ePPProgramPathwayDescriptor	375
384	evaluationElementRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationElementRatingLevelDescriptor	375
385	evaluationPeriodDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationPeriodDescriptor	375
386	evaluationRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationRatingLevelDescriptor	375
387	evaluationRatingStatusDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationRatingStatusDescriptor	375
388	evaluationTypeDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationTypeDescriptor	375
389	genderDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/genderDescriptor	375
390	objectiveRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/objectiveRatingLevelDescriptor	375
391	performanceEvaluationRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluationRatingLevelDescriptor	375
392	performanceEvaluationTypeDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluationTypeDescriptor	375
393	rubricRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/rubricRatingLevelDescriptor	375
394	candidate	http://ed-fi.org/ods/identity/claims/tpdm/candidate	5
395	surveyResponsePersonTargetAssociation	http://ed-fi.org/ods/identity/claims/tpdm/surveyResponsePersonTargetAssociation	11
396	surveySectionResponsePersonTargetAssociation	http://ed-fi.org/ods/identity/claims/tpdm/surveySectionResponsePersonTargetAssociation	11
397	snapshot	http://ed-fi.org/ods/identity/claims/publishing/snapshot	\N
\.


--
-- Data for Name: DeployJournal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DeployJournal" (schemaversionsid, scriptname, applied) FROM stdin;
1	Artifacts.PgSql.Structure.Security.0010-Schemas.sql	2023-12-06 23:16:21.579332
2	Artifacts.PgSql.Structure.Security.0020-Tables.sql	2023-12-06 23:16:21.67488
3	Artifacts.PgSql.Structure.Security.0030-ForeignKeys.sql	2023-12-06 23:16:21.705102
4	Artifacts.PgSql.Structure.Security.0040-Indexes.sql	2023-12-06 23:16:21.777019
5	Artifacts.PgSql.Structure.Security.0050-AddUniqueConstraintResourceClaimsClaimName.sql	2023-12-06 23:16:21.830052
6	Artifacts.PgSql.Structure.Security.0050-Tables-MultipleAuthStrats.sql	2023-12-06 23:16:21.917113
7	Artifacts.PgSql.Structure.Security.0060-AlterClaimsetTable.sql	2023-12-06 23:16:21.92954
8	Artifacts.PgSql.Structure.Security.0070-RemoveUnusedApplicationTableAndRemoveDisplayNameResourceName.sql	2023-12-06 23:16:21.95665
9	Artifacts.PgSql.Structure.Security.0080-Alter-Claimsets-Add-Unique-Constraint-ClaimsetName.sql	2023-12-06 23:16:21.965719
10	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.0001-ResourceClaimMetadata.sql	2023-12-06 23:16:21.999529
11	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.0002-ResourceClaimMetadata_generated.sql	2023-12-06 23:16:22.085909
12	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.1090-ManagedReasonNotTestedDescriptor.sql	2023-12-06 23:16:22.090048
13	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2000-AdminApp-ClaimSets.sql	2023-12-06 23:16:22.098687
14	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2000-AdminApp-ClaimSets_UpgradePath.sql	2023-12-06 23:16:22.107286
15	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2020-MigrateDataForMultipleAuthStrategies.sql	2023-12-06 23:16:22.112293
16	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2030-Clean-up-ReadChanges-from-AB-Connect-Claim-Set.sql	2023-12-06 23:16:22.126291
17	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2030-DropSingleAuthStrategyTables.sql	2023-12-06 23:16:22.136563
18	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2050-UpdateClaimSetReadOnlyAndInternalUseOnlyColum.sql	2023-12-06 23:16:22.141227
19	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2060-OwnershipBased-claims-for-People.sql	2023-12-06 23:16:22.150628
20	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2070-DataStandard4.0a-ResourceClaimMetadata.sql	2023-12-06 23:16:22.162457
21	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2070-Namespace-auth-for-GradebookEntry.sql	2023-12-06 23:16:22.170027
22	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2080-Finance-domain-security-metadata.sql	2023-12-06 23:16:22.205239
23	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2090-RemoveOwnershipBasedTestClaimSet.sql	2023-12-06 23:16:22.210993
24	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2100-UpdateClaimSetInternalUseOnlyColum.sql	2023-12-06 23:16:22.214014
25	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2120-Add-Auth-Strategies-Inverted-EdOrg-Hierarchy.sql	2023-12-06 23:16:22.217195
26	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2130-Reference-data-also-use-inverted-EdOrgHierarchy-for-Read.sql	2023-12-06 23:16:22.227648
27	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2140-Update-identities-claim-name.sql	2023-12-06 23:16:22.231144
28	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2145-Add-RelationshipsWithStudentsOnlyThroughResponsibilityIncludingDeletes-strategy.sql	2023-12-06 23:16:22.23602
29	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2150-StudentSpecialEducationProgramEligibilityAssociation-multiple-auth-strat.sql	2023-12-06 23:16:22.292279
30	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.2160-StudentContactAssociation-authorized-on-StudentOnly.sql	2023-12-06 23:16:22.299755
31	Extensions.TPDM.1.1.0.Standard.5.0.0.Artifacts.PgSql.Data.Security.1010-TPDM-ResourceClaims.sql	2023-12-06 23:16:22.334609
32	Extensions.TPDM.1.1.0.Standard.5.0.0.Artifacts.PgSql.Data.Security.1011-TPDM-Candidate.sql	2023-12-06 23:16:22.340194
33	Extensions.TPDM.1.1.0.Standard.5.0.0.Artifacts.PgSql.Data.Security.1020-TPDM-EducationPreparationProgram-ClaimSet.sql	2023-12-06 23:16:22.346042
34	Extensions.TPDM.1.1.0.Standard.5.0.0.Artifacts.PgSql.Data.Security.1030-TPDM-DelPerfEvalRatingsAuthStrategy.sql	2023-12-06 23:16:22.350287
35	Extensions.TPDM.1.1.0.Standard.5.0.0.Artifacts.PgSql.Data.Security.1030-TPDM-RmvReadChangesFromEdPrepProgClaimSet.sql	2023-12-06 23:16:22.352899
36	Extensions.TPDM.1.1.0.Standard.5.0.0.Artifacts.PgSql.Data.Security.1040-TPDM-RmvParentResourceClaimFromPeopleClaim.sql	2023-12-06 23:16:22.357603
37	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.Changes.0010-API-Publisher-Reader-Security-Metadata.sql	2023-12-06 23:16:22.402385
38	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.Changes.0020-API-Publisher-Writer-Security-Metadata.sql	2023-12-06 23:16:22.436932
39	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.Changes.0030-Sandbox-Publishing-Security-Metadata.sql	2023-12-06 23:16:22.465129
40	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.Changes.0040-Add-ReadChanges-to-Sandbox-Claim-Set.sql	2023-12-06 23:16:22.53524
41	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.Changes.0050-Remove-Overrides-from-Api-Publisher-Reader-Claim-Set.sql	2023-12-06 23:16:22.554642
42	EdFi.Ods.Standard.Standard.5.0.0.Artifacts.PgSql.Data.Security.Changes.0060-Apply-ReadChanges-Default-to-OrgDept.sql	2023-12-06 23:16:22.562569
43	Extensions.TPDM.1.1.0.Standard.5.0.0.Artifacts.PgSql.Data.Security.Changes.0010-EdFi-Sandbox-ReadChanges.sql	2023-12-06 23:16:22.586001
\.


--
-- Name: actions_actionid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.actions_actionid_seq', 5, true);


--
-- Name: authorizationstrategies_authorizationstrategyid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.authorizationstrategies_authorizationstrategyid_seq', 12, true);


--
-- Name: claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq', 111, true);


--
-- Name: claimsetresourceclaimactions_claimsetresourceclaimactionid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.claimsetresourceclaimactions_claimsetresourceclaimactionid_seq', 503, true);


--
-- Name: claimsets_claimsetid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.claimsets_claimsetid_seq', 14, true);


--
-- Name: resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq', 243, true);


--
-- Name: resourceclaimactions_resourceclaimactionid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.resourceclaimactions_resourceclaimactionid_seq', 236, true);


--
-- Name: resourceclaims_resourceclaimid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.resourceclaims_resourceclaimid_seq', 397, true);


--
-- Name: DeployJournal_schemaversionsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."DeployJournal_schemaversionsid_seq"', 43, true);


--
-- Name: actions actions_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.actions
    ADD CONSTRAINT actions_pk PRIMARY KEY (actionid);


--
-- Name: authorizationstrategies authorizationstrategies_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.authorizationstrategies
    ADD CONSTRAINT authorizationstrategies_pk PRIMARY KEY (authorizationstrategyid);


--
-- Name: claimsetresourceclaimactionauthorizationstrategyoverrides claimsetresourceclaimactionauthorizationstrategyoverrides_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactionauthorizationstrategyoverrides
    ADD CONSTRAINT claimsetresourceclaimactionauthorizationstrategyoverrides_pk PRIMARY KEY (claimsetresourceclaimactionauthorizationstrategyoverrideid);


--
-- Name: claimsetresourceclaimactions claimsetresourceclaimactions_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactions
    ADD CONSTRAINT claimsetresourceclaimactions_pk PRIMARY KEY (claimsetresourceclaimactionid);


--
-- Name: claimsets claimsets_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsets
    ADD CONSTRAINT claimsets_pk PRIMARY KEY (claimsetid);


--
-- Name: resourceclaimactionauthorizationstrategies resourceclaimactionauthorizationstrategies_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactionauthorizationstrategies
    ADD CONSTRAINT resourceclaimactionauthorizationstrategies_pk PRIMARY KEY (resourceclaimactionauthorizationstrategyid);


--
-- Name: resourceclaimactions resourceclaimactionid_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactions
    ADD CONSTRAINT resourceclaimactionid_pk PRIMARY KEY (resourceclaimactionid);


--
-- Name: resourceclaims resourceclaims_pk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaims
    ADD CONSTRAINT resourceclaims_pk PRIMARY KEY (resourceclaimid);


--
-- Name: claimsets uc_claimsets_claimsetname; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsets
    ADD CONSTRAINT uc_claimsets_claimsetname UNIQUE (claimsetname);


--
-- Name: resourceclaims uc_resourceclaims_claimname; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaims
    ADD CONSTRAINT uc_resourceclaims_claimname UNIQUE (claimname);


--
-- Name: DeployJournal PK_DeployJournal_Id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeployJournal"
    ADD CONSTRAINT "PK_DeployJournal_Id" PRIMARY KEY (schemaversionsid);


--
-- Name: actionauthorizationstrategyoverrides_ui_claimsetresourceclaimac; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX actionauthorizationstrategyoverrides_ui_claimsetresourceclaimac ON dbo.claimsetresourceclaimactionauthorizationstrategyoverrides USING btree (claimsetresourceclaimactionid, authorizationstrategyid);


--
-- Name: claimsetresourceclaimactions_ui_claimsetid_resourceclaimid_acti; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX claimsetresourceclaimactions_ui_claimsetid_resourceclaimid_acti ON dbo.claimsetresourceclaimactions USING btree (claimsetid, resourceclaimid, actionid);


--
-- Name: ix_resourceclaims_parentresourceclaimid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX ix_resourceclaims_parentresourceclaimid ON dbo.resourceclaims USING btree (parentresourceclaimid);


--
-- Name: resourceclaimactionauthorizationstrategies_ui_resourceclaimacti; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX resourceclaimactionauthorizationstrategies_ui_resourceclaimacti ON dbo.resourceclaimactionauthorizationstrategies USING btree (resourceclaimactionid, authorizationstrategyid);


--
-- Name: resourceclaimactions_ui_resourceclaimid_actionid; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX resourceclaimactions_ui_resourceclaimid_actionid ON dbo.resourceclaimactions USING btree (resourceclaimid, actionid);


--
-- Name: resourceclaimactionauthorizationstrategies fk_actionauthorizationstrategies_actionauthorizationid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactionauthorizationstrategies
    ADD CONSTRAINT fk_actionauthorizationstrategies_actionauthorizationid FOREIGN KEY (resourceclaimactionid) REFERENCES dbo.resourceclaimactions(resourceclaimactionid);


--
-- Name: resourceclaimactionauthorizationstrategies fk_actionauthorizationstrategies_authorizationstrategyid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactionauthorizationstrategies
    ADD CONSTRAINT fk_actionauthorizationstrategies_authorizationstrategyid FOREIGN KEY (authorizationstrategyid) REFERENCES dbo.authorizationstrategies(authorizationstrategyid) ON DELETE CASCADE;


--
-- Name: claimsetresourceclaimactionauthorizationstrategyoverrides fk_actionauthorizationstrategyoverrides_actionauthorizations; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactionauthorizationstrategyoverrides
    ADD CONSTRAINT fk_actionauthorizationstrategyoverrides_actionauthorizations FOREIGN KEY (claimsetresourceclaimactionid) REFERENCES dbo.claimsetresourceclaimactions(claimsetresourceclaimactionid);


--
-- Name: claimsetresourceclaimactionauthorizationstrategyoverrides fk_actionauthorizationstrategyoverrides_authorizationstrategies; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactionauthorizationstrategyoverrides
    ADD CONSTRAINT fk_actionauthorizationstrategyoverrides_authorizationstrategies FOREIGN KEY (authorizationstrategyid) REFERENCES dbo.authorizationstrategies(authorizationstrategyid) ON DELETE CASCADE;


--
-- Name: claimsetresourceclaimactions fk_claimsetresourceclaimactions_actions; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactions
    ADD CONSTRAINT fk_claimsetresourceclaimactions_actions FOREIGN KEY (actionid) REFERENCES dbo.actions(actionid);


--
-- Name: claimsetresourceclaimactions fk_claimsetresourceclaimactions_claimsets; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactions
    ADD CONSTRAINT fk_claimsetresourceclaimactions_claimsets FOREIGN KEY (claimsetid) REFERENCES dbo.claimsets(claimsetid) ON DELETE CASCADE;


--
-- Name: claimsetresourceclaimactions fk_claimsetresourceclaimactions_resourceclaims; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.claimsetresourceclaimactions
    ADD CONSTRAINT fk_claimsetresourceclaimactions_resourceclaims FOREIGN KEY (resourceclaimid) REFERENCES dbo.resourceclaims(resourceclaimid);


--
-- Name: resourceclaimactions fk_resourceclaimactions_actions; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactions
    ADD CONSTRAINT fk_resourceclaimactions_actions FOREIGN KEY (actionid) REFERENCES dbo.actions(actionid);


--
-- Name: resourceclaimactions fk_resourceclaimactions_resourceclaims; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaimactions
    ADD CONSTRAINT fk_resourceclaimactions_resourceclaims FOREIGN KEY (resourceclaimid) REFERENCES dbo.resourceclaims(resourceclaimid) ON DELETE CASCADE;


--
-- Name: resourceclaims fk_resourceclaims_resourceclaims; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.resourceclaims
    ADD CONSTRAINT fk_resourceclaims_resourceclaims FOREIGN KEY (parentresourceclaimid) REFERENCES dbo.resourceclaims(resourceclaimid);


--
-- PostgreSQL database dump complete
--

