--
-- PostgreSQL database dump
--

\restrict yJtS1QbDKjyfGS434GD12rilvmIcmb7gT6lPwk4fMySGUNdYPASleTCB34VpwdE

-- Dumped from database version 14.19 (Debian 14.19-1.pgdg13+1)
-- Dumped by pg_dump version 14.19

-- Started on 2025-10-20 04:18:39 UTC

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
-- TOC entry 844 (class 1247 OID 16412)
-- Name: condicion_especial_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.condicion_especial_enum AS ENUM (
    'NINGUNA',
    'EMBARAZO',
    'SILLA_RUEDAS',
    'ADULTO_MAYOR',
    'OTRA'
);


--
-- TOC entry 838 (class 1247 OID 16396)
-- Name: estado_general; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.estado_general AS ENUM (
    'ACTIVO',
    'INACTIVO'
);


--
-- TOC entry 841 (class 1247 OID 16402)
-- Name: estado_turno; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.estado_turno AS ENUM (
    'PENDIENTE',
    'EN_CURSO',
    'ATENDIDO',
    'CANCELADO'
);


--
-- TOC entry 835 (class 1247 OID 16386)
-- Name: tipo_usuario; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.tipo_usuario AS ENUM (
    'CLIENTE',
    'EMPLEADO',
    'PROVEEDOR',
    'INVITADO'
);


SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16424)
-- Name: ciudad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ciudad (
    ciudad_id integer NOT NULL,
    nombre_ciudad character varying(100) NOT NULL,
    codigo_postal character varying(20) NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 16423)
-- Name: ciudad_ciudad_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ciudad_ciudad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 209
-- Name: ciudad_ciudad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ciudad_ciudad_id_seq OWNED BY public.ciudad.ciudad_id;


--
-- TOC entry 218 (class 1259 OID 16467)
-- Name: empleado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empleado (
    empleado_id integer NOT NULL,
    usuario_id integer NOT NULL,
    cargo character varying(120) NOT NULL,
    departamento character varying(120) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16466)
-- Name: empleado_empleado_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.empleado_empleado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 217
-- Name: empleado_empleado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.empleado_empleado_id_seq OWNED BY public.empleado.empleado_id;


--
-- TOC entry 216 (class 1259 OID 16458)
-- Name: medio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medio (
    medio_id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16457)
-- Name: medio_medio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medio_medio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 215
-- Name: medio_medio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medio_medio_id_seq OWNED BY public.medio.medio_id;


--
-- TOC entry 220 (class 1259 OID 16481)
-- Name: notificacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notificacion (
    notificacion_id integer NOT NULL,
    usuario_id integer NOT NULL,
    medio_id integer NOT NULL,
    mensaje text NOT NULL,
    fecha_envio timestamp without time zone DEFAULT now() NOT NULL,
    estado public.estado_general DEFAULT 'ACTIVO'::public.estado_general NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16480)
-- Name: notificacion_notificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notificacion_notificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 219
-- Name: notificacion_notificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notificacion_notificacion_id_seq OWNED BY public.notificacion.notificacion_id;


--
-- TOC entry 214 (class 1259 OID 16446)
-- Name: servicio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servicio (
    servicio_id integer NOT NULL,
    nombre character varying(120) NOT NULL,
    descripcion text,
    estado public.estado_general DEFAULT 'ACTIVO'::public.estado_general NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 16445)
-- Name: servicio_servicio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.servicio_servicio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 213
-- Name: servicio_servicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.servicio_servicio_id_seq OWNED BY public.servicio.servicio_id;


--
-- TOC entry 222 (class 1259 OID 16502)
-- Name: turno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.turno (
    turno_id integer NOT NULL,
    usuario_id integer NOT NULL,
    servicio_id integer NOT NULL,
    empleado_id integer,
    fecha date NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    estado public.estado_turno DEFAULT 'PENDIENTE'::public.estado_turno NOT NULL,
    creado_en timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_horas_validas CHECK ((hora_fin > hora_inicio))
);


--
-- TOC entry 221 (class 1259 OID 16501)
-- Name: turno_turno_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.turno_turno_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 221
-- Name: turno_turno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.turno_turno_id_seq OWNED BY public.turno.turno_id;


