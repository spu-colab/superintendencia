USE `spu-sc`;
DROP PROCEDURE IF EXISTS proc_distribuicaodemanda_atualiza_situacao;
CREATE PROCEDURE proc_distribuicaodemanda_atualiza_situacao(pIdDemanda int(10))
    BEGIN
        DECLARE v_IdSituacaoCancelada INT;
        DECLARE v_IdSituacaoResolvida INT;
        DECLARE v_IdSituacaoEmAtendimento INT;
        DECLARE v_IdSituacaoPronta INT;

        SELECT id INTO v_IdSituacaoCancelada FROM situacaodemanda WHERE situacao = "Cancelada";
        SELECT id INTO v_IdSituacaoResolvida FROM situacaodemanda WHERE situacao = "Resolvida";

        IF (SELECT idSituacaoDemanda NOT IN (v_IdSituacaoCancelada, v_IdSituacaoResolvida) 
            FROM demanda WHERE id = pIdDemanda)
            THEN

                -- SE POSSUI DISTRIBUICAO
                IF (SELECT count(id) FROM distribuicaodemanda WHERE idDemanda = pIdDemanda) THEN 

                    IF (SELECT count(dd.id) > 0
                        FROM distribuicaodemanda dd WHERE dd.iddemanda = pIdDemanda AND dd.dataAtendimento IS NULL) THEN

                        SELECT id INTO v_IdSituacaoEmAtendimento FROM situacaodemanda WHERE situacao = "Em análise";
                        UPDATE demanda SET idSituacaoDemanda = v_IdSituacaoEmAtendimento WHERE id = pIdDemanda;
                    ELSE 
                        SELECT id INTO v_IdSituacaoPronta FROM situacaodemanda WHERE situacao = "Pronta";
                        UPDATE demanda SET idSituacaoDemanda = v_IdSituacaoPronta WHERE id = pIdDemanda;
                    END IF;
                END IF;

        END IF;

    END;   

DROP TRIGGER IF EXISTS tg_distribuicaodemanda_after_insert;
CREATE TRIGGER tg_distribuicaodemanda_after_insert AFTER INSERT ON distribuicaodemanda 
FOR EACH ROW
    BEGIN
        CALL proc_distribuicaodemanda_atualiza_situacao(NEW.idDemanda);
    END;

DROP TRIGGER IF EXISTS tg_distribuicaodemanda_after_update;
CREATE TRIGGER tg_distribuicaodemanda_after_update AFTER UPDATE ON distribuicaodemanda 
FOR EACH ROW
    BEGIN
        CALL proc_distribuicaodemanda_atualiza_situacao(NEW.idDemanda);
    END;