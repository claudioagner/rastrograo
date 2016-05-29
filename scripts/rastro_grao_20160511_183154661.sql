--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.1

-- Started on 2016-05-11 18:31:55

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
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 116029)
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
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 182
-- Name: TABLE acesso; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE acesso IS 'Tabela contendo os acessos do sistema';


--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN acesso.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN acesso.id IS 'identificador do registro';


--
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN acesso.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN acesso.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 183 (class 1259 OID 116035)
-- Name: acesso_empresas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso_empresas (
    empresa_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 181 (class 1259 OID 116027)
-- Name: acesso_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE acesso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 181
-- Name: acesso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE acesso_id_seq OWNED BY acesso.id;


--
-- TOC entry 184 (class 1259 OID 116040)
-- Name: acesso_propriedades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso_propriedades (
    propriedade_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 185 (class 1259 OID 116045)
-- Name: acesso_regra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso_regra (
    regra_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 187 (class 1259 OID 116052)
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
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE atributo IS 'Tabela contendo os Atributos das Fases dos Produtos cadastrados no sistema';


--
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN atributo.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.id IS 'identificador do registro';


--
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN atributo.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN atributo.descricao_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.descricao_atributo IS 'descrição do atributo da fase do produto';


--
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN atributo.fase_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.fase_id IS 'identificador da tabela fase';


--
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN atributo.nome_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN atributo.nome_atributo IS 'nome do atributo da fase do produto cadastrado';


--
-- TOC entry 186 (class 1259 OID 116050)
-- Name: atributo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE atributo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 186
-- Name: atributo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE atributo_id_seq OWNED BY atributo.id;


--
-- TOC entry 189 (class 1259 OID 116065)
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
-- TOC entry 188 (class 1259 OID 116063)
-- Name: audit_log_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audit_log_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 188
-- Name: audit_log_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audit_log_event_id_seq OWNED BY audit_log_event.id;


--
-- TOC entry 191 (class 1259 OID 116076)
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
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE certificacao_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE certificacao_empresa IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.id IS 'identificador do registro';


--
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2576 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_empresa.data_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.data_certificacao IS 'Data da certificacao';


--
-- TOC entry 2577 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.empresa_id IS 'identificador da empresa';


--
-- TOC entry 2578 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_empresa.observacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.observacao IS 'Observacao da certificação sem limite de caracteres';


--
-- TOC entry 2579 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN certificacao_empresa.tipo_certificacao_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_empresa.tipo_certificacao_id IS 'identificador do tipo de certificação';


--
-- TOC entry 190 (class 1259 OID 116074)
-- Name: certificacao_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE certificacao_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2580 (class 0 OID 0)
-- Dependencies: 190
-- Name: certificacao_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE certificacao_empresa_id_seq OWNED BY certificacao_empresa.id;


--
-- TOC entry 193 (class 1259 OID 116087)
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
-- TOC entry 2581 (class 0 OID 0)
-- Dependencies: 193
-- Name: TABLE certificacao_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE certificacao_propriedade IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2582 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN certificacao_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2583 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN certificacao_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2584 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN certificacao_propriedade.data_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.data_certificacao IS 'Data da certificacao';


--
-- TOC entry 2585 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN certificacao_propriedade.observacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.observacao IS 'Observacao da certificação sem limite de caracteres';


--
-- TOC entry 2586 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN certificacao_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.propriedade_id IS 'identificador da propriedade';


--
-- TOC entry 2587 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN certificacao_propriedade.tipo_certificacao_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN certificacao_propriedade.tipo_certificacao_id IS 'identificador do tipo de certificação';


--
-- TOC entry 192 (class 1259 OID 116085)
-- Name: certificacao_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE certificacao_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 192
-- Name: certificacao_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE certificacao_propriedade_id_seq OWNED BY certificacao_propriedade.id;


--
-- TOC entry 195 (class 1259 OID 116098)
-- Name: cidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cidade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    estado_id bigint NOT NULL,
    nome_cidade character varying(128) NOT NULL
);


--
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 195
-- Name: TABLE cidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE cidade IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2590 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN cidade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cidade.id IS 'identificador do registro';


--
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN cidade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cidade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2592 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN cidade.nome_cidade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cidade.nome_cidade IS 'Nome da cidade contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 194 (class 1259 OID 116096)
-- Name: cidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2593 (class 0 OID 0)
-- Dependencies: 194
-- Name: cidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cidade_id_seq OWNED BY cidade.id;


--
-- TOC entry 197 (class 1259 OID 116106)
-- Name: consolidacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE consolidacao (
    id bigint NOT NULL,
    version bigint NOT NULL,
    data_consolidacao timestamp without time zone NOT NULL,
    data_lote_origem timestamp without time zone NOT NULL,
    empresa_origem_id bigint NOT NULL,
    lote_id bigint NOT NULL,
    nr_lote_consolidado character varying(32) NOT NULL,
    observacao character varying(65534),
    propriedade_origem_id bigint NOT NULL,
    validade_lote_origem timestamp without time zone NOT NULL,
    volume_lote_origem double precision NOT NULL
);


--
-- TOC entry 2594 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE consolidacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE consolidacao IS 'Tabela contendo as consolidações do lote';


--
-- TOC entry 2595 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.id IS 'identificador do registro';


--
-- TOC entry 2596 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2597 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.data_consolidacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.data_consolidacao IS 'data da consolidação';


--
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.data_lote_origem; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.data_lote_origem IS 'data do lote de origem';


--
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.empresa_origem_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.empresa_origem_id IS 'empresa de origem do produto';


--
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.lote_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.lote_id IS 'identificador do lote que esta sendo consolidado';


--
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.nr_lote_consolidado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.nr_lote_consolidado IS 'numero do lote que está sendo consolidado';


--
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.observacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.observacao IS 'observações relacionadas ao produto';


--
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.propriedade_origem_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.propriedade_origem_id IS 'propriedade de origem do produto';


--
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.validade_lote_origem; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.validade_lote_origem IS 'data de validade do lote de origem';


--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN consolidacao.volume_lote_origem; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN consolidacao.volume_lote_origem IS 'volume em kg do lote a ser consolidado';


--
-- TOC entry 196 (class 1259 OID 116104)
-- Name: consolidacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE consolidacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 196
-- Name: consolidacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE consolidacao_id_seq OWNED BY consolidacao.id;


--
-- TOC entry 199 (class 1259 OID 116117)
-- Name: cultivar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cultivar (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_cultivar character varying(128) NOT NULL,
    produto_id bigint NOT NULL
);


--
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 199
-- Name: TABLE cultivar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE cultivar IS 'Tabela contendo os Cultivares dos produtos cadastrados no sistema';


--
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN cultivar.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.id IS 'identificador do registro';


--
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN cultivar.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2610 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN cultivar.descricao_cultivar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.descricao_cultivar IS 'descrição do cultivar cadastrado';


--
-- TOC entry 2611 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN cultivar.produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN cultivar.produto_id IS 'identificador do produto';


--
-- TOC entry 198 (class 1259 OID 116115)
-- Name: cultivar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cultivar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2612 (class 0 OID 0)
-- Dependencies: 198
-- Name: cultivar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cultivar_id_seq OWNED BY cultivar.id;


--
-- TOC entry 201 (class 1259 OID 116127)
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
    email_empresa character varying(128),
    logradouro_empresa character varying(128) NOT NULL,
    nome_empresa character varying(128) NOT NULL,
    nome_fantasia_empresa character varying(128) NOT NULL,
    numero_empresa character varying(10) NOT NULL,
    tipo_empresa character varying(32) NOT NULL
);


--
-- TOC entry 2613 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE empresa IS 'Tabela contendo as Empresas do sistema';


--
-- TOC entry 2614 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN empresa.id IS 'identificador do registro';


--
-- TOC entry 2615 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2616 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN empresa.nome_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN empresa.nome_empresa IS 'Nome da empresa contendo no máximo 128 caracteres';


--
-- TOC entry 200 (class 1259 OID 116125)
-- Name: empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2617 (class 0 OID 0)
-- Dependencies: 200
-- Name: empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE empresa_id_seq OWNED BY empresa.id;


--
-- TOC entry 203 (class 1259 OID 116138)
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
-- TOC entry 2618 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE estado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE estado IS 'Tabela contendo os Estados por Pais';


--
-- TOC entry 2619 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN estado.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.id IS 'identificador do registro';


--
-- TOC entry 2620 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN estado.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2621 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN estado.nome_estado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.nome_estado IS 'Nome do estado contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 2622 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN estado.sigla; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN estado.sigla IS 'Sigla do estado contendo no mínimo 2 e no máximo 2 caracteres e com valor único';


--
-- TOC entry 202 (class 1259 OID 116136)
-- Name: estado_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2623 (class 0 OID 0)
-- Dependencies: 202
-- Name: estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE estado_id_seq OWNED BY estado.id;


--
-- TOC entry 205 (class 1259 OID 116146)
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
-- TOC entry 2624 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE fase IS 'Tabela contendo as Fases dos Produtos cadastrados no sistema';


--
-- TOC entry 2625 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN fase.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.id IS 'identificador do registro';


--
-- TOC entry 2626 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN fase.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2627 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN fase.descricao_fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.descricao_fase IS 'descrição da fase do produto cadastrado';


--
-- TOC entry 2628 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN fase.observacao_fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.observacao_fase IS 'observações relacionadas à fase do produto';


--
-- TOC entry 2629 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN fase.produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN fase.produto_id IS 'identificador do produto';


--
-- TOC entry 204 (class 1259 OID 116144)
-- Name: fase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2630 (class 0 OID 0)
-- Dependencies: 204
-- Name: fase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fase_id_seq OWNED BY fase.id;


--
-- TOC entry 207 (class 1259 OID 116159)
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
-- TOC entry 2631 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE foto_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE foto_empresa IS 'Tabela contendo as imganes das Empresas do sistema';


--
-- TOC entry 2632 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN foto_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.id IS 'identificador do registro';


--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN foto_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN foto_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.empresa_id IS 'identificador da tabela empresa';


--
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN foto_empresa.foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.foto IS 'foto adicionada';


--
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN foto_empresa.titulo_foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_empresa.titulo_foto IS 'título da foto contendo no máximo 128 caracteres';


--
-- TOC entry 206 (class 1259 OID 116157)
-- Name: foto_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE foto_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 206
-- Name: foto_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE foto_empresa_id_seq OWNED BY foto_empresa.id;


--
-- TOC entry 209 (class 1259 OID 116170)
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
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE foto_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE foto_propriedade IS 'Tabela contendo as imagens das Propriedades do sistema';


--
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN foto_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN foto_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN foto_propriedade.foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.foto IS 'foto adicionada';


--
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN foto_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.propriedade_id IS 'identificador da tabela propriedade';


--
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN foto_propriedade.titulo_foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_propriedade.titulo_foto IS 'título da foto contendo no máximo 128 caracteres';


--
-- TOC entry 208 (class 1259 OID 116168)
-- Name: foto_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE foto_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2644 (class 0 OID 0)
-- Dependencies: 208
-- Name: foto_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE foto_propriedade_id_seq OWNED BY foto_propriedade.id;


--
-- TOC entry 211 (class 1259 OID 116181)
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
-- TOC entry 2645 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE foto_talhao_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE foto_talhao_propriedade IS 'Tabela contendo as imagens das TalhaoPropriedades do sistema';


--
-- TOC entry 2646 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN foto_talhao_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2647 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN foto_talhao_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2648 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN foto_talhao_propriedade.foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.foto IS 'foto adicionada';


--
-- TOC entry 2649 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN foto_talhao_propriedade.talhao_propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.talhao_propriedade_id IS 'identificador da tabela talhao propriedade';


--
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN foto_talhao_propriedade.titulo_foto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN foto_talhao_propriedade.titulo_foto IS 'título da foto contendo no máximo 128 caracteres';


--
-- TOC entry 210 (class 1259 OID 116179)
-- Name: foto_talhao_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE foto_talhao_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 210
-- Name: foto_talhao_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE foto_talhao_propriedade_id_seq OWNED BY foto_talhao_propriedade.id;


--
-- TOC entry 213 (class 1259 OID 116192)
-- Name: lista_atributo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lista_atributo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    atributo_id bigint NOT NULL,
    valor_lista_atributo character varying(128) NOT NULL
);


