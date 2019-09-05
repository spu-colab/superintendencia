SET @pDe = Date('2019-05-01');
SET @pAte = Date('2019-05-31');

SET @diasUteis = 1 + 5 * (DATEDIFF(@pAte, @pDe) DIV 7) + MID('0123444401233334012222340111123400012345001234550', 7 * WEEKDAY(@pDe) + WEEKDAY(@pAte) + 1, 1);
SET @demandasRecebidas = (SELECT count(d.id) FROM demanda d WHERE d.dataDocumento BETWEEN @pDe AND @pAte);
SET @demandasRespondidas = (SELECT count(d.id) FROM demanda d WHERE d.idSituacaoDemanda = 3 AND d.updated_at BETWEEN @pDe AND @pAte);

SELECT 
	@diasUteis as dias_uteis,
    -- demandas recebidas
	@demandasRecebidas as demandas_recebidas,    
    -- média diária de demandas recebidas
    @demandasRecebidas / (@diasUteis) as demandas_recebidas_dia,
    -- demandas respondidas
    @demandasRespondidas as demandas_respondidas,
    -- média diária de demandas respondidas
    @demandasRespondidas / (@diasUteis) as demandas_respondidas_dia;
    
    
    
    
    
-- natureza das demandas recebidas    
SELECT count(d.id), natOrg.natureza 
FROM 
	demanda d 
    JOIN autordemanda ad ON d.idAutorDemanda = ad.id 
    JOIN orgao ON ad.idOrgao = orgao.id
    JOIN naturezaorgao natOrg ON orgao.idNaturezaOrgao = natOrg.id
WHERE
	d.dataDocumento BETWEEN @pDe AND @pAte
GROUP BY 2;

-- maiores demandantes
-- distribuição das demandas
-- procedimentos com mais de uma demanda aberta (quantidade e lista de procedimentos)
    