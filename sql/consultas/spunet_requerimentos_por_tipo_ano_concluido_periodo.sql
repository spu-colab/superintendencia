--/*
SELECT
	tipo_requerimento,
	SUM(CASE WHEN ano = '2016' THEN quantidade ELSE 0 END) as "2016",
	SUM(CASE WHEN ano = '2017' THEN quantidade ELSE 0 END) as "2017",
	SUM(CASE WHEN ano = '2018' THEN quantidade ELSE 0 END) as "2018",
	SUM(CASE WHEN ano = '2019' THEN quantidade ELSE 0 END) as "2019",
	SUM(CASE WHEN ano = '2020' THEN quantidade ELSE 0 END) as "2020"
FROM (
-- */	
	SELECT tipo_requerimento, ano, count(id_requerimento) as quantidade FROM (
		SELECT		
			reqto.id_requerimento,
			substring(nu_atendimento from 9 for 12) as ano,
			serv.ds_titulo as tipo_requerimento,
			max(historico.dt_alteracao) as conclusao
		FROM
			servico.tb_atendimento atend
			JOIN servico.tb_requerimento reqto USING (id_atendimento)
			JOIN servico.tb_servico serv USING (id_servico)
			JOIN servico.tb_hist_requerimento historico USING (id_requerimento) 
		WHERE
			atend.nu_atendimento LIKE 'SC%'
			AND dt_alteracao BETWEEN '2020-01-01' AND '2020-01-31'
			AND reqto.ds_status IN ('DEFERIDO', 'INDEFERIDO')
		GROUP BY 1, 2, 3
	) as parcial
	GROUP BY 1, 2
--/*
) as requerimentos_ano
GROUP BY 1 ORDER BY 1
-- */