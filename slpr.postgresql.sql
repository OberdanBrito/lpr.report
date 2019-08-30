--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9
-- Dumped by pg_dump version 10.9

-- Started on 2019-08-29 20:57:10 -03

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
-- TOC entry 2252 (class 1262 OID 16384)
-- Name: slpr; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE slpr WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'pt_BR.UTF-8' LC_CTYPE = 'pt_BR.UTF-8';


ALTER DATABASE slpr OWNER TO postgres;

\connect slpr

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
-- TOC entry 8 (class 2615 OID 16504)
-- Name: cliente; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA cliente;


ALTER SCHEMA cliente OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 16505)
-- Name: report; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA report;


ALTER SCHEMA report OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 12281)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2254 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 229 (class 1255 OID 17871)
-- Name: plate_replace(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.plate_replace(placa character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    retorno VARCHAR(7);
BEGIN

    retorno := '';
    FOR I IN 1 .. 7 LOOP

        IF (I <= 3) THEN
            IF (substr(placa, I, 1) IN ('0')) THEN
                retorno = retorno || 'O';
            ELSEIF (substr(placa, I, 1) IN ('1')) THEN
                retorno = retorno || 'I';
            ELSEIF (substr(placa, I, 1) IN ('8','3')) THEN
                retorno = retorno || 'B';
            ELSEIF (substr(placa, I, 1) IN ('2')) THEN
                retorno = retorno || 'Z';
            ELSE
                retorno = retorno || substr(placa, I, 1);
            END IF;
        ELSE
            IF (substr(placa, I, 1) IN ('D', 'O', 'Q')) THEN
                retorno = retorno || '0';
            ELSEIF (substr(placa, I, 1) IN ('I', 'L')) THEN
                retorno = retorno || '1';
            ELSEIF (substr(placa, I, 1) IN ('Z')) THEN
                retorno = retorno || '2';
            ELSEIF (substr(placa, I, 1) IN ('B')) THEN
                retorno = retorno || '8';
            ELSEIF (substr(placa, I, 1) IN ('S')) THEN
                retorno = retorno || '5';
            ELSEIF (substr(placa, I, 1) IN ('G')) THEN
                retorno = retorno || '6';
            ELSE
                retorno = retorno || substr(placa, I, 1);
            END IF;
        END IF;

    END LOOP;
    RAISE NOTICE '% %',placa, retorno;
    RETURN retorno;
END
$$;


ALTER FUNCTION public.plate_replace(placa character varying) OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 16506)
-- Name: uf(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.uf(plate character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
begin

        if plate ~ '^B[F-Z]{2}[0-9]{4}$' = true then return 'SP';
        elseif plate ~ '^[C-F]{1}[A-Z]{2}[0-9]{4}$' = true then  return 'SP';
        elseif  plate ~ '^G[A-J]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'SP';
        elseif  plate ~ '^GK[A-I]{1}[0-9]{4}$' = true then  return 'SP';
        elseif  plate ~ '^SAV[0-9]{4}$' = true then  return 'SP';
        elseif  plate ~ '^QS[N-U]{1}[0-9]{4}$' = true then return 'SP';

        elseif  plate ~ '^MZ[N-Z]{1}[0-9]{4}$' = true then return 'AC';
        elseif  plate ~ '^NA[A-G]{1}[0-9]{4}$' = true then  return 'AC';
        elseif  plate ~ '^NX[R-T]{1}[0-9]{4}$' = true then  return 'AC';
        elseif  plate ~ '^OVG[0-9]{4}$' = true then  return 'AC';
        elseif  plate ~ '^OXP[0-9]{4}$' = true then  return 'AC';
        elseif  plate ~ '^QL[U-Z]{1}[0-9]{4}$' = true then  return 'AC';

        elseif  plate ~ '^GK[J-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^G[L-Z]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^H[A-N]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^HO[A-K]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^NX[X-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^NY[A-G]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^OL[O-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^OM[A-G]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^OO[V-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^OR[A-C]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^OW[H-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^OX[A-K]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^P[U-Z]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^QM[Q-Z]{1}[0-9]{4}$' = true then  return 'MG';
        elseif  plate ~ '^Q[N-Q]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'MG';

        elseif  plate ~ '^MU[A-Z]{1}[0-9]{4}$' = true then  return 'AL';
        elseif  plate ~ '^MV[A-K]{1}[0-9]{4}$' = true then  return 'AL';
        elseif  plate ~ '^NL[V-Z]{1}[0-9]{4}$' = true then  return 'AL';
        elseif  plate ~ '^NM[A-O]{1}[0-9]{4}$' = true then  return 'AL';
        elseif  plate ~ '^OH[B-K]{1}[0-9]{4}$' = true then  return 'AL';
        elseif  plate ~ '^OR[D-M]{1}[0-9]{4}$' = true then  return 'AL';
        elseif  plate ~ '^OXN[0-9]{4}$' = true then  return 'AL';

        elseif  plate ~ '^JW[F-Z]{1}[0-9]{4}$' = true then  return 'AP';
        elseif  plate ~ '^JX[A-Y]{1}[0-9]{4}$' = true then  return 'AP';
        elseif  plate ~ '^QL[N-T]{1}[0-9]{4}$' = true then  return 'AP';

        elseif  plate ~ '^JK[S-Z]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^J[L-S]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^NT[D-W]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^NY[H-Z]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^NZ[A-Z]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^OK[I-Z]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^OL[A-G]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^OU[F-Z]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^OV[A-D]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^OZ[C-V]{1}[0-9]{4}$' = true then  return 'BA';
        elseif  plate ~ '^P[J-L]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'BA';

        elseif  plate ~ '^GK[J-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^G[L-Z]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^H[A-N]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^HO[A-K]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^NX[X-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^NY[A-G]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^OL[O-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^OM[A-G]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^OO[V-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^OR[A-C]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^OW[H-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^OX[A-K]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^P[U-Z]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^QM[Q-Z]{1}[0-9]{4}$' = true then  return 'CE';
        elseif  plate ~ '^Q[N-Q]{1}[A-Z]{1}[0-9]{4}$' = true then  return 'CE';

        elseif  plate ~ '^JD[P-Z]{1}[0-9]{4}$' = true then  return 'DF';
        elseif  plate ~ '^J[E-J]{1}[A-Z][0-9]{4}$' = true then  return 'DF';
        elseif  plate ~ '^JK[A-R]{1}[0-9]{4}$' = true then  return 'DF';        
        elseif  plate ~ '^OV[M-V]{1}[0-9]{4}$' = true then  return 'DF';        
        elseif  plate ~ '^OZ[W-Z]{1}[0-9]{4}$' = true then  return 'DF';        
        elseif  plate ~ '^JD[P-Z]{1}[0-9]{4}$' = true then  return 'DF';
        
        else
            return null;
        end if;

    end;
$_$;


ALTER FUNCTION public.uf(plate character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16507)
-- Name: coletor; Type: TABLE; Schema: cliente; Owner: postgres
--

CREATE TABLE cliente.coletor (
    id integer NOT NULL,
    ponto integer NOT NULL,
    nome character varying(255) NOT NULL
);


ALTER TABLE cliente.coletor OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16510)
-- Name: coletor_id_seq; Type: SEQUENCE; Schema: cliente; Owner: postgres
--

CREATE SEQUENCE cliente.coletor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cliente.coletor_id_seq OWNER TO postgres;

--
-- TOC entry 2255 (class 0 OID 0)
-- Dependencies: 199
-- Name: coletor_id_seq; Type: SEQUENCE OWNED BY; Schema: cliente; Owner: postgres
--

ALTER SEQUENCE cliente.coletor_id_seq OWNED BY cliente.coletor.id;


--
-- TOC entry 200 (class 1259 OID 16512)
-- Name: info; Type: TABLE; Schema: cliente; Owner: postgres
--

CREATE TABLE cliente.info (
    id integer NOT NULL,
    nome character varying(255) NOT NULL
);


ALTER TABLE cliente.info OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16515)
-- Name: info_id_seq; Type: SEQUENCE; Schema: cliente; Owner: postgres
--

CREATE SEQUENCE cliente.info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cliente.info_id_seq OWNER TO postgres;

--
-- TOC entry 2256 (class 0 OID 0)
-- Dependencies: 201
-- Name: info_id_seq; Type: SEQUENCE OWNED BY; Schema: cliente; Owner: postgres
--

ALTER SEQUENCE cliente.info_id_seq OWNED BY cliente.info.id;


--
-- TOC entry 202 (class 1259 OID 16517)
-- Name: ponto; Type: TABLE; Schema: cliente; Owner: postgres
--

CREATE TABLE cliente.ponto (
    id integer NOT NULL,
    client integer NOT NULL,
    nome character varying(255) NOT NULL
);


ALTER TABLE cliente.ponto OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16520)
-- Name: site_id_seq; Type: SEQUENCE; Schema: cliente; Owner: postgres
--

