SELECT 
	(100 * t.resolvida / t.total) as percentual,
    t.total,
    t.resolvida
FROM 
    (SELECT
        COUNT(d.id) AS total,
        SUM(CASE(
                (
                    d.dataPrazo IS NOT NULL AND d.dataResposta <= d.dataPrazo
                ) OR d.dataPrazo IS NULL
            ) WHEN TRUE THEN 1 ELSE 0
            END) AS resolvida
    FROM
        demanda d
    JOIN situacaodemanda situacao ON
        d.idSituacaoDemanda = situacao.id
    WHERE
        d.dataPrazo BETWEEN '2020-01-01' AND '2020-01-31' OR(
            d.dataPrazo IS NULL AND d.dataResposta BETWEEN '2020-01-01' AND '2020-01-31'
        )
     ) as t