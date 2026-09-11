--
-- PostgreSQL database dump
--

\restrict ZlOE0FrvHWR3t7He9t4nX6JqcS80G5A1QWfPWDe90LaNybtF0mTcGDhdrb0eK4h

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: Dataset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Dataset" (
    id text NOT NULL,
    title text NOT NULL,
    description text,
    "unitId" text,
    year text,
    access text,
    format text,
    size text,
    draft boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Equipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Equipment" (
    id text NOT NULL,
    name text NOT NULL,
    "labId" text NOT NULL,
    category text,
    description text,
    status text DEFAULT 'available'::text NOT NULL,
    "workingUnits" integer DEFAULT 1 NOT NULL,
    "outOfOrder" integer DEFAULT 0 NOT NULL,
    "totalUnits" integer DEFAULT 1 NOT NULL,
    model text,
    specifications text[],
    image text
);


--
-- Name: EquipmentFeedback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."EquipmentFeedback" (
    id integer NOT NULL,
    "reservationId" integer,
    "equipmentId" text NOT NULL,
    "userName" text NOT NULL,
    "userEmail" text NOT NULL,
    rating integer NOT NULL,
    "benefitStatement" text NOT NULL,
    status text DEFAULT 'pending_review'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: EquipmentFeedback_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."EquipmentFeedback_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: EquipmentFeedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."EquipmentFeedback_id_seq" OWNED BY public."EquipmentFeedback".id;


--
-- Name: EquipmentReservation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."EquipmentReservation" (
    id integer NOT NULL,
    "equipmentId" text NOT NULL,
    "userName" text NOT NULL,
    "userEmail" text NOT NULL,
    "userType" text NOT NULL,
    purpose text NOT NULL,
    "startTime" timestamp(3) without time zone NOT NULL,
    "endTime" timestamp(3) without time zone NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    "rejectionReason" text,
    "approvedById" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: EquipmentReservation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."EquipmentReservation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: EquipmentReservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."EquipmentReservation_id_seq" OWNED BY public."EquipmentReservation".id;


--
-- Name: Event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Event" (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    "eventDate" timestamp(3) without time zone NOT NULL,
    image text,
    "eventType" text DEFAULT 'regular'::text NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    description text,
    content text,
    category text,
    "eventTime" text,
    location text,
    draft boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "galleryImages" text[] DEFAULT ARRAY[]::text[]
);


--
-- Name: Event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Event_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Event_id_seq" OWNED BY public."Event".id;


--
-- Name: Form; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Form" (
    id integer NOT NULL,
    title text NOT NULL,
    category text NOT NULL,
    description text,
    "filePath" text NOT NULL,
    "fileFormat" text,
    "fileSize" text,
    icon text DEFAULT 'fas fa-file-alt'::text NOT NULL,
    draft boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "formType" text,
    "subCategory" text
);


--
-- Name: Form_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Form_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Form_id_seq" OWNED BY public."Form".id;


--
-- Name: Lab; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Lab" (
    id text NOT NULL,
    title text NOT NULL,
    "shortName" text,
    location text,
    "locationName" text,
    department text,
    "departmentName" text,
    category text,
    "categoryName" text,
    description text,
    image text,
    contact text,
    "supervisorId" text,
    capacity text,
    status text DEFAULT 'active'::text NOT NULL,
    draft boolean DEFAULT false NOT NULL,
    platforms text[]
);


--
-- Name: Project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Project" (
    id text NOT NULL,
    title text NOT NULL,
    name text NOT NULL,
    description text,
    image text,
    status text NOT NULL,
    visibility text DEFAULT 'private'::text NOT NULL,
    "unitId" text,
    year text,
    "projectType" text,
    draft boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ProjectDiscussionMessage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ProjectDiscussionMessage" (
    id integer NOT NULL,
    "projectId" text NOT NULL,
    "senderId" text NOT NULL,
    message text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ProjectDiscussionMessage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."ProjectDiscussionMessage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ProjectDiscussionMessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."ProjectDiscussionMessage_id_seq" OWNED BY public."ProjectDiscussionMessage".id;


--
-- Name: Publication; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Publication" (
    id text NOT NULL,
    title text NOT NULL,
    "pubType" text NOT NULL,
    degree text,
    year text,
    "unitId" text,
    description text,
    pdf text,
    journal text,
    "supervisorId" text,
    draft boolean DEFAULT false NOT NULL
);


--
-- Name: Regulation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Regulation" (
    id integer NOT NULL,
    title text NOT NULL,
    category text NOT NULL,
    description text,
    "filePath" text NOT NULL,
    "fileSize" text,
    "lastUpdated" timestamp(3) without time zone,
    draft boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Regulation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Regulation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Regulation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Regulation_id_seq" OWNED BY public."Regulation".id;


--
-- Name: ResearchUnit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ResearchUnit" (
    id text NOT NULL,
    title text NOT NULL,
    name text NOT NULL,
    image text,
    description text,
    draft boolean DEFAULT false NOT NULL
);


--
-- Name: Staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Staff" (
    id text NOT NULL,
    "userId" text,
    title text NOT NULL,
    subtitle text,
    image text,
    "unitId" text,
    "titlePosition" text,
    email text,
    orcid text,
    "googleScholar" text,
    scopus text,
    researchgate text,
    "personalWebsite" text,
    bio text,
    content text,
    description text,
    "researchAreas" text[],
    draft boolean DEFAULT false NOT NULL,
    "subCategory" text
);


--
-- Name: SystemSettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SystemSettings" (
    "keyName" text NOT NULL,
    "valueText" text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Testimonial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Testimonial" (
    id text NOT NULL,
    title text NOT NULL,
    quote text NOT NULL,
    "position" text,
    image text,
    draft boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id text NOT NULL,
    name text,
    email text NOT NULL,
    "emailVerified" timestamp(3) without time zone,
    "passwordHash" text,
    image text,
    role text DEFAULT 'researcher'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "verificationCode" text
);


--
-- Name: _ProjectTeam; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_ProjectTeam" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _PublicationAuthors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_PublicationAuthors" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: EquipmentFeedback id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentFeedback" ALTER COLUMN id SET DEFAULT nextval('public."EquipmentFeedback_id_seq"'::regclass);


--
-- Name: EquipmentReservation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentReservation" ALTER COLUMN id SET DEFAULT nextval('public."EquipmentReservation_id_seq"'::regclass);


--
-- Name: Event id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Event" ALTER COLUMN id SET DEFAULT nextval('public."Event_id_seq"'::regclass);


--
-- Name: Form id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Form" ALTER COLUMN id SET DEFAULT nextval('public."Form_id_seq"'::regclass);


--
-- Name: ProjectDiscussionMessage id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ProjectDiscussionMessage" ALTER COLUMN id SET DEFAULT nextval('public."ProjectDiscussionMessage_id_seq"'::regclass);


--
-- Name: Regulation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Regulation" ALTER COLUMN id SET DEFAULT nextval('public."Regulation_id_seq"'::regclass);


--
-- Data for Name: Dataset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Dataset" (id, title, description, "unitId", year, access, format, size, draft, "createdAt") FROM stdin;
dataset-agricultural-survey	Agricultural Survey Data 2023	Survey data on agricultural practices, crop yields, and farming methods from regional surveys.	unit-agriculture	2023	Restricted	SPSS, CSV	8 MB	f	2026-07-21 01:17:49.992
dataset-climate-data	Climate Data Collection 2023-2024	Comprehensive climate data including temperature, precipitation, and weather patterns for Kurdistan Region.	\N	2024	Open	CSV, Excel	15 MB	f	2026-07-21 01:17:49.996
dataset-molecular-biology	Molecular Biology Dataset	Genomic and proteomic data from ongoing molecular biology research projects.	unit-biology-life-sciences	2024	On-Request	FASTA, CSV	250 MB	f	2026-07-21 01:17:49.997
dataset-social-research	Social Research Survey 2023	Social research data including demographic information and community surveys.	unit-social-sciences-humanities	2023	Open	SPSS, CSV	5 MB	f	2026-07-21 01:17:49.999
\.