--
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE lista_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE lista_atributo IS 'Tabela contendo os valores da lista do atributo cadastrados no sistema';


--
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN lista_atributo.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.id IS 'identificador do registro';


--
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN lista_atributo.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN lista_atributo.atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.atributo_id IS 'identificador da tabela atributo';


--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN lista_atributo.valor_lista_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lista_atributo.valor_lista_atributo IS 'valor da lista do atributo cadastrado';


--
-- TOC entry 212 (class 1259 OID 116190)
-- Name: lista_atributo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lista_atributo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 212
-- Name: lista_atributo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lista_atributo_id_seq OWNED BY lista_atributo.id;


--
-- TOC entry 215 (class 1259 OID 116202)
-- Name: lote; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lote (
    id bigint NOT NULL,
    version bigint NOT NULL,
    data_lote timestamp without time zone NOT NULL,
    nr_lote_manual character varying(255),
    nr_lote_sequencial boolean NOT NULL,
    observacao character varying(65534),
    rastro_produto_id bigint NOT NULL,
    validade_lote timestamp without time zone NOT NULL,
    volume_lote double precision NOT NULL
);


--
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE lote; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE lote IS 'Tabela contendo os lotes da customização';


--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.id IS 'identificador do registro';


--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.data_lote; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.data_lote IS 'data da geração do lote';


--
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.nr_lote_manual; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.nr_lote_manual IS 'numeração especificada manualmente';


--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.nr_lote_sequencial; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.nr_lote_sequencial IS 'quando ativado o número do lote será gerado pelo sistema, ou abre o campo para informe manual';


--
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.observacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.observacao IS 'observação relacionadas ao lote';


--
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.rastro_produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.rastro_produto_id IS 'customização que será loteada';


--
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.validade_lote; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.validade_lote IS 'data de validade do produto loteado';


--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN lote.volume_lote; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN lote.volume_lote IS 'volume em kg do lote';


--
-- TOC entry 214 (class 1259 OID 116200)
-- Name: lote_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 214
-- Name: lote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lote_id_seq OWNED BY lote.id;


--
-- TOC entry 217 (class 1259 OID 116213)
-- Name: pais; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pais (
    id bigint NOT NULL,
    version bigint NOT NULL,
    country_name character varying(128) NOT NULL,
    nome_pais character varying(128) NOT NULL
);


--
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE pais; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE pais IS 'Tabela contendo os paises do mundo';


--
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN pais.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.id IS 'identificador do registro';


--
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN pais.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN pais.country_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.country_name IS 'Nome do pais em Inglês contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN pais.nome_pais; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN pais.nome_pais IS 'Nome do pais contendo no máximo 128 caracteres e com valor único';


--
-- TOC entry 216 (class 1259 OID 116211)
-- Name: pais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 216
-- Name: pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pais_id_seq OWNED BY pais.id;


--
-- TOC entry 219 (class 1259 OID 116221)
-- Name: permissao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE permissao (
    id bigint NOT NULL,
    version bigint NOT NULL,
    config_attribute character varying(128) NOT NULL,
    url character varying(128) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 116219)
-- Name: permissao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE permissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 218
-- Name: permissao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE permissao_id_seq OWNED BY permissao.id;


--
-- TOC entry 221 (class 1259 OID 116231)
-- Name: produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE produto (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_produto character varying(128) NOT NULL,
    observacao_produto text,
    tipo_produto_id bigint NOT NULL
);


--
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE produto IS 'Tabela contendo os Produtos cadastrados no sistema';


--
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN produto.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.id IS 'identificador do registro';


--
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN produto.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN produto.descricao_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.descricao_produto IS 'descrição do produto cadastrado';


--
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN produto.observacao_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.observacao_produto IS 'observações relacionadas ao produto';


--
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN produto.tipo_produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN produto.tipo_produto_id IS 'identificador do tipo de produto';


--
-- TOC entry 220 (class 1259 OID 116229)
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 220
-- Name: produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE produto_id_seq OWNED BY produto.id;


--
-- TOC entry 223 (class 1259 OID 116242)
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
    email_propriedade character varying(128),
    logradouro_propriedade character varying(128) NOT NULL,
    nome_fantasia_propriedade character varying(128),
    nome_propriedade character varying(128) NOT NULL,
    numero_propriedade character varying(10) NOT NULL,
    porte character varying(32) NOT NULL,
    tipo_propriedade character varying(32) NOT NULL
);


--
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE propriedade IS 'Tabela contendo as Propriedades do sistema';


--
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN propriedade.id IS 'identificador do registro';


--
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN propriedade.nome_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN propriedade.nome_propriedade IS 'Nome da propriedade contendo no máximo 128 caracteres';


--
-- TOC entry 222 (class 1259 OID 116240)
-- Name: propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 222
-- Name: propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE propriedade_id_seq OWNED BY propriedade.id;


--
-- TOC entry 225 (class 1259 OID 116253)
-- Name: rastro_atributo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rastro_atributo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    atributo_id bigint NOT NULL,
    data_alterado timestamp without time zone,
    data_criado timestamp without time zone NOT NULL,
    exibirqrconsumidor boolean NOT NULL,
    rastro_fase_id bigint NOT NULL,
    registrar_dados boolean NOT NULL
);


--
-- TOC entry 2688 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE rastro_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE rastro_atributo IS 'Tabela contendo os valores do rastro atributo';


--
-- TOC entry 2689 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.id IS 'identificador do registro';


--
-- TOC entry 2690 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2691 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.atributo_id IS 'identificador da tabela atributo';


--
-- TOC entry 2692 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.data_alterado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.data_alterado IS 'data em que o rastro do atributo foi alterado';


--
-- TOC entry 2693 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.data_criado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.data_criado IS 'data em que o rastro do atributo foi criado';


--
-- TOC entry 2694 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.exibirqrconsumidor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.exibirqrconsumidor IS 'exibir o valor no qr code consumidor';


--
-- TOC entry 2695 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.rastro_fase_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.rastro_fase_id IS 'identificador da tabela rastro fase';


--
-- TOC entry 2696 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN rastro_atributo.registrar_dados; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_atributo.registrar_dados IS 'permite registrar o valor';


--
-- TOC entry 224 (class 1259 OID 116251)
-- Name: rastro_atributo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rastro_atributo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2697 (class 0 OID 0)
-- Dependencies: 224
-- Name: rastro_atributo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rastro_atributo_id_seq OWNED BY rastro_atributo.id;


--
-- TOC entry 227 (class 1259 OID 116261)
-- Name: rastro_fase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rastro_fase (
    id bigint NOT NULL,
    version bigint NOT NULL,
    data_criado timestamp without time zone NOT NULL,
    fase_id bigint NOT NULL,
    rastro_produto_id bigint NOT NULL
);


--
-- TOC entry 2698 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE rastro_fase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE rastro_fase IS 'Tabela contendo os valores do rastro fase';


--
-- TOC entry 2699 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN rastro_fase.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.id IS 'identificador do registro';


--
-- TOC entry 2700 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN rastro_fase.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2701 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN rastro_fase.data_criado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.data_criado IS 'data em que o rastro da fase foi criado';


--
-- TOC entry 2702 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN rastro_fase.fase_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.fase_id IS 'identificador da tabela fase';


--
-- TOC entry 2703 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN rastro_fase.rastro_produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_fase.rastro_produto_id IS 'identificador da tabela rastroProduto';


--
-- TOC entry 226 (class 1259 OID 116259)
-- Name: rastro_fase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rastro_fase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2704 (class 0 OID 0)
-- Dependencies: 226
-- Name: rastro_fase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rastro_fase_id_seq OWNED BY rastro_fase.id;


--
-- TOC entry 229 (class 1259 OID 116269)
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
    situacao character varying(12) NOT NULL,
    talhao_propriedade_id bigint NOT NULL
);


--
-- TOC entry 2705 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE rastro_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE rastro_produto IS 'Tabela contendo os valores do rastro produto';


--
-- TOC entry 2706 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.id IS 'identificador do registro';


--
-- TOC entry 2707 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2708 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.ano_safra; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.ano_safra IS 'identificador do ano da safra';


--
-- TOC entry 2709 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.cultivar_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.cultivar_id IS 'identificador da tabela cultivar';


--
-- TOC entry 2710 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.data_alterado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.data_alterado IS 'data em que o rastro do produto foi alterado';


--
-- TOC entry 2711 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.data_criado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.data_criado IS 'data em que o rastro do produto foi criado';


--
-- TOC entry 2712 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.empresa_id IS 'identificador da tabela empresa';


--
-- TOC entry 2713 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.produto_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.produto_id IS 'identificador da tabela produto';


--
-- TOC entry 2714 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.propriedade_id IS 'identificador da tabela propriedade';


--
-- TOC entry 2715 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.situacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.situacao IS 'responsável por determinar se a customização admite alterações';


--
-- TOC entry 2716 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN rastro_produto.talhao_propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN rastro_produto.talhao_propriedade_id IS 'identificador da tabela talhão propriedade';


--
-- TOC entry 228 (class 1259 OID 116267)
-- Name: rastro_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rastro_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2717 (class 0 OID 0)
-- Dependencies: 228
-- Name: rastro_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rastro_produto_id_seq OWNED BY rastro_produto.id;


--
-- TOC entry 231 (class 1259 OID 116279)
-- Name: registro_dados; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE registro_dados (
    id bigint NOT NULL,
    version bigint NOT NULL,
    comentario_atributo character varying(65534),
    data_alterado timestamp without time zone,
    data_criado timestamp without time zone NOT NULL,
    rastro_atributo_id bigint NOT NULL,
    rastro_fase_id bigint NOT NULL,
    rastro_produto_id bigint NOT NULL,
    valor_atributo character varying(128),
    valor_data_atributo timestamp without time zone,
    valor_lista_atributo_id bigint
);


--
-- TOC entry 2718 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE registro_dados; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE registro_dados IS 'Tabela contendo os valores de registro';


--
-- TOC entry 2719 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.id IS 'identificador do registro';


