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
1	120	1
2	121	1
3	122	1
4	123	1
5	124	1
6	125	1
7	126	1
8	127	1
9	128	1
10	129	1
11	130	1
12	131	1
13	132	1
14	133	1
15	134	1
16	135	1
17	136	1
18	137	1
19	138	1
20	139	1
21	140	1
22	141	1
23	142	1
37	215	1
38	216	1
39	217	1
40	218	1
41	219	1
42	220	1
43	221	1
44	222	1
45	223	1
46	224	1
47	225	1
48	226	1
49	227	1
67	335	1
68	336	1
69	337	1
70	338	1
71	339	1
72	340	1
73	341	1
74	342	1
75	343	1
76	344	1
77	345	1
78	346	1
79	347	1
80	360	1
81	361	1
82	362	1
83	363	1
84	364	1
85	365	1
86	366	1
87	367	1
88	368	1
89	369	1
90	370	1
91	371	1
92	376	1
93	377	1
94	378	1
95	379	1
96	380	1
97	381	1
98	382	1
99	383	1
111	493	1
112	494	1
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
9	1	2	2	\N
10	1	96	4	\N
11	1	10	4	\N
12	1	5	2	\N
13	1	9	4	\N
14	1	6	4	\N
15	1	96	1	\N
16	1	4	2	\N
17	1	3	2	\N
18	1	10	3	\N
19	1	3	3	\N
20	1	96	3	\N
21	1	9	1	\N
22	1	7	3	\N
23	1	7	2	\N
24	1	3	4	\N
25	1	6	2	\N
26	1	3	1	\N
27	1	6	3	\N
28	1	9	2	\N
29	1	96	2	\N
30	1	7	4	\N
31	1	9	3	\N
61	2	8	3	\N
64	2	8	1	\N
68	2	1	2	\N
71	2	8	2	\N
76	2	58	1	\N
77	2	58	2	\N
78	2	58	3	\N
79	2	58	4	\N
80	3	4	2	\N
81	3	50	2	\N
82	3	66	2	\N
83	3	72	2	\N
84	3	166	2	\N
85	3	238	2	\N
86	3	244	2	\N
87	3	250	2	\N
88	3	255	2	\N
89	3	263	2	\N
90	3	266	2	\N
91	3	292	2	\N
92	3	295	2	\N
93	4	14	1	\N
94	4	3	1	\N
95	4	147	1	\N
96	4	1	2	\N
97	4	14	3	\N
98	4	148	2	\N
99	4	14	4	\N
100	4	3	4	\N
101	4	3	2	\N
102	4	148	3	\N
103	4	148	4	\N
104	4	266	2	\N
105	4	148	1	\N
106	4	14	2	\N
107	4	147	2	\N
108	4	7	2	\N
109	4	3	3	\N
110	4	147	4	\N
111	4	7	3	\N
112	4	7	1	\N
113	4	2	2	\N
114	4	7	4	\N
115	4	147	3	\N
116	5	7	2	\N
117	5	147	2	\N
118	5	148	2	\N
119	5	266	2	\N
120	6	2	1	\N
121	6	3	1	\N
122	6	4	1	\N
123	6	17	1	\N
124	6	50	1	\N
125	6	56	1	\N
126	6	57	1	\N
127	6	58	1	\N
128	6	66	1	\N
129	6	101	1	\N
130	6	102	1	\N
131	6	103	1	\N
132	6	105	1	\N
133	6	112	1	\N
134	6	147	1	\N
135	6	148	1	\N
136	6	150	1	\N
137	6	162	1	\N
138	6	166	1	\N
139	6	196	1	\N
140	6	202	1	\N
141	6	232	1	\N
142	6	265	1	\N
143	8	182	1	\N
144	8	6	4	\N
145	8	10	2	\N
146	8	7	3	\N
147	8	3	2	\N
148	8	182	4	\N
149	8	96	1	\N
150	8	6	2	\N
151	8	10	4	\N
152	8	9	2	\N
153	8	7	2	\N
154	8	232	4	\N
155	8	9	1	\N
156	8	2	2	\N
157	8	232	3	\N
158	8	10	3	\N
159	8	5	2	\N
160	8	1	2	\N
161	8	9	4	\N
162	8	182	2	\N
163	8	5	1	\N
164	8	96	4	\N
165	8	162	3	\N
166	8	9	3	\N
167	8	6	1	\N
168	8	7	1	\N
169	8	6	3	\N
170	8	3	1	\N
171	8	232	2	\N
172	8	162	2	\N
173	8	182	3	\N
174	8	10	1	\N
175	8	3	4	\N
176	8	4	2	\N
177	8	7	4	\N
178	8	96	3	\N
179	8	96	2	\N
180	8	5	4	\N
181	8	5	3	\N
182	8	232	1	\N
183	8	3	3	\N
215	9	2	1	\N
216	9	3	1	\N
217	9	4	1	\N
218	9	2	2	\N
219	9	3	2	\N
220	9	4	2	\N
221	9	2	3	\N
222	9	3	3	\N
223	9	4	3	\N
224	9	2	4	\N
225	9	3	4	\N
226	9	4	4	\N
227	9	1	2	\N
228	10	9	1	\N
229	10	9	2	\N
230	10	9	3	\N
231	10	9	4	\N
232	10	14	1	\N
233	10	14	2	\N
234	10	14	3	\N
235	10	14	4	\N
236	10	119	1	\N
237	10	119	2	\N
238	10	119	3	\N
239	10	119	4	\N
240	10	214	1	\N
241	10	214	2	\N
242	10	214	3	\N
243	10	214	4	\N
244	4	188	1	\N
245	4	188	2	\N
250	2	326	1	\N
251	2	326	2	\N
252	2	326	3	\N
253	2	326	4	\N
254	2	326	5	\N
255	11	326	2	\N
256	11	326	5	\N
257	12	326	1	\N
258	12	326	2	\N
259	12	326	3	\N
260	12	326	4	\N
261	13	327	2	\N
262	13	336	1	\N
263	13	336	2	\N
264	13	336	3	\N
265	13	336	4	\N
270	6	360	1	\N
271	14	4	1	\N
272	14	4	2	\N
273	14	4	3	\N
274	14	4	4	\N
275	14	11	1	\N
276	14	11	2	\N
277	14	11	3	\N
278	14	11	4	\N
279	14	75	1	\N
280	14	75	2	\N
281	14	75	3	\N
282	14	75	4	\N
283	14	189	1	\N
284	14	189	2	\N
285	14	189	3	\N
286	14	189	4	\N
287	14	266	1	\N
288	14	266	2	\N
289	14	266	3	\N
290	14	266	4	\N
291	14	292	1	\N
292	14	292	2	\N
293	14	292	3	\N
294	14	292	4	\N
295	14	345	1	\N
296	14	345	2	\N
297	14	345	3	\N
298	14	345	4	\N
299	14	356	1	\N
300	14	356	2	\N
301	14	356	3	\N
302	14	356	4	\N
303	14	360	1	\N
304	14	360	2	\N
305	14	360	3	\N
306	14	360	4	\N
307	14	380	1	\N
308	14	380	2	\N
309	14	380	3	\N
310	14	380	4	\N
311	14	2	2	\N
312	11	1	2	\N
335	11	383	2	\N
336	12	1	1	\N
337	12	1	2	\N
338	12	1	3	\N
339	12	1	4	\N
340	12	2	1	\N
341	12	2	2	\N
342	12	2	3	\N
343	12	2	4	\N
344	12	3	1	\N
345	12	3	2	\N
346	12	3	3	\N
347	12	3	4	\N
348	12	4	1	\N
349	12	4	2	\N
350	12	4	3	\N
351	12	4	4	\N
352	12	5	1	\N
353	12	5	2	\N
354	12	5	3	\N
355	12	5	4	\N
356	12	6	1	\N
357	12	6	2	\N
358	12	6	3	\N
359	12	6	4	\N
360	12	58	1	\N
361	12	58	2	\N
362	12	58	3	\N
363	12	58	4	\N
364	12	7	1	\N
365	12	7	2	\N
366	12	7	3	\N
367	12	7	4	\N
368	12	9	1	\N
369	12	9	2	\N
370	12	9	3	\N
371	12	9	4	\N
372	12	10	1	\N
373	12	10	2	\N
374	12	10	3	\N
375	12	10	4	\N
376	12	11	1	\N
377	12	11	2	\N
378	12	11	3	\N
379	12	11	4	\N
380	12	96	1	\N
381	12	96	2	\N
382	12	96	3	\N
383	12	96	4	\N
429	2	2	1	\N
430	2	2	2	\N
431	2	2	3	\N
432	2	2	4	\N
433	2	2	5	\N
434	2	3	1	\N
435	2	3	2	\N
436	2	3	3	\N
437	2	3	4	\N
438	2	3	5	\N
439	2	4	1	\N
440	2	4	2	\N
441	2	4	3	\N
442	2	4	4	\N
443	2	4	5	\N
446	2	5	1	\N
447	2	5	2	\N
448	2	5	3	\N
449	2	5	4	\N
450	2	5	5	\N
451	2	6	1	\N
452	2	6	2	\N
453	2	6	3	\N
454	2	6	4	\N
455	2	6	5	\N
458	2	7	1	\N
459	2	7	2	\N
460	2	7	3	\N
461	2	7	4	\N
462	2	7	5	\N
463	2	9	1	\N
464	2	9	2	\N
465	2	9	3	\N
466	2	9	4	\N
467	2	9	5	\N
468	2	10	1	\N
469	2	10	2	\N
470	2	10	3	\N
471	2	10	4	\N
472	2	10	5	\N
473	2	11	1	\N
474	2	11	2	\N
475	2	11	3	\N
476	2	11	4	\N
477	2	11	5	\N
478	2	96	1	\N
479	2	96	2	\N
480	2	96	3	\N
481	2	96	4	\N
482	2	96	5	\N
483	11	2	2	\N
484	11	2	5	\N
485	11	3	2	\N
486	11	3	5	\N
487	11	4	2	\N
488	11	4	5	\N
489	11	5	2	\N
490	11	5	5	\N
491	11	6	2	\N
492	11	6	5	\N
493	11	58	2	\N
494	11	58	5	\N
495	11	189	2	\N
496	11	189	5	\N
497	11	7	2	\N
498	11	7	5	\N
499	11	9	2	\N
500	11	9	5	\N
501	11	10	2	\N
502	11	10	5	\N
503	11	96	2	\N
504	11	96	5	\N
505	2	344	1	\N
506	2	344	2	\N
507	2	344	3	\N
508	2	344	4	\N
509	2	344	5	\N
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
9	9	1
15	16	1
19	19	1
101	102	4
102	103	4
103	104	4
104	105	4
105	106	4
106	107	4
107	108	4
108	109	4
109	110	4
110	111	4
111	112	1
112	113	1
113	114	1
114	115	1
115	116	1
116	117	2
117	118	2
118	119	2
119	120	2
120	121	2
121	122	2
122	122	11
123	123	2
124	123	11
125	124	2
126	124	11
148	146	1
149	147	1
150	148	1
151	149	1
152	150	1
153	151	4
154	152	1
155	153	4
156	154	4
157	155	1
158	156	4
159	157	1
160	158	4
161	159	4
162	160	1
163	161	1
164	162	1
165	163	1
166	164	1
167	165	1
168	166	1
169	167	2
170	168	2
171	169	1
172	170	9
173	171	2
174	172	2
175	173	2
176	174	2
177	175	9
178	176	1
179	177	1
180	178	1
181	179	1
182	180	1
183	181	6
184	182	2
185	183	2
186	184	2
187	185	9
188	186	4
189	187	4
190	188	4
191	189	4
192	190	4
193	191	4
194	192	1
195	193	4
196	194	4
197	195	1
198	196	1
199	197	1
200	198	1
201	199	1
202	200	1
203	201	3
204	202	2
205	203	2
206	204	2
207	205	9
208	206	4
209	207	4
210	208	4
211	209	4
212	210	4
213	211	4
214	212	4
215	213	4
216	214	4
217	215	4
218	216	2
219	217	2
220	218	2
221	219	2
222	220	1
223	221	3
224	222	3
225	223	3
226	224	3
227	225	3
228	226	1
229	227	1
230	228	1
231	229	1
232	230	1
233	231	3
234	232	3
235	233	3
236	234	3
237	235	3
\.


