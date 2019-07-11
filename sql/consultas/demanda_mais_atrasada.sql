USE `spu-sc`;

-- SELECT nupsei, date_format(min(dataprazo), "%Y-%m-%d" ), now(), datediff(dataprazo, now()) from demanda;
-- SELECT datediff('2002-09-13', '2019-07-11');

SELECT nupsei, documentoExterno, dataprazo from demanda WHERE dataprazo is not null ORDER BY 3 ASC LIMIT 1;