SELECT
    COUNT(d.id) AS total
FROM
    demanda d
WHERE
	d.dataResposta BETWEEN '2020-03-01' AND '2020-03-31'

-- 2020/01: 174
-- 2020/02: 78
-- 2020/03: 77