--
-- PostgreSQL database dump
--

\restrict ejM2fp21pE1yG5ypRLqSGSdaNZbFuWjt63DojTsurFQP1fiCf39mimd3by2RNzu

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.6

-- Started on 2026-04-15 22:09:12

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

--
-- TOC entry 6 (class 2615 OID 16389)
-- Name: dchatdata; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dchatdata;


ALTER SCHEMA dchatdata OWNER TO postgres;

--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA dchatdata; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA dchatdata IS 'data for dchat';


--
-- TOC entry 7 (class 2615 OID 16470)
-- Name: dchatlogs; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dchatlogs;


ALTER SCHEMA dchatlogs OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16408)
-- Name: chat_users; Type: TABLE; Schema: dchatdata; Owner: postgres
--

CREATE TABLE dchatdata.chat_users (
    chat_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE dchatdata.chat_users OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16402)
-- Name: chats; Type: TABLE; Schema: dchatdata; Owner: postgres
--

CREATE TABLE dchatdata.chats (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE dchatdata.chats OWNER TO postgres;

--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE chats; Type: COMMENT; Schema: dchatdata; Owner: postgres
--

COMMENT ON TABLE dchatdata.chats IS 'chats data';


--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: chats_id_seq; Type: SEQUENCE; Schema: dchatdata; Owner: postgres
--

CREATE SEQUENCE dchatdata.chats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE dchatdata.chats_id_seq OWNER TO postgres;

--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 221
-- Name: chats_id_seq; Type: SEQUENCE OWNED BY; Schema: dchatdata; Owner: postgres
--

ALTER SEQUENCE dchatdata.chats_id_seq OWNED BY dchatdata.chats.id;


--
-- TOC entry 227 (class 1259 OID 16457)
-- Name: message_attachments; Type: TABLE; Schema: dchatdata; Owner: postgres
--

CREATE TABLE dchatdata.message_attachments (
    id bigint NOT NULL,
    message_id bigint NOT NULL,
    file_path text NOT NULL
);


ALTER TABLE dchatdata.message_attachments OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16456)
-- Name: message_attachments_id_seq; Type: SEQUENCE; Schema: dchatdata; Owner: postgres
--

CREATE SEQUENCE dchatdata.message_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE dchatdata.message_attachments_id_seq OWNER TO postgres;

--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 226
-- Name: message_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: dchatdata; Owner: postgres
--

ALTER SEQUENCE dchatdata.message_attachments_id_seq OWNED BY dchatdata.message_attachments.id;


--
-- TOC entry 225 (class 1259 OID 16424)
-- Name: messages; Type: TABLE; Schema: dchatdata; Owner: postgres
--

CREATE TABLE dchatdata.messages (
    id bigint NOT NULL,
    chat_id bigint,
    sender_id bigint,
    content text,
    sent_at timestamp with time zone
);


ALTER TABLE dchatdata.messages OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16423)
-- Name: text_messages_id_seq; Type: SEQUENCE; Schema: dchatdata; Owner: postgres
--

CREATE SEQUENCE dchatdata.text_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE dchatdata.text_messages_id_seq OWNER TO postgres;

--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 224
-- Name: text_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: dchatdata; Owner: postgres
--

ALTER SEQUENCE dchatdata.text_messages_id_seq OWNED BY dchatdata.messages.id;


--
-- TOC entry 220 (class 1259 OID 16391)
-- Name: users; Type: TABLE; Schema: dchatdata; Owner: postgres
--

CREATE TABLE dchatdata.users (
    id bigint NOT NULL,
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE dchatdata.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16390)
-- Name: users_id_seq; Type: SEQUENCE; Schema: dchatdata; Owner: postgres
--

CREATE SEQUENCE dchatdata.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE dchatdata.users_id_seq OWNER TO postgres;

--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: dchatdata; Owner: postgres
--

ALTER SEQUENCE dchatdata.users_id_seq OWNED BY dchatdata.users.id;


--
-- TOC entry 229 (class 1259 OID 16472)
-- Name: logs; Type: TABLE; Schema: dchatlogs; Owner: postgres
--

CREATE TABLE dchatlogs.logs (
    id bigint NOT NULL,
    type text,
    message text,
    "timestamp" timestamp with time zone DEFAULT now()
);


ALTER TABLE dchatlogs.logs OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16471)
-- Name: logs_id_seq; Type: SEQUENCE; Schema: dchatlogs; Owner: postgres
--

CREATE SEQUENCE dchatlogs.logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE dchatlogs.logs_id_seq OWNER TO postgres;

--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 228
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: dchatlogs; Owner: postgres
--

ALTER SEQUENCE dchatlogs.logs_id_seq OWNED BY dchatlogs.logs.id;


--
-- TOC entry 4668 (class 2604 OID 16405)
-- Name: chats id; Type: DEFAULT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.chats ALTER COLUMN id SET DEFAULT nextval('dchatdata.chats_id_seq'::regclass);


--
-- TOC entry 4670 (class 2604 OID 16460)
-- Name: message_attachments id; Type: DEFAULT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.message_attachments ALTER COLUMN id SET DEFAULT nextval('dchatdata.message_attachments_id_seq'::regclass);


--
-- TOC entry 4669 (class 2604 OID 16427)
-- Name: messages id; Type: DEFAULT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.messages ALTER COLUMN id SET DEFAULT nextval('dchatdata.text_messages_id_seq'::regclass);


--
-- TOC entry 4667 (class 2604 OID 16394)
-- Name: users id; Type: DEFAULT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.users ALTER COLUMN id SET DEFAULT nextval('dchatdata.users_id_seq'::regclass);


--
-- TOC entry 4671 (class 2604 OID 16475)
-- Name: logs id; Type: DEFAULT; Schema: dchatlogs; Owner: postgres
--

ALTER TABLE ONLY dchatlogs.logs ALTER COLUMN id SET DEFAULT nextval('dchatlogs.logs_id_seq'::regclass);


--
-- TOC entry 4841 (class 0 OID 16408)
-- Dependencies: 223
-- Data for Name: chat_users; Type: TABLE DATA; Schema: dchatdata; Owner: postgres
--

COPY dchatdata.chat_users (chat_id, user_id) FROM stdin;
1	2
1	1
2	3
2	1
3	2
3	3
4	4
4	1
5	4
5	2
6	5
6	1
7	5
7	2
8	5
8	3
9	5
9	4
10	6
10	1
11	6
11	2
12	6
12	3
13	4
13	6
14	7
14	4
15	8
15	1
16	3
16	8
17	10
17	9
18	10
18	1
19	11
19	12
20	1
20	12
21	15
21	14
\.


--
-- TOC entry 4840 (class 0 OID 16402)
-- Dependencies: 222
-- Data for Name: chats; Type: TABLE DATA; Schema: dchatdata; Owner: postgres
--

COPY dchatdata.chats (id, created_at) FROM stdin;
1	2025-06-16 23:17:35.531169+02
2	2025-06-16 23:23:02.650876+02
3	2025-06-16 23:32:50.287509+02
4	2025-06-16 23:37:27.979064+02
5	2025-06-16 23:40:53.526978+02
6	2025-06-16 23:52:30.851169+02
7	2025-06-16 23:54:13.369629+02
8	2025-06-16 23:58:27.451151+02
9	2025-06-17 00:02:23.948903+02
10	2025-06-17 00:10:31.785213+02
11	2025-06-17 00:16:20.890271+02
12	2025-06-17 01:34:20.477806+02
13	2025-06-17 01:37:25.369986+02
14	2025-06-17 01:39:59.555374+02
15	2025-06-17 02:48:53.566875+02
16	2025-06-17 02:51:53.204814+02
17	2025-06-17 03:17:05.134486+02
18	2025-06-17 03:29:52.83176+02
19	2025-06-17 09:15:26.45073+02
20	2025-06-17 09:20:53.082957+02
21	2025-06-17 13:31:24.749626+02
\.


