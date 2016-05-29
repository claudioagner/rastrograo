--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.1

-- Started on 2016-05-13 07:52:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

--
-- TOC entry 254 (class 1255 OID 51950)
-- Name: fn_estoque_aquisicao_implemento(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_estoque_aquisicao_implemento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
  IF (TG_OP = 'DELETE') THEN
    UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel - OLD.quantidade_item WHERE id = OLD.implemento_id;
	RETURN OLD;
      
  ELSIF (TG_OP = 'UPDATE') THEN
	IF (OLD.quantidade_item != NEW.quantidade_item) THEN
      IF (OLD.implemento_id != NEW.implemento_id) THEN
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel - OLD.quantidade_item WHERE id = OLD.implemento_id;
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + NEW.quantidade_item WHERE id = NEW.implemento_id;	

      ELSE
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel - (OLD.quantidade_item - NEW.quantidade_item) WHERE id = OLD.implemento_id;

      END IF;
      RETURN OLD;
      
    ELSE
      IF (OLD.implemento_id != NEW.implemento_id) THEN
      	UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel - OLD.quantidade_item WHERE id = OLD.implemento_id;
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + OLD.quantidade_item WHERE id = NEW.implemento_id;
        
      END IF;
      RETURN OLD;
      
    END IF;    
    
  ELSIF (TG_OP = 'INSERT') THEN
    UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + NEW.quantidade_item WHERE id = NEW.implemento_id;
    RETURN NEW;
    
  END IF;
  
  RETURN NULL;
END;
$$;


--
-- TOC entry 256 (class 1255 OID 51951)
-- Name: fn_estoque_aquisicao_insumo(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_estoque_aquisicao_insumo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
  IF (TG_OP = 'DELETE') THEN
    UPDATE public.insumo SET estoque_atual = estoque_atual - OLD.quantidade_item WHERE id = OLD.insumo_id;
	RETURN OLD;
      
  ELSIF (TG_OP = 'UPDATE') THEN
	IF (OLD.quantidade_item != NEW.quantidade_item) THEN
      IF (OLD.insumo_id != NEW.insumo_id) THEN
        UPDATE public.insumo SET estoque_atual = estoque_atual - OLD.quantidade_item WHERE id = OLD.insumo_id;
        UPDATE public.insumo SET estoque_atual = estoque_atual + NEW.quantidade_item WHERE id = NEW.insumo_id;	

      ELSE
        UPDATE public.insumo SET estoque_atual = estoque_atual - (OLD.quantidade_item - NEW.quantidade_item) WHERE id = OLD.insumo_id;

      END IF;
      RETURN OLD;
      
    ELSE
      IF (OLD.insumo_id != NEW.insumo_id) THEN
      	UPDATE public.insumo SET estoque_atual = estoque_atual - OLD.quantidade_item WHERE id = OLD.insumo_id;
        UPDATE public.insumo SET estoque_atual = estoque_atual + OLD.quantidade_item WHERE id = NEW.insumo_id;
        
      END IF;
      RETURN OLD;
      
    END IF;    
    
  ELSIF (TG_OP = 'INSERT') THEN
    UPDATE public.insumo SET estoque_atual = estoque_atual + NEW.quantidade_item WHERE id = NEW.insumo_id;
    RETURN NEW;
    
  END IF;
  
  RETURN NULL;
END;
$$;


--
-- TOC entry 253 (class 1255 OID 51952)
-- Name: fn_estoque_manejo_implemento(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_estoque_manejo_implemento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
  IF (TG_OP = 'DELETE') THEN
    UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id = OLD.implemento_id;
	RETURN OLD;
      
  ELSIF (TG_OP = 'UPDATE') THEN
    IF (OLD.implemento_id != NEW.implemento_id) THEN
      IF (OLD.data_hora_fim IS NOT NULL) THEN
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id = OLD.implemento_id;
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id = NEW.implemento_id;

      ELSE
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id = OLD.implemento_id;
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id = NEW.implemento_id;

      END IF;

	ELSE  
      IF (OLD.data_hora_fim IS NOT NULL) THEN
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id = OLD.implemento_id;

      END IF;
      
      IF (NEW.data_hora_fim IS NOT NULL) THEN
        UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id = OLD.implemento_id;
        
      END IF;
      
    END IF;
    
  ELSIF (TG_OP = 'INSERT') THEN
  	IF (NEW.data_hora_fim IS NULL) THEN
      UPDATE public.implemento SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id = NEW.implemento_id;    

    END IF;

    RETURN NEW;
  END IF;
  
  RETURN NULL;
END;
$$;


--
-- TOC entry 255 (class 1255 OID 51953)
-- Name: fn_estoque_manejo_insumo(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_estoque_manejo_insumo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
  IF (TG_OP = 'DELETE') THEN
    UPDATE public.insumo SET estoque_atual = estoque_atual + OLD.quantidade_insumo WHERE id = OLD.insumo_id;
	RETURN OLD;
      
  ELSIF (TG_OP = 'UPDATE') THEN
	IF (OLD.quantidade_insumo != NEW.quantidade_insumo) THEN
      IF (OLD.insumo_id != NEW.insumo_id) THEN
        UPDATE public.insumo SET estoque_atual = estoque_atual + OLD.quantidade_insumo WHERE id = OLD.insumo_id;
        UPDATE public.insumo SET estoque_atual = estoque_atual - NEW.quantidade_insumo WHERE id = NEW.insumo_id;	

      ELSE
        UPDATE public.insumo SET estoque_atual = estoque_atual + (OLD.quantidade_insumo - NEW.quantidade_insumo) WHERE id = OLD.insumo_id;

      END IF;
      RETURN OLD;
      
    ELSE
      IF (OLD.insumo_id != NEW.insumo_id) THEN
      	UPDATE public.insumo SET estoque_atual = estoque_atual + OLD.quantidade_insumo WHERE id = OLD.insumo_id;
        UPDATE public.insumo SET estoque_atual = estoque_atual - OLD.quantidade_insumo WHERE id = NEW.insumo_id;
        
      END IF;
      RETURN OLD;
      
    END IF;    
    
  ELSIF (TG_OP = 'INSERT') THEN
    UPDATE public.insumo SET estoque_atual = estoque_atual - NEW.quantidade_insumo WHERE id = NEW.insumo_id;
    RETURN NEW;
    
  END IF;
  
  RETURN NULL;
END;
$$;


--
-- TOC entry 257 (class 1255 OID 51954)
-- Name: fn_total_implemento(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_total_implemento(aquisicaoid bigint DEFAULT 0) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
	somaTotal double precision :=0;
	itemInstance aquisicao_implemento%rowtype;
BEGIN
	-- percorre os itens de implemento
	FOR itemInstance IN SELECT a.* FROM public.aquisicao_implemento a WHERE a.aquisicao_id = aquisicaoId LOOP
    	somaTotal := somaTotal + (itemInstance.quantidade_item * itemInstance.valor_item);
    END LOOP;
    RETURN somaTotal;
END;
$$;


--
-- TOC entry 258 (class 1255 OID 51955)
-- Name: fn_total_insumo(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_total_insumo(aquisicaoid bigint DEFAULT 0) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
	somaTotal double precision :=0;
	itemInstance aquisicao_insumo%rowtype;
BEGIN
	-- percorre os itens de insumo
	FOR itemInstance IN SELECT a.* FROM public.aquisicao_insumo a WHERE a.aquisicao_id = aquisicaoId LOOP
    	somaTotal := somaTotal + (itemInstance.quantidade_item * itemInstance.valor_item);
    END LOOP;
    RETURN somaTotal;
END;
$$;


--
-- TOC entry 251 (class 1255 OID 51956)
-- Name: fn_update_aquisicao(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_update_aquisicao() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  valorTotal double precision := 0;
BEGIN
  IF (TG_OP = 'DELETE') THEN
    --soma os valores da aquisicao
    valorTotal := (fn_total_implemento(OLD.id) + fn_total_insumo(OLD.id));
    --Atualiza o total da aquisicao
    UPDATE public.aquisicao
      SET valor_total = (valorTotal)
      WHERE id = OLD.id;
  	RETURN OLD;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    --soma os valores da aquisicao
    valorTotal := (fn_total_implemento(OLD.id) + fn_total_insumo(OLD.id));
    --Atualiza o total da aquisicao
    UPDATE public.aquisicao
      SET valor_total = (valorTotal)
      WHERE id = OLD.id;
  	RETURN OLD;

  ELSIF (TG_OP = 'INSERT') THEN
    --soma os valores da aquisicao
    valorTotal := (fn_total_implemento(NEW.id) + fn_total_insumo(NEW.id));
    --Atualiza o total da aquisicao
    UPDATE public.aquisicao
      SET valor_total = (valorTotal)
      WHERE id = NEW.id;
  	RETURN NEW;
    
  END IF;
  RETURN NULL;
  
END;
$$;


--
-- TOC entry 252 (class 1255 OID 51957)
-- Name: fn_update_parcela(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION fn_update_parcela() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  pagamentoInstance pagamento%rowtype;
  quantidadeParcela integer := 0;
  diaVencimento timestamp;
  valorTotal double precision := 0;
  aquisicaoId bigint;
BEGIN
	--recupera o id da aquisicao
	IF (NEW.id IS NULL) THEN
    	aquisicaoId := OLD.id;
    ELSE
    	aquisicaoId := NEW.id;
    END IF;

	--recupera a quantidade de parcelas da aquisicao
	IF (NEW.quantidade_parcela IS NULL) THEN
    	quantidadeParcela := OLD.quantidade_parcela;
    ELSE
    	quantidadeParcela := NEW.quantidade_parcela;
    END IF;
    
    --recupera o dia do vencimento
    IF (NEW.dia_vencimento IS NULL) THEN
		diaVencimento := OLD.dia_vencimento;    
    ELSE
		diaVencimento := NEW.dia_vencimento;    
    END IF;
    
    --recupera o valor total da aquisicao
    IF (NEW.valor_total IS NULL) THEN
		valorTotal := OLD.valor_total;    
    ELSE
		valorTotal := NEW.valor_total;        
    END IF;
    
    --percorre as parcelas da aquisicao
	FOR i IN 1 .. quantidadeParcela LOOP

	    SELECT * INTO pagamentoInstance FROM public.pagamento b WHERE b.aquisicao_id = aquisicaoId AND b.parcela_numero = i;
        
        IF pagamentoInstance IS NULL THEN    

          	INSERT INTO public.pagamento (version, aquisicao_id, data_parcela, parcela_numero, valor_parcela)
      	        VALUES (0, aquisicaoId, CAST(diaVencimento AS DATE) + (INTERVAL '30 DAYS' * i), i, valorTotal / quantidadeParcela);
        	RAISE NOTICE 'Pagamento foi inserido';

        ELSE            

            UPDATE public.pagamento 
	            SET 
    	            data_parcela = CAST(diaVencimento AS DATE) + (INTERVAL '30 DAYS' * i),
                    valor_parcela = valorTotal / quantidadeParcela
                WHERE 
                    aquisicao_id = aquisicaoId AND
                    parcela_numero = i;
        	RAISE NOTICE 'Pagamento foi atualizado';            
            
        END IF;

    END LOOP;
    
	IF(OLD.quantidade_parcela > NEW.quantidade_parcela) THEN

		UPDATE public.pagamento 
	        SET 
    	        data_parcela = diaVencimento,
                valor_parcela = valorTotal / quantidadeParcela
            WHERE 
                aquisicao_id = aquisicaoId AND
                parcela_numero > quantidadeParcela AND
                data_pagamento IS NOT NULL;
                
	     DELETE 
         	FROM public.pagamento 
            WHERE aquisicao_id = aquisicaoId 
            AND  parcela_numero > quantidadeParcela 
            AND data_pagamento IS NULL;
         
         RAISE NOTICE 'Pagamentos adicionais foram atualizados e/ou removidos';

	END IF;

    RETURN OLD;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 51528)
-- Name: acesso; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso (
    id bigint NOT NULL,
    version bigint NOT NULL,
    account_expired boolean NOT NULL,
    account_locked boolean NOT NULL,
    enabled boolean NOT NULL,
    password character varying(255) NOT NULL,
    password_expired boolean NOT NULL,
    username character varying(255) NOT NULL
);


--
-- TOC entry 184 (class 1259 OID 51539)
-- Name: acesso_autoridade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acesso_autoridade (
    autoridade_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 182 (class 1259 OID 51526)
-- Name: acesso_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE acesso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 182
-- Name: acesso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE acesso_id_seq OWNED BY acesso.id;


--
-- TOC entry 186 (class 1259 OID 51546)
-- Name: aquisicao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aquisicao (
    id bigint NOT NULL,
    version bigint NOT NULL,
    data_aquisicao timestamp without time zone NOT NULL,
    dia_vencimento timestamp without time zone NOT NULL,
    justificativa character varying(255),
    nota_fiscal character varying(32) NOT NULL,
    quantidade_parcela integer NOT NULL,
    valor_total double precision DEFAULT 0 NOT NULL
);


--
-- TOC entry 185 (class 1259 OID 51544)
-- Name: aquisicao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aquisicao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 185
-- Name: aquisicao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aquisicao_id_seq OWNED BY aquisicao.id;


--
-- TOC entry 188 (class 1259 OID 51557)
-- Name: aquisicao_implemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aquisicao_implemento (
    id bigint NOT NULL,
    version bigint NOT NULL,
    aquisicao_id bigint NOT NULL,
    implemento_id bigint NOT NULL,
    quantidade_item integer NOT NULL,
    tipo_aquisicao character varying(7) NOT NULL,
    valor_item double precision NOT NULL
);


--
-- TOC entry 187 (class 1259 OID 51555)
-- Name: aquisicao_implemento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aquisicao_implemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 187
-- Name: aquisicao_implemento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aquisicao_implemento_id_seq OWNED BY aquisicao_implemento.id;


--
-- TOC entry 190 (class 1259 OID 51565)
-- Name: aquisicao_insumo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aquisicao_insumo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    aquisicao_id bigint NOT NULL,
    insumo_id bigint NOT NULL,
    quantidade_item integer NOT NULL,
    valor_item double precision NOT NULL
);


--
-- TOC entry 189 (class 1259 OID 51563)
-- Name: aquisicao_insumo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aquisicao_insumo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 189
-- Name: aquisicao_insumo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aquisicao_insumo_id_seq OWNED BY aquisicao_insumo.id;


--
-- TOC entry 192 (class 1259 OID 51573)
-- Name: audit_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE audit_log (
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
-- TOC entry 191 (class 1259 OID 51571)
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audit_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 191
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audit_log_id_seq OWNED BY audit_log.id;


--
-- TOC entry 194 (class 1259 OID 51584)
-- Name: autoridade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE autoridade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    authority character varying(255) NOT NULL
);


--
-- TOC entry 193 (class 1259 OID 51582)
-- Name: autoridade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE autoridade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 193
-- Name: autoridade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE autoridade_id_seq OWNED BY autoridade.id;


--
-- TOC entry 196 (class 1259 OID 51594)
-- Name: cidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cidade (
    id bigint NOT NULL,
    version bigint NOT NULL,
    estado_id bigint NOT NULL,
    nome_cidade character varying(128) NOT NULL
);


--
-- TOC entry 195 (class 1259 OID 51592)
-- Name: cidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 195
-- Name: cidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cidade_id_seq OWNED BY cidade.id;


--
-- TOC entry 198 (class 1259 OID 51604)
-- Name: clima; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE clima (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_clima character varying(128) NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 51602)
-- Name: clima_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clima_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 197
-- Name: clima_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clima_id_seq OWNED BY clima.id;


--
-- TOC entry 200 (class 1259 OID 51614)
-- Name: colheita; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE colheita (
    id bigint NOT NULL,
    version bigint NOT NULL,
    cultivo_id bigint NOT NULL,
    data_colheita timestamp without time zone NOT NULL,
    insumo_id bigint NOT NULL,
    observacao character varying(255),
    quantidade integer NOT NULL
);


--
-- TOC entry 199 (class 1259 OID 51612)
-- Name: colheita_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE colheita_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 199
-- Name: colheita_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE colheita_id_seq OWNED BY colheita.id;


--
-- TOC entry 202 (class 1259 OID 51624)
-- Name: cultivo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cultivo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    data_encerramento timestamp without time zone,
    data_inicio timestamp without time zone NOT NULL,
    observacao character varying(255),
    talhao_id bigint NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 51622)
-- Name: cultivo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cultivo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 201
-- Name: cultivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cultivo_id_seq OWNED BY cultivo.id;


--
-- TOC entry 204 (class 1259 OID 51632)
-- Name: estado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE estado (
    id bigint NOT NULL,
    version bigint NOT NULL,
    nome_estado character varying(128) NOT NULL,
    pais_id bigint NOT NULL,
    sigla_estado character varying(2) NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 51630)
-- Name: estado_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 203
-- Name: estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE estado_id_seq OWNED BY estado.id;


--
-- TOC entry 206 (class 1259 OID 51644)
-- Name: evento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE evento (
    id bigint NOT NULL,
    version bigint NOT NULL,
    config_attribute character varying(255) NOT NULL,
    url character varying(255) NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 51642)
-- Name: evento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE evento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 205
-- Name: evento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE evento_id_seq OWNED BY evento.id;


--
-- TOC entry 208 (class 1259 OID 51657)
-- Name: implemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE implemento (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_implemento character varying(128) NOT NULL,
    quantidade_disponivel integer NOT NULL,
    tipo_implemento_id bigint NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 51655)
-- Name: implemento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE implemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 207
-- Name: implemento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE implemento_id_seq OWNED BY implemento.id;


--
-- TOC entry 210 (class 1259 OID 51667)
-- Name: insumo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE insumo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_insumo character varying(128) NOT NULL,
    estoque_atual integer DEFAULT 0 NOT NULL,
    estoque_max integer DEFAULT 0 NOT NULL,
    estoque_min integer DEFAULT 0 NOT NULL,
    produto_id bigint,
    tipo_insumo_id bigint NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 51665)
-- Name: insumo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE insumo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 209
-- Name: insumo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE insumo_id_seq OWNED BY insumo.id;


--
-- TOC entry 212 (class 1259 OID 51679)
-- Name: manejo_implemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE manejo_implemento (
    id bigint NOT NULL,
    version bigint NOT NULL,
    cultivo_id bigint NOT NULL,
    data_hora_fim timestamp without time zone,
    data_hora_inicio timestamp without time zone NOT NULL,
    implemento_id bigint NOT NULL,
    observacao character varying(255)
);


--
-- TOC entry 211 (class 1259 OID 51677)
-- Name: manejo_implemento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manejo_implemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 211
-- Name: manejo_implemento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE manejo_implemento_id_seq OWNED BY manejo_implemento.id;


--
-- TOC entry 214 (class 1259 OID 51689)
-- Name: manejo_insumo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE manejo_insumo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    cultivo_id bigint NOT NULL,
    data_manejo timestamp without time zone NOT NULL,
    insumo_id bigint NOT NULL,
    observacao character varying(255),
    quantidade_insumo integer NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 51687)
-- Name: manejo_insumo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manejo_insumo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 213
-- Name: manejo_insumo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE manejo_insumo_id_seq OWNED BY manejo_insumo.id;


--
-- TOC entry 216 (class 1259 OID 51699)
-- Name: ocorrencia_clima; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ocorrencia_clima (
    id bigint NOT NULL,
    version bigint NOT NULL,
    clima_id bigint NOT NULL,
    cultivo_id bigint NOT NULL,
    data_clima timestamp without time zone NOT NULL,
    temperatura double precision NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 51697)
-- Name: ocorrencia_clima_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ocorrencia_clima_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 215
-- Name: ocorrencia_clima_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ocorrencia_clima_id_seq OWNED BY ocorrencia_clima.id;


--
-- TOC entry 218 (class 1259 OID 51709)
-- Name: ocorrencia_praga; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ocorrencia_praga (
    id bigint NOT NULL,
    version bigint NOT NULL,
    cultivo_id bigint NOT NULL,
    data_controle timestamp without time zone,
    data_descoberta timestamp without time zone NOT NULL,
    descricao_controle character varying(255),
    praga_id bigint NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 51707)
-- Name: ocorrencia_praga_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ocorrencia_praga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 217
-- Name: ocorrencia_praga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ocorrencia_praga_id_seq OWNED BY ocorrencia_praga.id;


--
-- TOC entry 220 (class 1259 OID 51719)
-- Name: pagamento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pagamento (
    id bigint NOT NULL,
    version bigint NOT NULL,
    aquisicao_id bigint NOT NULL,
    data_pagamento timestamp without time zone,
    data_parcela timestamp without time zone NOT NULL,
    desconto double precision DEFAULT 0 NOT NULL,
    juros double precision DEFAULT 0 NOT NULL,
    multa double precision DEFAULT 0 NOT NULL,
    observacao character varying(255),
    parcela_numero integer NOT NULL,
    valor_pago double precision DEFAULT 0 NOT NULL,
    valor_parcela double precision NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 51717)
-- Name: pagamento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pagamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 219
-- Name: pagamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pagamento_id_seq OWNED BY pagamento.id;


--
-- TOC entry 222 (class 1259 OID 51731)
-- Name: pais; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pais (
    id bigint NOT NULL,
    version bigint NOT NULL,
    country_name character varying(128) NOT NULL,
    nome_pais character varying(128) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 51729)
-- Name: pais_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 221
-- Name: pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pais_id_seq OWNED BY pais.id;


--
-- TOC entry 224 (class 1259 OID 51743)
-- Name: praga; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE praga (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_praga character varying(128) NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 51741)
-- Name: praga_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE praga_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 223
-- Name: praga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE praga_id_seq OWNED BY praga.id;


--
-- TOC entry 226 (class 1259 OID 51753)
-- Name: produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE produto (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_produto character varying(128) NOT NULL,
    tipo_produto_id bigint NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 51751)
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 225
-- Name: produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE produto_id_seq OWNED BY produto.id;


--
-- TOC entry 228 (class 1259 OID 51763)
-- Name: talhao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE talhao (
    id bigint NOT NULL,
    version bigint NOT NULL,
    area_total double precision NOT NULL,
    descricao_talhao character varying(128) NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 51761)
-- Name: talhao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE talhao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 227
-- Name: talhao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE talhao_id_seq OWNED BY talhao.id;


--
-- TOC entry 230 (class 1259 OID 51773)
-- Name: talhao_tipo_solo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE talhao_tipo_solo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    porcentagem_area double precision NOT NULL,
    talhao_id bigint NOT NULL,
    tipo_solo_id bigint NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 51771)
-- Name: talhao_tipo_solo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE talhao_tipo_solo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 229
-- Name: talhao_tipo_solo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE talhao_tipo_solo_id_seq OWNED BY talhao_tipo_solo.id;


--
-- TOC entry 232 (class 1259 OID 51781)
-- Name: tipo_implemento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_implemento (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_implemento character varying(128) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 51779)
-- Name: tipo_implemento_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_implemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 231
-- Name: tipo_implemento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_implemento_id_seq OWNED BY tipo_implemento.id;


--
-- TOC entry 234 (class 1259 OID 51791)
-- Name: tipo_insumo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_insumo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    classificacao character varying(10) NOT NULL,
    descricao_tipo_insumo character varying(128) NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 51789)
-- Name: tipo_insumo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_insumo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 233
-- Name: tipo_insumo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_insumo_id_seq OWNED BY tipo_insumo.id;


--
-- TOC entry 236 (class 1259 OID 51801)
-- Name: tipo_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_produto (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_produto character varying(128) NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 51799)
-- Name: tipo_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2540 (class 0 OID 0)
-- Dependencies: 235
-- Name: tipo_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_produto_id_seq OWNED BY tipo_produto.id;


--
-- TOC entry 238 (class 1259 OID 51811)
-- Name: tipo_solo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipo_solo (
    id bigint NOT NULL,
    version bigint NOT NULL,
    descricao_tipo_solo character varying(128) NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 51809)
-- Name: tipo_solo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipo_solo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2541 (class 0 OID 0)
-- Dependencies: 237
-- Name: tipo_solo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipo_solo_id_seq OWNED BY tipo_solo.id;


--
-- TOC entry 2159 (class 2604 OID 51531)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso ALTER COLUMN id SET DEFAULT nextval('acesso_id_seq'::regclass);


--
-- TOC entry 2160 (class 2604 OID 51549)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao ALTER COLUMN id SET DEFAULT nextval('aquisicao_id_seq'::regclass);


--
-- TOC entry 2162 (class 2604 OID 51560)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_implemento ALTER COLUMN id SET DEFAULT nextval('aquisicao_implemento_id_seq'::regclass);


--
-- TOC entry 2163 (class 2604 OID 51568)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_insumo ALTER COLUMN id SET DEFAULT nextval('aquisicao_insumo_id_seq'::regclass);


--
-- TOC entry 2164 (class 2604 OID 51576)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audit_log ALTER COLUMN id SET DEFAULT nextval('audit_log_id_seq'::regclass);


--
-- TOC entry 2165 (class 2604 OID 51587)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY autoridade ALTER COLUMN id SET DEFAULT nextval('autoridade_id_seq'::regclass);


--
-- TOC entry 2166 (class 2604 OID 51597)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade ALTER COLUMN id SET DEFAULT nextval('cidade_id_seq'::regclass);


--
-- TOC entry 2167 (class 2604 OID 51607)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clima ALTER COLUMN id SET DEFAULT nextval('clima_id_seq'::regclass);


--
-- TOC entry 2168 (class 2604 OID 51617)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY colheita ALTER COLUMN id SET DEFAULT nextval('colheita_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 51627)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivo ALTER COLUMN id SET DEFAULT nextval('cultivo_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 51635)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado ALTER COLUMN id SET DEFAULT nextval('estado_id_seq'::regclass);


--
-- TOC entry 2171 (class 2604 OID 51647)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY evento ALTER COLUMN id SET DEFAULT nextval('evento_id_seq'::regclass);


--
-- TOC entry 2172 (class 2604 OID 51660)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY implemento ALTER COLUMN id SET DEFAULT nextval('implemento_id_seq'::regclass);


--
-- TOC entry 2173 (class 2604 OID 51670)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY insumo ALTER COLUMN id SET DEFAULT nextval('insumo_id_seq'::regclass);


--
-- TOC entry 2177 (class 2604 OID 51682)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_implemento ALTER COLUMN id SET DEFAULT nextval('manejo_implemento_id_seq'::regclass);


--
-- TOC entry 2178 (class 2604 OID 51692)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_insumo ALTER COLUMN id SET DEFAULT nextval('manejo_insumo_id_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 51702)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_clima ALTER COLUMN id SET DEFAULT nextval('ocorrencia_clima_id_seq'::regclass);


--
-- TOC entry 2180 (class 2604 OID 51712)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_praga ALTER COLUMN id SET DEFAULT nextval('ocorrencia_praga_id_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 51722)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pagamento ALTER COLUMN id SET DEFAULT nextval('pagamento_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 51734)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais ALTER COLUMN id SET DEFAULT nextval('pais_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 51746)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY praga ALTER COLUMN id SET DEFAULT nextval('praga_id_seq'::regclass);


--
-- TOC entry 2188 (class 2604 OID 51756)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto ALTER COLUMN id SET DEFAULT nextval('produto_id_seq'::regclass);


--
-- TOC entry 2189 (class 2604 OID 51766)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao ALTER COLUMN id SET DEFAULT nextval('talhao_id_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 51776)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_tipo_solo ALTER COLUMN id SET DEFAULT nextval('talhao_tipo_solo_id_seq'::regclass);


--
-- TOC entry 2191 (class 2604 OID 51784)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_implemento ALTER COLUMN id SET DEFAULT nextval('tipo_implemento_id_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 51794)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_insumo ALTER COLUMN id SET DEFAULT nextval('tipo_insumo_id_seq'::regclass);


--
-- TOC entry 2193 (class 2604 OID 51804)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_produto ALTER COLUMN id SET DEFAULT nextval('tipo_produto_id_seq'::regclass);


--
-- TOC entry 2194 (class 2604 OID 51814)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_solo ALTER COLUMN id SET DEFAULT nextval('tipo_solo_id_seq'::regclass);


--
-- TOC entry 2451 (class 0 OID 51528)
-- Dependencies: 183
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO acesso (id, version, account_expired, account_locked, enabled, password, password_expired, username) VALUES (1, 0, false, false, true, '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', false, 'admin');


--
-- TOC entry 2452 (class 0 OID 51539)
-- Dependencies: 184
-- Data for Name: acesso_autoridade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO acesso_autoridade (autoridade_id, acesso_id) VALUES (1, 1);


--
-- TOC entry 2542 (class 0 OID 0)
-- Dependencies: 182
-- Name: acesso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('acesso_id_seq', 1, true);


--
-- TOC entry 2454 (class 0 OID 51546)
-- Dependencies: 186
-- Data for Name: aquisicao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO aquisicao (id, version, data_aquisicao, dia_vencimento, justificativa, nota_fiscal, quantidade_parcela, valor_total) VALUES (1, 0, '2016-04-18 00:00:00', '2016-04-18 00:00:00', NULL, '123', 3, 24);


--
-- TOC entry 2543 (class 0 OID 0)
-- Dependencies: 185
-- Name: aquisicao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('aquisicao_id_seq', 1, true);


--
-- TOC entry 2456 (class 0 OID 51557)
-- Dependencies: 188
-- Data for Name: aquisicao_implemento; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2544 (class 0 OID 0)
-- Dependencies: 187
-- Name: aquisicao_implemento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('aquisicao_implemento_id_seq', 1, false);


--
-- TOC entry 2458 (class 0 OID 51565)
-- Dependencies: 190
-- Data for Name: aquisicao_insumo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO aquisicao_insumo (id, version, aquisicao_id, insumo_id, quantidade_item, valor_item) VALUES (1, 0, 1, 15, 2, 12);


--
-- TOC entry 2545 (class 0 OID 0)
-- Dependencies: 189
-- Name: aquisicao_insumo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('aquisicao_insumo_id_seq', 1, true);


--
-- TOC entry 2460 (class 0 OID 51573)
-- Dependencies: 192
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (1, 'system', 'Autoridade', '2016-04-13 19:49:25.825', 'INSERT', '2016-04-13 19:49:25.825', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (2, 'system', 'Acesso', '2016-04-13 19:49:26.043', 'INSERT', '2016-04-13 19:49:26.043', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (3, 'system', 'AcessoAutoridade', '2016-04-13 19:49:26.121', 'INSERT', '2016-04-13 19:49:26.121', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (4, 'system', 'Evento', '2016-04-13 19:49:26.137', 'INSERT', '2016-04-13 19:49:26.137', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (5, 'system', 'Evento', '2016-04-13 19:49:26.168', 'INSERT', '2016-04-13 19:49:26.168', NULL, NULL, '2', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (6, 'system', 'Evento', '2016-04-13 19:49:26.168', 'INSERT', '2016-04-13 19:49:26.168', NULL, NULL, '3', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (7, 'system', 'Evento', '2016-04-13 19:49:26.2', 'INSERT', '2016-04-13 19:49:26.2', NULL, NULL, '4', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (8, 'system', 'Evento', '2016-04-13 19:49:26.215', 'INSERT', '2016-04-13 19:49:26.215', NULL, NULL, '5', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (9, 'system', 'Evento', '2016-04-13 19:49:26.231', 'INSERT', '2016-04-13 19:49:26.231', NULL, NULL, '6', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (10, 'system', 'Evento', '2016-04-13 19:49:26.231', 'INSERT', '2016-04-13 19:49:26.231', NULL, NULL, '7', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (11, 'system', 'Evento', '2016-04-13 19:49:26.246', 'INSERT', '2016-04-13 19:49:26.246', NULL, NULL, '8', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (12, 'system', 'Evento', '2016-04-13 19:49:26.262', 'INSERT', '2016-04-13 19:49:26.262', NULL, NULL, '9', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (13, 'system', 'Evento', '2016-04-13 19:49:26.278', 'INSERT', '2016-04-13 19:49:26.278', NULL, NULL, '10', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (14, 'system', 'Evento', '2016-04-13 19:49:26.293', 'INSERT', '2016-04-13 19:49:26.293', NULL, NULL, '11', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (15, 'system', 'Evento', '2016-04-13 19:49:26.309', 'INSERT', '2016-04-13 19:49:26.309', NULL, NULL, '12', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (16, 'system', 'Evento', '2016-04-13 19:49:26.325', 'INSERT', '2016-04-13 19:49:26.325', NULL, NULL, '13', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (17, 'system', 'Evento', '2016-04-13 19:49:26.34', 'INSERT', '2016-04-13 19:49:26.34', NULL, NULL, '14', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (18, 'system', 'Evento', '2016-04-13 19:49:26.356', 'INSERT', '2016-04-13 19:49:26.356', NULL, NULL, '15', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (19, 'system', 'Evento', '2016-04-13 19:49:26.371', 'INSERT', '2016-04-13 19:49:26.371', NULL, NULL, '16', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (20, 'system', 'Evento', '2016-04-13 19:49:26.387', 'INSERT', '2016-04-13 19:49:26.387', NULL, NULL, '17', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (21, 'system', 'Evento', '2016-04-13 19:49:26.387', 'INSERT', '2016-04-13 19:49:26.387', NULL, NULL, '18', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (22, 'system', 'Evento', '2016-04-13 19:49:26.403', 'INSERT', '2016-04-13 19:49:26.403', NULL, NULL, '19', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (23, 'system', 'Evento', '2016-04-13 19:49:26.418', 'INSERT', '2016-04-13 19:49:26.418', NULL, NULL, '20', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (24, 'system', 'Evento', '2016-04-13 19:49:26.434', 'INSERT', '2016-04-13 19:49:26.434', NULL, NULL, '21', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (25, 'system', 'Evento', '2016-04-13 19:49:26.45', 'INSERT', '2016-04-13 19:49:26.45', NULL, NULL, '22', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (26, 'admin', 'Clima', '2016-04-18 15:51:04.101', 'INSERT', '2016-04-18 15:51:04.101', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (27, 'admin', 'TipoImplemento', '2016-04-18 15:51:13.823', 'INSERT', '2016-04-18 15:51:13.823', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (28, 'admin', 'Implemento', '2016-04-18 15:51:34.71', 'INSERT', '2016-04-18 15:51:34.71', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (29, 'admin', 'Aquisicao', '2016-04-18 15:59:35.709', 'INSERT', '2016-04-18 15:59:35.709', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (30, 'admin', 'Insumo', '2016-04-18 16:00:30.693', 'INSERT', '2016-04-18 16:00:30.693', NULL, NULL, '15', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (31, 'admin', 'AquisicaoInsumo', '2016-04-18 16:00:58.013', 'INSERT', '2016-04-18 16:00:58.013', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (32, 'admin', 'Praga', '2016-04-18 16:43:16.52', 'INSERT', '2016-04-18 16:43:16.52', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (33, 'admin', 'TipoSolo', '2016-04-18 16:43:30.312', 'INSERT', '2016-04-18 16:43:30.312', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (34, 'admin', 'Talhao', '2016-04-18 16:43:47.391', 'INSERT', '2016-04-18 16:43:47.391', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (35, 'admin', 'TalhaoTipoSolo', '2016-04-18 16:43:56.258', 'INSERT', '2016-04-18 16:43:56.258', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (36, 'admin', 'Cultivo', '2016-04-18 16:44:07.933', 'INSERT', '2016-04-18 16:44:07.933', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (37, 'admin', 'OcorrenciaPraga', '2016-04-18 16:44:34.549', 'INSERT', '2016-04-18 16:44:34.549', NULL, NULL, '1', 0, NULL, NULL);
INSERT INTO audit_log (id, actor, class_name, date_created, event_name, last_updated, new_value, old_value, persisted_object_id, persisted_object_version, property_name, uri) VALUES (38, 'admin', 'OcorrenciaPraga', '2016-04-18 16:44:46.383', 'DELETE', '2016-04-18 16:44:46.383', NULL, NULL, '1', 0, NULL, NULL);


--
-- TOC entry 2546 (class 0 OID 0)
-- Dependencies: 191
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('audit_log_id_seq', 38, true);


--
-- TOC entry 2462 (class 0 OID 51584)
-- Dependencies: 194
-- Data for Name: autoridade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO autoridade (id, version, authority) VALUES (1, 0, 'ROLE_ADMINISTRADOR');


--
-- TOC entry 2547 (class 0 OID 0)
-- Dependencies: 193
-- Name: autoridade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('autoridade_id_seq', 1, true);


--
-- TOC entry 2464 (class 0 OID 51594)
-- Dependencies: 196
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
-- TOC entry 2548 (class 0 OID 0)
-- Dependencies: 195
-- Name: cidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cidade_id_seq', 400, false);


--
-- TOC entry 2466 (class 0 OID 51604)
-- Dependencies: 198
-- Data for Name: clima; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO clima (id, version, descricao_clima) VALUES (1, 0, 'CHUVA');


--
-- TOC entry 2549 (class 0 OID 0)
-- Dependencies: 197
-- Name: clima_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('clima_id_seq', 1, true);


--
-- TOC entry 2468 (class 0 OID 51614)
-- Dependencies: 200
-- Data for Name: colheita; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2550 (class 0 OID 0)
-- Dependencies: 199
-- Name: colheita_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('colheita_id_seq', 1, false);


--
-- TOC entry 2470 (class 0 OID 51624)
-- Dependencies: 202
-- Data for Name: cultivo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cultivo (id, version, data_encerramento, data_inicio, observacao, talhao_id) VALUES (1, 0, NULL, '2016-04-18 00:00:00', 'teste
', 1);


--
-- TOC entry 2551 (class 0 OID 0)
-- Dependencies: 201
-- Name: cultivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cultivo_id_seq', 1, true);


--
-- TOC entry 2472 (class 0 OID 51632)
-- Dependencies: 204
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (1, 0, 'ACRE', 33, 'AC');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (2, 0, 'ALAGOAS', 33, 'AL');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (3, 0, 'AMAZONAS', 33, 'AM');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (4, 0, 'AMAPÁ', 33, 'AP');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (5, 0, 'BAHIA', 33, 'BA');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (6, 0, 'CEARÁ', 33, 'CE');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (7, 0, 'DISTRITO FEDERAL', 33, 'DF');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (8, 0, 'ESPÍRITO SANTO', 33, 'ES');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (9, 0, 'GOIÁS', 33, 'GO');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (10, 0, 'MARANHÃO', 33, 'MA');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (11, 0, 'MINAS GERAIS', 33, 'MG');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (12, 0, 'MATO GROSSO DO SUL', 33, 'MS');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (13, 0, 'MATO GROSSO', 33, 'MT');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (14, 0, 'PARÁ', 33, 'PA');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (15, 0, 'PARAÍBA', 33, 'PB');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (16, 0, 'PERNAMBUCO', 33, 'PE');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (17, 0, 'PIAUÍ', 33, 'PI');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (18, 0, 'PARANÁ', 33, 'PR');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (19, 0, 'RIO DE JANEIRO', 33, 'RJ');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (20, 0, 'RIO GRANDE DO NORTE', 33, 'RN');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (21, 0, 'RONDÔNIA', 33, 'RO');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (22, 0, 'RORAIMA', 33, 'RR');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (23, 0, 'RIO GRANDE DO SUL', 33, 'RS');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (24, 0, 'SANTA CATARINA', 33, 'SC');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (25, 0, 'SERGIPE', 33, 'SE');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (26, 0, 'SÃO PAULO', 33, 'SP');
INSERT INTO estado (id, version, nome_estado, pais_id, sigla_estado) VALUES (27, 0, 'TOCANTINS', 33, 'TO');


--
-- TOC entry 2552 (class 0 OID 0)
-- Dependencies: 203
-- Name: estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('estado_id_seq', 28, false);


--
-- TOC entry 2474 (class 0 OID 51644)
-- Dependencies: 206
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO evento (id, version, config_attribute, url) VALUES (1, 0, 'ROLE_ADMINISTRADOR', '/aquisicao/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (2, 0, 'ROLE_ADMINISTRADOR', '/aquisicaoImplemento/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (3, 0, 'ROLE_ADMINISTRADOR', '/aquisicaoInsumo/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (4, 0, 'ROLE_ADMINISTRADOR', '/clima/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (5, 0, 'ROLE_ADMINISTRADOR', '/colheita/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (6, 0, 'ROLE_ADMINISTRADOR', '/cultivo/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (7, 0, 'ROLE_ADMINISTRADOR', '/evento/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (8, 0, 'ROLE_ADMINISTRADOR', '/implemento/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (9, 0, 'ROLE_ADMINISTRADOR', '/insumo/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (10, 0, 'ROLE_ADMINISTRADOR', '/manejoImplemento/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (11, 0, 'ROLE_ADMINISTRADOR', '/manejoInsumo/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (12, 0, 'ROLE_ADMINISTRADOR', '/ocorrenciaClima/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (13, 0, 'ROLE_ADMINISTRADOR', '/ocorrenciaPraga/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (14, 0, 'ROLE_ADMINISTRADOR', '/pagamento/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (15, 0, 'ROLE_ADMINISTRADOR', '/praga/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (16, 0, 'ROLE_ADMINISTRADOR', '/produto/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (17, 0, 'ROLE_ADMINISTRADOR', '/talhao/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (18, 0, 'ROLE_ADMINISTRADOR', '/talhaoTipoSolo/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (19, 0, 'ROLE_ADMINISTRADOR', '/tipoImplemento/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (20, 0, 'ROLE_ADMINISTRADOR', '/tipoInsumo/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (21, 0, 'ROLE_ADMINISTRADOR', '/tipoProduto/**');
INSERT INTO evento (id, version, config_attribute, url) VALUES (22, 0, 'ROLE_ADMINISTRADOR', '/tipoSolo/**');


--
-- TOC entry 2553 (class 0 OID 0)
-- Dependencies: 205
-- Name: evento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('evento_id_seq', 22, true);


--
-- TOC entry 2476 (class 0 OID 51657)
-- Dependencies: 208
-- Data for Name: implemento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO implemento (id, version, descricao_implemento, quantidade_disponivel, tipo_implemento_id) VALUES (1, 0, 'PULVERIZADOR PA-600/800 L', 0, 1);


--
-- TOC entry 2554 (class 0 OID 0)
-- Dependencies: 207
-- Name: implemento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('implemento_id_seq', 1, true);


--
-- TOC entry 2478 (class 0 OID 51667)
-- Dependencies: 210
-- Data for Name: insumo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (1, 0, 'ESTERCO DE BOVINOS', 0, 0, 0, NULL, 5);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (2, 0, 'ESTERCO DE EQUINOS', 0, 0, 0, NULL, 5);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (3, 0, 'ESTERCO DE SUÍNOS', 0, 0, 0, NULL, 5);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (4, 0, 'ESTERCO DE OVINOS', 0, 0, 0, NULL, 5);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (5, 0, 'ESTERCO DE AVES', 0, 0, 0, NULL, 5);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (6, 0, 'COMPOSTO ORGÂNICO', 0, 0, 0, NULL, 5);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (7, 0, 'URÉIA', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (8, 0, 'SULFATO DE AMÔNIO', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (9, 0, 'SUPERFOSFATO SIMPLES', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (10, 0, 'SUPERFOSFATO TRIPLO', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (11, 0, 'CLORETO DE POTÁSSIO', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (12, 0, 'SULFATO DE POTÁSSIO', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (13, 0, 'FORMULAÇÃO NPK 4-14-8', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (14, 0, 'FORMULAÇÃO NPK 4-30-16', 0, 0, 0, NULL, 6);
INSERT INTO insumo (id, version, descricao_insumo, estoque_atual, estoque_max, estoque_min, produto_id, tipo_insumo_id) VALUES (15, 0, 'MILHO TESTE', 3, 0, 0, 81, 4);


--
-- TOC entry 2555 (class 0 OID 0)
-- Dependencies: 209
-- Name: insumo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('insumo_id_seq', 15, true);


--
-- TOC entry 2480 (class 0 OID 51679)
-- Dependencies: 212
-- Data for Name: manejo_implemento; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2556 (class 0 OID 0)
-- Dependencies: 211
-- Name: manejo_implemento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('manejo_implemento_id_seq', 1, false);


--
-- TOC entry 2482 (class 0 OID 51689)
-- Dependencies: 214
-- Data for Name: manejo_insumo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2557 (class 0 OID 0)
-- Dependencies: 213
-- Name: manejo_insumo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('manejo_insumo_id_seq', 1, false);


--
-- TOC entry 2484 (class 0 OID 51699)
-- Dependencies: 216
-- Data for Name: ocorrencia_clima; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 215
-- Name: ocorrencia_clima_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ocorrencia_clima_id_seq', 1, false);


--
-- TOC entry 2486 (class 0 OID 51709)
-- Dependencies: 218
-- Data for Name: ocorrencia_praga; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 217
-- Name: ocorrencia_praga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ocorrencia_praga_id_seq', 1, true);


--
-- TOC entry 2488 (class 0 OID 51719)
-- Dependencies: 220
-- Data for Name: pagamento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO pagamento (id, version, aquisicao_id, data_pagamento, data_parcela, desconto, juros, multa, observacao, parcela_numero, valor_pago, valor_parcela) VALUES (1, 0, 1, NULL, '2016-05-18 00:00:00', 0, 0, 0, NULL, 1, 0, 8);
INSERT INTO pagamento (id, version, aquisicao_id, data_pagamento, data_parcela, desconto, juros, multa, observacao, parcela_numero, valor_pago, valor_parcela) VALUES (2, 0, 1, NULL, '2016-06-17 00:00:00', 0, 0, 0, NULL, 2, 0, 8);
INSERT INTO pagamento (id, version, aquisicao_id, data_pagamento, data_parcela, desconto, juros, multa, observacao, parcela_numero, valor_pago, valor_parcela) VALUES (3, 0, 1, NULL, '2016-07-17 00:00:00', 0, 0, 0, NULL, 3, 0, 8);


--
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 219
-- Name: pagamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pagamento_id_seq', 3, true);


--
-- TOC entry 2490 (class 0 OID 51731)
-- Dependencies: 222
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
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 221
-- Name: pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pais_id_seq', 253, false);


--
-- TOC entry 2492 (class 0 OID 51743)
-- Dependencies: 224
-- Data for Name: praga; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO praga (id, version, descricao_praga) VALUES (1, 0, 'TESTE');


--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 223
-- Name: praga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('praga_id_seq', 1, true);


--
-- TOC entry 2494 (class 0 OID 51753)
-- Dependencies: 226
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (1, 0, 'ABACATE', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (2, 0, 'ABACAXI', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (3, 0, 'ABIU', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (4, 0, 'ATEMÓIA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (5, 0, 'BANANA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (6, 0, 'BLUEBERRY OU MIRTILO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (7, 0, 'CACAU', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (8, 0, 'CAJÁ', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (9, 0, 'CAJU', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (10, 0, 'CAMBUCI', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (11, 0, 'CAQUI', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (12, 0, 'CARAMBOLA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (13, 0, 'CEREJA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (14, 0, 'CHIRIMOYA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (15, 0, 'CIDRA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (16, 0, 'COCO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (17, 0, 'CUPUAÇU', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (18, 0, 'DAMASCO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (19, 0, 'FRAMBOESA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (20, 0, 'FRUTA PÃO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (21, 0, 'GOIABA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (22, 0, 'GRAPEFRUIT', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (23, 0, 'GRAVIOLA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (24, 0, 'JABUTICABA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (25, 0, 'JACA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (26, 0, 'JAMBO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (27, 0, 'JENIPAPO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (28, 0, 'KINO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (29, 0, 'KIWI', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (30, 0, 'LARANJA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (31, 0, 'LICHIA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (32, 1, 'LIMA DA PÉRSIA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (33, 0, 'LIMÃO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (34, 0, 'MAÇÃ', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (35, 0, 'MAMÃO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (36, 0, 'MANGA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (37, 0, 'MARACUJÁ', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (38, 0, 'MARMELO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (39, 0, 'MELÂNCIA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (40, 0, 'MELÃO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (41, 0, 'MEXERICA OU TANGERINA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (42, 0, 'MORANGO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (43, 0, 'NECTARINA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (44, 0, 'NÊSPERA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (45, 0, 'PERA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (46, 0, 'PÊSSEGO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (47, 0, 'PHYSALIS', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (48, 0, 'PITANGA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (49, 0, 'RAMBUTAM', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (50, 0, 'ROMÃ', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (51, 0, 'SAPOTI', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (52, 0, 'SERIGUELA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (53, 1, 'TAMARINDO', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (54, 0, 'TOMAT', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (55, 0, 'UMBU', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (56, 0, 'UVA ROXA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (57, 0, 'UVA VERD', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (58, 0, 'UVA VERMELHA', 3);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (59, 0, 'ABÓBORA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (61, 0, 'AIPIM', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (62, 0, 'ALHO', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (63, 0, 'ASPARGO', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (64, 0, 'BATATA BAROA OU MANDIOQUINHA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (67, 0, 'BATATA INGLESA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (60, 1, 'ABOBRINHA VERDE', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (65, 1, 'BATATA DOCE', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (68, 0, 'BATATA YACOM', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (69, 0, 'BERINJELA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (70, 0, 'BETERRABA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (71, 0, 'BRÓCOLIS', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (72, 0, 'CARÁ', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (73, 0, 'CEBOLA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (74, 0, 'CENOURA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (75, 0, 'CHUCHU', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (76, 0, 'COUVE-FLOR', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (77, 0, 'ERVILHA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (78, 0, 'INHAME', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (79, 0, 'JILÓ', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (80, 0, 'MAXIXE', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (81, 0, 'MILHO', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (82, 0, 'NABO', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (83, 0, 'PALMITO PUPUNHA', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (84, 0, 'PEPINO', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (85, 0, 'PIMENTÃO', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (86, 0, 'QUIABO', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (87, 0, 'RABANETE', 2);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (88, 0, 'AGRIÃO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (89, 0, 'AIPO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (90, 0, 'ALECRIM', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (91, 0, 'ALFACE', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (92, 0, 'ALHO-PORÓ', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (93, 0, 'ALMEIRÃO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (94, 0, 'BROTO DE ALFAFA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (95, 0, 'BROTO DE FEIJÃO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (96, 0, 'BROTO DE LENTILHA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (97, 0, 'BROTO DE TREVO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (98, 0, 'CEBOLINHA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (99, 0, 'CHICÓRIA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (100, 0, 'COENTRO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (101, 0, 'COUVE', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (102, 0, 'COUVE CHINESA OU ACELGA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (103, 0, 'COUVE DE BRUXELAS', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (104, 0, 'ENDÍVIA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (105, 0, 'ESPINAFRE', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (106, 0, 'HORTELÃ', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (107, 0, 'MANJERICÃO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (108, 0, 'MOSTARDA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (109, 0, 'REPOLHO', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (110, 0, 'SALSA', 1);
INSERT INTO produto (id, version, descricao_produto, tipo_produto_id) VALUES (111, 0, 'TOMILHO', 1);


--
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 225
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('produto_id_seq', 112, false);


--
-- TOC entry 2496 (class 0 OID 51763)
-- Dependencies: 228
-- Data for Name: talhao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO talhao (id, version, area_total, descricao_talhao) VALUES (1, 0, 1000, 'TALHÃO A');


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 227
-- Name: talhao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('talhao_id_seq', 1, true);


--
-- TOC entry 2498 (class 0 OID 51773)
-- Dependencies: 230
-- Data for Name: talhao_tipo_solo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO talhao_tipo_solo (id, version, porcentagem_area, talhao_id, tipo_solo_id) VALUES (1, 0, 100, 1, 1);


--
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 229
-- Name: talhao_tipo_solo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('talhao_tipo_solo_id_seq', 1, true);


--
-- TOC entry 2500 (class 0 OID 51781)
-- Dependencies: 232
-- Data for Name: tipo_implemento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipo_implemento (id, version, descricao_tipo_implemento) VALUES (1, 0, 'PLANTIO');


--
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 231
-- Name: tipo_implemento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_implemento_id_seq', 1, true);


--
-- TOC entry 2502 (class 0 OID 51791)
-- Dependencies: 234
-- Data for Name: tipo_insumo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipo_insumo (id, version, classificacao, descricao_tipo_insumo) VALUES (1, 0, 'ORGÂNICO', '*MUDA*');
INSERT INTO tipo_insumo (id, version, classificacao, descricao_tipo_insumo) VALUES (2, 0, 'INORGÂNICO', '*MUDA*');
INSERT INTO tipo_insumo (id, version, classificacao, descricao_tipo_insumo) VALUES (3, 0, 'ORGÂNICO', '*SEMENTE*');
INSERT INTO tipo_insumo (id, version, classificacao, descricao_tipo_insumo) VALUES (4, 0, 'INORGÂNICO', '*SEMENTE*');
INSERT INTO tipo_insumo (id, version, classificacao, descricao_tipo_insumo) VALUES (5, 0, 'ORGÂNICO', 'ADUBO');
INSERT INTO tipo_insumo (id, version, classificacao, descricao_tipo_insumo) VALUES (6, 1, 'INORGÂNICO', 'FERTILIZANTE QUÍMICO');


--
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 233
-- Name: tipo_insumo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_insumo_id_seq', 7, false);


--
-- TOC entry 2504 (class 0 OID 51801)
-- Dependencies: 236
-- Data for Name: tipo_produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipo_produto (id, version, descricao_tipo_produto) VALUES (1, 0, 'VERDURA');
INSERT INTO tipo_produto (id, version, descricao_tipo_produto) VALUES (2, 0, 'LEGUME');
INSERT INTO tipo_produto (id, version, descricao_tipo_produto) VALUES (3, 0, 'FRUTA');


--
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 235
-- Name: tipo_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_produto_id_seq', 4, false);


--
-- TOC entry 2506 (class 0 OID 51811)
-- Dependencies: 238
-- Data for Name: tipo_solo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipo_solo (id, version, descricao_tipo_solo) VALUES (1, 0, 'ARGILOSO');


--
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 237
-- Name: tipo_solo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipo_solo_id_seq', 1, true);


--
-- TOC entry 2200 (class 2606 OID 51543)
-- Name: acesso_autoridade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_autoridade
    ADD CONSTRAINT acesso_autoridade_pkey PRIMARY KEY (autoridade_id, acesso_id);


--
-- TOC entry 2196 (class 2606 OID 51536)
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2198 (class 2606 OID 51538)
-- Name: acesso_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso
    ADD CONSTRAINT acesso_username_key UNIQUE (username);


--
-- TOC entry 2206 (class 2606 OID 51562)
-- Name: aquisicao_implemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_implemento
    ADD CONSTRAINT aquisicao_implemento_pkey PRIMARY KEY (id);


--
-- TOC entry 2208 (class 2606 OID 51570)
-- Name: aquisicao_insumo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_insumo
    ADD CONSTRAINT aquisicao_insumo_pkey PRIMARY KEY (id);


--
-- TOC entry 2202 (class 2606 OID 51554)
-- Name: aquisicao_nota_fiscal_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao
    ADD CONSTRAINT aquisicao_nota_fiscal_key UNIQUE (nota_fiscal);


--
-- TOC entry 2204 (class 2606 OID 51552)
-- Name: aquisicao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao
    ADD CONSTRAINT aquisicao_pkey PRIMARY KEY (id);


--
-- TOC entry 2210 (class 2606 OID 51581)
-- Name: audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- TOC entry 2212 (class 2606 OID 51591)
-- Name: autoridade_authority_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY autoridade
    ADD CONSTRAINT autoridade_authority_key UNIQUE (authority);


--
-- TOC entry 2214 (class 2606 OID 51589)
-- Name: autoridade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY autoridade
    ADD CONSTRAINT autoridade_pkey PRIMARY KEY (id);


--
-- TOC entry 2216 (class 2606 OID 51601)
-- Name: cidade_nome_cidade_estado_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT cidade_nome_cidade_estado_id_key UNIQUE (nome_cidade, estado_id);


--
-- TOC entry 2218 (class 2606 OID 51599)
-- Name: cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT cidade_pkey PRIMARY KEY (id);


--
-- TOC entry 2220 (class 2606 OID 51611)
-- Name: clima_descricao_clima_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clima
    ADD CONSTRAINT clima_descricao_clima_key UNIQUE (descricao_clima);


--
-- TOC entry 2222 (class 2606 OID 51609)
-- Name: clima_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clima
    ADD CONSTRAINT clima_pkey PRIMARY KEY (id);


--
-- TOC entry 2224 (class 2606 OID 51621)
-- Name: colheita_cultivo_id_insumo_id_data_colheita_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY colheita
    ADD CONSTRAINT colheita_cultivo_id_insumo_id_data_colheita_key UNIQUE (cultivo_id, insumo_id, data_colheita);


--
-- TOC entry 2226 (class 2606 OID 51619)
-- Name: colheita_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY colheita
    ADD CONSTRAINT colheita_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 51629)
-- Name: cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivo
    ADD CONSTRAINT cultivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2230 (class 2606 OID 51639)
-- Name: estado_nome_estado_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_nome_estado_key UNIQUE (nome_estado);


--
-- TOC entry 2232 (class 2606 OID 51637)
-- Name: estado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2234 (class 2606 OID 51641)
-- Name: estado_sigla_estado_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_sigla_estado_key UNIQUE (sigla_estado);


--
-- TOC entry 2236 (class 2606 OID 51652)
-- Name: evento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 51654)
-- Name: evento_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_url_key UNIQUE (url);


--
-- TOC entry 2240 (class 2606 OID 51664)
-- Name: implemento_descricao_implemento_tipo_implemento_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY implemento
    ADD CONSTRAINT implemento_descricao_implemento_tipo_implemento_id_key UNIQUE (descricao_implemento, tipo_implemento_id);


--
-- TOC entry 2242 (class 2606 OID 51662)
-- Name: implemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY implemento
    ADD CONSTRAINT implemento_pkey PRIMARY KEY (id);


--
-- TOC entry 2244 (class 2606 OID 51676)
-- Name: insumo_descricao_insumo_tipo_insumo_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY insumo
    ADD CONSTRAINT insumo_descricao_insumo_tipo_insumo_id_key UNIQUE (descricao_insumo, tipo_insumo_id);


--
-- TOC entry 2246 (class 2606 OID 51672)
-- Name: insumo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY insumo
    ADD CONSTRAINT insumo_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 51674)
-- Name: insumo_produto_id_tipo_insumo_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY insumo
    ADD CONSTRAINT insumo_produto_id_tipo_insumo_id_key UNIQUE (produto_id, tipo_insumo_id);


--
-- TOC entry 2250 (class 2606 OID 51686)
-- Name: manejo_implemento_cultivo_id_implemento_id_data_hora_inicio_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_implemento
    ADD CONSTRAINT manejo_implemento_cultivo_id_implemento_id_data_hora_inicio_key UNIQUE (cultivo_id, implemento_id, data_hora_inicio);


--
-- TOC entry 2252 (class 2606 OID 51684)
-- Name: manejo_implemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_implemento
    ADD CONSTRAINT manejo_implemento_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 51696)
-- Name: manejo_insumo_cultivo_id_insumo_id_data_manejo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_insumo
    ADD CONSTRAINT manejo_insumo_cultivo_id_insumo_id_data_manejo_key UNIQUE (cultivo_id, insumo_id, data_manejo);


--
-- TOC entry 2256 (class 2606 OID 51694)
-- Name: manejo_insumo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_insumo
    ADD CONSTRAINT manejo_insumo_pkey PRIMARY KEY (id);


--
-- TOC entry 2258 (class 2606 OID 51706)
-- Name: ocorrencia_clima_cultivo_id_clima_id_data_clima_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_clima
    ADD CONSTRAINT ocorrencia_clima_cultivo_id_clima_id_data_clima_key UNIQUE (cultivo_id, clima_id, data_clima);


--
-- TOC entry 2260 (class 2606 OID 51704)
-- Name: ocorrencia_clima_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_clima
    ADD CONSTRAINT ocorrencia_clima_pkey PRIMARY KEY (id);


--
-- TOC entry 2262 (class 2606 OID 51716)
-- Name: ocorrencia_praga_cultivo_id_praga_id_data_descoberta_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_praga
    ADD CONSTRAINT ocorrencia_praga_cultivo_id_praga_id_data_descoberta_key UNIQUE (cultivo_id, praga_id, data_descoberta);


--
-- TOC entry 2264 (class 2606 OID 51714)
-- Name: ocorrencia_praga_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_praga
    ADD CONSTRAINT ocorrencia_praga_pkey PRIMARY KEY (id);


--
-- TOC entry 2266 (class 2606 OID 51728)
-- Name: pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pagamento
    ADD CONSTRAINT pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2268 (class 2606 OID 51738)
-- Name: pais_country_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_country_name_key UNIQUE (country_name);


--
-- TOC entry 2270 (class 2606 OID 51740)
-- Name: pais_nome_pais_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_nome_pais_key UNIQUE (nome_pais);


--
-- TOC entry 2272 (class 2606 OID 51736)
-- Name: pais_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (id);


--
-- TOC entry 2274 (class 2606 OID 51750)
-- Name: praga_descricao_praga_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY praga
    ADD CONSTRAINT praga_descricao_praga_key UNIQUE (descricao_praga);


--
-- TOC entry 2276 (class 2606 OID 51748)
-- Name: praga_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY praga
    ADD CONSTRAINT praga_pkey PRIMARY KEY (id);


--
-- TOC entry 2278 (class 2606 OID 51760)
-- Name: produto_descricao_produto_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_descricao_produto_key UNIQUE (descricao_produto);


--
-- TOC entry 2280 (class 2606 OID 51758)
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2282 (class 2606 OID 51770)
-- Name: talhao_descricao_talhao_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao
    ADD CONSTRAINT talhao_descricao_talhao_key UNIQUE (descricao_talhao);


--
-- TOC entry 2284 (class 2606 OID 51768)
-- Name: talhao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao
    ADD CONSTRAINT talhao_pkey PRIMARY KEY (id);


--
-- TOC entry 2286 (class 2606 OID 51778)
-- Name: talhao_tipo_solo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_tipo_solo
    ADD CONSTRAINT talhao_tipo_solo_pkey PRIMARY KEY (id);


--
-- TOC entry 2288 (class 2606 OID 51788)
-- Name: tipo_implemento_descricao_tipo_implemento_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_implemento
    ADD CONSTRAINT tipo_implemento_descricao_tipo_implemento_key UNIQUE (descricao_tipo_implemento);


--
-- TOC entry 2290 (class 2606 OID 51786)
-- Name: tipo_implemento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_implemento
    ADD CONSTRAINT tipo_implemento_pkey PRIMARY KEY (id);


--
-- TOC entry 2292 (class 2606 OID 51798)
-- Name: tipo_insumo_descricao_tipo_insumo_classificacao_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_insumo
    ADD CONSTRAINT tipo_insumo_descricao_tipo_insumo_classificacao_key UNIQUE (descricao_tipo_insumo, classificacao);


--
-- TOC entry 2294 (class 2606 OID 51796)
-- Name: tipo_insumo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_insumo
    ADD CONSTRAINT tipo_insumo_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 51808)
-- Name: tipo_produto_descricao_tipo_produto_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_produto
    ADD CONSTRAINT tipo_produto_descricao_tipo_produto_key UNIQUE (descricao_tipo_produto);


--
-- TOC entry 2298 (class 2606 OID 51806)
-- Name: tipo_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_produto
    ADD CONSTRAINT tipo_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2300 (class 2606 OID 51818)
-- Name: tipo_solo_descricao_tipo_solo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_solo
    ADD CONSTRAINT tipo_solo_descricao_tipo_solo_key UNIQUE (descricao_tipo_solo);


--
-- TOC entry 2302 (class 2606 OID 51816)
-- Name: tipo_solo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipo_solo
    ADD CONSTRAINT tipo_solo_pkey PRIMARY KEY (id);


--
-- TOC entry 2329 (class 2620 OID 51958)
-- Name: tr_aquisicao; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_aquisicao AFTER UPDATE OF dia_vencimento, quantidade_parcela, valor_total ON aquisicao FOR EACH ROW EXECUTE PROCEDURE fn_update_parcela();


--
-- TOC entry 2330 (class 2620 OID 51959)
-- Name: tr_aquisicao_implemento; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_aquisicao_implemento AFTER INSERT OR DELETE OR UPDATE ON aquisicao_implemento FOR EACH ROW EXECUTE PROCEDURE fn_update_aquisicao();


--
-- TOC entry 2332 (class 2620 OID 51960)
-- Name: tr_aquisicao_insumo; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_aquisicao_insumo AFTER INSERT OR DELETE OR UPDATE ON aquisicao_insumo FOR EACH ROW EXECUTE PROCEDURE fn_update_aquisicao();


--
-- TOC entry 2331 (class 2620 OID 51962)
-- Name: tr_estoque_implemento; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_estoque_implemento AFTER INSERT OR DELETE OR UPDATE ON aquisicao_implemento FOR EACH ROW EXECUTE PROCEDURE fn_estoque_aquisicao_implemento();


--
-- TOC entry 2333 (class 2620 OID 51961)
-- Name: tr_estoque_insumo; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_estoque_insumo AFTER INSERT OR DELETE OR UPDATE ON aquisicao_insumo FOR EACH ROW EXECUTE PROCEDURE fn_estoque_aquisicao_insumo();


--
-- TOC entry 2334 (class 2620 OID 51964)
-- Name: tr_manejo_implemento; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_manejo_implemento AFTER INSERT OR DELETE OR UPDATE ON manejo_implemento FOR EACH ROW EXECUTE PROCEDURE fn_estoque_manejo_implemento();


--
-- TOC entry 2335 (class 2620 OID 51963)
-- Name: tr_manejo_insumo; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_manejo_insumo AFTER INSERT OR DELETE OR UPDATE ON manejo_insumo FOR EACH ROW EXECUTE PROCEDURE fn_estoque_manejo_insumo();


--
-- TOC entry 2325 (class 2606 OID 51929)
-- Name: fk2e9a13269f4cea69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pagamento
    ADD CONSTRAINT fk2e9a13269f4cea69 FOREIGN KEY (aquisicao_id) REFERENCES aquisicao(id);


--
-- TOC entry 2312 (class 2606 OID 51864)
-- Name: fk42d82928e0ede8ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cultivo
    ADD CONSTRAINT fk42d82928e0ede8ab FOREIGN KEY (talhao_id) REFERENCES talhao(id);


--
-- TOC entry 2328 (class 2606 OID 51944)
-- Name: fk43b3df62413da6b4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_tipo_solo
    ADD CONSTRAINT fk43b3df62413da6b4 FOREIGN KEY (tipo_solo_id) REFERENCES tipo_solo(id);


--
-- TOC entry 2327 (class 2606 OID 51939)
-- Name: fk43b3df62e0ede8ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talhao_tipo_solo
    ADD CONSTRAINT fk43b3df62e0ede8ab FOREIGN KEY (talhao_id) REFERENCES talhao(id);


--
-- TOC entry 2322 (class 2606 OID 51914)
-- Name: fk7b52542c827764c9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_clima
    ADD CONSTRAINT fk7b52542c827764c9 FOREIGN KEY (clima_id) REFERENCES clima(id);


--
-- TOC entry 2321 (class 2606 OID 51909)
-- Name: fk7b52542cc0ff3889; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_clima
    ADD CONSTRAINT fk7b52542cc0ff3889 FOREIGN KEY (cultivo_id) REFERENCES cultivo(id);


--
-- TOC entry 2323 (class 2606 OID 51919)
-- Name: fk7c0c2131c0ff3889; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_praga
    ADD CONSTRAINT fk7c0c2131c0ff3889 FOREIGN KEY (cultivo_id) REFERENCES cultivo(id);


--
-- TOC entry 2324 (class 2606 OID 51924)
-- Name: fk7c0c2131f90a8aa9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_praga
    ADD CONSTRAINT fk7c0c2131f90a8aa9 FOREIGN KEY (praga_id) REFERENCES praga(id);


--
-- TOC entry 2304 (class 2606 OID 51824)
-- Name: fk8f2f06571daf6917; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_autoridade
    ADD CONSTRAINT fk8f2f06571daf6917 FOREIGN KEY (autoridade_id) REFERENCES autoridade(id);


--
-- TOC entry 2303 (class 2606 OID 51819)
-- Name: fk8f2f0657619bea97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acesso_autoridade
    ADD CONSTRAINT fk8f2f0657619bea97 FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2319 (class 2606 OID 51899)
-- Name: fk9d314478b3a79a40; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_insumo
    ADD CONSTRAINT fk9d314478b3a79a40 FOREIGN KEY (insumo_id) REFERENCES aquisicao_insumo(id);


--
-- TOC entry 2320 (class 2606 OID 51904)
-- Name: fk9d314478c0ff3889; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_insumo
    ADD CONSTRAINT fk9d314478c0ff3889 FOREIGN KEY (cultivo_id) REFERENCES cultivo(id);


--
-- TOC entry 2318 (class 2606 OID 51894)
-- Name: fkabf6de7bc0ff3889; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_implemento
    ADD CONSTRAINT fkabf6de7bc0ff3889 FOREIGN KEY (cultivo_id) REFERENCES cultivo(id);


--
-- TOC entry 2317 (class 2606 OID 51889)
-- Name: fkabf6de7bc8658460; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manejo_implemento
    ADD CONSTRAINT fkabf6de7bc8658460 FOREIGN KEY (implemento_id) REFERENCES aquisicao_implemento(id);


--
-- TOC entry 2309 (class 2606 OID 51849)
-- Name: fkaee65724193424b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT fkaee65724193424b FOREIGN KEY (estado_id) REFERENCES estado(id);


--
-- TOC entry 2313 (class 2606 OID 51869)
-- Name: fkb2e43966f3be326b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT fkb2e43966f3be326b FOREIGN KEY (pais_id) REFERENCES pais(id);


--
-- TOC entry 2316 (class 2606 OID 51884)
-- Name: fkb970fe2914401ae9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY insumo
    ADD CONSTRAINT fkb970fe2914401ae9 FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2315 (class 2606 OID 51879)
-- Name: fkb970fe292216bbf4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY insumo
    ADD CONSTRAINT fkb970fe292216bbf4 FOREIGN KEY (tipo_insumo_id) REFERENCES tipo_insumo(id);


--
-- TOC entry 2305 (class 2606 OID 51829)
-- Name: fkc124d77468f2c40b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_implemento
    ADD CONSTRAINT fkc124d77468f2c40b FOREIGN KEY (implemento_id) REFERENCES implemento(id);


--
-- TOC entry 2306 (class 2606 OID 51834)
-- Name: fkc124d7749f4cea69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_implemento
    ADD CONSTRAINT fkc124d7749f4cea69 FOREIGN KEY (aquisicao_id) REFERENCES aquisicao(id);


--
-- TOC entry 2308 (class 2606 OID 51844)
-- Name: fkc2aca1f13f85676b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_insumo
    ADD CONSTRAINT fkc2aca1f13f85676b FOREIGN KEY (insumo_id) REFERENCES insumo(id);


--
-- TOC entry 2307 (class 2606 OID 51839)
-- Name: fkc2aca1f19f4cea69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aquisicao_insumo
    ADD CONSTRAINT fkc2aca1f19f4cea69 FOREIGN KEY (aquisicao_id) REFERENCES aquisicao(id);


--
-- TOC entry 2314 (class 2606 OID 51874)
-- Name: fkc97057ac4244ac14; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY implemento
    ADD CONSTRAINT fkc97057ac4244ac14 FOREIGN KEY (tipo_implemento_id) REFERENCES tipo_implemento(id);


--
-- TOC entry 2310 (class 2606 OID 51854)
-- Name: fkda1c7cf92d57639b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY colheita
    ADD CONSTRAINT fkda1c7cf92d57639b FOREIGN KEY (insumo_id) REFERENCES manejo_insumo(id);


--
-- TOC entry 2311 (class 2606 OID 51859)
-- Name: fkda1c7cf9c0ff3889; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY colheita
    ADD CONSTRAINT fkda1c7cf9c0ff3889 FOREIGN KEY (cultivo_id) REFERENCES cultivo(id);


--
-- TOC entry 2326 (class 2606 OID 51934)
-- Name: fked8dcef983d95780; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT fked8dcef983d95780 FOREIGN KEY (tipo_produto_id) REFERENCES tipo_produto(id);


-- Completed on 2016-05-13 07:53:01

--
-- PostgreSQL database dump complete
--

