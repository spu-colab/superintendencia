USE spusc;

CREATE OR REPLACE VIEW vw_demanda AS
SELECT
    natureza.descricao as natureza,
    assunto.descricao as assunto,
    -- concat(substring(demanda.descricao, 1, 100), "...") as descricao, 
    demanda.descricao as descricao,
    origem.descricao AS origem, 
    demandante.nome AS demandante,
    demanda.oficio, 
    processo.edit AS sei,
    situacao.descricao AS situacao,
    demanda.dtinc AS datainclusao,
    demanda.dtinc AS dataprazo
FROM 
    cda_demanda AS demanda
    JOIN cda_demanda_natureza as natureza ON demanda.natureza = natureza.codigo
    JOIN cda_demanda_assunto as assunto ON demanda.assunto = assunto.codigo
    JOIN cda_demanda_origem AS origem ON demanda.origem = origem.codigo
    JOIN cda_demanda_demandante AS demandante ON demanda.demandante = demandante.codigo
    JOIN cda_acao AS acao ON demanda.acao = acao.codigo
    JOIN cda_acao_processo AS processo ON acao.codigo = processo.acao
    JOIN cda_demanda_situacao AS situacao ON demanda.situacao = situacao.codigo
WHERE
    1 = 1
    -- AND demanda.oficio = '3311/2018-GAB-WAM';
    -- AND natureza.descricao NOT IN ('JUDICIAL', 'CIDADÃO')
    AND situacao.descricao NOT IN ('EXCLUÍDA')
    AND demanda.dtinc >= '2018-07-01'