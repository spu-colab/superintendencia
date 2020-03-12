SELECT
    date(atend.dataHoraInicio) as dia,
    count(atend.id) as total,
    SUM(CASE WHEN tipo.tipo = "Presencial" THEN 1 ELSE 0 END) as presencial,
    SUM(CASE WHEN tipo.tipo = "Telefônico" THEN 1 ELSE 0 END) as telefonico,
    SUM(CASE WHEN tipo.tipo = "E-mail" THEN 1 ELSE 0 END) as email

FROM 
    atend_atendimento as atend
    JOIN atend_tipo as tipo ON tipo.id = atend.idtipo
WHERE
    atend.dataHoraFim IS NOT NULL
    AND atend.dataHoraInicio BETWEEN '2020-02-01' AND '2020-02-29'   
GROUP BY 1 ORDER BY 1