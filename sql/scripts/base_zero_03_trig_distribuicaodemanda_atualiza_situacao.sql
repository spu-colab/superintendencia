--
-- Gatilhos `distribuicaodemanda`
--
DROP TRIGGER IF EXISTS `tg_distribuicaodemanda_after_insert`;

CREATE TRIGGER `tg_distribuicaodemanda_after_insert` AFTER INSERT ON `distribuicaodemanda` FOR EACH ROW BEGIN
        CALL proc_distribuicaodemanda_atualiza_situacao(NEW.idDemanda);
    END;

DROP TRIGGER IF EXISTS `tg_distribuicaodemanda_after_update`;

CREATE TRIGGER `tg_distribuicaodemanda_after_update` AFTER UPDATE ON `distribuicaodemanda` FOR EACH ROW BEGIN
        CALL proc_distribuicaodemanda_atualiza_situacao(NEW.idDemanda);
    END;