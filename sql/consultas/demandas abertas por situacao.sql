USE `spu-sc-dev`;

SELECT 
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Nova") then 1 else 0 end) as nova,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Em análise") then 1 else 0 end) as em_analise,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Pronta") then 1 else 0 end) as pronta
FROM 
    demanda 
WHERE 
    idSituacaoDemanda IN (SELECT id FROM situacaodemanda WHERE situacao IN ("Nova", "Em análise", "Pronta"));