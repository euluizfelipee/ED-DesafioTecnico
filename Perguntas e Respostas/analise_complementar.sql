-- 10 subtipos de chamados com mais ocorrências
SELECT subtipo, COUNT(*) as total_chamados
FROM `datario.administracao_servicos_publicos.chamado_1746`
GROUP BY subtipo
ORDER BY total_chamados DESC
LIMIT 10;

-- Comparação de quantidade de chamados que foram concluidos dentro e fora do prazo.
SELECT dentro_prazo, COUNT(*) as total_chamados
FROM `datario.administracao_servicos_publicos.chamado_1746`
GROUP BY dentro_prazo;

-- Cinco unidades correcionais com mais chamados abertos:
SELECT nome_unidade_organizacional, COUNT(*) as total_chamados
FROM `datario.administracao_servicos_publicos.chamado_1746`
GROUP BY nome_unidade_organizacional
ORDER BY total_chamados DESC
LIMIT 5;

-- Os cinco bairros com mais chamdos durante toda as datas da tabela.
SELECT s.id_bairro, s.nome, COUNT(*) as total_chamados_bairro
FROM `datario.administracao_servicos_publicos.chamado_1746` c
JOIN `datario.dados_mestres.bairro` s ON c.id_bairro = s.id_bairro
GROUP BY s.id_bairro, s.nome
ORDER BY total_chamados_bairro DESC
LIMIT 5;

-- OS três chamados e os bairros do chamado com mais reclamações.
SELECT
  chamado.id_chamado,
  chamado.reclamacoes,
  bairro.nome AS nome_bairro
FROM
  `datario.administracao_servicos_publicos.chamado_1746` AS chamado
JOIN
  `datario.dados_mestres.bairro` AS bairro
ON
  chamado.id_bairro = bairro.id_bairro
ORDER BY
  chamado.reclamacoes DESC
LIMIT
  3;

