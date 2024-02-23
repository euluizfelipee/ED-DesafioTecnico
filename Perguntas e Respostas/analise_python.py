# Questão 01 
import basedosdados as bd
import pandas as pd

querry = """SELECT COUNT (*) AS  quantidade_de_chamados
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE CAST(data_inicio AS DATE) = '2023-04-01' """

df = bd.read_sql(querry, billing_project_id = "primeiro-projeto-414401")
display(df.head())

# Questão 02
import basedosdados as bd
import pandas as pd

querry = ''' SELECT tipo, COUNT(*) AS contagem
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE CAST(data_inicio AS DATE) = '2023-04-01'
GROUP BY tipo
ORDER BY contagem DESC
LIMIT 1;
'''

df = bd.read_sql(querry, billing_project_id = "primeiro-projeto-414401")
display(df.head())

# Questão 03
import basedosdados as bd
import pandas as pd


querry = """ SELECT 
  c.id_bairro, 
  b.nome AS nome_bairro,
  COUNT(*) AS contagem
FROM `datario.administracao_servicos_publicos.chamado_1746` c
JOIN `datario.dados_mestres.bairro` b ON c.id_bairro = b.id_bairro
WHERE CAST(c.data_inicio AS DATE) = '2023-04-01'
GROUP BY c.id_bairro, b.nome
ORDER BY contagem DESC
LIMIT 3;
"""

df = bd.read_sql(querry, billing_project_id = "primeiro-projeto-414401")
display(df.head())

# Questão 04
import basedosdados as bd
import pandas as pd

query = """ 
SELECT s.subprefeitura, COUNT(*) as total_chamados_abertos
FROM `datario.administracao_servicos_publicos.chamado_1746` c
JOIN `datario.dados_mestres.bairro` s ON c.id_bairro = s.id_bairro
WHERE CAST(c.data_inicio AS DATE) = '2023-04-01'
GROUP BY subprefeitura
ORDER BY total_chamados_abertos DESC
LIMIT 1;
"""

df = bd.read_sql(query, billing_project_id="primeiro-projeto-414401")

# Exibindo o DataFrame
display(df.head())

# Questão 05
import basedosdados as bd
import pandas as pd

query = """
SELECT *
FROM `datario.administracao_servicos_publicos.chamado_1746` c
WHERE CAST(c.data_inicio AS DATE) = '2023-04-01'
  AND (c.id_bairro IS NULL OR NOT EXISTS (
    SELECT 1
    FROM `datario.dados_mestres.bairro` b
    WHERE c.id_bairro = b.id_bairro
  ));
"""
df = bd.read_sql(query, billing_project_id="primeiro-projeto-414401")

# Exibindo o DataFrame
display(df.head())

# Questão 06
import basedosdados as bd
import pandas as pd

query = """
SELECT COUNT(*) AS contagem
FROM `datario.administracao_servicos_publicos.chamado_1746`
WHERE subtipo = "Perturbação do sossego" AND CAST(data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31';
"""
df = bd.read_sql(query, billing_project_id="primeiro-projeto-414401")

# Exibindo o DataFrame
display(df.head())

# Questão 07
import basedosdados as bd
import pandas as pd

query = """
SELECT c.id_chamado,
       c.data_inicio,
       c.data_fim,
       c.id_tipo,
       c.tipo,
       c.id_subtipo,
       c.subtipo,
       e.evento
FROM `datario.administracao_servicos_publicos.chamado_1746` AS c
INNER JOIN `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` AS e
ON c.data_inicio BETWEEN e.data_inicial AND e.data_final
WHERE c.subtipo = "Perturbação do sossego"
AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
AND CAST(c.data_inicio AS DATE) BETWEEN '2022-01-01' AND '2023-12-31';
"""
df = bd.read_sql(query, billing_project_id="primeiro-projeto-414401")

# Exibindo o DataFrame
display(df.head())

# Questão 08
import basedosdados as bd
import pandas as pd

query = """
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
"""
df = bd.read_sql(query, billing_project_id="primeiro-projeto-414401")

# Exibindo o DataFrame
display(df.head())

# Questão 09

import basedosdados as bd
import pandas as pd

query = """
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
"""
df = bd.read_sql(query, billing_project_id="primeiro-projeto-414401")

# Exibindo o DataFrame
display(df.head())


# Questão 10

import basedosdados as bd
import pandas as pd

query = """
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
"""
df = bd.read_sql(query, billing_project_id="primeiro-projeto-414401")

# Exibindo o DataFrame
display(df.head())