--
-- TOC entry 2720 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2721 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.comentario_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.comentario_atributo IS 'comentário do atributo';


--
-- TOC entry 2722 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.data_alterado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.data_alterado IS 'data em que o rastro do atributo foi alterado';


--
-- TOC entry 2723 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.data_criado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.data_criado IS 'data em que o rastro do atributo foi criado';


--
-- TOC entry 2724 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.rastro_atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.rastro_atributo_id IS 'identificador da tabela rastro atributo';


--
-- TOC entry 2725 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.valor_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.valor_atributo IS 'quando valor do atributo do tipo texto';


--
-- TOC entry 2726 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.valor_data_atributo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.valor_data_atributo IS 'quando atributo for do tipo data';


--
-- TOC entry 2727 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN registro_dados.valor_lista_atributo_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN registro_dados.valor_lista_atributo_id IS 'quando valor do atributo deriva da lista de valores do atributo';


--
-- TOC entry 230 (class 1259 OID 116277)
-- Name: registro_dados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE registro_dados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2728 (class 0 OID 0)
-- Dependencies: 230
-- Name: registro_dados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE registro_dados_id_seq OWNED BY registro_dados.id;


--
-- TOC entry 233 (class 1259 OID 116290)
-- Name: regra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE regra (
    id bigint NOT NULL,
    version bigint NOT NULL,
    authority character varying(64) NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 116288)
-- Name: regra_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2729 (class 0 OID 0)
-- Dependencies: 232
-- Name: regra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regra_id_seq OWNED BY regra.id;


--
-- TOC entry 235 (class 1259 OID 116300)
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
-- TOC entry 2730 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE responsavel_empresa IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2731 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN responsavel_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.id IS 'identificador do registro';


--
-- TOC entry 2732 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN responsavel_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2733 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN responsavel_empresa.ddd_responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.ddd_responsavel_empresa IS 'DDD do telefone do responsável pela empresa contendo 2 caracteres';


--
-- TOC entry 2734 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN responsavel_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.empresa_id IS 'identificador da empresa';


--
-- TOC entry 2735 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN responsavel_empresa.nome_responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.nome_responsavel_empresa IS 'Nome do responsável contendo no máximo 128 caracteres';


--
-- TOC entry 2736 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN responsavel_empresa.numero_telefone_responsavel_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.numero_telefone_responsavel_empresa IS 'Número do Telefone do responsável pela empresa contendo de 8 a 9 caracteres e com valor unico somando o ddd e o numero do telefone';


--
-- TOC entry 2737 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN responsavel_empresa.tipo_responsavel_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_empresa.tipo_responsavel_id IS 'identificador do tipo de responsável';


--
-- TOC entry 234 (class 1259 OID 116298)
-- Name: responsavel_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE responsavel_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2738 (class 0 OID 0)
-- Dependencies: 234
-- Name: responsavel_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE responsavel_empresa_id_seq OWNED BY responsavel_empresa.id;


--
-- TOC entry 237 (class 1259 OID 116310)
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
-- TOC entry 2739 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE responsavel_propriedade IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2740 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN responsavel_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2741 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN responsavel_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2742 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN responsavel_propriedade.ddd_responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.ddd_responsavel_propriedade IS 'DDD do telefone do responsável pela propriedade contendo 2 caracteres';


--
-- TOC entry 2743 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN responsavel_propriedade.nome_responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.nome_responsavel_propriedade IS 'Nome do responsável contendo no máximo 128 caracteres';


--
-- TOC entry 2744 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN responsavel_propriedade.numero_telefone_responsavel_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.numero_telefone_responsavel_propriedade IS 'Número do Telefone do responsável pela propriedade contendo de 8 a 9 caracteres e com valor unico somando o ddd e o numero do telefone';


--
-- TOC entry 2745 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN responsavel_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.propriedade_id IS 'identificador da propriedade';


--
-- TOC entry 2746 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN responsavel_propriedade.tipo_responsavel_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN responsavel_propriedade.tipo_responsavel_id IS 'identificador do tipo de responsável';


--
-- TOC entry 236 (class 1259 OID 116308)
-- Name: responsavel_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE responsavel_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2747 (class 0 OID 0)
-- Dependencies: 236
-- Name: responsavel_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE responsavel_propriedade_id_seq OWNED BY responsavel_propriedade.id;


--
-- TOC entry 239 (class 1259 OID 116320)
-- Name: talhao_propriedade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE talhao_propriedade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_talhao character varying(128) NOT NULL,
    ha_talhao double precision NOT NULL,
    latitude_talhao character varying(11),
    longitude_talhao character varying(11),
    propriedade_id bigint NOT NULL
);


--
-- TOC entry 2748 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE talhao_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE talhao_propriedade IS 'Tabela contendo os Talhoes das Propriedades do sistema';


--
-- TOC entry 2749 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN talhao_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN talhao_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2750 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN talhao_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN talhao_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 238 (class 1259 OID 116318)
-- Name: talhao_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE talhao_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2751 (class 0 OID 0)
-- Dependencies: 238
-- Name: talhao_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE talhao_propriedade_id_seq OWNED BY talhao_propriedade.id;


--
-- TOC entry 241 (class 1259 OID 116328)
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
-- TOC entry 2752 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE telefone_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE telefone_empresa IS 'Tabela contendo os telefones das Empresas do sistema';


--
-- TOC entry 2753 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN telefone_empresa.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.id IS 'identificador do registro';


--
-- TOC entry 2754 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN telefone_empresa.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2755 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN telefone_empresa.ddd_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.ddd_empresa IS 'número do ddd do telefone';


--
-- TOC entry 2756 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN telefone_empresa.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.empresa_id IS 'identificador da tabela empresa';


--
-- TOC entry 2757 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN telefone_empresa.numero_telefone_empresa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_empresa.numero_telefone_empresa IS 'número do telefone';


--
-- TOC entry 240 (class 1259 OID 116326)
-- Name: telefone_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE telefone_empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2758 (class 0 OID 0)
-- Dependencies: 240
-- Name: telefone_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE telefone_empresa_id_seq OWNED BY telefone_empresa.id;


--
-- TOC entry 243 (class 1259 OID 116338)
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
-- TOC entry 2759 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE telefone_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE telefone_propriedade IS 'Tabela contendo os telefones das Propriedades do sistema';


--
-- TOC entry 2760 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN telefone_propriedade.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.id IS 'identificador do registro';


--
-- TOC entry 2761 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN telefone_propriedade.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2762 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN telefone_propriedade.ddd_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.ddd_propriedade IS 'número do ddd do telefone';


--
-- TOC entry 2763 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN telefone_propriedade.numero_telefone_propriedade; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.numero_telefone_propriedade IS 'número do telefone';


--
-- TOC entry 2764 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN telefone_propriedade.propriedade_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN telefone_propriedade.propriedade_id IS 'identificador da tabela propriedade';


--
-- TOC entry 242 (class 1259 OID 116336)
-- Name: telefone_propriedade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE telefone_propriedade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2765 (class 0 OID 0)
-- Dependencies: 242
-- Name: telefone_propriedade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE telefone_propriedade_id_seq OWNED BY telefone_propriedade.id;


--
-- TOC entry 245 (class 1259 OID 116348)
-- Name: tipo_certificacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_certificacao (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_certificacao character varying(128) NOT NULL
);


--
-- TOC entry 2766 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE tipo_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE tipo_certificacao IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2767 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN tipo_certificacao.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_certificacao.id IS 'identificador do registro';


--
-- TOC entry 2768 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN tipo_certificacao.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_certificacao.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2769 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN tipo_certificacao.descricao_tipo_certificacao; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_certificacao.descricao_tipo_certificacao IS 'Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único';


--
-- TOC entry 244 (class 1259 OID 116346)
-- Name: tipo_certificacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_certificacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2770 (class 0 OID 0)
-- Dependencies: 244
-- Name: tipo_certificacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_certificacao_id_seq OWNED BY tipo_certificacao.id;


--
-- TOC entry 247 (class 1259 OID 116356)
-- Name: tipo_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_produto (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_produto character varying(128) NOT NULL
);


--
-- TOC entry 2771 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE tipo_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE tipo_produto IS 'Tabela contendo os Tipos de Produtos ';


--
-- TOC entry 2772 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN tipo_produto.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_produto.id IS 'identificador do registro';


--
-- TOC entry 2773 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN tipo_produto.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_produto.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2774 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN tipo_produto.descricao_tipo_produto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_produto.descricao_tipo_produto IS 'Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único';


--
-- TOC entry 246 (class 1259 OID 116354)
-- Name: tipo_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2775 (class 0 OID 0)
-- Dependencies: 246
-- Name: tipo_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_produto_id_seq OWNED BY tipo_produto.id;


--
-- TOC entry 249 (class 1259 OID 116364)
-- Name: tipo_responsavel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_responsavel (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_responsavel character varying(128) NOT NULL
);


--
-- TOC entry 2776 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE tipo_responsavel; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE tipo_responsavel IS 'Tabela contendo as Cidades por Estado';


--
-- TOC entry 2777 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN tipo_responsavel.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_responsavel.id IS 'identificador do registro';


--
-- TOC entry 2778 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN tipo_responsavel.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_responsavel.version IS 'versionamento do registro e controle de concorrência';


--
-- TOC entry 2779 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN tipo_responsavel.descricao_tipo_responsavel; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN tipo_responsavel.descricao_tipo_responsavel IS 'Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único';


--
-- TOC entry 248 (class 1259 OID 116362)
-- Name: tipo_responsavel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_responsavel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2780 (class 0 OID 0)
-- Dependencies: 248
-- Name: tipo_responsavel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_responsavel_id_seq OWNED BY tipo_responsavel.id;


