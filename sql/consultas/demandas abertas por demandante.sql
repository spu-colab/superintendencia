USE `spu-sc-dev`;

SELECT 
    ad.nome as demandante,
    o.sigla as orgao,
    count(d.id) as total,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Nova") then 1 else 0 end) as nova,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Em análise") then 1 else 0 end) as em_analise,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Pronta") then 1 else 0 end) as pronta,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Aguardando assinatura") then 1 else 0 end) as aguardando_assinatura,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Aguardando AR") then 1 else 0 end) as aguardando_ar,
    sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Resolvida") then 1 else 0 end) as resolvida
FROM 
    demanda d
    JOIN autordemanda ad ON d.idAutorDemanda = ad.id
    JOIN orgao o ON ad.idOrgao = o.id
WHERE 
    d.idSituacaoDemanda IN (SELECT id FROM situacaodemanda WHERE situacao IN ("Nova", "Em análise", "Pronta", "Aguardando assinatura", "Aguardando AR", "Resolvida"))
    -- AND d.created_at BETWEEN '2019-05-01' AND '2019-06-01' 
GROUP BY 1, 2 
ORDER BY 3 desc, 1 asc;