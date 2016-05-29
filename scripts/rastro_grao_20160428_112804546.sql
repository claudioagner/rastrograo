--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.1

-- Started on 2016-04-28 11:28:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 89522)
-- Name: acesso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso (
    id bigint NOT NULL,
    version bigint NOT NULL,
    account_expired boolean NOT NULL,
    account_locked boolean NOT NULL,
    email character varying(128) NOT NULL,
    enabled boolean NOT NULL,
    password character varying(64) NOT NULL,
    password_expired boolean NOT NULL,
    username character varying(32) NOT NULL
);


--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 182
-- Name: TABLE acesso; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE acesso IS 'Tabela contendo os acessos do sistema';


--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN acesso.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN acesso.id IS 'identificador do registro';


--
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN acesso.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN acesso.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 183 (class 1259 OID 89528)
-- Name: acesso_empresas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso_empresas (
    empresa_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 181 (class 1259 OID 89520)
-- Name: acesso_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE acesso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 181
-- Name: acesso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE acesso_id_seq OWNED BY acesso.id;


--
-- TOC entry 184 (class 1259 OID 89533)
-- Name: acesso_propriedades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso_propriedades (
    propriedade_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 185 (class 1259 OID 89538)
-- Name: acesso_regra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso_regra (
    regra_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 97230)
-- Name: atributo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE atributo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_atributo text,
    fase_id bigint NOT NULL,
    nome_atributo character varying(128) NOT NULL,
    tipo_atributo character varying(32) NOT NULL
);


--
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE atributo IS 'Tabela contendo os Atributos das Fases dos Produtos cadastrados no sistema';


--
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN atributo.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.id IS 'identificador do registro';


--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN atributo.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN atributo.descricao_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.descricao_atributo IS 'descrição do atributo da fase do produto';


--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN atributo.fase_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.fase_id IS 'identificador da tabela fase';


--
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN atributo.nome_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.nome_atributo IS 'nome do atributo da fase do produto cadastrado';


--
-- TOC entry 226 (class 1259 OID 97228)
-- Name: atributo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE atributo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 226
-- Name: atributo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE atributo_id_seq OWNED BY atributo.id;


--
-- TOC entry 187 (class 1259 OID 89545)
-- Name: audit_log_event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE audit_log_event (
    id bigint NOT NULL,
    actor text,
    class_name text,
    date_created timestamp without time zone NOT NULL,
    event_name text,
    last_updated timestamp without time zone NOT NULL,
    new_value text,
    old_value text,
    persisted_object_id text,
    persisted_object_version bigint,
    property_name text,
    uri text
);


--
-- TOC entry 186 (class 1259 OID 89543)
-- Name: audit_log_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audit_log_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 186
-- Name: audit_log_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audit_log_event_id_seq OWNED BY audit_log_event.id;


--
-- TOC entry 189 (class 1259 OID 89556)
-- Name: certificacao_empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE certificacao_empresa (
    id bigint NOT NULL,
    version bigint NOT NULL,
    data_certificacao timestamp without time zone NOT NULL,
    empresa_id bigint NOT NULL,
    observacao text,
    tipo_certificacao_id bigint NOT NULL
);


--
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE certificacao_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE certificacao_empresa IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN certificacao_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.id IS 'identificador do registro';


--
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN certificacao_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN certificacao_empresa.data_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.data_certificacao IS 'Data da certificacao';


--
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN certificacao_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.empresa_id IS 'identificador da empresa';


--
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN certificacao_empresa.observacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.observacao IS 'Observacao da certificação sem limite de caracteres';


--
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN certificacao_empresa.tipo_certificacao_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.tipo_certificacao_id IS 'identificador do tipo de certificação';


--
-- TOC entry 188 (class 1259 OID 89554)
-- Name: certificacao_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE certificacao_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 188
-- Name: certificacao_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE certificacao_empresa_id_seq OWNED BY certificacao_empresa.id;


--
-- TOC entry 191 (class 1259 OID 89567)
-- Name: certificacao_propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE certificacao_propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    data_certificacao timestamp without time zone NOT NULL,
    observacao text,
    propriedade_id bigint NOT NULL,
    tipo_certificacao_id bigint NOT NULL
);


--
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE certificacao_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE certificacao_propriedade IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_propriedade.data_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.data_certificacao IS 'Data da certificacao';


--
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_propriedade.observacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.observacao IS 'Observacao da certificação sem limite de caracteres';


--
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.propriedade_id IS 'identificador da propriedade';


--
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_propriedade.tipo_certificacao_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.tipo_certificacao_id IS 'identificador do tipo de certificação';


--
-- TOC entry 190 (class 1259 OID 89565)
-- Name: certificacao_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE certificacao_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 190
-- Name: certificacao_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE certificacao_propriedade_id_seq OWNED BY certificacao_propriedade.id;


--
-- TOC entry 193 (class 1259 OID 89578)
-- Name: cidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cidade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    estado_id bigint NOT NULL,
    nome_cidade character varying(128) NOT NULL
);


--
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 193
-- Name: TABLE cidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE cidade IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN cidade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cidade.id IS 'identificador do registro';


--
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN cidade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cidade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN cidade.nome_cidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cidade.nome_cidade IS 'Nome da cidade contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 192 (class 1259 OID 89576)
-- Name: cidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 192
-- Name: cidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cidade_id_seq OWNED BY cidade.id;


--
-- TOC entry 229 (class 1259 OID 97243)
-- Name: cultivar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cultivar (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_cultivar character varying(128) NOT NULL,
    produto_id bigint NOT NULL
);


--
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE cultivar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE cultivar IS 'Tabela contendo os Cultivares dos produtos cadastrados no sistema';


--
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN cultivar.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.id IS 'identificador do registro';


--
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN cultivar.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN cultivar.descricao_cultivar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.descricao_cultivar IS 'descrição do cultivar cadastrado';


--
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN cultivar.produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.produto_id IS 'identificador do produto';


--
-- TOC entry 228 (class 1259 OID 97241)
-- Name: cultivar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cultivar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 228
-- Name: cultivar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cultivar_id_seq OWNED BY cultivar.id;


--
-- TOC entry 195 (class 1259 OID 89586)
-- Name: empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE empresa (
    id bigint NOT NULL,
    version bigint NOT NULL,
    bairro_empresa character varying(64) NOT NULL,
    cep_empresa character varying(9) NOT NULL,
    cidade_id bigint NOT NULL,
    cnpj character varying(18),
    complemento_empresa character varying(128),
    cpf character varying(14),
    email_empresa character varying(128) NOT NULL,
    logradouro_empresa character varying(128) NOT NULL,
    nome_empresa character varying(128) NOT NULL,
    nome_fantasia_empresa character varying(128) NOT NULL,
    numero_empresa character varying(10) NOT NULL,
    tipo_empresa character varying(32) NOT NULL
);


--
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 195
-- Name: TABLE empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE empresa IS 'Tabela contendo as Empresas do sistema';


--
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN empresa.id IS 'identificador do registro';


--
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN empresa.nome_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN empresa.nome_empresa IS 'Nome da empresa contendo no máximo 128 caracteres';


--
-- TOC entry 194 (class 1259 OID 89584)
-- Name: empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 194
-- Name: empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE empresa_id_seq OWNED BY empresa.id;


--
-- TOC entry 197 (class 1259 OID 89597)
-- Name: estado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE estado (
    id bigint NOT NULL,
    version bigint NOT NULL,
    nome_estado character varying(128) NOT NULL,
    pais_id bigint NOT NULL,
    sigla character varying(2) NOT NULL
);


--
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE estado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE estado IS 'Tabela contendo os Estados por Pais';


--
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN estado.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.id IS 'identificador do registro';


--
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN estado.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN estado.nome_estado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.nome_estado IS 'Nome do estado contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN estado.sigla; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.sigla IS 'Sigla do estado contendo no mínimo 2 e no máximo 2 caracteres e com valor único';


--
-- TOC entry 196 (class 1259 OID 89595)
-- Name: estado_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 196
-- Name: estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE estado_id_seq OWNED BY estado.id;


--
-- TOC entry 231 (class 1259 OID 97253)
-- Name: fase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fase (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_fase character varying(128) NOT NULL,
    observacao_fase text,
    produto_id bigint NOT NULL
);


--
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE fase IS 'Tabela contendo as Fases dos Produtos cadastrados no sistema';


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN fase.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.id IS 'identificador do registro';


--
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN fase.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN fase.descricao_fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.descricao_fase IS 'descrição da fase do produto cadastrado';


--
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN fase.observacao_fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.observacao_fase IS 'observações relacionadas à fase do produto';


--
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN fase.produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.produto_id IS 'identificador do produto';


--
-- TOC entry 230 (class 1259 OID 97251)
-- Name: fase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 230
-- Name: fase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fase_id_seq OWNED BY fase.id;


--
-- TOC entry 199 (class 1259 OID 89605)
-- Name: foto_empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE foto_empresa (
    id bigint NOT NULL,
    version bigint NOT NULL,
    empresa_id bigint NOT NULL,
    foto bytea NOT NULL,
    titulo_foto character varying(128)
);


--
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 199
-- Name: TABLE foto_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE foto_empresa IS 'Tabela contendo as imganes das Empresas do sistema';


--
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN foto_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.id IS 'identificador do registro';


--
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN foto_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN foto_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.empresa_id IS 'identificador da tabela empresa';


--
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN foto_empresa.foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.foto IS 'foto adicionada';


--
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN foto_empresa.titulo_foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.titulo_foto IS 'título da foto contendo no máximo 128 caracteres';


--
-- TOC entry 198 (class 1259 OID 89603)
-- Name: foto_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE foto_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2576 (class 0 OID 0)
-- Dependencies: 198
-- Name: foto_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE foto_empresa_id_seq OWNED BY foto_empresa.id;


--
-- TOC entry 201 (class 1259 OID 89616)
-- Name: foto_propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE foto_propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    foto bytea NOT NULL,
    propriedade_id bigint NOT NULL,
    titulo_foto character varying(128)
);


--
-- TOC entry 2577 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE foto_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE foto_propriedade IS 'Tabela contendo as imagens das Propriedades do sistema';


--
-- TOC entry 2578 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN foto_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2579 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN foto_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2580 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN foto_propriedade.foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.foto IS 'foto adicionada';


--
-- TOC entry 2581 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN foto_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.propriedade_id IS 'identificador da tabela propriedade';


--
-- TOC entry 2582 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN foto_propriedade.titulo_foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.titulo_foto IS 'título da foto contendo no máximo 128 caracteres';


--
-- TOC entry 200 (class 1259 OID 89614)
-- Name: foto_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE foto_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2583 (class 0 OID 0)
-- Dependencies: 200
-- Name: foto_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE foto_propriedade_id_seq OWNED BY foto_propriedade.id;


--
-- TOC entry 203 (class 1259 OID 89627)
-- Name: foto_talhao_propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE foto_talhao_propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    foto bytea NOT NULL,
    talhao_propriedade_id bigint NOT NULL,
    titulo_foto character varying(128)
);


--
-- TOC entry 2584 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE foto_talhao_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE foto_talhao_propriedade IS 'Tabela contendo as imagens das TalhaoPropriedades do sistema';


--
-- TOC entry 2585 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN foto_talhao_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2586 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN foto_talhao_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2587 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN foto_talhao_propriedade.foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.foto IS 'foto adicionada';


--
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN foto_talhao_propriedade.talhao_propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.talhao_propriedade_id IS 'identificador da tabela talhao propriedade';


--
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN foto_talhao_propriedade.titulo_foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.titulo_foto IS 'título da foto contendo no máximo 128 caracteres';


--
-- TOC entry 202 (class 1259 OID 89625)
-- Name: foto_talhao_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE foto_talhao_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2590 (class 0 OID 0)
-- Dependencies: 202
-- Name: foto_talhao_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE foto_talhao_propriedade_id_seq OWNED BY foto_talhao_propriedade.id;


--
-- TOC entry 233 (class 1259 OID 97266)
-- Name: lista_atributo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_atributo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    atributo_id bigint NOT NULL,
    valor_lista_atributo character varying(128) NOT NULL
);


--
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE lista_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE lista_atributo IS 'Tabela contendo os valores da lista do atributo cadastrados no sistema';


--
-- TOC entry 2592 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN lista_atributo.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.id IS 'identificador do registro';


--
-- TOC entry 2593 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN lista_atributo.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2594 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN lista_atributo.atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.atributo_id IS 'identificador da tabela atributo';


--
-- TOC entry 2595 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN lista_atributo.valor_lista_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.valor_lista_atributo IS 'valor da lista do atributo cadastrado';


--
-- TOC entry 232 (class 1259 OID 97264)
-- Name: lista_atributo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_atributo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2596 (class 0 OID 0)
-- Dependencies: 232
-- Name: lista_atributo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_atributo_id_seq OWNED BY lista_atributo.id;


--
-- TOC entry 234 (class 1259 OID 97274)
-- Name: lista_atributo_rastros_lista_atributo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_atributo_rastros_lista_atributo (
    lista_atributo_id bigint NOT NULL,
    rastro_atributo_id bigint NOT NULL
);


--
-- TOC entry 2597 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN lista_atributo_rastros_lista_atributo.lista_atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo_rastros_lista_atributo.lista_atributo_id IS 'rastros das listas dos atributos';


--
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN lista_atributo_rastros_lista_atributo.rastro_atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo_rastros_lista_atributo.rastro_atributo_id IS 'rastros da lista atributo';


--
-- TOC entry 205 (class 1259 OID 89638)
-- Name: pais; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pais (
    id bigint NOT NULL,
    version bigint NOT NULL,
    country_name character varying(128) NOT NULL,
    nome_pais character varying(128) NOT NULL
);


--
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE pais; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE pais IS 'Tabela contendo os paises do mundo';


--
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN pais.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.id IS 'identificador do registro';


--
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN pais.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN pais.country_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.country_name IS 'Nome do pais em Inglês contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN pais.nome_pais; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.nome_pais IS 'Nome do pais contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 204 (class 1259 OID 89636)
-- Name: pais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 204
-- Name: pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pais_id_seq OWNED BY pais.id;


--
-- TOC entry 207 (class 1259 OID 89646)
-- Name: permissao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE permissao (
    id bigint NOT NULL,
    version bigint NOT NULL,
    config_attribute character varying(128) NOT NULL,
    url character varying(128) NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 89644)
-- Name: permissao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE permissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 206
-- Name: permissao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE permissao_id_seq OWNED BY permissao.id;


--
-- TOC entry 236 (class 1259 OID 97281)
-- Name: produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE produto (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_produto character varying(128) NOT NULL,
    observacao_produto text
);


--
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE produto IS 'Tabela contendo os Produtos cadastrados no sistema';


--
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN produto.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.id IS 'identificador do registro';


--
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN produto.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN produto.descricao_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.descricao_produto IS 'descrição do produto cadastrado';


--
-- TOC entry 2610 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN produto.observacao_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.observacao_produto IS 'observações relacionadas ao produto';


--
-- TOC entry 235 (class 1259 OID 97279)
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2611 (class 0 OID 0)
-- Dependencies: 235
-- Name: produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE produto_id_seq OWNED BY produto.id;


--
-- TOC entry 209 (class 1259 OID 89656)
-- Name: propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    bairro_propriedade character varying(64) NOT NULL,
    cep_propriedade character varying(9) NOT NULL,
    cidade_id bigint NOT NULL,
    cnpj character varying(18),
    complemento_propriedade character varying(128),
    cpf character varying(14),
    email_propriedade character varying(128) NOT NULL,
    logradouro_propriedade character varying(128) NOT NULL,
    nome_fantasia_propriedade character varying(128),
    nome_propriedade character varying(128) NOT NULL,
    numero_propriedade character varying(10) NOT NULL,
    porte character varying(32) NOT NULL,
    tipo_propriedade character varying(32) NOT NULL
);


--
-- TOC entry 2612 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE propriedade IS 'Tabela contendo as Propriedades do sistema';


--
-- TOC entry 2613 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN propriedade.id IS 'identificador do registro';


--
-- TOC entry 2614 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2615 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN propriedade.nome_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN propriedade.nome_propriedade IS 'Nome da propriedade contendo no máximo 128 caracteres';


--
-- TOC entry 208 (class 1259 OID 89654)
-- Name: propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2616 (class 0 OID 0)
-- Dependencies: 208
-- Name: propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE propriedade_id_seq OWNED BY propriedade.id;


--
-- TOC entry 238 (class 1259 OID 97292)
-- Name: rastro_atributo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rastro_atributo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    atributo_id bigint NOT NULL,
    comentario_atributo character varying(65534),
    exibirqrconsumidor boolean NOT NULL,
    rastro_fase_id bigint NOT NULL,
    valor_atributo character varying(128) NOT NULL
);


--
-- TOC entry 2617 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE rastro_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE rastro_atributo IS 'Tabela contendo os valores do rastro atributo';


--
-- TOC entry 2618 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rastro_atributo.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.id IS 'identificador do registro';


--
-- TOC entry 2619 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rastro_atributo.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2620 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rastro_atributo.atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.atributo_id IS 'identificador da tabela atributo';


--
-- TOC entry 2621 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rastro_atributo.comentario_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.comentario_atributo IS 'comentário do atributo';


--
-- TOC entry 2622 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rastro_atributo.exibirqrconsumidor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.exibirqrconsumidor IS 'exibir o valor no qr code consumidor';


--
-- TOC entry 2623 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rastro_atributo.rastro_fase_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.rastro_fase_id IS 'identificador da tabela rastro fase';


--
-- TOC entry 2624 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN rastro_atributo.valor_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.valor_atributo IS 'valor do atributo';


--
-- TOC entry 237 (class 1259 OID 97290)
-- Name: rastro_atributo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rastro_atributo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2625 (class 0 OID 0)
-- Dependencies: 237
-- Name: rastro_atributo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rastro_atributo_id_seq OWNED BY rastro_atributo.id;


--
-- TOC entry 240 (class 1259 OID 97303)
-- Name: rastro_fase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rastro_fase (
    id bigint NOT NULL,
    version bigint NOT NULL,
    fase_id bigint NOT NULL,
    rastro_produto_id bigint NOT NULL
);


--
-- TOC entry 2626 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE rastro_fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE rastro_fase IS 'Tabela contendo os valores do rastro fase';


--
-- TOC entry 2627 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rastro_fase.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.id IS 'identificador do registro';


--
-- TOC entry 2628 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rastro_fase.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2629 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rastro_fase.fase_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.fase_id IS 'identificador da tabela fase';


--
-- TOC entry 2630 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN rastro_fase.rastro_produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.rastro_produto_id IS 'identificador da tabela rastroProduto';


--
-- TOC entry 239 (class 1259 OID 97301)
-- Name: rastro_fase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rastro_fase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2631 (class 0 OID 0)
-- Dependencies: 239
-- Name: rastro_fase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rastro_fase_id_seq OWNED BY rastro_fase.id;


--
-- TOC entry 242 (class 1259 OID 97311)
-- Name: rastro_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rastro_produto (
    id bigint NOT NULL,
    version bigint NOT NULL,
    ano_safra character varying(4) NOT NULL,
    cultivar_id bigint NOT NULL,
    data_alterado timestamp without time zone,
    data_criado timestamp without time zone NOT NULL,
    empresa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    propriedade_id bigint NOT NULL,
    talhao_propriedade_id bigint NOT NULL
);


--
-- TOC entry 2632 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE rastro_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE rastro_produto IS 'Tabela contendo os valores do rastro produto';


--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.id IS 'identificador do registro';


--
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.ano_safra; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.ano_safra IS 'identificador do ano da safra';


--
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.cultivar_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.cultivar_id IS 'identificador da tabela cultivar';


--
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.data_alterado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.data_alterado IS 'data em que o rastro do produto foi alterado';


--
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.data_criado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.data_criado IS 'data em que o rastro do produto foi criado';


--
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.empresa_id IS 'identificador da tabela empresa';


--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.produto_id IS 'identificador da tabela produto';


--
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.propriedade_id IS 'identificador da tabela propriedade';


--
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN rastro_produto.talhao_propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.talhao_propriedade_id IS 'identificador da tabela talhão propriedade';


