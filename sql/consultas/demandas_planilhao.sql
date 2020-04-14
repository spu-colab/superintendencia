SELECT
    ad.nome,
    o.sigla AS orgao_sigla,
    o.orgao,
    oPai.sigla AS orgaopai_sigla,
    oPai.orgao AS orgaopai,
    td.tipodocumento,
    d.documentoExterno,
    d.dataDocumento,
    sd.situacao,
    d.dataPrazo,
    d.dataResposta,
    d.nupSEI,
    d.demanda,
    d.resumoSituacao
FROM
    demanda d
JOIN autordemanda ad ON
    d.idAutorDemanda = ad.id
JOIN orgao o ON
    ad.idOrgao = o.id
LEFT JOIN orgao oPai ON
    oPai.id = o.idOrgaoPai
JOIN situacaodemanda sd ON
    d.idSituacaoDemanda = sd.id
JOIN tipodocumento td ON
    d.idTipoDocumento = td.id
WHERE
    d.dataResposta IS NOT NULL