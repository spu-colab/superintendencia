use `spu-sc`;

SELECT
    (SELECT count(id) FROM demanda WHERE idsituacaodemanda NOT IN (3,4)) as em_analise,
    (SELECT count(id) FROM demanda WHERE idsituacaodemanda NOT IN (3,4) 
        AND DATE_FORMAT(dataPrazo, '%Y-%m-%d') < DATE_FORMAT(NOW(), '%Y-%m-%d')
        AND dataResposta IS NULL) as atrasadas,
    (SELECT count(id) FROM demanda WHERE idsituacaodemanda NOT IN (3,4) 
        AND sentencajudicial = true) as sentencajudicial;