CREATE SEQUENCE cliente.site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cliente.site_id_seq OWNER TO postgres;

--
-- TOC entry 2257 (class 0 OID 0)
-- Dependencies: 203
-- Name: site_id_seq; Type: SEQUENCE OWNED BY; Schema: cliente; Owner: postgres
--

ALTER SEQUENCE cliente.site_id_seq OWNED BY cliente.ponto.id;


--
-- TOC entry 204 (class 1259 OID 16522)
-- Name: candidates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidates (
    id bigint NOT NULL,
    results integer,
    plate character varying(20),
    confidence double precision,
    matches_template integer
);


ALTER TABLE public.candidates OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16525)
-- Name: candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidates_id_seq OWNER TO postgres;

--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 205
-- Name: candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidates_id_seq OWNED BY public.candidates.id;


--
-- TOC entry 206 (class 1259 OID 16527)
-- Name: coordinates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coordinates (
    id bigint NOT NULL,
    results integer,
    x integer,
    y integer
);


ALTER TABLE public.coordinates OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16530)
-- Name: coordinates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coordinates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coordinates_id_seq OWNER TO postgres;

--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 207
-- Name: coordinates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coordinates_id_seq OWNED BY public.coordinates.id;


--
-- TOC entry 208 (class 1259 OID 16532)
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    filedate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id bigint NOT NULL,
    version character varying(50),
    data_type character varying(50),
    epoch_time real,
    img_width integer,
    img_height integer,
    processing_time_ms real,
    uuid character varying(50),
    camera_id integer,
    site_id integer,
    company_id integer
);


