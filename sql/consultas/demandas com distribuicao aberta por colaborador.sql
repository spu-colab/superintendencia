USE `spu-sc`;
-- demandas com distribuicao não atendida por colaborador
SELECT 
    case dd.assignable_type when 
        "App\\User" then u.name 
        else do.sigla 
        end as colaborador,
    count(dd.id) as demandas_distribuidas
FROM
    demanda d
    JOIN distribuicaodemanda dd ON dd.idDemanda = d.id
    JOIN situacaodemanda sd ON sd.id = d.idSituacaoDemanda
    LEFT JOIN users u ON u.id = dd.assignable_id AND dd.assignable_type = "App\\User"
    LEFT JOIN divisaoorganograma do ON do.id = dd.assignable_id AND dd.assignable_type = "App\\DivisaoOrganograma"
WHERE
    sd.situacao = 'Em análise'
    AND dd.dataAtendimento is null
GROUP BY
    colaborador;