--
-- TOC entry 2199 (class 2604 OID 116032)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso ALTER COLUMN id SET DEFAULT nextval('acesso_id_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 116055)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo ALTER COLUMN id SET DEFAULT nextval('atributo_id_seq'::regclass);


--
-- TOC entry 2201 (class 2604 OID 116068)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audit_log_event ALTER COLUMN id SET DEFAULT nextval('audit_log_event_id_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 116079)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa ALTER COLUMN id SET DEFAULT nextval('certificacao_empresa_id_seq'::regclass);


--
-- TOC entry 2203 (class 2604 OID 116090)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade ALTER COLUMN id SET DEFAULT nextval('certificacao_propriedade_id_seq'::regclass);


--
-- TOC entry 2204 (class 2604 OID 116101)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade ALTER COLUMN id SET DEFAULT nextval('cidade_id_seq'::regclass);


--
-- TOC entry 2205 (class 2604 OID 116109)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY consolidacao ALTER COLUMN id SET DEFAULT nextval('consolidacao_id_seq'::regclass);


--
-- TOC entry 2206 (class 2604 OID 116120)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar ALTER COLUMN id SET DEFAULT nextval('cultivar_id_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 116130)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresa ALTER COLUMN id SET DEFAULT nextval('empresa_id_seq'::regclass);


--
-- TOC entry 2208 (class 2604 OID 116141)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado ALTER COLUMN id SET DEFAULT nextval('estado_id_seq'::regclass);


--
-- TOC entry 2209 (class 2604 OID 116149)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase ALTER COLUMN id SET DEFAULT nextval('fase_id_seq'::regclass);


--
-- TOC entry 2210 (class 2604 OID 116162)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_empresa ALTER COLUMN id SET DEFAULT nextval('foto_empresa_id_seq'::regclass);


--
-- TOC entry 2211 (class 2604 OID 116173)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_propriedade ALTER COLUMN id SET DEFAULT nextval('foto_propriedade_id_seq'::regclass);


--
-- TOC entry 2212 (class 2604 OID 116184)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_talhao_propriedade ALTER COLUMN id SET DEFAULT nextval('foto_talhao_propriedade_id_seq'::regclass);


--
-- TOC entry 2213 (class 2604 OID 116195)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo ALTER COLUMN id SET DEFAULT nextval('lista_atributo_id_seq'::regclass);


--
-- TOC entry 2214 (class 2604 OID 116205)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lote ALTER COLUMN id SET DEFAULT nextval('lote_id_seq'::regclass);


--
-- TOC entry 2215 (class 2604 OID 116216)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais ALTER COLUMN id SET DEFAULT nextval('pais_id_seq'::regclass);


--
-- TOC entry 2216 (class 2604 OID 116224)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissao ALTER COLUMN id SET DEFAULT nextval('permissao_id_seq'::regclass);


--
-- TOC entry 2217 (class 2604 OID 116234)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto ALTER COLUMN id SET DEFAULT nextval('produto_id_seq'::regclass);


--
-- TOC entry 2218 (class 2604 OID 116245)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY propriedade ALTER COLUMN id SET DEFAULT nextval('propriedade_id_seq'::regclass);


--
-- TOC entry 2219 (class 2604 OID 116256)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo ALTER COLUMN id SET DEFAULT nextval('rastro_atributo_id_seq'::regclass);


--
-- TOC entry 2220 (class 2604 OID 116264)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase ALTER COLUMN id SET DEFAULT nextval('rastro_fase_id_seq'::regclass);


--
-- TOC entry 2221 (class 2604 OID 116272)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto ALTER COLUMN id SET DEFAULT nextval('rastro_produto_id_seq'::regclass);


--
-- TOC entry 2222 (class 2604 OID 116282)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY registro_dados ALTER COLUMN id SET DEFAULT nextval('registro_dados_id_seq'::regclass);


--
-- TOC entry 2223 (class 2604 OID 116293)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regra ALTER COLUMN id SET DEFAULT nextval('regra_id_seq'::regclass);


--
-- TOC entry 2224 (class 2604 OID 116303)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa ALTER COLUMN id SET DEFAULT nextval('responsavel_empresa_id_seq'::regclass);


--
-- TOC entry 2225 (class 2604 OID 116313)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade ALTER COLUMN id SET DEFAULT nextval('responsavel_propriedade_id_seq'::regclass);


--
-- TOC entry 2226 (class 2604 OID 116323)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_propriedade ALTER COLUMN id SET DEFAULT nextval('talhao_propriedade_id_seq'::regclass);


--
-- TOC entry 2227 (class 2604 OID 116331)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa ALTER COLUMN id SET DEFAULT nextval('telefone_empresa_id_seq'::regclass);


--
-- TOC entry 2228 (class 2604 OID 116341)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade ALTER COLUMN id SET DEFAULT nextval('telefone_propriedade_id_seq'::regclass);


--
-- TOC entry 2229 (class 2604 OID 116351)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_certificacao ALTER COLUMN id SET DEFAULT nextval('tipo_certificacao_id_seq'::regclass);


--
-- TOC entry 2230 (class 2604 OID 116359)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_produto ALTER COLUMN id SET DEFAULT nextval('tipo_produto_id_seq'::regclass);


--
-- TOC entry 2231 (class 2604 OID 116367)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_responsavel ALTER COLUMN id SET DEFAULT nextval('tipo_responsavel_id_seq'::regclass);


--
-- TOC entry 2487 (class 0 OID 116029)
-- Dependencies: 182
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO acesso (id, version, account_expired, account_locked, email, enabled, password, password_expired, username) VALUES (1, 5, false, false, 'claudioagner@hotmail.com', true, '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', false, 'admin');
INSERT INTO acesso (id, version, account_expired, account_locked, email, enabled, password, password_expired, username) VALUES (2, 0, false, false, 'teste3@teste.com.br', true, 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', false, 'empresa3');


--
-- TOC entry 2488 (class 0 OID 116035)
-- Dependencies: 183
-- Data for Name: acesso_empresas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO acesso_empresas (empresa_id, acesso_id) VALUES (1, 1);
INSERT INTO acesso_empresas (empresa_id, acesso_id) VALUES (2, 1);


--
-- TOC entry 2781 (class 0 OID 0)
-- Dependencies: 181
-- Name: acesso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('acesso_id_seq', 2, true);


--
-- TOC entry 2489 (class 0 OID 116040)
-- Dependencies: 184
-- Data for Name: acesso_propriedades; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2490 (class 0 OID 116045)
-- Dependencies: 185
-- Data for Name: acesso_regra; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO acesso_regra (regra_id, acesso_id) VALUES (1, 1);
INSERT INTO acesso_regra (regra_id, acesso_id) VALUES (2, 2);


--
-- TOC entry 2492 (class 0 OID 116052)
-- Dependencies: 187
-- Data for Name: atributo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2782 (class 0 OID 0)
-- Dependencies: 186
-- Name: atributo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('atributo_id_seq', 1, false);


--
-- TOC entry 2494 (class 0 OID 116065)
-- Dependencies: 189
-- Data for Name: audit_log_event; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (1, 'system', 'Regra', '2016-05-11 10:50:48.885', 'INSERT', '2016-05-11 10:50:48.885', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (2, 'system', 'Regra', '2016-05-11 10:50:50.573', 'INSERT', '2016-05-11 10:50:50.573', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (3, 'system', 'Regra', '2016-05-11 10:50:50.573', 'INSERT', '2016-05-11 10:50:50.573', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (4, 'system', 'Regra', '2016-05-11 10:50:50.589', 'INSERT', '2016-05-11 10:50:50.589', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (5, 'system', 'Regra', '2016-05-11 10:50:50.604', 'INSERT', '2016-05-11 10:50:50.604', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (6, 'system', 'Acesso', '2016-05-11 10:50:50.651', 'INSERT', '2016-05-11 10:50:50.651', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (7, 'system', 'AcessoRegra', '2016-05-11 10:50:50.714', 'INSERT', '2016-05-11 10:50:50.714', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (8, 'system', 'Permissao', '2016-05-11 10:50:50.729', 'INSERT', '2016-05-11 10:50:50.729', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (9, 'system', 'Permissao', '2016-05-11 10:50:50.745', 'INSERT', '2016-05-11 10:50:50.745', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (10, 'system', 'Permissao', '2016-05-11 10:50:50.745', 'INSERT', '2016-05-11 10:50:50.745', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (11, 'system', 'Permissao', '2016-05-11 10:50:50.76', 'INSERT', '2016-05-11 10:50:50.76', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (12, 'system', 'Permissao', '2016-05-11 10:50:50.776', 'INSERT', '2016-05-11 10:50:50.776', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (13, 'system', 'Permissao', '2016-05-11 10:50:50.776', 'INSERT', '2016-05-11 10:50:50.776', NULL, NULL, '6', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (14, 'system', 'Permissao', '2016-05-11 10:50:50.792', 'INSERT', '2016-05-11 10:50:50.792', NULL, NULL, '7', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (15, 'system', 'Permissao', '2016-05-11 10:50:50.807', 'INSERT', '2016-05-11 10:50:50.807', NULL, NULL, '8', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (16, 'system', 'Permissao', '2016-05-11 10:50:50.807', 'INSERT', '2016-05-11 10:50:50.807', NULL, NULL, '9', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (17, 'system', 'Permissao', '2016-05-11 10:50:50.823', 'INSERT', '2016-05-11 10:50:50.823', NULL, NULL, '10', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (18, 'system', 'Permissao', '2016-05-11 10:50:50.839', 'INSERT', '2016-05-11 10:50:50.839', NULL, NULL, '11', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (19, 'system', 'Permissao', '2016-05-11 10:50:50.839', 'INSERT', '2016-05-11 10:50:50.839', NULL, NULL, '12', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (20, 'system', 'Permissao', '2016-05-11 10:50:50.854', 'INSERT', '2016-05-11 10:50:50.854', NULL, NULL, '13', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (21, 'system', 'Permissao', '2016-05-11 10:50:50.87', 'INSERT', '2016-05-11 10:50:50.87', NULL, NULL, '14', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (22, 'system', 'Permissao', '2016-05-11 10:50:50.87', 'INSERT', '2016-05-11 10:50:50.87', NULL, NULL, '15', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (23, 'system', 'Permissao', '2016-05-11 10:50:50.885', 'INSERT', '2016-05-11 10:50:50.885', NULL, NULL, '16', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (24, 'system', 'Permissao', '2016-05-11 10:50:50.901', 'INSERT', '2016-05-11 10:50:50.901', NULL, NULL, '17', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (25, 'system', 'Permissao', '2016-05-11 10:50:50.917', 'INSERT', '2016-05-11 10:50:50.917', NULL, NULL, '18', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (26, 'system', 'Permissao', '2016-05-11 10:50:50.932', 'INSERT', '2016-05-11 10:50:50.932', NULL, NULL, '19', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (27, 'system', 'Permissao', '2016-05-11 10:50:50.932', 'INSERT', '2016-05-11 10:50:50.932', NULL, NULL, '20', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (28, 'system', 'Permissao', '2016-05-11 10:50:50.948', 'INSERT', '2016-05-11 10:50:50.948', NULL, NULL, '21', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (29, 'system', 'Permissao', '2016-05-11 10:50:50.948', 'INSERT', '2016-05-11 10:50:50.948', NULL, NULL, '22', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (30, 'system', 'Permissao', '2016-05-11 10:50:50.964', 'INSERT', '2016-05-11 10:50:50.964', NULL, NULL, '23', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (31, 'system', 'Permissao', '2016-05-11 10:50:50.979', 'INSERT', '2016-05-11 10:50:50.979', NULL, NULL, '24', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (32, 'system', 'Permissao', '2016-05-11 10:50:50.979', 'INSERT', '2016-05-11 10:50:50.979', NULL, NULL, '25', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (33, 'system', 'Permissao', '2016-05-11 10:50:50.995', 'INSERT', '2016-05-11 10:50:50.995', NULL, NULL, '26', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (34, 'system', 'Permissao', '2016-05-11 10:50:50.995', 'INSERT', '2016-05-11 10:50:50.995', NULL, NULL, '27', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (35, 'system', 'Permissao', '2016-05-11 10:50:51.01', 'INSERT', '2016-05-11 10:50:51.01', NULL, NULL, '28', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (36, 'system', 'Permissao', '2016-05-11 10:50:51.026', 'INSERT', '2016-05-11 10:50:51.026', NULL, NULL, '29', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (37, 'system', 'Permissao', '2016-05-11 10:50:51.026', 'INSERT', '2016-05-11 10:50:51.026', NULL, NULL, '30', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (38, 'system', 'Permissao', '2016-05-11 10:50:51.042', 'INSERT', '2016-05-11 10:50:51.042', NULL, NULL, '31', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (39, 'system', 'Permissao', '2016-05-11 10:50:51.042', 'INSERT', '2016-05-11 10:50:51.042', NULL, NULL, '32', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (40, 'system', 'Permissao', '2016-05-11 10:50:51.057', 'INSERT', '2016-05-11 10:50:51.057', NULL, NULL, '33', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (41, 'system', 'Permissao', '2016-05-11 10:50:51.057', 'INSERT', '2016-05-11 10:50:51.057', NULL, NULL, '34', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (42, 'admin', 'Empresa', '2016-05-11 10:59:46.894', 'INSERT', '2016-05-11 10:59:46.894', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (43, 'admin', 'Acesso', '2016-05-11 10:59:47.026', 'UPDATE', '2016-05-11 10:59:47.026', '[EMPRESA TESTE 1]', '[]', '1', 1, 'empresas', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (44, 'admin', 'Empresa', '2016-05-11 11:01:13.981', 'INSERT', '2016-05-11 11:01:13.981', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (45, 'admin', 'AcessoRegra', '2016-05-11 11:02:40.731', 'INSERT', '2016-05-11 11:02:40.731', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (46, 'admin', 'AcessoRegra', '2016-05-11 11:03:50.282', 'INSERT', '2016-05-11 11:03:50.282', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (47, 'admin', 'AcessoRegra', '2016-05-11 11:04:45.14', 'INSERT', '2016-05-11 11:04:45.14', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (48, 'admin', 'Empresa', '2016-05-11 11:04:45.176', 'UPDATE', '2016-05-11 11:04:45.176', '[admin]', '[]', '1', 1, 'acessos', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (49, 'admin', 'Empresa', '2016-05-11 11:04:45.196', 'UPDATE', '2016-05-11 11:04:45.196', '[admin]', '[]', '2', 1, 'acessos', NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (50, 'system', 'Acesso', '2016-05-11 11:28:59.955', 'INSERT', '2016-05-11 11:28:59.955', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (51, 'system', 'AcessoRegra', '2016-05-11 11:28:59.979', 'INSERT', '2016-05-11 11:28:59.979', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (52, 'system', 'Permissao', '2016-05-11 18:31:09.16', 'INSERT', '2016-05-11 18:31:09.16', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (53, 'system', 'Permissao', '2016-05-11 18:31:09.269', 'INSERT', '2016-05-11 18:31:09.269', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (54, 'system', 'Permissao', '2016-05-11 18:31:09.285', 'INSERT', '2016-05-11 18:31:09.285', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (55, 'system', 'Permissao', '2016-05-11 18:31:09.3', 'INSERT', '2016-05-11 18:31:09.3', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (56, 'system', 'Permissao', '2016-05-11 18:31:09.316', 'INSERT', '2016-05-11 18:31:09.316', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (57, 'system', 'Permissao', '2016-05-11 18:31:09.331', 'INSERT', '2016-05-11 18:31:09.331', NULL, NULL, '6', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (58, 'system', 'Permissao', '2016-05-11 18:31:09.347', 'INSERT', '2016-05-11 18:31:09.347', NULL, NULL, '7', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (59, 'system', 'Permissao', '2016-05-11 18:31:09.363', 'INSERT', '2016-05-11 18:31:09.363', NULL, NULL, '8', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (60, 'system', 'Permissao', '2016-05-11 18:31:09.378', 'INSERT', '2016-05-11 18:31:09.378', NULL, NULL, '9', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (61, 'system', 'Permissao', '2016-05-11 18:31:09.394', 'INSERT', '2016-05-11 18:31:09.394', NULL, NULL, '10', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (62, 'system', 'Permissao', '2016-05-11 18:31:09.41', 'INSERT', '2016-05-11 18:31:09.41', NULL, NULL, '11', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (63, 'system', 'Permissao', '2016-05-11 18:31:09.41', 'INSERT', '2016-05-11 18:31:09.41', NULL, NULL, '12', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (64, 'system', 'Permissao', '2016-05-11 18:31:09.425', 'INSERT', '2016-05-11 18:31:09.425', NULL, NULL, '13', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (65, 'system', 'Permissao', '2016-05-11 18:31:09.441', 'INSERT', '2016-05-11 18:31:09.441', NULL, NULL, '14', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (66, 'system', 'Permissao', '2016-05-11 18:31:09.441', 'INSERT', '2016-05-11 18:31:09.441', NULL, NULL, '15', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (67, 'system', 'Permissao', '2016-05-11 18:31:09.456', 'INSERT', '2016-05-11 18:31:09.456', NULL, NULL, '16', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (68, 'system', 'Permissao', '2016-05-11 18:31:09.472', 'INSERT', '2016-05-11 18:31:09.472', NULL, NULL, '17', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (69, 'system', 'Permissao', '2016-05-11 18:31:09.488', 'INSERT', '2016-05-11 18:31:09.488', NULL, NULL, '18', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (70, 'system', 'Permissao', '2016-05-11 18:31:09.503', 'INSERT', '2016-05-11 18:31:09.503', NULL, NULL, '19', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (71, 'system', 'Permissao', '2016-05-11 18:31:09.519', 'INSERT', '2016-05-11 18:31:09.519', NULL, NULL, '20', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (72, 'system', 'Permissao', '2016-05-11 18:31:09.519', 'INSERT', '2016-05-11 18:31:09.519', NULL, NULL, '21', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (73, 'system', 'Permissao', '2016-05-11 18:31:09.535', 'INSERT', '2016-05-11 18:31:09.535', NULL, NULL, '22', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (74, 'system', 'Permissao', '2016-05-11 18:31:09.55', 'INSERT', '2016-05-11 18:31:09.55', NULL, NULL, '23', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (75, 'system', 'Permissao', '2016-05-11 18:31:09.566', 'INSERT', '2016-05-11 18:31:09.566', NULL, NULL, '24', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (76, 'system', 'Permissao', '2016-05-11 18:31:09.581', 'INSERT', '2016-05-11 18:31:09.581', NULL, NULL, '25', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (77, 'system', 'Permissao', '2016-05-11 18:31:09.597', 'INSERT', '2016-05-11 18:31:09.597', NULL, NULL, '26', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (78, 'system', 'Permissao', '2016-05-11 18:31:09.613', 'INSERT', '2016-05-11 18:31:09.613', NULL, NULL, '27', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (79, 'system', 'Permissao', '2016-05-11 18:31:09.613', 'INSERT', '2016-05-11 18:31:09.613', NULL, NULL, '28', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (80, 'system', 'Permissao', '2016-05-11 18:31:09.628', 'INSERT', '2016-05-11 18:31:09.628', NULL, NULL, '29', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (81, 'system', 'Permissao', '2016-05-11 18:31:09.644', 'INSERT', '2016-05-11 18:31:09.644', NULL, NULL, '30', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (82, 'system', 'Permissao', '2016-05-11 18:31:09.644', 'INSERT', '2016-05-11 18:31:09.644', NULL, NULL, '31', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (83, 'system', 'Permissao', '2016-05-11 18:31:09.66', 'INSERT', '2016-05-11 18:31:09.66', NULL, NULL, '32', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (84, 'system', 'Permissao', '2016-05-11 18:31:09.675', 'INSERT', '2016-05-11 18:31:09.675', NULL, NULL, '33', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (85, 'system', 'Permissao', '2016-05-11 18:31:09.675', 'INSERT', '2016-05-11 18:31:09.675', NULL, NULL, '34', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (86, 'system', 'Permissao', '2016-05-11 18:31:09.691', 'INSERT', '2016-05-11 18:31:09.691', NULL, NULL, '35', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (87, 'system', 'Permissao', '2016-05-11 18:31:09.706', 'INSERT', '2016-05-11 18:31:09.706', NULL, NULL, '36', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (88, 'system', 'Permissao', '2016-05-11 18:31:09.706', 'INSERT', '2016-05-11 18:31:09.706', NULL, NULL, '37', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (89, 'system', 'Permissao', '2016-05-11 18:31:09.722', 'INSERT', '2016-05-11 18:31:09.722', NULL, NULL, '38', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (90, 'system', 'Permissao', '2016-05-11 18:31:09.722', 'INSERT', '2016-05-11 18:31:09.722', NULL, NULL, '39', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (91, 'system', 'Permissao', '2016-05-11 18:31:09.738', 'INSERT', '2016-05-11 18:31:09.738', NULL, NULL, '40', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (92, 'system', 'Permissao', '2016-05-11 18:31:09.753', 'INSERT', '2016-05-11 18:31:09.753', NULL, NULL, '41', 0, NULL, NULL);
INSERT INTO audit_log_event (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (93, 'system', 'Permissao', '2016-05-11 18:31:09.753', 'INSERT', '2016-05-11 18:31:09.753', NULL, NULL, '42', 0, NULL, NULL);


--
-- TOC entry 2783 (class 0 OID 0)
-- Dependencies: 188
-- Name: audit_log_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('audit_log_event_id_seq', 93, true);


--
-- TOC entry 2496 (class 0 OID 116076)
-- Dependencies: 191
-- Data for Name: certificacao_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2784 (class 0 OID 0)
-- Dependencies: 190
-- Name: certificacao_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('certificacao_empresa_id_seq', 1, false);


--
-- TOC entry 2498 (class 0 OID 116087)
-- Dependencies: 193
-- Data for Name: certificacao_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2785 (class 0 OID 0)
-- Dependencies: 192
-- Name: certificacao_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('certificacao_propriedade_id_seq', 1, false);


--
-- TOC entry 2500 (class 0 OID 116098)
-- Dependencies: 195
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
-- TOC entry 2786 (class 0 OID 0)
-- Dependencies: 194
-- Name: cidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cidade_id_seq', 400, false);


--
-- TOC entry 2502 (class 0 OID 116106)
-- Dependencies: 197
-- Data for Name: consolidacao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2787 (class 0 OID 0)
-- Dependencies: 196
-- Name: consolidacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('consolidacao_id_seq', 1, false);


--
-- TOC entry 2504 (class 0 OID 116117)
-- Dependencies: 199
-- Data for Name: cultivar; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2788 (class 0 OID 0)
-- Dependencies: 198
-- Name: cultivar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cultivar_id_seq', 1, false);


--
-- TOC entry 2506 (class 0 OID 116127)
-- Dependencies: 201
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO empresa (id, version, bairro_empresa, cep_empresa, cidade_id, cnpj, complemento_empresa, cpf, email_empresa, logradouro_empresa, nome_empresa, nome_fantasia_empresa, numero_empresa, tipo_empresa) VALUES (1, 1, 'JARDIM BOA VISTA', '84070-470', 225, NULL, 'CASA', '864.121.972-22', 'teste1@teste.com.br', 'THEODORO GUIMARÃES', 'EMPRESA TESTE 1', 'EMPRESA TESTE 1', '255', 'Pessoa Física');
INSERT INTO empresa (id, version, bairro_empresa, cep_empresa, cidade_id, cnpj, complemento_empresa, cpf, email_empresa, logradouro_empresa, nome_empresa, nome_fantasia_empresa, numero_empresa, tipo_empresa) VALUES (2, 1, 'NOVA RÚSSIA', '84010-100', 225, NULL, 'PRÉDIO', '823.212.645-00', 'teste2@teste.com.br', 'AVENIDA ERNESTO VILELA', 'EMPRESA TESTE 2', 'EMPRESA TESTE 2', 'S/N', 'Pessoa Física');


--
-- TOC entry 2789 (class 0 OID 0)
-- Dependencies: 200
-- Name: empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('empresa_id_seq', 2, true);


--
-- TOC entry 2508 (class 0 OID 116138)
-- Dependencies: 203
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
-- TOC entry 2790 (class 0 OID 0)
-- Dependencies: 202
-- Name: estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('estado_id_seq', 28, false);


--
-- TOC entry 2510 (class 0 OID 116146)
-- Dependencies: 205
-- Data for Name: fase; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2791 (class 0 OID 0)
-- Dependencies: 204
-- Name: fase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('fase_id_seq', 1, false);


--
-- TOC entry 2512 (class 0 OID 116159)
-- Dependencies: 207
-- Data for Name: foto_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2792 (class 0 OID 0)
-- Dependencies: 206
-- Name: foto_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('foto_empresa_id_seq', 1, false);


--
-- TOC entry 2514 (class 0 OID 116170)
-- Dependencies: 209
-- Data for Name: foto_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2793 (class 0 OID 0)
-- Dependencies: 208
-- Name: foto_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('foto_propriedade_id_seq', 1, false);


--
-- TOC entry 2516 (class 0 OID 116181)
-- Dependencies: 211
-- Data for Name: foto_talhao_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2794 (class 0 OID 0)
-- Dependencies: 210
-- Name: foto_talhao_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('foto_talhao_propriedade_id_seq', 1, false);


--
-- TOC entry 2518 (class 0 OID 116192)
-- Dependencies: 213
-- Data for Name: lista_atributo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2795 (class 0 OID 0)
-- Dependencies: 212
-- Name: lista_atributo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lista_atributo_id_seq', 1, false);


--
-- TOC entry 2520 (class 0 OID 116202)
-- Dependencies: 215
-- Data for Name: lote; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2796 (class 0 OID 0)
-- Dependencies: 214
-- Name: lote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lote_id_seq', 1, false);


--
-- TOC entry 2522 (class 0 OID 116213)
-- Dependencies: 217
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
-- TOC entry 2797 (class 0 OID 0)
-- Dependencies: 216
-- Name: pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pais_id_seq', 253, false);


--
-- TOC entry 2524 (class 0 OID 116221)
-- Dependencies: 219
-- Data for Name: permissao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO permissao (id, version, config_attribute, url) VALUES (1, 0, 'ROLE_ADMINISTRADOR, ROLE_EMPRESA', '/acesso/edit/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (2, 0, 'ROLE_ADMINISTRADOR, ROLE_EMPRESA', '/acesso/show/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (3, 0, 'ROLE_ADMINISTRADOR, ROLE_EMPRESA', '/acesso/list/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (4, 0, 'ROLE_ADMINISTRADOR, ROLE_EMPRESA', '/acesso/create/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (5, 0, 'ROLE_ADMINISTRADOR', '/regra/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (6, 0, 'ROLE_ADMINISTRADOR', '/permissao/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (7, 0, 'ROLE_ADMINISTRADOR', '/auditLogEvent/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (8, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/empresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (9, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/certificacaoEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (10, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/fotoEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (11, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/responsavelEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (12, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/telefoneEmpresa/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (13, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/propriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (14, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/certificacaoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (15, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/fotoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (16, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/responsavelPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (17, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/talhaoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (18, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/fotoTalhaoPropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (19, 0, 'ROLE_ADMINISTRADOR,ROLE_EMPRESA', '/telefonePropriedade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (20, 0, 'ROLE_ADMINISTRADOR', '/cidade/create/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (21, 0, 'ROLE_ADMINISTRADOR', '/cidade/edit/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (22, 0, 'ROLE_ADMINISTRADOR', '/cidade/show/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (23, 0, 'ROLE_ADMINISTRADOR', '/cidade/list/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (24, 0, 'ROLE_ADMINISTRADOR, ROLE_EMPRESA', '/cidade/ajaxGetCidade/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (25, 0, 'ROLE_ADMINISTRADOR', '/estado/create/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (26, 0, 'ROLE_ADMINISTRADOR', '/estado/edit/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (27, 0, 'ROLE_ADMINISTRADOR', '/estado/show/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (28, 0, 'ROLE_ADMINISTRADOR', '/estado/list/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (29, 0, 'ROLE_ADMINISTRADOR, ROLE_EMPRESA', '/estado/ajaxGetEstado/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (30, 0, 'ROLE_ADMINISTRADOR', '/pais/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (31, 0, 'ROLE_ADMINISTRADOR', '/atributo/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (32, 0, 'ROLE_ADMINISTRADOR', '/cultivar/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (33, 0, 'ROLE_ADMINISTRADOR', '/fase/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (34, 0, 'ROLE_ADMINISTRADOR', '/listaAtributo/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (35, 0, 'ROLE_ADMINISTRADOR', '/produto/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (36, 0, 'ROLE_ADMINISTRADOR', '/rastroProduto/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (37, 0, 'ROLE_ADMINISTRADOR', '/registroDados/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (38, 0, 'ROLE_ADMINISTRADOR', '/tipoProduto/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (39, 0, 'ROLE_ADMINISTRADOR', '/tipoCertificacao/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (40, 0, 'ROLE_ADMINISTRADOR', '/tipoResponsavel/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (41, 0, 'ROLE_ADMINISTRADOR', '/lote/**');
INSERT INTO permissao (id, version, config_attribute, url) VALUES (42, 0, 'ROLE_ADMINISTRADOR', '/consolidacao/**');


--
-- TOC entry 2798 (class 0 OID 0)
-- Dependencies: 218
-- Name: permissao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('permissao_id_seq', 42, true);


--
-- TOC entry 2526 (class 0 OID 116231)
-- Dependencies: 221
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (1, 0, 'ABACATE', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (2, 0, 'ABACAXI', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (3, 0, 'ABIU', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (4, 0, 'ATEMÓIA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (5, 0, 'BANANA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (6, 0, 'BLUEBERRY OU MIRTILO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (7, 0, 'CACAU', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (8, 0, 'CAJÁ', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (9, 0, 'CAJU', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (10, 0, 'CAMBUCI', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (11, 0, 'CAQUI', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (12, 0, 'CARAMBOLA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (13, 0, 'CEREJA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (14, 0, 'CHIRIMOYA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (15, 0, 'CIDRA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (16, 0, 'COCO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (17, 0, 'CUPUAÇU', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (18, 0, 'DAMASCO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (19, 0, 'FRAMBOESA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (20, 0, 'FRUTA PÃO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (21, 0, 'GOIABA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (22, 0, 'GRAPEFRUIT', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (23, 0, 'GRAVIOLA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (24, 0, 'JABUTICABA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (25, 0, 'JACA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (26, 0, 'JAMBO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (27, 0, 'JENIPAPO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (28, 0, 'KINO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (29, 0, 'KIWI', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (30, 0, 'LARANJA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (31, 0, 'LICHIA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (32, 1, 'LIMA DA PÉRSIA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (33, 0, 'LIMÃO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (34, 0, 'MAÇÃ', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (35, 0, 'MAMÃO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (36, 0, 'MANGA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (37, 0, 'MARACUJÁ', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (38, 0, 'MARMELO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (39, 0, 'MELÂNCIA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (40, 0, 'MELÃO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (41, 0, 'MEXERICA OU TANGERINA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (42, 0, 'MORANGO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (43, 0, 'NECTARINA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (44, 0, 'NÊSPERA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (45, 0, 'PERA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (46, 0, 'PÊSSEGO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (47, 0, 'PHYSALIS', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (48, 0, 'PITANGA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (49, 0, 'RAMBUTAM', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (50, 0, 'ROMÃ', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (51, 0, 'SAPOTI', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (52, 0, 'SERIGUELA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (53, 1, 'TAMARINDO', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (54, 0, 'TOMAT', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (55, 0, 'UMBU', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (56, 0, 'UVA ROXA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (57, 0, 'UVA VERD', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (58, 0, 'UVA VERMELHA', NULL, 3);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (59, 0, 'ABÓBORA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (61, 0, 'AIPIM', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (62, 0, 'ALHO', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (63, 0, 'ASPARGO', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (64, 0, 'BATATA BAROA OU MANDIOQUINHA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (67, 0, 'BATATA INGLESA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (60, 1, 'ABOBRINHA VERDE', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (65, 1, 'BATATA DOCE', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (68, 0, 'BATATA YACOM', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (69, 0, 'BERINJELA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (70, 0, 'BETERRABA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (71, 0, 'BRÓCOLIS', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (72, 0, 'CARÁ', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (73, 0, 'CEBOLA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (74, 0, 'CENOURA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (75, 0, 'CHUCHU', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (76, 0, 'COUVE-FLOR', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (77, 0, 'ERVILHA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (78, 0, 'INHAME', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (79, 0, 'JILÓ', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (80, 0, 'MAXIXE', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (81, 0, 'MILHO', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (82, 0, 'NABO', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (83, 0, 'PALMITO PUPUNHA', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (84, 0, 'PEPINO', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (85, 0, 'PIMENTÃO', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (86, 0, 'QUIABO', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (87, 0, 'RABANETE', NULL, 2);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (88, 0, 'AGRIÃO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (89, 0, 'AIPO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (90, 0, 'ALECRIM', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (91, 0, 'ALFACE', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (92, 0, 'ALHO-PORÓ', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (93, 0, 'ALMEIRÃO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (94, 0, 'BROTO DE ALFAFA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (95, 0, 'BROTO DE FEIJÃO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (96, 0, 'BROTO DE LENTILHA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (97, 0, 'BROTO DE TREVO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (98, 0, 'CEBOLINHA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (99, 0, 'CHICÓRIA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (100, 0, 'COENTRO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (101, 0, 'COUVE', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (102, 0, 'COUVE CHINESA OU ACELGA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (103, 0, 'COUVE DE BRUXELAS', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (104, 0, 'ENDÍVIA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (105, 0, 'ESPINAFRE', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (106, 0, 'HORTELÃ', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (107, 0, 'MANJERICÃO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (108, 0, 'MOSTARDA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (109, 0, 'REPOLHO', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (110, 0, 'SALSA', NULL, 1);
INSERT INTO produto (id, version, descricao_produto, observacao_produto, tipo_produto_id) VALUES (111, 0, 'TOMILHO', NULL, 1);


--
-- TOC entry 2799 (class 0 OID 0)
-- Dependencies: 220
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('produto_id_seq', 112, false);


--
-- TOC entry 2528 (class 0 OID 116242)
-- Dependencies: 223
-- Data for Name: propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2800 (class 0 OID 0)
-- Dependencies: 222
-- Name: propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('propriedade_id_seq', 1, false);


--
-- TOC entry 2530 (class 0 OID 116253)
-- Dependencies: 225
-- Data for Name: rastro_atributo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2801 (class 0 OID 0)
-- Dependencies: 224
-- Name: rastro_atributo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('rastro_atributo_id_seq', 1, false);


--
-- TOC entry 2532 (class 0 OID 116261)
-- Dependencies: 227
-- Data for Name: rastro_fase; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2802 (class 0 OID 0)
-- Dependencies: 226
-- Name: rastro_fase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('rastro_fase_id_seq', 1, false);


--
-- TOC entry 2534 (class 0 OID 116269)
-- Dependencies: 229
-- Data for Name: rastro_produto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2803 (class 0 OID 0)
-- Dependencies: 228
-- Name: rastro_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('rastro_produto_id_seq', 1, false);


--
-- TOC entry 2536 (class 0 OID 116279)
-- Dependencies: 231
-- Data for Name: registro_dados; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2804 (class 0 OID 0)
-- Dependencies: 230
-- Name: registro_dados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('registro_dados_id_seq', 1, false);


--
-- TOC entry 2538 (class 0 OID 116290)
-- Dependencies: 233
-- Data for Name: regra; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO regra (id, version, authority) VALUES (1, 0, 'ROLE_ADMINISTRADOR');
INSERT INTO regra (id, version, authority) VALUES (2, 0, 'ROLE_EMPRESA');
INSERT INTO regra (id, version, authority) VALUES (3, 0, 'ROLE_PROPRIEDADE');
INSERT INTO regra (id, version, authority) VALUES (4, 0, 'ROLE_AGENTE');
INSERT INTO regra (id, version, authority) VALUES (5, 0, 'ROLE_CLIENTE');


--
-- TOC entry 2805 (class 0 OID 0)
-- Dependencies: 232
-- Name: regra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('regra_id_seq', 5, true);


--
-- TOC entry 2540 (class 0 OID 116300)
-- Dependencies: 235
-- Data for Name: responsavel_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2806 (class 0 OID 0)
-- Dependencies: 234
-- Name: responsavel_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('responsavel_empresa_id_seq', 1, false);


--
-- TOC entry 2542 (class 0 OID 116310)
-- Dependencies: 237
-- Data for Name: responsavel_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2807 (class 0 OID 0)
-- Dependencies: 236
-- Name: responsavel_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('responsavel_propriedade_id_seq', 1, false);


--
-- TOC entry 2544 (class 0 OID 116320)
-- Dependencies: 239
-- Data for Name: talhao_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2808 (class 0 OID 0)
-- Dependencies: 238
-- Name: talhao_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('talhao_propriedade_id_seq', 1, false);


--
-- TOC entry 2546 (class 0 OID 116328)
-- Dependencies: 241
-- Data for Name: telefone_empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2809 (class 0 OID 0)
-- Dependencies: 240
-- Name: telefone_empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('telefone_empresa_id_seq', 1, false);


--
-- TOC entry 2548 (class 0 OID 116338)
-- Dependencies: 243
-- Data for Name: telefone_propriedade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2810 (class 0 OID 0)
-- Dependencies: 242
-- Name: telefone_propriedade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('telefone_propriedade_id_seq', 1, false);


--
-- TOC entry 2550 (class 0 OID 116348)
-- Dependencies: 245
-- Data for Name: tipo_certificacao; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2811 (class 0 OID 0)
-- Dependencies: 244
-- Name: tipo_certificacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_certificacao_id_seq', 1, false);


--
-- TOC entry 2552 (class 0 OID 116356)
-- Dependencies: 247
-- Data for Name: tipo_produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipo_produto (id, version, descricao_tipo_produto) VALUES (1, 0, 'VERDURA');
INSERT INTO tipo_produto (id, version, descricao_tipo_produto) VALUES (2, 0, 'LEGUME');
INSERT INTO tipo_produto (id, version, descricao_tipo_produto) VALUES (3, 0, 'FRUTA');


--
-- TOC entry 2812 (class 0 OID 0)
-- Dependencies: 246
-- Name: tipo_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_produto_id_seq', 4, false);


--
-- TOC entry 2554 (class 0 OID 116364)
-- Dependencies: 249
-- Data for Name: tipo_responsavel; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2813 (class 0 OID 0)
-- Dependencies: 248
-- Name: tipo_responsavel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_responsavel_id_seq', 1, false);


--
-- TOC entry 2235 (class 2606 OID 116039)
-- Name: acesso_empresas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_empresas
    ADD CONSTRAINT acesso_empresas_pkey PRIMARY KEY (acesso_id, empresa_id);


--
-- TOC entry 2233 (class 2606 OID 116034)
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2237 (class 2606 OID 116044)
-- Name: acesso_propriedades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_propriedades
    ADD CONSTRAINT acesso_propriedades_pkey PRIMARY KEY (acesso_id, propriedade_id);


--
-- TOC entry 2239 (class 2606 OID 116049)
-- Name: acesso_regra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_regra
    ADD CONSTRAINT acesso_regra_pkey PRIMARY KEY (regra_id, acesso_id);


--
-- TOC entry 2241 (class 2606 OID 116062)
-- Name: atributo_fase_id_nome_atributo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo
    ADD CONSTRAINT atributo_fase_id_nome_atributo_key UNIQUE (fase_id, nome_atributo);


--
-- TOC entry 2243 (class 2606 OID 116060)
-- Name: atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo
    ADD CONSTRAINT atributo_pkey PRIMARY KEY (id);


--
-- TOC entry 2245 (class 2606 OID 116073)
-- Name: audit_log_event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY audit_log_event
    ADD CONSTRAINT audit_log_event_pkey PRIMARY KEY (id);


--
-- TOC entry 2247 (class 2606 OID 116084)
-- Name: certificacao_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa
    ADD CONSTRAINT certificacao_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2249 (class 2606 OID 116095)
-- Name: certificacao_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade
    ADD CONSTRAINT certificacao_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2251 (class 2606 OID 116103)
-- Name: cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT cidade_pkey PRIMARY KEY (id);


--
-- TOC entry 2253 (class 2606 OID 116114)
-- Name: consolidacao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY consolidacao
    ADD CONSTRAINT consolidacao_pkey PRIMARY KEY (id);


--
-- TOC entry 2255 (class 2606 OID 116124)
-- Name: cultivar_descricao_cultivar_produto_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar
    ADD CONSTRAINT cultivar_descricao_cultivar_produto_id_key UNIQUE (descricao_cultivar, produto_id);


--
-- TOC entry 2257 (class 2606 OID 116122)
-- Name: cultivar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar
    ADD CONSTRAINT cultivar_pkey PRIMARY KEY (id);


--
-- TOC entry 2259 (class 2606 OID 116135)
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2261 (class 2606 OID 116143)
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2263 (class 2606 OID 116154)
-- Name: fase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase
    ADD CONSTRAINT fase_pkey PRIMARY KEY (id);


--
-- TOC entry 2265 (class 2606 OID 116156)
-- Name: fase_produto_id_descricao_fase_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase
    ADD CONSTRAINT fase_produto_id_descricao_fase_key UNIQUE (produto_id, descricao_fase);


--
-- TOC entry 2267 (class 2606 OID 116167)
-- Name: foto_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_empresa
    ADD CONSTRAINT foto_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2269 (class 2606 OID 116178)
-- Name: foto_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_propriedade
    ADD CONSTRAINT foto_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2271 (class 2606 OID 116189)
-- Name: foto_talhao_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_talhao_propriedade
    ADD CONSTRAINT foto_talhao_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2273 (class 2606 OID 116197)
-- Name: lista_atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo
    ADD CONSTRAINT lista_atributo_pkey PRIMARY KEY (id);


--
-- TOC entry 2275 (class 2606 OID 116199)
-- Name: lista_atributo_valor_lista_atributo_atributo_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo
    ADD CONSTRAINT lista_atributo_valor_lista_atributo_atributo_id_key UNIQUE (valor_lista_atributo, atributo_id);


--
-- TOC entry 2277 (class 2606 OID 116210)
-- Name: lote_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lote
    ADD CONSTRAINT lote_pkey PRIMARY KEY (id);


--
-- TOC entry 2279 (class 2606 OID 116218)
-- Name: pais_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2281 (class 2606 OID 116226)
-- Name: permissao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissao
    ADD CONSTRAINT permissao_pkey PRIMARY KEY (id);


--
-- TOC entry 2283 (class 2606 OID 116228)
-- Name: permissao_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissao
    ADD CONSTRAINT permissao_url_key UNIQUE (url);


--
-- TOC entry 2285 (class 2606 OID 116239)
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2287 (class 2606 OID 116250)
-- Name: propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY propriedade
    ADD CONSTRAINT propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2289 (class 2606 OID 116258)
-- Name: rastro_atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo
    ADD CONSTRAINT rastro_atributo_pkey PRIMARY KEY (id);


--
-- TOC entry 2291 (class 2606 OID 116266)
-- Name: rastro_fase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase
    ADD CONSTRAINT rastro_fase_pkey PRIMARY KEY (id);


--
-- TOC entry 2293 (class 2606 OID 116276)
-- Name: rastro_produto_ano_safra_cultivar_id_produto_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT rastro_produto_ano_safra_cultivar_id_produto_id_key UNIQUE (ano_safra, cultivar_id, produto_id);


--
-- TOC entry 2295 (class 2606 OID 116274)
-- Name: rastro_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT rastro_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2297 (class 2606 OID 116287)
-- Name: registro_dados_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY registro_dados
    ADD CONSTRAINT registro_dados_pkey PRIMARY KEY (id);


--
-- TOC entry 2299 (class 2606 OID 116297)
-- Name: regra_authority_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regra
    ADD CONSTRAINT regra_authority_key UNIQUE (authority);


--
-- TOC entry 2301 (class 2606 OID 116295)
-- Name: regra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regra
    ADD CONSTRAINT regra_pkey PRIMARY KEY (id);


--
-- TOC entry 2303 (class 2606 OID 116307)
-- Name: responsavel_empresa_numero_telefone_responsavel_empresa_ddd_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT responsavel_empresa_numero_telefone_responsavel_empresa_ddd_key UNIQUE (numero_telefone_responsavel_empresa, ddd_responsavel_empresa);


--
-- TOC entry 2305 (class 2606 OID 116305)
-- Name: responsavel_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT responsavel_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2307 (class 2606 OID 116317)
-- Name: responsavel_propriedade_numero_telefone_responsavel_proprie_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT responsavel_propriedade_numero_telefone_responsavel_proprie_key UNIQUE (numero_telefone_responsavel_propriedade, ddd_responsavel_propriedade);


--
-- TOC entry 2309 (class 2606 OID 116315)
-- Name: responsavel_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT responsavel_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2311 (class 2606 OID 116325)
-- Name: talhao_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_propriedade
    ADD CONSTRAINT talhao_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2313 (class 2606 OID 116335)
-- Name: telefone_empresa_numero_telefone_empresa_ddd_empresa_empres_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa
    ADD CONSTRAINT telefone_empresa_numero_telefone_empresa_ddd_empresa_empres_key UNIQUE (numero_telefone_empresa, ddd_empresa, empresa_id);


--
-- TOC entry 2315 (class 2606 OID 116333)
-- Name: telefone_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa
    ADD CONSTRAINT telefone_empresa_pkey PRIMARY KEY (id);


--
-- TOC entry 2317 (class 2606 OID 116345)
-- Name: telefone_propriedade_numero_telefone_propriedade_ddd_propri_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade
    ADD CONSTRAINT telefone_propriedade_numero_telefone_propriedade_ddd_propri_key UNIQUE (numero_telefone_propriedade, ddd_propriedade, propriedade_id);


--
-- TOC entry 2319 (class 2606 OID 116343)
-- Name: telefone_propriedade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade
    ADD CONSTRAINT telefone_propriedade_pkey PRIMARY KEY (id);


--
-- TOC entry 2321 (class 2606 OID 116353)
-- Name: tipo_certificacao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_certificacao
    ADD CONSTRAINT tipo_certificacao_pkey PRIMARY KEY (id);


--
-- TOC entry 2323 (class 2606 OID 116361)
-- Name: tipo_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_produto
    ADD CONSTRAINT tipo_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2325 (class 2606 OID 116369)
-- Name: tipo_responsavel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_responsavel
    ADD CONSTRAINT tipo_responsavel_pkey PRIMARY KEY (id);


--
-- TOC entry 2341 (class 2606 OID 116445)
-- Name: fk182cfa986cc25b3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivar
    ADD CONSTRAINT fk182cfa986cc25b3d FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2369 (class 2606 OID 116585)
-- Name: fk184db5614cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_propriedade
    ADD CONSTRAINT fk184db5614cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2332 (class 2606 OID 116400)
-- Name: fk1d2346b8cb7ba557; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY atributo
    ADD CONSTRAINT fk1d2346b8cb7ba557 FOREIGN KEY (fase_id) REFERENCES fase(id);


--
-- TOC entry 2336 (class 2606 OID 116420)
-- Name: fk1f1b0e354cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade
    ADD CONSTRAINT fk1f1b0e354cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2335 (class 2606 OID 116415)
-- Name: fk1f1b0e35ec8cf724; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_propriedade
    ADD CONSTRAINT fk1f1b0e35ec8cf724 FOREIGN KEY (tipo_certificacao_id) REFERENCES tipo_certificacao(id);


--
-- TOC entry 2338 (class 2606 OID 116430)
-- Name: fk2fc801b990664537; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY consolidacao
    ADD CONSTRAINT fk2fc801b990664537 FOREIGN KEY (propriedade_origem_id) REFERENCES propriedade(id);


--
-- TOC entry 2340 (class 2606 OID 116440)
-- Name: fk2fc801b9c974e18d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY consolidacao
    ADD CONSTRAINT fk2fc801b9c974e18d FOREIGN KEY (lote_id) REFERENCES lote(id);


--
-- TOC entry 2339 (class 2606 OID 116435)
-- Name: fk2fc801b9f1e93f37; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY consolidacao
    ADD CONSTRAINT fk2fc801b9f1e93f37 FOREIGN KEY (empresa_origem_id) REFERENCES empresa(id);


--
-- TOC entry 2344 (class 2606 OID 116460)
-- Name: fk2fd84d6cc25b3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fase
    ADD CONSTRAINT fk2fd84d6cc25b3d FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2349 (class 2606 OID 116485)
-- Name: fk32c734d07b31eb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lote
    ADD CONSTRAINT fk32c734d07b31eb FOREIGN KEY (rastro_produto_id) REFERENCES rastro_produto(id);


--
-- TOC entry 2370 (class 2606 OID 116590)
-- Name: fk4f30c834d0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_empresa
    ADD CONSTRAINT fk4f30c834d0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2328 (class 2606 OID 116380)
-- Name: fk4f4693d2eb83573; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_propriedades
    ADD CONSTRAINT fk4f4693d2eb83573 FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2329 (class 2606 OID 116385)
-- Name: fk4f4693d4cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_propriedades
    ADD CONSTRAINT fk4f4693d4cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2346 (class 2606 OID 116470)
-- Name: fk64e0cc4e4cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_propriedade
    ADD CONSTRAINT fk64e0cc4e4cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2367 (class 2606 OID 116575)
-- Name: fk66bab38a4cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT fk66bab38a4cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2368 (class 2606 OID 116580)
-- Name: fk66bab38a9a70f730; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_propriedade
    ADD CONSTRAINT fk66bab38a9a70f730 FOREIGN KEY (tipo_responsavel_id) REFERENCES tipo_responsavel(id);


--
-- TOC entry 2357 (class 2606 OID 116525)
-- Name: fk6d557fc715f0d6f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc715f0d6f7 FOREIGN KEY (cultivar_id) REFERENCES cultivar(id);


--
-- TOC entry 2358 (class 2606 OID 116530)
-- Name: fk6d557fc74cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc74cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2356 (class 2606 OID 116520)
-- Name: fk6d557fc76cc25b3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc76cc25b3d FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2360 (class 2606 OID 116540)
-- Name: fk6d557fc7d0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc7d0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2359 (class 2606 OID 116535)
-- Name: fk6d557fc7f916efde; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_produto
    ADD CONSTRAINT fk6d557fc7f916efde FOREIGN KEY (talhao_propriedade_id) REFERENCES talhao_propriedade(id);


--
-- TOC entry 2347 (class 2606 OID 116475)
-- Name: fk72c2287cf916efde; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_talhao_propriedade
    ADD CONSTRAINT fk72c2287cf916efde FOREIGN KEY (talhao_propriedade_id) REFERENCES talhao_propriedade(id);


--
-- TOC entry 2334 (class 2606 OID 116410)
-- Name: fk84a6fdb5d0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa
    ADD CONSTRAINT fk84a6fdb5d0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2333 (class 2606 OID 116405)
-- Name: fk84a6fdb5ec8cf724; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificacao_empresa
    ADD CONSTRAINT fk84a6fdb5ec8cf724 FOREIGN KEY (tipo_certificacao_id) REFERENCES tipo_certificacao(id);


--
-- TOC entry 2353 (class 2606 OID 116505)
-- Name: fk9651afaa8ccbe2f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo
    ADD CONSTRAINT fk9651afaa8ccbe2f7 FOREIGN KEY (atributo_id) REFERENCES atributo(id);


--
-- TOC entry 2352 (class 2606 OID 116500)
-- Name: fk9651afaaadcbfd69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_atributo
    ADD CONSTRAINT fk9651afaaadcbfd69 FOREIGN KEY (rastro_fase_id) REFERENCES rastro_fase(id);


--
-- TOC entry 2363 (class 2606 OID 116555)
-- Name: fk9ea12c9fa02de209; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY registro_dados
    ADD CONSTRAINT fk9ea12c9fa02de209 FOREIGN KEY (rastro_atributo_id) REFERENCES rastro_atributo(id);


--
-- TOC entry 2361 (class 2606 OID 116545)
-- Name: fk9ea12c9fa41f63c9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY registro_dados
    ADD CONSTRAINT fk9ea12c9fa41f63c9 FOREIGN KEY (valor_lista_atributo_id) REFERENCES lista_atributo(id);


--
-- TOC entry 2362 (class 2606 OID 116550)
-- Name: fk9ea12c9fadcbfd69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY registro_dados
    ADD CONSTRAINT fk9ea12c9fadcbfd69 FOREIGN KEY (rastro_fase_id) REFERENCES rastro_fase(id);


--
-- TOC entry 2364 (class 2606 OID 116560)
-- Name: fk9ea12c9fd07b31eb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY registro_dados
    ADD CONSTRAINT fk9ea12c9fd07b31eb FOREIGN KEY (rastro_produto_id) REFERENCES rastro_produto(id);


--
-- TOC entry 2342 (class 2606 OID 116450)
-- Name: fk9f3540895a71537b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT fk9f3540895a71537b FOREIGN KEY (cidade_id) REFERENCES cidade(id);


--
-- TOC entry 2371 (class 2606 OID 116595)
-- Name: fka2ad81344cd6868d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY telefone_propriedade
    ADD CONSTRAINT fka2ad81344cd6868d FOREIGN KEY (propriedade_id) REFERENCES propriedade(id);


--
-- TOC entry 2337 (class 2606 OID 116425)
-- Name: fkaee65724e42c143b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT fkaee65724e42c143b FOREIGN KEY (estado_id) REFERENCES estado(id);


--
-- TOC entry 2343 (class 2606 OID 116455)
-- Name: fkb2e439662542c05b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT fkb2e439662542c05b FOREIGN KEY (pais_id) REFERENCES pais(id);


--
-- TOC entry 2348 (class 2606 OID 116480)
-- Name: fkbc1957f48ccbe2f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lista_atributo
    ADD CONSTRAINT fkbc1957f48ccbe2f7 FOREIGN KEY (atributo_id) REFERENCES atributo(id);


--
-- TOC entry 2331 (class 2606 OID 116395)
-- Name: fkbd0576702eb83573; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_regra
    ADD CONSTRAINT fkbd0576702eb83573 FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2330 (class 2606 OID 116390)
-- Name: fkbd057670c922d881; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_regra
    ADD CONSTRAINT fkbd057670c922d881 FOREIGN KEY (regra_id) REFERENCES regra(id);


--
-- TOC entry 2345 (class 2606 OID 116465)
-- Name: fkc6a9b04ed0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foto_empresa
    ADD CONSTRAINT fkc6a9b04ed0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2355 (class 2606 OID 116515)
-- Name: fkdbcc8a3fcb7ba557; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase
    ADD CONSTRAINT fkdbcc8a3fcb7ba557 FOREIGN KEY (fase_id) REFERENCES fase(id);


--
-- TOC entry 2354 (class 2606 OID 116510)
-- Name: fkdbcc8a3fd07b31eb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rastro_fase
    ADD CONSTRAINT fkdbcc8a3fd07b31eb FOREIGN KEY (rastro_produto_id) REFERENCES rastro_produto(id);


--
-- TOC entry 2366 (class 2606 OID 116570)
-- Name: fkdd30958a9a70f730; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT fkdd30958a9a70f730 FOREIGN KEY (tipo_responsavel_id) REFERENCES tipo_responsavel(id);


--
-- TOC entry 2365 (class 2606 OID 116565)
-- Name: fkdd30958ad0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responsavel_empresa
    ADD CONSTRAINT fkdd30958ad0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2326 (class 2606 OID 116370)
-- Name: fked3713d2eb83573; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_empresas
    ADD CONSTRAINT fked3713d2eb83573 FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2327 (class 2606 OID 116375)
-- Name: fked3713dd0bbfd8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_empresas
    ADD CONSTRAINT fked3713dd0bbfd8d FOREIGN KEY (empresa_id) REFERENCES empresa(id);


--
-- TOC entry 2350 (class 2606 OID 116490)
-- Name: fked8dcef9bea63b90; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT fked8dcef9bea63b90 FOREIGN KEY (tipo_produto_id) REFERENCES tipo_produto(id);


--
-- TOC entry 2351 (class 2606 OID 116495)
-- Name: fkf063c7095a71537b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY propriedade
    ADD CONSTRAINT fkf063c7095a71537b FOREIGN KEY (cidade_id) REFERENCES cidade(id);


-- Completed on 2016-05-11 18:32:01

--
-- PostgreSQL database dump complete
--