ALTER TABLE public.job OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16536)
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_id_seq OWNER TO postgres;

--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 209
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_id_seq OWNED BY public.job.id;


--
-- TOC entry 210 (class 1259 OID 16538)
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.results (
    filedate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id bigint NOT NULL,
    job integer,
    plate character varying(20),
    confidence double precision,
    matches_template double precision,
    plate_index integer,
    region character varying(5),
    region_confidence integer,
    processing_time_ms double precision,
    requested_topn integer,
    valido integer
);


ALTER TABLE public.results OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16542)
-- Name: lista_estados; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.lista_estados AS
 SELECT a.estado,
    count(*) AS count
   FROM ( SELECT results.plate,
            public.uf(results.plate) AS estado
           FROM public.results
          WHERE (results.valido = 1)) a
  GROUP BY a.estado;


ALTER TABLE public.lista_estados OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16546)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    id bigint NOT NULL,
    job integer,
    x integer,
    y integer,
    width integer,
    weight integer
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16549)
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO postgres;

--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 213
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_id_seq OWNED BY public.regions.id;


--
-- TOC entry 214 (class 1259 OID 16551)
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_id_seq OWNER TO postgres;

--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 214
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.results_id_seq OWNED BY public.results.id;


--
-- TOC entry 215 (class 1259 OID 17865)
-- Name: diario_captura_analitico; Type: VIEW; Schema: report; Owner: postgres
--

