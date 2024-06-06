--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-2.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-2.pgdg120+1)

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

ALTER TABLE ONLY public.user_cv_table DROP CONSTRAINT user_cv_table_user_id_112c5436_fk_user_login_table_id;
ALTER TABLE ONLY public.tastypie_apikey DROP CONSTRAINT tastypie_apikey_user_id_8c8fa920_fk_user_login_table_id;
ALTER TABLE ONLY public.user_profile_table DROP CONSTRAINT myapp_userprofile_user_id_8f877d36_fk_myapp_userlogin_id;
ALTER TABLE ONLY public.user_login_table_user_permissions DROP CONSTRAINT myapp_userlogin_user_userlogin_id_1e79140a_fk_myapp_use;
ALTER TABLE ONLY public.user_login_table_user_permissions DROP CONSTRAINT myapp_userlogin_user_permission_id_b4c6a088_fk_auth_perm;
ALTER TABLE ONLY public.user_login_table_groups DROP CONSTRAINT myapp_userlogin_groups_group_id_0d89786e_fk_auth_group_id;
ALTER TABLE ONLY public.user_login_table_groups DROP CONSTRAINT myapp_userlogin_grou_userlogin_id_15188e1a_fk_myapp_use;
ALTER TABLE ONLY public.company_details_table DROP CONSTRAINT myapp_companydetails_user_id_6eb1bbf4_fk_myapp_userlogin_id;
ALTER TABLE ONLY public.job_offers_table DROP CONSTRAINT job_offers_table_company_id_2119fd0a_fk_company_d;
ALTER TABLE ONLY public.job_application_table DROP CONSTRAINT job_application_table_user_id_d5f6d775_fk_user_login_table_id;
ALTER TABLE ONLY public.job_application_table DROP CONSTRAINT job_application_tabl_job_offer_id_c7e20ef7_fk_job_offer;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_myapp_userlogin_id;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX public.tastypie_apikey_key_17b411bb_like;
DROP INDEX public.tastypie_apikey_key_17b411bb;
DROP INDEX public.myapp_userlogin_username_87081017_like;
DROP INDEX public.myapp_userlogin_user_permissions_userlogin_id_1e79140a;
DROP INDEX public.myapp_userlogin_user_permissions_permission_id_b4c6a088;
DROP INDEX public.myapp_userlogin_groups_userlogin_id_15188e1a;
DROP INDEX public.myapp_userlogin_groups_group_id_0d89786e;
DROP INDEX public.job_offers_table_company_id_2119fd0a;
DROP INDEX public.job_application_table_user_id_d5f6d775;
DROP INDEX public.job_application_table_job_offer_id_c7e20ef7;
DROP INDEX public.django_session_session_key_c0390e0f_like;
DROP INDEX public.django_session_expire_date_a5c62663;
DROP INDEX public.django_admin_log_user_id_c564eba6;
DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX public.auth_permission_content_type_id_2f476e4b;
DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX public.auth_group_name_a6ea08ec_like;
ALTER TABLE ONLY public.user_cv_table DROP CONSTRAINT user_cv_table_user_cv_id_key;
ALTER TABLE ONLY public.tastypie_apikey DROP CONSTRAINT tastypie_apikey_user_id_key;
ALTER TABLE ONLY public.tastypie_apikey DROP CONSTRAINT tastypie_apikey_pkey;
ALTER TABLE ONLY public.tastypie_apiaccess DROP CONSTRAINT tastypie_apiaccess_pkey;
ALTER TABLE ONLY public.user_profile_table DROP CONSTRAINT myapp_userprofile_user_id_key;
ALTER TABLE ONLY public.user_profile_table DROP CONSTRAINT myapp_userprofile_pkey;
ALTER TABLE ONLY public.user_login_table DROP CONSTRAINT myapp_userlogin_username_key;
ALTER TABLE ONLY public.user_login_table_user_permissions DROP CONSTRAINT myapp_userlogin_user_permissions_pkey;
ALTER TABLE ONLY public.user_login_table_user_permissions DROP CONSTRAINT myapp_userlogin_user_per_userlogin_id_permission__04d817f9_uniq;
ALTER TABLE ONLY public.user_login_table DROP CONSTRAINT myapp_userlogin_pkey;
ALTER TABLE ONLY public.user_login_table_groups DROP CONSTRAINT myapp_userlogin_groups_userlogin_id_group_id_df2b70b4_uniq;
ALTER TABLE ONLY public.user_login_table_groups DROP CONSTRAINT myapp_userlogin_groups_pkey;
ALTER TABLE ONLY public.user_cv_table DROP CONSTRAINT myapp_usercv_pkey;
ALTER TABLE ONLY public.job_offers_table DROP CONSTRAINT myapp_joboffers_pkey;
ALTER TABLE ONLY public.company_details_table DROP CONSTRAINT myapp_companydetails_user_id_key;
ALTER TABLE ONLY public.company_details_table DROP CONSTRAINT myapp_companydetails_pkey;
ALTER TABLE ONLY public.job_application_table DROP CONSTRAINT job_application_table_user_id_job_offer_id_44052597_uniq;
ALTER TABLE ONLY public.job_application_table DROP CONSTRAINT job_application_table_pkey;
ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
DROP TABLE public.tastypie_apikey;
DROP TABLE public.tastypie_apiaccess;
DROP TABLE public.user_profile_table;
DROP TABLE public.user_login_table_user_permissions;
DROP TABLE public.user_login_table;
DROP TABLE public.user_login_table_groups;
DROP TABLE public.user_cv_table;
DROP TABLE public.job_offers_table;
DROP TABLE public.job_application_table;
DROP TABLE public.django_session;
DROP TABLE public.django_migrations;
DROP TABLE public.django_content_type;
DROP TABLE public.django_admin_log;
DROP TABLE public.company_details_table;
DROP TABLE public.auth_permission;
DROP TABLE public.auth_group_permissions;
DROP TABLE public.auth_group;
DROP EXTENSION vector;
--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO licentauser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO licentauser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO licentauser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: company_details_table; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.company_details_table (
    id bigint NOT NULL,
    company_name character varying(100),
    address character varying(100),
    contact_email character varying(254),
    phone character varying(100),
    description text,
    user_id bigint NOT NULL
);