--
-- Data for Name: Equipment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Equipment" (id, name, "labId", category, description, status, "workingUnits", "outOfOrder", "totalUnits", model, specifications, image) FROM stdin;
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-006	Electronic Balance	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Electronic Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-013	water bath	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	water bath	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-001	incubator	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	incubator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-014	Ultrasonic Cleaner	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Ultrasonic Cleaner	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-015	Centerifuge	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Centerifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-016	Automatic Voltage Regulator	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Automatic Voltage Regulator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-017	Rotery Evaporator	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Rotery Evaporator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-018	Distilator	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Distilator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-019	Texture Analyzer	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Texture Analyzer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-020	Refrigrator	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Refrigrator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-021	Autoclave	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Autoclave	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-022	High effect steadby voltage invert	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	High effect steadby voltage invert	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-grdarasha-001	milko scaner	agriculture-engineering-sciences-food-technology-grdarasha	food-technology	milko scaner	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-grdarasha-002	Centerifuge	agriculture-engineering-sciences-food-technology-grdarasha	food-technology	Centerifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-grdarasha-003	Gerber cenerifuge	agriculture-engineering-sciences-food-technology-grdarasha	food-technology	Gerber cenerifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-fish-resources-lab-33-002	Conductivity Meter	agriculture-engineering-sciences-fish-resources-lab-33	fish-resources	Conductivity Meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-005	Centerifuge	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Centerifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-004	Spectrophtometer	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Spectrophtometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-007	Spectrophtometer	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Spectrophtometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-011	Microscope	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-008	Texture Analyzer	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Texture Analyzer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-009	Hotplate stirrer	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Hotplate stirrer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-010	pHmeter	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	pHmeter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-012	Incubtor	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Incubtor	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-21-001	Heating meantles	agriculture-engineering-sciences-food-technology-lab-21	food-technology	Heating meantles	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-21-003	Balance	agriculture-engineering-sciences-food-technology-lab-21	food-technology	Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-21-002	Centrifuge	agriculture-engineering-sciences-food-technology-lab-21	food-technology	Centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-010	Mixer	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Mixer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-006	oven	agriculture-engineering-sciences-food-technology-lab-9	food-technology	oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-21-004	Oven	agriculture-engineering-sciences-food-technology-lab-21	food-technology	Oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-8-001	oven	agriculture-engineering-sciences-food-technology-lab-8	food-technology	oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-001	Microwave	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Microwave	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-002	oven	agriculture-engineering-sciences-food-technology-lab-9	food-technology	oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-004	oven	agriculture-engineering-sciences-food-technology-lab-9	food-technology	oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-005	oven	agriculture-engineering-sciences-food-technology-lab-9	food-technology	oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-013	Electric cooker Hot plate	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Electric cooker Hot plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-007	Food dehydrator	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Food dehydrator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-008	cookworks Juice extractor	agriculture-engineering-sciences-food-technology-lab-9	food-technology	cookworks Juice extractor	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-009	Meat grinder	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Meat grinder	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-011	Juice extractor	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Juice extractor	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-004	Oven	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-005	Microscope	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-014	Seed counter part 1	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Seed counter part 1	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-015	seed counter part 2	agriculture-engineering-sciences-food-technology-lab-9	food-technology	seed counter part 2	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-016	Brabender part 1	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Brabender part 1	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-grdarasha-005	separator	agriculture-engineering-sciences-food-technology-grdarasha	food-technology	separator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-grdarasha-006	electronic balance	agriculture-engineering-sciences-food-technology-grdarasha	food-technology	electronic balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-001	Autoclave	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Autoclave	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-002	Incubator	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Incubator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-003	Balance	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-006	Water Distellator	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Water Distellator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-007	Microscope - monitor	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Microscope - monitor	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-008	Microscpoe	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Microscpoe	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-10-009	Microscope	agriculture-engineering-sciences-food-technology-lab-10	food-technology	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-012	King mulfak roboty premiem king supreme	agriculture-engineering-sciences-food-technology-lab-9	food-technology	King mulfak roboty premiem king supreme	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-002	Oven	agriculture-engineering-sciences-food-technology-lab23	food-technology	Oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-003	Furance oven	agriculture-engineering-sciences-food-technology-lab23	food-technology	Furance oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-004	pH meter	agriculture-engineering-sciences-food-technology-lab23	food-technology	pH meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-005	E.C meter	agriculture-engineering-sciences-food-technology-lab23	food-technology	E.C meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-006	Spectrophotometer	agriculture-engineering-sciences-food-technology-lab23	food-technology	Spectrophotometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-007	Hot plate	agriculture-engineering-sciences-food-technology-lab23	food-technology	Hot plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-008	Elictrical Polarimeter	agriculture-engineering-sciences-food-technology-lab23	food-technology	Elictrical Polarimeter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-009	Rotational viscometer	agriculture-engineering-sciences-food-technology-lab23	food-technology	Rotational viscometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-010	Furance oven	agriculture-engineering-sciences-food-technology-lab23	food-technology	Furance oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-011	Digestion equipment	agriculture-engineering-sciences-food-technology-lab23	food-technology	Digestion equipment	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-012	Hot plate	agriculture-engineering-sciences-food-technology-lab23	food-technology	Hot plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-013	Balance	agriculture-engineering-sciences-food-technology-lab23	food-technology	Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-014	Centrifuge	agriculture-engineering-sciences-food-technology-lab23	food-technology	Centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-001	Autoclave	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Autoclave	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-003	Small oven	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Small oven	available	2	0	2	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-004	cooling Incubator	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	cooling Incubator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-006	Stereo Microscope	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Stereo Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-007	Laminar air flow	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Laminar air flow	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-008	pH-meter	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	pH-meter	available	2	0	2	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-018	microscope for grain	agriculture-engineering-sciences-food-technology-lab-9	food-technology	microscope for grain	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-019	Grain miller	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Grain miller	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-020	Electronic balance	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Electronic balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-021	Bostwich	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Bostwich	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-022	Balance camry	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Balance camry	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-023	Handeled grain crasher	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Handeled grain crasher	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-027	Blender strong	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Blender strong	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-026	Extruder	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Extruder	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-025	Electro thermal cup	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Electro thermal cup	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab23-001	Balance	agriculture-engineering-sciences-food-technology-lab23	food-technology	Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-024	krups for waffles	agriculture-engineering-sciences-food-technology-lab-9	food-technology	krups for waffles	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-011	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-014	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-012	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-013	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-015	Refrigerator	agriculture-engineering-sciences-plant-protection-11	plant-protection	Refrigerator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-010	oven	agriculture-engineering-sciences-plant-protection-12	plant-protection	oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-002	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-016	Freezer	agriculture-engineering-sciences-plant-protection-11	plant-protection	Freezer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-017	Datashow	agriculture-engineering-sciences-plant-protection-11	plant-protection	Datashow	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-001	AUTOCLAVE	agriculture-engineering-sciences-plant-protection-12	plant-protection	AUTOCLAVE	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-002	AUTOCLAVE	agriculture-engineering-sciences-plant-protection-12	plant-protection	AUTOCLAVE	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-003	AUTOCLAVE	agriculture-engineering-sciences-plant-protection-12	plant-protection	AUTOCLAVE	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-004	Incubatore	agriculture-engineering-sciences-plant-protection-12	plant-protection	Incubatore	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-005	Incubatore	agriculture-engineering-sciences-plant-protection-12	plant-protection	Incubatore	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-006	Incubatore COOLD	agriculture-engineering-sciences-plant-protection-12	plant-protection	Incubatore COOLD	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-007	Hood	agriculture-engineering-sciences-plant-protection-12	plant-protection	Hood	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-008	Hood	agriculture-engineering-sciences-plant-protection-12	plant-protection	Hood	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-009	Refrigerator	agriculture-engineering-sciences-plant-protection-12	plant-protection	Refrigerator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-001	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-012	MICROWAVE	agriculture-engineering-sciences-plant-protection-12	plant-protection	MICROWAVE	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-013	MICROWAVE	agriculture-engineering-sciences-plant-protection-12	plant-protection	MICROWAVE	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-014	Water bath	agriculture-engineering-sciences-plant-protection-12	plant-protection	Water bath	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-011	Microwave	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Microwave	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-003	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-004	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-006	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-009	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-008	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-007	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-010	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-011	Centerfuge	agriculture-engineering-sciences-plant-protection-12	plant-protection	Centerfuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-029	Compound Microscope	agriculture-engineering-sciences-plant-protection-12	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-030	Compound Microscope	agriculture-engineering-sciences-plant-protection-12	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-13-001	electrical spray	agriculture-engineering-sciences-plant-protection-13	plant-protection	electrical spray	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-031	Compound Microscope	agriculture-engineering-sciences-plant-protection-12	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-032	Heater (heating unit )	agriculture-engineering-sciences-plant-protection-12	plant-protection	Heater (heating unit )	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-033	Centerfuge	agriculture-engineering-sciences-plant-protection-12	plant-protection	Centerfuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-002	Compound Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-001	Compound Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-026	SHAKER	agriculture-engineering-sciences-plant-protection-12	plant-protection	SHAKER	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-003	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-004	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-006	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-007	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-008	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-009	Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-010	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-011	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-012	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-013	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-014	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-016	sensitive balance	agriculture-engineering-sciences-plant-protection-12	plant-protection	sensitive balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-017	Blender	agriculture-engineering-sciences-plant-protection-12	plant-protection	Blender	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-018	Blender	agriculture-engineering-sciences-plant-protection-12	plant-protection	Blender	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-020	grinder	agriculture-engineering-sciences-plant-protection-12	plant-protection	grinder	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-021	soxhlet extraction	agriculture-engineering-sciences-plant-protection-12	plant-protection	soxhlet extraction	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-022	Datashow	agriculture-engineering-sciences-plant-protection-12	plant-protection	Datashow	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-023	SHAKER	agriculture-engineering-sciences-plant-protection-12	plant-protection	SHAKER	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-024	SHAKER	agriculture-engineering-sciences-plant-protection-12	plant-protection	SHAKER	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-025	SHAKER	agriculture-engineering-sciences-plant-protection-12	plant-protection	SHAKER	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-028	Elisa reader	agriculture-engineering-sciences-plant-protection-12	plant-protection	Elisa reader	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-005	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-004	Halogen Moisture Analyzer	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	Halogen Moisture Analyzer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-008	Ec meter	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	Ec meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-19-004	pH meter	agriculture-engineering-sciences-soil-and-water-lab-19	soil-and-water	pH meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-003	Conductivity Measurement	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Conductivity Measurement	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-018	Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-026	Heater (heating unit )	agriculture-engineering-sciences-plant-protection-14	plant-protection	Heater (heating unit )	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-022	Overhead	agriculture-engineering-sciences-plant-protection-14	plant-protection	Overhead	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-19-001	Microscope	agriculture-engineering-sciences-soil-and-water-lab-19	soil-and-water	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-19-002	Microscope Normal	agriculture-engineering-sciences-soil-and-water-lab-19	soil-and-water	Microscope Normal	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-19-003	Ec meter	agriculture-engineering-sciences-soil-and-water-lab-19	soil-and-water	Ec meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-20-001	Balance	agriculture-engineering-sciences-soil-and-water-lab-20	soil-and-water	Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-001	Theodolite	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Theodolite	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-016	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-017	Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-019	Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-020	Incubatore	agriculture-engineering-sciences-plant-protection-14	plant-protection	Incubatore	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-021	Datashow	agriculture-engineering-sciences-plant-protection-14	plant-protection	Datashow	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-023	Heater (heating unit )	agriculture-engineering-sciences-plant-protection-14	plant-protection	Heater (heating unit )	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-024	Heater (heating unit )	agriculture-engineering-sciences-plant-protection-14	plant-protection	Heater (heating unit )	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-005	Hote Plate	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	Hote Plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-025	Heater (heating unit )	agriculture-engineering-sciences-plant-protection-14	plant-protection	Heater (heating unit )	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-027	Refrigerator	agriculture-engineering-sciences-plant-protection-14	plant-protection	Refrigerator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-001	Oven	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	Oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-002	Water Bath	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	Water Bath	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-006	spectro Photometer	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	spectro Photometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-007	pH meter	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	pH meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-002	Level	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Level	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-010	Sieve Shaker	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Sieve Shaker	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-010	Function Generator	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Function Generator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-004	Electrophoresis+power supply	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Electrophoresis+power supply	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-001	Hote Plate	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Hote Plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-003	Shaker	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Shaker	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-004	Electronic Balance	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Electronic Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-011	Microscope	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-001	Incubator	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Incubator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-002	Magnetic hot plate	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Magnetic hot plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-003	pH meter	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	pH meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-005	Microscope	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-006	Cooler centrifuge	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Cooler centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-007	Normal centrifuge	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Normal centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-005	Water Well Measurement	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Water Well Measurement	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-006	Distance Measurement	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Distance Measurement	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-007	Blender	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Blender	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-010	water bath	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	water bath	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-011	Oscilloscope	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Oscilloscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-011	Eliza +Eliza reader human	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Eliza +Eliza reader human	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-012	Microscope hot plate	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Microscope hot plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-013	Microscope human	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Microscope human	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-014	Microscope huge mirror	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Microscope huge mirror	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-015	Microwave	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Microwave	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-016	UV Transilluminator-regular	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	UV Transilluminator-regular	available	1	0	1	\N	{}	\N
eq-education-chemistry-industrial-chem-lab-005	Sand bath	education-chemistry-industrial-chem-lab	chemistry	Sand bath	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-008	Oven	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-008	Micro centrifuge	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Micro centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-009	Electrical balance	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Electrical balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-006	Calipper	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Calipper	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-007	Gasoline chain saw	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Gasoline chain saw	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-020	Autoclave	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Autoclave	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-001	Drying oven	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Drying oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-002	Drying oven	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Drying oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-003	Magnetic stirrere hot plate	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Magnetic stirrere hot plate	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-008	Water bath	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Water bath	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-009	Protimeter Grain Master	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Protimeter Grain Master	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-010	Electronic scale	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Electronic scale	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-019	Animal altrasound	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Animal altrasound	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-011	Vertical meter and Horizontal meter	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Vertical meter and Horizontal meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-012	Broadcast spreader setting matrix	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Broadcast spreader setting matrix	available	1950	0	1950	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-013	Hot plate heater	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Hot plate heater	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-014	Hallogen moisture analyzer	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Hallogen moisture analyzer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-015	80 slide tray	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	80 slide tray	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-004	Rotary microtome	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Rotary microtome	available	820	0	820	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-005	Electrone precession balance	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Electrone precession balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-017	Hygrothermometer	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Hygrothermometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-019	Hygrometer	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Hygrometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-020	Hygrometer	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Hygrometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-021	Refractometer or Polorimeter	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Refractometer or Polorimeter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-022	Moisture meter	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Moisture meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-023	Spiegel RELASKOP	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Spiegel RELASKOP	available	20468	0	20468	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-024	Mini LIGNO	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Mini LIGNO	available	14345	0	14345	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-025	Laser Rangefinder	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Laser Rangefinder	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-026	Electronic micrometer	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Electronic micrometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-018	Tropical(frozen Device)	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Tropical(frozen Device)	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-016	Hygrothermometer	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Hygrothermometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-018	Electrical balance	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Electrical balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-017	Humiditymeter	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Humiditymeter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-001	Drying oven	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Drying oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-030	SOKKIA with its attachments (3 parts)	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	SOKKIA with its attachments (3 parts)	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-003	Dicecator	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Dicecator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-033	Vaccum tensiometer	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Vaccum tensiometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-001	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-006	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-007	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-009	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-010	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-011	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-012	Centrifuge	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-013	Centrifuge	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-014	Hemoglobinometer	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Hemoglobinometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-002	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-015	Hemacytometer	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Hemacytometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-005	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-029	Measure meter	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Measure meter	available	5500	0	5500	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-031	TOPOCON	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	TOPOCON	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-002	Muffle furnace	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Muffle furnace	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-032	Seed Prometer Digital- Balemster	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Seed Prometer Digital- Balemster	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-004	protien digestion device(Kjeldahl)	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	protien digestion device(Kjeldahl)	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-005	soxhlet device	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	soxhlet device	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-005	Hot plate magnitic stirre	basic-education-general-science-chemistry	general-science	Hot plate magnitic stirre	available	2	0	2	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-028	Compensation plane- meter	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Compensation plane- meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-004	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-016	Linkam	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Linkam	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-009	Centerfuge	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	Centerfuge	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-001	Incnbator	basic-education-general-science-biology	general-science	Incnbator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-007	Incubator	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Incubator	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-003	Centrifuge	basic-education-general-science-biology	general-science	Centrifuge	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-004	Micro Centrifuge	basic-education-general-science-biology	general-science	Micro Centrifuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-006	Balance	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-007	PH Miter	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	PH Miter	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-001	TDS meter	basic-education-general-science-chemistry	general-science	TDS meter	available	2	0	2	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-008	Microscop	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	Microscop	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-003	Egg Tester	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	Egg Tester	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-004	Waterbath	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	Waterbath	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-002	Incnbator	basic-education-general-science-biology	general-science	Incnbator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-010	Electrical balance	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Electrical balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-011	Humidity (moisture) estimator	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Humidity (moisture) estimator	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-005	Centrifuge	basic-education-general-science-biology	general-science	Centrifuge	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-006	Vortex mixer	basic-education-general-science-biology	general-science	Vortex mixer	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-007	Magnatic Stirrer	basic-education-general-science-biology	general-science	Magnatic Stirrer	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-008	Oven	basic-education-general-science-biology	general-science	Oven	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-009	Outoclave	basic-education-general-science-biology	general-science	Outoclave	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-010	Water bath	basic-education-general-science-biology	general-science	Water bath	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-005	Micromiter	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	Micromiter	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-011	Digital kymograph	basic-education-general-science-biology	general-science	Digital kymograph	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-012	Sensitive Balance	basic-education-general-science-biology	general-science	Sensitive Balance	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-biology-013	Microscope	basic-education-general-science-biology	general-science	Microscope	available	4	0	4	\N	{}	\N
eq-basic-education-general-science-biology-014	Microwave oven	basic-education-general-science-biology	general-science	Microwave oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-001	normal oven	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	normal oven	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-002	EC meter	basic-education-general-science-chemistry	general-science	EC meter	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-004	Water distillation	basic-education-general-science-chemistry	general-science	Water distillation	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-008	Oven	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Oven	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-012	fiber estimator device	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	fiber estimator device	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad-002	Hardnes	agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	unknown	Hardnes	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-003	PH meter	basic-education-general-science-chemistry	general-science	PH meter	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-007	pH meter	education-chemistry-analytical-chem-lab	chemistry	pH meter	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-009	Heating mantles	education-chemistry-analytical-chem-lab	chemistry	Heating mantles	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-010	Water Still	education-chemistry-analytical-chem-lab	chemistry	Water Still	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-011	Vacuum pimp	education-chemistry-analytical-chem-lab	chemistry	Vacuum pimp	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-003	Power Supply	basic-education-general-science-physics-lab	general-science	Power Supply	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-004	Oven	education-chemistry-analytical-chem-lab	chemistry	Oven	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-008	Power Supply	basic-education-general-science-physics-lab	general-science	Power Supply	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-009	Digital Storage Oscilloscope	basic-education-general-science-physics-lab	general-science	Digital Storage Oscilloscope	available	2	0	2	\N	{}	\N
eq-basic-education-general-science-physics-lab-010	Power Supply	basic-education-general-science-physics-lab	general-science	Power Supply	available	2	0	2	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-008	Centerfuge	education-chemistry-analytical-chem-lab	chemistry	Centerfuge	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-011	AmpliFier	basic-education-general-science-physics-lab	general-science	AmpliFier	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-012	Function Generator	basic-education-general-science-physics-lab	general-science	Function Generator	available	2	0	2	\N	{}	\N
eq-basic-education-general-science-physics-lab-013	Pc oscilloscope	basic-education-general-science-physics-lab	general-science	Pc oscilloscope	available	2	0	2	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-002	Waterbath	education-chemistry-analytical-chem-lab	chemistry	Waterbath	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-003	Sand bath	education-chemistry-analytical-chem-lab	chemistry	Sand bath	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-005	Oven	education-chemistry-analytical-chem-lab	chemistry	Oven	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-006	Sensitive Balance	education-chemistry-analytical-chem-lab	chemistry	Sensitive Balance	available	1	0	1	\N	{}	\N
eq-education-chemistry-bio-chem-lab-002	Electric sand bath	education-chemistry-bio-chem-lab	chemistry	Electric sand bath	available	1	0	1	\N	{}	\N
eq-education-chemistry-bio-chem-lab-004	Waterbath	education-chemistry-bio-chem-lab	chemistry	Waterbath	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-001	Low Voltage Power supply	basic-education-general-science-physics-lab	general-science	Low Voltage Power supply	available	2	0	2	\N	{}	\N
eq-education-chemistry-industrial-chem-lab-001	Box Furnace	education-chemistry-industrial-chem-lab	chemistry	Box Furnace	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-002	Power Supply	basic-education-general-science-physics-lab	general-science	Power Supply	available	1	0	1	\N	{}	\N
eq-education-chemistry-industrial-chem-lab-004	Temp. controller	education-chemistry-industrial-chem-lab	chemistry	Temp. controller	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-012	Drier	education-chemistry-analytical-chem-lab	chemistry	Drier	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-004	Power Supply	basic-education-general-science-physics-lab	general-science	Power Supply	available	2	0	2	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-013	Heater	education-chemistry-analytical-chem-lab	chemistry	Heater	available	1	0	1	\N	{}	\N
eq-education-chemistry-bio-chem-lab-001	Electronic balance	education-chemistry-bio-chem-lab	chemistry	Electronic balance	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-009	hot plate	basic-education-general-science-chemistry	general-science	hot plate	available	1	0	1	\N	{}	\N
eq-education-chemistry-bio-chem-lab-005	UV-visible spectrophotometer	education-chemistry-bio-chem-lab	chemistry	UV-visible spectrophotometer	available	1	0	1	\N	{}	\N
eq-education-chemistry-industrial-chem-lab-002	Oil Bath	education-chemistry-industrial-chem-lab	chemistry	Oil Bath	available	1	0	1	\N	{}	\N
eq-education-chemistry-industrial-chem-lab-003	Oven	education-chemistry-industrial-chem-lab	chemistry	Oven	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-005	Scope Digital Multimeters	basic-education-general-science-physics-lab	general-science	Scope Digital Multimeters	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-006	Oscilloscope	basic-education-general-science-physics-lab	general-science	Oscilloscope	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-physics-lab-007	Power Supply	basic-education-general-science-physics-lab	general-science	Power Supply	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-007	Fume hood	basic-education-general-science-chemistry	general-science	Fume hood	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-008	Sensitive Balance	basic-education-general-science-chemistry	general-science	Sensitive Balance	available	1	0	1	\N	{}	\N
eq-education-chemistry-inorganic-chem-lab-004	Sand bath	education-chemistry-inorganic-chem-lab	chemistry	Sand bath	available	1	0	1	\N	{}	\N
eq-education-chemistry-inorganic-chem-lab-005	Waterbath	education-chemistry-inorganic-chem-lab	chemistry	Waterbath	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-006	GAS TURBINE JET ENGINE	engineering-aviation-aviation-lab	aviation	GAS TURBINE JET ENGINE	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-007	FLOW NOZZLE METER TRAINER	engineering-aviation-aviation-lab	aviation	FLOW NOZZLE METER TRAINER	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-008	NOZZLES FANS AND COMPRESSORS	engineering-aviation-aviation-lab	aviation	NOZZLES FANS AND COMPRESSORS	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-009	FREEZING POINT APPARATUS	engineering-aviation-aviation-lab	aviation	FREEZING POINT APPARATUS	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-007	Sand bath	education-chemistry-organic-chem-lab	chemistry	Sand bath	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-008	Melting point divice	education-chemistry-organic-chem-lab	chemistry	Melting point divice	available	1	0	1	\N	{}	\N
eq-education-chemistry-inorganic-chem-lab-002	Oven	education-chemistry-inorganic-chem-lab	chemistry	Oven	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-002	UV-visible spectrophotometer	education-chemistry-physical-chem-lab	chemistry	UV-visible spectrophotometer	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-003	Electronic balance	education-chemistry-physical-chem-lab	chemistry	Electronic balance	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-004	Oven	education-chemistry-physical-chem-lab	chemistry	Oven	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-005	Flask Shaker	education-chemistry-physical-chem-lab	chemistry	Flask Shaker	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-006	Conductivity meter	education-chemistry-physical-chem-lab	chemistry	Conductivity meter	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-007	Waterbath	education-chemistry-physical-chem-lab	chemistry	Waterbath	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-010	FLASH POINT TESTER	engineering-aviation-aviation-lab	aviation	FLASH POINT TESTER	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-008	Distilled water equipment	education-chemistry-physical-chem-lab	chemistry	Distilled water equipment	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-001	Subsonic Wind Tunnel Vertical Aerodynamic Trainer	engineering-aviation-aviation-lab	aviation	Subsonic Wind Tunnel Vertical Aerodynamic Trainer	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-002	AERODYNAMICS TRAINER	engineering-aviation-aviation-lab	aviation	AERODYNAMICS TRAINER	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-005	TURBO JET ENGINE CUT SECTION - MOTORISED	engineering-aviation-aviation-lab	aviation	TURBO JET ENGINE CUT SECTION - MOTORISED	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-002	Electronic Balance	education-chemistry-organic-chem-lab	chemistry	Electronic Balance	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-003	Rotatory Evaporator	education-chemistry-organic-chem-lab	chemistry	Rotatory Evaporator	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-003	Fluorescence \nMicroscope \nLABomed LX.400	research-center-unknown-lab1	unknown	Fluorescence \nMicroscope \nLABomed LX.400	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-011	VISCOSITY MEASURMENT APPARATUS	engineering-aviation-aviation-lab	aviation	VISCOSITY MEASURMENT APPARATUS	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-012	RAMSBOTTOM RESIDUE APPARATUS	engineering-aviation-aviation-lab	aviation	RAMSBOTTOM RESIDUE APPARATUS	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-013	FUEL COMBUSTION RATE APPARATUS	engineering-aviation-aviation-lab	aviation	FUEL COMBUSTION RATE APPARATUS	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-001	Oven	education-chemistry-organic-chem-lab	chemistry	Oven	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-014	FUEL ENERGY APPARATUS	engineering-aviation-aviation-lab	aviation	FUEL ENERGY APPARATUS	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-001	Incubater Binder \nED 53	research-center-unknown-lab1	unknown	Incubater Binder \nED 53	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-002	Incubater Binder \nBD 53	research-center-unknown-lab1	unknown	Incubater Binder \nBD 53	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-004	Waterbath	education-chemistry-organic-chem-lab	chemistry	Waterbath	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-005	Heater	education-chemistry-organic-chem-lab	chemistry	Heater	available	1	0	1	\N	{}	\N
eq-education-chemistry-inorganic-chem-lab-001	Magnetic Stirrer	education-chemistry-inorganic-chem-lab	chemistry	Magnetic Stirrer	available	1	0	1	\N	{}	\N
eq-education-chemistry-organic-chem-lab-006	Heating mantles	education-chemistry-organic-chem-lab	chemistry	Heating mantles	available	1	0	1	\N	{}	\N
eq-education-chemistry-physical-chem-lab-001	UV-visible spectrophotometer	education-chemistry-physical-chem-lab	chemistry	UV-visible spectrophotometer	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-004	FLIGHT DEMONSTRATION WIND TUNNEL	engineering-aviation-aviation-lab	aviation	FLIGHT DEMONSTRATION WIND TUNNEL	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-006	Liquid Nitrogen	research-center-unknown-lab1	unknown	Liquid Nitrogen	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-008	Centrifuge	research-center-unknown-lab1	unknown	Centrifuge	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-009	Light Microscope \nwith camera	research-center-unknown-lab1	unknown	Light Microscope \nwith camera	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-010	Deep freezer-40	research-center-unknown-lab1	unknown	Deep freezer-40	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-011	Vortex	research-center-unknown-lab1	unknown	Vortex	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-024	Mikroair Flow\n Cabinet Class-A2	research-center-unknown-lab1	unknown	Mikroair Flow\n Cabinet Class-A2	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-025	CO2 incubater With\nextra glass door	research-center-unknown-lab1	unknown	CO2 incubater With\nextra glass door	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-015	Western blotting\nmidi - systm	research-center-unknown-lab1	unknown	Western blotting\nmidi - systm	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-016	Western blotting\nMaxi	research-center-unknown-lab1	unknown	Western blotting\nMaxi	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-017	Coold incubator\n with orbital shaker\nstuart	research-center-unknown-lab1	unknown	Coold incubator\n with orbital shaker\nstuart	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-018	Refrigerated\n Circulator Producr	research-center-unknown-lab1	unknown	Refrigerated\n Circulator Producr	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-019	Automated Cell\n Counter7	research-center-unknown-lab1	unknown	Automated Cell\n Counter7	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-020	Nuwind Multi -\nApplication Centrifuge -Centrifuge 96 Well\nPlate 7	research-center-unknown-lab1	unknown	Nuwind Multi -\nApplication Centrifuge -Centrifuge 96 Well\nPlate 7	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-022	Analysis Electronic\nBalance -200g-0001g Kevn1	research-center-unknown-lab1	unknown	Analysis Electronic\nBalance -200g-0001g Kevn1	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-026	Cell Culture \nAspiration System2	research-center-unknown-lab1	unknown	Cell Culture \nAspiration System2	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-027	Imaging System\n Glite 900BW\nGel Documentaw	research-center-unknown-lab1	unknown	Imaging System\n Glite 900BW\nGel Documentaw	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-028	Magnetic Stirrer \nVelp Ltaly (2)	research-center-unknown-lab1	unknown	Magnetic Stirrer \nVelp Ltaly (2)	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-029	Refrigerated\n incubater Binder \nKb53	research-center-unknown-lab1	unknown	Refrigerated\n incubater Binder \nKb53	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-001	Microwave- Silver\n crest	research-center-unknown-lab2	unknown	Microwave- Silver\n crest	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-002	Laptop-Nano Drop	research-center-unknown-lab2	unknown	Laptop-Nano Drop	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-003	Nanodrop thermo \n1000	research-center-unknown-lab2	unknown	Nanodrop thermo \n1000	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-004	Bench centrifuge \nchalice	research-center-unknown-lab2	unknown	Bench centrifuge \nchalice	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-005	Inverted Tissue \nculture microscope\nTCM400 Labomed	research-center-unknown-lab1	unknown	Inverted Tissue \nculture microscope\nTCM400 Labomed	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-005	Elelectrophoresis \nAppartus Cleaver	research-center-unknown-lab2	unknown	Elelectrophoresis \nAppartus Cleaver	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-006	Orbitar Shaker	research-center-unknown-lab2	unknown	Orbitar Shaker	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-007	Lomiar Flow Hood \nBioquell Astes	research-center-unknown-lab2	unknown	Lomiar Flow Hood \nBioquell Astes	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-008	Fine vortex fine \nP.C.R  - Daigger	research-center-unknown-lab2	unknown	Fine vortex fine \nP.C.R  - Daigger	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-010	Micropipette	research-center-unknown-lab2	unknown	Micropipette	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-011	Water bath shaking	research-center-unknown-lab2	unknown	Water bath shaking	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-012	Safety Cabinet\n classll	research-center-unknown-lab1	unknown	Safety Cabinet\n classll	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-013	Cool Centrifuge\n Hettich	research-center-unknown-lab1	unknown	Cool Centrifuge\n Hettich	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-014	Micro Centirfuge\nWisespin	research-center-unknown-lab1	unknown	Micro Centirfuge\nWisespin	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-007	CO2 incubator RS\nBiotech	research-center-unknown-lab1	unknown	CO2 incubator RS\nBiotech	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-023	Lnverted Microcope \nWich com euromex-0x-2003-p17	research-center-unknown-lab1	unknown	Lnverted Microcope \nWich com euromex-0x-2003-p17	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-009	Hot Plate stirrer-\n Daigger	research-center-unknown-lab2	unknown	Hot Plate stirrer-\n Daigger	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-013	Analytical balance	research-center-unknown-lab2	unknown	Analytical balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-fish-resources-lab-33-003	Multi-Parameter Photo meter	agriculture-engineering-sciences-fish-resources-lab-33	fish-resources	Multi-Parameter Photo meter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-grdarasha-004	homoginizer	agriculture-engineering-sciences-food-technology-grdarasha	food-technology	homoginizer	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab4-005	Hood- Hedlab	research-center-unknown-lab4	unknown	Hood- Hedlab	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab4-006	Ts Micro plate \nreader 800 - bioteek	research-center-unknown-lab4	unknown	Ts Micro plate \nreader 800 - bioteek	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-009	Hot-plate Magnetic stirrer	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Hot-plate Magnetic stirrer	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-023	Alpha thermal \ncycler max PCR	research-center-unknown-lab2	unknown	Alpha thermal \ncycler max PCR	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-024	DNA concentrater \nmi vac	research-center-unknown-lab2	unknown	DNA concentrater \nmi vac	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-025	Mini see-saw rocker	research-center-unknown-lab2	unknown	Mini see-saw rocker	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-026	Mini centrifuge	research-center-unknown-lab2	unknown	Mini centrifuge	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-027	Ultra sonic Liquid \n  Processor	research-center-unknown-lab2	unknown	Ultra sonic Liquid \n  Processor	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-028	A TV E500 Auto \nclave	research-center-unknown-lab2	unknown	A TV E500 Auto \nclave	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-030	Incubater	research-center-unknown-lab2	unknown	Incubater	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-031	Power supply -\ncleaver	research-center-unknown-lab2	unknown	Power supply -\ncleaver	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-032	Western Blotting\n Mini	research-center-unknown-lab2	unknown	Western Blotting\n Mini	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab4-001	Phmer Daigger	research-center-unknown-lab4	unknown	Phmer Daigger	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab4-002	Western Blotting Mini	research-center-unknown-lab4	unknown	Western Blotting Mini	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab4-003	Pipette carrier-cleauer	research-center-unknown-lab4	unknown	Pipette carrier-cleauer	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab4-004	Balance	research-center-unknown-lab4	unknown	Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-017	Brabender part 2	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Brabender part 2	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-015	Water distiller	agriculture-engineering-sciences-plant-protection-12	plant-protection	Water distiller	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab4-007	Ts Micro plate \nWasher800 -bioteek	research-center-unknown-lab4	unknown	Ts Micro plate \nWasher800 -bioteek	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-014	UV gel decumeutation\n proxima 2500	research-center-unknown-lab2	unknown	UV gel decumeutation\n proxima 2500	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-fish-resources-lab-33-001	Haematology Analyser	agriculture-engineering-sciences-fish-resources-lab-33	fish-resources	Haematology Analyser	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-015	Prim pro 48 Real \ntimePCR system	research-center-unknown-lab2	unknown	Prim pro 48 Real \ntimePCR system	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-lab-9-003	Electric oven	agriculture-engineering-sciences-food-technology-lab-9	food-technology	Electric oven	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-016	Compact multi wide horizontal\n electrophorsis system	research-center-unknown-lab2	unknown	Compact multi wide horizontal\n electrophorsis system	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-017	power supply	research-center-unknown-lab2	unknown	power supply	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-018	Micropipette	research-center-unknown-lab2	unknown	Micropipette	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-019	Deep freezer-Lab\n TECH	research-center-unknown-lab2	unknown	Deep freezer-Lab\n TECH	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-020	Jenwer model 3010\nPH temp meter	research-center-unknown-lab2	unknown	Jenwer model 3010\nPH temp meter	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-021	power supply	research-center-unknown-lab2	unknown	power supply	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-022	Techne PCR tc 512	research-center-unknown-lab2	unknown	Techne PCR tc 512	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-033	Micro centirfuge\nchalice	research-center-unknown-lab2	unknown	Micro centirfuge\nchalice	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-002	water purification equipment	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	water purification equipment	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-008	Microscopic CE	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic CE	available	1	0	1	\N	{}	\N
eq-education-chemistry-bio-chem-lab-003	Angle head centerfuge	education-chemistry-bio-chem-lab	chemistry	Angle head centerfuge	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-002	Oven	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Oven	available	1	0	1	\N	{}	\N
eq-basic-education-general-science-chemistry-006	Digital Display heating mantle	basic-education-general-science-chemistry	general-science	Digital Display heating mantle	available	6	0	6	\N	{}	\N
eq-research-center-unknown-lab1-004	Dce 2- Microscope\n+ camera	research-center-unknown-lab1	unknown	Dce 2- Microscope\n+ camera	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab1-021	Inverted Flourecent\nMicrosocope Zeiss\ncoond Tempreture\nController Observer3-\nCo2 Madules-\nCarl Zeiss Microsocope Gmbh\nLED Manitar LG \nCase think Centor	research-center-unknown-lab1	unknown	Inverted Flourecent\nMicrosocope Zeiss\ncoond Tempreture\nController Observer3-\nCo2 Madules-\nCarl Zeiss Microsocope Gmbh\nLED Manitar LG \nCase think Centor	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-012	UV transilluminator\n-glass-Protector	research-center-unknown-lab2	unknown	UV transilluminator\n-glass-Protector	available	1	0	1	\N	{}	\N
eq-research-center-unknown-lab2-029	Techne digital\n dri-block heater for higt temperature Ambient to 200 deg C plus block for 20-1.5 ml tubes	research-center-unknown-lab2	unknown	Techne digital\n dri-block heater for higt temperature Ambient to 200 deg C plus block for 20-1.5 ml tubes	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab-18-003	Sensitive Balance	agriculture-engineering-sciences-soil-and-water-lab-18	soil-and-water	Sensitive Balance	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-department-higher-education-lab-003	Refractometer	agriculture-engineering-sciences-food-technology-department-higher-education-lab	food-technology-department	Refractometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-food-technology-grdarasha-007	refrigerator	agriculture-engineering-sciences-food-technology-grdarasha	food-technology	refrigerator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-005	Microscope with camera	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Microscope with camera	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-horticulture-25-tissue-culture-010	Refrigerator	agriculture-engineering-sciences-horticulture-25-tissue-culture	horticulture	Refrigerator	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-11-005	Compound Microscope	agriculture-engineering-sciences-plant-protection-11	plant-protection	Compound Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-019	Blender	agriculture-engineering-sciences-plant-protection-12	plant-protection	Blender	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-12-027	Elisa washer	agriculture-engineering-sciences-plant-protection-12	plant-protection	Elisa washer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-plant-protection-14-015	Dissecting Microscope	agriculture-engineering-sciences-plant-protection-14	plant-protection	Dissecting Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-005	Mobile Microscope	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Mobile Microscope	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-006	Voltage Power Supply	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Voltage Power Supply	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-009	Viscisity coefficient extraction	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Viscisity coefficient extraction	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-forestry-lab-lab-5-027	Micrometer (manual)	agriculture-engineering-sciences-unknown-forestry-lab-lab-5	unknown	Micrometer (manual)	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-009	Distiled Water Device	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Distiled Water Device	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-017	Fish Microscope+power supply	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	Fish Microscope+power supply	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-006	water distillation device	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	water distillation device	available	1	0	1	\N	{}	\N
eq-education-chemistry-inorganic-chem-lab-003	Melting point divice	education-chemistry-inorganic-chem-lab	chemistry	Melting point divice	available	1	0	1	\N	{}	\N
eq-engineering-aviation-aviation-lab-003	Subsonic Wind Tunnel Horizontal Aerodynamic Trainer	engineering-aviation-aviation-lab	aviation	Subsonic Wind Tunnel Horizontal Aerodynamic Trainer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-004	Frequency Measurement	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Frequency Measurement	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan-009	Crude fiber estimator device	agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	unknown	Crude fiber estimator device	available	1	0	1	\N	{}	\N
eq-education-chemistry-industrial-chem-lab-006	Heating mantles	education-chemistry-industrial-chem-lab	chemistry	Heating mantles	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-007	Voltmeter& ammeter	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Voltmeter& ammeter	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-soil-and-water-lab1-008	Avometer	agriculture-engineering-sciences-soil-and-water-lab1	soil-and-water	Avometer	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen-003	Microscopic	agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	unknown	Microscopic	available	1	0	1	\N	{}	\N
eq-education-chemistry-analytical-chem-lab-001	Multiposition heaters	education-chemistry-analytical-chem-lab	chemistry	Multiposition heaters	available	1	0	1	\N	{}	\N
eq-nt-005	Precision Vacuum Spin Coater	nanotechnology	Thin Film Fabrication	\N	available	1	0	1	\N	\N	\N
eq-agriculture-engineering-sciences-soil-and-water-lab7-002	Vacume Pump	agriculture-engineering-sciences-soil-and-water-lab7	soil-and-water	Vacume Pump	available	1	0	1	\N	{}	\N
eq-agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf-021	PCR	agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	unknown	PCR	available	1	0	1	\N	{}	\N
eq-cb-001	Automated Cell Counter	cancer-biology	Cell Culture	\N	available	2	0	2	\N	\N	\N
eq-cb-002	Real-Time PCR System (qPCR)	cancer-biology	Molecular Biology	\N	available	1	0	1	\N	\N	\N
eq-cb-003	Fluorescence Phase Contrast Microscope	cancer-biology	Cell Imaging	\N	available	1	0	1	\N	\N	\N
eq-cb-004	CO2 Incubator BSL-2	cancer-biology	Cell Culture	\N	available	3	0	3	\N	\N	\N
eq-cb-005	High-Speed Refrigerated Centrifuge	cancer-biology	Sample Processing	\N	available	2	0	2	\N	\N	\N
eq-cb-006	Multimode Microplate Reader (ELISA)	cancer-biology	Biomarker Discovery	\N	available	1	0	1	\N	\N	\N
eq-me-001	Mastercycler Gradient PCR Machine	molecular-engineering	Genetic Engineering	\N	available	4	0	4	\N	\N	\N
eq-me-002	Gel Documentation & Imaging System	molecular-engineering	Recombinant DNA	\N	available	2	0	2	\N	\N	\N
eq-me-003	NanoDrop Microvolume Spectrophotometer	molecular-engineering	Molecular Biology	\N	available	1	0	1	\N	\N	\N
eq-me-004	Fast Protein Liquid Chromatography (FPLC)	molecular-engineering	Protein Expression	\N	available	1	0	1	\N	\N	\N
eq-me-005	Ultra-Low Temperature Freezer (-80°C)	molecular-engineering	Biobanking	\N	available	2	0	2	\N	\N	\N
eq-ca-001	High-Performance Liquid Chromatograph (HPLC)	chemical-analysis	Chromatography	\N	available	1	0	1	\N	\N	\N
eq-ca-002	Atomic Absorption Spectrophotometer (AAS)	chemical-analysis	Heavy Metal Analysis	\N	available	1	0	1	\N	\N	\N
eq-ca-003	Double Beam UV-Vis Spectrophotometer	chemical-analysis	Spectrophotometry	\N	available	2	0	2	\N	\N	\N
eq-ca-004	Gas Chromatography-Mass Spectrophotometer (GC-MS)	chemical-analysis	Organic Analysis	\N	available	1	0	1	\N	\N	\N
eq-ca-005	Multi-Parameter Water Quality Meter	chemical-analysis	Environmental Analysis	\N	available	3	0	3	\N	\N	\N
eq-nt-001	TEM Sample Preparation & Ion Milling Unit	nanotechnology	Electron Microscopy	\N	available	1	0	1	\N	\N	\N
eq-nt-002	Dynamic Light Scattering (DLS) Zeta Potential Analyzer	nanotechnology	Material Characterization	\N	available	1	0	1	\N	\N	\N
eq-nt-003	High-Intensity Ultrasonic Homogenizer & Sonicator	nanotechnology	Nanoparticle Synthesis	\N	available	2	0	2	\N	\N	\N
eq-nt-004	High-Temperature Muffle Furnace (1200°C)	nanotechnology	Materials Synthesis	\N	available	1	0	1	\N	\N	\N
\.


