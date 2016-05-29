INSERT INTO public.tipo_produto ("id", "version", "descricao_tipo_produto")
VALUES
  (1, 0, 'VERDURA'),
  (2, 0, 'LEGUME'),
  (3, 0, 'FRUTA');

ALTER SEQUENCE public.tipo_produto_id_seq
  INCREMENT 1 MINVALUE 1
  MAXVALUE 9223372036854775807 START 1
  RESTART 4 CACHE 1
  NO CYCLE;  