SELECT
	nat.natureza,
    o.orgao,
    ad.nome,
    td.tipodocumento,
    d.documentoExterno,
    d.dataDocumento,
    d.dataPrazo
FROM
    demanda d
JOIN situacaodemanda sd ON 
    d.idSituacaoDemanda = sd.id
JOIN tipodocumento td ON
    d.idTipoDocumento = td.id
JOIN autordemanda ad ON
    d.idautordemanda = ad.id
JOIN orgao o ON
	ad.idOrgao = o.id
JOIN naturezaorgao nat ON
	o.idNaturezaOrgao = nat.id
WHERE
    sd.situacao IN ('Em Análise', 'Nova')