CREATE VIEW report.diario_captura_analitico AS
 SELECT b.data,
    info.nome AS cliente,
    ponto.nome AS ponto,
    coletor.nome AS coletor,
    b.identificacoes,
    (b.identificacoes / 24) AS ident_hora,
    b.capturas,
    (b.capturas / (24)::numeric) AS capt_hora,
    p.avgprocessing_time_ms,
    p.minprocessing_time_ms,
    p.maxprocessing_time_ms,
    r.avgconfidence,
    r.minconfidence,
    r.maxconfidence
   FROM (((((( SELECT a.data,
            a.camera_id,
            count(a.epoch_time) AS identificacoes,
            sum(a.capturas) AS capturas
           FROM ( SELECT (job.filedate)::date AS data,
                    job.camera_id,
                    job.epoch_time,
                    count(job.id) AS capturas
                   FROM public.job
                  GROUP BY ((job.filedate)::date), job.camera_id, job.epoch_time) a
          GROUP BY a.data, a.camera_id) b
     JOIN ( SELECT (job.filedate)::date AS data,
            job.camera_id,
            avg(job.processing_time_ms) AS avgprocessing_time_ms,
            max(job.processing_time_ms) AS maxprocessing_time_ms,
            min(job.processing_time_ms) AS minprocessing_time_ms
           FROM public.job
          GROUP BY ((job.filedate)::date), job.camera_id) p ON (((b.data = p.data) AND (b.camera_id = p.camera_id))))
     JOIN ( SELECT (results.filedate)::date AS data,
            job.camera_id,
            avg(results.confidence) AS avgconfidence,
            max(results.confidence) AS maxconfidence,
            min(results.confidence) AS minconfidence
           FROM (public.results
             JOIN public.job ON ((results.job = job.id)))
          GROUP BY ((results.filedate)::date), job.camera_id) r ON (((r.data = b.data) AND (r.camera_id = b.camera_id))))
     JOIN cliente.coletor ON ((b.camera_id = coletor.id)))
     JOIN cliente.ponto ON ((coletor.ponto = ponto.id)))
     JOIN cliente.info ON ((ponto.client = info.id)))
  ORDER BY info.nome, ponto.nome, coletor.nome, b.data;


ALTER TABLE report.diario_captura_analitico OWNER TO postgres;

--
-- TOC entry 2081 (class 2604 OID 16558)
-- Name: coletor id; Type: DEFAULT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.coletor ALTER COLUMN id SET DEFAULT nextval('cliente.coletor_id_seq'::regclass);


--
-- TOC entry 2082 (class 2604 OID 16559)
-- Name: info id; Type: DEFAULT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.info ALTER COLUMN id SET DEFAULT nextval('cliente.info_id_seq'::regclass);


--
-- TOC entry 2083 (class 2604 OID 16560)
-- Name: ponto id; Type: DEFAULT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.ponto ALTER COLUMN id SET DEFAULT nextval('cliente.site_id_seq'::regclass);


--
-- TOC entry 2084 (class 2604 OID 16561)
-- Name: candidates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates ALTER COLUMN id SET DEFAULT nextval('public.candidates_id_seq'::regclass);


--
-- TOC entry 2085 (class 2604 OID 16562)
-- Name: coordinates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordinates ALTER COLUMN id SET DEFAULT nextval('public.coordinates_id_seq'::regclass);


--
-- TOC entry 2087 (class 2604 OID 16563)
-- Name: job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job ALTER COLUMN id SET DEFAULT nextval('public.job_id_seq'::regclass);


--
-- TOC entry 2090 (class 2604 OID 16564)
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);


--
-- TOC entry 2089 (class 2604 OID 16565)
-- Name: results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);


--
-- TOC entry 2094 (class 2606 OID 16567)
-- Name: coletor coletor_pk; Type: CONSTRAINT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.coletor
    ADD CONSTRAINT coletor_pk PRIMARY KEY (id);


--
-- TOC entry 2098 (class 2606 OID 16569)
-- Name: info info_pk; Type: CONSTRAINT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.info
    ADD CONSTRAINT info_pk PRIMARY KEY (id);


--
-- TOC entry 2102 (class 2606 OID 16571)
-- Name: ponto site_pk; Type: CONSTRAINT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.ponto
    ADD CONSTRAINT site_pk PRIMARY KEY (id);


--
-- TOC entry 2105 (class 2606 OID 16573)
-- Name: candidates primary_key_candidates; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT primary_key_candidates PRIMARY KEY (id);


--
-- TOC entry 2108 (class 2606 OID 16575)
-- Name: coordinates primary_key_coordinates; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordinates
    ADD CONSTRAINT primary_key_coordinates PRIMARY KEY (id);