ALTER TABLE public.company_details_table OWNER TO licentauser;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO licentauser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO licentauser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO licentauser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO licentauser;

--
-- Name: job_application_table; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.job_application_table (
    id bigint NOT NULL,
    application_date timestamp with time zone NOT NULL,
    job_offer_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.job_application_table OWNER TO licentauser;

--
-- Name: job_application_table_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.job_application_table ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.job_application_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: job_offers_table; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.job_offers_table (
    id bigint NOT NULL,
    job_description text NOT NULL,
    salary numeric(10,2) NOT NULL,
    requirements text[] NOT NULL,
    location character varying(100) NOT NULL,
    job_category text NOT NULL,
    job_position text NOT NULL,
    company_id bigint,
    description_vector public.vector(300) NOT NULL,
    job_category_vector public.vector(300) NOT NULL,
    job_position_vector public.vector(300) NOT NULL,
    location_vector public.vector(300) NOT NULL,
    requirements_vector public.vector(300) NOT NULL
);


ALTER TABLE public.job_offers_table OWNER TO licentauser;

--
-- Name: myapp_companydetails_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.company_details_table ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.myapp_companydetails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: myapp_joboffers_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.job_offers_table ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.myapp_joboffers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_cv_table; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.user_cv_table (
    id bigint NOT NULL,
    studies text[] NOT NULL,
    experience text[] NOT NULL,
    abilities text[] NOT NULL,
    languages text[] NOT NULL,
    hobbies text[] NOT NULL,
    user_id bigint
);


ALTER TABLE public.user_cv_table OWNER TO licentauser;

--
-- Name: myapp_usercv_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.user_cv_table ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.myapp_usercv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_login_table_groups; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.user_login_table_groups (
    id bigint NOT NULL,
    userlogin_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.user_login_table_groups OWNER TO licentauser;

--
-- Name: myapp_userlogin_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.user_login_table_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.myapp_userlogin_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_login_table; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.user_login_table (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    account_type character varying(7) NOT NULL
);


ALTER TABLE public.user_login_table OWNER TO licentauser;

--
-- Name: myapp_userlogin_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.user_login_table ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.myapp_userlogin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_login_table_user_permissions; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.user_login_table_user_permissions (
    id bigint NOT NULL,
    userlogin_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.user_login_table_user_permissions OWNER TO licentauser;

--
-- Name: myapp_userlogin_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.user_login_table_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.myapp_userlogin_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_profile_table; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.user_profile_table (
    id bigint NOT NULL,
    address character varying(100),
    phone_number character varying(100),
    user_id bigint NOT NULL,
    age character varying(100)
);


ALTER TABLE public.user_profile_table OWNER TO licentauser;

--
-- Name: myapp_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.user_profile_table ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.myapp_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tastypie_apiaccess; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.tastypie_apiaccess (
    id bigint NOT NULL,
    identifier character varying(255) NOT NULL,
    url text NOT NULL,
    request_method character varying(10) NOT NULL,
    accessed integer NOT NULL,
    CONSTRAINT tastypie_apiaccess_accessed_check CHECK ((accessed >= 0))
);


ALTER TABLE public.tastypie_apiaccess OWNER TO licentauser;

--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.tastypie_apiaccess ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tastypie_apiaccess_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tastypie_apikey; Type: TABLE; Schema: public; Owner: licentauser
--

CREATE TABLE public.tastypie_apikey (
    id bigint NOT NULL,
    key character varying(128) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.tastypie_apikey OWNER TO licentauser;

--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE; Schema: public; Owner: licentauser
--

ALTER TABLE public.tastypie_apikey ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tastypie_apikey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.auth_group (id, name) FROM stdin;
1	CompanyDetails
2	JobApplication
3	JobOffers
4	UserCV
5	UserProfile
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	32
2	1	29
3	1	30
4	1	31
5	2	41
6	2	42
7	2	43
8	2	44
9	3	24
10	3	21
11	3	22
12	3	23
13	4	40
14	4	37
15	4	38
16	4	39
17	5	33
18	5	34
19	5	35
20	5	36
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add job offers	6	add_joboffers
22	Can change job offers	6	change_joboffers
23	Can delete job offers	6	delete_joboffers
24	Can view job offers	6	view_joboffers
25	Can add user login	7	add_userlogin
26	Can change user login	7	change_userlogin
27	Can delete user login	7	delete_userlogin
28	Can view user login	7	view_userlogin
29	Can add company details	8	add_companydetails
30	Can change company details	8	change_companydetails
31	Can delete company details	8	delete_companydetails
32	Can view company details	8	view_companydetails
33	Can add user profile	9	add_userprofile
34	Can change user profile	9	change_userprofile
35	Can delete user profile	9	delete_userprofile
36	Can view user profile	9	view_userprofile
37	Can add user cv	10	add_usercv
38	Can change user cv	10	change_usercv
39	Can delete user cv	10	delete_usercv
40	Can view user cv	10	view_usercv
41	Can add job application	11	add_jobapplication
42	Can change job application	11	change_jobapplication
43	Can delete job application	11	delete_jobapplication
44	Can view job application	11	view_jobapplication
45	Can add api access	12	add_apiaccess
46	Can change api access	12	change_apiaccess
47	Can delete api access	12	delete_apiaccess
48	Can view api access	12	view_apiaccess
49	Can add api key	13	add_apikey
50	Can change api key	13	change_apikey
51	Can delete api key	13	delete_apikey
52	Can view api key	13	view_apikey
\.


--
-- Data for Name: company_details_table; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.company_details_table (id, company_name, address, contact_email, phone, description, user_id) FROM stdin;
40						57
41						58
20	TechSolutions			0771234794	TechSolutions este specializată în furnizarea de soluții software inovatoare companiilor din întreaga lume. Echipa noastră de experți excelează în dezvoltarea de aplicații personalizate, asigurând o integrare perfectă și sporind eficiența operațională.	35
21	NextGenApps			0722965213	NextGenApps este în fruntea dezvoltării de aplicații mobile, creând aplicații de ultimă oră care redefinesc experiența utilizatorului. Accentul nostru este pe furnizarea de aplicații de înaltă calitate, scalabile și intuitive pentru diverse industrii.	36
36	RetailWorld			0771231964	RetailWorld este o companie lider de retail care oferă o gamă largă de produse la prețuri competitive. Angajamentul nostru este de a oferi un serviciu excelent pentru clienți și o experiență de cumpărături perfectă.	52
22	Cybernetics			0734271089	Cybernetics oferă servicii avansate de securitate cibernetică pentru a proteja companiile de amenințările digitale. Soluțiile noastre includ detectarea amenințărilor, răspunsul la incident și evaluări complete de securitate pentru a vă proteja datele.	37
23	AITech			0771456000	AITech este lider în soluții de inteligență artificială și învățare automată. Ajutăm companiile să valorifice puterea inteligenței artificiale pentru a stimula inovația, a îmbunătăți procesul decizional și a automatiza procesele.	38
24	GreenFields			0744666444	GreenFields este dedicat agriculturii durabile, oferind soluții agricole ecologice și produse ecologice. Misiunea noastră este să promovăm o viață sănătoasă prin practici agricole durabile.	40
37	ShopSmart			0713297004	ShopSmart este o companie inovatoare de retail, axată pe soluții inteligente de cumpărături. Oferim experiențe de cumpărături personalizate și oferte excelente la o varietate de produse.	53
25	AgriCo			0771434786	AgriCo este specializată în tehnologie și inovare agricolă, oferind soluții care sporesc randamentul culturilor și productivitatea fermei. Produsele și serviciile noastre sunt concepute pentru a susține nevoile agricole moderne.	41
26	HarvestHub			0711123942	HarvestHub conectează fermierii cu consumatorii, asigurând produse proaspete și din surse locale. Sprijinim fermele mici, oferind o platformă pentru a ajunge la o piață mai largă, promovând agricultura durabilă.	42
27	AgriVentures			0722597610	AgriVentures se concentrează pe cercetarea și dezvoltarea agricolă, creând soluții inovatoare pentru îmbunătățirea practicilor agricole. Scopul nostru este să promovăm agricultura prin știință și tehnologie.	43
28	LearnQuest			0732023596	LearnQuest oferă programe educaționale cuprinzătoare și resurse pentru studenții de toate vârstele. Misiunea noastră este să promovăm învățarea pe tot parcursul vieții prin conținut educațional antrenant și accesibil.	44
29	EduPride			0723123602	EduPride oferă cursuri online și programe de formare pentru dezvoltare profesională. Ne angajăm să ajutăm oamenii să-și atingă obiectivele de carieră prin educație de înaltă calitate și dezvoltarea abilităților.	45
30	KnowledgeTree			0723912543	KnowledgeTree este o platformă educațională care oferă o gamă largă de cursuri și resurse de învățare. Accentul nostru este să facem educația accesibilă și plăcută pentru toată lumea.	46
31	AcademicSolutions			0726110993	AcademicSolutions colaborează cu școli și instituții pentru a oferi soluții educaționale personalizate. Serviciile noastre includ dezvoltarea de curriculum, formarea profesorilor și programe de sprijin pentru elevi.	47
32	BizVentures			0729123067	BizVentures helps startups and small businesses grow through strategic consulting and investment. Our team provides expert advice on business development, marketing, and financial planning.\n\n	48
33	EnterpriseCorp			0739231923	EnterpriseCorp oferă companiilor mari soluții de afaceri complete, inclusiv optimizarea proceselor, servicii IT și consultanță în strategie corporativă. Ajutăm companiile să atingă excelența operațională.	49
34	BusinessHub			0748777124	BusinessHub este o soluție unică pentru toate nevoile afacerii dvs., oferind servicii precum analiză de piață, planificare financiară și consultanță în afaceri. Scopul nostru este să ajutăm companiile să prospere pe o piață competitivă.	50
35	ProfitPartners			0798123993	ProfitPartners este specializată în consultanță financiară și servicii de investiții pentru afaceri. Oferim perspective și strategii pentru a maximiza profitabilitatea și a asigura o creștere durabilă.	51
38	StoreWise			0798295307	StoreWise oferă o experiență unică de cumpărături cu o selecție curată de produse. Magazinele noastre sunt concepute pentru a oferi o experiență de cumpărături convenabilă și plăcută tuturor clienților.	54
39	RetailPlus			0720912541	RetailPlus este o companie de retail care se concentrează pe furnizarea de produse de înaltă calitate și servicii excepționale pentru clienți. Magazinele noastre oferă o gamă largă de articole, de la produse alimentare la produse electronice.	55
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-06-03 10:41:04.054171+00	1	CompanyDetails	1	[{"added": {}}]	3	1
2	2024-06-03 10:41:36.163696+00	2	JobApplication	1	[{"added": {}}]	3	1
3	2024-06-03 10:42:00.445323+00	3	JobOffers	1	[{"added": {}}]	3	1
4	2024-06-03 10:42:23.774855+00	4	UserCV	1	[{"added": {}}]	3	1
5	2024-06-03 10:42:45.281546+00	5	UserProfile	1	[{"added": {}}]	3	1
6	2024-06-03 12:01:56.277399+00	14	techsolutions	2	[{"changed": {"fields": ["Groups"]}}]	7	1
7	2024-06-03 12:20:19.506631+00	14	techsolutions	2	[{"changed": {"fields": ["User permissions"]}}]	7	1
8	2024-06-03 12:41:13.356066+00	25	academicsolutions	3		7	1
9	2024-06-03 12:41:13.357223+00	19	agrico	3		7	1
10	2024-06-03 12:41:13.357944+00	21	agriventures	3		7	1
11	2024-06-03 12:41:13.358605+00	17	aitech	3		7	1
12	2024-06-03 12:41:13.359259+00	26	bizventures	3		7	1
13	2024-06-03 12:41:13.359905+00	28	businesshub	3		7	1
14	2024-06-03 12:41:13.36056+00	16	cybernetics	3		7	1
15	2024-06-03 12:41:13.361202+00	34	DavidBMB	3		7	1
16	2024-06-03 12:41:13.361822+00	23	edupride	3		7	1
17	2024-06-03 12:41:13.362445+00	27	enterprisecorp	3		7	1
18	2024-06-03 12:41:13.363066+00	18	greenfields	3		7	1
19	2024-06-03 12:41:13.363675+00	20	harvesthub	3		7	1
20	2024-06-03 12:41:13.364297+00	24	knowledgetree	3		7	1
21	2024-06-03 12:41:13.364942+00	22	learnquest	3		7	1
22	2024-06-03 12:41:13.365653+00	15	nextgenapps	3		7	1
23	2024-06-03 12:41:13.366284+00	29	profitpartners	3		7	1
24	2024-06-03 12:41:13.366889+00	33	retailplus	3		7	1
25	2024-06-03 12:41:13.367502+00	30	retailworld	3		7	1
26	2024-06-03 12:41:13.368116+00	31	shopsmart	3		7	1
27	2024-06-03 12:41:13.368738+00	32	storewise	3		7	1
28	2024-06-03 12:41:13.369359+00	14	techsolutions	3		7	1
29	2024-06-03 12:47:10.728689+00	39		3		7	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	myapp	joboffers
7	myapp	userlogin
8	myapp	companydetails
9	myapp	userprofile
10	myapp	usercv
11	myapp	jobapplication
12	tastypie	apiaccess
13	tastypie	apikey
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-06-04 09:16:24.516784+00
2	contenttypes	0002_remove_content_type_name	2024-06-04 09:16:24.523943+00
3	auth	0001_initial	2024-06-04 09:16:24.567693+00
4	auth	0002_alter_permission_name_max_length	2024-06-04 09:16:24.574865+00
5	auth	0003_alter_user_email_max_length	2024-06-04 09:16:24.579989+00
6	auth	0004_alter_user_username_opts	2024-06-04 09:16:24.586826+00
7	auth	0005_alter_user_last_login_null	2024-06-04 09:16:24.59809+00
8	auth	0006_require_contenttypes_0002	2024-06-04 09:16:24.601159+00
9	auth	0007_alter_validators_add_error_messages	2024-06-04 09:16:24.608016+00
10	auth	0008_alter_user_username_max_length	2024-06-04 09:16:24.615461+00
11	auth	0009_alter_user_last_name_max_length	2024-06-04 09:16:24.624642+00
12	auth	0010_alter_group_name_max_length	2024-06-04 09:16:24.631654+00
13	auth	0011_update_proxy_permissions	2024-06-04 09:16:24.639333+00
14	auth	0012_alter_user_first_name_max_length	2024-06-04 09:16:24.645708+00
15	myapp	0001_initial	2024-06-04 09:16:24.802751+00
16	admin	0001_initial	2024-06-04 09:16:24.835373+00
17	admin	0002_logentry_remove_auto_add	2024-06-04 09:16:24.844385+00
18	admin	0003_logentry_add_action_flag_choices	2024-06-04 09:16:24.856644+00
19	myapp	0017_enable_pg_vector	2024-06-04 09:16:24.869043+00
20	myapp	0002_alter_userlogin_options_alter_companydetails_table_and_more	2024-06-04 09:16:24.920662+00
21	myapp	0003_remove_userprofile_email_remove_userprofile_name_and_more	2024-06-04 09:16:24.953351+00
22	myapp	0004_joboffers_job_category_joboffers_job_position	2024-06-04 09:16:24.965377+00
23	myapp	0005_remove_userprofile_gender	2024-06-04 09:16:24.978399+00
24	myapp	0006_alter_userprofile_address_and_more	2024-06-04 09:16:25.013177+00
25	myapp	0007_remove_userprofile_date_of_birth_userprofile_age	2024-06-04 09:16:25.033284+00
26	myapp	0008_remove_usercv_user_profile_usercv_user_cv_and_more	2024-06-04 09:16:25.15567+00
27	myapp	0009_rename_user_cv_usercv_user	2024-06-04 09:16:25.171295+00
28	myapp	0010_alter_usercv_abilities_alter_usercv_experience_and_more	2024-06-04 09:16:25.173722+00
29	myapp	0011_alter_usercv_abilities_alter_usercv_experience_and_more	2024-06-04 09:16:25.293081+00
30	myapp	0012_wrap_text_in_array	2024-06-04 09:16:25.306575+00
31	myapp	0013_remove_companydetails_job_offers_joboffers_company_and_more	2024-06-04 09:16:25.383825+00
32	myapp	0014_rename_email_companydetails_contact_email	2024-06-04 09:16:25.393951+00
33	myapp	0015_alter_joboffers_requirements	2024-06-04 09:16:25.413468+00
34	myapp	0016_jobapplication_joboffers_applicants	2024-06-04 09:16:25.461815+00
35	myapp	0018_merge	2024-06-04 09:16:25.46811+00
36	myapp	0019_joboffers_description_vector_and_more	2024-06-04 09:16:25.54041+00
37	sessions	0001_initial	2024-06-04 09:16:25.56045+00
38	tastypie	0001_initial	2024-06-04 09:16:25.605659+00
39	tastypie	0002_api_access_url_length	2024-06-04 09:16:25.614699+00
40	tastypie	0003_alter_apiaccess_id_alter_apikey_id	2024-06-04 09:16:25.654207+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
2b9z1kztotzz077grhwr765eaxzqes59	.eJxVjMsOwiAQRf-FtSE8SmVcuu83EGYGpGogKe3K-O_apAvd3nPOfYkQt7WEraclzCwuQovT74aRHqnugO-x3pqkVtdlRrkr8qBdTo3T83q4fwcl9vKtlcLBZG2RCJRFyKO3mLWKCdE7AKfBxZGtN6wVeZ9IkcsA9gyDIzbi_QHexzeo:1sE56T:VHwkSHJo9XsKLPAkFLYT0KLwm32XOX4oEbBAnmZVw8g	2024-06-17 10:39:49.49779+00
wwgj98jxb1nnkyprx0ze4p579hn4qu6e	.eJxVjMsOwiAQRf-FtSE8SmVcuu83EGYGpGogKe3K-O_apAvd3nPOfYkQt7WEraclzCwuQovT74aRHqnugO-x3pqkVtdlRrkr8qBdTo3T83q4fwcl9vKtlcLBZG2RCJRFyKO3mLWKCdE7AKfBxZGtN6wVeZ9IkcsA9gyDIzbi_QHexzeo:1sETeJ:SRQPSaQiTGvkl-xkwS8D3B1Sp_bfq_CiZAhg8P4pLZo	2024-06-18 12:52:23.07214+00
\.


--
-- Data for Name: job_application_table; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.job_application_table (id, application_date, job_offer_id, user_id) FROM stdin;
\.


--
-- Data for Name: job_offers_table; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.job_offers_table (id, job_description, salary, requirements, location, job_category, job_position, company_id, description_vector, job_category_vector, job_position_vector, location_vector, requirements_vector) FROM stdin;
\.


--
-- Data for Name: tastypie_apiaccess; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.tastypie_apiaccess (id, identifier, url, request_method, accessed) FROM stdin;
\.


--
-- Data for Name: tastypie_apikey; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.tastypie_apikey (id, key, created, user_id) FROM stdin;
25	18a354c19fbdd2a443d34150664df2428bcc63fe	2024-06-04 12:49:25.202992+00	57
37	864f41908820460f794dbb4596fd19af37005341	2024-06-05 10:00:32.315435+00	12
38	5ca8a24ff42f23cef471b4bc50405102f0cce583	2024-06-06 11:17:39.188711+00	6
\.


--
-- Data for Name: user_cv_table; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.user_cv_table (id, studies, experience, abilities, languages, hobbies, user_id) FROM stdin;
2	{}	{}	{asd}	{}	{}	4
1	{studie1}	{experience1}	{ability1,hello}	{language2}	{hobby1}	3
3	{}	{}	{}	{}	{}	5
4	{}	{}	{}	{}	{}	6
5	{}	{}	{}	{}	{}	7
6	{}	{}	{}	{}	{}	8
7	{}	{}	{}	{}	{}	9
8	{}	{}	{}	{}	{}	10
9	{}	{}	{}	{}	{}	11
10	{}	{}	{}	{}	{}	12
\.


--
-- Data for Name: user_login_table; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.user_login_table (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, account_type) FROM stdin;
2	pbkdf2_sha256$720000$BrDZ4PGssjQs0JsvYoxOzi$3Pk2dM05E8MlQ+V0ZII+Y25OH7c/QP5q1FvMiJYGwb4=	\N	f	David	Bumba	David	david@email.com	f	t	2024-06-03 11:06:14.32993+00	normal
4	pbkdf2_sha256$720000$nLlZSWztv3vsX8m5GN7h5q$svF7shPdgx/jev8zFbJlu6obYljLCKDTwpvZfx9I+bQ=	\N	f	oceanbreeze88	Maya	Johnson	oceanbreeze88@example.com	f	t	2024-06-03 11:14:04.686864+00	normal
5	pbkdf2_sha256$720000$5swC5kP5nmAdk4zpZfDLcF$RXsya8/MD8qMCmMon7XoZhl6vYLKJ58HpqX2R6kYxU8=	\N	f	forestwhisper22	Ethan	Clark	forestwhisper22@example.com	f	t	2024-06-03 11:14:15.846483+00	normal
10	pbkdf2_sha256$720000$fzvb89U9WJrU71dU4b0N6c$A833vY433XxqL+Bv4eqMamNaNlDd8oEGm/mZIobJ4eo=	\N	f	desertrose66	Isabella	Rodriguez	desertrose66@example.com	f	t	2024-06-03 11:14:59.621252+00	normal
35	pbkdf2_sha256$720000$tlNDH4YFy4h6y4phq0spch$Th7+NKGw3Quecu334VtUOFioDxOlE2/HPGMr7lmid2A=	\N	f	techsolutions			info@techsolutions.com	f	t	2024-06-03 12:41:57.839538+00	company
43	pbkdf2_sha256$720000$hb5V03EqXfzcVSIuX6O43W$2Zuyt2qh8rQfs7n9Enb78ntSWarukFs7O6CN/Wa77lc=	\N	f	agriventures			info@agriventures.com	f	t	2024-06-03 12:44:10.694709+00	company
48	pbkdf2_sha256$720000$T6GzVOa7OyeXkvrMSGgcnd$rhgCsF5/nqBYSt5uDJnyRvLwjPJPqXflw3musDubkLo=	\N	f	bizventures			contact@bizventures.com	f	t	2024-06-03 12:44:49.96276+00	company
44	pbkdf2_sha256$720000$effakzcOLQacuPoGLmWuzg$0DyJK8A747omntCh9/r8gH8N7yr5t39QTOypL4u4f90=	\N	f	learnquest			contact@learnquest.com	f	t	2024-06-03 12:44:20.771066+00	company
53	pbkdf2_sha256$720000$q5LJhjOaakE6x8tNMVrLsK$ICXgZBOHrCH7Ih9iGy5chNvocRprXyhY6NO6AevSiMw=	\N	f	shopsmart			info@shopsmart.com	f	t	2024-06-03 12:45:17.064291+00	company
45	pbkdf2_sha256$720000$kIZK7EOO8tF52vrUTZHVd1$lPlGwnX2lMPbNia+9sDUi4rqOOAzYjl4sqIgN4M2oSg=	\N	f	edupride			info@edupride.com	f	t	2024-06-03 12:44:34.534181+00	company
38	pbkdf2_sha256$720000$MVCTf5wOdGy4AEeiihFIaI$5x7cz8LVF/BcEt1CUUweImkut9fQNouLLuPJCiYL1bk=	\N	f	aitech			info@aitech.com	f	t	2024-06-03 12:43:13.448039+00	company
49	pbkdf2_sha256$720000$tiGbxvpHsdq6qdl1kSzedk$JQRYv928o1hSdoVxAfYzb0BA1MmQW4chMU/CyOCeuMU=	\N	f	enterprisecorp			info@enterprisecorp.com	f	t	2024-06-03 12:44:55.58057+00	company
46	pbkdf2_sha256$720000$TP7aCoTJOovfKoDDQ88Rhb$DPWR7hVzk9EPm42wcwVrxwFFAITJMftUPYZC0YuCmmY=	\N	f	knowledgetree			support@knowledgetree.com	f	t	2024-06-03 12:44:37.270054+00	company
50	pbkdf2_sha256$720000$yEL4hp7LxJdPhNTYskfcRg$4ur8vwO78LHGcUSaaVefmuVn0IdLtUR08HwMptv4hhE=	\N	f	businesshub			support@businesshub.com	f	t	2024-06-03 12:45:01.851788+00	company
40	pbkdf2_sha256$720000$6wZvmhCdNj6OXaVGEgwa8Q$SyOCVbPM6Zn2X+ugCtbjHoukZgLeFyeFl6ze67B8hE0=	\N	f	greenfields			contact@greenfields.com	f	t	2024-06-03 12:43:55.160371+00	company
51	pbkdf2_sha256$720000$CjfhSgPjSIRohHNrG9YphM$hTuBQc3oGh28jPmmDBAKCOxUo/4Thp6Vzx09FDDWxg4=	\N	f	profitpartners			info@profitpartners.com	f	t	2024-06-03 12:45:06.190202+00	company
52	pbkdf2_sha256$720000$B8nZZ3CooMPIuCdCWrL5vz$V5bdydmtspF9L0iMZUKO3WxqK0nkRYmmUKjDpS9ozYo=	\N	f	retailworld			contact@retailworld.com	f	t	2024-06-03 12:45:11.379015+00	company
47	pbkdf2_sha256$720000$2oi3c59XAMI5mz1KyoIRJZ$mzJAIHUAVGO260Yw8V1L7V11+tYBOJDGUOf388NvA1U=	\N	f	academicsolutions			info@academicsolutions.com	f	t	2024-06-03 12:44:43.662069+00	company
54	pbkdf2_sha256$720000$b54GoEKhrbn14WCLbqottf$EnZrv22N1SdXlmnAXp/X1AC3x/0J1Jno7DcqB8F4NbY=	\N	f	storewise			support@storewise.com	f	t	2024-06-03 12:45:22.115536+00	company
36	pbkdf2_sha256$720000$DGkrCfK0mblFkb4y4eyes9$9u3l6qExrRtVLQbaPeS1FIN0Hjg78H37hLDwitMdUtE=	\N	f	nextgenapps			contact@nextgenapps.com	f	t	2024-06-03 12:43:02.811293+00	company
55	pbkdf2_sha256$720000$6mmNoAtVBgRbH2IsQ0Ir1p$00RbG/hN5zQv1dMTxlJ1Y16NI0WIaaKVS/twViTZwhs=	\N	f	retailplus			info@retailplus.com	f	t	2024-06-03 12:45:26.734098+00	company
41	pbkdf2_sha256$720000$XXifvTL5e1l6jg9INk6Lvx$wlcNEPhnJTzDAEGiBrQFmhnQSQsFujNudRZBdOsVR5E=	\N	f	agrico			info@agrico.com	f	t	2024-06-03 12:44:00.977302+00	company
37	pbkdf2_sha256$720000$NtlVPZixtesLgRYGDzxugq$uVRy/BZgsLoGE00NCv/tZHf3VOTuCqtSt27xBpW2xJ8=	\N	f	cybernetics			support@cybernetics.com	f	t	2024-06-03 12:43:07.759718+00	company
42	pbkdf2_sha256$720000$IuqNUehazNTY0W3v9dVE18$qID5UwYRHPFzaWGKP6sPsoMULnfIUkutK4IO/km5hWI=	\N	f	harvesthub			support@harvesthub.com	f	t	2024-06-03 12:44:05.767259+00	company
1	pbkdf2_sha256$720000$qzJSOkleyvlsvy8WbUyNf5$op6PpyKFw+FrX4LqBy/5oakQ4fCpLZyH9FIP68wGN68=	2024-06-04 12:52:23.069319+00	t	admin			admin@example.com	t	t	2024-06-03 10:37:59.067918+00	
56	pbkdf2_sha256$720000$NSaZMYgRhcXzWyf7C8lkt4$NaLveUYHz2Xl5sRNJyBShKi/pe3EUvpkHydoEKToT+4=	\N	f	viaductus	Rares	Stanca	rares.stanca@email.com	f	t	2024-06-04 12:41:04.395188+00	user
3	pbkdf2_sha256$720000$aIKyH5PQgJbfOIMnZqy6Km$9F1cy3+865XBlmRHpuJqFZ03JmbasQKAKa5UB5MQ23o=	\N	f	skywalker77	Luke	Skywalker	skywalker77@example.com	f	t	2024-06-03 11:13:56.690173+00	normal
57	pbkdf2_sha256$720000$oHFpam0rlHBoW4n4UUIw2P$d2rY6fKbbM6cAhEYt/FO/v/1HKfgbgy6WyFxNxd0/vU=	\N	f	kendra			kendra@group.com	f	t	2024-06-04 12:49:24.116816+00	company
6	pbkdf2_sha256$720000$q3nyiPEoCqCfESGuIp6ukW$ZcZOeN5X/d7lQjZ6ZpHmB4e02wU1f0KXFwqFmdIVKA4=	\N	f	mountainpeak99	Ava	Miller	mountainpeak99@example.com	f	t	2024-06-03 11:14:26.102998+00	normal
58	pbkdf2_sha256$720000$v8ton9ZWBcalW22aL4u4Xg$kVaTMlaCi2NjbyAVnImvgVRwzv3mUy1Tm/QApUx13CY=	\N	f	karina			karina@bumba.email	f	t	2024-06-04 12:58:49.059462+00	company
7	pbkdf2_sha256$720000$qy5YfFppLPpwFMefy5s9Ef$DAqErwKHj6zQ8SE3Xbc1wqr0Ix/sh545BVLDwjfD1Kk=	\N	f	sunsetglow55	Liam	Davis	sunsetglow55@example.com	f	t	2024-06-03 11:14:37.141751+00	normal
8	pbkdf2_sha256$720000$vn6DmilnpOkdcrl6Zw9GhU$C9cRozhKqjOejV7vurGWTYjLrP37uwS4D+DbryVf2EE=	\N	f	starlight88	Sophia	Garcia	starlight88@example.com	f	t	2024-06-03 11:14:45.781092+00	normal
9	pbkdf2_sha256$720000$AMYSD5DDB9ZLGxQU47KplK$Pe4IPVcX9cjwncfyqzqvjs8eXXy1Bd3oULlHz6nWMGM=	\N	f	riverflow33	Noah	Martinez	riverflow33@example.com	f	t	2024-06-03 11:14:52.712691+00	normal
11	pbkdf2_sha256$720000$0hNNhSJsfTilnrWCxmCE4P$0Vlln/8d3XG46F3yFyxzO+WlYSIRoe1MLJuL6EWQUQg=	\N	f	midnightowl44	James	Hernandez	midnightowl44@example.com	f	t	2024-06-03 11:15:06.472557+00	normal
12	pbkdf2_sha256$720000$zWINaajLq4bXovK5ec1FCH$hx2yjb7SIWZR9YFyIq3rAPdKzzFm3a+AjXoMp2mRhkY=	\N	f	rainbowdash77	Emily	Lopez	rainbowdash77@example.com	f	t	2024-06-03 11:15:12.738106+00	normal
\.


--
-- Data for Name: user_login_table_groups; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.user_login_table_groups (id, userlogin_id, group_id) FROM stdin;
1	2	5
2	2	4
3	2	2
4	3	5
5	3	4
6	3	2
7	4	5
8	4	4
9	4	2
10	5	5
11	5	4
12	5	2
13	6	5
14	6	4
15	6	2
16	7	5
17	7	4
18	7	2
19	8	5
20	8	4
21	8	2
22	9	5
23	9	4
24	9	2
25	10	5
26	10	4
27	10	2
28	11	5
29	11	4
30	11	2
31	12	5
32	12	4
33	12	2
77	35	1
78	35	3
79	36	1
80	36	3
81	37	1
82	37	3
83	38	1
84	38	3
85	40	1
86	40	3
87	41	1
88	41	3
89	42	1
90	42	3
91	43	1
92	43	3
93	44	1
94	44	3
95	45	1
96	45	3
97	46	1
98	46	3
99	47	1
100	47	3
101	48	1
102	48	3
103	49	1
104	49	3
105	50	1
106	50	3
107	51	1
108	51	3
109	52	1
110	52	3
111	53	1
112	53	3
113	54	1
114	54	3
115	55	1
116	55	3
117	57	1
118	57	3
119	58	1
120	58	3
\.


--
-- Data for Name: user_login_table_user_permissions; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.user_login_table_user_permissions (id, userlogin_id, permission_id) FROM stdin;
\.


--
-- Data for Name: user_profile_table; Type: TABLE DATA; Schema: public; Owner: licentauser
--

COPY public.user_profile_table (id, address, phone_number, user_id, age) FROM stdin;
1			2	
3			4	
4			5	
9			10	
2	Timisoara	0731292012	3	22
5	Oradea	0722991823	6	25
6	Bucuresti	0798231567	7	30
7	Cluj-Napoca	0723901992	8	24
8	Iasi	0788231994	9	26
10	Constanta	0722549014	11	28
11	Sibiu	0756923568	12	23
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 5, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 20, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 52, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 29, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 13, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 40, true);


--
-- Name: job_application_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.job_application_table_id_seq', 1, false);


--
-- Name: myapp_companydetails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.myapp_companydetails_id_seq', 41, true);


--
-- Name: myapp_joboffers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.myapp_joboffers_id_seq', 1, false);


--
-- Name: myapp_usercv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.myapp_usercv_id_seq', 10, true);


--
-- Name: myapp_userlogin_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.myapp_userlogin_groups_id_seq', 120, true);


--
-- Name: myapp_userlogin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.myapp_userlogin_id_seq', 58, true);


--
-- Name: myapp_userlogin_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.myapp_userlogin_user_permissions_id_seq', 4, true);


--
-- Name: myapp_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.myapp_userprofile_id_seq', 12, true);


--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.tastypie_apiaccess_id_seq', 1, false);


--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: licentauser
--

SELECT pg_catalog.setval('public.tastypie_apikey_id_seq', 38, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: job_application_table job_application_table_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.job_application_table
    ADD CONSTRAINT job_application_table_pkey PRIMARY KEY (id);


--
-- Name: job_application_table job_application_table_user_id_job_offer_id_44052597_uniq; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.job_application_table
    ADD CONSTRAINT job_application_table_user_id_job_offer_id_44052597_uniq UNIQUE (user_id, job_offer_id);


--
-- Name: company_details_table myapp_companydetails_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.company_details_table
    ADD CONSTRAINT myapp_companydetails_pkey PRIMARY KEY (id);


--
-- Name: company_details_table myapp_companydetails_user_id_key; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.company_details_table
    ADD CONSTRAINT myapp_companydetails_user_id_key UNIQUE (user_id);


--
-- Name: job_offers_table myapp_joboffers_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.job_offers_table
    ADD CONSTRAINT myapp_joboffers_pkey PRIMARY KEY (id);


--
-- Name: user_cv_table myapp_usercv_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_cv_table
    ADD CONSTRAINT myapp_usercv_pkey PRIMARY KEY (id);


--
-- Name: user_login_table_groups myapp_userlogin_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_groups
    ADD CONSTRAINT myapp_userlogin_groups_pkey PRIMARY KEY (id);


--
-- Name: user_login_table_groups myapp_userlogin_groups_userlogin_id_group_id_df2b70b4_uniq; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_groups
    ADD CONSTRAINT myapp_userlogin_groups_userlogin_id_group_id_df2b70b4_uniq UNIQUE (userlogin_id, group_id);


--
-- Name: user_login_table myapp_userlogin_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table
    ADD CONSTRAINT myapp_userlogin_pkey PRIMARY KEY (id);


--
-- Name: user_login_table_user_permissions myapp_userlogin_user_per_userlogin_id_permission__04d817f9_uniq; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_user_permissions
    ADD CONSTRAINT myapp_userlogin_user_per_userlogin_id_permission__04d817f9_uniq UNIQUE (userlogin_id, permission_id);


--
-- Name: user_login_table_user_permissions myapp_userlogin_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_user_permissions
    ADD CONSTRAINT myapp_userlogin_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: user_login_table myapp_userlogin_username_key; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table
    ADD CONSTRAINT myapp_userlogin_username_key UNIQUE (username);


--
-- Name: user_profile_table myapp_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_profile_table
    ADD CONSTRAINT myapp_userprofile_pkey PRIMARY KEY (id);


--
-- Name: user_profile_table myapp_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_profile_table
    ADD CONSTRAINT myapp_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: tastypie_apiaccess tastypie_apiaccess_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.tastypie_apiaccess
    ADD CONSTRAINT tastypie_apiaccess_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apikey tastypie_apikey_pkey; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apikey tastypie_apikey_user_id_key; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_user_id_key UNIQUE (user_id);


--
-- Name: user_cv_table user_cv_table_user_cv_id_key; Type: CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_cv_table
    ADD CONSTRAINT user_cv_table_user_cv_id_key UNIQUE (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: job_application_table_job_offer_id_c7e20ef7; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX job_application_table_job_offer_id_c7e20ef7 ON public.job_application_table USING btree (job_offer_id);


--
-- Name: job_application_table_user_id_d5f6d775; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX job_application_table_user_id_d5f6d775 ON public.job_application_table USING btree (user_id);


--
-- Name: job_offers_table_company_id_2119fd0a; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX job_offers_table_company_id_2119fd0a ON public.job_offers_table USING btree (company_id);


--
-- Name: myapp_userlogin_groups_group_id_0d89786e; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX myapp_userlogin_groups_group_id_0d89786e ON public.user_login_table_groups USING btree (group_id);


--
-- Name: myapp_userlogin_groups_userlogin_id_15188e1a; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX myapp_userlogin_groups_userlogin_id_15188e1a ON public.user_login_table_groups USING btree (userlogin_id);


--
-- Name: myapp_userlogin_user_permissions_permission_id_b4c6a088; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX myapp_userlogin_user_permissions_permission_id_b4c6a088 ON public.user_login_table_user_permissions USING btree (permission_id);


--
-- Name: myapp_userlogin_user_permissions_userlogin_id_1e79140a; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX myapp_userlogin_user_permissions_userlogin_id_1e79140a ON public.user_login_table_user_permissions USING btree (userlogin_id);


--
-- Name: myapp_userlogin_username_87081017_like; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX myapp_userlogin_username_87081017_like ON public.user_login_table USING btree (username varchar_pattern_ops);


--
-- Name: tastypie_apikey_key_17b411bb; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX tastypie_apikey_key_17b411bb ON public.tastypie_apikey USING btree (key);


--
-- Name: tastypie_apikey_key_17b411bb_like; Type: INDEX; Schema: public; Owner: licentauser
--

CREATE INDEX tastypie_apikey_key_17b411bb_like ON public.tastypie_apikey USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_myapp_userlogin_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_myapp_userlogin_id FOREIGN KEY (user_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: job_application_table job_application_tabl_job_offer_id_c7e20ef7_fk_job_offer; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.job_application_table
    ADD CONSTRAINT job_application_tabl_job_offer_id_c7e20ef7_fk_job_offer FOREIGN KEY (job_offer_id) REFERENCES public.job_offers_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: job_application_table job_application_table_user_id_d5f6d775_fk_user_login_table_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.job_application_table
    ADD CONSTRAINT job_application_table_user_id_d5f6d775_fk_user_login_table_id FOREIGN KEY (user_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: job_offers_table job_offers_table_company_id_2119fd0a_fk_company_d; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.job_offers_table
    ADD CONSTRAINT job_offers_table_company_id_2119fd0a_fk_company_d FOREIGN KEY (company_id) REFERENCES public.company_details_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: company_details_table myapp_companydetails_user_id_6eb1bbf4_fk_myapp_userlogin_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.company_details_table
    ADD CONSTRAINT myapp_companydetails_user_id_6eb1bbf4_fk_myapp_userlogin_id FOREIGN KEY (user_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_login_table_groups myapp_userlogin_grou_userlogin_id_15188e1a_fk_myapp_use; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_groups
    ADD CONSTRAINT myapp_userlogin_grou_userlogin_id_15188e1a_fk_myapp_use FOREIGN KEY (userlogin_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_login_table_groups myapp_userlogin_groups_group_id_0d89786e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_groups
    ADD CONSTRAINT myapp_userlogin_groups_group_id_0d89786e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_login_table_user_permissions myapp_userlogin_user_permission_id_b4c6a088_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_user_permissions
    ADD CONSTRAINT myapp_userlogin_user_permission_id_b4c6a088_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_login_table_user_permissions myapp_userlogin_user_userlogin_id_1e79140a_fk_myapp_use; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_login_table_user_permissions
    ADD CONSTRAINT myapp_userlogin_user_userlogin_id_1e79140a_fk_myapp_use FOREIGN KEY (userlogin_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profile_table myapp_userprofile_user_id_8f877d36_fk_myapp_userlogin_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_profile_table
    ADD CONSTRAINT myapp_userprofile_user_id_8f877d36_fk_myapp_userlogin_id FOREIGN KEY (user_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tastypie_apikey tastypie_apikey_user_id_8c8fa920_fk_user_login_table_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_user_id_8c8fa920_fk_user_login_table_id FOREIGN KEY (user_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_cv_table user_cv_table_user_id_112c5436_fk_user_login_table_id; Type: FK CONSTRAINT; Schema: public; Owner: licentauser
--

ALTER TABLE ONLY public.user_cv_table
    ADD CONSTRAINT user_cv_table_user_id_112c5436_fk_user_login_table_id FOREIGN KEY (user_id) REFERENCES public.user_login_table(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