--
-- TOC entry 241 (class 1259 OID 97309)
-- Name: rastro_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rastro_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 241
-- Name: rastro_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rastro_produto_id_seq OWNED BY rastro_produto.id;


--
-- TOC entry 211 (class 1259 OID 89667)
-- Name: regra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE regra (
    id bigint NOT NULL,
    version bigint NOT NULL,
    authority character varying(64) NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 89665)
-- Name: regra_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2644 (class 0 OID 0)
-- Dependencies: 210
-- Name: regra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regra_id_seq OWNED BY regra.id;


--
-- TOC entry 213 (class 1259 OID 89677)
-- Name: responsavel_empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE responsavel_empresa (
    id bigint NOT NULL,
    version bigint NOT NULL,
    ddd_responsavel_empresa character varying(2) NOT NULL,
    empresa_id bigint NOT NULL,
    nome_responsavel_empresa character varying(128) NOT NULL,
    numero_telefone_responsavel_empresa character varying(9) NOT NULL,
    tipo_responsavel_id bigint NOT NULL
);


--
-- TOC entry 2645 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE responsavel_empresa IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2646 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN responsavel_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.id IS 'identificador do registro';


--
-- TOC entry 2647 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN responsavel_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2648 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN responsavel_empresa.ddd_responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.ddd_responsavel_empresa IS 'DDD do telefone do responsável pela empresa contendo 2 caracteres';


--
-- TOC entry 2649 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN responsavel_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.empresa_id IS 'identificador da empresa';


--
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN responsavel_empresa.nome_responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.nome_responsavel_empresa IS 'Nome do responsável contendo no máximo 128 caracteres';


--
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN responsavel_empresa.numero_telefone_responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.numero_telefone_responsavel_empresa IS 'Número do Telefone do responsável pela empresa contendo de 8 a 9 caracteres e com valor unico somando o ddd e o numero do telefone';


--
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN responsavel_empresa.tipo_responsavel_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.tipo_responsavel_id IS 'identificador do tipo de responsável';


--
-- TOC entry 212 (class 1259 OID 89675)
-- Name: responsavel_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE responsavel_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 212
-- Name: responsavel_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE responsavel_empresa_id_seq OWNED BY responsavel_empresa.id;


--
-- TOC entry 215 (class 1259 OID 89687)
-- Name: responsavel_propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE responsavel_propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    ddd_responsavel_propriedade character varying(2) NOT NULL,
    nome_responsavel_propriedade character varying(128) NOT NULL,
    numero_telefone_responsavel_propriedade character varying(9) NOT NULL,
    propriedade_id bigint NOT NULL,
    tipo_responsavel_id bigint NOT NULL
);


--
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE responsavel_propriedade IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN responsavel_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN responsavel_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN responsavel_propriedade.ddd_responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.ddd_responsavel_propriedade IS 'DDD do telefone do responsável pela propriedade contendo 2 caracteres';


--
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN responsavel_propriedade.nome_responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.nome_responsavel_propriedade IS 'Nome do responsável contendo no máximo 128 caracteres';


--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN responsavel_propriedade.numero_telefone_responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.numero_telefone_responsavel_propriedade IS 'Número do Telefone do responsável pela propriedade contendo de 8 a 9 caracteres e com valor unico somando o ddd e o numero do telefone';


--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN responsavel_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.propriedade_id IS 'identificador da propriedade';


--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN responsavel_propriedade.tipo_responsavel_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.tipo_responsavel_id IS 'identificador do tipo de responsável';


--
-- TOC entry 214 (class 1259 OID 89685)
-- Name: responsavel_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE responsavel_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 214
-- Name: responsavel_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE responsavel_propriedade_id_seq OWNED BY responsavel_propriedade.id;


--
-- TOC entry 217 (class 1259 OID 89697)
-- Name: talhao_propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE talhao_propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_talhao character varying(128) NOT NULL,
    ha_talhao double precision NOT NULL,
    latitude_talhao character varying(11) NOT NULL,
    longitude_talhao character varying(11) NOT NULL,
    propriedade_id bigint NOT NULL
);


--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE talhao_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE talhao_propriedade IS 'Tabela contendo os Talhoes das Propriedades do sistema';


--
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN talhao_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN talhao_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN talhao_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN talhao_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 216 (class 1259 OID 89695)
-- Name: talhao_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE talhao_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 216
-- Name: talhao_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE talhao_propriedade_id_seq OWNED BY talhao_propriedade.id;


--
-- TOC entry 219 (class 1259 OID 89705)
-- Name: telefone_empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE telefone_empresa (
    id bigint NOT NULL,
    version bigint NOT NULL,
    ddd_empresa character varying(2) NOT NULL,
    empresa_id bigint NOT NULL,
    numero_telefone_empresa character varying(9) NOT NULL
);


--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE telefone_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE telefone_empresa IS 'Tabela contendo os telefones das Empresas do sistema';


--
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN telefone_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.id IS 'identificador do registro';


--
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN telefone_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN telefone_empresa.ddd_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.ddd_empresa IS 'número do ddd do telefone';


--
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN telefone_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.empresa_id IS 'identificador da tabela empresa';


--
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN telefone_empresa.numero_telefone_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.numero_telefone_empresa IS 'número do telefone';


--
-- TOC entry 218 (class 1259 OID 89703)
-- Name: telefone_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE telefone_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 218
-- Name: telefone_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE telefone_empresa_id_seq OWNED BY telefone_empresa.id;


--
-- TOC entry 221 (class 1259 OID 89715)
-- Name: telefone_propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE telefone_propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    ddd_propriedade character varying(2) NOT NULL,
    numero_telefone_propriedade character varying(9) NOT NULL,
    propriedade_id bigint NOT NULL
);


--
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE telefone_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE telefone_propriedade IS 'Tabela contendo os telefones das Propriedades do sistema';


--
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN telefone_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN telefone_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN telefone_propriedade.ddd_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.ddd_propriedade IS 'número do ddd do telefone';


--
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN telefone_propriedade.numero_telefone_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.numero_telefone_propriedade IS 'número do telefone';


--
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN telefone_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.propriedade_id IS 'identificador da tabela propriedade';


--
-- TOC entry 220 (class 1259 OID 89713)
-- Name: telefone_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE telefone_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 220
-- Name: telefone_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE telefone_propriedade_id_seq OWNED BY telefone_propriedade.id;


--
-- TOC entry 223 (class 1259 OID 89725)
-- Name: tipo_certificacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_certificacao (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_certificacao character varying(128) NOT NULL
);


--
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE tipo_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE tipo_certificacao IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN tipo_certificacao.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_certificacao.id IS 'identificador do registro';


--
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN tipo_certificacao.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_certificacao.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN tipo_certificacao.descricao_tipo_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_certificacao.descricao_tipo_certificacao IS 'Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único';


--
-- TOC entry 222 (class 1259 OID 89723)
-- Name: tipo_certificacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_certificacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 222
-- Name: tipo_certificacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_certificacao_id_seq OWNED BY tipo_certificacao.id;


--
-- TOC entry 225 (class 1259 OID 89733)
-- Name: tipo_responsavel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_responsavel (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_responsavel character varying(128) NOT NULL
);


--
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE tipo_responsavel; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE tipo_responsavel IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN tipo_responsavel.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_responsavel.id IS 'identificador do registro';


--
-- TOC entry 2688 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN tipo_responsavel.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_responsavel.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2689 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN tipo_responsavel.descricao_tipo_responsavel; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_responsavel.descricao_tipo_responsavel IS 'Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único';


--
-- TOC entry 224 (class 1259 OID 89731)
-- Name: tipo_responsavel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_responsavel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2690 (class 0 OID 0)
-- Dependencies: 224
-- Name: tipo_responsavel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_responsavel_id_seq OWNED BY tipo_responsavel.id;


--
-- TOC entry 2177 (class 2604 OID 89525)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso ALTER COLUMN id SET DEFAULT nextval('acesso_id_seq'::regclass);


--
-- TOC entry 2198 (class 2604 OID 97233)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo ALTER COLUMN id SET DEFAULT nextval('atributo_id_seq'::regclass);