--
-- TOC entry 4845 (class 0 OID 16457)
-- Dependencies: 227
-- Data for Name: message_attachments; Type: TABLE DATA; Schema: dchatdata; Owner: postgres
--

COPY dchatdata.message_attachments (id, message_id, file_path) FROM stdin;
\.


--
-- TOC entry 4843 (class 0 OID 16424)
-- Dependencies: 225
-- Data for Name: messages; Type: TABLE DATA; Schema: dchatdata; Owner: postgres
--

COPY dchatdata.messages (id, chat_id, sender_id, content, sent_at) FROM stdin;
1	8	5	hi	2025-06-16 23:58:31.51091+02
2	9	5	hi	2025-06-17 00:02:27.389231+02
3	9	5	hello	2025-06-17 00:02:59.329298+02
4	10	6	hi	2025-06-17 00:10:38.081839+02
5	11	6	hello	2025-06-17 00:16:28.702262+02
6	12	6	hi	2025-06-17 01:34:25.825821+02
7	13	4	hi	2025-06-17 01:37:29.252771+02
8	14	7	hi	2025-06-17 01:40:06.073997+02
9	16	3	hi	2025-06-17 02:52:00.998171+02
10	16	8	hello	2025-06-17 02:52:56.237981+02
11	1	1	lol	2025-06-17 03:11:53.938443+02
12	15	1	why	2025-06-17 03:12:21.724423+02
13	10	1	Hello there buddy	2025-06-17 03:15:14.762736+02
14	17	10	Hello bro!	2025-06-17 03:17:16.061865+02
15	17	9	How r u doing?	2025-06-17 03:17:57.285562+02
16	17	10	oh im good ty	2025-06-17 03:18:04.390074+02
17	17	10	wanna go cs?	2025-06-17 03:18:12.269672+02
18	17	9	alright see ya then	2025-06-17 03:18:57.338818+02
19	17	10	Heeey it is so stylish now	2025-06-17 03:24:43.384891+02
20	18	10	Hi	2025-06-17 03:30:08.778883+02
21	18	10	=)	2025-06-17 03:30:13.215879+02
22	17	10	YES!	2025-06-17 03:33:20.870138+02
23	17	10	It works finally. Now i want to type a big message to check if it wraps correctly and that stuff u know	2025-06-17 03:33:53.701902+02
24	17	10	GAAAALY	2025-06-17 03:33:59.744074+02
25	18	10	hiii	2025-06-17 03:57:10.723223+02
26	19	11	Hello bro	2025-06-17 09:15:38.219791+02
27	19	12	Hi how r u	2025-06-17 09:15:48.576411+02
28	19	11	hahaha	2025-06-17 09:15:54.290393+02
29	19	11	it works	2025-06-17 09:15:56.359806+02
30	19	12	yup u r right	2025-06-17 09:16:02.859281+02
31	19	11	long message euruierhuie uirheuirheuirh ieurhuierhueirhiu iuerhueruiehrui eriuheruiehruihe iurhuiehruiehriu uiehruiehriuehrui eiurhiuehriuehriueiurhiuehrui	2025-06-17 09:16:53.063666+02
32	19	12	bye	2025-06-17 09:19:41.502453+02
33	19	12	see ya	2025-06-17 09:19:44.324175+02
34	2	1	hi	2025-06-17 09:20:41.683458+02
35	20	1	Hello	2025-06-17 09:20:57.212389+02
36	18	1	yo	2025-06-17 10:01:34.969841+02
37	18	1	dfg	2025-06-17 10:01:41.051934+02
38	18	1	f	2025-06-17 10:01:41.771284+02
39	18	1	f	2025-06-17 10:01:42.117892+02
40	18	1	g	2025-06-17 10:01:42.531152+02
41	18	1	hf	2025-06-17 10:01:43.56618+02
42	18	1	dsf	2025-06-17 10:01:44.49533+02
43	18	1	sdf	2025-06-17 10:01:45.059419+02
44	18	1	sdf	2025-06-17 10:01:45.599758+02
45	18	1	sdf	2025-06-17 10:01:45.977304+02
46	18	1	sf	2025-06-17 10:01:46.431379+02
47	18	1	sdf	2025-06-17 10:01:46.986727+02
48	18	1	sdf	2025-06-17 10:01:47.52583+02
49	18	1	sdf	2025-06-17 10:01:48.261297+02
50	18	1	sdf	2025-06-17 10:01:48.755001+02
51	18	1	sdf	2025-06-17 10:01:49.229531+02
52	18	1	sdf	2025-06-17 10:01:49.720323+02
53	18	1	sdf	2025-06-17 10:01:50.115687+02
54	18	1	sdf	2025-06-17 10:01:50.620084+02
55	18	1	sdf	2025-06-17 10:01:51.052164+02
56	18	1	sdf	2025-06-17 10:01:51.485416+02
57	18	1	gw	2025-06-17 10:01:52.271534+02
58	18	1	w	2025-06-17 10:01:52.661287+02
59	18	1	eg	2025-06-17 10:01:53.16598+02
60	18	1	gr	2025-06-17 10:01:53.555768+02
61	18	1	g	2025-06-17 10:01:54.431298+02
62	21	15	Hello	2025-06-17 13:31:54.437093+02
63	21	15	how r u doing	2025-06-17 13:32:05.762184+02
64	21	14	hi	2025-06-17 13:32:09.628058+02
\.


--
-- TOC entry 4838 (class 0 OID 16391)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: dchatdata; Owner: postgres
--

COPY dchatdata.users (id, username, password) FROM stdin;
1	Bot123	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
2	Bot1234	27562aafaf7994c84dc2f641fcb817747270c0e66bcf705b4aae050dac0ba3a4
3	Bot12345	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
4	Bot321	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
5	Bot4321	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
6	Bot111	6ffcd51fa045b35aa38b3cfbc4a7c0ca7d779b2edcae52e04028706d4665e846
7	Bot1111	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
8	Bot222	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
9	Test1	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
10	Test2	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
11	Test3	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
12	Test4	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
13	somerandom	3110556a60fe330b1e3aaa8980a38164193edfb9801beb2b4fcc500f2e09862c
14	Denys25	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
15	Denys26	918cc23afffa046fbc858f2fcf6612433c9912c8d0302ffa5304e0d6b1fea8c6
\.


--
-- TOC entry 4847 (class 0 OID 16472)
-- Dependencies: 229
-- Data for Name: logs; Type: TABLE DATA; Schema: dchatlogs; Owner: postgres
--

