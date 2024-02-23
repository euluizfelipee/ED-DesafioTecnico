--1. Quantos chamados foram abertos no dia 01/04/2023?
SELECT *
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE CAST(data_inicio AS DATE) = '2023-04-01';

--2. Qual o tipo de chamado que teve mais reclamações no dia 01/04/2023?
SELECT tipo, COUNT(*) AS contagem
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE CAST(data_inicio AS DATE) = '2023-04-01'
GROUP BY tipo
ORDER BY contagem DESC
LIMIT 1;

--3. Quais os nomes dos 3 bairros que mais tiveram chamados abertos nesse dia?
SELECT 
  c.id_bairro, 
  b.nome AS nome_bairro,
  COUNT(*) AS contagem
FROM `datario.administracao_servicos_publicos.chamado_1746` c
JOIN `datario.dados_mestres.bairro` b ON c.id_bairro = b.id_bairro
WHERE CAST(c.data_inicio AS DATE) = '2023-04-01'
GROUP BY c.id_bairro, b.nome
ORDER BY contagem DESC
LIMIT 3;

--4. Qual o nome da subprefeitura com mais chamados abertos nesse dia?
SELECT s.subprefeitura, COUNT(*) as total_chamados_abertos
FROM `datario.administracao_servicos_publicos.chamado_1746` c
JOIN `datario.dados_mestres.bairro` s ON c.id_bairro = s.id_bairro
WHERE CAST(c.data_inicio AS DATE) = '2023-04-01'
GROUP BY subprefeitura
ORDER BY total_chamados_abertos DESC
LIMIT 1;

-- 5. Existe algum chamado aberto nesse dia que não foi associado a um bairro ou subprefeitura na tabela de bairros? Se sim, por que isso acontece?
SELECT *
FROM `datario.administracao_servicos_publicos.chamado_1746` c
WHERE CAST(c.data_inicio AS DATE) = '2023-04-01'
  AND (c.id_bairro IS NULL OR NOT EXISTS (
    SELECT 1
    FROM `datario.dados_mestres.bairro` b
    WHERE c.id_bairro = b.id_bairro
  ));
-- Acontece em um caso como mostrado, pois o mesmo não possue dados nas colunas como id_bairro, id_territorialidade,id_logradouro e numero_logradouro.


--6. Quantos chamados com o subtipo "Perturbação do sossego" foram abertos desde 01/01/2022 até 31/12/2023 (incluindo extremidades)?
SELECT COUNT(*) AS contagem
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE subtipo = "Perturbação do sossego" AND CAST(data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31';

--7. Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon, Carnaval e Rock in Rio).
SELECT c.*
FROM `datario.administracao_servicos_publicos.chamado_1746` AS c
INNER JOIN `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` AS e
ON c.data_inicio BETWEEN e.data_inicial AND e.data_final
WHERE c.subtipo = "Perturbação do sossego"
AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
AND CAST(c.data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31';

--8. Quantos chamados desse subtipo foram abertos em cada evento?
SELECT
  e.evento,
  COUNT(*) AS total_chamados
FROM
  `datario.administracao_servicos_publicos.chamado_1746` AS c
INNER JOIN
  `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` AS e
ON
  c.data_inicio BETWEEN e.data_inicial AND e.data_final
WHERE
  c.subtipo = "Perturbação do sossego"
  AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
  AND CAST(c.data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31'
GROUP BY
  e.evento;

-- 9. Qual evento teve a maior média diária de chamados abertos desse subtipo?
WITH EventoChamados AS (
  SELECT
    e.evento,
    DATE_DIFF(e.data_final, e.data_inicial, DAY) + 1 AS dias_evento,
    COUNT(DISTINCT c.id_chamado) AS total_chamados
  FROM
    `datario.administracao_servicos_publicos.chamado_1746` AS c
  INNER JOIN
    `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` AS e
  ON
    c.data_inicio BETWEEN e.data_inicial AND e.data_final
  WHERE
    c.subtipo = "Perturbação do sossego"
    AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
    AND CAST(c.data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31'
  GROUP BY
    e.evento, dias_evento
)

SELECT
  evento,
  SUM(total_chamados) / SUM(dias_evento) AS media_diaria_chamados
FROM
  EventoChamados
GROUP BY
  evento
ORDER BY
  media_diaria_chamados DESC
LIMIT 1;


-- 10. Compare as médias diárias de chamados abertos desse subtipo durante eventos específicos (Reveillon, Carnaval e Rock in Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 até 31/12/2023
WITH EventoChamados AS (
  SELECT
    e.evento,
    DATE_DIFF(e.data_final, e.data_inicial, DAY) + 1 AS dias_evento,
    COUNT(DISTINCT c.id_chamado) AS total_chamados
  FROM
    `datario.administracao_servicos_publicos.chamado_1746` AS c
  INNER JOIN
    `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` AS e
  ON
    c.data_inicio BETWEEN e.data_inicial AND e.data_final
  WHERE
    c.subtipo = "Perturbação do sossego"
    AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
    AND CAST(c.data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31'
  GROUP BY
    e.evento, dias_evento
),

TotalChamados AS (
  SELECT
    COUNT(DISTINCT id_chamado) AS total_chamados
  FROM
    `datario.administracao_servicos_publicos.chamado_1746`
  WHERE
    subtipo = "Perturbação do sossego"
    AND CAST(data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31'
)

SELECT
  'Eventos Específicos' AS periodo,
  evento,
  SUM(total_chamados) / SUM(dias_evento) AS media_diaria_chamados
FROM
  EventoChamados
GROUP BY
  evento

UNION ALL

SELECT
  'Período Total' AS periodo,
  NULL AS evento,
  total_chamados / DATE_DIFF('2023-12-31', '2022-01-01', DAY) + 1 AS media_diaria_chamados
FROM
  TotalChamados;