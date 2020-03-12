SELECT 
	servico.ds_titulo as tipo_requerimento,
	coalesce(protocolados."2016", 0) as "protocolo_2016",
	coalesce(protocolados."2017", 0) as "protocolo_2017",
	coalesce(protocolados."2018", 0) as "protocolo_2018",
	coalesce(protocolados."2019", 0) as "protocolo_2019",
	coalesce(protocolados."2020", 0) as "protocolo_2020",
	coalesce(concluidos."2016", 0) as "protocolo_2016_concluidos_periodo",
	coalesce(concluidos."2017", 0) as "protocolo_2017_concluidos_periodo",
	coalesce(concluidos."2018", 0) as "protocolo_2018_concluidos_periodo",
	coalesce(concluidos."2019", 0) as "protocolo_2019_concluidos_periodo",
	coalesce(concluidos."2020", 0) as "protocolo_2020_concluidos_periodo",
	coalesce(posicao."2016", 0) as "protocolo_2016_posicao",
	coalesce(posicao."2017", 0) as "protocolo_2017_posicao",
	coalesce(posicao."2018", 0) as "protocolo_2018_posicao",
	coalesce(posicao."2019", 0) as "protocolo_2019_posicao",
	coalesce(posicao."2020", 0) as "protocolo_2020_posicao"
FROM
	servico.tb_servico servico
	LEFT JOIN (
	-- PROTOCOLADOS POR ANO
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
		) as protocolados
		GROUP BY 1
		ORDER BY 1
	-- Fim de: PROTOCOLADOS POR ANO
	) as protocolados ON servico.ds_titulo = protocolados.tipo_requerimento
	
	LEFT JOIN (
	-- CONCLUIDOS PERIODO
		SELECT
			tipo_requerimento,
			SUM(CASE WHEN ano = '2016' THEN quantidade ELSE 0 END) as "2016",
			SUM(CASE WHEN ano = '2017' THEN quantidade ELSE 0 END) as "2017",
			SUM(CASE WHEN ano = '2018' THEN quantidade ELSE 0 END) as "2018",
			SUM(CASE WHEN ano = '2019' THEN quantidade ELSE 0 END) as "2019",
			SUM(CASE WHEN ano = '2020' THEN quantidade ELSE 0 END) as "2020"
		FROM (
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
					AND dt_alteracao BETWEEN '2020-02-01' AND '2020-02-29'
					AND reqto.ds_status IN ('DEFERIDO', 'INDEFERIDO')
				GROUP BY 1, 2, 3
			) as parcial
			GROUP BY 1, 2
		) as concluidos
		GROUP BY 1 ORDER BY 1
	-- Fim de: CONCLUIDOS PERIODO
	) as concluidos USING (tipo_requerimento)
	LEFT JOIN (
		-- POSICAO NA DATA X
		SELECT 
			tipo_requerimento,
			SUM(CASE WHEN ano = '2016' THEN 1 ELSE 0 END) as "2016",
			SUM(CASE WHEN ano = '2017' THEN 1 ELSE 0 END) as "2017",
			SUM(CASE WHEN ano = '2018' THEN 1 ELSE 0 END) as "2018",
			SUM(CASE WHEN ano = '2019' THEN 1 ELSE 0 END) as "2019",
			SUM(CASE WHEN ano = '2020' THEN 1 ELSE 0 END) as "2020"
		FROM (
			SELECT 
				substring(atend.nu_atendimento from 9 for 12) as ano,
				serv.ds_titulo as tipo_requerimento,
				reqto.id_requerimento,
				hist.ds_situacao_atual
				-- atend.nu_atendimento,		
				-- hist.dt_alteracao
			FROM
				servico.tb_requerimento reqto 
				JOIN servico.tb_atendimento atend ON reqto.id_atendimento = atend.id_atendimento
				JOIN (
					SELECT id_requerimento, max(id_hist_requerimento) as id_hist_requerimento
					FROM servico.tb_atendimento atend JOIN servico.tb_requerimento reqto USING (id_atendimento) JOIN servico.tb_hist_requerimento hist USING (id_requerimento)
					WHERE atend.nu_atendimento LIKE 'SC%' AND date(hist.dt_alteracao) < '2020-01-01' 
					GROUP BY 1
				) as hist2 ON hist2.id_requerimento = reqto.id_requerimento	
				JOIN servico.tb_hist_requerimento hist ON hist2.id_hist_requerimento = hist.id_hist_requerimento
				JOIN servico.tb_servico serv USING (id_servico)
			ORDER BY 1, 2

		) as posicao 
		WHERE posicao.ds_situacao_atual IN ('EM_ANALISE_PREVIA', 'EM_ANALISE_TECNICA', 'AGUARDANDO_REQUERENTE', 'AGUARDANDO_RETORNO_SEI', 'AGUARDANDO_ANALISE_PREVIA')
		GROUP BY 1
	-- Fim de: POSICAO NA DATA X
	) posicao USING (tipo_requerimento)
WHERE
	servico.ic_ativo = true AND servico.ic_cancelado = false
ORDER BY tipo_requerimento