COPY dchatlogs.logs (id, type, message, "timestamp") FROM stdin;
1	SERVER	CONNECTED	2025-05-26 23:04:40.106258+02
2	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:04:44.491652+02
3	SERVER	CONNECTED	2025-05-26 23:07:41.044189+02
4	SERVER	RUNNING...	2025-05-26 23:19:16.658195+02
5	SERVER	RUNNING...	2025-05-26 23:20:23.546852+02
6	SERVER	RUNNING...	2025-05-26 23:21:14.37221+02
7	SERVER	RUNNING...	2025-05-26 23:21:32.072016+02
8	SERVER	RUNNING...	2025-05-26 23:24:40.190456+02
9	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:25:10.598358+02
10	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:25:12.415178+02
11	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:25:13.319603+02
12	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:25:14.667234+02
13	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:25:15.30501+02
14	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:25:15.985677+02
15	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:25:16.616942+02
16	SERVER	RUNNING...	2025-05-26 23:25:42.379739+02
17	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-26 23:26:02.712364+02
18	SERVER	RUNNING...	2025-05-29 17:03:43.635758+02
19	SERVER	RUNNING...	2025-05-29 17:04:08.72042+02
20	SERVER	RUNNING...	2025-05-29 17:15:33.664602+02
21	SERVER	RUNNING...	2025-05-29 17:30:01.6969+02
22	SERVER	RUNNING...	2025-05-29 22:20:31.273702+02
23	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-29 22:21:00.352508+02
24	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-29 22:21:05.586978+02
25	ACTION	Client /0:0:0:0:0:0:0:1 is connected...	2025-05-29 22:21:06.984587+02
26	SERVER	RUNNING...	2025-06-02 22:28:49.441188+02
27	ACTION	Client /127.0.0.1 is connected...	2025-06-02 22:29:16.464056+02
28	ACTION	Client /127.0.0.1 is connected...	2025-06-02 22:32:09.171866+02
29	ACTION	Client /127.0.0.1 is connected...	2025-06-02 22:34:53.342119+02
30	ACTION	Client /127.0.0.1 is connected...	2025-06-02 22:37:13.654094+02
31	SERVER	RUNNING...	2025-06-09 22:38:32.858841+02
32	SERVER	RUNNING...	2025-06-09 22:39:23.340798+02
33	ACTION	Client /127.0.0.1 is connected...	2025-06-09 22:39:35.249109+02
34	SERVER	RUNNING...	2025-06-09 22:54:27.079672+02
35	ACTION	Client /192.168.1.55 is connected...	2025-06-09 22:55:48.462339+02
36	ACTION	Client /192.168.1.55 is connected...	2025-06-09 22:55:48.701519+02
37	ACTION	Client /192.168.1.55 is connected...	2025-06-09 22:55:48.858505+02
38	ACTION	Client /192.168.1.55 is connected...	2025-06-09 22:56:00.373872+02
39	ACTION	Client /192.168.1.55 is connected...	2025-06-09 22:56:00.427981+02
40	ACTION	Client /192.168.1.55 is connected...	2025-06-09 22:56:00.474333+02
41	SERVER	RUNNING...	2025-06-09 23:00:11.66849+02
42	ACTION	Client /127.0.0.1 is connected...	2025-06-09 23:00:16.060468+02
43	SERVER	RUNNING...	2025-06-09 23:02:29.089883+02
44	ACTION	Client /127.0.0.1 is connected...	2025-06-09 23:02:31.389549+02
45	SERVER	RUNNING...	2025-06-11 13:29:52.173+02
46	SERVER	RUNNING...	2025-06-11 13:52:38.656669+02
47	SERVER	RUNNING...	2025-06-11 13:52:57.60239+02
48	SERVER	RUNNING...	2025-06-11 13:59:16.248543+02
49	SERVER	RUNNING...	2025-06-11 14:07:05.549885+02
50	ACTION	Client /127.0.0.1 is connected...	2025-06-11 14:07:18.957624+02
51	SERVER	RUNNING...	2025-06-11 14:54:04.459565+02
52	ACTION	Client /127.0.0.1 is connected...	2025-06-11 14:54:17.94682+02
53	ACTION	Client /127.0.0.1 is connected...	2025-06-11 14:55:28.30254+02
54	SERVER	RUNNING...	2025-06-11 14:57:24.462401+02
55	SERVER	RUNNING...	2025-06-11 14:57:30.498681+02
56	ACTION	Client /127.0.0.1 is connected...	2025-06-11 14:57:35.42941+02
57	SERVER	RUNNING...	2025-06-11 15:01:03.297434+02
58	ACTION	Client /127.0.0.1 is connected...	2025-06-11 15:01:16.655747+02
59	DISCONNECT	localhost/127.0.0.1 has disconnected.	2025-06-11 15:01:20.278649+02
60	LOGOUT	user has logged out.	2025-06-11 15:01:20.431356+02
61	LOGOUT	user has logged out.	2025-06-11 15:01:20.570809+02
62	SERVER	RUNNING...	2025-06-11 15:04:39.239735+02
63	ACTION	Client /127.0.0.1 is connected...	2025-06-11 15:04:50.121212+02
64	DISCONNECT	localhost/127.0.0.1 has disconnected.	2025-06-11 15:04:52.052772+02
65	LOGOUT	user has logged out.	2025-06-11 15:04:52.102077+02
66	LOGOUT	user has logged out.	2025-06-11 15:04:52.155818+02
67	SERVER	RUNNING...	2025-06-11 15:06:25.111185+02
68	ACTION	Client /127.0.0.1 is connected...	2025-06-11 15:06:35.24072+02
69	DISCONNECT	localhost/127.0.0.1 has disconnected.	2025-06-11 15:06:36.763463+02
70	LOGOUT	user has logged out.	2025-06-11 15:06:36.813222+02
71	LOGOUT	user has logged out.	2025-06-11 15:06:36.867958+02
72	SERVER	RUNNING...	2025-06-11 15:07:15.052131+02
73	SERVER	RUNNING...	2025-06-11 15:11:02.354563+02
74	SERVER	RUNNING...	2025-06-11 15:13:11.820889+02
75	SERVER	RUNNING...	2025-06-11 15:13:25.012223+02
76	SERVER	RUNNING...	2025-06-11 15:55:06.236765+02
77	ACTION	Client /127.0.0.1 is connected...	2025-06-11 15:55:19.260328+02
78	LOGOUT	user has logged out.	2025-06-11 15:55:21.270642+02
79	LOGOUT	user has logged out.	2025-06-11 15:55:21.329925+02
80	SERVER	RUNNING...	2025-06-11 15:56:02.576998+02
81	SERVER	RUNNING...	2025-06-11 15:57:49.788053+02
82	ACTION	Client /127.0.0.1 is connected...	2025-06-11 15:57:58.560798+02
83	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-11 15:58:01.415988+02
84	SERVER	RUNNING...	2025-06-11 15:58:16.930987+02
85	SERVER	RUNNING...	2025-06-11 16:00:07.427953+02
86	SERVER	RUNNING...	2025-06-11 16:02:01.004838+02
87	SERVER	RUNNING...	2025-06-11 21:29:14.9223+02
88	ACTION	Client /127.0.0.1 is connected...	2025-06-11 21:29:32.326378+02
89	SERVER	RUNNING...	2025-06-11 21:51:16.773446+02
90	ACTION	Client /127.0.0.1 is connected...	2025-06-11 21:51:40.371755+02
91	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-11 21:53:11.984889+02
92	SERVER	RUNNING...	2025-06-12 11:06:30.596066+02
93	SERVER	RUNNING...	2025-06-12 11:08:22.015455+02
94	SERVER	RUNNING...	2025-06-12 12:11:46.779831+02
95	SERVER	RUNNING...	2025-06-12 12:12:25.104687+02
96	SERVER	RUNNING...	2025-06-12 12:18:24.801302+02
97	SERVER	RUNNING...	2025-06-12 12:18:44.231613+02
98	SERVER	RUNNING...	2025-06-12 12:24:29.242325+02
99	SERVER	RUNNING...	2025-06-12 14:35:06.636645+02
100	SERVER	RUNNING...	2025-06-12 14:41:18.760023+02
101	ACTION	Client /127.0.0.1 is connected...	2025-06-12 14:41:31.381417+02
102	REGISTER	user Bot123 has registered	2025-06-12 14:41:55.056189+02
103	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 14:42:32.016105+02
104	ACTION	Client /127.0.0.1 is connected...	2025-06-12 14:42:38.766524+02
105	LOGIN	user Bot123 has logged in	2025-06-12 14:42:54.319332+02
106	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 14:43:01.515586+02
107	ACTION	Client /127.0.0.1 is connected...	2025-06-12 14:45:11.789999+02
108	LOGIN	user Bot123 has logged in	2025-06-12 14:45:22.416501+02
109	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 14:45:39.102953+02
110	ACTION	Client /127.0.0.1 is connected...	2025-06-12 14:50:22.331764+02
111	LOGIN	user Bot123 has logged in	2025-06-12 14:50:42.938851+02
112	ACTION	Client /127.0.0.1 is connected...	2025-06-12 15:10:06.390008+02
113	LOGIN	user Bot123 has logged in	2025-06-12 15:10:19.590845+02
114	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 15:10:38.75399+02
115	ACTION	Client /127.0.0.1 is connected...	2025-06-12 15:15:13.698812+02
116	LOGIN	user Bot123 has logged in	2025-06-12 15:15:25.487683+02
117	ACTION	Client /127.0.0.1 is connected...	2025-06-12 15:15:49.850517+02
118	LOGIN	user Bot123 has logged in	2025-06-12 15:15:58.719883+02
119	SERVER	RUNNING...	2025-06-12 15:24:52.768595+02
120	ACTION	Client /127.0.0.1 is connected...	2025-06-12 15:25:03.279191+02
121	LOGIN	user Bot123 has logged in	2025-06-12 15:25:14.432425+02
122	SERVER	RUNNING...	2025-06-12 16:49:04.730288+02
123	ACTION	Client /127.0.0.1 is connected...	2025-06-12 16:49:15.94988+02
124	LOGIN	user Bot123 has logged in	2025-06-12 16:49:34.984416+02
125	ACTION	Client /127.0.0.1 is connected...	2025-06-12 16:49:47.719466+02
126	LOGIN	user Bot123 has logged in	2025-06-12 16:50:00.935997+02
127	ACTION	Client /127.0.0.1 is connected...	2025-06-12 17:14:25.799393+02
128	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 17:14:27.790246+02
129	SERVER	RUNNING...	2025-06-12 17:30:35.169478+02
130	ACTION	Client /127.0.0.1 is connected...	2025-06-12 17:30:48.647378+02
131	LOGIN	user Bot123 has logged in	2025-06-12 17:31:09.267294+02
132	ACTION	Client /127.0.0.1 is connected...	2025-06-12 17:31:24.566739+02
133	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 17:31:26.403068+02
134	SERVER	RUNNING...	2025-06-12 19:32:33.851263+02
135	ACTION	Client /127.0.0.1 is connected...	2025-06-12 19:32:46.755228+02
136	LOGIN	user Bot123 has logged in	2025-06-12 19:32:59.113381+02
137	SERVER	RUNNING...	2025-06-12 19:41:34.120514+02
138	ACTION	Client /127.0.0.1 is connected...	2025-06-12 19:41:47.120256+02
139	LOGIN	user Bot123 has logged in	2025-06-12 19:42:00.36115+02
140	LOGOUT	Bot123 has logged out.	2025-06-12 19:42:03.087387+02
141	LOGIN	user Socket[addr=localhost/127.0.0.1,port=8080,localport=63644] has logged in	2025-06-12 19:42:03.12944+02
142	LOGOUT	user has logged out.	2025-06-12 19:42:03.190641+02
143	ACTION	Client /127.0.0.1 is connected...	2025-06-12 19:42:12.014346+02
144	LOGIN	user Bot123 has logged in	2025-06-12 19:42:23.459723+02
145	LOGOUT	Bot123 has logged out.	2025-06-12 19:42:29.587981+02
146	LOGIN	user Socket[addr=localhost/127.0.0.1,port=8080,localport=63660] has logged in	2025-06-12 19:42:29.80565+02
147	LOGOUT	user has logged out.	2025-06-12 19:42:29.860142+02
148	ACTION	Client /127.0.0.1 is connected...	2025-06-12 19:50:27.589616+02
149	LOGIN	user Bot123 has logged in	2025-06-12 19:50:48.11521+02
150	LOGOUT	Bot123 has logged out.	2025-06-12 19:50:51.357899+02
151	LOGIN	user Socket[addr=localhost/127.0.0.1,port=8080,localport=63818] has logged in	2025-06-12 19:50:51.405147+02
152	LOGOUT	user has logged out.	2025-06-12 19:50:51.449255+02
153	ACTION	Client /127.0.0.1 is connected...	2025-06-12 19:51:41.009572+02
154	LOGIN	user Bot123 has logged in	2025-06-12 19:51:54.871265+02
155	LOGOUT	Bot123 has logged out.	2025-06-12 19:52:00.47379+02
156	LOGIN	user Socket[addr=localhost/127.0.0.1,port=8080,localport=63847] has logged in	2025-06-12 19:52:00.52187+02
157	LOGOUT	user has logged out.	2025-06-12 19:52:00.567661+02
158	SERVER	RUNNING...	2025-06-12 19:57:51.866758+02
159	ACTION	Client /127.0.0.1 is connected...	2025-06-12 19:58:03.4875+02
160	LOGIN	user Bot123 has logged in	2025-06-12 19:58:14.379773+02
161	LOGOUT	Bot123 has logged out.	2025-06-12 19:58:18.164562+02
162	LOGOUT	user Socket[addr=localhost/127.0.0.1,port=8080,localport=63990] has logged out	2025-06-12 19:58:18.219947+02
163	LOGOUT	user has logged out.	2025-06-12 19:58:18.285851+02
164	SERVER	RUNNING...	2025-06-12 20:03:11.479475+02
165	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:03:23.320796+02
166	LOGIN	user Bot123 has logged in	2025-06-12 20:03:37.948004+02
167	LOGOUT	Bot123 has logged out.	2025-06-12 20:03:44.410739+02
168	LOGOUT	user has logged out.	2025-06-12 20:03:44.46877+02
169	SERVER	RUNNING...	2025-06-12 20:11:16.000545+02
170	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:11:22.747212+02
171	LOGIN	user Bot123 has logged in	2025-06-12 20:11:35.336813+02
172	LOGOUT	Bot123 has logged out.	2025-06-12 20:11:37.032709+02
173	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:18:01.149096+02
174	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 20:18:05.235109+02
175	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:19:12.285297+02
176	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 20:19:17.155024+02
177	SERVER	RUNNING...	2025-06-12 20:23:37.63988+02
178	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:23:51.053387+02
179	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 20:23:52.57546+02
180	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:23:56.394375+02
181	LOGIN	user Bot123 has logged in	2025-06-12 20:24:09.608936+02
182	LOGOUT	Bot123 has logged out.	2025-06-12 20:24:24.351127+02
183	LOGOUT	user has logged out.	2025-06-12 20:24:24.403707+02
184	SERVER	RUNNING...	2025-06-12 20:27:00.008098+02
185	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:27:09.5223+02
186	LOGIN	user Bot123 has logged in	2025-06-12 20:27:23.661941+02
187	LOGOUT	Bot123 has logged out.	2025-06-12 20:27:27.270731+02
188	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:27:38.4035+02
189	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-12 20:27:46.900654+02
190	SERVER	RUNNING...	2025-06-12 20:29:02.300276+02
191	ACTION	Client /127.0.0.1 is connected...	2025-06-12 20:29:09.664263+02
192	LOGIN	user Bot123 has logged in	2025-06-12 20:29:19.75104+02
193	LOGOUT	Bot123 has logged out.	2025-06-12 20:29:21.957208+02
194	SERVER	RUNNING...	2025-06-12 20:50:38.827421+02
195	SERVER	RUNNING...	2025-06-13 00:17:24.600272+02
196	ACTION	Client /127.0.0.1 is connected...	2025-06-13 00:17:38.936577+02
197	LOGIN	user Bot123 has logged in	2025-06-13 00:17:51.054249+02
198	LOGOUT	Bot123 has logged out.	2025-06-13 00:18:11.399874+02
199	ACTION	Client /127.0.0.1 is connected...	2025-06-13 00:21:51.76832+02
200	LOGIN	user Bot123 has logged in	2025-06-13 00:22:00.490511+02
201	LOGOUT	Bot123 has logged out.	2025-06-13 00:22:56.157814+02
202	ACTION	Client /127.0.0.1 is connected...	2025-06-13 00:28:43.349816+02
203	LOGIN	user Bot123 has logged in	2025-06-13 00:28:52.550481+02
204	LOGOUT	Bot123 has logged out.	2025-06-13 00:28:56.476044+02
205	SERVER	RUNNING...	2025-06-13 11:02:39.325948+02
206	ACTION	Client /127.0.0.1 is connected...	2025-06-13 11:02:49.931429+02
207	LOGIN	user Bot123 has logged in	2025-06-13 11:03:00.204114+02
208	LOGOUT	Bot123 has logged out.	2025-06-13 11:03:35.755386+02
209	SERVER	RUNNING...	2025-06-14 00:23:28.564853+02
210	ACTION	Client /127.0.0.1 is connected...	2025-06-14 00:23:42.300344+02
211	LOGIN	user Bot123 has logged in	2025-06-14 00:23:53.423029+02
212	ACTION	Client /127.0.0.1 is connected...	2025-06-14 00:25:37.47557+02
213	LOGIN	user Bot123 has logged in	2025-06-14 00:25:48.631354+02
214	ACTION	Client /127.0.0.1 is connected...	2025-06-14 00:27:52.473801+02
215	LOGIN	user Bot123 has logged in	2025-06-14 00:28:02.64866+02
216	LOGOUT	Bot123 has logged out.	2025-06-14 00:28:20.572526+02
217	ACTION	Client /127.0.0.1 is connected...	2025-06-14 00:29:36.329125+02
218	LOGIN	user Bot123 has logged in	2025-06-14 00:29:46.493822+02
219	LOGOUT	Bot123 has logged out.	2025-06-14 00:29:54.495062+02
220	SERVER	RUNNING...	2025-06-15 22:57:23.665284+02
221	ACTION	Client /127.0.0.1 is connected...	2025-06-15 22:57:38.401489+02
222	LOGIN	user Bot123 has logged in	2025-06-15 22:57:52.132173+02
223	LOGOUT	Bot123 has logged out.	2025-06-15 22:58:13.03822+02
224	SERVER	RUNNING...	2025-06-16 00:22:57.635693+02
225	ACTION	Client /127.0.0.1 is connected...	2025-06-16 00:23:08.7334+02
226	LOGIN	user Bot123 has logged in	2025-06-16 00:23:22.520888+02
227	ACTION	Client /127.0.0.1 is connected...	2025-06-16 00:32:31.431017+02
228	LOGIN	user Bot123 has logged in	2025-06-16 00:32:44.616602+02
229	LOGOUT	Bot123 has logged out.	2025-06-16 00:33:13.558526+02
230	SERVER	RUNNING...	2025-06-16 11:24:33.027149+02
231	ACTION	Client /127.0.0.1 is connected...	2025-06-16 11:24:45.627391+02
232	LOGIN	user Bot123 has logged in	2025-06-16 11:25:01.914335+02
233	LOGOUT	Bot123 has logged out.	2025-06-16 11:25:19.011777+02
234	SERVER	RUNNING...	2025-06-16 23:15:55.983694+02
235	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:16:16.573364+02
236	LOGIN	user Bot123 has logged in	2025-06-16 23:16:26.682114+02
237	LOGOUT	Bot123 has logged out.	2025-06-16 23:16:51.834004+02
238	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:16:55.227018+02
239	REGISTER	user Bot1234 has registered	2025-06-16 23:17:22.620922+02
240	CHAT	User Bot1234 created chat with Bot123	2025-06-16 23:17:35.579317+02
241	LOGOUT	Bot1234 has logged out.	2025-06-16 23:18:31.999444+02
242	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:21:57.481601+02
243	LOGIN	user Bot1234 has logged in	2025-06-16 23:22:13.510298+02
244	LOGOUT	Bot1234 has logged out.	2025-06-16 23:22:39.466425+02
245	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:22:42.712481+02
246	REGISTER	user Bot12345 has registered	2025-06-16 23:22:55.055953+02
247	CHAT	User Bot12345 created chat with Bot123	2025-06-16 23:23:02.715823+02
248	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:32:25.16824+02
249	LOGIN	user Bot1234 has logged in	2025-06-16 23:32:43.028646+02
250	CHAT	User Bot1234 created chat with Bot12345	2025-06-16 23:32:50.337816+02
251	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:37:08.465847+02
252	REGISTER	user Bot321 has registered	2025-06-16 23:37:22.186251+02
253	CHAT	User Bot321 created chat with Bot123	2025-06-16 23:37:28.029663+02
254	LOGOUT	Bot321 has logged out.	2025-06-16 23:38:04.501337+02
255	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:40:35.577905+02
256	LOGIN	user Bot321 has logged in	2025-06-16 23:40:48.259003+02
257	CHAT	User Bot321 created chat with Bot1234	2025-06-16 23:40:53.582445+02
258	LOGOUT	Bot321 has logged out.	2025-06-16 23:41:29.882735+02
259	SERVER	RUNNING...	2025-06-16 23:50:35.556965+02
260	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:50:50.76212+02
261	LOGIN	user Bot1234 has logged in	2025-06-16 23:51:09.536829+02
262	LOGOUT	Bot1234 has logged out.	2025-06-16 23:52:01.671466+02
263	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:52:04.116833+02
264	REGISTER	user Bot4321 has registered	2025-06-16 23:52:18.234267+02
265	CHAT	User Bot4321 created chat with Bot123	2025-06-16 23:52:30.996586+02
266	LOGOUT	Bot4321 has logged out.	2025-06-16 23:53:13.106487+02
267	SERVER	RUNNING...	2025-06-16 23:53:48.977545+02
268	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:53:50.7875+02
269	LOGIN	user Bot4321 has logged in	2025-06-16 23:54:07.512057+02
270	CHAT	User Bot4321 created chat with Bot1234	2025-06-16 23:54:13.431377+02
271	LOGOUT	Bot4321 has logged out.	2025-06-16 23:54:39.89449+02
272	SERVER	RUNNING...	2025-06-16 23:57:55.22109+02
273	ACTION	Client /127.0.0.1 is connected...	2025-06-16 23:58:04.882035+02
274	LOGIN	user Bot4321 has logged in	2025-06-16 23:58:16.25091+02
275	CHAT	User Bot4321 created chat with Bot12345	2025-06-16 23:58:27.504655+02
276	MESSAGE	user Bot4321 sent a message to user Bot12345	2025-06-16 23:58:31.549642+02
277	LOGOUT	Bot4321 has logged out.	2025-06-17 00:00:46.340092+02
278	ACTION	Client /127.0.0.1 is connected...	2025-06-17 00:01:58.159253+02
279	LOGIN	user Bot4321 has logged in	2025-06-17 00:02:11.704638+02
280	CHAT	User Bot4321 created chat with Bot321	2025-06-17 00:02:24.000209+02
281	MESSAGE	user Bot4321 sent a message to user Bot321	2025-06-17 00:02:27.426453+02
282	MESSAGE	user Bot4321 sent a message to user Bot321	2025-06-17 00:02:59.37701+02
283	LOGOUT	Bot4321 has logged out.	2025-06-17 00:05:45.593951+02
284	ACTION	Client /192.168.1.41 is connected...	2025-06-17 00:09:25.154305+02
285	REGISTER	user Bot111 has registered	2025-06-17 00:09:46.187844+02
286	ACTION	Client /127.0.0.1 is connected...	2025-06-17 00:10:05.626891+02
287	LOGIN	user Bot123 has logged in	2025-06-17 00:10:19.659256+02
288	CHAT	User Bot111 created chat with Bot123	2025-06-17 00:10:31.8323+02
289	MESSAGE	user Bot111 sent a message to user Bot123	2025-06-17 00:10:38.128662+02
290	LOGOUT	Bot111 has logged out.	2025-06-17 00:11:19.803082+02
291	ACTION	Client /192.168.1.41 is connected...	2025-06-17 00:15:40.184745+02
292	ACTION	Client /127.0.0.1 is connected...	2025-06-17 00:15:48.055825+02
293	LOGIN	user Bot111 has logged in	2025-06-17 00:15:55.902127+02
294	LOGIN	user Bot1234 has logged in	2025-06-17 00:16:08.824978+02
295	CHAT	User Bot111 created chat with Bot1234	2025-06-17 00:16:20.937273+02
296	MESSAGE	user Bot111 sent a message to user Bot1234	2025-06-17 00:16:28.749322+02
297	SERVER	RUNNING...	2025-06-17 01:32:29.628424+02
298	ACTION	Client /127.0.0.1 is connected...	2025-06-17 01:32:41.049417+02
299	LOGIN	user Bot12345 has logged in	2025-06-17 01:32:58.740785+02
300	ACTION	Client /192.168.1.41 is connected...	2025-06-17 01:33:56.32093+02
301	LOGIN	user Bot111 has logged in	2025-06-17 01:34:05.385366+02
302	CHAT	User Bot111 created chat with Bot12345	2025-06-17 01:34:20.670702+02
303	MESSAGE	user Bot111 sent a message to user Bot12345	2025-06-17 01:34:25.882142+02
304	ACTION	Client /127.0.0.1 is connected...	2025-06-17 01:36:46.689512+02
305	LOGIN	user Bot12345 has logged in	2025-06-17 01:36:58.570966+02
306	LOGOUT	Bot12345 has logged out.	2025-06-17 01:37:04.889835+02
307	ACTION	Client /127.0.0.1 is connected...	2025-06-17 01:37:07.381497+02
308	LOGIN	user Bot321 has logged in	2025-06-17 01:37:15.605109+02
309	CHAT	User Bot321 created chat with Bot111	2025-06-17 01:37:25.421875+02
310	MESSAGE	user Bot321 sent a message to user Bot111	2025-06-17 01:37:29.302058+02
311	ACTION	Client /192.168.1.41 is connected...	2025-06-17 01:39:30.130819+02
312	REGISTER	user Bot1111 has registered	2025-06-17 01:39:47.091863+02
313	CHAT	User Bot1111 created chat with Bot321	2025-06-17 01:39:59.60462+02
314	MESSAGE	user Bot1111 sent a message to user Bot321	2025-06-17 01:40:06.121489+02
315	LOGOUT	Bot321 has logged out.	2025-06-17 01:42:49.962731+02
316	LOGOUT	Bot1111 has logged out.	2025-06-17 01:42:56.622337+02
317	SERVER	RUNNING...	2025-06-17 02:24:54.13319+02
318	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:25:05.316166+02
319	LOGIN	user Bot123 has logged in	2025-06-17 02:25:16.38131+02
320	SERVER	RUNNING...	2025-06-17 02:28:22.898316+02
321	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:28:36.332233+02
322	LOGIN	user Bot123 has logged in	2025-06-17 02:28:46.080953+02
323	SERVER	RUNNING...	2025-06-17 02:43:58.876553+02
324	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:44:07.232963+02
325	LOGIN	user Bot123 has logged in	2025-06-17 02:44:18.346461+02
326	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-17 02:44:28.116483+02
327	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:44:53.166184+02
328	LOGIN	user Bot123 has logged in	2025-06-17 02:45:01.580812+02
329	LOGOUT	Bot123 has logged out.	2025-06-17 02:45:31.012478+02
330	SERVER	RUNNING...	2025-06-17 02:47:21.068971+02
331	ACTION	Client /192.168.1.41 is connected...	2025-06-17 02:48:07.541539+02
332	REGISTER	user Bot222 has registered	2025-06-17 02:48:22.124937+02
333	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:48:35.586614+02
334	LOGIN	user Bot123 has logged in	2025-06-17 02:48:48.845579+02
335	CHAT	User Bot222 created chat with Bot123	2025-06-17 02:48:53.630807+02
336	LOGOUT	Bot222 has logged out.	2025-06-17 02:49:29.109356+02
337	ACTION	Client /192.168.1.41 is connected...	2025-06-17 02:50:39.377061+02
338	LOGIN	user Bot222 has logged in	2025-06-17 02:50:49.932901+02
339	LOGOUT	Bot123 has logged out.	2025-06-17 02:50:59.636303+02
340	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:51:38.45894+02
341	LOGIN	user Bot12345 has logged in	2025-06-17 02:51:46.637723+02
342	CHAT	User Bot12345 created chat with Bot222	2025-06-17 02:51:53.373586+02
343	MESSAGE	user Bot12345 sent a message to user Bot222	2025-06-17 02:52:01.205651+02
344	MESSAGE	user Bot222 sent a message to user Bot12345	2025-06-17 02:52:56.431155+02
345	LOGOUT	Bot12345 has logged out.	2025-06-17 02:53:21.386766+02
346	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:53:25.515038+02
347	LOGIN	user Bot12345 has logged in	2025-06-17 02:53:34.538755+02
348	LOGOUT	Bot12345 has logged out.	2025-06-17 02:53:38.799629+02
349	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:57:53.563223+02
350	LOGIN	user Bot123 has logged in	2025-06-17 02:58:12.285143+02
351	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:58:47.88337+02
352	LOGIN	user Bot123 has logged in	2025-06-17 02:58:57.069778+02
353	LOGOUT	Bot123 has logged out.	2025-06-17 02:59:08.541503+02
354	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:59:27.076516+02
355	LOGIN	user Bot123 has logged in	2025-06-17 02:59:35.166226+02
356	LOGOUT	Bot123 has logged out.	2025-06-17 02:59:45.936271+02
357	ACTION	Client /127.0.0.1 is connected...	2025-06-17 02:59:49.865818+02
358	LOGIN	user Bot12345 has logged in	2025-06-17 02:59:58.36033+02
359	LOGOUT	Bot12345 has logged out.	2025-06-17 03:00:01.328757+02
360	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:06:36.174723+02
361	LOGIN	user Bot123 has logged in	2025-06-17 03:06:44.718359+02
362	LOGOUT	Bot123 has logged out.	2025-06-17 03:07:12.93271+02
363	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:08:32.084736+02
364	LOGIN	user Bot123 has logged in	2025-06-17 03:08:43.480005+02
365	LOGOUT	Bot123 has logged out.	2025-06-17 03:10:39.411648+02
366	SERVER	RUNNING...	2025-06-17 03:11:32.232644+02
367	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:11:38.005031+02
368	LOGIN	user Bot123 has logged in	2025-06-17 03:11:46.18227+02
369	MESSAGE	user Bot123 sent a message to user Bot1234	2025-06-17 03:11:54.090735+02
370	MESSAGE	user Bot123 sent a message to user Bot222	2025-06-17 03:12:21.773755+02
371	LOGOUT	Bot123 has logged out.	2025-06-17 03:12:29.933392+02
372	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:14:52.319601+02
373	LOGIN	user Bot123 has logged in	2025-06-17 03:15:02.017456+02
374	MESSAGE	user Bot123 sent a message to user Bot111	2025-06-17 03:15:14.813052+02
375	LOGOUT	Bot123 has logged out.	2025-06-17 03:15:28.121488+02
376	ACTION	Client /192.168.1.41 is connected...	2025-06-17 03:16:30.316426+02
377	REGISTER	user Test1 has registered	2025-06-17 03:16:44.271353+02
378	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:16:49.742401+02
379	REGISTER	user Test2 has registered	2025-06-17 03:16:57.776561+02
380	CHAT	User Test2 created chat with Test1	2025-06-17 03:17:05.194991+02
381	MESSAGE	user Test2 sent a message to user Test1	2025-06-17 03:17:16.115642+02
382	MESSAGE	user Test1 sent a message to user Test2	2025-06-17 03:17:57.325193+02
383	MESSAGE	user Test2 sent a message to user Test1	2025-06-17 03:18:04.428179+02
384	MESSAGE	user Test2 sent a message to user Test1	2025-06-17 03:18:12.316149+02
385	LOGOUT	Test2 has logged out.	2025-06-17 03:18:48.656789+02
386	MESSAGE	user Test1 sent a message to user Test2	2025-06-17 03:18:57.376382+02
387	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:19:03.061816+02
388	LOGIN	user Test2 has logged in	2025-06-17 03:19:15.645168+02
389	LOGOUT	Test2 has logged out.	2025-06-17 03:19:42.372158+02
390	LOGOUT	Test1 has logged out.	2025-06-17 03:19:49.355837+02
391	SERVER	RUNNING...	2025-06-17 03:24:01.56752+02
392	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:24:07.760802+02
393	LOGIN	user Test2 has logged in	2025-06-17 03:24:20.572297+02
394	MESSAGE	user Test2 sent a message to user Test1	2025-06-17 03:24:43.598407+02
395	LOGOUT	Test2 has logged out.	2025-06-17 03:26:00.03833+02
396	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:29:18.201416+02
397	LOGIN	user Test2 has logged in	2025-06-17 03:29:29.202583+02
398	CHAT	User Test2 created chat with Bot123	2025-06-17 03:29:52.884812+02
399	MESSAGE	user Test2 sent a message to user Bot123	2025-06-17 03:30:08.835583+02
400	MESSAGE	user Test2 sent a message to user Bot123	2025-06-17 03:30:13.263721+02
401	LOGOUT	Test2 has logged out.	2025-06-17 03:30:31.237634+02
402	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:32:58.770317+02
403	LOGIN	user Test2 has logged in	2025-06-17 03:33:07.095825+02
404	MESSAGE	user Test2 sent a message to user Test1	2025-06-17 03:33:21.065134+02
405	MESSAGE	user Test2 sent a message to user Test1	2025-06-17 03:33:53.750725+02
406	MESSAGE	user Test2 sent a message to user Test1	2025-06-17 03:33:59.795957+02
407	LOGOUT	Test2 has logged out.	2025-06-17 03:34:13.826766+02
408	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:35:57.523421+02
409	LOGIN	user Test2 has logged in	2025-06-17 03:36:10.034263+02
410	LOGOUT	Test2 has logged out.	2025-06-17 03:36:55.88855+02
411	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:39:55.345338+02
412	LOGIN	user Test2 has logged in	2025-06-17 03:40:07.422583+02
413	LOGOUT	Test2 has logged out.	2025-06-17 03:40:21.385135+02
414	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:48:55.877336+02
415	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-17 03:48:57.878545+02
416	SERVER	RUNNING...	2025-06-17 03:56:43.641898+02
417	ACTION	Client /127.0.0.1 is connected...	2025-06-17 03:56:52.513029+02
418	LOGIN	user Test2 has logged in	2025-06-17 03:57:01.553135+02
419	MESSAGE	user Test2 sent a message to user Bot123	2025-06-17 03:57:10.779386+02
420	LOGOUT	Test2 has logged out.	2025-06-17 03:57:35.930398+02
421	LOGOUT	user has logged out.	2025-06-17 03:57:35.98008+02
422	SERVER	RUNNING...	2025-06-17 09:12:30.845736+02
423	ACTION	Client /192.168.1.41 is connected...	2025-06-17 09:13:42.349009+02
424	ACTION	Client /127.0.0.1 is connected...	2025-06-17 09:14:02.12542+02
425	REGISTER	user Test3 has registered	2025-06-17 09:14:37.524394+02
426	REGISTER	user Test4 has registered	2025-06-17 09:14:51.783347+02
427	CHAT	User Test3 created chat with Test4	2025-06-17 09:15:26.506405+02
428	MESSAGE	user Test3 sent a message to user Test4	2025-06-17 09:15:38.277008+02
429	MESSAGE	user Test4 sent a message to user Test3	2025-06-17 09:15:48.726548+02
430	MESSAGE	user Test3 sent a message to user Test4	2025-06-17 09:15:54.440818+02
431	MESSAGE	user Test3 sent a message to user Test4	2025-06-17 09:15:56.402049+02
432	MESSAGE	user Test4 sent a message to user Test3	2025-06-17 09:16:03.004836+02
433	MESSAGE	user Test3 sent a message to user Test4	2025-06-17 09:16:53.21429+02
434	ACTION	Client /192.168.1.55 is connected...	2025-06-17 09:18:51.080501+02
435	ACTION	Client /192.168.1.55 is connected...	2025-06-17 09:18:51.128772+02
436	LOGOUT	user has logged out.	2025-06-17 09:18:51.171497+02
437	LOGOUT	user has logged out.	2025-06-17 09:18:51.276453+02
438	ACTION	Client /192.168.1.55 is connected...	2025-06-17 09:18:51.289113+02
439	LOGOUT	user has logged out.	2025-06-17 09:18:51.328873+02
440	LOGOUT	Test3 has logged out.	2025-06-17 09:19:37.223077+02
441	LOGOUT	user has logged out.	2025-06-17 09:19:37.262386+02
442	MESSAGE	user Test4 sent a message to user Test3	2025-06-17 09:19:41.548678+02
443	MESSAGE	user Test4 sent a message to user Test3	2025-06-17 09:19:44.370211+02
444	ACTION	Client /127.0.0.1 is connected...	2025-06-17 09:19:49.815458+02
445	LOGIN	user Test3 has logged in	2025-06-17 09:20:03.795441+02
446	LOGOUT	Test3 has logged out.	2025-06-17 09:20:11.294223+02
447	LOGOUT	user has logged out.	2025-06-17 09:20:11.33311+02
448	ACTION	Client /127.0.0.1 is connected...	2025-06-17 09:20:20.703373+02
449	LOGIN	user Bot123 has logged in	2025-06-17 09:20:29.401584+02
450	MESSAGE	user Bot123 sent a message to user Bot12345	2025-06-17 09:20:41.886826+02
451	CHAT	User Bot123 created chat with Test4	2025-06-17 09:20:53.267498+02
452	MESSAGE	user Bot123 sent a message to user Test4	2025-06-17 09:20:57.358325+02
453	LOGOUT	Test4 has logged out.	2025-06-17 09:21:17.830149+02
454	LOGOUT	user has logged out.	2025-06-17 09:21:18.033438+02
455	LOGOUT	Bot123 has logged out.	2025-06-17 09:21:23.094541+02
456	LOGOUT	user has logged out.	2025-06-17 09:21:23.140498+02
457	SERVER	RUNNING...	2025-06-17 09:29:52.917328+02
458	SERVER	RUNNING...	2025-06-17 09:47:57.526723+02
459	ACTION	Client /127.0.0.1 is connected...	2025-06-17 09:50:01.389614+02
460	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-17 09:50:04.326351+02
461	LOGOUT	user has logged out.	2025-06-17 09:50:04.375184+02
462	SERVER	RUNNING...	2025-06-17 09:53:38.795692+02
463	ACTION	Client /127.0.0.1 is connected...	2025-06-17 09:53:47.790059+02
464	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-17 09:53:49.663846+02
465	ACTION	Client /127.0.0.1 is connected...	2025-06-17 09:53:58.614734+02
466	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-17 09:54:01.205573+02
467	ACTION	Client /127.0.0.1 is connected...	2025-06-17 09:54:12.939043+02
468	LOGIN	user Bot123 has logged in	2025-06-17 09:54:21.921043+02
469	SERVER	RUNNING...	2025-06-17 10:00:51.005711+02
470	ACTION	Client /127.0.0.1 is connected...	2025-06-17 10:01:01.778574+02
471	LOGIN	user Bot123 has logged in	2025-06-17 10:01:21.332569+02
472	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:35.020256+02
473	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:41.256314+02
474	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:41.820907+02
475	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:42.16916+02
476	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:42.679254+02
477	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:43.613138+02
478	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:44.703798+02
479	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:45.106784+02
480	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:45.812804+02
481	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:46.023286+02
482	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:46.477552+02
483	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:47.036237+02
484	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:47.712287+02
485	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:48.458778+02
486	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:48.803815+02
487	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:49.27569+02
488	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:49.769601+02
489	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:50.165799+02
490	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:50.668587+02
491	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:51.098211+02
492	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:51.524186+02
493	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:52.468059+02
494	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:52.700157+02
495	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:53.214233+02
496	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:53.592995+02
497	MESSAGE	user Bot123 sent a message to user Test2	2025-06-17 10:01:54.480757+02
498	LOGOUT	Bot123 has logged out.	2025-06-17 10:02:00.609685+02
499	LOGOUT	user has logged out.	2025-06-17 10:02:00.650268+02
500	SERVER	RUNNING...	2025-06-17 12:51:38.503156+02
501	ACTION	Client /127.0.0.1 is connected...	2025-06-17 12:51:40.001229+02
502	DISCONNECT	localhost/127.0.0.1 has logged out.	2025-06-17 12:51:41.771429+02
503	LOGOUT	user has logged out.	2025-06-17 12:51:41.861072+02
504	ACTION	Client /127.0.0.1 is connected...	2025-06-17 12:51:49.065498+02
505	REGISTER	user somerandom has registered	2025-06-17 12:52:09.907353+02
506	LOGOUT	somerandom has logged out.	2025-06-17 12:52:12.651985+02
507	LOGOUT	user has logged out.	2025-06-17 12:52:12.700648+02
508	SERVER	RUNNING...	2025-06-17 13:27:45.745591+02
509	ACTION	Client /127.0.0.1 is connected...	2025-06-17 13:28:20.546422+02
510	REGISTER	user Denys25 has registered	2025-06-17 13:29:58.556434+02
511	ACTION	Client /192.168.1.41 is connected...	2025-06-17 13:30:27.767309+02
512	REGISTER	user Denys26 has registered	2025-06-17 13:30:46.571638+02
513	CHAT	User Denys26 created chat with Denys25	2025-06-17 13:31:24.819322+02
514	MESSAGE	user Denys26 sent a message to user Denys25	2025-06-17 13:31:54.598589+02
515	MESSAGE	user Denys26 sent a message to user Denys25	2025-06-17 13:32:05.81722+02
516	MESSAGE	user Denys25 sent a message to user Denys26	2025-06-17 13:32:09.779323+02
517	LOGOUT	Denys25 has logged out.	2025-06-17 13:33:05.260531+02
518	LOGOUT	user has logged out.	2025-06-17 13:33:05.321832+02
519	LOGOUT	Denys26 has logged out.	2025-06-17 13:33:11.522355+02
520	LOGOUT	user has logged out.	2025-06-17 13:33:11.577067+02
\.