--
-- TOC entry 2111 (class 2606 OID 16577)
-- Name: job primary_key_job; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT primary_key_job PRIMARY KEY (id);


--
-- TOC entry 2116 (class 2606 OID 16579)
-- Name: regions primary_key_regions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT primary_key_regions PRIMARY KEY (id);


--
-- TOC entry 2113 (class 2606 OID 16581)
-- Name: results primary_key_results; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT primary_key_results PRIMARY KEY (id);


--
-- TOC entry 2091 (class 1259 OID 16582)
-- Name: coletor_id_uindex; Type: INDEX; Schema: cliente; Owner: postgres
--

CREATE UNIQUE INDEX coletor_id_uindex ON cliente.coletor USING btree (id);


--
-- TOC entry 2092 (class 1259 OID 16583)
-- Name: coletor_nome_uindex; Type: INDEX; Schema: cliente; Owner: postgres
--

CREATE UNIQUE INDEX coletor_nome_uindex ON cliente.coletor USING btree (nome);


--
-- TOC entry 2095 (class 1259 OID 16584)
-- Name: info_id_uindex; Type: INDEX; Schema: cliente; Owner: postgres
--

CREATE UNIQUE INDEX info_id_uindex ON cliente.info USING btree (id);


--
-- TOC entry 2096 (class 1259 OID 16585)
-- Name: info_nome_uindex; Type: INDEX; Schema: cliente; Owner: postgres
--

CREATE UNIQUE INDEX info_nome_uindex ON cliente.info USING btree (nome);


--
-- TOC entry 2099 (class 1259 OID 16586)
-- Name: site_id_uindex; Type: INDEX; Schema: cliente; Owner: postgres
--

CREATE UNIQUE INDEX site_id_uindex ON cliente.ponto USING btree (id);


--
-- TOC entry 2100 (class 1259 OID 16587)
-- Name: site_nome_uindex; Type: INDEX; Schema: cliente; Owner: postgres
--

CREATE UNIQUE INDEX site_nome_uindex ON cliente.ponto USING btree (nome);


--
-- TOC entry 2103 (class 1259 OID 16588)
-- Name: candidates_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX candidates_id_uindex ON public.candidates USING btree (id);


--
-- TOC entry 2106 (class 1259 OID 16589)
-- Name: coordinates_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX coordinates_id_uindex ON public.coordinates USING btree (id);


--
-- TOC entry 2109 (class 1259 OID 16590)
-- Name: job_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX job_id_uindex ON public.job USING btree (id);


--
-- TOC entry 2117 (class 1259 OID 16591)
-- Name: regions_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX regions_id_uindex ON public.regions USING btree (id);


--
-- TOC entry 2114 (class 1259 OID 16592)
-- Name: results_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX results_id_uindex ON public.results USING btree (id);


--
-- TOC entry 2118 (class 2606 OID 16593)
-- Name: coletor coletor_ponto_fk; Type: FK CONSTRAINT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.coletor
    ADD CONSTRAINT coletor_ponto_fk FOREIGN KEY (ponto) REFERENCES cliente.ponto(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2119 (class 2606 OID 16598)
-- Name: ponto site_info_fk; Type: FK CONSTRAINT; Schema: cliente; Owner: postgres
--

ALTER TABLE ONLY cliente.ponto
    ADD CONSTRAINT site_info_fk FOREIGN KEY (client) REFERENCES cliente.info(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2120 (class 2606 OID 16603)
-- Name: candidates candidates_results_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT candidates_results_fkey FOREIGN KEY (results) REFERENCES public.results(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2121 (class 2606 OID 16608)
-- Name: coordinates coordinates_results_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coordinates
    ADD CONSTRAINT coordinates_results_fkey FOREIGN KEY (results) REFERENCES public.results(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2123 (class 2606 OID 16613)
-- Name: regions regions_job_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_job_fkey FOREIGN KEY (job) REFERENCES public.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2122 (class 2606 OID 16618)
-- Name: results results_job_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_job_fkey FOREIGN KEY (job) REFERENCES public.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-08-29 20:57:14 -03

--
-- PostgreSQL database dump complete
--