--
-- Data for Name: resourceclaimactions; Type: TABLE DATA; Schema: dbo; Owner: postgres
--

COPY dbo.resourceclaimactions (resourceclaimactionid, resourceclaimid, actionid, validationrulesetname) FROM stdin;
9	8	3	\N
16	8	2	\N
19	1	2	\N
21	8	1	\N
102	83	1	\N
103	83	2	\N
104	83	3	\N
105	83	4	\N
106	83	5	\N
107	117	1	\N
108	117	2	\N
109	117	3	\N
110	117	4	\N
111	117	5	\N
112	327	1	\N
113	327	2	\N
114	327	3	\N
115	327	4	\N
116	327	5	\N
117	336	1	\N
118	336	2	\N
119	336	3	\N
120	336	4	\N
121	336	5	\N
122	66	2	\N
123	202	2	\N
124	337	2	\N
146	380	1	\N
147	380	2	\N
148	380	3	\N
149	380	4	\N
150	380	5	\N
151	2	1	\N
152	2	2	\N
153	2	3	\N
154	2	4	\N
155	2	5	\N
156	3	1	\N
157	3	2	\N
158	3	3	\N
159	3	4	\N
160	3	5	\N
161	4	1	\N
162	4	2	\N
163	4	3	\N
164	4	4	\N
165	4	5	\N
166	5	1	\N
167	5	2	\N
168	5	3	\N
169	5	4	\N
170	5	5	\N
171	6	1	\N
172	6	2	\N
173	6	3	\N
174	6	4	\N
175	6	5	\N
176	189	1	\N
177	189	2	\N
178	189	3	\N
179	189	4	\N
180	189	5	\N
181	288	1	\N
182	288	2	\N
183	288	3	\N
184	288	4	\N
185	288	5	\N
186	7	1	\N
187	7	2	\N
188	7	3	\N
189	7	4	\N
190	7	5	\N
191	9	1	\N
192	9	2	\N
193	9	3	\N
194	9	4	\N
195	9	5	\N
196	75	1	\N
197	75	2	\N
198	75	3	\N
199	75	4	\N
200	75	5	\N
201	10	1	\N
202	10	2	\N
203	10	3	\N
204	10	4	\N
205	10	5	\N
206	11	1	\N
207	11	2	\N
208	11	3	\N
209	11	4	\N
210	11	5	\N
211	96	1	\N
212	96	2	\N
213	96	3	\N
214	96	4	\N
215	96	5	\N
216	182	1	\N
217	182	2	\N
218	182	3	\N
219	182	4	\N
220	182	5	\N
221	345	1	\N
222	345	2	\N
223	345	3	\N
224	345	4	\N
225	345	5	\N
226	355	1	\N
227	355	2	\N
228	355	3	\N
229	355	4	\N
230	355	5	\N
231	360	1	\N
232	360	2	\N
233	360	3	\N
234	360	4	\N
235	360	5	\N
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
61	contactTypeDescriptor	http://ed-fi.org/ods/identity/claims/contactTypeDescriptor	2
62	contentClassDescriptor	http://ed-fi.org/ods/identity/claims/contentClassDescriptor	2
63	continuationOfServicesReasonDescriptor	http://ed-fi.org/ods/identity/claims/continuationOfServicesReasonDescriptor	2
64	costRateDescriptor	http://ed-fi.org/ods/identity/claims/costRateDescriptor	2
65	countryDescriptor	http://ed-fi.org/ods/identity/claims/countryDescriptor	2
8	identity	http://ed-fi.org/ods/identity/claims/services/identity	\N
5	people	http://ed-fi.org/ods/identity/claims/domains/people	\N
66	course	http://ed-fi.org/ods/identity/claims/course	6
67	courseAttemptResultDescriptor	http://ed-fi.org/ods/identity/claims/courseAttemptResultDescriptor	2
68	courseDefinedByDescriptor	http://ed-fi.org/ods/identity/claims/courseDefinedByDescriptor	2
69	courseGPAApplicabilityDescriptor	http://ed-fi.org/ods/identity/claims/courseGPAApplicabilityDescriptor	2
70	courseIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/courseIdentificationSystemDescriptor	2
71	courseLevelCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/courseLevelCharacteristicDescriptor	2
72	courseOffering	http://ed-fi.org/ods/identity/claims/courseOffering	6
73	courseRepeatCodeDescriptor	http://ed-fi.org/ods/identity/claims/courseRepeatCodeDescriptor	2
74	courseTranscript	http://ed-fi.org/ods/identity/claims/courseTranscript	6
75	credential	http://ed-fi.org/ods/identity/claims/credential	9
76	credentialFieldDescriptor	http://ed-fi.org/ods/identity/claims/credentialFieldDescriptor	2
77	credentialTypeDescriptor	http://ed-fi.org/ods/identity/claims/credentialTypeDescriptor	2
78	creditCategoryDescriptor	http://ed-fi.org/ods/identity/claims/creditCategoryDescriptor	2
79	creditTypeDescriptor	http://ed-fi.org/ods/identity/claims/creditTypeDescriptor	2
80	cteProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/cteProgramServiceDescriptor	2
81	curriculumUsedDescriptor	http://ed-fi.org/ods/identity/claims/curriculumUsedDescriptor	2
82	deliveryMethodDescriptor	http://ed-fi.org/ods/identity/claims/deliveryMethodDescriptor	2
83	descriptorMapping	http://ed-fi.org/ods/identity/claims/descriptorMapping	6
84	diagnosisDescriptor	http://ed-fi.org/ods/identity/claims/diagnosisDescriptor	2
85	diplomaLevelDescriptor	http://ed-fi.org/ods/identity/claims/diplomaLevelDescriptor	2
86	diplomaTypeDescriptor	http://ed-fi.org/ods/identity/claims/diplomaTypeDescriptor	2
87	disabilityDescriptor	http://ed-fi.org/ods/identity/claims/disabilityDescriptor	2
88	disabilityDesignationDescriptor	http://ed-fi.org/ods/identity/claims/disabilityDesignationDescriptor	2
89	disabilityDeterminationSourceTypeDescriptor	http://ed-fi.org/ods/identity/claims/disabilityDeterminationSourceTypeDescriptor	2
90	disciplineAction	http://ed-fi.org/ods/identity/claims/disciplineAction	6
91	disciplineActionLengthDifferenceReasonDescriptor	http://ed-fi.org/ods/identity/claims/disciplineActionLengthDifferenceReasonDescriptor	2
92	disciplineDescriptor	http://ed-fi.org/ods/identity/claims/disciplineDescriptor	2
93	disciplineIncident	http://ed-fi.org/ods/identity/claims/disciplineIncident	6
94	disciplineIncidentParticipationCodeDescriptor	http://ed-fi.org/ods/identity/claims/disciplineIncidentParticipationCodeDescriptor	2
95	educationalEnvironmentDescriptor	http://ed-fi.org/ods/identity/claims/educationalEnvironmentDescriptor	2
96	educationContent	http://ed-fi.org/ods/identity/claims/educationContent	\N
97	educationOrganizationAssociationTypeDescriptor	http://ed-fi.org/ods/identity/claims/educationOrganizationAssociationTypeDescriptor	2
98	educationOrganizationCategoryDescriptor	http://ed-fi.org/ods/identity/claims/educationOrganizationCategoryDescriptor	2
99	educationOrganizationIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/educationOrganizationIdentificationSystemDescriptor	2
100	educationOrganizationInterventionPrescriptionAssociation	http://ed-fi.org/ods/identity/claims/educationOrganizationInterventionPrescriptionAssociation	6
101	educationOrganizationNetwork	http://ed-fi.org/ods/identity/claims/educationOrganizationNetwork	4
102	educationOrganizationNetworkAssociation	http://ed-fi.org/ods/identity/claims/educationOrganizationNetworkAssociation	6
103	educationOrganizationPeerAssociation	http://ed-fi.org/ods/identity/claims/educationOrganizationPeerAssociation	6
104	educationPlanDescriptor	http://ed-fi.org/ods/identity/claims/educationPlanDescriptor	2
105	educationServiceCenter	http://ed-fi.org/ods/identity/claims/educationServiceCenter	4
106	electronicMailTypeDescriptor	http://ed-fi.org/ods/identity/claims/electronicMailTypeDescriptor	2
107	employmentStatusDescriptor	http://ed-fi.org/ods/identity/claims/employmentStatusDescriptor	2
108	entryGradeLevelReasonDescriptor	http://ed-fi.org/ods/identity/claims/entryGradeLevelReasonDescriptor	2
109	entryTypeDescriptor	http://ed-fi.org/ods/identity/claims/entryTypeDescriptor	2
110	eventCircumstanceDescriptor	http://ed-fi.org/ods/identity/claims/eventCircumstanceDescriptor	2
111	exitWithdrawTypeDescriptor	http://ed-fi.org/ods/identity/claims/exitWithdrawTypeDescriptor	2
112	feederSchoolAssociation	http://ed-fi.org/ods/identity/claims/feederSchoolAssociation	6
113	financialCollectionDescriptor	http://ed-fi.org/ods/identity/claims/financialCollectionDescriptor	2
116	grade	http://ed-fi.org/ods/identity/claims/grade	6
117	gradebookEntry	http://ed-fi.org/ods/identity/claims/gradebookEntry	6
118	gradebookEntryTypeDescriptor	http://ed-fi.org/ods/identity/claims/gradebookEntryTypeDescriptor	2
119	gradeLevelDescriptor	http://ed-fi.org/ods/identity/claims/gradeLevelDescriptor	2
120	gradePointAverageTypeDescriptor	http://ed-fi.org/ods/identity/claims/gradePointAverageTypeDescriptor	2
121	gradeTypeDescriptor	http://ed-fi.org/ods/identity/claims/gradeTypeDescriptor	2
122	gradingPeriod	http://ed-fi.org/ods/identity/claims/gradingPeriod	6
123	gradingPeriodDescriptor	http://ed-fi.org/ods/identity/claims/gradingPeriodDescriptor	2
124	graduationPlan	http://ed-fi.org/ods/identity/claims/graduationPlan	6
125	graduationPlanTypeDescriptor	http://ed-fi.org/ods/identity/claims/graduationPlanTypeDescriptor	2
126	gunFreeSchoolsActReportingStatusDescriptor	http://ed-fi.org/ods/identity/claims/gunFreeSchoolsActReportingStatusDescriptor	2
127	homelessPrimaryNighttimeResidenceDescriptor	http://ed-fi.org/ods/identity/claims/homelessPrimaryNighttimeResidenceDescriptor	2
128	homelessProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/homelessProgramServiceDescriptor	2
129	identificationDocumentUseDescriptor	http://ed-fi.org/ods/identity/claims/identificationDocumentUseDescriptor	2
130	incidentLocationDescriptor	http://ed-fi.org/ods/identity/claims/incidentLocationDescriptor	2
131	indicatorDescriptor	http://ed-fi.org/ods/identity/claims/indicatorDescriptor	2
132	indicatorGroupDescriptor	http://ed-fi.org/ods/identity/claims/indicatorGroupDescriptor	2
133	indicatorLevelDescriptor	http://ed-fi.org/ods/identity/claims/indicatorLevelDescriptor	2
134	institutionTelephoneNumberTypeDescriptor	http://ed-fi.org/ods/identity/claims/institutionTelephoneNumberTypeDescriptor	2
135	interactivityStyleDescriptor	http://ed-fi.org/ods/identity/claims/interactivityStyleDescriptor	2
136	internetAccessDescriptor	http://ed-fi.org/ods/identity/claims/internetAccessDescriptor	2
137	internetAccessTypeInResidenceDescriptor	http://ed-fi.org/ods/identity/claims/internetAccessTypeInResidenceDescriptor	2
138	internetPerformanceInResidenceDescriptor	http://ed-fi.org/ods/identity/claims/internetPerformanceInResidenceDescriptor	2
139	intervention	http://ed-fi.org/ods/identity/claims/intervention	6
140	interventionClassDescriptor	http://ed-fi.org/ods/identity/claims/interventionClassDescriptor	2
141	interventionEffectivenessRatingDescriptor	http://ed-fi.org/ods/identity/claims/interventionEffectivenessRatingDescriptor	2
142	interventionPrescription	http://ed-fi.org/ods/identity/claims/interventionPrescription	6
143	interventionStudy	http://ed-fi.org/ods/identity/claims/interventionStudy	6
144	languageDescriptor	http://ed-fi.org/ods/identity/claims/languageDescriptor	2
145	languageInstructionProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/languageInstructionProgramServiceDescriptor	2
146	languageUseDescriptor	http://ed-fi.org/ods/identity/claims/languageUseDescriptor	2
147	learningObjective	http://ed-fi.org/ods/identity/claims/learningObjective	9
148	learningStandard	http://ed-fi.org/ods/identity/claims/learningStandard	9
149	learningStandardCategoryDescriptor	http://ed-fi.org/ods/identity/claims/learningStandardCategoryDescriptor	2
150	learningStandardEquivalenceAssociation	http://ed-fi.org/ods/identity/claims/learningStandardEquivalenceAssociation	9
151	learningStandardEquivalenceStrengthDescriptor	http://ed-fi.org/ods/identity/claims/learningStandardEquivalenceStrengthDescriptor	2
152	learningStandardScopeDescriptor	http://ed-fi.org/ods/identity/claims/learningStandardScopeDescriptor	2
153	levelOfEducationDescriptor	http://ed-fi.org/ods/identity/claims/levelOfEducationDescriptor	2
154	licenseStatusDescriptor	http://ed-fi.org/ods/identity/claims/licenseStatusDescriptor	2
155	licenseTypeDescriptor	http://ed-fi.org/ods/identity/claims/licenseTypeDescriptor	2
156	limitedEnglishProficiencyDescriptor	http://ed-fi.org/ods/identity/claims/limitedEnglishProficiencyDescriptor	2
157	localAccount	http://ed-fi.org/ods/identity/claims/localAccount	6
158	localActual	http://ed-fi.org/ods/identity/claims/localActual	6
159	localBudget	http://ed-fi.org/ods/identity/claims/localBudget	6
160	localContractedStaff	http://ed-fi.org/ods/identity/claims/localContractedStaff	6
161	localeDescriptor	http://ed-fi.org/ods/identity/claims/localeDescriptor	2
162	localEducationAgency	http://ed-fi.org/ods/identity/claims/localEducationAgency	4
163	localEducationAgencyCategoryDescriptor	http://ed-fi.org/ods/identity/claims/localEducationAgencyCategoryDescriptor	2
164	localEncumbrance	http://ed-fi.org/ods/identity/claims/localEncumbrance	6
165	localPayroll	http://ed-fi.org/ods/identity/claims/localPayroll	6
166	location	http://ed-fi.org/ods/identity/claims/location	6
167	magnetSpecialProgramEmphasisSchoolDescriptor	http://ed-fi.org/ods/identity/claims/magnetSpecialProgramEmphasisSchoolDescriptor	2
168	mediumOfInstructionDescriptor	http://ed-fi.org/ods/identity/claims/mediumOfInstructionDescriptor	2
169	methodCreditEarnedDescriptor	http://ed-fi.org/ods/identity/claims/methodCreditEarnedDescriptor	2
170	migrantEducationProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/migrantEducationProgramServiceDescriptor	2
171	modelEntityDescriptor	http://ed-fi.org/ods/identity/claims/modelEntityDescriptor	2
172	monitoredDescriptor	http://ed-fi.org/ods/identity/claims/monitoredDescriptor	2
173	neglectedOrDelinquentProgramDescriptor	http://ed-fi.org/ods/identity/claims/neglectedOrDelinquentProgramDescriptor	2
174	neglectedOrDelinquentProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/neglectedOrDelinquentProgramServiceDescriptor	2
175	networkPurposeDescriptor	http://ed-fi.org/ods/identity/claims/networkPurposeDescriptor	2
177	objectiveAssessment	http://ed-fi.org/ods/identity/claims/objectiveAssessment	7
178	oldEthnicityDescriptor	http://ed-fi.org/ods/identity/claims/oldEthnicityDescriptor	2
179	openStaffPosition	http://ed-fi.org/ods/identity/claims/openStaffPosition	6
180	operationalStatusDescriptor	http://ed-fi.org/ods/identity/claims/operationalStatusDescriptor	2
182	organizationDepartment	http://ed-fi.org/ods/identity/claims/organizationDepartment	4
183	otherNameTypeDescriptor	http://ed-fi.org/ods/identity/claims/otherNameTypeDescriptor	2
184	parent	http://ed-fi.org/ods/identity/claims/parent	5
185	participationDescriptor	http://ed-fi.org/ods/identity/claims/participationDescriptor	2
186	participationStatusDescriptor	http://ed-fi.org/ods/identity/claims/participationStatusDescriptor	2
187	performanceBaseConversionDescriptor	http://ed-fi.org/ods/identity/claims/performanceBaseConversionDescriptor	2
188	performanceLevelDescriptor	http://ed-fi.org/ods/identity/claims/performanceLevelDescriptor	3
189	person	http://ed-fi.org/ods/identity/claims/person	6
190	personalInformationVerificationDescriptor	http://ed-fi.org/ods/identity/claims/personalInformationVerificationDescriptor	2
191	platformTypeDescriptor	http://ed-fi.org/ods/identity/claims/platformTypeDescriptor	2
192	populationServedDescriptor	http://ed-fi.org/ods/identity/claims/populationServedDescriptor	2
193	postingResultDescriptor	http://ed-fi.org/ods/identity/claims/postingResultDescriptor	2
194	postSecondaryEvent	http://ed-fi.org/ods/identity/claims/postSecondaryEvent	6
195	postSecondaryEventCategoryDescriptor	http://ed-fi.org/ods/identity/claims/postSecondaryEventCategoryDescriptor	2
196	postSecondaryInstitution	http://ed-fi.org/ods/identity/claims/postSecondaryInstitution	4
197	postSecondaryInstitutionLevelDescriptor	http://ed-fi.org/ods/identity/claims/postSecondaryInstitutionLevelDescriptor	2
198	primaryLearningDeviceAccessDescriptor	http://ed-fi.org/ods/identity/claims/primaryLearningDeviceAccessDescriptor	2
199	primaryLearningDeviceAwayFromSchoolDescriptor	http://ed-fi.org/ods/identity/claims/primaryLearningDeviceAwayFromSchoolDescriptor	2
200	primaryLearningDeviceProviderDescriptor	http://ed-fi.org/ods/identity/claims/primaryLearningDeviceProviderDescriptor	2
201	proficiencyDescriptor	http://ed-fi.org/ods/identity/claims/proficiencyDescriptor	2
202	program	http://ed-fi.org/ods/identity/claims/program	6
203	programAssignmentDescriptor	http://ed-fi.org/ods/identity/claims/programAssignmentDescriptor	2
204	programCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/programCharacteristicDescriptor	2
206	programSponsorDescriptor	http://ed-fi.org/ods/identity/claims/programSponsorDescriptor	2
207	programTypeDescriptor	http://ed-fi.org/ods/identity/claims/programTypeDescriptor	2
208	progressDescriptor	http://ed-fi.org/ods/identity/claims/progressDescriptor	2
209	progressLevelDescriptor	http://ed-fi.org/ods/identity/claims/progressLevelDescriptor	2
211	providerCategoryDescriptor	http://ed-fi.org/ods/identity/claims/providerCategoryDescriptor	2
212	providerProfitabilityDescriptor	http://ed-fi.org/ods/identity/claims/providerProfitabilityDescriptor	2
213	providerStatusDescriptor	http://ed-fi.org/ods/identity/claims/providerStatusDescriptor	2
214	publicationStatusDescriptor	http://ed-fi.org/ods/identity/claims/publicationStatusDescriptor	2
215	questionFormDescriptor	http://ed-fi.org/ods/identity/claims/questionFormDescriptor	2
216	raceDescriptor	http://ed-fi.org/ods/identity/claims/raceDescriptor	2
217	reasonExitedDescriptor	http://ed-fi.org/ods/identity/claims/reasonExitedDescriptor	2
219	recognitionTypeDescriptor	http://ed-fi.org/ods/identity/claims/recognitionTypeDescriptor	2
220	relationDescriptor	http://ed-fi.org/ods/identity/claims/relationDescriptor	2
221	repeatIdentifierDescriptor	http://ed-fi.org/ods/identity/claims/repeatIdentifierDescriptor	2
222	reportCard	http://ed-fi.org/ods/identity/claims/reportCard	6
223	reporterDescriptionDescriptor	http://ed-fi.org/ods/identity/claims/reporterDescriptionDescriptor	2
224	reportingTagDescriptor	http://ed-fi.org/ods/identity/claims/reportingTagDescriptor	2
225	residencyStatusDescriptor	http://ed-fi.org/ods/identity/claims/residencyStatusDescriptor	2
226	responseIndicatorDescriptor	http://ed-fi.org/ods/identity/claims/responseIndicatorDescriptor	2
227	responsibilityDescriptor	http://ed-fi.org/ods/identity/claims/responsibilityDescriptor	2
228	restraintEvent	http://ed-fi.org/ods/identity/claims/restraintEvent	6
229	restraintEventReasonDescriptor	http://ed-fi.org/ods/identity/claims/restraintEventReasonDescriptor	2
230	resultDatatypeTypeDescriptor	http://ed-fi.org/ods/identity/claims/resultDatatypeTypeDescriptor	2
231	retestIndicatorDescriptor	http://ed-fi.org/ods/identity/claims/retestIndicatorDescriptor	2
232	school	http://ed-fi.org/ods/identity/claims/school	4
233	schoolCategoryDescriptor	http://ed-fi.org/ods/identity/claims/schoolCategoryDescriptor	2
234	schoolChoiceImplementStatusDescriptor	http://ed-fi.org/ods/identity/claims/schoolChoiceImplementStatusDescriptor	2
235	schoolFoodServiceProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/schoolFoodServiceProgramServiceDescriptor	2
236	schoolTypeDescriptor	http://ed-fi.org/ods/identity/claims/schoolTypeDescriptor	2
237	schoolYearType	http://ed-fi.org/ods/identity/claims/schoolYearType	1
238	section	http://ed-fi.org/ods/identity/claims/section	6
239	sectionAttendanceTakenEvent	http://ed-fi.org/ods/identity/claims/sectionAttendanceTakenEvent	6
240	sectionCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/sectionCharacteristicDescriptor	2
241	separationDescriptor	http://ed-fi.org/ods/identity/claims/separationDescriptor	2
242	separationReasonDescriptor	http://ed-fi.org/ods/identity/claims/separationReasonDescriptor	2
243	serviceDescriptor	http://ed-fi.org/ods/identity/claims/serviceDescriptor	2
244	session	http://ed-fi.org/ods/identity/claims/session	6
245	sexDescriptor	http://ed-fi.org/ods/identity/claims/sexDescriptor	2
247	sourceSystemDescriptor	http://ed-fi.org/ods/identity/claims/sourceSystemDescriptor	2
248	specialEducationProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/specialEducationProgramServiceDescriptor	2
249	specialEducationSettingDescriptor	http://ed-fi.org/ods/identity/claims/specialEducationSettingDescriptor	2
250	staff	http://ed-fi.org/ods/identity/claims/staff	5
251	staffAbsenceEvent	http://ed-fi.org/ods/identity/claims/staffAbsenceEvent	6
252	staffClassificationDescriptor	http://ed-fi.org/ods/identity/claims/staffClassificationDescriptor	2
253	staffCohortAssociation	http://ed-fi.org/ods/identity/claims/staffCohortAssociation	6
254	staffDisciplineIncidentAssociation	http://ed-fi.org/ods/identity/claims/staffDisciplineIncidentAssociation	6
255	staffEducationOrganizationAssignmentAssociation	http://ed-fi.org/ods/identity/claims/staffEducationOrganizationAssignmentAssociation	10
256	staffEducationOrganizationContactAssociation	http://ed-fi.org/ods/identity/claims/staffEducationOrganizationContactAssociation	6
257	staffEducationOrganizationEmploymentAssociation	http://ed-fi.org/ods/identity/claims/staffEducationOrganizationEmploymentAssociation	10
258	staffIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/staffIdentificationSystemDescriptor	2
259	staffLeave	http://ed-fi.org/ods/identity/claims/staffLeave	6
260	staffLeaveEventCategoryDescriptor	http://ed-fi.org/ods/identity/claims/staffLeaveEventCategoryDescriptor	2
261	staffProgramAssociation	http://ed-fi.org/ods/identity/claims/staffProgramAssociation	6
262	staffSchoolAssociation	http://ed-fi.org/ods/identity/claims/staffSchoolAssociation	6
263	staffSectionAssociation	http://ed-fi.org/ods/identity/claims/staffSectionAssociation	6
264	stateAbbreviationDescriptor	http://ed-fi.org/ods/identity/claims/stateAbbreviationDescriptor	2
265	stateEducationAgency	http://ed-fi.org/ods/identity/claims/stateEducationAgency	4
266	student	http://ed-fi.org/ods/identity/claims/student	5
267	studentAcademicRecord	http://ed-fi.org/ods/identity/claims/studentAcademicRecord	6
268	studentAssessment	http://ed-fi.org/ods/identity/claims/studentAssessment	7
269	studentAssessmentEducationOrganizationAssociation	http://ed-fi.org/ods/identity/claims/studentAssessmentEducationOrganizationAssociation	6
270	studentCharacteristicDescriptor	http://ed-fi.org/ods/identity/claims/studentCharacteristicDescriptor	2
271	studentCohortAssociation	http://ed-fi.org/ods/identity/claims/studentCohortAssociation	6
272	studentCompetencyObjective	http://ed-fi.org/ods/identity/claims/studentCompetencyObjective	6
273	studentCTEProgramAssociation	http://ed-fi.org/ods/identity/claims/studentCTEProgramAssociation	6
274	studentDisciplineIncidentAssociation	http://ed-fi.org/ods/identity/claims/studentDisciplineIncidentAssociation	6
275	studentDisciplineIncidentBehaviorAssociation	http://ed-fi.org/ods/identity/claims/studentDisciplineIncidentBehaviorAssociation	6
276	studentDisciplineIncidentNonOffenderAssociation	http://ed-fi.org/ods/identity/claims/studentDisciplineIncidentNonOffenderAssociation	6
277	studentEducationOrganizationAssociation	http://ed-fi.org/ods/identity/claims/studentEducationOrganizationAssociation	6
278	studentEducationOrganizationResponsibilityAssociation	http://ed-fi.org/ods/identity/claims/studentEducationOrganizationResponsibilityAssociation	6
279	studentGradebookEntry	http://ed-fi.org/ods/identity/claims/studentGradebookEntry	6
280	studentHomelessProgramAssociation	http://ed-fi.org/ods/identity/claims/studentHomelessProgramAssociation	6
281	studentIdentificationSystemDescriptor	http://ed-fi.org/ods/identity/claims/studentIdentificationSystemDescriptor	2
282	studentInterventionAssociation	http://ed-fi.org/ods/identity/claims/studentInterventionAssociation	6
283	studentInterventionAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentInterventionAttendanceEvent	6
284	studentLanguageInstructionProgramAssociation	http://ed-fi.org/ods/identity/claims/studentLanguageInstructionProgramAssociation	6
285	studentLearningObjective	http://ed-fi.org/ods/identity/claims/studentLearningObjective	6
286	studentMigrantEducationProgramAssociation	http://ed-fi.org/ods/identity/claims/studentMigrantEducationProgramAssociation	6
287	studentNeglectedOrDelinquentProgramAssociation	http://ed-fi.org/ods/identity/claims/studentNeglectedOrDelinquentProgramAssociation	6
288	studentParentAssociation	http://ed-fi.org/ods/identity/claims/studentParentAssociation	6
289	studentParticipationCodeDescriptor	http://ed-fi.org/ods/identity/claims/studentParticipationCodeDescriptor	2
290	studentProgramAssociation	http://ed-fi.org/ods/identity/claims/studentProgramAssociation	6
291	studentProgramAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentProgramAttendanceEvent	6
292	studentSchoolAssociation	http://ed-fi.org/ods/identity/claims/studentSchoolAssociation	10
293	studentSchoolAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentSchoolAttendanceEvent	6
294	studentSchoolFoodServiceProgramAssociation	http://ed-fi.org/ods/identity/claims/studentSchoolFoodServiceProgramAssociation	6
295	studentSectionAssociation	http://ed-fi.org/ods/identity/claims/studentSectionAssociation	6
296	studentSectionAttendanceEvent	http://ed-fi.org/ods/identity/claims/studentSectionAttendanceEvent	6
297	studentSpecialEducationProgramAssociation	http://ed-fi.org/ods/identity/claims/studentSpecialEducationProgramAssociation	6
298	studentTitleIPartAProgramAssociation	http://ed-fi.org/ods/identity/claims/studentTitleIPartAProgramAssociation	6
299	submissionStatusDescriptor	http://ed-fi.org/ods/identity/claims/submissionStatusDescriptor	2
300	survey	http://ed-fi.org/ods/identity/claims/survey	11
301	surveyCategoryDescriptor	http://ed-fi.org/ods/identity/claims/surveyCategoryDescriptor	2
302	surveyCourseAssociation	http://ed-fi.org/ods/identity/claims/surveyCourseAssociation	6
303	surveyLevelDescriptor	http://ed-fi.org/ods/identity/claims/surveyLevelDescriptor	2
304	surveyProgramAssociation	http://ed-fi.org/ods/identity/claims/surveyProgramAssociation	6
305	surveyQuestion	http://ed-fi.org/ods/identity/claims/surveyQuestion	11
306	surveyQuestionResponse	http://ed-fi.org/ods/identity/claims/surveyQuestionResponse	11
307	surveyResponse	http://ed-fi.org/ods/identity/claims/surveyResponse	11
308	surveyResponseEducationOrganizationTargetAssociation	http://ed-fi.org/ods/identity/claims/surveyResponseEducationOrganizationTargetAssociation	6
309	surveyResponseStaffTargetAssociation	http://ed-fi.org/ods/identity/claims/surveyResponseStaffTargetAssociation	6
310	surveySection	http://ed-fi.org/ods/identity/claims/surveySection	11
311	surveySectionAssociation	http://ed-fi.org/ods/identity/claims/surveySectionAssociation	6
312	surveySectionResponse	http://ed-fi.org/ods/identity/claims/surveySectionResponse	11
375	genderDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/genderDescriptor	361
313	surveySectionResponseEducationOrganizationTargetAssociation	http://ed-fi.org/ods/identity/claims/surveySectionResponseEducationOrganizationTargetAssociation	6
314	surveySectionResponseStaffTargetAssociation	http://ed-fi.org/ods/identity/claims/surveySectionResponseStaffTargetAssociation	6
315	teachingCredentialBasisDescriptor	http://ed-fi.org/ods/identity/claims/teachingCredentialBasisDescriptor	2
316	teachingCredentialDescriptor	http://ed-fi.org/ods/identity/claims/teachingCredentialDescriptor	2
317	technicalSkillsAssessmentDescriptor	http://ed-fi.org/ods/identity/claims/technicalSkillsAssessmentDescriptor	2
318	telephoneNumberTypeDescriptor	http://ed-fi.org/ods/identity/claims/telephoneNumberTypeDescriptor	2
319	termDescriptor	http://ed-fi.org/ods/identity/claims/termDescriptor	2
320	titleIPartAParticipantDescriptor	http://ed-fi.org/ods/identity/claims/titleIPartAParticipantDescriptor	2
321	titleIPartAProgramServiceDescriptor	http://ed-fi.org/ods/identity/claims/titleIPartAProgramServiceDescriptor	2
322	titleIPartASchoolDesignationDescriptor	http://ed-fi.org/ods/identity/claims/titleIPartASchoolDesignationDescriptor	2
323	tribalAffiliationDescriptor	http://ed-fi.org/ods/identity/claims/tribalAffiliationDescriptor	2
324	visaDescriptor	http://ed-fi.org/ods/identity/claims/visaDescriptor	2
325	weaponDescriptor	http://ed-fi.org/ods/identity/claims/weaponDescriptor	2
218	reasonNotTestedDescriptor	http://ed-fi.org/ods/identity/claims/reasonNotTestedDescriptor	3
326	finance	http://ed-fi.org/ods/identity/claims/domains/finance	\N
327	dimensions	http://ed-fi.org/ods/identity/claims/domains/finance/dimensions	326
328	fundDimension	http://ed-fi.org/ods/identity/claims/ed-fi/fundDimension	327
329	programDimension	http://ed-fi.org/ods/identity/claims/ed-fi/programDimension	327
330	functionDimension	http://ed-fi.org/ods/identity/claims/ed-fi/functionDimension	327
331	objectDimension	http://ed-fi.org/ods/identity/claims/ed-fi/objectDimension	327
332	projectDimension	http://ed-fi.org/ods/identity/claims/ed-fi/projectDimension	327
333	operationalUnitDimension	http://ed-fi.org/ods/identity/claims/ed-fi/operationalUnitDimension	327
334	sourceDimension	http://ed-fi.org/ods/identity/claims/ed-fi/sourceDimension	327
335	balanceSheetDimension	http://ed-fi.org/ods/identity/claims/ed-fi/balanceSheetDimension	327
336	locals	http://ed-fi.org/ods/identity/claims/domains/finance/locals	326
337	chartOfAccount	http://ed-fi.org/ods/identity/claims/ed-fi/chartOfAccount	336
338	localAccount	http://ed-fi.org/ods/identity/claims/ed-fi/localAccount	336
339	localBudget	http://ed-fi.org/ods/identity/claims/ed-fi/localBudget	336
340	localActual	http://ed-fi.org/ods/identity/claims/ed-fi/localActual	336
341	localEncumbrance	http://ed-fi.org/ods/identity/claims/ed-fi/localEncumbrance	336
342	localContractedStaff	http://ed-fi.org/ods/identity/claims/ed-fi/localContractedStaff	336
343	localPayroll	http://ed-fi.org/ods/identity/claims/ed-fi/localPayroll	336
344	tpdm	http://ed-fi.org/ods/identity/claims/domains/tpdm	\N
345	performanceEvaluation	http://ed-fi.org/ods/identity/claims/domains/tpdm/performanceEvaluation	344
346	performanceEvaluation	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluation	345
347	evaluation	http://ed-fi.org/ods/identity/claims/tpdm/evaluation	345
348	evaluationObjective	http://ed-fi.org/ods/identity/claims/tpdm/evaluationObjective	345
349	evaluationElement	http://ed-fi.org/ods/identity/claims/tpdm/evaluationElement	345
350	rubricDimension	http://ed-fi.org/ods/identity/claims/tpdm/rubricDimension	345
351	evaluationRating	http://ed-fi.org/ods/identity/claims/tpdm/evaluationRating	345
352	evaluationObjectiveRating	http://ed-fi.org/ods/identity/claims/tpdm/evaluationObjectiveRating	345
353	evaluationElementRating	http://ed-fi.org/ods/identity/claims/tpdm/evaluationElementRating	345
354	performanceEvaluationRating	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluationRating	345
355	noFurtherAuthorizationRequiredData	http://ed-fi.org/ods/identity/claims/domains/tpdm/noFurtherAuthorizationRequiredData	344
356	candidatePreparation	http://ed-fi.org/ods/identity/claims/domains/tpdm/candidatePreparation	355
357	candidateEducatorPreparationProgramAssociation	http://ed-fi.org/ods/identity/claims/tpdm/candidateEducatorPreparationProgramAssociation	356
358	students	http://ed-fi.org/ods/identity/claims/domains/tpdm/students	355
359	financialAid	http://ed-fi.org/ods/identity/claims/tpdm/financialAid	358
360	educatorPreparationProgram	http://ed-fi.org/ods/identity/claims/tpdm/educatorPreparationProgram	344
361	descriptors	http://ed-fi.org/ods/identity/claims/domains/tpdm/descriptors	2
362	accreditationStatusDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/accreditationStatusDescriptor	361
363	aidTypeDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/aidTypeDescriptor	361
364	certificationRouteDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/certificationRouteDescriptor	361
365	coteachingStyleObservedDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/coteachingStyleObservedDescriptor	361
366	credentialStatusDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/credentialStatusDescriptor	361
367	educatorRoleDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/educatorRoleDescriptor	361
368	englishLanguageExamDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/englishLanguageExamDescriptor	361
369	ePPProgramPathwayDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/ePPProgramPathwayDescriptor	361
370	evaluationElementRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationElementRatingLevelDescriptor	361
371	evaluationPeriodDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationPeriodDescriptor	361
372	evaluationRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationRatingLevelDescriptor	361
373	evaluationRatingStatusDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationRatingStatusDescriptor	361
374	evaluationTypeDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/evaluationTypeDescriptor	361
376	objectiveRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/objectiveRatingLevelDescriptor	361
377	performanceEvaluationRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluationRatingLevelDescriptor	361
378	performanceEvaluationTypeDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/performanceEvaluationTypeDescriptor	361
379	rubricRatingLevelDescriptor	http://ed-fi.org/ods/identity/claims/tpdm/rubricRatingLevelDescriptor	361
380	candidate	http://ed-fi.org/ods/identity/claims/tpdm/candidate	5
381	surveyResponsePersonTargetAssociation	http://ed-fi.org/ods/identity/claims/tpdm/surveyResponsePersonTargetAssociation	11
382	surveySectionResponsePersonTargetAssociation	http://ed-fi.org/ods/identity/claims/tpdm/surveySectionResponsePersonTargetAssociation	11
383	snapshot	http://ed-fi.org/ods/identity/claims/publishing/snapshot	\N
\.