--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 221
-- Name: chats_id_seq; Type: SEQUENCE SET; Schema: dchatdata; Owner: postgres
--

SELECT pg_catalog.setval('dchatdata.chats_id_seq', 21, true);


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 226
-- Name: message_attachments_id_seq; Type: SEQUENCE SET; Schema: dchatdata; Owner: postgres
--

SELECT pg_catalog.setval('dchatdata.message_attachments_id_seq', 1, false);


--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 224
-- Name: text_messages_id_seq; Type: SEQUENCE SET; Schema: dchatdata; Owner: postgres
--

SELECT pg_catalog.setval('dchatdata.text_messages_id_seq', 64, true);


--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: dchatdata; Owner: postgres
--

SELECT pg_catalog.setval('dchatdata.users_id_seq', 15, true);


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 228
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: dchatlogs; Owner: postgres
--

SELECT pg_catalog.setval('dchatlogs.logs_id_seq', 520, true);


--
-- TOC entry 4678 (class 2606 OID 16407)
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);


--
-- TOC entry 4680 (class 2606 OID 16412)
-- Name: chat_users composite_pk_chat_users; Type: CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.chat_users
    ADD CONSTRAINT composite_pk_chat_users PRIMARY KEY (chat_id, user_id);


--
-- TOC entry 4684 (class 2606 OID 16464)
-- Name: message_attachments message_attachments_pkey; Type: CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.message_attachments
    ADD CONSTRAINT message_attachments_pkey PRIMARY KEY (id);


