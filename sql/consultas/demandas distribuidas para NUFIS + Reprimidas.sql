SELECT DISTINCT 
    sd.situacao as situacao_demanda,
    d.nupSEI,
    td.tipodocumento,
    d.documentoExterno,
    date_format(d.dataDocumento, "%d/%m/%Y" ) as dataDocumento,
    date_format(d.dataPrazo, "%d/%m/%Y" ) as prazo,
    tpe.tipoprocedimento,
    pe.procedimento,
    pe.resumo as procedimento_resumo,
    ad.nome, 
    cargo.cargo,
    org.sigla,
    divO.sigla as distribuida_para,
    d.resumoSituacao as demanda_resumo   
FROM
    demanda d 
    JOIN situacaodemanda sd ON sd.id = d.idSituacaoDemanda
    JOIN tipodocumento td ON td.id = d.idTipoDocumento 
    JOIN procedimentoexterno pe ON pe.id = d.idProcedimentoExterno
    JOIN tipoprocedimentoexterno tpe ON tpe.id = pe.idTipoProcedimentoExterno
    JOIN autordemanda ad ON ad.id = d.idAutorDemanda 
    JOIN cargo ON cargo.id = ad.idCargo
    JOIN orgao org ON org.id = ad.idOrgao
    JOIN distribuicaodemanda dd ON dd.idDemanda = d.id
    JOIN divisaoorganograma divO ON divO.id = dd.assignable_id AND dd.assignable_type = "App\\DivisaoOrganograma"
WHERE
    divO.sigla = 'Reprimida' OR divO.sigla = 'SPU-SC-NUFIS'
ORDER BY d.dataDocumento