--
-- TOC entry 212 (class 1259 OID 16433)
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    usuario_id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    tipo_usuario public.tipo_usuario NOT NULL,
    condicion_especial public.condicion_especial_enum DEFAULT 'NINGUNA'::public.condicion_especial_enum NOT NULL,
    ciudad_id integer NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 16432)
-- Name: usuario_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 211
-- Name: usuario_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_usuario_id_seq OWNED BY public.usuario.usuario_id;


--
-- TOC entry 3296 (class 2604 OID 16427)
-- Name: ciudad ciudad_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ciudad ALTER COLUMN ciudad_id SET DEFAULT nextval('public.ciudad_ciudad_id_seq'::regclass);


--
-- TOC entry 3302 (class 2604 OID 16470)
-- Name: empleado empleado_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado ALTER COLUMN empleado_id SET DEFAULT nextval('public.empleado_empleado_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16461)
-- Name: medio medio_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medio ALTER COLUMN medio_id SET DEFAULT nextval('public.medio_medio_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 16484)
-- Name: notificacion notificacion_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion ALTER COLUMN notificacion_id SET DEFAULT nextval('public.notificacion_notificacion_id_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 16449)
-- Name: servicio servicio_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicio ALTER COLUMN servicio_id SET DEFAULT nextval('public.servicio_servicio_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16505)
-- Name: turno turno_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turno ALTER COLUMN turno_id SET DEFAULT nextval('public.turno_turno_id_seq'::regclass);


--
-- TOC entry 3297 (class 2604 OID 16436)
-- Name: usuario usuario_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuario_usuario_id_seq'::regclass);


--
-- TOC entry 3485 (class 0 OID 16424)
-- Dependencies: 210
-- Data for Name: ciudad; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ciudad (ciudad_id, nombre_ciudad, codigo_postal) FROM stdin;
1	Cali	760001
2	Palmira	763531
3	Yumbo	760507
4	Jamundí	761027
5	Bogotá	110111
6	Medellín	050021
7	Barranquilla	080001
8	Cartagena	130001
9	Bucaramanga	680001
10	Pereira	660001
\.


--
-- TOC entry 3493 (class 0 OID 16467)
-- Dependencies: 218
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.empleado (empleado_id, usuario_id, cargo, departamento) FROM stdin;
1	6	Asesor Senior	Atención
2	7	Asesor	Atención
3	8	Coordinador	Operaciones
4	13	Técnico	Soporte
5	14	Técnico	Soporte
6	15	Analista	Consultoría
7	16	Especialista	Instalación
8	17	Supervisor	Mantenimiento
9	18	Instructor	Capacitación
10	19	Operario	Logística
\.


--
-- TOC entry 3491 (class 0 OID 16458)
-- Dependencies: 216
-- Data for Name: medio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medio (medio_id, nombre) FROM stdin;
1	EMAIL
2	SMS
3	WHATSAPP
4	LLAMADA
5	PUSH
\.


--
-- TOC entry 3495 (class 0 OID 16481)
-- Dependencies: 220
-- Data for Name: notificacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notificacion (notificacion_id, usuario_id, medio_id, mensaje, fecha_envio, estado) FROM stdin;
1	1	1	Bienvenido a LiMar. Registro exitoso.	2025-10-10 01:45:57.734925	ACTIVO
2	2	2	Su registro ha sido validado.	2025-10-11 01:45:57.734925	ACTIVO
3	3	3	Recuerde su condición especial: EMbarazo.	2025-10-12 01:45:57.734925	ACTIVO
4	4	1	Acceso habilitado. Puede tomar turnos.	2025-10-13 01:45:57.734925	ACTIVO
5	5	4	Actualización de datos confirmada.	2025-10-14 01:45:57.734925	ACTIVO
6	9	2	Contraseña restablecida.	2025-10-15 01:45:57.734925	ACTIVO
7	10	3	Proveedor verificado.	2025-10-16 01:45:57.734925	ACTIVO
8	11	1	Nuevos servicios disponibles.	2025-10-17 01:45:57.734925	ACTIVO
9	12	5	Notificación de seguridad.	2025-10-18 01:45:57.734925	ACTIVO
10	1	1	Recordatorio: tiene un turno mañana.	2025-10-19 01:45:57.734925	ACTIVO
\.


--
-- TOC entry 3489 (class 0 OID 16446)
-- Dependencies: 214
-- Data for Name: servicio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.servicio (servicio_id, nombre, descripcion, estado) FROM stdin;
1	Despacho	Despacho de mercancías	ACTIVO
2	Entrega	Entrega de artículos al cliente	ACTIVO
3	Recepción	Recepción de artículos de proveedores	ACTIVO
4	Atención al cliente	Soporte y PQRS	ACTIVO
5	Consultoría	Asesoría especializada	ACTIVO
6	Instalación	Instalación de equipos	ACTIVO
7	Mantenimiento	Mantenimiento preventivo y correctivo	ACTIVO
8	Capacitación	Entrenamientos a clientes/proveedores	ACTIVO
9	Devoluciones	Gestión de devoluciones	ACTIVO
10	Logística interna	Operaciones internas de logística	ACTIVO
\.


--
-- TOC entry 3497 (class 0 OID 16502)
-- Dependencies: 222
-- Data for Name: turno; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.turno (turno_id, usuario_id, servicio_id, empleado_id, fecha, hora_inicio, hora_fin, estado, creado_en) FROM stdin;
1	1	4	1	2025-10-20	08:00:00	08:30:00	EN_CURSO	2025-10-20 01:45:57.734925
2	2	1	2	2025-10-20	08:30:00	09:00:00	PENDIENTE	2025-10-20 01:45:57.734925
3	3	5	6	2025-10-20	09:00:00	09:45:00	PENDIENTE	2025-10-20 01:45:57.734925
4	4	2	3	2025-10-20	09:15:00	09:45:00	PENDIENTE	2025-10-20 01:45:57.734925
5	5	7	8	2025-10-20	10:00:00	10:40:00	PENDIENTE	2025-10-20 01:45:57.734925
6	9	8	9	2025-10-20	10:45:00	11:15:00	PENDIENTE	2025-10-20 01:45:57.734925
7	10	3	10	2025-10-20	11:30:00	12:00:00	PENDIENTE	2025-10-20 01:45:57.734925
8	11	9	5	2025-10-21	08:00:00	08:30:00	PENDIENTE	2025-10-20 01:45:57.734925
9	12	6	7	2025-10-21	08:30:00	09:10:00	PENDIENTE	2025-10-20 01:45:57.734925
10	1	4	1	2025-10-21	09:30:00	10:00:00	PENDIENTE	2025-10-20 01:45:57.734925
\.


--
-- TOC entry 3487 (class 0 OID 16433)
-- Dependencies: 212
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.usuario (usuario_id, nombre, apellido, tipo_usuario, condicion_especial, ciudad_id) FROM stdin;
1	Laura	Mora	CLIENTE	NINGUNA	1
2	Carlos	López	CLIENTE	ADULTO_MAYOR	5
3	María	Gómez	CLIENTE	EMBARAZO	1
4	Andrés	Pérez	CLIENTE	SILLA_RUEDAS	2
5	Sofía	Rivas	CLIENTE	NINGUNA	3
6	Camila	García	EMPLEADO	NINGUNA	1
7	Julián	Hernández	EMPLEADO	NINGUNA	1
8	Sergio	Rojas	EMPLEADO	NINGUNA	5
9	Paula	Nieves	CLIENTE	NINGUNA	6
10	Diego	Torres	PROVEEDOR	NINGUNA	7
11	Valeria	Luna	CLIENTE	NINGUNA	4
12	Esteban	Cano	CLIENTE	NINGUNA	9
13	Natalia	Vega	EMPLEADO	NINGUNA	1
14	Hugo	Salazar	EMPLEADO	NINGUNA	2
15	Verónica	Mena	EMPLEADO	NINGUNA	3
16	Ricardo	Paz	EMPLEADO	NINGUNA	4
17	Daniela	Hoyos	EMPLEADO	NINGUNA	5
18	Felipe	Ibarra	EMPLEADO	NINGUNA	6
19	Karol	Quintero	EMPLEADO	NINGUNA	7
\.


--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 209
-- Name: ciudad_ciudad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ciudad_ciudad_id_seq', 11, true);


--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 217
-- Name: empleado_empleado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.empleado_empleado_id_seq', 10, true);


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 215
-- Name: medio_medio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medio_medio_id_seq', 7, true);


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 219
-- Name: notificacion_notificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notificacion_notificacion_id_seq', 10, true);


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 213
-- Name: servicio_servicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.servicio_servicio_id_seq', 10, true);


--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 221
-- Name: turno_turno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.turno_turno_id_seq', 10, true);


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 211
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuario_usuario_id_seq', 43, true);


--
-- TOC entry 3311 (class 2606 OID 16429)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (ciudad_id);


--
-- TOC entry 3326 (class 2606 OID 16472)
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (empleado_id);


--
-- TOC entry 3328 (class 2606 OID 16474)
-- Name: empleado empleado_usuario_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_usuario_id_key UNIQUE (usuario_id);


--
-- TOC entry 3322 (class 2606 OID 16465)
-- Name: medio medio_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medio
    ADD CONSTRAINT medio_nombre_key UNIQUE (nombre);


--
-- TOC entry 3324 (class 2606 OID 16463)
-- Name: medio medio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medio
    ADD CONSTRAINT medio_pkey PRIMARY KEY (medio_id);


--
-- TOC entry 3331 (class 2606 OID 16490)
-- Name: notificacion notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (notificacion_id);


--
-- TOC entry 3318 (class 2606 OID 16454)
-- Name: servicio servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_pkey PRIMARY KEY (servicio_id);


--
-- TOC entry 3337 (class 2606 OID 16510)
-- Name: turno turno_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_pkey PRIMARY KEY (turno_id);


--
-- TOC entry 3313 (class 2606 OID 16431)
-- Name: ciudad uq_ciudad; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT uq_ciudad UNIQUE (nombre_ciudad, codigo_postal);


--
-- TOC entry 3320 (class 2606 OID 16456)
-- Name: servicio uq_servicio_nombre; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT uq_servicio_nombre UNIQUE (nombre);


--
-- TOC entry 3316 (class 2606 OID 16439)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 3329 (class 1259 OID 16527)
-- Name: idx_empleado_usuario; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_empleado_usuario ON public.empleado USING btree (usuario_id);


--
-- TOC entry 3332 (class 1259 OID 16530)
-- Name: idx_turno_empleado; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_turno_empleado ON public.turno USING btree (empleado_id);


--
-- TOC entry 3333 (class 1259 OID 16531)
-- Name: idx_turno_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_turno_fecha ON public.turno USING btree (fecha, hora_inicio);


--
-- TOC entry 3334 (class 1259 OID 16529)
-- Name: idx_turno_servicio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_turno_servicio ON public.turno USING btree (servicio_id);


--
-- TOC entry 3335 (class 1259 OID 16528)
-- Name: idx_turno_usuario; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_turno_usuario ON public.turno USING btree (usuario_id);


--
-- TOC entry 3314 (class 1259 OID 16526)
-- Name: idx_usuario_ciudad; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usuario_ciudad ON public.usuario USING btree (ciudad_id);


--
-- TOC entry 3339 (class 2606 OID 16475)
-- Name: empleado empleado_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3341 (class 2606 OID 16496)
-- Name: notificacion notificacion_medio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_medio_id_fkey FOREIGN KEY (medio_id) REFERENCES public.medio(medio_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3340 (class 2606 OID 16491)
-- Name: notificacion notificacion_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3344 (class 2606 OID 16521)
-- Name: turno turno_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3343 (class 2606 OID 16516)
-- Name: turno turno_servicio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_servicio_id_fkey FOREIGN KEY (servicio_id) REFERENCES public.servicio(servicio_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3342 (class 2606 OID 16511)
-- Name: turno turno_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3338 (class 2606 OID 16440)
-- Name: usuario usuario_ciudad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_ciudad_id_fkey FOREIGN KEY (ciudad_id) REFERENCES public.ciudad(ciudad_id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-10-20 04:18:39 UTC

--
-- PostgreSQL database dump complete
--

\unrestrict yJtS1QbDKjyfGS434GD12rilvmIcmb7gT6lPwk4fMySGUNdYPASleTCB34VpwdE