--
-- TOC entry 4682 (class 2606 OID 16431)
-- Name: messages text_messages_pkey; Type: CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.messages
    ADD CONSTRAINT text_messages_pkey PRIMARY KEY (id);


--
-- TOC entry 4674 (class 2606 OID 16400)
-- Name: users username_unique; Type: CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- TOC entry 4676 (class 2606 OID 16398)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4686 (class 2606 OID 16479)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: dchatlogs; Owner: postgres
--

ALTER TABLE ONLY dchatlogs.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4687 (class 2606 OID 16413)
-- Name: chat_users chat_id_ref; Type: FK CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.chat_users
    ADD CONSTRAINT chat_id_ref FOREIGN KEY (chat_id) REFERENCES dchatdata.chats(id) ON DELETE CASCADE;


--
-- TOC entry 4689 (class 2606 OID 16432)
-- Name: messages chat_id_ref; Type: FK CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.messages
    ADD CONSTRAINT chat_id_ref FOREIGN KEY (chat_id) REFERENCES dchatdata.chats(id) ON DELETE CASCADE;


--
-- TOC entry 4691 (class 2606 OID 16465)
-- Name: message_attachments message_id_ref; Type: FK CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.message_attachments
    ADD CONSTRAINT message_id_ref FOREIGN KEY (message_id) REFERENCES dchatdata.messages(id) ON DELETE CASCADE;


--
-- TOC entry 4690 (class 2606 OID 16437)
-- Name: messages sender_id_ref; Type: FK CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.messages
    ADD CONSTRAINT sender_id_ref FOREIGN KEY (sender_id) REFERENCES dchatdata.users(id) ON DELETE SET NULL;


--
-- TOC entry 4688 (class 2606 OID 16418)
-- Name: chat_users user_id_ref; Type: FK CONSTRAINT; Schema: dchatdata; Owner: postgres
--

ALTER TABLE ONLY dchatdata.chat_users
    ADD CONSTRAINT user_id_ref FOREIGN KEY (user_id) REFERENCES dchatdata.users(id) ON DELETE CASCADE;


-- Completed on 2026-04-15 22:09:12

--
-- PostgreSQL database dump complete
--

\unrestrict ejM2fp21pE1yG5ypRLqSGSdaNZbFuWjt63DojTsurFQP1fiCf39mimd3by2RNzu

