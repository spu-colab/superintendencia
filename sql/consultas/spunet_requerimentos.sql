SELECT
	tipo_requerimento,
	SUM(CASE WHEN ano = '2016' THEN quantidade ELSE 0 END) as "2016",
	SUM(CASE WHEN ano = '2017' THEN quantidade ELSE 0 END) as "2017",
	SUM(CASE WHEN ano = '2018' THEN quantidade ELSE 0 END) as "2018",
	SUM(CASE WHEN ano = '2019' THEN quantidade ELSE 0 END) as "2019",
	SUM(CASE WHEN ano = '2020' THEN quantidade ELSE 0 END) as "2020"
FROM (
	SELECT
		substring(nu_atendimento from 9 for 12) as ano,
		-- reqto.id_requerimento
		serv.ds_titulo as tipo_requerimento,
		count(reqto.id_requerimento) as quantidade
	FROM
		servico.tb_atendimento atend
		JOIN servico.tb_requerimento reqto USING (id_atendimento)
		JOIN servico.tb_servico serv USING (id_servico)
	WHERE
		atend.nu_atendimento LIKE 'SC%'
		-- AND reqto.ds_status NOT IN ('CANCELADO')
	GROUP BY 1, 2
	ORDER BY 1, 2
) as requerimentos_ano
GROUP BY 1
ORDER BY 1
