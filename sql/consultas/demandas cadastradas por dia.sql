USE `spu-sc`;
-- demandas cadastrar por dia no último mês

SELECT 
                dias.dia,
                IF(criadas.criada, criadas.criada, 0) as criadas,
                cast(IF(respondidas.respondidas, respondidas.respondidas, 0) as unsigned) as respondidas,
                cast(IF(canceladas.canceladas, canceladas.canceladas, 0) as unsigned) as canceladas
            FROM ( 
                -- TABELA COM A SEQUENCIA DE DIAS
                SELECT 
                    DATE_FORMAT(DATE(cal.date), '%Y-%m-%d') as dia
                FROM (
                    SELECT SUBDATE(NOW(), INTERVAL 30 DAY) + INTERVAL xc DAY AS date
                    FROM (
                            SELECT @xi:=@xi+1 as xc from
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc1,
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc2,
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc3,
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc4,
                            (SELECT @xi:=-1) xc0
                    ) xxc1
                ) cal
                WHERE cal.date <= NOW()
                ORDER BY cal.date DESC
                ) dias 

                -- CRIADAS POR DIA
                LEFT JOIN (
                    SELECT
                        DATE_FORMAT(d.created_at, '%Y-%m-%d') as dia_c,
                        count(d.id) as criada
                    FROM 
                        demanda d
                    WHERE
                        d.created_at >= DATE_SUB(NOW(), INTERVAL 30 day)
                    GROUP BY dia_c
                ) criadas ON dias.dia = criadas.dia_c 

                -- RESPONDIDAS POR DIA 
                LEFT JOIN (
                    SELECT 
                        dia, 
                        sum(respondida) as respondidas 
                    FROM ( 
                        SELECT 
                            DATE_FORMAT(updated_at, '%Y-%m-%d') as dia, 
                            IF(idSituacaoDemanda = 3, 1, 0) as respondida 
                        FROM 
                            demanda 
                        WHERE 
                            updated_at >= DATE_SUB(NOW(), INTERVAL 30 day) 
                    ) as soma_respondidas 
                    GROUP BY dia 
                ) respondidas ON dias.dia = respondidas.dia 

                -- CANCELADAS POR DIA
                LEFT JOIN (
                    SELECT 
                        dia,
                        sum(cancelada) as canceladas
                    FROM (
                        SELECT
                            DATE_FORMAT(d.updated_at, '%Y-%m-%d') as dia,
                            IF(d.idSituacaoDemanda = 4, 1, 0) as cancelada
                        FROM 
                            demanda d
                        WHERE
                            d.updated_at >= DATE_SUB(NOW(), INTERVAL 30 day)
                    ) as soma_canceladas 
                    GROUP BY dia
                ) canceladas ON dias.dia = canceladas.dia 
                ORDER BY 1 