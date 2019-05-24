USE `spu-sc`;

UPDATE demanda SET dataResposta = updated_at WHERE idSituacaoDemanda IN (3,7);