--
-- Data for Name: EquipmentFeedback; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."EquipmentFeedback" (id, "reservationId", "equipmentId", "userName", "userEmail", rating, "benefitStatement", status, "createdAt") FROM stdin;
\.


--
-- Data for Name: EquipmentReservation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."EquipmentReservation" (id, "equipmentId", "userName", "userEmail", "userType", purpose, "startTime", "endTime", status, "rejectionReason", "approvedById", "createdAt") FROM stdin;
\.


--
-- Data for Name: Event; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Event" (id, title, slug, "eventDate", image, "eventType", featured, description, content, category, "eventTime", location, draft, "createdAt", "galleryImages") FROM stdin;
244	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-244	2026-06-02 18:25:00	/images/events/fb/1501168944783110.jpg	seminar	f	Official Announcement: Official Notice: Due to schedule updates, the World Environment Day 2026 Symposium has been convened for Sunday.. Date:: 7-6-2026 Saturday Time: 10 Location: Salahaddin University-Erbil- E...	Official Announcement: Official Notice: Due to schedule updates, the World Environment Day 2026 Symposium has been convened for Sunday.. Date:: 7-6-2026 Saturday Time: 10 Location: Salahaddin University-Erbil- Erbil/ .	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.204	{}
246	On the occasion of Eid al-Adha, the Director General and Executive Boa	on-the-occasion-of-eid-al-adha-the-director-genera-246	2026-05-26 10:58:00	\N	seminar	f	On the occasion of Eid al-Adha, the Director General and Executive Board of the Scientific Research Center extend their warmest congratulations to all faculty members, researchers, students, and Muslims worldwide. Wishing peace, health, and acad...	On the occasion of Eid al-Adha, the Director General and Executive Board of the Scientific Research Center extend their warmest congratulations to all faculty members, researchers, students, and Muslims worldwide. Wishing peace, health, and academic prosperity to all.	Announcement	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.225	{}
253	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-253	2026-03-24 14:53:00	/images/events/fb/1596242734949067.jpg	seminar	f	... (7) ... () (Fully Funded). ... ... (IELTS & TOEFL). ...	... (7) ... () (Fully Funded). ... ... (IELTS & TOEFL). () (2026-2027). + +. . ( ) () (2026-2027)... ... : 0777 154 9502 0751 152 8233	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.234	{}
3	Molecular Biology Research Seminar Series	event-3	2024-04-05 11:00:00	images/blog/post-3.jpg	regular	f	Monthly seminar series featuring cutting-edge research in molecular biology and genetics.	\N	Seminar	\N	Biology Lab, Science Building	f	2026-09-08 07:44:54.015	{}
4	Environmental Monitoring Field Trip	event-4	2024-04-12 05:00:00	images/blog/post-4.jpg	regular	f	Field trip to environmental monitoring sites to observe data collection methods.	\N	Field Trip	\N	Various Field Sites, Erbil Region	f	2026-09-08 07:44:54.017	{}
5	Chemistry Lab Safety Training Session	event-5	2024-04-18 08:00:00	images/blog/post-5.jpg	regular	f	Comprehensive safety training for all chemistry laboratory users.	\N	Training	\N	Chemistry Lab, Science Building	f	2026-09-08 07:44:54.018	{}
6	Social Sciences Research Methodology Workshop	event-6	2024-04-25 06:30:00	images/blog/post-6.jpg	regular	f	Workshop on research methodologies for social sciences and humanities.	\N	Workshop	\N	Social Sciences Building, Room 301	f	2026-09-08 07:44:54.019	{}
7	Agricultural Research Open Day	event-7	2024-05-02 07:00:00	images/blog/post-7.jpg	regular	f	Open day showcasing agricultural research projects and innovations.	\N	Open Day	\N	Agricultural Research Station	f	2026-09-08 07:44:54.02	{}
8	Materials Science Conference: Innovations in Industrial Applications	event-8	2024-05-10 06:00:00	images/blog/post-8.jpg	regular	f	Two-day conference on materials science and its industrial applications.	\N	Conference	\N	Main Auditorium, SURC Building	f	2026-09-08 07:44:54.021	{}
9	Student Research Poster Competition	event-9	2024-05-15 10:00:00	images/blog/post-1.jpg	regular	f	Annual competition showcasing undergraduate and graduate student research projects.	\N	Competition	\N	Exhibition Hall, Main Building	f	2026-09-08 07:44:54.022	{}
10	Research Ethics and Integrity Training	event-10	2024-05-20 07:00:00	images/blog/post-2.jpg	regular	f	Training session on research ethics, integrity, and responsible conduct of research.	\N	Training	\N	Conference Room, SURC Building	f	2026-09-08 07:44:54.023	{}
11	Pump-up the team morale and celebrate the excellence	event-11	2020-07-18 04:07:21	images/blog/post-2.jpg	regular	f	This is meta description	\N	Workshop	\N	Research Center, Room 201	f	2026-09-08 07:44:54.024	{}
12	screens with built in Present and Dismiss animations.	event-12	2020-06-18 04:07:21	images/blog/post-3.jpg	regular	f	This is meta description	\N	Conference	\N	SUE Campus, Erbil	f	2026-09-08 07:44:54.025	{}
13	Adversus is a web-based dialer and practical CRM solution	event-13	2020-05-18 04:07:21	images/blog/post-4.jpg	regular	f	This is meta description	\N	Conference	\N	SUE Campus, Erbil	f	2026-09-08 07:44:54.026	{}
14	Adversus is a web-based dialer and practical CRM solution	event-14	2020-04-18 04:07:21	images/blog/post-5.jpg	regular	f	This is meta description	\N	Conference	\N	SUE Campus, Erbil	f	2026-09-08 07:44:54.027	{}
15	Adversus is a web-based dialer and practical CRM solution	event-15	2020-03-18 04:07:21	images/blog/post-6.jpg	regular	f	This is meta description	\N	Conference	\N	SUE Campus, Erbil	f	2026-09-08 07:44:54.028	{}
16	How and why we decided to launch an EMI scheme for our employees	event-16	2021-02-18 04:07:21	images/blog/post-3.jpg	regular	f	This is meta description	\N	Conference	\N	SUE Campus, Erbil	f	2026-09-08 07:44:54.029	{}
17	What to consider before starting a business – Inside The Studio	event-17	2021-01-18 04:07:21	images/blog/post-5.jpg	regular	f	This is meta description	\N	Conference	\N	SUE Campus, Erbil	f	2026-09-08 07:44:54.03	{}
18	International Research Symposium on Climate Change	event-18	2024-03-15 06:00:00	images/blog/post-1.jpg	regular	f	Join us for a comprehensive symposium on climate change research and its impact on Kurdistan region.	\N	Symposium	\N	Main Conference Hall, SURC Building	f	2026-09-08 07:44:54.031	{}
19	Events	event-19	2026-09-11 23:18:49.65	\N	regular	f	View all upcoming events	\N	Conference	\N	SUE Campus, Erbil	f	2026-09-08 07:44:54.032	{}
1	Adversus is a web-based dialer and practical CRM solution	event-1	2020-08-18 04:07:21	images/blog/post-1.jpg	regular	f	This is meta description	\N	Conference	\N	Main Auditorium, SURC Building	f	2026-09-08 07:44:53.998	{}
2	Data Science Workshop: Advanced Analytics Techniques	event-2	2024-03-22 07:00:00	images/blog/post-2.jpg	regular	f	Hands-on workshop on advanced data analytics and machine learning applications.	\N	Workshop	\N	Computer Lab, Data Analysis Unit	f	2026-09-08 07:44:54.014	{}
240	Quality Assurance & Accreditation Council Assembly	quality-assurance-accreditation-council-assembly-240	2026-07-08 09:05:00	/images/events/fb/1532488931651111.jpg	seminar	t	Date: 30/6/2026 supervision of the Director General of the Scientific Research Center Research unit directors, quality assurance leads, and lab managers Council members convened a strategic planni...	Date: 30/6/2026 supervision of the Director General of the Scientific Research Center Research unit directors, quality assurance leads, and lab managers Council members convened a strategic planning meeting alignment with institutional accreditation and quality framework standards . review and enhancement of the official Research Center web portal defining long-term research vision and strategic goals Salahaddin University-Erbil – Erbil .	Administrative Meeting	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.196	{/images/events/fb/1532488944984443.jpg,/images/events/fb/1532489341651070.jpg,/images/events/fb/1532489318317739.jpg,/images/events/fb/1532489478317723.jpg,/images/events/fb/1532489541651050.jpg,/images/events/fb/1532489598317711.jpg,/images/events/fb/1532489698317701.jpg}
247	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-247	2026-05-24 22:18:00	/images/events/fb/1493275238905814.jpg	seminar	f	Saturday 24/5/2026 Scientific Research Center -Erbil ...	Saturday 24/5/2026 Scientific Research Center -Erbil .	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.227	{}
361	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-361	2025-03-03 19:36:00	/images/events/fb/1148161856750489.jpg	seminar	f	Saturday Date: 3/ 3/ 2025 ... ...	Saturday Date: 3/ 3/ 2025 ... 2024-2025 .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.343	{/images/events/fb/1148161876750487.jpg,/images/events/fb/1148161883417153.jpg,/images/events/fb/1148161980083810.jpg,/images/events/fb/1148161966750478.jpg}
254	SURC Research Activity Announcement	surc-research-activity-announcement-254	2026-03-09 19:16:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @dunya 07806253125 _ _ # ‎ ‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.235	{}
264	SURC Research Activity Announcement	surc-research-activity-announcement-264	2026-01-26 18:18:00	\N	seminar	f	Scientific Activity Announcement - seminar 450 seminar...	Scientific Activity Announcement - seminar 450 seminar seminar seminar {{ }} Dunya hiwa & & 07806253125 ‎ _ _ # ‎ ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.248	{}
286	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-286	2026-01-05 20:40:00	/images/events/fb/1381238423442830.jpg	seminar	f	Saturday 5/1/2026 Scientific Research Center -Erbil Scientific Research Center . ...	Saturday 5/1/2026 Scientific Research Center -Erbil Scientific Research Center . Scientific Research Center -Erbil Geo-AI . . Scientific Research Center -Erbil -Erbil Geo-AI.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.269	{/images/events/fb/1381238390109500.jpg,/images/events/fb/1381238383442834.jpg,/images/events/fb/1381238473442825.jpg}
250	Applied Workshop: Livestock Breeding & Management	applied-workshop-livestock-breeding-management-250	2026-04-19 09:29:00	/images/events/fb/1463186035248068.jpg	workshop	f	Salahaddin University Research Center Scientific Activity: : Scientific Research Center/ . - Erbil scientific applied workshop « » ...	Salahaddin University Research Center Scientific Activity: : Scientific Research Center/ . - Erbil scientific applied workshop « » Erbil Erbil. Date:: 20-4-2026 / Saturday Time: 9 Location: Salahaddin University-Erbil-Erbil. :	Workshop	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.23	{}
252	Kurdish Language Terminology Standardization Board Meeting	kurdish-language-terminology-standardization-board-252	2026-03-31 18:14:00	/images/events/fb/1448599323373406.jpg	seminar	f	Supreme Board for the Kurdish Language Terminology Standardization Project held its inaugural official meeting.... Saturday Date: 30/ 3/ 2026 Under official academic auspices at Salahaddin University-Erbil.	Supreme Board for the Kurdish Language Terminology Standardization Project held its inaugural official meeting.... Saturday Date: 30/ 3/ 2026 Under official academic auspices at Salahaddin University-Erbil. Salahaddin University-Erbil- Erbil ....	Language & Culture	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.232	{}
262	SURC Research Activity Announcement	surc-research-activity-announcement-262	2026-02-01 12:14:00	\N	seminar	f	Scientific Activity Announcement - ( ) ( ) ...	Scientific Activity Announcement - ( ) ( ) 450 @Dunya & & 07806253125 ‎ _ _ # ‎ ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.245	{}
320	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-320	2025-10-31 13:22:00	/images/events/fb/1332027025030637.jpg	seminar	f	Date: 30/10/2025 Scientific Research Center-Salahaddin University-Erbil-Erbil / ... / ...	Date: 30/10/2025 Scientific Research Center-Salahaddin University-Erbil-Erbil / ... / . Scientific Research Center . . .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.303	{/images/events/fb/1332027018363971.jpg}
270	Congratulatory Announcement:....	congratulatory-announcement-270	2026-03-19 12:43:00	/images/events/fb/1438420051058000.jpg	seminar	f	Congratulatory Announcement:.... ...	Congratulatory Announcement:.... ... . . Scientific Research Center/ . - Erbil	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.254	{}
333	SURC Research Activity Announcement	surc-research-activity-announcement-333	2026-02-26 18:52:00	\N	seminar	f	Scientific Activity Announcement - 450 ...	Scientific Activity Announcement - 450 @Dunya & & 07806253125 _ _ # ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.316	{}
260	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-260	2026-02-05 11:24:00	/images/events/fb/1404905724409433.jpg	conference	f	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center ...	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center : ( (COP30) ). (COP30) . : . Date:: 9-2-2026 Time: 10 Location: - -Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.243	{}
271	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-271	2026-02-26 18:58:00	/images/events/fb/1422837845949554.jpg	seminar	f	25-2-2026 Scientific Research Center ...	25-2-2026 Scientific Research Center .	Meeting	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.255	{/images/events/fb/1422837832616222.jpg,/images/events/fb/1422838115949527.jpg,/images/events/fb/1422838092616196.jpg,/images/events/fb/1422838109282861.jpg}
278	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-278	2026-02-03 18:42:00	/images/events/fb/1400969952043178.jpg	symposium	f	Salahaddin University Research Center .. .... Salahaddin University-Erbil (WaPOR) (Remote Sensing) ...	Salahaddin University Research Center .. .... Salahaddin University-Erbil (WaPOR) (Remote Sensing) .…	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.261	{/images/events/fb/1400970135376493.jpg,/images/events/fb/1400970005376506.jpg,/images/events/fb/1400970182043155.jpg,/images/events/fb/1400970148709825.jpg}
344	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-344	2025-05-13 09:11:00	/images/events/fb/1199219948311346.jpg	seminar	f	Scientific Research Center Salahaddin University-Erbil-Erbil. . / . / . ...	Scientific Research Center Salahaddin University-Erbil-Erbil. . / . / . ... / . / Erbil. / . / Erbil. . / / ‌ . / . ( ) ( ) Salahaddin University-Erbil . . ‌‌ .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.326	{/images/events/fb/1199219931644681.jpg,/images/events/fb/1199219954978012.jpg,/images/events/fb/1199220014978006.jpg,/images/events/fb/1199220024978005.jpg}
282	SURC Research Activity Announcement	surc-research-activity-announcement-282	2026-01-21 16:03:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - & & & 07806253125 @dunya ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.265	{}
364	SURC Research Activity Announcement	surc-research-activity-announcement-364	2025-02-05 06:53:00	\N	seminar	f	Scientific Activity Announcement - ... .... Salahaddin University-Erbil ...	Scientific Activity Announcement - ... .... Salahaddin University-Erbil ... Rudaw Health . Salahaddin University-Erbil	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.346	{}
283	SURC Research Activity Announcement	surc-research-activity-announcement-283	2026-01-12 17:36:00	\N	seminar	f	Scientific Activity Announcement - 10 ...	Scientific Activity Announcement - 10 @dunya 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.266	{}
295	Publication Milestone: Climate Change Unit Research Paper	publication-milestone-climate-change-unit-research-295	2025-12-14 17:20:00	\N	seminar	f	The Environmental Monitoring and Climate Change Unit (EMCH) at the Scientific Research Center announces the official publication of its inaugural research paper focusing on regional environmental indicators and climate adaptability in Kurdistan.	The Environmental Monitoring and Climate Change Unit (EMCH) at the Scientific Research Center announces the official publication of its inaugural research paper focusing on regional environmental indicators and climate adaptability in Kurdistan.	Publication Announcement	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.278	{}
370	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-370	2024-11-05 08:29:00	/images/events/fb/971039828372719.jpg	seminar	f	Salahaddin University Research Center .... SUE Research Center .	Salahaddin University Research Center .... SUE Research Center .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.351	{/images/events/fb/971039855039383.jpg,/images/events/fb/971039831706052.jpg,/images/events/fb/971039911706044.jpg,/images/events/fb/971039931706042.jpg}
239	Statement of Support for the Syndicate of Kurdistan Artists	statement-of-support-for-the-syndicate-of-kurdista-239	2026-08-20 13:35:00	/images/events/fb/122293376726200149.jpg	seminar	t	Special gratitude and appreciation to the Syndicate Board of Kurdistan Artists We request all media outlets to adhere strictly to this ethical guidelines decision Calling on fellow artists to boycott media outlets that exploit health situations ...	Special gratitude and appreciation to the Syndicate Board of Kurdistan Artists We request all media outlets to adhere strictly to this ethical guidelines decision Calling on fellow artists to boycott media outlets that exploit health situations / / .. in honor and recognition of their fruitful lifelong artistic contributions . . . " . 20 2026	Official Statement	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.186	{}
267	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-267	2026-06-07 15:08:00	/images/events/fb/1512402380899934.jpg	seminar	f	2026 .... Salahaddin University-Erbil ( 2026 ) .…	2026 .... Salahaddin University-Erbil ( 2026 ) .…	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.251	{/images/events/fb/1512402430899929.jpg,/images/events/fb/1512402660899906.jpg,/images/events/fb/1512402540899918.jpg,/images/events/fb/1512402547566584.jpg}
374	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-374	2024-10-13 12:27:00	/images/events/fb/954289496714419.jpg	seminar	f	Salahaddin University Research Center ... 50 SUE Research ...	Salahaddin University Research Center ... 50 SUE Research Center (50) .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.354	{/images/events/fb/954289490047753.jpg,/images/events/fb/954289480047754.jpg,/images/events/fb/954289550047747.jpg}
241	SUE Excellence Awards: Honoring Top Cited Researchers	sue-excellence-awards-honoring-top-cited-researche-241	2026-06-23 12:05:00	/images/events/fb/26371378969205017.jpg	seminar	t	..... Saturday 23/ 6/ 2026 Honoring Ceremony for Outstanding Leading Researchers and Faculty at the level of Salahaddin University-Erbil Chair of the Highest Publications...	..... Saturday 23/ 6/ 2026 Honoring Ceremony for Outstanding Leading Researchers and Faculty at the level of Salahaddin University-Erbil Chair of the Highest Publications Committee Recipients of the Highest Citations Award CITATION Scientific achievements of the Scientific Research Center	Award Ceremony	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.199	{/images/events/fb/26371379285871652.jpg,/images/events/fb/26371379595871621.jpg,/images/events/fb/26371379975871583.jpg,/images/events/fb/26371380422538205.jpg,/images/events/fb/26371381049204809.jpg,/images/events/fb/26371381725871408.jpg,/images/events/fb/26371382022538045.jpg,/images/events/fb/26371972335812347.jpg,/images/events/fb/26373465562329691.jpg,/images/events/fb/26375800418762872.jpg}
263	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-263	2026-01-27 19:40:00	/images/events/fb/1398348018398537.jpg	symposium	f	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center -Erbil ...	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center -Erbil (FAO) . (WaPOR) (Remote Sensing) . FAO (WaPOR) . Date:: 3-2-2026 Time: 10 12 . : Salahaddin University-Erbil-Erbil- . : Under the supervision of the President of Salahaddin University - Erbil, Prof. Kamaran Younis Mohammed Amin. The Environmental Monitoring & Climate Change Unit at the Directorate General of the Scientific Research Center, Salahaddin University-Erbil, in collaboration with the Food and Agriculture Organization of the United Nations (FAO) in Iraq. Conducts a symposium on the use of the WaPOR portal database derived from remote sensing data for sustainable water resources management. The symposium, which will include several presentations and a panel, will highlight the importance and capabilities of WaPOR in providing data, analysis, monitoring, and decision-making support for water resources management.	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.246	{}
272	SURC Research Activity Announcement	surc-research-activity-announcement-272	2026-02-24 12:18:00	/images/events/fb/1574578297115511.jpg	seminar	f	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.256	{}
276	SURC Research Activity Announcement	surc-research-activity-announcement-276	2026-02-06 07:24:00	\N	seminar	f	Scientific Activity Announcement - .	Scientific Activity Announcement - .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.259	{}
287	SURC Research Activity Announcement	surc-research-activity-announcement-287	2025-12-25 16:01:00	\N	seminar	f	Scientific Activity Announcement - 500 ...	Scientific Activity Announcement - 500 ( ) @Dunya & & 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.27	{}
298	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-298	2025-12-09 09:23:00	/images/events/fb/1361759238724082.jpg	seminar	f	‌ (Proteomics) .	‌ (Proteomics) .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.281	{/images/events/fb/1361759245390748.jpg,/images/events/fb/1361759275390745.jpg,/images/events/fb/1361759318724074.jpg}
396	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-396	2020-09-30 17:14:00	/images/events/fb/187500442816640.jpg	seminar	f	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	.. 9 12 ... 859 .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.374	{/images/events/fb/187500496149968.jpg}
279	SURC Research Activity Announcement	surc-research-activity-announcement-279	2026-01-22 19:05:00	\N	seminar	f	Scientific Activity Announcement - : : 2026	Scientific Activity Announcement - : : 2026	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.262	{}
304	SURC Research Activity Announcement	surc-research-activity-announcement-304	2026-03-05 17:47:00	\N	seminar	f	Scientific Activity Announcement - seminar ...	Scientific Activity Announcement - seminar @Dunya & & 07806253125 ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.286	{}
406	Karzan Shekh Muhsin Barzinji	karzan-shekh-muhsin-barzinji-406	2020-03-15 19:01:00	/images/events/fb/2585847301628618.jpg	seminar	f	Karzan Shekh Muhsin Barzinji -19 20-60‏ .. .. …	Karzan Shekh Muhsin Barzinji -19 20-60‏ .. .. …	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.385	{/images/events/fb/2585852111628137.jpg}
245	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-245	2026-05-31 16:46:00	/images/events/fb/1499172314982773.jpg	symposium	f	Scientific Activity: : World Environment Day Symposium: Celebrating environmental monitoring & sustainability initiatives at SURC. Under official academic auspices at Salahaddin University-Erbil.	Scientific Activity: : World Environment Day Symposium: Celebrating environmental monitoring & sustainability initiatives at SURC. Under official academic auspices at Salahaddin University-Erbil. Date:: 4-6-2026 Time: 9:30 Location: -Erbil. : : : 8:30 9:30 . English: On celebrating World Environment Day: Under the esteemed patronage of the Senior Advisor to the Prime Minister for Foreign Affairs and Climate Change, the Directorate General of the Scientific Research Center at Salahaddin University-Erbil / Environmental Monitoring and Climate Change Unit is organizing a scientific symposium titled: (World Environment Day 2026, Building a Sustainable Future for the Kurdistan Region: Strategic Approaches to Water Security, Biodiversity Conservation, and Sustainable Waste Management) Date: June 4th, 2026 Time: 9:30 AM Venue: Cultural and Academic Center of Salahaddin University-Erbil To register, please visit the link below: For more information, visit the link below: Note: On-site registration is from 8:30 AM to 9:30 AM.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.205	{}
248	Scientific Seminar: Applications of Lissachatina Fulica Secretions	scientific-seminar-applications-of-lissachatina-fu-248	2026-05-19 08:10:00	/images/events/fb/1488468576053147.jpg	seminar	f	: Scientific Research Center/ . - Erbil a specialized academic seminar entitled: Management, Clinical and Aesthetic Applications of the Giant African Land Snail Lissachatina fulic...	: Scientific Research Center/ . - Erbil a specialized academic seminar entitled: Management, Clinical and Aesthetic Applications of the Giant African Land Snail Lissachatina fulica (Bowdich, 1822) Secretions Date:: 20-5-2026 / Saturday Time: (11) Location: Salahaddin University-Erbil-Erbil.	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.228	{}
251	Kurdish Language Terminology Standardization Board Meeting	kurdish-language-terminology-standardization-board-251	2026-03-31 18:14:00	/images/events/fb/1448599323373406.jpg	seminar	f	Supreme Board for the Kurdish Language Terminology Standardization Project held its inaugural official meeting.... Saturday Date: 30/ 3/ 2026 Under official academic auspices at Salahaddin University-Erbil.	Supreme Board for the Kurdish Language Terminology Standardization Project held its inaugural official meeting.... Saturday Date: 30/ 3/ 2026 Under official academic auspices at Salahaddin University-Erbil. Salahaddin University-Erbil- Erbil ....	Language & Culture	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.231	{}
398	SURC Research Activity Announcement	surc-research-activity-announcement-398	2020-04-11 20:37:00	\N	seminar	f	Scientific Activity Announcement - Karzan Shekh Muhsin Barzinji : 1- 12-24 .. 2- 12-24 ...	Scientific Activity Announcement - Karzan Shekh Muhsin Barzinji : 1- 12-24 .. 2- 12-24 .. 3- 12-24 apoptosis 4- 12-24 macrophage scavengers 5- 12-24 .. .. .. 6- . - ‏	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.376	{}
242	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-242	2026-06-08 08:48:00	/images/events/fb/1506307384269266.jpg	seminar	t	Under the auspices of Honorable Ms. Bayan Sami Abdulrahman, Senior Advisor to the Prime Minister for Foreign Affairs and Climate ChangeSenior Advisor to the Prime Minister for Foreign Affairs and Climate Change Environmental Monitoring and Clim...	Under the auspices of Honorable Ms. Bayan Sami Abdulrahman, Senior Advisor to the Prime Minister for Foreign Affairs and Climate ChangeSenior Advisor to the Prime Minister for Foreign Affairs and Climate Change Environmental Monitoring and Climate Change Unit (EMCH)/ at the Directorate General of the Scientific Research Center 7 6 2026 on the occasion of World Environment Dayin the presence of University President Prof. Dr. Kamaran Younis Mohammedamin President of Salahaddin University-Erbil “ . “ “ . “ “ .. “ …	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.201	{/images/events/fb/1506307414269263.jpg,/images/events/fb/1506307494269255.jpg,/images/events/fb/1506307544269250.jpg,/images/events/fb/1506307620935909.jpg,/images/events/fb/1506308220935849.jpg,/images/events/fb/1506308137602524.jpg,/images/events/fb/1506308170935854.jpg,/images/events/fb/1506308520935819.jpg,/images/events/fb/1506308554269149.jpg,/images/events/fb/1506308614269143.jpg,/images/events/fb/1506309070935764.jpg,/images/events/fb/1506309117602426.jpg,/images/events/fb/1506309094269095.jpg,/images/events/fb/1506309550935716.jpg,/images/events/fb/1506309480935723.jpg,/images/events/fb/1506309434269061.jpg,/images/events/fb/1506309817602356.jpg,/images/events/fb/1506309870935684.jpg,/images/events/fb/1506309904269014.jpg,/images/events/fb/1506310074268997.jpg,/images/events/fb/1506310187602319.jpg,/images/events/fb/1506310157602322.jpg,/images/events/fb/1506310267602311.jpg,/images/events/fb/1506310327602305.jpg,/images/events/fb/1506310357602302.jpg,/images/events/fb/1506310427602295.jpg,/images/events/fb/1506310474268957.jpg,/images/events/fb/1506307730935898.jpg,/images/events/fb/1506307877602550.jpg,/images/events/fb/1506307780935893.jpg,/images/events/fb/1506308344269170.jpg,/images/events/fb/1506308447602493.jpg,/images/events/fb/1506308377602500.jpg,/images/events/fb/1506308987602439.jpg,/images/events/fb/1506308974269107.jpg,/images/events/fb/1506309077602430.jpg,/images/events/fb/1506309494269055.jpg,/images/events/fb/1506309534269051.jpg,/images/events/fb/1506309610935710.jpg,/images/events/fb/1506309894269015.jpg,/images/events/fb/1506309944269010.jpg,/images/events/fb/1506308070935864.jpg}
243	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-243	2026-06-05 13:31:00	/images/events/fb/1508498957956943.jpg	seminar	t	Saturday 7/ 6/ 2026 . . Salahaddin University Research Center ..... 2026 Under official academic auspices at Salahaddin University-Erbil. ...	Saturday 7/ 6/ 2026 . . Salahaddin University Research Center ..... 2026 Under official academic auspices at Salahaddin University-Erbil. Salahaddin University-Erbil Official Announcement: . ( 2026 ) Saturday. Date:: 7 6 2026 Saturday Time: 10 Location: Salahaddin University-Erbil- Erbil - .	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.202	{}
268	Academic Reception: Visit of Dr. Orhan Tog to SURC	academic-reception-visit-of-dr-orhan-tog-to-surc-268	2026-04-09 11:48:00	/images/events/fb/25491674297175493.jpg	seminar	f	Wednesday 8/ 4/ 2026 . Scientific Research Center	Wednesday 8/ 4/ 2026 . Scientific Research Center	Delegation Visit	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.252	{}
343	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-343	2025-05-13 09:11:00	/images/events/fb/1199219948311346.jpg	seminar	f	Scientific Research Center Salahaddin University-Erbil-Erbil. . / . / . ...	Scientific Research Center Salahaddin University-Erbil-Erbil. . / . / . ... / . / Erbil. / . / Erbil. . / / ‌ . / . ( ) ( ) Salahaddin University-Erbil . . ‌‌ .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.325	{/images/events/fb/1199219931644681.jpg,/images/events/fb/1199219954978012.jpg,/images/events/fb/1199220014978006.jpg,/images/events/fb/1199220024978005.jpg}
255	SURC Research Activity Announcement	surc-research-activity-announcement-255	2026-03-05 17:47:00	\N	seminar	f	Scientific Activity Announcement - seminar ...	Scientific Activity Announcement - seminar @Dunya & & 07806253125 # ‎ ‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.236	{}
305	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-305	2025-11-29 16:28:00	/images/events/fb/25171720222438635.jpg	seminar	f	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	( ) ( ) 31 2013 ( 27 2011) . . ( 321): Yale Law School UoD College of Law College of Law Siberian Federal University Law School The Hague Academy of International Law Faculty of Law, Political Science and Management - Soran University Faculty of Law, University of Oxford Salahaddin University Research Center Cihan University Duhok University of Sulaimani - Soran University / International University of Erbil Lebanese French University-LFU Journal of Law & Emerging Technologies - Nawroz University Vehêl Gelnaskî Writer	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.288	{/images/events/fb/25171720199105304.jpg,/images/events/fb/25171720235771967.jpg,/images/events/fb/25171720395771951.jpg}
311	SURC Research Activity Announcement	surc-research-activity-announcement-311	2026-01-26 18:18:00	\N	seminar	f	Scientific Activity Announcement - seminar 450 seminar...	Scientific Activity Announcement - seminar 450 seminar seminar seminar {{ }} Dunya hiwa & & 07806253125 _ _ # ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.293	{}
393	SURC Research Activity Announcement	surc-research-activity-announcement-393	2020-03-18 19:54:00	\N	seminar	f	Scientific Activity Announcement - KURDISTAN24.NET ‌ ‌‌ ‌ ‌‌ ‌‌	Scientific Activity Announcement - KURDISTAN24.NET ‌ ‌‌ ‌ ‌‌ ‌‌	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.371	{}
257	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-257	2026-02-24 12:10:00	/images/events/fb/1574573987115942.jpg	seminar	f	... .. ( IELTS TOEFL). ( ) (2026-2027). + + ...	... .. ( IELTS TOEFL). ( ) (2026-2027). + + . () (2026-2027). ……………………………………………………………………………………. ( ): . ( ): . ……………………………………………………………………………………. . 1. ( ). 2. (: ). . 3. (). 4. . 5. . 6. . 7. ( ) . 8. , . 9. . 10- (Medical Certificate) 11- ( - Recommendation Latter). 12- : (Proposal). 13- (Motivation Latter). 14- ( ). . ……………………………………………………………………………………. : 1- . 2- . 3- ( ) . 4- . 5- . 6- . 7- . 8- . ……………………………………………………………………………………. : : • 07771549502 ----------------------------------------------------- (scholarship) (Fully Funded). ... ... (IELTS & TOEFL). () (2026-2027). + +. ( ) () (2026-2027)... ... ............................................................................................ (Fully Funded): . (Fully Funded): . ............................................................................................ +++ . 1- . 2- : ( 12 ) . 3- (C.V) . 4- . 5- . 6- . 7- Official Announcement: . 8- . 9- . 10- (Medical Certificate) 11- (Recommendation Latter). 12- : (Proposal). 13- : (Motivation Latter). 14- ( ). . ............................................................................................ . 1- . 2- . 3- . 4- . 5- . 6- . 7- . 8- . ............................................................................................ : • 07771549502 • 07511528233	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.239	{}
258	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-258	2026-02-15 15:38:00	/images/events/fb/24983395294670065.jpg	seminar	f	....... Salahaddin University Research Center .... ...	....... Salahaddin University Research Center .... Scientific Research Center/ Salahaddin University-Erbil- Erbil :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.24	{/images/events/fb/24983395581336703.jpg,/images/events/fb/24983395874670007.jpg}
315	SURC Research Activity Announcement	surc-research-activity-announcement-315	2026-02-01 12:14:00	\N	seminar	f	Scientific Activity Announcement - ( ) ( ) ...	Scientific Activity Announcement - ( ) ( ) 450 @Dunya & & 07806253125 _ _ # ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.297	{}
259	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-259	2026-02-09 19:50:00	/images/events/fb/1408752317358107.jpg	conference	f	COP30 . Scientific Research Center -Erbil ...	COP30 . Scientific Research Center -Erbil . 9 2 2026 “ .. ” President of Salahaddin University-Erbil ( COP30 ). 2025 (COP30) . .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.242	{/images/events/fb/1408752307358108.jpg,/images/events/fb/1408752294024776.jpg,/images/events/fb/1408752370691435.jpg,/images/events/fb/1408752410691431.jpg,/images/events/fb/1408752434024762.jpg,/images/events/fb/1408752464024759.jpg,/images/events/fb/1408752517358087.jpg,/images/events/fb/1408752510691421.jpg,/images/events/fb/1408752570691415.jpg,/images/events/fb/1408752610691411.jpg,/images/events/fb/1408752650691407.jpg,/images/events/fb/1408752694024736.jpg,/images/events/fb/1408752740691398.jpg,/images/events/fb/1408752760691396.jpg,/images/events/fb/1408752780691394.jpg,/images/events/fb/1408752817358057.jpg,/images/events/fb/1408752857358053.jpg,/images/events/fb/1408752894024716.jpg,/images/events/fb/1408752934024712.jpg,/images/events/fb/1408752960691376.jpg,/images/events/fb/1408752987358040.jpg,/images/events/fb/1408753030691369.jpg,/images/events/fb/1408753064024699.jpg,/images/events/fb/1408753094024696.jpg,/images/events/fb/1408753144024691.jpg,/images/events/fb/1408753160691356.jpg,/images/events/fb/1408753190691353.jpg,/images/events/fb/1408753244024681.jpg,/images/events/fb/1408753254024680.jpg,/images/events/fb/1408753390691333.jpg,/images/events/fb/1408753337358005.jpg,/images/events/fb/1408753347358004.jpg,/images/events/fb/1408753417357997.jpg,/images/events/fb/1408753454024660.jpg,/images/events/fb/1408753480691324.jpg,/images/events/fb/1408753517357987.jpg,/images/events/fb/1408753547357984.jpg,/images/events/fb/1408753644024641.jpg,/images/events/fb/1408753734024632.jpg,/images/events/fb/1408753694024636.jpg,/images/events/fb/1408753717357967.jpg}
269	SURC Research Activity Announcement	surc-research-activity-announcement-269	2026-03-21 12:26:00	/images/events/fb/25293101193699472.jpg	seminar	f	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.253	{}
382	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-382	2022-08-11 17:16:00	/images/events/fb/3309002682646406.jpg	seminar	f	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	.. .. .. … Salahaddin University Research Center ECHO Organization	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.361	{/images/events/fb/3309002855979722.jpg,/images/events/fb/3309002692646405.jpg,/images/events/fb/3309002779313063.jpg,/images/events/fb/3309002739313067.jpg}
383	SURC Research Activity Announcement	surc-research-activity-announcement-383	2022-01-19 17:39:00	/images/events/fb/458297212403627.jpg	workshop	f	20 1 2022 . . Saturday ...	20 1 2022 . . Saturday 2712022 . 27 27 1 2022 Saturday . 27 1 2022 Dear All, Due to the unforeseen circumstances and weather conditions. This is in addition to the governmental announcement of a sudden holiday of tomorrow 20January2022. We are obliged to postpone the workshop for one week. AILAR will be held on January 27th, 2022. However, your registration will be still active for the attendance and will proceed on the day of the event on January 27th. We are extremely sorry for any inconvenience this may have caused. looking forward to seeing you on January 27th, 2022. stay safe and have a great holiday. best regards The Organizing Committee Research Center	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.362	{}
346	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-346	2025-05-10 19:59:00	/images/events/fb/8957317817704402.jpg	seminar	f	( ) Under official academic auspices at Salahaddin University-Erbil.	( ) Under official academic auspices at Salahaddin University-Erbil. . ....	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.328	{}
266	Publication Milestone: Climate Change Unit Research Paper	publication-milestone-climate-change-unit-research-266	2026-06-08 22:12:00	\N	seminar	f	Under the auspices of Honorable Ms. Bayan Sami Abdulrahman, Senior Advisor to the Prime Minister for Foreign Affairs and Climate Change, the Environmental Monitoring and Climate Change Unit (EMCH) at the Scientific Research Center hosted a sympo...	Under the auspices of Honorable Ms. Bayan Sami Abdulrahman, Senior Advisor to the Prime Minister for Foreign Affairs and Climate Change, the Environmental Monitoring and Climate Change Unit (EMCH) at the Scientific Research Center hosted a symposium on June 7, 2026, commemorating World Environment Day, attended by University President Prof. Dr. Kamaran Younis Mohammedamin and academic leaders.	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.25	{}
353	Seminar: Phenomenology of Perception in Management	seminar-phenomenology-of-perception-in-management-353	2025-04-14 09:40:00	/images/events/fb/1178647680368573.jpg	seminar	f	( ) Saturday Date: 14/ 4/ 2025 .. Scientific Research Center ...	( ) Saturday Date: 14/ 4/ 2025 .. Scientific Research Center Scientific Research Center ( ... ... « » . .	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.335	{/images/events/fb/1178647673701907.jpg,/images/events/fb/1178647690368572.jpg,/images/events/fb/1178647750368566.jpg,/images/events/fb/1178647767035231.jpg}
261	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-261	2026-02-05 11:24:00	/images/events/fb/1404905724409433.jpg	conference	f	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center ...	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center : ( (COP30) ). (COP30) . : . Date:: 9-2-2026 Time: 10 Location: - -Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.244	{}
273	SURC Research Activity Announcement	surc-research-activity-announcement-273	2026-03-09 19:16:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @dunya 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.257	{}
274	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-274	2026-02-09 15:32:00	/images/events/fb/1406537144819792.jpg	seminar	f	Salahaddin University Research Center .... COP30 .... Salahaddin University-Erbil COP30 ...	Salahaddin University Research Center .... COP30 .... Salahaddin University-Erbil COP30 .…	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.258	{/images/events/fb/1406537664819740.jpg,/images/events/fb/1406537434819763.jpg,/images/events/fb/1406537384819768.jpg,/images/events/fb/1406537264819780.jpg}
265	SURC Research Activity Announcement	surc-research-activity-announcement-265	2026-01-25 18:19:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - turn.tin AI( )plagarism ( ) similarty() ( ) @dunya 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.249	{}
281	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-281	2026-01-21 12:30:00	/images/events/fb/1392708395629166.jpg	seminar	f	Wednesday 21/ 1/ 2026 . . Scientific Research Center « »..... ...	Wednesday 21/ 1/ 2026 . . Scientific Research Center « »..... .....	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.264	{/images/events/fb/1392708378962501.jpg,/images/events/fb/1392708365629169.jpg,/images/events/fb/1392708478962491.jpg}
300	Salahaddin University-Erbil	salahaddin-university-erbil-300	2025-12-06 20:29:00	/images/events/fb/1353778996762274.jpg	seminar	f	Salahaddin University-Erbil Scientific Research Center - Erbil .…	Salahaddin University-Erbil Scientific Research Center - Erbil .…	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.283	{/images/events/fb/1353779093428931.jpg,/images/events/fb/1353779063428934.jpg,/images/events/fb/1353779043428936.jpg}
394	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-394	2020-11-24 06:03:00	/images/events/fb/203123047921046.jpg	seminar	f	‌‌ ‌‌ ‌‌ ‌ ‌ ‌‌ ‌‌‌ ..‌‌ ‌ ‌ ‌ ‌‌ ‌‌ . ‌ ‌‌ .‌ ‌‌ ‌ ‌ ...	‌‌ ‌‌ ‌‌ ‌ ‌ ‌‌ ‌‌‌ ..‌‌ ‌ ‌ ‌ ‌‌ ‌‌ . ‌ ‌‌ .‌ ‌‌ ‌ ‌ ‌‌ ‌‌ ‌‌ ‌‌ ‌‌ ‌‌ ‌‌ ‌‌ ‌ ‌‌‌ ‌‌ ‌ ‌ ‌ ‌ ‌‌‌ ‌‌ ‌‌ ‌‌ ‌‌ ‌‌‌‌ ‌ ‌‌ ‌ ‌‌ ‌‌ ‌ ‌ ‌‌ ‌‌ ‌‌‌ ‌ ‌‌ ‌ ‌ ‌‌ ‌‌‌ ‌‌ ‌‌ ‌ ‌‌ ‌‌‌ ‌‌ ‌ ‌‌‌ ‌ ‌‌ ‌‌ ‌ ‌ ‌‌ ‌ ‌ ‌ ‌‌ ‌‌. ‌‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌ ‌‌ ‌‌‌ ‌‌ ‌‌ ‌ ‌ ‌‌ ‌‌ ‌‌ .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.372	{/images/events/fb/203123107921040.jpg,/images/events/fb/203123154587702.jpg}
288	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-288	2025-12-24 21:21:00	/images/events/fb/1372818824284790.jpg	seminar	f	Date: 405 " -Erbil" ".. " ".. " ...	Date: 405 " -Erbil" ".. " ".. " ".. " " " "... " " " ".. " Scientific Research Center" "Hands on Genomics and Proteomics" . Scientific Research Center . ".. " Scientific Research Center 05 . .	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.271	{/images/events/fb/1372818974284775.jpg,/images/events/fb/1372818957618110.jpg,/images/events/fb/1372819094284763.jpg,/images/events/fb/1372819080951431.jpg}
291	Research Capacity Building & Safety Training Course	research-capacity-building-safety-training-course-291	2025-12-17 17:06:00	/images/events/fb/1367627741470565.jpg	seminar	f	Scientific Research Center ...... Wednesday 17/ 12/ 2025 ...	Scientific Research Center ...... Wednesday 17/ 12/ 2025 « » .... Scientific Research Center !! " " .... . . .... ... ....	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.274	{/images/events/fb/1367627694803903.jpg,/images/events/fb/1367627654803907.jpg,/images/events/fb/1367627661470573.jpg,/images/events/fb/1367627758137230.jpg}
318	SURC Research Activity Announcement	surc-research-activity-announcement-318	2026-02-26 18:52:00	\N	seminar	f	Scientific Activity Announcement - 450 ...	Scientific Activity Announcement - 450 @Dunya & & 07806253125 _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.301	{}
284	SURC Research Activity Announcement	surc-research-activity-announcement-284	2026-01-07 16:06:00	\N	seminar	f	Scientific Activity Announcement - (LATEX - ) ...	Scientific Activity Announcement - (LATEX - ) @dunya 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.267	{}
292	SURC Research Activity Announcement	surc-research-activity-announcement-292	2026-05-26 10:58:00	\N	seminar	f	Scientific Activity Announcement - Congratulations.... ...	Scientific Activity Announcement - Congratulations.... ..... 17/ 12/ 2025 . . Scientific Research Center	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.275	{}
319	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-319	2025-11-02 07:41:00	/images/events/fb/1333589978207675.jpg	seminar	f	(Hands on Genomics and Proteomic Techniques) Scientific Research Center Salahaddin University-Erbil-Erbil.	(Hands on Genomics and Proteomic Techniques) Scientific Research Center Salahaddin University-Erbil-Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.302	{/images/events/fb/1333589984874341.jpg,/images/events/fb/1333589961541010.jpg,/images/events/fb/1333590081540998.jpg,/images/events/fb/1333590088207664.jpg}
285	SURC Research Activity Announcement	surc-research-activity-announcement-285	2026-01-12 17:36:00	\N	seminar	f	Scientific Activity Announcement - 10 ...	Scientific Activity Announcement - 10 @dunya 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.268	{}
307	SURC Research Activity Announcement	surc-research-activity-announcement-307	2025-11-26 19:15:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @dunya 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.289	{}
310	SURC Research Activity Announcement	surc-research-activity-announcement-310	2025-11-16 17:22:00	\N	seminar	f	Scientific Activity Announcement - spss ...	Scientific Activity Announcement - spss ( data analayse ) ( ,...spss,latex, xlstat,excel ) @Dunya & & 07806253125 _ _ # ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.292	{}
290	Panel Discussion: Artificial Intelligence & Cross-Disciplinary Research	panel-discussion-artificial-intelligence-cross-dis-290	2025-12-23 17:05:00	/images/events/fb/1371991651034174.jpg	seminar	f	Scientific Research Center...... . ...	Scientific Research Center...... . ...... President of Salahaddin University-Erbil- Erbil ......	Panel Discussion	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.273	{}
325	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-325	2025-10-01 08:19:00	/images/events/fb/1305915460975127.jpg	seminar	f	Scientific Research Center -Erbil - Date: 6/10/2025 18/12/2025. ...	Scientific Research Center -Erbil - Date: 6/10/2025 18/12/2025. : ‌(Hands-on Genomics and Proteomics Techniques Training) . :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.309	{}
330	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-330	2025-06-25 20:51:00	/images/events/fb/1230056168561057.jpg	seminar	f	Congratulatory Announcement: .... 1447 Scientific Research Center Salahaddin University-Erbil-Erbil ...	Congratulatory Announcement: .... 1447 Scientific Research Center Salahaddin University-Erbil-Erbil .... . .. Scientific Research Center Salahaddin University-Erbil - Erbil	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.313	{}
334	SURC Research Activity Announcement	surc-research-activity-announcement-334	2025-11-26 19:15:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @dunya 07806253125 _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.317	{}
293	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-293	2025-12-15 16:46:00	/images/events/fb/1366224038277602.jpg	seminar	f	Date: 15/12/2025 . ( ) ( ) , ( ) ( ) ...	Date: 15/12/2025 . ( ) ( ) , ( ) ( ) . ( ) Scientific Research Center - . …	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.276	{/images/events/fb/1366224044944268.jpg,/images/events/fb/1366224031610936.jpg,/images/events/fb/1366224111610928.jpg}
336	SURC Research Activity Announcement	surc-research-activity-announcement-336	2026-02-26 18:52:00	\N	seminar	f	Scientific Activity Announcement - 450 ...	Scientific Activity Announcement - 450 @Dunya & & 07806253125 _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.32	{}
294	SURC Research Activity Announcement	surc-research-activity-announcement-294	2026-01-26 18:18:00	\N	seminar	f	Scientific Activity Announcement - seminar 450 seminar...	Scientific Activity Announcement - seminar 450 seminar seminar seminar {{ }} Dunya hiwa & & 07806253125 ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.277	{}
355	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-355	2025-04-09 17:53:00	/images/events/fb/8737971079639078.jpg	seminar	f	Under official academic auspices at Salahaddin University-Erbil. Salahaddin University-Erbil- Erbil : 8-9/ 4/ 2025 ....	Under official academic auspices at Salahaddin University-Erbil. Salahaddin University-Erbil- Erbil : 8-9/ 4/ 2025 ....	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.338	{}
339	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-339	2025-07-11 09:08:00	/images/events/fb/1241777887388885.jpg	seminar	f	Scientific Research Center -Erbil ...	Scientific Research Center -Erbil (ArcGIS Pro for Climate & Seismic Data Processing, Analysis, and Visualization / Basic) Scientific Research Center GIS-Climate Change . . (7 – 10 2025) (ArcGIS Pro. 3.5). Scientific Research Center . :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.322	{/images/events/fb/1241777894055551.jpg,/images/events/fb/1241780237388650.jpg,/images/events/fb/1241780227388651.jpg}
357	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-357	2025-03-20 11:57:00	/images/events/fb/1159888378911170.jpg	seminar	f	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	... . .... . .. Scientific Research Center	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.339	{}
358	SURC Research Activity Announcement	surc-research-activity-announcement-358	2025-03-06 11:44:00	\N	seminar	f	Scientific Activity Announcement - Salahaddin University-Erbil Salahaddin University-Erbil AI ...	Scientific Activity Announcement - Salahaddin University-Erbil Salahaddin University-Erbil AI ..... Salahaddin University-Erbil SU.EDU.KRD Salahaddin University-Erbil	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.34	{}
392	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-392	2021-11-29 08:10:00	/images/events/fb/427581242141891.jpg	seminar	f	.. . Challenges in Article Publishing (CAP) Journal Types and Qualities Date:: 6-12-2021-- Time: 9:30 L...	.. . Challenges in Article Publishing (CAP) Journal Types and Qualities Date:: 6-12-2021-- Time: 9:30 Location:	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.371	{}
296	Publication Milestone: Climate Change Unit Research Paper	publication-milestone-climate-change-unit-research-296	2025-12-14 17:20:00	\N	seminar	f	The Environmental Monitoring and Climate Change Unit (EMCH) at the Scientific Research Center announces the official publication of its inaugural research paper focusing on regional environmental indicators and climate adaptability in Kurdistan.	The Environmental Monitoring and Climate Change Unit (EMCH) at the Scientific Research Center announces the official publication of its inaugural research paper focusing on regional environmental indicators and climate adaptability in Kurdistan.	Publication Announcement	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.279	{}
359	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-359	2025-03-03 19:36:00	/images/events/fb/1148161856750489.jpg	seminar	f	Saturday Date: 3/ 3/ 2025 ... ...	Saturday Date: 3/ 3/ 2025 ... 2024-2025 .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.341	{/images/events/fb/1148161876750487.jpg,/images/events/fb/1148161883417153.jpg,/images/events/fb/1148161980083810.jpg,/images/events/fb/1148161966750478.jpg}
362	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-362	2025-02-28 21:12:00	/images/events/fb/1146155836951091.jpg	seminar	f	: Scientific Research Center ‌ ‌ ‌...	: Scientific Research Center ‌ ‌ ‌ ‌. . ... Scientific Research Center	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.344	{/images/events/fb/1146156490284359.jpg}
365	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-365	2025-01-15 12:58:00	/images/events/fb/8252598261509698.jpg	symposium	f	Under official academic auspices at Salahaddin University-Erbil.	Under official academic auspices at Salahaddin University-Erbil. ( ). Time: 9:30 Date:: 16-1-2025 ( Saturday) Location: Salahaddin University-Erbil-Erbil/	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.346	{}
369	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-369	2024-11-22 09:59:00	/images/events/fb/7969181073184753.jpg	seminar	f	.. . ..... .. ...	.. . ..... .. . ... ....	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.35	{}
297	Research Capacity Building & Safety Training Course	research-capacity-building-safety-training-course-297	2025-12-10 09:40:00	/images/events/fb/1362462838653722.jpg	seminar	f	Wednesday 10/ 12/ 2025 SDS	Wednesday 10/ 12/ 2025 SDS	Training	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.28	{/images/events/fb/1362462811987058.jpg,/images/events/fb/1362462805320392.jpg,/images/events/fb/1362462871987052.jpg,/images/events/fb/1362462888653717.jpg}
299	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-299	2025-12-09 09:23:00	/images/events/fb/1361759238724082.jpg	seminar	f	‌ (Proteomics) .	‌ (Proteomics) .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.282	{/images/events/fb/1361759245390748.jpg,/images/events/fb/1361759275390745.jpg,/images/events/fb/1361759318724074.jpg}
397	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-397	2020-09-30 09:57:00	/images/events/fb/187430276156990.jpg	seminar	f	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.375	{/images/events/fb/187430282823656.jpg,/images/events/fb/187430299490321.jpg,/images/events/fb/187430292823655.jpg,/images/events/fb/187430342823650.jpg}
302	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-302	2025-12-01 21:35:00	/images/events/fb/1356491695917503.jpg	seminar	f	Date: 05 " Scientific Research Center" ".. " Scientific Research Center " ...	Date: 05 " Scientific Research Center" ".. " Scientific Research Center " " ".. "". " " " " " . .	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.284	{/images/events/fb/1356492502584089.jpg,/images/events/fb/1356492515917421.jpg,/images/events/fb/1356492542584085.jpg,/images/events/fb/1356492582584081.jpg}
303	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-303	2025-12-01 08:09:00	/images/events/fb/1356036869296319.jpg	seminar	f	(Proteomics) ‌ : 9-12-2025 .	(Proteomics) ‌ : 9-12-2025 .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.285	{}
322	SURC Research Activity Announcement	surc-research-activity-announcement-322	2026-03-05 17:47:00	\N	seminar	f	Scientific Activity Announcement - seminar ...	Scientific Activity Announcement - seminar @Dunya & & 07806253125 _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.305	{}
409	SURC Research Activity Announcement	surc-research-activity-announcement-409	2020-02-05 20:51:00	/images/events/fb/108937134006305.jpg	seminar	f	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.388	{}
410	SURC Research Activity Announcement	surc-research-activity-announcement-410	1970-01-01 00:00:00	\N	seminar	f	Scientific Activity Announcement - Born on February 5, 1977	Scientific Activity Announcement - Born on February 5, 1977	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.388	{}
308	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-308	2025-11-24 10:16:00	/images/events/fb/1351090473124292.jpg	seminar	f	Under official academic auspices at Salahaddin University-Erbil. ...	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center - Salahaddin University-Erbil–Erbil : Geospatial Solutions for Environmental Sustainability and Water Security Symposium. (GIS Day 2025). ( - - ) (. – – ) (... – ) (... – ) 300 . : : .. . – Scientific Research Center -Erbil. : - .. . – - : Applications of GIS for Climate Change & Environmental Management - . . – - : Role of Geospatial Technology (GIS) in Water Resource Management - . – – : Geoinformatics-Based Automated Landform Classification and Analysis of Their Relationship with Landslide Susceptibility in Akre District, Kurdistan Region, Iraq. (GIS) . GIS DAY/ ESRI : Salahaddin University-Erbil .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.29	{/images/events/fb/1351090896457583.jpg,/images/events/fb/1351090433124296.jpg,/images/events/fb/1351090813124258.jpg,/images/events/fb/1351090486457624.jpg}
309	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-309	2025-11-24 10:16:00	/images/events/fb/1351090473124292.jpg	symposium	f	Under official academic auspices at Salahaddin University-Erbil. ...	Under official academic auspices at Salahaddin University-Erbil. Scientific Research Center - Salahaddin University-Erbil–Erbil : Geospatial Solutions for Environmental Sustainability and Water Security Symposium. (GIS Day 2025). ( - - ) (. – – ) (... – ) (... – ) 300 . : : .. . – Scientific Research Center -Erbil. : - .. . – - : Applications of GIS for Climate Change & Environmental Management - . . – - : Role of Geospatial Technology (GIS) in Water Resource Management - . – – : Geoinformatics-Based Automated Landform Classification and Analysis of Their Relationship with Landslide Susceptibility in Akre District, Kurdistan Region, Iraq. (GIS) . GIS DAY/ ESRI : Salahaddin University-Erbil .	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.291	{/images/events/fb/1351090896457583.jpg,/images/events/fb/1351090433124296.jpg,/images/events/fb/1351090813124258.jpg,/images/events/fb/1351090486457624.jpg}
351	Panel Discussion: Artificial Intelligence & Cross-Disciplinary Research	panel-discussion-artificial-intelligence-cross-dis-351	2025-04-18 07:49:00	/images/events/fb/1181534730079868.jpg	seminar	f	: . Scientific Research Center ( ...	: . Scientific Research Center ( ). : Saturday 19/ 4/ 2025. Time: 5 . Location: . .	Panel Discussion	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.334	{}
312	SURC Research Activity Announcement	surc-research-activity-announcement-312	2026-01-07 16:06:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @dunya 07806253125 _ _ # ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.294	{}
313	SURC Research Activity Announcement	surc-research-activity-announcement-313	2025-11-26 19:15:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @dunya 07806253125 _ _ # ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.295	{}
314	World Environment Day Symposium: Climate Change Initiatives	world-environment-day-symposium-climate-change-ini-314	2025-11-18 19:39:00	/images/events/fb/1346902386876434.jpg	symposium	f	Under official academic auspices at Salahaddin University-Erbil.	Under official academic auspices at Salahaddin University-Erbil. (GIS Day 2025): : Geospatial Solutions for Environmental Sustainability and Water Security Symposium. (GIS) . : - : . . . - . : Applications of GIS for Climate Change & Environmental Management. - . : Role of Geospatial Technology (GIS) in Water Resource Management. - - . : Automated Landform Classification and Landslide Susceptibility mapping improve disaster preparedness and land management practices. . : . : Saturday 23 2025 Location: - Salahaddin University-Erbil–Erbil Time: 10:00 – 11:30 Under the supervision of Professor Dr. Kamaran Younis M. Amin the president of Salahaddin university-Erbil, The Environmental Monitoring and Climate Change Unit at the General Directorate of Scientific Research Center - Salahaddin University–Erbil (SURC). On World GIS Day is pleased to announce organizing of a Symposium in Title of: GIS Day Symposium 2025: Geospatial Solutions for Environmental Sustainability and Water Security. This symposium will bring together academic experts, university leadership, postgraduate and undergraduate students, and key decision-makers from various KRG ministries to highlight the critical role of Geographic Information Systems (GIS) and Remote Sensing in addressing today’s environmental and water-related challenges. The event will feature Three invited speakers presenting research and applied case studies on:  Moderator: Asst. Prof. Dr. Huner Khayyat 1. Dr. Heman Abdulkhaleq Gaznayee Applications of GIS for Climate Change & Environmental Management. 2. Prof. Dr. Tahseen Abdulraheem The Role of Geospatial Technology (GIS) in Water Resource Management. 3. Dr. Kaiwan K. Fatah Automated Landform Classification and Landslide Susceptibility Mapping improve disaster preparedness and land management practices. This event represents an important platform for exchanging knowledge, strengthening collaboration between academic and government institutions, and highlighting the growing impact of geospatial technologies in environmental monitoring and climate resilience. We warmly invite academic staff, researchers, students, and representatives of governmental and non-governmental organizations to attend and participate. Note: Registration is free and All attendees will receive an official Certificate of Attendance upon completion of the symposium. To register: Please click the link below: Date: Sunday, 23 November 2025 Venue: Cultural & Academic Center - Salahaddin University–Erbil Time: 10:00 AM – 11:30 AM	Symposium	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.296	{}
371	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-371	2024-11-03 17:07:00	/images/events/fb/1067623944804281.jpg	seminar	f	Scientific Research Center Salahaddin University-Erbil-Erbil :-	Scientific Research Center Salahaddin University-Erbil-Erbil :-	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.352	{}
316	SURC Research Activity Announcement	surc-research-activity-announcement-316	1970-01-01 00:00:00	\N	seminar	f	Scientific Activity Announcement - seminar. ...	Scientific Activity Announcement - seminar. : | | : – seminar – - - - - - - . ‏ ‏ ‏ ! ‏ ! ‏ ! ‏ ! 07806252125 @dunya : - FIB - _ _ # ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.298	{}
324	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-324	2025-10-01 08:19:00	/images/events/fb/1305915460975127.jpg	seminar	f	Scientific Research Center -Erbil - Date: 6/10/2025 18/12/2025. ...	Scientific Research Center -Erbil - Date: 6/10/2025 18/12/2025. : ‌(Hands-on Genomics and Proteomics Techniques Training) . :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.307	{}
317	SURC Research Activity Announcement	surc-research-activity-announcement-317	2026-02-26 18:52:00	\N	seminar	f	Scientific Activity Announcement - 450 ...	Scientific Activity Announcement - 450 @Dunya & & 07806253125 _ _ # ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.3	{}
323	SURC Research Activity Announcement	surc-research-activity-announcement-323	2025-12-25 16:01:00	\N	seminar	f	Scientific Activity Announcement - 500 ...	Scientific Activity Announcement - 500 ( ) @Dunya & & 07806253125 _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.306	{}
327	SURC Research Activity Announcement	surc-research-activity-announcement-327	1970-01-01 00:00:00	\N	seminar	f	Scientific Activity Announcement - seminar. ...	Scientific Activity Announcement - seminar. : | | : – seminar – - - - - - - . ‏ ‏ ‏ ! ‏ ! ‏ ! ‏ ! 07806252125 @dunya : - FIB - ‏‎ _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.31	{}
342	SURC Research Activity Announcement	surc-research-activity-announcement-342	2025-05-20 17:25:00	/images/events/fb/9036722983097218.jpg	seminar	f	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	Official scientific research announcement and academic activity at Salahaddin University-Erbil Research Center.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.325	{}
326	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-326	2025-09-26 18:04:00	/images/events/fb/10005100612926112.jpg	seminar	f	Saturday 29/ 9/ 2025 .....	Saturday 29/ 9/ 2025 .....	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.309	{}
328	SURC Research Activity Announcement	surc-research-activity-announcement-328	2025-11-04 05:19:00	\N	seminar	f	Scientific Activity Announcement - Director General of Scientific Research Center Salahaddin University-Erbil-Erbil . YOUTUBE...	Scientific Activity Announcement - Director General of Scientific Research Center Salahaddin University-Erbil-Erbil . YOUTUBE.COM Erbil	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.311	{}
329	SURC Research Activity Announcement	surc-research-activity-announcement-329	2026-03-05 17:47:00	\N	seminar	f	Scientific Activity Announcement - seminar ...	Scientific Activity Announcement - seminar @Dunya & & 07806253125	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.312	{}
348	Interdisciplinary Panel Discussion: "Interdisciplinary Research and th	interdisciplinary-panel-discussion-interdisciplina-348	2026-06-05 13:31:00	\N	seminar	f	Interdisciplinary Panel Discussion: "Interdisciplinary Research and the Role of Artificial Intelligence in Future Scientific Discoveries", highlighting AI models, data analytics, and cross-domain research integration at Salahaddin University-Erbil.	Interdisciplinary Panel Discussion: "Interdisciplinary Research and the Role of Artificial Intelligence in Future Scientific Discoveries", highlighting AI models, data analytics, and cross-domain research integration at Salahaddin University-Erbil.	Panel Discussion	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.33	{}
352	Congratulatory Announcement: .....	congratulatory-announcement-352	2025-04-14 16:42:00	/images/events/fb/1178909107009097.jpg	seminar	f	Congratulatory Announcement: ..... Scientific Research Center 19 . ...	Congratulatory Announcement: ..... Scientific Research Center 19 . .... ... .... ... .. Scientific Research Center	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.335	{}
331	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-331	2025-06-15 13:22:00	/images/events/fb/9216465771789604.jpg	seminar	f	Saturday Date: 15/6/2025 Scientific Research Center Salahaddin University-Erbil-Erbil (. ) ...	Saturday Date: 15/6/2025 Scientific Research Center Salahaddin University-Erbil-Erbil (. ) Scientific Research Center Salahaddin University-Erbil-Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.314	{}
332	SURC Research Activity Announcement	surc-research-activity-announcement-332	1970-01-01 00:00:00	\N	seminar	f	Scientific Activity Announcement - seminar. ...	Scientific Activity Announcement - seminar. : | | : – seminar – - - - - - - . ‏ ‏ ‏ ! ‏ ! ‏ ! ‏ ! 07806252125 @dunya : - FIB - _ _ # ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.315	{}
381	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-381	2022-11-28 08:26:00	/images/events/fb/662532131980133.jpg	workshop	f	//English : .. Scientific Research Center ...	//English : .. Scientific Research Center : (Student Projects and Research Challenges (SPARC)) Saturday 29-11-2022 . 9:30 .. : : - 10 . - . : - : Student Projects and Research Challenges (SPARC) 29-11-2022 . - 9:30 : - 10000 . ⁃ . English ‏Student graduation project is an important gate toward knowledge building of students. However challenges and obstacles are to be considered. Thus, The General Directorate of Scientific Research Center at Salahaddin University in partnership with the College of Education and The Directorate of Quality Assurance are to organize a national workshop entitled: ‏ Student Projects and Research Challenges (SPARC) That will be presented by best researchers and academicians of Salahaddin University-Erbil. On Tuesday , November 29th, 2022 at Dr. Khaled SaeedHall at the College of Law of Salahaddin University-Erbil at 9:00 am. ‏Notes: ‏- Due to limited number of seats, online pre-registration is required to ensure your participation. Kindly register through the following link: ‏- Participation fee including access to all sessions and tea break services is 10,000 IQD only. ‏- Certificate of attendance and participation will be given to the participants at the end of the workshop by the registration desk.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.36	{}
335	SURC Research Activity Announcement	surc-research-activity-announcement-335	2026-03-05 17:47:00	\N	seminar	f	Scientific Activity Announcement - seminar ...	Scientific Activity Announcement - seminar @Dunya & & 07806253125 _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.319	{}
337	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-337	2025-09-01 21:13:00	/images/events/fb/1282244556675551.jpg	seminar	f	2025-2026 Date: 1-9-2025 ( ) ...	2025-2026 Date: 1-9-2025 ( ) .	Meeting	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.32	{/images/events/fb/1282245113342162.jpg}
338	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-338	2025-07-13 20:25:00	/images/events/fb/122151381458784277.jpg	seminar	f	. Salahaddin University Research Center Emad Balisany -Baha Printing " ...	. Salahaddin University Research Center Emad Balisany -Baha Printing " " :…	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.321	{}
340	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-340	2025-06-10 18:48:00	/images/events/fb/9183646881738160.jpg	seminar	f	Saturday Date: 10/ 6/ 2025 ... . / . ...	Saturday Date: 10/ 6/ 2025 ... . / . (2025-2026) .... ....	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.323	{/images/events/fb/9183647015071480.jpg}
341	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-341	2025-05-25 20:06:00	/images/events/fb/9071669106269272.jpg	seminar	f	.... 25/ 5/ 2025 .... 15/ 5/ 2025 Salahaddi...	.... 25/ 5/ 2025 .... 15/ 5/ 2025 Salahaddin University Research Center ....	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.324	{/images/events/fb/9071669276269255.jpg}
345	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-345	2025-05-10 19:59:00	/images/events/fb/8957317817704402.jpg	seminar	f	( ) Under official academic auspices at Salahaddin University-Erbil.	( ) Under official academic auspices at Salahaddin University-Erbil. . ....	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.327	{}
347	Panel Discussion: Artificial Intelligence & Cross-Disciplinary Research	panel-discussion-artificial-intelligence-cross-dis-347	2025-04-19 18:14:00	/images/events/fb/1150535197086656.jpg	seminar	f	Salahaddin University Research Center Salahaddin University-Erbil " " …	Salahaddin University Research Center Salahaddin University-Erbil " " …	Panel Discussion	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.329	{/images/events/fb/1150535263753316.jpg,/images/events/fb/1150535340419975.jpg,/images/events/fb/1150535327086643.jpg,/images/events/fb/1150535210419988.jpg}
350	Panel Discussion: Artificial Intelligence & Cross-Disciplinary Research	panel-discussion-artificial-intelligence-cross-dis-350	2025-04-18 07:49:00	/images/events/fb/1181534730079868.jpg	seminar	f	: . Scientific Research Center ( ...	: . Scientific Research Center ( ). : Saturday 19/ 4/ 2025. Time: 5 . Location: . .	Panel Discussion	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.333	{}
388	SURC Research Activity Announcement	surc-research-activity-announcement-388	2020-04-11 20:37:00	\N	seminar	f	Scientific Activity Announcement - Karzan Shekh Muhsin Barzinji : !! : .. : ...	Scientific Activity Announcement - Karzan Shekh Muhsin Barzinji : !! : .. : : .. : 100‏!! : .. : ! : .. : ! : .. : BCG 19!! : .. :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.367	{}
349	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-349	2025-04-19 07:24:00	/images/events/fb/1182237460009595.jpg	seminar	f	Scientific Activity: Scientific Research Center (4) ...	Scientific Activity: Scientific Research Center (4) ( ) Research Ethics. ( ) . ( ) . :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.331	{}
360	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-360	2025-03-03 19:39:00	/images/events/fb/1148168663416475.jpg	seminar	f	Saturday Date: 3/ 3/ 2025 ... ...	Saturday Date: 3/ 3/ 2025 ... 2024-2025 .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.342	{/images/events/fb/1148168676749807.jpg,/images/events/fb/1148168650083143.jpg}
389	SURC Research Activity Announcement	surc-research-activity-announcement-389	2020-04-08 12:57:00	\N	seminar	f	Scientific Activity Announcement - SU.EDU.KRD Salahaddin University-Erbil	Scientific Activity Announcement - SU.EDU.KRD Salahaddin University-Erbil	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.368	{}
390	SURC Research Activity Announcement	surc-research-activity-announcement-390	2020-03-18 19:54:00	\N	seminar	f	Scientific Activity Announcement - KURDISTAN24.NET	Scientific Activity Announcement - KURDISTAN24.NET	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.369	{}
354	Seminar: Phenomenology of Perception in Management	seminar-phenomenology-of-perception-in-management-354	2025-04-14 09:40:00	/images/events/fb/1178647680368573.jpg	seminar	f	( ) Saturday Date: 14/ 4/ 2025 .. Scientific Research Center ...	( ) Saturday Date: 14/ 4/ 2025 .. Scientific Research Center Scientific Research Center ( ... ... « » . .	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.337	{/images/events/fb/1178647673701907.jpg,/images/events/fb/1178647690368572.jpg,/images/events/fb/1178647750368566.jpg,/images/events/fb/1178647767035231.jpg}
366	SUE Research Center	sue-research-center-366	2025-01-07 17:39:00	/images/events/fb/1015464253930276.jpg	seminar	f	SUE Research Center Under official academic auspices at Salahaddin University-Erbil.	SUE Research Center Under official academic auspices at Salahaddin University-Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.348	{}
367	SURC Research Activity Announcement	surc-research-activity-announcement-367	2024-12-16 20:21:00	\N	seminar	f	Scientific Activity Announcement - 17/ 12/ 2024 ...	Scientific Activity Announcement - 17/ 12/ 2024 ...	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.348	{}
368	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-368	2024-12-03 10:52:00	/images/events/fb/1042568531216657.jpg	seminar	f	Salahaddin University Research Center ... Salahaddin University-Erbil Salahaddin University-Erbil …	Salahaddin University Research Center ... Salahaddin University-Erbil Salahaddin University-Erbil …	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.349	{/images/events/fb/1042568731216637.jpg,/images/events/fb/1042568611216649.jpg,/images/events/fb/1042568774549966.jpg,/images/events/fb/1042569024549941.jpg}
373	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-373	2024-10-13 21:03:00	/images/events/fb/954631533346882.jpg	seminar	f	Scientific Activity: 2024-2025 Salahaddin University Research Center ..... SUE Research Center President of Salahaddin University-Erbil- Erbil ...	Scientific Activity: 2024-2025 Salahaddin University Research Center ..... SUE Research Center President of Salahaddin University-Erbil- Erbil Erbil …	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.353	{/images/events/fb/954631830013519.jpg,/images/events/fb/954631953346840.jpg,/images/events/fb/954632050013497.jpg,/images/events/fb/954632190013483.jpg}
376	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-376	2024-09-06 10:30:00	/images/events/fb/1027168895516453.jpg	symposium	f	President of Salahaddin University-Erbil- Erbil Scientific Research Center Erbil ...	President of Salahaddin University-Erbil- Erbil Scientific Research Center Erbil Thursday 2024/9/5 .	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.356	{/images/events/fb/1027168935516449.jpg,/images/events/fb/1027168982183111.jpg,/images/events/fb/1027169012183108.jpg,/images/events/fb/1027169262183083.jpg}
377	SURC Research Activity Announcement	surc-research-activity-announcement-377	2024-05-25 11:28:00	/images/events/fb/965090398390970.jpg	seminar	f	: . Location: Scientific Research Center Date:: 26- 5 -2024-- : 10:00	: . Location: Scientific Research Center Date:: 26- 5 -2024-- : 10:00	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.357	{}
380	SURC Research Activity Announcement	surc-research-activity-announcement-380	2023-02-05 05:42:00	\N	seminar	f	Scientific Activity Announcement -	Scientific Activity Announcement -	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.359	{}
391	SURC Research Activity Announcement	surc-research-activity-announcement-391	2021-12-06 09:59:00	/images/events/fb/431692945064054.jpg	seminar	f	Principles of cancer screening ... / Scientific Research Center Date:/7-12-2021 -- / 10:30	Principles of cancer screening ... / Scientific Research Center Date:/7-12-2021 -- / 10:30	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.37	{}
375	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-375	2024-09-30 14:20:00	/images/events/fb/7632885360147661.jpg	seminar	f	Salahaddin University Research Center Saturday Date: 2024/9/30 (9) ( ) ...	Salahaddin University Research Center Saturday Date: 2024/9/30 (9) ( ) Erbil Scientific Research Center (... ) (3) .	Workshop	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.355	{/images/events/fb/7632885483480982.jpg,/images/events/fb/7632885703480960.jpg,/images/events/fb/7632885893480941.jpg,/images/events/fb/7632886116814252.jpg}
384	SURC Research Activity Announcement	surc-research-activity-announcement-384	2022-01-09 09:41:00	/images/events/fb/451970799702935.jpg	seminar	f	Genetics of ADHD (attention deficit hyperactivity) . . / Scientific Research Center Date:/ 11-1-2022 -- / 10:30	Genetics of ADHD (attention deficit hyperactivity) . . / Scientific Research Center Date:/ 11-1-2022 -- / 10:30	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.363	{}
385	SURC Research Activity Announcement	surc-research-activity-announcement-385	2021-12-20 06:14:00	/images/events/fb/440093524223996.jpg	seminar	f	Epidemiology of Colon Cancer . / Scientific Research Center Date:/ 21-12-2021 -- / 10:30	Epidemiology of Colon Cancer . / Scientific Research Center Date:/ 21-12-2021 -- / 10:30	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.364	{}
387	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-387	2021-12-06 15:42:00	/images/events/fb/453139899580921.jpg	seminar	f	Salahaddin University Research Center SUE Research Center Principles of cancer screening…	Salahaddin University Research Center SUE Research Center Principles of cancer screening…	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.366	{}
401	SURC Research Activity Announcement	surc-research-activity-announcement-401	2020-02-05 20:45:00	/images/events/fb/108931907340161.jpg	seminar	f	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.38	{}
402	SURC Research Activity Announcement	surc-research-activity-announcement-402	2020-03-15 19:03:00	\N	seminar	f	Scientific Activity Announcement - PUBS.RSNA.ORG Correlation of Chest CT and RT-PCR Testing in Coronavirus Disease 2019 (COVID-19) in China: A Report of 1014 Cases | Radiology Background Chest CT is used for diagnosis of 2019 novel coronavirus d...	Scientific Activity Announcement - PUBS.RSNA.ORG Correlation of Chest CT and RT-PCR Testing in Coronavirus Disease 2019 (COVID-19) in China: A Report of 1014 Cases | Radiology Background Chest CT is used for diagnosis of 2019 novel coronavirus disease (COVID-19), as an important complement to the reverse-transcription polymerase chain reaction (RT-PCR) tests. Purpose To ...	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.381	{}
403	SURC Research Activity Announcement	surc-research-activity-announcement-403	2020-03-15 19:03:00	\N	seminar	f	Scientific Activity Announcement - : : 3 . : : 1 ...	Scientific Activity Announcement - : : 3 . : : 1 3 9 .. : : 1-9 . : : .. .. -19. : 14 : 1‏ 14 .. : : 15 RNA . : : rt-PCR RNA CT Scan . : rt-PCR : 1- . 2- primer . 3- . 1- . 2- CT Scan . : : 20 30 . : 2 S L : . . . : : . 80 . . : : . : : .. .... .. . .. ... Director General of - :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.382	{}
404	Karzan Shekh Muhsin Barzinji	karzan-shekh-muhsin-barzinji-404	2020-03-15 19:02:00	/images/events/fb/2587166348163380.jpg	seminar	f	Karzan Shekh Muhsin Barzinji - …	Karzan Shekh Muhsin Barzinji - …	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.383	{/images/events/fb/2587215431491805.jpg}
407	Karzan Shekh Muhsin Barzinji	karzan-shekh-muhsin-barzinji-407	2020-03-15 19:00:00	/images/events/fb/2584129565133725.jpg	seminar	f	Karzan Shekh Muhsin Barzinji	Karzan Shekh Muhsin Barzinji	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.386	{}
408	SURC Research Activity Announcement	surc-research-activity-announcement-408	2020-03-14 19:10:00	\N	seminar	f	Scientific Activity Announcement - ........	Scientific Activity Announcement - ........	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.387	{}
249	Applied Workshop: Livestock Breeding & Management	applied-workshop-livestock-breeding-management-249	2026-04-19 09:29:00	/images/events/fb/1463186035248068.jpg	workshop	f	Salahaddin University Research Center Scientific Activity: : Scientific Research Center/ . - Erbil scientific applied workshop « » ...	Salahaddin University Research Center Scientific Activity: : Scientific Research Center/ . - Erbil scientific applied workshop « » Erbil Erbil. Date:: 20-4-2026 / Saturday Time: 9 Location: Salahaddin University-Erbil-Erbil. :	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.229	{}
256	SURC Research Activity Announcement	surc-research-activity-announcement-256	2026-02-26 18:52:00	\N	seminar	f	Scientific Activity Announcement - 450 ...	Scientific Activity Announcement - 450 @Dunya & & 07806253125 ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.237	{}
280	SURC Research Activity Announcement	surc-research-activity-announcement-280	2026-01-21 16:03:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - & & & 07806253125 @dunya ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.263	{}
301	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-301	2025-12-05 10:11:00	/images/events/fb/1358945685672104.jpg	seminar	f	Scientific Research Center (.. ) .... . . Scien...	Scientific Research Center (.. ) .... . . Scientific Research Center	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.284	{}
306	SURC Research Activity Announcement	surc-research-activity-announcement-306	2025-11-18 15:55:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @Dunya & & 07806253125 _ _ # ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.289	{}
289	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-289	2025-12-24 21:21:00	/images/events/fb/1372818824284790.jpg	seminar	f	Date: 405 " -Erbil" ".. " ".. " ...	Date: 405 " -Erbil" ".. " ".. " ".. " " " "... " " " ".. " Scientific Research Center" "Hands on Genomics and Proteomics" . Scientific Research Center . ".. " Scientific Research Center 05 . .	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.272	{/images/events/fb/1372818974284775.jpg,/images/events/fb/1372818957618110.jpg,/images/events/fb/1372819094284763.jpg,/images/events/fb/1372819080951431.jpg}
405	SURC Research Activity Announcement	surc-research-activity-announcement-405	2026-06-05 13:31:00	\N	seminar	f	Scientific Activity Announcement - Salahaddin University-Erbil . . " " ‏	Scientific Activity Announcement - Salahaddin University-Erbil . . " " ‏	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.384	{}
321	SURC Research Activity Announcement	surc-research-activity-announcement-321	2025-11-26 19:15:00	\N	seminar	f	Scientific Activity Announcement - ...	Scientific Activity Announcement - @dunya 07806253125 _ _ # ‏‎ ‏‎ ‏‎ ‏‎ ‏‎	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.303	{}
386	SURC Research Activity Announcement	surc-research-activity-announcement-386	2021-12-11 10:47:00	/images/events/fb/434670491432966.jpg	seminar	f	( -19) ( . ) . Location: Scientific Research Center Date:: 14/12.202...	( -19) ( . ) . Location: Scientific Research Center Date:: 14/12.2021 Time: 10:30	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.365	{}
356	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-356	2025-04-06 21:22:00	/images/events/fb/1083597453783622.jpg	seminar	f	Scientific Activity: Salahaddin University Research Center .... ... SUE Research Center ...	Scientific Activity: Salahaddin University Research Center .... ... SUE Research Center Scientific Research Center ( )…	Seminar	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.338	{/images/events/fb/1083637340446300.jpg}
372	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-372	2024-10-15 20:53:00	/images/events/fb/7760889294013933.jpg	seminar	f	15 / 10 / 2024 190 Salahaddin University Research Center	15 / 10 / 2024 190 Salahaddin University Research Center	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.353	{/images/events/fb/7760889430680586.jpg,/images/events/fb/7760889554013907.jpg,/images/events/fb/7760889664013896.jpg,/images/events/fb/7760889804013882.jpg}
379	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-379	2023-12-04 15:33:00	/images/events/fb/788845633255616.jpg	seminar	f	Salahaddin University Research Center Salahaddin University-Erbil ‌‌ ‌‌ ‌‌‌ .…	Salahaddin University Research Center Salahaddin University-Erbil ‌‌ ‌‌ ‌‌‌ .…	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.358	{/images/events/fb/788845809922265.jpg,/images/events/fb/788845769922269.jpg,/images/events/fb/788845909922255.jpg,/images/events/fb/788845879922258.jpg}
395	Salahaddin University Scientific Research Activity	salahaddin-university-scientific-research-activity-395	2020-10-22 16:34:00	/images/events/fb/2779000258979987.jpg	seminar	f	- (mouth wash) . - . - ...	- (mouth wash) . - . - . - . - 2 15 .. - . - .. .. - 2 : 1- .2- . - . - .. . .. Salahaddin University Research Center Photo from . Bioworld.com	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.373	{}
399	SURC Research Activity Announcement	surc-research-activity-announcement-399	2020-03-15 19:13:00	/images/events/fb/130697918496893.jpg	seminar	f	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Scientific Activity Announcement - Research Center activity & scientific development event at Salahaddin University-Erbil.	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.377	{}
400	Karzan Shekh Muhsin Barzinji	karzan-shekh-muhsin-barzinji-400	2020-03-15 19:04:00	/images/events/fb/2588031391410209.jpg	seminar	f	Karzan Shekh Muhsin Barzinji R0…	Karzan Shekh Muhsin Barzinji R0…	Research Activity	10:00 AM - 01:00 PM	SURC	f	2026-09-01 23:57:38.379	{}
\.


--
-- Data for Name: Form; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Form" (id, title, category, description, "filePath", "fileFormat", "fileSize", icon, draft, "createdAt", "formType", "subCategory") FROM stdin;
4	Application Form for Animal Research Ethics Committee (AREC)	Ethics	Required application for research involving laboratory or experimental animals under the 3Rs principles.	/forms/SUE_Animal_Resaerch_Form.docx	DOCX	\N	fas fa-paw	f	2026-09-01 19:48:01.08	ethics_animal	\N
5	Application Form for Botanical Research Ethics Review	Ethics	Review form for botanical collection, plant protection, environmental risk, and biodiversity research.	/forms/SUE_Botanical_Resaerch_Form.docx	DOCX	\N	fas fa-leaf	f	2026-09-01 19:48:01.081	ethics_botanical	\N
6	Application Form for Humanities and Law Research Ethics Committee	Ethics	Ethics review application for qualitative, social science, humanities, legal, and community-based research.	/forms/SUE_Humanities_and_Law_Research_Form.docx	DOCX	\N	fas fa-gavel	f	2026-09-01 19:48:01.082	ethics_humanities	\N
7	Teacher Research Plan Information Form (فۆرمی زانیاری پلانی توێژینەوەی مامۆستایان)	Proposals	Official template for university faculty and researchers submitting annual scientific research plans.	/forms/Reseach Proposal form.pdf	PDF	\N	fas fa-file-signature	f	2026-09-01 19:48:01.083	proposal	\N
8	Higher Education Student Guideline & Laboratory Usage Contract	Contracts	Laboratory safety regulations (40 rules), equipment usage agreement, and 300,000 IQD deposit requirements.	/policies/instructions & contract.pdf	PDF	\N	fas fa-file-contract	f	2026-09-01 19:48:01.085	contract	\N
9	Volunteer & External Placement Work Contract (ڕێککەوتنامەی خۆبەخش)	Contracts	Official terms of agreement for volunteer researchers and external seconded staff at SURC.	/policies/ڕێککەوتنامەی کارکردن بە خۆبەخش.pdf	PDF	\N	fas fa-handshake	f	2026-09-01 19:48:01.086	volunteer_contract	\N
3	Application Form for Human Research Ethics Review	Ethics	Ethical review form for projects involving prospective human participants, clinical trials, or medical data.	/forms/SUE_Human_Research_Form (2).docx	DOCX	\N	fas fa-user-shield	f	2026-09-01 19:48:01.077	ethics_human	\N
1	Research Proposal Application Form	Proposals	Standard application form for new research proposals and projects.	#	DOCX	500 KB	fas fa-file-alt	f	2026-07-21 01:17:49.989	proposal	\N
2	Forms and Templates	Proposals	Downloadable resources for research proposals, ethics applications, and official documentation for lab usage	#	DOCX	500 KB	fas fa-file-alt	f	2026-07-21 01:17:49.991	proposal	\N
\.


--
-- Data for Name: Lab; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Lab" (id, title, "shortName", location, "locationName", department, "departmentName", category, "categoryName", description, image, contact, "supervisorId", capacity, status, draft, platforms) FROM stdin;
agriculture-engineering-sciences-plant-protection-13	Agriculture Engineering Sciences – plant protection – 13	13	agriculture-engineering-sciences	Agriculture Engineering Sciences	plant-protection	plant protection	plant-protection	plant protection	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-plant-protection-13.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-plant-protection-14	Agriculture Engineering Sciences – plant protection – 14	14	agriculture-engineering-sciences	Agriculture Engineering Sciences	plant-protection	plant protection	plant-protection	plant protection	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-plant-protection-14.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-soil-and-water-lab-19	Agriculture Engineering Sciences – Soil and Water – Lab 19	Lab 19	agriculture-engineering-sciences	Agriculture Engineering Sciences	soil-and-water	Soil and Water	soil-and-water	Soil and Water	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-soil-and-water-lab-19.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-food-technology-lab-8	Agriculture Engineering Sciences – Food Technology – lab 8	lab 8	agriculture-engineering-sciences	Agriculture Engineering Sciences	food-technology	Food Technology	food-technology	Food Technology	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-food-technology-lab-8.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-horticulture-25-tissue-culture	Agriculture Engineering Sciences – Horticulture – 25- Tissue Culture	25- Tissue Culture	agriculture-engineering-sciences	Agriculture Engineering Sciences	horticulture	Horticulture	horticulture	Horticulture	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-horticulture-25-tissue-culture.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-food-technology-lab-9	Agriculture Engineering Sciences – Food technology – Lab 9	Lab 9	agriculture-engineering-sciences	Agriculture Engineering Sciences	food-technology	Food technology	food-technology	Food technology	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-food-technology-lab-9.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-plant-protection-11	Agriculture Engineering Sciences – plant protection – 11	11	agriculture-engineering-sciences	Agriculture Engineering Sciences	plant-protection	plant protection	plant-protection	plant protection	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-plant-protection-11.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-food-technology-grdarasha	Agriculture Engineering Sciences – Food Technology – Grdarasha	Grdarasha	agriculture-engineering-sciences	Agriculture Engineering Sciences	food-technology	Food Technology	food-technology	Food Technology	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-food-technology-grdarasha.jpg	\N	\N	N/A	active	f	\N
engineering-aviation-aviation-lab	Engineering – Aviation – Aviation Lab	Aviation Lab	engineering	Engineering	aviation	Aviation	aviation	Aviation	Laboratory equipped for teaching and experimental activities.	images/labs/engineering-aviation-aviation-lab.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-food-technology-lab-10	Agriculture Engineering Sciences – Food technology – Lab 10	Lab 10	agriculture-engineering-sciences	Agriculture Engineering Sciences	food-technology	Food technology	food-technology	Food technology	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-food-technology-lab-10.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-food-technology-lab23	Agriculture Engineering Sciences – Food Technology – Lab23	Lab23	agriculture-engineering-sciences	Agriculture Engineering Sciences	food-technology	Food Technology	food-technology	Food Technology	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-food-technology-lab23.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-plant-protection-12	Agriculture Engineering Sciences – plant protection – 12	12	agriculture-engineering-sciences	Agriculture Engineering Sciences	plant-protection	plant protection	plant-protection	plant protection	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-plant-protection-12.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-soil-and-water-lab-18	Agriculture Engineering Sciences – Soil and Water – Lab 18	Lab 18	agriculture-engineering-sciences	Agriculture Engineering Sciences	soil-and-water	Soil and Water	soil-and-water	Soil and Water	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-soil-and-water-lab-18.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-food-technology-lab-21	Agriculture Engineering Sciences – Food technology – Lab 21	Lab 21	agriculture-engineering-sciences	Agriculture Engineering Sciences	food-technology	Food technology	food-technology	Food technology	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-food-technology-lab-21.jpg	\N	\N	N/A	active	f	\N
education-chemistry-analytical-chem-lab	Education – Chemistry – Analytical Chem. Lab.	Analytical Chem. Lab.	education	Education	chemistry	Chemistry	chemistry	Chemistry	Laboratory equipped for teaching and experimental activities.	images/labs/education-chemistry-analytical-chem-lab.jpg	\N	\N	N/A	active	f	\N
education-chemistry-organic-chem-lab	Education – Chemistry – Organic Chem. Lab.	Organic Chem. Lab.	education	Education	chemistry	Chemistry	chemistry	Chemistry	Laboratory equipped for teaching and experimental activities.	images/labs/education-chemistry-organic-chem-lab.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad	Agriculture Engineering Sciences – Unknown – Poultry Lab.\nDr. Bnar Fuad	Poultry Lab.\nDr. Bnar Fuad	agriculture-engineering-sciences	Agriculture Engineering Sciences	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-unknown-poultry-lab-dr-bnar-fuad.jpg	\N	\N	N/A	active	f	\N
basic-education-general-science-biology	Basic Education – General Science – Biology	Biology	basic-education	Basic Education	general-science	General Science	general-science	General Science	Laboratory equipped for teaching and experimental activities.	images/labs/basic-education-general-science-biology.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-unknown-forestry-lab-lab-5	Agriculture Engineering Sciences – Unknown – Forestry Lab. (Lab.5)	Forestry Lab. (Lab.5)	agriculture-engineering-sciences	Agriculture Engineering Sciences	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-unknown-forestry-lab-lab-5.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen	Agriculture Engineering Sciences – Unknown – LAB 29\nDr. Edres Abdulla Hamadamen	LAB 29\nDr. Edres Abdulla Hamadamen	agriculture-engineering-sciences	Agriculture Engineering Sciences	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-unknown-lab-29-dr-edres-abdulla-hamadamen.jpg	\N	\N	N/A	active	f	\N
basic-education-general-science-chemistry	Basic Education – General Science – Chemistry	Chemistry	basic-education	Basic Education	general-science	General Science	general-science	General Science	Laboratory equipped for teaching and experimental activities.	images/labs/basic-education-general-science-chemistry.jpg	\N	\N	N/A	active	f	\N
education-chemistry-bio-chem-lab	Education – Chemistry – Bio Chem. Lab.	Bio Chem. Lab.	education	Education	chemistry	Chemistry	chemistry	Chemistry	Laboratory equipped for teaching and experimental activities.	images/labs/education-chemistry-bio-chem-lab.jpg	\N	\N	N/A	active	f	\N
education-chemistry-industrial-chem-lab	Education – Chemistry – Industrial Chem. Lab.	Industrial Chem. Lab.	education	Education	chemistry	Chemistry	chemistry	Chemistry	Laboratory equipped for teaching and experimental activities.	images/labs/education-chemistry-industrial-chem-lab.jpg	\N	\N	N/A	active	f	\N
education-chemistry-physical-chem-lab	Education – Chemistry – Physical Chem. Lab.	Physical Chem. Lab.	education	Education	chemistry	Chemistry	chemistry	Chemistry	Laboratory equipped for teaching and experimental activities.	images/labs/education-chemistry-physical-chem-lab.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan	Agriculture Engineering Sciences – Unknown – Nutrition Lab.code : D5\nAssist.Prof.Dr. suzan	Nutrition Lab.code : D5\nAssist.Prof.Dr. suzan	agriculture-engineering-sciences	Agriculture Engineering Sciences	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-unknown-nutrition-lab-code-d5-assist-prof-dr-suzan.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-soil-and-water-lab7	Agriculture Engineering Sciences – Soil and Water – Lab7	Lab7	agriculture-engineering-sciences	Agriculture Engineering Sciences	soil-and-water	Soil and Water	soil-and-water	Soil and Water	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-soil-and-water-lab7.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf	Agriculture Engineering Sciences – Unknown – biotechnologyLab.code : D9\nProf.Dr.yusouf	biotechnologyLab.code : D9\nProf.Dr.yusouf	agriculture-engineering-sciences	Agriculture Engineering Sciences	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-unknown-biotechnologylab-code-d9-prof-dr-yusouf.jpg	\N	\N	N/A	active	f	\N
education-chemistry-inorganic-chem-lab	Education – Chemistry – Inorganic Chem. Lab.	Inorganic Chem. Lab.	education	Education	chemistry	Chemistry	chemistry	Chemistry	Laboratory equipped for teaching and experimental activities.	images/labs/education-chemistry-inorganic-chem-lab.jpg	\N	\N	N/A	active	f	\N
basic-education-general-science-physics-lab	Basic Education – General Science – Physics Lab	Physics Lab	basic-education	Basic Education	general-science	General Science	general-science	General Science	Laboratory equipped for teaching and experimental activities.	images/labs/basic-education-general-science-physics-lab.jpg	\N	\N	N/A	active	f	\N
molecular-engineering	Molecular Engineering Laboratory	MEL	Building B, 1st Floor, Room 102	Research Center Main Campus, Erbil	molecular-engineering-and-cancer-biology	Molecular Engineering & Cancer Biology Unit	Molecular Engineering	Biotechnology & Genetic Engineering	Specialized facility for recombinant protein expression, genetic engineering, synthetic biology, and molecular vector construction.	/images/labs/lab-engineering.svg	\N	dr-suhad-mustafa	20	ACTIVE	f	{"Genetic Engineering","Recombinant DNA","Protein Expression","Cloning & Vector Construction"}
chemical-analysis	Chemical Analysis Laboratory	CAL	Building A, Ground Floor, Room 10	Research Center Main Campus, Erbil	environmental-monitoring-and-climate-change-unit-emccu	Environmental Monitoring & Climate Change Unit	Analytical Chemistry	Chemical & Environmental Analysis	Equipped with precision spectroscopy, chromatography, and elemental analysis instruments for soil, water, food, and environmental chemistry samples.	/images/labs/lab-chemistry.svg	\N	\N	30	ACTIVE	f	{Spectrophotometry,Chromatography,"Heavy Metal Analysis","Water & Soil Quality"}
agriculture-engineering-sciences-soil-and-water-lab-20	Agriculture Engineering Sciences – Soil and Water – Lab 20	Lab 20	agriculture-engineering-sciences	Agriculture Engineering Sciences	soil-and-water	Soil and Water	soil-and-water	Soil and Water	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-soil-and-water-lab-20.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-soil-and-water-lab1	Agriculture Engineering Sciences – Soil and Water – Lab1	Lab1	agriculture-engineering-sciences	Agriculture Engineering Sciences	soil-and-water	Soil and Water	soil-and-water	Soil and Water	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-soil-and-water-lab1.jpg	\N	\N	N/A	active	f	\N
research-center-unknown-lab1	Research Center – Unknown – Lab1	Lab1	research-center	Research Center	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/research-center-unknown-lab1.jpg	\N	\N	N/A	active	f	\N
nanotechnology	Nanotechnology Laboratory	NTL	Building C, 1st Floor, Room 108	Research Center Main Campus, Erbil	data-analysis-unit	Data Analysis & AI Unit	Nanotechnology & Materials	Advanced Materials & Nanotechnology	Focuses on nanoparticle synthesis, characterization, targeted drug delivery vehicles, and advanced nanomaterial fabrication for biomedical and energy applications.	/images/labs/lab-engineering.svg	\N	\N	15	ACTIVE	f	{"Nanoparticle Synthesis","Material Characterization","Targeted Drug Delivery","Electron Microscopy"}
research-center-unknown-lab2	Research Center – Unknown – Lab2	Lab2	research-center	Research Center	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/research-center-unknown-lab2.jpg	\N	\N	N/A	active	f	\N
research-center-unknown-lab4	Research Center – Unknown – Lab4	Lab4	research-center	Research Center	unknown	Unknown	unknown	Unknown	Laboratory equipped for teaching and experimental activities.	images/labs/research-center-unknown-lab4.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-fish-resources-lab-33	Agriculture Engineering Sciences – Fish Resources – Lab 33	Lab 33	agriculture-engineering-sciences	Agriculture Engineering Sciences	fish-resources	Fish Resources	fish-resources	Fish Resources	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-fish-resources-lab-33.jpg	\N	\N	N/A	active	f	\N
agriculture-engineering-sciences-food-technology-department-higher-education-lab	Agriculture Engineering Sciences – Food Technology Department – Higher Education lab.	Higher Education lab.	agriculture-engineering-sciences	Agriculture Engineering Sciences	food-technology-department	Food Technology Department	food-technology-department	Food Technology Department	Laboratory equipped for teaching and experimental activities.	images/labs/agriculture-engineering-sciences-food-technology-department-higher-education-lab.jpg	\N	\N	N/A	active	f	\N
cancer-biology	Cancer Biology Laboratory	CBL	Building B, 2nd Floor, Room 204	Research Center Main Campus, Erbil	molecular-engineering-and-cancer-biology	Molecular Engineering & Cancer Biology Unit	Biomedical & Precision Oncology	Biomedical & Precision Oncology	The Cancer Biology Laboratory is equipped to support multidisciplinary research in molecular oncology, cancer cell biology, tumor microenvironment, experimental therapeutics, and translational cancer research.	/images/labs/lab-biology.svg	\N	dr-treska-hassan	25	ACTIVE	f	{"Cell Culture","Molecular Biology","Protein Analysis","Cell Imaging","Cancer Therapeutics & Drug Screening","Biomarker Discovery","Experimental Oncology","Sample Processing & Biobanking"}
\.


--
-- Data for Name: Project; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Project" (id, title, name, description, image, status, visibility, "unitId", year, "projectType", draft, "createdAt") FROM stdin;
advanced-neural-modeling-of-kurdish-handwritten-text	Advanced Neural Modeling of Kurdish Handwritten Text	Advanced Neural Modeling of Kurdish Handwritten Text	A project focused on deep learning classification models for low-resource Kurdish handwritten character recognition.	\N	ongoing	public	unit-agriculture	2026	AIIC Research Initiative	f	2026-07-24 14:39:15.93
project-community-engagement	Community Engagement Program	Community Engagement Program	Outreach program connecting research outcomes with community needs and stakeholders.	images/projects/community.jpg	ongoing	public	development-cooperation	2024	Funded Research	f	2026-07-21 01:17:49.228
project-climate-change-impact	Climate Change Impact Assessment	Climate Change Impact Assessment	Comprehensive study on climate change impacts on Kurdistan's ecosystems and agricultural systems.	images/projects/climate-change.jpg	ongoing	public	emccu	2024	Funded Research	f	2026-07-21 01:17:49.22
project-environmental-monitoring	Environmental Monitoring System	Environmental Monitoring System	Development of an integrated environmental monitoring system for real-time data collection.	images/projects/monitoring.jpg	ongoing	public	emccu	2024	Funded Research	f	2026-07-21 01:17:49.233
project-materials-science	Materials Science Innovation	Materials Science Innovation	Research on new materials for industrial applications and sustainable technologies.	images/projects/materials.jpg	completed	public	unit-chemistry	2023	Funded Research	f	2026-07-21 01:17:49.236
project-molecular-biology	Molecular Biology Research Initiative	Molecular Biology Research Initiative	Advanced molecular biology studies focusing on genetic research and biotechnological applications.	images/projects/molecular-bio.jpg	ongoing	public	unit-biology-life-sciences	2024	Funded Research	f	2026-07-21 01:17:49.239
project-social-research	Social Research Study	Social Research Study	Comprehensive social research examining cultural dynamics and community development patterns.	images/projects/social-research.jpg	completed	public	unit-social-sciences-humanities	2023	Funded Research	f	2026-07-21 01:17:49.242
project-sustainable-agriculture	Sustainable Agriculture Practices	Sustainable Agriculture Practices	Research on sustainable farming methods and crop improvement techniques for local farmers.	images/projects/agriculture.jpg	completed	public	unit-agriculture	2023	Funded Research	f	2026-07-21 01:17:49.244
project-data-platform	Data Analytics Platform Development	Data Analytics Platform Development	Development of an advanced data analytics platform for research data management and analysis.	images/projects/data-platform.jpg	ongoing	public	data-analysis-ai	2024	Funded Research	f	2026-07-21 01:17:49.231
\.


--
-- Data for Name: ProjectDiscussionMessage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ProjectDiscussionMessage" (id, "projectId", "senderId", message, "createdAt") FROM stdin;
1	project-data-platform	staff-polla-fattah	Initial platform setup is complete. Starting sprint 1.	2026-07-24 13:52:11.114
\.


--
-- Data for Name: Publication; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Publication" (id, title, "pubType", degree, year, "unitId", description, pdf, journal, "supervisorId", draft) FROM stdin;
pub-001	Monthly occurrence, maturation time and some host factor effects on the spirurine nematode Rhabdochona longispicula	article	\N	2024	unit-agriculture	The study collected Cyprinion macrostomus fish monthly from three points on the Greater Zab River in 2022 to determine infection prevalence and maturation of the nematode Rhabdochona longispicula. Results showed peak infection in May–June with prevalence up to 42.85 %, while host sex had no significant effect on infection but older fish had higher prevalence.	/pdfs/spirurine-nematode-study.pdf	\N	\N	f
pub-015	Temporal patterns of cancer burden in Asia, 1990-2019	article	\N	2024	unit-biology-life-sciences	A systematic examination for the Global Burden of Disease study, analyzing cancer incidence and mortality trends across Asian demographics.	/pdfs/hassan-cancer-burden-asia.pdf	\N	\N	f
pub-013	A Review of Criteria in Rain Water Harvesting Management	article	\N	2019	emccu	Published in the International Journal of Engineering and Natural Sciences, this article reviews key criteria for selecting suitable rainwater harvesting sites. It highlights the importance of remote sensing and GIS techniques and summarizes parameters used to optimize rainwater harvesting in arid regions.	/pdfs/rainwater-harvesting-review.pdf	\N	\N	f
pub-016	Health problems of chemical bombardment survivors in Kurdistan	article	\N	2015	unit-biology-life-sciences	Comprehensive assessment of the long-term genetic and physiological health impacts on survivors of chemical weapon attacks.	/pdfs/maaruf-chemical-survivors.pdf	\N	\N	f
pub-018	Structure of Description in the novel 'Hotel Europe' by Farhad Pirbal	article	\N	2024	unit-social-sciences-humanities	Literary analysis of postmodern narrative techniques and descriptive structures in contemporary Kurdish fiction.	/pdfs/noori-hotel-europe.pdf	\N	\N	f
pub-014	Genetic and non-genetic factors affecting in Saanen goat milk production	article	\N	2024	unit-agriculture	Quantitative analysis of heritability and environmental factors influencing the productive traits of Saanen goats in the Kurdistan Region.	/pdfs/raoof-saanen-genetics.pdf	\N	\N	f
pub-005	Genome Analysis of SARS‑CoV‑2 Delta variant in the Kurdistan region of Iraq	article	\N	2024	unit-biology-life-sciences	This genomic study sequenced SARS‑CoV‑2 Delta variant samples from West Erbil Emergency Hospital. The variant belonged to lineage B.1.617.2 and contained 13 mutations on the spike protein, including unique substitutions (E156G, T250I, T19A and L861W) not previously reported in Delta isolates. The findings underscore the need for further investigation of novel mutations and vaccine efficacy.	/pdfs/delta-variant-genome-analysis.pdf	\N	\N	f
pub-012	Multi‑Factor Classification Using Deep Learning for X‑ray Images	article	\N	2024	data-analysis-ai	This journal article proposes a deep‑learning model that performs multi‑factor classification on X‑ray images, enabling simultaneous diagnosis of multiple conditions. The approach improves diagnostic accuracy and efficiency by leveraging deep neural networks.	/pdfs/multi-factor-xray-classification.pdf	\N	\N	f
pub-002	Impact of IL‑6‑174G/C, IL‑10‑1082A/G Gene Polymorphisms on Toxoplasma gondii infections	article	\N	2023	unit-biology-life-sciences	This study assessed cytokine gene polymorphisms in 40 women with toxoplasmosis and 30 healthy controls. It found that specific IL‑6 and IL‑10 genotypes were associated with increased or decreased risk of Toxoplasma gondii infection; for example, the IL‑6‑174 CC genotype tripled infection risk while the IL‑10‑1082 mutant heterozygote showed a protective effect.	/pdfs/il6-il10-toxoplasma-study.pdf	\N	\N	f
pub-017	Assessing air quality impacts of gas stations through heavy metal analysis	article	\N	2025	emccu	Occupational health study utilizing scalp hair and dust analysis to measure heavy metal exposure in gas station employees.	/pdfs/yasin-air-quality-2025.pdf	\N	\N	f
pub-007	LXR Inhibits Proliferation of Human Breast Cancer Cells through the PI3K‑Akt Pathway	article	\N	2015	unit-biology-life-sciences	This research demonstrates that activation of liver X receptors (LXRs) reduces proliferation of human breast cancer cells. LXRs inhibit PI3K‑Akt pathway signalling, increasing expression of phosphatases (PTEN, PHLPP, PHLPPL) and reducing phosphorylation of Akt and PI3K. The findings highlight LXRs as potential targets for cancer therapy.	/pdfs/lxr-breast-cancer.pdf	\N	\N	f
pub-003	Role of sex chromatin on performance in the local (black) goats	article	\N	2016	unit-agriculture	Researchers examined 132 black goats to study the influence of sex chromatin shapes (drum stick, sessile nodule, tear drop, small club) on milk production, fertility and birth weight. Sex chromatin shape significantly affected daily milk yield, fertility rate and other traits; goats with drum‑stick chromatin produced the most milk (≈681 g day⁻¹).	/pdfs/black-goats-sex-chromatin.pdf	\N	\N	f
pub-011	Hematological Alterations Linked to Occupational Heavy Metal Exposure in Gasoline Station Workers: A Biomonitoring Study From Erbil City	article	\N	2026	emccu	A cross‑sectional biomonitoring study examined 75 gasoline‑station workers and 25 controls in Erbil, assessing blood counts and heavy‑metal concentrations. Exposed workers showed decreased haemoglobin and haematocrit, increased red and white blood cell counts, and higher lymphocyte percentages; heavy‑metal levels in scalp hair and dust correlated with these hematological changes.	/pdfs/gasoline-workers-biomonitoring.pdf	\N	\N	f
pub-009	Nanoscale Zero‑Valent Iron Efficient for Remediation of Chromium, Nickel, and Cadmium‑Contaminated Soils Near Oil Refinery Sites	article	\N	2025	emccu	This study analyzed soils near an oil refinery in Erbil contaminated with heavy metals and tested remediation using green nanoscale zero‑valent iron (nZVI) nanoparticles. Soil samples showed elevated chromium (52.85–79.54 mg·kg⁻¹), nickel (41.10–63.42 mg·kg⁻¹) and cadmium (1.41–1.76 mg·kg⁻¹) exceeding baseline standards. Green nZVI, synthesized from lemon‑peel extract, achieved 12 %, 5 % and 6 % removal of Cr, Ni and Cd, respectively, offering a sustainable remediation approach.	/pdfs/nzvi-heavy-metal-remediation.pdf	\N	\N	f
pub-019	The Concept of Balance as an Aesthetic Value in Contemporary Sculpture	article	\N	2025	unit-social-sciences-humanities	Theoretical examination of 'balance' not just as a physical necessity but as a core philosophical element in regional Kurdish sculpture.	/pdfs/azeez-sculpture-balance.pdf	\N	\N	f
pub-006	Adolescents' Social Phobia and its relationship to Parental treatment methods: A field study in Erbil city center	article	\N	2024	unit-social-sciences-humanities	Using scales validated through Cronbach's alpha, researchers surveyed 402 high‑school students in Erbil to assess social phobia prevalence and parental treatment methods. Analysis showed teenagers had very low levels of social phobia; parents predominantly used democratic parenting, and no significant differences were found by gender, grade level or school type.	/pdfs/social-phobia-parental-methods.pdf	\N	\N	f
pub-004	Role of Sex Chromatin on performance in the Arabi sheep	article	\N	2017	unit-agriculture	Conducted on 122 Arabi sheep in Erbil from July 2014 to August 2015, this study assessed how sex chromatin shapes affect milk production, fertility and other reproductive traits. The findings showed significant effects of chromatin shapes on daily milk production and reproduction; the repeatability coefficient for daily milk production was estimated at 0.42.	/pdfs/arabi-sheep-sex-chromatin.pdf	\N	\N	f
pub-010	Assessment of heavy metals in rainfall as an indicator of air pollution from Erbil Steel Factory in Iraq	article	\N	2024	emccu	This study measured heavy‑metal concentrations in rainfall near the Erbil Steel Factory, finding levels of Mn, Pb, Fe, As, Co, Se, Hg and Cd significantly higher than those at a rural control site. The geo‑accumulation index for Mn (6.28) indicated extreme contamination, and the pollution load index (13.46) showed the area is heavily metal‑polluted.	/pdfs/rainfall-heavy-metals.pdf	\N	\N	f
pub-008	Assessment the Clean Index and Fertilizing Index of Some Imported Composts to Erbil City	article	\N	2019	emccu	Researchers evaluated composts from various countries imported to Erbil using a completely randomized design. Fertilizer index values ranged from 4.13 to 4.47 and clean index values from 3.20 to 3.93, indicating medium heavy‑metal content; overall the composts had good quality suitable for agricultural land.	/pdfs/compost-clean-index.pdf	\N	\N	f
\.


--
-- Data for Name: Regulation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Regulation" (id, title, category, description, "filePath", "fileSize", "lastUpdated", draft, "createdAt") FROM stdin;
7	Publication & Authorship Policy	Ethics	Defines mandatory authorship criteria, ORCID integration, preprint guidelines, and anti-plagiarism compliance.	/policies/instructions & contract.pdf	\N	\N	f	2026-09-01 19:48:01.093
8	Intellectual Property (IP) & Commercialization Policy	IP	Defines institutional ownership of patents, inventions, software, research databases, and technology transfer pathways.	/policies/instructions & contract.pdf	\N	\N	f	2026-09-01 19:48:01.094
9	Open Science and FAIR Data Policy	Open Science	Encourages open access publishing, FAIR data repository standards, and experimental reproducibility.	/policies/instructions & contract.pdf	\N	\N	f	2026-09-01 19:48:01.095
4	Research Center Policy & Governance	Policy	General governance framework governing all research centers and laboratories at Salahaddin University-Erbil.	/policies/instructions & contract.pdf	\N	\N	f	2026-09-01 19:48:01.088
5	Biosafety and Biosecurity Policy	Safety	Protocol governing BSL-2 cell culture, chemical containment, hazard disposal, and personal protective equipment.	/policies/instructions & contract.pdf	\N	\N	f	2026-09-01 19:48:01.09
1	Data Management Policy	Data Management	Policy document on research data management, storage, sharing, and preservation.	#	1.2 MB	2023-12-20 00:00:00	f	2026-07-21 01:17:49.982
2	Research Ethics Guidelines	Ethics	Comprehensive guidelines on research ethics, informed consent, and ethical conduct in research.	#	1.2 MB	2024-01-15 00:00:00	f	2026-07-21 01:17:49.985
6	Information and Data Security Policy	Security	Protects research data repositories, sequencing files, AI models, laboratory servers, and network infrastructure.	/policies/instructions & contract.pdf	\N	\N	f	2026-09-01 19:48:01.092
3	Regulations and Guidelines	Ethics & Governance	Essential information on research ethics, university standards, and strategic developmental goals	#	1.2 MB	\N	f	2026-07-21 01:17:49.986
\.


--
-- Data for Name: ResearchUnit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ResearchUnit" (id, title, name, image, description, draft) FROM stdin;
development-cooperation	Development & Cooperation Unit	Development & Cooperation Unit	/images/labs/lab-chemistry.svg	Coordinates international research grants, multi-institutional university collaborations, industrial technology transfer, and evidence-based policy outreach.	f
unit-agriculture	Agriculture Research Unit	Agriculture Research Unit	/images/labs/lab-agriculture.svg	Conducts practical applied agricultural research, crop science studies, soil quality analytics, and aquaculture research.	f
unit-biology-life-sciences	Biology & Life Sciences Unit	Biology & Life Sciences Unit	/images/labs/lab-biology.svg	Focuses on biomedical research, molecular genetics, microbiology, parasitology, and occupational bio-monitoring.	f
unit-chemistry	Chemistry & Materials Unit	Chemistry & Materials Unit	/images/labs/lab-chemistry.svg	Specializes in analytical chemistry, spectrophotometry, heavy metal bio-remediation, and environmental chemical analytics.	f
unit-social-sciences-humanities	Social Sciences & Humanities Unit	Social Sciences & Humanities Unit	/images/labs/lab-engineering.svg	Promotes interdisciplinary studies in humanities, social phobia biomonitoring, educational methods, and regional cultural preservation.	f
emccu	Environmental Monitoring & Climate Change Unit	Environmental Monitoring & Climate Change Unit (EMCCU)	/images/labs/lab-agriculture.svg	Leading research in regional environmental monitoring, climate change impact assessment, air and water quality analytics, and GIS spatial modeling across Kurdistan.	f
data-analysis-ai	Data Analysis and AI Unit	Data Analysis and AI Unit	/images/labs/lab-engineering.svg	Pioneering computational research in artificial intelligence, deep learning, temporal data mining, medical image classification, and Kurdish natural language processing (NLP).	f
\.


--
-- Data for Name: Staff; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Staff" (id, "userId", title, subtitle, image, "unitId", "titlePosition", email, orcid, "googleScholar", scopus, researchgate, "personalWebsite", bio, content, description, "researchAreas", draft, "subCategory") FROM stdin;
staff-shawnim-mushir-maaruf	ec92070c-9c3d-4895-b49d-a0812c131dac	Shawnim Mushir Maaruf	Lecturer in Molecular Genetics	images/staff/researcher-1.jpg	unit-biology-life-sciences	Lecturer	shawnim.maaruf@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Shawnim Mushir Maaruf, Lecturer in Molecular Genetics	{}	f	\N
staff-suhad-asad-mustafa	29f4f680-c066-42a5-a4e5-7a3ace3063f5	Dr. Suhad Asad Mustafa	Head of Molecular Genetics Laboratory	images/staff/researcher-3.jpg	unit-biology-life-sciences	Head of Molecular Genetics Laboratory	suhad.mustafa@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Dr. Suhad Asad Mustafa, Head of Molecular Genetics Laboratory	{}	f	\N
staff-treska-salih-hassan	7c2b9747-7d6d-4048-85bb-73fdb3075ff6	Treska Salih Hassan	Researcher in Molecular Biology and Cancer Research	images/staff/researcher-5.jpg	unit-biology-life-sciences	Researcher	treska.hassan@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Treska Salih Hassan, Researcher in Molecular Biology and Cancer Research	{}	f	\N
staff-polla-fattah	b1273ffc-b813-4764-ab36-477397e480a2	Dr. Polla Fattah	Lecturer in Software Engineering	images/staff/polla.png	data-analysis-ai	Lecturer in Software Engineering	polla.fattah@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Dr. Polla Fattah, Lecturer in Software Engineering	{}	f	\N
staff-shakar-jamal-aweez	518cc801-672f-4269-9053-ae0f0dacd2a7	Shakar Jamal Aweez	Researcher in Environmental Science	images/staff/researcher-6.jpg	emccu	Researcher	shakar.aweez@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Shakar Jamal Aweez, Researcher in Environmental Science	{}	f	\N
staff-sara-abdulkhaliq-yasin	7f5f6e29-90d5-452a-acd3-de4c8cbfdd4b	Sara Abdulkhaliq Yasin	Master of Science in Phycolimnology	images/staff/researcher-2.jpg	emccu	Researcher	sara.yasin@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Sara Abdulkhaliq Yasin, Researcher in Environmental Sciences	{}	f	\N
staff-shaho-jangi-noori	4f155485-40d2-494c-a793-fa712b8c2dff	Shaho Jangi Noori	Researcher in Water Resource Management	images/staff/researcher-3.jpg	emccu	Researcher	shaho.noori@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Shaho Jangi Noori, Researcher in Water Resource Management	{}	f	\N
staff-salim-omar-raoof	c2905363-669b-4417-89eb-c2eb6643fc6a	Dr. Salim Omar Raoof	Doctor of Animal Breeding and Quality Assurance Manager	images/staff/researcher-2.jpg	unit-agriculture	Doctor of Animal Breeding and Quality Assurance Manager	salim.raoof@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Dr. Salim Omar Raoof, Quality Assurance Manager	{}	f	\N
staff-samir-jawdat-bilal	84958efe-3cf8-4e74-9e66-b60211f3e282	Dr. Samir Jawdat Bilal	Assistant Professor of Fish Parasitology	images/staff/samir.png	unit-agriculture	Assistant Professor of Fish Parasitology	samir.bilal@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Dr. Samir Jawdat Bilal, Assistant Professor of Fish Parasitology	{}	f	\N
staff-sarbast-muhsen-azeez	b82069bd-89ab-4fa5-bd3c-57bcadf80a08	Sarbast Muhsen Azeez	Assistant Lecturer in Fine Arts	images/staff/researcher-4.jpg	unit-social-sciences-humanities	Assistant Lecturer	sarbast.azeez@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Sarbast Muhsen Azeez, Assistant Lecturer in Fine Arts	{}	f	\N
dr-treska-hassan	39fcaba4-d5f2-4c89-aed7-01d738d571ff	Dr. Treska Salih Hassan	Ph.D. in Molecular & Cellular Oncology	\N	emccu	Director, Cancer Biology Laboratory	treska.hasan@su.edu.krd	\N	\N	\N	\N	\N	Directs multidisciplinary cancer research in molecular oncology, tumor microenvironment, experimental therapeutics, and precision oncology.	\N	\N	{"Cancer Biology","Molecular Oncology","Tumor Microenvironment","Biomarker Discovery"}	f	academic
shakar-jamal	e6e2153d-d094-44c7-b4b9-738406605b30	Shakar Jamal Aweez Sadeq	Ph.D. Candidate (Soil Pollution)	\N	emccu	Staff Member (Environmental Researcher), EMCCU	shakar.sadeq@su.edu.krd	\N	\N	\N	\N	\N	Leads EMCCU soil and environmental pollution research line, heavy metal analysis, environmental microbiology, and soil remediation science.	\N	\N	{"Soil Pollution","Environmental Microbiology","Heavy Metal Analysis",Remediation}	f	academic
dr-huner-khayyat	ccee4c42-d258-4bc0-a638-e91a3aeb62ce	Asst. Prof. Dr. Huner Khayyat	Ph.D. in GIS & Remote Sensing	\N	emccu	Head, Environmental Monitoring & Climate Change Unit (EMCCU)	huner.khayyat@su.edu.krd	\N	\N	\N	\N	\N	Ph.D. in GIS and Remote Sensing (Climate Change focus). Strategic direction, cryosphere & climate-data research, government and international liaison.	\N	\N	{GIS,"Remote Sensing","Climate Change",Cryosphere,"Spatial Data Science"}	f	academic
staff-fenk-amjad-hasan	8ecbd1f2-0fee-40a6-8e9d-55008a2e5c9c	Fenk Amjad Hasan	Researcher in Psychology and Education	images/staff/researcher-4.jpg	unit-social-sciences-humanities	Researcher	fenk.hasan@su.edu.krd	\N	\N	\N	\N	\N	\N	\N	Profile of Fenk Amjad Hasan, Researcher in Psychology and Education	{}	f	\N
dr-suhad-mustafa	\N	Prof. Dr. Suhad A. Mustafa	Professor of Molecular Engineering	\N	emccu	Director of Molecular Engineering Laboratory & Head of Animal Research Ethics Committee (AREC)	\N	\N	\N	\N	\N	\N	Provides scientific leadership in molecular engineering, postgraduate supervision, serves as Head of AREC, and member of the University Academic Titles Committee.	\N	\N	{"Molecular Engineering","Recombinant Proteins","Gene Cloning","Animal Research Ethics"}	f	academic
sara-abdulkhaleq	85810ec4-a2c4-4274-84af-887889b6d996	Sara Abdulkhaleq Yaseen	Ph.D. Candidate, SURC	\N	emccu	Staff Member (Environmental Researcher), EMCCU	sara.yaseen@su.edu.krd	\N	\N	\N	\N	\N	Environmental researcher contributing to climate monitoring, scientific workshop coordination, and institutional partnership development.	\N	\N	{"Environmental Science","Climate Monitoring","Event Coordination",Sustainability}	f	academic
\.


--
-- Data for Name: SystemSettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."SystemSettings" ("keyName", "valueText", "updatedAt") FROM stdin;
jisds_journal_info	Journal of Intelligent Spatial Data Science (JISDS) is an international peer-reviewed journal established by the Environmental Monitoring & Climate Change Unit (EMCCU) at SURC, in collaboration with Sapienza University of Rome.	2026-09-01 21:29:09.831
vision_statement	Advanced data analytics, interdisciplinary research, and technological innovation to address local and global challenges in the Kurdistan Region and beyond.	2026-09-11 23:18:48.832
mission_statement	To promote excellent scientific inquiry, support academic staff at Salahaddin University-Erbil, manage specialized laboratory equipment, and publish impactful research outputs.	2026-09-11 23:18:48.844
homepage_president_quote	Salahaddin University Research Center represents our dedication to scientific advancement, academic integrity, and policy-driven development.	2026-09-11 23:18:48.846
\.


--
-- Data for Name: Testimonial; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Testimonial" (id, title, quote, "position", image, draft, "createdAt") FROM stdin;
c81f7775-19c7-4340-ae86-8b065f8bd57f	Erbil Governor	The Research Center at Salahaddin University-Erbil plays a crucial role in addressing the challenges facing our region through evidence-based research and community engagement. Their work in environmental studies, data analysis, and social sciences directly benefits the people of Erbil and Kurdistan. We value the Center's contributions to regional development and look forward to continued collaboration.	Erbil Governorate	\N	f	2026-07-21 01:17:50.016
9d57207f-64ba-42c0-b184-3b7d0b18cc7c	Noora Ibrahim	The Research Center has provided me with exceptional opportunities to develop my research skills and contribute to meaningful social science projects. The training workshops, access to research resources, and supportive academic environment have been crucial to my success. I am grateful for the Center's commitment to supporting early-career researchers and students.	MSc Student, Social Sciences Unit	\N	f	2026-07-21 01:17:50.022
c091928d-75ed-4b5a-9685-32265a270af6	Frmesk Jutiar	Working as a research assistant at SURC has been an incredible learning experience. The Center provides excellent facilities, supportive mentorship, and opportunities to work on diverse research projects. The collaborative atmosphere encourages innovation and knowledge sharing, which has significantly contributed to my professional development and research skills.	Research Assistant, Biology Unit	\N	f	2026-07-21 01:17:50.023
4e71b67d-4320-4c14-a7e8-c24739fa2e87	Sakar Sardar	As a student at SURC, I have experienced firsthand the exceptional support and resources available for research. The Center has provided me with access to state-of-the-art facilities, expert mentorship, and opportunities to contribute to meaningful research projects. The collaborative environment and commitment to student development have been instrumental in my academic growth and research journey.	Student, Salahaddin University-Erbil	\N	f	2026-07-21 01:17:50.024
7a24222c-98eb-4681-8ec7-b179e28d8e08	Dr. Ahmed Hassan	The Research Center has been instrumental in advancing environmental research in our region. Through their support, we've been able to conduct comprehensive studies on climate change impacts and develop sustainable solutions for agricultural challenges. The collaborative environment and access to advanced data analysis tools have significantly enhanced our research capabilities.	Professor of Environmental Science, College of Science	\N	f	2026-07-21 01:17:50.005
02b34d66-0233-496f-ba9d-5a5770ede24f	Dr. Farhad Aziz	The Research Center's support for agricultural research has been transformative for our work. Through their data analysis capabilities and research infrastructure, we've been able to develop sustainable farming practices that directly benefit local farmers. The Center's approach of connecting research with community needs ensures that our work creates real, measurable impact.	Professor of Agricultural Sciences	\N	f	2026-07-21 01:17:50.007
b38bbd48-5d2e-4435-8c6d-39a72a9c01c2	Dr. Karwan Ahmed	Our collaboration with SURC has been essential in addressing environmental challenges facing the Kurdistan Region. The Center's research on environmental monitoring and data collection has provided us with critical insights for policy development. Their commitment to evidence-based research and community engagement makes them an invaluable partner in our efforts to protect and preserve our natural resources.	Director, Erbil Environmental Protection Agency	\N	f	2026-07-21 01:17:50.008
edd42e1b-2a15-4730-942f-9ffe13c97fab	Dr. Layla Mahmoud	As a researcher working with SURC, I have found the Center to be an invaluable resource for my work in molecular biology and plant genetics. The state-of-the-art laboratory facilities, combined with the Center's commitment to supporting interdisciplinary research, have enabled me to pursue innovative projects that contribute to both scientific knowledge and practical applications in agriculture.	Associate Professor, Department of Biology	\N	f	2026-07-21 01:17:50.01
584fb83c-95ac-456b-be84-3632c32c7558	Dr. Razgar Mustafa	SURC's support for materials science research has enabled our department to pursue cutting-edge projects with industrial applications. The Center's emphasis on collaboration between academia and industry has opened new avenues for research that directly benefits our region's technological development. Their commitment to maintaining high ethical standards and protecting intellectual property gives us confidence in our partnerships.	Head of Chemistry Department, College of Science	\N	f	2026-07-21 01:17:50.014
92c8e444-c05a-48c4-818c-61d4d325e5f5	Dr. Sardar Ahmed	The Research Center's data analysis unit has been a game-changer for computational research at our university. Their advanced infrastructure and expertise in data management have enabled us to tackle complex research questions that would otherwise be impossible. The Center's emphasis on open data and reproducible research practices sets an excellent example for the entire academic community.	Associate Professor, Computer Science Department	\N	f	2026-07-21 01:17:50.015
4117a93b-7c91-4734-a52d-e427ea046720	Shadman Ali	My internship at SURC has been an eye-opening experience. Working alongside experienced researchers and having access to state-of-the-art facilities has given me invaluable insights into the research process. The Center's supportive environment and commitment to student development have inspired me to pursue a career in research. I am grateful for this opportunity to contribute to meaningful scientific work.	Undergraduate Research Intern	\N	f	2026-07-21 01:17:50.018
da9cfc48-8564-4bfc-811c-bae93255f4cd	Mohammed Ali	Completing my doctoral research at SURC has been a transformative experience. The mentorship I received, access to comprehensive datasets, and the collaborative research environment have all contributed to my academic and professional growth. The Center's emphasis on bridging research with real-world applications has given me valuable insights into how academic work can create meaningful impact in our community.	PhD Student, Data Analysis Unit	\N	f	2026-07-21 01:17:50.02
e7887876-9991-400c-87ca-1d8f29679080	Minister of Higher Education	The Salahaddin University Research Center represents a significant advancement in higher education and research excellence in Kurdistan. The Center's commitment to bridging academic research with real-world applications demonstrates the transformative power of higher education institutions. We are proud to support such initiatives that contribute to the development of our region through scientific innovation and knowledge creation.	Kurdistan Regional Government	\N	f	2026-07-21 01:17:50.019
ba532d68-9ccd-4430-ad92-32b0d583395f	Testimonials		\N	\N	f	2026-07-21 01:17:50.025
a713e765-076e-4458-8b6b-1f9ae4979016	Arwa Mohammed	As a graduate student, SURC has provided me with access to resources and opportunities that have been essential to my research journey. The Center's commitment to supporting students, combined with their excellent facilities and expert guidance, has enabled me to conduct meaningful research on environmental issues affecting our region. I am proud to be part of such a forward-thinking research community.	Graduate Student, Environmental Studies	\N	f	2026-07-21 01:17:50.002
04b4cc22-1073-47f0-ac1a-65e94c581360	Dr. Nawzad Hamid	SURC represents the future of research excellence in Kurdistan. The Center's comprehensive approach to research, from proposal development to dissemination, demonstrates a commitment to quality and impact that serves as a model for other institutions. Their work in building research capacity and fostering collaboration between different sectors is essential for the continued development of our region's knowledge economy.	Director, Kurdistan Regional Government - Ministry of Higher Education	\N	f	2026-07-21 01:17:50.012
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, name, email, "emailVerified", "passwordHash", image, role, "createdAt", "updatedAt", "verificationCode") FROM stdin;
b82069bd-89ab-4fa5-bd3c-57bcadf80a08	Sarbast Muhsen Azeez	sarbast.azeez@su.edu.krd	\N	8eb412e33a33e2e6e151762fae1e79dc:f6cd1e505492cf29857cfb708f52479c42d5ac75a80019758eceecc2548aa8dbc249f46fab9b8d6b685fa4b391f08a6b2af496772318e1c2b1cad71bb9734fba	images/staff/researcher-4.jpg	researcher	2026-07-21 01:17:49.205	2026-09-11 23:18:48.904	\N
29f4f680-c066-42a5-a4e5-7a3ace3063f5	Dr. Suhad Asad Mustafa	suhad.mustafa@su.edu.krd	\N	10e40f318ac089f9faaa5c8f33eb6507:2bbbd91860849996d42666f0037eaec1ef01af7ddd22bcbc47de987944eb8891bed87ee1f77d368b4bb6a4e76bfd3db6bbcb40401ba99af3f62f672b2c6dbea3	images/staff/researcher-3.jpg	researcher	2026-07-21 01:17:49.215	2026-09-11 23:18:48.925	\N
b1273ffc-b813-4764-ab36-477397e480a2	Dr. Polla Fattah	polla.fattah@su.edu.krd	\N	c87ef890e87af8a564dfcccc3adf8406:8cfd0fa93eb9bd2b766d791f1ab67e3ca8c71cdaef746ed91eec92965043885d541f0593eb1dc75818ef5151f35c24f4dcdfb0221cf3149073367b2e9a4552ef	images/staff/polla.png	superadmin	2026-07-21 01:17:49.194	2026-09-11 23:18:48.876	\N
9d774502-fa61-4110-b87f-e65c07dd4a55	SURC Superadmin	admin@su.edu.krd	\N	7daf499e23bb7ac21b9d22b982dbae34:3675dfaae6f91fd87e6b8bcb308f5047d37cbb98fbd7a19b501bb95a179e89e6c8d7e02dff6705139c715241dd970ced8667fb3c88c8442b200b38bbd58d0e48	\N	superadmin	2026-07-21 11:28:20.627	2026-09-01 21:29:09.104	\N
7c2b9747-7d6d-4048-85bb-73fdb3075ff6	Treska Salih Hassan	treska.hassan@su.edu.krd	\N	1102cabd8f3b89094cb0a30563e0dfd5:1c44afe5567162b83eafe8e2c42a1d79f7e3857712f8ccadcc7986a7e2ca90666e7cb3631820f4ab1cd34fed755f954f5a61000200fbfcb22b7fc91d3e7026a4	images/staff/researcher-5.jpg	researcher	2026-07-21 01:17:49.217	2026-09-11 23:18:48.93	\N
4f155485-40d2-494c-a793-fa712b8c2dff	Shaho Jangi Noori	shaho.noori@su.edu.krd	\N	5f82eaf2c02e8d289604801b4849223f:a877496721151116924ede9950ae18ef5f75190cdf9e1e247fedce75053e316a7c26f271fdcd42faa19c97f94033e45ad795797e8c4229ce7c09a96ea76241bc	images/staff/researcher-3.jpg	researcher	2026-07-21 01:17:49.207	2026-09-11 23:18:48.91	\N
39fcaba4-d5f2-4c89-aed7-01d738d571ff	Dr. Treska Salih Hassan	treska.hasan@su.edu.krd	\N	1295040a04e90a29180ea6c00ed389be:549bf23af24ae3b7d140f4399aa209ff7c1bf8d577a2f03829db8333260ac90abc12f78db99e73245f970fa6f0aee1f09a022f48923a63db4c4b33f3cce8a772	\N	researcher	2026-09-01 19:48:01.049	2026-09-01 21:29:09.796	\N
de5f73dd-7c02-4dd3-9cd7-fd1a95c159ac	SURC Lab Staff	lab_staff@su.edu.krd	\N	125c532a13cb511250ac78dcdc1e8599:6fe203ed2cc1467480e87a36f3527565a70f55cb11c3beca668f03483167a20b6d4332ae250830fe511c55a931bac87e0e4bbcbce79ca5f6f9c61e4f9f549392	\N	lab_staff	2026-07-21 11:28:20.631	2026-09-01 21:29:09.107	\N
e6e2153d-d094-44c7-b4b9-738406605b30	Shakar Jamal Aweez Sadeq	shakar.sadeq@su.edu.krd	\N	114206777009a60de4859725967be1ce:b085e37aa6f03e60505bb7e9f50f7b1c1e12e4808b915fac8a39771c5ed9b75e5d0aa79d07a4f4e1f4ecd70757ef55b0fc0c1c82a9b0b107cdf8d34dc5df08ad	\N	researcher	2026-09-01 19:48:01.054	2026-09-01 21:29:09.8	\N
85810ec4-a2c4-4274-84af-887889b6d996	Sara Abdulkhaleq Yaseen	sara.yaseen@su.edu.krd	\N	61427fadc5dbbab34a91d18666a6760c:6160eba3685dbcb4bcc82c76d096b8c54524d957a837be2368fcf1e922eac5d6d694b3108ed447f9c1532f1a3d9e461d4e89f1a1034d458dff89e9bf05a1d365	\N	researcher	2026-09-01 19:48:01.058	2026-09-01 21:29:09.804	\N
c2905363-669b-4417-89eb-c2eb6643fc6a	Dr. Salim Omar Raoof	salim.raoof@su.edu.krd	\N	9b484f606b6255114593f87b8b1ac7ea:c7bb796302d74033fa15d1ebb761bce288e0cd25e0f843ee6535cb86e6859c8d84679371dce9a73a1724524ae8d2be0841a2c2f85478078086d343465b47e241	images/staff/researcher-2.jpg	researcher	2026-07-21 01:17:49.196	2026-09-11 23:18:48.884	\N
84958efe-3cf8-4e74-9e66-b60211f3e282	Dr. Samir Jawdat Bilal	samir.bilal@su.edu.krd	\N	22b6d11d28a38bfc4fb79ae3d5786f71:d2cb23f8c0972d23f2d13baf6bee0d5606fdd4b41557ba506af9f21724a07c561a3a3947ca4cfc960aa7e4e0dc7bd0687957765e2b2ae9c5f969ba02410296bb	images/staff/samir.png	researcher	2026-07-21 01:17:49.199	2026-09-11 23:18:48.892	\N
7f5f6e29-90d5-452a-acd3-de4c8cbfdd4b	Sara Abdulkhaliq Yasin	sara.yasin@su.edu.krd	\N	f4226d6b35fde643cb9488043e0d66d1:bcf2ff12b407f106aaa0095b853aa612a9f168a567f3eeb78ee76458fd4f3867b8b04e1e6a7d1db16533ea6d1150414daf1f879c7e2de5c5cf648e1f93f4a8d3	images/staff/researcher-2.jpg	researcher	2026-07-21 01:17:49.201	2026-09-11 23:18:48.898	\N
518cc801-672f-4269-9053-ae0f0dacd2a7	Shakar Jamal Aweez	shakar.aweez@su.edu.krd	\N	1c4d326d7234cea86506e1a8a61a3869:e11fe9ba3129fd2d7399ee152fd10222886cd07584c75a3e08ee8c3a9de359bbcd9af810ac50d850f0142d45d533ef0225b1a5a47ece3ec35b15b007d808f3b8	images/staff/researcher-6.jpg	researcher	2026-07-21 01:17:49.21	2026-09-11 23:18:48.915	\N
adda3a17-81d3-4762-96fb-d65542fa670c	Sanar Fawzi	sanar.fawzi@su.edu.krd	2026-09-01 22:45:59.139	14732a9e5b1645fe07722a2108ccb4fa:921e3a89b7a0ef7b6e194f7a768efd1b186b89990954bf650395b1c93bb38e7258e0f94e1c89f266cf3f7bfa05aeadc421cd13b9218657c31aa05294b5876077	\N	lab_staff	2026-09-01 22:43:14.921	2026-09-01 22:45:59.14	\N
ccee4c42-d258-4bc0-a638-e91a3aeb62ce	Asst. Prof. Dr. Huner Khayyat	huner.khayyat@su.edu.krd	\N	cf1df2a47f1d998065fafb7e17a6ae93:3f801e32ec3cdf5957c91b5e0b7e78b7f8e9320e0830d2ab0bc5a90ad0f1a2df542e54bc88531167155e66e867133b6408d533c0a5de19a5448b95bc9f8424b7	\N	researcher	2026-09-01 19:47:41.758	2026-09-01 21:29:09.786	\N
ec92070c-9c3d-4895-b49d-a0812c131dac	Shawnim Mushir Maaruf	shawnim.maaruf@su.edu.krd	\N	36c5598ab32a7173ab2b37f6d8b4a696:b2f5c194af51e7125703fefdf93a909723df5ade25cf62604cc02e02f5ef9ca218aaa23f91eb34254a3723efae423b475c786304fd2ed2b75a23b3f5836fd48d	images/staff/researcher-1.jpg	researcher	2026-07-21 01:17:49.212	2026-09-11 23:18:48.92	\N
8ecbd1f2-0fee-40a6-8e9d-55008a2e5c9c	Fenk Amjad Hasan	fenk.hasan@su.edu.krd	\N	f69aff9f5d10630b40a919fdbb2c0bc5:62da49a1127af3666fd9c70c0a3b46142610c7cb325cdc8da2d6bf14042e49d2e7fc3a1379f68d6c53482672fde3eaa3fd6426f408f3601263da00e71e506e25	images/staff/researcher-4.jpg	researcher	2026-07-21 01:17:49.185	2026-09-11 23:18:48.862	\N
\.


--
-- Data for Name: _ProjectTeam; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_ProjectTeam" ("A", "B") FROM stdin;
project-climate-change-impact	staff-shaho-jangi-noori
project-climate-change-impact	staff-shakar-jamal-aweez
project-climate-change-impact	staff-samir-jawdat-bilal
project-community-engagement	staff-fenk-amjad-hasan
project-data-platform	staff-polla-fattah
project-environmental-monitoring	staff-sara-abdulkhaliq-yasin
project-environmental-monitoring	staff-shakar-jamal-aweez
project-materials-science	staff-suhad-asad-mustafa
project-molecular-biology	staff-shawnim-mushir-maaruf
project-molecular-biology	staff-treska-salih-hassan
project-molecular-biology	staff-suhad-asad-mustafa
project-social-research	staff-sarbast-muhsen-azeez
project-social-research	staff-fenk-amjad-hasan
project-sustainable-agriculture	staff-salim-omar-raoof
project-sustainable-agriculture	staff-samir-jawdat-bilal
advanced-neural-modeling-of-kurdish-handwritten-text	staff-polla-fattah
\.


--
-- Data for Name: _PublicationAuthors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_PublicationAuthors" ("A", "B") FROM stdin;
pub-006	staff-fenk-amjad-hasan
pub-015	staff-treska-salih-hassan
pub-016	staff-shawnim-mushir-maaruf
pub-008	staff-shakar-jamal-aweez
pub-017	staff-sara-abdulkhaliq-yasin
pub-011	staff-sara-abdulkhaliq-yasin
pub-018	staff-shaho-jangi-noori
pub-002	staff-samir-jawdat-bilal
pub-007	staff-treska-salih-hassan
pub-012	staff-polla-fattah
pub-001	staff-samir-jawdat-bilal
pub-009	staff-shakar-jamal-aweez
pub-010	staff-shakar-jamal-aweez
pub-013	staff-shaho-jangi-noori
pub-014	staff-salim-omar-raoof
pub-005	staff-suhad-asad-mustafa
pub-019	staff-sarbast-muhsen-azeez
pub-004	staff-salim-omar-raoof
pub-003	staff-salim-omar-raoof
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
98da1c15-af7c-40f4-b014-81288131d755	5f89987cba864621c73904f6a0d7c9828797c92a34589590b2e224041c06a0d4	2026-07-21 04:16:46.266008+03	20260721011645_init	\N	\N	2026-07-21 04:16:45.88485+03	1
\.


--
-- Name: EquipmentFeedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."EquipmentFeedback_id_seq"', 1, false);


--
-- Name: EquipmentReservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."EquipmentReservation_id_seq"', 1, false);


--
-- Name: Event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Event_id_seq"', 410, true);


--
-- Name: Form_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Form_id_seq"', 9, true);


--
-- Name: ProjectDiscussionMessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."ProjectDiscussionMessage_id_seq"', 1, true);


--
-- Name: Regulation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Regulation_id_seq"', 9, true);


--
-- Name: Dataset Dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Dataset"
    ADD CONSTRAINT "Dataset_pkey" PRIMARY KEY (id);


--
-- Name: EquipmentFeedback EquipmentFeedback_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentFeedback"
    ADD CONSTRAINT "EquipmentFeedback_pkey" PRIMARY KEY (id);


--
-- Name: EquipmentReservation EquipmentReservation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentReservation"
    ADD CONSTRAINT "EquipmentReservation_pkey" PRIMARY KEY (id);


--
-- Name: Equipment Equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Equipment"
    ADD CONSTRAINT "Equipment_pkey" PRIMARY KEY (id);


--
-- Name: Event Event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_pkey" PRIMARY KEY (id);


--
-- Name: Form Form_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Form"
    ADD CONSTRAINT "Form_pkey" PRIMARY KEY (id);


--
-- Name: Lab Lab_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Lab"
    ADD CONSTRAINT "Lab_pkey" PRIMARY KEY (id);


--
-- Name: ProjectDiscussionMessage ProjectDiscussionMessage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ProjectDiscussionMessage"
    ADD CONSTRAINT "ProjectDiscussionMessage_pkey" PRIMARY KEY (id);


--
-- Name: Project Project_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Project"
    ADD CONSTRAINT "Project_pkey" PRIMARY KEY (id);


--
-- Name: Publication Publication_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Publication"
    ADD CONSTRAINT "Publication_pkey" PRIMARY KEY (id);


--
-- Name: Regulation Regulation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Regulation"
    ADD CONSTRAINT "Regulation_pkey" PRIMARY KEY (id);


--
-- Name: ResearchUnit ResearchUnit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ResearchUnit"
    ADD CONSTRAINT "ResearchUnit_pkey" PRIMARY KEY (id);


--
-- Name: Staff Staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT "Staff_pkey" PRIMARY KEY (id);


--
-- Name: SystemSettings SystemSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SystemSettings"
    ADD CONSTRAINT "SystemSettings_pkey" PRIMARY KEY ("keyName");


--
-- Name: Testimonial Testimonial_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Testimonial"
    ADD CONSTRAINT "Testimonial_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _ProjectTeam _ProjectTeam_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_ProjectTeam"
    ADD CONSTRAINT "_ProjectTeam_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _PublicationAuthors _PublicationAuthors_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_PublicationAuthors"
    ADD CONSTRAINT "_PublicationAuthors_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Event_slug_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Event_slug_key" ON public."Event" USING btree (slug);


--
-- Name: Staff_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Staff_email_key" ON public."Staff" USING btree (email);


--
-- Name: Staff_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Staff_userId_key" ON public."Staff" USING btree ("userId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: _ProjectTeam_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_ProjectTeam_B_index" ON public."_ProjectTeam" USING btree ("B");


--
-- Name: _PublicationAuthors_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_PublicationAuthors_B_index" ON public."_PublicationAuthors" USING btree ("B");


--
-- Name: Dataset Dataset_unitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Dataset"
    ADD CONSTRAINT "Dataset_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES public."ResearchUnit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EquipmentFeedback EquipmentFeedback_equipmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentFeedback"
    ADD CONSTRAINT "EquipmentFeedback_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES public."Equipment"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EquipmentFeedback EquipmentFeedback_reservationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentFeedback"
    ADD CONSTRAINT "EquipmentFeedback_reservationId_fkey" FOREIGN KEY ("reservationId") REFERENCES public."EquipmentReservation"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EquipmentReservation EquipmentReservation_approvedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentReservation"
    ADD CONSTRAINT "EquipmentReservation_approvedById_fkey" FOREIGN KEY ("approvedById") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EquipmentReservation EquipmentReservation_equipmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EquipmentReservation"
    ADD CONSTRAINT "EquipmentReservation_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES public."Equipment"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Equipment Equipment_labId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Equipment"
    ADD CONSTRAINT "Equipment_labId_fkey" FOREIGN KEY ("labId") REFERENCES public."Lab"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Lab Lab_supervisorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Lab"
    ADD CONSTRAINT "Lab_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ProjectDiscussionMessage ProjectDiscussionMessage_projectId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ProjectDiscussionMessage"
    ADD CONSTRAINT "ProjectDiscussionMessage_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES public."Project"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProjectDiscussionMessage ProjectDiscussionMessage_senderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ProjectDiscussionMessage"
    ADD CONSTRAINT "ProjectDiscussionMessage_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Project Project_unitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Project"
    ADD CONSTRAINT "Project_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES public."ResearchUnit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Publication Publication_supervisorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Publication"
    ADD CONSTRAINT "Publication_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Publication Publication_unitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Publication"
    ADD CONSTRAINT "Publication_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES public."ResearchUnit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Staff Staff_unitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT "Staff_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES public."ResearchUnit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Staff Staff_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Staff"
    ADD CONSTRAINT "Staff_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: _ProjectTeam _ProjectTeam_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_ProjectTeam"
    ADD CONSTRAINT "_ProjectTeam_A_fkey" FOREIGN KEY ("A") REFERENCES public."Project"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ProjectTeam _ProjectTeam_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_ProjectTeam"
    ADD CONSTRAINT "_ProjectTeam_B_fkey" FOREIGN KEY ("B") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _PublicationAuthors _PublicationAuthors_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_PublicationAuthors"
    ADD CONSTRAINT "_PublicationAuthors_A_fkey" FOREIGN KEY ("A") REFERENCES public."Publication"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _PublicationAuthors _PublicationAuthors_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_PublicationAuthors"
    ADD CONSTRAINT "_PublicationAuthors_B_fkey" FOREIGN KEY ("B") REFERENCES public."Staff"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict ZlOE0FrvHWR3t7He9t4nX6JqcS80G5A1QWfPWDe90LaNybtF0mTcGDhdrb0eK4h