--
-- Data for Name: DeployJournal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DeployJournal" (schemaversionsid, scriptname, applied) FROM stdin;
1	Artifacts.PgSql.Structure.Security.0010-Schemas.sql	2023-12-06 23:14:35.641525
2	Artifacts.PgSql.Structure.Security.0020-Tables.sql	2023-12-06 23:14:35.711502
3	Artifacts.PgSql.Structure.Security.0030-ForeignKeys.sql	2023-12-06 23:14:35.73517
4	Artifacts.PgSql.Structure.Security.0040-Indexes.sql	2023-12-06 23:14:35.79555
5	Artifacts.PgSql.Structure.Security.0050-AddUniqueConstraintResourceClaimsClaimName.sql	2023-12-06 23:14:35.837823
6	Artifacts.PgSql.Structure.Security.0050-Tables-MultipleAuthStrats.sql	2023-12-06 23:14:35.902357
7	Artifacts.PgSql.Structure.Security.0060-AlterClaimsetTable.sql	2023-12-06 23:14:35.905976
8	Artifacts.PgSql.Structure.Security.0070-RemoveUnusedApplicationTableAndRemoveDisplayNameResourceName.sql	2023-12-06 23:14:35.93312
9	Artifacts.PgSql.Structure.Security.0080-Alter-Claimsets-Add-Unique-Constraint-ClaimsetName.sql	2023-12-06 23:14:35.941599
10	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.0001-ResourceClaimMetadata.sql	2023-12-06 23:14:35.974035
11	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.0002-ResourceClaimMetadata_generated.sql	2023-12-06 23:14:36.057392
12	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.1090-ManagedReasonNotTestedDescriptor.sql	2023-12-06 23:14:36.060323
13	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2000-AdminApp-ClaimSets.sql	2023-12-06 23:14:36.068254
14	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2000-AdminApp-ClaimSets_UpgradePath.sql	2023-12-06 23:14:36.076774
15	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2020-MigrateDataForMultipleAuthStrategies.sql	2023-12-06 23:14:36.081038
16	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2030-Clean-up-ReadChanges-from-AB-Connect-Claim-Set.sql	2023-12-06 23:14:36.093468
17	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2030-DropSingleAuthStrategyTables.sql	2023-12-06 23:14:36.102475
18	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2050-UpdateClaimSetReadOnlyAndInternalUseOnlyColum.sql	2023-12-06 23:14:36.105731
19	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2060-OwnershipBased-claims-for-People.sql	2023-12-06 23:14:36.113432
20	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2070-DataStandard4.0a-ResourceClaimMetadata.sql	2023-12-06 23:14:36.127558
21	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2070-Namespace-auth-for-GradebookEntry.sql	2023-12-06 23:14:36.134007
22	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2080-Finance-domain-security-metadata.sql	2023-12-06 23:14:36.167141
23	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2090-RemoveOwnershipBasedTestClaimSet.sql	2023-12-06 23:14:36.171371
24	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2100-UpdateClaimSetInternalUseOnlyColum.sql	2023-12-06 23:14:36.173827
25	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2120-Add-Auth-Strategies-Inverted-EdOrg-Hierarchy.sql	2023-12-06 23:14:36.176859
26	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2130-Reference-data-also-use-inverted-EdOrgHierarchy-for-Read.sql	2023-12-06 23:14:36.185147
27	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2140-Update-identities-claim-name.sql	2023-12-06 23:14:36.187686
28	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2145-Add-RelationshipsWithStudentsOnlyThroughResponsibilityIncludingDeletes-strategy.sql	2023-12-06 23:14:36.190103
29	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.2150-StudentParentAssociation-authorized-on-StudentOnly.sql	2023-12-06 23:14:36.196856
30	Extensions.TPDM.1.1.0.Standard.4.0.0.Artifacts.PgSql.Data.Security.1010-TPDM-ResourceClaims.sql	2023-12-06 23:14:36.231461
31	Extensions.TPDM.1.1.0.Standard.4.0.0.Artifacts.PgSql.Data.Security.1011-TPDM-Candidate.sql	2023-12-06 23:14:36.235146
32	Extensions.TPDM.1.1.0.Standard.4.0.0.Artifacts.PgSql.Data.Security.1020-TPDM-EducationPreparationProgram-ClaimSet.sql	2023-12-06 23:14:36.240132
33	Extensions.TPDM.1.1.0.Standard.4.0.0.Artifacts.PgSql.Data.Security.1030-TPDM-DelPerfEvalRatingsAuthStrategy.sql	2023-12-06 23:14:36.244187
34	Extensions.TPDM.1.1.0.Standard.4.0.0.Artifacts.PgSql.Data.Security.1030-TPDM-RmvReadChangesFromEdPrepProgClaimSet.sql	2023-12-06 23:14:36.245982
35	Extensions.TPDM.1.1.0.Standard.4.0.0.Artifacts.PgSql.Data.Security.1040-TPDM-RmvParentResourceClaimFromPeopleClaim.sql	2023-12-06 23:14:36.24895
36	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.Changes.0010-API-Publisher-Reader-Security-Metadata.sql	2023-12-06 23:14:36.291568
37	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.Changes.0020-API-Publisher-Writer-Security-Metadata.sql	2023-12-06 23:14:36.325324
38	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.Changes.0030-Sandbox-Publishing-Security-Metadata.sql	2023-12-06 23:14:36.349849
39	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.Changes.0040-Add-ReadChanges-to-Sandbox-Claim-Set.sql	2023-12-06 23:14:36.420676
40	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.Changes.0050-Remove-Overrides-from-Api-Publisher-Reader-Claim-Set.sql	2023-12-06 23:14:36.439744
41	EdFi.Ods.Standard.Standard.4.0.0.Artifacts.PgSql.Data.Security.Changes.0060-Apply-ReadChanges-Default-to-OrgDept.sql	2023-12-06 23:14:36.446637
42	Extensions.TPDM.1.1.0.Standard.4.0.0.Artifacts.PgSql.Data.Security.Changes.0010-EdFi-Sandbox-ReadChanges.sql	2023-12-06 23:14:36.473208
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

SELECT pg_catalog.setval('dbo.claimsetresourceclaimactionau_claimsetresourceclaimactionau_seq', 112, true);


--
-- Name: claimsetresourceclaimactions_claimsetresourceclaimactionid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.claimsetresourceclaimactions_claimsetresourceclaimactionid_seq', 509, true);


--
-- Name: claimsets_claimsetid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.claimsets_claimsetid_seq', 14, true);


--
-- Name: resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.resourceclaimactionauthorizat_resourceclaimactionauthorizat_seq', 237, true);


--
-- Name: resourceclaimactions_resourceclaimactionid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.resourceclaimactions_resourceclaimactionid_seq', 235, true);


--
-- Name: resourceclaims_resourceclaimid_seq; Type: SEQUENCE SET; Schema: dbo; Owner: postgres
--

SELECT pg_catalog.setval('dbo.resourceclaims_resourceclaimid_seq', 383, true);


--
-- Name: DeployJournal_schemaversionsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."DeployJournal_schemaversionsid_seq"', 42, true);


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

