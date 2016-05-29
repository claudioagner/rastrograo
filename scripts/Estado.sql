INSERT INTO public.estado ("id", "version", "nome_estado", "pais_id", "sigla")
VALUES
  (1, 0, 'ACRE', 33, 'AC'),
  (2, 0, 'ALAGOAS', 33, 'AL'),
  (3, 0, 'AMAZONAS', 33, 'AM'),
  (4, 0, 'AMAPÁ', 33, 'AP'),
  (5, 0, 'BAHIA', 33, 'BA'),
  (6, 0, 'CEARÁ', 33, 'CE'),
  (7, 0, 'DISTRITO FEDERAL', 33, 'DF'),
  (8, 0, 'ESPÍRITO SANTO', 33, 'ES'),
  (9, 0, 'GOIÁS', 33, 'GO'),
  (10, 0, 'MARANHÃO', 33, 'MA'),
  (11, 0, 'MINAS GERAIS', 33, 'MG'),
  (12, 0, 'MATO GROSSO DO SUL', 33, 'MS'),
  (13, 0, 'MATO GROSSO', 33, 'MT'),
  (14, 0, 'PARÁ', 33, 'PA'),
  (15, 0, 'PARAÍBA', 33, 'PB'),
  (16, 0, 'PERNAMBUCO', 33, 'PE'),
  (17, 0, 'PIAUÍ', 33, 'PI'),
  (18, 0, 'PARANÁ', 33, 'PR'),
  (19, 0, 'RIO DE JANEIRO', 33, 'RJ'),
  (20, 0, 'RIO GRANDE DO NORTE', 33, 'RN'),
  (21, 0, 'RONDÔNIA', 33, 'RO'),
  (22, 0, 'RORAIMA', 33, 'RR'),
  (23, 0, 'RIO GRANDE DO SUL', 33, 'RS'),
  (24, 0, 'SANTA CATARINA', 33, 'SC'),
  (25, 0, 'SERGIPE', 33, 'SE'),
  (26, 0, 'SÃO PAULO', 33, 'SP'),
  (27, 0, 'TOCANTINS', 33, 'TO');

ALTER SEQUENCE public.estado_id_seq
  INCREMENT 1 MINVALUE 1
  MAXVALUE 9223372036854775807 START 1
  RESTART 28 CACHE 1
  NO CYCLE;  