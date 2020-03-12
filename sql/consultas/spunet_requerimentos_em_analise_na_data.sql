-- /*
SELECT 
	tipo_requerimento,
	SUM(CASE WHEN ano = '2016' THEN 1 ELSE 0 END) as "2016",
	SUM(CASE WHEN ano = '2017' THEN 1 ELSE 0 END) as "2017",
	SUM(CASE WHEN ano = '2018' THEN 1 ELSE 0 END) as "2018",
	SUM(CASE WHEN ano = '2019' THEN 1 ELSE 0 END) as "2019",
	SUM(CASE WHEN ano = '2020' THEN 1 ELSE 0 END) as "2020"
FROM (
-- */
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
	
	
	