--
-- TOC entry 2178 (class 2604 OID 89548)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audit_log_event ALTER COLUMN id SET DEFAULT nextval('audit_log_event_id_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 89559)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa ALTER COLUMN id SET DEFAULT nextval('certificacao_empresa_id_seq'::regclass);


--
-- TOC entry 2180 (class 2604 OID 89570)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade ALTER COLUMN id SET DEFAULT nextval('certificacao_propriedade_id_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 89581)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade ALTER COLUMN id SET DEFAULT nextval('cidade_id_seq'::regclass);


--
-- TOC entry 2199 (class 2604 OID 97246)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar ALTER COLUMN id SET DEFAULT nextval('cultivar_id_seq'::regclass);


--
-- TOC entry 2182 (class 2604 OID 89589)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresa ALTER COLUMN id SET DEFAULT nextval('empresa_id_seq'::regclass);


--
-- TOC entry 2183 (class 2604 OID 89600)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado ALTER COLUMN id SET DEFAULT nextval('estado_id_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 97256)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase ALTER COLUMN id SET DEFAULT nextval('fase_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 89608)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_empresa ALTER COLUMN id SET DEFAULT nextval('foto_empresa_id_seq'::regclass);


--
-- TOC entry 2185 (class 2604 OID 89619)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_propriedade ALTER COLUMN id SET DEFAULT nextval('foto_propriedade_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 89630)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_talhao_propriedade ALTER COLUMN id SET DEFAULT nextval('foto_talhao_propriedade_id_seq'::regclass);


--
-- TOC entry 2201 (class 2604 OID 97269)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo ALTER COLUMN id SET DEFAULT nextval('lista_atributo_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 89641)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais ALTER COLUMN id SET DEFAULT nextval('pais_id_seq'::regclass);


--
-- TOC entry 2188 (class 2604 OID 89649)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissao ALTER COLUMN id SET DEFAULT nextval('permissao_id_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 97284)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto ALTER COLUMN id SET DEFAULT nextval('produto_id_seq'::regclass);


--
-- TOC entry 2189 (class 2604 OID 89659)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY propriedade ALTER COLUMN id SET DEFAULT nextval('propriedade_id_seq'::regclass);


--
-- TOC entry 2203 (class 2604 OID 97295)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo ALTER COLUMN id SET DEFAULT nextval('rastro_atributo_id_seq'::regclass);


--
-- TOC entry 2204 (class 2604 OID 97306)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase ALTER COLUMN id SET DEFAULT nextval('rastro_fase_id_seq'::regclass);


--
-- TOC entry 2205 (class 2604 OID 97314)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto ALTER COLUMN id SET DEFAULT nextval('rastro_produto_id_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 89670)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regra ALTER COLUMN id SET DEFAULT nextval('regra_id_seq'::regclass);


--
-- TOC entry 2191 (class 2604 OID 89680)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa ALTER COLUMN id SET DEFAULT nextval('responsavel_empresa_id_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 89690)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade ALTER COLUMN id SET DEFAULT nextval('responsavel_propriedade_id_seq'::regclass);


--
-- TOC entry 2193 (class 2604 OID 89700)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_propriedade ALTER COLUMN id SET DEFAULT nextval('talhao_propriedade_id_seq'::regclass);


--
-- TOC entry 2194 (class 2604 OID 89708)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa ALTER COLUMN id SET DEFAULT nextval('telefone_empresa_id_seq'::regclass);


--
-- TOC entry 2195 (class 2604 OID 89718)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade ALTER COLUMN id SET DEFAULT nextval('telefone_propriedade_id_seq'::regclass);


--
-- TOC entry 2196 (class 2604 OID 89728)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_certificacao ALTER COLUMN id SET DEFAULT nextval('tipo_certificacao_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 89736)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_responsavel ALTER COLUMN id SET DEFAULT nextval('tipo_responsavel_id_seq'::regclass);


--
-- TOC entry 2446 (class 0 OID 89522)
-- Dependencies: 182
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO acesso (id, version, account_expired, account_locked, email, enabled, password, password_expired, username) VALUES (1, 9, false, false, 'claudioagner@hotmail.com', true, '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', false, 'admin');


--
-- TOC entry 2447 (class 0 OID 89528)
-- Dependencies: 183
-- Data for Name: acesso_empresas; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2691 (class 0 OID 0)
-- Dependencies: 181
-- Name: acesso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('acesso_id_seq', 4, true);


--
-- TOC entry 2448 (class 0 OID 89533)
-- Dependencies: 184
-- Data for Name: acesso_propriedades; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2449 (class 0 OID 89538)
-- Dependencies: 185
-- Data for Name: acesso_regra; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO acesso_regra (regra_id, acesso_id) VALUES (1, 1);


--
-- TOC entry 2491 (class 0 OID 97230)
-- Dependencies: 227
-- Data for Name: atributo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (14, 0, NULL, 2, 'DATA APLICAÇÃO', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (16, 0, NULL, 3, 'DATA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (62, 0, NULL, 9, 'TIPO DO SILO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (70, 1, NULL, 10, 'DOSE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (29, 1, NULL, 4, 'FORNECEDOR PRODUTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (103, 1, NULL, 14, 'IDENTIFICAÇÃO SILO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (28, 1, NULL, 4, 'PRODUTO UTILIZADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (32, 0, NULL, 4, 'DATA APLICAÇÃO', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (63, 0, NULL, 9, 'DATA ENTRADA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (1, 0, NULL, 1, 'FORNECEDOR SEMENTE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (2, 0, NULL, 1, 'PRODUTO APLICADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (3, 0, NULL, 1, 'FORNECEDOR PRODUTO APLICADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (4, 0, NULL, 1, 'DOSE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (5, 0, NULL, 1, 'VARIEDADE SEMENTE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (6, 0, NULL, 1, 'PERÍODO TRATAMENTO', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (7, 0, NULL, 1, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (8, 0, NULL, 2, 'PRODUTO UTILIZADO BASE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (9, 0, NULL, 2, 'PRODUTO UTILIZADO COBERTURA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (10, 0, NULL, 2, 'FORMULAÇÃO BASE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (11, 0, NULL, 2, 'FORMULAÇÃO COBERTURA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (12, 0, NULL, 2, 'DOSE BASE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (13, 0, NULL, 2, 'DOSE COBERTURA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (15, 0, NULL, 2, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (17, 0, NULL, 3, 'TALHÃO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (18, 0, NULL, 3, 'ÁREA CULTIVADA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (20, 0, NULL, 3, 'ROTAÇÃO DE CULTURAS', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (22, 1, NULL, 3, 'TIPO DO SOLO', 'Lista');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (23, 0, NULL, 3, 'N° DE SEMENTES/METRO LINEAR', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (24, 1, NULL, 3, 'ESPAÇAMENTO ENTRE-LINHAS', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (25, 0, NULL, 3, 'IDENTIFICAÇÃO IMPLEMENTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (26, 0, NULL, 3, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (33, 0, NULL, 4, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (41, 1, NULL, 5, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (43, 1, NULL, 6, 'DESCRIÇÃO ALVO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (51, 0, NULL, 6, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (52, 0, NULL, 7, 'IDENTIFICAÇÃO IMPLEMENTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (53, 0, NULL, 7, 'DATA REGULAGEM', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (54, 0, NULL, 7, 'DESCRIÇÃO SERVIÇO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (55, 0, NULL, 7, 'RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (56, 0, NULL, 7, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (57, 0, NULL, 8, 'PRODUTIVIDADE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (58, 0, NULL, 8, 'PERÍODO COLHEITA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (59, 0, NULL, 8, 'IDENTIFICAÇÃO IMPLEMENTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (60, 0, NULL, 8, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (61, 0, NULL, 9, 'IDENTIFICAÇÃO SILO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (64, 0, NULL, 9, 'DATA SAÍDA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (65, 0, NULL, 9, 'UMIDADE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (66, 0, NULL, 9, 'TEMPERATURA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (67, 0, NULL, 9, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (72, 0, NULL, 10, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (73, 0, NULL, 11, 'IDENTIFICAÇÃO DO VEÍCULO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (74, 0, NULL, 11, 'DATA SAÍDA PROPRIEDADE', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (75, 0, NULL, 11, 'DATA ENTRADA EMPRESA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (76, 0, NULL, 11, 'RESPONSÁVEL TRANSPORTE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (77, 0, NULL, 11, 'ANÁLISE QUÍMICA AMOSTRA - DESCRIÇÃO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (78, 0, NULL, 11, 'ANÁLISE QUÍMICA AMOSTRA – QUANTIDADE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (79, 0, NULL, 11, 'ANÁLISE QUÍMICA AMOSTRA – RESULTADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (80, 0, NULL, 11, 'IDENTIFICAÇÃO DA MOEGA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (81, 0, NULL, 11, 'NÚMERO NOTA FISCAL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (82, 0, NULL, 11, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (83, 1, NULL, 12, 'DATA ANÁLISE', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (88, 1, NULL, 12, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (89, 0, NULL, 13, 'IDENTIFICAÇÃO EMPRESA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (90, 0, NULL, 13, 'IDENTIFICAÇÃO SILO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (91, 0, NULL, 13, 'TIPO DO SILO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (92, 0, NULL, 13, 'CLASSIFICAÇÃO GRÃO', 'Lista');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (93, 0, NULL, 13, 'DATA ENTRADA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (94, 0, NULL, 13, 'DATA SAÍDA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (95, 0, NULL, 13, 'IDENTIFICAÇÃO SECADOR', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (96, 0, NULL, 13, 'TEMPERATURA SECADOR', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (97, 0, NULL, 13, 'TEMPERATURA DO AR AMBIENTE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (98, 0, NULL, 13, 'UMIDADE DO AR AMBIENTE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (99, 0, NULL, 13, 'UMIDADE DO AR SECADOR', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (100, 0, NULL, 13, 'UMIDADE MASSA DE GRÃOS', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (101, 0, NULL, 13, 'TEMPERATURA MASSA DE GRÃOS', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (102, 0, NULL, 13, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (39, 1, NULL, 5, 'DATA APLICAÇÃO', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (37, 1, NULL, 5, 'DOSE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (36, 1, NULL, 5, 'FORNECEDOR PRODUTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (40, 1, NULL, 5, 'INFORMAÇÕES METEOROLÓGICAS', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (35, 1, NULL, 5, 'PRODUTO UTILIZADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (50, 1, NULL, 6, 'DATA APLICAÇÃO', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (49, 1, NULL, 6, 'DOSE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (44, 1, NULL, 6, 'ESTÁGIO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (48, 1, NULL, 6, 'FORNECEDOR PRODUTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (47, 1, NULL, 6, 'PRODUTO UTILIZADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (31, 1, NULL, 4, 'DOSE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (27, 1, NULL, 4, 'ESTÁDIO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (19, 1, NULL, 3, 'ANÁLISE QUÍMICA DO SOLO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (69, 1, NULL, 10, 'FORNECEDOR PRODUTO APLICADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (71, 1, NULL, 10, 'PERÍODO TRATAMENTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (68, 1, NULL, 10, 'PRODUTO APLICADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (84, 2, NULL, 12, 'HORA ANÁLISE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (87, 1, NULL, 12, 'RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (86, 1, NULL, 12, 'RESULTADO ANÁLISE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (85, 1, NULL, 12, 'TIPO ANÁLISE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (21, 1, NULL, 3, 'PREPARO DO SOLO', 'Lista');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (107, 0, NULL, 14, 'DATA APLICAÇÃO', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (110, 0, NULL, 14, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (114, 0, NULL, 15, 'DESCRIÇÃO VISTORIA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (115, 0, NULL, 15, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (127, 0, NULL, 17, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (133, 0, NULL, 18, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (134, 0, NULL, 19, 'TIPO EMBALAGEM', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (139, 0, NULL, 19, 'IDENTIFICAÇÃO DOS LOTES', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (140, 0, NULL, 19, 'RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (141, 0, NULL, 19, 'AGENTE RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (128, 1, NULL, 18, 'DATA ANÁLISE', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (129, 1, NULL, 18, 'HORA ANÁLISE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (132, 1, NULL, 18, 'RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (131, 1, NULL, 18, 'RESULTADO ANÁLISE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (130, 1, NULL, 18, 'TIPO ANÁLISE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (34, 1, NULL, 5, 'ESTÁDIO FENOLÓGICO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (136, 1, NULL, 19, 'DATA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (137, 1, NULL, 19, 'HORA INÍCIO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (138, 1, NULL, 19, 'HORA TÉRMINO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (135, 1, NULL, 19, 'QUANTIDADE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (106, 1, NULL, 14, 'DOSE', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (104, 1, NULL, 14, 'IDENTIFICAÇÃO INSETO/PRAGA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (108, 1, NULL, 14, 'JUSTIFICATIVA', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (105, 1, NULL, 14, 'PRODUTO APLICADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (109, 1, NULL, 14, 'RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (112, 1, NULL, 15, 'DATA VISTORIA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (111, 1, NULL, 15, 'IDENTIFICAÇÃO SILO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (113, 1, NULL, 15, 'RESULTADO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (124, 1, NULL, 17, 'DATA ROTULAGEM', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (125, 1, NULL, 17, 'DESCRIÇÃO SERVIÇO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (123, 1, NULL, 17, 'IDENTIFICAÇÃO EQUIPAMENTO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (126, 1, NULL, 17, 'RESPONSÁVEL', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (119, 1, NULL, 16, 'DATA ENTRADA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (120, 1, NULL, 16, 'DATA SAÍDA', 'Data');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (121, 1, NULL, 16, 'HORA INÍCIO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (122, 1, NULL, 16, 'HORA TÉRMINO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (116, 1, NULL, 16, 'IDENTIFICAÇÃO CAIXA DE PREPARAÇÃO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (117, 1, NULL, 16, 'IDENTIFICAÇÃO SILO', 'Texto');
INSERT INTO atributo (id, version, descricao_atributo, fase_id, nome_atributo, tipo_atributo) VALUES (118, 1, NULL, 16, 'QUANTIDADE', 'Texto');


--
-- TOC entry 2692 (class 0 OID 0)
-- Dependencies: 226
-- Name: atributo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('atributo_id_seq', 141, true);


--
-- TOC entry 2451 (class 0 OID 89545)
-- Dependencies: 187
-- Data for Name: audit_log_event; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (1, 'system', 'Regra', '2016-04-24 15:24:45.262', 'INSERT', '2016-04-24 15:24:45.262', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (2, 'system', 'Regra', '2016-04-24 15:24:45.387', 'INSERT', '2016-04-24 15:24:45.387', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (3, 'system', 'Regra', '2016-04-24 15:24:45.403', 'INSERT', '2016-04-24 15:24:45.403', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (4, 'system', 'Regra', '2016-04-24 15:24:45.418', 'INSERT', '2016-04-24 15:24:45.418', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (5, 'system', 'Regra', '2016-04-24 15:24:45.434', 'INSERT', '2016-04-24 15:24:45.434', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (6, 'system', 'Acesso', '2016-04-24 15:24:45.497', 'INSERT', '2016-04-24 15:24:45.497', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (7, 'system', 'AcessoRegra', '2016-04-24 15:24:45.559', 'INSERT', '2016-04-24 15:24:45.559', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (8, 'system', 'Permissao', '2016-04-24 15:24:45.59', 'INSERT', '2016-04-24 15:24:45.59', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (9, 'system', 'Permissao', '2016-04-24 15:24:45.606', 'INSERT', '2016-04-24 15:24:45.606', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (10, 'system', 'Permissao', '2016-04-24 15:24:45.622', 'INSERT', '2016-04-24 15:24:45.622', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (11, 'system', 'Permissao', '2016-04-24 15:24:45.637', 'INSERT', '2016-04-24 15:24:45.637', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (12, 'system', 'Permissao', '2016-04-24 15:24:45.668', 'INSERT', '2016-04-24 15:24:45.668', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (13, 'system', 'Permissao', '2016-04-24 15:24:45.684', 'INSERT', '2016-04-24 15:24:45.684', NULL, NULL, '6', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (14, 'system', 'Permissao', '2016-04-24 15:24:45.7', 'INSERT', '2016-04-24 15:24:45.7', NULL, NULL, '7', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (15, 'system', 'Permissao', '2016-04-24 15:24:45.7', 'INSERT', '2016-04-24 15:24:45.7', NULL, NULL, '8', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (16, 'system', 'Permissao', '2016-04-24 15:24:45.731', 'INSERT', '2016-04-24 15:24:45.731', NULL, NULL, '9', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (17, 'system', 'Permissao', '2016-04-24 15:24:45.747', 'INSERT', '2016-04-24 15:24:45.747', NULL, NULL, '10', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (18, 'system', 'Permissao', '2016-04-24 15:24:45.762', 'INSERT', '2016-04-24 15:24:45.762', NULL, NULL, '11', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (19, 'system', 'Permissao', '2016-04-24 15:24:45.762', 'INSERT', '2016-04-24 15:24:45.762', NULL, NULL, '12', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (20, 'system', 'Permissao', '2016-04-24 15:24:45.778', 'INSERT', '2016-04-24 15:24:45.778', NULL, NULL, '13', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (21, 'system', 'Permissao', '2016-04-24 15:24:45.793', 'INSERT', '2016-04-24 15:24:45.793', NULL, NULL, '14', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (22, 'system', 'Permissao', '2016-04-24 15:24:45.809', 'INSERT', '2016-04-24 15:24:45.809', NULL, NULL, '15', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (23, 'system', 'Permissao', '2016-04-24 15:24:45.825', 'INSERT', '2016-04-24 15:24:45.825', NULL, NULL, '16', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (24, 'system', 'Permissao', '2016-04-24 15:24:45.84', 'INSERT', '2016-04-24 15:24:45.84', NULL, NULL, '17', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (25, 'system', 'Permissao', '2016-04-24 15:24:45.856', 'INSERT', '2016-04-24 15:24:45.856', NULL, NULL, '18', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (26, 'system', 'Permissao', '2016-04-24 15:24:45.872', 'INSERT', '2016-04-24 15:24:45.872', NULL, NULL, '19', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (27, 'admin', 'AcessoRegra', '2016-04-25 22:31:20.651', 'INSERT', '2016-04-25 22:31:20.651', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (28, 'admin', 'Acesso', '2016-04-25 22:31:20.907', 'UPDATE', '2016-04-25 22:31:20.907', 'false', 'true', '1', 0, 'enabled', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (29, 'admin', 'AcessoRegra', '2016-04-25 22:31:29.152', 'INSERT', '2016-04-25 22:31:29.152', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (30, 'admin', 'Acesso', '2016-04-25 22:31:29.171', 'UPDATE', '2016-04-25 22:31:29.171', 'true', 'false', '1', 1, 'enabled', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (31, 'admin', 'AcessoRegra', '2016-04-26 07:37:41.063', 'INSERT', '2016-04-26 07:37:41.063', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (32, 'admin', 'Empresa', '2016-04-26 07:57:34.381', 'INSERT', '2016-04-26 07:57:34.381', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (33, 'admin', 'AcessoRegra', '2016-04-26 07:57:46.027', 'INSERT', '2016-04-26 07:57:46.027', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (34, 'admin', 'Empresa', '2016-04-26 07:57:46.239', 'UPDATE', '2016-04-26 07:57:46.239', '[admin]', '[]', '1', 1, 'acessos', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (35, 'admin', 'Propriedade', '2016-04-26 07:58:26.86', 'INSERT', '2016-04-26 07:58:26.86', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (36, 'admin', 'AcessoRegra', '2016-04-26 07:58:37.589', 'INSERT', '2016-04-26 07:58:37.589', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (37, 'admin', 'Propriedade', '2016-04-26 07:58:37.617', 'UPDATE', '2016-04-26 07:58:37.617', '[admin]', '[]', '1', 1, 'acessos', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (38, 'admin', 'AcessoRegra', '2016-04-26 08:53:27.449', 'INSERT', '2016-04-26 08:53:27.449', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (39, 'admin', 'Acesso', '2016-04-26 08:53:27.473', 'UPDATE', '2016-04-26 08:53:27.473', 'true', 'false', '1', 6, 'passwordExpired', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (40, 'admin', 'Acesso', '2016-04-26 08:53:27.481', 'UPDATE', '2016-04-26 08:53:27.481', 'true', 'false', '1', 6, 'accountExpired', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (41, 'admin', 'Acesso', '2016-04-26 08:53:27.489', 'UPDATE', '2016-04-26 08:53:27.489', 'true', 'false', '1', 6, 'accountLocked', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (42, 'admin', 'AcessoRegra', '2016-04-26 08:53:33.381', 'INSERT', '2016-04-26 08:53:33.381', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (43, 'admin', 'Acesso', '2016-04-26 08:53:33.397', 'UPDATE', '2016-04-26 08:53:33.397', 'false', 'true', '1', 7, 'passwordExpired', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (44, 'admin', 'Acesso', '2016-04-26 08:53:33.405', 'UPDATE', '2016-04-26 08:53:33.405', 'false', 'true', '1', 7, 'accountExpired', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (45, 'admin', 'Acesso', '2016-04-26 08:53:33.413', 'UPDATE', '2016-04-26 08:53:33.413', 'false', 'true', '1', 7, 'accountLocked', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (46, 'admin', 'Acesso', '2016-04-26 09:59:28.817', 'DELETE', '2016-04-26 09:59:28.817', NULL, NULL, '1', 7, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (47, 'admin', 'AcessoRegra', '2016-04-26 10:13:15.591', 'INSERT', '2016-04-26 10:13:15.591', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (48, 'admin', 'AcessoRegra', '2016-04-26 10:17:40.765', 'INSERT', '2016-04-26 10:17:40.765', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (49, 'admin', 'Acesso', '2016-04-26 12:58:19.024', 'INSERT', '2016-04-26 12:58:19.024', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (50, 'admin', 'Acesso', '2016-04-26 12:58:51.547', 'UPDATE', '2016-04-26 12:58:51.547', '**********', '**********', '2', 0, 'password', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (51, 'admin', 'AcessoRegra', '2016-04-26 12:59:32.191', 'INSERT', '2016-04-26 12:59:32.191', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (52, 'admin', 'Acesso', '2016-04-26 12:59:40.328', 'DELETE', '2016-04-26 12:59:40.328', NULL, NULL, '2', 2, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (53, 'admin', 'Acesso', '2016-04-26 13:00:28.062', 'DELETE', '2016-04-26 13:00:28.062', NULL, NULL, '2', 3, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (54, 'admin', 'Acesso', '2016-04-26 13:22:47.846', 'INSERT', '2016-04-26 13:22:47.846', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (55, 'admin', 'AcessoRegra', '2016-04-26 13:22:47.868', 'INSERT', '2016-04-26 13:22:47.868', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (56, 'admin', 'AcessoRegra', '2016-04-26 13:22:59.509', 'INSERT', '2016-04-26 13:22:59.509', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (57, 'admin', 'AcessoRegra', '2016-04-26 13:23:44.727', 'INSERT', '2016-04-26 13:23:44.727', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (58, 'admin', 'Acesso', '2016-04-26 13:23:44.743', 'UPDATE', '2016-04-26 13:23:44.743', 'claudioagner@hotmail.com', 'claudioagner@hotmail.re', '3', 0, 'email', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (59, 'admin', 'AcessoRegra', '2016-04-26 13:24:30.017', 'INSERT', '2016-04-26 13:24:30.017', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (60, 'admin', 'Acesso', '2016-04-26 13:24:30.07', 'UPDATE', '2016-04-26 13:24:30.07', 'claudioagner@teste.com', 'claudioagner@hotmail.com', '3', 1, 'email', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (61, 'admin', 'AcessoRegra', '2016-04-26 13:26:07.679', 'INSERT', '2016-04-26 13:26:07.679', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (62, 'admin', 'Acesso', '2016-04-26 13:27:00.739', 'DELETE', '2016-04-26 13:27:00.739', NULL, NULL, '3', 3, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (63, 'admin', 'Acesso', '2016-04-26 13:58:29.506', 'INSERT', '2016-04-26 13:58:29.506', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (64, 'admin', 'Acesso', '2016-04-26 13:58:48.894', 'DELETE', '2016-04-26 13:58:48.894', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (65, 'system', 'Produto', '2016-04-26 20:54:57.616', 'INSERT', '2016-04-26 20:54:57.616', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (66, 'system', 'Cultivar', '2016-04-26 20:55:13.509', 'INSERT', '2016-04-26 20:55:13.509', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (67, 'system', 'Fase', '2016-04-26 20:56:20.444', 'INSERT', '2016-04-26 20:56:20.444', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (68, 'system', 'Atributo', '2016-04-26 20:57:06.668', 'INSERT', '2016-04-26 20:57:06.668', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (69, 'system', 'Atributo', '2016-04-26 20:58:02.083', 'INSERT', '2016-04-26 20:58:02.083', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (70, 'system', 'Atributo', '2016-04-26 20:58:16.702', 'INSERT', '2016-04-26 20:58:16.702', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (71, 'system', 'Atributo', '2016-04-26 20:58:37.243', 'INSERT', '2016-04-26 20:58:37.243', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (72, 'system', 'Atributo', '2016-04-26 21:00:08.06', 'INSERT', '2016-04-26 21:00:08.06', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (73, 'system', 'Atributo', '2016-04-26 21:00:20.166', 'INSERT', '2016-04-26 21:00:20.166', NULL, NULL, '6', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (74, 'system', 'Atributo', '2016-04-26 21:00:31.296', 'INSERT', '2016-04-26 21:00:31.296', NULL, NULL, '7', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (75, 'system', 'Fase', '2016-04-26 21:00:56.424', 'INSERT', '2016-04-26 21:00:56.424', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (76, 'system', 'Atributo', '2016-04-26 21:01:18.066', 'INSERT', '2016-04-26 21:01:18.066', NULL, NULL, '8', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (77, 'system', 'Atributo', '2016-04-26 21:01:35.119', 'INSERT', '2016-04-26 21:01:35.119', NULL, NULL, '9', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (78, 'system', 'Atributo', '2016-04-26 21:01:44.48', 'INSERT', '2016-04-26 21:01:44.48', NULL, NULL, '10', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (79, 'system', 'Atributo', '2016-04-26 21:01:55.059', 'INSERT', '2016-04-26 21:01:55.059', NULL, NULL, '11', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (80, 'system', 'Atributo', '2016-04-26 21:02:05.103', 'INSERT', '2016-04-26 21:02:05.103', NULL, NULL, '12', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (81, 'system', 'Atributo', '2016-04-26 21:02:30.535', 'INSERT', '2016-04-26 21:02:30.535', NULL, NULL, '13', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (82, 'system', 'Atributo', '2016-04-26 21:02:44.857', 'INSERT', '2016-04-26 21:02:44.857', NULL, NULL, '14', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (83, 'system', 'Atributo', '2016-04-26 21:03:54.093', 'INSERT', '2016-04-26 21:03:54.093', NULL, NULL, '15', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (84, 'system', 'Fase', '2016-04-26 21:04:43.417', 'INSERT', '2016-04-26 21:04:43.417', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (85, 'system', 'Atributo', '2016-04-26 21:04:51.778', 'INSERT', '2016-04-26 21:04:51.778', NULL, NULL, '16', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (86, 'system', 'Atributo', '2016-04-26 21:05:25.655', 'INSERT', '2016-04-26 21:05:25.655', NULL, NULL, '17', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (87, 'system', 'Atributo', '2016-04-26 21:05:40.916', 'INSERT', '2016-04-26 21:05:40.916', NULL, NULL, '18', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (88, 'system', 'Atributo', '2016-04-26 21:06:50.103', 'INSERT', '2016-04-26 21:06:50.103', NULL, NULL, '19', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (89, 'system', 'Atributo', '2016-04-26 21:07:09.342', 'INSERT', '2016-04-26 21:07:09.342', NULL, NULL, '20', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (90, 'system', 'Atributo', '2016-04-26 21:07:28.753', 'INSERT', '2016-04-26 21:07:28.753', NULL, NULL, '21', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (91, 'system', 'Atributo', '2016-04-26 21:07:41.924', 'INSERT', '2016-04-26 21:07:41.924', NULL, NULL, '22', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (92, 'system', 'Atributo', '2016-04-26 21:07:54.698', 'INSERT', '2016-04-26 21:07:54.698', NULL, NULL, '23', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (93, 'system', 'Atributo', '2016-04-26 21:08:08.093', 'INSERT', '2016-04-26 21:08:08.093', NULL, NULL, '24', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (94, 'system', 'Atributo', '2016-04-26 21:08:17.785', 'UPDATE', '2016-04-26 21:08:17.785', 'Número', 'Texto Curto', '24', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (95, 'system', 'Atributo', '2016-04-26 21:08:32.542', 'INSERT', '2016-04-26 21:08:32.542', NULL, NULL, '25', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (96, 'system', 'Atributo', '2016-04-26 21:09:02.96', 'INSERT', '2016-04-26 21:09:02.96', NULL, NULL, '26', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (97, 'admin', 'ListaAtributo', '2016-04-27 09:21:30.053', 'INSERT', '2016-04-27 09:21:30.053', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (98, 'admin', 'ListaAtributo', '2016-04-27 09:21:33.783', 'DELETE', '2016-04-27 09:21:33.783', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (99, 'admin', 'ListaAtributo', '2016-04-27 09:32:59.382', 'INSERT', '2016-04-27 09:32:59.382', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (100, 'admin', 'Fase', '2016-04-27 09:45:41.253', 'INSERT', '2016-04-27 09:45:41.253', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (101, 'admin', 'Atributo', '2016-04-27 09:46:09.831', 'INSERT', '2016-04-27 09:46:09.831', NULL, NULL, '27', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (102, 'admin', 'Atributo', '2016-04-27 09:47:44.089', 'INSERT', '2016-04-27 09:47:44.089', NULL, NULL, '28', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (103, 'admin', 'Atributo', '2016-04-27 09:48:11.185', 'INSERT', '2016-04-27 09:48:11.185', NULL, NULL, '29', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (104, 'system', 'Atributo', '2016-04-27 09:51:32.819', 'INSERT', '2016-04-27 09:51:32.819', NULL, NULL, '31', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (105, 'system', 'Atributo', '2016-04-27 09:51:50.857', 'INSERT', '2016-04-27 09:51:50.857', NULL, NULL, '32', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (106, 'system', 'Atributo', '2016-04-27 09:52:33.659', 'INSERT', '2016-04-27 09:52:33.659', NULL, NULL, '33', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (107, 'system', 'Fase', '2016-04-27 09:53:07.039', 'INSERT', '2016-04-27 09:53:07.039', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (108, 'system', 'Atributo', '2016-04-27 09:53:15.559', 'INSERT', '2016-04-27 09:53:15.559', NULL, NULL, '34', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (109, 'system', 'Atributo', '2016-04-27 09:53:44.969', 'INSERT', '2016-04-27 09:53:44.969', NULL, NULL, '35', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (110, 'system', 'Atributo', '2016-04-27 09:54:03.631', 'INSERT', '2016-04-27 09:54:03.631', NULL, NULL, '36', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (111, 'system', 'Atributo', '2016-04-27 10:03:34.498', 'INSERT', '2016-04-27 10:03:34.498', NULL, NULL, '37', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (112, 'system', 'Atributo', '2016-04-27 10:07:28.297', 'INSERT', '2016-04-27 10:07:28.297', NULL, NULL, '38', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (113, 'system', 'Atributo', '2016-04-27 10:07:58.908', 'DELETE', '2016-04-27 10:07:58.908', NULL, NULL, '38', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (114, 'system', 'Atributo', '2016-04-27 10:08:21.691', 'INSERT', '2016-04-27 10:08:21.691', NULL, NULL, '39', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (115, 'system', 'Atributo', '2016-04-27 10:10:45.438', 'INSERT', '2016-04-27 10:10:45.438', NULL, NULL, '40', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (116, 'system', 'Atributo', '2016-04-27 10:10:56.599', 'INSERT', '2016-04-27 10:10:56.599', NULL, NULL, '41', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (117, 'system', 'Fase', '2016-04-27 10:11:28.91', 'INSERT', '2016-04-27 10:11:28.91', NULL, NULL, '6', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (118, 'system', 'Atributo', '2016-04-27 10:11:45.752', 'INSERT', '2016-04-27 10:11:45.752', NULL, NULL, '42', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (119, 'system', 'Atributo', '2016-04-27 10:12:00.433', 'DELETE', '2016-04-27 10:12:00.433', NULL, NULL, '42', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (120, 'system', 'Atributo', '2016-04-27 10:12:19.405', 'INSERT', '2016-04-27 10:12:19.405', NULL, NULL, '43', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (121, 'system', 'Atributo', '2016-04-27 10:12:40.144', 'INSERT', '2016-04-27 10:12:40.144', NULL, NULL, '44', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (122, 'system', 'Atributo', '2016-04-27 10:17:52.668', 'UPDATE', '2016-04-27 10:17:52.668', 'Texto', 'Texto Curto', '41', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (123, 'system', 'Atributo', '2016-04-27 10:18:09.828', 'UPDATE', '2016-04-27 10:18:09.828', 'Texto', 'Texto Curto', '43', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (124, 'system', 'Atributo', '2016-04-27 10:19:15.682', 'INSERT', '2016-04-27 10:19:15.682', NULL, NULL, '47', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (125, 'system', 'Atributo', '2016-04-27 10:19:28.668', 'INSERT', '2016-04-27 10:19:28.668', NULL, NULL, '48', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (126, 'system', 'Atributo', '2016-04-27 10:19:41.174', 'INSERT', '2016-04-27 10:19:41.174', NULL, NULL, '49', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (127, 'system', 'Atributo', '2016-04-27 10:19:55.28', 'INSERT', '2016-04-27 10:19:55.28', NULL, NULL, '50', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (128, 'system', 'Atributo', '2016-04-27 10:20:07.162', 'INSERT', '2016-04-27 10:20:07.162', NULL, NULL, '51', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (129, 'system', 'Fase', '2016-04-27 10:20:42.372', 'INSERT', '2016-04-27 10:20:42.372', NULL, NULL, '7', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (130, 'system', 'Atributo', '2016-04-27 10:20:53.361', 'INSERT', '2016-04-27 10:20:53.361', NULL, NULL, '52', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (131, 'system', 'Atributo', '2016-04-27 10:21:03.83', 'INSERT', '2016-04-27 10:21:03.83', NULL, NULL, '53', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (132, 'system', 'Atributo', '2016-04-27 10:21:16.976', 'INSERT', '2016-04-27 10:21:16.976', NULL, NULL, '54', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (133, 'system', 'Atributo', '2016-04-27 10:21:29.58', 'INSERT', '2016-04-27 10:21:29.58', NULL, NULL, '55', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (134, 'system', 'Atributo', '2016-04-27 10:21:47.822', 'INSERT', '2016-04-27 10:21:47.822', NULL, NULL, '56', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (135, 'system', 'Fase', '2016-04-27 10:22:03.538', 'INSERT', '2016-04-27 10:22:03.538', NULL, NULL, '8', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (136, 'system', 'Atributo', '2016-04-27 10:22:38.452', 'INSERT', '2016-04-27 10:22:38.452', NULL, NULL, '57', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (137, 'system', 'Atributo', '2016-04-27 10:22:56.598', 'INSERT', '2016-04-27 10:22:56.598', NULL, NULL, '58', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (138, 'system', 'Atributo', '2016-04-27 10:23:38.32', 'INSERT', '2016-04-27 10:23:38.32', NULL, NULL, '59', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (139, 'system', 'Atributo', '2016-04-27 10:23:51.01', 'INSERT', '2016-04-27 10:23:51.01', NULL, NULL, '60', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (140, 'system', 'Fase', '2016-04-27 10:24:27.326', 'INSERT', '2016-04-27 10:24:27.326', NULL, NULL, '9', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (141, 'system', 'Atributo', '2016-04-27 10:24:35.958', 'INSERT', '2016-04-27 10:24:35.958', NULL, NULL, '61', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (142, 'system', 'Atributo', '2016-04-27 10:24:54.698', 'INSERT', '2016-04-27 10:24:54.698', NULL, NULL, '62', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (143, 'system', 'Atributo', '2016-04-27 10:25:08.216', 'INSERT', '2016-04-27 10:25:08.216', NULL, NULL, '63', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (144, 'system', 'Atributo', '2016-04-27 10:25:28.744', 'INSERT', '2016-04-27 10:25:28.744', NULL, NULL, '64', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (145, 'system', 'Atributo', '2016-04-27 10:25:40.39', 'INSERT', '2016-04-27 10:25:40.39', NULL, NULL, '65', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (146, 'system', 'Atributo', '2016-04-27 10:25:51.896', 'INSERT', '2016-04-27 10:25:51.896', NULL, NULL, '66', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (147, 'system', 'Atributo', '2016-04-27 10:26:07.178', 'INSERT', '2016-04-27 10:26:07.178', NULL, NULL, '67', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (148, 'system', 'Fase', '2016-04-27 10:26:28.378', 'INSERT', '2016-04-27 10:26:28.378', NULL, NULL, '10', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (149, 'system', 'Atributo', '2016-04-27 10:26:38.41', 'INSERT', '2016-04-27 10:26:38.41', NULL, NULL, '68', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (150, 'system', 'Atributo', '2016-04-27 10:27:04.454', 'INSERT', '2016-04-27 10:27:04.454', NULL, NULL, '69', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (151, 'system', 'Atributo', '2016-04-27 10:27:16.838', 'INSERT', '2016-04-27 10:27:16.838', NULL, NULL, '70', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (152, 'system', 'Atributo', '2016-04-27 10:27:51.75', 'INSERT', '2016-04-27 10:27:51.75', NULL, NULL, '71', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (153, 'system', 'Atributo', '2016-04-27 10:28:03.996', 'INSERT', '2016-04-27 10:28:03.996', NULL, NULL, '72', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (154, 'system', 'Fase', '2016-04-27 10:28:49.612', 'INSERT', '2016-04-27 10:28:49.612', NULL, NULL, '11', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (155, 'system', 'Atributo', '2016-04-27 10:28:59.044', 'INSERT', '2016-04-27 10:28:59.044', NULL, NULL, '73', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (156, 'system', 'Atributo', '2016-04-27 10:29:09.39', 'INSERT', '2016-04-27 10:29:09.39', NULL, NULL, '74', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (157, 'system', 'Atributo', '2016-04-27 10:29:19.52', 'INSERT', '2016-04-27 10:29:19.52', NULL, NULL, '75', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (158, 'system', 'Atributo', '2016-04-27 10:29:28.914', 'INSERT', '2016-04-27 10:29:28.914', NULL, NULL, '76', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (159, 'system', 'Atributo', '2016-04-27 10:29:39.924', 'INSERT', '2016-04-27 10:29:39.924', NULL, NULL, '77', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (160, 'system', 'Atributo', '2016-04-27 10:29:55.47', 'INSERT', '2016-04-27 10:29:55.47', NULL, NULL, '78', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (161, 'system', 'Atributo', '2016-04-27 10:30:10.682', 'INSERT', '2016-04-27 10:30:10.682', NULL, NULL, '79', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (162, 'system', 'Atributo', '2016-04-27 10:30:26.042', 'INSERT', '2016-04-27 10:30:26.042', NULL, NULL, '80', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (163, 'system', 'Atributo', '2016-04-27 10:30:39.88', 'INSERT', '2016-04-27 10:30:39.88', NULL, NULL, '81', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (164, 'system', 'Atributo', '2016-04-27 10:30:49.77', 'INSERT', '2016-04-27 10:30:49.77', NULL, NULL, '82', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (165, 'system', 'Fase', '2016-04-27 10:31:14.404', 'INSERT', '2016-04-27 10:31:14.404', NULL, NULL, '12', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (166, 'system', 'Atributo', '2016-04-27 10:31:23.05', 'INSERT', '2016-04-27 10:31:23.05', NULL, NULL, '83', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (167, 'system', 'Atributo', '2016-04-27 10:31:42.822', 'INSERT', '2016-04-27 10:31:42.822', NULL, NULL, '84', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (168, 'system', 'Atributo', '2016-04-27 10:31:57.4', 'INSERT', '2016-04-27 10:31:57.4', NULL, NULL, '85', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (169, 'system', 'Atributo', '2016-04-27 10:32:06.702', 'UPDATE', '2016-04-27 10:32:06.702', 'Lista', 'Texto', '84', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (170, 'system', 'Atributo', '2016-04-27 10:32:32.238', 'INSERT', '2016-04-27 10:32:32.238', NULL, NULL, '86', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (171, 'system', 'Atributo', '2016-04-27 10:32:44.014', 'INSERT', '2016-04-27 10:32:44.014', NULL, NULL, '87', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (172, 'system', 'Atributo', '2016-04-27 10:33:20.636', 'INSERT', '2016-04-27 10:33:20.636', NULL, NULL, '88', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (173, 'system', 'Atributo', '2016-04-27 10:33:29.15', 'UPDATE', '2016-04-27 10:33:29.15', 'Texto', 'Lista', '88', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (174, 'system', 'Fase', '2016-04-27 10:34:13.034', 'INSERT', '2016-04-27 10:34:13.034', NULL, NULL, '13', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (175, 'system', 'Atributo', '2016-04-27 10:34:31.592', 'INSERT', '2016-04-27 10:34:31.592', NULL, NULL, '89', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (176, 'system', 'Atributo', '2016-04-27 10:34:48.138', 'INSERT', '2016-04-27 10:34:48.138', NULL, NULL, '90', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (177, 'system', 'Atributo', '2016-04-27 10:35:11.664', 'INSERT', '2016-04-27 10:35:11.664', NULL, NULL, '91', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (178, 'system', 'Atributo', '2016-04-27 10:37:14.071', 'INSERT', '2016-04-27 10:37:14.071', NULL, NULL, '92', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (179, 'system', 'Atributo', '2016-04-27 10:38:35.345', 'INSERT', '2016-04-27 10:38:35.345', NULL, NULL, '93', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (180, 'system', 'Atributo', '2016-04-27 10:38:45.642', 'INSERT', '2016-04-27 10:38:45.642', NULL, NULL, '94', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (181, 'system', 'Atributo', '2016-04-27 10:39:04.868', 'INSERT', '2016-04-27 10:39:04.868', NULL, NULL, '95', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (182, 'system', 'Atributo', '2016-04-27 10:39:34.05', 'INSERT', '2016-04-27 10:39:34.05', NULL, NULL, '96', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (183, 'system', 'Atributo', '2016-04-27 10:39:56.83', 'INSERT', '2016-04-27 10:39:56.83', NULL, NULL, '97', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (184, 'system', 'Atributo', '2016-04-27 10:40:18.148', 'INSERT', '2016-04-27 10:40:18.148', NULL, NULL, '98', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (185, 'system', 'Atributo', '2016-04-27 10:40:36.65', 'INSERT', '2016-04-27 10:40:36.65', NULL, NULL, '99', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (186, 'system', 'Atributo', '2016-04-27 10:41:01.802', 'INSERT', '2016-04-27 10:41:01.802', NULL, NULL, '100', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (187, 'system', 'Atributo', '2016-04-27 10:41:21.264', 'INSERT', '2016-04-27 10:41:21.264', NULL, NULL, '101', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (188, 'system', 'Atributo', '2016-04-27 10:41:31.022', 'INSERT', '2016-04-27 10:41:31.022', NULL, NULL, '102', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (189, 'system', 'Fase', '2016-04-27 10:41:57.904', 'INSERT', '2016-04-27 10:41:57.904', NULL, NULL, '14', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (190, 'system', 'Atributo', '2016-04-27 10:42:09.847', 'INSERT', '2016-04-27 10:42:09.847', NULL, NULL, '103', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (191, 'system', 'Atributo', '2016-04-27 10:42:28.393', 'INSERT', '2016-04-27 10:42:28.393', NULL, NULL, '104', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (192, 'system', 'Atributo', '2016-04-27 10:42:43.48', 'INSERT', '2016-04-27 10:42:43.48', NULL, NULL, '105', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (193, 'system', 'Atributo', '2016-04-27 10:42:56.588', 'INSERT', '2016-04-27 10:42:56.588', NULL, NULL, '106', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (194, 'system', 'Atributo', '2016-04-27 10:43:06.389', 'INSERT', '2016-04-27 10:43:06.389', NULL, NULL, '107', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (195, 'system', 'Atributo', '2016-04-27 10:43:32.887', 'INSERT', '2016-04-27 10:43:32.887', NULL, NULL, '108', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (196, 'system', 'Atributo', '2016-04-27 10:43:49.028', 'INSERT', '2016-04-27 10:43:49.028', NULL, NULL, '109', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (197, 'system', 'Atributo', '2016-04-27 10:44:00.332', 'INSERT', '2016-04-27 10:44:00.332', NULL, NULL, '110', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (198, 'system', 'Fase', '2016-04-27 10:44:22.627', 'INSERT', '2016-04-27 10:44:22.627', NULL, NULL, '15', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (199, 'system', 'Atributo', '2016-04-27 10:44:31.147', 'INSERT', '2016-04-27 10:44:31.147', NULL, NULL, '111', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (200, 'system', 'Atributo', '2016-04-27 10:44:47.45', 'INSERT', '2016-04-27 10:44:47.45', NULL, NULL, '112', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (201, 'system', 'Atributo', '2016-04-27 10:45:34.945', 'INSERT', '2016-04-27 10:45:34.945', NULL, NULL, '113', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (202, 'system', 'Atributo', '2016-04-27 10:45:55.77', 'INSERT', '2016-04-27 10:45:55.77', NULL, NULL, '114', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (203, 'system', 'Atributo', '2016-04-27 10:46:10.717', 'INSERT', '2016-04-27 10:46:10.717', NULL, NULL, '115', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (204, 'system', 'Fase', '2016-04-27 10:47:30.681', 'INSERT', '2016-04-27 10:47:30.681', NULL, NULL, '16', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (205, 'system', 'Atributo', '2016-04-27 10:47:41.27', 'INSERT', '2016-04-27 10:47:41.27', NULL, NULL, '116', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (206, 'system', 'Atributo', '2016-04-27 10:47:55.348', 'INSERT', '2016-04-27 10:47:55.348', NULL, NULL, '117', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (207, 'system', 'Atributo', '2016-04-27 10:48:10.976', 'INSERT', '2016-04-27 10:48:10.976', NULL, NULL, '118', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (208, 'system', 'Atributo', '2016-04-27 10:48:43.012', 'INSERT', '2016-04-27 10:48:43.012', NULL, NULL, '119', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (209, 'system', 'Atributo', '2016-04-27 10:48:55.583', 'INSERT', '2016-04-27 10:48:55.583', NULL, NULL, '120', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (210, 'system', 'Atributo', '2016-04-27 10:49:08.656', 'INSERT', '2016-04-27 10:49:08.656', NULL, NULL, '121', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (211, 'system', 'Atributo', '2016-04-27 10:49:20.917', 'INSERT', '2016-04-27 10:49:20.917', NULL, NULL, '122', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (212, 'system', 'Fase', '2016-04-27 10:49:36.265', 'INSERT', '2016-04-27 10:49:36.265', NULL, NULL, '17', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (213, 'system', 'Atributo', '2016-04-27 10:49:59.977', 'INSERT', '2016-04-27 10:49:59.977', NULL, NULL, '123', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (214, 'system', 'Atributo', '2016-04-27 10:50:22.712', 'INSERT', '2016-04-27 10:50:22.712', NULL, NULL, '124', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (215, 'system', 'Atributo', '2016-04-27 10:50:44.619', 'INSERT', '2016-04-27 10:50:44.619', NULL, NULL, '125', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (216, 'system', 'Atributo', '2016-04-27 10:51:42.659', 'INSERT', '2016-04-27 10:51:42.659', NULL, NULL, '126', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (217, 'system', 'Atributo', '2016-04-27 10:51:53.733', 'INSERT', '2016-04-27 10:51:53.733', NULL, NULL, '127', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (218, 'system', 'Fase', '2016-04-27 10:52:09.435', 'INSERT', '2016-04-27 10:52:09.435', NULL, NULL, '18', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (219, 'system', 'Atributo', '2016-04-27 10:52:20.685', 'INSERT', '2016-04-27 10:52:20.685', NULL, NULL, '128', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (220, 'system', 'Atributo', '2016-04-27 10:52:32.547', 'INSERT', '2016-04-27 10:52:32.547', NULL, NULL, '129', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (221, 'system', 'Atributo', '2016-04-27 10:52:40.919', 'INSERT', '2016-04-27 10:52:40.919', NULL, NULL, '130', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (222, 'system', 'Atributo', '2016-04-27 10:52:50.699', 'INSERT', '2016-04-27 10:52:50.699', NULL, NULL, '131', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (223, 'system', 'Atributo', '2016-04-27 10:53:04.731', 'INSERT', '2016-04-27 10:53:04.731', NULL, NULL, '132', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (224, 'system', 'Atributo', '2016-04-27 10:53:15.811', 'INSERT', '2016-04-27 10:53:15.811', NULL, NULL, '133', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (225, 'system', 'Fase', '2016-04-27 10:53:46.253', 'INSERT', '2016-04-27 10:53:46.253', NULL, NULL, '19', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (226, 'system', 'Atributo', '2016-04-27 10:54:23.389', 'INSERT', '2016-04-27 10:54:23.389', NULL, NULL, '134', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (227, 'system', 'Atributo', '2016-04-27 10:54:35.991', 'INSERT', '2016-04-27 10:54:35.991', NULL, NULL, '135', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (228, 'system', 'Atributo', '2016-04-27 10:55:12.879', 'INSERT', '2016-04-27 10:55:12.879', NULL, NULL, '136', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (229, 'system', 'Atributo', '2016-04-27 10:55:35.701', 'INSERT', '2016-04-27 10:55:35.701', NULL, NULL, '137', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (230, 'system', 'Atributo', '2016-04-27 10:55:47.109', 'INSERT', '2016-04-27 10:55:47.109', NULL, NULL, '138', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (231, 'system', 'Atributo', '2016-04-27 10:56:06.641', 'INSERT', '2016-04-27 10:56:06.641', NULL, NULL, '139', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (232, 'system', 'Atributo', '2016-04-27 10:56:16.559', 'INSERT', '2016-04-27 10:56:16.559', NULL, NULL, '140', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (233, 'system', 'Atributo', '2016-04-27 10:56:47.161', 'INSERT', '2016-04-27 10:56:47.161', NULL, NULL, '141', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (234, 'admin', 'TalhaoPropriedade', '2016-04-27 11:00:04.625', 'INSERT', '2016-04-27 11:00:04.625', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (235, 'admin', 'RastroProduto', '2016-04-27 11:01:03.197', 'INSERT', '2016-04-27 11:01:03.197', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (236, 'system', 'Permissao', '2016-04-27 11:14:03.259', 'INSERT', '2016-04-27 11:14:03.259', NULL, NULL, '20', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (237, 'system', 'Permissao', '2016-04-27 11:14:03.353', 'INSERT', '2016-04-27 11:14:03.353', NULL, NULL, '21', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (238, 'system', 'Permissao', '2016-04-27 11:14:03.353', 'INSERT', '2016-04-27 11:14:03.353', NULL, NULL, '22', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (239, 'system', 'Permissao', '2016-04-27 11:14:03.369', 'INSERT', '2016-04-27 11:14:03.369', NULL, NULL, '23', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (240, 'system', 'Permissao', '2016-04-27 11:14:03.384', 'INSERT', '2016-04-27 11:14:03.384', NULL, NULL, '24', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (241, 'admin', 'Cultivar', '2016-04-27 11:32:17.577', 'INSERT', '2016-04-27 11:32:17.577', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (242, 'admin', 'Cultivar', '2016-04-27 11:34:57.224', 'UPDATE', '2016-04-27 11:34:57.224', 'OUTRO TESTE', 'TESTE', '2', 0, 'descricaoCultivar', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (243, 'admin', 'Produto', '2016-04-27 12:36:05.653', 'INSERT', '2016-04-27 12:36:05.653', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (244, 'admin', 'TelefoneEmpresa', '2016-04-27 17:24:48.888', 'INSERT', '2016-04-27 17:24:48.888', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (245, 'admin', 'TelefoneEmpresa', '2016-04-27 17:25:57.63', 'DELETE', '2016-04-27 17:25:57.63', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (246, 'admin', 'TipoCertificacao', '2016-04-27 17:26:30.551', 'INSERT', '2016-04-27 17:26:30.551', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (247, 'admin', 'CertificacaoEmpresa', '2016-04-27 17:27:03.077', 'INSERT', '2016-04-27 17:27:03.077', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (248, 'admin', 'CertificacaoEmpresa', '2016-04-27 17:27:57.255', 'DELETE', '2016-04-27 17:27:57.255', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (249, 'admin', 'Cultivar', '2016-04-28 07:18:56.546', 'DELETE', '2016-04-28 07:18:56.546', NULL, NULL, '2', 1, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (250, 'admin', 'Cultivar', '2016-04-28 07:19:05.378', 'UPDATE', '2016-04-28 07:19:05.378', 'CULTIVAR TRIGO', 'CULTIVAR TESTE', '1', 0, 'descricaoCultivar', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (251, 'admin', 'Produto', '2016-04-28 08:00:58.388', 'DELETE', '2016-04-28 08:00:58.388', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (252, 'admin', 'Atributo', '2016-04-28 08:01:42.676', 'UPDATE', '2016-04-28 08:01:42.676', 'Data', 'Lista', '128', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (253, 'admin', 'Atributo', '2016-04-28 08:01:49.044', 'UPDATE', '2016-04-28 08:01:49.044', 'Texto', 'Lista', '129', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (254, 'admin', 'Atributo', '2016-04-28 08:01:55.61', 'UPDATE', '2016-04-28 08:01:55.61', 'Texto', 'Lista', '132', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (255, 'admin', 'Atributo', '2016-04-28 08:02:02.759', 'UPDATE', '2016-04-28 08:02:02.759', 'Texto', 'Lista', '131', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (256, 'admin', 'Atributo', '2016-04-28 08:02:07.762', 'UPDATE', '2016-04-28 08:02:07.762', 'Texto', 'Lista', '130', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (257, 'admin', 'Atributo', '2016-04-28 08:03:07.333', 'UPDATE', '2016-04-28 08:03:07.333', 'Data', 'Lista', '39', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (258, 'admin', 'Atributo', '2016-04-28 08:03:12.981', 'UPDATE', '2016-04-28 08:03:12.981', 'Texto', 'Lista', '37', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (259, 'admin', 'Atributo', '2016-04-28 08:03:18.813', 'UPDATE', '2016-04-28 08:03:18.813', 'Texto', 'Lista', '34', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (260, 'admin', 'Atributo', '2016-04-28 08:03:24.517', 'UPDATE', '2016-04-28 08:03:24.517', 'Texto', 'Lista', '36', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (261, 'admin', 'Atributo', '2016-04-28 08:03:31.007', 'UPDATE', '2016-04-28 08:03:31.007', 'Texto', 'Lista', '40', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (262, 'admin', 'Atributo', '2016-04-28 08:03:36.319', 'UPDATE', '2016-04-28 08:03:36.319', 'Texto', 'Lista', '35', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (263, 'admin', 'Atributo', '2016-04-28 08:03:53.889', 'UPDATE', '2016-04-28 08:03:53.889', 'Data', 'Lista', '50', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (264, 'admin', 'Atributo', '2016-04-28 08:03:59.41', 'UPDATE', '2016-04-28 08:03:59.41', 'Texto', 'Lista', '49', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (265, 'admin', 'Atributo', '2016-04-28 08:04:06.889', 'UPDATE', '2016-04-28 08:04:06.889', 'Texto', 'Lista', '44', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (266, 'admin', 'Atributo', '2016-04-28 08:04:17.534', 'UPDATE', '2016-04-28 08:04:17.534', 'Texto', 'Lista', '48', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (267, 'admin', 'Atributo', '2016-04-28 08:04:23.265', 'UPDATE', '2016-04-28 08:04:23.265', 'Texto', 'Lista', '47', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (268, 'admin', 'Atributo', '2016-04-28 08:04:41.913', 'UPDATE', '2016-04-28 08:04:41.913', 'Texto', 'Lista', '31', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (269, 'admin', 'Atributo', '2016-04-28 08:04:47.525', 'UPDATE', '2016-04-28 08:04:47.525', 'Texto', 'Lista', '27', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (270, 'admin', 'Atributo', '2016-04-28 08:04:52.778', 'UPDATE', '2016-04-28 08:04:52.778', 'Texto', 'Lista', '29', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (271, 'admin', 'Atributo', '2016-04-28 08:04:57.924', 'UPDATE', '2016-04-28 08:04:57.924', 'Texto', 'Lista', '28', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (272, 'admin', 'Atributo', '2016-04-28 08:05:16.199', 'UPDATE', '2016-04-28 08:05:16.199', 'Data', 'Lista', '136', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (273, 'admin', 'Atributo', '2016-04-28 08:05:21.049', 'UPDATE', '2016-04-28 08:05:21.049', 'Texto', 'Lista', '137', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (274, 'admin', 'Atributo', '2016-04-28 08:05:27.056', 'UPDATE', '2016-04-28 08:05:27.056', 'Texto', 'Lista', '138', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (275, 'admin', 'Atributo', '2016-04-28 08:05:37.283', 'UPDATE', '2016-04-28 08:05:37.283', 'Texto', 'Lista', '135', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (276, 'admin', 'Atributo', '2016-04-28 08:06:01.135', 'UPDATE', '2016-04-28 08:06:01.135', 'Texto', 'Lista', '106', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (277, 'admin', 'Atributo', '2016-04-28 08:06:05.898', 'UPDATE', '2016-04-28 08:06:05.898', 'Texto', 'Lista', '104', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (278, 'admin', 'Atributo', '2016-04-28 08:06:11.601', 'UPDATE', '2016-04-28 08:06:11.601', 'Texto', 'Lista', '103', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (279, 'admin', 'Atributo', '2016-04-28 08:06:17.128', 'UPDATE', '2016-04-28 08:06:17.128', 'Texto', 'Lista', '108', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (280, 'admin', 'Atributo', '2016-04-28 08:06:22.304', 'UPDATE', '2016-04-28 08:06:22.304', 'Texto', 'Lista', '105', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (281, 'admin', 'Atributo', '2016-04-28 08:06:27.516', 'UPDATE', '2016-04-28 08:06:27.516', 'Texto', 'Lista', '109', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (282, 'admin', 'Atributo', '2016-04-28 08:09:24.219', 'UPDATE', '2016-04-28 08:09:24.219', 'Data', 'Lista', '112', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (283, 'admin', 'Atributo', '2016-04-28 08:09:29.821', 'UPDATE', '2016-04-28 08:09:29.821', 'Texto', 'Lista', '111', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (284, 'admin', 'Atributo', '2016-04-28 08:09:35.603', 'UPDATE', '2016-04-28 08:09:35.603', 'Texto', 'Lista', '113', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (285, 'admin', 'Atributo', '2016-04-28 08:09:48.547', 'UPDATE', '2016-04-28 08:09:48.547', 'Data', 'Lista', '124', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (286, 'admin', 'Atributo', '2016-04-28 08:09:53.512', 'UPDATE', '2016-04-28 08:09:53.512', 'Texto', 'Lista', '125', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (287, 'admin', 'Atributo', '2016-04-28 08:09:58.416', 'UPDATE', '2016-04-28 08:09:58.416', 'Texto', 'Lista', '123', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (288, 'admin', 'Atributo', '2016-04-28 08:10:02.224', 'UPDATE', '2016-04-28 08:10:02.224', 'Texto', 'Lista', '126', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (289, 'admin', 'Atributo', '2016-04-28 08:10:23', 'UPDATE', '2016-04-28 08:10:23', 'Texto', 'Lista', '19', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (290, 'admin', 'Atributo', '2016-04-28 08:10:37.127', 'UPDATE', '2016-04-28 08:10:37.127', 'Data', 'Lista', '119', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (291, 'admin', 'Atributo', '2016-04-28 08:10:41.367', 'UPDATE', '2016-04-28 08:10:41.367', 'Data', 'Lista', '120', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (292, 'admin', 'Atributo', '2016-04-28 08:10:45.882', 'UPDATE', '2016-04-28 08:10:45.882', 'Texto', 'Lista', '121', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (293, 'admin', 'Atributo', '2016-04-28 08:10:50.531', 'UPDATE', '2016-04-28 08:10:50.531', 'Texto', 'Lista', '122', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (294, 'admin', 'Atributo', '2016-04-28 08:10:57.013', 'UPDATE', '2016-04-28 08:10:57.013', 'Texto', 'Lista', '116', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (295, 'admin', 'Atributo', '2016-04-28 08:11:01.922', 'UPDATE', '2016-04-28 08:11:01.922', 'Texto', 'Lista', '117', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (296, 'admin', 'Atributo', '2016-04-28 08:11:06.502', 'UPDATE', '2016-04-28 08:11:06.502', 'Texto', 'Lista', '118', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (297, 'admin', 'Atributo', '2016-04-28 08:32:44.25', 'UPDATE', '2016-04-28 08:32:44.25', 'Texto', 'Lista', '70', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (298, 'admin', 'Atributo', '2016-04-28 08:32:50.522', 'UPDATE', '2016-04-28 08:32:50.522', 'Texto', 'Lista', '69', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (299, 'admin', 'Atributo', '2016-04-28 08:32:55.278', 'UPDATE', '2016-04-28 08:32:55.278', 'Texto', 'Lista', '71', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (300, 'admin', 'Atributo', '2016-04-28 08:33:00.153', 'UPDATE', '2016-04-28 08:33:00.153', 'Texto', 'Lista', '68', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (301, 'admin', 'Atributo', '2016-04-28 08:33:37.949', 'UPDATE', '2016-04-28 08:33:37.949', 'Texto', 'Lista', '84', 1, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (302, 'admin', 'Atributo', '2016-04-28 08:33:43.894', 'UPDATE', '2016-04-28 08:33:43.894', 'Data', 'Lista', '83', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (303, 'admin', 'Atributo', '2016-04-28 08:33:49.659', 'UPDATE', '2016-04-28 08:33:49.659', 'Texto', 'Lista', '87', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (304, 'admin', 'Atributo', '2016-04-28 08:33:57.284', 'UPDATE', '2016-04-28 08:33:57.284', 'Texto', 'Lista', '86', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (305, 'admin', 'Atributo', '2016-04-28 08:34:05.047', 'UPDATE', '2016-04-28 08:34:05.047', 'Texto', 'Lista', '85', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (306, 'admin', 'Atributo', '2016-04-28 08:35:11.027', 'UPDATE', '2016-04-28 08:35:11.027', 'Lista', 'Texto', '21', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (307, 'admin', 'ListaAtributo', '2016-04-28 08:35:23.961', 'INSERT', '2016-04-28 08:35:23.961', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (308, 'admin', 'ListaAtributo', '2016-04-28 08:42:44.996', 'INSERT', '2016-04-28 08:42:44.996', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (309, 'admin', 'ListaAtributo', '2016-04-28 08:48:23.557', 'DELETE', '2016-04-28 08:48:23.557', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (310, 'admin', 'ListaAtributo', '2016-04-28 09:15:05.773', 'INSERT', '2016-04-28 09:15:05.773', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (311, 'admin', 'Atributo', '2016-04-28 09:33:37.194', 'UPDATE', '2016-04-28 09:33:37.194', 'Lista', 'Texto', '22', 0, 'tipoAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (312, 'admin', 'ListaAtributo', '2016-04-28 09:34:15.144', 'INSERT', '2016-04-28 09:34:15.144', NULL, NULL, '6', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (313, 'admin', 'ListaAtributo', '2016-04-28 09:34:19.091', 'UPDATE', '2016-04-28 09:34:19.091', 'LATOSSOLO', 'LATOSSOLO,', '6', 0, 'valorListaAtributo', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (314, 'admin', 'ListaAtributo', '2016-04-28 09:34:40.353', 'INSERT', '2016-04-28 09:34:40.353', NULL, NULL, '7', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (315, 'admin', 'ListaAtributo', '2016-04-28 09:34:51.206', 'INSERT', '2016-04-28 09:34:51.206', NULL, NULL, '8', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (316, 'admin', 'ListaAtributo', '2016-04-28 09:35:01.764', 'INSERT', '2016-04-28 09:35:01.764', NULL, NULL, '9', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (317, 'admin', 'ListaAtributo', '2016-04-28 09:35:47.573', 'INSERT', '2016-04-28 09:35:47.573', NULL, NULL, '10', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (318, 'admin', 'ListaAtributo', '2016-04-28 09:35:58.376', 'INSERT', '2016-04-28 09:35:58.376', NULL, NULL, '11', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (319, 'admin', 'ListaAtributo', '2016-04-28 09:36:08.198', 'INSERT', '2016-04-28 09:36:08.198', NULL, NULL, '12', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (320, 'admin', 'ListaAtributo', '2016-04-28 09:36:22.314', 'INSERT', '2016-04-28 09:36:22.314', NULL, NULL, '13', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (321, 'admin', 'TipoResponsavel', '2016-04-28 10:30:33.799', 'INSERT', '2016-04-28 10:30:33.799', NULL, NULL, '1', 0, NULL, NULL);


--
-- TOC entry 2693 (class 0 OID 0)
-- Dependencies: 186
-- Name: audit_log_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('audit_log_event_id_seq', 321, true);


--
-- TOC entry 2453 (class 0 OID 89556)
-- Dependencies: 189
-- Data for Name: certificacao_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2694 (class 0 OID 0)
-- Dependencies: 188
-- Name: certificacao_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('certificacao_empresa_id_seq', 1, true);


--
-- TOC entry 2455 (class 0 OID 89567)
-- Dependencies: 191
-- Data for Name: certificacao_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2695 (class 0 OID 0)
-- Dependencies: 190
-- Name: certificacao_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('certificacao_propriedade_id_seq', 1, false);


--
-- TOC entry 2457 (class 0 OID 89578)
-- Dependencies: 193
-- Data for Name: cidade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (73, 0, 18, 'ARARUNA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (74, 0, 18, 'BARBOSA FERRAZ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (63, 0, 18, 'BOA ESPERANÇA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (64, 0, 18, 'CAMPINA DA LAGOA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (75, 1, 18, 'CAMPO MOURÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (77, 0, 18, 'ENGENHEIRO BELTRÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (78, 0, 18, 'FAROL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (79, 0, 18, 'FÊNIX');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (65, 0, 18, 'GOIOERÊ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (80, 0, 18, 'IRETAMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (66, 0, 18, 'JANIÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (67, 0, 18, 'JURANDA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (81, 0, 18, 'LUIZIANA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (68, 0, 18, 'MOREIRA SALES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (69, 0, 18, 'NOVA CANTU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (83, 0, 18, 'PEABIRU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (70, 0, 18, 'QUARTO CENTENÁRIO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (84, 0, 18, 'QUINTA DO SOL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (85, 0, 18, 'RONCADOR');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (86, 0, 18, 'TERRA BOA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (72, 0, 18, 'UBIRATÃ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (31, 0, 18, 'ALTO PIQUIRI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (30, 0, 18, 'ALTÔNIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (32, 0, 18, 'BRASILÂNDIA DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (33, 0, 18, 'CAFEZAL DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (34, 0, 18, 'CRUZEIRO DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (35, 0, 18, 'DOURADINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (37, 0, 18, 'FRANCISCO ALVES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (38, 0, 18, 'ICARAÍMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (39, 0, 18, 'IPORÃ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (40, 0, 18, 'IVATÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (41, 0, 18, 'MARIA HELENA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (42, 0, 18, 'MARILUZ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (44, 0, 18, 'PEROBAL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (45, 0, 18, 'PÉROLA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (46, 0, 18, 'SÃO JORGE DO PATROCÍNIO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (47, 0, 18, 'TAPIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (48, 1, 18, 'UMUARAMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (49, 0, 18, 'ALTO PARAÍSO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (51, 1, 18, 'CIANORTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (50, 0, 18, 'XAMBRÊ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (53, 0, 18, 'GUAPOREMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (54, 0, 18, 'INDIANÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (55, 0, 18, 'JAPURÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (56, 0, 18, 'JUSSARA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (57, 0, 18, 'RONDON');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (59, 0, 18, 'SÃO TOMÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (60, 0, 18, 'TAPEJARA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (61, 0, 18, 'TUNEIRAS DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (1, 0, 18, 'ALTO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (2, 0, 18, 'AMAPORÃ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (3, 0, 18, 'CRUZEIRO DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (4, 0, 18, 'DIAMANTE DO NORTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (5, 0, 18, 'GUAIRAÇÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (6, 0, 18, 'INAJÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (8, 0, 18, 'JARDIM OLINDA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (9, 0, 18, 'LOANDA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (10, 0, 18, 'MARILENA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (11, 0, 18, 'MIRADOR');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (12, 0, 18, 'NOVA ALIANÇA DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (13, 1, 18, 'NOVA LONDRINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (14, 0, 18, 'PARAÍSO DO NORTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (17, 1, 18, 'PARANAVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (198, 0, 18, 'JABOTI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (18, 0, 18, 'PLANALTINA DO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (19, 0, 18, 'PORTO RICO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (20, 0, 18, 'QUERÊNCIA DO NORTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (21, 0, 18, 'SANTA CRUZ DE MONTE CASTELO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (22, 0, 18, 'SANTA ISABEL DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (24, 0, 18, 'SANTO ANTÔNIO DO CAIUÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (25, 0, 18, 'SÃO CARLOS DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (26, 0, 18, 'SÃO JOÃO DO CAIUÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (27, 0, 18, 'SÃO PEDRO DO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (28, 0, 18, 'TAMBOARA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (29, 0, 18, 'TERRA RICA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (87, 0, 18, 'ÂNGULO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (88, 0, 18, 'ASTORGA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (92, 0, 18, 'COLORADO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (93, 0, 18, 'FLÓRIDA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (95, 0, 18, 'IGUARAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (96, 0, 18, 'ITAGUAJÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (98, 0, 18, 'LOBATO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (90, 0, 18, 'CAFEARA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (91, 0, 18, 'CENTENÁRIO DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (94, 0, 18, 'GUARACI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (97, 0, 18, 'JAGUAPITÃ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (99, 0, 18, 'LUPIONÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (118, 0, 18, 'FLORAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (120, 0, 18, 'ITAMBÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (121, 0, 18, 'IVATUBA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (100, 0, 18, 'MANDAGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (124, 0, 18, 'MANDAGUARI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (125, 0, 18, 'MARIALVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (126, 1, 18, 'MARINGÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (102, 0, 18, 'NOSSA SENHORA DAS GRAÇAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (103, 0, 18, 'NOVA ESPERANÇA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (122, 0, 18, 'OURIZONA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (127, 0, 18, 'PAIÇANDU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (104, 0, 18, 'PRESIDENTE CASTELO BRANCO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (105, 0, 18, 'SANTA FÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (107, 0, 18, 'SANTO INÁCIO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (123, 0, 18, 'SÃO JORGE DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (128, 0, 18, 'SARANDI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (108, 0, 18, 'UNIFLOR');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (129, 1, 18, 'APUCARANA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (130, 0, 18, 'ARAPONGAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (145, 0, 18, 'BORRAZÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (131, 0, 18, 'CALIFÓRNIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (132, 0, 18, 'CAMBIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (147, 0, 18, 'FAXINAL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (155, 0, 18, 'GRANDES RIOS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (133, 0, 18, 'JANDAIA DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (148, 0, 18, 'KALORÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (149, 0, 18, 'MARUMBI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (135, 0, 18, 'MAUÁ DA SERRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (136, 0, 18, 'NOVO ITACOLOMI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (150, 0, 18, 'RIO BOM');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (137, 0, 18, 'SABÁUDIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (165, 0, 18, 'SÃO PEDRO DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (109, 0, 18, 'ALVORADA DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (166, 0, 18, 'ASSAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (138, 0, 18, 'CAMBÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (111, 0, 18, 'FLORESTÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (140, 0, 18, 'LONDRINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (139, 0, 18, 'IBIPORÃ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (167, 0, 18, 'JATAIZINHO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (112, 0, 18, 'MIRASELVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (141, 0, 18, 'PITANGUEIRAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (114, 0, 18, 'PRADO FERREIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (115, 0, 18, 'PRIMEIRO DE MAIO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (142, 0, 18, 'ROLÂNDIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (116, 0, 18, 'SERTANÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (143, 0, 18, 'TAMARANA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (174, 0, 18, 'ABATIÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (176, 0, 18, 'BANDEIRANTES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (177, 0, 18, 'CONGONHINHAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (178, 1, 18, 'CORNÉLIO PROCÓPIO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (179, 0, 18, 'ITAMBARACÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (180, 0, 18, 'LEÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (182, 0, 18, 'NOVA FÁTIMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (168, 0, 18, 'NOVA SANTA BÁRBARA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (169, 0, 18, 'RANCHO ALEGRE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (183, 0, 18, 'RIBEIRÃO DO PINHAL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (184, 0, 18, 'SANTA AMÉLIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (170, 0, 18, 'SANTA CECÍLIA DO PAVÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (185, 0, 18, 'SANTA MARIANA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (171, 0, 18, 'SÃO JERÔNIMO DA SERRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (172, 0, 18, 'SÃO SEBASTIÃO DA AMOREIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (187, 0, 18, 'SERTANEJA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (173, 0, 18, 'URAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (188, 0, 18, 'BARRA DO JACARÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (189, 0, 18, 'CAMBARÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (194, 0, 18, 'CONSELHEIRO MAIRINCK');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (196, 0, 18, 'FIGUEIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (197, 0, 18, 'IBAITI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (191, 0, 18, 'JUNDIAÍ DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (192, 0, 18, 'RIBEIRÃO CLARO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (193, 0, 18, 'SANTO ANTÔNIO DA PLATINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (195, 0, 18, 'CURIÚVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (151, 0, 18, 'ARAPUÃ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (152, 0, 18, 'ARIRANHA DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (146, 0, 18, 'CRUZMALTINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (154, 0, 18, 'GODOY MOREIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (156, 1, 18, 'IVAIPORÃ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (157, 0, 18, 'JARDIM ALEGRE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (158, 0, 18, 'LIDIANÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (159, 0, 18, 'LUNARDELLI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (161, 0, 18, 'NOVA TEBAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (162, 0, 18, 'RIO BRANCO DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (163, 0, 18, 'ROSÁRIO DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (164, 0, 18, 'SÃO JOÃO DO IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (222, 0, 18, 'CARAMBEÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (219, 0, 18, 'JAGUARIAÍVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (224, 0, 18, 'PALMEIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (220, 0, 18, 'PIRAÍ DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (225, 1, 18, 'PONTA GROSSA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (221, 0, 18, 'SENGÉS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (276, 0, 18, 'AMPÉRE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (277, 0, 18, 'BELA VISTA DA CAROBA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (285, 0, 18, 'BOA ESPERANÇA DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (286, 0, 18, 'BOM JESUS DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (278, 0, 18, 'CAPANEMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (287, 0, 18, 'CRUZEIRO DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (289, 0, 18, 'ENÉAS MARQUES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (290, 0, 18, 'FLOR DA SERRA DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (291, 1, 18, 'FRANCISCO BELTRÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (292, 0, 18, 'MANFRINÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (293, 0, 18, 'MARMELEIRO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (294, 0, 18, 'NOVA ESPERANÇA DO SUDOESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (279, 0, 18, 'PÉROLA D''OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (296, 0, 18, 'PINHAL DE SÃO BENTO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (280, 0, 18, 'PLANALTO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (281, 0, 18, 'PRANCHITA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (282, 0, 18, 'REALEZA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (283, 0, 18, 'SANTA IZABEL DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (266, 1, 18, 'FOZ DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (267, 0, 18, 'ITAIPULÂNDIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (269, 0, 18, 'MEDIANEIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (270, 0, 18, 'MISSAL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (271, 0, 18, 'RAMILÂNDIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (272, 0, 18, 'SANTA TEREZINHA DE ITAIPU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (273, 0, 18, 'SÃO MIGUEL DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (274, 0, 18, 'SERRANÓPOLIS DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (247, 0, 18, 'ANAHY');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (249, 0, 18, 'BRAGANEY');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (250, 0, 18, 'CAFELÂNDIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (251, 0, 18, 'CAMPO BONITO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (252, 0, 18, 'CAPITÃO LEÔNIDAS MARQUES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (253, 1, 18, 'CASCAVEL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (254, 0, 18, 'CATANDUVAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (265, 0, 18, 'CÉU AZUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (255, 0, 18, 'CORBÉLIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (229, 0, 18, 'FORMOSA DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (257, 0, 18, 'GUARANIAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (258, 0, 18, 'IBEMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (259, 0, 18, 'IGUATU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (231, 0, 18, 'IRACEMA DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (232, 0, 18, 'JESUÍTAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (260, 0, 18, 'LINDOESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (262, 0, 18, 'SANTA LÚCIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (263, 0, 18, 'SANTA TEREZA DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (264, 0, 18, 'TRÊS BARRAS DO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (275, 0, 18, 'VERA CRUZ DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (201, 0, 18, 'SAPOPEMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (202, 0, 18, 'CARLÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (199, 0, 18, 'JAPIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (204, 0, 18, 'JOAQUIM TÁVORA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (200, 0, 18, 'PINHALÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (205, 0, 18, 'QUATIGUÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (206, 0, 18, 'SALTO DO ITARARÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (208, 0, 18, 'SÃO JOSÉ DA BOA VISTA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (209, 0, 18, 'SIQUEIRA CAMPOS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (210, 0, 18, 'TOMAZINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (211, 0, 18, 'WENCESLAU BRAZ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (226, 0, 18, 'ASSIS CHATEAUBRIAND');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (227, 0, 18, 'DIAMANTE D''OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (228, 0, 18, 'ENTRE RIOS DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (230, 0, 18, 'GUAÍRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (234, 0, 18, 'MARIPÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (235, 0, 18, 'MERCEDES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (236, 0, 18, 'NOVA SANTA ROSA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (237, 0, 18, 'OURO VERDE DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (238, 0, 18, 'PALOTINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (239, 1, 18, 'PATO BRAGADO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (240, 0, 18, 'QUATRO PONTES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (242, 0, 18, 'SÃO JOSÉ DAS PALMEIRAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (243, 0, 18, 'SÃO PEDRO DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (244, 0, 18, 'TERRA ROXA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (245, 1, 18, 'TOLEDO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (246, 0, 18, 'TUPÃSSI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (212, 0, 18, 'IMBAÚ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (213, 0, 18, 'ORTIGUEIRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (214, 0, 18, 'RESERVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (216, 0, 18, 'TIBAGI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (217, 0, 18, 'VENTANIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (388, 0, 18, 'GUARAQUEÇABA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (389, 0, 18, 'GUARATUBA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (390, 0, 18, 'MATINHOS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (392, 1, 18, 'PARANAGUÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (393, 0, 18, 'PONTAL DO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (363, 0, 18, 'ADRIANÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (394, 0, 18, 'AGUDOS DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (368, 0, 18, 'ALMIRANTE TAMANDARÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (370, 0, 18, 'BALSA NOVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (371, 0, 18, 'BOCAIÚVA DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (372, 0, 18, 'CAMPINA GRANDE DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (373, 0, 18, 'CAMPO LARGO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (374, 0, 18, 'CAMPO MAGRO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (364, 0, 18, 'CERRO AZUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (375, 0, 18, 'COLOMBO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (376, 0, 18, 'CONTENDA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (365, 0, 18, 'DOUTOR ULYSSES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (378, 0, 18, 'FAZENDA RIO GRANDE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (379, 0, 18, 'ITAPERUÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (366, 0, 18, 'LAPA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (380, 0, 18, 'MANDIRITUBA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (381, 0, 18, 'PINHAIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (383, 0, 18, 'QUATRO BARRAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (384, 0, 18, 'RIO BRANCO DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (385, 0, 18, 'SÃO JOSÉ DOS PINHAIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (386, 0, 18, 'TUNAS DO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (346, 0, 18, 'IVAÍ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (345, 0, 18, 'IPIRANGA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (361, 0, 18, 'SÃO JOÃO DO TRIUNFO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (342, 0, 18, 'FERNANDES PINHEIRO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (343, 0, 18, 'GUAMIRANGA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (344, 0, 18, 'IMBITUVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (326, 0, 18, 'INÁCIO MARTINS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (349, 1, 18, 'IRATI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (351, 0, 18, 'REBOUÇAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (352, 0, 18, 'RIO AZUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (348, 0, 18, 'TEIXEIRA SOARES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (313, 0, 18, 'BOA VENTURA DE SÃO ROQUE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (319, 0, 18, 'CAMPINA DO SIMÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (320, 0, 18, 'CANDÓI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (323, 0, 18, 'FOZ DO JORDÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (324, 0, 18, 'GOIOXIM');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (325, 1, 18, 'GUARAPUAVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (314, 0, 18, 'LARANJAL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (327, 0, 18, 'LARANJEIRAS DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (328, 0, 18, 'MARQUINHO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (316, 0, 18, 'PALMITAL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (330, 0, 18, 'PINHÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (317, 0, 18, 'PITANGA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (331, 0, 18, 'PORTO BARREIRO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (347, 0, 18, 'PRUDENTÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (333, 0, 18, 'RESERVA DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (335, 0, 18, 'TURVO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (336, 0, 18, 'VIRMOND');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (360, 0, 18, 'ANTÔNIO OLINTO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (353, 0, 18, 'BITURUNA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (354, 0, 18, 'CRUZ MACHADO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (355, 0, 18, 'GENERAL CARNEIRO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (356, 0, 18, 'PAULA FREITAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (357, 0, 18, 'PAULO FRONTIN');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (362, 0, 18, 'SÃO MATEUS DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (359, 1, 18, 'UNIÃO DA VITÓRIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (303, 0, 18, 'BOM SUCESSO DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (304, 0, 18, 'CHOPINZINHO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (337, 0, 18, 'CLEVELÂNDIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (338, 0, 18, 'CORONEL DOMINGOS SOARES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (339, 0, 18, 'HONÓRIO SERPA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (306, 0, 18, 'ITAPEJARA D''OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (340, 0, 18, 'MANGUEIRINHA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (307, 0, 18, 'MARIÓPOLIS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (341, 0, 18, 'PALMAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (308, 0, 18, 'PATO BRANCO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (309, 0, 18, 'SÃO JOÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (311, 0, 18, 'SULINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (312, 0, 18, 'VITORINO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (297, 0, 18, 'RENASCENÇA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (298, 0, 18, 'SALGADO FILHO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (299, 0, 18, 'SALTO DO LONTRA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (300, 0, 18, 'SANTO ANTÔNIO DO SUDOESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (301, 0, 18, 'SÃO JORGE D''OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (302, 0, 18, 'VERÊ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (332, 0, 18, 'QUEDAS DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (315, 0, 18, 'MATO RICO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (318, 0, 18, 'SANTA MARIA DO OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (218, 0, 18, 'ARAPOTI');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (223, 0, 18, 'CASTRO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (387, 0, 18, 'ANTONINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (391, 0, 18, 'MORRETES');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (369, 0, 18, 'ARAUCÁRIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (395, 0, 18, 'CAMPO DO TENENTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (377, 1, 18, 'CURITIBA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (396, 0, 18, 'PIÊN');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (382, 0, 18, 'PIRAQUARA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (397, 0, 18, 'QUITANDINHA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (398, 0, 18, 'RIO NEGRO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (399, 0, 18, 'TIJUCAS DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (367, 0, 18, 'PORTO AMAZONAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (350, 0, 18, 'MALLET');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (321, 0, 18, 'CANTAGALO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (329, 0, 18, 'NOVA LARANJEIRAS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (334, 0, 18, 'RIO BONITO DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (358, 0, 18, 'PORTO VITÓRIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (305, 0, 18, 'CORONEL VIVIDA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (310, 0, 18, 'SAUDADE DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (284, 0, 18, 'BARRACÃO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (288, 0, 18, 'DOIS VIZINHOS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (295, 0, 18, 'NOVA PRATA DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (268, 0, 18, 'MATELÂNDIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (248, 0, 18, 'BOA VISTA DA APARECIDA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (256, 0, 18, 'DIAMANTE DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (322, 0, 18, 'ESPIGÃO ALTO DO IGUAÇU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (261, 0, 18, 'NOVA AURORA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (62, 0, 18, 'ALTAMIRA DO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (76, 0, 18, 'CORUMBATAÍ DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (82, 0, 18, 'MAMBORÊ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (71, 0, 18, 'RANCHO ALEGRE D''OESTE');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (36, 0, 18, 'ESPERANÇA NOVA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (43, 0, 18, 'NOVA OLÍMPIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (52, 0, 18, 'MUNICIPIO GAÚCHA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (58, 0, 18, 'SÃO MANOEL DO PARANÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (7, 0, 18, 'ITAÚNA DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (16, 0, 18, 'PARANAPOEMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (23, 0, 18, 'SANTA MÔNICA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (89, 0, 18, 'ATALAIA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (117, 0, 18, 'DOUTOR CAMARGO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (119, 0, 18, 'FLORESTA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (101, 0, 18, 'MUNHOZ DE MELO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (15, 0, 18, 'PARANACITY');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (106, 0, 18, 'SANTA INÊS');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (144, 0, 18, 'BOM SUCESSO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (134, 0, 18, 'MARILÂNDIA DO SUL');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (110, 0, 18, 'BELA VISTA DO PARAÍSO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (113, 0, 18, 'PORECATU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (175, 0, 18, 'ANDIRÁ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (181, 0, 18, 'NOVA AMÉRICA DA COLINA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (186, 0, 18, 'SANTO ANTÔNIO DO PARAÍSO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (203, 0, 18, 'GUAPIRAMA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (190, 1, 18, 'JACAREZINHO');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (207, 0, 18, 'SANTANA DO ITARARÉ');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (233, 0, 18, 'MARECHAL CÂNDIDO RONDON');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (241, 0, 18, 'SANTA HELENA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (215, 1, 18, 'TELÊMACO BORBA');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (153, 0, 18, 'CÂNDIDO DE ABREU');
INSERT INTO cidade (id, version, estado_id, nome_cidade) VALUES (160, 0, 18, 'MANOEL RIBAS');


--
-- TOC entry 2696 (class 0 OID 0)
-- Dependencies: 192
-- Name: cidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cidade_id_seq', 400, false);


--
-- TOC entry 2493 (class 0 OID 97243)
-- Dependencies: 229
-- Data for Name: cultivar; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cultivar (id, version, descricao_cultivar, produto_id) VALUES (1, 1, 'CULTIVAR TRIGO', 1);


--
-- TOC entry 2697 (class 0 OID 0)
-- Dependencies: 228
-- Name: cultivar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cultivar_id_seq', 2, true);


--
-- TOC entry 2459 (class 0 OID 89586)
-- Dependencies: 195
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO empresa (id, version, bairro_empresa, cep_empresa, cidade_id, cnpj, complemento_empresa, cpf, email_empresa, logradouro_empresa, nome_empresa, nome_fantasia_empresa, numero_empresa, tipo_empresa) VALUES (1, 1, 'UVARANAS', '84030-900', 225, '80.257.355/0001-08', 'CAMPUS UVARANAS', NULL, 'uepg@uepg.br', ' AV. GENERAL CARLOS CAVALCANTI', 'UNIVERSIDADE ESTADUAL DE PONTA GROSSA', 'UEPG', '4748', 'Pessoa Jurídica');


--
-- TOC entry 2698 (class 0 OID 0)
-- Dependencies: 194
-- Name: empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('empresa_id_seq', 1, true);


--
-- TOC entry 2461 (class 0 OID 89597)
-- Dependencies: 197
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (1, 0, 'ACRE', 33, 'AC');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (2, 0, 'ALAGOAS', 33, 'AL');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (3, 0, 'AMAZONAS', 33, 'AM');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (4, 0, 'AMAPÁ', 33, 'AP');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (5, 0, 'BAHIA', 33, 'BA');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (6, 0, 'CEARÁ', 33, 'CE');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (7, 0, 'DISTRITO FEDERAL', 33, 'DF');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (8, 0, 'ESPÍRITO SANTO', 33, 'ES');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (9, 0, 'GOIÁS', 33, 'GO');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (10, 0, 'MARANHÃO', 33, 'MA');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (11, 0, 'MINAS GERAIS', 33, 'MG');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (12, 0, 'MATO GROSSO DO SUL', 33, 'MS');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (13, 0, 'MATO GROSSO', 33, 'MT');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (14, 0, 'PARÁ', 33, 'PA');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (15, 0, 'PARAÍBA', 33, 'PB');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (16, 0, 'PERNAMBUCO', 33, 'PE');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (17, 0, 'PIAUÍ', 33, 'PI');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (18, 0, 'PARANÁ', 33, 'PR');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (19, 0, 'RIO DE JANEIRO', 33, 'RJ');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (20, 0, 'RIO GRANDE DO NORTE', 33, 'RN');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (21, 0, 'RONDÔNIA', 33, 'RO');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (22, 0, 'RORAIMA', 33, 'RR');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (23, 0, 'RIO GRANDE DO SUL', 33, 'RS');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (24, 0, 'SANTA CATARINA', 33, 'SC');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (25, 0, 'SERGIPE', 33, 'SE');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (26, 0, 'SÃO PAULO', 33, 'SP');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla) VALUES (27, 0, 'TOCANTINS', 33, 'TO');


--
-- TOC entry 2699 (class 0 OID 0)
-- Dependencies: 196
-- Name: estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('estado_id_seq', 28, false);


--
-- TOC entry 2495 (class 0 OID 97253)
-- Dependencies: 231
-- Data for Name: fase; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (1, 0, 'TRATAMENTO DE SEMENTES', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (2, 0, 'ADUBAÇÃO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (3, 0, 'PLANTIO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (4, 0, 'CONTROLE PLANTAS DANINHAS', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (5, 0, 'CONTROLE CRESCIMENTO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (6, 0, 'CONTROLE DE DOENÇAS/INSETOS', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (7, 0, 'MONITORAMENTO IMPLEMENTO AGRÍCOLA', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (8, 0, 'COLHEITA', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (9, 0, 'ARMAZENAMENTO PROPRIEDADE', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (10, 0, 'TRATAMENTO GRÃO PÓS COLHEITA', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (11, 0, 'TRANSPORTE PROPRIEDADE / EMPRESA', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (12, 0, 'ANÁLISE QUALIDADE GRÃO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (13, 0, 'ARMAZENAMENTO EMPRESA', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (14, 0, 'MONITORAMENTO ARMAZENAMENTO GRÃO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (15, 0, 'MONITORAMENTO LOCAL ARMAZENAMENTO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (16, 0, 'PREPARAÇÃO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (17, 0, 'MONITORAMENTO MATERIAL LABORATÓRIO', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (18, 0, 'ANÁLISE QUALIDADE FARINHA', NULL, 1);
INSERT INTO fase (id, version, descricao_fase, observacao_fase, produto_id) VALUES (19, 0, 'ENVASE', NULL, 1);


--
-- TOC entry 2700 (class 0 OID 0)
-- Dependencies: 230
-- Name: fase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('fase_id_seq', 19, true);


--
-- TOC entry 2463 (class 0 OID 89605)
-- Dependencies: 199
-- Data for Name: foto_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2701 (class 0 OID 0)
-- Dependencies: 198
-- Name: foto_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('foto_empresa_id_seq', 1, false);


--
-- TOC entry 2465 (class 0 OID 89616)
-- Dependencies: 201
-- Data for Name: foto_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2702 (class 0 OID 0)
-- Dependencies: 200
-- Name: foto_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('foto_propriedade_id_seq', 1, false);


--
-- TOC entry 2467 (class 0 OID 89627)
-- Dependencies: 203
-- Data for Name: foto_talhao_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2703 (class 0 OID 0)
-- Dependencies: 202
-- Name: foto_talhao_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('foto_talhao_propriedade_id_seq', 1, false);


--
-- TOC entry 2497 (class 0 OID 97266)
-- Dependencies: 233
-- Data for Name: lista_atributo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (3, 0, 21, 'CULTIVO MÍNIMO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (4, 0, 21, 'PLANTIO DIRETO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (5, 0, 21, 'CONVENCIONAL');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (6, 1, 22, 'LATOSSOLO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (7, 0, 22, 'ARGISSOLO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (8, 0, 22, 'CAMBISSOLO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (9, 0, 22, 'NEOSSOLO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (10, 0, 92, 'PADRÃO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (11, 0, 92, 'BRANCO');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (12, 0, 92, 'MELHORADOR');
INSERT INTO lista_atributo (id, version, atributo_id, valor_lista_atributo) VALUES (13, 0, 92, 'OUTROS');


--
-- TOC entry 2704 (class 0 OID 0)
-- Dependencies: 232
-- Name: lista_atributo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_atributo_id_seq', 13, true);


--
-- TOC entry 2498 (class 0 OID 97274)
-- Dependencies: 234
-- Data for Name: lista_atributo_rastros_lista_atributo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2469 (class 0 OID 89638)
-- Dependencies: 205
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO pais (id, version, country_name, nome_pais) VALUES (1, 0, 'AFGHANISTAN', 'AFEGANISTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (2, 0, 'AKROTIRI E DEKÉLIA', 'ACROTÍRI E DECELIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (3, 0, 'SOUTH AFRICA', 'ÁFRICA DO SUL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (4, 0, 'ALBANIA', 'ALBÂNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (5, 0, 'GERMANY', 'ALEMANHA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (6, 0, 'AMERICAN SAMOA', 'AMERICAN SAMOA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (7, 0, 'ANDORRA', 'ANDORRA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (8, 0, 'ANGOLA', 'ANGOLA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (9, 0, 'ANGUILLA', 'ANGUILLA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (10, 0, 'ANTIGUA AND BARBUDA', 'ANTÍGUA E BARBUDA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (11, 0, 'NETHERLANDS ANTILLES', 'ANTILHAS NEERLANDESAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (12, 0, 'SAUDI ARABIA', 'ARÁBIA SAUDITA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (13, 0, 'ALGERIA', 'ARGÉLIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (14, 0, 'ARGENTINA', 'ARGENTINA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (15, 0, 'ARMENIA', 'ARMÉNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (16, 0, 'ARUBA', 'ARUBA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (17, 0, 'AUSTRALIA', 'AUSTRÁLIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (18, 0, 'AUSTRIA', 'ÁUSTRIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (19, 0, 'AZERBAIJAN', 'AZERBAIJÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (20, 0, 'BAHAMAS, THE', 'BAHAMAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (21, 0, 'BANGLADESH', 'BANGLADECHE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (22, 0, 'BARBADOS', 'BARBADOS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (23, 0, 'BAHRAIN', 'BARÉM');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (24, 0, 'BASSAS DA INDIA', 'BASSAS DA ÍNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (25, 0, 'BELGIUM', 'BÉLGICA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (26, 0, 'BELIZE', 'BELIZE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (27, 0, 'BENIN', 'BENIM');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (28, 0, 'BERMUDA', 'BERMUDAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (29, 0, 'BELARUS', 'BIELORRÚSSIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (30, 0, 'BOLIVIA', 'BOLÍVIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (31, 0, 'BOSNIA AND HERZEGOVINA', 'BÓSNIA E HERZEGOVINA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (32, 0, 'BOTSWANA', 'BOTSUANA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (33, 0, 'BRAZIL', 'BRASIL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (34, 0, 'BRUNEI DARUSSALAM', 'BRUNEI DARUSSALAM');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (35, 0, 'BULGARIA', 'BULGÁRIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (36, 0, 'BURKINA FASO', 'BURQUINA FASO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (37, 0, 'BURUNDI', 'BURUNDI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (38, 0, 'BHUTAN', 'BUTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (39, 0, 'CAPE VERDE', 'CABO VERDE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (40, 0, 'CAMEROON', 'CAMARÕES');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (41, 0, 'CAMBODIA', 'CAMBOJA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (42, 0, 'CANADA', 'CANADÁ');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (43, 0, 'QATAR', 'CATAR');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (44, 0, 'KAZAKHSTAN', 'CAZAQUISTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (45, 0, 'CENTRAL AFRICAN REPUBLIC', 'CENTRO-AFRICANA REPÚBLICA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (46, 0, 'CHAD', 'CHADE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (47, 0, 'CHILE', 'CHILE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (48, 0, 'CHINA', 'CHINA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (49, 0, 'CYPRUS', 'CHIPRE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (50, 0, 'COLOMBIA', 'COLÔMBIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (51, 0, 'COMOROS', 'COMORES');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (52, 0, 'CONGO', 'CONGO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (53, 0, 'CONGO DEMOCRATIC REPUBLIC', 'CONGO REPÚBLICA DEMOCRÁTICA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (54, 0, 'KOREA NORTH', 'COREIA DO NORTE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (55, 0, 'KOREA SOUTH', 'COREIA DO SUL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (56, 0, 'IVORY COAST', 'COSTA DO MARFIM');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (57, 0, 'COSTA RICA', 'COSTA RICA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (58, 0, 'CROATIA', 'CROÁCIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (59, 0, 'CUBA', 'CUBA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (60, 0, 'DENMARK', 'DINAMARCA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (61, 0, 'DOMINICA', 'DOMÍNICA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (62, 0, 'EGYPT', 'EGIPTO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (63, 0, 'UNITED ARAB EMIRATES', 'EMIRADOS ÁRABES UNIDOS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (64, 0, 'ECUADOR', 'EQUADOR');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (65, 0, 'ERITREA', 'ERITREIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (66, 0, 'SLOVAKIA', 'ESLOVÁQUIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (67, 0, 'SLOVENIA', 'ESLOVÉNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (68, 0, 'SPAIN', 'ESPANHA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (69, 0, 'UNITED STATES', 'ESTADOS UNIDOS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (70, 0, 'ESTONIA', 'ESTÓNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (71, 0, 'ETHIOPIA', 'ETIÓPIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (72, 0, 'GAZA STRIP', 'FAIXA DE GAZA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (73, 0, 'FIJI', 'FIJI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (74, 0, 'PHILIPPINES', 'FILIPINAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (75, 0, 'FINLAND', 'FINLÂNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (76, 0, 'FRANCE', 'FRANÇA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (77, 0, 'GABON', 'GABÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (78, 0, 'GAMBIA', 'GÂMBIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (79, 0, 'GHANA', 'GANA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (80, 0, 'GEORGIA', 'GEÓRGIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (81, 0, 'GIBRALTAR', 'GIBRALTAR');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (82, 0, 'GRENADA', 'GRANADA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (83, 0, 'GREECE', 'GRÉCIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (84, 0, 'GREENLAND', 'GRONELÂNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (85, 0, 'GUADELOUPE', 'GUADALUPE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (86, 0, 'GUAM', 'GUAM');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (87, 0, 'GUATEMALA', 'GUATEMALA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (88, 0, 'GUERNSEY', 'GUERNSEY');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (89, 0, 'GUYANA', 'GUIANA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (90, 0, 'FRENCH GUIANA', 'GUIANA FRANCESA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (91, 0, 'GUINEA', 'GUINÉ');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (92, 0, 'EQUATORIAL GUINEA', 'GUINÉ EQUATORIAL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (93, 0, 'GUINEA-BISSAU', 'GUINÉ-BISSAU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (94, 0, 'HAITI', 'HAITI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (95, 0, 'HONDURAS', 'HONDURAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (96, 0, 'HONG KONG', 'HONG KONG');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (97, 0, 'HUNGARY', 'HUNGRIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (98, 0, 'YEMEN', 'IÉMEN');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (99, 0, 'BOUVET ISLAND', 'ILHA BOUVET');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (100, 0, 'CHRISTMAS ISLAND', 'ILHA CHRISTMAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (101, 0, 'CLIPPERTON ISLAND', 'ILHA DE CLIPPERTON');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (102, 0, 'JUAN DE NOVA ISLAND', 'ILHA DE JOÃO DA NOVA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (103, 0, 'ISLE OF MAN', 'ILHA DE MAN');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (104, 0, 'NAVASSA ISLAND', 'ILHA DE NAVASSA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (105, 0, 'EUROPA ISLAND', 'ILHA EUROPA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (106, 0, 'NORFOLK ISLAND', 'ILHA NORFOLK');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (107, 0, 'TROMELIN ISLAND', 'ILHA TROMELIN');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (108, 0, 'ASHMORE AND CARTIER ISLANDS', 'ILHAS ASHMORE E CARTIER');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (109, 0, 'CAYMAN ISLANDS', 'ILHAS CAIMAN');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (110, 0, 'COCOS (KEELING) ISLANDS', 'ILHAS COCOS (KEELING)');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (111, 0, 'COOK ISLANDS', 'ILHAS COOK');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (112, 0, 'CORAL SEA ISLANDS', 'ILHAS DO MAR DE CORAL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (113, 0, 'FALKLAND ISLANDS (ISLAS MALVINAS)', 'ILHAS FALKLANDS (ILHAS MALVINAS)');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (114, 0, 'FAROE ISLANDS', 'ILHAS FEROE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (115, 0, 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'ILHAS GEÓRGIA DO SUL E SANDWICH DO SUL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (116, 0, 'NORTHERN MARIANA ISLANDS', 'ILHAS MARIANAS DO NORTE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (117, 0, 'MARSHALL ISLANDS', 'ILHAS MARSHALL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (118, 0, 'PARACEL ISLANDS', 'ILHAS PARACEL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (119, 0, 'PITCAIRN ISLANDS', 'ILHAS PITCAIRN');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (120, 0, 'SOLOMON ISLANDS', 'ILHAS SALOMÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (121, 0, 'SPRATLY ISLANDS', 'ILHAS SPRATLY');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (122, 0, 'UNITED STATES VIRGIN ISLANDS', 'ILHAS VIRGENS AMERICANAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (241, 0, 'TURKEY', 'TURQUIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (123, 0, 'BRITISH VIRGIN ISLANDS', 'ILHAS VIRGENS BRITÂNICAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (124, 0, 'INDIA', 'ÍNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (125, 0, 'INDONESIA', 'INDONÉSIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (126, 0, 'IRAN', 'IRÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (127, 0, 'IRAQ', 'IRAQUE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (128, 0, 'IRELAND', 'IRLANDA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (129, 0, 'ICELAND', 'ISLÂNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (130, 0, 'ISRAEL', 'ISRAEL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (131, 0, 'ITALY', 'ITÁLIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (132, 0, 'JAMAICA', 'JAMAICA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (133, 0, 'JAN MAYEN', 'JAN MAYEN');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (134, 0, 'JAPAN', 'JAPÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (135, 0, 'JERSEY', 'JERSEY');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (136, 0, 'DJIBOUTI', 'JIBUTI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (137, 0, 'JORDAN', 'JORDÂNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (138, 0, 'KIRIBATI', 'KIRIBATI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (139, 0, 'KUWAIT', 'KOWEIT');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (140, 0, 'LAOS', 'LAOS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (141, 0, 'LESOTHO', 'LESOTO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (142, 0, 'LATVIA', 'LETÓNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (143, 0, 'LEBANON', 'LÍBANO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (144, 0, 'LIBERIA', 'LIBÉRIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (145, 0, 'LIBYAN ARAB JAMAHIRIYA', 'LÍBIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (146, 0, 'LIECHTENSTEIN', 'LISTENSTAINE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (147, 0, 'LITHUANIA', 'LITUÂNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (148, 0, 'LUXEMBOURG', 'LUXEMBURGO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (149, 0, 'MACAO', 'MACAU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (150, 0, 'MACEDONIA', 'MACEDÓNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (151, 0, 'MADAGASCAR', 'MADAGÁSCAR');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (152, 0, 'MALAYSIA', 'MALÁSIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (153, 0, 'MALAWI', 'MALAVI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (154, 0, 'MALDIVES', 'MALDIVAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (155, 0, 'MALI', 'MALI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (156, 0, 'MALTA', 'MALTA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (157, 0, 'MOROCCO', 'MARROCOS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (158, 0, 'MARTINIQUE', 'MARTINICA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (159, 0, 'MAURITIUS', 'MAURÍCIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (160, 0, 'MAURITANIA', 'MAURITÂNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (161, 0, 'MAYOTTE', 'MAYOTTE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (162, 0, 'MEXICO', 'MÉXICO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (163, 0, 'MYANMAR BURMA', 'MIANMAR');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (164, 0, 'MICRONESIA', 'MICRONÉSIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (165, 0, 'MOZAMBIQUE', 'MOÇAMBIQUE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (166, 0, 'MOLDOVA', 'MOLDÁVIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (167, 0, 'MONACO', 'MÓNACO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (168, 0, 'MONGOLIA', 'MONGÓLIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (169, 0, 'MONTENEGRO', 'MONTENEGRO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (170, 0, 'MONTSERRAT', 'MONTSERRAT');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (171, 0, 'NAMIBIA', 'NAMÍBIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (172, 0, 'NAURU', 'NAURU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (173, 0, 'NEPAL', 'NEPAL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (174, 0, 'NICARAGUA', 'NICARÁGUA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (175, 0, 'NIGER', 'NÍGER');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (176, 0, 'NIGERIA', 'NIGÉRIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (177, 0, 'NIUE', 'NIUE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (178, 0, 'NORWAY', 'NORUEGA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (179, 0, 'NEW CALEDONIA', 'NOVA CALEDÓNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (180, 0, 'NEW ZEALAND', 'NOVA ZELÂNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (181, 0, 'OMAN', 'OMÃ');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (182, 0, 'NETHERLANDS', 'PAÍSES BAIXOS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (183, 0, 'PALAU', 'PALAU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (184, 0, 'PALESTINE', 'PALESTINA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (185, 0, 'PANAMA', 'PANAMÁ');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (186, 0, 'PAPUA NEW GUINEA', 'PAPUÁSIA-NOVA GUINÉ');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (187, 0, 'PAKISTAN', 'PAQUISTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (188, 0, 'PARAGUAY', 'PARAGUAI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (189, 0, 'PERU', 'PERU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (190, 0, 'FRENCH POLYNESIA', 'POLINÉSIA FRANCESA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (191, 0, 'POLAND', 'POLÓNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (192, 0, 'PUERTO RICO', 'PORTO RICO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (193, 0, 'PORTUGAL', 'PORTUGAL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (194, 0, 'KENYA', 'QUÉNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (195, 0, 'KYRGYZSTAN', 'QUIRGUIZISTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (196, 0, 'UNITED KINGDOM', 'REINO UNIDO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (197, 0, 'CZECH REPUBLIC', 'REPÚBLICA CHECA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (198, 0, 'DOMINICAN REPUBLIC', 'REPÚBLICA DOMINICANA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (199, 0, 'ROMANIA', 'ROMÉNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (200, 0, 'RWANDA', 'RUANDA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (201, 0, 'RUSSIAN FEDERATION', 'RÚSSIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (202, 0, 'WESTERN SAHARA', 'SAHARA OCCIDENTAL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (203, 0, 'EL SALVADOR', 'SALVADOR');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (204, 0, 'SAMOA', 'SAMOA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (205, 0, 'SAINT HELENA', 'SANTA HELENA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (206, 0, 'SAINT LUCIA', 'SANTA LÚCIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (207, 0, 'HOLY SEE', 'SANTA SÉ');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (208, 0, 'SAINT KITTS AND NEVIS', 'SÃO CRISTÓVÃO E NEVES');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (209, 0, 'SAN MARINO', 'SÃO MARINO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (210, 0, 'SAINT PIERRE AND MIQUELON', 'SÃO PEDRO E MIQUELÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (211, 0, 'SAO TOME AND PRINCIPE', 'SÃO TOMÉ E PRÍNCIPE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (212, 0, 'SAINT VINCENT AND THE GRENADINES', 'SÃO VICENTE E GRANADINAS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (213, 0, 'SEYCHELLES', 'SEICHELES');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (214, 0, 'SENEGAL', 'SENEGAL');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (215, 0, 'SIERRA LEONE', 'SERRA LEOA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (216, 0, 'SERBIA', 'SÉRVIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (217, 0, 'SINGAPORE', 'SINGAPURA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (218, 0, 'SYRIA', 'SÍRIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (219, 0, 'SOMALIA', 'SOMÁLIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (220, 0, 'SRI LANKA', 'SRI LANCA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (221, 0, 'SWAZILAND', 'SUAZILÂNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (222, 0, 'SUDAN', 'SUDÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (223, 0, 'SWEDEN', 'SUÉCIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (224, 0, 'SWITZERLAND', 'SUÍÇA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (225, 0, 'SURINAME', 'SURINAME');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (226, 0, 'SVALBARD', 'SVALBARD');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (227, 0, 'THAILAND', 'TAILÂNDIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (228, 0, 'TAIWAN', 'TAIWAN');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (229, 0, 'TAJIKISTAN', 'TAJIQUISTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (230, 0, 'TANZANIA', 'TANZÂNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (231, 0, 'BRITISH INDIAN OCEAN TERRITORY', 'TERRITÓRIO BRITÂNICO DO OCEANO ÍNDICO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (232, 0, 'HEARD ISLAND AND MCDONALD ISLANDS', 'TERRITÓRIO DAS ILHAS HEARD E MCDONALD');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (233, 0, 'TIMOR-LESTE', 'TIMOR-LESTE');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (234, 0, 'TOGO', 'TOGO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (235, 0, 'TOKELAU', 'TOKELAU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (236, 0, 'TONGA', 'TONGA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (237, 0, 'TRINIDAD AND TOBAGO', 'TRINDADE E TOBAGO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (238, 0, 'TUNISIA', 'TUNÍSIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (239, 0, 'TURKS AND CAICOS ISLANDS', 'TURKS E CAICOS');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (240, 0, 'TURKMENISTAN', 'TURQUEMENISTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (242, 0, 'TUVALU', 'TUVALU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (243, 0, 'UKRAINE', 'UCRÂNIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (244, 0, 'UGANDA', 'UGANDA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (245, 0, 'URUGUAY', 'URUGUAI');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (246, 0, 'UZBEKISTAN', 'USBEQUISTÃO');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (247, 0, 'VANUATU', 'VANUATU');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (248, 0, 'VENEZUELA', 'VENEZUELA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (249, 0, 'VIETNAM', 'VIETNAME');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (250, 0, 'WALLIS AND FUTUNA', 'WALLIS E FUTUNA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (251, 0, 'ZAMBIA', 'ZÂMBIA');
INSERT INTO pais (id, version, country_name, nome_pais) VALUES (252, 0, 'ZIMBABWE', 'ZIMBABUÉ');


--
-- TOC entry 2705 (class 0 OID 0)
-- Dependencies: 204
-- Name: pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pais_id_seq', 253, false);


--
-- TOC entry 2471 (class 0 OID 89646)
-- Dependencies: 207
-- Data for Name: permissao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO permissao (id, version, config_attribute, url) VALUES (1, 0, 'ROLE_ADMINISTRADOR', '/acesso/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (2, 0, 'ROLE_ADMINISTRADOR', '/regra/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (3, 0, 'ROLE_ADMINISTRADOR', '/permissao/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (4, 0, 'ROLE_ADMINISTRADOR', '/auditLogEvent/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (5, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/empresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (6, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/certificacaoEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (7, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/fotoEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (8, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/responsavelEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (9, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/telefoneEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (10, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA,ROLE_PROPRIEDADE', '/propriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (11, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA,ROLE_PROPRIEDADE', '/certificacaoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (12, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA,ROLE_PROPRIEDADE', '/fotoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (13, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA,ROLE_PROPRIEDADE', '/responsavelPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (14, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA,ROLE_PROPRIEDADE', '/talhaoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (15, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA,ROLE_PROPRIEDADE', '/fotoTalhaoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (16, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA,ROLE_PROPRIEDADE', '/telefonePropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (17, 0, 'ROLE_ADMINISTRADOR', '/cidade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (18, 0, 'ROLE_ADMINISTRADOR', '/estado/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (19, 0, 'ROLE_ADMINISTRADOR', '/pais/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (20, 0, 'ROLE_ADMINISTRADOR', '/atributo/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (21, 0, 'ROLE_ADMINISTRADOR', '/cultivar/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (22, 0, 'ROLE_ADMINISTRADOR', '/fase/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (23, 0, 'ROLE_ADMINISTRADOR', '/listaAtributo/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (24, 0, 'ROLE_ADMINISTRADOR', '/produto/**');


--
-- TOC entry 2706 (class 0 OID 0)
-- Dependencies: 206
-- Name: permissao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('permissao_id_seq', 24, true);


--
-- TOC entry 2500 (class 0 OID 97281)
-- Dependencies: 236
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO produto (id, version, descricao_produto, observacao_produto) VALUES (1, 0, 'TRIGO', NULL);


--
-- TOC entry 2707 (class 0 OID 0)
-- Dependencies: 235
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('produto_id_seq', 2, true);


--
-- TOC entry 2473 (class 0 OID 89656)
-- Dependencies: 209
-- Data for Name: propriedade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO propriedade (id, version, bairro_propriedade, cep_propriedade, cidade_id, cnpj, complemento_propriedade, cpf, email_propriedade, logradouro_propriedade, nome_fantasia_propriedade, nome_propriedade, numero_propriedade, porte, tipo_propriedade) VALUES (1, 1, 'MATO QUEIMADO', '84010-100', 225, NULL, 'ÁREA RURAL', '925.757.579-91', 'hortifrutipg@hotmail.com', 'RUA B', 'HORTIFRUTI PONTA GROSSA', 'HORTIFRUTI PONTA GROSSA', 'S/N', 'Pequena', 'Pessoa Física');


--
-- TOC entry 2708 (class 0 OID 0)
-- Dependencies: 208
-- Name: propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('propriedade_id_seq', 1, true);


--
-- TOC entry 2502 (class 0 OID 97292)
-- Dependencies: 238
-- Data for Name: rastro_atributo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2709 (class 0 OID 0)
-- Dependencies: 237
-- Name: rastro_atributo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('rastro_atributo_id_seq', 1, false);


--
-- TOC entry 2504 (class 0 OID 97303)
-- Dependencies: 240
-- Data for Name: rastro_fase; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2710 (class 0 OID 0)
-- Dependencies: 239
-- Name: rastro_fase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('rastro_fase_id_seq', 1, false);


--
-- TOC entry 2506 (class 0 OID 97311)
-- Dependencies: 242
-- Data for Name: rastro_produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO rastro_produto (id, version, ano_safra, cultivar_id, data_alterado, data_criado, empresa_id, produto_id, propriedade_id, talhao_propriedade_id) VALUES (1, 0, '2016', 1, NULL, '2016-04-27 00:00:00', 1, 1, 1, 1);


--
-- TOC entry 2711 (class 0 OID 0)
-- Dependencies: 241
-- Name: rastro_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('rastro_produto_id_seq', 1, true);


--
-- TOC entry 2475 (class 0 OID 89667)
-- Dependencies: 211
-- Data for Name: regra; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO regra (id, version, authority) VALUES (1, 0, 'ROLE_ADMINISTRADOR');
INSERT INTO regra (id, version, authority) VALUES (2, 0, 'ROLE_EMPRESA');
INSERT INTO regra (id, version, authority) VALUES (3, 0, 'ROLE_PROPRIEDADE');
INSERT INTO regra (id, version, authority) VALUES (4, 0, 'ROLE_AGENTE');
INSERT INTO regra (id, version, authority) VALUES (5, 0, 'ROLE_CLIENTE');


--
-- TOC entry 2712 (class 0 OID 0)
-- Dependencies: 210
-- Name: regra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('regra_id_seq', 5, true);


--
-- TOC entry 2477 (class 0 OID 89677)
-- Dependencies: 213
-- Data for Name: responsavel_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2713 (class 0 OID 0)
-- Dependencies: 212
-- Name: responsavel_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('responsavel_empresa_id_seq', 1, false);


--
-- TOC entry 2479 (class 0 OID 89687)
-- Dependencies: 215
-- Data for Name: responsavel_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2714 (class 0 OID 0)
-- Dependencies: 214
-- Name: responsavel_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('responsavel_propriedade_id_seq', 1, false);


--
-- TOC entry 2481 (class 0 OID 89697)
-- Dependencies: 217
-- Data for Name: talhao_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO talhao_propriedade (id, version, descricao_talhao, ha_talhao, latitude_talhao, longitude_talhao, propriedade_id) VALUES (1, 0, '1', 10, '-25.0794073', '-50.1916156', 1);


--
-- TOC entry 2715 (class 0 OID 0)
-- Dependencies: 216
-- Name: talhao_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('talhao_propriedade_id_seq', 1, true);


--
-- TOC entry 2483 (class 0 OID 89705)
-- Dependencies: 219
-- Data for Name: telefone_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2716 (class 0 OID 0)
-- Dependencies: 218
-- Name: telefone_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('telefone_empresa_id_seq', 1, true);


--
-- TOC entry 2485 (class 0 OID 89715)
-- Dependencies: 221
-- Data for Name: telefone_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2717 (class 0 OID 0)
-- Dependencies: 220
-- Name: telefone_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('telefone_propriedade_id_seq', 1, false);


--
-- TOC entry 2487 (class 0 OID 89725)
-- Dependencies: 223
-- Data for Name: tipo_certificacao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipo_certificacao (id, version, descricao_tipo_certificacao) VALUES (1, 0, 'CERTIFICAÇÃO ISO');


--
-- TOC entry 2718 (class 0 OID 0)
-- Dependencies: 222
-- Name: tipo_certificacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_certificacao_id_seq', 1, true);


--
-- TOC entry 2489 (class 0 OID 89733)
-- Dependencies: 225
-- Data for Name: tipo_responsavel; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipo_responsavel (id, version, descricao_tipo_responsavel) VALUES (1, 0, 'PROPRIETÁRIO');


--
-- TOC entry 2719 (class 0 OID 0)
-- Dependencies: 224
-- Name: tipo_responsavel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_responsavel_id_seq', 1, true);


--
-- TOC entry 2209 (class 2606 OID 89532)
-- Name: acesso_empresas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_empresas
    ADD CONSTRAINT acesso_empresas_pkey PRIMARY KEY (acesso_id, empresa_id);


--
-- TOC entry 2207 (class 2606 OID 89527)
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2211 (class 2606 OID 89537)
-- Name: acesso_propriedades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_propriedades
    ADD CONSTRAINT acesso_propriedades_pkey PRIMARY KEY (acesso_id, propriedade_id);


--
-- TOC entry 2213 (class 2606 OID 89542)
-- Name: acesso_regra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_regra
    ADD CONSTRAINT acesso_regra_pkey PRIMARY KEY (regra_id, acesso_id);


--
-- TOC entry 2267 (class 2606 OID 97240)
-- Name: atributo_fase_id_nome_atributo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo
    ADD CONSTRAINT atributo_fase_id_nome_atributo_key UNIQUE (fase_id, nome_atributo);


--
-- TOC entry 2269 (class 2606 OID 97238)
-- Name: atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo
    ADD CONSTRAINT atributo_pkey PRIMARY KEY (id);


--
-- TOC entry 2215 (class 2606 OID 89553)
-- Name: audit_log_event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY audit_log_event
    ADD CONSTRAINT audit_log_event_pkey PRIMARY KEY (id);


--
-- TOC entry 2217 (class 2606 OID 89564)
-- Name: certificacao_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa
    ADD CONSTRAINT certificacao_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2219 (class 2606 OID 89575)
-- Name: certificacao_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade
    ADD CONSTRAINT certificacao_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2221 (class 2606 OID 89583)
-- Name: cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT cidade_pkey PRIMARY KEY (id);


--
-- TOC entry 2271 (class 2606 OID 97250)
-- Name: cultivar_descricao_cultivar_produto_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar
    ADD CONSTRAINT cultivar_descricao_cultivar_produto_id_key UNIQUE (descricao_cultivar, produto_id);


--
-- TOC entry 2273 (class 2606 OID 97248)
-- Name: cultivar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar
    ADD CONSTRAINT cultivar_pkey PRIMARY KEY (id);


--
-- TOC entry 2223 (class 2606 OID 89594)
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2225 (class 2606 OID 89602)
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2275 (class 2606 OID 97261)
-- Name: fase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase
    ADD CONSTRAINT fase_pkey PRIMARY KEY (id);


--
-- TOC entry 2277 (class 2606 OID 97263)
-- Name: fase_produto_id_descricao_fase_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase
    ADD CONSTRAINT fase_produto_id_descricao_fase_key UNIQUE (produto_id, descricao_fase);


--
-- TOC entry 2227 (class 2606 OID 89613)
-- Name: foto_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_empresa
    ADD CONSTRAINT foto_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2229 (class 2606 OID 89624)
-- Name: foto_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_propriedade
    ADD CONSTRAINT foto_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2231 (class 2606 OID 89635)
-- Name: foto_talhao_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_talhao_propriedade
    ADD CONSTRAINT foto_talhao_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2279 (class 2606 OID 97271)
-- Name: lista_atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo
    ADD CONSTRAINT lista_atributo_pkey PRIMARY KEY (id);


--
-- TOC entry 2283 (class 2606 OID 97278)
-- Name: lista_atributo_rastros_lista_atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo_rastros_lista_atributo
    ADD CONSTRAINT lista_atributo_rastros_lista_atributo_pkey PRIMARY KEY (lista_atributo_id, rastro_atributo_id);


--
-- TOC entry 2281 (class 2606 OID 97273)
-- Name: lista_atributo_valor_lista_atributo_atributo_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo
    ADD CONSTRAINT lista_atributo_valor_lista_atributo_atributo_id_key UNIQUE (valor_lista_atributo, atributo_id);


--
-- TOC entry 2233 (class 2606 OID 89643)
-- Name: pais_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2235 (class 2606 OID 89651)
-- Name: permissao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissao
    ADD CONSTRAINT permissao_pkey PRIMARY KEY (id);


--
-- TOC entry 2237 (class 2606 OID 89653)
-- Name: permissao_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissao
    ADD CONSTRAINT permissao_url_key UNIQUE (url);


--
-- TOC entry 2285 (class 2606 OID 97289)
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2239 (class 2606 OID 89664)
-- Name: propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY propriedade
    ADD CONSTRAINT propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2287 (class 2606 OID 97300)
-- Name: rastro_atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo
    ADD CONSTRAINT rastro_atributo_pkey PRIMARY KEY (id);


--
-- TOC entry 2289 (class 2606 OID 97308)
-- Name: rastro_fase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase
    ADD CONSTRAINT rastro_fase_pkey PRIMARY KEY (id);


--
-- TOC entry 2291 (class 2606 OID 97316)
-- Name: rastro_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT rastro_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2241 (class 2606 OID 89674)
-- Name: regra_authority_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regra
    ADD CONSTRAINT regra_authority_key UNIQUE (authority);


--
-- TOC entry 2243 (class 2606 OID 89672)
-- Name: regra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regra
    ADD CONSTRAINT regra_pkey PRIMARY KEY (id);


--
-- TOC entry 2245 (class 2606 OID 89684)
-- Name: responsavel_empresa_numero_telefone_responsavel_empresa_ddd_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT responsavel_empresa_numero_telefone_responsavel_empresa_ddd_key UNIQUE (numero_telefone_responsavel_empresa, ddd_responsavel_empresa);


--
-- TOC entry 2247 (class 2606 OID 89682)
-- Name: responsavel_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT responsavel_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2249 (class 2606 OID 89694)
-- Name: responsavel_propriedade_numero_telefone_responsavel_proprie_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT responsavel_propriedade_numero_telefone_responsavel_proprie_key UNIQUE (numero_telefone_responsavel_propriedade, ddd_responsavel_propriedade);


--
-- TOC entry 2251 (class 2606 OID 89692)
-- Name: responsavel_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT responsavel_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2253 (class 2606 OID 89702)
-- Name: talhao_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_propriedade
    ADD CONSTRAINT talhao_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2255 (class 2606 OID 89712)
-- Name: telefone_empresa_numero_telefone_empresa_ddd_empresa_empres_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa
    ADD CONSTRAINT telefone_empresa_numero_telefone_empresa_ddd_empresa_empres_key UNIQUE (numero_telefone_empresa, ddd_empresa, empresa_id);


--
-- TOC entry 2257 (class 2606 OID 89710)
-- Name: telefone_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa
    ADD CONSTRAINT telefone_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2259 (class 2606 OID 89722)
-- Name: telefone_propriedade_numero_telefone_propriedade_ddd_propri_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade
    ADD CONSTRAINT telefone_propriedade_numero_telefone_propriedade_ddd_propri_key UNIQUE (numero_telefone_propriedade, ddd_propriedade, propriedade_id);


--
-- TOC entry 2261 (class 2606 OID 89720)
-- Name: telefone_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade
    ADD CONSTRAINT telefone_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2263 (class 2606 OID 89730)
-- Name: tipo_certificacao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_certificacao
    ADD CONSTRAINT tipo_certificacao_pkey PRIMARY KEY (id);


--
-- TOC entry 2265 (class 2606 OID 89738)
-- Name: tipo_responsavel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_responsavel
    ADD CONSTRAINT tipo_responsavel_pkey PRIMARY KEY (id);


--
-- TOC entry 2317 (class 2606 OID 97322)
-- Name: fk182cfa986cc25b3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar
    ADD CONSTRAINT fk182cfa986cc25b3d FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2313 (class 2606 OID 89844)
-- Name: fk184db5614cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_propriedade
    ADD CONSTRAINT fk184db5614cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2316 (class 2606 OID 97317)
-- Name: fk1d2346b8cb7ba557; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo
    ADD CONSTRAINT fk1d2346b8cb7ba557 FOREIGN KEY (fase_id) REFERENCES fase(id);


--
-- TOC entry 2301 (class 2606 OID 89784)
-- Name: fk1f1b0e354cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade
    ADD CONSTRAINT fk1f1b0e354cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2300 (class 2606 OID 89779)
-- Name: fk1f1b0e35ec8cf724; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade
    ADD CONSTRAINT fk1f1b0e35ec8cf724 FOREIGN KEY (tipo_certificacao_id) REFERENCES tipo_certificacao(id);


--
-- TOC entry 2318 (class 2606 OID 97327)
-- Name: fk2fd84d6cc25b3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase
    ADD CONSTRAINT fk2fd84d6cc25b3d FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2314 (class 2606 OID 89849)
-- Name: fk4f30c834d0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa
    ADD CONSTRAINT fk4f30c834d0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2294 (class 2606 OID 89749)
-- Name: fk4f4693d2eb83573; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_propriedades
    ADD CONSTRAINT fk4f4693d2eb83573 FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2295 (class 2606 OID 89754)
-- Name: fk4f4693d4cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_propriedades
    ADD CONSTRAINT fk4f4693d4cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2306 (class 2606 OID 89809)
-- Name: fk64e0cc4e4cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_propriedade
    ADD CONSTRAINT fk64e0cc4e4cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2311 (class 2606 OID 89834)
-- Name: fk66bab38a4cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT fk66bab38a4cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2312 (class 2606 OID 89839)
-- Name: fk66bab38a9a70f730; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT fk66bab38a9a70f730 FOREIGN KEY (tipo_responsavel_id) REFERENCES tipo_responsavel(id);


--
-- TOC entry 2327 (class 2606 OID 97372)
-- Name: fk6d557fc715f0d6f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc715f0d6f7 FOREIGN KEY (cultivar_id) REFERENCES cultivar(id);


--
-- TOC entry 2328 (class 2606 OID 97377)
-- Name: fk6d557fc74cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc74cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2326 (class 2606 OID 97367)
-- Name: fk6d557fc76cc25b3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc76cc25b3d FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2330 (class 2606 OID 97387)
-- Name: fk6d557fc7d0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc7d0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2329 (class 2606 OID 97382)
-- Name: fk6d557fc7f916efde; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc7f916efde FOREIGN KEY (talhao_propriedade_id) REFERENCES talhao_propriedade(id);


--
-- TOC entry 2307 (class 2606 OID 89814)
-- Name: fk72c2287cf916efde; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_talhao_propriedade
    ADD CONSTRAINT fk72c2287cf916efde FOREIGN KEY (talhao_propriedade_id) REFERENCES talhao_propriedade(id);


--
-- TOC entry 2299 (class 2606 OID 89774)
-- Name: fk84a6fdb5d0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa
    ADD CONSTRAINT fk84a6fdb5d0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2298 (class 2606 OID 89769)
-- Name: fk84a6fdb5ec8cf724; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa
    ADD CONSTRAINT fk84a6fdb5ec8cf724 FOREIGN KEY (tipo_certificacao_id) REFERENCES tipo_certificacao(id);


--
-- TOC entry 2322 (class 2606 OID 97347)
-- Name: fk9651afaa76022112; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo
    ADD CONSTRAINT fk9651afaa76022112 FOREIGN KEY (rastro_fase_id) REFERENCES rastro_fase(id);


--
-- TOC entry 2323 (class 2606 OID 97352)
-- Name: fk9651afaa8ccbe2f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo
    ADD CONSTRAINT fk9651afaa8ccbe2f7 FOREIGN KEY (atributo_id) REFERENCES atributo(id);


--
-- TOC entry 2303 (class 2606 OID 89794)
-- Name: fk9f3540895a71537b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT fk9f3540895a71537b FOREIGN KEY (cidade_id) REFERENCES cidade(id);


--
-- TOC entry 2315 (class 2606 OID 89854)
-- Name: fka2ad81344cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade
    ADD CONSTRAINT fka2ad81344cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2302 (class 2606 OID 89789)
-- Name: fkaee65724e42c143b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT fkaee65724e42c143b FOREIGN KEY (estado_id) REFERENCES estado(id);


--
-- TOC entry 2304 (class 2606 OID 89799)
-- Name: fkb2e439662542c05b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT fkb2e439662542c05b FOREIGN KEY (pais_id) REFERENCES pais(id);


--
-- TOC entry 2319 (class 2606 OID 97332)
-- Name: fkbc1957f48ccbe2f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo
    ADD CONSTRAINT fkbc1957f48ccbe2f7 FOREIGN KEY (atributo_id) REFERENCES atributo(id);


--
-- TOC entry 2297 (class 2606 OID 89764)
-- Name: fkbd0576702eb83573; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_regra
    ADD CONSTRAINT fkbd0576702eb83573 FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2296 (class 2606 OID 89759)
-- Name: fkbd057670c922d881; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_regra
    ADD CONSTRAINT fkbd057670c922d881 FOREIGN KEY (regra_id) REFERENCES regra(id);


--
-- TOC entry 2305 (class 2606 OID 89804)
-- Name: fkc6a9b04ed0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_empresa
    ADD CONSTRAINT fkc6a9b04ed0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2321 (class 2606 OID 97342)
-- Name: fkd14cf2f830e11284; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo_rastros_lista_atributo
    ADD CONSTRAINT fkd14cf2f830e11284 FOREIGN KEY (lista_atributo_id) REFERENCES lista_atributo(id);


--
-- TOC entry 2320 (class 2606 OID 97337)
-- Name: fkd14cf2f853e80932; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo_rastros_lista_atributo
    ADD CONSTRAINT fkd14cf2f853e80932 FOREIGN KEY (rastro_atributo_id) REFERENCES rastro_atributo(id);


--
-- TOC entry 2324 (class 2606 OID 97357)
-- Name: fkdbcc8a3fa4bb01a2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase
    ADD CONSTRAINT fkdbcc8a3fa4bb01a2 FOREIGN KEY (rastro_produto_id) REFERENCES rastro_produto(id);


--
-- TOC entry 2325 (class 2606 OID 97362)
-- Name: fkdbcc8a3fcb7ba557; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase
    ADD CONSTRAINT fkdbcc8a3fcb7ba557 FOREIGN KEY (fase_id) REFERENCES fase(id);


--
-- TOC entry 2310 (class 2606 OID 89829)
-- Name: fkdd30958a9a70f730; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT fkdd30958a9a70f730 FOREIGN KEY (tipo_responsavel_id) REFERENCES tipo_responsavel(id);


--
-- TOC entry 2309 (class 2606 OID 89824)
-- Name: fkdd30958ad0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT fkdd30958ad0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2292 (class 2606 OID 89739)
-- Name: fked3713d2eb83573; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_empresas
    ADD CONSTRAINT fked3713d2eb83573 FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2293 (class 2606 OID 89744)
-- Name: fked3713dd0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_empresas
    ADD CONSTRAINT fked3713dd0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2308 (class 2606 OID 89819)
-- Name: fkf063c7095a71537b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY propriedade
    ADD CONSTRAINT fkf063c7095a71537b FOREIGN KEY (cidade_id) REFERENCES cidade(id);


-- Completed on 2016-04-28 11:28:09

--
-- PostgreSQL database dump complete
--

