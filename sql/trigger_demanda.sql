DELIMITER $
$
--
-- Procedimentos
--
CREATE DEFINER=`sistemaspu`@`%` PROCEDURE `proc_distribuicaodemanda_atualiza_situacao`
(IN `pIdDemanda` INT
(10))
BEGIN
    DECLARE v_IdSituacaoCancelada, v_IdSituacaoResolvida, v_IdSituacaoEmAtendimento, v_IdSituacaoPronta INT;
    SELECT
        id
    INTO v_IdSituacaoCancelada
    FROM
        situacaodemanda
    WHERE
    situacao = "Cancelada";
    SELECT
        id
    INTO v_IdSituacaoResolvida
    FROM
        situacaodemanda
    WHERE
    situacao = "Resolvida";
    IF(
    SELECT
        idSituacaoDemanda NOT IN(
            v_IdSituacaoCancelada,
            v_IdSituacaoResolvida
        )
    FROM
        demanda
    WHERE
        id = pIdDemanda
) THEN
    -- SE POSSUI DISTRIBUICAO
    IF(
    SELECT
        COUNT(id)
    FROM
        distribuicaodemanda
    WHERE
        idDemanda = pIdDemanda
) THEN
    IF(
    SELECT
        COUNT(dd.id) > 0
    FROM
        distribuicaodemanda dd
    WHERE
        dd.iddemanda = pIdDemanda AND dd.dataAtendimento IS NULL
) THEN
    SELECT
        id
    INTO v_IdSituacaoEmAtendimento
    FROM
        situacaodemanda
    WHERE
    situacao = "Em análise";
    UPDATE
    demanda
SET
    idSituacaoDemanda = v_IdSituacaoEmAtendimento
WHERE
    id = pIdDemanda;
    ELSE
    SELECT
        id
    INTO v_IdSituacaoPronta
    FROM
        situacaodemanda
    WHERE
    situacao = "Pronta";
    UPDATE
    demanda
SET
    idSituacaoDemanda = v_IdSituacaoPronta
WHERE
    id = pIdDemanda;
END
IF;
END
IF;
END
IF;
END$$

DELIMITER ;