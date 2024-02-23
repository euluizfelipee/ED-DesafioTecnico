## Sobre a resolução das perguntas em SQL: 

##### 01. Quantidade de chamados abertos no dia 01/04/2023:

    Usa um SELECT para recuperar todas as colunas da tabela chamado_1746.
    Filtra os resultados para incluir apenas os chamados que foram abertos no dia 01/04/2023.

##### 02. Tipo de chamado com mais reclamações no dia 01/04/2023:

    Utiliza um SELECT para obter o tipo de chamado e a contagem de cada tipo.
    Filtra os resultados para incluir apenas os chamados que foram abertos no dia 01/04/2023.
    Agrupa os resultados pelo tipo de chamado.
    Ordena em ordem decrescente de contagem e limita o resultado para mostrar apenas o primeiro tipo (aquele com mais reclamações).

##### 03. Três bairros com mais chamados abertos no dia 01/04/2023:

    Faz um SELECT para recuperar o ID do bairro, o nome do bairro e a contagem de chamados para cada bairro.
    Realiza um JOIN com a tabela bairro para obter o nome do bairro.
    Filtra os resultados para incluir apenas os chamados que foram abertos no dia 01/04/2023.
    Agrupa os resultados pelo ID do bairro e nome do bairro.
    Ordena em ordem decrescente de contagem e limita o resultado para mostrar apenas os três primeiros bairros.

##### 04. Nome da subprefeitura com mais chamados abertos no dia 01/04/2023:

    Utiliza um SELECT para obter o nome da subprefeitura e a contagem total de chamados.
    Realiza um JOIN com a tabela bairro para obter a subprefeitura correspondente.
    Filtra os resultados para incluir apenas os chamados que foram abertos no dia 01/04/2023.
    Agrupa os resultados pelo nome da subprefeitura.
    Ordena em ordem decrescente de contagem e limita o resultado para mostrar apenas a subprefeitura com mais chamados.

##### 05. Chamados abertos no dia 01/04/2023 sem associação a um bairro ou subprefeitura:

    Utiliza um SELECT para recuperar todos os campos da tabela chamado_1746.
    Filtra os resultados para incluir apenas os chamados que foram abertos no dia 01/04/2023 e não estão associados a um bairro na tabela de bairros.

##### 06. Quantidade de chamados do subtipo "Perturbação do sossego" entre 01/01/2022 e 31/12/2023:

    Utiliza um SELECT para contar a quantidade de chamados com o subtipo "Perturbação do sossego" que foram abertos no período especificado.

##### 07. Chamados do subtipo "Perturbação do sossego" durante eventos específicos:

    Realiza um JOIN com a tabela de eventos para obter chamados que ocorreram durante eventos específicos (Reveillon, Carnaval, Rock in Rio) e têm o subtipo "Perturbação do sossego".

##### 08. Quantidade de chamados do subtipo "Perturbação do sossego" em cada evento:

    Utiliza um SELECT para contar a quantidade de chamados com o subtipo "Perturbação do sossego" em cada evento específico.

##### 09. Evento com a maior média diária de chamados do subtipo "Perturbação do sossego":

    Usa uma CTE (Common Table Expression) para calcular a média diária de chamados para cada evento.
    Seleciona o evento com a maior média diária.

##### 10. Comparação das médias diárias de chamados do subtipo "Perturbação do sossego" durante eventos específicos e durante o período total:

    Utiliza duas CTEs para calcular as médias diárias de chamados durante eventos específicos e durante todo o período.
    Realiza uma união (UNION ALL) para comparar as médias diárias.


### Ánalise Complementar

##### 01. 10 subtipos de chamados com mais ocorrências:

    A consulta retorna os 10 subtipos de chamados de serviço com maior quantidade de ocorrências da tabela específica. Conta o número de ocorrências para cada subtipo, agrupa-os por subtipo, e ordena os resultados em ordem decrescente pelo total de ocorrências. Por fim, limita a saída aos 10 subtipos mais frequentes.

##### 02. Comparação de quantidade de chamados que foram concluidos dentro e fora do prazo: 

    A consulta compara a quantidade de chamados de serviço que foram concluídos dentro e fora do prazo. Conta as ocorrências de cada categoria (dentro_prazo - dentro do prazo ou fora_prazo - fora do prazo) e agrupa-as conforme a categoria

##### 03. Cinco unidades correcionais com mais chamados abertos:

    A consulta identifica as cinco unidades correcionais com o maior número de chamados de serviço abertos. Conta as ocorrências para cada unidade correcional, agrupa-as pelo nome da unidade e ordena os resultados em ordem decrescente pelo total de ocorrências.

##### 04. Os cinco bairros com mais chamdos durante toda as datas da tabela.

    A consulta recupera os cinco bairros com o maior número total de chamados de serviço. Realiza um join entre a tabela de chamados de serviço e a tabela de dados mestres de bairros, conta as ocorrências para cada bairro, agrupa-as pelo ID e nome do bairro, e ordena os resultados em ordem decrescente pelo total de ocorrências.

##### 05. OS três chamados e os bairros do chamado com mais reclamações.

    A consulta retorna os três chamados de serviço com o maior número de reclamações. Inclui o ID do chamado, a quantidade de reclamações e o nome do bairro correspondente. Os resultados são ordenados em ordem decrescente pela quantidade de reclamações, e apenas os três primeiros registros são incluídos na saída.