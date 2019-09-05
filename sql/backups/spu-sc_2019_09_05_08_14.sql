-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 05-Set-2019 Ã s 13:14
-- VersÃ£o do servidor: 10.1.28-MariaDB
-- PHP Version: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spu-sc`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`spu-sc`@`localhost` PROCEDURE `proc_distribuicaodemanda_atualiza_situacao` (`pIdDemanda` INT(10))  BEGIN
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

                        SELECT id INTO v_IdSituacaoEmAtendimento FROM situacaodemanda WHERE situacao = "Em anÃ¡lise";
                        UPDATE demanda SET idSituacaoDemanda = v_IdSituacaoEmAtendimento WHERE id = pIdDemanda;
                    ELSE 
                        SELECT id INTO v_IdSituacaoPronta FROM situacaodemanda WHERE situacao = "Pronta";
                        UPDATE demanda SET idSituacaoDemanda = v_IdSituacaoPronta WHERE id = pIdDemanda;
                    END IF;
                END IF;

        END IF;

    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `autordemanda`
--

CREATE TABLE `autordemanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `idOrgao` int(10) UNSIGNED NOT NULL,
  `idCargo` int(10) UNSIGNED NOT NULL,
  `nome` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` char(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `autordemanda`
--

INSERT INTO `autordemanda` (`id`, `idOrgao`, `idCargo`, `nome`, `email`, `telefone`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 'DÃ©bora Beal ThaÃ­s de CÃ³rdova', '[email_nao_fornecido]', '(48)32036380', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(3, 5, 33, 'Felipe Dulac Goulart', '[email_nao_fornecido]', '(48)38212000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(20, 11, 39, 'Jackson Torres', '[email_nao_fornecido]', '(47)34226367', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(22, 12, 37, 'Francisco JosÃ© Tarso de SabÃ³ia', '[email_nao_fornecido]', '(49)32241989', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(23, 12, 39, 'Daniel Oliveira Teles de Menezes', '[email_nao_fornecido]', '(49)32241989', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(55, 45, 37, 'MÃRCIO WESSNER', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(56, 46, 37, 'DIOGO CAVALLI', '[email_nao_fornecido]', '(48)34334174', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(57, 47, 37, 'CIRO CARVALHO MIRANDA', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(58, 48, 33, 'MARCELO DA MOTA', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(59, 50, 5, 'ANDERSON LODETTI CUNHA DE OLIVEIRA', '[email_nao_fornecido]', '(49)34212100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(60, 51, 5, 'RENATO DE REZENDE GOMES', '[email_nao_fornecido]', '(49)33131200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(62, 53, 5, 'DARLAN AIRTON DIAS', '[email_nao_fornecido]', '(48)34112500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(65, 56, 5, 'MÃRIO ROBERTO DOS SANTOS', '[email_nao_fornecido]', '(49)32027000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(68, 59, 5, 'RUI MAURÃCIO RIBAS RUCINSKI', '[email_nao_fornecido]', '(47)36415400', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(69, 60, 6, 'LUCYANA MARINA PEPE AFFONSO', '[email_nao_fornecido]', '(47)34112255', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(72, 62, 5, 'DANIEL RICKEN', '[email_nao_fornecido]', '(48)33021000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(73, 62, 5, 'ELOI FRANCISCO ZATTI FACCIONI', '[email_nao_fornecido]', '(48)33021000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(74, 54, 5, 'Andrei Mattiuzi Balvedi', 'naoinformado@gov.br', '(47)33211700', '2019-01-23 20:05:26', '2019-08-14 22:35:48'),
(75, 49, 5, 'MICHAEL VON MUHLEN DE BARROS GONÃ‡ALVES', '[email_nao_fornecido]', '(47)33211700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(76, 49, 6, 'RAFAELLA ALBERICI', '[email_nao_fornecido]', '(47)33211700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(79, 53, 6, 'PATRÃCIA MUXFELDT', '[email_nao_fornecido]', '(48)34112500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(80, 54, 5, 'RAFAEL BRUM MIRON', '[email_nao_fornecido]', '(47)34045150', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(82, 57, 5, 'FLÃVIO PAVLOV DA SILVEIRA', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(83, 57, 5, 'MÃRIO SÃ‰RGIO GHANNAGE BARBOSA', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(85, 57, 5, 'TIAGO ALZUGUIR GUTIERREZ', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(86, 48, 6, 'ANALÃšCIA DE ANDRADE HARTMANN', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(87, 48, 5, 'ANDRÃ‰ STEFANI BERTUOL', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(89, 48, 6, 'DANIELE CARDOSO ESCOBAR', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(90, 48, 5, 'EDUARDO BARRAGAN SEROA DA MOTTA', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(91, 48, 5, 'JOÃƒO MARQUES BRANDÃƒO NETO', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(95, 48, 5, 'WALMOR ALVES MOREIRA', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(99, 44, 1, 'ULISSES VETTORELLO', '[email_nao_fornecido]', '(47)33228918', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(100, 45, 40, 'MARILES WICHROSKI DOS SANTOS', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(102, 45, 1, 'ADAUTO JOSE SILVA FILHO', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(103, 46, 1, 'VICTOR KLAFKE RIBEIRO', '[email_nao_fornecido]', '(48)34334174', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(105, 47, 39, 'FÃBIO CRISTIANO WOERNER GALLE', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(106, 47, 2, 'MARIA LUCIA HOLANDA GURGEL PEREIRA', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(107, 47, 2, 'VIVIANE FENRICH', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(108, 47, 1, 'DANIEL CARLOS ANDRADE', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(109, 47, 1, 'JOSÃ‰ OLIVEIRA DA SILVA', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(113, 2, 1, 'JOSÃ‰ WANDERLEY KOZIMA', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(114, 2, 1, 'Emedi Camilo Vizzotto', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(119, 57, 38, 'FÃBIO GALLE', '[email_nao_fornecido]', '(47)34220590', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(121, 47, 15, 'AndrÃ©a Rocha', '[email_nao_fornecido]', '(48)34220590', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(122, 5, 5, 'Dinemar Zoccoli', '[email_nao_fornecido]', '(48)32512000', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(126, 2, 5, 'AndrÃ© Luiz de CÃ³rdova', '[email_nao_fornecido]', '(48)32036349', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(144, 11, 6, 'Catia Rosane Viertel Crestani', '[email_nao_fornecido]', '(47)34226367', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(145, 11, 6, 'Larissa Keil Marinelli', '[email_nao_fornecido]', '(47)34226367', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(159, 82, 57, 'ADALBERTO JOSÃ‰ KASPARY FILHO', '[email_nao_fornecido]', '(51)35116500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(161, 1, 3, 'MARCELO KRÃS BORGES', '[email_nao_fornecido]', '(48)32036349', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(166, 2, 1, 'Dauton Luis de Andrade', '[email_nao_fornecido]', '(48)32036365', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(167, 2, 1, 'MÃ¡rcio Wesnner', '[email_nao_fornecido]', '(48)32036349', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(172, 88, 1, 'Arnaldo Aparecido de Melo', '[email_nao_fornecido]', '(55)32229216', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(174, 67, 49, 'Lenice Born da Silva', '[email_nao_fornecido]', '(47)33697195', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(177, 1, 3, 'DiÃ³genes TarcÃ­sio Marcelino Teixeira', '[email_nao_fornecido]', '(48)300000000', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(182, 67, 49, 'AnalÃº Liberato Longo', '[email_nao_fornecido]', '(48)33302131', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(187, 79, 51, 'TATIANA NUNES LIMA', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(194, 1, 17, 'REGINALDO SOETHE', '[email_nao_fornecido]', '(47)33415800', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(199, 2, 1, 'LUCIANO CARDOSO BACKER', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(201, 47, 2, 'ANDREA DA SILVEIRA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(209, 82, 1, 'HÃ‰CIO BENDER DE OLIVEIRA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(211, 100, 4, 'ANUSKA FELSKI DA SILVA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(214, 5, 6, 'ANA CLAUDIA FARIA CAFIERO', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(216, 101, 49, 'SIMONE CRISTINA SCHULTZ CORRÃŠA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(218, 79, 52, 'JOSÃ‰ ANTÃ”NIO AMARAL NETO', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(224, 2, 2, 'VirgÃ­nia Brodbeck Bolzani', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(226, 83, 2, 'VirgÃ­nia Brodbeck Bolzani', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(228, 44, 61, 'SINEMÃ‰SIA MENDES DE OLIVEIRA', '', '', NULL, NULL),
(231, 7, 5, 'Igor AragÃ£o Brilhante', 'divida.sc.chapeco.psfn@pgfn.gov.br', '(49) 3329-9288', '2019-03-11 13:43:11', '2019-03-11 13:43:11'),
(232, 107, 3, 'Cesar Augusto Vieira', 'rscar01@jfrs.jus.br', NULL, '2019-03-18 19:30:46', '2019-03-18 19:30:46'),
(233, 1, 3, 'Eduardo Didonet Teixeira', 'scflp09@jfsc.jus.br', '(48) 3251-2933', '2019-03-26 12:48:30', '2019-03-26 12:48:30'),
(234, 2, 2, 'VIRGINIA BRODBECK BOLZANI', 'distribuicao.pusc@agu.gov.br', NULL, '2019-03-27 19:14:33', '2019-03-27 19:14:33'),
(235, 40, 56, 'Marcos Sebastiani', 'marcos.sebastani@pmsj.sc.gov.br', NULL, '2019-04-02 13:55:16', '2019-04-02 13:55:16'),
(236, 63, 1, 'RogÃ©rio Lopez Garcia', 'pupr.protocolo@agu.gov.br', '(41) 3204-5700', '2019-04-02 18:23:39', '2019-04-02 18:23:39'),
(237, 108, 3, 'Guilherme Mattei Borsoi', 'tubarao.criminal1@tjsc.jus.br', '(48) 3621-1535', '2019-04-03 18:23:08', '2019-04-03 18:23:08'),
(239, 60, 5, 'ALISSON NELICIO CIRILO CAMPOS', 'prsc-prmriodosul@mpf.mp.br', '47 3411-2255', '2019-04-05 17:50:26', '2019-04-05 17:50:26'),
(240, 110, 18, 'DENIZE DIAS SCHAEFER', 'scitaOS @jfsc.jus.br', '(47) 3341-5800', '2019-04-08 14:03:47', '2019-04-08 14:03:47'),
(241, 62, 5, 'MÃRIO ROBERTO DOS SANTOS', 'prsc-tubarao@mpf.mp.br', '(48)3302-1000', '2019-04-09 13:29:31', '2019-04-09 13:29:31'),
(243, 2, 2, 'SINEMÃ‰SIA MENDES DE OLIVEIRA', 'psu.cco@agu.gov.br', NULL, '2019-04-09 16:50:02', '2019-04-09 16:50:02'),
(244, 103, 3, 'Cesar Nadal Souza', '1vara_jve@trt12.jus.br', '47 3431-4910', '2019-04-10 12:24:52', '2019-04-10 12:24:52'),
(245, 111, 52, 'JOSÃ‰ LEANDRO DA SILVA', 'delemaph.srsc@pf.gov.br', '(48)32816500', '2019-04-10 13:56:14', '2019-04-10 13:56:14'),
(247, 111, 51, 'VALERIA BORBA DA SILVA', 'delemaph.srsc@pf.gov.br', '(48)32816500', '2019-04-10 15:58:38', '2019-04-10 15:58:38'),
(248, 111, 51, 'PRISCILLA BURLACENKO', 'delemaph.srsc@pf.gov.br', '(48) 32816500', '2019-04-10 16:13:48', '2019-04-10 16:13:48'),
(250, 112, 62, 'RENAN SOARES DE SOUZA', 'renandesouza@defensoria.sc.gov.be', '(49) 2049-7621', '2019-04-10 18:12:16', '2019-04-10 18:12:16'),
(251, 111, 52, 'GIUSEPPE BORSATO CAVAGNARI', 'delinst.srsc@dpf.gov.br', '(48)32816431', '2019-04-11 17:01:06', '2019-04-11 17:01:06'),
(252, 87, 3, 'AndrÃ© Luiz Anrain Trentini', 'portobelo.vara1@tjsc.jus.br', '47 33697148', '2019-04-11 18:42:14', '2019-04-11 18:42:14'),
(253, 5, 6, 'Jaqueline AraÃºjo de Oliveira', 'jacqueline.oliveira@pgfn.gov.br', NULL, '2019-04-12 14:30:37', '2019-04-12 14:30:37'),
(254, 5, 6, 'RENATA REINALDO SELINGER', 'apoio.se.criciuma.psfn@pgfn.gov.br', '(48) 3433-1235', '2019-04-12 16:40:25', '2019-04-12 16:40:25'),
(255, 67, 50, 'Luis Felippe Fonseca CatÃ³lico', 'garopaba01PJ@mpsc.mp.br', '48 3254-7901', '2019-04-12 16:54:20', '2019-04-12 16:54:20'),
(256, 1, 3, 'Inezil Penna Marinho Junior', 'sctijua01@jfsg.jus.br', NULL, '2019-04-15 16:52:37', '2019-04-15 16:52:37'),
(257, 48, 5, 'Dermeval Ribeiro Vianna Filho', 'prsc-tubarao@mpf.mp.br', '48 3302-1000', '2019-04-22 13:03:23', '2019-04-22 13:03:23'),
(258, 104, 3, 'Vitoraldo Bridi', 'capital.civel2@tjsc.jus.br', NULL, '2019-04-22 18:15:39', '2019-04-22 18:15:39'),
(259, 113, 4, 'Fabiane Kruetzmann Schapinsky', 'fksc@tjpr.jus.br', '(41) 3033-4606', '2019-04-23 13:47:29', '2019-04-23 13:47:29'),
(260, 84, 2, 'AnÃºbia Secco Giaretta', 'pru4.corepam@agu.gov.br', NULL, '2019-04-24 18:39:35', '2019-04-24 18:39:35'),
(261, 1, 3, 'LEONARDO CACAU SANTOS LA BRADBURY', 'scflp02@jfsc.jus.br', '48 3251-2526', '2019-04-25 14:26:42', '2019-04-25 14:26:42'),
(262, 104, 3, 'Welton Rubenich', 'imbituba@tjsc.jus.br', '48 3355-8000', '2019-05-02 13:12:38', '2019-05-02 13:12:38'),
(263, 114, 5, 'Luciano alaor Bogo', 'luciano.bogo@pgfn.gov.br', '(41) 3310-3010', '2019-05-03 12:43:49', '2019-05-03 12:43:49'),
(264, 84, 1, 'Eder Mauricio Pezzi Lopez', 'eder.lopez@agu.gov.br', '(51) 35116557', '2019-05-03 14:16:55', '2019-05-03 14:16:55'),
(265, 115, 52, 'Marcelo Nascimento Bessa', 'dpf.cm.ccm.srsc@dpf.gov.br', '48 3461-8600', '2019-05-03 18:46:20', '2019-05-03 18:46:20'),
(266, 116, 5, 'Thiago Lira Da Costa', 'thiago.costa@pgfn.gov.br', NULL, '2019-05-07 16:56:42', '2019-05-07 16:56:42'),
(267, 84, 1, 'Carlos Eduardo Wandscheer', 'apoio.dide2.rs.prfn4regiao@pgfn.gov.br', '51 32904917', '2019-05-07 17:30:20', '2019-05-07 17:30:20'),
(268, 67, 49, 'MIRELA DUTRA ALBERTON', 'imaruipj@mpsc.mp.br', '(48) 3643-8201', '2019-05-08 12:40:09', '2019-05-08 12:40:09'),
(269, 101, 49, 'Elaine Rita Auerbach', 'Joinville14PJ@mpsc.mp.br', '(47) 3130-6014', '2019-05-08 17:06:29', '2019-05-08 17:06:29'),
(270, 117, 4, 'ANGELA MARIA KONRATH', 'vara_ima@trtl2.jus.br', '(48) 3255-0520', '2019-05-14 12:54:35', '2019-05-14 12:54:35'),
(271, 64, 1, 'SADI TOLFO JUNIOR', 'pru4.corepam@agu.gov.br', '5135116557', '2019-05-22 17:27:40', '2019-05-22 17:27:40'),
(272, 84, 5, 'JÃºlio Cesar Alves Rodrigues JÃºnior', 'julio.junior@pgfn.gov.br', NULL, '2019-05-23 18:53:18', '2019-05-23 18:53:18'),
(273, 84, 5, 'FÃ¡bio Ruthzatz', 'apoio.uv4.rs@pgfn.gov.br', NULL, '2019-05-27 14:31:30', '2019-05-27 14:31:30'),
(274, 75, 52, 'Tales Teixeira JÃºnior', 'paula.pmr@dpf.gov.br', '4732496799', '2019-05-27 17:14:43', '2019-05-27 17:14:43'),
(275, 80, 63, 'THIAGO ROBERTO MIOTO', 'dpu.joinville@dpu.def.br', NULL, '2019-05-28 17:33:12', '2019-05-28 17:33:12'),
(276, 7, 61, 'Juliane Garghetti', 'divida.sc.chapeco.psfn@pgfn.gov.br', '4933299288', '2019-05-28 18:00:34', '2019-05-28 18:00:34'),
(277, 5, 6, 'Cristina Vasquez', 'cristina.vazques@pgfn.gov.br', NULL, '2019-05-29 19:19:02', '2019-05-29 19:19:02'),
(278, 82, 5, 'Marcelo Rissi', 'marcelo.rissi@agu.gov.br', NULL, '2019-05-31 20:53:31', '2019-05-31 20:53:31'),
(279, 1, 18, 'HELENA TERESINHA GOMES GALAFASSI', 'SCFLP02@JFSC.JUS.BR', '4832512526', '2019-06-03 19:54:23', '2019-06-03 19:54:23'),
(280, 118, 63, 'JoÃ£o Vicente Pandolfb Panitz', 'dpu.sc@dpu.def.br', '483221940', '2019-06-04 14:06:51', '2019-06-04 14:06:51'),
(281, 1, 17, 'ANDERSON LUEDERS', 'scflp09@jfsc.jus.br', '4832512933', '2019-06-04 15:53:27', '2019-06-04 15:53:27'),
(282, 119, 17, 'VICENTE FERNANDO ORTH', 'scflp06@jfsc.jus.br', '04832512565', '2019-06-04 16:23:19', '2019-06-04 16:23:19'),
(283, 120, 1, 'SADI TOLFO JÃšNIOR', 'pru4.corepam@agu.gov.br', '513511655', '2019-06-04 19:34:55', '2019-06-04 19:34:55'),
(286, 85, 49, 'SANDRA GOULART GIESTA DA SILVA', 'Laguna02PJ@mpsc.mp.br', '4836448402', '2019-06-05 21:03:45', '2019-06-05 21:03:45'),
(287, 62, 5, 'FÃBIO NESI VENZON', 'PRSC-prmtubarao@mpf.mp.br', '483302100', '2019-06-07 17:04:18', '2019-06-07 17:04:18'),
(289, 69, 52, 'Cristian Juliano Cardoso', 'andreia.anj@dpf.gov.br', '4734316826', '2019-06-10 20:45:54', '2019-06-10 20:45:54'),
(290, 97, 7, 'Luciano Sabatke Diz', 'coges.spu.pr@planejamento.gov.br', NULL, '2019-06-17 20:05:39', '2019-06-17 20:05:39'),
(291, 84, 2, 'Rafaela Fernanda Fontoura Pszebiszeski', 'pru4.corepam@agu.gov.br', NULL, '2019-06-24 20:28:24', '2019-06-24 20:28:24'),
(292, 3, 7, 'Carlos JosÃ© Bauer', 'carlos.bauer@planejamento.gov.br', '4832518210', '2019-06-28 19:55:05', '2019-06-28 19:55:05'),
(293, 67, 50, 'JANIR LUIZ DELLA GIUSTINA', 'e-mail: tubarao06pj@mpsc.mp.br', NULL, '2019-07-05 17:19:23', '2019-07-05 17:19:23'),
(295, 104, 4, 'Dayse Herget de Oliveira Marinho', 'bcvciv3@tjsc.jus.br', '473261184', '2019-07-08 16:50:57', '2019-07-08 16:50:57'),
(296, 104, 4, 'CRISTINA LERCH LUNARDI', 'capital.civel4@tjsc.jus.br', '4832876651', '2019-07-09 22:00:53', '2019-07-09 22:00:53'),
(297, 104, 3, 'Clayton Cesar Wandscheer', 'blumenau.civel2@tjsc.jus.br', '4733219342', '2019-07-12 21:59:23', '2019-07-12 21:59:23'),
(298, 5, 6, 'Janine Menelli Cardoso', 'janine.cardoso@pgfn.gov.br', NULL, '2019-07-15 15:22:39', '2019-07-15 15:22:39'),
(299, 53, 5, 'FÃ¡bio de Oliveira', 'prsc-prmcriciuma@mpf.mp.br', '4834112500', '2019-07-18 20:02:58', '2019-07-18 20:02:58'),
(300, 53, 5, 'FÃ¡bio de Oliveira', 'prsc-prmcriciuma@mpf.mp.br', '4834112500', '2019-07-18 20:03:07', '2019-07-18 20:03:07'),
(301, 104, 3, 'Luiz OctÃ¡vio David Cavalli', 'balcamboriu.civel1@tjsc.jus.br', '4732611717', '2019-07-18 20:25:12', '2019-07-18 20:25:12'),
(302, 101, 50, 'Nazareno Bez Batti', 'joinville21pj@mpsc.mp.br', '4731306021', '2019-07-22 17:28:17', '2019-07-22 17:28:17'),
(303, 5, 5, 'Manolo AurÃ©lio Bedin Keller', 'manolo.keller@pgfn.gov.br', NULL, '2019-07-22 20:14:47', '2019-07-22 20:14:47'),
(304, 5, 5, 'Manolo AurÃ©lio Bedin Keller', 'manolo.keller@pgfn.gov.br', NULL, '2019-07-22 20:14:59', '2019-07-22 20:14:59'),
(305, 121, 1, 'PAULA SIQUEIRA VIANA', 'nÃ£o@nÃ£o.br', NULL, '2019-07-24 16:07:58', '2019-07-24 16:07:58'),
(306, 48, 5, 'Marco Aurelio Dutra Aydos', ': PRSC-FlorianopolisGABPR4@mpf.mp.br', '4821076140', '2019-07-24 19:41:04', '2019-07-24 19:41:04'),
(307, 1, 4, 'MARJÃ”RIE CRISTINA FREIBERGER', 'XXX@jus.gov.br', '48', '2019-07-30 20:27:02', '2019-07-30 20:27:02'),
(308, 84, 6, 'Sara de FranÃ§a Lacerda de Medeiros', 'sara.lacerda@pgfn.gov.br', '5132904992', '2019-07-30 20:53:25', '2019-07-30 20:53:25'),
(309, 59, 5, 'Lucas Aguilar Sete', 'prsc-prmmafra@mpf.mp.br', '4736415400', '2019-08-01 21:15:11', '2019-08-01 21:15:11'),
(310, 120, 6, 'ROBERTA LONGONI DE VASCONCELLOS', 'naoinformado@pgfn.com', '5134552173', '2019-08-02 16:02:34', '2019-08-02 16:02:34'),
(311, 120, 6, 'ROBERTA LONGONI DE VASCONCELLOS', 'naoinformado@pgfn.com', '5134552173', '2019-08-02 16:03:03', '2019-08-02 16:03:03'),
(312, 49, 6, 'RAFAELLA ALBERICI DE BARROS GONÃ‡ALVES', 'prsc-prmblumenau@mpf.mp.br', '473321170', '2019-08-02 19:37:17', '2019-08-02 19:37:17'),
(313, 84, 5, 'Ricardo Gewehr Spohr', 'ricardo.spohr@agu.gov.br', '5135116557', '2019-08-05 19:00:25', '2019-08-05 19:00:25'),
(314, 122, 3, 'LEANDRO PAULO CYPRIANI', 'scblu01@jfsc.jus.br', '473231680', '2019-08-06 20:19:54', '2019-08-06 20:19:54'),
(315, 45, 61, 'Marcos Luiz Valmorbida', 'psu.cco@agu.gov.br', '4832036380', '2019-08-07 19:13:09', '2019-08-07 19:13:09'),
(316, 104, 4, 'Ana Vera Sganzerla Truccolo', 'itajai.civel4@tjsc.jus.br', '4733419321', '2019-08-09 17:05:32', '2019-08-09 17:05:32'),
(317, 104, 4, 'Ana Vera Sganzerla Truccolo', 'itajai.civel4@tjsc.jus.br', '4733419321', '2019-08-09 17:06:16', '2019-08-09 17:06:16'),
(318, 111, 52, 'GUILHERME MATTOS DE OLIVEIRA', 'nÃ£ofornecido@pf.gov', NULL, '2019-08-12 17:08:51', '2019-08-12 17:08:51'),
(319, 2, 1, 'Pedro Augusto Rodrigues Costa', 'distribuicao.pusc@agu.gov.br', '4832036303', '2019-08-14 22:14:55', '2019-08-14 22:14:55'),
(320, 56, 5, 'FELIPE DELIA CAMARGO', 'viaAPP@MPF.gov', '4821076100', '2019-08-15 15:33:46', '2019-08-15 15:33:46'),
(321, 56, 5, 'FELIPE DELIA CAMARGO', 'viaAPP@MPF.gov', '4821076100', '2019-08-15 15:34:20', '2019-08-15 15:34:20'),
(322, 2, 1, 'Claudinei Moser', 'distribuicao@pusc.gov.br', '4832036330', '2019-08-21 22:00:07', '2019-08-21 22:00:07'),
(323, 104, 3, 'Fernando Machado Carboni', 'itajai.infancia@tjsc.jus.br', '4733419409', '2019-08-27 19:42:29', '2019-08-27 19:42:29'),
(324, 64, 2, 'Ana Paula Niedzieluk Lisboa', 'ana.n.lisboa@agu.gov.br', '4535326864', '2019-08-30 21:15:29', '2019-08-30 21:15:29');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cargo`
--

CREATE TABLE `cargo` (
  `id` int(10) UNSIGNED NOT NULL,
  `cargo` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `cargo`
--

INSERT INTO `cargo` (`id`, `cargo`, `created_at`, `updated_at`) VALUES
(1, 'Advogado', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(2, 'Advogada', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(3, 'JuÃ­z', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(4, 'JuÃ­za', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(5, 'Procurador', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(6, 'Procuradora', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(7, 'Superintendente', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(15, 'Chefe', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(17, 'Diretor', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(18, 'Diretora', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(33, 'Procurador-Chefe', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(37, 'Procurador Seccional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(38, 'Procuradora Seccional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(39, 'Procurador Seccional Subst.', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(40, 'Procuradora Seccional Subst.', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(49, 'Promotora', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(50, 'Promotor', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(51, 'Delegada', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(52, 'Delegado', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(56, 'TÃ©cnico', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(57, 'Subprocurador Regional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(61, 'Chefe de DivisÃ£o', NULL, NULL),
(62, 'Outro', NULL, NULL),
(63, 'Defensor', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoriademanda`
--

CREATE TABLE `categoriademanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `categoria` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `conteudo`
--

CREATE TABLE `conteudo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conteudo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `demanda`
--

CREATE TABLE `demanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `idTipoDocumento` int(10) UNSIGNED NOT NULL,
  `documentoExterno` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nupSEI` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seiMP` tinyint(1) NOT NULL DEFAULT '0',
  `demanda` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `resumoSituacao` text COLLATE utf8mb4_unicode_ci,
  `dataDocumento` date DEFAULT NULL,
  `dataPrazo` date DEFAULT NULL,
  `dataResposta` timestamp NULL DEFAULT NULL,
  `idUsuarioCriacao` int(10) UNSIGNED NOT NULL,
  `idUsuarioAlteracao` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `idAutorDemanda` int(10) UNSIGNED DEFAULT NULL,
  `idSituacaoDemanda` int(10) UNSIGNED NOT NULL,
  `sentencajudicial` tinyint(1) NOT NULL DEFAULT '0',
  `idCategoriaDemanda` int(10) UNSIGNED DEFAULT NULL,
  `idProcedimentoExterno` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `demanda`
--

INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `seiMP`, `demanda`, `resumoSituacao`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(1, 1, '02313/2018', '04972.005144/2017-72', 1, 'apresentar nos autos o exato posicionamento dos terrenos e acrescidos de marinha nas Ã¡reas compreendidas nas transcriÃ§Ãµes nÂº 12.480, nÂº 12.481 e nÂº 3.386 (evento 1, OUT35, fls. 16-33) e na matrÃ­cula nÂº 13.204 (evento 1, OUT35, fls. 13-15) do CartÃ³rio de Registro de ImÃ³veis de Laguna, a fim de facilitar o deslinde do feito', NULL, '2019-01-23', '2019-01-30', '2019-04-23 12:52:45', 9, 3, '2019-01-23 20:13:55', '2019-04-24 16:50:49', 224, 3, 0, NULL, 13),
(2, 1, '01024/2017', '04972.205757/2015-46', 1, 'informar quanto aos desdobramentos das medidas administrativas tendentes Ã  demoliÃ§Ã£o do imÃ³vel em questÃ£o, alÃ©m de realizaÃ§Ã£o de diligÃªncia no local para esclarecer as dÃºvidas suscitadas pelo Sr. Oficial de JustiÃ§a-Avaliador no Evento 54, a fim de demonstrar de modo inequÃ­voco qual Ã© o bem objeto da demoliÃ§Ã£o', 'Fluxo de contrataÃ§Ã£o de demoliÃ§Ã£o acordado com NUGES/Recursos Internos (Laureano). Ver processo 04972.001973/2019-48.', '2019-02-14', '2018-06-18', NULL, 9, 1, '2019-02-14 21:38:39', '2019-07-10 23:11:21', 114, 2, 1, NULL, 7),
(3, 1, '01530/2018', '04972.010691/2018-51', 1, 'prestar informaÃ§Ãµes sobre o interesse da UniÃ£o na causa,tendo em consideraÃ§Ã£o, os documentos juntados nos ev. 49, 51 e 54 do e-proc', NULL, '2019-02-14', '2019-01-07', '2019-05-09 18:59:39', 9, 8, '2019-02-14 21:41:45', '2019-05-09 18:59:40', 100, 3, 0, NULL, 12),
(4, 1, '02321/2018', '04972.008386/2018-07', 1, 'demanda resolvida antes da entrada deste sistema em produÃ§Ã£o', NULL, '2019-02-14', '2018-11-13', '2019-03-06 18:23:20', 9, NULL, '2019-02-14 21:44:01', '2019-03-06 18:23:20', 226, 3, 0, NULL, 5),
(5, 1, '02477/2018', '04972.005805/2017-60', 1, 'informar se hÃ¡ interesse da UniÃ£o no feito', NULL, '2019-02-14', '2018-11-20', '2019-05-09 18:57:17', 9, 8, '2019-02-14 21:46:09', '2019-05-09 18:57:18', 226, 3, 0, NULL, 9),
(6, 1, '02705/2018', '05022.000974/2002-29', 1, 'esclarecer a divergÃªncia entre os 73 imÃ³veis/processos administrativos relatados no OfÃ­cio 105133/2018-MP, contra as 120 (cento e vinte) edificaÃ§Ãµes naquele local, conforme a Nota  TÃ©cnica  nÂº  9558/2016-MP', NULL, '2019-02-14', '2018-12-14', '2019-08-26 15:58:03', 9, 4, '2019-02-14 21:47:54', '2019-08-26 15:58:03', 100, 5, 0, NULL, 11),
(7, 1, '04264/2018', '04972.005990/2018-73', 1, 'manifestar expressamente sobre a aceitaÃ§Ã£o ou nÃ£o da RecomendaÃ§Ã£o nÂº 23/2018', NULL, '2019-02-14', '2018-10-09', NULL, 9, 8, '2019-02-14 21:49:55', '2019-05-10 12:50:37', 86, 2, 0, NULL, 8),
(8, 1, '05979/2018', '04972.002880/2013-45', 1, 'demanda atendida antes da entrada deste sistema em produÃ§Ã£o', NULL, '2019-02-14', '2019-02-04', '2019-03-06 19:06:12', 9, NULL, '2019-02-14 21:50:59', '2019-03-06 19:06:12', 89, 3, 0, NULL, 5),
(9, 1, '00009/2019', '04972.003497/2017-38', 1, 'fornecer manifestaÃ§Ã£o conclusiva acerca do pedido de usucapiÃ£o, considerando os novos documentos apresentados pela parte autora no ev. 69, do E-proc, que acompanhou o OfÃ­cio 9/2018 (7768034)', NULL, '2019-02-14', '2019-01-23', '2019-03-06 18:53:28', 9, NULL, '2019-02-14 21:53:51', '2019-03-06 18:53:28', 100, 3, 0, NULL, 5),
(10, 1, '00030/2019', '00552.000186/2015-45', 1, 'demanda resolvida', NULL, '2019-02-14', '2019-01-24', '2019-03-06 17:47:52', 9, NULL, '2019-02-14 21:55:29', '2019-03-06 17:47:52', 100, 3, 0, NULL, 5),
(11, 1, '00035/2019', '04972.000697/2019-09', 1, 'manifestar eventual interesse da UniÃ£o na lide', NULL, '2019-02-14', '2019-02-08', '2019-05-10 12:18:02', 9, 8, '2019-02-14 21:58:34', '2019-05-10 12:18:03', 99, 3, 0, NULL, 14),
(12, 1, '00037/2019', '04972.000529/2019-13', 1, 'demanda atendida antes da entrada em produÃ§Ã£o deste sistema', NULL, '2019-02-14', '2019-02-05', '2019-03-06 19:07:32', 9, NULL, '2019-02-14 21:59:53', '2019-03-06 19:07:32', 100, 3, 0, NULL, 5),
(13, 1, '00073/2019', '04972.206605/2015-61', 1, 'prestar informaÃ§Ãµes sobre vistoria realizada no local e possÃ­vel regularizaÃ§Ã£o da ocupaÃ§Ã£o/atividade', NULL, '2019-02-14', '2019-02-23', '2019-05-08 14:05:08', 9, 1, '2019-02-14 22:01:30', '2019-05-08 14:05:09', 82, 3, 0, NULL, 15),
(14, 1, '01193/2018', '04972.006141/2017-56', 1, 'informar quais as medidas adotadas para sanar as irregularidades constantes no item \"5\" da Nota TÃ©cnica n.20285/2017-MP, pois coincidem com o objeto do procedimento em epÃ­grafe (anexos seguem os ofÃ­cios enviados e a referida Nota TÃ©cnica).', NULL, '2019-02-14', '2018-12-03', '2019-03-15 14:41:50', 9, 1, '2019-02-14 22:04:02', '2019-03-15 14:41:50', 74, 3, 0, NULL, 10),
(16, 1, '123/2018', '0000000000011111', 1, 'asdasdasd', NULL, '2019-02-21', '2019-02-21', NULL, 9, NULL, '2019-02-21 16:21:04', '2019-03-01 13:38:50', 224, 4, 0, NULL, 5),
(17, 1, '127/2019', '04972.001010/2019-44', 1, '', NULL, '2019-02-21', '2019-03-04', '2019-02-21 21:14:08', 9, NULL, '2019-02-21 20:31:49', '2019-02-21 21:14:08', 82, 3, 0, NULL, 1),
(18, 1, '00081/2019', '04972.206525/2015-13', 1, '', NULL, '2019-02-21', '2019-03-14', NULL, 9, 3, '2019-02-21 21:27:31', '2019-04-24 18:11:21', 228, 4, 1, NULL, 2),
(19, 1, '01057/2018', '04972.010712/2018-38', 1, 'informar se hÃ¡ interesse da UniÃ£o na aÃ§Ã£o judicial', NULL, '2019-02-22', '2019-01-07', '2019-03-06 18:52:15', 9, NULL, '2019-02-22 17:55:34', '2019-03-06 18:52:15', 121, 3, 0, NULL, 3),
(20, 1, '23131', '04972.000000000', 1, 'informar sobre interesse da UniÃ£o', NULL, '2019-02-28', '2019-03-13', NULL, 9, NULL, '2019-02-28 16:43:55', '2019-03-06 18:04:19', 3, 4, 1, NULL, 1),
(21, 1, '12312', '9999999999999999', 1, 'era apenas um teste', NULL, '2019-03-01', NULL, NULL, 9, NULL, '2019-03-01 13:50:10', '2019-03-06 17:49:28', 1, 4, 0, NULL, 1),
(22, 1, '2755/2018', '04972.010715/2018-71', 1, 'informar sobre interesse da UniÃ£o na Ã¡rea objeto da lide', NULL, '2019-03-07', '2018-12-26', '2019-03-26 18:45:11', 9, 1, '2019-03-07 13:48:31', '2019-03-26 18:45:11', 126, 3, 0, NULL, 16),
(23, 1, '55/2019', '04972.001594/2019-58', 1, 'Prestar as informaÃ§Ãµes para a defesa judicial da UniÃ£o no caso concreto', NULL, '2019-03-07', '2019-03-11', '2019-03-26 18:54:13', 9, 1, '2019-03-07 17:59:05', '2019-03-26 18:54:13', 224, 3, 0, NULL, 17),
(24, 1, '300/2019', '04972.001526/2017-27', 1, 'CiÃªncia acerca do acordo celebrado nos autos.', NULL, '2019-03-07', NULL, '2019-04-12 16:53:55', 9, 8, '2019-03-07 18:49:25', '2019-04-12 16:53:55', 126, 3, 1, NULL, 18),
(25, 1, '320/2019', '04972.001644/2019-05', 1, 'ManifestaÃ§Ã£o quanto Ã  interferÃªncia da Ã¡rea.', NULL, '2019-03-08', '2019-03-22', '2019-04-08 14:02:51', 9, 4, '2019-03-08 13:03:19', '2019-04-08 14:02:51', 114, 3, 0, NULL, 19),
(26, 1, '123/2019', '04972.001654/2019-32', 1, 'CÃ³pia integral do processo administrativo referente ao RIP 8319.0000038-52.', NULL, '2019-03-08', '2019-03-18', '2019-05-09 18:53:22', 9, 8, '2019-03-08 16:55:18', '2019-05-09 18:53:23', 201, 3, 0, NULL, 20),
(27, 1, '040/2019', '04972.000143/2019-01', 1, 'A sentenÃ§a condena  o rÃ©u particular nos itens a, b, em sÃ­ntese, nas obrigaÃ§Ãµes de  elaboraÃ§Ã£o do PRAD,  na retirada das edificaÃ§Ãµes existentes, bem como a recuperaÃ§Ã£o da Ã¡rea degradada em atÃ© 90 (noventa) dias do trÃ¢nsito em julgado da presente aÃ§Ã£o. TambÃ©m no item c a regularizaÃ§Ã£o da inscriÃ§Ã£o de ocupaÃ§Ã£o da Ã¡rea junto Ã  SPU. No entanto, sentencia tambÃ©m no item 2, que em caso de nÃ£o execuÃ§Ã£o do PRAD, caberÃ¡ a UniÃ£o Federal cumprir a determinaÃ§Ã£o judicial (sentenÃ§a), nos termos do rÃ©u particular. Por fim, no item 2.1 determina que a UniÃ£o providencie a averbaÃ§Ã£o junto ao CartÃ³rio de Registro de ImÃ³veis competente, da informaÃ§Ã£o de que os imÃ³veis que compÃµem a Ã¡rea objeto da aÃ§Ã£o sÃ£o pertencentes UniÃ£o e constituem Ã¡reas de preservaÃ§Ã£o.', NULL, '2019-03-11', NULL, '2019-03-12 14:45:43', 9, NULL, '2019-03-11 13:48:24', '2019-03-12 14:45:43', 201, 3, 1, NULL, 22),
(28, 1, '196/2019', '04972.001694/2019-84', 1, 'Cumprimento da decisÃ£o Liminar para suspensÃ£o da exigibilidade e imediata retirada do nome do autor da titularidade do RIP : 8111.0000472-15.', NULL, '2019-03-11', '2019-03-20', '2019-05-09 18:42:25', 9, 8, '2019-03-11 13:58:49', '2019-05-09 18:42:27', 231, 3, 1, NULL, 23),
(29, 1, '632/2019', '04972.001197/2019-86', 1, 'A adoÃ§Ã£o de providÃªncias para viabilizar o cadastramento da comunidade Quilombola Vidal Martins.', NULL, '2019-03-11', NULL, '2019-03-11 17:22:01', 9, NULL, '2019-03-11 17:22:01', '2019-03-11 17:22:01', 86, 3, 0, NULL, 24),
(30, 1, '34/2019', '04972.001156/2019-90', 1, 'ManifestaÃ§Ã£o sobre interesse.', NULL, '2019-03-11', NULL, '2019-03-11 17:30:50', 9, NULL, '2019-03-11 17:30:50', '2019-03-11 17:30:50', 224, 3, 0, NULL, 25),
(31, 1, '21/2019', '04972.205163/2015-35', 1, 'AnÃ¡lise de nova documentaÃ§Ã£o.', NULL, '2019-03-11', '2019-02-08', '2019-03-11 17:41:13', 9, NULL, '2019-03-11 17:41:13', '2019-03-11 17:41:13', 224, 3, 0, NULL, 26),
(32, 1, '131/2019', '04972.001751/2019-25', 1, 'ManifestaÃ§Ã£o de Interesse- UsucapiÃ£o Federal.', NULL, '2019-03-11', '2019-03-23', '2019-04-08 18:40:47', 9, 1, '2019-03-11 17:59:17', '2019-04-08 18:40:47', 121, 3, 0, NULL, 27),
(33, 1, '00047/2019', '04972.008875/2018-51', 1, 'Informar se hÃ¡ interesse da UniÃ£o. JÃ¡ existe manifestaÃ§Ã£o prÃ©via, porÃ©m inconclusiva por falta de delimitaÃ§Ã£o mÃ­nima da Ã¡rea.', NULL, '2019-03-11', '2019-03-05', '2019-03-27 18:10:35', 9, 1, '2019-03-11 18:05:10', '2019-03-27 18:10:35', 224, 3, 0, NULL, 28),
(34, 1, '334/2019', '04972.005401/2016-95', 1, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', NULL, '2019-03-11', '2019-03-21', '2019-03-26 19:13:05', 9, 1, '2019-03-11 18:32:02', '2019-03-26 19:13:05', 126, 3, 0, NULL, 29),
(35, 1, '00020/2019', '00638304220118240023', 1, 'apresentar memorial/planta legÃ­vel com coordenadas UTM em que demonstre a interferÃªncia com Ã¡rea de marinha', NULL, '2019-03-11', '2019-03-18', '2019-03-19 14:17:39', 9, 1, '2019-03-11 18:32:30', '2019-03-19 14:17:39', 224, 3, 0, NULL, 30),
(36, 1, '00031/2019', '03002583120158240045', 1, 'apresentar memorial/planta legÃ­vel com coordenadas UTM em que demonstre a interferÃªnciacom Ã¡rea de marinha', NULL, '2019-03-11', '2019-02-26', '2019-03-15 14:14:38', 9, 3, '2019-03-11 18:37:36', '2019-03-15 14:14:38', 224, 3, 0, NULL, 31),
(37, 1, '00050/2019', '04972.008783/2018-71', 1, 'Analisar o levantamento topogrÃ¡fico fornecido pelo MunicÃ­pio de BiguaÃ§u e produzir manifestaÃ§Ã£o sobre interesse da UniÃ£o no feito.', NULL, '2019-03-12', '2019-03-11', '2019-03-19 14:14:36', 9, 1, '2019-03-12 12:52:09', '2019-03-19 14:14:36', 224, 3, 0, NULL, 33),
(38, 1, '00021/2019', '04972.205163/2015-35', 1, 'Demanda atendida antes do seu cadastramento', NULL, '2019-03-12', '2019-02-08', '2019-03-12 13:52:44', 9, NULL, '2019-03-12 13:52:44', '2019-03-12 13:52:44', 224, 3, 0, NULL, 26),
(39, 1, '00028/2019', '04972.004990/2016-94', 1, 'manifestaÃ§Ã£o sobre o laudo pericial complementar juntado, prova pericial cujo objetivo Ã© encontrar o cÃ¡lculo da indenizaÃ§Ã£o devida pela UniÃ£o relacionada ao prÃ©dio localizado na Avenida Irineu Bornhausen, 5034', NULL, '2019-03-12', '2019-03-12', '2019-03-15 17:16:31', 9, 1, '2019-03-12 14:03:46', '2019-03-15 17:16:31', 224, 3, 0, NULL, 34),
(40, 1, '00042/2019', '04972.004792/2017-10', 1, 'indicar assistente tÃ©cnico e formular quesitos', NULL, '2019-03-12', '2019-03-08', '2019-03-15 14:09:35', 9, 3, '2019-03-12 14:59:04', '2019-03-15 14:09:35', 224, 3, 0, NULL, 35),
(41, 1, '00008/2019', '04972.006449/2016-11', 1, 'adotar eventuais providÃªncias decorrentes da sentenÃ§a proferida no procedimento referenciado', NULL, '2019-03-12', NULL, '2019-05-28 16:55:59', 9, 5, '2019-03-12 18:19:25', '2019-05-28 16:56:00', 224, 3, 0, NULL, 36),
(42, 3, '123/2019', '04972.000000/0000-00', 1, 'asd asd asd asd 2 2', NULL, '2019-03-12', NULL, NULL, 1, 1, '2019-03-12 21:00:21', '2019-03-13 14:15:08', 159, 4, 0, NULL, 5),
(43, 1, '7/2019', '04972.006143/2017-45', 1, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', NULL, '2019-03-13', '2019-03-21', '2019-05-10 12:19:31', 4, 8, '2019-03-13 17:19:46', '2019-05-10 12:20:06', 214, 3, 0, NULL, 37),
(44, 1, '386/2017', '04972.001699/2017-45', 1, 'Informa o trÃ¢nsito em julgado da sentenÃ§a para decretar a nulidade de todo os atos processuais posteriores Ã  citaÃ§Ã£o e da sentenÃ§a prolatada no processo de RetificaÃ§Ã£o de Registro ImobiliÃ¡rio nÂ° 1.899/1992(031.92.000091-7), que tramitou junto a 2Âª Vara da Comarca de Indaial -Santa Catarina, atingidos ainda todos os atos processuais subsequentes, bem como as averbaÃ§Ãµes deles decorrentes.', NULL, '2019-03-13', NULL, '2019-05-09 18:41:02', 4, 8, '2019-03-13 18:20:04', '2019-05-09 18:41:03', 99, 3, 1, NULL, 38),
(45, 2, '8088493', '04972.001471/2019-17', 1, 'subsÃ­dios para defesa dos interesses da UniÃ£o no curso da AÃ§Ã£o, especificamente em relaÃ§Ã£o a data de inÃ­cio da revisÃ£o financeira em virtude de revisÃ£o cadastral de imÃ³vel inserido parcialmente na cessÃ£o ao MunicÃ­pio de Bombinhas/SC (Projeto Orla).', NULL, '2019-03-13', '2019-03-13', '2019-03-13 18:26:55', 8, NULL, '2019-03-13 18:26:55', '2019-03-13 18:26:55', 22, 3, 0, NULL, 39),
(46, 1, '241/2019', '04972.003786/2018-18', 1, 'ManifestaÃ§Ã£o sobre nova documentaÃ§Ã£o', NULL, '2019-03-13', NULL, '2019-04-23 17:00:14', 4, 4, '2019-03-13 19:00:23', '2019-04-23 17:00:26', 100, 3, 0, NULL, 40),
(48, 1, '00011/2019', '04972.000452/2019-73', 1, 'assistente tÃ©cnico e apresentaÃ§Ã£o de quesitos no que toca a perÃ­cia de engenharia.\r\nO feito tem conexÃ£o com os autos da aÃ§Ã£o civil pÃºblica n. 5001840-53.2011.404.7201.', NULL, '2019-03-14', '2019-02-04', '2019-03-27 17:26:29', 8, 1, '2019-03-14 11:42:34', '2019-03-27 17:26:29', 228, 3, 0, NULL, 42),
(49, 1, '00091/2019', '04972.000532/2019-29', 1, 'manifestaÃ§Ã£o em defesa dos interesses da UniÃ£o quanto Ã  interferÃªncia da Ã¡rea.', NULL, '2019-03-14', '2019-02-07', '2019-03-19 13:15:41', 8, 4, '2019-03-14 11:58:41', '2019-03-19 13:15:41', 114, 3, 0, NULL, 43),
(50, 1, '00043/2019', '04972.000807/2019-24', 1, 'manifestaÃ§Ã£o de eventual interesse na lide.', NULL, '2019-03-14', '2019-02-13', '2019-03-27 20:33:11', 8, 1, '2019-03-14 12:39:45', '2019-03-27 20:33:11', 228, 3, 0, NULL, 44),
(51, 1, '260/2019', '04972.001801/2019-74', 1, 'Encaminha  o Parecer de ForÃ§a ExecutÃ³ria 22/2019, informando a nulidade do procedimento demarcatÃ³rio por ausÃªncia de intimaÃ§Ã£o pessoal dos ora interessados em relaÃ§Ã£o Ã s unidades do CondomÃ­nio EdifÃ­cio Itambei, com sede na Rua 153, esquina com a Avenida Beira Mar, Centro, na cidade de Itapema â€“ SC , ressalvando a possibilidade de realizaÃ§Ã£o de novo procedimento demarcatÃ³rio.', 'Os cancelamentos jÃ¡ foram adotados e registrados no processo n. 04972.614634/2010-98, processo originalmente utilizado para inscriÃ§Ã£o em dÃ­vida ativa da UniÃ£o.\r\nPosto isso, o processo foi remetido Ã  extinta  DIIUP/COCAI/SPU, demarcaÃ§Ã£o e caracterizaÃ§Ã£o, para ciÃªncia e promoÃ§Ã£o do cumprimento integral dos termos da sentenÃ§a em relaÃ§Ã£o Ã  nova demarcaÃ§Ã£o e ao novo cadastramento do CondomÃ­nio EdifÃ­cio Itambei, com sede na Rua 153, esquina com a Avenida Beira Mar, Centro, na cidade de Itapema â€“ SC.', '2019-03-14', NULL, '2019-07-05 20:08:23', 4, 1, '2019-03-14 13:32:14', '2019-07-30 23:00:52', 100, 3, 1, NULL, 45),
(53, 1, '13/2019', '04972.006827/2018-28', 1, 'IndicaÃ§Ã£o de assistente TÃ©cnico e quesitos.', NULL, '2019-03-14', '2019-03-21', '2019-03-27 17:42:24', 4, 1, '2019-03-14 14:24:07', '2019-03-27 17:42:24', 126, 3, 0, NULL, 47),
(54, 1, '1609/2018', '04972.006827/2018-28', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-03-14', NULL, '2019-03-14 16:36:30', 4, NULL, '2019-03-14 16:36:30', '2019-03-14 16:36:30', 114, 3, 0, NULL, 47),
(55, 1, '276/2019', '04972.006225/2018-71', 1, 'Fornecimento de documentos solicitados pelo Perito.', NULL, '2019-03-14', '2019-03-27', '2019-04-10 14:33:52', 4, 1, '2019-03-14 16:45:20', '2019-04-10 14:33:52', 100, 3, 0, NULL, 46),
(56, 1, '725/2018', '04972.006225/2018-71', 1, 'CÃ³pia do Procedimento DemarcatÃ³rio.', NULL, '2019-03-14', NULL, '2019-03-14 16:47:37', 4, NULL, '2019-03-14 16:47:37', '2019-03-14 16:47:37', 100, 3, 0, NULL, 46),
(57, 1, '24/2019', '04972.000320/2019-41', 1, 'Proceder Ã  demoliÃ§Ã£o da edificaÃ§Ã£o em questÃ£o, devendo contatar diretamente o IMA â€“ Instituto do meio ambiente de Santa Catarina para acompanhar o processo de remoÃ§Ã£o do material.', 'Fluxo de contrataÃ§Ã£o de demoliÃ§Ã£o acordado com NUGES/Recursos Internos (Laureano). Ver processo 04972.001973/2019-48.', '2019-03-14', '2019-03-20', '2019-08-05 20:50:31', 4, 1, '2019-03-14 17:34:03', '2019-08-05 20:50:33', 100, 3, 1, NULL, 48),
(58, 1, '21/2019', '04972.000600/2019-50', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-14', '2019-02-01', '2019-03-14 18:01:56', 4, 4, '2019-03-14 17:54:05', '2019-03-14 18:01:56', 228, 3, 0, NULL, 41),
(59, 1, '282/2019', '04972.009330/2018-61', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-03-14', '2019-03-04', '2019-03-14 18:17:56', 4, NULL, '2019-03-14 18:17:56', '2019-03-14 18:17:56', 126, 3, 0, NULL, 50),
(60, 1, '203/2019', '04972.001196/2019-31', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-03-14', '2019-02-18', '2019-03-14 18:50:28', 4, NULL, '2019-03-14 18:50:28', '2019-03-14 18:50:28', 126, 3, 0, NULL, 51),
(61, 1, '78/2019', '04972.000516/2019-36', 1, 'ManifestaÃ§Ã£o acerca da interferÃªncia da Ã¡rea da UniÃ£o.', NULL, '2019-03-14', '2019-02-28', '2019-03-14 19:30:18', 4, NULL, '2019-03-14 19:30:18', '2019-03-14 19:30:18', 126, 3, 0, NULL, 52),
(62, 1, '29/2019', '04972.205274/2015-41', 1, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', NULL, '2019-03-14', '2019-02-20', '2019-03-14 19:46:05', 4, NULL, '2019-03-14 19:46:05', '2019-03-14 19:46:05', 228, 3, 0, NULL, 53),
(63, 1, '00045/2019', '04972.001385/2018-23', 1, 'manifestaÃ§Ã£o acerca do Laudo Pericial.\r\nConstruÃ§Ã£o irregular na Ponta do Papagaio, em PalhoÃ§a/SC', NULL, '2019-03-15', '2019-03-15', '2019-03-26 19:38:18', 8, 3, '2019-03-15 11:54:52', '2019-03-26 19:38:18', 224, 3, 0, NULL, 54),
(64, 1, '0165/2019', '04972.200783/2015-88', 1, 'subsÃ­dios de fato e de direito para a defesa da UniÃ£o na aÃ§Ã£o de usucapiÃ£o, especialmente ratificando\nou retificando o parecer tÃ©cnico nÂº COCAP-SP-SC 0105862.', NULL, '2019-03-15', '2019-02-15', '2019-03-26 19:10:57', 8, 1, '2019-03-15 12:30:20', '2019-03-26 19:10:57', 126, 3, 0, NULL, 55),
(65, 1, '3766/2018', '04972.006191/2018-14', 1, 'InformaÃ§Ã£o acerca de como o projeto orla trata da pesca em pontes', NULL, '2019-03-15', NULL, '2019-03-27 14:10:02', 3, 3, '2019-03-15 14:23:02', '2019-03-27 14:10:02', 90, 3, 0, NULL, 56),
(66, 1, '99999', '9999999999999999', 1, '999999999', NULL, '2019-03-15', '2019-03-09', '2019-03-15 17:46:26', 1, 1, '2019-03-15 17:25:03', '2019-03-15 17:46:26', 159, 3, 0, NULL, 5),
(67, 1, '144/2019', '04972.001824/2019-89', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-03-15', '2019-03-29', '2019-04-08 18:31:43', 4, 1, '2019-03-15 19:08:50', '2019-04-08 18:31:43', 228, 3, 0, NULL, 58),
(68, 1, '146/2019', '04972.001826/2019-78', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-03-15', '2019-03-29', '2019-04-08 18:32:10', 4, 1, '2019-03-15 19:15:35', '2019-04-08 18:32:10', 228, 3, 0, NULL, 59),
(69, 1, '2624/2018', '04972.010279/2018-31', 1, 'manifestaÃ§Ã£o quanto Ã  interferÃªncia da Ã¡rea em questÃ£o.', NULL, '2019-03-18', '2018-12-03', '2019-03-20 17:05:45', 8, 1, '2019-03-18 16:14:19', '2019-03-20 17:05:45', 114, 3, 0, NULL, 61),
(70, 1, '00277/2019', '04972.004678/2017-81', 1, 'ElaboraÃ§Ã£o de Documento TÃ©cnico Conjunto que registre todas as intervenÃ§Ãµes, edificaÃ§Ãµes ou acessÃµes feitas atÃ© agora sobre os bens da UniÃ£o na regiÃ£o definida no item 1.\r\nMulta diÃ¡ria de R$ 10.000,00', 'Em fase de recurso no TRF4. Foi Criado um Grupo de Trabalho entre SPU, IBAMA, ICMBIO, IMA, Floram, SMDU e IPUF para cumprir parte da sentenÃ§a referente a elaboraÃ§Ã£o de Documento TÃ©cnico Conjunto.', '2019-03-18', '2019-03-11', NULL, 1, 5, '2019-03-18 17:33:43', '2019-07-03 23:03:22', 114, 2, 1, NULL, 62),
(71, 1, '140/2019', '04972.006757/2011-31', 1, 'informar se  tem interesse em cumprir a ordem de reintegraÃ§Ã£o de posse do imÃ³vel e se jÃ¡ hÃ¡ definiÃ§Ã£o na destinaÃ§Ã£o do imÃ³vel e se hÃ¡ viabilidade de o ocupante adquirir o imÃ³vel, informando as condiÃ§Ãµes e procedimento, neste caso.', NULL, '2019-03-18', '2019-03-29', '2019-05-10 17:08:53', 4, 3, '2019-03-18 18:19:35', '2019-05-10 17:08:55', 228, 3, 0, NULL, 60),
(72, 1, '141/2019', '04972.001828/2019-67', 1, 'Cumprimento de sentenÃ§a consistente na  elaboraÃ§Ã£o de Plano de RecuperaÃ§Ã£o da Ãrea Degradada - PRAD, a ser submetido aocrivo do IBAMA e da FATMA, o qual deverÃ¡ prever a integral recuperaÃ§Ã£o ambiental.', 'Nosso termo de referÃªncia estÃ¡ no NUP 04972.007627/2017-10 sendo o arquivo Termo CODES-SPU-SC (4872540), aguarando resposta do Ã“rgÃ£o Central.\r\n\r\nO que foi feito:\r\n- Oficiamos a Prefeitura de SÃ£o Francisco do Sul para demoliÃ§Ã£o, pois Ã© requisito para elaboraÃ§Ã£o do PRAD (em conjunto com a mesma Prefeitura)\r\n- Oficiamos AGU comunicando que pende a demoliÃ§Ã£o por parte do municÃ­pio\r\n\r\nO que falta fazer:\r\nAguardando demoliÃ§Ã£o/manifestaÃ§Ã£o pela Prefeitura de SÃ£o Francisco do Sul para realizaÃ§Ã£o do PRAD em conjunto', '2019-03-18', '2019-06-27', NULL, 4, 1, '2019-03-18 18:39:15', '2019-08-21 16:06:03', 99, 2, 1, NULL, 63),
(73, 1, '143/2018', '04972.001829/2019-10', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-18', NULL, '2019-05-09 17:33:19', 4, 1, '2019-03-18 19:23:16', '2019-05-09 17:33:29', 121, 3, 0, NULL, 64),
(74, 1, '366/2019', '04972.001831/2019-81', 1, 'Informar se o imÃ³vel de inscriÃ§Ã£o imobiliÃ¡ria nÂ° 40.15.072.0805.001-852, estÃ¡ situado em terreno de marinha, e caso positivo, informe sobre a possÃ­vel cessÃ£o de direitos de ocupaÃ§Ã£o de terreno de marinha, bem como sobre os responsÃ¡veis pelo pagamento do respectivo laudÃªmio.', NULL, '2019-03-18', '2019-03-25', '2019-04-11 13:14:39', 4, 4, '2019-03-18 19:36:44', '2019-04-11 13:14:39', 232, 3, 0, NULL, 65),
(75, 1, '0153/2019', '04972.001420/2019-95', 1, 'manifestaÃ§Ã£o de interesse na lide.', NULL, '2019-03-19', '2019-03-20', NULL, 8, 5, '2019-03-19 11:42:53', '2019-04-03 19:36:39', 100, 2, 0, NULL, 66),
(76, 1, '2467/2018', '04972.009450/2018-69', 1, 'aferir se a Ã¡rea descrita na denÃºncia interfere com propriedade da UniÃ£o.', 'MÃ¢nglio estÃ¡ analisando se hÃ¡ interferÃªncia com terras da UniÃ£o', '2019-03-19', NULL, NULL, 8, 1, '2019-03-19 11:59:07', '2019-08-05 17:31:38', 224, 4, 1, NULL, 67),
(77, 1, '92/2019', '04972.001854/2019-95', 1, 'InformaÃ§Ãµes e documentos referentes ao referido bem imÃ³vel.', NULL, '2019-03-19', NULL, NULL, 4, NULL, '2019-03-19 13:07:36', '2019-03-19 13:07:36', 103, 2, 0, NULL, 68),
(78, 1, '2673/2016', '04972.003900/2016-48', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-19', NULL, '2019-03-19 13:37:58', 4, 4, '2019-03-19 13:37:49', '2019-03-19 13:37:58', 167, 3, 0, NULL, 71),
(79, 1, '588/2018', '04972.003900/2016-48', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-03-19', NULL, '2019-03-19 13:39:52', 4, 4, '2019-03-19 13:39:45', '2019-03-19 13:39:52', 224, 3, 0, NULL, 71),
(80, 1, '2774/2018', '04972.003900/2016-48', 1, 'ManifestaÃ§Ã£o sobre Laudo Pericial', NULL, '2019-03-19', NULL, '2019-03-19 13:42:29', 4, 4, '2019-03-19 13:42:27', '2019-03-19 13:42:29', 114, 3, 0, NULL, 71),
(81, 1, '2182/2018', '04972.008923/2018-19', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-19', NULL, '2019-03-19 14:08:48', 4, 4, '2019-03-19 14:08:45', '2019-03-19 14:08:48', 224, 3, 0, NULL, 72),
(82, 1, '40/2019', '04972.008923/2018-19', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-19', NULL, '2019-03-19 14:10:28', 4, 4, '2019-03-19 14:10:20', '2019-03-19 14:10:28', 224, 3, 0, NULL, 72),
(83, 1, '1173/2017', '04972.001675/2017-96', 1, 'InformaÃ§Ãµes para a defesa judicial da UniÃ£o no caso concreto, notadamente sobre a alegaÃ§Ã£o de essa SPU ter-se quedado inerte diante da notÃ­cia da ilegalidade perpetrada pelo rÃ©u pessoa fÃ­sica, bem como os desdobramentos da recomendaÃ§Ã£o do MPF.', NULL, '2019-03-19', NULL, '2019-03-19 14:23:08', 4, 4, '2019-03-19 14:22:53', '2019-03-19 14:23:08', 167, 3, 0, NULL, 73),
(84, 1, '2671/2017', '04972.001675/2017-96', 1, 'SubsÃ­dios de fato e de direito que possam ser empregados na defesa da\nUniÃ£o no feito.', NULL, '2019-03-19', NULL, '2019-03-19 14:28:33', 4, 4, '2019-03-19 14:28:30', '2019-03-19 14:28:33', 199, 3, 0, NULL, 73),
(85, 1, '571/2017', '04972.001712/2017-66', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-19', NULL, '2019-03-19 18:30:43', 4, 4, '2019-03-19 18:30:39', '2019-03-19 18:30:43', 119, 3, 0, NULL, 74),
(86, 1, '152/2019', '04972.001712/2017-66', 1, 'Designar servidor para audiÃªncia.', NULL, '2019-03-19', '2019-04-22', '2019-04-29 20:18:15', 4, 1, '2019-03-19 18:33:39', '2019-04-29 20:18:18', 121, 3, 0, NULL, 74),
(87, 1, '1660/2017', '04972.007162/2017-99', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-19', NULL, '2019-03-19 18:58:06', 4, 4, '2019-03-19 18:57:31', '2019-03-19 18:58:06', 119, 3, 0, NULL, 75),
(89, 1, '24/2019', '04972.007162/2017-99', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-19', '2019-03-01', '2019-03-19 19:00:00', 4, 4, '2019-03-19 18:59:55', '2019-03-19 19:00:00', 228, 3, 0, NULL, 75),
(90, 1, '0211/2019', '04972.002267/2016-71', 1, 'indicaÃ§Ã£o de preposto para representar a SPU na audiÃªncia designada para a data de 11/04/2019, Ã s 14 horas.', NULL, '2019-03-20', '2019-04-08', '2019-04-02 12:19:59', 8, 8, '2019-03-20 14:06:09', '2019-04-02 12:19:59', 114, 3, 0, NULL, 76),
(91, 1, '1574/2018', '04972.010714/2018-27', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-03-20', NULL, '2019-03-20 17:52:27', 4, 4, '2019-03-20 17:52:23', '2019-03-20 17:52:27', 100, 3, 0, NULL, 77),
(94, 1, '955/2019', '04972.001755/2019-11', 1, 'Informar sobre autorizaÃ§Ã£o para realizaÃ§Ã£o do evento descrito no Procedimento Externo relacionado.', NULL, '2019-03-21', '2019-03-26', '2019-03-21 17:16:47', 1, 1, '2019-03-21 17:16:38', '2019-03-21 17:16:47', 95, 3, 0, NULL, 79),
(95, 1, '00164/2019', '04972.001447/2019-88', 1, 'informar sobre o interesse da UniÃ£o na lide.', NULL, '2019-03-25', '2019-03-23', '2019-04-10 14:27:35', 8, 1, '2019-03-25 12:30:42', '2019-04-10 14:27:35', 100, 3, 0, NULL, 80),
(96, 1, '2402/2018/PU/SC', '04972.000966/2017-67', 1, 'acompanhamento para cumprimento do acordo homologado.', NULL, '2019-03-25', NULL, '2019-04-03 18:12:19', 8, 8, '2019-03-25 13:30:42', '2019-04-03 18:12:19', 126, 3, 1, NULL, 81),
(97, 1, '33/2019', '04972.000689/2019-54', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-25', NULL, '2019-03-25 17:46:35', 4, 4, '2019-03-25 17:46:31', '2019-03-25 17:46:35', 121, 3, 0, NULL, 82),
(98, 1, '180/2019', '04972.001951/2019-88', 1, 'ProvidÃªncias administrativas que entender pertinentes.', NULL, '2019-03-25', NULL, '2019-05-30 13:46:34', 4, 1, '2019-03-25 18:14:53', '2019-05-30 13:46:35', 74, 3, 0, NULL, 83),
(99, 6, '01', '04972.010624/2018-36', 1, 'AnotaÃ§Ã£o de Indisponibilidade do Direito de OcupaÃ§Ã£o', NULL, '2019-03-26', NULL, '2019-03-26 12:57:54', 8, 8, '2019-03-26 12:57:50', '2019-03-26 12:57:54', 233, 3, 1, NULL, 84),
(100, 6, '01', '04972.010624/2018-36', 1, 'AnotaÃ§Ã£o de Indisponibilidade do Direito de OcupaÃ§Ã£o', NULL, '2019-03-26', NULL, '2019-03-26 13:00:00', 8, 8, '2019-03-26 12:59:57', '2019-03-26 13:00:00', 233, 3, 1, NULL, 85),
(101, 6, '01', '04972.010624/2018-36', 1, 'AnotaÃ§Ã£o de Indisponibilidade do Direito de OcupaÃ§Ã£o', NULL, '2019-03-26', NULL, '2019-03-26 13:01:49', 8, 8, '2019-03-26 13:01:47', '2019-03-26 13:01:49', 233, 3, 1, NULL, 87),
(102, 6, '01', '04972.010624/2018-36', 1, 'AnotaÃ§Ã£o de Indisponibilidade do Direito de OcupaÃ§Ã£o', NULL, '2019-03-26', NULL, '2019-03-26 13:03:16', 8, 8, '2019-03-26 13:03:15', '2019-03-26 13:03:16', 233, 3, 1, NULL, 86),
(103, 1, '37/2019', '04972.001325/2019-91', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-03-26', '2019-03-08', '2019-03-26 13:57:52', 4, 4, '2019-03-26 13:57:42', '2019-03-26 13:57:52', 224, 3, 0, NULL, 88),
(104, 1, '1548/2016', '04972.006197/2016-20', 1, 'SubsÃ­dios de fato e direito.', NULL, '2019-03-26', NULL, '2019-03-26 16:35:08', 4, 4, '2019-03-26 16:34:21', '2019-03-26 16:35:08', 107, 3, 0, NULL, 89),
(105, 1, '00400/2018', '04972.010399/2018-38', 1, 'manifestaÃ§Ã£o se o imÃ³vel objeto da lide interfere com patrimÃ´nio da UniÃ£o.', NULL, '2019-03-26', '2019-03-26', '2019-03-26 16:42:00', 8, 8, '2019-03-26 16:41:46', '2019-03-26 16:42:00', 228, 3, 0, NULL, 90),
(106, 1, '1505/2016', '04972.006077/2016-22', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 16:43:20', 4, 4, '2019-03-26 16:43:17', '2019-03-26 16:43:20', 119, 3, 0, NULL, 91),
(107, 1, '1566/2016', '04972.006199/2016-19', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 16:46:46', 4, 4, '2019-03-26 16:46:43', '2019-03-26 16:46:46', 107, 3, 0, NULL, 93),
(108, 1, '1607/2016', '04972.006348/2016-40', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 16:54:47', 4, 4, '2019-03-26 16:54:45', '2019-03-26 16:54:47', 107, 3, 0, NULL, 94),
(109, 1, '1617/2016', '04972.006397/2016-82', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 17:00:03', 4, 4, '2019-03-26 16:59:58', '2019-03-26 17:00:03', 107, 3, 0, NULL, 95),
(110, 1, '1644/2016', '04972.006463/2016-14', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 17:28:27', 4, 4, '2019-03-26 17:28:25', '2019-03-26 17:28:27', 105, 3, 0, NULL, 96),
(111, 1, '1648/2016', '04972.006466/2016-58', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 17:33:17', 4, 4, '2019-03-26 17:33:16', '2019-03-26 17:33:17', 105, 3, 0, NULL, 97),
(112, 1, '1647/2016', '04972.006467/2016-01', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 17:40:54', 4, 4, '2019-03-26 17:40:50', '2019-03-26 17:40:54', 105, 3, 0, NULL, 98),
(113, 1, '1685/2016', '04972.006551/2016-16', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-26', NULL, '2019-03-26 17:58:32', 4, 4, '2019-03-26 17:58:30', '2019-03-26 17:58:32', 121, 3, 0, NULL, 99),
(114, 1, '1690/2016', '04972.006577/2016-64', 1, 'SuspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014- TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-26', NULL, '2019-03-26 18:12:55', 4, 4, '2019-03-26 18:12:50', '2019-03-26 18:12:55', 107, 3, 0, NULL, 94),
(115, 1, '1693/2016', '04972.006587/2016-08', 1, 'SuspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014- TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­do.', NULL, '2019-03-26', NULL, '2019-03-26 18:31:06', 4, 4, '2019-03-26 18:31:04', '2019-03-26 18:31:06', 107, 3, 0, NULL, 101),
(116, 1, '1699/2016', '04972.006624/2016-70', 1, 'Determinar a suspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014-TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-26', NULL, '2019-03-26 18:50:12', 4, 4, '2019-03-26 18:50:10', '2019-03-26 18:50:12', 57, 3, 0, NULL, 99),
(117, 1, '1694/2016', '04972.006605/2016-43', 1, 'SuspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014- TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-26', NULL, '2019-03-26 19:02:18', 4, 4, '2019-03-26 19:02:00', '2019-03-26 19:02:18', 107, 3, 0, NULL, 103),
(118, 1, '1698/2016', '04972.006623/2016-25', 1, 'SuspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014-TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-26', NULL, '2019-03-26 19:46:09', 4, 4, '2019-03-26 19:12:42', '2019-03-26 19:46:09', 57, 3, 0, NULL, 104),
(119, 1, '1708/2016', '04972.006653/2016-31', 1, 'SuspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014- TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-26', NULL, '2019-03-26 19:56:37', 4, 4, '2019-03-26 19:56:35', '2019-03-26 19:56:37', 107, 3, 0, NULL, 105),
(120, 1, '154/2019', '04972.001356/2017-81', 1, 'Reitera solicitaÃ§Ã£o de resposta ao OfÃ­cio 845/2017-GABPRM5-FPS (3838831), de 15/05/2017, reiterado pelo OfÃ­cio nÂº 865/2018-GABPRM5-FPS (6272981), de 16/05/2018.', NULL, '2019-03-27', '2019-03-11', '2019-03-27 18:08:04', 1, 1, '2019-03-27 18:08:01', '2019-03-27 18:08:04', 82, 3, 0, NULL, 106),
(121, 1, '1700/2016', '04972.006625/2016-14', 1, 'determinar a suspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPUSC no livro nÂº SC-014-TERMOS DIVERSOS E ESCRITURA Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-27', NULL, '2019-03-27 18:32:52', 4, 4, '2019-03-27 18:32:50', '2019-03-27 18:32:52', 57, 3, 0, NULL, 108),
(122, 1, '1405/2019', '04972.001956/2019-19', 1, 'Prestar informaÃ§Ãµes sobre a atual situaÃ§Ã£o do projeto habitacional aos integrantes da \'OcupaÃ§Ã£o Contestado\'', NULL, '2019-03-27', '2019-04-12', '2019-05-09 18:32:52', 1, 1, '2019-03-27 18:46:37', '2019-05-09 18:32:53', 58, 3, 0, NULL, 110),
(123, 1, '1720/2016', '04972.006685/2016-37', 1, 'suspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014-TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-27', NULL, '2019-03-27 18:46:46', 4, 4, '2019-03-27 18:46:44', '2019-03-27 18:46:46', 107, 3, 0, NULL, 111),
(124, 1, '1722/2016', '04972.006682/2016-01', 1, 'SuspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o.', NULL, '2019-03-27', NULL, '2019-03-27 18:57:18', 4, 4, '2019-03-27 18:56:54', '2019-03-27 18:57:18', 107, 3, 0, NULL, 112),
(125, 1, '1723/2016', '04972.006732/2016-42', 1, 'suspensÃ£o daeficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014- TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-27', NULL, '2019-03-27 19:02:21', 4, 4, '2019-03-27 19:02:20', '2019-03-27 19:02:21', 107, 3, 0, NULL, 113),
(126, 1, '1520/2016', '04972.006120/2016-50', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-27', NULL, '2019-03-27 19:09:38', 4, 4, '2019-03-27 19:09:34', '2019-03-27 19:09:38', 121, 3, 0, NULL, 114),
(127, 7, '03/2019', '04972.001957/2019-55', 1, 'RECOMENDA ao SUPERINTENDENTE DO PATRIMÃ“NIO DA UNIÃƒO EM SANTA CATARINA - SPU/SC, na pessoa de seu Superintendente Substituto - Senhor Carlos JosÃ© Bauer, que:\r\n1) adote medidas para identificaÃ§Ã£o dos ocupantes e adoÃ§Ã£o das medidas administrativas e/ou judiciais necessÃ¡rias para desocupaÃ§Ã£o dos imÃ³veis da UniÃ£o no loteamento Ouro Verde, municÃ­pio de BalneÃ¡rio Gaivota/SC, localizados em Ã¡reas de preservaÃ§Ã£o permanente;\r\n2) proceda a anulaÃ§Ã£o de eventuais inscriÃ§Ãµes de ocupaÃ§Ã£o jÃ¡ deferida se para que se abstenha de deferir novas inscriÃ§Ãµes,  por se tratar de Ãrea de PreservaÃ§Ã£o Permanente, nos termos da alÃ­nea \"a\" do inciso l do Â§1Â° da Lei n.9.636/98.', NULL, '2019-03-27', '2019-04-25', '2019-05-28 13:17:21', 1, 1, '2019-03-27 19:13:28', '2019-05-28 13:17:22', 65, 3, 0, NULL, 115),
(128, 1, '1518/2016', '04972.006086/2016-13', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-27', NULL, '2019-03-27 19:31:28', 4, 4, '2019-03-27 19:31:27', '2019-03-27 19:31:28', 121, 3, 0, NULL, 116),
(129, 1, '1703/2016', '04972.000215/2017-41', 1, 'suspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014-TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos', NULL, '2019-03-27', NULL, '2019-03-27 19:37:19', 4, 4, '2019-03-27 19:37:11', '2019-03-27 19:37:19', 109, 3, 0, NULL, 117),
(130, 1, '115/2017', '04972.000528/2017-07', 1, 'suspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPUSC no livro nÂº SC-014-TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', NULL, '2019-03-27', NULL, '2019-03-27 19:43:23', 4, 4, '2019-03-27 19:43:21', '2019-03-27 19:43:23', 121, 3, 0, NULL, 118),
(131, 1, '971/2019', '04972.001641/2019-63', 1, 'prestar informaÃ§Ãµes sobre eventual autorizaÃ§Ã£o desta SuperintendÃªncia para obras de desmatamento na Ã¡rea indicada na representaÃ§Ã£o', NULL, '2019-03-27', '2019-04-08', '2019-03-27 20:31:02', 1, 1, '2019-03-27 19:58:24', '2019-03-27 20:31:02', 95, 3, 0, NULL, 119),
(132, 1, '17///2016', '04972.000105/2017-89', 1, 'suspensÃ£o da eficÃ¡ciada clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014-TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos', NULL, '2019-03-27', NULL, '2019-03-27 20:26:08', 4, 4, '2019-03-27 20:26:04', '2019-03-27 20:26:08', 109, 3, 0, NULL, 120),
(133, 1, '1712/2016', '04972.000107/2017-78', 1, 'suspensÃ£o da eficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o', NULL, '2019-03-27', NULL, '2019-03-27 20:40:13', 4, 4, '2019-03-27 20:40:11', '2019-03-27 20:40:13', 109, 3, 0, NULL, 121),
(134, 1, '1853/2018', '04972.007633/2018-40', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-03-28', NULL, '2019-03-28 18:12:10', 4, 4, '2019-03-28 18:11:34', '2019-03-28 18:12:10', 126, 3, 0, NULL, 122),
(135, 1, '427/2019', '04972.007633/2018-40', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-03-28', '2019-04-08', '2019-04-22 13:10:03', 4, 1, '2019-03-28 18:14:16', '2019-04-22 13:10:03', 126, 3, 0, NULL, 122),
(136, 1, '4875/2019', '04972.207030/2015-01', 1, 'Elementos para a defesa/manifestaÃ§Ã£o sobre o pedido de liminar, em aÃ§Ã£o objetivando a decretaÃ§Ã£o da nulidade da decisÃ£o administrativa proferida nos autos do processo 04972.200918/2015-13.', NULL, '2019-04-01', NULL, '2019-04-01 13:37:52', 4, 4, '2019-04-01 13:37:41', '2019-04-01 13:37:52', 113, 3, 0, NULL, 123),
(137, 1, '4058/2016', '04972.207030/2015-01', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnica e formulaÃ§Ã£o de quesitos.', NULL, '2019-04-01', NULL, '2019-04-01 13:39:42', 4, 4, '2019-04-01 13:39:35', '2019-04-01 13:39:42', 126, 3, 0, NULL, 123),
(138, 1, '1446/2018', '04972.207030/2015-01', 1, 'ManifestaÃ§Ã£o acerca do laudo pericial.', NULL, '2019-04-01', NULL, '2019-04-01 13:42:08', 4, 4, '2019-04-01 13:41:37', '2019-04-01 13:42:08', 126, 3, 0, NULL, 123),
(139, 1, '2253/2018', '04972.207030/2015-01', 1, 'ManifestaÃ§Ã£o sobre laudo pericial.', NULL, '2019-04-01', NULL, '2019-04-01 13:44:02', 4, 4, '2019-04-01 13:43:58', '2019-04-01 13:44:02', 126, 3, 0, NULL, 123),
(140, 1, '428/2019', '04972.207030/2015-01', 1, 'ManifestaÃ§Ã£o sobre laudo complementar.', NULL, '2019-04-01', '2019-04-08', '2019-04-10 14:22:09', 4, 1, '2019-04-01 13:46:08', '2019-04-10 14:22:09', 126, 3, 0, NULL, 123),
(141, 1, '173/2019', '04972.002116/2019-65', 1, 'ManifestaÃ§Ã£o sobre laudo tÃ©cnico.', NULL, '2019-04-01', '2019-04-15', '2019-04-26 12:21:53', 4, 4, '2019-04-01 14:22:06', '2019-04-29 19:23:34', 228, 3, 0, NULL, 124),
(142, 1, '630/2018', '04972.006106/2018-18', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-04-01', NULL, '2019-04-01 16:42:57', 4, 4, '2019-04-01 16:42:55', '2019-04-01 16:42:57', 100, 3, 0, NULL, 125),
(143, 1, '390/2019', '04972.006106/2018-18', 1, 'Informa a data da perÃ­cia.', NULL, '2019-04-01', NULL, '2019-04-01 16:46:42', 4, 4, '2019-04-01 16:46:39', '2019-04-01 16:46:42', 100, 3, 0, NULL, 125),
(144, 1, '4810/2015', '04972.206943/2015-01', 1, 'Informa a data da perÃ­cia.', NULL, '2019-04-01', NULL, '2019-04-01 17:03:55', 4, 4, '2019-04-01 17:03:18', '2019-04-01 17:03:55', 55, 3, 0, NULL, 126),
(145, 1, '2969/2017', '04972.206943/2015-01', 1, 'ManifestaÃ§Ã£o sobre laudo pericial.', NULL, '2019-04-01', NULL, '2019-04-01 17:06:42', 4, 4, '2019-04-01 17:06:40', '2019-04-01 17:06:42', 199, 3, 0, NULL, 126),
(146, 1, '1034/2018', '04972.206943/2015-01', 1, 'Informa a data da perÃ­cia.', NULL, '2019-04-01', NULL, '2019-04-01 17:09:31', 4, 4, '2019-04-01 17:09:28', '2019-04-01 17:09:31', 114, 3, 0, NULL, 126),
(147, 1, '19/2019', '04972.206943/2015-01', 1, 'Informa a data da perÃ­cia.', NULL, '2019-04-01', NULL, '2019-04-01 17:14:39', 4, 4, '2019-04-01 17:14:36', '2019-04-01 17:14:39', 114, 3, 0, NULL, 126),
(148, 1, '14/2019', '04972.206943/2015-01', 1, 'Informa a data da perÃ­cia.', NULL, '2019-04-01', NULL, '2019-04-01 17:16:01', 4, 4, '2019-04-01 17:15:59', '2019-04-01 17:16:01', 234, 3, 0, NULL, 126),
(149, 1, '424/2019', '04972.206943/2015-01', 1, 'Informa a data da perÃ­cia.', NULL, '2019-04-01', NULL, '2019-04-01 17:18:43', 4, 4, '2019-04-01 17:18:41', '2019-04-01 17:18:43', 114, 3, 0, NULL, 126),
(150, 1, '0108/2019', '04972.001591/2019-14', 1, 'manifestar acerca do interesse da UniÃ£o em relaÃ§Ã£o ao local atingido pelo dano ambiental', NULL, '2019-04-01', '2019-03-15', '2019-04-02 12:59:02', 1, 1, '2019-04-01 18:58:24', '2019-04-02 12:59:02', 216, 3, 0, NULL, 127),
(151, 1, '00049/2019', '04972.206919/2015-63', 1, 'manifestaÃ§Ã£o acerca dos documentos juntados pela parte autora no evento 227 (novo memorial descritivo).', NULL, '2019-04-01', '2019-03-15', '2019-04-08 18:39:24', 1, 1, '2019-04-01 19:27:38', '2019-04-08 18:39:24', 224, 3, 0, NULL, 128),
(152, 1, '00177/2019', '04972.010806/2018-15', 1, 'esclarecer a situaÃ§Ã£o do imÃ³vel objeto da controvÃ©rsia (RFFSA), em defesa da nossa posiÃ§Ã£o jurÃ­dica eventualmente tangida', NULL, '2019-04-01', '2019-04-01', '2019-04-02 12:56:10', 1, 1, '2019-04-01 19:46:41', '2019-04-02 12:56:10', 106, 3, 0, NULL, 130),
(153, 1, '1488/2017', '04972.006326/2017-61', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-04-02', NULL, '2019-04-02 13:27:31', 4, 4, '2019-04-02 13:27:29', '2019-04-02 13:27:31', 105, 3, 0, NULL, 134),
(154, 1, '170/2019', '04972.006326/2017-61', 1, 'Informe se os requeridos regularizam a ocupaÃ§Ã£o do imÃ³vel objeto da lide, nos termos do acordo do ev. 69.', NULL, '2019-04-02', NULL, '2019-04-02 13:31:21', 4, 4, '2019-04-02 13:31:19', '2019-04-02 13:31:21', 228, 3, 0, NULL, 134),
(155, 1, '6/2019', '04972.003727/2018-40', 1, 'prestar informaÃ§Ãµes sobre o processo administrativo nÂ° 04972.003727/2018-40, da Prefeitura Municipal de SÃ£o JosÃ©, relacionado com os dados dos  imÃ³veis sobre terras de marinha, localizados entre a foz do Rio Maruim e a foz do Rio AraÃºjo, tendo em vista o teor do relatÃ³rio de execuÃ§Ã£o do diagnÃ³stico socio ambiental apresentado pela FMADS (anexo ao ofÃ­cio)', 'A demanda foi mantida aberta para acompanhamento da aÃ§Ã£o de identificaÃ§Ã£o dos imÃ³veis da SÃ£o JosÃ©. Solicitamos dilaÃ§Ã£o do prazo em 30 dias em 12/07/2019', '2019-01-08', '2019-08-12', NULL, 1, 1, '2019-04-02 13:40:35', '2019-07-12 16:57:48', 90, 2, 0, NULL, 135),
(156, 2, '01/04/2019', '04972.003727/2018-40', 1, 'fornecer informaÃ§Ãµes cartogrÃ¡ficas (mapa, planta, carta topogrÃ¡fica, etc, preferencialmente em meiodigital), contendo a delimitaÃ§Ã£o dos lotes na Ã¡rea de estudo (Terras de Marinha na Orla Sul do MunicÃ­pio de SÃ£o JosÃ©,situados entre a foz do rio Maruim e a foz do rio AraÃºjo), com a respectiva identificaÃ§Ã£o dos RIPs. Pede-se que a referida cartografia deve ter escala adequada para que seja possÃ­vel identificar cada um dos imÃ³veis.', 'Solicitamos dilaÃ§Ã£o do prazo em 30 dias em 12/07/2019.', '2019-04-02', '2019-08-12', NULL, 1, 1, '2019-04-02 13:58:22', '2019-07-12 16:58:07', 235, 2, 0, NULL, 135),
(157, 1, '454/2019', '04972.002177/2019-22', 1, 'o OfÃ­cio 454/2019 - NUP 04972.002177/2019-22, trata de terras indÃ­genas e a UniÃ£o foi condenada na obrigaÃ§Ã£o de fazer consistente na adoÃ§Ã£o das providÃªncias administrativas e judiciais necessÃ¡rias para impedir obras e invasÃµes na terra indÃ­gena Cambirela, na PalhoÃ§a, bem como demolir  as construÃ§Ãµes ilegais jÃ¡ implantadas e recuperaÃ§Ã£o ambiental.', NULL, '2019-04-02', '2019-04-16', NULL, 3, 1, '2019-04-02 16:40:59', '2019-04-23 13:50:57', 114, 4, 0, NULL, 1),
(158, 1, '455/2019', '04972.007530/2013-75', 1, 'o OfÃ­cio 455/2019 - NUP 04972.002119/2019-07, trata da abertura de acessos em Governador Celso Ramos. O MunicÃ­pio alegou que a UniÃ£o (SPU) nÃ£o estava cumprindo a parte dela e o juiz determinou que a UniÃ£o em 15 dias informe quais sÃ£o as inscriÃ§Ãµes e/ou aforamentos de terras de marinha cuja manutenÃ§Ã£o pela UniÃ£o estariam impedindo a abertura dos acessos, bem como que fosse informadas eventuais ocupaÃ§Ãµes irregulares.\r\n\r\nO NUP 04972.001952/2017-61 que trata do pedido de retificaÃ§Ã£o efetuado pelo MunicÃ­pio de Governador Celso Ramos estÃ¡ sendo tratado pelo Eng. Marcelo.\r\nO NUP 04972.007530/2013-75 trata dos procedimentos adotados atÃ© o momento pela SPU/SC para  a execuÃ§Ã£o da sentenÃ§a.', NULL, '2019-04-02', '2019-04-16', '2019-04-29 19:25:54', 3, 1, '2019-04-02 16:49:18', '2019-05-15 14:05:40', 114, 3, 1, NULL, 139),
(159, 1, '66/2018', '04972.008437/2017-10', 1, '[i] seja informado, por meio de planilha descritiva [mÃªs a mÃªs], os valores devidos no perÃ­odo compreendido entre 2006 a 2018, levando em conta a nova forma de reajuste determinado pelo provimento jurisdicional antes referido [aplicaÃ§Ã£o de Ã­ndices inflacionÃ¡rios]; [ii] informar o valor a ser abatido do valor depositado em juÃ­zo, e cuja devoluÃ§Ã£o estÃ¡ sendo requerida pela demandante, de acordo com os extratos juntados aos autos, a fim de que a UniÃ£o possa impugnar a execuÃ§Ã£o do julgado se for o caso.', NULL, '2019-04-02', NULL, '2019-04-02 17:43:40', 4, 4, '2019-04-02 17:41:49', '2019-04-02 17:43:40', 102, 3, 0, NULL, 140),
(160, 1, '373/2019', '04972.008437/2017-10', 1, 'Demonstrativo administrativo atualizado do dÃ©bito controvertido, a fim de se aferir a necessidade de ajustes dos cÃ¡lculos.', NULL, '2019-04-02', '2019-03-26', '2019-04-02 17:53:13', 4, 4, '2019-04-02 17:53:08', '2019-04-02 17:53:13', 100, 3, 0, NULL, 140),
(161, 1, '385/2018', '04972.004256/2018-97', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-04-02', NULL, '2019-04-02 18:16:55', 4, 4, '2019-04-02 18:16:53', '2019-04-02 18:16:55', 107, 3, 0, NULL, 142),
(162, 1, '21/2018', '04972.004256/2018-97', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-04-02', NULL, '2019-04-02 18:18:33', 4, 4, '2019-04-02 18:18:31', '2019-04-02 18:18:33', 99, 3, 0, NULL, 142),
(163, 1, '424/2019', '04972.004256/2018-97', 1, 'ManifestaÃ§Ã£o sobre a alegada inconsistÃªncia de coordenadas.', NULL, '2019-04-02', '2019-04-08', '2019-04-10 14:31:09', 4, 1, '2019-04-02 18:32:27', '2019-04-10 14:31:09', 100, 3, 0, NULL, 142),
(164, 1, '00072/2019', '04972.002766/2019-19', 1, 'prestar subsÃ­dios aptos a demonstrar a regularidade da cobranÃ§a da taxa de ocupaÃ§Ã£o', 'null', '2019-04-02', '2019-04-12', '2019-05-28 17:07:11', 1, 4, '2019-04-02 18:33:27', '2019-08-30 21:10:19', 236, 3, 0, NULL, 143),
(165, 1, '3177/2017', '04972.007519/2017-39', 1, 'IndicaÃ§Ã£o de assistente e formulaÃ§Ã£o de quesitos.', NULL, '2019-04-02', NULL, '2019-04-02 18:55:59', 4, 4, '2019-04-02 18:55:57', '2019-04-02 18:55:59', 199, 3, 0, NULL, 144),
(166, 1, '1240/2018', '04972.004416/2016-36', 1, 'aferir a existÃªncia de registro em cartÃ³rio de imÃ³vel pertencente Ã  UniÃ£o em nome de terceiros como proprietÃ¡rios.', NULL, '2019-04-03', NULL, '2019-04-03 12:11:20', 8, 8, '2019-04-03 12:10:34', '2019-04-03 12:11:20', 199, 3, 1, NULL, 145),
(167, 1, 'n. 0005949-48.2011.8.24.0075-0005', '04972.001765/2019-49', 1, 'solicita que seja manifestado interesse nos seguintes bens: 2 aros de liga leve para automÃ³veis', NULL, '2019-04-03', '2019-04-22', '2019-04-05 19:08:09', 4, 4, '2019-04-03 18:30:23', '2019-04-05 19:08:09', 237, 3, 0, NULL, 146),
(168, 1, '00191/2019', '50067468920164047208', 1, 'anÃ¡lise laudo pericial.', NULL, '2019-04-03', '2019-04-12', '2019-05-09 17:18:59', 8, 4, '2019-04-03 18:37:47', '2019-05-16 17:54:09', 106, 3, 0, NULL, 147),
(169, 1, '00180/2019', '04972.000415/2017-01', 1, 'Aeroporto de Navegantes', NULL, '2019-04-03', '2019-04-08', '2019-05-09 17:21:09', 8, 4, '2019-04-03 19:30:50', '2019-05-15 12:34:08', 228, 3, 0, NULL, 149),
(170, 1, '00335/2018', '04972.009642/2018-75', 1, 'manifestaÃ§Ã£o de interesse federal na causa', NULL, '2019-04-03', '2018-11-26', '2019-04-22 13:06:51', 8, 1, '2019-04-03 19:39:33', '2019-04-22 13:06:51', 201, 3, 0, NULL, 152),
(171, 1, '00209/2019', '04972.009778/2018-85', 1, 'manifestaÃ§Ã£o sobre proposta de acordo.', NULL, '2019-04-03', '2019-02-18', '2019-04-08 17:51:45', 8, 5, '2019-04-03 19:53:51', '2019-04-08 17:51:45', 126, 3, 0, NULL, 153),
(172, 2, '23/04/2018', '04972.004802/2018-90', 1, 'Pede manifestaÃ§Ã£o sobre o pedido de cancelamento feito pelo registro de imÃ³veis', NULL, '2019-04-03', NULL, '2019-04-26 13:15:19', 1, 3, '2019-04-03 20:30:23', '2019-04-26 13:15:19', 211, 7, 0, NULL, 154),
(173, 1, '00419/2018', '04972.010479/2018-93', 1, 'subsÃ­dios e informa liminar.', NULL, '2019-04-04', '2019-01-15', '2019-06-25 20:46:22', 8, 1, '2019-04-04 11:27:07', '2019-06-25 20:46:23', 201, 3, 0, NULL, 155),
(174, 1, '2316/2018', '04972.006506/2017-42', 1, 'acompanhamento em imissÃ£o na posse de imÃ³vel em Laguna.', 'Solicitar a situaÃ§Ã£o atualizada da aÃ§Ã£o.', '2019-04-04', NULL, '2019-07-15 19:48:59', 8, 4, '2019-04-04 11:34:49', '2019-07-15 19:49:00', 234, 3, 1, NULL, 156);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `seiMP`, `demanda`, `resumoSituacao`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(175, 1, '00365/2018', '04972.010249/2018-24', 1, 'manifestar interesse no feito.', NULL, '2019-04-04', '2019-01-21', '2019-04-08 18:35:58', 8, 4, '2019-04-04 11:43:49', '2019-04-08 18:35:58', 201, 3, 0, NULL, 158),
(176, 1, '00063/2019', '04972.002491/2016-62', 1, 'manifestaÃ§Ã£o acerca do Laudo Pericial complementar', NULL, '2019-04-04', '2019-04-10', '2019-04-23 14:17:39', 8, 1, '2019-04-04 12:21:38', '2019-04-30 14:43:31', 234, 3, 0, NULL, 159),
(177, 1, '00386/2019', '04972.001056/2017-00', 1, 'indicar servidor para acompanhar imissÃ£o na posse.', NULL, '2019-04-04', '2019-04-01', NULL, 8, NULL, '2019-04-04 12:42:32', '2019-04-04 12:42:32', 126, 5, 0, NULL, 160),
(178, 1, '00068/2019', '04972.007519/2017-39', 1, 'manifestaÃ§Ã£o acerca de Laudo pericial complementar', NULL, '2019-04-04', '2019-04-15', '2019-05-06 14:12:02', 8, 1, '2019-04-04 13:08:30', '2019-05-08 14:56:16', 234, 3, 0, NULL, 144),
(179, 1, '00184/2019', '04972.002117/2019-18', 1, 'indicaÃ§Ã£o de assistente tÃ©cnico', NULL, '2019-04-04', '2019-04-12', '2019-04-23 17:15:40', 8, 4, '2019-04-04 13:21:46', '2019-04-23 17:15:48', 106, 3, 0, NULL, 162),
(180, 1, '2456/2019', '04972.009454/2018-47', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-04-04', NULL, '2019-04-04 14:15:49', 4, 4, '2019-04-04 14:15:42', '2019-04-04 14:15:49', 114, 3, 0, NULL, 163),
(181, 1, '00472/2019', '04972.007816/2018-65', 1, 'informar se hÃ¡ cessÃ£o da Ã¡rea.', NULL, '2019-04-04', '2019-04-05', '2019-04-08 18:32:32', 8, 1, '2019-04-04 16:51:54', '2019-04-08 18:32:32', 126, 3, 0, NULL, 164),
(182, 1, '0470/2019', '04972.203332/2015-01', 1, 'reintegraÃ§Ã£o de posse. Porto de laguna', NULL, '2019-04-04', '2019-04-15', '2019-05-07 13:44:33', 8, 1, '2019-04-04 17:24:09', '2019-05-07 13:44:35', 126, 3, 0, NULL, 165),
(183, 1, '00059/2019', '04972.001400/2017-52', 1, 'ciÃªncia de perÃ­cia.', NULL, '2019-04-04', '2019-05-20', '2019-04-04 18:04:21', 8, 8, '2019-04-04 18:04:16', '2019-04-04 18:04:21', 234, 3, 0, NULL, 166),
(184, 1, '00456/2019', '04972.202317/2015-37', 1, 'manifestaÃ§Ã£o sobre Laudo complementar', NULL, '2019-04-05', '2019-04-11', '2019-05-21 18:56:17', 8, 3, '2019-04-05 12:02:56', '2019-05-21 19:21:59', 114, 3, 0, NULL, 167),
(185, 1, '00439/2019', '04972.006484/2017-11', 1, 'retirar suspensÃ£o. AÃ§Ã£o julgada improcedente.', NULL, '2019-04-05', NULL, '2019-04-05 13:06:37', 8, 8, '2019-04-05 13:06:16', '2019-04-05 13:06:37', 114, 3, 1, NULL, 168),
(186, 1, '00429', '04972.002933/2018-32', 1, 'ciÃªncia de vistoria tÃ©cnica.', NULL, '2019-04-05', '2019-04-25', '2019-04-05 13:26:37', 8, 8, '2019-04-05 13:26:27', '2019-04-05 13:26:37', 126, 3, 0, NULL, 169),
(187, 1, '00441/2019', '04972.003787/2018-62', 1, 'indicaÃ§Ã£o de assistente tÃ©cnico e formulaÃ§Ã£o de quesitos.', NULL, '2019-04-05', '2019-04-15', '2019-04-23 14:34:16', 8, 1, '2019-04-05 13:40:25', '2019-04-30 18:02:01', 126, 3, 0, NULL, 170),
(188, 1, '104/2019', '04972.001589/2019-45', 1, 'informar a situaÃ§Ã£o cadastral Loteamento Green Ville, localizado na Rodovia Jorge Lacerda, Km 12,4, Ilhota/SC', NULL, '2019-04-05', '2019-03-29', '2019-04-15 18:41:31', 8, 3, '2019-04-05 17:14:47', '2019-04-15 18:41:31', 76, 3, 0, NULL, 171),
(189, 1, '981/2019', '04972.001754/2019-69', 1, 'informaÃ§Ã£o se a Obra de arrimo das margens do RibeirÃ£o Capela e reconstruÃ§Ã£o de ponte de concreto. Ratones, FlorianÃ³polis/SC, interfere com bens da UniÃ£o.', NULL, '2019-04-05', '2019-03-29', '2019-04-10 14:13:41', 8, 1, '2019-04-05 17:20:09', '2019-04-10 14:13:41', 95, 3, 0, NULL, 172),
(190, 1, '0613/2019', '04972.001800/2019-20', 1, 'Informar se o Ã¡rea localizada na Estrada Intendente AntÃ³nio Damasco, s/nÂ°, ao Iaco doj \"Trevo\'s Bar\", Ratones, FlorianÃ³polis/SC, coordenadas de referÃªncia Datum WGS -84 -27.489785Â°S / -48.493368Â°O, incide em terrenos de marinha e seus acrescidos.', NULL, '2019-04-05', '2019-04-22', '2019-04-10 14:44:19', 8, 1, '2019-04-05 17:33:36', '2019-04-10 14:44:19', 187, 3, 0, NULL, 173),
(191, 1, '146/2019', '04972.000663/2017-44', 1, 'informaÃ§Ã£o sobre a regularidade cadastral Marina PatrÃ­cio, localizada na Rua Luis Joaquim dos Santos, bairro SÃ£o Pedro, no MunicÃ­pio de Navegantes/SC, Ã s margens do Rio ItajaÃ­-AÃ§u.', NULL, '2019-04-05', '2019-04-18', '2019-06-19 16:40:36', 8, 4, '2019-04-05 17:39:07', '2019-06-19 16:40:37', 74, 3, 0, NULL, 174),
(192, 1, '00069/2019', '04972.006391/2018-77', 1, 'informaÃ§Ã£o atualizada sobre a efetivaÃ§Ã£o da transferÃªncia do imÃ³vel (barragem oeste TaiÃ³/SC)', NULL, '2019-04-05', '2019-05-06', '2019-04-26 12:43:51', 8, 3, '2019-04-05 17:43:06', '2019-04-26 12:43:56', 234, 3, 0, NULL, 175),
(193, 1, '51/2019', '04972.206928/2015-54', 1, 'informaÃ§Ãµes se jÃ¡ houve a conclusÃ£o dos trabalhos referentes a regularizaÃ§Ã£o da delimitaÃ§Ã£o da Linha de Preamar MÃ©dia/1831 e, em caso negativo, quais as medidas adotadas para a referida\r\nregularizaÃ§Ã£o.', NULL, '2019-04-05', '2019-04-09', '2019-05-29 18:20:32', 8, 1, '2019-04-05 17:52:30', '2019-05-29 18:20:33', 239, 3, 0, NULL, 176),
(194, 1, '00073/2019', '04972.008923/2018-19', 1, 'informaÃ§Ãµes complementares Ã  NT 5876/2016', NULL, '2019-04-05', '2019-04-29', '2019-05-06 13:55:28', 8, 1, '2019-04-05 17:59:23', '2019-05-08 14:50:05', 224, 3, 0, NULL, 72),
(195, 1, '00454/2019', '04972.002177/2019-22', 1, 'LIMINAR para a adoÃ§Ã£o das providÃªncias administrativas e judiciais para impedir obras e invasÃµes na terra indÃ­gena Cambirela, MunicÃ­pio de palhoÃ§a.', NULL, '2019-04-08', '2019-04-16', '2019-04-24 14:11:59', 8, 1, '2019-04-08 12:00:18', '2019-04-25 17:49:42', 114, 3, 1, NULL, 137),
(196, 1, '00477/2019', '04972.002279/2019-48', 1, 'subsÃ­dios para MS. Pedido de remiÃ§Ã£o de aforamento em anÃ¡lise.', NULL, '2019-04-08', '2019-04-08', '2019-05-06 13:40:47', 8, 3, '2019-04-08 12:13:44', '2019-05-06 13:40:50', 114, 3, 0, NULL, 179),
(197, 1, '00007/2019', '04972.002280/2019-72', 1, 'que seja confirmada a ReintegraÃ§Ã£o de posse do imÃ³vel funcional situado na Rua Engenheiro FiÃºza da Rocha, 84, Centro, no MunicÃ­pio de CriciÃºma/SC, com Ã¡rea de 452,23 mÂ², sobre o qual se encontra edificada uma casa de alvenaria de 126,69 mÂ², registrado no 1Â° Oficio do Registro de ImÃ³veis da Comarca de CriciÃºma, sob a matrÃ­cula de nÂº 2.108.', NULL, '2019-04-08', '2019-04-15', '2019-05-28 16:42:38', 8, 5, '2019-04-08 12:21:54', '2019-05-28 16:42:40', 99, 3, 0, NULL, 180),
(198, 1, '00384/219', '04972.001885/2019-46', 1, 'indicar servidor para conciliaÃ§Ã£o, audiÃªncia em 04/06/2019', NULL, '2019-04-08', '2019-06-04', '2019-04-11 13:29:30', 8, 4, '2019-04-08 12:41:18', '2019-04-11 13:29:30', 126, 3, 0, NULL, 181),
(199, 1, '00446/2019', '04972.001815/2018-15', 1, 'informar se a identificaÃ§Ã£o do imÃ³vel levada a efeito pela SPU (evento 101 - INF2) implica cancelamento, ainda que parcial, da enfiteuse que recai sobre o imÃ³vel ocupado pelo autor e, em consequÃªncia, restituiÃ§Ã£o de taxa de ocupaÃ§Ã£o por ele paga a maior.', NULL, '2019-04-08', '2019-04-29', '2019-05-09 17:22:19', 8, 4, '2019-04-08 13:56:13', '2019-05-15 12:50:36', 100, 3, 0, NULL, 182),
(200, 1, '720004508095', '04972.002282/2019-61', 1, 'reabertura de prazo para entrega de tÃ­tulos CondomÃ­nio Habitacional Ernesto Che Guevara', NULL, '2019-04-08', NULL, '2019-04-08 14:05:31', 8, 8, '2019-04-08 14:05:06', '2019-04-08 14:05:31', 240, 3, 1, NULL, 178),
(201, 1, '720004557498', '04972.002283/2019-14', 1, 'reabertura de prazo para entrega de tÃ­tulos CondomÃ­nio Habitacional Ernesto Che Guevara', NULL, '2019-04-08', NULL, '2019-04-08 14:10:01', 8, 8, '2019-04-08 14:09:46', '2019-04-08 14:10:01', 240, 3, 1, NULL, 183),
(202, 1, '720004505970', '04972.002284/2019-51', 1, 'reabertura de prazo para entrega de tÃ­tulos CondomÃ­nio Habitacional Ernesto Che Guevara', NULL, '2019-04-08', NULL, '2019-04-08 14:12:35', 8, 8, '2019-04-08 14:12:20', '2019-04-08 14:12:35', 240, 3, 1, NULL, 184),
(203, 1, '00192/2019', '04972.002207/2019-09', 1, 'elementos de fato e de direito relativos ao caso.\nTerreno de 7.793,40 m2, situado na Rodovia L.A.P, Rodesindo Pavan - Avenida Interpraias, s/n, Bairro Estaleiro, BalneÃ¡rio CamboriÃº-SC, tendo o\nJuÃ­zo Estadual declinado da competÃªncia em razÃ£o de manifestaÃ§Ã£o de interesse da UniÃ£o.', NULL, '2019-04-08', '2019-04-22', '2019-04-22 18:19:17', 8, 4, '2019-04-08 16:42:37', '2019-04-22 18:19:17', 106, 3, 0, NULL, 185),
(204, 1, '400/2019', '04972.001955/2019-66', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-04-08', '2019-04-03', '2019-04-08 17:00:17', 4, 4, '2019-04-08 17:00:09', '2019-04-08 17:00:17', 126, 3, 0, NULL, 186),
(205, 1, '290/2019', '04972.001861/2019-97', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-04-08', '2019-04-03', '2019-04-10 19:39:10', 4, 1, '2019-04-08 17:08:25', '2019-04-10 19:39:10', 100, 3, 0, NULL, 148),
(206, 1, '65/2019', '04972.001953/2019-77', 1, 'ManifestaÃ§Ã£o de interesse', NULL, '2019-04-08', '2019-04-12', '2019-04-08 17:45:05', 4, 4, '2019-04-08 17:45:04', '2019-04-08 17:45:05', 234, 3, 0, NULL, 187),
(207, 1, '00189/2019', '04972.008114/2017-18', 1, 'subsÃ­dios em relaÃ§Ã£o ao parecer 7344936 e a possÃ­vel restituiÃ§Ã£o de valores.', NULL, '2019-04-08', '2019-04-22', '2019-05-15 12:12:39', 8, 3, '2019-04-08 18:26:54', '2019-05-16 17:22:44', 106, 3, 0, NULL, 188),
(208, 1, '457/2019', '04972.002404/2019-10', 1, 'informaÃ§Ãµes acerca da regularidade do rancho de pesca instalado na Praia do Forte, em SÃ£o Francisco do Sul/SC, objeto da AuA n2 41/2017 e Parecer TÃ©cnico Interno n. 730/2017 (cÃ³pias anexas), ern nome de Hugo da Silva Oliveira, CPF 024.127.109-61.', NULL, '2019-04-09', '2019-05-10', '2019-05-15 12:44:01', 8, 1, '2019-04-09 11:39:56', '2019-05-15 12:44:02', 85, 3, 0, NULL, 189),
(209, 1, '319/2019', '04972.001862/2019-31', 1, 'verificaÃ§Ã£o de interferÃªncia com Ã¡rea da UniÃ£o.', NULL, '2019-04-09', '2019-04-22', '2019-04-15 19:18:12', 8, 3, '2019-04-09 13:04:24', '2019-04-15 19:18:12', 82, 3, 0, NULL, 191),
(210, 1, '68/2019', '00556.001729/2016-92', 1, 'informaÃ§Ãµes sobre o andamento da cessÃ£o onerosa da Plataforma de Pesca Entremares AraranguÃ¡', NULL, '2019-04-09', '2019-04-22', '2019-04-25 19:07:54', 8, 3, '2019-04-09 13:31:56', '2019-04-25 19:07:56', 241, 3, 0, NULL, 192),
(211, 1, '376/2019', '04972.000285/2017-07', 1, 'DemoliÃ§Ã£o de Casas na Praia do Forte\r\nO OfÃ­cio da AGU foi respondido, mas ainda falta liberaÃ§Ã£o dos recursos para o cumprimento da sentenÃ§a que determinou a demoliÃ§Ã£o das casas.', 'O que falta fazer:\r\ncontrataÃ§Ã£o da demoliÃ§Ã£o. Fluxo acordado com NUGES/Recursos Internos (Laureano). Ver processo 04972.001973/2019-48.', '2019-04-09', '2019-04-23', NULL, 3, 1, '2019-04-09 16:29:50', '2019-08-12 16:35:00', 126, 2, 1, NULL, 194),
(212, 1, '81/2019', '04972.206525/2015-13', 1, 'a UniÃ£o noticiou ao JuÃ­zo que aquele Ã³rgÃ£o concluiu pela renÃºncia Ã \r\ndÃ­vida do Sr. Santos de Souza, diante do interesse social, restando ainda a questÃ£o da destinaÃ§Ã£o do bem que, conforme\r\na SPU, seria analisada em conjunto com as demais situaÃ§Ãµes existentes na Rua Campos ElÃ­sios, sendo aguardado o\r\nlaudo ambiental para que a DIRFH analise a possibilidade de RegularizaÃ§Ã£o FundiÃ¡ria de Interesse Social.', NULL, '2019-04-09', '2019-04-11', '2019-05-07 13:40:15', 3, 1, '2019-04-09 16:53:25', '2019-05-07 13:40:17', 228, 3, 0, NULL, 195),
(213, 1, '00515/2019', '04972.205855/2015-83', 1, 'manifestaÃ§Ã£o acerca do novo memorial descritivo.', NULL, '2019-04-09', '2019-04-22', '2019-04-22 14:02:56', 8, 4, '2019-04-09 17:21:25', '2019-04-22 14:02:56', 126, 3, 0, NULL, 196),
(214, 1, '79/2019', '04972.006467/2018-64', 1, 'manifestaÃ§Ã£o de interesse no feito.', NULL, '2019-04-09', '2019-04-17', '2019-04-22 18:15:51', 8, 4, '2019-04-09 17:31:39', '2019-04-22 18:15:51', 234, 3, 0, NULL, 197),
(215, 1, '00197/2019', '04972.003918/2016-40', 1, 'informaÃ§Ã£o atualizada acerca dos trabalhos da ComissÃ£o de DemarcaÃ§Ã£o designada pela portaria SPU n. 211/2010, da linha de Preamar MÃ©dia de 1831 (LPM/1831), no MunicÃ­pio de Joinville (SC).', NULL, '2019-04-09', '2019-04-22', '2019-05-14 13:03:53', 8, 1, '2019-04-09 18:04:04', '2019-05-16 18:54:59', 201, 3, 0, NULL, 198),
(216, 6, '985', '04972.002444/2019-61', 1, 'informaÃ§Ãµes sobre existÃªncia de cadastro.', NULL, '2019-04-10', '2019-05-03', '2019-04-10 12:26:09', 8, 8, '2019-04-10 12:25:55', '2019-04-10 12:26:09', 244, 3, 0, NULL, 199),
(217, 1, '0720/2019', '04972.002001/2019-71', 1, 'informar se o local onde foi lavrado o AUTO DE INFRAÃ‡ÃƒO 032211 B encontra-se inserido em Ã¡rea de marinha e seus acrescidos.', NULL, '2019-04-10', '2019-04-23', '2019-04-29 20:23:54', 8, 1, '2019-04-10 14:00:43', '2019-04-29 20:23:56', 245, 3, 0, NULL, 200),
(218, 1, '407/2019', '04972.001863/2019-86', 1, 'informaÃ§Ã£o sobre projeto da rodovia que liga o chamado \"trevo de JaraguÃ¡ do Sul\"', NULL, '2019-04-10', '2019-04-12', '2019-04-23 14:30:34', 8, 1, '2019-04-10 14:08:40', '2019-04-23 14:30:36', 85, 3, 0, NULL, 202),
(219, 1, '0807/2019', '04972.002002/2019-15', 1, 'informar se a Ã¡rea objeto do Auto de InfraÃ§Ã£o de nÂ° 48885, em anexo, incide em terreno de marinha e seus acrÃ©scimos ou Ã¡rea de preservaÃ§Ã£o permanente.', NULL, '2019-04-10', '2019-04-22', '2019-05-28 15:06:54', 8, 1, '2019-04-10 16:00:11', '2019-05-28 15:06:56', 247, 3, 0, NULL, 203),
(220, 4, '0833/2019', '04972.007746/2018-45', 1, 'informar interferÃªncia com terrenos de marinha e se hÃ¡ qualquer procedimento administrativo envolvendo a Ã¡rea.', NULL, '2019-04-10', '2019-04-22', NULL, 8, NULL, '2019-04-10 16:30:40', '2019-04-10 16:30:40', 248, 2, 0, NULL, 204),
(221, 1, '309/2019', '04972.002000/2019-26', 1, 'a cessÃ£o do imÃ³vel situado na Rua ItajaÃ­, 1115, Blumenau/SC, antigo prÃ©dio do MinistÃ©rio do Trabalho,', NULL, '2019-04-10', '2019-04-29', '2019-05-02 17:03:37', 8, 3, '2019-04-10 16:46:42', '2019-05-02 17:24:06', 69, 3, 0, NULL, 205),
(222, 1, '187/2018', '04972.006238/2018-40', 1, 'SentenÃ§a condena UniÃ£o e ao MunicÃ­pio de Bombinhas a demolirem o deck/trapiche', 'Demanda duplicada. Ver demanda [documento:665/2019; NUP: 04972.006238/2018-40]', '2019-04-10', '2019-03-25', '2019-07-10 21:28:20', 1, 1, '2019-04-10 17:33:08', '2019-07-10 21:28:21', 100, 3, 1, NULL, 206),
(223, 1, '016/2019', '04972.001958/2019-08', 1, 'informar sobre documentaÃ§Ã£o do INCRA.', NULL, '2019-04-10', '2019-04-30', '2019-04-10 18:14:29', 8, 8, '2019-04-10 18:14:14', '2019-04-10 18:14:29', 250, 3, 0, NULL, 207),
(224, 1, '1023/2019', '04972.203240/2015-12', 1, 'o envio de mapa atualizado com a linha de marinha incidente sobre a orla de praia do Bairro JoÃ£o Paulo, nessa Capita', NULL, '2019-04-11', '2019-04-15', '2019-05-29 18:11:41', 8, 1, '2019-04-11 13:41:34', '2019-05-29 18:11:42', 95, 3, 0, NULL, 208),
(225, 1, '1653/2019', '04972.002467/2019-76', 1, 'informaÃ§Ãµes a respeito do quanto noticiado, em suma, sobre suposto abandono do terreno da UniÃ£o localizado na Rua JosÃ© da Costa Moellman, em frente ao Tribunal de Contas do Estado.', NULL, '2019-04-11', '2019-04-22', '2019-05-28 15:07:36', 8, 1, '2019-04-11 16:54:44', '2019-05-28 15:07:38', 87, 3, 0, NULL, 209),
(226, 1, '1029/2019', '04972.002466/2019-21', 1, 'disponibilizar cÃ³pia integrai do procedimento relativo ao requerimento de JAIME ANTÃ“NIO PEREIRA, CPF nÂ° 226.812.059-72, para utilizaÃ§Ã£o/regularizaÃ§Ã£o do imÃ³vel da UniÃ£o denominado \"Ilha Grande\" (ou \"Ilha Quinta dos Ganchos\"), situada no municÃ­pio de Governador Celso Ramos/SC', NULL, '2019-04-11', '2019-04-26', '2019-04-29 12:28:50', 8, 8, '2019-04-11 17:03:24', '2019-04-29 12:28:52', 251, 3, 0, NULL, 210),
(227, 1, '473/2019', '04972.002448/2019-40', 1, 'sobre procedimentos de TAUS.', NULL, '2019-04-11', '2019-05-10', '2019-05-22 19:52:42', 8, 1, '2019-04-11 17:07:20', '2019-05-22 19:52:44', 85, 3, 0, NULL, 211),
(228, 1, '1549/2019', '04972.002135/2017-20', 1, 'informaÃ§Ãµes atualizadas sobre o andamento da concessÃ£o de Termos de AutorizaÃ§Ã£o de Uso SustentÃ¡vel (TAUS) para os ranchos de pesca situados no Bairro do AbraÃ£o', NULL, '2019-04-11', '2019-05-08', '2019-05-14 13:38:31', 8, 1, '2019-04-11 17:14:19', '2019-05-14 13:38:34', 95, 3, 0, NULL, 212),
(229, 1, '436/2019', '04972.002309/2016-73', 1, 'informar sobre TAUS na Ilha do Linguado, MunicÃ­pio de BalneÃ¡rio Barra do Sul.', NULL, '2019-04-11', '2019-05-07', NULL, 8, 1, '2019-04-11 17:22:07', '2019-07-30 23:18:04', 85, 3, 0, NULL, 213),
(230, 1, '1559/2019', '04972.200588/2015-58', 1, 'informaÃ§Ãµes sobre TAUS na regiÃ£o do Rio ImaruÃ­m, PalhoÃ§a/SC', NULL, '2019-04-11', '2019-05-08', '2019-05-15 18:14:18', 8, 3, '2019-04-11 17:35:55', '2019-05-15 18:14:20', 95, 3, 0, NULL, 214),
(231, 1, '83/2019', '04972.004078/2013-90', 1, 'cÃ³pia do processo.', NULL, '2019-04-11', '2019-04-23', '2019-05-28 15:04:36', 8, 1, '2019-04-11 17:47:35', '2019-05-28 15:04:36', 239, 7, 0, NULL, 215),
(232, 1, '0300658-20.2016.8.24.0139-0004', '04972.003824/2017-51', 1, 'a descriÃ§Ã£o completa do imÃ³vel, com RIP nÂ° 8265 0000695-91', NULL, '2019-04-11', NULL, NULL, 4, 4, '2019-04-11 18:44:36', '2019-04-11 18:44:52', 252, 2, 0, NULL, 216),
(233, 2, 's/n', '04972.002528/2019-03', 1, 'ContestaÃ§Ã£o de CobranÃ§a, alegaÃ§Ã£o de ilegitimidade passiva - Clube AtlÃ©tico TubarÃ£o', NULL, '2019-04-12', '2019-04-30', '2019-04-30 13:53:33', 3, 1, '2019-04-12 14:36:45', '2019-06-03 23:00:19', 253, 3, 0, NULL, 217),
(234, 1, '16/2019', '04972.629583/2008-84', 1, 'confirmaÃ§Ã£o de cancelamento de DAU.', NULL, '2019-04-12', '2019-04-12', '2019-04-12 16:41:42', 8, 8, '2019-04-12 16:41:40', '2019-04-12 16:41:42', 254, 3, 0, NULL, 218),
(235, 1, '498/2019', '04972.002532/2019-63', 1, 'EsclareÃ§a se o local apontado interfere com terreno de marinha.', NULL, '2019-04-12', '2019-04-17', '2019-04-30 13:46:45', 4, 4, '2019-04-12 16:57:35', '2019-05-03 12:49:15', 255, 3, 0, NULL, 219),
(236, 1, '00501/2019', '04972.002525/2019-61', 1, 'informaÃ§Ãµes sobre TAUS, imÃ³vel no ribeirÃ£o, em nome de Rita de CÃ¡ssia Rodrigues', NULL, '2019-04-12', '2019-04-22', '2019-05-16 18:57:48', 8, 4, '2019-04-12 17:13:30', '2019-05-16 19:00:48', 114, 3, 0, NULL, 220),
(237, 1, '00076/2019', '04972.002397/2019-56', 1, 'informar sobre as atuais ocupaÃ§Ãµes na Ã¡rea objeto da lide.', NULL, '2019-04-12', '2019-05-03', '2019-05-09 12:53:45', 8, 1, '2019-04-12 17:39:40', '2019-05-13 13:01:10', 234, 3, 0, NULL, 221),
(238, 1, '561/2017', '04972.000971/2017-70', 1, 'SubsÃ­dios para a defesa da UniÃ£o.', NULL, '2019-04-15', NULL, '2019-04-15 13:13:25', 4, 4, '2019-04-15 13:13:22', '2019-04-15 13:13:25', 126, 3, 0, NULL, 222),
(239, 1, '843/2017', '04972.000971/2017-70', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-04-15', NULL, '2019-04-15 13:14:45', 4, 4, '2019-04-15 13:14:44', '2019-04-15 13:14:45', 126, 3, 0, NULL, 222),
(240, 1, '2016/2018', '04972.000971/2017-70', 1, 'DisponibilizaÃ§Ã£o de arquivo no formato digital â€œDWGâ€, conforme requerido pelo Perito no item 4\nda petiÃ§Ã£o do evento 133.', NULL, '2019-04-15', NULL, '2019-04-15 13:16:16', 4, 4, '2019-04-15 13:16:11', '2019-04-15 13:16:16', 126, 3, 0, NULL, 222),
(241, 1, '524/2019', '04972.000971/2017-70', 1, 'Informa a data da perÃ­cia.', NULL, '2019-04-15', NULL, '2019-07-12 21:48:58', 4, 1, '2019-04-15 13:18:23', '2019-07-30 22:52:17', 126, 3, 0, NULL, 222),
(242, 1, '1407/2016', '04972.005864/2016-57', 1, 'SubsÃ­dios de fato e de direito Ã  defesa da UniÃ£o', NULL, '2019-04-15', NULL, '2019-04-15 13:26:00', 4, 4, '2019-04-15 13:25:56', '2019-04-15 13:26:00', 107, 3, 0, NULL, 223),
(243, 6, 'N/I', '04972.005864/2016-57', 1, 'Informe a respeito da prorrogaÃ§Ã£o do convÃªnio.', NULL, '2019-04-15', '2019-05-20', NULL, 4, NULL, '2019-04-15 16:56:00', '2019-04-15 16:56:00', 256, 2, 0, NULL, 223),
(244, 1, '741/2017', '04972.004273/2017-43', 1, 'esclarecer se a informaÃ§Ã£o produzida de estar o imÃ³vel situado em zona de seguranÃ§a se deve ao fato de estar situado em faixa de fronteira ou se por outro motivo.', NULL, '2019-04-15', NULL, '2019-05-28 14:57:51', 4, 1, '2019-04-15 17:05:24', '2019-05-28 14:57:53', 172, 3, 0, NULL, 224),
(245, 1, '205/2019', '04972.002536/2019-41', 1, 'Solicita dados para a conversÃ£o em renda dos valores depositados em juÃ­zo.', NULL, '2019-04-15', NULL, '2019-05-28 18:58:36', 4, 4, '2019-04-15 17:12:31', '2019-06-05 20:00:12', 243, 3, 0, NULL, 225),
(246, 1, '80/2019', '04972.002553/2019-89', 1, 'InformaÃ§Ãµes acerca do registro da Ã¡rea expropriada.', NULL, '2019-04-15', NULL, '2019-05-15 12:49:47', 4, 1, '2019-04-15 17:31:27', '2019-05-15 13:04:38', 224, 3, 0, NULL, 226),
(247, 1, '4108/2016', '04972.005172/2016-17', 1, 'InformaÃ§Ãµes acerca da ocupaÃ§Ã£o de Ã¡rea de marinha por RODRIGO MAURO DA SILVA (CPF 019.358.069-12) e ZENILDA JOAQUINA JOAQUIM (CPF 022.026.819-30), principalmente, se sÃ£o ocupantes regularizados junto Ã  SPU/SC.', NULL, '2019-04-15', NULL, '2019-04-15 17:41:34', 4, 4, '2019-04-15 17:41:05', '2019-04-15 17:41:34', 126, 3, 0, NULL, 227),
(248, 1, '86/2018', '04972.005172/2016-17', 1, 'Indique assistente tÃ©cnico e formule quesitos para a defesa da UniÃ£o.', NULL, '2019-04-15', NULL, '2019-04-15 17:43:08', 4, 4, '2019-04-15 17:43:06', '2019-04-15 17:43:08', 126, 3, 0, NULL, 227),
(249, 1, '1025/2018', '04972.005172/2016-17', 1, 'ManifestaÃ§Ã£o acerca do laudo pericial.', NULL, '2019-04-15', NULL, '2019-04-15 17:46:26', 4, 4, '2019-04-15 17:46:24', '2019-04-15 17:46:26', 126, 3, 0, NULL, 227),
(250, 1, '556/2018', '04972.005172/2016-17', 1, 'ManifestaÃ§Ã£o acerca do laudo pericial.', NULL, '2019-04-15', '2019-04-22', '2019-04-23 16:38:17', 4, 1, '2019-04-15 17:48:35', '2019-04-30 18:06:05', 126, 3, 0, NULL, 227),
(251, 1, '1164/2017', '04972.004810/2017-55', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-04-15', NULL, '2019-04-15 18:08:04', 4, 4, '2019-04-15 18:08:00', '2019-04-15 18:08:04', 121, 3, 0, NULL, 228),
(252, 1, '211/2019', '04972.004810/2017-55', 1, 'Solicita a indicaÃ§Ã£o de representante desse Ã³rgÃ£o para acompanhar a audiÃªncia junto ao juÃ­zo federal de FlorianÃ³polis, por videoconferÃªncia, que serÃ¡ realizada em 12/06/2019, Ã s 14h00.', NULL, '2019-04-15', '2019-06-10', '2019-07-23 15:54:53', 4, 4, '2019-04-15 18:13:08', '2019-07-24 16:44:58', 228, 3, 0, NULL, 228),
(253, 1, '213/2019', '04972.002554/2019-23', 1, 'Encaminha o PARECER DE FORÃ‡A EXECUTÃ“RIA n. 00013/2019/CARPS/PUSC/PGU/AGU', NULL, '2019-04-15', NULL, '2019-04-22 14:32:40', 4, 8, '2019-04-15 19:11:43', '2019-04-22 14:32:40', 228, 3, 0, NULL, 229),
(254, 1, '559/2019', '04972.002581/2019-04', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-04-16', '2019-05-03', '2019-05-07 13:57:22', 4, 1, '2019-04-16 16:43:27', '2019-05-07 13:57:23', 166, 3, 0, NULL, 230),
(255, 1, '214/2019', '04972.003436/2018-51', 1, 'Requer seja vistoriado o imÃ³vel pela SPU e acaso esteja em terras de marinha seja feita a inscriÃ§Ã£o de OfÃ­cio com comunicado ao CartÃ³rio competente para averbaÃ§Ã£o na matrÃ­cula', NULL, '2019-04-16', NULL, '2019-06-25 14:36:00', 4, 4, '2019-04-16 17:09:57', '2019-06-26 16:42:10', 121, 3, 0, NULL, 231),
(256, 1, '563/2019', '04972.002583/2019-95', 1, 'Informe se hÃ¡ interferÃªncia com Ã¡rea de domÃ­nio da UniÃ£o e se hÃ¡ interesse em participar do polo ativo da ACP.', NULL, '2019-04-16', '2019-04-22', '2019-05-15 12:56:33', 4, 4, '2019-04-16 17:21:45', '2019-05-15 12:56:34', 126, 3, 0, NULL, 232),
(257, 1, '1790/2015', '04972.205157/2015-88', 1, 'InformaÃ§Ãµes sobre terreno de marinha.', NULL, '2019-04-17', NULL, '2019-04-17 13:43:23', 4, 4, '2019-04-17 13:43:18', '2019-04-17 13:43:23', 82, 3, 0, NULL, 233),
(258, 1, '970/2016', '04972.205157/2015-88', 1, 'ReiteraÃ§Ã£o de OfÃ­cio.', NULL, '2019-04-17', NULL, '2019-04-17 13:51:54', 4, 4, '2019-04-17 13:51:52', '2019-04-17 13:51:54', 82, 3, 0, NULL, 233),
(259, 1, '11/2019', '04972.003480/2018-61', 1, 'SubsÃ­dios para contestaÃ§Ã£o.', NULL, '2019-04-17', NULL, '2019-04-17 13:58:25', 4, 4, '2019-04-17 13:58:21', '2019-04-17 13:58:25', 224, 3, 0, NULL, 234),
(260, 1, '2256/2018', '04972.008840/2018-11', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-04-17', NULL, '2019-04-17 14:11:08', 4, 4, '2019-04-17 14:11:06', '2019-04-17 14:11:08', 126, 3, 0, NULL, 235),
(261, 1, '92/2019', '04972.008840/2018-11', 1, 'ManifestaÃ§Ã£o sobre levantamento planimÃ©trico.', NULL, '2019-04-17', NULL, '2019-04-17 14:17:46', 4, 4, '2019-04-17 14:17:42', '2019-04-17 14:17:46', 126, 3, 0, NULL, 235),
(262, 1, '387/2019', '04972.008840/2018-11', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-04-17', NULL, '2019-04-17 14:19:35', 4, 4, '2019-04-17 14:19:30', '2019-04-17 14:19:35', 126, 3, 0, NULL, 235),
(263, 1, '82/2019', '04972.002597/2019-17', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-04-17', '2019-05-15', '2019-06-13 15:24:02', 4, 4, '2019-04-17 17:38:39', '2019-06-13 22:39:21', 234, 3, 0, NULL, 236),
(264, 1, '44/2019', '04972.003056/2016-55', 1, 'SubsÃ­dios para defesa da UniÃ£o', NULL, '2019-04-17', NULL, '2019-04-17 18:26:45', 4, 4, '2019-04-17 18:26:39', '2019-04-17 18:26:45', 234, 3, 0, NULL, 237),
(265, 1, '269/2019', '04972.002622/2019-54', 1, 'Verifique se os DICs 41380, 35330 e 43643, e a Ã¡rea indicada na fl. 201, de fato, se encontram em terreno de marinha, e, posteriormente, caso positivo, apurar eventual irregularidade na ocupaÃ§Ã£o da Ã¡rea dos lotes parcialmente inseridos em bem da UniÃ£o,', NULL, '2019-04-18', '2019-05-15', '2019-05-23 20:17:53', 4, 1, '2019-04-18 17:57:27', '2019-05-23 20:17:54', 74, 3, 0, NULL, 238),
(266, 1, '154/2019', '04972.002595/2019-10', 1, 'informar se a Ã¡rea em questÃ£o, localizada na Rodovia SC 100 Canto da Lagoa - Laguna, coordenadas 22J 713601/ 6837445, estÃ¡ situada em terrenos de marinha.', NULL, '2019-04-22', '2019-04-29', '2019-04-30 14:50:42', 8, 1, '2019-04-22 13:04:43', '2019-04-30 14:50:44', 257, 3, 0, NULL, 239),
(267, 1, '347/2019', '04972.002302/2019-02', 1, 'averiguar a regularidade ambiental do empreendimento imobiliÃ¡rio \"Jardim das DÃ¡lias\", localizado na Rua Elsbeth Feddersen, s/n, Bairro Salto do Norte, municÃ­pio de Blumenau, CEP 89065-430, potencialmente em Ã¡rea de preservaÃ§Ã£o permanente em virtude da proximidade com o Rio ItajaÃ­-AÃ§u.', NULL, '2019-04-22', '2019-04-24', '2019-05-10 17:03:27', 8, 1, '2019-04-22 13:19:35', '2019-05-10 17:03:28', 75, 3, 0, NULL, 240),
(268, 1, '0204/2019', '04972.004273/2017-43', 1, 'esclarecer a informaÃ§Ã£o produzida de estar o imÃ³vel situado em zona de seguranÃ§a se deve ao fato de estar situado em faixa de fronteira ou se por outro motivo.', NULL, '2019-04-22', '2019-05-10', '2019-05-24 13:41:36', 8, 3, '2019-04-22 13:26:21', '2019-05-24 18:57:13', 228, 3, 0, NULL, 224),
(269, 1, '225/2019', '04972.001237/2019-90', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-04-22', NULL, '2019-04-22 13:54:59', 4, 4, '2019-04-22 13:54:57', '2019-04-22 13:54:59', 114, 3, 0, NULL, 246),
(270, 1, '577/2019', '04972.001237/2019-90', 1, 'ManifestaÃ§Ã£o sobre novos documentos.', NULL, '2019-04-22', '2019-05-01', '2019-05-06 13:53:50', 4, 1, '2019-04-22 13:56:27', '2019-05-08 14:53:33', 126, 3, 0, NULL, 246),
(271, 1, '578/2019', '04972.002684/2019-66', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o', NULL, '2019-04-22', '2019-04-30', '2019-05-06 12:17:27', 4, 4, '2019-04-22 17:12:42', '2019-05-29 19:49:28', 126, 3, 0, NULL, 250),
(272, 1, '579/2019', '04972.002686/2019-55', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-04-22', '2019-04-30', '2019-04-30 18:29:20', 4, 1, '2019-04-22 17:36:47', '2019-04-30 18:58:03', 126, 3, 0, NULL, 252),
(273, 1, '94/2019', '03011441320168240007', 1, 'ManifestaÃ§Ã£o sobre novos documentos.', NULL, '2019-04-22', NULL, '2019-05-09 17:31:46', 4, 4, '2019-04-22 17:51:01', '2019-05-15 13:30:11', 234, 3, 0, NULL, 254),
(274, 1, '01/2019', '04972.002668/2018-92', 1, 'cÃ³pia do processo administrativo n. 04972.003180/2010-25.', NULL, '2019-04-22', '2019-05-13', '2019-05-28 15:04:00', 8, 1, '2019-04-22 18:17:31', '2019-05-28 15:04:01', 258, 3, 0, NULL, 255),
(275, 1, '00584/2019', '04972.002694/2019-00', 1, 'manifestaÃ§Ã£o de interesse em integrar o polo ativo.', NULL, '2019-04-23', '2019-04-26', '2019-05-06 14:22:16', 8, 1, '2019-04-23 13:05:15', '2019-05-08 14:57:28', 126, 3, 0, NULL, 256),
(276, 1, '0523/2019', '04972.007301/2011-99', 1, 'Verificar se hÃ¡ documentaÃ§Ã£o hÃ¡bil para a realizaÃ§Ã£o da transferÃªncia do RIP 8105.0005756-59.', NULL, '2019-04-23', '2019-05-31', '2019-04-25 12:08:21', 8, 8, '2019-04-23 13:50:51', '2019-04-25 12:08:22', 259, 3, 0, NULL, 257),
(277, 1, '594/2019', '04972.002731/2019-71', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-04-23', '2019-04-26', '2019-04-25 18:24:45', 4, 3, '2019-04-23 16:53:51', '2019-04-25 18:57:35', 126, 3, 0, NULL, 258),
(278, 1, '220/2019', '04972.002739/2019-38', 1, 'InformaÃ§Ãµes e documentos referentes ao imÃ³vel.', NULL, '2019-04-23', '2019-05-06', '2019-05-09 17:30:15', 4, 4, '2019-04-23 18:36:13', '2019-05-09 17:30:16', 106, 3, 0, NULL, 259),
(279, 1, '2425/2018', '04972.009286/2018-90', 1, 'encaminhar ao setor de cadastro para futuro cadastramento.', NULL, '2019-04-23', NULL, '2019-04-29 14:12:08', 8, 8, '2019-04-23 18:54:25', '2019-04-29 14:12:09', 114, 3, 1, NULL, 260),
(280, 1, '256/2018', '04972.008544/2018-11', 1, 'SubsÃ­dios Ã¡ defesa da UniÃ£o.', NULL, '2019-04-23', NULL, '2019-04-23 19:13:43', 4, 4, '2019-04-23 19:13:07', '2019-04-23 19:13:44', 121, 3, 0, NULL, 261),
(281, 1, '221/2019', '04972.008544/2018-11', 1, 'Manifestar-se acerca da proposta de acordo e trazer mapa', NULL, '2019-04-23', NULL, '2019-05-09 17:32:18', 4, 4, '2019-04-23 19:15:33', '2019-05-15 12:39:04', 121, 3, 0, NULL, 261),
(282, 1, '60/2019', '10983.004479/8922', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-04-24', '2019-04-17', '2019-05-03 18:55:18', 4, 4, '2019-04-24 18:14:31', '2019-05-03 18:55:22', 224, 3, 0, NULL, 262),
(283, 1, '118/2019', '04972.201016/2015-96', 1, 'Encaminha o Parecer de forÃ§a executÃ³ria 9/2019.', NULL, '2019-04-24', NULL, '2019-05-30 18:26:15', 4, 3, '2019-04-24 18:43:03', '2019-06-12 16:11:12', 260, 3, 0, NULL, 263),
(284, 1, '1345/2016', '04972.005692/2016-11', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o', NULL, '2019-04-24', NULL, '2019-04-24 19:41:22', 4, 4, '2019-04-24 19:40:57', '2019-04-24 19:41:24', 109, 3, 0, NULL, 264),
(285, 1, '223/2019', '04972.005692/2016-11', 1, 'InformaÃ§Ãµes sobre PermissÃ£o de Uso.', NULL, '2019-04-24', NULL, '2019-05-17 13:07:54', 4, 3, '2019-04-24 19:43:28', '2019-05-17 13:28:01', 121, 3, 0, NULL, 264),
(286, 6, 'MANDADO DE SEGURANÃ‡A NÂº 5008044-38.2019.4.04.7200/SC', '04972.002791/2019-94', 1, 'liminar, concedendo o prazo de 60 (sessenta) dias, para que a autoridade coatora promova anÃ¡lise do Pedido de RetificaÃ§Ã£o de Ãrea, requerimento/processo administrativo sob nÂº 0497.2008.469/2017-\r\n15. MunicÃ­pio de Itapema/SC. Prestar informaÃ§Ãµes atÃ© 09/05/2019.', NULL, '2019-04-25', NULL, '2019-05-07 16:35:40', 3, 3, '2019-04-25 14:39:16', '2019-05-07 16:35:48', 261, 3, 1, NULL, 266),
(287, 1, '1045/2018', '04902.001135/2018-17', 1, 'suspensÃ£o da exigibilidade da cobranÃ§a.', NULL, '2019-04-26', NULL, '2019-04-26 13:34:17', 4, 4, '2019-04-26 13:33:52', '2019-04-26 13:34:20', 260, 3, 0, NULL, 267),
(288, 1, '2377/2018', '04902.001135/2018-17', 1, 'informa que as determinaÃ§Ãµes da decisÃ£o de Evento 33 dos autos de 2Âº Grau (expediÃ§Ã£o de CertidÃ£o Negativa de DÃ©bito em nome do requerente) nÃ£o mais geram efeitos e nÃ£o necessitam mais serem cumpridas.', NULL, '2019-04-26', NULL, '2019-04-26 13:37:51', 4, 4, '2019-04-26 13:37:20', '2019-04-26 13:37:52', 209, 3, 0, NULL, 267),
(289, 1, '125/2019', '04902.001135/2018-17', 1, 'seja informado se o comprovante de pagamento anexo (data limite de pagamento 11/04/2019) Ã© suficiente para o pagamento do dÃ©bito do autor vinculada aos imÃ³veis matriculados sob os nÂº s 81.682, 81.687, 81.712 e 81.713 e objeto da aÃ§Ã£o judicial nÂº 5013141-60.2012.4.04.7201.', NULL, '2019-04-26', '2019-05-03', '2019-04-30 14:31:55', 4, 1, '2019-04-26 13:39:31', '2019-06-03 22:58:54', 260, 3, 0, NULL, 267),
(290, 1, '226/2019', '04972.002882/2019-20', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-04-26', NULL, '2019-05-21 19:07:32', 4, 1, '2019-04-26 14:07:15', '2019-07-31 15:46:46', 121, 3, 0, NULL, 268),
(291, 1, '509/2017', '04972.000898/2017-36', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-04-26', NULL, '2019-04-26 16:54:16', 4, 4, '2019-04-26 16:54:04', '2019-04-26 16:54:17', 55, 3, 0, NULL, 269),
(292, 1, '307/2018', '04972.000898/2017-36', 1, 'ManifestaÃ§Ã£o sobre novos documentos.', NULL, '2019-04-26', NULL, NULL, 4, 4, '2019-04-26 16:55:46', '2019-04-26 16:55:53', 199, 4, 0, NULL, 269),
(294, 1, '359/2018', '04972.000898/2017-36', 1, 'solicita que este Ã³rgÃ£o analise os documentos colacionados aos autos de matrÃ­cula no registro de imÃ³veis ou outros documentos do processo que entender pertinentes, visando aferir a existÃªncia de registro de imÃ³vel pertencente Ã  UniÃ£o em nome de terceiros', NULL, '2019-04-26', NULL, '2019-04-26 17:00:21', 4, 4, '2019-04-26 17:00:03', '2019-04-26 17:00:23', 199, 3, 0, NULL, 269),
(295, 1, '469/2019', '04972.000898/2017-36', 1, 'ManifestaÃ§Ã£o sobre novos documentos.', NULL, '2019-04-26', '2019-04-19', '2019-05-06 14:10:13', 4, 1, '2019-04-26 17:04:09', '2019-05-08 14:55:01', 126, 3, 0, NULL, 269),
(296, 1, '630/2019', '04972.002922/2019-33', 1, 'Comunica acerca de editais de leilÃ£o', NULL, '2019-04-26', NULL, NULL, 4, NULL, '2019-04-26 17:37:00', '2019-04-26 17:37:00', 126, 2, 0, NULL, 270),
(297, 1, '632/2019', '04972.001677/2017-85', 1, 'ManifestaÃ§Ã£o sobre laudo complementar.', NULL, '2019-04-26', '2019-05-06', '2019-05-09 17:22:46', 4, 4, '2019-04-26 18:03:22', '2019-05-15 13:20:40', 114, 3, 0, NULL, 271),
(298, 1, '1841/2019-GAB-EB', '04972.005810/2016-91', 1, 'informaÃ§Ã£o acerca dos procedimentos adotados para regularizar o imÃ³vel localizado na Rua Silva Jardim, nÂ° 1278, Bairro Prainha, em FlorianÃ³polis.', NULL, '2019-04-29', '2019-05-13', '2019-05-30 14:12:36', 8, 3, '2019-04-29 12:22:13', '2019-05-30 14:12:38', 95, 3, 0, NULL, 272),
(299, 1, '227/2019', '04972.004198/2017-11', 1, 'ComprovaÃ§Ã£o quanto a conclusÃ£o do Processo de IncorporaÃ§Ã£o.', NULL, '2019-04-29', '2019-05-03', '2019-05-24 19:01:47', 4, 3, '2019-04-29 14:01:07', '2019-05-24 19:01:49', 121, 3, 0, NULL, 273),
(300, 1, '561/2019', '04972.003557/2018-01', 1, 'Informa a data da realizaÃ§Ã£o de PerÃ­cia.', NULL, '2019-04-29', NULL, '2019-04-29 16:42:58', 4, 4, '2019-04-29 16:42:40', '2019-04-29 16:42:59', 100, 3, 0, NULL, 274),
(301, 1, '85/2019', '00439993720138240023', 1, 'ManifestaÃ§Ã£o de interesse', NULL, '2019-04-29', NULL, '2019-05-09 17:32:43', 4, 4, '2019-04-29 17:43:29', '2019-05-15 12:53:41', 224, 3, 0, NULL, 275),
(302, 1, '86/2019', '04972.002791/2019-94', 1, 'subsÃ­dios para a elaboraÃ§Ã£o de defesa contra a decisÃ£o, caso haja interesse da SPU.', NULL, '2019-04-29', NULL, '2019-05-07 16:37:22', 4, 1, '2019-04-29 19:19:29', '2019-07-30 23:20:51', 224, 3, 0, NULL, 266),
(303, 1, '2346/2018', '04972.008984/2018-78', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o', NULL, '2019-04-29', NULL, '2019-04-29 19:54:11', 4, 4, '2019-04-29 19:53:44', '2019-04-29 19:54:11', 126, 3, 0, NULL, 276),
(304, 1, '650/2019', '04972.008984/2018-78', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos', NULL, '2019-04-29', '2019-05-06', '2019-05-09 17:26:27', 4, 4, '2019-04-29 19:55:54', '2019-05-15 13:12:50', 126, 3, 0, NULL, 276),
(305, 1, '1884/2019', '04972.003069/2019-77', 1, 'informar a regularidade do imÃ³vel localizado na Rua JoÃ£o Becker, 1777 - Praia dos Ingleses - FlorianÃ³polis/SC', NULL, '2019-04-30', '2019-05-29', '2019-05-28 20:19:23', 8, 4, '2019-04-30 12:29:29', '2019-05-28 20:19:25', 95, 3, 0, NULL, 277),
(306, 1, '652/2019', '04972.003072/2019-91', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-04-30', '2019-04-08', '2019-05-10 17:05:35', 4, 4, '2019-04-30 14:08:54', '2019-05-15 14:15:51', 114, 3, 0, NULL, 278),
(307, 1, '87/2019', '04972.001675/2017-96', 1, 'Que sejam adotadas as providÃªncias para o cumprimento do acordo.', NULL, '2019-04-30', NULL, NULL, 4, NULL, '2019-04-30 16:50:50', '2019-04-30 16:50:50', 224, 2, 0, NULL, 73),
(308, 2, 's/n', '04972.003074/2019-80', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o', NULL, '2019-04-30', '2019-05-15', '2019-05-14 16:59:42', 4, 3, '2019-04-30 17:35:14', '2019-05-14 16:59:45', 22, 3, 0, NULL, 279),
(309, 2, 'Processo SPU 03129454920188240008', '04972.002600/2019-94', 1, 'reitero a solicitaÃ§Ã£o de manifestaÃ§Ã£o dessa SPU quando Ã  retificaÃ§Ã£o de registro imobiliÃ¡rio com base nos dados que constam nos autos, jÃ¡ que a UniÃ£o foi citada e deverÃ¡ contestar dentro do prazo processual. Reencaminho a planta, agora legÃ­vel, onde o sr. poderÃ¡ encontrar as coordenadas. Ressalto que conforme consta na inicial, o pedido se restringe', NULL, '2019-04-30', '2019-04-30', '2019-04-30 18:55:44', 1, 1, '2019-04-30 17:49:02', '2019-04-30 19:11:57', 228, 3, 0, NULL, 280),
(310, 1, '449/2016', '04972.002869/2016-28', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-04-30', '2019-04-22', '2019-04-30 18:12:42', 4, 4, '2019-04-30 18:11:36', '2019-07-02 20:42:39', 121, 3, 0, NULL, 281),
(311, 1, '378/2018', '04972.002869/2016-28', 1, 'Informe se existem ou se jÃ¡ existiram ocupaÃ§Ãµes em terreno de marinha registradas em nome das seguintes pessoas:\nJAIME CORREA (002.899.499-04) ;\nBEATRIZ DE MACEDO CORREA (511.122.059-34);\nPAULO CESAR CORREA (392.958.939-72);\nROSANA CORREA LOPES (457.511.299-20).', NULL, '2019-04-30', NULL, '2019-04-30 18:19:15', 4, 4, '2019-04-30 18:18:08', '2019-07-02 20:44:44', 228, 3, 0, NULL, 281),
(312, 1, '380/2018', '04972.002869/2016-28', 1, 'CÃ³pia integral do processo administrativo em que a empresa autora pediu a revisÃ£o da posiÃ§Ã£o da LPM - 1831 - processo 11452.001088-73 - protocolo 04972.005842/2010-00.', NULL, '2019-04-30', NULL, '2019-04-30 18:23:29', 4, 4, '2019-04-30 18:21:44', '2019-04-30 18:23:30', 228, 3, 0, NULL, 281),
(313, 1, '01/2019', '04972.003071/2019-46', 1, 'usucapiÃ£o imÃ³vel localizado', NULL, '2019-05-02', '2019-05-15', '2019-05-06 14:28:44', 8, 1, '2019-05-02 13:14:47', '2019-05-08 14:59:37', 262, 3, 0, NULL, 282),
(314, 1, '89/2019', '04972.003121/2019-95', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-05-02', '2019-05-03', '2019-05-06 17:43:15', 4, 3, '2019-05-02 17:11:31', '2019-05-07 18:38:14', 234, 3, 0, NULL, 283),
(315, 1, '2922/2016', '04972.004026/2016-66', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-02', NULL, '2019-05-02 19:16:29', 4, 4, '2019-05-02 19:16:13', '2019-05-02 19:16:29', 126, 7, 0, NULL, 284),
(316, 1, '92/2019', '04972.004026/2016-66', 1, 'Informa a data da perÃ­cia.', NULL, '2019-05-02', NULL, '2019-08-19 15:55:11', 4, 4, '2019-05-02 19:17:58', '2019-08-19 15:55:11', 234, 7, 0, NULL, 284),
(317, 1, '238/2019', '04972.003136/2019-53', 1, 'subsÃ­dios de defesa, informando em especial se a Ã¡rea Ã© ocupada regularmente pelos rÃ©us e/ou terceiros, e em caso negativo, se foram tomadas providÃªncias para a regularizaÃ§Ã£o do imÃ³vel ou medidas fiscalizatÃ³rios ou protetivas de defesa do patrimÃ´nio nacional', NULL, '2019-05-02', '2019-05-23', '2019-05-23 20:20:19', 4, 1, '2019-05-02 20:05:12', '2019-05-24 13:21:23', 228, 3, 0, NULL, 285),
(318, 1, '577/2019', '00008290220108240126', 1, 'ManifestaÃ§Ã£o de Interesse.', 'Reiterado em 15/07/2019', '2019-05-02', '2019-07-22', '2019-07-18 20:53:12', 4, 4, '2019-05-02 20:57:46', '2019-07-19 20:12:41', 100, 3, 0, NULL, 286),
(319, 1, '150/2019', '04972.004898/2017-13', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-02', '2019-05-10', '2019-05-09 17:22:21', 4, 4, '2019-05-02 21:12:06', '2019-05-09 17:22:24', 121, 3, 0, NULL, 287),
(320, 2, 's/n', '04972.003139/2019-97', 1, 'Trata-se de embargos Ã¡ execuÃ§Ã£o fiscal em que a embargante visa\r\ndesconstituir as certidÃµes de dÃ­vida ativa 9061400161002, 9061101856050, 9061600066666,\r\nreferentes a taxa de ocupaÃ§Ã£o do RIP 8041.0000434-60 no perÃ­odo de 1988 a 2013 e a\r\ncertidÃ£o de dÃ­vida ativa 9061600066747 referente a taxa de ocupaÃ§Ã£o do RIP 8245.0000178-\r\n05 no perÃ­odo de 2009 a 2013.', NULL, '2019-05-03', '2019-06-03', '2019-05-28 15:03:24', 3, 1, '2019-05-03 12:50:35', '2019-05-28 15:03:25', 263, 3, 0, NULL, 288),
(321, 1, '2/2019', '04972.003142/2019-19', 1, 'consultar forÃ§a executÃ³ria.', 'A AGU foi consultada sobre o trÃ¢nsito em julgado e sobre o parecer de forÃ§a executÃ³ria.', '2019-05-03', NULL, '2019-07-29 20:34:09', 4, 4, '2019-05-03 14:18:18', '2019-07-29 20:34:10', 264, 3, 1, NULL, 289),
(322, 1, '658/2018', '04972.006287/2018-82', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-05-03', NULL, '2019-05-03 17:11:19', 4, 4, '2019-05-03 17:10:08', '2019-05-03 17:11:20', 121, 3, 0, NULL, 290),
(323, 1, '293/2018', '04972.006287/2018-82', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-05-03', NULL, '2019-05-03 17:13:29', 4, 4, '2019-05-03 17:13:02', '2019-05-03 17:13:30', 121, 3, 0, NULL, 290),
(324, 1, '256/2019', '04972.006287/2018-82', 1, 'envie o arquivo digital no formato .dwg\" com a linha preamar que passa sobre o imÃ³vel em questÃ£o, que esta informaÃ§Ã£o/arquivo seja enviado para o e-mail: \"topograforicardo@gmail.com\" e que seja enviada junto a informaÃ§Ã£o do DATUM no qual a linha se encontra (se o DATUM SAD69 ou o DATUM SIRGAS2000), bem como a informaÃ§Ã£o se esta mesma linha preamar jÃ¡ se encontra Homologada e qual a sua data de HomologaÃ§Ã£o.', NULL, '2019-05-03', NULL, '2019-05-06 17:44:38', 4, 4, '2019-05-03 17:15:57', '2019-06-25 21:24:49', 121, 3, 0, NULL, 290),
(325, 1, '245/2019', '04972.003145/2019-44', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-03', '2019-05-30', '2019-05-27 11:39:17', 4, 4, '2019-05-03 18:04:46', '2019-06-07 21:17:19', 228, 3, 0, NULL, 291),
(326, 1, '253/2019', '04972.003150/2019-57', 1, 'informe em nome de quem estÃ£o registrados os imÃ³veis em referÃªncia nesse Ã³rgÃ£o e qual a conduta prevista na lei no caso de transferÃªncia entre particulares, manifestando eventual interesse em integrar a lide.', NULL, '2019-05-03', '2019-05-17', '2019-06-28 20:08:44', 4, 4, '2019-05-03 18:21:10', '2019-07-01 20:34:11', 228, 3, 0, NULL, 292),
(327, 1, '453/2019', '04972.002126/2017-39', 1, 'prestem informaÃ§Ãµes acerca da regularidade das ocupaÃ§Ãµes apontadas nos autos, eventuais providÃªncias adotadas (enviando cÃ³pias dos procedimentos pertinentes), e, acaso nÃ£o tenha havido autuaÃ§Ã£o, sugerindo realizaÃ§Ã£o de fiscalizaÃ§Ã£o das irregularidades aventadas em sede de InquÃ©rito Civil levada efeito pelo MPF ter-se-ia constatado suposta implantaÃ§Ã£o irregular de loteamento no municÃ­pio de Jaguaruna/SC', NULL, '2019-05-03', '2019-05-03', NULL, 4, NULL, '2019-05-03 18:47:55', '2019-05-03 18:47:55', 265, 2, 0, NULL, 293),
(328, 1, '641/2019', '04972.003140/2019-11', 1, 'informar sobre a adoÃ§Ã£o das medidas cabÃ­veis, principalmente no que diz Ã  notÃ­cia de venda da ilha pela Proconsult Projeto Consultoria e ConstruÃ§Ã£o Ltda.  Ilha dos Herdeiros, com RIP 83190000094-60, R!P 83190000181-08, RIP83190000186-12 e RIP 83190000505-08.', 'Respondido atravÃ©s do Despacho DIIUP-SPU-SC 8832060', '2019-05-06', '2019-07-02', '2019-08-19 20:48:55', 8, 1, '2019-05-06 11:54:24', '2019-08-19 20:48:56', 85, 3, 0, NULL, 294),
(329, 1, '321/2019', '04972.000758/2019-20', 1, 'esclarecimentos sobre:\n1. a notÃ­cia de contaminaÃ§Ã£o do AquÃ­fero do Campeche;\n2. a contaminaÃ§Ã£o dos cursos d\"Ã¡gua que desaguam no\nmar e a regularidade das obras de macrodrenagem na regiÃ£o\nda Rua dos Eucaliptos/Lagoa da Chica, com desÃ¡gue no mar.', NULL, '2019-05-06', NULL, '2019-05-06 14:05:22', 4, 4, '2019-05-06 14:05:04', '2019-05-06 14:05:23', 90, 3, 0, NULL, 295),
(330, 1, '197/2019', '04972.003169/2019-01', 1, 'Informa para ciÃªncia e acompanhamento ajuizamento da AÃ§Ã£o de RetificaÃ§Ã£o de Registro ImobiliÃ¡rio n. 0300068-51.2019.8.24.0167, por Beatriz Albano de Abreu, para retificaÃ§Ã£o da Ã¡rea constante da matrÃ­cula n. 4.072 do Registro de ImÃ³veis da Comarca de Garopaba/SC, para que conste a Ã¡rea de 3.450 mÂ²m em razÃ£o do erro material na sentenÃ§a proferida nos autos n. 0000025-57.2000.8.24.0167.', NULL, '2019-05-06', NULL, '2019-05-10 12:16:57', 4, 4, '2019-05-06 14:21:03', '2019-05-15 14:11:39', 65, 3, 0, NULL, 296),
(331, 1, '686/2019', '04972.003536/2017-05', 1, 'adotadas as medidas necessÃ¡rias para cumprir a r. decisÃ£o do Evento 154 (Intimem-se os reÃºs para se manifestarem, no prazo de 15 (quinze) dias, acerca das informaÃ§Ãµes lanÃ§adas na petiÃ§Ã£o do Evento 152, sobretudo quanto a veracidade e comprovando as devidas providÃªncias) que faria menÃ§Ã£o a ocupaÃ§Ã£o irregular noticiada (cÃ³pia anexa) por particular de parte da Ã¡rea objeto do presente feito.', NULL, '2019-05-06', '2019-05-17', '2019-06-10 21:41:10', 4, 3, '2019-05-06 17:37:41', '2019-06-10 22:26:57', 114, 3, 1, NULL, 297),
(332, 1, '1041/2018', '00013710820128240075', 1, 'informar interferÃªncia do imÃ³vel com Ã¡rea da UniÃ£o. Pedras Grandes/SC', NULL, '2019-05-07', '2019-05-07', '2019-05-08 12:35:55', 8, 8, '2019-05-07 12:38:08', '2019-05-08 12:35:58', 103, 3, 0, NULL, 298),
(333, 1, '91/2019', '04972.003163/2009-54', 1, 'Informar se houve registro do imÃ³vel em nome da UniÃ£o no cartÃ³rio de registro de imÃ³veis.', 'null', '2019-05-07', NULL, NULL, 4, 1, '2019-05-07 13:09:09', '2019-07-23 16:39:10', 224, 2, 0, NULL, 299),
(334, 1, '1646/2017', '04972.000307/2017-21', 1, 'informar acerca de quais medidas/providÃªncias/intervenÃ§Ãµes/medidas fiscalizatÃ³rias foram adotadas ou programadas pela SPU no caso concreto, no Ã¢mbito de seu poder de polÃ­cia, apÃ³s a expediÃ§Ã£o do OfÃ­cio nÂ° 15169/2017-MP ao MinistÃ©rio PÃºblico Federal', NULL, '2019-05-07', '2017-10-27', '2019-05-08 14:00:46', 1, 1, '2019-05-07 13:10:22', '2019-05-08 14:00:48', 82, 3, 0, NULL, 300),
(335, 1, '90/2019', '04972.009358/2018-07', 1, 'Informar se houve registro do imÃ³vel no cartÃ³rio em nome da UniÃ£o.', NULL, '2019-05-07', NULL, NULL, 4, NULL, '2019-05-07 13:32:52', '2019-05-07 13:32:52', 234, 2, 0, NULL, 301),
(336, 1, '852/2018', '04972.201364/2015-63', 1, 'informar quanto a data em que esta SPU-SC tomou ciÃªncia das irregularidades relatadas e quanto Ã  quais medidas fiscalizatÃ³rias foram adotadas', NULL, '2019-05-07', '2018-07-02', '2019-05-14 13:00:30', 1, 1, '2019-05-07 14:15:49', '2019-05-14 13:00:31', 82, 3, 0, NULL, 302),
(337, 1, '253/2019', '04972.002156/2016-64', 1, 'prestar informaÃ§Ãµes sobre ciÃªncia das regularidades apontadas (Bairro Guanabara, Joinville, entre as ruas Nacar e dos Cravos), quais medidas foram adotadas, existÃªncia de algum laudo, parecer, etc e se os imÃ³veis situados na Ã¡rea estÃ£o cadastrados na SPU', NULL, '2019-05-07', '2019-03-22', '2019-06-05 16:29:54', 1, 1, '2019-05-07 16:18:55', '2019-06-05 16:29:57', 82, 3, 0, NULL, 303),
(338, 1, '267/2019', '04972.005842/2016-97', 1, 'informar sobre a data da ciÃªncia das ocupaÃ§Ãµes e quais medidas, inclusive de fiscalizaÃ§Ã£o, foram tomadas atÃ© o momento', NULL, '2019-05-07', '2019-03-25', '2019-05-30 13:29:37', 1, 1, '2019-05-07 16:27:40', '2019-06-03 23:39:02', 82, 3, 0, NULL, 304),
(339, 2, 's/n', '04972.003192/2019-98', 1, 'o envio da cÃ³pia do aviso de recebimento com o fim de instruir recurso contra sentenÃ§a que decretou a\r\nnulidade do lanÃ§amento pela suposta falta de notificaÃ§Ã£o, nos autos do processo acima referenciado.\r\nProcessos administrativos de nÂº 04972.600373/2016-14 e 04972.603827/2016-17.', NULL, '2019-05-07', '2019-05-16', '2019-05-15 19:09:25', 3, 3, '2019-05-07 17:04:02', '2019-05-15 19:09:26', 266, 3, 0, NULL, 307),
(340, 1, '368/2019', '04972.005802/2016-45', 1, 'informar sobre quais os limites exatos da Ã¡rea de dominialidade da UniÃ£o e/ou de interferÃªncia com bens de seu domÃ­nio do local descrito nos anteditos ofÃ­cios (ver 2Âº e 3Âº documentos do NUP 04972.005802/2016-45)', 'O que Ã©: informar sobre quais os limites exatos da Ã¡rea de dominialidade da UniÃ£o e/ou de interferÃªncia com bens de seu domÃ­nio do local descrito nos anteditos ofÃ­cios (ver 2Âº e 3Âº documentos do NUP 04972.005802/2016-45)', '2019-05-07', '2019-05-08', NULL, 1, 1, '2019-05-07 17:04:39', '2019-08-08 20:44:01', 82, 2, 0, NULL, 305),
(341, 1, '855/2017', '04972.005318/2012-92', 1, 'informar sobre as providÃªncias adotadas apÃ³s a fiscalizaÃ§Ã£o realizada (Auto de InfraÃ§Ã£o nÂº 103/COIF/SPU/SC/2013)', 'O que Ã©: Pontal da Figueira, ItapoÃ¡ - Solicita informaÃ§Ãµes acerca de quais medidas providÃªncias/intervenÃ§Ãµes/medidas foram adotadas pela SPU, apÃ³s a lavratura do antedito RelatÃ³rio de Vistoria e auto de infraÃ§Ã£o nÂ° 103/COIF/SPU/SC/2013 (anexos), no caso concreto, visando a reparaÃ§Ã£o do dano ocorrido em Ã¡rea de dominialidade da UniÃ£o.\r\n\r\nO que foi feito:\r\nnÃ£o constam outros procedimentos realizados\r\n\r\nO que falta:\r\nverificar com a equipe de fiscalizaÃ§Ã£o quanto a quais providÃªncias deverÃ£o ser adotadas\r\nÃšltimo OfÃ­cio do MPF: 25/05/2017 \r\n\r\n12/07/2019 - Aguardando manifestaÃ§Ã£o sobre providÃªncias adotadas apÃ³s a fiscalizaÃ§Ã£o realizada (Auto de InfraÃ§Ã£o nÂº 103/COIF/SPU/SC/2013)', '2017-05-18', NULL, NULL, 1, 1, '2019-05-07 17:19:48', '2019-08-08 20:40:26', 82, 2, 0, NULL, 312),
(342, 1, '2/2019', '04972.005203/2018-93', 1, 'solicita que, com a finalizaÃ§Ã£o dos respectivos recursos administrativos, nos termos da fundamentaÃ§Ã£o do julgado, seja informada a Procuradoria de Joinville para eventual levantamento da suspensÃ£o.', NULL, '2019-05-07', NULL, NULL, 4, NULL, '2019-05-07 17:32:44', '2019-05-07 17:32:44', 267, 2, 0, NULL, 313),
(343, 1, '261/2019', '04972.003233/2019-46', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-07', '2019-06-27', '2019-06-24 23:03:23', 4, 4, '2019-05-07 17:49:42', '2019-06-26 16:21:28', 228, 3, 0, NULL, 314),
(344, 1, '700/2019', '00099919720148240023', 1, 'ManifestaÃ§Ã£o de interesse.', NULL, '2019-05-07', '2019-05-21', '2019-05-27 11:51:18', 4, 3, '2019-05-07 18:00:39', '2019-05-28 13:19:30', 126, 3, 0, NULL, 315),
(345, 1, '699/2019', '04972.005966/2018-34', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-07', '2019-05-21', '2019-05-23 20:24:01', 4, 1, '2019-05-07 18:48:33', '2019-05-24 13:22:45', 126, 3, 0, NULL, 316),
(347, 1, '596/2019', '04972.200075/2015-47', 1, 'MAPAS OFICIAIS da demarcaÃ§Ã£o para o entÃ£o distrito do MunicÃ­pio de IÃ§ara (atual MunicÃ­pio de BalneÃ¡rio RincÃ£o) para CONFRONTO, ou seja, o mapa anterior para o qual serviu de revisÃ£o para o ano 2000', NULL, '2019-05-07', '2019-05-15', '2019-05-24 13:30:41', 4, 3, '2019-05-07 19:59:45', '2019-05-24 13:35:56', 100, 3, 0, NULL, 317),
(348, 1, '691/2019', '03025240820158240007', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-07', '2019-05-31', '2019-05-30 12:06:31', 4, 1, '2019-05-07 20:30:15', '2019-07-30 22:37:48', 126, 3, 0, NULL, 318);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `seiMP`, `demanda`, `resumoSituacao`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(349, 1, '173/2019', '04972.001092/2019-27', 1, 'informar a regularidade do imÃ³vel localizado entre as ruas Antenor Borges e a esquina Vasco de Oliveira Gondin, em Canasvieiras, FlorianÃ³polois/SC', NULL, '2019-05-08', '2019-03-29', '2019-05-28 14:55:22', 8, 1, '2019-05-08 12:06:00', '2019-07-30 22:58:19', 248, 3, 0, NULL, 319),
(350, 1, '172/2017', '04972.000805/2017-73', 1, 'fiscalizaÃ§Ã£o em Ã¡rea localizado na Rua Camilo de Oliveira, em BalneÃ¡rio Barra do Sul/SC.', NULL, '2019-05-08', '2019-05-09', '2019-05-08 14:05:56', 8, 8, '2019-05-08 12:20:26', '2019-05-08 14:05:58', 85, 3, 0, NULL, 320),
(351, 1, '0105/2019', '04972.003723/2018-61', 1, 'Informar se as Ã¡reas atualmente ocupadas pela Locadora de DVD\'s e Ketty Lanches (PraÃ§a Vereador Halley Capanema), pelo Ney Lanches \n(Avenida Governador Celso Ramos) e pela ME Bar e Lanchonete (PraÃ§a Cel. Serafim da Silva Matos) se encontram em terrenos de marinha.', NULL, '2019-05-08', '2019-03-29', '2019-05-09 12:26:04', 8, 4, '2019-05-08 12:42:01', '2019-05-28 20:00:17', 268, 3, 0, NULL, 321),
(352, 1, '0120/2019', '04972.001328/2019-25', 1, 'informar se a Ã¡rea indicada Ã© de interesse da UniÃ£o. Ãrea localizada em Joinville/SC', NULL, '2019-05-08', '2019-03-15', '2019-05-09 12:45:04', 8, 4, '2019-05-08 17:08:29', '2019-05-15 14:04:19', 269, 3, 0, NULL, 323),
(353, 1, '258/2019', '04972.003265/2019-41', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-08', '2019-05-17', '2019-05-27 11:35:21', 4, 3, '2019-05-08 17:30:24', '2019-05-30 13:24:31', 121, 3, 0, NULL, 324),
(354, 1, '229/2019', '04972.206116/2015-17', 1, 'Atesta-se a forÃ§a executÃ³ria do acÃ³rdÃ£o de apelaÃ§Ã£o que julgou improcedentes os pedidos autorais, nÃ£o havendo Ã³bice no bojo do referido processo judicial para a cobranÃ§a das receitas patrimoniais afetas aos imÃ³veis objetos da lide.', NULL, '2019-05-08', NULL, '2019-05-08 17:57:06', 4, 4, '2019-05-08 17:56:16', '2019-05-08 17:57:09', 99, 3, 0, NULL, 325),
(355, 1, '710/2019', '04972.006867/2018-70', 1, 'manifestaÃ§Ã£o conclusiva acerca da petiÃ§Ã£o do impetrante do evento 12.', NULL, '2019-05-08', '2019-05-14', '2019-05-21 17:35:04', 4, 4, '2019-05-08 18:48:59', '2019-05-21 17:35:05', 126, 3, 0, NULL, 326),
(356, 1, '71/2019', '04972.001230/2019-78', 1, 'confirmaÃ§Ã£o de interferÃªncia da Ã¡rea com bens da UniÃ£o. ImÃ³vel localizado na Rua JosÃ© Medeiros Vieira, 1538, Praia Brava, ItajaÃ­/SC.', NULL, '2019-05-09', '2019-03-08', '2019-05-09 18:04:35', 8, 4, '2019-05-09 12:51:31', '2019-05-14 18:05:54', 74, 3, 0, NULL, 327),
(357, 4, '1981/2019', '04972.003269/2019-20', 1, 'informaÃ§Ãµes acerca da regulamentaÃ§Ã£o e fiscalizaÃ§Ã£o do uso desse bem da UniÃ£o, levando em consideraÃ§Ã£o as tratativas do Projeto Orla e o gerenciamento costeiro, em FlorianÃ³polis - Barra da Lagoa da ConceiÃ§Ã£o.', NULL, '2019-05-09', '2019-05-20', '2019-05-30 17:01:11', 8, 3, '2019-05-09 13:13:38', '2019-05-30 17:01:13', 86, 3, 0, NULL, 328),
(360, 1, '265/2019', '04972.003271/2019-07', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-09', '2019-05-29', '2019-05-28 18:59:11', 4, 4, '2019-05-09 13:42:39', '2019-06-05 20:02:39', 228, 3, 0, NULL, 329),
(361, 1, '264/2019', '04972.003273/2019-98', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-09', '2019-05-14', '2019-05-21 18:43:26', 4, 1, '2019-05-09 16:55:09', '2019-05-21 19:15:57', 121, 3, 0, NULL, 330),
(362, 1, '268/2019', '04972.003287/2019-10', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-05-09', NULL, '2019-05-28 16:34:46', 4, 3, '2019-05-09 20:03:00', '2019-07-02 21:14:20', 121, 3, 0, NULL, 331),
(363, 1, '489/2019', '04972.004280/2016-64', 1, 'informar acerca da regularidade da ocupaÃ§Ã£o da Ilha dos Barcos perante a SPU', NULL, '2019-05-10', '2019-05-09', '2019-05-13 14:03:23', 1, 1, '2019-05-10 17:49:37', '2019-05-13 14:03:24', 85, 3, 0, NULL, 21),
(364, 9, '5013737-37.2018.4.04.7200', '04972.008389/2018-32', 1, 'DETERMINO Ã  autoridade impetrada queconclua a anÃ¡lise  do pedidos  de  averbaÃ§Ã£o de transferÃªncia  n. 04972.004186/2009-86,protocolizado   em   16/10/2009,   e   dos   pedidos   de   outorga   gratuita   de   aforamentons.   04972.007791/2013-95   e   04972.207127/2015-14,   protocolizados,   respectivamente,em 21/08/2013 e 29/12/2015, no prazo mÃ¡ximo de 180 dias, a contar da intimaÃ§Ã£o destasentenÃ§a, devendo envidar todos os esforÃ§os para que essa conclusÃ£o ocorra no menor tempopossÃ­vel, cobrando da AGU, de forma devidamente comprovada, a breve manifestaÃ§Ã£o acercada questÃ£o abstrata pendente', '22/07/2019\r\nO que Ã©: sentenÃ§a determina a conclusÃ£o da anÃ¡lise dos pedidos de outorga gratuita de aforamentos (SPU-SC-NUDEP).\r\nO que foi feito: Solicitamos parecer conclusivo da CJU-SC sobre questÃ£o constitucional sobre aforamento. Parecer jÃ¡ foi fornecido.\r\nO que falta fazer: conclusÃ£o do pedido administrativo de aforamento.', '2019-05-10', '2019-11-03', NULL, 1, 1, '2019-05-10 19:04:31', '2019-07-22 20:16:06', 261, 2, 1, NULL, 332),
(365, 9, '5010405-28.2019.4.04.7200', '04972.003350/2019-18', 1, 'O MS foi impetrado por Altamiro RogÃ©rio Philippi e demais filhos do senhor Arlindo Francisco Philippi, jÃ¡ falecido, foreiro do imÃ³vel de RIP nÂº 0983.009682/82-47, situado na Rua Francisco Tolentino, 657, em FlorianÃ³polis/SC.\r\n\r\nEm resumo, contestam a decisÃ£o administrativa proferida na Nota TÃ©cnica nÂº 27122/2018-MP (7454936), acolhida no Despacho SEREP-SPU-SC nÂº 8555990, integrantes  do processo nÂº 0983.009862/82-47 (a este relacionado), que indeferiu pedido de cancelamento de dÃ©bitos de laudÃªmio por prescriÃ§Ã£o.', NULL, '2019-05-13', '2019-05-23', '2019-05-29 13:38:05', 1, 3, '2019-05-13 20:34:46', '2019-05-29 13:38:08', 161, 3, 1, NULL, 333),
(366, 1, '1052/2017', '04972.004413/2017-83', 1, 'informar interferÃªncia com Ã¡rea da UniÃ£o o imÃ³vel estÃ¡ situado em local prÃ³ximo Ã  rodovia municipal PGR-104, no municÃ­pio de Praia Grande/SC.', NULL, '2019-05-14', '2017-09-26', '2019-05-14 12:01:52', 8, 8, '2019-05-14 12:01:39', '2019-05-14 12:01:53', 56, 3, 0, NULL, 334),
(367, 9, '01/2019', '04972.001960/2019-79', 1, 'a penhora DO DOMÃNIO ÃšTIL ou direito real de uso que a executada, Imbituba Empreendimentos e ParticipaÃ§Ãµes S/A, CNPJ 27.276.211/0001-08, detÃ©m sobre o imÃ³vel matriculado sob o n.Â° 14.808', NULL, '2019-05-14', '2019-05-10', '2019-05-20 11:58:19', 8, 8, '2019-05-14 12:58:22', '2019-05-20 11:58:21', 270, 3, 0, NULL, 336),
(368, 1, '266/2019', '04972.003388/2019-82', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-14', '2019-05-28', '2019-06-11 15:37:57', 4, 3, '2019-05-14 17:04:04', '2019-06-11 15:37:57', 121, 7, 0, NULL, 337),
(369, 1, '94/2019', '04972.202955/2015-58', 1, 'ManifestaÃ§Ã£o sobre nova documentaÃ§Ã£o.', NULL, '2019-05-14', '2019-05-24', '2019-05-27 11:44:36', 4, 4, '2019-05-14 17:15:32', '2019-05-27 13:43:27', 224, 3, 0, NULL, 338),
(370, 1, '719/2019', '04972.207030/2015-01', 1, 'InformaÃ§Ã£o sobre a Ã¡rea compreendida no RIP nÂº 8143.0000141-02', NULL, '2019-05-14', '2019-05-24', '2019-05-28 14:59:06', 4, 4, '2019-05-14 17:31:05', '2019-05-28 19:44:54', 126, 3, 0, NULL, 123),
(371, 1, '718/2019', '04972.003389/2019-27', 1, 'Prestar InformaÃ§Ãµes em Mandado de SeguranÃ§a.', NULL, '2019-05-14', '2019-05-20', '2019-05-15 12:57:22', 4, 3, '2019-05-14 17:55:30', '2019-05-15 12:57:34', 126, 3, 0, NULL, 339),
(372, 1, '719/2019', '04972.003396/2019-29', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-05-14', '2019-05-24', '2019-05-20 13:46:50', 4, 3, '2019-05-14 18:35:35', '2019-05-20 13:46:52', 126, 3, 0, NULL, 341),
(373, 1, '334/2019', '04972.003432/2019-54', 1, 'que seja informada a regularidade do empreendimento \"Spazio Bauhaus\", localizado na Rua Heinrich Hemmer, nÂ° 1900, Bairro Badenfurt, municÃ­pio de Blumenau', NULL, '2019-05-15', '2019-05-29', '2019-05-28 16:40:12', 8, 4, '2019-05-15 12:30:50', '2019-05-28 20:30:40', 76, 3, 0, NULL, 342),
(374, 1, '340/2019', '04972.003433/2019-07', 1, 'informar sobre a regularidade da posse exercida nos lotes 4, 5, 6, 8, 11/12 e 20/21, do Loteamento Jardim das Gaivotas, no MunicÃ­pio de Itapema.', NULL, '2019-05-15', '2019-06-14', '2019-06-13 15:46:27', 8, 8, '2019-05-15 12:44:14', '2019-06-13 15:46:28', 74, 3, 0, NULL, 343),
(375, 1, '696/2019', '04972.003230/2019-11', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-15', '2019-05-10', '2019-05-15 13:55:06', 4, 1, '2019-05-15 13:54:49', '2019-07-31 15:50:59', 126, 3, 0, NULL, 344),
(376, 1, '5555/2018-GAB-WAM', '04972.001477/2010-56', 1, 'informar sobre situaÃ§Ã£o do processo de regularizaÃ§Ã£o da Ã¡rea (demoliÃ§Ã£o das benfeitorias e aterro irregular/trapiche) em Coqueiros, FlorianÃ³polis/SC. LR Amorim Administradora de Bens LTDA', NULL, '2019-05-15', '2019-01-02', '2019-05-21 13:35:40', 1, 1, '2019-05-15 18:54:23', '2019-05-21 13:35:41', 95, 3, 0, NULL, 345),
(377, 1, '150/2019', '04972.003439/2019-76', 1, 'Seja verificado se hÃ¡ intervenÃ§Ã£o em imÃ³veis da UniÃ£o, especialmente, em terreno de marinha, solicitando que caso a SPU verifique alguma ocorrÃªncia de fraude ou interesse da UniÃ£o em determinada aÃ§Ã£o de usucapiÃ£o, em trÃ¢mite no MunicÃ­pio de Barra Velha, a Procuradoria Seccional da UniÃ£o em Joinville seja comunicada para as providÃªncias cabÃ­veis', NULL, '2019-05-15', NULL, '2019-08-06 15:58:05', 4, 8, '2019-05-15 19:30:50', '2019-08-06 15:58:05', 103, 7, 0, NULL, 346),
(378, 1, '292/2019', '04972.005743/2018-77', 1, 'indicaÃ§Ã£o de assistente tÃ©cnico e apresentaÃ§Ã£o de\r\nquesitos, no prazo de 10 dias.', NULL, '2019-05-16', '2019-05-25', '2019-05-28 16:29:21', 3, 4, '2019-05-16 12:53:20', '2019-06-05 19:57:11', 228, 3, 0, NULL, 347),
(379, 1, '0193/2019', '04972.007420/2014-94', 1, 'registro da  isenÃ§Ã£o do pagamento da taxa de ocupaÃ§Ã£o do imÃ³vel cadastrado sob o RIP nÂº 8265.0000123-01, exclusivamente para as competÃªncias 2007 a 2013', NULL, '2019-05-16', '2019-05-23', '2019-05-16 16:42:41', 8, 8, '2019-05-16 13:03:09', '2019-05-16 16:42:43', 243, 3, 1, NULL, 348),
(380, 1, '720004585493', '04972.003464/2019-50', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC.', NULL, '2019-05-16', NULL, '2019-05-17 17:33:37', 8, 8, '2019-05-16 18:25:25', '2019-05-17 17:33:38', 240, 3, 1, NULL, 351),
(381, 1, '720004596359', '04972.003461/2019-16', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-16', NULL, '2019-05-17 17:19:46', 8, 8, '2019-05-16 18:27:41', '2019-05-17 17:19:47', 240, 3, 1, NULL, 352),
(382, 1, '72000458550', '04972.003462/2019-61', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/S', NULL, '2019-05-16', NULL, '2019-05-17 17:20:13', 8, 8, '2019-05-16 18:30:07', '2019-05-17 17:20:14', 240, 3, 1, NULL, 353),
(383, 1, '72000458545', '04972.003463/2019-13', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-16', NULL, '2019-05-17 17:20:35', 8, 8, '2019-05-16 18:33:16', '2019-05-17 17:20:36', 240, 3, 1, NULL, 355),
(384, 1, '720004583502', '04972.003460/2019-71', 1, 'Ã  prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/S', NULL, '2019-05-16', NULL, '2019-05-17 12:20:51', 8, 8, '2019-05-16 18:36:00', '2019-05-17 12:20:56', 240, 3, 1, NULL, 356),
(385, 1, '720004589712', '04972.003466/2019-49', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-16', NULL, '2019-05-16 19:27:59', 8, 8, '2019-05-16 18:39:10', '2019-05-16 19:28:00', 240, 3, 1, NULL, 357),
(386, 1, '720004584845', '04972.003465/2019-02', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, '2019-05-16', NULL, '2019-05-17 18:03:08', 8, 8, '2019-05-16 18:41:04', '2019-05-17 18:03:09', 240, 3, 1, NULL, 358),
(387, 1, '2873/2018', '04972.006553/2018-77', 1, 'informar sobre:\r\n\r\n    a delimitaÃ§Ã£o da LPM/1831 para toda a localidade do Morro e da Praia do Matadeiro, isto Ã©, na fraÃ§Ã£o de terras existente entre a ponte localizada ao final da Rua Fernando Beck (coordenadas N=6927571 E=745992 â€” Google Earth), e a Ponta do Quebra Remo, (coordenadas N=6927351 E=747562 â€” Google Earth);\r\n     \r\n    a identificaÃ§Ã£o de cada uma das edificaÃ§Ãµes que ocupam terreno de marinha;\r\n\r\n    as providÃªncias tÃ©cnicas de retirada do molhe que une a margem esquerda da foz do Rio Quincas AntÃ´nio Ã  Ponta das Campanhas, a fim de possibilitar o restabelecimento do fluxo de\r\n    sedimentos entre a Praia da ArmaÃ§Ã£oo do PÃ¢ntano do Sul e a Praia do Matadeiro; e\r\n\r\n    a demoliÃ§Ã£o das construÃ§Ãµes que ocupam ilegalmente bens da UNIÃƒO no local.', NULL, '2019-05-16', '2018-07-25', '2019-06-17 23:12:08', 1, 8, '2019-05-16 20:32:20', '2019-06-17 23:12:09', 90, 3, 0, NULL, 359),
(388, 1, '97/2019', '04972.000611/2017-78', 1, 'ManifestaÃ§Ã£o sobre laudo pericial', NULL, '2019-05-17', '2019-05-30', '2019-05-29 13:38:29', 4, 3, '2019-05-17 13:39:03', '2019-05-30 13:10:20', 224, 3, 0, NULL, 360),
(389, 1, '290/2019', '04972.010806/2018-15', 1, 'anÃ¡lise e manifestaÃ§Ã£o quanto possibilidade de perdÃ£o da dÃ­vida', NULL, '2019-05-17', '2019-05-24', '2019-06-14 20:31:45', 4, 3, '2019-05-17 14:10:07', '2019-06-14 20:31:47', 106, 3, 0, NULL, 130),
(390, 1, '749/2019', '04972.200914/2015-27', 1, 'Indique assistente tÃ©cnico e formule quesitos para a defesa da UniÃ£o', NULL, '2019-05-17', '2019-05-24', '2019-05-27 11:33:36', 4, 3, '2019-05-17 14:30:04', '2019-05-28 14:36:32', 126, 3, 0, NULL, 361),
(391, 1, '289/2019', '04972.003500/2019-85', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o', NULL, '2019-05-17', '2019-06-05', '2019-06-26 19:56:20', 4, 4, '2019-05-17 17:21:34', '2019-06-26 22:27:05', 228, 3, 0, NULL, 362),
(392, 1, '98/2019', '03002583120158240045', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e formulaÃ§Ã£o de quesitos', NULL, '2019-05-17', '2019-05-31', '2019-05-30 12:14:20', 4, 8, '2019-05-17 17:38:31', '2019-05-30 12:14:20', 234, 7, 0, NULL, 31),
(393, 1, '756/2019', '04972.003502/2019-74', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-17', '2019-05-21', '2019-07-16 20:44:42', 4, 4, '2019-05-17 18:15:27', '2019-07-16 20:44:44', 126, 3, 0, NULL, 364),
(394, 1, '720004589812', '04972.003467/2019-93', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-17', NULL, '2019-05-17 18:46:25', 8, 8, '2019-05-17 18:43:46', '2019-05-17 18:46:26', 240, 3, 1, NULL, 365),
(395, 1, '763/2019', '04972.005401/2016-95', 1, 'ManifestaÃ§Ã£o sobre laudo Pericial', NULL, '2019-05-17', '2019-05-30', '2019-05-30 13:27:42', 4, 3, '2019-05-17 19:10:34', '2019-05-30 13:27:45', 126, 3, 0, NULL, 29),
(396, 1, '720004589845', '04972.003475/2019-30', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, '2019-05-20', NULL, '2019-05-20 16:37:09', 8, 8, '2019-05-20 12:17:26', '2019-05-20 16:37:10', 240, 3, 1, NULL, 366),
(397, 1, '720004589783', '04972.003476/2019-84', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, '2019-05-20', NULL, '2019-05-20 16:45:26', 8, 8, '2019-05-20 12:21:12', '2019-05-20 16:45:27', 240, 3, 1, NULL, 367),
(398, 1, '720004588388', '04972.003477/2019-29', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-20', NULL, '2019-05-20 19:06:44', 8, 8, '2019-05-20 12:23:13', '2019-05-20 19:06:45', 240, 3, 1, NULL, 368),
(399, 1, '720004589764', '04972.003478/2019-73', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-20', NULL, '2019-05-22 11:39:36', 8, 8, '2019-05-20 12:54:50', '2019-05-22 11:39:37', 240, 3, 1, NULL, 369),
(400, 1, '720004585474', '04972.003479/2019-18', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-20', NULL, '2019-05-22 11:39:04', 8, 8, '2019-05-20 12:57:06', '2019-05-22 11:39:05', 240, 3, 1, NULL, 370),
(401, 1, '720004584770', '04972.003480/2019-42', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-20', NULL, '2019-05-21 18:26:08', 8, 8, '2019-05-20 12:59:43', '2019-05-21 18:26:09', 240, 3, 1, NULL, 371),
(402, 1, '720004584754', '04972.003481/2019-97', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-20', NULL, '2019-05-21 11:21:37', 8, 8, '2019-05-20 13:10:51', '2019-05-21 11:21:38', 240, 3, 1, NULL, 372),
(403, 1, '720004584673', '04972.003482/2019-31', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-20', NULL, '2019-05-21 11:20:45', 8, 8, '2019-05-20 13:12:42', '2019-05-21 11:20:46', 240, 3, 1, NULL, 374),
(404, 1, '72000458406', '04972.003483/2019-86', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, '2019-05-20', NULL, '2019-05-21 11:19:47', 8, 8, '2019-05-20 13:14:48', '2019-05-21 11:19:48', 240, 3, 1, NULL, 375),
(405, 1, '720004584808', '04972.003484/2019-21', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, '2019-05-20', NULL, '2019-05-20 17:25:46', 8, 8, '2019-05-20 13:16:23', '2019-05-20 17:25:47', 240, 3, 1, NULL, 376),
(406, 1, '761/2019', '04972.003534/2019-70', 1, 'IncluÃ­do no PAF 2019 constante do processo 04972.001058/2019-52', NULL, '2019-05-20', '2019-05-31', '2019-07-31 20:04:59', 4, 4, '2019-05-20 14:14:37', '2019-07-31 20:04:59', 126, 5, 0, NULL, 377),
(407, 1, '760/2019', '04972.007460/2017-89', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-20', '2019-05-30', '2019-05-28 16:47:40', 4, 3, '2019-05-20 16:39:03', '2019-05-30 13:29:05', 126, 3, 0, NULL, 378),
(408, 1, '663/2019', '04972.205274/2015-41', 1, 'ManifestaÃ§Ã£o sobre laudo complementar', NULL, '2019-05-20', '2019-06-05', '2019-05-29 18:26:47', 4, 1, '2019-05-20 16:50:23', '2019-05-29 18:42:56', 100, 3, 0, NULL, 53),
(409, 1, '665/2019', '04972.006238/2018-40', 1, 'Informa sobre a concessÃ£o da dilaÃ§Ã£o do prazo, em 30 (trinta) dias, para o cumprimento da obrigaÃ§Ã£o de fazer', 'O que Ã©:\r\nNecessidade de demoliÃ§Ã£o de um trapiche de pequeno porte. O Juiz jÃ¡ indeferiu os orÃ§amentos apresentados pelo MunicÃ­pio e determinou que fosse realizado pelos autores (UniÃ£o e MunicÃ­pio de Bombinhas).\r\n\r\nO que foi feito:\r\n- diversos contatos com Capitania dos Portos, com os quais conseguimos disponibilizaÃ§Ã£o de embarÃ§Ã£o para apoio na remoÃ§Ã£o\r\n- enviamos OfÃ­cio nÂº 54267/2019/DIGES-SPU-SC/MP Ã  Prefeitura de Bombinhas, solicitando confirmaÃ§Ã£o da demoliÃ§Ã£o\r\n- comunicamos AGU sobre nova tentativa junto Ã  Prefeitura de Bombinhas\r\n\r\nO que falta fazer:\r\n- aguardar resposta da Prefeitura de Bombinhas\r\n- apÃ³s, verificar com Cristina a cobranÃ§a ao Gestor Municipal de Praias.\r\n- apÃ³s, oficiar AGU', '2019-08-09', '2019-06-10', '2019-07-10 21:23:55', 4, 1, '2019-05-20 17:04:49', '2019-08-21 16:09:59', 100, 2, 1, NULL, 206),
(410, 1, '2021/2019', '04972.008373/2017-49', 1, 'informe, no prazo de 15 (quinze) dias Ãºteis, a atual situaÃ§Ã£o do projeto habitacional aos integrantes da \' OcupaÃ§Ã£o Contestado \' .', NULL, '2019-05-20', '2019-05-25', '2019-05-20 17:25:16', 4, 4, '2019-05-20 17:24:49', '2019-05-20 17:25:17', 58, 3, 0, NULL, 110),
(411, 1, '664/2019', '04972.003536/2019-69', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos', NULL, '2019-05-20', '2019-06-07', '2019-06-07 15:03:08', 4, 3, '2019-05-20 18:19:24', '2019-06-11 21:09:21', 100, 3, 0, NULL, 379),
(412, 1, '678/2019', '00556.001083/2015-62', 1, 'informar ao juÃ­zo acerca do andamento do processo administrativo nÂº 04972.004901/2010-14, objeto da aÃ§Ã£o', NULL, '2019-05-20', '2019-06-07', NULL, 4, NULL, '2019-05-20 19:26:50', '2019-05-20 19:26:50', 100, 2, 0, NULL, 380),
(413, 1, '669/2019', '04972.003552/2019-51', 1, 'Encaminha o o PARECER DE FORÃ‡A EXECUTÃ“RIA n.00059/2019/PSUCCO/PGU/AGU, que atesta que Ã¡ a SPU cumprir a decisÃ£o, deixando de exigir eventuais taxas de ocupaÃ§Ã£o, laudÃªmio e/ou multa por atraso na transferÃªncia, enquanto nÃ£o concluÃ­do o regular procedimento administrativo demarcatÃ³rio das terras de marinha e inscritos os referidos imÃ³veis.', NULL, '2019-05-21', NULL, '2019-06-19 15:33:12', 4, 4, '2019-05-21 14:31:05', '2019-06-21 20:39:04', 100, 3, 0, NULL, 381),
(414, 1, '662/2019', '04972.003553/2019-04', 1, 'Encaminha  O PARECER DE FORÃ‡A EXECUTÃ“RIA n.00058/2019/PSUCCO/PGU/AGU, atestando a forÃ§a executÃ³ria plena do acÃ³rdÃ£o proferido pelo TRF da 4Âª RegiÃ£o, podendo\na SPU/SC exigir do autor da aÃ§Ã£o o laudÃªmio e a multa devidos no caso concreto.', NULL, '2019-05-21', NULL, NULL, 4, 4, '2019-05-21 17:02:05', '2019-05-21 17:02:29', 100, 4, 0, NULL, 382),
(415, 1, '300/2019', '04972.001438/2019-97', 1, 'Verificar regularidade e interferÃªncia da Ã¡rea com bem da UniÃ£o, casa e trapiche, localizadas na Rua JosÃ© Dobrotinick, esquina com a Avenida Lindolfo de Freitas Ledoux (coordenadas: 26Â°14\'50.53\"S/48Â°4228.081\"O)', NULL, '2019-05-21', '2019-03-29', '2019-06-18 21:04:43', 8, 4, '2019-05-21 18:20:46', '2019-06-18 21:07:44', 85, 3, 0, NULL, 383),
(416, 1, '287/2019', '04972.003560/2019-06', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-05-21', '2019-06-03', '2019-07-02 23:30:06', 4, 3, '2019-05-21 18:21:15', '2019-07-04 15:00:40', 201, 3, 0, NULL, 384),
(417, 1, '285/2019', '04972.003568/2019-64', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-21', '2019-06-26', '2019-06-17 19:48:54', 4, 4, '2019-05-21 18:47:29', '2019-06-18 22:09:10', 121, 3, 0, NULL, 386),
(418, 1, '95/2019', '04972.205738/2015-10', 1, 'ManifestaÃ§Ã£o sobre proposta de acordo.', NULL, '2019-05-21', '2019-05-30', '2019-06-03 18:50:56', 4, 1, '2019-05-21 20:37:52', '2019-06-03 22:56:23', 224, 3, 0, NULL, 387),
(419, 1, '255/2019', '04972.003265/2016-07', 1, 'informar regularidade do imÃ³vel e a possibilidade atividade de carcinicultura realizada por JosÃ© Vanderlei dos Santos na citada Ã¡rea Ã© passÃ­vel de registro de ocupaÃ§Ã£o.', 'O que Ã©: informar regularidade do imÃ³vel e a possibilidade atividade de carcinicultura realizada por JosÃ© Vanderlei dos Santos na citada Ã¡rea Ã© passÃ­vel de registro de ocupaÃ§Ã£o.<br><br>\r\nO que foi feito: nÃ£o foi encontrado RIP sob responsabilidade de JosÃ© Vanderlei dos Santos, CPF 603.484.709-59. Ã‰ possÃ­vel a regularizaÃ§Ã£o do imÃ³vel perante a SPU, desde que nÃ£o ocorram quaisquer indÃ­cios de danos ambientais na Ã¡rea, obtendo a parte interessada todas as LicenÃ§as Ambientais necessÃ¡rias, bem como, nÃ£o ocorra nenhuma restriÃ§Ã£o do MunicÃ­pio quanto a LegislaÃ§Ã£o de uso e ocupaÃ§Ã£o do solo.<br><br>\r\nO que falta fazer: Vstoria programada para o perÃ­odo de 07 a 11/10/2019', '2019-05-22', '2019-03-25', NULL, 8, 1, '2019-05-22 12:05:41', '2019-07-12 21:28:38', 82, 2, 0, NULL, 388),
(420, 1, '00070/2019', '04972.004030/2016-24', 1, 'participaÃ§Ã£o em audiÃªncia 27/06/2019', NULL, '2019-05-22', '2019-06-27', '2019-05-22 17:01:07', 8, 8, '2019-05-22 16:59:47', '2019-05-22 17:01:08', 224, 3, 0, NULL, 132),
(421, 1, '00142/2019', '04902.000813/2019-13', 0, 'LimitaÃ§Ã£o administrativa - imÃ³vel localizado na Av. Aroeira da Praia, Mariscal, ao lado do n. 1527 - Bombinhas/SC', 'null', '2019-05-22', '2019-05-24', '2019-08-30 17:44:00', 8, 1, '2019-05-22 17:30:56', '2019-08-30 17:44:02', 271, 3, 0, NULL, 392),
(422, 1, '608/2019', '04972.003629/2019-93', 1, 'Encaminha  PARECER DE FORÃ‡A EXECUTÃ“RIA n.00050/2019/PSUCCO/PGU/A G U', NULL, '2019-05-22', NULL, '2019-05-22 17:49:33', 4, 4, '2019-05-22 17:49:14', '2019-05-22 17:49:34', 100, 3, 0, NULL, 393),
(423, 1, '00153/2019', '04972.001860/2019-42', 1, 'informar eventual interesse da UniÃ£o na lide.', NULL, '2019-05-23', '2019-04-01', '2019-06-26 20:49:46', 8, 4, '2019-05-23 18:03:32', '2019-06-26 22:31:59', 228, 3, 0, NULL, 394),
(424, 1, '1/2019', '04972.007847/2013-10', 1, 'Para ciÃªncia e adoÃ§Ã£o de providÃªncias.', NULL, '2019-05-23', NULL, NULL, 4, NULL, '2019-05-23 19:02:34', '2019-05-23 19:02:34', 272, 2, 0, NULL, 395),
(425, 1, '1751/2019', '04972.003663/2019-68', 1, 'informar a existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o em favor do Sr. Wendell Ferreira da Silva, CPF 257.319.408-60.', NULL, '2019-05-24', '2019-06-03', '2019-05-30 17:43:51', 8, 3, '2019-05-24 12:30:58', '2019-05-30 17:43:53', 86, 3, 0, NULL, 397),
(426, 1, '19/2019', '04972.006143/2017-45', 1, 'ManifestaÃ§Ã£o acerca do laudo pericial complementar.', NULL, '2019-05-24', '2019-06-05', '2019-06-11 19:46:07', 4, 3, '2019-05-24 17:58:42', '2019-06-11 20:56:17', 122, 3, 0, NULL, 37),
(427, 1, '750/2019', '04972.004280/2016-64', 1, 'Demandante fornece cÃ³pia do IC 1.33.005.000308/2013-31', NULL, '2019-05-24', NULL, '2019-05-28 13:47:53', 1, 1, '2019-05-24 18:04:10', '2019-05-28 13:47:55', 85, 3, 0, NULL, 400),
(428, 1, '238/2018', '04972.205664/2015-11', 1, 'informaÃ§Ãµes  e  encaminhamento  dedocumentos  a  respeito  da  edificaÃ§Ã£o,  situada  na Av. Dr. Armando Petrelli,  nÂ°  142,  centro,de  Barra  Velha/SC, Coordenadas UTM:  22J  730894  7025159,  matriculado  sob o  nÂ°  1945 noCartÃ³rio  de  Registro  de  ImÃ³veis  da  Comarca de  Barra  Velha,  cujo  proprietÃ¡rio  Ã©  NestorDomingo  Roque FÃ©ssia, inscrito   no  CPF sob  o  nÂ°  948.092.839-68, notadamente  acerca  dequais  providÃªncias/intervenÃ§Ãµes/medidas  fiscalizatÃ³rias  foram  adotadas pela  SPU em  facede   Nestor  Domingo  Roque   FÃ©ssia.   no  Ã¢mbito  de  seu  poder   de  polÃ­cia,  para  evitar  aconstruÃ§Ã£o da aludida edificaÃ§Ã£o  no  local.', NULL, '2019-05-24', '2018-04-09', '2019-05-24 18:14:26', 1, 1, '2019-05-24 18:13:52', '2019-05-24 18:14:28', 82, 3, 0, NULL, 401),
(429, 1, '333/2019', '04972.005807/2016-78', 1, '(i) Quais foram as medidas  adotadas  pela  Secretaria  de  PatrimÃ³nio  daUniÃ£o,  no Ã¢mbito  de seu poder  de polÃ­cia,  a fim  de impedir  as  edificaÃ§Ãµes,em terras  de domÃ­nio da UniÃ£o,  localizadas  nos loteamentos  JosÃ© Loureiro le  II,  no Bairro  Ulysses GuimarÃ£es,  em Joinville; e\r\n(ii.)  quais  foram  as  medidas  adotadas  pela  Secretaria  de  PatrimÃ³nio  daUniÃ£o,   no  Ã¢mbito   de  seu  poder   de  polÃ­cia,   apÃ³s  ter   sido   constatado,inequivocamente,   a  existÃªncia   de  imÃ³veis  interferindo  em  terreno  demarinha   e  acrescidos,  conforme   OfÃ­cio   n.   73949/2016-MP  e  OfÃ­cio   nÂ°66144/2018-MP (anexos).', 'O que Ã©:\r\ni) Quais foram as medidas  adotadas  pela  Secretaria  de  PatrimÃ³nio da UniÃ£o,  no Ã¢mbito  de seu poder  de polÃ­cia,  a fim  de impedir  as  edificaÃ§Ãµes, em terras  de domÃ­nio da UniÃ£o,  localizadas  nos loteamentos  JosÃ© Loureiro le  II,  no Bairro  Ulysses GuimarÃ£es,  em Joinville; e\r\n(ii.)  quais  foram  as  medidas  adotadas  pela  Secretaria  de  PatrimÃ³nio  da UniÃ£o,   no  Ã¢mbito   de  seu  poder   de  polÃ­cia,   apÃ³s  ter   sido   constatado,inequivocamente,   a  existÃªncia   de  imÃ³veis  interferindo  em  terreno  demarinha   e  acrescidos,  conforme   OfÃ­cio   n.   73949/2016-MP  e  OfÃ­cio   nÂ°66144/2018-MP (anexos).\r\n\r\nO que falta:\r\nPrecisamos definir quais diligÃªncias adotar junto aos Ã³rgÃ£os municipais', '2019-05-24', '2019-04-05', NULL, 1, 1, '2019-05-24 19:27:44', '2019-08-08 20:43:25', 82, 2, 0, NULL, 402),
(430, 1, '351/2019', '04972.003689/2019-14', 1, 'informar quais foram as medidas adotadas pela Secretaria de PatrimÃ´nio da UniÃ£o, no Ã¢mbito de seu poder de polÃ­cia, a fim de impedir as edificaÃ§Ãµes, em terras de domÃ­nio da UniÃ£o,  localizadas  no loteamento  JosÃ© Loureiro  II,no Bairro  Ulysses GuimarÃ£es,  em Joinville; e(ii.)  quais  foram  as  medidas   adotadas   pela  Secretaria  de  PatrimÃ´nio  da UniÃ£o,   no  Ã¢mbito  de  seu  poder   de  polÃ­cia,   apÃ³s  ter   sido   constatado,inequivocamente,    a  existÃªncia   de  imÃ³veis   interferindo  em  terreno  de marinha   e  acrescidos,  conforme   OfÃ­cio   n.   73949/2016-MP (2842113 - NUP 04972.006136/2016-62)', 'O que Ã©:\r\ninformar quais foram as medidas adotadas pela Secretaria de PatrimÃ´nio da UniÃ£o, no Ã¢mbito de seu poder de polÃ­cia, a fim de impedir as edificaÃ§Ãµes, em terras de domÃ­nio da UniÃ£o,  localizadas  no loteamento  JosÃ© Loureiro  II,no Bairro  Ulysses GuimarÃ£es,  em Joinville; e(ii.)  quais  foram  as  medidas   adotadas   pela  Secretaria  de  PatrimÃ´nio  da UniÃ£o,   no  Ã¢mbito  de  seu  poder   de  polÃ­cia,   apÃ³s  ter   sido   constatado,inequivocamente,    a  existÃªncia   de  imÃ³veis   interferindo  em  terreno  de marinha   e  acrescidos,  conforme   OfÃ­cio   n.   73949/2016-MP (2842113 - NUP 04972.006136/2016-62)\r\n\r\nO que falta:\r\nPrecisamos definir quais diligÃªncias adotar junto aos Ã³rgÃ£os municipais', '2019-05-24', '2019-05-30', NULL, 1, 1, '2019-05-24 19:48:47', '2019-08-08 20:47:47', 82, 2, 0, NULL, 403),
(431, 1, '4470/2016', '04972.005457/2016-40', 1, 'informaÃ§Ã£o/notÃ­cia de possÃ­vel utilizaÃ§Ã£o indevida de parte de terreno/acrescido de marinha cedido pela UniÃ£o ao MunicÃ­pio de SÃ£o JosÃ©/SC, em local denominado Angra de SÃ£o JosÃ© (Aterro hidrÃ¡ulico).', NULL, '2019-05-27', '2019-05-27', '2019-05-27 12:15:50', 8, 4, '2019-05-27 12:15:35', '2019-05-28 13:24:58', 126, 3, 0, NULL, 404),
(432, 1, '57/2019', '04972.003717/2019-95', 1, 'SubsÃ­dios para a defesa da UniÃ£o', NULL, '2019-05-27', '2019-06-10', '2019-06-24 20:18:19', 4, 3, '2019-05-27 14:32:52', '2019-08-21 19:19:40', 273, 3, 0, NULL, 405),
(433, 1, '00039/2019', '04972.014104/2012-15', 1, 'remetemos consulta sobre o andamento da aÃ§Ã£o.', NULL, '2019-05-27', '2019-05-27', '2019-05-27 16:26:32', 8, 3, '2019-05-27 16:26:18', '2019-05-30 13:20:37', 201, 3, 0, NULL, 406),
(434, 1, '162/2019', '04972.002751/2017-81', 1, 'Informar sobre a finalizaÃ§Ã£o do procedimento administrativo de regularizaÃ§Ã£o (04972.004937/2010-06)', NULL, '2019-05-27', NULL, '2019-06-12 16:44:01', 4, 4, '2019-05-27 16:49:15', '2019-07-29 21:08:07', 103, 3, 0, NULL, 407),
(435, 1, '1391/2019', '04972.003720/2019-17', 1, 'Informar se a Ã¡rea Ã© terreno de marinha', NULL, '2019-05-27', '2019-06-14', '2019-06-13 15:34:08', 4, 8, '2019-05-27 17:16:11', '2019-06-13 15:34:08', 274, 7, 0, NULL, 408),
(436, 1, '1400/2019', '04972.003721/2019-53', 1, 'Informar se a Ã¡rea encontra-se em terrenos de marinha.', NULL, '2019-05-27', '2019-06-14', '2019-06-13 15:30:50', 4, 8, '2019-05-27 17:27:24', '2019-06-13 15:30:50', 274, 7, 0, NULL, 409),
(437, 1, '101/2019', '04972.001156/2019-90', 1, 'ManifestaÃ§Ã£o sobre novos documentos', NULL, '2019-05-27', '2019-06-10', '2019-06-04 15:28:28', 4, 4, '2019-05-27 18:56:14', '2019-06-07 21:06:06', 224, 3, 0, NULL, 25),
(438, 1, '0220/2018', '04972.001241/2019-58', 1, 'dados cartogrÃ¡ficos acerca do rio ItajaÃ­-AÃ§u, em especial para identificar atÃ© que ponto precisamente o referido rio sofre influÃªncia das marÃ©s dentre os MunicÃ­pios de ApiÃºna, Ascurra, Benedito Novo, Blumenau, Doutor Pedrinho, Gaspar, Ilhota, Indaial, Luiz Alves, Pomerode, Rio dos Cedros, Rodeio e TimbÃ³, sendo suas respectivas margens consideradas terrenos de marinha. Outrossim, requisita informar especificamente acerca do imÃ³vel da empresa SANTA PAULINA STRASBOURG VEÃCULOS LTDA., na Rua ItajaÃ­, nÂº 1999, Bairro Vorstadt, em Blumenau/SC, se abrange ou nÃ£o terras de marinha e se estas foram ou nÃ£o ocupadas.', NULL, '2019-05-28', '2019-05-27', '2019-05-28 12:11:16', 8, 8, '2019-05-28 12:10:59', '2019-05-28 12:11:16', 218, 7, 0, NULL, 410),
(439, 1, '320/2019', '04972.003074/2019-80', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o', NULL, '2019-05-28', '2019-06-07', '2019-06-21 20:59:43', 4, 4, '2019-05-28 13:51:41', '2019-06-21 20:59:44', 228, 3, 0, NULL, 279),
(440, 1, '625/2019', '04972.003751/2019-60', 1, 'se manifeste conclusivamente sobre a possibilidade de resoluÃ§Ã£o extrajudicial.', NULL, '2019-05-28', NULL, NULL, 4, NULL, '2019-05-28 16:38:55', '2019-05-28 16:38:55', 56, 2, 0, NULL, 412),
(441, 1, '778/2019', '04972.003892/2017-11', 1, 'comunica que foi agendada a vistoria da Ã¡rea em questÃ£o pelo expert.', NULL, '2019-05-28', '2019-06-10', NULL, 4, NULL, '2019-05-28 17:32:49', '2019-05-28 17:32:49', 114, 2, 0, NULL, 413),
(442, 1, '0223/2019', '04972.005864/2012-23', 1, 'informar procedimentos para regularizaÃ§Ã£o de transferÃªncia.', NULL, '2019-05-28', '2019-03-29', '2019-05-30 12:22:04', 8, 3, '2019-05-28 17:35:01', '2019-05-30 14:13:37', 275, 3, 0, NULL, 414),
(443, 1, '105/2019', '04972.003756/2019-92', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-28', NULL, '2019-06-13 15:41:29', 4, 4, '2019-05-28 17:54:18', '2019-06-13 22:29:14', 224, 3, 0, NULL, 415),
(444, 1, '306/2018', '04972.001748/2019-10', 1, 'solicitado que esta SPU-SC faÃ§a o seguinte:\r\na) efetue a alteraÃ§Ã£o do titular do bem (RIP n. 8105.0003494-89) para a empresa Bigolin ParticipaÃ§Ãµes Ltda, CNPJ n. 01.351.876/0001-45 e;\r\nb) elabore novo demonstrativo de dÃ©bito para embasar a alteraÃ§Ã£o do devedor da CDA n. 91.6.14.022005-83 e remeta a esta PSFN/ChapecÃ³, para providÃªncias a nosso cargo.', NULL, '2019-05-28', NULL, '2019-05-29 18:14:08', 1, 1, '2019-05-28 18:01:40', '2019-05-30 12:40:30', 276, 3, 0, NULL, 417),
(445, 6, '00005/2019', '04972.001962/2019-68', 1, 'PARECER DE FORÃ‡A EXECUTÃ“RIA n. 00005/2019/CARPS/PUSC/PGU/AGUPROCESSO\r\nINTERESSADOS: PAULINA HERONDINA WAGNER E OUTROS\r\nSenhor Superintendente,De ordem, ATESTO, na forma do Decreto 2.839/98, da Portaria AGU 1.547/08 e da Lei 9.028/95, que a sentenÃ§a, dosautos   do   processo   acima  epigrafado,  Ã©  apta   a   produzir  efeitos,     para   anular  o   procedimento   administrativo   que   demarcou   oimÃ³vel   dos   autores   como   terreno   de   marinha,   por   vÃ­cio   formal,  decorrente   da   falta  de   intimaÃ§Ã£o   pessoal   dos   interessadoscertos, cancelando, em consequÃªncia, os dÃ©bitos relativos Ã  taxa de ocupaÃ§Ã£o constituÃ­dos contra os autores.', NULL, '2019-05-28', NULL, '2019-05-29 18:23:35', 1, 1, '2019-05-28 18:35:15', '2019-06-24 17:31:06', 201, 3, 0, NULL, 418),
(446, 1, '106/2019', '04972.004075/2016-07', 1, 'Prestar informaÃ§Ãµes sobre a conclusÃ£o do processo administrativo n. 04972003727201840.', 'OfÃ­cio respondido solicitando dilaÃ§Ã£o de prazo em 30 dias. SolicitaÃ§Ã£o feita em 12/07/2019. Demanda estÃ¡ mantida aberta para monitoramento do trabalho de identificaÃ§Ã£o dos imÃ³veis da zona costeira de sÃ£o josÃ©.', '2019-05-28', '2019-08-12', NULL, 4, 1, '2019-05-28 19:09:12', '2019-07-12 17:02:01', 224, 2, 0, NULL, 419),
(447, 1, '107/2019', '04972.005144/2017-72', 1, 'Apresentar o exato posicionamento dos terrenos e acrescidos de marinha. nas Ã¡reas compreendidas nas transcriÃ§Ãµes nÂº 12.480, nÂº 12.481 e nÂº 3.386 (evento 1, OUT35, fls. 16-33) e na matrÃ­cula nÂº 13.204.', NULL, '2019-05-22', '2019-07-11', '2019-06-26 16:03:34', 4, 4, '2019-05-29 17:23:08', '2019-06-27 23:17:52', 234, 3, 0, NULL, 13),
(448, 1, '170/2019', '04972.007236/2017-97', 1, 'Informa- se que Diante da decisÃ£o proferida em sede de aÃ§Ã£o rescisÃ³ria, verifica-se que ficou reconhecida a propriedade da UniÃ£o sobre o imÃ³vel indicado na petiÃ§Ã£o inicial (imÃ³vel descrito sob o nÂº 6.066 no CRI da 2Âª CircunscriÃ§Ã£o JudiciÃ¡ria de Joinville/SC), sendo que apenas foi afastada a possibilidade de cobranÃ§a de taxa de ocupaÃ§Ã£o da parte autora atÃ© a regularizaÃ§Ã£o do procedimento demarcatÃ³rio, com a intimaÃ§Ã£o pessoal do interessado.', NULL, '2019-05-29', NULL, '2019-05-30 18:19:43', 4, 8, '2019-05-29 18:09:30', '2019-05-30 18:19:45', 260, 3, 0, NULL, 420),
(449, 2, 's/n', '04972.003779/2019-05', 1, 'SubsÃ­dios Ã  defesa da uniÃ£o.', NULL, '2019-05-29', '2019-06-19', '2019-05-30 18:02:05', 4, 3, '2019-05-29 19:20:25', '2019-05-30 18:02:05', 277, 7, 0, NULL, 421),
(450, 1, '789/2019', '04972.002684/2019-66', 1, 'SubsÃ­dios a defesa da UniÃ£o.', NULL, '2019-05-29', '2019-06-07', '2019-06-11 14:46:38', 4, 3, '2019-05-29 19:52:28', '2019-06-11 20:58:42', 126, 3, 0, NULL, 250),
(451, 1, '3137/2016', '04972.004414/2016-47', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-30', NULL, NULL, 4, 4, '2019-05-30 13:44:19', '2019-05-30 13:44:29', 126, 4, 0, NULL, 422),
(453, 1, '805/2019', '04972.004414/2016-47', 1, 'informa acerca do acordo judicialmente homologado', NULL, '2019-05-30', NULL, '2019-05-30 13:47:56', 4, 4, '2019-05-30 13:47:39', '2019-05-30 13:47:57', 126, 3, 0, NULL, 422),
(454, 1, '321/2019', '04972.003895/2016-73', 1, 'InformaÃ§Ã£o atualizada quanto Ã  transferÃªncia da barragem Norte de JosÃ© Boiteux ao Estado de Santa Catarina', NULL, '2019-05-30', '2019-06-06', NULL, 4, NULL, '2019-05-30 14:28:21', '2019-05-30 14:28:21', 99, 2, 0, NULL, 423),
(455, 1, '804/2019', '04972.005427/2018-03', 1, 'comunica acerca do acÃ³rdÃ£o (evento 46) e do trÃ¢nsito em julgado da sentenÃ§a que denegou a seguranÃ§a e julgou improcedente o pedido.', NULL, '2019-05-30', NULL, '2019-05-30 17:51:56', 4, 4, '2019-05-30 17:51:22', '2019-05-30 17:51:57', 126, 3, 0, NULL, 424),
(456, 1, '242/2019', '04972.003831/2019-15', 1, 'Informe se Rubens Teixeira Madalena, CPF n. 306.046.809-53, e/ou Marilene Madalena Figueiredo possuem algum tipo de autorizaÃ§Ã£o/permissÃ£o para construir dentro da Lagoa de ImaruÃ­, notadamente, na Rua JoÃ£o Madalena, TaquaraÃ§utuba, ImaruÃ­/SC, coordenadas GeogrÃ¡ficas UTM 715596.05 E 6863352.80 S', NULL, '2019-05-30', '2019-06-13', '2019-06-13 20:11:56', 4, 4, '2019-05-30 18:09:40', '2019-06-18 21:01:17', 65, 3, 0, NULL, 425),
(457, 1, '234/2019', '04972.006107/2016-09', 1, 'Informe quais medidas foram tomadas quanto aos ranchos de pesca descaracterizados, verificados in loco, na Praia de ItapirubÃ¡, em Imbituba, conforme descrito no RelatÃ³rio de FiscalizaÃ§Ã£o de TerritÃ³rio n. 105/2018, notadamente se os RIPs ou TAUS jÃ¡ concedidos foram cancelados, e os que estavam em andamento, negados, encaminhando-se cÃ³pia da documentaÃ§Ã£o, caso existente', 'Aguardando barramento\r\nEncaminhar para NUREF', '2019-05-30', '2019-06-13', NULL, 4, 1, '2019-05-30 18:30:35', '2019-09-03 20:40:07', 65, 2, 0, NULL, 426),
(458, 5, '123', '000000000000000', 1, 'qweqweqweqw', NULL, '2019-05-30', NULL, NULL, 1, 1, '2019-05-30 23:01:26', '2019-05-30 23:01:39', 159, 4, 0, NULL, 5),
(459, 1, '00751/2019', '00745.002261/2019-79', 1, 'Pagamento de honorÃ¡rios periciais.', NULL, '2019-05-31', '2019-06-04', '2019-07-02 14:54:38', 8, 1, '2019-05-31 15:23:45', '2019-07-30 22:33:13', 100, 3, 0, NULL, 427),
(460, 1, '00739/2019', '00745.002248/2019-10', 1, 'Pagamento de honorÃ¡rios periciais.', 'Reiterado pela AGU em 15/207/2019', '2019-05-31', '2019-05-22', '2019-07-22 15:41:48', 8, 3, '2019-05-31 15:29:33', '2019-07-22 15:41:50', 100, 3, 0, NULL, 429),
(461, 1, '0357/2019', '04972.003869/2019-98', 1, 'a parte autora requer em CARÃTER LIMINAR, o pedido de tutela de urgÃªncia, para\r\nque a Requerida promova a reativaÃ§Ã£o da RIP nÂ°8161.0100112-36, junto ao processo administrativo nÃºmero\r\n10983.003074/8561, expedindo a guia para recolhimento da taxa de laudÃªmio e a consequente transferÃªncia de domÃ­nio\r\nÃºtil em nome do Requerente, no prazo mÃ¡ximo de 30 (trinta) dias, impondo-se multa diÃ¡ria no valor de R$ 1.000,00 (um\r\nmil reais), em caso de inadimplemento, nos termos do Artigo 300 do CPC', NULL, '2019-05-31', '2019-06-06', '2019-06-11 21:07:30', 3, 3, '2019-05-31 17:04:03', '2019-06-11 21:07:32', 201, 3, 0, NULL, 430),
(462, 1, '39040/2019', '04972.004494/2016-31', 1, 'Proceder a suspensÃ£o de exigibilidade das taxas de ocupaÃ§Ã£o relativas ao imÃ³vel objeto da aÃ§Ã£o (matrÃ­cula nÂº 9.357 do 1Âº Registro de ImÃ³veis de Joinville, situado Ã  Rua Albano Schulz, nÂº 911 e 925, bairro Centro, Joinville/SC)', NULL, '2019-05-31', NULL, '2019-06-03 19:53:20', 4, 4, '2019-05-31 20:55:35', '2019-06-07 21:32:18', 278, 3, 0, NULL, 431),
(463, 1, '079/2019', '04972.010729/2018-95', 1, 'informa trÃ¢nsito em julgado da aÃ§Ã£o. Julgado improcedente o pedido de nulidade.\nNecessitamos que sejam apresentados os extratos atualizados das contas 005 e 635 vinculados a aÃ§Ã£o para conversÃ£o em renda via DARF.', NULL, '2019-06-03', NULL, '2019-06-03 19:52:49', 8, 4, '2019-06-03 16:18:42', '2019-06-10 19:38:26', 145, 3, 1, NULL, 432),
(464, 1, '223/2019', '00556.001729/2016-92', 1, 'ComplementaÃ§Ã£o de documentaÃ§Ã£o', NULL, '2019-06-03', '2019-06-14', '2019-07-18 15:18:21', 4, 3, '2019-06-03 17:18:50', '2019-07-18 15:18:24', 65, 3, 0, NULL, 192),
(465, 1, '96/2019', '00638304220118240023', 1, 'ManifestaÃ§Ã£o de interesse - Apresentar memorial/planta legÃ­vel com coordenadas UTM em que demonstre a interferÃªncia com Ã¡rea da UniÃ£o.', NULL, '2019-05-15', '2019-05-29', '2019-06-12 16:13:13', 3, 3, '2019-06-03 17:40:39', '2019-06-12 16:22:52', 234, 3, 0, NULL, 30),
(466, 1, '330/2019', '04972.003938/2019-63', 0, 'Providenciar a elaboraÃ§Ã£o do PRAD no prazo estipulado.', 'Por meio da Nota TÃ©cnica 15/2019 (3530369), foi solicitada prorrogaÃ§Ã£o de prazo de 120 em 20/08/2019.', '2019-06-03', '2019-08-15', NULL, 4, 3, '2019-06-03 19:51:27', '2019-08-20 20:59:59', 106, 2, 1, NULL, 22),
(467, 9, '5016609-25.2018.4.04.7200', '04972.008781/2018-81', 1, 'DEFERIU: \"(...) Ã \r\nautoridade impetrada o derradeiro prazo de 60 (sessenta) dias, ciente das\r\ndificuldades enfrentadas pela Secretaria de PatrimÃ´nio da UniÃ£o, para que ultime\r\na anÃ¡lise da documentaÃ§Ã£o apresentada e CONCLUA o Processo Administrativo\r\nprotocolado sob o n. 04972.000232.2009-78, sob pena de aplicaÃ§Ã£o de multa\r\ndiÃ¡ria em face de eventual descumprimento, que fixo em R$ 500,00 (quinhentos\r\nreais), tendo como dias a quo o primeiro dia Ãºtil apÃ³s o decurso do prazo acima\r\nconcedido (...)\".', NULL, '2019-05-30', '2019-07-30', '2019-07-03 20:24:07', 3, 3, '2019-06-03 19:58:50', '2019-07-03 20:24:18', 279, 3, 1, NULL, 433),
(468, 1, '811/2019', '04972.206202/2015-11', 1, 'Comunica a data da vistoria: 02/07/2019.', NULL, '2019-05-24', NULL, '2019-06-03 20:08:06', 4, 4, '2019-06-03 20:07:37', '2019-06-03 20:08:07', 126, 3, 0, NULL, 434),
(469, 1, '750/2019', '04972.004256/2018-97', 1, 'ManifestaÃ§Ã£o sobre nova documentaÃ§Ã£o.', NULL, '2019-05-24', '2019-06-13', '2019-06-12 19:13:13', 4, 4, '2019-06-03 20:44:58', '2019-06-13 23:22:14', 100, 3, 0, NULL, 142),
(470, 1, '5471/2016', '04972.006300/2016-31', 1, 'informaÃ§Ãµes sobre se jÃ¡ houve ou nÃ£o a regularizaÃ§Ã£o da obra por meio de Termo de AutorizaÃ§Ã£o de Uso (TAU). Em caso negativo, requisito sua imediata demoliÃ§Ã£o, haja vista que ocupa  Ã¡rea protegida pela  legislaÃ§Ã£o e de uso comum.', NULL, '2016-11-11', '2016-11-21', NULL, 1, NULL, '2019-06-03 21:49:53', '2019-06-03 21:49:53', 86, 2, 0, NULL, 435),
(471, 1, '1694/2017', '04972.001913/2019-25', 1, 'prestar informaÃ§Ãµes sobre a regularidade das ocupaÃ§Ãµes na Ilha AraÃºjo de Fora, na BaÃ­a da Babitonga, em SÃ£o Francisco do Sul.\r\nObs: O OfÃ­cio da demanda estÃ¡ no processo SEI nÂº 04972.004280/2016-64', 'O que Ã©: RelatÃ³rio de FiscalizaÃ§Ã£o nÂº 17/2019 - Ilha AraÃºjo de Fora - BaÃ­a da Babitonga, RIP 83190100057-50, nÃ£o existe OfÃ­cio pendente nesse processo, porÃ©m, o procedimento consta do OfÃ­cio 1694/2017.<br>\r\nO que foi feito: Realizada a FiscalizaÃ§Ã£o o ocupante foi Notificado a apresentar documentos que comprovem a regularidade das construÃ§Ãµes em 30/05/2019.<br>\r\nO que falta fazer: Juntar o Aviso de Recebimento - AR e verificar o atendimento da NotificaÃ§Ã£o. Caso nÃ£o seja atendida, aplicar as sanÃ§Ãµes cabÃ­veis.', '2018-09-15', '2018-10-15', NULL, 1, 5, '2019-06-03 23:15:31', '2019-07-11 21:39:17', 82, 2, 0, NULL, 436),
(472, 1, '1694/2017', '04972.001914/2019-70', 1, 'informar sobre medidas de fiscalizaÃ§Ã£o da ocupaÃ§Ã£o da Ilha AraÃºjo de Dentro, na BaÃ­a da Babitonga, em SÃ£o Francisco do Sul', 'O que Ã©: RelatÃ³rio de FiscalizaÃ§Ã£o nÂº 18/2019 - Ilha AraÃºjo de Dentro - BaÃ­a da Babitonga, nÃ£o existe OfÃ­cio pendente nesse processo, porÃ©m, o procedimento consta do OfÃ­cio 1694/2017.<br>\r\nO que foi feito: Realizada a FiscalizaÃ§Ã£o o ocupante foi Notificado a apresentar documentos que comprovem a regularidade das construÃ§Ãµes em 30/05/2019.<br>\r\nO que falta fazer: Juntar o Aviso de Recebimento - AR e verificar o atendimento da NotificaÃ§Ã£o. Caso nÃ£o seja atendida, aplicar as sanÃ§Ãµes cabÃ­veis.', '2017-09-15', '2017-10-16', NULL, 1, 5, '2019-06-03 23:26:17', '2019-07-11 21:44:53', 82, 2, 0, NULL, 438),
(473, 1, '1694/2017', '04972.001916/2019-69', 1, 'informar sobre medidas de fiscalizaÃ§Ã£o na Ilha dos Negros, localizada na BaÃ­a da Babitonga, municÃ­pio de SÃ£o Francisco do Sul', 'O que Ã©: RelatÃ³rio de FiscalizaÃ§Ã£o nÂº 20/2019 - Ilha dos Negros - BaÃ­a da Babitonga, nÃ£o existe OfÃ­cio pendente nesse processo, porÃ©m, o procedimento consta do OfÃ­cio 1694/2017.<br>\r\nO que foi feito: Realizada a FiscalizaÃ§Ã£o o ocupante foi Notificado a apresentar documentos que comprovem a regularidade das construÃ§Ãµes em 30/05/2019.<br>\r\nO que falta fazer: Juntar o Aviso de Recebimento - AR e verificar o atendimento da NotificaÃ§Ã£o. Caso nÃ£o seja atendida, aplicar as sanÃ§Ãµes cabÃ­veis.', '2017-09-15', '2017-10-16', NULL, 1, 5, '2019-06-03 23:31:10', '2019-07-11 21:46:32', 82, 2, 0, NULL, 439),
(474, 1, '45/2017 DPU/SC', '04972.000433/2017-85', 1, 'InformaÃ§Ãµes sobre o fechamento do acesso ao mar em ponto localizado Ã  R. HemÃ³genes Coelho, Barra da Lagoa, CEP 88.061-048, em tese, pela empresa Barra NÃ¡utica Marina Escola.', NULL, '2017-01-26', '2017-01-28', NULL, 17, NULL, '2019-06-04 14:40:34', '2019-06-04 14:40:34', 280, 2, 0, NULL, 440),
(475, 1, '2727/2017', '04972.002157/2017-90', 1, 'Encaminho em anexo considerando o exposto nos OfÃ­cios nÂ°041/2017 e nÂ°18/2017 emitidos, respectivamente, pela Prefeitura de BiguaÃ§u e FAMABI (cÃ³pias em anexo), REQUISITO, EM 60 DIAS, manifestaÃ§Ã£o \r\nsobre cada um dos ranchos identificados pela FAMABI.', NULL, '2017-05-11', '2019-07-10', NULL, 17, 17, '2019-06-04 15:01:22', '2019-06-04 15:02:41', 90, 2, 0, NULL, 441),
(476, 9, '01', '04972.003944/2019-11', 1, 'anotar indisponibilidade de transferÃªncia do RIP  8327 0000129-76.', NULL, '2019-06-03', NULL, '2019-06-05 20:00:34', 8, 8, '2019-06-04 15:55:49', '2019-06-05 20:00:35', 281, 3, 1, NULL, 442),
(477, 1, '910/2017', '04972.008618/2017-38', 1, 'informaÃ§Ã£o acerca da homologaÃ§Ã£o do restante das linhas do preamar mÃ©dio de 1831 e do limite dos terrenos de marinha no rio Bombinhas, assim como informe quanto a eventuais ocupaÃ§Ãµes irregulares existentes em bens da UniÃ£o naquele local, incluindo os terrenos de marinha e seus acrescidos.', NULL, '2017-12-18', '2017-12-31', '2019-08-12 19:46:26', 8, 3, '2019-06-04 16:27:06', '2019-08-12 19:46:27', 62, 3, 0, NULL, 443),
(478, 9, '5012052-58.2019.4.04.7200', '04972.003957/2019-90', 1, 'Trata-se de mandado de seguranÃ§a proposto pela autarquia municipal em face\r\ndo Superintendente da Secretaria de PatrimÃ´nio da UniÃ£o em que requer a suspensÃ£o do\r\nprocesso administrativo n. 04972.007208/2017-70 da Secretaria do PatrimÃ´nio da UniÃ£o em\r\nde Santa Catarina e para que desconstituÃ­do ato da autoridade coatora que concluiu pela\r\nlavratura de Contrato de CessÃ£o da Ã¡rea de 5.829,70 mÂ² ao MunicÃ­pio de Navegantes. Alega\r\nfalta de observÃ¢ncia ao contraditÃ³rio e de motivaÃ§Ã£o. Narrou que requereu a revisÃ£o do ato de\r\ncessÃ£o, pois a atual gestÃ£o \"tomou ciÃªncia de invasÃµes de grande parcela da Ã¡rea objeto de\r\ncessÃ£o, sem olvidar o necessÃ¡rio resguardo do imÃ³vel para atender as suas finalidades\", mas\r\nnÃ£o obteve Ãªxito. Apontou que a Ã¡rea leste do terreno objeto de cessÃ£o foi invadida em Ã¡rea\r\nde dez quilÃ´metros de extensÃ£o de praia. Disse ter tomado medidas para impedir a invasÃ£o,\r\nmas foram edificadas seis construÃ§Ãµes no local, em relaÃ§Ã£o as quais nÃ£o se sabe sobre a\r\nexistÃªncia de saneamento bÃ¡sico.', NULL, '2019-06-03', '2019-06-13', '2019-07-03 20:22:33', 3, 3, '2019-06-04 16:29:08', '2019-07-03 21:55:59', 282, 3, 0, NULL, 444),
(479, 7, '07/2014', '04972.003243/2014-77', 1, 'recomenda o cancelamento dos RIPs na Praia da Ilhota, em Laguna/SC', NULL, '2017-04-17', NULL, NULL, 8, NULL, '2019-06-04 16:39:15', '2019-06-04 16:39:15', 72, 2, 0, NULL, 446),
(480, 1, '376/2017', '04972.001119/2017-10', 1, 'Solicita informaÃ§Ãµes sobre a possÃ­vel existÃªncia de Ã¡rea pertencente Ã  UniÃ£o e/ou que abranja terras de marinha e seus acrescidos, no entorno da Rua Divina ProvidÃªncia, no bairro Comasa, em Joinville; em caso de resposta afirmativa para o questionamento anterior, seja informado se hÃ¡ registro de ocupaÃ§Ã£o regular na Ã¡rea perante a SPU e quem Ã© o titular; e, por fim, seja informado se a SPU foi notificada pelo MunicÃ­pio de Joinville ou outra fonte a respeito de possÃ­veis infraÃ§Ãµes no local e, tendo havido a aludida notificaÃ§Ã£o, quais medidas foram adotadas para sanar a irregularidade apontada.', 'Niarcos verificar', '2017-03-02', '2017-04-01', '2019-07-11 21:34:45', 17, 3, '2019-06-04 16:39:38', '2019-07-11 21:34:47', 82, 3, 0, NULL, 445),
(481, 1, '108/2019', '04972.003949/2019-43', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-05-28', '2019-06-11', '2019-06-07 14:59:19', 4, 3, '2019-06-04 16:47:40', '2019-06-11 21:10:40', 234, 3, 0, NULL, 448),
(482, 1, '29/2017', '04972.000828/2017-88', 1, 'o cancelamento das ocupaÃ§Ãµes no Parque Residencial Porto Belo - Porto Belo/SC', NULL, '2017-02-23', NULL, NULL, 8, NULL, '2019-06-04 16:54:17', '2019-06-04 16:54:17', 62, 2, 0, NULL, 449);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `seiMP`, `demanda`, `resumoSituacao`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(483, 1, '397/2017', '04972.001322/2014-43', 1, 'informaÃ§Ãµes sobre o atual andamento do caso das irregularidades nos ranchos de pesca localizados na Praia da Enseada do Brito, PalhoÃ§a/SC', NULL, '2017-01-31', '2017-02-20', NULL, 8, NULL, '2019-06-04 17:02:13', '2019-06-04 17:02:13', 95, 2, 0, NULL, 450),
(484, 1, '3307/2017', '04972.003225/2017-38', 1, 'a realizaÃ§Ã£o de vistoria no local e elaboraÃ§Ã£o de documento tÃ©cnico informando se as ocupaÃ§Ãµes, inclusive edificaÃ§Ã£o do SR. AMÃ‚NCIO LIDOMAR DA SILVA VARREIRA. FiscalizaÃ§Ã£o - Praia de Naufragados - FlorianÃ³polis/SC', NULL, '2017-06-08', NULL, NULL, 8, NULL, '2019-06-04 17:13:25', '2019-06-04 17:13:25', 90, 2, 0, NULL, 451),
(485, 1, '305/2019', '04972.206417/2015-32', 1, 'informar interferÃªncia e regularidade da  Via GastronÃ´mica da Praia de ArmaÃ§Ã£o do Itapocoroy - Penha/SC', 'null', '2019-04-25', '2019-05-10', '2019-08-14 16:41:36', 8, 3, '2019-06-04 19:33:39', '2019-08-14 16:41:40', 74, 3, 0, NULL, 453),
(486, 6, 'PARECER DE FORÃ‡A EXECUTÃ“RIA n. 00011/2019/COREPAM-SI/PRU4R/PGU/AGU', '04972.006758/2017-71', 1, 'aÃ§Ã£o rescisÃ³ria ajuizada por CARIN HUHN, CONRADO HUHN e DIANA\r\nMARA GONÃ‡ALVES HUHN em face da UniÃ£o, buscando a rescisÃ£o de acÃ³rdÃ£o proferido nos autos da\r\napelaÃ§Ã£o nÂº 5001010-24.2010.404.7201/SC, que deu provimento o apelo da ora rÃ© e Ã  remessa oficial, para\r\nreconhecer como terreno de marinha o imÃ³vel da parte autora objeto da discussÃ£o (ev. 1).\r\n\r\nIV. CONCLUSÃƒO\r\nAnte todo o exposto, este Ã³rgÃ£o de execuÃ§Ã£o da AGU informa que a decisÃ£o possui forÃ§a\r\nexecutÃ³ria, de forma que restam suspensas \"quaisquer execuÃ§Ãµes que visem Ã  cobranÃ§a de exaÃ§Ã£o\r\ndecorrente da condiÃ§Ã£o de terreno de marinha do imÃ³vel objeto da lide, inclusive os executivos\r\nfiscais de n. 5013976-38.2018.4.04.7201 (2006.72.01.000260-9) e nÂº 5002156- 85.2019.4.04.7201\r\n(2009.72.01.001822-9), bem assim, da dÃ­vida administrativa vinculada ao RIP nÂº 8179000323303\".\r\nDe outro norte, havendo a necessidade de informaÃ§Ãµes para a defesa da UniÃ£o nesta aÃ§Ã£o\r\nrescisÃ³ria, solicito seja encaminhada Ã  CoordenaÃ§Ã£o de PatrimÃ´nio da UniÃ£o da PRU4, no prazo\r\nmÃ¡xima de atÃ© 15 dias corridos, cÃ³pia integral do processo administrativo de inscriÃ§Ã£o da ocupaÃ§Ã£o\r\ndo imÃ³vel em testilha, ou eventuais outras informaÃ§Ãµes que julgar oportunas, as quais podem tambÃ©m ser\r\nenviada ao e-mail sadi.tolfo@agu.gov.br, a fim de dar celeridade ao feito.', NULL, '2019-05-15', '2019-06-07', '2019-06-10 17:20:40', 3, 3, '2019-06-04 19:40:19', '2019-06-10 19:46:57', 283, 4, 1, NULL, 454),
(487, 1, '73/2016', '04972.002970/2016-89', 1, 'informaÃ§Ãµes acerca da regularidade cadastral das ilhas Feias e Itacolumis (Norte e Sul) - PiÃ§arras/SC', NULL, '2016-04-07', NULL, NULL, 8, NULL, '2019-06-04 19:45:34', '2019-06-04 19:45:34', 60, 2, 0, NULL, 455),
(488, 1, '398/2017', '04972.002129/2017-72', 1, 'regularidade de rancho de pesca na Praia da Vila, em Imbituba/SC - TAUS', 'FiscalizaÃ§Ã£o agendada - 23/07/2019', '2017-05-09', NULL, NULL, 8, 8, '2019-06-04 19:51:11', '2019-07-17 20:04:30', 65, 2, 0, NULL, 456),
(489, 1, '645/2019', '04972.004275/2018-13', 1, 'informaÃ§Ã£o a respeito de eventual anuÃªncia da SuperintendÃªncia do PatrimÃ´nio da UniÃ£o para utilizaÃ§Ã£o da Ã¡rea onde foi instalado o estacionamento para veÃ­culos, situada na esquina da Rua Caramuru com a Avenida AtlÃ¢ntica, na Praia do Ervino, SÃ£o Francisco do Sul, bem como para informar se a Ã¡rea conta com registro de inscriÃ§Ã£o patrimonial (coordenadas 26Â°23\'56.82\"S/48Â°35\'20.99\"O)', NULL, '2019-04-11', '2019-05-06', '2019-06-18 21:38:25', 8, 4, '2019-06-04 20:02:55', '2019-06-18 21:38:27', 85, 3, 0, NULL, 459),
(490, 1, '408/2019', '04972.010385/2018-14', 1, 'Sejam adotadas as medidas cabÃ­veis quanto ao imÃ³vel objeto do procedimento e os adjacentes, jÃ¡ que estÃ£o em Ã¡rea de marinha e nÃ£o possuem inscriÃ§Ã£o de uso/ocupaÃ§Ã£o.', NULL, '2019-05-23', NULL, '2019-06-12 19:12:20', 4, 8, '2019-06-04 20:30:06', '2019-06-12 19:12:22', 74, 3, 0, NULL, 460),
(491, 1, '2296/2018', '04972.005990/2018-73', 1, 'regularidade dos ranchos de pesca em terras de marinha Ã s margens da Lagoa da ConceiÃ§Ã£o.', NULL, '2018-05-24', NULL, NULL, 8, 8, '2019-06-04 20:34:47', '2019-06-04 20:35:27', 86, 2, 0, NULL, 461),
(492, 1, '513/2017', '04972.002994/2017-19', 1, 'informaÃ§Ãµes sobre a regularidade cadastral do terreno de marinha em nome de Ã‰dio Marques da Silva (Restaurante Tartaruga), para a localidade da Barra de Ibiraquera, municÃ­pio de Imbituba/SC', NULL, '2017-06-06', '2016-06-30', NULL, 8, NULL, '2019-06-04 20:46:43', '2019-06-04 20:46:43', 73, 2, 0, NULL, 463),
(493, 1, '2177/2016', '04972.000267/2017-17', 1, 'informaÃ§Ãµes sobre a regularidade cadastral dos imÃ³veis localizados no Canal do Linguado - SÃ£o Francisco do Sul e Araquari', NULL, '2017-01-19', NULL, NULL, 8, NULL, '2019-06-04 20:56:17', '2019-06-04 20:56:17', 85, 2, 0, NULL, 464),
(494, 1, '471/2019', '04972.005843/2016-31', 1, 'InformaÃ§Ãµes atualizadas sobre a questÃ£o relatada no ofÃ­cio (incorporaÃ§Ã£o de imÃ³veis em Mafra/SC, mais especificamente se jÃ¡ foram realizados os procedimentos complementares administrativos\r\nvisando a incorporaÃ§Ã£o dos imÃ³veis para posterior repasse ao setor de destinaÃ§Ã£o e fiscalizaÃ§Ã£o, conforme fl. 163, anexa ao ofÃ­cio.', NULL, '2019-04-24', '2019-05-27', NULL, 18, 18, '2019-06-04 21:01:11', '2019-06-04 21:02:19', 68, 2, 0, NULL, 465),
(495, 1, '849/2019', '04972.001575/2017-60', 1, 'solicita sejam conferidos os dados registrais da matrÃ­cula em que a parte rÃ© acolheu o pedido de retificaÃ§Ã£o do registro de imÃ³veis para afastar da Ã¡rea registrada a Ã¡rea de propriedade da UniÃ£o.', NULL, '2019-05-29', '2019-06-14', '2019-06-13 20:12:27', 4, 4, '2019-06-04 21:06:04', '2019-06-13 22:44:20', 114, 3, 0, NULL, 466),
(496, 1, '1682/2018', '04972.003122/2016-97', 1, 'adoÃ§Ã£o de medidas para regularizaÃ§Ã£o de ocupaÃ§Ã£o.', NULL, '2018-10-11', NULL, NULL, 8, NULL, '2019-06-04 21:07:40', '2019-06-04 21:07:40', 85, 2, 0, NULL, 467),
(497, 1, '1063/2017', '04972.004073/2017-91', 1, 'informaÃ§Ãµes acerca das providÃªncias adotadas a partir da notÃ­cia de irregularidade na ocupaÃ§Ã£o do imÃ³vel localizado na Rua JoÃ£o Luzia, n. 1622, em\r\nBarra do Sul, e se existem dÃ©bitos pendentes', NULL, '2018-07-06', NULL, NULL, 8, 17, '2019-06-04 21:13:49', '2019-06-24 15:51:36', 85, 2, 0, NULL, 468),
(498, 1, '500/2015', '04972.000760/2015-75', 1, 'InformaÃ§Ãµes sobre intervenÃ§Ã£o em bens da UniÃ£o, existÃªncia e regularidade de inscriÃ§Ã£o de ocupaÃ§Ã£o da construÃ§Ã£o de um prÃ©dio denominado Ilha do Arvoredo, na Praia de Palmas, em Governador Celso Ramos/SC, de responsabilidade atribuÃ­da Ã  construtora Sanluzzi.', NULL, '2015-01-29', '2015-02-09', NULL, 17, NULL, '2019-06-04 21:34:52', '2019-06-04 21:34:52', 86, 2, 0, NULL, 469),
(499, 1, '1935/2019', '04972.004280/2016-64', 1, 'informaÃ§Ãµes sobre quais as medidas adotadas para fiscalizaÃ§Ã£o e proteÃ§Ã£o do patrimÃ´nio da UniÃ£o nas ilhas da BaÃ­a da Babitonga.\nInquÃ©rito Civil nÂ° 1.33.005.000308/2013-31.', NULL, '2019-06-03', '2019-06-13', '2019-06-14 20:37:13', 8, 3, '2019-06-04 21:36:19', '2019-06-14 20:37:17', 248, 3, 0, NULL, 475),
(500, 1, '418/2018', '04972.001443/2017-38', 1, 'InformaÃ§Ãµes sobre qual fase estÃ¡ o processo de cessÃ£ ao IPHAN e como pretende dar maior celeridade para que a cessÃ£o seja efetivada, bem como  esclareÃ§a quais as providÃªncias jÃ¡ adotou e que pretende\r\nadotar para a preservaÃ§Ã£o do ArmazÃ©m FerroviÃ¡rio, localizado no MunicÃ­pio de Matos Costa que estÃ¡ com risco de ruÃ­na em razÃ£o de graves danos na estrutura de telhado.', NULL, '2018-11-05', '2018-11-19', NULL, 18, 18, '2019-06-04 21:40:03', '2019-06-04 21:40:19', 59, 2, 0, NULL, 476),
(501, 1, '155/2019', '04972.001444/2017-82', 1, 'InformaÃ§Ãµes sobre o andamento e conclusÃ£o do processo de cessÃ£o dos bens imÃ³veis da extinta RFFSA existentes no MunicÃ­pio de Porto UniÃ£o diretamente Ã quele MunicÃ­pio.Havendo pendÃªncias, que informe especificamente quais sÃ£o, eis que o MunicÃ­pio possui interesse na conservaÃ§Ã£o dos bens, restando impedido de realizar maiores obras em virtude da demora na efetivaÃ§Ã£o da cessÃ£o.', NULL, '2019-05-22', '2019-06-05', NULL, 18, 18, '2019-06-04 21:56:30', '2019-06-04 21:57:14', 59, 2, 0, NULL, 478),
(502, 1, '3554/2018', '04972.014654/2012-26', 1, 'InformaÃ§Ãµes e o embargo/interdiÃ§Ã£o do local no prazo de 24 horas por razÃ£o de comunicaÃ§Ã£o de obra de concretagem caracterizando apropriaÃ§Ã£o de Ã¡rea comum do povo (praia), considerando anterior decisÃ£o judicial nos autos da ACP n.Âº 5026468-07.2014.4.04.7200 (Beach Clubs).', NULL, '2018-06-27', '2019-06-28', NULL, 17, NULL, '2019-06-04 22:07:47', '2019-06-04 22:07:47', 95, 2, 0, NULL, 479),
(503, 1, '4972/2018', '04972.007774/2018-62', 1, 'Destacar as informaÃ§Ãµes sobre a ausÃªncia de regularidade e de posse direta pela Empresa Pioneira da Costa S/A, para requisitar, visto o OfÃ­cio nÂ° 84467/2018, informaÃ§Ãµes sobre a soluÃ§Ã£o porventura encontrada para a ocupaÃ§Ã£o de fato existente na ilha na Ã¡rea inscrita para a referida empresa, e a possibilidade de sua regularizaÃ§Ã£o, inclusive ouvido o IPHAN.', NULL, '2018-10-05', '2018-11-05', NULL, 17, NULL, '2019-06-04 22:55:48', '2019-06-04 22:55:48', 86, 2, 0, NULL, 483),
(504, 1, '206/2019', '04972.005263/2017-25', 1, 'NÃ£o hÃ¡ demanda, apenas informaÃ§Ã£o>> Informa que requisitou resposta ao DNIT, de solicitaÃ§Ã£o de resposta Ã quele Ã³rgÃ£o quanto aos ofÃ­cios 72561/2018 e 72558/2018 desta SPU/SC, jÃ¡ que as Ã¡reas em discussÃ£o sÃ£o de propriedade do DNIT.', NULL, '2019-02-14', '2019-06-05', NULL, 18, 18, '2019-06-04 22:56:10', '2019-06-04 22:57:14', 68, 2, 0, NULL, 480),
(505, 1, '987/2018', '04972.008948/2018-12', 1, 'Encaminha a NotÃ­cia de Fato para ciÃªncia e adoÃ§Ã£o das providÃªncias que entender cabÃ­veis relativamente ao imÃ³vel.', NULL, '2018-09-24', '2019-06-04', NULL, 18, NULL, '2019-06-04 23:08:02', '2019-06-04 23:08:02', 73, 2, 0, NULL, 485),
(506, 7, '38/2014', '11452.002473/0078', 1, 'Recomenda cancelamento de todas as inscriÃ§Ãµes de ocupaÃ§Ã£o sobre a APP em nome da AssociaÃ§Ã£o Couto de Magalhaes ou qualquer outra pessoa ou associaÃ§Ã£o. Requisita identificaÃ§Ã£o das Ã¡reas APP e medidas para os cancelamentos, bem como recuperaÃ§Ã£o ambiental.', NULL, '2014-06-28', '2014-07-07', NULL, 17, 17, '2019-06-05 15:30:25', '2019-06-05 16:25:03', 86, 2, 0, NULL, 486),
(507, 1, '5664/2016', '04972.006422/2016-28', 1, 'Regularidade do Loteamento Residencial GÃªnova pela empresa Pantanal ConstruÃ§Ãµes e Incorporadora Ltda., BiguaÃ§u/SC', NULL, '2016-11-28', NULL, NULL, 8, NULL, '2019-06-05 15:33:10', '2019-06-05 15:33:10', 90, 2, 0, NULL, 487),
(508, 1, '3842/2018', '04972.008134/2018-70', 1, 'informaÃ§Ãµes atualizadas quanto as providÃªncias adotadas nas inscriÃ§Ãµes de ocupaÃ§Ã£o na Ã¡rea do empreendimento localizado na Barra da Lagoa, cadastrados sob os RIP\'s 81050000383-00, 81050004883-30 e 81050005597-00', NULL, '2018-08-13', NULL, NULL, 8, NULL, '2019-06-05 15:41:58', '2019-06-05 15:41:58', 86, 2, 0, NULL, 488),
(509, 1, '2853/2018', '04972.006846/2018-54', 1, 'vistoria e informaÃ§Ãµes sobre a regularidade em relaÃ§Ã£o ao contrato de cessÃ£o de uso do Processo nÂ° 04972.003671/2016-61 desse\nÃ³rgÃ£o, especialmente no que se relaciona com Ã¡reas de uso comum.', NULL, '2018-06-28', '2018-07-13', NULL, 8, NULL, '2019-06-05 16:12:57', '2019-06-05 16:12:57', 86, 2, 0, NULL, 489),
(510, 1, '111/2019', '04972.006391/2018-77', 1, 'InformaÃ§Ãµes atualizadas.', 'null', '2019-05-29', '2019-07-01', NULL, 4, 1, '2019-06-05 16:51:00', '2019-09-02 23:16:30', 224, 2, 1, NULL, 175),
(511, 4, '711/2014', '04972.004164/2014-83', 1, 'Participar de reuniÃ£o referente Ã  a viabilidade de Termo de Ajuste de Conduta, a fim de instruir IC que investiga existÃªncia de balsas pesqueiras instaladas no Rio AraranguÃ¡.', NULL, '2014-05-12', NULL, NULL, 17, 17, '2019-06-05 16:54:49', '2019-06-05 17:11:58', 79, 2, 0, NULL, 491),
(512, 1, '5315/2015', '04972.009905/2014-12', 1, 'ManifestaÃ§Ã£o sobre quais foram as providÃªncias adotadas para regularizar a Ã¡rea invadida em SÃ£o JosÃ©/SC', NULL, '2015-08-12', NULL, NULL, 8, NULL, '2019-06-05 16:59:45', '2019-06-05 16:59:45', 90, 2, 0, NULL, 492),
(513, 1, '414/2019', '04972.000663/2017-44', 1, 'ReiteraÃ§Ã£o do OfÃ­cio nÂº 146/2019.', NULL, '2019-05-29', '2019-06-25', '2019-06-19 16:38:11', 4, 4, '2019-06-05 17:04:56', '2019-06-19 16:38:12', 74, 3, 0, NULL, 174),
(514, 1, '2345/2016', '04972.005916/2013-42', 1, 'informar sobre a regularidade na construÃ§Ã£o de edificaÃ§Ã£o situada na Rodovia Baldicero Filomeno, nÂ° 19.794, Bairro Caieira da Barra do Sul, em\nFlorianÃ³polis', NULL, '2016-05-18', NULL, NULL, 8, 8, '2019-06-05 17:10:38', '2019-06-05 17:10:55', 91, 2, 0, NULL, 494),
(515, 1, '1093/2018', '04972.003572/2017-61', 1, 'Informa o trÃ¢nsito em julgado que atestou a regularidade da cobranÃ§a do laudÃªmio.', NULL, '2018-12-21', NULL, '2019-06-05 19:53:56', 4, 4, '2019-06-05 19:52:44', '2019-06-05 19:54:00', 102, 3, 0, NULL, 495),
(516, 1, '3152/2017', '05022.000703/2002-73', 1, 'verificar a regularidade de ocupaÃ§Ãµes em terrenos da UniÃ£o na praia do Campeche, em FlorianÃ³polis/SC', NULL, '2017-06-05', NULL, NULL, 8, NULL, '2019-06-05 19:56:56', '2019-06-05 19:56:56', 90, 2, 0, NULL, 496),
(517, 1, '369/2019', '00745.000880/2019-29', 1, 'requer-se:\r\nA UNIÃƒO, o arquivo no formato digital â€œDWGâ€ da Base CartogrÃ¡fica do GRPU/SPU, articulaÃ§Ãµes ou folhas\r\nnsÂº 735-011, 735-012, conforme prevÃª o CPC Art. 473. Â§ 3Âº. Enviar por e-mail (alexandre@santangelo.eng.br);', NULL, '2019-06-04', '2019-06-08', '2019-06-05 20:34:45', 3, 3, '2019-06-05 20:00:49', '2019-06-07 20:37:03', 121, 3, 0, NULL, 497),
(518, 1, '2598/2018', '04972.006304/2018-81', 1, 'informaÃ§Ãµes se jÃ¡ houve a demoliÃ§Ã£o do muro - construÃ§Ã£o irregular - RibeirÃ£o da Ilha - FlorianÃ³polis/SC', NULL, '2018-06-07', NULL, NULL, 8, NULL, '2019-06-05 21:05:26', '2019-06-05 21:05:26', 90, 2, 0, NULL, 499),
(519, 1, '0001/2015', '04972.200146/2015-10', 1, '\"Decretar a nulidade do Decreto Legislativo n. 04/89 e do ConvÃªnio firmado entre MunicÃ­pio de Laguna e Ravena Cassino Hotel Ltda, e todos os atos deles decorrentes, especialmente o registro do novo loteamento, voltando ao patrimÃ´nio municipal as Ã¡reas objetos da CessÃ£o sob o Regime de aforamento conforme matrÃ­cula n. 13.204.\"', NULL, '2015-01-09', '2019-06-05', NULL, 18, NULL, '2019-06-05 21:10:48', '2019-06-05 21:10:48', 286, 2, 0, NULL, 498),
(520, 1, '285/2019', '04972.002995/2017-63', 1, 'informaÃ§Ãµes atualizadas quanto ao cumprimento da RecomendaÃ§Ã£o n. 8/2017 (cÃ³pia em anexo), notadamente, se houve instauraÃ§Ã£o de processo administrativo para a retirada dos contÃªineres localizados em terrenos de marinha ou se, em caso negativo,hÃ¡ previsÃ£o para o seu cumprimento', NULL, '2019-05-29', '2019-06-20', NULL, 4, 1, '2019-06-05 21:13:59', '2019-07-01 15:37:55', 65, 2, 0, NULL, 500),
(521, 1, '5554/2018', '04972.200584/2015-70', 1, 'InformaÃ§Ãµes sobre a aprovaÃ§Ã£o e conclusÃ£o do contrato de cessÃ£o da Ã¡rea ocupada pelos cataedores, onde estarÃ£o dispostas as condicionantes indicadas pela FLORAM (Parecer TÃ©cnico nÂ° 424/2018-DlLlC).', NULL, '2018-11-16', '2018-12-14', '2019-07-05 21:09:16', 18, 3, '2019-06-05 21:21:56', '2019-07-05 21:09:17', 95, 3, 1, NULL, 501),
(522, 1, '1933/2017', '04972.007437/2017-94', 1, 'informaÃ§Ã£o sobre a notÃ­cia de construÃ§Ã£o de quiosques em faixa de areia (bem de propriedade da UniÃ£o), nas praias Ervino, ItaguaÃ§u, Praia Grande e Ubatuba em SÃ£o Francisco do Sul/SC', NULL, '2017-10-27', NULL, NULL, 8, NULL, '2019-06-05 21:46:43', '2019-06-05 21:46:43', 85, 2, 0, NULL, 505),
(523, 1, '760/2019', '04972.004000/2019-61', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-05-30', '2019-06-27', NULL, 4, NULL, '2019-06-05 21:57:50', '2019-06-05 21:57:50', 100, 2, 0, NULL, 506),
(524, 1, '515/2018', '04972.003594/2018-10', 1, 'informaÃ§Ãµes acerca da existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o deferida para o referido estabelecimento ou local, bem como vistoria e adoÃ§Ã£o imediata de providÃªncias para a desocupaÃ§Ã£o das Ã¡reas de uso comum e de preservaÃ§Ã£o permanente (restinga) da UniÃ£o.Canasvieiras, FlorianÃ³polis/SC', NULL, '2018-02-20', NULL, NULL, 8, 8, '2019-06-05 22:14:07', '2019-06-05 22:14:49', 86, 2, 0, NULL, 507),
(525, 1, '2693/2015', '04972.201478/2015-11', 1, 'RegularizaÃ§Ã£o cessÃ£o de uso em Santo AntÃ´nio de Lisboa e Sambaqui.', NULL, '2015-04-30', '2019-06-06', NULL, 18, NULL, '2019-06-05 22:35:47', '2019-06-05 22:35:47', 86, 2, 0, NULL, 508),
(526, 1, '4131/2015', '04972.202976/2015-73', 1, 'InformaÃ§Ãµes atualizadas sobre o caso, Obras da Beira-Mar de SÃ£o JosÃ© Trecho Barreiros.', NULL, '2015-06-16', '2019-06-05', NULL, 18, 18, '2019-06-05 22:45:33', '2019-06-05 22:46:28', 90, 2, 0, NULL, 509),
(527, 1, '2440/2014', '04972.011102/2013-47', 1, 'MPF questiona SPU quanto medidas adotadas apÃ³s constataÃ§Ã£o de imÃ³vel inserido em terras de marinha sem registro de inscriÃ§Ã£o de ocupaÃ§Ã£o, em Vila da Gloria - SÃ£o Francisco do Sul.', 'O que Ã©:\r\nMPF questiona SPU quanto medidas adotadas apÃ³s constataÃ§Ã£o de imÃ³vel inserido em terras de marinha sem registro de inscriÃ§Ã£o de ocupaÃ§Ã£o, em Vila da Gloria - SÃ£o Francisco do Sul (O Ãºltimo ofÃ­cio do Pavlov data de 21/09/2014. \r\n\r\nO que foi feito:\r\nfiscalizaÃ§Ã£o e notificaÃ§Ã£o ao interessado\r\n\r\nO que falta:\r\nfinalizar o Despacho DIIUP-SPU-SC (6965921) nÃ£o assinado e adotar as providÃªncias nele mencionadas.\r\nVer com a Flavia', '2014-11-21', '2014-12-01', NULL, 17, 1, '2019-06-05 22:49:17', '2019-08-08 20:21:25', 82, 2, 0, NULL, 510),
(528, 1, '2477/2019', '04972.204130/2015-78', 1, 'InformaÃ§Ãµes atualizadas (posteriores a 4 de janeiro de 2019 - Oficio nÂ° 8105/2019/CODES-SPU-SC/MP) sobre a implantaÃ§Ã£o do empreendimento.', NULL, '2019-06-04', '2019-06-20', '2019-07-15 19:30:34', 18, 4, '2019-06-05 22:57:02', '2019-07-15 19:30:40', 90, 3, 0, NULL, 511),
(529, 1, '3824/2017', '04972.003802/2016-19', 1, 'Solicito seja informado se houve finalizaÃ§Ã£o dos processos nÂ°03120.000157/96-55 e 04972.001632/2014-68, que vem tratando das doaÃ§Ãµes dos imÃ³veis correspondentes Ã s instalaÃ§Ãµes dos complexos das barragens de contenÃ§Ã£o de Ã¡guas nos municÃ­pios de TaiÃ³ c Ituporanga. Em caso negativo, qual o estado atual dos trabalhos?', NULL, '2017-07-04', '2017-08-04', NULL, 18, NULL, '2019-06-05 23:16:48', '2019-06-05 23:16:48', 89, 2, 0, NULL, 513),
(530, 1, '1694/2017', '04972.001915/2019-14', 1, 'informar sobre os procedimentos fiscalizatÃ³rios realizados na Ilha das Claras, na BaÃ­a da Babitonga, em SÃ£o Francisco do Sul', NULL, '2017-09-27', '2017-10-27', '2019-06-11 15:18:56', 1, 3, '2019-06-07 00:49:32', '2019-06-11 15:18:58', 82, 3, 0, NULL, 519),
(531, 1, '2010/2017', '04972.001618/2017-15', 1, 'a adoÃ§Ã£o das providÃªncias administrativas para o cancelamento do RIP nÂ° 8105.00309.000-1 inscrito em favor de Arlindo Isaac da Costa, para o imÃ³vel localizado na ServidÃ£o Ivo D\'Aquino nÂ°133, Ponta da Areia, margens da Lagoa da ConceiÃ§Ã£o (Marina Ponta da Areia Bar e Restaurante) - FlorianÃ³polis/SC', NULL, '2017-04-06', '2016-04-20', NULL, 8, NULL, '2019-06-07 15:18:15', '2019-06-07 15:18:15', 86, 2, 0, NULL, 520),
(532, 1, '11/2019', '04972.000249/2019-05', 1, 'se hÃ¡ interferÃªncia das obras de dragagem realizadas no Rio GravatÃ¡ pela Prefeitura de Navegantes/SC com Ã¡rea da UniÃ£o.', NULL, '2019-01-08', '2019-01-25', '2019-06-19 15:26:51', 8, 4, '2019-06-07 15:31:36', '2019-06-19 16:59:35', 74, 3, 0, NULL, 521),
(533, 1, '8063/2015', '04972.206837/2015-19', 1, 'Cancelamento de Cadastro - RIP 8105.0003562-64 - Lagoa da ConceiÃ§Ã£o - FlorianÃ³polis/SC - ACP 5004722-51.2010.4.04.7200', NULL, '2015-11-30', '2015-12-30', NULL, 8, 8, '2019-06-07 15:44:17', '2019-06-10 15:17:56', 86, 2, 0, NULL, 522),
(534, 1, '5608/2017', '04972.007352/2017-14', 1, 'cancelamento de eventual cadastro - Praia dos Ingleses - ACP 5014640-14.2014.4.04.7200', NULL, '2017-10-17', '2017-10-30', NULL, 8, NULL, '2019-06-07 16:05:47', '2019-06-07 16:05:47', 86, 2, 0, NULL, 525),
(535, 1, '54/2019', '05022.000974/2002-29', 1, 'SOLICITO manifestaÃ§Ã£o acerca da petiÃ§Ã£o do MPF - evento 147 â€“ PARECER1 e a comprovaÃ§Ã£o do cumprimento das obrigaÃ§Ãµes de fazer atinentes ao desapossamento ou ao cadastramento (conforme haja ou nÃ£o vedaÃ§Ã£o ambiental para a construÃ§Ã£o/manutenÃ§Ã£o) de todos os imÃ³veis localizados em terrenos de marinha e acrescidos, abrangidos no Loteamento Praia da Galheta, no BalneÃ¡rio Galheta, em Laguna/SC.', 'null', '2019-02-28', '2019-06-03', '2019-08-23 21:49:33', 17, 4, '2019-06-07 16:08:56', '2019-08-26 15:55:54', 234, 3, 0, NULL, 11),
(536, 1, '1080/2017', '04972.003554/2016-06', 1, 'prestar informaÃ§Ãµes sobre procedimentos fiscalizatÃ³rios na Ilha Redonda - BaÃ­a da Babatonga - SÃ£o Francisco do Sul', 'AtualizaÃ§Ã£o: 09/07/2019\r\nRelatÃ³rio TÃ©cnico de FiscalizaÃ§Ã£o: 25/04/2019\r\nDespacho DIIUP (FiscalizaÃ§Ã£o) 8857990 enviado como resposta ao MPF.\r\nCÃ³pia do InquÃ©rito Civil anexada ao processo.', '2017-07-04', '2017-07-24', '2019-08-19 20:29:16', 1, 1, '2019-06-07 16:09:28', '2019-08-19 20:29:18', 85, 3, 0, NULL, 523),
(537, 1, '299/2002', '05022.001595/2002-56', 1, 'Vistoria no empreendimento CondomÃ­nio Cano de Santa Marta, na localidade da Praia do Cardoso, Laguna/SC para verificar a ocupaÃ§Ã£o de terreno de marinha, e informar da existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o/posse em nome do aludido empreendimento.', NULL, '2002-08-13', '2002-09-13', NULL, 17, NULL, '2019-06-07 17:13:22', '2019-06-07 17:13:22', 287, 2, 0, NULL, 527),
(538, 1, '770/2019', '04972.006656/2016-75', 1, 'InformaÃ§Ãµes sobre a regularizaÃ§Ã£o fundiÃ¡ria objeto deste cumprimento de sentenÃ§a', 'Foram prestadas informaÃ§Ãµes Ã  AGU por meio do OFÃCIO NÂº 53297/2019/DIGES-SPU-SC/MP, datado de 24/07/2019, porÃ©m ainda nÃ£o houve o cumprimento da sentenÃ§a.', '2019-05-31', '2019-05-31', '2019-07-26 17:14:08', 4, 3, '2019-06-07 19:36:06', '2019-08-29 19:16:30', 100, 2, 0, NULL, 528),
(539, 1, '62/2019', '04972.008293/2018-74', 1, 'indicaÃ§Ã£o de assistente tÃ©cnico, bem como a elaboraÃ§Ã£o de seus quesitos', NULL, '2019-01-25', '2019-02-05', '2019-06-07 19:44:26', 4, 4, '2019-06-07 19:41:56', '2019-06-07 19:44:28', 100, 3, 0, NULL, 515),
(540, 1, '1097/2018', '04972.008293/2018-74', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2018-08-20', '2018-09-20', '2019-06-07 19:44:03', 4, 4, '2019-06-07 19:43:34', '2019-06-07 19:44:04', 100, 3, 0, NULL, 515),
(541, 1, '762/2019', '04972.008293/2018-74', 1, 'Esclarecimentos sobre, se houve inscriÃ§Ã£o do nome do autor no CADIN, protesto, Serasa, SPC por esta SuperintendÃªncia e, caso positivo, a quais/valores/taxas/anos correspondem as inscriÃ§Ãµes.', NULL, '2019-05-31', '2019-06-12', '2019-06-19 15:20:11', 4, 4, '2019-06-07 19:46:16', '2019-06-19 17:03:45', 100, 3, 0, NULL, 515),
(542, 1, '756/2019', '04972.006225/2018-71', 1, 'manifestaÃ§Ã£o acerca do laudo pericial', NULL, '2019-05-31', '2019-06-11', '2019-06-25 14:40:19', 4, 4, '2019-06-07 19:54:48', '2019-06-25 20:59:39', 100, 3, 0, NULL, 46),
(543, 1, '754/2019', '50017374320164047210', 1, 'InformaÃ§Ãµes sobre as tratativas legislativas a respeito do caso.', NULL, '2019-05-28', '2019-06-20', '2019-07-11 21:10:55', 4, 3, '2019-06-07 20:03:11', '2019-07-11 21:11:17', 100, 3, 0, NULL, 530),
(544, 1, '720004261602', '04972.010872/2018-87', 1, 'informaÃ§Ãµes sobre os cadastros RIP 8105 0000607-30 e RIP 8105 0002369-51.', NULL, '2018-12-18', '2019-01-10', '2019-06-07 20:05:18', 8, 8, '2019-06-07 20:05:02', '2019-06-07 20:05:20', 177, 3, 0, NULL, 531),
(545, 1, '90/2017', '04972.000524/2017-11', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2017-02-09', '2017-02-16', '2019-06-07 20:13:14', 4, 4, '2019-06-07 20:12:09', '2019-06-07 20:13:17', 119, 3, 0, NULL, 532),
(546, 1, '298/2018', '04972.000524/2017-11', 1, 'Informa a data da perÃ­cia', NULL, '2018-10-04', '2018-10-08', '2019-06-07 20:16:25', 4, 4, '2019-06-07 20:16:03', '2019-06-07 20:16:26', 121, 3, 0, NULL, 532),
(547, 1, '1/2019', '04972.000524/2017-11', 1, 'ManifestaÃ§Ã£o sobre laudo pericial.', NULL, '2019-01-08', '2019-01-21', '2019-06-07 20:19:19', 4, 4, '2019-06-07 20:18:56', '2019-06-07 20:19:20', 228, 3, 0, NULL, 532),
(548, 1, '358/2019', '04972.000524/2017-11', 1, 'anÃ¡lise e manifestaÃ§Ã£o quanto a complementaÃ§Ã£o do laudo pericial', NULL, '2019-05-30', '2019-06-14', '2019-06-17 16:26:51', 4, 4, '2019-06-07 20:20:26', '2019-06-18 21:50:30', 121, 3, 0, NULL, 532),
(549, 1, '295/2019', '04972.004009/2019-71', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-05-29', '2019-06-26', '2019-06-17 22:19:34', 4, 8, '2019-06-07 20:39:54', '2019-06-17 23:11:45', 65, 3, 0, NULL, 517),
(550, 1, '288/2019', '04972.002994/2017-19', 1, 'informe se houve resposta Ã  notificaÃ§Ã£o n. 14/2018, expedida a Ã‰dio Marques da Silva, CPF n. 520.891.779-34, em que se solicitou a desocupaÃ§Ã£o do imÃ³vel por ele construÃ­do em terrenos de marinha e Ã¡rea de preservaÃ§Ã£o permanente, e quais as medidas administrativas tomadas (considerando a resposta ou a inÃ©rcia do requerido) para o caso, notadamente, se houve instauraÃ§Ã£o de processo administrativo visando Ã  retirada do imÃ³vel construÃ­do em Ã¡rea da UniÃ£o.', 'Confirmar se a informaÃ§Ã£o a ser prestada ao MPF pode ser a mesma do OfÃ­cio da APA Baleia Franca (processo da NotificaÃ§Ã£o)', '2019-05-29', '2019-06-18', NULL, 4, 1, '2019-06-07 20:45:47', '2019-09-03 21:02:30', 65, 2, 0, NULL, 463),
(551, 1, '358/2019', '04972.001711/2017-11', 1, 'Informar se o imÃ³vel em questÃ£o encontra-se em Ã¡rea pertencente Ã  UniÃ£o (terreno de marinha) ou se possui alguma influÃªncia com terrenos de marinha', NULL, '2019-04-18', '2019-04-30', '2019-06-19 16:44:28', 8, 4, '2019-06-07 20:53:01', '2019-06-19 16:44:30', 76, 3, 0, NULL, 534),
(552, 1, '115/2019', '04972.008781/2018-81', 1, 'CONCLUA o Processo Administrativo protocolado sob o n. 04972.000232.2009-78.', NULL, '2019-05-31', '2019-07-31', '2019-07-03 20:24:44', 4, 3, '2019-06-07 21:01:02', '2019-07-03 21:59:43', 224, 3, 1, NULL, 433),
(553, 1, '1112/2016', '04972.002646/2019-11', 1, 'solicita informaÃ§Ãµes sobre a regularidade das ocupaÃ§Ãµes na Ilha da Queimada, na BaÃ­a da Babitonga, em SÃ£o Francisco do Sul, alÃ©m de informaÃ§Ãµes sobre a fiscalizaÃ§Ã£o na Ã¡rea.', NULL, '2016-06-03', '2016-09-03', '2019-06-11 15:29:22', 1, 3, '2019-06-07 22:06:26', '2019-06-11 15:29:23', 82, 3, 0, NULL, 535),
(554, 1, '1694/2017', '04972.001917/2019-11', 1, 'informar sobre procedimentos fiscalizatÃ³rios na Ilha das Flores, na BaÃ­a da Babitonga, em SÃ£o Francisco do Sul', 'Resposta enviada', '2017-09-15', '2017-10-15', '2019-07-12 15:50:14', 1, 1, '2019-06-07 22:15:07', '2019-07-12 15:50:27', 82, 3, 0, NULL, 536),
(555, 1, '1694/2017', '04972.001919/2019-01', 1, 'prestar informaÃ§Ãµes sobre fiscalizaÃ§Ã£o da Ilha do Corisco, BaÃ­a da Babitonga, SÃ£o Francisco do Sul', 'O que Ã©: prestar informaÃ§Ãµes sobre fiscalizaÃ§Ã£o da Ilha do Corisco, BaÃ­a da Babitonga, SÃ£o Francisco do Sul\r\n\r\nO que foi feito: RelatÃ³rio TÃ©cnico DIIU`-SPU-SC 8646361\r\n\r\n- O que falta:\r\n1) Monitorar processo de notificaÃ§Ã£o (solicitaÃ§Ã£o da regularizaÃ§Ã£o pelo particular ou aplicaÃ§Ã£o da multa).\r\n\r\nAnalisado pela NUJUC em 19/08/2019.', '2017-09-27', '2017-10-27', '2019-08-19 16:11:21', 1, 1, '2019-06-07 22:31:15', '2019-08-19 16:11:22', 82, 3, 0, NULL, 400),
(556, 1, '1694/2017', '04972.002648/2019-01', 1, 'informar sobre os procedimentos fiscalizatÃ³rios na Ilha dos Barcos - BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'O que Ã©: Trata-se do OfÃ­cio 489/2019 (04972.004280/2016-64), pelo qual o MPF solicita informar sobre a regularidade das ocupaÃ§Ãµes na Ilha dos Barcos - BaÃ­a da Babitonga - SÃ£o Francisco do Sul <br><br>\r\nO que foi feito: nÃ£o foi possÃ­vel a fiscalizaÃ§Ã£o na Ilha dos Barcos, devido Ã  sua localizaÃ§Ã£o e condiÃ§Ãµes meteorolÃ³gicas, por questÃ£o de seguranÃ§a, conforme decidido pela equipe da Capitania dos Portos. NÃ£o localizamos inscriÃ§Ã£o de ocupaÃ§Ã£o em nome de Nivaldo Marques, CPF 055.150.099-91, ocupante atual apontado no Laudo TÃ©cnico do IBAMA nÂº 1/2019-NUBIO-SC/DITEC-SC/SUPES-SC.<br><br>\r\nO que falta fazer: Vistoria reprogramada para o perÃ­odo de 07 a 11 de outubro de 2019.', '2017-09-27', '2017-10-27', NULL, 1, 1, '2019-06-07 22:38:25', '2019-07-12 20:19:03', 82, 2, 0, NULL, 21),
(557, 1, '403/2016', '04972.207095/2015-49', 1, 'informaÃ§Ãµes sobre qual o posicionamento da SPU em relaÃ§Ã£o Ã s solicitaÃ§Ãµes encaminhadas pelo MinistÃ©rio PÃºblico Federal, por meio do OfÃ­cio nÂ° 497/2015 - RBM (cÃ³pia em anexo), de 10 de setembro de 2015, referentes Ã  Comunidade Tradicional de Pescadores da Vila do AraÃ§Ã¡, Porto Belo/SC.', NULL, '2016-08-05', '2016-08-15', NULL, 8, NULL, '2019-06-10 15:11:45', '2019-06-10 15:11:45', 62, 2, 0, NULL, 537),
(558, 1, '8075/2015', '04972.207057/2015-96', 1, 'regularidade cadastral - cumprimento de sentenÃ§a - Lagoa da ConceiÃ§Ã£o - FlorianÃ³polis/SC - AÃ§Ã£o Civil PÃºblica 5004772-51.2010.404.7200', NULL, '2015-04-30', '2015-05-30', NULL, 8, NULL, '2019-06-10 15:21:07', '2019-06-10 15:21:07', 86, 2, 0, NULL, 522),
(559, 1, '2056/2019', '04972.206933/2015-67', 1, 'informaÃ§Ãµes sobre a regularizaÃ§Ã£o da situaÃ§Ã£o de Rancho de Pescadores na Prainha - FlorianÃ³polis/SC', NULL, '2019-05-10', '2019-06-10', '2019-07-31 20:13:36', 8, 1, '2019-06-10 15:26:51', '2019-07-31 20:13:40', 89, 3, 0, NULL, 538),
(560, 1, '494/2015', '04972.206074/2015-14', 1, 'Cancelamento Ilha JoÃ£o Cunha - Porto Belo/SC', NULL, '2015-12-11', '2016-01-10', NULL, 8, NULL, '2019-06-10 16:13:45', '2019-06-10 16:13:45', 80, 2, 0, NULL, 540),
(561, 1, '6630/2015', '04972.205830/2015-80', 1, 'informaÃ§Ãµes sobre regularidade cadastral dos imÃ³veis em APPs de BiguaÃ§u/SC', NULL, '2015-09-30', '2015-10-30', NULL, 8, NULL, '2019-06-10 16:29:25', '2019-06-10 16:29:25', 90, 2, 0, NULL, 541),
(562, 1, '6039/2015', '04972.205388/2015-91', 1, 'informaÃ§Ãµes sobre a regularidade cadastral dos imÃ³veis localizados na orla de Coqueiros - FlorianÃ³polis/SC', NULL, '2015-09-08', '2015-12-10', NULL, 8, NULL, '2019-06-10 16:59:07', '2019-06-10 16:59:07', 90, 2, 0, NULL, 542),
(563, 1, '873/2019', '04972.002471/2017-72', 1, 'ManifestaÃ§Ã£o sobre laudo Pericial', NULL, '2019-06-03', '2019-06-21', '2019-06-17 16:20:39', 4, 4, '2019-06-10 17:22:18', '2019-06-18 21:42:49', 126, 3, 0, NULL, 543),
(564, 1, '441/2019', '04972.004073/2019-52', 1, 'informe se a Ã¡rea compreendida na coordenada geogrÃ¡fica 27Âº 00\" 41.8\"\"S 48Âº 34\"46.1 \"W, e/ou endereÃ§o Rua JacarandÃ¡, n. 35, Taquaras, BalneÃ¡rio CamboriÃº/SC, que se refere ao objeto do procedimento em epÃ­grafe, possui Registro ImobiliÃ¡rio Patrimonial (RIP) em nome de ClÃ¡udio Roberto Fernandez Molina (CPF: 008.961.379-10) ou outro tÃ­tulo autorizativo para a ocupaÃ§Ã£o do imÃ³vel que se encontra em Ã¡rea de marinha.', NULL, '2019-06-03', '2019-06-17', '2019-06-12 19:21:44', 4, 4, '2019-06-10 19:29:07', '2019-06-18 20:57:44', 74, 3, 0, NULL, 544),
(565, 1, '116/2019', '04972.007475/2017-47', 1, 'InformaÃ§Ãµes sobre a conversÃ£o em renda', 'Aguardando providÃªncias da AGU/JuÃ­zo junto a CEF para finalizaÃ§Ã£o do procedimento de conversÃ£o em renda', '2019-06-03', '2019-06-17', NULL, 4, 1, '2019-06-10 20:09:54', '2019-07-05 20:37:42', 224, 2, 0, NULL, 545),
(566, 1, '617/2019', '04972.004076/2019-96', 1, 'solicitando-se seja realizada a fiscalizaÃ§Ã£o de Ã¡rea de domÃ­nio da UniÃ£o, a fim de constatar a invasÃ£o da mesma e emissÃ£o de informaÃ§Ã£o tÃ©cnica.', NULL, '2019-06-07', '2019-06-21', '2019-09-03 16:34:18', 4, 3, '2019-06-10 20:51:03', '2019-09-03 16:34:18', 289, 7, 0, NULL, 546),
(567, 1, '5936/2015', '04972.205283/2015-32', 1, 'InformaÃ§Ãµes atualizadas sobre as providÃªncias que a SPU/SC adotou para as edificaÃ§Ãµes feitas em APPs e em bens da UniÃ£o na localidade do PÃ¢ntano do Sul em FlorianÃ³polis/SC', NULL, '2015-09-01', '2015-09-30', '2019-06-10 21:09:26', 8, 8, '2019-06-10 21:09:09', '2019-06-10 21:09:27', 90, 3, 0, NULL, 547),
(568, 1, '477/2017', '04972.004188/2017-85', 1, 'adoÃ§Ã£o de eventual medida considerada adequada Ã  defesa do patrimÃ´nio da UniÃ£o, utilizaÃ§Ã£o de faixa de areia - Praia da ArmaÃ§Ã£o - Penha/SC-', NULL, '2017-07-04', '2017-08-04', NULL, 8, NULL, '2019-06-10 21:34:33', '2019-06-10 21:34:33', 74, 2, 0, NULL, 548),
(569, 1, '363/2019', '04972.004078/2019-85', 1, 'informar se a vistoria foi realizada, se o imÃ³vel foi desocupado e reintegraÃ§Ã£o', NULL, '2019-06-03', '2019-06-25', NULL, 4, NULL, '2019-06-10 21:53:27', '2019-06-10 21:53:27', 121, 2, 0, NULL, 549),
(570, 1, '119/2019', '04972.202638/2015-31', 1, 'ENCAMINHA PARECER DE FORÃ‡A EXECUTÃ“RIA. ISENÃ‡ÃƒO DE TAXA DE OCUPAÃ‡ÃƒO\nE DECLARAÃ‡ÃƒO JUDICIAL DE ISENÃ‡ÃƒO', NULL, '2019-06-04', NULL, '2019-08-20 22:08:30', 4, 3, '2019-06-11 16:52:23', '2019-08-20 22:32:52', 224, 3, 0, NULL, 551),
(571, 1, '1311/2019', '04972.002880/2013-45', 1, 'Considerando a informaÃ§Ã£o recebida de construÃ§Ã£o em Ã¡rea de marinha, especificamente na Praia do Antenor, na Ilha de Anhatomirim, municÃ­pio de Governador Celso Ramos, neste Estado, solicito a Vossa Senhoria informar acerca da: 1) existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o de terrenos de marinha relativa ao local onde situado o Restaurante SPADART, edificado no entorno das coordenadas UTM 22 J 739783 6963991 na ponta oeste da localidade da praia do Antenor; 2) existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o de terrenos de marinha em nome de SÃ©rgio de Souza ou Antenor JÃºlio de Souza na localidade indicada.', NULL, '2019-03-18', '2019-04-19', NULL, 17, 17, '2019-06-11 17:10:02', '2019-06-11 17:15:44', 89, 2, 0, NULL, 552),
(572, 1, '118/2019', '10154.105642/2019-12', 1, 'Encaminha Parecer de ForÃ§a ExecutÃ³ria', 'ElaboraÃ§Ã£o de PRAD - UniÃ£o subsidiÃ¡ria.\nNÃ£o conceder e invalidar eventuais licenÃ§as, autorizaÃ§Ãµes, inscriÃ§Ã£o de ocupaÃ§Ã£o que tenha sido emitida em proveito do empreendimento sub judice.\nMulta diÃ¡ria no valor de R$ 1.000,00', '2019-06-04', NULL, NULL, 4, 8, '2019-06-11 17:28:04', '2019-07-08 20:26:59', 224, 2, 1, NULL, 553),
(573, 1, '370/2019', '04972.004087/2019-76', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-04', '2019-07-02', '2019-07-11 22:14:49', 4, 4, '2019-06-11 19:31:33', '2019-07-12 17:09:10', 121, 3, 0, NULL, 555),
(574, 1, '1030/2018', '04972.004144/2017-55', 1, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', NULL, '2018-05-10', '2018-05-15', '2019-06-11 19:44:05', 4, 4, '2019-06-11 19:43:42', '2019-06-11 19:44:06', 114, 3, 0, NULL, 556),
(575, 1, '885/2019', '04972.004144/2017-55', 1, 'Informa a data da PerÃ­cia.', NULL, '2019-06-04', NULL, '2019-06-11 19:45:21', 4, 4, '2019-06-11 19:45:04', '2019-06-11 19:45:23', 114, 3, 0, NULL, 556),
(576, 1, '117/2019', '04972.005520/2018-18', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-04', '2019-07-03', '2019-07-12 20:46:34', 4, 4, '2019-06-11 20:08:48', '2019-07-12 20:46:40', 224, 3, 0, NULL, 557),
(577, 4, '0832/2014', '04972.011748/2014-13', 1, 'InquÃ©rito Policial referente a degradaÃ§Ã£o ambiental na margem do Rio da VovÃ³ - Porto Belo. MPSC solicita informaÃ§Ãµes sobre possÃ­vel caracterizaÃ§Ã£o de Ã¡rea de marinha, bem como informar sobre demarcaÃ§Ã£o da Ã¡rea.', NULL, '2014-12-11', '2014-12-26', NULL, 17, 17, '2019-06-11 20:29:54', '2019-06-11 20:30:47', 174, 2, 0, NULL, 558),
(578, 1, '448/2016', '04972.001847/2016-41', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2016-02-15', '2016-02-25', '2019-06-11 20:47:57', 4, 4, '2019-06-11 20:47:39', '2019-06-11 20:47:58', 113, 3, 0, NULL, 560),
(579, 1, '884/2019', '04972.001847/2016-41', 1, 'Informa a data da realizaÃ§Ã£o da vistoria tÃ©cnica.', NULL, '2019-06-04', NULL, '2019-06-11 20:55:41', 4, 4, '2019-06-11 20:53:08', '2019-06-11 20:55:43', 114, 3, 0, NULL, 560),
(580, 1, '066/2016', '04972.001930/2016-10', 1, 'Referente Ã  InquÃ©rito Civil, MPF requisita informar acerca da regularidade da ocupaÃ§Ã£o do imÃ³vel em que funciona o bar Sabor do Mar, na praia da Sepultura, MunicÃ­pio de Bombinhas.', NULL, '2016-02-16', '2016-02-26', NULL, 17, 17, '2019-06-11 21:34:21', '2019-06-11 21:35:00', 62, 2, 0, NULL, 562),
(581, 1, '036/2016', '04972.000866/2016-50', 1, 'MPF solicita seja iniciado procedimento de cancelamento da inscriÃ§Ã£o de ocupaÃ§Ã£o referente ao RIP 8265.0000770-04 em nome de Marinas Porto Belo Resort Hotel S/A. Posteriormente reitera solicitaÃ§Ã£o em OfÃ­cio 282/2016 (1945812), e novamente OfÃ­cio 402/2016 (2274086).', NULL, '2016-01-19', NULL, NULL, 17, 17, '2019-06-11 22:03:03', '2019-06-11 22:14:36', 80, 2, 0, NULL, 564),
(582, 1, '708/2019', '04972.005760/2011-38', 1, 'InformaÃ§Ãµes atualizadas', 'Reiterado em 15/07/2019. \r\nReiterado novamente em 24/07/2019', '2019-06-05', '2019-07-02', '2019-08-08 21:02:53', 4, 4, '2019-06-11 22:04:50', '2019-08-22 15:42:20', 56, 3, 0, NULL, 566),
(583, 1, '4191/2018', '04972.206931/2015-78', 1, 'InformaÃ§Ãµes quanto a regularizaÃ§Ã£o do imÃ³vel do Projeto SESC-LER, Bairro da PraÃ§a, Tijucas/SC.', NULL, '2018-08-29', '2018-09-29', NULL, 17, 17, '2019-06-11 22:30:38', '2019-06-11 22:32:38', 89, 2, 0, NULL, 567),
(584, 1, '362/2019', '04972.004096/2019-67', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-06-05', '2019-06-28', '2019-07-15 16:54:30', 4, 4, '2019-06-12 19:39:00', '2019-07-15 16:54:31', 99, 3, 0, NULL, 568),
(585, 1, '704/2019', '04972.004104/2019-75', 1, 'informe se hÃ¡ procedimento extrajudicial em curso relativo ao imÃ³vel em questÃ£o em que figure como interessada VergÃ­nia Neves Leopoldo, CPF n. 704.696.959-00, ou outra pessoa.', NULL, '2019-06-05', '2019-06-28', '2019-07-02 22:16:23', 4, 3, '2019-06-12 20:15:09', '2019-08-02 20:34:49', 56, 3, 0, NULL, 569),
(586, 1, '4507/2017', '04972.206929/2015-07', 1, 'Que informe quais as medidas serÃ£o adotadas face a nÃ£o apresentaÃ§Ã£o dos documentos requisitados aos detentores dos Ranchos de Pescadores nÂ° 04 (04972.001566/2016-98 - Luiz Carlos Costa), 06 (04972.001573/2016-90 - Ademir da ConceiÃ§Ã£o) e 09 (04972.001574/2016-34 - EdilmÃ¡rio Flor da Silva). Qual o procedimento adolado pela SPU nestes casos?', NULL, '2017-08-24', '2017-09-24', NULL, 17, 17, '2019-06-12 20:17:07', '2019-06-12 20:25:42', 89, 2, 0, NULL, 570),
(587, 1, '794/2019', '04972.001336/2017-18', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos', NULL, '2019-06-28', '2019-06-28', '2019-06-24 20:47:34', 4, 4, '2019-06-12 20:57:53', '2019-06-25 17:12:30', 100, 3, 0, NULL, 571),
(588, 1, '786/2019', '04972.008547/2017-73', 1, 'Assistente tÃ©cnico e quesitos', NULL, '2019-06-06', '2019-06-28', '2019-06-25 14:52:04', 4, 4, '2019-06-12 21:12:25', '2019-06-26 16:26:46', 100, 3, 0, NULL, 12),
(589, 1, '156/2019', '04972.006430/2017-55', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2017-09-20', '2017-10-04', '2019-06-13 16:49:20', 4, 4, '2019-06-13 16:49:00', '2019-06-13 16:49:22', 109, 3, 0, NULL, 572),
(590, 1, '774/2019', '04972.006430/2017-55', 1, 'Informa o trÃ¢nsito em julgado favorÃ¡vel Ã  UniÃ£o.', NULL, '2019-06-06', NULL, '2019-06-13 16:51:28', 4, 4, '2019-06-13 16:51:10', '2019-06-13 16:51:31', 100, 3, 0, NULL, 572),
(591, 1, '913/2019', '04972.008984/2018-78', 1, 'Informa que o perito judicial agendou o dia 25/07/2019, Ã s 10h00min (tendo como ponto de encontro o imÃ³vel objeto da lide) para realizaÃ§Ã£o de diligÃªncia no local a ser periciado.', NULL, '2019-06-07', NULL, '2019-06-13 17:11:19', 4, 4, '2019-06-13 17:11:00', '2019-06-13 17:11:20', 126, 3, 0, NULL, 276),
(592, 1, '838/2019', '04972.001778/2019-18', 1, 'manifeste no sentido de explicitar se hÃ¡ ou nÃ£o interferÃªncia da Ã¡rea usucapienda', NULL, '2019-05-27', '2019-06-13', '2019-06-17 16:16:18', 8, 4, '2019-06-13 21:13:24', '2019-06-18 21:45:23', 126, 3, 0, NULL, 574),
(593, 1, '1605/2019', '04972.010857/2018-39', 1, 'Informa a data da perÃ­cia.', NULL, '2018-12-12', NULL, '2019-06-13 21:13:41', 4, 4, '2019-06-13 21:13:25', '2019-06-13 21:13:43', 100, 3, 0, NULL, 573),
(594, 1, '374/2019', '04972.010857/2018-39', 1, 'ManifestaÃ§Ã£o sobre laudo pericial', NULL, '2019-06-07', '2019-06-25', '2019-06-19 15:19:04', 4, 4, '2019-06-13 21:17:14', '2019-06-21 20:54:31', 99, 3, 0, NULL, 573),
(595, 1, '2680/2018', '04972.009324/2018-12', 1, 'remete parecer de forÃ§a executÃ³ria - APPs - ZONA COSTEIRA DA ARMAÃ‡ÃƒO E DA ARMAÃ‡ÃƒO DO PÃ‚NTANO DO SUL - FlorianÃ³polis/SC.', NULL, '2018-12-17', NULL, '2019-06-19 16:29:25', 8, 4, '2019-06-14 17:17:08', '2019-06-19 16:29:27', 234, 3, 1, NULL, 575),
(596, 1, '120/2019', '10154.100708/2019-88', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-10', '2019-07-10', '2019-07-12 15:01:35', 4, 4, '2019-06-17 16:27:34', '2019-07-15 20:15:20', 224, 3, 0, NULL, 576),
(597, 1, '922/2019', '04972.010856/2018-94', 1, 'Informa a data de audiÃªncia de conciliaÃ§Ã£o : 25/06/2019.', NULL, '2019-06-10', NULL, NULL, 4, 4, '2019-06-17 17:00:59', '2019-06-17 17:01:45', 114, 2, 0, NULL, 577),
(598, 1, '378/2019', '04972.006723/2018-13', 1, 'Solicito informaÃ§Ãµes, em especial sobre eventuais repasses de verbas federais ao Estado de Santa Catarina, para cumprimento das obrigaÃ§Ãµes de fazer impostas na sentenÃ§a judicial, a fim de subsidiar a defesa da UniÃ£o.', NULL, '2019-06-10', '2019-06-21', NULL, 4, NULL, '2019-06-17 17:26:48', '2019-06-17 17:26:48', 99, 2, 0, NULL, 578),
(599, 1, '47982/2019', '04972.004088/2019-11', 1, 'Cumprimento de DecisÃ£o Liminar.', NULL, '2019-06-11', '2019-06-17', '2019-06-18 22:01:51', 4, 4, '2019-06-17 20:07:14', '2019-06-18 22:01:52', 290, 3, 0, NULL, 579),
(600, 1, '821/2019', '10154.100767/2019-56', 1, 'SubsÃ­dios Ã  defesa da UniÃ£o.', NULL, '2019-06-10', '2019-07-10', '2019-07-16 15:54:42', 4, 4, '2019-06-17 20:20:55', '2019-07-17 16:55:46', 100, 3, 0, NULL, 580),
(601, 1, '391/2015', '04972.206216/2015-35', 1, 'Adote as medidas necessÃ¡rias com vistas Ã  demoliÃ§Ã£o do imÃ³vel questÃ£o. ACP para retirada da obra construida, recuperaÃ§Ã£o de Ã¡rea degradada, e indenizaÃ§Ã£o por danos ao meio ambiente em APP, em Ã¡rea da uniÃ£o. Bairro AraÃ§Ã¡, Porto Belo/SC.', NULL, '2015-10-23', '2015-12-23', NULL, 17, 17, '2019-06-17 20:57:37', '2019-06-17 21:21:24', 80, 2, 0, NULL, 581),
(602, 1, '186/2019', '04972.206605/2015-61', 1, 'Informa o arquivamento do inquÃ©rito.', NULL, '2019-06-10', NULL, NULL, 4, NULL, '2019-06-17 21:20:10', '2019-06-17 21:20:10', 103, 2, 0, NULL, 15),
(603, 1, '926/2019', '04972.002069/2019-50', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-11', '2019-06-21', '2019-06-19 15:10:03', 4, 4, '2019-06-17 21:55:31', '2019-06-19 16:53:55', 114, 3, 0, NULL, 583),
(604, 1, '1956/2015', '04972.205720/2015-18', 1, 'Informar se Rio do BraÃ§o, localizado na regiÃ£o nordeste do Estado de Santa Catarina, Ã© um rio federal.', NULL, '2015-09-01', '2015-09-11', NULL, 17, 17, '2019-06-17 22:10:49', '2019-06-17 22:12:14', 83, 2, 0, NULL, 584),
(605, 1, '686/2016', '04972.203446/2015-42', 1, 'identificaÃ§Ã£o dos proprietÃ¡rios dos imÃ³veis localizados em Ã¡rea de praia no MunicÃ­pio de ItapoÃ¡, referente Ã s ocupaÃ§Ãµes irregulares Ã  margem da lagoa de Barra Velha.', NULL, '2016-05-12', '2016-05-22', NULL, 17, 17, '2019-06-17 22:23:40', '2019-06-17 22:24:35', 85, 2, 0, NULL, 585),
(606, 1, '860/2016', '04972.006318/2016-33', 1, 'Informe se hÃ¡ (ou houve) processo de regularizaÃ§Ã£o de um aterro e construÃ§Ã£o Ã  beira da Lagoa de Santa Marta Pequena, em Laguna, em nome de Rosane Tasca, CPF n. 437.769.579-72. Segue em anexo cÃ³pia o RVA n. 038/2015 para orientÃ¡-los em relaÃ§Ã£o ao local dos fatos.', NULL, '2016-11-03', NULL, NULL, 18, 18, '2019-06-17 23:06:21', '2019-06-17 23:07:05', 72, 2, 0, NULL, 586),
(607, 1, '155/2017', '04972.000874/2017-87', 1, 'ManifestaÃ§Ã£ sobre a regularidade de todas as ocupaÃ§Ãµes (nÃ£o somente ao restaurante) por CÃ©lio Damiani, na localidade da Ponta da Barra, em Laguna.', NULL, '2017-02-20', NULL, NULL, 18, NULL, '2019-06-17 23:20:34', '2019-06-17 23:20:34', 73, 2, 0, NULL, 587),
(608, 1, '122/2019', '04972.002721/2017-74', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-11', '2019-07-11', '2019-07-11 22:02:34', 4, 4, '2019-06-18 16:14:33', '2019-07-15 20:50:17', 224, 3, 0, NULL, 588),
(609, 1, '121/2019', '10154.100935/2019-11', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-11', '2019-07-11', '2019-07-17 15:39:21', 4, 3, '2019-06-18 16:44:59', '2019-07-17 15:39:24', 224, 3, 0, NULL, 589),
(610, 1, '931/2019', '10154.100949/2019-27', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-06-11', '2019-06-25', '2019-06-25 16:34:57', 4, 4, '2019-06-18 17:38:20', '2019-06-27 23:25:14', 126, 3, 0, NULL, 590),
(611, 1, '312/2019', '04972.201718/2015-70', 1, 'InformaÃ§Ãµes atualizadas sobre o andamento do processo administrativo n. 04972.003364/2018-42.', NULL, '2019-06-11', '2019-07-08', '2019-08-06 15:46:34', 4, 3, '2019-06-18 19:48:58', '2019-08-06 15:46:38', 65, 3, 0, NULL, 591),
(612, 1, '124/2019', '04972.007147/2017-41', 1, 'Informa a data da perÃ­cia.', NULL, '2019-06-12', NULL, '2019-06-18 20:07:55', 4, 4, '2019-06-18 20:07:36', '2019-06-18 20:07:56', 224, 3, 0, NULL, 592),
(613, 1, '123/2019', '10154.100998/2019-60', 1, 'Encaminha Parecer de ForÃ§a ExecutÃ³ria.', NULL, '2019-06-12', NULL, '2019-06-28 21:01:24', 4, 8, '2019-06-18 20:52:56', '2019-06-28 21:01:25', 224, 3, 0, NULL, 593),
(614, 1, '623/2017', '04972.001737/2017-60', 1, 'O MinistÃ©rio PÃºblico Federal, com fundamento no arÃ­. 8Â°, inciso II, da Lei Complementar nÂ° 75/93, requisita a Vossa Senhoria que informe se o imÃ³vel\r\nobjeto dos autos epigrafados estÃ¡ regularizado em face de UniÃ£o. ImÃ³vel extinta RFFSA.', NULL, '2017-04-19', NULL, NULL, 18, 18, '2019-06-18 21:08:41', '2019-06-18 21:09:10', 76, 2, 0, NULL, 594),
(615, 1, '377/2015', '04972.203391/2015-71', 1, 'Encaminhar ao MPF relatÃ³rio e demais documentos comprobatÃ³rios de vistoria in loco.', NULL, '2015-10-07', '2015-11-03', NULL, 17, 17, '2019-06-18 22:02:53', '2019-06-18 22:04:26', 80, 2, 0, NULL, 598),
(616, 1, '4197/2018', '04972.005251/2017-09', 1, 'informaÃ§Ãµes atualizadas sobre ranchos de pesca situados Ã s margens do Rio AririÃº, no final da Rua OtÃ¡vio Garcia, no MunicÃ­pio de PalhoÃ§a e, em especial, o penÃºltimo rancho de pesca que, supostamente, estÃ¡ sendo reformado em alvenaria com ampliaÃ§Ã£o mediante aterro em Ã¡rea de mangue, conforme documentos anexos.', NULL, '2018-09-03', '2018-09-23', NULL, 17, 17, '2019-06-18 22:54:31', '2019-06-18 22:55:05', 95, 2, 0, NULL, 599),
(617, 1, '720004787882', '10154.101026/2019-92', 1, 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, '2019-06-17', NULL, '2019-06-25 19:56:00', 8, 8, '2019-06-19 15:01:41', '2019-06-25 19:56:09', 240, 3, 1, NULL, 601),
(618, 1, '0803/2019', '04972.000288/2019-02', 1, 'apresentar a planta/mapa a que alude o Parecer TÃ©cnico - NÂº 8248829, anteriormente enviado Ã  PSU de Joinville.', NULL, '2019-06-05', '2019-06-28', '2019-06-24 22:54:13', 8, 4, '2019-06-19 20:19:17', '2019-06-24 22:54:16', 100, 3, 0, NULL, 602),
(619, 1, '852/2019', '10154.101176/2019-04', 0, 'Encaminha o PARECER DE FORÃ‡A EXECUTÃ“RIA n.00083/2019/PSUCCO/PGU/AGU, atestando e que os pedidos formulados na aÃ§Ã£o foram julgados parcialmente procedentes para reconhecer a invalidade da intimaÃ§Ã£o editalÃ­cia de interessado certo e com endereÃ§o conhecido, como no caso dos autos e, excluir o pagamento das taxas de ocupaÃ§Ã£o do imÃ³vel cadastrado no RIP 55370000076-66', '09/07/2019 - Encaminhado Ã  NUREP para cancelar os dÃ©bitos e a NUCIP para cancelamento do cadastro e promoÃ§Ã£o do cumprimento integral dos termos da sentenÃ§a em relaÃ§Ã£o Ã  nova demarcaÃ§Ã£o e ao novo cadastramento.', '2019-06-12', NULL, '2019-06-28 20:59:43', 4, 3, '2019-06-19 20:22:14', '2019-07-09 20:52:02', 100, 2, 1, NULL, 603),
(620, 1, '851/2019', '10154.101182/2019-53', 0, 'Encaminha o o PARECER DE FORÃ‡A EXECUTÃ“RIA n.00082/2019/PSUCCO/PGU/AGU, atestando nÃ£o haver Ã³bices Ã  cobranÃ§a da taxa de ocupaÃ§Ã£o pela UniÃ£o (SPU) nos moldes calculados no ano de\n2007.', NULL, '2019-06-12', NULL, '2019-06-28 20:56:41', 4, 8, '2019-06-19 20:36:42', '2019-06-28 20:56:46', 100, 3, 0, NULL, 604),
(621, 1, '943/2019', '04972.002550/2018-64', 1, 'Informa que foi proferida SentenÃ§a de parcial procedÃªncia, jÃ¡ transitada em julgado, que deferiu o pedido do autor tÃ£o somente Ã  Ã¡rea alodial.', 'Fazer encaminhamento conforme documento 3437714', '2019-06-13', NULL, '2019-09-03 21:41:44', 4, 1, '2019-06-19 21:05:01', '2019-09-03 21:41:45', 114, 3, 0, NULL, 605),
(622, 1, '190/2019', '04972.006305/2016-64', 1, 'Informa o ajuizamento da aÃ§Ã£o de suscitaÃ§Ã£o de dÃºvida.', NULL, '2019-06-13', NULL, NULL, 4, NULL, '2019-06-19 21:50:40', '2019-06-19 21:50:40', 103, 1, 0, NULL, 606),
(623, 1, '126/2019', '10154.101221/2019-12', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-06-14', '2019-06-28', '2019-06-24 21:13:06', 4, 8, '2019-06-19 22:21:06', '2019-08-08 17:14:59', 224, 3, 0, NULL, 607),
(624, 1, '0015/2018', '04972.001850/2004-21', 1, 'Cancelamento do RIP: 8179.0002766- 04', NULL, '2018-01-11', NULL, '2019-06-21 15:12:03', 8, 8, '2019-06-21 15:11:49', '2019-06-21 15:12:04', 201, 3, 1, NULL, 608),
(625, 1, '91/2016', '04972.003054/2016-66', 1, 'regularidade obras no municÃ­pio de Penha/SC', NULL, '2016-04-18', '2019-07-30', NULL, 8, NULL, '2019-06-21 15:56:21', '2019-06-21 15:56:21', 60, 2, 0, NULL, 609),
(626, 1, '2577/2019', '10154.100925/2019-78', 0, 'informaÃ§Ãµes sobre a regularidade da ocupaÃ§Ã£o do terreno de marinha situado na Rodovia SC 401, n. 5309, Distrito de Santo AntÃ´nio de Lisboa prÃ³ximo ao Trevo de CacupÃ© - FlorianÃ³polis/SC', 'null', '2018-06-13', '2019-07-15', '2019-07-22 18:55:39', 8, 4, '2019-06-21 16:43:54', '2019-07-22 18:55:41', 95, 3, 0, NULL, 610),
(627, 1, '422/2019', '10154.100979/2019-33', 1, 'o cumprimento da sentenÃ§a de declarou que nÃ£o hÃ¡ relaÃ§Ã£o jurÃ­dica que obrigue o autor a pagar Ã  UniÃ£o laudÃªmio e taxa de ocupaÃ§Ã£o relacionados aos imÃ³veis cadastrados no PatrimÃ´nio da UniÃ£o, sob os RIP\'s de nÃºmeros 8041 0000325-07 e 8041 0000350-18 (objetos das matrÃ­culas 5.547 e 5.548 do Registro de ImÃ³veis da 2\" CircunscriÃ§Ã£o de SÃ£o Francisco do Sul).', NULL, '2019-06-17', NULL, '2019-06-28 21:03:34', 8, 8, '2019-06-21 17:05:30', '2019-06-28 21:03:40', 20, 3, 1, NULL, 611),
(628, 1, '946/2019', '00730350320088240023', 1, 'Informa SentenÃ§a de parcial procedÃªncia, jÃ¡ transitada em julgado, que deferiu o pedido do autor tÃ£o somente Ã  Ã¡rea alodial.', NULL, '2019-06-14', NULL, '2019-06-27 19:51:59', 4, 8, '2019-06-21 19:17:18', '2019-06-27 19:52:05', 114, 3, 0, NULL, 612),
(629, 1, '950/2019', '04972.006867/2018-70', 1, 'Resposta a e-mail', NULL, '2019-06-14', NULL, '2019-07-16 21:10:47', 4, 4, '2019-06-21 19:34:21', '2019-07-16 21:10:49', 126, 3, 0, NULL, 326);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `seiMP`, `demanda`, `resumoSituacao`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(630, 1, '127/2019', '00040854220138240030', 1, 'ManifestaÃ§Ã£o de Interesse', NULL, '2019-06-17', '2019-07-02', '2019-07-12 20:35:35', 4, 4, '2019-06-21 19:43:44', '2019-07-15 19:40:44', 224, 3, 0, NULL, 613),
(631, 1, '861/2016', '04972.002196/2016-14', 1, 'Recomenda que seja executada a sentenÃ§a da aÃ§Ã£o, especialmente em relaÃ§Ã£o ao cancelamento das inscriÃ§Ãµes de ocupaÃ§Ã£o localizadas na praia da ArmaÃ§Ã£o do PÃ¢ntano do Sul - FlorianÃ³polis/SC', 'O OfÃ­cio do MPF de marÃ§o de 2016 - A LPM nÃ£o Ã© homologada no local. NÃ£o consta atendimento. Em 5/07/2019, foi encaminhada consulta Ã  AGU solicitando a situaÃ§Ã£o atualizada da aÃ§Ã£o 5008067-23.2015.4.04.7200 e, se for o caso, o Parecer de ForÃ§a ExecutÃ³ria.', '2016-03-01', NULL, NULL, 8, 3, '2019-06-21 20:09:53', '2019-07-05 20:32:18', 86, 2, 1, NULL, 614),
(632, 1, '260/2017', '04972.002310/2016-06', 1, 'que informe quais foram as providÃªncias adotadas, no Ã¢mbito de seu poder-dever de polÃ­cia administrativa, a partir da notÃ­cia da ocupaÃ§Ã£o irregular em imÃ³vel da UniÃ£o localizado na Rua Carlos Tost, n9 129, Centro, BalneÃ¡rio Barra do Sul/SC', NULL, '2017-03-06', '2017-04-06', NULL, 8, NULL, '2019-06-21 20:14:46', '2019-06-21 20:14:46', 85, 2, 0, NULL, 615),
(633, 1, '1760/2018', '04972.004071/2016-11', 1, 'requisito sejam informadas detalhadamente quais medidas foram tomadas pela SPU apÃ³s a confecÃ§Ã£o da Nota TÃ©cnica nÂ° 11584/2016-MP (anexa), em 17/08/2016, bem assim da NotificaÃ§Ã£o n. 4322451 SPU-SC (anexa) notadamente no que diz respeito ao poder de polÃ­cia da SPU, a fim de sanar as irregularidades detectadas.', 'O que Ã©: solicito informaÃ§Ã£o sobre quais medidas administrativas foram adotadas no Ã¢mbito dessa SuperintendÃªncia, diante das informaÃ§Ãµes prestadas por V.SÂª atravÃ©s da Nota tÃ©cnica nÂº 11419/2016-MP, de que os imÃ³veis estÃ£o em Ã¡rea da UniÃ£o <br><br> O que foi feito: O NUP nÂº 04972.004095/2016-70 (Demanda da AGU), que tambÃ©m trata da Marina Kalemar, alÃ©m das construÃ§Ãµes em terreno da UniÃ£o, referente ao PP nÂº  1.33.005.000494/2015-71, encontra-se relacionado para fiscalizaÃ§Ã£o no perÃ­odo de 07/10/2019 a 11/10/2019, constante do Plano Anual Estadual de FiscalizaÃ§Ã£o - PAEF 2019, inserido no processo 04972.001058/2019-52. <br><br> O que falta: Verificar as providÃªncias adotadas no NUP 04972.004095/2016-70), pois trata-se da mesma Ã¡rea (Marina Kalemar) apesar de possuir nÃºmeros de ICP diferentes. NÃ£o existe LPM homologada. Considerando que versa sobre APP, sugerir o encaminhamento ao Ã³rgÃ£o ambiental para providÃªncias, uma vez que as sanÃ§Ãµes patrimoniais nÃ£o podem ser aplicadas em LPM/1831 nÃ£o homologada.', '2018-11-16', '2018-12-16', NULL, 8, 3, '2019-06-21 20:22:01', '2019-07-12 21:40:02', 82, 2, 0, NULL, 616),
(634, 1, '435/2019', '04972.006761/2017-95', 1, 'Informa que foi proferida sentenÃ§a julgando procedente o pedido â€œ... para desconstituir os tÃ­tulos que embasam a ExecuÃ§Ã£o\nFiscal nÂº 2009.72.01000909-5, por vÃ­cio formal do procedimento demarcatÃ³rio.', NULL, '2019-06-17', NULL, '2019-08-08 22:32:48', 4, 3, '2019-06-21 20:32:14', '2019-08-08 22:32:50', 144, 3, 0, NULL, 617),
(635, 1, '4412/2017', '04972.005134/2017-37', 1, 'informaÃ§Ãµes sobre regularidade de de rancho de pesca, Ã¡rea de preservaÃ§Ã£o permanente, faixa de areia, Praia do Sonho-PalhoÃ§a/SC.', NULL, '2017-08-07', '2017-09-10', NULL, 17, 17, '2019-06-24 14:39:33', '2019-06-24 14:40:07', 91, 2, 0, NULL, 619),
(636, 1, '753/2017', '04972.004453/2017-25', 1, 'informar se Maurino Lemos  possui Termo de AutorizaÃ§Ã£o de Uso SustentÃ¡vel e/ou CessÃ£o em Espelho D\'Ã¡gua, para a construÃ§Ã£o de rancho de pesca dentro da lagoa do Mirim, em Laguna/SC e, em caso negativo, a viabilidade de concessÃ£o deles. Para subsidiar a resposta encaminho cÃ³pia do TCAnÂ° 03.05.016/17-03.', NULL, '2017-07-12', '2017-08-10', NULL, 17, 17, '2019-06-24 14:54:46', '2019-06-24 14:55:20', 65, 2, 0, NULL, 620),
(637, 1, '379/2019', '10154.101527/2019-79', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-18', '2019-07-15', '2019-07-16 15:53:44', 4, 8, '2019-06-24 15:59:01', '2019-07-16 15:53:44', 65, 7, 0, NULL, 622),
(638, 1, '129/2019', '04972.007959/2017-96', 1, 'Informa decisÃ£o judicial e solicita envio de guia DARF para a conversÃ£o em renda', NULL, '2019-06-18', '2019-07-05', '2019-07-11 19:59:11', 4, 3, '2019-06-24 16:22:51', '2019-07-11 19:59:13', 224, 3, 0, NULL, 623),
(639, 1, '00010/2019', '04972.008325/2018-31', 1, 'aguardando conversÃ£o de valores.', 'null', '2019-01-18', NULL, '2019-07-03 22:33:13', 8, 8, '2019-06-24 16:38:43', '2019-07-03 22:33:17', 201, 3, 1, NULL, 624),
(640, 1, '358/2019', '10154.101559/2019-74', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-18', '2019-07-08', '2019-07-15 20:00:15', 4, 4, '2019-06-24 16:44:05', '2019-07-15 20:00:17', 65, 3, 0, NULL, 625),
(641, 1, '968/2019', '10154.101585/2019-01', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-18', '2019-07-08', '2019-07-15 20:18:03', 4, 4, '2019-06-24 17:29:24', '2019-07-15 20:18:05', 126, 3, 0, NULL, 626),
(645, 1, '199/2019', '10154.101659/2019-09', 1, 'disponibilizaÃ§Ã£o dos documentos solicitados (processo de demarcaÃ§Ã£o da LPM/1891 de BalneÃ¡rio Camboriu/SC e documentos relativos ao registro do imÃ³vel RIP 8039.0000749-09', 'Dar acesso externo ao processo de demarcaÃ§Ã£o de BalneÃ¡rio CamboriÃº 11452.001088/96-73, SEI-MP\nDar acesso externo ao processo do RIP 8039 0000749-09 (10983.006963/84-81), solicitei a digitalizaÃ§Ã£o SEI-ECONOMIA.', '2019-06-14', '2019-06-30', '2019-07-25 22:26:07', 4, 3, '2019-06-24 20:43:02', '2019-07-25 22:26:09', 291, 3, 0, NULL, 627),
(646, 1, '888/2019', '04972.008542/2017-41', 1, 'Informa o trÃ¢nsito em julgado favorÃ¡vel Ã  UniÃ£o.', NULL, '2019-06-18', NULL, NULL, 4, NULL, '2019-06-24 20:55:16', '2019-06-24 20:55:16', 100, 2, 0, NULL, 628),
(647, 1, '862/2019', '04972.007409/2018-58', 1, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', NULL, '2019-06-18', '2019-06-28', '2019-07-11 22:09:06', 4, 4, '2019-06-24 21:17:40', '2019-07-15 20:28:03', 100, 3, 0, NULL, 629),
(648, 1, '00382/2019', '04972.206516/2015-14', 1, 'informar se esta SPU-SC pretende dar cumprimento ao julgado para reintegraÃ§Ã£o de posse ou se mantÃ©m a suspensÃ£o da execuÃ§Ã£o.', NULL, '2019-06-10', '2019-07-01', NULL, 1, 3, '2019-06-24 21:50:31', '2019-07-09 19:16:29', 99, 3, 0, NULL, 630),
(649, 1, '885/2019', '10154.101713/2019-16', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o. DesapropriaÃ§Ã£o. Aeroporto, Navegantes.', 'Reiterado pela AGU em 15/07/2019', '2019-06-18', '2019-07-17', '2019-07-31 19:34:15', 4, 3, '2019-06-24 21:50:35', '2019-07-31 21:13:36', 100, 3, 0, NULL, 631),
(650, 1, '2473/2017', '04972.001802/2017-57', 1, 'RecomendaÃ§Ã£o nÂ° 59/2017 - Pesca da Tainha - Refere IC para fiscalizar te, interferem na realizaÃ§Ã£o das prÃ¡ticas da temporada da SAFRA DA TAINHA, sobretudo a modalidade de pesca praticada pelas COMUNIDADES TRADICIONAIS, bem como a extensÃ£o marÃ­tima em que Ã© possÃ­vel e se permite a atividade. E pedido de informaÃ§Ãµes atualizadas em mais duas reiteraÃ§Ãµes.', NULL, '2017-05-02', NULL, NULL, 17, 17, '2019-06-24 22:22:51', '2019-06-24 22:23:50', 90, 2, 0, NULL, 632),
(651, 1, '896/2019', '03007259220148240126', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-19', '2019-09-10', NULL, 4, NULL, '2019-06-24 22:38:00', '2019-06-24 22:38:00', 100, 2, 0, NULL, 634),
(652, 1, '00389/2019', '04972.005396/2017-00', 1, 'solicitar  o  depÃ³sito  do  valor  correspondente  aos  honorÃ¡rios  periciais  nomontante de R$4.240,00, em respeito Ã  decisÃ£o judicial do ev. 133, no prazo de 05 (cinco) dias', '19/07/2019 - AGU cobra resposta\r\n\r\nO que foi feito: OfÃ­cio nÂº 50285/2019/DIGES-SPU-SC/MP solicita descentralizaÃ§Ã£o de crÃ©dito para SAMF-SC para pagamento dos honorÃ¡rios periciaias.\r\n\r\nO que falta fazer: EstÃ¡ em fase de elaboraÃ§Ã£o de Nota Tecnica pela COSUL-SPU (Logistica/Eunice). Solicitamos Ã  NUGES cobrar essa resposta', '2019-06-19', '2019-06-26', NULL, 1, 3, '2019-06-24 22:58:25', '2019-08-09 17:01:17', 99, 2, 0, NULL, 635),
(653, 1, '423/2017', '04972.001537/2017-15', 1, 'informaÃ§Ãµes sobre regularidade de ocupaÃ§Ã£o Rua Oscar Galm, 137 - Itajuba - Barra Velha (SC) pois trata-se de Ã¡rea adjacente Ã  acrescido de marinha e APP.', 'Resposta sobre a fiscalizaÃ§Ã£o - OfÃ­cio n. 53095\nFalta promover a cobranÃ§a', '2017-03-17', '2017-04-07', NULL, 17, 8, '2019-06-24 23:01:55', '2019-07-22 16:43:58', 85, 2, 0, NULL, 636),
(654, 1, '385/2019', '10154.101770/2019-97', 1, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-19', '2019-07-05', '2019-07-12 15:07:51', 4, 4, '2019-06-24 23:18:17', '2019-07-15 19:43:01', 99, 3, 0, NULL, 637),
(655, 1, '130/2019', '04972.003480/2018-61', 1, 'solicita que este Ã³rgÃ£o analise os documentos colacionados aos autos de matrÃ­cula no registro de imÃ³veis ou outros documentos do processo que entender pertinentes, visando aferir a existÃªncia de registro em cartÃ³rio de imÃ³vel pertencente Ã  UniÃ£o em nome de terceiros.', NULL, '2019-06-19', NULL, NULL, 4, NULL, '2019-06-25 15:37:47', '2019-06-25 15:37:47', 224, 1, 0, NULL, 234),
(656, 1, '973/2019', '04972.001575/2017-60', 1, 'Solicita complementaÃ§Ã£o do OfÃ­cio 48614/2019.', NULL, '2019-06-19', '2019-06-28', '2019-06-27 19:58:46', 4, 4, '2019-06-25 15:55:15', '2019-07-01 21:08:33', 114, 3, 0, NULL, 466),
(657, 1, '131/2019', '10154.101880/2019-59', 1, 'anÃ¡lise de documentaÃ§Ã£o.', NULL, '2019-06-21', '2019-07-23', '2019-07-24 17:00:35', 4, 4, '2019-06-25 16:19:03', '2019-07-24 17:00:36', 224, 3, 0, NULL, 638),
(658, 1, '982/2019', '04972.202317/2015-37', 1, 'ManifestaÃ§Ã£o sobre Laudo Complementar', NULL, '2019-06-19', '2019-07-03', '2019-07-11 22:21:05', 4, 4, '2019-06-25 16:54:32', '2019-07-12 21:08:45', 114, 3, 0, NULL, 167),
(659, 1, '906/2019', '10154.102025/2019-65', 0, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-24', '2019-06-26', '2019-06-28 21:32:47', 4, 3, '2019-06-25 20:03:10', '2019-06-28 21:32:50', 100, 3, 0, NULL, 639),
(660, 1, '907/2019', '00221059120128240038', 1, 'CÃ³pia do Processo DemarcatÃ³rio. Joinville', NULL, '2019-06-21', '2019-07-01', '2019-07-16 21:04:01', 4, 3, '2019-06-25 20:28:11', '2019-07-17 15:52:33', 100, 3, 0, NULL, 640),
(661, 1, '392/2019', '04972.006287/2018-82', 1, 'ManifestaÃ§Ã£o sobre laudo pericial', NULL, '2019-06-21', '2019-07-09', '2019-07-01 17:09:41', 4, 4, '2019-06-25 21:29:56', '2019-07-01 17:09:44', 99, 3, 0, NULL, 290),
(662, 1, '4528/2018', '04972.008945/2018-71', 0, 'versa sobre invasÃ£o e uso da faixa de praia na Barra da Lagoa - FlorianÃ³polis/SC', NULL, '2018-09-18', '2018-10-19', NULL, 8, 8, '2019-06-26 15:13:59', '2019-07-11 19:40:50', 86, 4, 0, NULL, 642),
(663, 1, '2563/2018', '04972.006230/2011-15', 1, 'Processo encontra-se suspenso', 'Parecer de ForÃ§a ExecutÃ³ria 7/2018 (7512027) referente a ACP 5027598-32.2014.4.04.7200 que tambÃ©m informa a manutenÃ§Ã£o do EFEITO SUSPENSIVO.\r\nAguardando nova manifestaÃ§Ã£o da AGU', '2018-11-05', NULL, NULL, 1, 1, '2019-06-26 16:58:37', '2019-07-03 22:51:35', 126, 2, 1, NULL, 643),
(664, 1, '010/2019', '04972.008325/2018-31', 1, 'conversÃ£o de depÃ³sito judicial.', NULL, '2019-01-18', NULL, '2019-06-26 20:03:35', 8, 4, '2019-06-26 20:03:20', '2019-06-27 22:49:59', 201, 3, 1, NULL, 624),
(665, 1, '465/2019', '10154.102085/2019-88', 0, 'fiscalize as edificaÃ§Ãµes analisadas nos referidos documentos tÃ©cnicos e, acaso constatadas irregularidades que configurem infraÃ§Ã£o administrativa, nos termos do art. 3Âº da IN 01/2017, promova as medidas administrativas de que tratam os artigos 5Âº e 7Âº da IN 01/2017. Requisita-se, ainda no mesmo prazo, a apresentaÃ§Ã£o de informaÃ§Ãµes acerca das constataÃ§Ãµes e aÃ§Ãµes adotadas pela SPU.', 'Pedido de FiscalizaÃ§Ã£o.\nEnviado ao setor para inclusÃ£o no PAF.', '2019-06-24', '2019-07-22', '2019-08-14 22:59:17', 4, 4, '2019-06-26 21:09:57', '2019-08-14 22:59:19', 74, 3, 0, NULL, 641),
(666, 1, '0181/2019', '04972.006236/2018-51', 1, 'cumprimento de liminar, pretende seja reconhecida a inexigibilidade dos dÃ©bitos cobrados pela SPU a tÃ­tulo de taxa de ocupaÃ§Ã£o, juros e multa, desde 2007 (inclusive)', NULL, '2019-03-29', NULL, '2019-06-27 20:03:10', 8, 4, '2019-06-26 21:17:08', '2019-07-01 21:24:56', 106, 3, 1, NULL, 644),
(667, 1, '0009/2018', '04972.203370/2015-55', 1, 'Informa que a ACP foi julgada improcedente. SentenÃ§a em 10/2017 (evento 283).', NULL, '2018-01-09', NULL, '2019-06-26 21:24:57', 1, 1, '2019-06-26 21:23:33', '2019-06-26 21:24:59', 126, 3, 1, NULL, 645),
(668, 1, '1310/2018', '04972.001717/2017-99', 1, 'Referida sentenÃ§a em favor da UniÃ£o transitou em julgado, conferindo em favor do ente pÃºblico (UniÃ£o) a reintegraÃ§Ã£o da posse dos imÃ³veis matriculados sob os nÂºs 19.902 e 19.904 e TranscriÃ§Ã£o nÂº 3.210, todas do 4Âº Registro de ImÃ³veis de Lages (informaÃ§Ã£o quanto aos registros extraÃ­da do OfÃ­cio nÂº 15/2014-PUSC:EDIT, de 07/01/2014 â€“ em anexo). Conforme  referido  na  sentenÃ§a  transitada  em  julgado,  nÃ£o  foi  expedido  o mandado de reintegraÃ§Ã£o em razÃ£o das tratativas de acordo no Ã¢mbito administrativo. Sobre as tratativas entre os Ã³rgÃ£os e entes envolvidos (SPU/SC, MunicÃ­pio de Lages, DNIT), verifico que: - no tocantes Ã s Ã¡reas 1 e 3, houve manifestaÃ§Ã£o de interesse por parte do DNIT, nos termos do OfÃ­cio 566/2016/DIF/DNIT, de 24/11/2016 (Evento 2 â€“ PROCJUD11, pÃ¡gina  3  â€“  em  anexo),  restando,  assim,  contraditÃ³ria  a  informaÃ§Ã£o  constante  da  Nota Informativa nÂº 5409/2018-MP, de 24/05/2018; - no tocante Ã s Ã¡reas 2 e 4, existia a intenÃ§Ã£o de regularizaÃ§Ã£o fundiÃ¡ria de interesse social  mediante a sua doaÃ§Ã£o por parte da UniÃ£o ao MunicÃ­pio de Lages, conforme se lÃª na Nota TÃ©cnica 13592/2017-MP (Evento 2 â€“ PROCJUD11, pÃ¡ginas 5/6 â€“ em anexo). Assim, tendo em vista os documentos oriundos deste r. Ã³rgÃ£o e do DNIT acima mencionados: a)renovo a solicitaÃ§Ã£o de informaÃ§Ã£o quanto ao deslinde administrativo da questÃ£o junto ao DNIT relativamente Ã s Ã¡reas 1 e 3; b)solicito seja informado se as Ã¡reas 2 e 4, objeto da ocupaÃ§Ã£o irregular pelos rÃ©us  particulares,  foram  efetivamente  cedidas  ao  MunicÃ­pio  de  Lages  e  procedida  Ã  regularizaÃ§Ã£o fundiÃ¡ria, ou se, ao contrÃ¡rio, remanesce interesse na expediÃ§Ã£o de mandado de reintegraÃ§Ã£o de posse, visando Ã  sua desocupaÃ§Ã£o.', NULL, '2018-06-20', NULL, NULL, 1, NULL, '2019-06-26 21:37:44', '2019-06-26 21:37:44', 224, 2, 0, NULL, 646),
(669, 1, '00147/2018', '04972.001028/2009-74', 1, 'entendeu-se nÃ£o ser oportuna a designaÃ§Ã£o de audiÃªncia de conciliaÃ§Ã£o, sendo cabÃ­vel dar seguimento Ã s tratativas de doaÃ§Ã£o da Ã¡rea ao MunicÃ­pio para que este ente promova a regularizaÃ§Ã£o da cua ocupaÃ§Ã£o.', NULL, '2018-08-28', NULL, NULL, 1, NULL, '2019-06-26 22:01:57', '2019-06-26 22:01:57', 264, 2, 0, NULL, 648),
(670, 1, '418/2019', '10154.102504/2019-81', 0, 'cÃ³pia integral e preste informaÃ§Ãµes sobre o andamento do processo administrativo, que visa Ã  expediÃ§Ã£o de TAUS, em favor de AntÃ´nio Teixeira, para a construÃ§Ã£o e manutenÃ§Ã£o de um rancho de pesca sobre as dunas frontais da Praia da Barra de Ibiraquera, em Imbituba', NULL, '2019-06-21', '2019-07-11', '2019-07-19 19:43:19', 4, 4, '2019-06-26 22:03:35', '2019-07-19 19:43:20', 65, 3, 0, NULL, 647),
(671, 1, '873/2016', '10983.002949/9138', 1, 'prestar os seguintes esclarecimentos:\r\n1. Quais  medidas  foram  adotadas  para  a  regularizaÃ§Ã£o  dos  lotes  emnome  dos  efetivos  ocupantes  da  Ã¡rea  correspondente  ao  RIP    81790001373-29?   Qual  asituaÃ§Ã£o atual?\r\n2. As  ocupaÃ§Ãµes  existentes  apresentam  compatibilidade  com  o  objetoda cessÃ£o,  qual seja de aforamento gratuito Ã s pessoas  de baixa renda?\r\n3.  O MunicÃ­pio de  Joinville  realizou o  cadastro  socioeconÃ´mico  pararevisÃ£o  dos limites da Ã¡rea  cedida?\r\n4,  Foram  instaurados  procedimentos  de  revisÃ£o  dos  limites  da  Ã¡reacedida  e  realizada   a  consequente  anÃ¡lise   para   regularizaÃ§Ã£o  dos iimÃ³veis   consideradosincompatÃ­veis com o objeto da  cessÃ£o', NULL, '2016-03-10', '2016-04-01', NULL, 1, NULL, '2019-06-26 22:46:43', '2019-06-26 22:46:43', 83, 2, 0, NULL, 649),
(672, 1, '3824/2017', '04972.005986/2017-24', 1, 'Ã€ CODES/SPU/SC, setor regimentalmente responsÃ¡vel pela gestÃ£o das utilizaÃ§Ãµes dos imÃ³veis da UniÃ£o, para:\r\nAnalisar o requerimento administrativo n. 4728702, protocolo n. 09830.036788/194, remetendo a devida resposta ao requerente;\r\nInformar-nos, por meio de processo especÃ­fico, se a Ã¡rea Ã© passÃ­vel de regularizaÃ§Ã£o via Termo de AutorizaÃ§Ã£o de Uso SustentÃ¡vel (TAUS);', 'SentenÃ§a para cancelamento de RIP (rancho de pesca).\r\nPendente anÃ¡lise de requerimento administrativo para TAUS (SPU-SC-NUREF) e, caso negativo, cancelamento do RIP.', '2017-12-28', NULL, NULL, 1, 1, '2019-06-26 23:10:51', '2019-07-03 22:39:25', 199, 2, 1, NULL, 650),
(673, 1, '0549/2017', '04972.006629/2016-01', 1, 'mantida a condenaÃ§Ã£o a obrigaÃ§Ã£o de fazer referente Ã  desocupaÃ§Ã£o da Casa do Piloto por particulares, sob pena de multadiÃ¡ria de R$ 100,00 a contar do trÃ¢nsito em julgado da aÃ§Ã£o', 'Em tratamento na demanda 0549/2017, do mesmo NUP', '2017-03-07', '2017-05-07', NULL, 1, 1, '2019-06-26 23:29:50', '2019-08-05 21:27:51', 167, 4, 1, NULL, 651),
(674, 1, '132/2019', '10154.102698/2019-15', 0, 'ManifestaÃ§Ã£o de Interesse.', NULL, '2019-06-24', '2019-07-24', '2019-07-29 17:20:25', 4, 4, '2019-06-27 17:12:27', '2019-07-29 17:20:26', 224, 3, 0, NULL, 652),
(675, 1, '1014/2019', '04972.009154/2018-68', 0, 'emitir manifestaÃ§Ã£o quanto Ã  proposta de acordo formulada nos autos pelo MunicÃ­pio de SÃ£o JosÃ©, que envolve o suporte das despesas e a disponibilizaÃ§Ã£o de informaÃ§Ãµes por essa d. SPU.', 'null', '2019-06-27', '2019-07-08', '2019-07-30 22:28:13', 3, 4, '2019-06-27 19:29:17', '2019-08-01 21:27:46', 114, 3, 0, NULL, 653),
(677, 1, '905/2019', '04972.206452/2015-51', 1, 'Informa que foi efetuada a reintegraÃ§Ã£o de posse, conforme certidÃ£o do oficial de justiÃ§a, devendo ser arquivado o processo', NULL, '2019-06-24', NULL, '2019-06-27 20:31:53', 4, 4, '2019-06-27 20:31:31', '2019-06-27 20:31:55', 100, 3, 0, NULL, 654),
(678, 1, '986/2019', '04972.009645/2018-17', 1, 'manifeste acerca dos argumentos dispostos na petiÃ§Ã£o do evento 92, especialmente sobre a alegaÃ§Ã£o de que a Secretaria do PatrimÃ´nio da UniÃ£o nÃ£o realizou ou deu atendimento ao disposto nos artigos 11 e 12-B do Decreto Lei 9760/1946 para demarcar a Ã¡rea e cadastrar todos os moradores da regiÃ£o (Costa da Lagoa da ConceiÃ§Ã£o).', 'null', '2019-06-24', '2019-07-24', '2019-08-23 21:56:48', 4, 4, '2019-06-27 21:21:32', '2019-08-26 16:12:56', 126, 3, 0, NULL, 655),
(679, 1, '284/2017', '04972.004604/2014-01', 1, 'prestar informaÃ§Ãµes acerca das seguintes notificaÃ§Ãµes expedidas no Ã¢mbito do Processo SPU 04972.200019/2015-11, em especial, seja houve a formalizaÃ§Ã£o da desocupaÃ§Ã£o dos imÃ³veis pelos responsÃ¡veis, haja vista o esgotamento do prazode 90 (noventa) dias concedido por esta SuperintendÃªncia.', NULL, '2017-03-29', '2017-06-29', NULL, 1, NULL, '2019-06-27 21:31:09', '2019-06-27 21:31:09', 65, 2, 0, NULL, 656),
(680, 1, '262/2015', '04972.200918/2015-13', 1, 'Verificar a regularidade da ocupaÃ§Ã£o dos imÃ³veis identificados como Restaurante CasarÃ£o e Parador Swell, localizados na Praia do Rosa, em Imbituba/SC', NULL, '2015-03-25', '2015-06-25', NULL, 1, NULL, '2019-06-27 21:46:27', '2019-06-27 21:46:27', 72, 2, 0, NULL, 657),
(681, 1, '206/2019', '04972.006318/2017-14', 0, 'confirme a intervenÃ§Ã£o do imÃ³vel sobre Ã¡rea de propriedade da UniÃ£o e informe se hÃ¡ alguma possibilidade de resoluÃ§Ã£o administrativa da questÃ£o.', NULL, '2019-06-25', '2019-07-25', '2019-07-12 20:13:51', 4, 8, '2019-06-27 23:05:55', '2019-07-12 20:13:51', 103, 7, 0, NULL, 658),
(682, 7, '12/2019', '04972.200724/2015-18', 0, 'Realize vistoria na Praia da Cigana, em Laguna/SC, a fim de identificar se os ranchos de pesca construÃ­dos naquela localidade sÃ£o utilizados por pescadores artesanais e se sÃ£o passÃ­veis de regularizaÃ§Ã£o perante este Ã³rgÃ£o', NULL, '2019-06-12', NULL, NULL, 4, NULL, '2019-06-27 23:46:34', '2019-06-27 23:46:34', 65, 2, 0, NULL, 659),
(683, 1, '471/2019', '04972.001451/2017-84', 1, 'prestar informaÃ§Ãµes sobre as medidas eventualmente adotadas apÃ³s a constataÃ§Ã£o de que o empreendimento \"Loteamento Portal da Barra\" localizado na Estrada Geral Barra do ItapocÃº, interfere totalmente com terras da UniÃ£o e nÃ£o conta com registro de ocupaÃ§Ã£o no SIAPA.', NULL, '2019-03-19', '2019-05-02', '2019-07-12 16:36:42', 1, 1, '2019-06-28 20:02:28', '2019-07-12 16:36:45', 85, 3, 0, NULL, 660),
(684, 1, '50783/2019', '04972.001451/2017-84', 1, 'verificar atendimento do solicitado no OfÃ­cio 50783/2019 (8781999 - SEI MP):\r\nsolicitamos seja providenciada a regularizaÃ§Ã£o da Ã¡rea perante esta SuperintendÃªncia, no prazo de 90 dias, sob pena da ocupaÃ§Ã£o ser considerada infraÃ§Ã£o administrativa contra o patrimÃ´nio da UniÃ£o, nos termos do Art.6Âº do Decreto-Lei nÂº 2.398, de 21 dezembro de 1987, com a consequente aplicaÃ§Ã£o das sanÃ§Ãµes cabÃ­veis.', 'Pendente:<br>1) Monitorar resposta Ã  NotificaÃ§Ã£o.<br>2) CartÃ³rio de Araqui solicita identificar quais lotes devem ter a matricula anotada com interferÃªncia em terra de marinha', '2019-06-27', '2019-09-27', NULL, 1, 1, '2019-06-28 20:06:37', '2019-07-17 20:29:34', 292, 2, 0, NULL, 660),
(685, 1, '922/2019', '10154.104020/2019-77', 0, 'ManifestaÃ§Ã£o de Interesse.', 'Respondido', '2019-06-25', '2019-07-16', '2019-07-17 14:27:15', 4, 4, '2019-07-02 17:35:10', '2019-07-19 21:02:57', 100, 3, 0, NULL, 661),
(686, 1, '1452/2018', '04972.003792/2016-11', 0, 'emissÃ£o de TAUS - proximidades da Ponte HercÃ­lio Luz, Estreito, MunicÃ­pio de FlorianÃ³polis/SC', NULL, '2018-06-21', '2018-06-30', '2019-07-15 19:51:59', 8, 4, '2019-07-02 20:32:04', '2019-07-15 19:52:01', 114, 3, 0, NULL, 662),
(687, 1, '00817/2016', '00054212820018240022', 0, 'manifestaÃ§Ã£o dessa SuperintendÃªncia a respeito do imÃ³vel em questÃ£o, especialmente sobre eventual validade do ajuste intitulado \"Termo Particular de CessÃ£o de Direito e de Posse de Ilha MarÃ­tima\" firmado entre particulares e juntado aos autos. SÃ£o Carlos/SC.', NULL, '2016-05-01', '2016-05-12', '2019-07-12 19:55:37', 8, 4, '2019-07-02 20:35:53', '2019-07-15 17:03:17', 100, 3, 0, NULL, 664),
(688, 1, '1011/2019', '10154.104174/2019-69', 0, 'InformaÃ§Ãµes em mandado de seguranÃ§a.', 'Trata-se  o presente de solicitaÃ§Ã£o de subsÃ­dios para defesa judicial dos interesses da UniÃ£o, referente ao Mandado de SeguranÃ§a n. 5014018-56.2019.4.04.7200, na forma do OfÃ­cio n. 01011/2019/PROT/PUSC/PGU/AGU (2819492).\r\nEm anÃ¡lise no NUCIP - Aguardando resposta', '2019-06-26', '2019-07-15', '2019-07-12 16:14:08', 4, 3, '2019-07-02 20:38:17', '2019-07-12 16:26:28', 126, 3, 0, NULL, 665),
(689, 1, '395/2019', '04972.002869/2016-28', 0, 'Acesso externo', NULL, '2019-06-26', '2019-07-05', '2019-07-03 15:49:10', 4, 3, '2019-07-02 20:52:58', '2019-07-03 15:49:12', 99, 3, 0, NULL, 281),
(690, 1, '393/2019', '04972.003233/2019-46', 0, 'Identificar a Ã¡rea da UniÃ£o interferida, plotando-o, se possÃ­vel, na planta do imÃ³vel usucapiendo do ev. 1 - OUT9', NULL, '2019-06-26', '2019-07-03', '2019-07-12 20:31:06', 4, 4, '2019-07-02 21:23:53', '2019-07-15 16:44:13', 99, 3, 0, NULL, 314),
(691, 2, 'n/i', '10154.104265/2019-02', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o', 'Reiterado em 16/07/2019', '2019-07-25', '2019-07-15', '2019-07-24 15:48:59', 4, 4, '2019-07-02 22:13:53', '2019-07-24 16:38:04', 277, 3, 0, NULL, 666),
(692, 1, '448/2019', '10154.104444/2019-31', 0, 'apresentar arquivo no formato digital â€œDWGâ€ da Base CartogrÃ¡fica do GRPU/SPU, articulaÃ§Ãµes ou folhas nÂº 739-069 e 739-071.', NULL, '2019-07-25', '2019-07-05', '2019-07-03 20:11:48', 4, 4, '2019-07-03 16:50:29', '2019-07-04 20:55:50', 20, 3, 0, NULL, 667),
(693, 1, '134/2019', '03002583120158240045', 0, 'Informa a data da PerÃ­cia.', NULL, '2019-06-27', NULL, '2019-07-08 19:57:32', 4, 8, '2019-07-03 17:07:10', '2019-07-08 19:57:32', 234, 7, 0, NULL, 31),
(694, 1, '133/2019', '04972.001699/2017-45', 1, 'Cumprimento de sentenÃ§a (incorporaÃ§Ã£o de imÃ³vel da RFFSA). Ver Despacho DIINC-SPU-SC 8160767', 'Pendente a incorporaÃ§Ã£o do referido NBP, que serÃ¡ tratada no NUP 04972.000477/2016-24', '2019-04-20', '2019-05-20', NULL, 1, 1, '2019-07-03 17:18:08', '2019-07-03 21:35:00', 99, 2, 1, NULL, 38),
(695, 1, '113/2019', '04972.005336/2018-60', 0, 'Informa o trÃ¢nsito em julgado da sentenÃ§a de procedÃªncia que determinou a conclusÃ£o do Processo Administrativo nÂº 10983.012436/86-22.', NULL, '2019-06-27', NULL, '2019-07-03 17:36:21', 4, 4, '2019-07-03 17:36:04', '2019-07-03 17:36:22', 114, 3, 0, NULL, 668),
(696, 1, '00763/2017', '04972.002670/2017-81', 1, 'Ante o exposto, julgo procedente o pedido para pronunciar a  prescriÃ§Ã£o  aquisitiva  e,  consequentemente,  a  aquisiÃ§Ã£o originÃ¡ria,  por  usucapiÃ£o,  pela  parte  autora,  do  imÃ³vel urbano localizado Ã s margens da ferrovia aproximadamente  no  km  24+000,  distante  74,16  metros  da Rua  AntÃ´nio  Ramos  Alvim,  MunicÃ­pio de  Araquari/  SC, conforme  memorial  descritivo  de  evento  73:2,  datado  de 01/04/2015.', '22/07/2019\r\nO que foi feito:\r\nEnviado o OfÃ­cio nÂº 51376/2019/DIGES-SPU-SC/MP solicitando Ã  AGU - acesso ao memorial descritivo citado no comando judicial, o qual jÃ¡ foi respondido com envio da documentaÃ§Ã£o solicitada.\r\n\r\nO que falta fazer:\r\nPendente anÃ¡lise e providÃªncias pela DIINC', '2017-05-31', '2017-07-03', '2019-07-12 17:06:22', 1, 1, '2019-07-03 19:55:18', '2019-08-05 16:32:05', 102, 2, 1, NULL, 669),
(697, 1, '1012/2019', '04972.001790/2019-22', 0, 'Informa a decisÃ£o transitada em julgado que concluiu pela extinÃ§Ã£o do feito sem julgamento do mÃ©rito.', NULL, '2019-06-27', NULL, '2019-07-03 20:31:04', 4, 4, '2019-07-03 20:28:15', '2019-07-03 20:31:05', 114, 3, 0, NULL, 670),
(698, 1, '400/2019', '04972.006236/2018-51', 0, 'Resposta ao Despacho DIREP  8295201.', 'undefined', '2019-06-28', NULL, NULL, 4, NULL, '2019-07-04 16:39:19', '2019-07-04 16:39:19', 121, 2, 0, NULL, 644),
(699, 1, '136/2019', '04972.008389/2018-32', 0, 'ConclusÃ£o dos Processos de Aforamento nÂº 04972.007791/2013-95 e 04972.207127/2015-14.', 'A CODES informou que esta SPU/SC estÃ¡ impossibilitada de ultimar o pedido de ConstituiÃ§Ã£o Aforamento, entre tantos outros na mesma situaÃ§Ã£o, pelos motivos expostos na Nota TÃ©cnica 13148 (8700232), pois estÃ¡ aguardando definiÃ§Ã£o final da questÃ£o, que encontra-se no Ã¢mbito da Advocacia Geral da UniÃ£o.', '2019-07-01', '2019-10-30', '2019-07-12 16:01:22', 4, 4, '2019-07-04 17:32:16', '2019-07-12 21:34:34', 234, 3, 1, NULL, 332),
(700, 1, '2484/2019', '10154.105001/2019-68', 0, 'informe se o Ã¡rea localizada nas coordenadas: latitude 27Â°36\'05\" 5 - longitude 48Â°35\'54\" W, foco da denÃºncia, de propriedade da Senhora Florisbela Becker (CPF 599.324.309-00), setenta e nove anos, incide em terrenos de marinha e seus acrescidos.', 'undefined', '2019-06-19', '2019-07-19', NULL, 8, NULL, '2019-07-04 22:29:26', '2019-07-04 22:29:26', 245, 2, 0, NULL, 671),
(701, 1, '133/2019', '10154.105019/2019-60', 0, 'anÃ¡lise dos documentos que acompanham o Parecer de ForÃ§a ExecutÃ³ria.', 'Resposta da consulta Ã  CJU-SC (OFÃCIO SEI NÂº 46/2019/NUJUC/SPU-SC/SPU/SEDDM-ME):\r\nEm resumo, fomos orientados a somente iniciar a cobranÃ§a do valor atualizado da taxa de ocupaÃ§Ã£o apÃ³s a decisÃ£o final do processo administrativo instaurado com tal finalidade, ou seja, somente depois de atendidos \"todos os requisitos legais exigidos em diversas decisÃµes judiciais idÃªnticas, quais sejam: intimar pessoalmente a parte; conceder prazo para defesa e apresentaÃ§Ã£o de documentos; intimar da decisÃ£o administrativa que alterar o valor; abrir prazo para o recurso; apreciar eventual recurso e somente apÃ³s a publicaÃ§Ã£o ou intimaÃ§Ã£o do resultado desse recurso, ou seja, da decisÃ£o final, iniciar a cobranÃ§a do novo valor da taxa de ocupaÃ§Ã£o\".\r\n\r\nDessa forma, o marco temporal que encerra a cobranÃ§a dos valores com a simples atualizaÃ§Ã£o pelo IPCA-E e inicia a cobranÃ§a dos novos valores definidos em novo procedimento de atualizaÃ§Ã£o Ã© do da conclusÃ£o do processo administrativo instaurado com essa finalidade, devendo ser observados os prazos para apresentaÃ§Ã£o de recurso pelo administrado, constantes em cada notificaÃ§Ã£o ou na legislaÃ§Ã£o vigente.\r\n\r\nO que falta fazer:\r\n- NUCIP definir valores e datas\r\n- NUREP operacionalizar a cobranÃ§a\r\n- Informar Ã  AGU', '2019-06-27', '2019-07-26', NULL, 4, 1, '2019-07-04 22:36:36', '2019-08-22 21:25:05', 224, 2, 0, NULL, 672),
(702, 1, '228/2017', '04972.001456/2017-15', 0, 'MPF solicito informar se os empreendimentos listados estÃ£o ocupando Ã¡rea pertencente Ã  UniÃ£o e, em caso afirmativo, se possuem autorizaÃ§Ã£o de ocupaÃ§Ã£o:1) Sky Beach (RMG Restaurante Ltda.), Rua Higino JoÃ£o Pio, 400,Praia do Estaleirinho, BalneÃ¡rio CamboriÃº/SC; 2) Parador Beach Club (Mini resort Estaleirinho Ltda.), Rua Victorio Fornerolli, 654, Praia do Estaleirinho, BalneÃ¡rio CamboriÃº/SC; 3) Vitali Beach Lounge, Av. Rodesino Pavan, 10.205 e 4) Dreams Beach Club, Av. Interpraias, s/n, BalneÃ¡rio CamboriÃº.', 'Respondido OfÃ­cio 31106 (3671428).', '2017-03-27', '2017-04-17', NULL, 17, 1, '2019-07-04 22:46:43', '2019-07-15 21:48:51', 74, 2, 0, NULL, 673),
(703, 1, '396/2018', '04972.001445/2017-27', 0, 'que adote as medidas que entender necessÃ¡rias no tocante Ã  ocupaÃ§Ã£o das 8 (oito) casas da extinta RFFSA em Rio das Antas.', 'NÃ£o respondido. Ultimo doc Despacho propÃµe encaminhamento Ã  COCAI para anÃ¡lise e manifestaÃ§Ã£o.', '2018-10-17', NULL, NULL, 17, 17, '2019-07-04 22:59:47', '2019-07-04 23:00:08', 59, 2, 0, NULL, 675),
(704, 1, '960/2019', '04972.002278/2016-51', 1, 'iformaÃ§Ãµes atualizadas sobre os trabalhos de elaboraÃ§Ã£o dos mapas, com levantamento de Ã¡rea total e de marinha e anÃ¡lise dos casos de ocupaÃ§Ãµes irregulares que envolvem as margens do Rio Acarai, objeto do RelatÃ³rio de FiscalizaÃ§Ã£o nÂ° 108/2018 (processo 04972.002278/2016-51), mencionado no Oficio nÂ° 106399/2018-MP, de 03 de dezembro de 2018, dessa SuperintendÃªncia.', 'undefined', '2019-06-24', '2019-08-12', NULL, 1, NULL, '2019-07-05 16:21:12', '2019-07-05 16:21:12', 85, 2, 0, NULL, 676),
(705, 1, '1486/2018', '04972.001362/2017-38', 0, 'informaÃ§Ãµes atualizadas quanto Ã  anÃ¡lise do pedido de inscriÃ§Ã£o de ocupaÃ§Ã£o da Ã¡rea efetuado pela empresa Worldport Desenvolvimento PortuÃ¡rio S/A., bem como se hÃ¡ solicitaÃ§Ã£o de cessÃ£o de espelho d\'Ã¡gua.', 'undefined', '2018-09-17', '2018-10-07', NULL, 17, 17, '2019-07-05 17:05:57', '2019-07-05 17:06:47', 85, 2, 0, NULL, 1),
(706, 6, '0044/2017', '04972.001353/2017-47', 0, 'manifestaÃ§Ã£o sobre o interesse relativo a existÃªncia de construÃ§Ãµes irregulares (casas, pontes e etc.) em Ã¡rea de preservaÃ§Ã£o permanente, ao longo do Rio da Madre, situado em TubarÃ£o, para a adoÃ§Ã£o de medidas judiciais e extrajudiciais, nos termos do despacho de arquivamento anexo ao ofÃ­cio acima referenciado.', 'undefined', '2017-03-29', NULL, NULL, 17, 17, '2019-07-05 17:23:10', '2019-07-05 17:23:48', 293, 2, 0, NULL, 678),
(707, 1, '0348/2019', '10154.105163/2019-04', 0, 'Manifeste-se acerca do interesse da UniÃ£o em relaÃ§Ã£o Ã  Ã¡rea atingida.', 'undefined', '2019-07-03', '2019-07-22', '2019-07-24 16:41:50', 8, 4, '2019-07-05 19:38:21', '2019-07-24 16:41:52', 216, 3, 0, NULL, 680),
(708, 9, '5014077-44.2019.4.04.7200', '10154.104740/2019-32', 0, 'Prestar informaÃ§Ãµes em Mandado de seguranÃ§a - a parte impetrante pretende seja concedida a medida liminar para o fim de ser suspensa a exigibilidade das taxas geradas a partir da inscriÃ§Ã£o da impetrante como ocupante da Ã¡rea de marinha correspondente ao RIP 8113.0000168-80.\nDemanda tambÃ©m enviada pela AGU (00745.002865/2019-15).', 'Elaborada resposta - Aguardando assinatura', '2019-07-03', '2019-07-15', '2019-07-16 22:33:19', 3, 3, '2019-07-05 19:49:20', '2019-07-17 15:41:37', 161, 3, 0, NULL, 681),
(709, 1, '00048/2019', '04972.006628/2016-58', 1, 'Apresentar PRAD referente ao isolamento da Ã¡rea e o cronograma de monitoramento periÃ³dico, sob pena de multa diÃ¡ria de R$ 100,00.', 'Acompanhamento do PRAD. No Primeiro ciclo anual (Junho de 2019 a Junho de 2020) os relatÃ³rios sÃ£o trimestrais sendo entÃ£o um no inÃ­cio, logo apÃ³s cercamento provavelmente em junho de 2019, outro em setembro de 2019, um em dezembro de 2019, outro em marÃ§o de 2020 e o Ãºltimo em Junho de 2020. Multa diÃ¡ria de R$ 100,00.', '2019-02-01', '2019-03-21', '2019-08-05 17:02:39', 1, 1, '2019-07-05 20:10:24', '2019-08-05 17:02:40', 100, 3, 1, NULL, 682),
(710, 1, '392/2017', '04972.001116/2017-86', 0, 'informaÃ§Ãµes sobre a Ã¡rea apontada no Auto de ConstataÃ§Ã£o nÂ° 053/23 Cia/BPMA/2015, localizada a Rua Prefeito Baltazar Buschle, Joinville/SC, Coordenadas UTM 22J 0720448-70908898, localiza-se, ao menos parcialmente, em Ã¡reas de terras de marinha e seus acrecidos (LPM/1831), nos termos do art. 2Â°,\"a\", do Decreto-Lei nÂ° 9.760/46.', 'O que Ã©: SolicitaÃ§Ã£o de informaÃ§Ãµes sobre  a Ã¡rea apontada no Auto de ConstataÃ§Ã£o nÂº 053/2Âª Cia/BPMA/2015, localizada a Rua Prefeito Baltazar Buschle, Joinville/SC, Coordenadas UTM 22J 0720448-7090898, localiza-se, ao menos parcialmente, em Ã¡reas de terras de marinha e seus acrescidos (LPM/1831) <br>\r\nO que foi feito: Informado que o local se sobrepÃµe totalmente Ã  Terrenos de Marinha e Acrescidos, e encaminhado para FiscalizaÃ§Ã£o em 04/05/2017.\r\nInserido no PAF 2019 para a data de 07 a 11/10/2019. <br>\r\nO que falta fazer: A vistoria de FiscalizaÃ§Ã£o na data 07 a 11/10/2019 <br>', '2017-03-16', '2017-04-16', NULL, 17, 5, '2019-07-05 20:32:46', '2019-07-11 21:23:18', 82, 2, 0, NULL, 685),
(711, 1, '405/2019', '10154.105314/2019-16', 0, 'Informa o trÃ¢nsito em julgado da SentenÃ§a que declarou inexigÃ­vel a cobranÃ§a de laudÃªmio, e improcedente os demais pedidos autorais.', 'undefined', '2019-07-02', NULL, '2019-07-29 16:55:47', 4, 4, '2019-07-05 21:18:20', '2019-07-29 16:56:25', 228, 3, 0, NULL, 686),
(712, 1, '398/2019', '04972.002280/2019-72', 0, 'informar que o juÃ­zo concedeu o prazo solicitado de 60 dias para que essa SPU/SC verifique se houve a desocupaÃ§Ã£o voluntÃ¡ria do imÃ³vel objeto do processo acima identificado.', 'Verificar se houve a desocupaÃ§Ã£o voluntÃ¡ria do imÃ³vel objeto do processo. Prazo : 27/08/2019', '2019-07-02', '2019-08-27', '2019-08-22 21:12:10', 4, 4, '2019-07-05 21:45:38', '2019-08-26 16:50:28', 99, 3, 1, NULL, 180),
(713, 1, '6111/2016', '04972.000133/2017-04', 0, 'que em relaÃ§Ã£o ao documento em que Annito Zeno Petry e Habitasul cedem terras ao MunicÃ­pio, informaÃ§Ã£o detalhada quanto ao encaminhamento, no Ã¢mbito do ServiÃ§o do PatrimÃ³nio da UniÃ£o, que foi dado a tal cessÃ£o, desde 31/7/1990 atÃ© hoje; informaÃ§Ã£o trazendo a relaÃ§Ã£o dos fatos que estejam registrados e que liguem os documentos com a sua localizaÃ§Ã£o atualizada, e seja informado se o ServiÃ§o do PatrimÃ³nio da UniÃ£o tem registrado o conceito de postos de praia.', 'undefined', '2016-12-19', '2017-01-13', NULL, 17, 17, '2019-07-05 21:46:36', '2019-07-05 21:47:00', 91, 2, 0, NULL, 687),
(714, 1, '1964/2016', '04972.006336/2016-15', 0, 'o encaminhamento e  informaÃ§Ãµes/documentos sobre a Ã¡rea localizada na \"Rua dos Pescadores\", lateral da Estrada Geral do Frias, Bairro Frias, MunicÃ­pio e ao Francisco do Sul,  se pertence Ã  UniÃ£o, notadamente se abrange terras de marinha e seus acrescidos.', 'O que Ã©:\r\nsolicita o encaminhamento e  informaÃ§Ãµes/documentos sobre a Ã¡rea localizada na \"Rua dos Pescadores\", lateral da Estrada Geral do Frias, Bairro Frias, MunicÃ­pio e ao Francisco do Sul,  se pertence Ã  UniÃ£o, notadamente se abrange terras de marinha e seus acrescidos.\r\n\r\nO que foi feito:\r\nfoi encaminhado ao MPF o RelatÃ³rio de FiscalizaÃ§Ã£o Individual nÂº 35/2019\r\n\r\nO que falta:\r\no processo foi encaminhado Ã  DIREP para (a) emissÃ£o do DARF no valor total especificado no auto de InfraÃ§Ã£o  ( 8693855 );    (b) notificar o infrator sobre os dÃ©bitos consolidados para quitaÃ§Ã£o, mediante envio do DARF e, caso nÃ£o sejam regularizados os dÃ©bitos, formalizar/instruir o processo para inscriÃ§Ã£o no CADIN e em DAU;   (c) para gerenciamento das cobranÃ§as  pela Ã¡rea de receitas nos termos do normativo SPU descrito pelo Memorando nÂº 8922/2017-MP (4230575), constante do processo 04905.002069/2017-91, o que inclui a emissÃ£o de DARF mensalmente, considerando-se o art. 6Âº, do DL 2.398/87:   \" Â§A multa de que trata o inciso II do Â§ 4Âº  serÃ¡ mensal, sendo automaticamente aplicada pela SuperintendÃªncia do PatrimÃ´nio da UniÃ£o sempre que o cometimento da infraÃ§Ã£o persistir\".', '2016-11-24', '2016-12-24', NULL, 17, 1, '2019-07-05 21:55:51', '2019-08-08 20:41:18', 82, 2, 0, NULL, 688),
(715, 1, '364/2019', '10154.105245/2019-41', 0, 'Informar se os imÃ³veis de propriedade de Denise Neves da Silva Machado, construÃ­dos entre as localidades conhecidas como \"Arroio Corrente\" e \nCampo Bom\", no municÃ­pio de Jaguaruna (coordenadas geogrÃ¡ficas: ImÃ³vel 1 - 28Â°42\"28.13\"S 49Â°02\"24.57\"W; ImÃ³vel 2 - 28Â°42\"27.79\"S 49Â°02\"24.81\"W), estÃ£o situados total ou parcialmente em terrenos de marinha e/ou acrescidos. Jaguaruna/SC.', 'DistribuÃ­do - Em anÃ¡lise.', '2019-06-17', '2019-07-15', '2019-07-18 20:42:56', 8, 4, '2019-07-08 15:10:46', '2019-07-19 20:17:40', 65, 3, 0, NULL, 689),
(716, 1, '368/2019', '10154.105281/2019-12', 0, 'acesso ao processo administrativo n. 04972.000951/2015-37.', 'DistribuÃ­do - Fornecer acesso Ã  Ã­ntegra do processo ao MinistÃ©rio PÃºblico.', '2019-07-18', '2019-07-16', '2019-07-23 20:13:07', 8, 3, '2019-07-08 15:30:07', '2019-07-23 20:45:34', 65, 3, 0, NULL, 690),
(717, 1, '352/2019', '10154.105229/2019-58', 0, 'que seja apurada a regularidade cadastral do imÃ³vel localizado na RoÃ§a Grande, municÃ­pio de Imbituba (coordenadas UTM 22J 0721582 - 6865421).', 'DistribuÃ­do - Em anÃ¡lise.\nIC ainda em fase de PP.', '2019-06-28', '2019-07-26', '2019-07-29 21:24:17', 8, 4, '2019-07-08 16:00:41', '2019-08-01 17:30:21', 65, 3, 0, NULL, 691),
(718, 1, '002', '10154.105496/2019-25', 0, 'SuscitaÃ§Ã£o de DÃºvida 1Âº OfÃ­cio de Registro de ImÃ³veis BalneÃ¡rio CamboriÃº/SC.\nEdifÃ­cio Infinity Coast Residence.\nProcesso SEI-MP n. 04972.004318/2018-61.', 'DistribuÃ­do - Em anÃ¡lise.\nSuscitaÃ§Ã£o de DÃºvida 1Âº OfÃ­cio de Registro de ImÃ³veis BalneÃ¡rio CamboriÃº/SC.\nEdifÃ­cio Infinity Coast Residence.', '2019-06-18', '2019-07-18', NULL, 8, NULL, '2019-07-08 16:53:44', '2019-07-08 16:53:44', 295, 2, 0, NULL, 692),
(719, 1, '1041/2019', '10154.105520/2019-26', 0, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', 'undefined', '2019-07-02', '2019-07-22', '2019-07-22 21:53:57', 4, 4, '2019-07-08 17:11:37', '2019-07-24 17:08:08', 126, 3, 0, NULL, 693),
(720, 7, '16/2019', '10154.105527/2019-48', 0, 'RECOMENDAÃ‡ÃƒO nÂ° 16/2019 - mediante processo administrativo, realize o desapossamento de todos os imÃ³veis inseridos em terrenos de marinha e/ou acrescidos na localidade da Praia do Gi (lado norte), no municÃ­pio de Laguna, visto que situados em Ã¡rea de preservaÃ§Ã£o permanente e proceda o cancelamento dos RIPs jÃ¡ emitidos, nos termos do art. 9Â°, inciso II a e art. 10, ambos da Lei n. 9.636/98, devendo, ainda, ainda abster-se de deferir inscriÃ§Ã£o de ocupaÃ§Ã£o para imÃ³veis situados naquela localidade.', 'DistribuÃ­do\nVerificar junto ao Superintendente o acatamento da RecomendaÃ§Ã£o.', '2019-06-28', '2019-07-30', '2019-07-17 22:25:07', 8, 3, '2019-07-08 19:17:20', '2019-07-17 22:25:16', 65, 2, 0, NULL, 694),
(721, 1, '137/2019', '04972.008781/2018-81', 0, 'Finalizar o Processo nÂ° 04972.000232/2009-78', 'Concluir o Processo nÂ° 04972.000232/2009-78 atÃ© 23/08/2019. Multa diÃ¡ria : R$ 500,00', '2019-07-02', '2019-08-23', NULL, 4, 4, '2019-07-08 20:15:48', '2019-07-08 20:24:53', 234, 2, 1, NULL, 433),
(725, 1, '00403/2019', '10154.105659/2019-70', 0, 'manifestar interesse em integrar a lide', 'DistribuÃ­do - Em anÃ¡lise', '2019-07-02', '2019-07-12', '2019-07-16 15:54:00', 8, 4, '2019-07-08 21:02:58', '2019-07-17 16:42:15', 121, 3, 0, NULL, 695),
(726, 1, '397/2019', '04972.007122/2017-47', 0, 'apresente a DARF retificada, nos moldes da decisÃ£o transitada em julgado.', 'Enviar Ã  Advocacia-Geral da UniÃ£o um novo Documento de ArrecadaÃ§Ã£o de Receitas Federais (DARF) atualizado pelo Ã­ndice do IPCA-E.\nEncaminhar ao setor tÃ©cnico para emissÃ£o de notificaÃ§Ã£o de atualizaÃ§Ã£o das taxas ao ocupante, o que possibilitarÃ¡ a retomada das cobranÃ§as na forma regular de nossas Plantas de Valores GenÃ©ricos (PVGs).', '2019-07-02', '2019-07-09', '2019-07-15 16:49:06', 4, 4, '2019-07-08 23:08:53', '2019-07-15 16:49:10', 99, 3, 0, NULL, 696),
(727, 1, '995/2016', '04972.004095/2016-70', 0, 'MPF a fim de instruir o Procedimento PreparatÃ³rio 1.33.005.000494/2015-71 solicita informaÃ§Ãµes/documentos sobre os imÃ³veis objeto da presente apuraÃ§Ã£o, notadamente se as Ã¡reas descritas pertencem Ã  UniÃ£o e se abrangem terras de marinha e seus acrescidos.', 'O OfÃ­cio 995/2016 foi respondido pelo OfÃ­cio nÂº 49083/2016-MP. Existe no mesmo processo uma demanda da AGU. Assunto referente a mesma Ã¡rea tambÃ©m estÃ¡ sendo tratado no processo 04972.004071/2016-11, porÃ©m com um nÃºmero de inquÃ©rito diferente.', '2016-06-13', '2016-07-13', '2019-07-12 21:34:56', 17, 3, '2019-07-09 15:37:21', '2019-07-12 21:34:58', 82, 3, 0, NULL, 697),
(728, 1, '2392/2016', '04972.003745/2016-60', 0, 'REQUISITO, em 10DIAS, esclarecimentos sobre a regularidade das obras e ocupaÃ§Ã£o na Ã¡rea, sobretudo se pertence Ã  UNIÃƒO ou a alguma autarquia federal, bem como a delimitaÃ§Ã£o da LPM/1831 no local, a fim de verificar os limites da Ã¡rea de marinha e se as interferÃªncias estÃ£o sendo realizadas sobre Ã¡rea de bem de uso comum do povo. Em caso de confirmaÃ§Ã£o de irregularidade na execuÃ§Ã£o das obras de aterro e construÃ§Ã£o, a S PU deverÃ¡ informar quais medidas pretende adotar no Ã¢mbito de sua competÃªncia.', 'undefined', '2016-05-20', '2016-05-30', NULL, 17, NULL, '2019-07-09 16:01:24', '2019-07-09 16:01:24', 91, 2, 0, NULL, 699),
(729, 1, '616/2019', '04972.007087/2017-66', 1, 'verificar a interferÃªncia com bens da UniÃ£o e adotar medidas fiscalizatÃ³rias e de cadastro - Estrada Geral da Barra do ItapocÃº, Bairro ItapocÃº, em Araquari/SC', 'Verificado que hÃ¡ interferÃªncia com bens da UniÃ£o. Foi solicitado Ã  Cristina e ao Marcelo a reabertura do processo na COCAI para Notificar o interessado para regularizaÃ§Ã£o. Depois deverÃ¡ ser enviada resposta ao MPF.', '2019-05-02', '2019-06-03', '2019-08-09 17:20:09', 8, 3, '2019-07-09 16:09:42', '2019-08-09 17:20:09', 85, 7, 0, NULL, 700),
(730, 1, '1059/2019', '10154.105964/2019-61', 0, 'dÃª cumprimento a sentenÃ§a/acÃ³rdÃ£o proferido no evento 2 SENT 51 e SENT 58 dos autos originÃ¡rios e, evento 6 RELVOTO1 e ACORD2 dos autos em apenso ( recurso de apelaÃ§Ã£o nÂº 5013635-88.2013.4.04.7200), que deu parcial provimento ao apelo da UNIÃƒO e ao reexame necessÃ¡rio e negou provimento Ã  apelaÃ§Ã£o da parte autora, de modo que, de acordo com a sentenÃ§a, foi julgado PROCEDENTE o pedido sucessivo (â€œc3â€) para declarar que os valores corretos referentes ao imÃ³vel (em relaÃ§Ã£o ao terreno de marinha), para efeito do cÃ¡lculo da taxa de ocupaÃ§Ã£o para os anos de 2007 e 2008, sÃ£o, respectivamente, de R$ 261.436,70 e de R$ 583.173,55; e consequente, declarar a nulidade do lanÃ§amento das taxas de ocupaÃ§Ã£o referente a esses exercÃ­cios.', 'undefined', '2019-07-03', NULL, '2019-08-13 20:00:29', 4, 4, '2019-07-09 19:49:03', '2019-08-13 20:00:31', 126, 3, 0, NULL, 701),
(731, 1, '720004898551/2019', '10154.105978/2019-85', 0, 'caso seja localizada ou posteriormente aberta inscriÃ§Ã£o nesse Ã³rgÃ£o federal relativa a Ã¡rea que abarque o imÃ³vel situado na Rua Chile, 40, Capri, SÃ£o Francisco do Sul/SC, identificado pela InscriÃ§Ã£o ImobiliÃ¡ria nÂº 02.01.021.0271.001.01.03, contendo a Ã¡rea de 849,92 mÂ² e situado nas coordenadas identificadas nos documentos anexos, haja imediata anotaÃ§Ã£o do sequestro decretado sobre tal bem.', 'Respondido', '2019-07-03', NULL, '2019-07-17 15:30:59', 4, 4, '2019-07-09 20:15:14', '2019-07-22 19:06:54', 194, 3, 0, NULL, 702),
(732, 2, 'PFN', '10154.105969/2019-94', 0, 'Nos autos do processo acima mencionado, a parte autora, DALVA MARIA SÃ“CRATES (CPF n. 008.080.459-46), responsÃ¡vel pelo imÃ³vel matriculado sob o RIP n. 8221010004318, pretende o reconhecimento do direito Ã  isenÃ§Ã£o de taxa de ocupaÃ§Ã£o prevista no art. 1Âº do Decreto-Lei n. 1.876/81, bem como, por conseguinte a deconstituiÃ§Ã£o dos dÃ©bitos existentes em seu nome atualmente inscritos em DAU. Alega que, desde 2014, jÃ¡ formulou diversos pedidos de reconhecimento do direito Ã  isenÃ§Ã£o perante a SPU (Protocolos n. 04972010318201476 , 04972205703201581, 04972004580201813 e 04972007660201812), mas nunca obteve resposta. Em anexo, segue a petiÃ§Ã£o inicial. \r\nDiante do exposto, para viabilizar manifestaÃ§Ã£o nos autos, indago se, de fato, realmente nÃ£o houve manifestaÃ§Ã£o da SPU sobre o caso em tela. Caso exista alguma manifestaÃ§Ã£o, solicito, se possÃ­vel, seu encaminhamento para juntada aos autos.', 'undefined', '2019-07-09', '2019-07-10', '2019-07-11 20:00:53', 3, 3, '2019-07-09 20:25:51', '2019-07-11 20:00:55', 23, 3, 0, NULL, 703),
(733, 1, '139/2019', '10154.104740/2019-32', 0, 'SubsÃ­dios de Ã  defesa da UniÃ£o.', 'undefined', '2019-07-04', '2019-07-24', '2019-07-16 22:33:02', 4, 3, '2019-07-09 20:58:27', '2019-07-16 22:33:04', 224, 3, 0, NULL, 681),
(734, 1, '1065/2019', '10154.106034/2019-25', 0, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos', 'undefined', '2019-07-04', '2019-07-15', '2019-07-16 15:54:10', 4, 4, '2019-07-09 21:21:07', '2019-07-17 19:35:03', 126, 3, 0, NULL, 704),
(735, 1, '310000047474', '10154.103568/2019-08', 0, 'anotaÃ§Ã£o de indisponibilidade de transferÃªncia do cadastro.', 'Registrada a indisponibilidade.\nRIP n. 8105 0100474-00â€‹.', '2019-06-19', NULL, '2019-07-16 15:55:14', 8, 3, '2019-07-09 22:04:50', '2019-07-25 15:57:57', 296, 3, 1, NULL, 705),
(736, 1, '439/2019', '04972.003319/2016-26', 0, 'MPF solicita que informe quais foram as providÃªncias adotadas/ no Ã¢mbito de seu poder-dever de polÃ­cia administrativa, a partir da notÃ­cia da inexistÃªncia de registros de regularizaÃ§Ã£o da atividade desempenhada pela empresa Lombok ParticipaÃ§Ãµes e Consultoria Empresarial Ltda.', 'pedido de dilaÃ§Ã£o de prazo para resposta  atÃ© a data de 14 de dezembro de 2019.', '2019-04-08', '2019-04-28', NULL, 17, 3, '2019-07-10 17:17:02', '2019-08-13 19:24:57', 85, 2, 0, NULL, 706),
(737, 1, '128/2018', '04972.002867/2018-09', 0, 'informaÃ§Ãµes sobre inscriÃ§Ã£o de ocupaÃ§Ã£o concedida em nome da referida empresa sob os RIPs  8111.0000290-71,  8111.0000370-\r\n90,  8111.0000382-24, e 8111.0000380-05. Tem ofÃ­cio posterior - 5189/2018.', 'undefined', '2018-01-17', '2018-02-01', NULL, 18, NULL, '2019-07-10 17:23:33', '2019-07-10 17:23:33', 91, 2, 0, NULL, 707),
(738, 1, '5189/2018', '04972.002867/2018-09', 0, 'ProvidÃªncias pertinentes ao cancelamento cias inscriÃ§Ãµes de ocupaÃ§Ã£o RIP nÂ° 8111.0000370-0, 8111.0000383-05,\r\n8111.0000290-71 e 8111.0000382-24, haja vista a caracterizaÃ§Ã£o ambiental da Ã¡rea como de preservaÃ§Ã£o permanente, conforme a Nota TÃ©cnica nÂ° 12/2018 - APA Anhatomirim/ICMBio.', 'undefined', '2018-10-22', '2018-08-08', NULL, 18, NULL, '2019-07-10 17:35:22', '2019-07-10 17:35:22', 86, 2, 0, NULL, 707),
(739, 1, '65/2018', '04972.002868/2018-45', 0, 'DesocupaÃ§Ã£o do bem pÃºblico (trapiche), tendo em vista que a Mitra Metropolitana e a AssociaÃ§Ã£o dos Moradores da Costa\r\nLagoa, nÃ£o possuem direito a cessÃ£o de uso (cÃ³pia em anexo) de bem pÃºblico, e tampouco o de deliberar construÃ§Ã£o de estrutura de deck sobre as Ã¡guas da Lagoa,que somente seria autorizado mediante a apresentaÃ§Ã£o de EIA/RIMA (ClÃ¡usula 3a do TAJ) para o seu regular funcionamento.', 'undefined', '2018-01-12', '2018-02-03', NULL, 18, NULL, '2019-07-10 17:42:17', '2019-07-10 17:42:17', 91, 2, 0, NULL, 518),
(740, 1, '138/2019', '04972.008781/2018-81', 0, 'â€œconclusÃ£o do Processo Administrativo protocolado sob o n. 04972.000232.2009-78 referente a CessÃ£o Onerosa de Uso de EspaÃ§o FÃ­sico em Ãguas PÃºblica', 'Aguarda a conclusÃ£o do Processo Administrativo protocolado sob o n. 04972.000232.2009-78 referente a CessÃ£o Onerosa de Uso de EspaÃ§o FÃ­sico em Ãguas PÃºblica', '2019-07-04', '2019-08-23', NULL, 4, 4, '2019-07-10 19:33:58', '2019-07-10 19:37:18', 224, 2, 0, NULL, 433),
(741, 1, '536/2018', '04972.003676/2018-56', 0, 'Informar se o imÃ³vel encontra-se em Ã¡rea de marinha e/ou praia e se estÃ¡ regularizado perante a UniÃ£o.', 'undefined', '2018-02-21', '2019-02-18', NULL, 18, NULL, '2019-07-10 20:32:18', '2019-07-10 20:32:18', 95, 2, 0, NULL, 711),
(742, 1, '283/2018', '04972.004288/2018-92', 0, 'Informar sobre autorizaÃ§Ã£o para ocupaÃ§Ã£o e venda de imÃ³vel situada na Rua ItajaÃ­, fundos LiquigÃ¡s, nÂº 2050, bairro Vorstadt, Blumenau/SC.', 'undefined', '2018-03-23', '2019-04-09', NULL, 18, NULL, '2019-07-10 20:54:00', '2019-07-10 20:54:00', 76, 2, 0, NULL, 714),
(743, 1, '5999/2018', '04972.008945/2018-71', 0, 'Vistoria no Deck 6 Restaurante Ltda., de propriedade de Elvira Campos da Silva, e no Restaurante Vereda Tropical, de propriedade de Paulo CÃ©sar dos Santos, incluindo verificaÃ§Ã£o da regularidade ambiental e patrimonial da ocupaÃ§Ã£o tambÃ©m de terrenos de marinha (existÃªncia de inscriÃ§Ã£o e caracterÃ­sticas ambientais; fixando prazo de 90 dias para a realizaÃ§Ã£o completa das vistorias e elaboraÃ§Ã£o de laudos.', 'undefined', '2018-12-06', '2019-03-06', NULL, 17, 17, '2019-07-10 21:15:21', '2019-07-10 21:15:49', 86, 2, 0, NULL, 642),
(744, 1, '3460/2018', '04972.007715/2018-94', 0, 'MPF requisita adoÃ§Ã£o de medidas para a regularizaÃ§Ã£o da utilizaÃ§Ã£o de rancho de pesca artesanal, tendo em vista possÃ­vel fechamento de acesso de banhistas canal da Barra da Lagoa/FlorianÃ³polis.', 'undefined', '2018-08-09', '2018-08-24', NULL, 17, 17, '2019-07-10 21:34:57', '2019-07-10 21:35:31', 90, 2, 0, NULL, 718),
(745, 1, '797/2018', '04972.007293/2018-57', 0, 'Se a SPU tem conhecimento das ocupaÃ§Ãµes e motivo de nÃ£o ter adotado aÃ§Ãµes para contÃª-las.', 'undefined', '2018-07-13', '2018-07-23', NULL, 18, NULL, '2019-07-10 21:41:36', '2019-07-10 21:41:36', 74, 2, 0, NULL, 719),
(746, 1, '374/2019', '10154.105309/2019-11', 0, 'sobre a regularizaÃ§Ã£o fundiÃ¡ria que serÃ¡ realizada entre os bairros de Vila VitÃ³ria e Ponta das Pedras - Laguna/SC', 'Enviado a CoordenaÃ§Ã£o para manifestaÃ§Ã£o.', '2019-06-28', '2019-07-30', NULL, 8, 8, '2019-07-10 21:42:31', '2019-07-10 21:42:43', 65, 2, 0, NULL, 715);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `seiMP`, `demanda`, `resumoSituacao`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(747, 1, '107/2018', '04972.003321/2018-67', 0, 'MPF encaminha cÃ³pia da decisÃ£o de arquivamento para que adote as medidas que entender cabÃ­veis sobreo caso. Denuncia de de edificaÃ§Ã£o sobre espelho d\'agua, AraÃ§Ã¡ Porto Belo/SC. Procedimento PreparatÃ³rio convertido em InquÃ©rito Civil.', 'undefined', '2018-02-08', NULL, NULL, 17, NULL, '2019-07-10 21:47:43', '2019-07-10 21:47:43', 74, 2, 0, NULL, 720),
(748, 1, '1069/2019', '10154.106313/2019-99', 0, 'ManifestaÃ§Ã£o de Interesse.', 'Respondido', '2019-07-05', '2019-07-19', '2019-07-17 20:21:22', 4, 4, '2019-07-10 21:59:24', '2019-07-22 19:00:58', 114, 3, 0, NULL, 708),
(749, 1, '1062/2019', '04972.206202/2015-11', 0, 'Informa a data da vistoria : 08/07/2019', 'undefined', '2019-07-04', NULL, '2019-07-10 22:22:34', 4, 4, '2019-07-10 22:22:13', '2019-07-10 22:22:35', 126, 3, 0, NULL, 434),
(750, 1, '003/2019', '10154.106511/2019-52', 0, 'subsidiando a defesa da UniÃ£o em juÃ­zo e em especial subsÃ­dios sobre o pedido liminar - Verificar se estÃ¡ em Ã¡rea da UniÃ£o', 'undefined', '2019-07-10', '2019-07-12', '2019-07-11 20:55:15', 3, 4, '2019-07-11 15:22:13', '2019-07-12 20:11:13', 106, 3, 0, NULL, 724),
(751, 1, '141/2019', '10154.106543/2019-58', 0, 'Encaminha Parecer de ForÃ§a ExecutÃ³ria atestando a  forÃ§a executÃ³ria da decisÃ£o do evento 9 (em anexo) e a sua exequibilidade a partir da comprovaÃ§Ã£o nos autos do depÃ³sito do valor integral da multa, por parte do auto, encaminhando-se OfÃ­cio Ã  SPU/SC para que proceda em conformidade com os termos da referida decisÃ£o.', 'Enviado ao NUREP para fornecimento de informaÃ§Ãµes relativas ao registro da transaÃ§Ã£o e Ã  aplicaÃ§Ã£o/cobranÃ§a da multa de averbaÃ§Ã£o.', '2019-07-05', '2019-08-05', '2019-08-26 15:47:03', 4, 4, '2019-07-11 16:21:33', '2019-08-26 15:47:15', 224, 3, 0, NULL, 725),
(752, 1, '1241/2015', '04972.200138/2015-65', 0, 'MPF requisita informaÃ§Ãµes sobre providencias adotadas referente a edificaÃ§Ã£o irregular em faixa de areia no Canto da Feiticeira, Praia dos Ingleses.', 'undefined', '2015-03-03', '2015-03-13', NULL, 17, 17, '2019-07-11 17:23:54', '2019-07-11 17:24:51', 182, 2, 0, NULL, 726),
(753, 1, '140/2019', '04972.003957/2019-90', 0, 'indaga se existe a possibilidade e/ou o interesse de requerer-se ao JuÃ­zo a designaÃ§Ã£o de audiÃªncia judicial conciliatÃ³ria para que, no futuro, eventualmente, possamos apresentar nos autos uma proposta de acordo judicial, dando fim ao processo.', 'undefined', '2019-07-05', '2019-07-19', '2019-08-15 22:13:14', 4, 4, '2019-07-11 20:21:00', '2019-08-15 22:13:14', 234, 7, 0, NULL, 444),
(754, 1, '1080/2019', '04972.010279/2018-31', 0, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', 'undefined', '2019-07-08', '2019-07-25', '2019-07-25 22:18:14', 4, 4, '2019-07-11 20:37:48', '2019-07-26 17:20:36', 126, 3, 0, NULL, 61),
(755, 1, '731/2019', '04972.004684/2016-58', 0, 'que se manifeste a respeito do teor da referida resposta da SuperintendÃªncia Regional em Santa Catarina do DNIT', 'undefined', '2019-07-08', '2019-07-22', '2019-08-28 19:40:24', 4, 3, '2019-07-11 21:38:22', '2019-08-28 19:40:27', 68, 3, 0, NULL, 465),
(756, 1, '328/2019', '04972.004095/2016-70', 0, 'Tendo em vista que no OfÃ­cio nÂº 61344/2017-MP, consta que foi oficiado ao Ã³rgÃ£o ambiental municipal, Ã  prefeitura Municipal e notificados os ocupantes, a AGU solicita informaÃ§Ãµes atualizadas quanto Ã s providÃªncias\r\nadotadas posteriormente, a respeito das ocupaÃ§Ãµes em Ã¡rea da UniÃ£o. Para que possamos responder aos questionamentos do MPF.', 'Em resposta, foi encaminhado o OfÃ­cio nÂº 45183/2019/DIGES-SPU-SC/MP, informando que o processo encontra-se relacionado para fiscalizaÃ§Ã£o no perÃ­odo de 07/10/2019 a 11/10/2019, constante do Plano Anual Estadual de FiscalizaÃ§Ã£o - PAEF 2019, inserido no processo 04972.001058/2019-52.', '2019-05-23', '2019-06-03', NULL, 3, 3, '2019-07-12 21:26:06', '2019-07-12 21:26:55', 106, 2, 0, NULL, 728),
(759, 1, '434/2019', '04972.008389/2018-32', 0, 'Encaminha Nota Juridica CJU-Orientando Indeferir os requerimentos de aforamento.', 'Demanda duplicada', '2019-07-01', NULL, '2019-07-22 20:14:36', 4, 1, '2019-07-12 21:37:39', '2019-07-22 20:14:37', 108, 3, 0, NULL, 332),
(760, 1, '1092/2019', '04972.000971/2017-70', 0, 'Informa a data da perÃ­cia.', 'undefined', '2019-07-09', '2019-07-23', '2019-07-12 21:50:56', 4, 1, '2019-07-12 21:50:34', '2019-07-30 22:52:56', 126, 3, 0, NULL, 222),
(761, 5, '0016064-53.2002.8.24.0008-0009', '10154.106881/2019-90', 0, 'penhora dos direitos de ocupaÃ§Ã£o sobre o imÃ³vel de marinha registrado sobre o RIP 8265 0001168-59', 'Registrado.', '2019-07-05', NULL, '2019-07-16 15:55:00', 8, 4, '2019-07-12 22:01:04', '2019-07-19 20:04:18', 297, 3, 1, NULL, 729),
(762, 2, '01', '04972.010874/2018-76', 1, 'subsÃ­dios em relaÃ§Ã£o Ã  alegaÃ§Ã£o da empresa nÃ£o ser a responsÃ¡vel pelos dÃ©bitos.', 'DistribuÃ­do - Em anÃ¡lise no setor de receitas.', '2018-12-17', '2019-01-30', NULL, 8, 8, '2019-07-15 15:26:14', '2019-07-15 15:26:22', 298, 2, 0, NULL, 730),
(763, 1, '720004889257', '10154.106989/2019-82', 0, 'prorrogaÃ§Ã£o da data final da doaÃ§Ã£o do imÃ³vel (Conjunto Habitacional Ernesto Che Guevara) da UniÃ£o ao MunicÃ­pio de Tijucas/SC', 'O assunto estÃ¡ em tratamento no protocolo SEI-MP n. 04972.007046/2013-46.', '2019-07-11', NULL, '2019-07-15 16:08:34', 8, 8, '2019-07-15 16:07:49', '2019-07-15 16:08:35', 240, 3, 1, NULL, 91),
(764, 1, '731/2017', '04972.004684/2016-58', 1, 'que se manifeste a respeito do teor da resposta da SuperintendÃªncia Regional em Santa Catarina do DNIT, a qual segue anexada ao presente.', 'undefined', '2019-07-04', '2019-07-26', '2019-08-28 19:41:14', 3, 3, '2019-07-15 20:21:35', '2019-08-28 19:41:16', 68, 3, 0, NULL, 465),
(765, 1, '1083/2019', '10154.107112/2019-17', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', 'Respondido', '2019-07-09', '2019-07-16', '2019-07-17 14:21:15', 4, 3, '2019-07-15 21:40:58', '2019-07-17 15:05:19', 114, 3, 0, NULL, 732),
(766, 1, '988/2019', '10154.107136/2019-68', 0, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', 'Respondido', '2019-07-09', '2019-07-23', '2019-07-29 16:48:31', 4, 4, '2019-07-15 22:07:26', '2019-07-29 16:48:35', 100, 3, 0, NULL, 733),
(767, 1, '986/2019', '04972.003553/2019-04', 0, 'Encaminha o PARECER DE FORÃ‡A EXECUTÃ“RIA n. 00103/2019/PSUCCO/PGU/AGU', 'undefined', '2019-07-09', NULL, NULL, 4, NULL, '2019-07-15 22:40:22', '2019-07-15 22:40:22', 100, 2, 0, NULL, 382),
(768, 1, '945/2019', '04972.006628/2016-58', 0, 'Enviar comprovante do cumprimento das decisÃµes. Cercamento da Ã¡rea e PRAD . Processos: 04972.003337/2019-51 e 04972.003521/2019-09', 'Enviar comprovante do cumprimento das decisÃµes atÃ© 15/08/2019. Cercamento da Ã¡rea e PRAD . Processos: 04972.003337/2019-51 (compra do material) e 04972.003521/2019-09 (cronograma de execuÃ§Ã£o/vistorias do PRAD)', '2019-07-09', '2019-08-15', '2019-08-14 21:22:06', 4, 3, '2019-07-16 16:56:37', '2019-08-14 21:38:18', 100, 3, 1, NULL, 682),
(769, 1, '1101/2019', '10154.107398/2019-22', 0, 'solicita que dÃª cumprimento ao acÃ³rdÃ£o que deu parcial provimento a apelaÃ§Ã£o para reduzir o valor do domÃ­nio Ãºtil do imÃ³vel com base no laudo pericial (determinar que a taxa de ocupaÃ§Ã£o seja calculada com base no valor do domÃ­nio Ãºtil apresentado pelo perito, quais sejam: R$ 1.193.717,25 para 2007; R$ 1.318.816,41 para 2008; R$ 1.306.591,19 para 2009; R$ 1.362.358,28 para 2010; R$ 3.617.325,00 para 2011; R$ 6.447.546,88 para 2012; R$ 6.799.231,25 para 2013; R$ 7.349.366,09 para 2014; R$ 8.467.889,88 para 2015), e condenar a UniÃ£o Ã  devoluÃ§Ã£o dos valores eventualmente pagos a maior pela parte autora a tÃ­tulo de taxa de ocupaÃ§Ã£o de terreno de marinha.', 'Enviado Ã  CoordenaÃ§Ã£o para cumprimento.', '2019-07-10', NULL, '2019-09-04 17:01:10', 4, 23, '2019-07-16 20:34:53', '2019-09-04 17:46:49', 126, 3, 0, NULL, 734),
(770, 1, '1098/2019', '04972.003502/2019-74', 0, 'que seja desconsiderado o OFÃCIO n.00756/2019/PROT/PUSC/PGU/AGU, uma vez que os documentos em anexo comprovam a ausÃªncia de interesse da UniÃ£o.', 'undefined', '2019-07-10', NULL, '2019-07-16 21:18:13', 4, 4, '2019-07-16 20:46:50', '2019-07-16 21:18:14', 126, 3, 0, NULL, 364),
(771, 1, '1097/2019', '04972.006867/2018-70', 0, 'encaminha  decisÃ£o proferida nos autos em epÃ­grafe, que agasalhou a tese sustentada pela UniÃ£o, qual seja, de que tese da exequente parte de premissa equivocada, visto que o objeto do mandamus, sob o qual se instaurou a controvÃ©rsia, diz respeito Ã  ilegalidade da majoraÃ§Ã£o promovida no valor das Taxas de OcupaÃ§Ã£o para o exercÃ­cio de 2007 (EVENTO 16). Diante disso, prevaleceu o entendimento da UniÃ£o (forÃ§a executÃ³ria) de que o objeto da causa diz respeito apenas ao ano de 2007, no que permanece hÃ­gida a cobranÃ§a da SPU pelos critÃ©rios que entendeu adequados relacionada aos demais anos', 'undefined', '2019-07-10', NULL, NULL, 4, 4, '2019-07-16 21:14:51', '2019-07-16 21:16:31', 114, 2, 0, NULL, 326),
(772, 1, '1458/2018', '04972.010275/2018-52', 0, 'ManifestaÃ§Ã£o de interesse.', 'undefined', '2018-11-12', '2018-11-27', '2019-07-16 21:28:18', 4, 4, '2019-07-16 21:27:05', '2019-07-16 21:28:20', 100, 3, 0, NULL, 735),
(773, 1, '275/2019', '10154.107421/2019-89', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-16', '2019-07-23', '2019-07-17 22:24:14', 4, 3, '2019-07-16 21:36:20', '2019-07-18 14:57:40', 121, 3, 0, NULL, 736),
(774, 1, '1458/2019', '10154.107421/2019-89', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-11', '2019-08-02', NULL, 4, 4, '2019-07-16 21:44:17', '2019-07-16 21:59:43', 100, 4, 0, NULL, 736),
(775, 1, '7/2019', '04972.010275/2018-52', 0, 'manifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-11', '2019-08-02', '2019-08-08 17:21:39', 4, 4, '2019-07-16 22:02:00', '2019-08-08 17:21:40', 234, 3, 0, NULL, 735),
(776, 1, '0971', '10154.107287/2019-16', 0, 'manifestar, de modo especÃ­fico, seu interesse no feito', 'Respondido Ã  AGU.\nEncaminhado ao nÃºcleo de fiscalizaÃ§Ã£o para incluir na rotina de fiscalizaÃ§Ã£o.', '2019-07-04', '2019-07-24', '2019-07-25 15:35:22', 8, 8, '2019-07-17 15:02:44', '2019-07-25 15:38:43', 100, 2, 0, NULL, 737),
(777, 1, '4/2019', '10154.101221/2019-12', 0, 'informaÃ§Ãµes complementares quanto Ã  demarcaÃ§Ã£o/homologaÃ§Ã£o da LPM/1831.', 'undefined', '2019-07-11', '2019-08-12', '2019-08-09 21:25:30', 4, 4, '2019-07-17 19:53:20', '2019-08-12 16:42:38', 224, 3, 0, NULL, 607),
(778, 1, '414/2019', '10154.107622/2019-86', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-11', '2019-07-31', '2019-08-06 15:34:59', 4, 4, '2019-07-17 20:12:10', '2019-08-08 19:42:49', 121, 3, 0, NULL, 738),
(779, 1, '392/2019', '10154.105317/2019-50', 0, 'informar quais medidas foram tomadas, conforme estabelecido na RecomendaÃ§Ã£o n. 07/2017.', 'Respondido - a fiscalizaÃ§Ã£o da Ã¡rea estÃ¡ agendada para o dia 23/07/2019.\nAssunto tratado no processo n. 04972.002129/2017-72', '2019-07-03', '2019-07-23', '2019-07-17 20:15:33', 8, 4, '2019-07-17 20:15:16', '2019-07-22 19:03:36', 65, 3, 0, NULL, 456),
(780, 1, '996/2019', '04972.008736/2018-27', 0, 'que acostem relatÃ³rios trimestrais aos autos acerca das atividades realizadas ao longo do corrente ano, conforme cronograma apresentado, sem prejuÃ­zo de que mantenham a regularidade das fiscalizaÃ§Ãµes ao longo das margens do Rio ItajaÃ­-AÃ§Ãº, como determinado em sentenÃ§a.', 'ApresentaÃ§Ã£o de relatÃ³rios trimestrais aos autos acerca das atividades realizadas ao longo do corrente ano\r\nFoi encaminhado o OfÃ­cio 54359/2019 (8845177) informando as datas da fiscalizaÃ§Ã£o no perÃ­odos de 16 a 20/09/2019 e 02 a 06/12/2019, que deverÃ¡ ser submetido ao JuÃ­zo para concordÃ¢ncia.', '2019-07-11', NULL, NULL, 4, 3, '2019-07-17 20:28:19', '2019-08-13 15:59:14', 100, 2, 1, NULL, 739),
(781, 1, '2/2019', '10154.107649/2019-79', 0, 'ManifestaÃ§Ã£o de Interesse', 'Respondido', '2019-07-11', '2019-07-29', '2019-07-29 21:13:08', 4, 4, '2019-07-17 21:33:10', '2019-08-01 17:26:03', 99, 3, 0, NULL, 741),
(782, 1, '018/2019', '10154.107608/2019-82', 0, 'informar se estÃ¡ inserido em Ã¡rea pertencente Ã  UniÃ£o ou em Ãrea de Marinha ou seus acrescidos o terreno que estÃ¡ servindo de estacionamento, localizado no interior da gleba Ratones da ESEC CarijÃ³s, junto aos seus limites confrontantes com a ocupaÃ§Ã£o existente no BalneÃ¡rio Daniela, acesso pelas rodovias SC-402, SC-400', 'DistribuÃ­do - Em anÃ¡lise', '2019-07-15', '2019-08-16', '2019-08-21 20:03:22', 8, 3, '2019-07-17 21:42:02', '2019-08-21 20:03:24', 245, 3, 0, NULL, 742),
(783, 1, '5/2019', '04972.004075/2016-07', 0, 'foi deferido o prazo de mais 30 (trinta) dias em favor da UniÃ£o para a apresentaÃ§Ã£o das informaÃ§Ãµes sobre a conclusÃ£o do processo administrativo n. 04972003727201840, protocolizado pelo MunicÃ­pio de SÃ£o JosÃ©, sobre os dados dos imÃ³veis em terras de marinha, localizados entre a foz do Rio Maruim e foz do Rio AraÃºjo', 'undefined', '2019-07-11', '2019-08-19', NULL, 4, NULL, '2019-07-17 21:49:01', '2019-07-17 21:49:01', 234, 2, 0, NULL, 419),
(784, 1, '00006/2019', '10154.107684/2019-98', 0, 'manifestar interesse no feito', 'DistribuÃ­do - em anÃ¡lise.', '2019-07-11', '2019-08-02', '2019-08-06 15:13:32', 8, 4, '2019-07-18 16:29:41', '2019-08-12 16:37:12', 99, 3, 0, NULL, 744),
(785, 1, '725/2019', '04972.003492/2016-24', 1, 'Solicita, em reiteraÃ§Ã£o ao OfÃ­cio nÂ° 419/2019. que informe se o imÃ³vel encontra-se devidamente incorporado ao patrimÃ´nio da UniÃ£o, sob tutela desta Secretaria e, caso positivo, que informe em que estÃ¡gio se encontra o processo e as tratativas para transferÃªncia do bem ao MunicÃ­pio de CriciÃºma, conforme anteriormente informado no RelatÃ³rio de Vistoria.', 'Foi solicitado ao Tullio que reabrisse o processo na DIINC', '2019-06-27', '2019-08-01', NULL, 3, 3, '2019-07-18 20:05:57', '2019-07-18 20:06:47', 299, 2, 0, NULL, 746),
(786, 1, '0003779-51.2013.8.24.0005', '10154.107738/2019-15', 0, 'NÃ£o hÃ¡ ordem judicial para cumprir, o presente veio apenas para ciÃªncia,improcedente o pedido de nulidade e cancelamento da Escritura PÃºblica que transferiu o imÃ³vel cadastrado sob o RIP 8039 0103375-38.', 'Apenas para conhecimento', '2019-07-17', NULL, '2019-07-19 19:15:46', 8, 8, '2019-07-18 20:27:20', '2019-07-19 19:15:50', 301, 3, 1, NULL, 745),
(787, 1, '1846/2019', '10154.108492/2019-07', 0, 'informe se a Ã¡rea objeto do presente apuratÃ³rio, localizada nas coordenadas geogrÃ¡ficas aproximadas de 26Â°19\"07.71\"S/ 48Â°48\"38.53\"0, efetivamente integra o patrimÃ´nio da UniÃ£o ou interfere com terras de marinha e acrescidos e se sua ocupaÃ§Ã£o encontra-se devidamente autorizada.', 'undefined', '2019-07-11', '2019-07-30', '2019-08-15 22:19:41', 4, 3, '2019-07-19 21:23:57', '2019-08-15 22:19:41', 289, 7, 0, NULL, 747),
(788, 1, '415/2019', '10154.108508/2019-73', 0, 'ManifestaÃ§Ã£o sobre perÃ­cia.', 'undefined', '2019-07-11', '2019-08-02', '2019-08-06 16:35:21', 4, 4, '2019-07-19 21:49:05', '2019-08-12 16:30:59', 99, 3, 0, NULL, 748),
(789, 1, '1172/2019', '04972.001310/2019-23', 0, 'UsucapiÃ£o - ManifestaÃ§Ã£o de interesse', 'undefined', '2019-07-19', '2019-07-24', '2019-07-25 22:20:32', 3, 4, '2019-07-22 16:34:25', '2019-07-26 17:18:32', 114, 3, 0, NULL, 749),
(790, 1, '116/2019', '10154.108942/2019-53', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-12', '2019-07-31', '2019-08-06 15:08:42', 4, 4, '2019-07-22 17:07:19', '2019-08-06 20:23:24', 114, 3, 0, NULL, 753),
(799, 1, '378/2019', '10154.108966/2019-11', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-15', '2019-07-31', '2019-07-31 19:33:17', 4, 3, '2019-07-22 17:29:30', '2019-08-01 15:19:28', 302, 3, 0, NULL, 755),
(800, 1, '117/2019', '04972.202317/2015-37', 0, 'ManifestaÃ§Ã£o sobre laudo complementar.', 'undefined', '2019-07-12', '2019-07-31', '2019-07-25 22:17:23', 4, 4, '2019-07-22 19:35:02', '2019-07-26 17:27:29', 114, 3, 0, NULL, 167),
(801, 1, '419/2019', '10154.109099/2019-22', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.', 'undefined', '2019-07-12', '2019-07-29', '2019-08-06 22:35:01', 4, 4, '2019-07-22 20:03:25', '2019-08-12 16:24:01', 99, 3, 0, NULL, 757),
(802, 2, 'PFN', '10154.109096/2019-99', 0, 'Saber se esses valores depositados judicialmente e posteriormente transformados em pagamento definitivo foram abatidos dos valores inscritos em dÃ­vida ativa ou qualquer outra informaÃ§Ã£o relevante para a defesa da UniÃ£o no caso.', 'undefined', '2019-07-18', '2019-07-26', '2019-07-26 17:18:47', 3, 3, '2019-07-22 20:19:22', '2019-08-29 20:58:35', 303, 3, 0, NULL, 759),
(803, 1, '8/2019', '10154.109110/2019-54', 0, 'Enviar cÃ³pia do Processo nÂº  04972.003717/2017-23', 'undefined', '2019-07-12', '2019-07-25', '2019-08-02 16:13:14', 4, 3, '2019-07-22 20:28:32', '2019-08-02 16:13:16', 234, 3, 0, NULL, 761),
(804, 1, '2206/2019', '04972.001477/2010-56', 1, 'avaliar proposta de acordo para ajuste de conduta', 'O que Ã©: MPF instaurou processo para verificaÃ§Ã£o da regularidade de ocupaÃ§Ã£o (trapiche) na Praia do Riso, em Coqueiros, FlorianÃ³polis-SC.\r\n\r\nO que foi feito: vistoria apurou que a ocupaÃ§Ã£o Ã© irregular e processo caminhou atÃ© a conclusÃ£o pela demoliÃ§Ã£o do trapiche.\r\n\r\nO que falta fazer: avaliar a proposta de ajuste de conduta apresentada pelo administrado.', '2019-05-17', '2019-06-17', '2019-07-25 17:42:36', 1, 1, '2019-07-22 20:57:53', '2019-07-25 17:42:37', 95, 3, 0, NULL, 345),
(805, 1, '424/2019', '04972.003869/2019-98', 0, 'atÃ© o prazo da contestaÃ§Ã£o, promova a anÃ¡lise do pedido (requerimento/processo administrativo sob o nÂº 10983003074/85-61 - RIP 81.61.0100112-36), dando resposta ao mÃ©rito da pretensÃ£o, sob pena de fixaÃ§Ã£o de multa diÃ¡ria em caso de descumprimento da ordem', 'Finalizar o Processo nÂº 10983.003074/8561 e enviar comprovaÃ§Ã£o atÃ© 02/09/2019. Multa diÃ¡ria', '2019-07-15', '2019-07-29', '2019-08-01 15:29:44', 4, 3, '2019-07-22 21:20:23', '2019-08-01 15:29:46', 201, 3, 1, NULL, 430),
(806, 2, '8824383', '04972.002031/2017-15', 0, 'subsÃ­dios Ã  SPU para eventual apelaÃ§Ã£o da sentenÃ§a, ou seja, se hÃ¡ argumentos que invalidam os fundamentos da sentenÃ§a, no sentido de que a Ã¡rea de preservaÃ§Ã£o permanente nÃ£o pode ser considerada para fins de incidÃªncia da taxa de ocupaÃ§Ã£o.', 'Em anÃ¡lise.', '2019-07-18', '2019-08-16', '2019-08-21 20:24:03', 8, 4, '2019-07-22 21:23:36', '2019-08-21 20:24:04', 233, 3, 0, NULL, 762),
(807, 1, '423/2019', '04972.206199/2015-36', 0, 'a) comprove o cancelamento do lanÃ§amento do ano de 2019; ou\r\nb) traga informaÃ§Ã£o acerca da existÃªncia de novo procedimento de demarcaÃ§Ã£o da Ã¡rea objeto desta aÃ§Ã£o, bem\r\ncomo a incidÃªncia dessa Ã¡rea em terreno de marinha e consequente notificaÃ§Ã£o pessoal dirigida ao ocupante. O preenchimento\r\ndesses critÃ©rios denotarÃ¡ que a cobranÃ§a de 2019 Ã© devida; e\r\nc) demonstre as providÃªncias adotadas, seja por anotaÃ§Ã£o nos procedimentos administrativos ou em seu sistema\r\neletrÃ´nico, aptas a prevenir nova emissÃ£o de cobranÃ§a indevida, se for o caso.', 'O que Ã©:\r\nNulidade de demarcaÃ§Ã£o.\r\n\r\nO que falta fazer:\r\n1) Cancelar as utilizaÃ§Ãµes dos imÃ³veis no sistema SIAPA ou, caso seja impossÃ­vel realizar os registros, solicitar ao Ã“rgÃ£o Central a realizaÃ§Ã£o de Acerto Manual que cancele as utilizaÃ§Ãµes dos imÃ³veis no sistema SIAPA;\r\n2) Promover nova demarcaÃ§Ã£o e novo cadastramento dos imÃ³veis.', '2019-07-15', '2019-07-29', '2019-08-08 21:30:18', 4, 3, '2019-07-22 21:53:42', '2019-08-08 21:30:28', 121, 3, 1, NULL, 763),
(808, 1, '422/2019', '10154.109226/2019-93', 0, 'anÃ¡lise e manifestaÃ§Ã£o quanto a existÃªncia de eventual regularidade da propriedade , para subsidiar a defesa da UniÃ£o.', 'undefined', '2019-07-15', '2019-08-15', '2019-08-06 22:30:13', 4, 3, '2019-07-22 22:44:21', '2019-08-07 21:00:57', 121, 3, 0, NULL, 765),
(809, 1, '1124/2019', '10154.109407/2019-10', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-15', '2019-08-06', '2019-08-12 16:57:32', 4, 4, '2019-07-23 16:25:54', '2019-08-12 21:28:07', 126, 3, 0, NULL, 766),
(810, 1, '3011/2019', '10154.109062/2019-02', 0, 'RequisiÃ§Ã£o de fiscalizaÃ§Ã£o da construÃ§Ã£o da nova ponte sobre o Canal da Barra da Lagoa, nesta Capital/SC, em especial, para verificar a ocorrÃªncia de novos danos ambientais na Ã¡rea de preservaÃ§Ã£o permanente localizada sobre terreno de marinha.', 'Realizar FiscalizaÃ§Ã£o.\nPedido dilaÃ§Ã£o de prazo atÃ© 13/09/2019', '2019-07-17', '2019-07-31', NULL, 8, 8, '2019-07-23 16:31:30', '2019-08-06 15:20:25', 90, 2, 0, NULL, 768),
(811, 1, '1123/2019', '10154.109463/2019-54', 0, 'calcular e informar os montantes equivalentes a tÃ­tulo de taxa de ocupaÃ§Ã£o para o imÃ³vel, tendo como marco inicial os noventa dias apÃ³s o recebimento da notificaÃ§Ã£o administrativa da SPU (fls. 93 e 94, Evento 1, PROCADM2) atÃ© a data da imissÃ£o da posse da UniÃ£o (1-11-2018, como consta da CertidÃ£o do Evento 187 dos auto', 'Enviado Ã  CoordenaÃ§Ã£o para calcular a indenizaÃ§Ã£o.', '2019-07-15', '2019-08-02', '2019-08-06 15:47:22', 4, 4, '2019-07-23 16:52:10', '2019-08-06 20:07:19', 114, 3, 0, NULL, 769),
(812, 1, '10/2019', '04972.006506/2017-42', 0, 'Encaminha Parecer de ForÃ§a ExecutÃ³ria referente Ã  aÃ§Ã£o nÂº  5001116-71.2019.404.7200', 'undefined', '2019-07-15', NULL, NULL, 4, NULL, '2019-07-23 17:07:39', '2019-07-23 17:07:39', 234, 1, 0, NULL, 156),
(813, 1, '1122/2019', '10154.109498/2019-93', 0, 'ManifestaÃ§Ã£o quanto a proposta de acordo.', 'undefined', '2019-07-15', '2019-08-02', '2019-08-06 15:41:20', 4, 4, '2019-07-23 17:22:52', '2019-08-06 20:10:13', 114, 3, 0, NULL, 771),
(814, 1, '1120/2019', '10154.109595/2019-86', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-15', '2019-08-06', NULL, 4, NULL, '2019-07-23 19:02:04', '2019-07-23 19:02:04', 114, 2, 0, NULL, 772),
(815, 1, '1141/2019', '10154.109604/2019-39', 0, 'manifeste-se conclusivamente acerca da possibilidade de aderir ao acordo entabulado no evento 33 dos autos', 'DistribuÃ­do - Em anÃ¡lise.\nTratativas de regularizaÃ§Ã£o do espaÃ§o no processo n. 04972.008380/2018-21.', '2019-07-16', '2019-07-31', '2019-07-25 14:57:38', 4, 4, '2019-07-23 19:48:04', '2019-07-29 17:23:32', 126, 3, 0, NULL, 774),
(816, 1, '1140/2019', '10154.109616/2019-63', 0, 'SUBSÃDIOS DE FATO E DE DIREITO PARA A DEFESA DA UNIÃƒO\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-16', '2019-08-06', '2019-08-12 16:54:58', 4, 4, '2019-07-23 20:23:13', '2019-08-12 22:38:23', 126, 3, 0, NULL, 775),
(817, 1, '1138/2019', '10154.109660/2019-73', 0, 'SUBSÃDIOS DE FATO E DE DIREITO PARA A DEFESA DA UNIÃƒO\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-16', '2019-08-06', '2019-08-12 16:57:42', 4, 4, '2019-07-23 20:35:38', '2019-08-13 20:19:25', 126, 3, 0, NULL, 777),
(818, 1, '1137/2019', '10154.109686/2019-11', 0, 'SUBSÃDIOS DE FATO E DE DIREITO PARA A DEFESA DA UNIÃƒO\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-16', '2019-08-06', '2019-08-12 16:57:20', 4, 4, '2019-07-23 20:50:28', '2019-08-13 20:12:04', 126, 3, 0, NULL, 778),
(819, 6, 'n/i', '10154.109711/2019-67', 0, 'SubsÃ­dios Ã¡ defesa da UniÃ£o.', 'undefined', '2019-07-16', '2019-08-02', '2019-07-25 22:21:51', 4, 4, '2019-07-23 21:18:06', '2019-07-26 17:30:32', 277, 3, 0, NULL, 779),
(820, 1, '1133/2019', '10154.109732/2019-82', 0, 'ConcessÃ£o de o prazo de 90 dias para o municÃ­pio cumprir a decisÃ£o e para reduzir a multa aplicada. Por fim, informo que mesmo que a UniÃ£o seja rÃ© no feito, nÃ£o hÃ¡ nenhum comando judicial propriamente em face do ente federal.', 'undefined', '2019-07-16', NULL, '2019-07-23 21:29:05', 4, 4, '2019-07-23 21:28:47', '2019-07-23 21:29:06', 114, 3, 0, NULL, 78),
(821, 1, '1132/2019', '04972.205757/2015-46', 0, 'informaÃ§Ãµes atualizadas quanto aos desdobramentos das medidas para a demoliÃ§Ã£o do imÃ³vel aludidas no ofÃ­cio n. 22663/2019/SPU-SC.', 'undefined', '2019-07-16', '2019-08-06', NULL, 4, 4, '2019-07-23 22:02:30', '2019-07-23 22:02:58', 114, 2, 0, NULL, 7),
(822, 6, 'COTA n. 02968/2019/PGFN/AGU', '00745.002778/2019-68', 0, 'informaÃ§Ãµes e documentos sobre o caso, no Ã¢mbito de suas atribuiÃ§Ãµes, os quais devem ser remetidos a esta Consultoria JurÃ­dica - execuÃ§Ã£o fiscal movida pelo MUNICÃPIO DE TUBARÃƒO em face da Rede FerroviÃ¡ria Federal SA - RFFSA, sucedida pela UNIÃƒO, objetivando a cobranÃ§a de IPTU sobre o imÃ³vel descrito na CertidÃ£o de DÃ­vida Ativa', 'undefined', '2019-07-02', '2019-07-09', '2019-07-24 20:20:06', 3, 3, '2019-07-24 16:12:03', '2019-07-31 19:52:45', 305, 3, 0, NULL, 780),
(823, 1, '1130/2019', '04972.204526/2015-15', 0, 'Informa que os pedidos da parte autora foram julgados improcedentes, nos termos da SentenÃ§a que segue em anexo, a qual tambÃ©m revogou a tutela provisÃ³ria antes concedida em favor da autora que determinava a suspensÃ£o das medidas de cobranÃ§a do dÃ©bito', 'undefined', '2019-07-16', NULL, NULL, 4, NULL, '2019-07-24 19:21:24', '2019-07-24 19:21:24', 114, 2, 0, NULL, 781),
(824, 1, '2981/2019', '10154.110328/2019-51', 0, 'seja informado se pertence Ã  UniÃ£o o imÃ³vel localizado na faixa entre 5m da linha da extinta Rede FerroviÃ¡ria Federal S/A (RFFSA) e a 15m da margem esquerda do Rio do Peixe (curso de Ã¡gua com largura de aproximadamente 70m), nas imediaÃ§Ãµes da Rua EugÃªnio Fantin, Bairro CibrazÃ©m, em Videira/SC, local mais precisamente situado na coordenada UTM (22J) Leste 483631,589; Norte 7013169,413', 'DistribuÃ­do - Em anÃ¡lise', '2019-07-16', '2019-08-07', '2019-08-09 21:46:26', 4, 4, '2019-07-24 19:45:29', '2019-08-09 21:46:28', 306, 3, 0, NULL, 782),
(825, 1, '11/2019', '10154.110339/2019-31', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-16', '2019-08-15', '2019-08-09 21:09:54', 4, 4, '2019-07-24 20:11:02', '2019-08-12 16:49:15', 224, 3, 0, NULL, 783),
(826, 1, '472/2019', '10154.110366/2019-12', 0, 'providencie a realizaÃ§Ã£o de vistoria na Praia do Porto, no municÃ­pio de Imbituba, a fim de verificar se os ranchos de pesca lÃ¡ construÃ­dos (ou o rancho de pesca coletivo), sÃ£o utilizados por pescadores artesanais, e portanto, possuem os requisitos necessÃ¡rios para receberem ligaÃ§Ã£o de energia elÃ©trica e TAUS', 'undefined', '2019-07-17', '2019-08-30', NULL, 4, NULL, '2019-07-24 20:32:09', '2019-07-24 20:32:09', 65, 2, 0, NULL, 784),
(827, 1, '1155/2019', '10154.110375/2019-03', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-17', '2019-08-05', '2019-08-07 19:46:22', 4, 4, '2019-07-24 20:42:56', '2019-08-08 19:28:27', 114, 3, 0, NULL, 785),
(828, 1, '1153/2019', '10154.110389/2019-19', 0, 'ManifestaÃ§Ã£o de Interesse.', 'Em anÃ¡lise.', '2019-07-17', '2019-07-31', '2019-08-06 15:24:18', 4, 4, '2019-07-24 21:23:09', '2019-08-06 20:14:35', 126, 3, 0, NULL, 786),
(829, 1, '1152/2019', '10154.110447/2019-12', 0, 'SUBSÃDIOS DE FATO E DE DIREITO PARA A DEFESA DA UNIÃƒO\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:56:23', 4, 4, '2019-07-24 21:45:16', '2019-08-12 22:43:44', 126, 3, 0, NULL, 787),
(830, 1, '431/2019', '10154.110478/2019-65', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:56:09', 4, 4, '2019-07-24 22:10:54', '2019-09-04 22:50:51', 121, 3, 0, NULL, 788),
(831, 1, '430/2019', '10154.110525/2019-71', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:55:37', 4, 4, '2019-07-24 23:28:53', '2019-09-04 22:55:20', 121, 3, 0, NULL, 789),
(832, 1, '429/2019', '10154.110529/2019-59', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:55:26', 4, 4, '2019-07-24 23:46:28', '2019-09-04 23:03:41', 121, 3, 0, NULL, 790),
(833, 1, '428/2019', '10154.110537/2019-03', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:55:07', 4, 4, '2019-07-25 00:12:56', '2019-09-04 20:47:44', 121, 3, 0, NULL, 791),
(834, 1, '427/2019', '10154.110844/2019-86', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:56:36', 4, 4, '2019-07-25 19:05:00', '2019-09-04 22:42:05', 121, 3, 0, NULL, 792),
(835, 1, '426/2019', '10154.110847/2019-10', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:56:47', 4, 4, '2019-07-25 19:13:41', '2019-09-04 22:31:39', 121, 3, 0, NULL, 794),
(836, 1, '425/2019', '10154.110852/2019-22', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.\r\nAcesso Ã  praia Governador Celso Ramos', 'DistribuÃ­do', '2019-07-17', '2019-08-06', '2019-08-12 16:57:08', 4, 4, '2019-07-25 19:30:36', '2019-09-04 21:23:41', 121, 3, 0, NULL, 795),
(837, 1, '14/2019', '10154.104740/2019-32', 0, 'Acusa o recebimento do OfÃ­cio SEI NÂº 6/2019/NUJUC/SPU-SC/SPU/SEDD-ME, acompanhado de email com link de acesso ao processo administrativo 10983.002541/8761 e da InstruÃ§Ã£o Normativa nÂº 4, de 14 de agosto de 2018 (SEI nÂº 864747), e informa juntada aos autos do processo judicial em epÃ­grafe dentro do prazo em curso (evento 19), em atenÃ§Ã£o Ã  solicitaÃ§Ã£o.', 'undefined', '2019-07-17', NULL, '2019-07-25 19:42:34', 4, 4, '2019-07-25 19:42:16', '2019-07-25 19:42:35', 234, 3, 0, NULL, 681),
(838, 1, '245/2019', '04972.005484/2016-12', 0, 'questiona-se, para fins de celebraÃ§Ã£o de acordo judicial:\na) Ã© viÃ¡vel o recebimento da prÃ³pria plataforma (pier) como daÃ§Ã£o em pagamento pelos valores\ndevidos pela ocupaÃ§Ã£o ilÃ­cita?\nb) existe possibilidade de eventual cessÃ£o do bem a particulares, seja para a prÃ³pria associaÃ§Ã£o ou para\noutros, com ou sem processo licitatÃ³rio?\nc) quais seriam eventuais impeditivos ou riscos do recebimento do bem pela UniÃ£o?\nd) Haveria alguma forma de manutenÃ§Ã£o da propriedade do bem com a AssociaÃ§Ã£o, desde que\natendidas determinadas condiÃ§Ãµes?\ne) Qual seria, nesse caso, a modalidade de uso do bem pÃºblico praia?\nf) Como Ã© que sÃ£o cedidos regularmente os espaÃ§os para outras plataformas de pesca no litoral\ncatarinense ou em outras localidades do Brasil?', 'undefined', '2019-07-18', '2019-08-16', NULL, 4, 4, '2019-07-25 20:37:29', '2019-07-25 20:45:01', 264, 2, 0, NULL, 796),
(839, 1, '454/2019', '10154.110887/2019-61', 0, 'informe se houve emissÃ£o de inscriÃ§Ã£o de ocupaÃ§Ã£o para os imÃ³veis construÃ­dos na Rua Manoel Ãlvaro de AraÃºjo, n. 193 (frente e fundos), municÃ­pio de Garopaba, em nome de Claudemira da Silva', 'undefined', '2019-07-18', '2019-08-07', '2019-08-07 19:57:41', 4, 8, '2019-07-25 21:00:48', '2019-08-07 19:57:41', 65, 7, 0, NULL, 797),
(840, 1, '131/2019', '04972.003552/2019-51', 0, 'Encaminha novo Parecer de ForÃ§a ExecutÃ³ria.', 'undefined', '2019-07-18', NULL, '2019-08-06 15:28:05', 4, 8, '2019-07-25 21:13:59', '2019-08-06 15:28:13', 100, 3, 0, NULL, 381),
(841, 1, '1159/2019', '10154.110920/2019-53', 0, 'ManifestaÃ§Ã£o quanto Ã s afirmaÃ§Ãµes de descumprimento do comando judicial.', 'TransferÃªncia pendente.\nRegistros no SEI-MP 04972.200015/2015-24', '2019-07-18', '2019-08-01', '2019-08-12 17:24:01', 4, 4, '2019-07-25 22:04:32', '2019-08-12 22:24:42', 114, 3, 0, NULL, 798),
(842, 1, '0032/2019', '10154.110991/2019-56', 0, 'verificaÃ§Ã£o de interferÃªncia da Ã¡rea com bens da UniÃ£o.', 'em anÃ¡lise.', '2019-07-25', '2019-08-25', '2019-08-22 15:48:47', 8, 3, '2019-07-26 15:40:54', '2019-08-22 15:48:47', 245, 7, 0, NULL, 799),
(843, 1, '0033/2019', '10154.110996/2019-89', 0, 'verificaÃ§Ã£o de interferÃªncia da Ã¡rea com bens da UniÃ£o.', 'Em anÃ¡lise.', '2019-07-25', '2019-08-23', '2019-08-21 20:09:05', 8, 3, '2019-07-26 15:45:39', '2019-08-21 20:09:15', 245, 3, 0, NULL, 800),
(844, 1, '443/2019', '04972.000805/2017-73', 0, 'informaÃ§Ã£o sobre a realizaÃ§Ã£o de vistoria programada\" pÃ£rÃ¢\"6^Segundo semestre de 2018, na Rua Camilo de Oliveira, em BalneÃ¡rio Barra do Sul/SC, pelo Setor de FiscalizaÃ§Ã£o, a fim verificar a situaÃ§Ã£o dos imÃ³veis situados em locais que interferem com terras de marinha e seus acrescidos, conforme consta do OfÃ­cio nÂº 77149/2018-MP', 'undefined', '2019-04-08', '2019-05-08', '2019-07-29 17:10:30', 4, 4, '2019-07-29 17:10:13', '2019-07-29 17:10:31', 85, 3, 0, NULL, 320),
(845, 1, '1171/2019', '10154.111883/2019-09', 0, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos.', 'Reiterado em 29/07/2019', '2019-07-19', '2019-08-05', '2019-08-07 19:59:22', 4, 4, '2019-07-29 20:05:12', '2019-08-08 19:26:42', 126, 3, 0, NULL, 801),
(846, 1, '1165/2019', '04972.003302/2016-79', 0, 'seja informado quanto Ã  integridade das informaÃ§Ãµes fornecidas pelo MunicÃ­pio de FlorianÃ³polis para os trabalhos de notificaÃ§Ã£o a serem realizados por essa SPU nos trechos demarcados da LPM 1831 na Ilha de Santa Catarina.', 'undefined', '2019-07-19', '2019-08-09', NULL, 4, NULL, '2019-07-29 20:21:37', '2019-07-29 20:21:37', 114, 2, 0, NULL, 802),
(847, 1, '246/2019', '04972.003142/2019-19', 0, 'Responde questionamentos feitos pelo OFÃCIO NÂº 51155/2019/DIGES-SPU-SC/MP.', 'undefined', '2019-07-19', NULL, NULL, 4, 3, '2019-07-29 20:37:37', '2019-08-09 16:59:59', 264, 2, 0, NULL, 289),
(848, 1, '1174/2019', '10154.111933/2019-40', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-22', '2019-08-08', '2019-08-07 19:57:53', 4, 4, '2019-07-29 20:55:28', '2019-08-08 19:24:03', 114, 3, 0, NULL, 803),
(849, 1, '20/2019', '04972.002751/2017-81', 0, 'Informar sobre a finalizaÃ§Ã£o do procedimento administrativo de regularizaÃ§Ã£o (04972.004937/2010-06)', 'undefined', '2019-07-22', '2019-08-22', NULL, 4, 3, '2019-07-29 21:11:15', '2019-09-04 15:27:02', 234, 6, 0, NULL, 407),
(850, 9, '5021445-80.2014.4.04.7200', '10154.111972/2019-47', 0, 'Intimem-se pessoalmente o Sr. Prefeito Municipal e o Sr. Superintendente da SPU para que o MunicÃ­pio e a UniÃ£o cumpram todos os compromissos firmados no prazo de 30 dias, sob pena de aplicaÃ§Ã£o de multa de R$ 10.000,00 ao dia. DemoliÃ§Ã£o ou regularizaÃ§Ã£o dos Ranchos de Pesca do Bloco 7 no MunicÃ­pio de FlorianÃ³polis. Multa ao dia de R$ 10.000,00.', 'Foi realizada AudiÃªncia nos seguintes termos:\r\nAberta a audiÃªncia, foram as partes instadas Ã  composiÃ§Ã£o do litÃ­gio pela via conciliatÃ³ria, e alertadas sobre a conveniÃªncia da referida forma de soluÃ§Ã£o, seja pela sua maior agilidade, seja pela melhor potencialidade de pacificaÃ§Ã£o do conflito trazido a juÃ­zo. ApÃ³s as medidas administrativas adotadas em conjunto pelo MunicÃ­pio, FLORAM e UniÃ£o, foi possÃ­vel identificar as situaÃ§Ãµes dos ocupantes regulares e irregulares dos ranchos existentes na Ã¡rea. A SPU se comprometeu a emitir os TAUS que estÃ£o em ocupaÃ§Ã£o regular, no prazo de 60 dias. Aqueles que se encontram em situaÃ§Ã£o irregular jÃ¡\r\nforam notificados. Os casos que nÃ£o foram notificados, serÃ£o notificados no prazo de 30 dias, para sanar as irregularidades, sob as penas da lei.\r\nO MunicÃ­pio se compromete desde jÃ¡ com a demoliÃ§Ã£o do conjunto 4 de ranchos do bloco 7, no prazo de 30 (trinta) dias, com a remoÃ§Ã£o do entulho. Com relaÃ§Ã£o aos demais pedidos, o MunicÃ­pio reitera os pedidos das alegaÃ§Ãµes finais (evento 271).\r\nA Prefeitura requer a expediÃ§Ã£o de mandado de demoliÃ§Ã£o, com o acompanhamento da SPU. Os prepostos da SPU informaram que vÃ£o acompanhar o cumprimento do mandado pelo MunicÃ­pio.\r\nAs situaÃ§Ãµes de fragilidades sociais deverÃ£o ser resolvidas administrativamente pelas partes.\r\nO MPF requer que as medidas acima elencadas sejam adotadas como\r\nencaminhamento para soluÃ§Ã£o final e, considerando a necessidade de serem esgotadas as\r\npossibilidades de uma composiÃ§Ã£o tambÃ©m para os demais pedidos da aÃ§Ã£o, propÃµe a\r\nrealizaÃ§Ã£o de uma inspeÃ§Ã£o conjunta na Ã¡rea, em atÃ© 90 dias, bem como de uma audiÃªncia a\r\nser fixada no inÃ­cio do mÃªs de dezembro do corrente.\r\nPelo MM. Juiz foi dito: â€œdefiro as medidas solicitadas pelas partes, em especial\r\na demoliÃ§Ã£o do conjunto 4 de ranchos do bloco 7; a entrega dos TAUS e as notificaÃ§Ãµes.\r\nDesigno o dia 19-11-2019, Ã s 14h30 para inspeÃ§Ã£o judicial; e o dia 10-12-2019, Ã s 14h,\r\npara audiÃªncia de conciliaÃ§Ã£o. Revogo a decisÃ£o do evento 273\".', '2019-07-26', '2019-08-26', NULL, 3, 3, '2019-07-29 21:31:20', '2019-08-21 20:20:52', 161, 2, 1, NULL, 804),
(851, 1, '1177/2019', '10154.111980/2019-93', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.', 'undefined', '2019-07-22', '2019-08-06', '2019-08-12 16:58:01', 4, 4, '2019-07-29 21:31:47', '2019-08-12 22:31:23', 126, 3, 0, NULL, 805),
(852, 1, '461/2019', '10154.112019/2019-16', 0, 'informe se a construÃ§Ã£o/rancho pertencente ao Sr. Aurino Pereira Vieira, CPF n. 309.227.049-53, apontado no Termo Circunstanciado n. 07.03.052/2012-05 de 25 de maio de 2012, emitido pela PolÃ­cia Militar Ambiental de Santa Catarina (cÃ³pia em anexo), estÃ¡ inserido em terrenos de marinha. Em caso de resposta positiva, que informe se este possui inscriÃ§Ã£o de ocupaÃ§Ã£o perante essa SuperintendÃªncia (ou eventual TAUS)', 'undefined', '2019-07-22', '2019-08-19', '2019-08-16 16:00:42', 4, 4, '2019-07-29 22:01:59', '2019-08-16 16:00:44', 241, 3, 0, NULL, 807),
(853, 1, '001', '10154.105510/2019-91', 0, 'solicita informaÃ§Ãµes sobre a situaÃ§Ã£o do imÃ³vel de matricula n. 42.706, registrado no Oficio de Registro de ImÃ³veis da Comarca de BalneÃ¡rio PiÃ§arras', 'Respondido', '2019-07-08', '2019-07-31', '2019-07-30 15:37:08', 8, 8, '2019-07-30 15:36:47', '2019-07-30 15:37:08', 297, 7, 0, NULL, 808),
(854, 1, '0031/2019', '10154.112160/2019-19', 0, 'verificar se o imÃ³vel estÃ¡ inserido em Ã¡rea de marinha e seus acrescidos.', 'Em anÃ¡lise', '2019-07-29', '2019-08-30', NULL, 8, 8, '2019-07-30 15:48:53', '2019-09-02 17:04:13', 245, 6, 0, NULL, 809),
(855, 1, '030/2019', '10154.112143/2019-81', 0, 'Verificar se o imÃ³vel estÃ¡ inserido em Ã¡rea de marinha e seus acrescidos.', 'Em anÃ¡lise.', '2019-07-29', '2019-08-30', NULL, 8, 8, '2019-07-30 16:14:53', '2019-07-30 16:16:01', 245, 2, 0, NULL, 810),
(856, 1, '434/2019', '04972.006106/2018-18', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial', 'undefined', '2019-07-23', '2019-08-08', '2019-08-07 22:28:20', 4, 4, '2019-07-30 19:33:31', '2019-08-08 19:16:30', 121, 3, 0, NULL, 125),
(857, 1, '19/2019', '10154.112336/2019-32', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-23', '2019-08-22', '2019-08-16 15:13:12', 4, 4, '2019-07-30 19:50:13', '2019-08-16 16:23:21', 106, 3, 0, NULL, 811),
(858, 1, '433/2019', '04972.000524/2017-11', 0, 'designar algum servidor/tÃ©cnico para acompanhar a audiÃªncia, nos enviando com antecedÃªncia o nome.', 'informado que esta SuperintendÃªncia serÃ¡ representada pela Analista de Infraestrutura MARINA CHRISTOFIDIS', '2019-07-23', '2019-08-20', '2019-08-14 17:03:56', 4, 3, '2019-07-30 20:06:07', '2019-08-14 19:41:10', 121, 3, 0, NULL, 532),
(859, 1, '432/2019', '04972.008544/2018-11', 0, 'deverÃ¡ o autor adotar as providÃªncias administrativas pertinentes junto Ã  Secretaria do PatrimÃ´nio da UniÃ£o, notadamente no sentido de consultar o processo demarcatÃ³rio e de ocupaÃ§Ã£o (locaÃ§Ã£o), acessando eventuais documentos pertinentes, para entÃ£o apresentar nova manifestaÃ§Ã£o nestes autos, apontando precisamente os erros tÃ©cnicos ou administrativos que entende atingirem o processo demarcatÃ³rio, a retificaÃ§Ã£o das medidas de terreno de marinha, ou as medidas permissivas de edificaÃ§Ã£o para o terreno objeto desta aÃ§Ã£o', 'undefined', '2019-07-23', NULL, NULL, 4, NULL, '2019-07-30 20:24:54', '2019-07-30 20:24:54', 121, 1, 0, NULL, 261),
(860, 9, '5016764-91.2019.4.04.7200', '10154.112340/2019-09', 0, 'Prestar informaÃ§Ãµes quanto Ã  conclusÃ£o do requerimento de inscriÃ§Ã£o de ocupaÃ§Ã£o junto Ã  Secretaria de PatrimÃ´nio da UniÃ£o (SPU) de um imÃ³vel localizado na Avenida AntÃ´nio Joaquim Tavares, S/N, ArmaÃ§Ã£o, 88385-000, no MunicÃ­pio de Penha/SC. O pedido foi cadastrado sob o n.Âº SC01413/2018 - NUP SEI-MP 04972.005890/2018-47.', 'undefined', '2019-07-29', '2019-08-13', '2019-08-06 22:15:42', 3, 3, '2019-07-30 20:29:56', '2019-08-06 22:15:44', 307, 3, 0, NULL, 813),
(861, 1, '104/2019', '10154.112368/2019-38', 0, 'manifestaÃ§Ã£o  sobre alegaÃ§Ã£o do contribuinte OTAVIANO GHIZONI - CPF: 572086 209-97 quanto Ã  cobranÃ§a de tributo em duplicidade.', 'undefined', '2019-07-23', '2019-08-16', '2019-08-20 17:01:33', 4, 4, '2019-07-30 20:54:53', '2019-08-21 20:46:32', 308, 3, 0, NULL, 814),
(862, 1, '26/2019', '10154.112388/2019-17', 0, 'ManifestaÃ§Ã£o de Interesse.', 'Prazo fatal 19/08/2019', '2019-07-23', '2019-08-12', '2019-08-13 20:54:58', 4, 4, '2019-07-30 21:20:01', '2019-08-14 17:21:43', 106, 3, 0, NULL, 815),
(863, 1, '24/2019', '04972.206943/2015-01', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', 'undefined', '2019-07-23', '2019-08-16', '2019-08-14 15:27:05', 4, 4, '2019-07-30 21:26:22', '2019-08-16 17:11:34', 106, 3, 0, NULL, 126),
(864, 1, '23/2019', '04972.004144/2017-55', 0, 'ManifestaÃ§Ã£o sobre laudo pericial - trata-se de  Laudo que analisa o Solo do Terreno, ou seja, questiona o critÃ©rio da demarcaÃ§Ã£o da LMP em funÃ§Ã£o do tipo de solo do local', 'undefined', '2019-07-23', '2019-08-20', '2019-09-03 14:53:53', 4, 3, '2019-07-30 21:36:12', '2019-09-03 21:26:58', 106, 3, 0, NULL, 556),
(865, 1, '1213/2019', '04972.000320/2019-41', 0, 'manifestaÃ§Ã£o no sentido de informar a situaÃ§Ã£o do loca e as medidas eventualmente necessÃ¡rias a demoliÃ§Ã£o. BalneÃ¡rio CamboriÃº', 'O que Ã©:\r\nConsiderando a inÃ©rcia do executado em promover a demoliÃ§Ã£o, o magistrado proferiu o Despacho/DecisÃ£o no evento 108 dos autos da aÃ§Ã£o de execuÃ§Ã£o nÂº 5011583-90.2016.4.04.7208, datado de 10/01/2019, intimando a UniÃ£o para, atravÃ©s da SuperintendÃªncia do PatrimÃ´nio, proceder Ã  demoliÃ§Ã£o da edificaÃ§Ã£o em questÃ£o, devendo contatar diretamente o IMA â€“ Instituto do Meio Ambiente de Santa Catarina para acompanhar o processo de remoÃ§Ã£o do material, consoante constou no acÃ³rdÃ£o, no prazo de 60 dias.\r\n\r\nO que foi feito:\r\n1) demanda encaminhada ao NÃºcleo de FiscalizaÃ§Ã£o (Despacho 3397471)\r\n2) OfÃ­cio nÂº 54320/2019/DIGES-SPU-SC/MP encaminhado Ã  Prefeitura de BC, solicitando auxÃ­lio da demoliÃ§Ã£o da obra\r\n3) OfÃ­cio nÂº 54483/2019/DIGES-SPU-SC/MP encaminhado Ã  AGU, informando das medidas adotadas (fiscalizaÃ§Ã£o p/ 08/08/19 e ofÃ­cio Ã  PMBC)\r\n4) vistoria no local verificou que a demoliÃ§Ã£o nÃ£o foi efetivada\r\n5) processo foi encaminhado ao NUGES para contrataÃ§Ã£o do serviÃ§o de demoliÃ§Ã£o\r\n\r\nO que falta fazer:\r\n\r\n1) contrataÃ§Ã£o do serviÃ§o de demoliÃ§Ã£o, nos moldes estabelecidos no Despacho COSUL-SPU (8320910) constante do NUP 04972.001973/2019-48, devendo a AGU ser informada do tempo necessÃ¡rio para a contrataÃ§Ã£o do serviÃ§o.', '2019-07-29', '2019-08-05', NULL, 3, 1, '2019-07-30 22:20:39', '2019-08-19 16:52:51', 126, 2, 1, NULL, 48),
(866, 1, '28/2019', '04972.001325/2019-91', 0, 'Aguarde a realizaÃ§Ã£o de estudo antropolÃ³gico e o seu encaminhamento para a finalizaÃ§Ã£o do Processo nÂº 04972.009998/2018-17', 'undefined', '2019-07-24', NULL, NULL, 4, NULL, '2019-07-31 19:33:56', '2019-07-31 19:33:56', 234, 2, 0, NULL, 88),
(867, 1, '1202/2019', '04972.003534/2019-70', 0, 'Informe se a decisÃ£o foi cumprida.( DemoliÃ§Ã£o).', 'Foi feita a fiscalizaÃ§Ã£o na qual foi constatado o seguinte:\r\nA partir da aÃ§Ã£o de fiscalizaÃ§Ã£o do imÃ³vel na Praia do Campeche,  contactamos  o Sr Edi Luis de Oliveira responsÃ¡vel pelo mesmo alvo da sentenÃ§a judicial, que nos acompanhou na vistoria e relatou estar executando o cumprimento da sentenÃ§a de demoliÃ§Ã£o das benfeitorias,  que jÃ¡ se encontram parcialmente demolidas com cerca de trinta por cento jÃ¡ executadas,  PorÃ©m alegou que por questÃµes pessoais nÃ£o teve condiÃ§Ãµes de  concluir a demoliÃ§Ã£o conforme sentenÃ§a. O  responsÃ¡vel se comprometeu  que atÃ© a data de 05/10/2019 estarÃ£o finalizadas as obras de demoliÃ§Ã£o. Procedemos entÃ£o com a coleta de dados conforme RelatÃ³rio FotogrÃ¡fico nÂº 8845797 e mapa de locaÃ§Ã£o anexo nÂº8695212. \r\nAguardar nova fiscalizaÃ§Ã£o para comprovar a demoliÃ§Ã£o.', '2019-07-25', '2019-09-27', '2019-08-07 19:53:10', 4, 3, '2019-07-31 20:06:50', '2019-08-07 20:19:22', 126, 7, 1, NULL, 377),
(868, 1, '1203/2019', '04972.205274/2015-41', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial', 'reiterado em 07/08/2019', '2019-07-25', '2019-08-15', '2019-08-08 20:48:00', 4, 3, '2019-07-31 20:21:34', '2019-08-08 21:01:56', 126, 3, 0, NULL, 53),
(869, 1, '21/2019', '04972.004256/2018-97', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial', 'undefined', '2019-07-26', '2019-08-12', '2019-08-09 20:30:57', 4, 4, '2019-07-31 20:50:45', '2019-08-09 21:51:06', 234, 3, 0, NULL, 142),
(870, 1, '34/2019', '10154.105964/2019-61', 0, 'fornecer novo cÃ¡lculo das taxas de ocupaÃ§Ã£o, desde 2007, com base nos valores dos imÃ³veis.', 'undefined', '2019-07-26', '2019-08-09', NULL, 4, NULL, '2019-07-31 21:12:41', '2019-07-31 21:12:41', 234, 2, 0, NULL, 701),
(871, 1, '33/2019', '10154.112798/2019-50', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', 'Reiterado em 12/08/2019', '2019-07-26', '2019-08-20', '2019-08-14 15:34:39', 4, 8, '2019-07-31 22:16:31', '2019-08-14 15:34:39', 106, 7, 0, NULL, 816),
(872, 1, '32/2019', '10154.112819/2019-37', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', 'undefined', '2019-07-26', '2019-08-16', '2019-08-14 15:43:51', 4, 8, '2019-07-31 22:52:53', '2019-08-14 15:43:51', 234, 7, 0, NULL, 818),
(873, 1, '30/2019', '04972.002553/2019-89', 0, 'InformaÃ§Ãµes sobre o registro em nome da UniÃ£o da Ã¡rea expropriada.', 'O que foi feito:\r\n- informamos que as providÃªncias seriam tomadas pelo DNIT\r\n- reiteramos necessidade de resposta pelo DNIT (oficio ao DNIT)\r\n- informamos Ã  AGU sobre as providÃªncias acima', '2019-07-26', '2019-08-26', '2019-08-26 15:54:10', 4, 1, '2019-08-01 17:10:03', '2019-08-26 15:54:10', 234, 7, 0, NULL, 226),
(878, 1, '36/2019', '10154.106543/2019-58', 0, 'Encaminha comprovante de depÃ³sito judicial.', 'undefined', '2019-07-29', '2019-08-05', '2019-08-26 15:47:34', 4, 4, '2019-08-01 18:45:38', '2019-08-26 15:47:40', 234, 3, 0, NULL, 725),
(879, 1, '37/2019', '10154.113005/2019-10', 0, 'Encaminha parecer de forÃ§a executÃ³ria.\nInforma o trÃ¢nsito em julgado favorÃ¡vel Ã  UniÃ£o.\nCancelamento de concessÃ£o de isenÃ§Ã£o.', 'Encaminha para conhecimento e eventual registro.', '2019-07-29', NULL, NULL, 4, 8, '2019-08-01 19:13:31', '2019-08-02 15:35:43', 234, 2, 0, NULL, 819),
(880, 1, '35/2019', '10154.113012/2019-11', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-29', '2019-08-23', '2019-08-21 15:29:03', 4, 3, '2019-08-01 19:42:57', '2019-08-21 17:09:54', 234, 3, 0, NULL, 820),
(881, 1, '44/2019', '10154.113036/2019-71', 0, 'Encaminha Parecer de ForÃ§a ExecutÃ³ria, acompanhado da sentenÃ§a e da certidÃ£o de trÃ¢nsito em julgado, tÃ£o somente para seu conhecimento.', 'undefined', '2019-07-30', NULL, '2019-08-01 20:29:55', 4, 4, '2019-08-01 20:28:39', '2019-08-01 20:29:56', 234, 3, 0, NULL, 822),
(882, 1, '797/2019', '04972.004684/2016-58', 0, 'ReiteraÃ§Ã£o do ofÃ­cio nÂº 731/2019', 'undefined', '2019-07-30', '2019-08-15', '2019-08-28 19:41:38', 4, 3, '2019-08-01 21:18:14', '2019-08-28 19:41:40', 309, 3, 0, NULL, 465),
(883, 1, '349/2019', '10154.106101/2019-10', 0, 'a) Se foi realizada nova vistoria em 2018 na Ã¡rea localizada na Rua Wendelim\r\nMetzger, entre as Ruas Oscar de Castilho e EuzÃ©bio Piermann, bairro ~cÃ­lio Dias,\r\nmunicÃ­pio de Canoinhas/SC - se afirmativo, solicita-se o envio do respectivo laudo;\r\nb) Se foi identificado o responsÃ¡vel inicial pela invasÃ£o e pelo loteamento irregular da\r\nÃ¡rea pertencente Ã  UniÃ£o - se afirmativo, solicita-se o fornecimento de seus dados\r\ncompletos de identificaÃ§Ã£o para que se viabilize sua futura oitiva em sede policial;\r\nc) Se foi ajuizada alguma aÃ§Ã£o para reintegraÃ§Ã£o de posse da Ã¡rea em questÃ£o - se\r\nafirmativo, solicita-se seja informado o nÃºmero do correlato processo judicial para\r\nverificaÃ§Ã£o quanto ao seu estÃ¡gio atual;\r\nd) Se a Ã¡rea em comento efetivamente ainda integra o patrimÃ´nio da UniÃ£o (enviar da\r\ncÃ³pia da ficha registrai desse imÃ³vel). Por fim, caso nÃ£o tenha havido nova fiscalizaÃ§Ã£o\r\nem 2018, entÃ£o, que seja realizada fiscalizaÃ§Ã£o com identificaÃ§Ã£o dos invasores\r\n(novos), em data prÃ³xima a ser agendada e acompanha por agentes desta Delegacia.', 'Reiterado pelo OfÃ­cio n.Â° 1805/2019 - DPF/JVE/SC de 8/07/2019.', '2019-02-25', '2019-08-08', NULL, 3, 3, '2019-08-02 15:45:28', '2019-08-02 15:48:30', 289, 2, 1, NULL, 823),
(885, 1, '01', '05022.001309/2003-33', 0, 'Informa a realizaÃ§Ã£o de perÃ­cia.', 'Apenas ciÃªncia.', '2019-08-01', '2019-08-26', NULL, 8, 8, '2019-08-02 16:05:28', '2019-08-02 16:08:43', 311, 2, 0, NULL, 824),
(886, 1, '283/2019', '04972.005030/2016-41', 0, 'que informe quais os procedimentos administrativos que tramitam nesta Secretaria acerca de edificaÃ§Ãµes irregulares em terrenos de marinha Ã s margens do Rio ItajaÃ­-AÃ§u no municÃ­pio de Blumenau, nos termos do OfÃ­cio nÂ°\r\n175/2018 anexo.', 'reiterado pelo OfÃ­cio nÂ° 536/2019, de 05/07/2019', '2019-03-14', '2019-04-01', NULL, 3, 3, '2019-08-02 19:41:08', '2019-08-02 19:44:28', 312, 2, 0, NULL, 825),
(887, 1, '265/2019', '10154.113479/2019-61', 0, 'suspensÃ£o da exigibilidade da majoraÃ§Ã£o da taxa de ocupaÃ§Ã£o realizada a partir do ano de 2012, mediante o depÃ³sito judicial, em conta vinculada a este processo, do mesmo valor exigido pela UniÃ£o no ano de 2011 para todos os anos subsequentes, devidamente corrigido monetariamente.', 'undefined', '2019-07-30', '2019-08-12', '2019-08-23 20:24:47', 4, 4, '2019-08-05 19:03:02', '2019-08-23 20:24:49', 313, 3, 0, NULL, 826),
(888, 1, '1044/2019', '04972.006629/2016-01', 0, 'identifique todos os ocupantes particulares em todas as glebas do Campo de AviaÃ§Ã£o, com as devidas matrÃ­culas individuais, no prazo de 30 (trinta) dias.', 'O que Ã©:\r\nA sentenÃ§a foi reformada pelo TRF4, com trÃ¢nsito em julgado, mantendo apenas a obrigaÃ§Ã£o da UniÃ£o em promover a desocupaÃ§Ã£o do Casa dos Pilotos. \r\n\r\nA UniÃ£o jÃ¡ ajuizou aÃ§Ã£o de reintegraÃ§Ã£o de posse nÂº 5014972-44.2015.4.04.7200, juntamente com o MunicÃ­pio, que encontra-se em trÃ¢mite.\r\n\r\n\r\nO que falta fazer:\r\nIdentificar todos os ocupantes particulares em todas as glebas do Campo de AviaÃ§Ã£o, com as devidas matrÃ­culas individuais, no prazo de 30 (trinta) dias, a contar desta data.', '2019-07-30', '2019-09-04', NULL, 4, 1, '2019-08-05 19:33:51', '2019-08-05 21:27:12', 100, 2, 1, NULL, 651),
(889, 1, '502/2019', '10154.113535/2019-68', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-31', '2019-08-26', '2019-08-22 15:53:55', 4, 4, '2019-08-05 20:28:12', '2019-08-22 15:53:56', 65, 3, 0, NULL, 827);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `seiMP`, `demanda`, `resumoSituacao`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(890, 1, '499/2019', '04972.010059/2018-15', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-31', '2019-08-15', '2019-08-08 19:19:12', 4, 4, '2019-08-05 20:52:48', '2019-08-08 19:19:13', 73, 3, 0, NULL, 828),
(891, 1, '497/2019', '04972.008946/2018-15', 0, 'CÃ³pia do Processo  11452.001478/98-60.', 'undefined', '2019-07-31', '2019-08-20', '2019-08-05 23:26:43', 4, 4, '2019-08-05 21:09:41', '2019-08-05 23:26:44', 65, 3, 0, NULL, 829),
(892, 6, '00', '10154.113562/2019-31', 0, 'disponibilizaÃ§Ã£o de linha ao perito.', 'undefined', '2019-08-05', NULL, '2019-08-08 16:27:07', 8, 8, '2019-08-06 16:17:44', '2019-08-08 16:27:10', 161, 3, 0, NULL, 434),
(893, 1, '2334616', '04972.004096/2019-67', 0, 'anotaÃ§Ã£o (RIP 80470000412-62) acerca da liminar na qual foi deferida a imissÃ£o provisÃ³ria na posse do autor (MunicÃ­pio de TubarÃ£o ) no terreno descrito na\r\nexordial.', 'undefined', '2019-07-29', '2019-08-16', NULL, 3, 8, '2019-08-06 20:27:11', '2019-08-07 15:00:23', 314, 2, 0, NULL, 568),
(894, 1, '494/2019', '04972.006145/2017-34', 0, 'que delimite os terrenos e acrescidos de marinha, com base na LPM presumida, bem como informe as medidas adotadas para resguardar o patrimÃ´nio pÃºblico federal, conforme noticiado nas manifestaÃ§Ãµes tÃ©cnicas que acompanharam o OfÃ­cio 83984/2017-MP', 'undefined', '2019-07-31', '2019-08-20', '2019-08-22 16:18:04', 4, 4, '2019-08-06 21:26:59', '2019-08-22 16:18:05', 65, 3, 0, NULL, 831),
(895, 1, '49/2019', '10154.114217/2019-14', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.', 'AÃ§Ã£o de adjudicaÃ§Ã£o compulsÃ³ria.\nEnvolve imÃ³vel da extinta Rede FerroviÃ¡ria S/A.', '2019-07-31', '2019-08-30', '2019-09-03 16:09:38', 4, 3, '2019-08-06 21:57:06', '2019-09-03 20:00:37', 234, 3, 0, NULL, 832),
(896, 1, '46/2019', '10154.114231/2019-18', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-31', '2019-08-30', '2019-08-28 17:02:54', 4, 4, '2019-08-06 22:29:02', '2019-08-28 17:02:56', 224, 3, 0, NULL, 833),
(897, 1, '47/2019', '10154.114497/2019-61', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial', 'undefined', '2019-07-31', '2019-08-30', '2019-09-04 17:39:23', 4, 23, '2019-08-07 17:40:56', '2019-09-04 17:39:27', 234, 3, 0, NULL, 834),
(898, 1, '48/2019', '10154.114531/2019-05', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-07-31', '2019-08-22', '2019-08-16 15:34:07', 4, 4, '2019-08-07 19:14:30', '2019-08-16 16:20:00', 315, 3, 0, NULL, 835),
(899, 1, '111/2019', '10145.101129/2019-61', 0, 'comunicaÃ§Ã£o de decisÃ£o, sentenÃ§a juntada (3371008), e solicitaÃ§Ã£o de subsÃ­dios para defesa judicial da UniÃ£o no curso da AÃ§Ã£o.\nTransferÃªncia de OcupaÃ§Ã£o - Ocupante falecido - Nulidade das cobranÃ§as apÃ³s o falecimento - RIP 8185.0100485-10â€‹', 'Encaminhado Ã  CoordenaÃ§Ã£o para cumprimento imediato.\nDeterminaÃ§Ã£o para que a UniÃ£o abstenha-se de realizar a cobranÃ§a, sob pena de aplicaÃ§Ã£o de multa diÃ¡ria de R$100,00, pelo descumprimento.', '2019-08-02', '2019-08-30', NULL, 8, NULL, '2019-08-07 20:09:30', '2019-08-07 20:09:30', 308, 2, 0, NULL, 836),
(900, 1, '437/2019', '10154.114539/2019-63', 0, 'esclareÃ§a acerca da titularidade e histÃ³rico do RIP 8030.04885.000-3.', 'undefined', '2019-08-01', '2019-08-15', '2019-08-16 15:22:33', 4, 4, '2019-08-07 20:43:37', '2019-08-19 15:38:36', 121, 3, 0, NULL, 837),
(901, 1, '436/2019', '10154.114591/2019-10', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-01', '2019-08-23', '2019-08-23 20:07:23', 4, 4, '2019-08-07 21:00:17', '2019-08-26 16:21:39', 121, 3, 0, NULL, 839),
(902, 1, '435/2019', '10154.114625/2019-76', 0, 'ManifestaÃ§Ã£o sobre novos documentos', 'undefined', '2019-08-01', '2019-08-23', '2019-08-21 19:18:48', 4, 4, '2019-08-07 21:30:29', '2019-08-22 16:06:47', 121, 3, 0, NULL, 26),
(903, 1, '56/2019', '10154.114669/2019-04', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-01', '2019-08-16', '2019-08-09 21:25:59', 4, 4, '2019-08-07 22:16:08', '2019-08-12 16:45:45', 234, 3, 0, NULL, 842),
(904, 1, '1055/2019', '10154.114728/2019-36', 0, 'indicaÃ§Ã£o de preposto para comparecimento Ã  audiÃªncia acima referida, no dia 31/10/2019, Ã s 14:00h, com poderes para transigir acerca do interesse pÃºblico da UNIÃƒO, se houver necessidade', 'undefined', '2019-08-02', '2019-08-20', '2019-08-14 17:10:32', 4, 4, '2019-08-07 22:45:14', '2019-08-14 17:10:32', 100, 7, 0, NULL, 843),
(905, 7, '23/2019', '10154.114981/2019-90', 0, 'Promova a retificaÃ§Ã£o do RIP 8143.0000153-43, para excluir a Ã¡rea de preservaÃ§Ã£o permanente, exigindo-se a remoÃ§Ã£o do cercamento realizado sobre a APP.', 'undefined', '2019-08-02', '2019-08-29', '2019-08-28 14:53:15', 4, 4, '2019-08-08 20:18:21', '2019-08-28 17:18:23', 241, 3, 0, NULL, 844),
(906, 1, '1035/2019', '10154.114988/2019-10', 0, 'Informa que oi prolatada sentenÃ§a julgando procedente a aÃ§Ã£o, mas excluindo os terrenos de marinha, conforme dados emitidos por essa SuperintendÃªncia', 'undefined', '2019-08-02', NULL, NULL, 4, NULL, '2019-08-08 20:34:35', '2019-08-08 20:34:35', 100, 1, 0, NULL, 846),
(907, 6, '5/2019', '10154.115054/2019-97', 0, 'Informa o trÃ¢nsito em julgado que para declarar que deverÃ¡, o rÃ©u, proceder Ã  demoliÃ§Ã£o do imÃ³vel, com a retirada de todos os entulhos, bem como apresentar, no prazo de 30 dias, sob pena de multa diÃ¡ria fixada em R$ 100,00, Plano de RecuperaÃ§Ã£o da Ãrea Degradada, o qual deverÃ¡ ser executado pelo rÃ©u, apÃ³s sua aprovaÃ§Ã£o pelo Ã³rgÃ£o ambiental competente', 'undefined', '2019-08-05', NULL, '2019-08-08 21:42:47', 4, 4, '2019-08-08 21:42:24', '2019-08-08 21:42:49', 106, 3, 0, NULL, 847),
(908, 1, '61/2019', '10154.115112/2019-82', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-05', '2019-08-15', '2019-08-12 21:04:59', 4, 4, '2019-08-08 22:19:59', '2019-08-13 20:02:52', 224, 3, 0, NULL, 848),
(909, 1, '004', '10154.115223/2019-99', 0, 'informaÃ§Ãµes sobre procedimentos para transferÃªncia de ocupaÃ§Ã£o, especialmente em relaÃ§Ã£o Ã  exigÃªncia de pagamento de ITBI.', 'DistribuÃ­do - Em anÃ¡lise.', '2019-08-08', '2019-08-26', '2019-08-30 19:35:17', 8, 8, '2019-08-09 17:09:06', '2019-08-30 19:35:17', 316, 7, 0, NULL, 849),
(910, 1, '60/2019', '10154.115337/2019-39', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-05', '2019-08-15', '2019-08-12 21:01:10', 4, 4, '2019-08-09 17:31:32', '2019-08-13 19:54:37', 106, 3, 0, NULL, 850),
(911, 1, '59/2019', '04972.006292/2018-95', 0, 'ManifestaÃ§Ã£o sobre laudo pericial.', 'undefined', '2019-08-05', '2019-08-23', '2019-08-21 21:50:25', 4, 4, '2019-08-09 19:23:12', '2019-08-22 16:03:17', 106, 3, 0, NULL, 851),
(912, 6, '4/2019', '04972.002165/2016-55', 0, 'Em sede de sentenÃ§a o processo foi julgado parcialmente procedente para declarar o domÃ­nio do autor WILMAR DUARTE GOMES sobre a Ã¡rea alodial de 1.963,75mÂ², imÃ³vel localizado na Rua Carlos Sales, nÂº 130, Distrito de Campeche, FlorianÃ³polis â€“ SC. As medidas e confrontaÃ§Ãµes dessa Ã¡rea constam da planta anexa ao Laudo pericial(273 LAUDO 1 e 2), que faz parte integrante desta sentenÃ§a. Ressalvo o direito da UniÃ£o alterar a Linha de Preamar em razÃ£o de sua homologaÃ§Ã£o definitiva.', 'undefined', '2019-08-05', NULL, '2019-08-09 19:45:59', 4, 4, '2019-08-09 19:45:33', '2019-08-09 19:46:00', 106, 3, 0, NULL, 852),
(913, 1, '64/2019', '04972.205738/2015-10', 0, 'Encaminha Parecer JurÃ­dica que informa a homologaÃ§Ã£o de acordo.', 'undefined', '2019-08-07', NULL, NULL, 4, NULL, '2019-08-09 21:38:19', '2019-08-09 21:38:19', 224, 1, 0, NULL, 387),
(914, 1, '25/2019', '10154.107615/2019-84', 0, 'informar se Ã¡rea interfere com bens da UniÃ£o.', 'undefined', '2019-07-15', '2019-08-15', NULL, 8, 8, '2019-08-12 17:10:01', '2019-08-12 17:10:14', 318, 6, 0, NULL, 743),
(915, 1, '807/2019', '04972.200262/2015-21', 0, '1) informaÃ§Ãµes atualizadas sobre a incorporaÃ§Ã£o da Ã¡rea em questÃ£o;\n2) esclarecimentos sobre o item \"10\" da comunicaÃ§Ã£o anexa\n(NUP 04972.200262/2015-21), vez que repleto de termos tÃ©cnicos que\nfogem do conhecimento do MinistÃ©rio PÃºblico Federal.', 'undefined', '2019-08-07', '2019-08-26', NULL, 4, NULL, '2019-08-12 17:16:26', '2019-08-12 17:16:26', 68, 2, 0, NULL, 853),
(916, 1, '1080/2019', '10154.111972/2019-47', 0, 'Informa que foi proferida decisÃ£o, designando audiÃªncia de conciliaÃ§Ã£o para a data de 14/08/2019, Ã s 14h, a ser realizada na sala de audiÃªncias da 6Âª Vara Ambiental e AgrÃ¡ria de FlorianÃ³polis.', 'undefined', '2019-08-07', '2019-08-14', '2019-08-12 19:43:38', 4, 4, '2019-08-12 19:39:18', '2019-08-12 19:43:39', 100, 3, 0, NULL, 804),
(917, 1, '1074/2019', '04972.006397/2016-82', 0, 'Informa que a decisÃ£o transitou em julgado em 17/07/2019. Desta forma, o processo deve ser arquivado em relaÃ§Ã£o Ã  UniÃ£o.', 'undefined', '2019-08-07', NULL, '2019-08-12 19:59:02', 4, 4, '2019-08-12 19:58:47', '2019-08-12 19:59:04', 100, 3, 0, NULL, 95),
(918, 1, '1073/2019', '04972.006086/2016-13', 0, 'Informa o trÃ¢nsito em julgado em 17/07/2019. Desta forma, o processo deverÃ¡ ser arquivado.', 'undefined', '2019-08-07', NULL, '2019-08-12 20:04:25', 4, 4, '2019-08-12 20:03:59', '2019-08-12 20:04:26', 100, 3, 0, NULL, 116),
(919, 1, '1072/2019', '04972.001336/2017-18', 0, 'Informa que foi proferida decisÃ£o intimando a UniÃ£o, da data da perÃ­cia.A referida perÃ­cia, ocorrerÃ¡ na data de 28 de agosto de 2019, Ã s 14:00 horas, serÃ¡ realizada pelo Sr. ClÃ¡udio Eduardo Bestetti Filho, Engenheiro Civil, no endereÃ§o do imÃ³vel objeto da lide.', 'undefined', '2019-08-07', NULL, '2019-08-12 20:08:24', 4, 4, '2019-08-12 20:08:05', '2019-08-12 20:08:26', 100, 3, 0, NULL, 571),
(920, 1, '1251/2019', '00099919720148240023', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-07', '2019-08-30', '2019-09-04 17:18:12', 4, 23, '2019-08-12 20:25:27', '2019-09-04 17:18:17', 126, 3, 0, NULL, 315),
(921, 1, '1265/2019', '04972.003557/2018-01', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', 'undefined', '2019-08-08', '2019-08-27', '2019-08-23 20:30:28', 4, 4, '2019-08-12 20:54:08', '2019-08-23 20:30:29', 114, 3, 0, NULL, 274),
(922, 1, '1264/2019', '00221059120128240038', 0, 'DisponibilizaÃ§Ã£o do Processo DemarcatÃ³rio.', 'undefined', '2019-08-08', '2019-08-19', '2019-08-15 16:23:03', 4, 3, '2019-08-12 21:07:23', '2019-08-15 22:00:04', 114, 3, 0, NULL, 640),
(923, 1, '1079/2019', '10154.116427/2019-47', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-08', '2019-08-22', '2019-08-20 15:37:11', 4, 4, '2019-08-13 20:57:11', '2019-08-20 15:39:34', 100, 3, 0, NULL, 854),
(924, 9, 'Mandado 5016764-91.2019.4.04.7200', '10154.112340/2019-09', 0, 'CONCEDEU A SEGURANÃ‡A para assegurar Ã  Impetrante o direito Ã  decisÃ£o administrativa (artigo 49 da Lei 9.784/99), quanto ao pedido de inscriÃ§Ã£o de ocupaÃ§Ã£o de terreno de marinha, nos termos do art. 487, inciso I, c/c art. 14 da Lei 12.016/09.', 'undefined', '2019-08-13', '2019-08-29', '2019-08-20 15:45:09', 3, 3, '2019-08-14 15:36:40', '2019-08-20 15:45:11', 307, 3, 1, NULL, 813),
(925, 1, '1256/2019', '10154.116874/2019-04', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.', 'undefined', '2019-08-08', '2019-08-21', NULL, 4, 4, '2019-08-14 22:20:23', '2019-08-14 22:22:34', 319, 2, 0, NULL, 855),
(926, 1, '185/2019', '10154.116983/2019-13', 0, 'que informe, no prazo de 15 (quinze) dias, sobre a propriedade do imÃ³vel com InscriÃ§Ã£o ImobiliÃ¡ria n. 01.05.028.1500, situado Ã s margens da linha fÃ©rrea, na Rua JosÃ© Dal Pizzol, s/n, prÃ³ximo Ã  captaÃ§Ã£o (caixa d\'Ã¡gua) da VISAN, Bairro Farroupilha, na Cidade de Videira/SC.', 'Encaminhado ao NUCIP.\nEnvolve Ã¡rea da extinta Rede FerroviÃ¡ria S/A', '2019-08-14', '2019-08-30', '2019-08-21 20:00:21', 8, 3, '2019-08-15 15:36:38', '2019-08-21 20:00:23', 320, 3, 0, NULL, 856),
(927, 1, '451/2019', '10154.117086/2019-27', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-14', '2019-08-19', '2019-08-20 20:35:22', 4, 4, '2019-08-15 16:33:01', '2019-08-20 22:14:47', 216, 3, 0, NULL, 858),
(928, 1, '69/2019', '10154.117200/2019-19', 0, 'InformaÃ§Ãµes atualizadas acerca da demarcaÃ§Ã£o e ou homologaÃ§Ã£o da LPM 1831 no trecho em questÃ£o e sobre a regularidade da ocupaÃ§Ã£o.', 'undefined', '2019-08-13', '2019-09-13', NULL, 4, NULL, '2019-08-15 20:25:50', '2019-08-15 20:25:50', 224, 2, 0, NULL, 859),
(929, 1, '1261/2019', '10154.117249/2019-71', 0, 'Informa acerca das decisÃµes , que puseram desfecho a aÃ§Ã£o, que culminou com o restabelecimento da sentenÃ§a que havia julgado extinto o feito em face da prescriÃ§Ã£o.', 'undefined', '2019-08-08', NULL, '2019-08-15 21:31:33', 4, 8, '2019-08-15 21:31:15', '2019-08-19 22:48:22', 126, 3, 0, NULL, 860),
(930, 1, '80/2019', '04972.004026/2016-66', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', 'undefined', '2019-08-14', '2019-09-16', NULL, 4, 4, '2019-08-19 15:58:38', '2019-08-19 15:59:15', 224, 2, 0, NULL, 284),
(931, 1, '1383/2019', '04972.006210/2018-11', 0, 'adotar providÃªncias para cumprir o julgado, ou seja, a sentenÃ§a proferida no evento 17, que â€œ(...)JULGO PROCEDENTE o pedido contido na inicial, para CONDENAR a rÃ© UNIÃƒO Ã  obrigaÃ§Ã£o de fazer atravÃ©s de regular processo administrativo, no prazo de 90 dias, a efetiva preservaÃ§Ã£o das Ã¡reas ocupadas ou nÃ£o, com a demarcaÃ§Ã£o das mesmas, cadastramento e fiscalizaÃ§Ã£o, por intermÃ©dio da SPU/SC, sobre todos os imÃ³veis localizados em terrenos de marinha e acrescidos, abrangidos na Ã¡rea PRAIA DA BARRA, GAROPABA/SC, sob pena de fixaÃ§Ã£o de multa diÃ¡ria de R$ 500,00 (quinhentos reais) para o caso de descumprimento, sem prejuÃ­zo da verificaÃ§Ã£o das sanÃ§Ãµes cÃ­veis e criminais no caso.â€, com a urgÃªncia necessÃ¡ria', 'undefined', '2018-06-11', '2018-09-04', NULL, 4, NULL, '2019-08-19 16:36:23', '2019-08-19 16:36:23', 126, 2, 1, NULL, 861),
(932, 1, '1112/2019', '04972.004196/2008-31', 0, 'indicaÃ§Ã£o de preposto, com conhecimento dos fatos e poder para transigir, para comparecimento Ã  audiÃªncia acima referida, no dia 27/08/2019, Ã s 17:00h.', 'undefined', '2019-08-14', '2019-08-23', NULL, 4, NULL, '2019-08-19 16:53:27', '2019-08-19 16:53:27', 100, 2, 0, NULL, 862),
(933, 1, '78/2019', '10154.117967/2019-48', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.', 'undefined', '2019-08-14', '2019-08-30', NULL, 4, 4, '2019-08-19 17:29:25', '2019-08-19 17:31:07', 224, 2, 0, NULL, 865),
(934, 1, '79/2019', '10154.118060/2019-04', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.', 'undefined', '2019-08-14', '2019-08-30', NULL, 4, 4, '2019-08-19 19:40:41', '2019-08-19 19:42:49', 224, 2, 0, NULL, 866),
(935, 1, '76/2019', '10154.118070/2019-31', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o - TransferÃªncia.', 'SubsÃ­dios solicitados ao setor tÃ©cnico responsÃ¡vel pelos registros.', '2019-08-14', '2019-08-30', '2019-08-23 20:20:38', 4, 4, '2019-08-19 20:08:05', '2019-08-26 16:56:49', 224, 3, 0, NULL, 867),
(936, 1, '77/2019', '10154.118078/2019-06', 0, 'SubsÃ­dios Ã  defesa da UniÃ£o.', 'undefined', '2019-08-14', '2019-08-30', NULL, 4, NULL, '2019-08-19 20:21:29', '2019-08-19 20:21:29', 224, 2, 0, NULL, 868),
(937, 1, '68/2019', '04972.002042/2017-03', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial', 'undefined', '2019-08-14', '2019-08-26', NULL, 4, 4, '2019-08-19 20:46:23', '2019-08-19 20:47:07', 99, 2, 0, NULL, 869),
(938, 1, '81/2019', '04972.008723/2018-58', 0, 'Informa o condenaÃ§Ã£o da UniÃ£o ao pagamento de indenizaÃ§Ã£o por danos morais.', 'Encaminho o presente processo Ã  unidade SEI-MP SPU-SC para conhecimento das informaÃ§Ãµes contidas no OFÃCIO n. 00081/2019/GEPAM/PUSC/PGU/AGU e NOTA JURÃDICA n. 00004/2019/GEPAM/PUSC/PGU/AGU, acerca da condenaÃ§Ã£o da UniÃ£o ao pagamento de indenizaÃ§Ã£o por danos\r\nmorais pelo suposto descumprimento de ordem judicial, nÃ£o cabendo mais recurso.\r\n\r\nOs expedientes acima mencionados nÃ£o apontam quais providÃªncias subsequentes deverÃ£o ser tomadas.', '2019-08-15', NULL, '2019-08-23 16:19:31', 4, 3, '2019-08-19 21:21:10', '2019-08-23 16:19:32', 224, 3, 0, NULL, 870),
(939, 1, '1309/2019', '10154.118292/2019-54', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial', 'undefined', '2019-08-15', '2019-09-03', NULL, 4, NULL, '2019-08-20 16:11:17', '2019-08-20 16:11:17', 114, 5, 0, NULL, 871),
(940, 1, '83/2019', '00099919720148240023', 0, 'ManifestaÃ§Ã£o sobre novos documentos.', 'undefined', '2019-08-15', '2019-09-16', '2019-09-04 17:19:50', 4, 23, '2019-08-20 16:30:20', '2019-09-04 17:19:53', 224, 3, 0, NULL, 315),
(941, 1, '75/2019', '04972.000611/2017-78', 0, 'ManifestaÃ§Ã£o sobre complementaÃ§Ã£o da PerÃ­cia.', 'undefined', '2019-08-15', '2019-08-30', '2019-09-04 17:01:34', 4, 8, '2019-08-20 19:54:11', '2019-09-04 17:01:34', 99, 7, 0, NULL, 360),
(942, 1, '1115/2019', '04972.006551/2018-88', 0, 'Informa a realizaÃ§Ã£o de PerÃ­cia.', 'undefined', '2019-08-15', NULL, '2019-08-20 20:05:47', 4, 4, '2019-08-20 20:05:10', '2019-08-20 20:05:51', 100, 3, 0, NULL, 872),
(943, 1, '1106/2019', '04972.002049/2017-17', 0, 'Informa a realizaÃ§Ã£o de perÃ­cia na data de 16 de outubro de 2019, Ã s 10:00 horas,  realizada pelo Sr. Daniel Fernandes Dinslaken, Perito Ambiental-BiÃ³logo, CRBio 63359-03, no endereÃ§o do imÃ³vel objeto da lide', 'undefined', '2019-08-15', NULL, '2019-08-20 20:17:21', 4, 4, '2019-08-20 20:17:04', '2019-08-20 20:17:22', 100, 3, 0, NULL, 873),
(944, 1, '88/2019', '04972.002558/2019-10', 0, 'Resposta ao OfÃ­cio  53796/2019/DIGES-SPU-SC/MP.', 'undefined', '2019-08-16', NULL, NULL, 4, NULL, '2019-08-20 20:56:44', '2019-08-20 20:56:44', 106, 2, 0, NULL, 250),
(945, 9, '01', '04972.003389/2019-27', 0, 'suspensÃ£o de multa de averbaÃ§Ã£o de transferÃªncia.', 'undefined', '2019-08-20', NULL, '2019-08-22 16:13:24', 8, 4, '2019-08-21 15:58:53', '2019-08-22 16:13:25', 126, 3, 1, NULL, 339),
(946, 1, '1161/2019', '10154.118638/2019-14', 0, 'verificar interferÃªncia da Ã¡rea com bens da UniÃ£o.', 'undefined', '2019-08-20', '2019-09-23', NULL, 8, 8, '2019-08-21 20:00:27', '2019-08-21 20:00:41', 85, 2, 0, NULL, 875),
(947, 1, '86/2019', '04972.006272/2018-14', 0, 'ManifestaÃ§Ã£o sobre novos documentos.', 'undefined', '2019-08-16', '2019-09-02', '2019-09-04 17:02:57', 4, 23, '2019-08-21 20:54:03', '2019-09-04 17:24:12', 224, 3, 0, NULL, 876),
(948, 1, '85/2019', '04972.000807/2019-24', 0, 'ManifestaÃ§Ã£o sobre novos documentos', 'undefined', '2019-08-16', '2019-09-02', '2019-09-04 17:13:58', 4, 3, '2019-08-21 21:05:28', '2019-09-04 17:13:58', 224, 7, 0, NULL, 44),
(949, 1, '890/2019', '04972.000528/2017-07', 0, 'manifestaÃ§Ã£o tÃ©cnica conclusiva indicada na NOTA n. 00042/2019/CJU-SC/CGU/AGU', 'undefined', '2019-08-16', '2019-08-30', '2019-08-29 20:49:25', 4, 4, '2019-08-21 22:01:24', '2019-09-02 21:11:18', 322, 3, 0, NULL, 118),
(950, 1, '521/2019', '10154.119207/2019-75', 0, 'que se realize vistoria na localidade de Garopaba do Sul, no municÃ­pio de Jaguaruna (entre as coordenadas UTM (WGS 84) 703143.73 mE - 6833027.03 mS e 706234.94 mE - 6832665.16 mS)', 'undefined', '2019-08-16', '2019-10-16', NULL, 4, 4, '2019-08-22 16:53:41', '2019-08-22 16:54:01', 65, 2, 0, NULL, 877),
(951, 1, '2153/2019', '04972.004076/2019-96', 0, 'ReiteraÃ§Ã£o ofÃ­cio nÂ° 617/2019-DPF/JVE/SC - URGENTE .', 'undefined', '2019-08-16', '2019-08-16', NULL, 4, NULL, '2019-08-22 17:10:54', '2019-08-22 17:10:54', 289, 2, 0, NULL, 546),
(952, 1, '93/2019', '04972.003560/2019-06', 0, 'IndicaÃ§Ã£o de assistente tÃ©cnico e quesitos', 'undefined', '2019-08-19', '2019-08-28', NULL, 4, 4, '2019-08-22 20:02:19', '2019-08-22 20:12:34', 106, 2, 0, NULL, 384),
(953, 1, '1329/2019', '10154.119369/2019-11', 0, 'ante o descumprimento da ordem de demoliÃ§Ã£o pelo rÃ©u, o autor (MPF) requereu ao MM. Juiz que a ordem seja cumprida pela SPU, jÃ¡ que se trata de ocupaÃ§Ã£o irregular em bens da UniÃ£o.', 'undefined', '2019-08-19', '2019-08-29', NULL, 4, 4, '2019-08-22 20:39:44', '2019-08-22 20:45:10', 114, 2, 0, NULL, 878),
(954, 1, '91/2019', '04972.001438/2017-25', 0, 'ManifestaÃ§Ã£o sobre documentos juntados pelo autor.', 'undefined', '2019-08-19', '2019-08-28', '2019-08-29 16:47:06', 4, 3, '2019-08-22 22:01:58', '2019-08-29 16:47:08', 224, 3, 0, NULL, 879),
(955, 1, '1337/2019', '10154.119890/2019-41', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-20', '2019-08-30', NULL, 4, 4, '2019-08-23 20:50:57', '2019-08-23 20:52:17', 114, 2, 0, NULL, 880),
(956, 1, '94/2019', '04972.002025/2017-68', 0, 'Encaminha Parecer informando o seguinte acordo:  Tratando-se de ocupaÃ§Ã£o de terreno de marinha ou acrescido de marinha, o MunicÃ­pio obrigarÃ¡ o ocupante a promover a sua inscriÃ§Ã£o/regularizaÃ§Ã£o junto Ã  SuperintendÃªncia do PatrimÃ´nio da UniÃ£o em Santa Catarina â€“ SPU/SC. Em caso de recusa ou omissÃ£o do ocupante, o MunicÃ­pio oficiarÃ¡ a SPU/SC para que tenha ciÃªncia do fato e possa tomar as providÃªncias que entender cabÃ­veis.', 'undefined', '2019-08-20', NULL, '2019-08-23 21:07:46', 4, 4, '2019-08-23 21:07:28', '2019-08-23 21:07:47', 224, 3, 0, NULL, 882),
(957, 1, '0015', '10983.012958/86-98', 0, 'informaÃ§Ã£o sobre dÃ©bitos existentes para o imÃ³vel.', 'undefined', '2019-08-20', '2019-09-05', NULL, 8, NULL, '2019-08-23 21:40:51', '2019-08-23 21:40:51', 297, 2, 0, NULL, 883),
(958, 6, '7/2019', '04972.006537/2017-01', 0, 'Encaminha o Parecer 7/2019', 'undefined', '2019-08-20', NULL, NULL, 4, NULL, '2019-08-23 22:14:12', '2019-08-23 22:14:12', 106, 1, 0, NULL, 885),
(959, 1, '2705', '10154.104190/2019-51', 0, 'informaÃ§Ãµes atualizadas sobre a regularizaÃ§Ã£o dos ranchos de pesca em Ã¡rea de marinha na localidade da Barra do AririÃº, PalhoÃ§a/SC', 'undefined', '2019-07-02', '2019-08-02', '2019-08-28 14:32:00', 8, 4, '2019-08-26 16:54:29', '2019-08-28 17:25:21', 95, 3, 0, NULL, 599),
(960, 1, '87/2019', '10154.120143/2019-55', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-20', '2019-09-03', NULL, 4, 4, '2019-08-26 19:15:34', '2019-08-26 19:16:00', 99, 2, 0, NULL, 886),
(961, 1, '90/2019', '10154.120152/2019-46', 0, 'Encaminha o PARECER DE FORÃ‡A EXECUTÃ“RIA n.00006/2019/GEPAM/PUSC/PGU/AGU.\nAnotaÃ§Ã£o na matrÃ­cula n. 17.851 (porÃ§Ã£o da Ã¡rea equivalente a terreno de marinha).', 'Enviado Ã  CoordenaÃ§Ã£o para promover o registro.', '2019-08-20', NULL, NULL, 4, 8, '2019-08-26 19:58:55', '2019-08-27 15:35:23', 99, 2, 1, NULL, 887),
(962, 1, '89/2019', '10154.120158/2019-13', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-20', '2019-09-03', NULL, 4, 4, '2019-08-26 20:25:59', '2019-08-26 20:26:08', 99, 2, 0, NULL, 888),
(963, 1, '98/2019', '10154.120171/2019-72', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-21', '2019-09-04', NULL, 4, NULL, '2019-08-26 20:44:14', '2019-08-26 20:44:14', 224, 2, 0, NULL, 890),
(964, 1, '97/2019', '04972.008437/2017-10', 0, 'dar cumprimento Ã  decisÃ£o judicial acima, solicito se proceda:\n- Ã  \"compensaÃ§Ã£o administrativa dos valores pagos a maior administrativamente, com os\nvalores em aberto\"; e\n- Ã  \"revisÃ£o do valor lanÃ§ado para o ano de 2019, conforme o julgado\"', 'undefined', '2019-08-21', '2019-09-06', NULL, 4, 4, '2019-08-26 21:28:11', '2019-08-26 21:28:39', 224, 2, 0, NULL, 140),
(965, 1, '534/2019', '04972.008946/2018-15', 0, 'esclareÃ§a se hÃ¡ processo administrativo referente ao Mercado PÃºblico de ImaruÃ­ (coordenadas geogrÃ¡ficas 28Âº 20\'44.70\'\'S / 48Âº 49\'1.00\'\'O', 'undefined', '2019-08-21', '2019-09-06', NULL, 4, 4, '2019-08-26 22:07:33', '2019-08-26 22:08:03', 65, 2, 0, NULL, 829),
(966, 1, '101/2019', '10154.120293/2019-69', 0, 'ManifestaÃ§Ã£o de interesse.', 'undefined', '2019-08-22', '2019-09-12', NULL, 4, NULL, '2019-08-27 16:11:50', '2019-08-27 16:11:50', 224, 2, 0, NULL, 894),
(967, 1, '537/2019', '10154.120298/2019-91', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-22', '2019-09-17', NULL, 4, NULL, '2019-08-27 16:25:34', '2019-08-27 16:25:34', 65, 2, 0, NULL, 896),
(968, 1, '1118/2019', '00745.002261/2019-79', 0, 'Informa a realizaÃ§Ã£o de perÃ­cia.', 'undefined', '2019-08-23', NULL, '2019-08-27 17:07:23', 4, 4, '2019-08-27 17:06:59', '2019-08-27 17:07:24', 100, 3, 0, NULL, 427),
(969, 1, '1119/2019', '10154.111972/2019-47', 0, 'solicito a indicaÃ§Ã£o de preposto para acompanhamento da inspeÃ§Ã£o judicial no dia 19/11/2019, Ã s 14:30h e participaÃ§Ã£o na audiÃªncia no dia 10/12/2019, Ã s 14:00h, com poderes para transigir acerca do interesse pÃºblico da UNIÃƒO, se houver necessidade.', 'undefined', '2019-08-23', NULL, NULL, 4, NULL, '2019-08-27 17:23:18', '2019-08-27 17:23:18', 100, 2, 0, NULL, 804),
(970, 1, '0000439-69.2000.8.24.00330040', '10154.120394/2019-30', 0, 'informar sobre a existÃªncia de autorizaÃ§Ã£o de ocupaÃ§Ã£o quanto ao imÃ³vel localizado na Rua JequitibÃ¡, 357, Campo Grande, Bombinhas/SC, e, em caso positivo, indique o(s) titular(es) da inscriÃ§Ã£o de ocupaÃ§Ã£o, bem como se hÃ¡ recolhimento de taxa de ocupaÃ§Ã£o', 'O que falta fazer:\r\ninformar sobre a existÃªncia de autorizaÃ§Ã£o de ocupaÃ§Ã£o quanto ao imÃ³vel localizado na Rua JequitibÃ¡, 357, Campo Grande, Bombinhas/SC, e, em caso positivo, indique o(s) titular(es) da inscriÃ§Ã£o de ocupaÃ§Ã£o, bem como se hÃ¡ recolhimento de taxa de ocupaÃ§Ã£o', '2019-08-23', '2019-09-10', NULL, 4, 1, '2019-08-27 19:46:34', '2019-08-28 16:41:47', 323, 2, 0, NULL, 897),
(971, 9, '5015883-17.2019.4.04.7200', '10154.120392/2019-41', 0, 'Prestar informaÃ§Ã£o em Mandado de SeguranÃ§a contra Multa de TransferÃªncia - AlegaÃ§Ã£o de que nÃ£o incide em transferÃªncia nÃ£o onerosa.', 'undefined', '2019-08-27', '2019-09-09', '2019-09-04 21:22:51', 3, 3, '2019-08-27 20:01:55', '2019-09-04 21:22:53', 161, 3, 0, NULL, 898),
(972, 1, '484/2019', '10154.120402/2019-48', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-23', '2019-09-03', NULL, 4, NULL, '2019-08-27 20:13:12', '2019-08-27 20:13:12', 216, 2, 0, NULL, 899),
(973, 1, '1070/2016', '04972.201342/2015-01', 0, 'Encaminha o PARECER SOBRE FORÃ‡A EXECUTÃ“RIA, atestando o forÃ§a executÃ³ria do acÃ³rdÃ£o, o qual afastou definitivamente a cobranÃ§a do laudÃªmio dos autores.', 'undefined', '2016-08-16', NULL, NULL, 4, NULL, '2019-08-27 20:47:54', '2019-08-27 20:47:54', 107, 1, 0, NULL, 900),
(974, 1, '3516', '10154.120459/2019-47', 0, 'informaÃ§Ãµes atualizadas s sobre os ranchos de pesca no Rio Imaruim, observada a Nota TÃ©cnica 10691/2019-MP, trazendo, tambÃ©m, a situaÃ§Ã£o atual dos registros levantados e cadastramento dos ranchos regularizados.\n IC NÂ° 1.33.000.000626/2013-42. RANCHOS DE PESCA DO RIO IMARUIM. MUNICÃPIO DE PALHOÃ‡A.', 'undefined', '2019-08-27', '2019-09-27', NULL, 8, NULL, '2019-08-27 22:19:51', '2019-08-27 22:19:51', 95, 2, 0, NULL, 214),
(975, 1, '0000439-69.2000.8.24.0033-0040', '10154.120654/2019-77', 0, 'informar sobre a existÃªncia de autorizaÃ§Ã£o de ocupaÃ§Ã£o quanto ao imÃ³vel localizado na Rua JequitibÃ¡, 357, Campo Grande, Bombinhas/SC, e, em caso positivo, indique o(s) titular(es) da inscriÃ§Ã£o de ocupaÃ§Ã£o, bem como se hÃ¡ recolhimento de taxa de ocupaÃ§Ã£o, de acordo com a cÃ³pia da respectiva decisÃ£o anexa, bem como de demais documentos extraÃ­dos dos autos.', 'O que falta fazer:\r\ninformar sobre a existÃªncia de autorizaÃ§Ã£o de ocupaÃ§Ã£o quanto ao imÃ³vel localizado na Rua JequitibÃ¡, 357, Campo Grande, Bombinhas/SC, e, em caso positivo, indique o(s) titular(es) da inscriÃ§Ã£o de ocupaÃ§Ã£o, bem como se hÃ¡ recolhimento de taxa de ocupaÃ§Ã£', '2019-08-22', '2019-09-12', NULL, 1, 1, '2019-08-28 16:11:06', '2019-08-28 16:41:34', 323, 4, 0, NULL, 903),
(976, 1, '565/2019', '10154.120792/2019-56', 0, 'ManifestaÃ§Ã£o de Interesse', 'undefined', '2019-08-26', '2019-09-16', NULL, 4, 4, '2019-08-28 19:24:33', '2019-08-28 19:26:00', 65, 2, 0, NULL, 904),
(977, 1, '107/2019', '10154.120806/2019-31', 0, 'se manifeste sobre a proposta de conciliaÃ§Ã£o, ou seja, se haveria possibilidade de regularizaÃ§Ã£o da ocupaÃ§Ã£o nos terrenos de marinha e acrescidos, com diminuiÃ§Ã£o da Ã¡rea de preservaÃ§Ã£o no leito do rio, no seguinte modo proposto:\n1. ElaboraÃ§Ã£o e execuÃ§Ã£o de PRAD para a Ã¡rea 1 (maior), de modo a que a faixa de preservaÃ§Ã£o a partir do rio seja de 30 metros.\n2. ElaboraÃ§Ã£o e execuÃ§Ã£o de PRAD para a Ã¡rea 2 (menor), de modo a que a faixa de preservaÃ§Ã£o a partir do rio seja de 15 metros;\n3. como compensaÃ§Ã£o ambiental pela supressÃ£o da faixa de APP do leio do rio, a construtora promoveria o custeio do plano de manejo para o MunicÃ­pio de Itapema, para cumprimento do Decreto Municipal nÂº 087/2012, que criou a Unidade de ConservaÃ§Ã£o e RefÃºgio da Vida Silvestre - ev. 190', 'undefined', '2019-08-26', '2019-09-18', NULL, 4, 4, '2019-08-28 19:56:06', '2019-08-28 19:57:10', 99, 2, 0, NULL, 905),
(978, 1, '1266/2019', '04972.002471/2017-72', 0, 'ManifestaÃ§Ã£o sobre Laudo complementar', 'undefined', '2019-08-09', '2019-09-02', '2019-09-02 17:25:25', 3, 4, '2019-08-28 20:29:24', '2019-09-02 17:25:27', 114, 3, 0, NULL, 543),
(979, 2, 'n/i', '10154.120845/2019-39', 0, 'ManifestaÃ§Ã£o de Interesse', 'undefined', '2019-08-26', '2019-08-06', NULL, 4, 8, '2019-08-28 20:32:43', '2019-09-04 20:11:09', 121, 6, 0, NULL, 906),
(980, 1, '555/2019', '04972.200527/2015-91', 0, 'informaÃ§Ãµes atualizadas sobre o Processo n. 04972.200527/2015-91', NULL, '2019-08-26', '2019-09-16', '2019-09-04 20:12:13', 4, 23, '2019-08-28 20:47:44', '2019-09-04 20:12:18', 65, 3, 0, NULL, 907),
(981, 1, '105/2019', '10154.106543/2019-58', 0, 'ComplementaÃ§Ã£o das informaÃ§Ãµes para a elaboraÃ§Ã£o da defesa da UniÃ£o contra os pedidos formulados no processo.', 'undefined', '2019-08-26', '2019-09-11', NULL, 4, NULL, '2019-08-28 21:21:11', '2019-08-28 21:21:11', 224, 2, 0, NULL, 725),
(982, 1, '538/2019', '04972.001558/2017-22', 0, 'Reitera o OfÃ­cio 837/2018 - Requisita informaÃ§Ãµes quanto Ã  previsÃ£o para adoÃ§Ã£o das medidas necessÃ¡rias ao cumprimento da norma prevista no Art. 22-A, da Lei 9.636/98 na rua Tocantins, nÂº 56, Centro, Blumenau/SC.', 'undefined', '2019-08-21', NULL, NULL, 3, NULL, '2019-08-29 15:45:43', '2019-08-29 15:45:43', 312, 2, 0, NULL, 908),
(983, 1, '02177', '04972.002293/2017-80', 0, 'adoÃ§Ã£o de eventuais providÃªncias cabÃ­veis, cÃ³pias dos autos e da decisÃ£o proferida pelo Superior Tribunal de JustiÃ§a no RECURSO ESPECIAL NÂ° 1.796.820 - SC (2019/0037171-4), que deu provimento ao recurso especial para reconhecer a prescriÃ§Ã£o da pretensÃ£o autoral quanto Ã  nulidade do processo demarcatÃ³rio de terreno de marinha, bem como a possibilidade de cobranÃ§a de laudÃªmio na transferÃªncia onerosa de bem imÃ³vel ou de benfeitorias nele construÃ­das, ainda que em regime de ocupaÃ§Ã£o, relativo ao RIP n. 8161.0000055-78.', 'undefined', '2019-08-22', NULL, NULL, 8, NULL, '2019-08-29 16:19:34', '2019-08-29 16:19:34', 308, 2, 1, NULL, 909),
(984, 1, '110/2019', '10154.121190/2019-16', 0, 'InformaÃ§Ãµes a respeito da conclusÃ£o dos trabalhos de revisÃ£o da ComissÃ£o de DemarcaÃ§Ã£o da Linha Preamar MÃ©dia de 1831, no municÃ­pio de Joinville, designada pela Portaria SPU NÂº 211/2010.', 'undefined', '2019-08-27', '2019-09-16', NULL, 4, 4, '2019-08-29 19:07:50', '2019-08-29 19:08:55', 99, 2, 0, NULL, 910),
(985, 1, '675/2019', '04972.206417/2015-32', 0, 'esclareÃ§a se Ã© necessÃ¡rio ou nÃ£o a autorizaÃ§Ã£o do Ã³rgÃ£o para fins de regularizaÃ§Ã£o da obra de reurbanizaÃ§Ã£o da Via GastronÃ´mica da Praia de ArmaÃ§Ã£o no MunicÃ­pio de Penha/SC.', 'undefined', '2019-08-27', '2019-09-09', NULL, 4, 4, '2019-08-29 19:17:12', '2019-08-29 19:21:35', 74, 2, 0, NULL, 453),
(986, 1, '99/2019', '10154.121239/2019-31', 0, 'Quesitos e assistente tÃ©cnico.', 'undefined', '2019-08-26', '2019-09-13', NULL, 4, 4, '2019-08-29 19:39:53', '2019-08-29 19:40:13', 99, 2, 0, NULL, 911),
(987, 1, '1168/2019', '04972.003269/2017-68', 0, 'Informa a data da perÃ­cia.', 'undefined', '2019-08-28', NULL, '2019-08-29 20:01:14', 4, 4, '2019-08-29 20:00:42', '2019-08-29 20:01:16', 100, 3, 0, NULL, 912),
(988, 1, '1169/2019', '04972.001528/2017-16', 0, 'Informa a data da perÃ­cia.', 'undefined', '2019-08-28', NULL, '2019-08-29 20:07:57', 4, 4, '2019-08-29 20:07:35', '2019-08-29 20:07:59', 100, 3, 0, NULL, 913),
(989, 1, '1165/2019', '04972.006391/2018-77', 0, 'ReiteraÃ§Ã£o do OFÃCIO n. 00111/2019/PATRIM/PUSC/PGU/AGU', 'undefined', '2019-08-28', '2019-09-27', NULL, 4, 4, '2019-08-29 20:31:41', '2019-08-29 20:44:27', 224, 2, 0, NULL, 175),
(990, 1, '1171/2019', '04972.002416/2016-00', 0, 'Informa a data da PerÃ­cia.', 'undefined', '2019-08-28', NULL, '2019-08-29 20:51:25', 4, 4, '2019-08-29 20:51:08', '2019-08-29 20:51:26', 100, 3, 0, NULL, 914),
(991, 1, '1167/2019', '04972.003733/2016-35', 0, 'Informa a data da perÃ­cia.', 'undefined', '2019-08-28', NULL, '2019-08-29 20:58:59', 4, 4, '2019-08-29 20:58:06', '2019-08-29 20:59:00', 100, 3, 0, NULL, 915),
(992, 1, '1164/2019', '04972.004990/2016-94', 0, 'se digne determinar o fornecimento da manifestaÃ§Ã£o do laudo pericial complementar.', 'undefined', '2019-08-28', '2019-09-12', NULL, 4, 4, '2019-08-29 21:47:50', '2019-08-29 21:59:57', 100, 2, 0, NULL, 34),
(993, 1, '1161/2019', '10154.121351/2019-71', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-28', '2019-09-12', NULL, 4, NULL, '2019-08-29 22:17:32', '2019-08-29 22:17:32', 100, 2, 0, NULL, 916),
(994, 1, '1150/2019', '00745.002248/2019-10', 0, 'Informa a data da perÃ­cia.', 'undefined', '2019-08-28', NULL, '2019-08-29 22:28:40', 4, 4, '2019-08-29 22:28:16', '2019-08-29 22:28:41', 100, 3, 0, NULL, 429),
(995, 1, '117/2019', '04972.005144/2017-72', 0, 'CÃ³pia de plantas com coordenadas, manifestaÃ§Ã£o quanto ao evento 103 e indicaÃ§Ã£o de representante para participar de audiÃªncia', 'undefined', '2019-08-29', '2019-09-11', NULL, 3, NULL, '2019-08-30 15:37:04', '2019-08-30 15:37:04', 234, 2, 0, NULL, 13),
(996, 1, '1159', '10154.121402/2019-65', 0, 'indicaÃ§Ã£o de preposto, com conhecimento dos fatos e poder para transigir, para comparecimento Ã  audiÃªncia acima referida, no dia 23/10/2019, Ã s 15:00h.', 'undefined', '2019-08-22', '2019-10-18', NULL, 8, NULL, '2019-08-30 19:47:35', '2019-08-30 19:47:35', 100, 2, 0, NULL, 917),
(997, 1, '1395/2019', '10154.101585/2019-01', 0, 'manifestaÃ§Ã£o em defesa dos interesses da UniÃ£o quanto aos documentos juntados no 65 pela FLORAM.', 'undefined', '2019-08-28', '2019-08-16', NULL, 4, 4, '2019-08-30 20:15:36', '2019-08-30 20:16:49', 114, 2, 0, NULL, 626),
(998, 1, '1394/2019', '10154.121796/2019-51', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial', 'undefined', '2019-08-28', '2019-09-10', NULL, 4, 4, '2019-08-30 20:57:56', '2019-08-30 20:58:14', 114, 2, 0, NULL, 918),
(999, 1, '296/2019', '04972.002766/2019-19', 0, 'Encaminha SentenÃ§a de procedÃªncia para determinar que a UniÃ£o se abstenha de cobrar da autora as taxas de ocupaÃ§Ã£o sobre os imÃ³veis de RIPs 8045.0000277-43 e 8045.0000278-24.', 'undefined', '2019-08-28', NULL, NULL, 4, NULL, '2019-08-30 21:18:05', '2019-08-30 21:18:05', 324, 2, 0, NULL, 143),
(1000, 1, '1393/2019', '10154.121854/2019-47', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-28', '2019-09-18', NULL, 4, 4, '2019-08-30 21:32:39', '2019-08-30 21:43:04', 114, 2, 0, NULL, 919),
(1001, 1, '01424/2019', '10154.121542/2019-33', 0, 'dar imediato cumprimento quanto Ã  suspensÃ£o da cobranÃ§a dos dÃ©bitos, bem como prestar as informaÃ§Ãµes para a defesa da UniÃ£o', 'undefined', '2019-09-30', NULL, NULL, 23, NULL, '2019-09-02 17:23:08', '2019-09-02 17:23:08', 114, 2, 1, NULL, 920),
(1002, 1, '112/2019', '04972.003964/2016-49', 0, 'AnÃ¡lise de Laudo Complementar que trata de tratamento de esgoto na Bacia do Itacorubi - FlorianÃ³polis/SC', 'undefined', '2019-08-28', '2019-10-07', NULL, 3, 3, '2019-09-02 20:03:26', '2019-09-02 20:10:38', 228, 2, 0, NULL, 921),
(1003, 1, '114/2019', '04972.002041/2017-51', 0, 'ManifestaÃ§Ã£o sobre petiÃ§Ã£o.', 'undefined', '2019-08-29', '2019-09-09', NULL, 4, NULL, '2019-09-02 21:48:49', '2019-09-02 21:48:49', 106, 2, 0, NULL, 922),
(1004, 9, '5001894-90.2019.4.04.7216', '10154.122163/2019-61', 0, 'determinar Ã  autoridade coatora que proceda Ã  conclusÃ£o da anÃ¡lise do pedido de ocupaÃ§Ã£o, referente ao processo n.\r\n04972.005344/2014-82, no prazo de atÃ© 30 dias, sob pena de multa diÃ¡ria de R$ 1.000,00\r\n(mil reais).', 'undefined', '2019-09-27', '2019-09-27', NULL, 3, NULL, '2019-09-02 22:28:59', '2019-09-02 22:28:59', 307, 2, 1, NULL, 923),
(1005, 1, '1396/2019', '10154.122255/2019-41', 0, 'ManifestaÃ§Ã£o de Interesse', 'undefined', '2019-08-28', '2019-09-16', NULL, 4, NULL, '2019-09-02 22:51:04', '2019-09-02 22:51:04', 114, 2, 0, NULL, 924),
(1006, 1, '2977/2019', '04972.003727/2018-40', 0, 'Por meio do OfÃ­cio 51984 (8804212) esta SPU-SC solicitou dilaÃ§Ã£o de prazo por 30 dias para resposta ao OfÃ­cio 1919/2019 (8522421). O prazo se esgotou em 14/08/2019. Realizar DiagnÃ³stico SÃ³cioambiental da Orla Sul de SÃ£o JosÃ©.', 'undefined', '2019-07-12', '2019-08-14', NULL, 3, NULL, '2019-09-03 15:30:53', '2019-09-03 15:30:53', 90, 2, 0, NULL, 135),
(1007, 1, '3604', '04972.008373/2017-49', 0, 'informaÃ§Ãµes atualizadas do projeto habitacional da \'OcupaÃ§Ã£o Contestado\'.', 'undefined', '2019-09-02', '2019-09-13', NULL, 8, NULL, '2019-09-03 15:52:54', '2019-09-03 15:52:54', 58, 2, 0, NULL, 110),
(1008, 1, '50/2019', '04972.003678/2018-45', 0, 'informar se hÃ¡ interferÃªncia do imÃ³vel usucapiendo com patrimÃ´nio da UniÃ£o', 'undefined', '2019-07-31', '2019-08-16', NULL, 3, NULL, '2019-09-03 19:44:57', '2019-09-03 19:44:57', 234, 2, 0, NULL, 925),
(1009, 1, '111/2019', '10154.122551/2019-41', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-28', '2019-09-19', NULL, 4, 4, '2019-09-03 19:56:40', '2019-09-03 19:59:11', 99, 2, 0, NULL, 927),
(1010, 1, '1399/2019', '04972.003892/2017-11', 0, 'ManifestaÃ§Ã£o sobre Laudo Pericial.', 'undefined', '2019-08-28', '2019-09-20', NULL, 4, NULL, '2019-09-03 20:07:36', '2019-09-03 20:07:36', 114, 2, 0, NULL, 413),
(1011, 1, '3623', '10154.122357/2019-66', 0, 'informaÃ§Ãµes\natualizadas sobre a regularidade do estabelecimento Marina Santo Antonio, situada na Rodovia Gilson da Costa Xavier n. 21, Sambaqui, FlorianÃ³polis/SC (S 27Â° 30 387, W 048Â° 31 314), no tocante ao uso da orla de praia.', 'undefined', '2019-09-02', '2019-10-04', NULL, 8, NULL, '2019-09-03 20:14:30', '2019-09-03 20:14:30', 95, 2, 0, NULL, 928),
(1012, 1, '1131/2019', '10154.122575/2019-09', 0, 'Encaminha o PARECER DE FORÃ‡A EXECUTÃ“RIA n. 00010/2019/GEPAM/PUSC/PGU/AGU informando a improcedÃªncia do processo.', 'undefined', '2019-08-28', NULL, NULL, 4, NULL, '2019-09-03 20:42:21', '2019-09-03 20:42:21', 100, 2, 0, NULL, 929),
(1013, 1, '116/2019', '04972.203332/2015-01', 0, 'Solicita seja avaliada a conveniÃªncia da retomada das providÃªncias ou da adoÃ§Ã£o de outras e reitera a possibilidade de agendamento de reuniÃ£o.', 'undefined', '2019-08-29', NULL, NULL, 4, NULL, '2019-09-03 21:01:45', '2019-09-03 21:01:45', 224, 2, 0, NULL, 165),
(1014, 1, '501/2019', '10154.122645/2019-11', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-29', '2019-09-10', NULL, 4, 4, '2019-09-03 21:37:40', '2019-09-03 21:38:04', 216, 5, 0, NULL, 930),
(1015, 1, '58/2019', '04972.001858/2016-21', 0, 'A AGU estÃ¡ solicitando, por meio do OfÃ­cio 58/2019, informaÃ§Ãµes atualizadas quanto Ã  ACP 50021179620164047200, que versa sobre  a degradaÃ§Ã£o ambiental em Ã¡rea de terrenos de marinha e de preservaÃ§Ã£o permanente no Bairro da ArmaÃ§Ã£o (ServidÃ£o EugÃªnio Amaro Duarte) - NUP SEI-ME 04972.001858/2016-21. Prazo 05/09/2019.', 'undefined', '2019-08-05', '2019-09-05', NULL, 3, NULL, '2019-09-03 21:52:20', '2019-09-03 21:52:20', 234, 2, 0, NULL, 931),
(1016, 1, '503/2019', '10154.122998/2019-11', 0, 'ManifestaÃ§Ã£o de Interesse.', 'undefined', '2019-08-30', '2019-09-16', NULL, 4, 4, '2019-09-04 20:21:58', '2019-09-04 20:22:10', 216, 2, 0, NULL, 932),
(1017, 1, '1219', '10154.122761/2019-30', 0, 'informaÃ§Ãµes, pormenorizadas, sobre o procedimento de cessÃ£o do imÃ³vel \"Horto Florestal Flor de Lay\" ao MunicÃ­pio de Araquari.', 'undefined', '2019-09-03', '2019-10-03', NULL, 8, NULL, '2019-09-04 21:03:32', '2019-09-04 21:03:32', 85, 2, 0, NULL, 933),
(1018, 4, '0429/2019', '04972.003778/2019-52', 0, 'Informar se hÃ¡ interferÃªncia do imÃ³vel usucapiendo em Ã¡rea de domÃ­nio pÃºblico federal.', 'undefined', '2019-04-15', '2019-10-14', NULL, 23, 23, '2019-09-04 21:44:07', '2019-09-04 21:44:42', 103, 2, 0, NULL, 938),
(1019, 1, '900/2019', '04972.200262/2015-21', 0, 'Reitera o OfÃ­cio 807/2019 e solicita:\r\n1) informaÃ§Ãµes atualizadas sobre a incorporaÃ§Ã£o da Ã¡rea em questÃ£o;\r\n2) esclarecimentos sobre o item \"10\" da comunicaÃ§Ã£o anexa\r\n(NUP 04972.200262/2015-21), vez que repleto de termos tÃ©cnicos que\r\nfogem do conhecimento do MinistÃ©rio PÃºblico Federal.', 'undefined', '2019-09-04', '2019-09-19', NULL, 3, 3, '2019-09-04 22:05:44', '2019-09-04 22:09:11', 68, 2, 0, NULL, 853);

-- --------------------------------------------------------

--
-- Estrutura da tabela `demandamovimentacao`
--

CREATE TABLE `demandamovimentacao` (
  `id` int(10) UNSIGNED NOT NULL,
  `idDemanda` int(10) UNSIGNED NOT NULL,
  `idDivisaoOrganogramaOrigem` int(10) UNSIGNED NOT NULL,
  `idDivisaoOrganogramaDestino` int(10) UNSIGNED NOT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `demandamovimentacao`
--

INSERT INTO `demandamovimentacao` (`id`, `idDemanda`, `idDivisaoOrganogramaOrigem`, `idDivisaoOrganogramaDestino`, `idUsuario`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 3, 1, '2019-01-23 20:13:55', '2019-01-23 20:13:55'),
(2, 1, 2, 4, 1, '2019-01-23 20:13:55', '2019-01-23 20:13:55'),
(3, 2, 2, 3, 1, '2019-02-14 21:38:39', '2019-02-14 21:38:39'),
(4, 3, 2, 3, 1, '2019-02-14 21:41:45', '2019-02-14 21:41:45'),
(5, 4, 2, 3, 1, '2019-02-14 21:44:01', '2019-02-14 21:44:01'),
(6, 5, 2, 3, 1, '2019-02-14 21:46:09', '2019-02-14 21:46:09'),
(7, 6, 2, 3, 1, '2019-02-14 21:47:54', '2019-02-14 21:47:54'),
(8, 7, 2, 3, 1, '2019-02-14 21:49:55', '2019-02-14 21:49:55'),
(9, 8, 2, 3, 1, '2019-02-14 21:50:59', '2019-02-14 21:50:59'),
(10, 9, 2, 3, 1, '2019-02-14 21:53:51', '2019-02-14 21:53:51'),
(11, 10, 2, 3, 1, '2019-02-14 21:55:29', '2019-02-14 21:55:29'),
(12, 11, 2, 3, 1, '2019-02-14 21:58:34', '2019-02-14 21:58:34'),
(13, 12, 2, 3, 1, '2019-02-14 21:59:53', '2019-02-14 21:59:53'),
(14, 13, 2, 3, 1, '2019-02-14 22:01:30', '2019-02-14 22:01:30'),
(15, 14, 2, 3, 1, '2019-02-14 22:04:02', '2019-02-14 22:04:02'),
(17, 16, 2, 3, 1, '2019-02-21 16:21:04', '2019-02-21 16:21:04'),
(18, 16, 2, 4, 1, '2019-02-21 16:21:04', '2019-02-21 16:21:04'),
(19, 17, 2, 4, 1, '2019-02-21 20:31:49', '2019-02-21 20:31:49'),
(20, 18, 2, 3, 1, '2019-02-21 21:27:31', '2019-02-21 21:27:31'),
(21, 19, 2, 4, 1, '2019-02-22 17:55:34', '2019-02-22 17:55:34');

-- --------------------------------------------------------

--
-- Estrutura da tabela `distribuicaodemanda`
--

CREATE TABLE `distribuicaodemanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `idDemanda` int(10) UNSIGNED NOT NULL,
  `idUsuarioDe` int(10) UNSIGNED NOT NULL,
  `dataDistribuicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dataAtendimento` timestamp NULL DEFAULT NULL,
  `comentarioDistribuicao` text COLLATE utf8mb4_unicode_ci,
  `comentarioAtendimento` text COLLATE utf8mb4_unicode_ci,
  `assignable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `assignable_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `distribuicaodemanda`
--

INSERT INTO `distribuicaodemanda` (`id`, `idDemanda`, `idUsuarioDe`, `dataDistribuicao`, `dataAtendimento`, `comentarioDistribuicao`, `comentarioAtendimento`, `assignable_type`, `assignable_id`) VALUES
(2, 16, 1, '2019-03-01 13:25:52', '2019-03-01 13:25:52', '123123', '234234', 'App\\DivisaoOrganograma', 3),
(3, 16, 1, '2019-03-01 13:25:42', '2019-03-01 13:25:42', 'testando', NULL, 'App\\User', 1),
(4, 21, 1, '2019-03-01 13:54:09', '2019-03-01 13:54:09', 'Fazer demanda 9999999999992', NULL, 'App\\User', 1),
(5, 22, 1, '2019-03-26 16:59:49', '2019-03-26 16:59:49', 'Juliano, o Advogado da UniÃ£o ligou hoje para cÃ¡ cobrando essa resposta. Deixou o telefone dele 99935-3732', NULL, 'App\\User', 5),
(6, 23, 4, '2019-03-26 17:21:43', '2019-03-26 17:21:43', NULL, NULL, 'App\\User', 5),
(7, 2, 1, '2019-05-28 17:03:39', '2019-05-28 17:03:39', 'Atualizando as atribuiÃ§Ãµes de acordo com os andamentos no SEI', NULL, 'App\\User', 5),
(8, 27, 1, '2019-03-11 13:49:25', '2019-03-11 13:49:25', NULL, 'AtribuiÃ§Ã£o duplicada', 'App\\User', 1),
(9, 27, 1, '2019-03-12 14:44:53', '2019-03-12 14:44:53', NULL, 'Respondia pelo OfÃ­cio 18539/2019', 'App\\User', 1),
(10, 33, 1, '2019-03-26 17:01:38', '2019-03-26 17:01:38', 'Informar se Ã¡rea incide com bens da UniÃ£o com base na informaÃ§Ã£o prestada pelo MunicÃ­pio (planta)', NULL, 'App\\User', 5),
(11, 35, 1, '2019-03-19 14:17:37', '2019-03-19 14:17:37', 'Apresentar memorial/planta legÃ­vel com coordenadas UTM em que demonstre a interferÃªncia com Ã¡rea de marinha', 'Respondido pelo OfÃ­cio nÂº 19374/2019/DIGES-SPU-SC/MP', 'App\\User', 5),
(12, 36, 1, '2019-03-15 14:14:10', '2019-03-15 14:14:10', NULL, 'Nota TÃ©cnica nÂº 5855/2019-MP', 'App\\User', 5),
(13, 37, 1, '2019-03-19 14:14:31', '2019-03-19 14:14:31', 'Analisar o levantamento topogrÃ¡fico fornecido pelo MunicÃ­pio de BiguaÃ§u e produzir manifestaÃ§Ã£o sobre interesse da UniÃ£o no feito.', 'Respondido pelo OfÃ­cio nÂº 19209/2019/DIGES-SPU-SC/MP', 'App\\User', 5),
(14, 1, 1, '2019-04-15 19:47:19', '2019-04-15 19:47:19', 'apresentar o exato posicionamento dos terrenos e acrescidos de marinha nas Ã¡reas compreendidas nas transcriÃ§Ãµes nÂº 12.480, nÂº 12.481 e nÂº 3.386 (evento 1, OUT35, fls. 16-33) e na matrÃ­cula nÂº 13.204 (evento 1, OUT35, fls. 13-15)', NULL, 'App\\User', 5),
(15, 39, 1, '2019-03-15 17:15:35', '2019-03-15 17:15:35', 'Minutar ofÃ­cio de resposta', 'OfÃ­cio nÂº 18987/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(16, 40, 1, '2019-03-15 14:08:25', '2019-03-15 14:08:25', 'indicar assistente tÃ©cnico e formular quesitos', 'Atendido pela Nota TÃ©cnica 5948/2019 - 8153476', 'App\\User', 5),
(17, 34, 1, '2019-03-26 17:20:13', '2019-03-26 17:20:13', 'produzir manifestaÃ§Ã£o sobre laudo pericial', NULL, 'App\\User', 5),
(18, 41, 1, '2019-05-28 16:55:32', '2019-05-28 16:55:32', 'para ciÃªncia e eventuais providÃªncias decorrentes da sentenÃ§a proferida na aÃ§Ã£o', NULL, 'App\\User', 5),
(19, 48, 8, '2019-03-26 16:58:22', '2019-03-26 16:58:22', NULL, NULL, 'App\\User', 5),
(20, 53, 4, '2019-03-26 17:04:38', '2019-03-26 17:04:38', NULL, NULL, 'App\\User', 5),
(21, 14, 1, '2019-03-15 14:39:46', '2019-03-15 14:39:46', 'Minutar OfÃ­cio ao MunicÃ­pio para demoliÃ§Ã£o dos quiosques', 'OfÃ­cio nÂº 20223/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(22, 65, 3, '2019-03-15 14:23:21', NULL, NULL, NULL, 'App\\User', 3),
(23, 66, 1, '2019-03-15 17:29:05', '2019-03-15 17:29:05', '9999999999999', NULL, 'App\\User', 1),
(24, 66, 1, '2019-03-15 17:46:10', '2019-03-15 17:46:10', NULL, NULL, 'App\\User', 1),
(25, 69, 8, '2019-03-18 16:25:58', '2019-03-18 16:25:58', 'Processo em fase avanÃ§ada. Tramitou sem manifestaÃ§Ã£o da SPU/SC.', NULL, 'App\\User', 8),
(26, 75, 8, '2019-04-03 19:36:19', '2019-04-03 19:36:19', NULL, NULL, 'App\\User', 5),
(27, 76, 8, '2019-03-19 11:59:24', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(28, 49, 4, '2019-03-19 13:15:38', '2019-03-19 13:15:38', NULL, NULL, 'App\\User', 4),
(29, 57, 1, '2019-03-19 13:41:55', '2019-03-19 13:41:55', 'Oficiar AGU para que consulte o juÃ­z da aÃ§Ã£o sobre eventual cumprimento por parte do rÃ©u, dado que recebemos informaÃ§Ãµes de que haveria uma demoliÃ§Ã£o em curso.', 'Enviado o OfÃ­cio nÂº 20969/2019/SPU-SC/MP', 'App\\User', 10),
(30, 57, 1, '2019-04-08 18:37:33', '2019-04-08 18:37:33', 'Monitorar resposta da AGU para providÃªnciais.', 'Aguardando resposta ao OfÃ­cio nÂº 20969/2019/SPU-SC/MP (8171987)', 'App\\User', 1),
(31, 41, 1, '2019-03-19 14:20:10', '2019-03-19 14:20:10', 'Favor ignorar essa distribuiÃ§Ã£o: apenas para atualizar a situaÃ§Ã£o de demanda', NULL, 'App\\User', 1),
(32, 64, 1, '2019-03-26 14:01:10', '2019-03-26 14:01:10', 'Resposta cobrada por telefone e email para PUSC em 22/03/2019 - 15:45h. Prazo ePROC 27/03/2017', NULL, 'App\\User', 5),
(33, 95, 8, '2019-04-03 18:30:08', '2019-04-03 18:30:08', NULL, 'Atribuido ao Manglio', 'App\\User', 5),
(34, 64, 1, '2019-03-26 19:10:56', '2019-03-26 19:10:56', 'Aguardar assinatura do SPU-SC para envio do OfÃ­cio nÂº 23845/2019/DIGES-SPU-SC/MP', NULL, 'App\\User', 1),
(35, 48, 5, '2019-03-26 16:58:16', '2019-03-26 16:58:16', NULL, NULL, 'App\\User', 5),
(36, 63, 3, '2019-03-26 19:37:31', '2019-03-26 19:37:31', NULL, NULL, 'App\\User', 3),
(37, 50, 5, '2019-03-27 16:47:28', '2019-03-27 16:47:28', NULL, NULL, 'App\\User', 5),
(38, 50, 1, '2019-03-27 20:33:09', '2019-03-27 20:33:09', 'Aguardando assinatura do SPU-SC', 'Atendida atravÃ©s do OfÃ­cio nÂº 24506/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(39, 98, 1, '2019-04-24 17:43:42', '2019-04-24 17:43:42', 'Tomar ciÃªncia do fato, alÃ©m das providÃªncias pertinentes para a soluÃ§Ã£o dos problemas referidos no Auto de ConstataÃ§Ã£o (avarias no prÃ©dio). Comunicar ao MPF sobre as medidas que serÃ£o adotadas.', 'Conversei com Antonio da CODES-SPU-SC para dar tratamento Ã  demanda.', 'App\\User', 1),
(40, 122, 1, '2019-03-27 19:00:45', '2019-03-27 19:00:45', 'Encaminhar Ã  CODES-SPU-SC', 'Encaminhado atravÃ©s do Despacho DIGES-SPU-SC nÂº 8239769', 'App\\User', 1),
(41, 122, 1, '2019-05-09 18:31:19', '2019-05-09 18:31:19', 'Prestar informaÃ§Ãµes sobre a atual situaÃ§Ã£o do projeto habitacional aos integrantes da \'OcupaÃ§Ã£o Contestado\'', 'E-mail DIRFH-SPU-SC 8245444', 'App\\DivisaoOrganograma', 4),
(42, 127, 1, '2019-05-28 13:17:18', '2019-05-28 13:17:18', 'Juliano, estou encaminhando para vocÃª essa demanda para vocÃª tratar com o setor de fiscalizaÃ§Ã£o', 'OfÃ­cio nÂº 42755/2019/SPU-SC/MP', 'App\\User', 5),
(43, 131, 1, '2019-03-27 20:31:00', '2019-03-27 20:31:00', 'Aguardando assinatura do Bauer para envio do OfÃ­cio 24636', 'OfÃ­cio 246636 enviado.', 'App\\User', 1),
(44, 70, 1, '2019-03-27 20:36:20', NULL, NULL, NULL, 'App\\User', 5),
(45, 96, 1, '2019-04-03 18:12:02', '2019-04-03 18:12:02', 'Para acompanhamento (por estar o NUP SEI atribuÃ­do ao mesmo CPF)', NULL, 'App\\User', 8),
(46, 51, 1, '2019-09-02 19:39:57', '2019-07-05 20:08:15', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(47, 72, 1, '2019-04-01 13:46:43', '2019-04-01 13:46:43', 'Distribuindo ao mesmo CPF ao qual o NUP SEI estÃ¡ atribuÃ­do', NULL, 'App\\User', 3),
(48, 25, 1, '2019-04-03 21:01:21', '2019-04-03 21:01:21', 'Prestar informaÃ§Ã£o sobre interferÃªncia da Ã¡rea sobre bens da UniÃ£o.', 'Nota TÃ©cnica nÂº 7699/2019-MP', 'App\\User', 13),
(49, 32, 1, '2019-04-03 12:49:17', '2019-04-03 12:49:17', 'Prestar informaÃ§Ã£o sobre interferÃªncia da Ã¡rea sobre bens da UniÃ£o.', NULL, 'App\\User', 13),
(50, 74, 1, '2019-04-03 18:39:10', '2019-04-03 18:39:10', 'Informar se o imÃ³vel localizado na ServidÃ£o LuÃ­zaMaria dos Santos (Dona Zinha) nÂº 255, SÃ£o JoÃ£o do Rio Vermelho, CEP: 88060-435, municÃ­pio de FlorianÃ³polis/SC, estÃ¡ localizado em terreno de marinha', NULL, 'App\\User', 5),
(51, 55, 1, '2019-04-08 17:30:07', '2019-04-08 17:30:07', 'Fornecer documentos solicitados pelo perito. Ver OfÃ­cio 276/2019 (8147765)', 'Fazer o OfÃ­cio encaminhando o Anexo: Cartas TopogrÃ¡ficas 747-096 e 748-096. NÃ£o tem necessidade de fazer Nota TÃ©cnica.', 'App\\User', 5),
(52, 67, 1, '2019-04-03 20:59:34', '2019-04-03 20:59:34', 'informar se hÃ¡, tambÃ©m, interesse da UniÃ£o no referido processo deoposiÃ§Ã£o', 'Nota TÃ©cnica nÂº 7869/2019-MP', 'App\\User', 13),
(53, 68, 1, '2019-04-03 20:55:42', '2019-04-03 20:55:42', 'informar sobre a aÃ§Ã£o de usucapiÃ£o de imÃ³vel acima identificada esolicito que essa SPU/SC manifeste eventual interesse em intervir na lide', 'Atendido por meio da Nota TÃ©cnica nÂº 7927/2019-MP', 'App\\User', 13),
(54, 71, 1, '2019-05-09 13:11:17', '2019-05-09 13:11:17', 'Encaminhado conforme Despacho DIINC-SPU-SC 8227231', 'OfÃ­cio nÂº 36448/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(55, 90, 1, '2019-04-02 11:50:53', '2019-04-02 11:50:53', 'Encaminhado conforme Despacho DIGES-SPU-SC 7970003', 'Foi indicado para participar da audiÃªncia o servidor JoÃ£o JosÃ© dos Santos, CPF 542.170.249-91, MatrÃ­cula SIAPE 1021974.', 'App\\User', 8),
(56, 73, 1, '2019-04-03 21:00:29', '2019-04-03 21:00:29', 'informar  sobre  o  predicado  pÃºblico â€“ou  nÃ£o,  da  terra  discutida,  dando  a  saber  a (in)existÃªncia  de  pedido  de  ocupaÃ§Ã£o/aforamento/autorizaÃ§Ã£o/cessÃ£o  (etc)  junto  Ã   SPU,  e  o interesse  da  mesma  na  figuraÃ§Ã£o  da  UF  nos  autos,  em  defesa  de  sua  posiÃ§Ã£o  jurÃ­dica eventualmente tangida', 'Nota TÃ©cnica nÂº 7783/2019-MP', 'App\\User', 13),
(57, 77, 1, '2019-03-28 14:28:18', NULL, 'Encaminhada conforme Despacho DIGES-SPU-SC nÂº 8234112', NULL, 'App\\DivisaoOrganograma', 4),
(58, 135, 4, '2019-04-08 16:18:33', '2019-04-08 16:18:33', NULL, NULL, 'App\\User', 4),
(59, 72, 1, '2019-04-10 17:00:05', '2019-04-10 17:00:05', 'Assumindo a demanda para tratar com Bauer/Camila/Marina/Juliano', 'Distribuindo ao Niarcos por estar saindo de fÃ©rias', 'App\\User', 1),
(60, 46, 5, '2019-04-08 18:52:35', '2019-04-08 18:52:35', NULL, NULL, 'App\\User', 13),
(61, 150, 1, '2019-04-02 12:58:59', '2019-04-02 12:58:59', 'aguardando assinatura do SPU-SC para envio da resposta', 'Respondida atravÃ©s do OfÃ­cio 26099/2019', 'App\\User', 1),
(62, 151, 1, '2019-04-03 12:16:46', '2019-04-03 12:16:46', 'manifestaÃ§Ã£o acerca dos documentos juntados pela parte autora no evento 227 (novo memorial descritivo)\r\nSolicitamos dilaÃ§ao de prazo em 01/04/2019', NULL, 'App\\User', 5),
(63, 152, 1, '2019-04-02 12:56:05', '2019-04-02 12:56:05', 'aguardando assinatura do SPU-SC para envio da resposta', 'Respondida atravÃ©s do OfÃ­cio 26202/2019', 'App\\User', 1),
(64, 155, 1, '2019-07-09 14:27:18', '2019-07-09 17:27:18', 'Demanda distribuÃ­da conforme carga atual do SEI (aberta na COCAI no seu CPF)', NULL, 'App\\User', 5),
(65, 156, 1, '2019-04-02 14:00:02', NULL, 'Existem duas demandas abertas para esse NUP, uma do MPF (OfÃ­cio 6/2019 do Eduardo Barrgan) e esta, da Prefeitura de SÃ£o JosÃ© (enviado por email, anexado ao processo).', NULL, 'App\\User', 5),
(66, 157, 3, '2019-04-22 14:22:53', '2019-04-22 14:22:53', 'A questÃ£o envolve terras indÃ­genas no Cambirela - PalhoÃ§a', NULL, 'App\\User', 5),
(67, 158, 3, '2019-04-22 16:59:55', '2019-04-22 16:59:55', 'Abertura de acessos - Governador Celso Ramos', NULL, 'App\\User', 5),
(68, 158, 3, '2019-04-24 18:47:50', '2019-04-24 18:47:50', 'Acessos  -Governador Celso Ramos', NULL, 'App\\User', 5),
(69, 164, 1, '2019-04-04 19:33:23', '2019-04-04 19:33:23', 'Conversar com o Juliano para entender o que falta para fazer a transferÃªncia e dar o encaminhamento necessÃ¡rio', 'enviei e-mail para o Juliano a atribuÃ­ o processo SEI a ele', 'App\\User', 1),
(70, 166, 8, '2019-04-03 12:11:07', '2019-04-03 12:11:07', 'Despachar para setor tÃ©cnico.', NULL, 'App\\User', 8),
(71, 95, 5, '2019-04-08 14:24:12', '2019-04-08 14:24:12', 'Verificar a interferÃªncia com bens da UniÃ£o.', 'Encaminhada Ã  Ex DIINC por tratar-se de Ã¡rea da RFFSA', 'App\\User', 13),
(72, 167, 4, '2019-04-03 19:13:57', '2019-04-03 19:13:57', NULL, NULL, 'App\\User', 4),
(73, 168, 8, '2019-04-22 12:40:52', '2019-04-22 12:40:52', 'AnÃ¡lise de laudo.', NULL, 'App\\User', 5),
(74, 140, 8, '2019-04-08 17:06:26', '2019-04-08 17:06:26', NULL, NULL, 'App\\User', 5),
(75, 74, 5, '2019-04-03 20:51:52', '2019-04-03 20:51:52', NULL, NULL, 'App\\User', 13),
(76, 76, 8, '2019-04-03 18:42:11', NULL, 'informar se hÃ¡ interesse da UniÃ£o no feito', NULL, 'App\\User', 13),
(77, 141, 8, '2019-04-24 16:37:30', '2019-04-24 16:37:30', NULL, NULL, 'App\\User', 5),
(78, 169, 8, '2019-05-07 18:56:40', '2019-05-07 18:56:40', NULL, NULL, 'App\\User', 5),
(79, 75, 5, '2019-04-03 19:36:28', NULL, NULL, NULL, 'App\\User', 13),
(80, 170, 8, '2019-04-05 13:27:25', '2019-04-05 13:27:25', NULL, NULL, 'App\\User', 13),
(81, 171, 8, '2019-04-08 17:50:50', '2019-04-08 17:50:50', 'manifestaÃ§Ã£o sobre proposta de acordo.', 'A AGU jÃ¡ peticionou nos autos e a proposta de acordo foi recusada pelo autor MPF. Dessa forma, resta apenas a conclusÃ£o do processo atÃ© nova manifestaÃ§Ã£o da AGU.', 'App\\User', 5),
(82, 172, 1, '2019-04-26 13:15:15', '2019-04-26 13:15:15', 'Esta demanda estava no bloco interno que vocÃª criou com processos a serem cadastrados. DistribuÃ­ para vocÃª por estar o processo SEI na sua carga.', NULL, 'App\\User', 5),
(83, 173, 8, '2019-05-28 17:09:43', '2019-05-28 17:09:43', 'SubsÃ­dios em aÃ§Ã£o ambiental e informaÃ§Ã£o de liminar.', NULL, 'App\\User', 5),
(84, 174, 8, '2019-05-28 16:58:07', '2019-05-28 16:58:07', 'acompanhamento em imissÃ£o na posse de imÃ³vel em Laguna.', NULL, 'App\\User', 5),
(85, 175, 8, '2019-04-05 17:45:28', '2019-04-05 17:45:28', 'AnÃ¡lise de usucapiÃ£o.', NULL, 'App\\User', 13),
(86, 176, 8, '2019-04-17 18:23:14', '2019-04-17 18:23:14', 'Laudo complementar', NULL, 'App\\User', 5),
(87, 163, 8, '2019-04-08 16:40:06', '2019-04-08 16:40:06', NULL, NULL, 'App\\User', 5),
(88, 177, 8, '2019-06-19 13:19:39', '2019-06-19 16:19:39', 'IndicaÃ§Ã£o de servidor para acompanhar desocupaÃ§Ã£o RFFSA', NULL, 'App\\User', 3),
(89, 151, 1, '2019-04-08 14:06:46', '2019-04-08 14:06:46', 'Aguardando confirmaÃ§Ã£o de recebimento', NULL, 'App\\User', 1),
(90, 25, 4, '2019-04-05 18:07:55', '2019-04-05 18:07:55', 'minutar resposta', NULL, 'App\\User', 4),
(91, 67, 1, '2019-04-08 18:31:41', '2019-04-08 18:31:41', 'Aguardando confirmaÃ§Ã£o de recebimento', '8313530', 'App\\User', 1),
(92, 178, 8, '2019-04-30 14:16:08', '2019-04-30 14:16:08', 'Laudo complementar', NULL, 'App\\User', 5),
(93, 32, 4, '2019-04-08 14:16:53', '2019-04-08 14:16:53', 'Minutar resposta', NULL, 'App\\User', 4),
(94, 74, 1, '2019-04-08 18:30:42', '2019-04-08 18:30:42', 'Minutar resposta', 'OfÃ­cio nÂº 27198/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(95, 179, 8, '2019-04-17 12:46:16', '2019-04-17 12:46:16', 'indicaÃ§Ã£o de assistente tÃ©cnico', NULL, 'App\\User', 5),
(96, 68, 1, '2019-04-08 18:32:08', '2019-04-08 18:32:08', 'Aguardando confirmaÃ§Ã£o de recebimento', '8314745', 'App\\User', 1),
(97, 73, 1, '2019-04-11 13:10:54', '2019-04-11 13:10:54', 'Aguardando confirmaÃ§Ã£o de recebimento', NULL, 'App\\User', 1),
(98, 167, 1, '2019-04-05 18:09:02', '2019-04-05 18:09:02', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 4),
(99, 86, 1, '2019-04-26 16:42:18', '2019-04-26 16:42:18', 'Designar servidor para audiÃªncia por videoconferÃªncia no dia 24/04/2019', NULL, 'App\\User', 5),
(100, 181, 8, '2019-04-05 20:10:50', '2019-04-05 20:10:50', 'Verificar a existÃªncia de cessÃ£o.', 'Atendido pelo Despacho DIGES-SPU-SC 8298154', 'App\\DivisaoOrganograma', 4),
(101, 182, 8, '2019-05-07 13:44:28', '2019-05-07 13:44:28', NULL, '8332764', 'App\\DivisaoOrganograma', 4),
(102, 135, 4, '2019-04-08 16:18:25', '2019-04-08 16:18:25', NULL, NULL, 'App\\User', 5),
(103, 164, 1, '2019-05-28 17:07:06', '2019-05-28 17:07:06', 'Favor olhar esse caso. Trata-se de um cancelamento que era pra ter sido feito e a SPU continua cobrando taxa de ocupaÃ§Ã£o, inclusive foi para DAU por isso.', NULL, 'App\\User', 5),
(104, 184, 8, '2019-05-21 12:49:44', '2019-05-21 12:49:44', 'Laudo complementar.', NULL, 'App\\User', 5),
(105, 185, 8, '2019-04-05 13:06:35', '2019-04-05 13:06:35', NULL, NULL, 'App\\User', 8),
(106, 187, 8, '2019-04-17 13:02:04', '2019-04-17 13:02:04', 'assistente tÃ©cnico e formulaÃ§Ã£o de quesito', NULL, 'App\\User', 5),
(107, 188, 8, '2019-04-08 14:10:09', '2019-04-08 14:10:09', NULL, NULL, 'App\\User', 13),
(108, 189, 8, '2019-04-08 16:37:39', '2019-04-08 16:37:39', NULL, NULL, 'App\\User', 13),
(109, 190, 8, '2019-04-08 17:49:20', '2019-04-08 17:49:20', NULL, NULL, 'App\\User', 13),
(110, 191, 8, '2019-05-29 19:09:09', '2019-05-29 19:09:09', NULL, NULL, 'App\\User', 5),
(111, 192, 8, '2019-04-26 12:43:47', '2019-04-26 12:43:47', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(112, 193, 8, '2019-05-28 13:58:39', '2019-05-28 13:58:39', 'SequÃªncia a NT 8217', NULL, 'App\\User', 5),
(113, 194, 8, '2019-04-30 16:42:46', '2019-04-30 16:42:46', 'informaÃ§Ãµes complementares Ã  NT 5876/2016.', NULL, 'App\\User', 5),
(114, 181, 1, '2019-04-08 18:32:30', '2019-04-08 18:32:30', 'Aguardando confirmaÃ§Ã£o de recebimento', '8313372', 'App\\User', 1),
(115, 195, 8, '2019-04-22 18:03:28', '2019-04-22 18:03:28', NULL, NULL, 'App\\User', 8),
(116, 197, 8, '2019-05-28 16:42:21', '2019-05-28 16:42:21', NULL, NULL, 'App\\User', 5),
(117, 196, 8, '2019-05-06 13:40:40', '2019-05-06 13:40:40', 'Aguardando manifestaÃ§Ã£o da CODES no processo 04972.008375/2017-38.', NULL, 'App\\User', 3),
(118, 198, 8, '2019-04-11 13:29:25', '2019-04-11 13:29:25', 'Fazer ofÃ­cio indicando servidor e atribuir Ã  CODES', NULL, 'App\\User', 8),
(119, 24, 4, '2019-04-12 16:53:51', '2019-04-12 16:53:51', NULL, NULL, 'App\\User', 8),
(120, 199, 8, '2019-05-08 17:41:16', '2019-05-08 17:41:16', NULL, NULL, 'App\\User', 5),
(121, 200, 8, '2019-04-08 14:05:28', '2019-04-08 14:05:28', NULL, NULL, 'App\\User', 8),
(122, 201, 8, '2019-04-08 14:09:58', '2019-04-08 14:09:58', NULL, NULL, 'App\\User', 8),
(123, 202, 8, '2019-04-08 14:12:34', '2019-04-08 14:12:34', NULL, NULL, 'App\\User', 8),
(124, 95, 5, '2019-09-02 19:39:57', '2019-04-08 14:24:50', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(125, 203, 8, '2019-04-09 14:45:38', '2019-04-09 14:45:38', NULL, NULL, 'App\\User', 13),
(126, 205, 4, '2019-04-10 18:59:18', '2019-04-10 18:59:18', NULL, NULL, 'App\\User', 4),
(127, 170, 4, '2019-04-15 18:34:32', '2019-04-15 18:34:32', NULL, NULL, 'App\\User', 4),
(128, 74, 1, '2019-04-11 13:14:19', '2019-04-11 13:14:19', 'Aguardando confirmaÃ§Ã£o do recebimento', NULL, 'App\\User', 1),
(129, 55, 1, '2019-04-10 14:33:49', '2019-04-10 14:33:49', 'Aguardando confirmaÃ§Ã£o de recebimento', 'OfÃ­cio nÂº 28485/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(130, 188, 4, '2019-04-15 18:40:50', '2019-04-15 18:40:50', 'Minutar ofÃ­cio de resposta', NULL, 'App\\User', 4),
(131, 189, 1, '2019-04-10 14:13:38', '2019-04-10 14:13:38', 'Aguardando confirmaÃ§Ã£o do recebimento', 'OfÃ­cio nÂº 28513/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(132, 135, 4, '2019-04-17 13:30:26', '2019-04-17 13:30:26', 'Minutar resposta', NULL, 'App\\User', 4),
(133, 140, 1, '2019-04-10 14:22:06', '2019-04-10 14:22:06', 'Aguardando confirmaÃ§Ã£o do recebimento', 'OfÃ­cio nÂº 28526/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(134, 163, 1, '2019-04-10 14:31:03', '2019-04-10 14:31:03', 'Aguardando confirmaÃ§Ã£o de recebimento', 'Nota TÃ©cnica nÂº 8315/2019-MP', 'App\\User', 1),
(135, 95, 1, '2019-04-10 14:27:34', '2019-04-10 14:27:34', 'Aguardando confirmaÃ§Ã£o de recebimento', 'OfÃ­cio nÂº 28547/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(136, 208, 8, '2019-05-14 14:21:49', '2019-05-14 14:21:49', 'TAUS.', '8552347', 'App\\DivisaoOrganograma', 4),
(137, 209, 8, '2019-04-09 18:56:33', '2019-04-09 18:56:33', NULL, NULL, 'App\\User', 13),
(138, 190, 1, '2019-04-10 14:44:18', '2019-04-10 14:44:18', 'Aguardando confirmaÃ§Ã£o de recebimento', 'Oficio 28824/2019', 'App\\User', 1),
(139, 46, 1, '2019-04-16 17:45:04', '2019-04-16 17:45:04', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(140, 210, 8, '2019-04-25 19:07:48', '2019-04-25 19:07:48', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(141, 211, 3, '2019-04-17 12:09:55', '2019-04-17 12:09:55', 'Aguardand manifestaÃ§Ã£o do setor de fiscalizaÃ§Ã£o da SPU - Verificar com a Camila', NULL, 'App\\User', 3),
(142, 212, 3, '2019-09-02 19:39:57', '2019-05-07 13:39:57', NULL, '8330633', 'App\\DivisaoOrganograma', 3),
(143, 213, 8, '2019-04-09 18:55:55', '2019-04-09 18:55:55', NULL, NULL, 'App\\User', 13),
(144, 214, 8, '2019-04-11 16:30:03', '2019-04-11 16:30:03', NULL, NULL, 'App\\User', 5),
(145, 215, 8, '2019-05-10 18:00:20', '2019-05-10 18:00:20', NULL, NULL, 'App\\User', 5),
(146, 216, 8, '2019-04-10 12:26:06', '2019-04-10 12:26:06', NULL, NULL, 'App\\User', 8),
(147, 217, 8, '2019-04-11 16:28:54', '2019-04-11 16:28:54', NULL, NULL, 'App\\User', 13),
(148, 218, 8, '2019-04-22 17:40:17', '2019-04-22 17:40:17', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(149, 219, 8, '2019-04-11 16:29:22', '2019-04-11 16:29:22', NULL, NULL, 'App\\User', 13),
(150, 220, 8, '2019-04-10 16:33:56', NULL, NULL, NULL, 'App\\User', 13),
(151, 221, 8, '2019-05-02 17:03:27', '2019-05-02 17:03:27', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(152, 72, 1, '2019-04-23 19:42:25', '2019-04-23 19:42:25', 'Niarcos, estou distribuindo para vocÃª acompanhar pois estou saindo de fÃ©rias', 'Retornando acompanhamento para o Alysson', 'App\\User', 3),
(153, 222, 1, '2019-05-28 15:11:00', '2019-05-28 15:11:00', 'Monitorar o cumprimento da sentenÃ§a, conforme orientaÃ§Ãµes em:\r\nhttp://10.209.232.158/wordpress/gabinete/reuniao-sobre-demolicoes-acoes-judiciais/', 'DistribuiÃ§Ã£o conforme SEI', 'App\\User', 3),
(154, 223, 8, '2019-04-10 18:14:27', '2019-04-10 18:14:27', NULL, NULL, 'App\\User', 8),
(155, 224, 8, '2019-05-28 14:00:08', '2019-05-28 14:00:08', NULL, NULL, 'App\\User', 13),
(156, 225, 8, '2019-05-28 15:07:32', '2019-05-28 15:07:32', NULL, 'OfÃ­cio nÂº 30850/2019/DIGES-SPU-SC/MP', 'App\\User', 3),
(157, 226, 8, '2019-04-29 12:27:59', '2019-04-29 12:27:59', NULL, NULL, 'App\\User', 8),
(158, 227, 8, '2019-05-14 18:37:05', '2019-05-14 18:37:05', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(159, 228, 8, '2019-05-14 13:38:26', '2019-05-14 13:38:26', NULL, 'Nota TÃ©cnica nÂº 11051/2019-MP', 'App\\DivisaoOrganograma', 4),
(160, 229, 8, '2019-05-09 18:47:32', '2019-05-09 18:47:32', NULL, 'Nota TÃ©cnica nÂº 11248/2019-MP', 'App\\DivisaoOrganograma', 4),
(161, 230, 8, '2019-05-15 18:14:12', '2019-05-15 18:14:12', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(162, 231, 8, '2019-05-28 15:04:33', '2019-05-28 15:04:33', 'Acesso externo', 'E-mail 8366694', 'App\\User', 3),
(163, 232, 4, '2019-04-11 18:44:42', NULL, NULL, NULL, 'App\\User', 4),
(164, 233, 3, '2019-04-29 20:08:23', '2019-04-29 20:08:23', NULL, NULL, 'App\\User', 3),
(165, 195, 8, '2019-04-22 14:21:28', '2019-04-22 14:21:28', 'AtÃ© 16/04/2019\r\nLIMINAR - TERRAS INDÃGENAS CAMBIRELA - PALHOÃ‡A/SC.\r\nVERIFICAR COMPETÃŠNCIA DA SPU', NULL, 'App\\User', 5),
(166, 235, 4, '2019-04-26 17:14:09', '2019-04-26 17:14:09', NULL, NULL, 'App\\User', 13),
(167, 236, 8, '2019-05-14 13:27:01', '2019-05-14 13:27:01', NULL, 'OfÃ­cio nÂº 37490/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(168, 237, 8, '2019-05-08 18:44:29', '2019-05-08 18:44:29', 'OcupaÃ§Ã£o Amarildo da Silva', NULL, 'App\\User', 5),
(169, 241, 4, '2019-07-12 18:48:55', '2019-07-12 21:48:55', NULL, NULL, 'App\\User', 4),
(170, 213, 3, '2019-04-15 16:51:38', '2019-04-15 16:51:38', NULL, NULL, 'App\\User', 3),
(171, 243, 4, '2019-04-15 16:56:08', NULL, NULL, NULL, 'App\\User', 4),
(172, 246, 4, '2019-05-14 14:12:35', '2019-05-14 14:12:35', NULL, 'OfÃ­cio nÂº 38129/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(173, 250, 4, '2019-04-17 19:27:00', '2019-04-17 19:27:00', NULL, NULL, 'App\\User', 5),
(174, 252, 4, '2019-07-23 12:54:29', '2019-07-23 15:54:29', NULL, 'Atendido pelo Despacho DIGES-SPU-SC 8809988', 'App\\DivisaoOrganograma', 4),
(175, 254, 4, '2019-05-07 13:57:14', '2019-05-07 13:57:14', NULL, '8384310', 'App\\DivisaoOrganograma', 4),
(176, 255, 4, '2019-05-28 16:45:32', '2019-05-28 16:45:32', NULL, NULL, 'App\\User', 5),
(177, 256, 4, '2019-05-15 12:56:24', '2019-05-15 12:56:24', NULL, NULL, 'App\\User', 5),
(178, 263, 4, '2019-06-13 12:23:59', '2019-06-13 15:23:59', 'Aguarda envio de documentos que nÃ£o acompanharam o OfÃ­cio 82/2019.', NULL, 'App\\User', 4),
(179, 265, 4, '2019-05-10 18:12:55', '2019-05-10 18:12:55', NULL, 'AtribuÃ­do ao Arq. Manglio', 'App\\User', 5),
(180, 168, 5, '2019-04-22 12:41:22', '2019-04-22 12:41:22', NULL, NULL, 'App\\User', 13),
(181, 168, 5, '2019-05-09 12:43:59', '2019-05-09 12:43:59', NULL, NULL, 'App\\User', 5),
(182, 170, 1, '2019-04-22 13:06:49', '2019-04-22 13:06:49', 'Minutar resposta', 'Resposta jÃ¡ havia sido dada, inclusive com AR', 'App\\User', 1),
(183, 1, 1, '2019-04-23 12:52:37', '2019-04-23 12:52:37', 'Aguardando confirmaÃ§Ã£o de recebimento', 'Marcando como atendida para adequar a situaÃ§Ã£o da demanda', 'App\\User', 1),
(184, 135, 1, '2019-04-22 13:10:01', '2019-04-22 13:10:01', 'Minutar resposta', 'Resposta jÃ¡ havia sido enviada, inclusive com AR registrado no SEI.', 'App\\User', 1),
(185, 266, 8, '2019-04-26 17:14:47', '2019-04-26 17:14:47', NULL, NULL, 'App\\User', 13),
(186, 176, 1, '2019-04-22 13:32:38', '2019-04-22 13:32:38', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(187, 179, 1, '2019-04-23 17:15:29', '2019-04-23 17:15:29', 'Aguardando confirmaÃ§Ã£o do recebimento (email 8386714)', NULL, 'App\\User', 3),
(188, 187, 1, '2019-04-22 19:57:50', '2019-04-22 19:57:50', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(189, 214, 1, '2019-04-22 18:15:07', '2019-04-22 18:15:07', 'Aguardando AR', NULL, 'App\\User', 3),
(190, 267, 8, '2019-05-06 17:20:00', '2019-05-06 17:20:00', NULL, NULL, 'App\\User', 13),
(191, 268, 8, '2019-05-10 18:01:19', '2019-05-10 18:01:19', NULL, NULL, 'App\\User', 5),
(192, 176, 1, '2019-04-22 19:59:27', '2019-04-22 19:59:27', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(193, 211, 1, '2019-04-26 18:30:43', '2019-04-26 18:30:43', 'AtribuÃ­da para monitoramento da resposta do Ã“rgÃ£o Central.\r\n\r\nEm vista disso, e considerando que esta SPU-SC depende da descentralizaÃ§Ã£o dos recursos por parte de sua Unidade Central para adoÃ§Ã£o das providÃªncias de contrataÃ§Ã£o do serviÃ§o de demoliÃ§Ã£o, informamos que, tÃ£o logo sejam liberados tais recursos, daremos continuidade as providÃªncias para o cumprimento da sentenÃ§a.', NULL, 'App\\User', 1),
(194, 203, 1, '2019-04-22 18:19:12', '2019-04-22 18:19:12', 'Aguardando confirmaÃ§Ã£o de recebimento', NULL, 'App\\User', 3),
(195, 219, 1, '2019-05-28 15:06:51', '2019-05-28 15:06:51', 'Aguardando confirmaÃ§Ã£o de recebimento', 'OfÃ­cio nÂº 30058/2019/DIGES-SPU-SC/MP', 'App\\User', 3),
(196, 250, 1, '2019-04-22 19:56:35', '2019-04-22 19:56:35', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(197, 253, 8, '2019-04-22 14:32:31', '2019-04-22 14:32:31', NULL, NULL, 'App\\User', 8),
(198, 270, 4, '2019-04-26 17:15:58', '2019-04-26 17:15:58', NULL, NULL, 'App\\User', 13),
(199, 272, 4, '2019-04-26 17:15:10', '2019-04-26 17:15:10', NULL, NULL, 'App\\User', 13),
(200, 273, 4, '2019-04-29 11:43:32', '2019-04-29 11:43:32', NULL, NULL, 'App\\User', 13),
(201, 274, 8, '2019-05-28 15:03:56', '2019-05-28 15:03:56', 'Fornecer acesso externo.', 'E-mail 8412387', 'App\\User', 3),
(202, 218, 1, '2019-04-23 13:19:50', '2019-04-23 13:19:50', 'Minutar resposta', 'OfÃ­cio nÂº 32484/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(203, 157, 1, '2019-04-23 13:50:52', '2019-04-23 13:50:52', 'Minutar resposta', 'Demanda duplicada', 'App\\User', 1),
(204, 195, 1, '2019-04-23 13:50:22', '2019-04-23 13:50:22', 'Minutar resposta', 'OfÃ­cio nÂº 32523/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(205, 275, 8, '2019-04-23 13:36:05', '2019-04-23 13:36:05', 'Fazer ofÃ­cio confirmando interesse em integrar o polo ativo.', NULL, 'App\\User', 8),
(206, 276, 8, '2019-04-23 14:16:53', '2019-04-23 14:16:53', 'Fazer despacho para a DIREP verificar a transferÃªncia do RIP 8105.0005756-59', NULL, 'App\\User', 8),
(207, 277, 4, '2019-04-25 18:24:16', '2019-04-25 18:24:16', NULL, NULL, 'App\\User', 5),
(208, 207, 8, '2019-05-14 18:20:39', '2019-05-14 18:20:39', 'Consultar a DIREP sobre pagamento a maior', 'Aguardando resposta da DIREP', 'App\\User', 8),
(209, 279, 8, '2019-04-29 14:12:04', '2019-04-29 14:12:04', 'Fazer despacho para DIIUP', NULL, 'App\\User', 8),
(210, 280, 4, '2019-04-23 19:13:22', '2019-04-23 19:13:22', NULL, NULL, 'App\\User', 8),
(211, 281, 4, '2019-05-08 17:41:44', '2019-05-08 17:41:44', NULL, NULL, 'App\\User', 5),
(212, 72, 1, '2019-07-10 20:08:09', '2019-07-10 23:08:09', 'Acompanhar aÃ§Ã£o de demoliÃ§Ã£o', 'Acompanhamento serÃ¡ feito via Resumo Gerencial', 'App\\User', 1),
(213, 98, 1, '2019-05-29 17:12:01', '2019-05-29 17:12:01', 'Combinado que o Antonio daria tratamento Ã  demanda', 'OfÃ­cio nÂº 41918/2019/CODES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(214, 212, 3, '2019-05-07 13:39:48', '2019-05-07 13:39:48', NULL, '8005406', 'App\\DivisaoOrganograma', 4),
(215, 212, 3, '2019-05-07 13:39:39', '2019-05-07 13:39:39', NULL, 'Despacho CODES-SPU-SC', 'App\\DivisaoOrganograma', 4),
(216, 282, 4, '2019-05-02 18:32:28', '2019-05-02 18:32:28', NULL, NULL, 'App\\User', 5),
(217, 282, 4, '2019-05-02 18:30:42', '2019-05-02 18:30:42', NULL, NULL, 'App\\User', 4),
(218, 283, 4, '2019-05-30 17:11:18', '2019-05-30 17:11:18', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(219, 284, 4, '2019-04-24 19:41:16', '2019-04-24 19:41:16', NULL, NULL, 'App\\User', 4),
(220, 285, 4, '2019-05-17 13:07:45', '2019-05-17 13:07:45', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(221, 286, 3, '2019-05-07 16:35:36', '2019-05-07 16:35:36', NULL, NULL, 'App\\User', 3),
(222, 278, 8, '2019-05-07 13:59:45', '2019-05-07 13:59:45', NULL, '8452629', 'App\\DivisaoOrganograma', 4),
(223, 287, 4, '2019-04-26 13:34:12', '2019-04-26 13:34:12', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(224, 288, 4, '2019-04-26 13:37:48', '2019-04-26 13:37:48', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(225, 289, 4, '2019-04-29 19:35:22', '2019-04-29 19:35:22', NULL, 'Despacho DIREP-SPU-SC 8452847', 'App\\DivisaoOrganograma', 6),
(226, 271, 8, '2019-05-02 12:24:32', '2019-05-02 12:24:32', 'PGV e IsenÃ§Ã£o', NULL, 'App\\User', 8),
(227, 290, 4, '2019-05-21 19:07:27', '2019-05-21 19:07:27', 'Aguarda envio de documentaÃ§Ã£o', NULL, 'App\\User', 4),
(228, 263, 4, '2019-04-30 14:22:54', '2019-04-30 14:22:54', NULL, NULL, 'App\\User', 13),
(229, 86, 5, '2019-04-29 20:18:09', '2019-04-29 20:18:09', 'Trata de audiÃªncia de conciliaÃ§Ã£o, creio que deve ser encaminhado ao ponto focal da Ex. CODES.\r\nFavor verificar a divergÃªncia entre o Anexo 1_INIC1(7)pdf (3671524) e Anexo 1_INIC (8219927). Creio que tratam de aÃ§Ãµes diferentes.', 'Demanda encaminhada Ã  CODES atravÃ©s do Despacho DIGES-SPU-SC 8458228', 'App\\User', 1),
(230, 291, 4, '2019-04-26 16:54:14', '2019-04-26 16:54:14', NULL, NULL, 'App\\User', 4),
(231, 292, 4, '2019-04-26 16:55:51', NULL, NULL, NULL, 'App\\User', 4),
(232, 294, 4, '2019-04-26 17:00:14', '2019-04-26 17:00:14', NULL, NULL, 'App\\User', 4),
(233, 295, 4, '2019-04-29 16:38:08', '2019-04-29 16:38:08', NULL, NULL, 'App\\User', 13),
(234, 296, 4, '2019-04-26 17:37:05', NULL, NULL, NULL, 'App\\User', 4),
(235, 297, 4, '2019-04-29 18:49:15', '2019-04-29 18:49:15', NULL, NULL, 'App\\User', 13),
(236, 211, 1, '2019-07-10 20:09:46', '2019-07-10 23:09:46', 'AtribuÃ­da para monitoramento da resposta do Ã“rgÃ£o Central.\r\n\r\nEm vista disso, e considerando que esta SPU-SC depende da descentralizaÃ§Ã£o dos recursos por parte de sua Unidade Central para adoÃ§Ã£o das providÃªncias de contrataÃ§Ã£o do serviÃ§o de demoliÃ§Ã£o, informamos que, tÃ£o logo sejam liberados tais recursos, daremos continuidade as providÃªncias para o cumprimento da sentenÃ§a.', NULL, 'App\\User', 1),
(237, 298, 8, '2019-05-30 14:12:32', '2019-05-30 14:12:32', 'Assunto tratado parcialmente pela DIIUP NT 12559, falta a CODES verificar a correta concessÃ£o na utilizaÃ§Ã£o da ocupaÃ§Ã£o.', NULL, 'App\\DivisaoOrganograma', 4),
(238, 299, 4, '2019-09-02 19:39:57', '2019-05-24 19:01:38', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(239, 300, 4, '2019-04-29 16:42:53', '2019-04-29 16:42:53', NULL, NULL, 'App\\User', 4),
(240, 301, 4, '2019-05-02 18:51:03', '2019-05-02 18:51:03', NULL, NULL, 'App\\User', 13),
(241, 158, 1, '2019-04-29 19:25:43', '2019-04-29 19:25:43', 'Minutar resposta', 'OfÃ­cio nÂº 33063/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(242, 235, 1, '2019-04-30 13:45:13', '2019-04-30 13:45:13', 'Minutar resposta', 'OfÃ­cio nÂº 33546/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(243, 295, 1, '2019-04-29 19:50:58', '2019-04-29 19:50:58', 'Minutar resposta', 'OfÃ­cio nÂº 34242/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(244, 217, 1, '2019-04-29 20:23:51', '2019-04-29 20:23:51', 'Minutar resposta', 'JÃ¡ havia sido minuta a resposta, assinada, enviada e registrado AR. Faltava sÃ³ atualizar a situaÃ§Ã£o da demanda', 'App\\User', 1),
(245, 266, 1, '2019-04-29 20:24:43', '2019-04-29 20:24:43', 'Minutar resposta', 'OfÃ­cio nÂº 33552/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(246, 302, 4, '2019-05-07 16:37:17', '2019-05-07 16:37:17', NULL, NULL, 'App\\User', 3),
(247, 289, 1, '2019-04-30 13:43:02', '2019-04-30 13:43:02', 'Minutar resposta', 'OfÃ­cio nÂº 34404/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(248, 303, 4, '2019-04-29 19:54:05', '2019-04-29 19:54:05', NULL, NULL, 'App\\User', 4),
(249, 304, 4, '2019-04-30 17:51:34', '2019-04-30 17:51:34', NULL, NULL, 'App\\User', 13),
(250, 305, 8, '2019-05-07 18:06:53', '2019-05-07 18:06:53', NULL, NULL, 'App\\User', 13),
(251, 233, 1, '2019-04-30 13:22:16', '2019-04-30 13:22:16', 'Minutar resposta', 'OfÃ­cio nÂº 34383/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(252, 306, 4, '2019-05-02 16:24:42', '2019-05-02 16:24:42', NULL, NULL, 'App\\User', 13),
(253, 307, 4, '2019-04-30 16:50:59', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(254, 308, 4, '2019-05-14 16:59:34', '2019-05-14 16:59:34', NULL, NULL, 'App\\User', 3),
(255, 309, 1, '2019-04-30 18:51:56', '2019-04-30 18:51:56', 'Manifestar sobre possÃ­vel sobreposiÃ§Ã£o de imÃ³vel em terras da UniÃ£o', 'Nota TÃ©cnica nÂº 10489/2019-MP', 'App\\User', 13),
(256, 310, 4, '2019-04-30 18:12:38', '2019-04-30 18:12:38', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(257, 311, 4, '2019-04-30 18:19:11', '2019-04-30 18:19:11', NULL, NULL, 'App\\User', 4),
(258, 312, 4, '2019-04-30 18:23:26', '2019-04-30 18:23:26', NULL, NULL, 'App\\User', 10),
(259, 178, 1, '2019-04-30 18:50:22', '2019-04-30 18:50:22', 'Minutar resposta', 'OfÃ­cio nÂº 34606/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(260, 194, 1, '2019-04-30 19:10:01', '2019-04-30 19:10:01', 'Minutar resposta', 'OfÃ­cio nÂº 34640/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(261, 309, 1, '2019-04-30 18:55:41', '2019-04-30 18:55:41', 'Minutar resposta', 'E-mail (8466237) 04972.002600/2019-94 - Resposta ao e-mail PSU-BNU-SC (Processo 0312945-49.2018.8.24.0008)', 'App\\User', 1),
(262, 270, 1, '2019-04-30 19:22:17', '2019-04-30 19:22:17', 'Minutar resposta', 'OfÃ­cio nÂº 34654/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(263, 313, 8, '2019-05-02 13:37:39', '2019-05-02 13:37:39', 'JÃ¡ respondido - Parecer 3877884\nFazer ofÃ­cio', NULL, 'App\\User', 8),
(264, 314, 4, '2019-05-03 14:23:59', '2019-05-03 14:23:59', NULL, NULL, 'App\\User', 13),
(265, 290, 4, '2019-05-07 12:07:13', '2019-05-07 12:07:13', NULL, NULL, 'App\\User', 13),
(266, 282, 4, '2019-05-02 18:32:38', '2019-05-02 18:32:38', NULL, NULL, 'App\\User', 3),
(267, 315, 4, '2019-05-02 19:16:27', '2019-05-02 19:16:26', NULL, NULL, 'App\\User', 4),
(268, 316, 4, '2019-08-19 12:55:04', '2019-08-19 15:55:04', NULL, NULL, 'App\\User', 4),
(269, 317, 4, '2019-05-10 18:37:42', '2019-05-10 18:37:42', NULL, NULL, 'App\\User', 13),
(270, 318, 4, '2019-07-18 17:53:10', '2019-07-18 20:53:10', NULL, NULL, 'App\\User', 13),
(271, 319, 4, '2019-05-03 18:56:13', '2019-05-03 18:56:13', NULL, NULL, 'App\\User', 13),
(272, 320, 3, '2019-05-28 15:03:22', '2019-05-28 15:03:22', NULL, 'E-mail 8485716', 'App\\User', 3),
(273, 321, 4, '2019-07-02 17:27:14', '2019-07-02 20:27:14', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(274, 322, 4, '2019-05-03 17:11:15', '2019-05-03 17:11:15', NULL, NULL, 'App\\User', 8),
(275, 323, 4, '2019-05-03 17:13:26', '2019-05-03 17:13:26', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(276, 324, 4, '2019-05-06 17:20:20', '2019-05-06 17:20:20', NULL, NULL, 'App\\User', 13),
(277, 325, 4, '2019-05-27 11:39:11', '2019-05-27 11:39:11', NULL, NULL, 'App\\User', 13),
(278, 326, 4, '2019-06-27 13:56:44', '2019-06-27 16:56:44', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(279, 327, 4, '2019-09-02 19:45:26', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(280, 328, 8, '2019-06-07 14:16:46', '2019-06-07 17:16:46', 'Verificar a resposta dada ao IBAMA, protocolo 04972.005401/2018-57, e responder ao MPF.', 'DistribuiÃ§Ã£o cancelada', 'App\\DivisaoOrganograma', 4),
(281, 329, 4, '2019-05-06 14:05:19', '2019-05-06 14:05:19', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(282, 331, 4, '2019-06-10 18:41:06', '2019-06-10 21:41:06', NULL, NULL, 'App\\User', 5),
(283, 314, 3, '2019-05-06 17:43:00', '2019-05-06 17:43:00', NULL, NULL, 'App\\User', 3),
(284, 324, 3, '2019-05-06 17:44:34', '2019-05-06 17:44:34', NULL, NULL, 'App\\User', 3),
(285, 13, 1, '2019-05-07 18:21:04', '2019-05-07 18:21:04', 'Minutar ofÃ­cio de resposta', 'OfÃ­cio nÂº 36268/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(286, 332, 8, '2019-05-07 12:38:20', '2019-05-07 12:38:20', NULL, NULL, 'App\\User', 8),
(287, 333, 4, '2019-07-23 13:08:08', '2019-07-23 16:08:08', NULL, 'Despacho DIGES-SPU-SC 8816979', 'App\\DivisaoOrganograma', 4),
(288, 334, 1, '2019-05-07 18:45:57', '2019-05-07 18:45:57', 'Minutar resposta', 'OfÃ­cio nÂº 36316/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(289, 335, 4, '2019-07-23 13:06:04', '2019-07-23 16:06:04', NULL, 'DIGES-SPU-SC 8817358', 'App\\DivisaoOrganograma', 4),
(290, 122, 1, '2019-05-09 18:31:28', '2019-05-09 18:31:28', 'Monitorar resposta da CODES-SPU-SC', NULL, 'App\\User', 1),
(291, 71, 1, '2019-05-09 13:11:04', '2019-05-09 13:11:04', 'Monitorar resposta da CODES-SPU-SC', 'OfÃ­cio nÂº 36448/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(292, 236, 1, '2019-05-14 13:26:54', '2019-05-14 13:26:54', 'Monitorar resposta da CODES-SPU-SC', 'OfÃ­cio nÂº 37490/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(293, 278, 1, '2019-05-09 17:30:10', '2019-05-09 17:30:10', 'Minutar OfÃ­cio de resposta', NULL, 'App\\User', 3),
(294, 229, 1, '2019-05-09 18:47:26', '2019-05-09 18:47:26', 'Minutar resposta da CODES-SPU-SC', 'Nota TÃ©cnica nÂº 11248/2019-MP', 'App\\User', 1),
(295, 336, 1, '2019-09-02 19:45:26', '2019-05-13 18:33:49', NULL, 'Despacho DIIUP-SPU-SC 8554631', 'App\\DivisaoOrganograma', 9),
(296, 336, 1, '2019-05-13 19:04:46', '2019-05-13 19:04:46', 'Minutar resposta', 'OfÃ­cio nÂº 37874/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(297, 13, 1, '2019-09-02 19:45:26', '2019-05-07 17:39:25', NULL, 'Despacho DIIUP-SPU-SC 8500338', 'App\\DivisaoOrganograma', 9),
(298, 334, 1, '2019-09-02 19:45:26', '2019-05-07 18:30:18', NULL, 'Despacho DIIUP-SPU_SC', 'App\\DivisaoOrganograma', 9),
(299, 337, 1, '2019-06-05 13:29:25', '2019-06-05 16:29:25', 'prestar as informaÃ§Ãµes solicitadas (ver descriÃ§Ã£o da demanda)', 'Atendida pela Barbara OfÃ­cio nÂº 45394/2019/SPU-SC/MP', 'App\\User', 5),
(300, 338, 1, '2019-05-30 13:29:23', '2019-05-30 13:29:23', 'informar sobre a data da ciÃªncia das ocupaÃ§Ãµes e quais medidas, inclusive de fiscalizaÃ§Ã£o, foram tomadas atÃ© o momento', 'OfÃ­cio nÂº 43710/2019/SPU-SC/MP', 'App\\User', 5),
(301, 302, 3, '2019-05-07 16:36:30', '2019-05-07 16:36:30', NULL, NULL, 'App\\User', 3),
(302, 339, 3, '2019-05-15 19:09:07', '2019-05-15 19:09:07', NULL, NULL, 'App\\User', 3),
(303, 340, 1, '2019-05-07 17:04:50', NULL, NULL, NULL, 'App\\User', 5),
(304, 339, 3, '2019-05-15 19:09:16', '2019-05-15 19:09:16', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(305, 341, 1, '2019-05-07 17:20:54', NULL, NULL, NULL, 'App\\User', 5),
(306, 342, 4, '2019-05-07 17:32:50', NULL, NULL, NULL, 'App\\User', 8),
(307, 343, 4, '2019-06-13 19:03:44', '2019-06-13 22:03:44', NULL, NULL, 'App\\User', 13),
(308, 344, 4, '2019-05-09 14:27:42', '2019-05-09 14:27:42', NULL, NULL, 'App\\User', 13),
(309, 345, 4, '2019-05-08 18:48:22', '2019-05-08 18:48:22', NULL, NULL, 'App\\User', 13),
(310, 347, 4, '2019-05-22 17:41:19', '2019-05-22 17:41:19', NULL, NULL, 'App\\User', 5),
(311, 348, 4, '2019-05-29 13:37:33', '2019-05-29 13:37:33', NULL, NULL, 'App\\User', 13),
(312, 349, 8, '2019-05-08 12:06:10', '2019-05-08 12:06:10', NULL, NULL, 'App\\User', 8),
(313, 350, 8, '2019-05-08 12:21:23', '2019-05-08 12:21:23', NULL, NULL, 'App\\User', 8),
(314, 351, 8, '2019-05-08 12:57:22', '2019-05-08 12:57:22', NULL, NULL, 'App\\User', 8),
(315, 352, 8, '2019-05-08 17:17:40', '2019-05-08 17:17:40', NULL, NULL, 'App\\User', 8),
(316, 353, 4, '2019-05-27 11:35:19', '2019-05-27 11:35:19', NULL, NULL, 'App\\User', 13),
(317, 354, 4, '2019-05-08 17:56:56', '2019-05-08 17:56:56', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(318, 354, 4, '2019-05-08 17:57:03', '2019-05-08 17:57:02', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(319, 355, 4, '2019-05-21 17:34:51', '2019-05-21 17:34:51', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(320, 356, 8, '2019-05-09 13:04:15', '2019-05-09 13:04:15', NULL, NULL, 'App\\User', 8),
(321, 357, 8, '2019-05-30 17:01:07', '2019-05-30 17:01:07', 'Projeto Orla em FlorianÃ³polis', NULL, 'App\\DivisaoOrganograma', 4),
(322, 360, 4, '2019-05-17 18:40:25', '2019-05-17 18:40:25', NULL, NULL, 'App\\User', 13),
(323, 244, 8, '2019-05-10 18:02:22', '2019-05-10 18:02:22', 'ImÃ³vel localizado em XanxerÃª -SC.\r\nVerificar a informaÃ§Ã£o de imÃ³vel situado em Zona de SeguranÃ§a Nacional.', NULL, 'App\\User', 5),
(324, 245, 8, '2019-05-28 17:12:52', '2019-05-28 17:12:52', 'RIP 8161.0000103-00\nConversÃ£o em renda dos valores depositados em juÃ­zo', NULL, 'App\\DivisaoOrganograma', 6),
(325, 361, 4, '2019-05-10 18:06:29', '2019-05-10 18:06:29', NULL, 'AtribuÃ­da ao Arq. Manglio.', 'App\\User', 5),
(326, 330, 8, '2019-05-10 12:05:55', '2019-05-10 12:05:55', NULL, NULL, 'App\\User', 8),
(327, 306, 1, '2019-05-09 18:28:48', '2019-05-09 18:28:48', 'Minutar resposta', 'OfÃ­cio nÂº 37089/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(328, 169, 1, '2019-05-09 17:21:04', '2019-05-09 17:21:04', 'Minutar resposta', 'OfÃ­cio nÂº 36631/2019/DIGES-SPU-SC/MP', 'App\\User', 3),
(329, 267, 1, '2019-05-09 18:43:42', '2019-05-09 18:43:42', 'Minutar resposta', 'OfÃ­cio nÂº 37125/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(330, 344, 1, '2019-05-27 11:51:13', '2019-05-27 11:51:13', 'Minutar resposta', NULL, 'App\\User', 1),
(331, 44, 8, '2019-05-09 18:40:59', '2019-05-09 18:40:59', NULL, NULL, 'App\\User', 8),
(332, 28, 8, '2019-05-09 18:42:23', '2019-05-09 18:42:23', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(333, 229, 1, '2019-05-14 13:20:01', '2019-05-14 13:20:01', 'Minutar resposta', 'Nota TÃ©cnica nÂº 11317/2019-MP', 'App\\User', 1),
(334, 26, 8, '2019-05-09 18:53:19', '2019-05-09 18:53:19', NULL, NULL, 'App\\User', 8),
(335, 5, 8, '2019-05-09 18:57:11', '2019-05-09 18:57:11', NULL, NULL, 'App\\User', 8),
(336, 3, 8, '2019-05-09 18:59:36', '2019-05-09 18:59:36', NULL, NULL, 'App\\User', 4),
(337, 362, 4, '2019-05-28 12:59:36', '2019-05-28 12:59:36', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(338, 362, 4, '2019-05-28 12:59:28', '2019-05-28 12:59:28', NULL, NULL, 'App\\User', 4),
(339, 11, 8, '2019-05-10 12:17:58', '2019-05-10 12:17:58', NULL, NULL, 'App\\User', 5),
(340, 43, 8, '2019-05-10 12:19:22', '2019-05-10 12:19:22', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(341, 6, 8, '2019-09-02 19:45:26', '2019-08-26 15:58:01', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(342, 7, 8, '2019-05-10 12:50:14', '2019-05-10 12:50:14', 'RecomendaÃ§Ã£o de cancelamento do RIP 8105.0005837-59.\nRanchos de pesca em terreno de marinha Ã s margens da Lagoa da ConceiÃ§Ã£o.', NULL, 'App\\User', 5),
(343, 7, 8, '2019-05-10 12:50:45', '2019-05-10 12:50:45', 'RecomendaÃ§Ã£o de cancelamento do RIP 8105.0005837-59.\nRanchos de pesca em terreno de marinha Ã s margens da Lagoa da ConceiÃ§Ã£o.', NULL, 'App\\DivisaoOrganograma', 4),
(344, 7, 8, '2019-05-10 12:50:55', NULL, 'RecomendaÃ§Ã£o de cancelamento do RIP 8105.0005837-59.\nRanchos de pesca em terreno de marinha Ã s margens da Lagoa da ConceiÃ§Ã£o.', NULL, 'App\\DivisaoOrganograma', 4),
(345, 71, 3, '2019-05-10 17:08:48', '2019-05-10 17:08:48', NULL, NULL, 'App\\User', 3),
(346, 71, 3, '2019-05-10 17:08:24', '2019-05-10 17:08:24', NULL, NULL, 'App\\User', 3),
(347, 363, 1, '2019-05-10 18:20:26', '2019-05-10 18:20:26', 'Minutar resposta', 'OfÃ­cio nÂº 37475/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(348, 361, 5, '2019-05-14 14:10:59', '2019-05-14 14:10:59', NULL, NULL, 'App\\User', 13),
(349, 265, 5, '2019-05-14 14:03:53', '2019-05-14 14:03:53', NULL, NULL, 'App\\User', 13),
(350, 364, 1, '2019-05-10 19:15:57', NULL, 'SentenÃ§a determina a conclusÃ£o da anÃ¡lise dos   pedidos   de   outorga   gratuita   de   aforamentons.   04972.007791/2013-95   e   04972.207127/2015-14', NULL, 'App\\DivisaoOrganograma', 4),
(351, 364, 1, '2019-05-10 20:36:29', '2019-05-10 20:36:29', 'SentenÃ§a determina a conclusÃ£o da anÃ¡lise do pedido de averbaÃ§Ã£o de transferÃªncia  n. 04972.004186/2009-86', 'Cancelando distribuiÃ§Ã£o', 'App\\User', 5),
(352, 364, 1, '2019-07-10 20:13:24', '2019-07-10 23:13:24', 'Continuar Despacho 8546808', 'Acompanhamento da demanda serÃ¡ feito via resumo gerencial.', 'App\\User', 1),
(353, 364, 1, '2019-05-28 19:51:09', '2019-05-28 19:51:09', NULL, 'Despacho DIREP-SPU-SC 8642810', 'App\\DivisaoOrganograma', 6),
(354, 215, 1, '2019-05-13 17:31:00', '2019-05-13 17:31:00', 'Minutar resposta', 'OfÃ­cio nÂº 37799/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(355, 365, 1, '2019-05-28 18:08:49', '2019-05-28 18:08:49', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(356, 365, 1, '2019-05-28 18:09:03', '2019-05-28 18:09:03', 'Monitorar resposta DIREP-SPU-SC', NULL, 'App\\User', 1),
(357, 366, 8, '2019-05-14 12:01:48', '2019-05-14 12:01:48', NULL, NULL, 'App\\User', 8),
(358, 367, 8, '2019-05-14 13:44:00', '2019-05-14 13:44:00', NULL, NULL, 'App\\User', 8),
(359, 208, 1, '2019-05-14 14:36:33', '2019-05-14 14:36:33', 'Minutar resposta', 'OfÃ­cio nÂº 38152/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(360, 368, 4, '2019-06-11 12:37:51', '2019-06-11 15:37:51', NULL, NULL, 'App\\User', 13),
(361, 369, 4, '2019-05-15 16:50:34', '2019-05-15 16:50:34', NULL, NULL, 'App\\User', 13),
(362, 370, 4, '2019-05-22 17:47:27', '2019-05-22 17:47:27', NULL, 'AtribuÃ­da ao Arq. Manglio', 'App\\User', 5),
(363, 371, 4, '2019-05-14 18:28:56', '2019-05-14 18:28:56', NULL, NULL, 'App\\User', 3),
(364, 372, 4, '2019-05-20 13:46:47', '2019-05-20 13:46:47', NULL, NULL, 'App\\User', 8),
(365, 373, 8, '2019-05-17 18:39:18', '2019-05-17 18:39:18', NULL, NULL, 'App\\User', 13),
(366, 374, 8, '2019-06-13 12:46:23', '2019-06-13 15:46:23', NULL, NULL, 'App\\User', 13),
(367, 375, 4, '2019-05-15 13:55:03', '2019-05-15 13:55:03', NULL, NULL, 'App\\User', 13),
(368, 230, 3, '2019-05-15 18:14:02', '2019-05-15 18:14:02', NULL, NULL, 'App\\User', 3),
(369, 230, 3, '2019-05-15 18:13:50', '2019-05-15 18:13:50', NULL, NULL, 'App\\User', 3),
(370, 376, 1, '2019-05-21 13:35:23', '2019-05-21 13:35:23', 'Minutar resposta ao MPF', 'OfÃ­cio nÂº 39868/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(371, 376, 1, '2019-05-20 13:47:22', '2019-05-20 13:47:22', 'Minutar despacho para SCGPU para reexame da decisÃ£o', NULL, 'App\\User', 1),
(372, 377, 4, '2019-08-05 18:31:35', '2019-08-05 21:31:35', NULL, NULL, 'App\\User', 8),
(373, 378, 3, '2019-05-27 12:24:46', '2019-05-27 12:24:46', NULL, NULL, 'App\\User', 5),
(374, 379, 8, '2019-05-16 13:03:33', '2019-05-16 13:03:33', NULL, NULL, 'App\\User', 8),
(375, 355, 3, '2019-05-21 17:33:55', '2019-05-21 17:33:55', NULL, NULL, 'App\\User', 3),
(376, 380, 8, '2019-05-17 17:33:35', '2019-05-17 17:33:35', NULL, NULL, 'App\\User', 8),
(377, 381, 8, '2019-05-17 17:19:40', '2019-05-17 17:19:40', NULL, NULL, 'App\\User', 8),
(378, 382, 8, '2019-05-17 17:20:07', '2019-05-17 17:20:07', NULL, NULL, 'App\\User', 8),
(379, 383, 8, '2019-05-17 17:20:32', '2019-05-17 17:20:32', NULL, NULL, 'App\\User', 8),
(380, 384, 8, '2019-05-17 12:20:49', '2019-05-17 12:20:49', NULL, NULL, 'App\\User', 8),
(381, 385, 8, '2019-05-16 19:27:55', '2019-05-16 19:27:55', NULL, NULL, 'App\\User', 8),
(382, 386, 8, '2019-05-17 18:02:56', '2019-05-17 18:02:56', NULL, NULL, 'App\\User', 8),
(383, 387, 1, '2019-05-28 17:00:27', '2019-05-28 17:00:27', NULL, NULL, 'App\\User', 5),
(384, 388, 4, '2019-05-28 16:41:50', '2019-05-28 16:41:50', NULL, NULL, 'App\\User', 13),
(385, 389, 4, '2019-05-22 13:12:58', '2019-05-22 13:12:58', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(386, 390, 4, '2019-05-27 11:33:33', '2019-05-27 11:33:33', NULL, NULL, 'App\\User', 13),
(387, 391, 4, '2019-06-25 16:34:40', '2019-06-25 19:34:40', NULL, NULL, 'App\\User', 5),
(388, 392, 4, '2019-05-29 13:37:07', '2019-05-29 13:37:07', NULL, NULL, 'App\\User', 13),
(389, 393, 4, '2019-07-16 17:44:38', '2019-07-16 20:44:38', NULL, NULL, 'App\\User', 4),
(390, 394, 8, '2019-05-17 18:46:23', '2019-05-17 18:46:23', NULL, NULL, 'App\\User', 8),
(391, 395, 4, '2019-05-27 16:48:26', '2019-05-27 16:48:26', NULL, NULL, 'App\\User', 13),
(392, 396, 8, '2019-05-20 16:37:06', '2019-05-20 16:37:06', NULL, NULL, 'App\\User', 8),
(393, 397, 8, '2019-05-20 16:45:24', '2019-05-20 16:45:24', NULL, NULL, 'App\\User', 8),
(394, 398, 8, '2019-05-20 19:06:42', '2019-05-20 19:06:42', NULL, NULL, 'App\\User', 8),
(395, 399, 8, '2019-05-22 11:39:32', '2019-05-22 11:39:32', NULL, NULL, 'App\\User', 8),
(396, 400, 8, '2019-05-22 11:39:01', '2019-05-22 11:39:01', NULL, NULL, 'App\\User', 8),
(397, 401, 8, '2019-05-21 18:26:05', '2019-05-21 18:26:05', NULL, NULL, 'App\\User', 8),
(398, 402, 8, '2019-05-21 11:21:33', '2019-05-21 11:21:33', NULL, NULL, 'App\\User', 8),
(399, 403, 8, '2019-05-21 11:20:42', '2019-05-21 11:20:42', NULL, NULL, 'App\\User', 8),
(400, 404, 8, '2019-05-21 11:19:44', '2019-05-21 11:19:44', NULL, NULL, 'App\\User', 8),
(401, 405, 8, '2019-05-20 17:25:40', '2019-05-20 17:25:40', NULL, NULL, 'App\\User', 8),
(402, 406, 4, '2019-09-02 19:45:26', '2019-06-21 20:46:28', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(403, 407, 4, '2019-05-27 14:14:15', '2019-05-27 14:14:15', NULL, NULL, 'App\\User', 13),
(404, 408, 4, '2019-05-28 14:27:14', '2019-05-28 14:27:14', NULL, NULL, 'App\\User', 5),
(405, 409, 4, '2019-05-28 15:01:34', '2019-05-28 15:01:34', NULL, 'DistribuÃ­da para o Alysson', 'App\\User', 3),
(406, 410, 4, '2019-05-20 17:25:08', '2019-05-20 17:25:08', NULL, NULL, 'App\\DivisaoOrganograma', 7),
(407, 411, 4, '2019-06-04 13:40:16', '2019-06-04 16:40:16', NULL, NULL, 'App\\User', 13),
(408, 412, 4, '2019-09-02 19:39:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(409, 413, 4, '2019-05-21 14:31:18', '2019-05-21 14:31:18', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(410, 414, 4, '2019-05-21 17:02:26', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(411, 227, 1, '2019-05-22 19:52:40', '2019-05-22 19:52:40', 'Minutar resposta', 'OfÃ­cio nÂº 40236/2019/DIRFH-SPU-SC/MP', 'App\\User', 1);
INSERT INTO `distribuicaodemanda` (`id`, `idDemanda`, `idUsuarioDe`, `dataDistribuicao`, `dataAtendimento`, `comentarioDistribuicao`, `comentarioAtendimento`, `assignable_type`, `assignable_id`) VALUES
(412, 265, 1, '2019-05-21 18:29:16', '2019-05-21 18:29:16', 'Atribuir demanda', 'OfÃ­cio nÂº 40248/2019/DIGES-SPU-SC/MP e Despacho DIGES-SPU-SC 8604570', 'App\\User', 1),
(413, 184, 1, '2019-05-21 18:56:12', '2019-05-21 18:56:12', 'Minutar resposta', NULL, 'App\\User', 3),
(414, 415, 8, '2019-05-28 16:51:16', '2019-05-28 16:51:16', NULL, NULL, 'App\\User', 13),
(415, 416, 4, '2019-06-18 12:37:21', '2019-06-18 15:37:21', NULL, NULL, 'App\\User', 13),
(416, 268, 1, '2019-05-24 13:41:30', '2019-05-24 13:41:30', 'Minutar resposta', NULL, 'App\\User', 3),
(417, 345, 1, '2019-05-21 19:13:43', '2019-05-21 19:13:43', NULL, 'OfÃ­cio nÂº 40313/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(418, 417, 4, '2019-06-17 13:34:38', '2019-06-17 16:34:38', NULL, NULL, 'App\\User', 13),
(419, 290, 3, '2019-05-21 19:06:16', '2019-05-21 19:06:16', NULL, NULL, 'App\\User', 3),
(420, 290, 3, '2019-05-21 19:07:09', '2019-05-21 19:07:09', NULL, NULL, 'App\\User', 3),
(421, 418, 4, '2019-06-03 13:39:53', '2019-06-03 16:39:53', NULL, 'Despacho CODES-SPU-SC 8662640', 'App\\DivisaoOrganograma', 4),
(422, 419, 8, '2019-05-28 13:24:25', '2019-05-28 13:24:25', NULL, 'OfÃ­cio nÂº 42932/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(423, 389, 3, '2019-09-02 19:39:57', '2019-05-30 17:33:55', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(424, 317, 1, '2019-05-22 14:35:41', '2019-05-22 14:35:41', 'Minutar resposta', 'OfÃ­cio nÂº 40494/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(425, 420, 8, '2019-05-22 17:01:05', '2019-05-22 17:01:05', 'Indicado o servidor Humberto para participar da audiÃªncia em 27/06/2019', NULL, 'App\\DivisaoOrganograma', 4),
(426, 421, 8, '2019-08-30 14:43:12', '2019-08-30 17:43:12', NULL, 'Despacho 3524301', 'App\\DivisaoOrganograma', 4),
(427, 370, 5, '2019-05-24 19:20:02', '2019-05-24 19:20:02', 'Efetuar a locaÃ§Ã£o do RIP cancelado', NULL, 'App\\User', 13),
(428, 422, 4, '2019-05-22 17:49:29', '2019-05-22 17:49:29', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(429, 423, 8, '2019-06-14 13:24:07', '2019-06-14 16:24:07', NULL, NULL, 'App\\User', 13),
(430, 424, 4, '2019-05-23 19:02:46', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(431, 425, 8, '2019-05-30 17:43:48', '2019-05-30 17:43:48', NULL, NULL, 'App\\User', 13),
(432, 426, 4, '2019-06-11 13:03:21', '2019-06-11 16:03:21', NULL, NULL, 'App\\User', 5),
(433, 427, 1, '2019-05-24 18:06:49', '2019-05-24 18:06:49', NULL, NULL, 'App\\User', 1),
(434, 427, 1, '2019-09-02 19:45:26', '2019-05-28 13:47:31', 'Para conhecimento da cÃ³pia do IC 1.33.005.000308/2013-3 (Ilha do Corisco) enviada pelo MPF/Joinville (8620736)', 'OfÃ­cio nÂº 41815/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 9),
(435, 428, 1, '2019-05-24 18:14:19', '2019-05-24 18:14:19', 'OfÃ­cio nÂº 20915/2019/DIGES-SPU-SC/MP', 'OfÃ­cio nÂº 20915/2019/DIGES-SPU-SC/MP', 'App\\User', 3),
(436, 429, 1, '2019-05-24 19:33:01', NULL, 'Elaborar processo de trabalho para cadastramento ex-ofÃ­cio:\r\nMinutar OfÃ­cio Sec. Ambiente Joinville (parecer sobre a Ã¡rea, dano ambiental)\r\nMinutar OfÃ­cio Prefeitura Joinville (cadastro dos responsÃ¡veis pelos imÃ³veis)', NULL, 'App\\User', 1),
(437, 429, 1, '2019-05-24 19:33:09', NULL, 'Elaborar processo de trabalho para cadastramento ex-ofÃ­cio:\r\nMinutar OfÃ­cio Sec. Ambiente Joinville (parecer sobre a Ã¡rea, dano ambiental)\r\nMinutar OfÃ­cio Prefeitura Joinville (cadastro dos responsÃ¡veis pelos imÃ³veis)', NULL, 'App\\User', 5),
(438, 430, 1, '2019-05-24 19:53:10', NULL, 'Verificar que no NUP 04972.006136/2016-62 jÃ¡ consta manifestaÃ§Ã£o sobre a Ã¡rea (a investigaÃ§Ã£o do MPE/SC deve ter migrado para o MPF/Joinville).\r\nNaquele NUP, o Oficio do MPE traz manifestacao da Secretaria do Meio Ambiente de Joinville sobre a realizaÃ§Ã£o de diversas vistorias, notificaÃ§Ãµes, etc.\r\nElaborar procedimento padrÃ£o para esse tipo de caso (ocupaÃ§Ã£o irregular, dano ambiental, linha homologada(?))', NULL, 'App\\User', 5),
(439, 430, 1, '2019-05-24 19:53:22', NULL, 'Verificar que no NUP 04972.006136/2016-62 jÃ¡ consta manifestaÃ§Ã£o sobre a Ã¡rea (a investigaÃ§Ã£o do MPE/SC deve ter migrado para o MPF/Joinville).\r\nNaquele NUP, o Oficio do MPE traz manifestacao da Secretaria do Meio Ambiente de Joinville sobre a realizaÃ§Ã£o de diversas vistorias, notificaÃ§Ãµes, etc.\r\nElaborar procedimento padrÃ£o para esse tipo de caso (ocupaÃ§Ã£o irregular, dano ambiental, linha homologada(?))', NULL, 'App\\User', 1),
(440, 431, 8, '2019-05-27 12:15:47', '2019-05-27 12:15:47', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(441, 432, 4, '2019-06-24 14:05:24', '2019-06-24 17:05:24', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(442, 433, 8, '2019-05-27 16:26:28', '2019-05-27 16:26:28', NULL, NULL, 'App\\User', 8),
(443, 434, 4, '2019-06-12 13:43:57', '2019-06-12 16:43:57', 'Conceder acesso externo ao Processo 04972.004937/2010-06', NULL, 'App\\User', 3),
(444, 435, 4, '2019-06-11 17:17:07', '2019-06-11 20:17:07', NULL, NULL, 'App\\User', 13),
(445, 436, 4, '2019-06-11 17:17:54', '2019-06-11 20:17:54', NULL, NULL, 'App\\User', 13),
(446, 437, 4, '2019-06-03 14:01:13', '2019-06-03 17:01:13', NULL, NULL, 'App\\User', 13),
(447, 438, 8, '2019-05-28 12:11:11', '2019-05-28 12:11:11', NULL, NULL, 'App\\User', 5),
(448, 439, 4, '2019-05-28 15:02:44', '2019-05-28 15:02:44', NULL, 'Atualizando distribuiÃ§Ã£o conforme SEI', 'App\\User', 3),
(449, 413, 1, '2019-06-19 12:32:59', '2019-06-19 15:32:59', 'Monitorar resposta da DIREP', NULL, 'App\\User', 4),
(450, 413, 1, '2019-06-19 12:33:05', '2019-06-19 15:33:05', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(451, 360, 1, '2019-05-28 18:59:06', '2019-05-28 18:59:06', 'Minutar resposta', NULL, 'App\\User', 8),
(452, 224, 1, '2019-05-28 19:36:28', '2019-05-28 19:36:28', 'Minutar resposta', 'OfÃ­cio nÂº 43266/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(453, 408, 1, '2019-05-28 19:46:49', '2019-05-28 19:46:49', NULL, 'OfÃ­cio nÂº 43290/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(454, 193, 1, '2019-05-28 19:26:44', '2019-05-28 19:26:44', 'Minutar resposta', 'OfÃ­cio nÂº 43249/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(455, 409, 1, '2019-07-10 18:22:10', '2019-07-10 21:22:10', 'DemoliÃ§Ã£o - Monitorar', 'Monitoramento serÃ¡ feito via resumo gerencial', 'App\\User', 1),
(456, 439, 1, '2019-06-21 17:59:40', '2019-06-21 20:59:40', 'Atualizando distribuiÃ§Ã£o conforme SEI', NULL, 'App\\User', 4),
(457, 222, 1, '2019-07-10 18:28:16', '2019-07-10 21:28:16', 'DistribuiÃ§Ã£o conforme SEI', 'Monitoramento serÃ¡ feito pelo resumo gerencial', 'App\\User', 1),
(458, 440, 4, '2019-09-02 19:39:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(459, 255, 5, '2019-06-04 12:50:19', '2019-06-04 15:50:19', 'Favor verificar se existe como identificar o local. Caso nÃ£o consiga, encaminhar para vistoria.', NULL, 'App\\User', 13),
(460, 174, 5, '2019-07-15 16:48:55', '2019-07-15 19:48:55', 'Verificar com o servidor Nilton Martins a conclusÃ£o do processo de imissÃ£o na posse', NULL, 'App\\User', 8),
(461, 387, 5, '2019-06-14 13:23:24', '2019-06-14 16:23:24', 'Elaborar mapa da LPM 1831 na Praia do Matadeiro. ApÃ³s, retornar para Juliano verificar o cumprimento da decisÃ£o liminar na ACP da Praia da ArmaÃ§Ã£o, que abrange a Ã¡rea em questÃ£o.', NULL, 'App\\User', 13),
(462, 2, 5, '2019-07-10 20:11:42', '2019-07-10 23:11:42', 'Verificar o recebimento do OfÃ­cio 22652 pela Prefeitura e solicitar a resposta.', NULL, 'App\\User', 1),
(463, 173, 5, '2019-06-25 17:46:19', '2019-06-25 20:46:19', 'Liminar informando da manutenÃ§Ã£o de passagem. NÃ£o tem necessidade de responder a AGU. NecessÃ¡rio criar rotina de divulgaÃ§Ã£o da decisÃ£o liminar. Proponho que seja dado ciÃªncia ao NÃºcleo de FiscalizaÃ§Ã£o e a CODES em casos semelhante.', 'Despacho DIGES-SPU-SC 8772666', 'App\\User', 1),
(464, 441, 4, '2019-05-28 17:32:58', NULL, NULL, NULL, 'App\\User', 4),
(465, 442, 8, '2019-05-28 17:35:13', '2019-05-28 17:35:13', NULL, NULL, 'App\\User', 8),
(466, 419, 1, '2019-05-28 18:59:35', NULL, 'Aguardando realizaÃ§Ã£o da fiscalizaÃ§Ã£o', NULL, 'App\\DivisaoOrganograma', 9),
(467, 443, 4, '2019-06-12 17:27:18', '2019-06-12 20:27:18', NULL, NULL, 'App\\User', 13),
(468, 444, 1, '2019-05-28 18:12:38', '2019-05-28 18:12:38', 'Minutar resposta', 'OfÃ­cio nÂº 43151/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(469, 445, 1, '2019-05-28 18:49:27', '2019-05-28 18:49:27', 'Minutar resposta', 'OfÃ­cio nÂº 43193/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(470, 446, 4, '2019-07-09 14:27:47', '2019-07-09 17:27:47', NULL, NULL, 'App\\User', 5),
(471, 98, 1, '2019-05-29 17:24:59', '2019-05-29 17:24:59', 'Minutar resposta ao MPF', 'OfÃ­cio nÂº 43590/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(472, 447, 4, '2019-06-24 19:36:39', '2019-06-24 22:36:39', NULL, NULL, 'App\\User', 5),
(473, 448, 4, '2019-05-30 18:19:41', '2019-05-30 18:19:41', NULL, NULL, 'App\\User', 8),
(474, 191, 5, '2019-06-19 13:40:31', '2019-06-19 16:40:31', 'Verificar se existe inscriÃ§Ã£o de ocupaÃ§Ã£o ou cessÃ£o de espelho d\'Ã¡gua no local. Verificar tambÃ©m se a Ã¡rea estÃ¡ inserida na poligonal do Porto Organizado de ItajaÃ­ / Navegantes.', NULL, 'App\\User', 13),
(475, 449, 4, '2019-05-30 18:02:02', '2019-05-30 18:02:02', 'Acredito que seja suficiente a concessÃ£o de acesso externo ao P.A 10983.000202/87-03', NULL, 'App\\User', 3),
(476, 450, 4, '2019-06-11 11:46:35', '2019-06-11 14:46:35', NULL, NULL, 'App\\User', 8),
(477, 451, 4, '2019-05-30 13:44:26', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(478, 453, 4, '2019-05-30 13:47:53', '2019-05-30 13:47:53', NULL, NULL, 'App\\User', 4),
(479, 454, 4, '2019-05-30 14:28:31', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(480, 177, 3, '2019-07-03 19:49:05', '2019-07-03 22:49:05', NULL, NULL, 'App\\User', 10),
(481, 389, 3, '2019-06-14 17:31:42', '2019-06-14 20:31:42', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(482, 455, 4, '2019-05-30 17:51:53', '2019-05-30 17:51:53', NULL, NULL, 'App\\User', 5),
(483, 459, 8, '2019-07-02 11:54:33', '2019-07-02 14:54:33', NULL, NULL, 'App\\User', 3),
(484, 460, 8, '2019-07-22 12:41:40', '2019-07-22 15:41:40', NULL, NULL, 'App\\User', 3),
(485, 461, 3, '2019-06-11 18:07:24', '2019-06-11 21:07:24', NULL, NULL, 'App\\DivisaoOrganograma', 1),
(486, 462, 8, '2019-06-03 16:53:16', '2019-06-03 19:53:16', NULL, NULL, 'App\\User', 8),
(487, 463, 8, '2019-06-03 13:56:55', '2019-06-03 16:56:55', NULL, NULL, 'App\\User', 8),
(488, 418, 1, '2019-06-03 13:45:13', '2019-06-03 16:45:13', 'Minutar resposta', 'OfÃ­cio nÂº 44765/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(489, 464, 4, '2019-07-18 12:18:17', '2019-07-18 15:18:17', NULL, NULL, 'App\\User', 4),
(490, 465, 3, '2019-06-11 19:03:16', '2019-06-11 22:03:16', NULL, NULL, 'App\\User', 5),
(491, 467, 3, '2019-07-03 17:23:57', '2019-07-03 20:23:57', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(492, 467, 3, '2019-09-02 19:45:26', '2019-07-03 20:24:03', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(493, 456, 8, '2019-06-11 17:19:55', '2019-06-11 20:19:55', NULL, NULL, 'App\\User', 13),
(494, 468, 4, '2019-06-03 17:08:02', '2019-06-03 20:08:02', NULL, NULL, 'App\\User', 4),
(495, 469, 4, '2019-06-05 17:31:13', '2019-06-05 20:31:13', NULL, NULL, 'App\\User', 13),
(496, 470, 1, '2019-06-03 21:52:23', NULL, 'Verificar o atendimento da demanda. Existe o processo relacionado nÂº 04972.006824/2018-94 com manifestaÃ§Ãµes posteriores', NULL, 'App\\DivisaoOrganograma', 7),
(497, 471, 1, '2019-06-03 20:17:01', '2019-06-03 23:17:01', NULL, 'Despacho DIIUP-SPU-SC nÂº 8661185', 'App\\DivisaoOrganograma', 9),
(498, 471, 1, '2019-06-04 19:22:23', '2019-06-04 22:22:23', 'Minutar ofÃ­cio de resposta', 'OfÃ­cio nÂº 45423/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(499, 472, 1, '2019-06-03 20:27:38', '2019-06-03 23:27:38', NULL, 'Atendido por Despacho DIIUP-SPU-SC 8671049', 'App\\DivisaoOrganograma', 9),
(500, 472, 1, '2019-06-04 17:55:22', '2019-06-04 20:55:22', 'Minutar resposta', 'OfÃ­cio nÂº 45061/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(501, 473, 1, '2019-06-03 20:31:33', '2019-06-03 23:31:33', NULL, 'Despacho DIIUP-SPU-SC 8664976', 'App\\DivisaoOrganograma', 9),
(502, 473, 1, '2019-06-04 19:23:38', '2019-06-04 22:23:38', 'Minutar resposta', 'OfÃ­cio nÂº 45382/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(503, 474, 17, '2019-06-04 14:42:14', NULL, 'Requerimento foi reiterado no processo relacionado 04972.001549/2017-31.', NULL, 'App\\DivisaoOrganograma', 10),
(504, 475, 17, '2019-06-04 15:02:35', NULL, 'Encaminhamento da CODES para DIRFH em maio de 2017.', NULL, 'App\\DivisaoOrganograma', 10),
(505, 476, 8, '2019-06-04 12:59:32', '2019-06-04 15:59:32', NULL, NULL, 'App\\User', 8),
(506, 477, 8, '2019-08-12 16:46:23', '2019-08-12 19:46:23', NULL, NULL, 'App\\DivisaoOrganograma', 10),
(507, 478, 3, '2019-07-03 17:22:30', '2019-07-03 20:22:30', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(508, 479, 8, '2019-06-04 16:39:27', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(509, 480, 17, '2019-07-11 18:34:36', '2019-07-11 21:34:36', 'Respondida, porÃ©m apÃ³s a resposta ao requerente CODES sucitou nova conclusÃ£o pedindo retorno do processo para analise. Elaborada novo oficio sem evidÃªncia de entrega.', NULL, 'App\\DivisaoOrganograma', 10),
(510, 481, 4, '2019-06-07 11:59:16', '2019-06-07 14:59:16', NULL, NULL, 'App\\User', 13),
(511, 482, 8, '2019-06-04 16:54:25', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(512, 483, 8, '2019-06-04 17:02:20', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(513, 484, 8, '2019-06-04 17:13:34', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(514, 485, 8, '2019-06-04 16:36:14', '2019-06-04 19:36:14', NULL, NULL, 'App\\User', 13),
(515, 485, 8, '2019-08-09 16:51:05', '2019-08-09 19:51:05', NULL, NULL, 'App\\DivisaoOrganograma', 10),
(516, 486, 3, '2019-06-10 14:20:34', '2019-06-10 17:20:34', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(517, 487, 8, '2019-06-04 19:45:42', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(518, 488, 8, '2019-06-04 19:51:21', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(519, 489, 8, '2019-06-11 17:19:17', '2019-06-11 20:19:17', NULL, NULL, 'App\\User', 13),
(520, 491, 8, '2019-06-04 20:34:59', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(521, 492, 8, '2019-06-04 20:46:50', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(522, 493, 8, '2019-06-04 20:56:26', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(523, 494, 18, '2019-06-04 21:02:10', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(524, 495, 4, '2019-06-11 17:19:34', '2019-06-11 20:19:34', NULL, NULL, 'App\\User', 13),
(525, 496, 8, '2019-06-04 21:07:48', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(526, 497, 8, '2019-06-04 21:13:56', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(527, 498, 17, '2019-06-04 21:35:33', NULL, 'A solicitaÃ§Ã£o foi reiterada no processo 04972.002027/2016-76.', NULL, 'App\\DivisaoOrganograma', 10),
(528, 499, 8, '2019-06-14 17:37:08', '2019-06-14 20:37:08', NULL, NULL, 'App\\User', 1),
(529, 500, 18, '2019-06-04 21:40:16', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(530, 501, 18, '2019-06-04 21:57:10', NULL, 'Respondida/NÃ£o resolvida, DIINC', NULL, 'App\\DivisaoOrganograma', 10),
(531, 502, 17, '2019-06-04 22:08:46', NULL, 'Respondida', NULL, 'App\\DivisaoOrganograma', 10),
(532, 503, 17, '2019-06-04 22:57:05', NULL, 'Respondido OfÃ­cio 97045 (7356523). Cancelamento de dÃ©bitos em processamento.', NULL, 'App\\DivisaoOrganograma', 10),
(533, 504, 18, '2019-06-04 22:57:10', NULL, 'Encaminhado Ã  DIINC pela DIGES para ciÃªncia de providÃªncias adotadas pelo MPF. NÃ£o hÃ¡ pendÃªncia de resposta Ã quele Ã³rgÃ£o.', NULL, 'App\\DivisaoOrganograma', 10),
(534, 505, 18, '2019-06-04 23:09:14', NULL, 'HÃ¡ manifestaÃ§Ã£o DIINC que julga nÃ£o precisar informar nada ao MPF. (Nota Informativas 286 - SEI 7749830)', NULL, 'App\\DivisaoOrganograma', 10),
(535, 506, 17, '2019-06-05 15:32:24', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(536, 507, 8, '2019-06-05 15:33:18', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(537, 337, 1, '2019-06-05 13:29:50', '2019-06-05 16:29:50', 'Enviar resposta', NULL, 'App\\User', 1),
(538, 508, 8, '2019-06-05 15:42:05', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(539, 509, 8, '2019-06-05 16:13:05', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(540, 510, 4, '2019-06-05 16:53:33', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(541, 471, 1, '2019-06-05 16:57:09', NULL, 'Monitorar processo de fiscalizaÃ§Ã£o (notificaÃ§Ã£o enviada)', NULL, 'App\\DivisaoOrganograma', 9),
(542, 512, 8, '2019-06-05 16:59:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(543, 513, 4, '2019-06-17 17:26:35', '2019-06-17 20:26:35', NULL, NULL, 'App\\User', 13),
(544, 473, 1, '2019-06-05 17:10:15', NULL, 'Monitorar processo de fiscalizaÃ§Ã£o (notificaÃ§Ã£o enviada)', NULL, 'App\\DivisaoOrganograma', 9),
(545, 514, 8, '2019-06-05 17:10:50', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(546, 511, 17, '2019-06-05 17:11:52', NULL, 'Ato contÃ­nuo, para firmar o TAC, a SPU/SC solicitou planta de poligonal da Ã¡rea em referÃªncia Ã  Prefeitura de AraranguÃ¡ (2015). Em 2017 a SPU solicitou informaÃ§Ãµes ao MPF do andamento do IC pois observou-se que nÃ£o houve conclusÃ£o da anÃ¡lise processual. Em 2018 InstruÃ§Ãµes para SolicitaÃ§Ã£o junto ao SPU de CessÃ£o do espaÃ§o aquÃ¡tico Ã  MUNICÃPIO DE ARARANGUÃ.', NULL, 'App\\DivisaoOrganograma', 10),
(547, 472, 1, '2019-06-05 17:16:20', NULL, 'Monitorando processo de fiscalizaÃ§Ã£o (notificaÃ§Ã£o enviada)', NULL, 'App\\DivisaoOrganograma', 9),
(548, 515, 4, '2019-06-05 16:53:52', '2019-06-05 19:53:52', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(549, 516, 8, '2019-06-05 19:57:05', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(550, 517, 3, '2019-06-05 17:34:40', '2019-06-05 20:34:40', NULL, NULL, 'App\\User', 13),
(551, 518, 8, '2019-06-05 21:05:35', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(552, 519, 18, '2019-06-05 21:11:11', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(553, 520, 4, '2019-07-01 12:47:29', '2019-07-01 15:47:29', NULL, NULL, 'App\\DivisaoOrganograma', 10),
(554, 521, 18, '2019-07-05 18:09:08', '2019-07-05 21:09:08', NULL, NULL, 'App\\DivisaoOrganograma', 10),
(555, 522, 8, '2019-06-05 21:46:50', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(556, 523, 4, '2019-06-05 21:59:24', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(557, 524, 8, '2019-06-05 22:14:43', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(558, 525, 18, '2019-06-05 22:35:56', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(559, 526, 18, '2019-06-05 22:46:25', NULL, 'NÃ£o colocado prazo por estar respondida, porÃ©m nÃ£o resolvida.', NULL, 'App\\DivisaoOrganograma', 10),
(560, 527, 17, '2019-08-08 17:27:45', '2019-08-08 20:27:45', 'Respondido ao MPF que foi questionado o municÃ­pio quanto a autorizaÃ§Ã£o para realizaÃ§Ã£o das edificaÃ§Ãµes, obtida resposta de negativa de protocolo de solicitaÃ§Ã£o da referida licenÃ§a.', 'Acompanhamento terÃ¡ prosseguimento com distribuiÃ§Ã£o Ã  NUFIS', 'App\\DivisaoOrganograma', 10),
(561, 528, 18, '2019-07-02 17:25:39', '2019-07-02 20:25:39', 'Beira Mar Norte, Parque Urbano e Marina', NULL, 'App\\DivisaoOrganograma', 10),
(562, 529, 18, '2019-06-05 23:17:49', NULL, 'Barragem TaiÃ³, Ituporanga', NULL, 'App\\DivisaoOrganograma', 10),
(563, 530, 1, '2019-06-07 21:29:09', '2019-06-08 00:29:09', 'Monitorar resposta da fiscalizaÃ§Ã£o', NULL, 'App\\User', 1),
(564, 530, 1, '2019-06-07 21:28:58', '2019-06-08 00:28:58', 'Elaborar manifestaÃ§Ã£o tÃ©cnica', 'Despacho DIIUP-SPU-SC 8680000', 'App\\DivisaoOrganograma', 9),
(565, 531, 8, '2019-06-07 15:18:31', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(566, 532, 8, '2019-06-19 12:26:45', '2019-06-19 15:26:45', NULL, NULL, 'App\\User', 13),
(567, 533, 8, '2019-06-07 15:55:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(568, 534, 8, '2019-06-07 16:05:59', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(569, 536, 1, '2019-06-07 21:23:03', '2019-06-08 00:23:03', 'monitorar resposta da fiscalizaÃ§Ã£o', 'cancelado (atribuÃ­do ao Niarcos)', 'App\\User', 1),
(570, 536, 1, '2019-08-19 17:28:40', '2019-08-19 20:28:40', 'elaborar manifestaÃ§Ã£o tÃ©cnica', 'Despacho DIIUP-SPU-SC 8857990', 'App\\DivisaoOrganograma', 9),
(571, 535, 17, '2019-08-23 18:49:29', '2019-08-23 21:49:29', 'Oficio da AGU solicita manifestaÃ§Ã£o acerca da petiÃ§Ã£o do MPF.\r\nPrazo 03/06/2019', NULL, 'App\\DivisaoOrganograma', 10),
(572, 328, 1, '2019-06-07 21:26:30', '2019-06-08 00:26:30', 'monitorar resposta da fiscalizaÃ§Ã£o', 'cancelado (para Niarcos)', 'App\\User', 1),
(573, 328, 1, '2019-08-19 17:48:51', '2019-08-19 20:48:51', 'elaborar manifestaÃ§Ã£o tÃ©cnica', 'Despacho DIIUP-SPU-SC 8832060', 'App\\DivisaoOrganograma', 9),
(574, 537, 17, '2019-06-07 17:26:24', NULL, 'Demanda respondida, na Ã©poca, que nÃ£o havia inscriÃ§Ã£o junto ao SIAPA da referida Ã¡rea. Novo questionamento do MPF em 2004. Em 2005 proprietÃ¡rio do condomÃ­nio requer desarquivamento e cÃ³pia do processo.', NULL, 'App\\DivisaoOrganograma', 10),
(575, 538, 4, '2019-07-24 12:49:49', '2019-07-24 15:49:49', NULL, NULL, 'App\\DivisaoOrganograma', 7),
(576, 539, 4, '2019-06-07 16:42:09', '2019-06-07 19:42:09', NULL, NULL, 'App\\User', 5),
(577, 540, 4, '2019-06-07 16:43:59', '2019-06-07 19:43:59', NULL, NULL, 'App\\User', 8),
(578, 541, 4, '2019-06-19 12:19:58', '2019-06-19 15:19:58', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(579, 542, 4, '2019-06-24 16:58:59', '2019-06-24 19:58:59', NULL, NULL, 'App\\User', 13),
(580, 543, 4, '2019-07-11 18:10:49', '2019-07-11 21:10:49', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(581, 544, 8, '2019-06-07 17:05:14', '2019-06-07 20:05:14', NULL, NULL, 'App\\User', 8),
(582, 545, 4, '2019-06-07 17:13:11', '2019-06-07 20:13:11', NULL, NULL, 'App\\User', 5),
(583, 546, 4, '2019-06-07 17:16:22', '2019-06-07 20:16:22', NULL, NULL, 'App\\User', 5),
(584, 547, 4, '2019-06-07 17:19:16', '2019-06-07 20:19:16', NULL, NULL, 'App\\User', 5),
(585, 548, 4, '2019-06-11 17:16:46', '2019-06-11 20:16:46', NULL, NULL, 'App\\User', 13),
(586, 549, 4, '2019-06-17 18:39:56', '2019-06-17 21:39:56', NULL, NULL, 'App\\User', 13),
(587, 551, 8, '2019-06-11 17:18:07', '2019-06-11 20:18:07', NULL, NULL, 'App\\User', 13),
(588, 552, 4, '2019-07-03 17:24:40', '2019-07-03 20:24:40', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(589, 553, 1, '2019-06-07 19:07:19', '2019-06-07 22:07:19', 'Elaborar manifestaÃ§Ã£o tÃ©cnica', 'Atendido pelo Despacho DIIUP-SPU-SC 8688461', 'App\\DivisaoOrganograma', 9),
(590, 553, 1, '2019-06-07 21:17:55', '2019-06-08 00:17:55', 'minutar resposta', 'OfÃ­cio nÂº 47540/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(591, 554, 1, '2019-07-01 13:48:56', '2019-07-01 16:48:56', 'elaborar manifestaÃ§Ã£o tÃ©cnica', 'Despacho DIIUP-SPU-SC 8770304', 'App\\DivisaoOrganograma', 9),
(592, 554, 1, '2019-07-01 13:49:49', '2019-07-01 16:49:49', 'minutar resposta', 'Oficio 51014/2019 (8786331)', 'App\\User', 1),
(593, 555, 1, '2019-08-19 13:11:13', '2019-08-19 16:11:13', 'elaborar manifestaÃ§Ã£o tÃ©cnica', 'Despacho DIIUP-SPU-SC 8809586', 'App\\DivisaoOrganograma', 9),
(594, 555, 1, '2019-07-09 14:05:21', '2019-07-09 17:05:21', 'monitorar resposta da fiscalizaÃ§Ã£o', 'Monitoramento serÃ¡ feito atravÃ©s do Resumo Gerencial', 'App\\User', 1),
(595, 556, 1, '2019-06-07 22:38:40', NULL, 'elaborar manifestaÃ§Ã£o tÃ©cnica', NULL, 'App\\DivisaoOrganograma', 9),
(596, 556, 1, '2019-07-09 14:09:05', '2019-07-09 17:09:05', 'monitorar resposta da fiscalizaÃ§Ã£o', 'Monitoramento serÃ¡ feito via Resumo Gerencial', 'App\\User', 1),
(597, 553, 1, '2019-06-11 12:29:16', '2019-06-11 15:29:16', 'aguardar a aprovaÃ§Ã£o da minuta do OfÃ­cio nÂº 47540/2019/DIGES-SPU-SC/MP pelo Bauer, coletar assinatura e enviar', NULL, 'App\\User', 3),
(598, 536, 1, '2019-07-09 13:44:34', '2019-07-09 16:44:34', 'aguardar despacho diiup e monitorar resposta. ver modelo 8688184', 'Monitoramento sendo realizado via Resumo Gerencial', 'App\\User', 3),
(599, 328, 1, '2019-07-09 13:44:44', '2019-07-09 16:44:44', 'monitorar resposta da fiscalizaÃ§Ã£o', 'Monitoramento sendo realizado via Resumo Gerencial', 'App\\User', 3),
(600, 530, 1, '2019-06-11 12:18:52', '2019-06-11 15:18:52', 'Minutar resposta', NULL, 'App\\User', 3),
(601, 557, 8, '2019-06-10 15:11:55', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(602, 558, 8, '2019-06-10 15:21:19', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(603, 559, 8, '2019-07-31 17:13:23', '2019-07-31 20:13:23', NULL, 'Despacho DIGES-SPU-SC 8823088 (JoÃ£o)', 'App\\DivisaoOrganograma', 4),
(604, 560, 8, '2019-06-10 16:14:43', NULL, 'Ilha JoÃ£o Cunha - JÃ¡ foi respondido que cancelarÃ­amos o cadastro, mas ele continua ativo.', NULL, 'App\\User', 5),
(605, 561, 8, '2019-06-10 16:29:31', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(606, 562, 8, '2019-06-10 16:59:14', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(607, 563, 4, '2019-06-12 12:42:16', '2019-06-12 15:42:16', NULL, NULL, 'App\\User', 13),
(608, 564, 4, '2019-06-11 17:17:28', '2019-06-11 20:17:28', NULL, NULL, 'App\\User', 13),
(609, 565, 4, '2019-07-05 17:36:24', '2019-07-05 20:36:24', NULL, 'Despacho DIREP-SPU-SC 8727806', 'App\\DivisaoOrganograma', 6),
(610, 566, 4, '2019-09-02 19:39:57', '2019-08-22 20:11:08', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(611, 567, 8, '2019-06-10 18:09:24', '2019-06-10 21:09:24', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(612, 568, 8, '2019-06-10 21:34:40', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(613, 569, 4, '2019-09-02 19:39:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(614, 570, 4, '2019-06-11 13:52:59', '2019-06-11 16:52:59', NULL, NULL, 'App\\DivisaoOrganograma', 2),
(615, 570, 4, '2019-08-20 19:08:25', '2019-08-20 22:08:25', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(616, 571, 17, '2019-06-11 17:13:22', NULL, 'OfÃ­cio 1311/2019 (8181718), ja Ã© uma reiteraÃ§Ã£o da solicitaÃ§Ã£o do oficio OfÃ­cio 5979/2018 (7599269), que foi respondido solicitando dilaÃ§Ã£o de prazo em 15 dias.\r\nApÃ³s, novo OfÃ­cio 2057/2019 (8549025), apensado ao processo reitera a demanda do OfÃ­cio 1311/2019 (8181718)', NULL, 'App\\DivisaoOrganograma', 10),
(617, 573, 4, '2019-07-02 17:29:04', '2019-07-02 20:29:04', NULL, NULL, 'App\\User', 13),
(618, 574, 4, '2019-06-11 16:44:00', '2019-06-11 19:44:00', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(619, 575, 4, '2019-06-11 16:45:18', '2019-06-11 19:45:18', NULL, NULL, 'App\\User', 4),
(620, 490, 8, '2019-06-11 16:58:45', '2019-06-11 19:58:45', NULL, NULL, 'App\\User', 8),
(621, 576, 4, '2019-07-05 18:31:18', '2019-07-05 21:31:18', NULL, NULL, 'App\\User', 13),
(622, 577, 17, '2019-06-11 20:30:42', NULL, 'Demanda respondida', NULL, 'App\\DivisaoOrganograma', 10),
(623, 578, 4, '2019-06-11 17:47:53', '2019-06-11 20:47:53', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(624, 579, 4, '2019-06-11 17:55:38', '2019-06-11 20:55:38', NULL, NULL, 'App\\User', 4),
(625, 580, 17, '2019-06-11 21:34:56', NULL, 'Respondido', NULL, 'App\\DivisaoOrganograma', 10),
(626, 581, 17, '2019-06-11 22:04:14', NULL, 'Demanda inicial OfÃ­cio 36/2016 (1312663), reiterada pelo OfÃ­cio 282/2016 (1945812), novamente reitera pelo OfÃ­cio 402/2016 (2274086)', NULL, 'App\\DivisaoOrganograma', 10),
(627, 582, 4, '2019-09-02 19:39:57', '2019-08-08 21:02:49', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(628, 583, 17, '2019-06-11 22:32:34', NULL, 'Processo jÃ¡ tramitou pela DIGES, CODES, retornando para DIGES que despacha ao superintendente propondo encaminhamento para COCAI analisar e  manifestar-se.', NULL, 'App\\DivisaoOrganograma', 10),
(629, 585, 4, '2019-09-02 19:39:57', '2019-07-02 22:16:19', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(630, 586, 17, '2019-06-12 20:17:47', NULL, 'Oficio respondido.', NULL, 'App\\DivisaoOrganograma', 10),
(631, 587, 4, '2019-06-24 13:01:50', '2019-06-24 16:01:50', NULL, NULL, 'App\\User', 13),
(632, 588, 4, '2019-06-25 11:52:02', '2019-06-25 14:52:02', NULL, NULL, 'App\\User', 13),
(633, 589, 4, '2019-06-13 13:49:14', '2019-06-13 16:49:14', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(634, 590, 4, '2019-06-13 13:51:23', '2019-06-13 16:51:23', NULL, NULL, 'App\\User', 4),
(635, 591, 4, '2019-06-13 14:11:15', '2019-06-13 17:11:15', NULL, NULL, 'App\\User', 4),
(636, 592, 8, '2019-06-13 18:13:38', '2019-06-13 21:13:38', NULL, NULL, 'App\\User', 13),
(637, 593, 4, '2019-06-13 18:13:38', '2019-06-13 21:13:38', NULL, NULL, 'App\\User', 4),
(638, 594, 4, '2019-06-17 17:58:47', '2019-06-17 20:58:47', NULL, NULL, 'App\\User', 5),
(639, 343, 4, '2019-09-02 19:39:57', '2019-06-13 22:03:54', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(640, 343, 4, '2019-09-02 19:39:57', '2019-06-24 21:21:09', NULL, 'Despacho DIINC-SPU-SC', 'App\\DivisaoOrganograma', 3),
(641, 595, 8, '2019-06-19 13:29:18', '2019-06-19 16:29:18', 'Solicitar novo parecer de forÃ§a executÃ³ria.', NULL, 'App\\User', 8),
(642, 596, 4, '2019-07-02 14:11:43', '2019-07-02 17:11:43', NULL, NULL, 'App\\User', 13),
(643, 597, 4, '2019-06-17 17:02:58', NULL, NULL, NULL, 'App\\User', 16),
(644, 598, 4, '2019-06-17 17:26:55', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(645, 599, 4, '2019-06-17 17:07:27', '2019-06-17 20:07:27', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(646, 599, 4, '2019-06-18 19:01:38', '2019-06-18 22:01:38', NULL, NULL, 'App\\User', 3),
(647, 600, 4, '2019-06-25 16:47:33', '2019-06-25 19:47:33', NULL, NULL, 'App\\User', 8),
(648, 601, 17, '2019-06-17 20:58:30', NULL, 'Oficio de 2015 embasado em sentem de 2007. Determina aÃ§Ãµes em 60 dias.', NULL, 'App\\DivisaoOrganograma', 10),
(649, 602, 4, '2019-06-17 21:20:20', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(650, 603, 4, '2019-06-19 12:09:59', '2019-06-19 15:09:59', NULL, NULL, 'App\\User', 13),
(651, 604, 17, '2019-06-17 22:12:11', NULL, 'Oficio OfÃ­cio 1956/2015 (0845495) do MPF de 01/09/2015, respondido pelo OfÃ­cio 17295 (0913170).', NULL, 'App\\DivisaoOrganograma', 10),
(652, 605, 17, '2019-06-17 22:23:53', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(653, 606, 18, '2019-06-17 23:06:56', NULL, 'LAGUNA/SC -   Rosane Tasca', NULL, 'App\\DivisaoOrganograma', 10),
(654, 607, 18, '2019-06-17 23:21:01', NULL, 'CELIO DAMINANI. PONTA DA BARRA, LAGUNA/SC.', NULL, 'App\\DivisaoOrganograma', 10),
(655, 416, 5, '2019-06-18 12:37:46', '2019-06-18 15:37:46', NULL, NULL, 'App\\User', 5),
(656, 416, 5, '2019-06-28 18:25:48', '2019-06-28 21:25:48', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(657, 608, 4, '2019-07-02 17:27:57', '2019-07-02 20:27:57', NULL, NULL, 'App\\User', 13),
(658, 609, 4, '2019-07-17 12:39:15', '2019-07-17 15:39:15', NULL, NULL, 'App\\User', 4),
(659, 610, 4, '2019-06-19 13:37:02', '2019-06-19 16:37:02', NULL, NULL, 'App\\User', 13),
(660, 612, 4, '2019-06-18 17:07:51', '2019-06-18 20:07:51', NULL, NULL, 'App\\User', 4),
(661, 614, 18, '2019-06-18 21:09:05', NULL, 'RFFSA. Respondida/NÃ£o resolvida', NULL, 'App\\DivisaoOrganograma', 10),
(662, 615, 17, '2019-06-18 22:03:55', NULL, 'OfÃ­cio 377/2015 (0895102), reiterado pelo OfÃ­cio 441/2015 (1034703) no processo 04972.206416/2015-98, respondido pelo OfÃ­cio 11649 (1467516).', NULL, 'App\\DivisaoOrganograma', 10),
(663, 616, 17, '2019-06-18 22:55:00', NULL, 'Respondido OfÃ­cio 171 (7726785)', NULL, 'App\\DivisaoOrganograma', 10),
(664, 617, 8, '2019-06-25 16:55:52', '2019-06-25 19:55:52', NULL, NULL, 'App\\User', 8),
(665, 618, 8, '2019-06-19 17:19:31', '2019-06-19 20:19:31', NULL, NULL, 'App\\User', 13),
(666, 623, 4, '2019-06-24 18:13:04', '2019-06-24 21:13:04', NULL, NULL, 'App\\User', 13),
(667, 624, 8, '2019-06-21 12:12:01', '2019-06-21 15:12:01', NULL, NULL, 'App\\User', 8),
(668, 625, 8, '2019-06-21 15:56:31', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(669, 626, 8, '2019-07-16 16:52:02', '2019-07-16 19:52:02', NULL, NULL, 'App\\User', 13),
(670, 619, 8, '2019-06-28 17:59:41', '2019-06-28 20:59:41', 'Encaminhar', NULL, 'App\\User', 8),
(671, 627, 8, '2019-06-28 18:03:16', '2019-06-28 21:03:16', NULL, NULL, 'App\\User', 8),
(672, 629, 4, '2019-07-16 18:10:41', '2019-07-16 21:10:41', NULL, NULL, 'App\\User', 3),
(673, 630, 4, '2019-07-02 14:07:17', '2019-07-02 17:07:17', NULL, NULL, 'App\\User', 13),
(674, 631, 8, '2019-06-21 20:10:01', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(675, 632, 8, '2019-06-21 20:15:01', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(676, 633, 8, '2019-06-21 20:22:14', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(677, 634, 4, '2019-08-08 19:32:39', '2019-08-08 22:32:39', NULL, NULL, 'App\\User', 3),
(678, 406, 4, '2019-07-31 17:04:52', '2019-07-31 20:04:52', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(679, 635, 17, '2019-06-24 14:40:01', NULL, 'Resposta no OfÃ­cio 69318 (4490748).', NULL, 'App\\DivisaoOrganograma', 10),
(680, 636, 17, '2019-06-24 14:55:16', NULL, 'Resposta no OfÃ­cio 58259 (4261663)', NULL, 'App\\DivisaoOrganograma', 10),
(681, 584, 8, '2019-07-02 14:09:08', '2019-07-02 17:09:08', NULL, NULL, 'App\\User', 13),
(682, 637, 4, '2019-07-15 18:46:50', '2019-07-15 21:46:50', NULL, NULL, 'App\\User', 13),
(683, 638, 4, '2019-07-11 16:59:04', '2019-07-11 19:59:04', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(684, 639, 8, '2019-07-03 19:33:10', '2019-07-03 22:33:10', NULL, NULL, 'App\\User', 8),
(685, 640, 4, '2019-07-03 17:36:45', '2019-07-03 20:36:45', NULL, NULL, 'App\\User', 13),
(686, 641, 4, '2019-07-04 19:01:31', '2019-07-04 22:01:31', NULL, NULL, 'App\\User', 13),
(687, 542, 5, '2019-06-24 16:59:16', '2019-06-24 19:59:16', NULL, NULL, 'App\\User', 5),
(688, 646, 4, '2019-06-24 20:55:24', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(689, 647, 4, '2019-07-02 14:07:58', '2019-07-02 17:07:58', NULL, NULL, 'App\\User', 13),
(690, 343, 1, '2019-06-24 18:21:44', '2019-06-24 21:21:44', 'Minutar resposta', 'OfÃ­cio nÂº 50058/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(691, 648, 1, '2019-07-09 16:16:27', '2019-07-09 19:16:27', 'informar se esta SPU-SC pretende dar cumprimento ao julgado para reintegraÃ§Ã£o de posse ou se mantÃ©m a suspensÃ£o da execuÃ§Ã£o.', NULL, 'App\\DivisaoOrganograma', 4),
(692, 648, 1, '2019-06-24 21:50:50', NULL, 'Monitorar resposta da CODES-SPU-SC', NULL, 'App\\User', 1),
(693, 650, 17, '2019-06-24 22:23:48', NULL, 'OfÃ­cio 2473/2017 (3711345), reiterado OfÃ­cio 4310/2017 (4292633), e novamente reiterado OfÃ­cio 5515/2017 (4728798).', NULL, 'App\\DivisaoOrganograma', 10),
(694, 651, 4, '2019-06-24 22:38:07', NULL, NULL, NULL, 'App\\User', 13),
(695, 652, 1, '2019-08-09 14:01:13', '2019-08-09 17:01:13', 'Niarcos, favor agilizar o pagamento de honorÃ¡rios (seria legal documentar na intranet para que outros possam fazer)', NULL, 'App\\User', 3),
(696, 653, 17, '2019-07-22 13:44:07', '2019-07-22 16:44:07', 'Resposta OfÃ­cio 31082 (3670951)', NULL, 'App\\DivisaoOrganograma', 10),
(697, 654, 4, '2019-07-03 17:35:58', '2019-07-03 20:35:58', NULL, NULL, 'App\\User', 13),
(698, 645, 8, '2019-07-03 20:41:04', '2019-07-03 23:41:04', 'O nÃºmero do processo de demarcaÃ§Ã£o no SIAPA nÃ£o confere.', NULL, 'App\\User', 5),
(699, 613, 8, '2019-06-28 18:01:22', '2019-06-28 21:01:22', NULL, NULL, 'App\\User', 8),
(700, 620, 8, '2019-06-26 14:05:48', '2019-06-26 17:05:48', NULL, NULL, 'App\\User', 8),
(701, 423, 1, '2019-06-25 13:25:22', '2019-06-25 16:25:22', 'Minutar ofÃ­cio de resposta', 'OfÃ­cio nÂº 50145/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(702, 656, 4, '2019-06-27 13:24:06', '2019-06-27 16:24:06', NULL, NULL, 'App\\User', 13),
(703, 649, 8, '2019-07-31 13:59:14', '2019-07-31 16:59:14', 'DesapropriaÃ§Ã£o. Aeroporto, Navegantes.', NULL, 'App\\User', 5),
(704, 657, 4, '2019-07-22 12:33:31', '2019-07-22 15:33:31', NULL, NULL, 'App\\User', 13),
(705, 447, 1, '2019-06-25 16:17:32', '2019-06-25 19:17:32', 'Minutar resposta', 'OfÃ­cio nÂº 50164/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(706, 658, 4, '2019-07-02 14:06:33', '2019-07-02 17:06:33', NULL, NULL, 'App\\User', 13),
(707, 600, 8, '2019-07-12 17:17:02', '2019-07-12 20:17:02', NULL, NULL, 'App\\User', 13),
(708, 659, 4, '2019-06-28 13:53:48', '2019-06-28 16:53:48', NULL, NULL, 'App\\User', 3),
(709, 660, 4, '2019-07-16 18:03:55', '2019-07-16 21:03:55', NULL, NULL, 'App\\User', 3),
(710, 661, 4, '2019-06-28 14:15:11', '2019-06-28 17:15:11', NULL, NULL, 'App\\User', 13),
(711, 662, 8, '2019-06-26 15:17:53', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(712, 663, 1, '2019-06-26 16:59:12', NULL, 'Monitorar andamento da aÃ§Ã£o (suspensa)', NULL, 'App\\User', 1),
(713, 628, 8, '2019-06-26 16:48:21', '2019-06-26 19:48:21', NULL, NULL, 'App\\User', 8),
(714, 664, 8, '2019-06-26 17:03:33', '2019-06-26 20:03:33', NULL, NULL, 'App\\User', 8),
(715, 666, 8, '2019-06-26 18:17:19', '2019-06-26 21:17:19', NULL, NULL, 'App\\User', 8),
(716, 667, 1, '2019-06-26 18:24:11', '2019-06-26 21:24:11', NULL, 'Despacho DIRFH-SPU-SC 8683956', 'App\\DivisaoOrganograma', 7),
(717, 667, 1, '2019-06-26 18:24:51', '2019-06-26 21:24:51', NULL, 'ConclusÃ£o do processo enquanto aguarda nova manifestaÃ§Ã£o judicial', 'App\\User', 1),
(718, 668, 1, '2019-06-26 21:37:54', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(719, 669, 1, '2019-06-26 22:02:14', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(720, 671, 1, '2019-06-26 22:46:52', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(721, 672, 1, '2019-06-26 23:10:58', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(722, 673, 1, '2019-06-26 23:30:55', NULL, 'Acompanhar intimaÃ§Ã£o da AGU para desocupaÃ§Ã£o da Casa do Piloto', NULL, 'App\\User', 5),
(723, 674, 4, '2019-07-29 14:20:21', '2019-07-29 17:20:21', NULL, NULL, 'App\\User', 13),
(724, 675, 3, '2019-07-10 17:08:52', '2019-07-10 20:08:52', NULL, NULL, 'App\\User', 5),
(725, 677, 4, '2019-06-27 17:31:45', '2019-06-27 20:31:45', NULL, NULL, 'App\\User', 4),
(726, 678, 4, '2019-08-12 16:46:02', '2019-08-12 19:46:02', NULL, NULL, 'App\\User', 5),
(727, 679, 1, '2019-06-27 21:31:33', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(728, 680, 1, '2019-06-27 21:46:36', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(729, 681, 4, '2019-07-02 18:00:26', '2019-07-02 21:00:26', NULL, NULL, 'App\\User', 13),
(730, 682, 4, '2019-06-27 23:46:46', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(731, 683, 1, '2019-06-28 17:03:06', '2019-06-28 20:03:06', NULL, 'Despacho DIGES-SPU-SC 8776609', 'App\\User', 5),
(732, 683, 1, '2019-07-12 13:36:37', '2019-07-12 16:36:37', 'Minutar ofÃ­cios para registro de imÃ³veis, HR Loteamento, AGU e MPF', 'Duplicada', 'App\\User', 1),
(733, 683, 1, '2019-07-12 13:36:24', '2019-07-12 16:36:24', 'Minutar ofÃ­cios para registro de imÃ³veis, HR Loteamento, AGU e MPF', 'Registro de ImÃ³veis 8781823\r\nHR Loteamento 8781999\r\nMPF 8786867\r\nAGU 8789189', 'App\\User', 1),
(734, 684, 1, '2019-06-28 17:27:35', NULL, 'Verificar atendimento do OfÃ­cio 50783/2019 (nosso)', NULL, 'App\\DivisaoOrganograma', 9),
(735, 520, 1, '2019-07-01 15:47:23', NULL, 'Juliano, a SPU-SC informou que acatava a RecomendaÃ§Ã£o 8/2017 e encaminhou Ã  Ã¡rea tÃ©cnica. MPF cobra quais providÃªncias foram adotadas.\r\nTrata-se de conteiner instalado em Ã¡rea de dunas na APA Baleia Franca.', NULL, 'App\\User', 5),
(736, 685, 4, '2019-07-16 16:00:40', '2019-07-16 19:00:40', NULL, NULL, 'App\\User', 13),
(737, 686, 8, '2019-07-02 17:32:15', '2019-07-02 20:32:15', NULL, NULL, 'App\\User', 8),
(738, 687, 8, '2019-07-02 17:36:04', '2019-07-02 20:36:04', NULL, NULL, 'App\\User', 8),
(739, 689, 4, '2019-07-03 12:49:06', '2019-07-03 15:49:06', NULL, NULL, 'App\\User', 3),
(740, 690, 4, '2019-07-09 12:01:35', '2019-07-09 15:01:35', NULL, NULL, 'App\\User', 13),
(741, 692, 4, '2019-07-03 17:11:45', '2019-07-03 20:11:45', NULL, NULL, 'App\\User', 13),
(742, 694, 1, '2019-07-10 20:12:31', '2019-07-10 23:12:31', 'Acompanhar cumprimento da decisÃ£o', 'Acompanhamento serÃ¡ feito pelo resumo gerencial', 'App\\User', 1),
(743, 694, 1, '2019-09-02 19:39:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(744, 695, 4, '2019-07-03 14:36:17', '2019-07-03 17:36:17', NULL, NULL, 'App\\User', 4),
(745, 696, 1, '2019-07-03 16:55:52', '2019-07-03 19:55:52', 'Oficio solicitando memorial descritivo do imÃ³vel', 'OfÃ­cio nÂº 51376/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(746, 697, 4, '2019-07-03 17:30:58', '2019-07-03 20:30:58', NULL, NULL, 'App\\User', 4),
(747, 57, 1, '2019-07-10 20:10:09', '2019-07-10 23:10:09', 'Acompanhar elaboraÃ§Ã£o termo de referÃªncia', NULL, 'App\\User', 1),
(748, 691, 3, '2019-07-24 12:48:55', '2019-07-24 15:48:55', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(749, 645, 5, '2019-07-25 19:25:54', '2019-07-25 22:25:54', 'Dar acesso externo ao processo de demarcaÃ§Ã£o de BalneÃ¡rio CamboriÃº 11452.001088/96-73, e ao ao processo do RIP', NULL, 'App\\User', 8),
(750, 688, 8, '2019-07-12 13:14:03', '2019-07-12 16:14:03', 'Pede a transferÃªncia da responsabilidade pela ocupaÃ§Ã£o do imÃ³vel cadastrado sob o RIP n. 8045.0000180-86.', NULL, 'App\\DivisaoOrganograma', 13),
(751, 698, 4, '2019-07-04 16:39:51', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(752, 670, 8, '2019-07-19 16:43:15', '2019-07-19 19:43:15', 'InformaÃ§Ã£o sobre a existÃªncia de manifestaÃ§Ã£o do Ã³rgÃ£o ambiental competente.', NULL, 'App\\DivisaoOrganograma', 7),
(753, 700, 8, '2019-07-04 22:29:35', NULL, NULL, NULL, 'App\\User', 13),
(754, 701, 4, '2019-08-22 18:25:28', NULL, 'Aguardar definiÃ§Ã£o de valores/datas pelo NUCIP', NULL, 'App\\DivisaoOrganograma', 6),
(755, 702, 17, '2019-07-04 22:47:06', NULL, 'Respondido OfÃ­cio 31106 (3671428)', NULL, 'App\\DivisaoOrganograma', 10),
(756, 703, 17, '2019-07-04 23:00:04', NULL, 'NÃ£o respondido. Ultimo doc Despacho propÃµe encaminhamento Ã  COCAI para anÃ¡lise e manifestaÃ§Ã£o.', NULL, 'App\\DivisaoOrganograma', 10),
(757, 704, 1, '2019-07-05 16:23:26', NULL, 'No processo jÃ¡ existe um mapa da fiscalizaÃ§Ã£o que foi anexado pelo Marcelo, mas nÃ£o sei se Ã© o mapa cuja elaboraÃ§Ã£o foi mencionada no RelatÃ³rio de FiscalizaÃ§Ã£o.', NULL, 'App\\User', 5),
(758, 705, 17, '2019-07-05 17:06:44', NULL, 'Demanda reiterada pelo OfÃ­cio 1786/2018 (7466191), e respondida pelo OfÃ­cio 103595 (7498130).', NULL, 'App\\DivisaoOrganograma', 10),
(759, 706, 17, '2019-07-05 17:23:43', NULL, 'Respondido OfÃ­cio 31887 (3687237)', NULL, 'App\\DivisaoOrganograma', 10),
(760, 707, 8, '2019-07-23 12:55:29', '2019-07-23 15:55:29', NULL, NULL, 'App\\User', 13),
(761, 708, 3, '2019-07-05 16:49:37', '2019-07-05 19:49:37', NULL, NULL, 'App\\User', 3),
(762, 709, 1, '2019-08-05 14:02:28', '2019-08-05 17:02:28', NULL, 'OfÃ­cio nÂº 40299/2019/SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(763, 710, 17, '2019-08-08 17:25:32', '2019-08-08 20:25:32', 'Respondida OfÃ­cio 25644 (3563454)', NULL, 'App\\DivisaoOrganograma', 10),
(764, 565, 1, '2019-07-05 17:38:35', '2019-07-05 20:38:35', 'Aguardando providÃªncias da AGU/JuÃ­zo junto a CEF para finalizaÃ§Ã£o do procedimento de conversÃ£o em renda', 'Cancelando', 'App\\DivisaoOrganograma', 7),
(765, 565, 1, '2019-07-05 20:38:43', NULL, 'Aguardando providÃªncias da AGU/JuÃ­zo junto a CEF para finalizaÃ§Ã£o do procedimento de conversÃ£o em renda', NULL, 'App\\DivisaoOrganograma', 6),
(766, 699, 1, '2019-07-05 18:03:15', '2019-07-05 21:03:15', 'Minutar OfÃ­cio para AGU', 'OfÃ­cio nÂº 51700/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(767, 711, 4, '2019-07-29 13:55:41', '2019-07-29 16:55:41', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(768, 712, 4, '2019-08-22 18:12:07', '2019-08-22 21:12:07', NULL, 'OFÃCIO SEI NÂº 103/2019/NUJUC/SPU-SC/SPU/SEDDM-ME', 'App\\DivisaoOrganograma', 9),
(769, 713, 17, '2019-07-05 21:46:57', NULL, 'Respondido OfÃ­cio 3137 (3084806)', NULL, 'App\\DivisaoOrganograma', 10),
(770, 714, 17, '2019-07-12 13:40:27', '2019-07-12 16:40:27', 'Respondido OfÃ­cio 5108 (3129719). InclusÃ£o PAF, fiscalizaÃ§Ã£o realizada em 26/04/2019 RelatÃ³rio DIIUP-SPU-SC (8677837)', NULL, 'App\\DivisaoOrganograma', 10),
(771, 715, 8, '2019-07-16 17:30:10', '2019-07-16 20:30:10', NULL, NULL, 'App\\User', 13),
(772, 716, 8, '2019-07-23 17:13:02', '2019-07-23 20:13:02', NULL, NULL, 'App\\User', 3),
(773, 717, 8, '2019-07-25 16:55:38', '2019-07-25 19:55:38', NULL, NULL, 'App\\User', 13),
(774, 718, 8, '2019-07-08 16:53:55', NULL, NULL, NULL, 'App\\User', 5),
(775, 719, 4, '2019-07-22 12:02:19', '2019-07-22 15:02:19', NULL, NULL, 'App\\User', 13),
(776, 720, 8, '2019-07-17 19:25:03', '2019-07-17 22:25:03', NULL, NULL, 'App\\User', 3),
(777, 693, 8, '2019-07-08 16:57:03', '2019-07-08 19:57:03', NULL, NULL, 'App\\User', 13),
(778, 721, 4, '2019-07-08 17:23:18', '2019-07-08 20:23:18', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(779, 572, 8, '2019-07-08 20:21:12', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(780, 721, 4, '2019-07-08 20:23:28', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(781, 725, 8, '2019-07-12 19:17:32', '2019-07-12 22:17:32', NULL, NULL, 'App\\User', 13),
(782, 726, 4, '2019-07-09 14:06:47', '2019-07-09 17:06:47', NULL, NULL, 'App\\User', 3),
(783, 727, 17, '2019-07-12 18:34:52', '2019-07-12 21:34:52', NULL, NULL, 'App\\DivisaoOrganograma', 10),
(784, 728, 17, '2019-07-09 16:01:32', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(785, 729, 8, '2019-07-15 18:47:23', '2019-07-15 21:47:23', NULL, NULL, 'App\\User', 13),
(786, 726, 3, '2019-07-09 14:06:59', '2019-07-09 17:06:59', NULL, NULL, 'App\\User', 3),
(787, 726, 3, '2019-07-09 18:14:15', '2019-07-09 21:14:15', NULL, NULL, 'App\\User', 8),
(788, 732, 3, '2019-07-11 17:00:49', '2019-07-11 20:00:49', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(789, 619, 3, '2019-07-09 20:51:35', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(790, 619, 3, '2019-07-09 20:51:44', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(791, 733, 4, '2019-07-16 19:32:55', '2019-07-16 22:32:55', NULL, NULL, 'App\\User', 3),
(792, 734, 4, '2019-07-15 18:47:08', '2019-07-15 21:47:08', NULL, NULL, 'App\\User', 13),
(793, 735, 8, '2019-07-09 19:05:03', '2019-07-09 22:05:03', NULL, NULL, 'App\\User', 8),
(794, 446, 1, '2019-07-09 19:05:30', '2019-07-09 22:05:30', 'Minutar resposta', 'OfÃ­cio nÂº 51970/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(795, 155, 1, '2019-07-09 19:22:31', '2019-07-09 22:22:31', 'Minutar resposta', 'OfÃ­cio nÂº 51984/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(796, 736, 17, '2019-07-10 17:17:10', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(797, 737, 18, '2019-07-10 17:25:28', NULL, 'JÃ¡ respondido, porÃ©m existe ofÃ­cio posterior - 5189/2018 (nÃ£o estÃ¡ abrindo no SEI) sem atendimento.', NULL, 'App\\DivisaoOrganograma', 10),
(798, 737, 18, '2019-07-10 17:28:43', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(799, 737, 18, '2019-07-10 17:29:49', NULL, 'Tem ofÃ­cio posterior, solicitando atendimento, 5189/2018.', NULL, 'App\\DivisaoOrganograma', 10),
(800, 738, 18, '2019-07-10 17:35:55', NULL, 'NÃ£o respondido, com despacho da DIGES a CODES e COCAI sem resposta.', NULL, 'App\\DivisaoOrganograma', 10),
(801, 739, 18, '2019-07-10 17:42:27', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(802, 740, 4, '2019-07-10 19:35:22', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(803, 741, 18, '2019-07-10 20:32:29', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(804, 742, 18, '2019-07-10 20:54:08', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(805, 743, 17, '2019-07-10 21:15:31', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(807, 409, 1, '2019-08-05 19:37:06', '2019-08-05 22:37:06', 'Despacho DIGES-SPU-SC (8838761), com as providÃªncias necessÃ¡rias', NULL, 'App\\User', 5),
(808, 744, 17, '2019-07-10 21:35:29', NULL, 'Resposta OfÃ­cio 83682 (7057972)', NULL, 'App\\DivisaoOrganograma', 10),
(809, 745, 18, '2019-07-10 21:41:45', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 10),
(810, 746, 8, '2019-07-10 21:42:51', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(811, 747, 17, '2019-07-10 21:47:58', NULL, 'NÃ£o Respondida', NULL, 'App\\DivisaoOrganograma', 10),
(812, 748, 4, '2019-07-16 18:56:38', '2019-07-16 21:56:38', NULL, NULL, 'App\\User', 13),
(813, 409, 1, '2019-08-05 21:06:59', '2019-08-06 00:06:59', 'Ver como estÃ¡ a negociaÃ§Ã£o com o MunicÃ­pio', 'Monitoramento serÃ¡ feito pelo NUJUC', 'App\\User', 10),
(814, 749, 4, '2019-07-10 19:22:26', '2019-07-10 22:22:26', NULL, NULL, 'App\\User', 4),
(815, 72, 1, '2019-08-12 18:26:25', NULL, 'Aguardar demoliÃ§Ã£o pela Prefeitura de SÃ£o Francisco e elaborar PRAD em conjunto com aquele municÃ­pio', NULL, 'App\\DivisaoOrganograma', 4),
(816, 211, 1, '2019-08-07 12:44:14', '2019-08-07 15:44:14', NULL, NULL, 'App\\User', 5),
(817, 57, 1, '2019-08-05 17:50:25', '2019-08-05 20:50:25', NULL, 'Demanda reiterado pelo Oficio 1213/2019, mesmo NUP. Acompanhamento se darÃ¡ naquele registro', 'App\\User', 5),
(818, 2, 1, '2019-07-10 23:11:37', NULL, NULL, NULL, 'App\\User', 5),
(819, 645, 8, '2019-07-25 19:26:03', '2019-07-25 22:26:03', NULL, NULL, 'App\\User', 3),
(820, 750, 3, '2019-07-11 17:54:55', '2019-07-11 20:54:55', NULL, NULL, 'App\\User', 13),
(821, 752, 17, '2019-07-11 17:24:49', NULL, 'Ã‰ reiteraÃ§Ã£o do OF. 5887/2014', NULL, 'App\\DivisaoOrganograma', 10),
(822, 754, 4, '2019-07-25 19:18:11', '2019-07-25 22:18:11', NULL, NULL, 'App\\User', 13),
(823, 480, 3, '2019-07-11 18:33:22', '2019-07-11 21:33:22', NULL, NULL, 'App\\User', 3),
(824, 480, 3, '2019-07-11 18:34:16', '2019-07-11 21:34:16', NULL, NULL, 'App\\User', 3),
(825, 714, 8, '2019-07-12 13:40:35', '2019-07-12 16:40:35', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(826, 714, 8, '2019-07-12 16:37:49', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(827, 155, 1, '2019-07-12 16:53:38', NULL, 'Juliano, mantive a demanda aberta para acompanhamento da aÃ§Ã£o de identificaÃ§Ã£o dos imÃ³veis da SÃ£o JosÃ©.', NULL, 'App\\User', 5),
(828, 446, 1, '2019-07-12 17:02:26', NULL, NULL, NULL, 'App\\User', 5),
(829, 756, 3, '2019-07-12 21:26:46', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(830, 756, 3, '2019-07-12 21:26:46', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(831, 759, 4, '2019-07-22 17:14:33', '2019-07-22 20:14:33', NULL, 'Demanda duplicada', 'App\\DivisaoOrganograma', 13),
(832, 760, 4, '2019-07-12 18:50:53', '2019-07-12 21:50:53', NULL, NULL, 'App\\User', 4),
(833, 761, 8, '2019-07-12 19:01:14', '2019-07-12 22:01:14', NULL, NULL, 'App\\User', 8),
(834, 321, 8, '2019-07-29 17:34:02', '2019-07-29 20:34:02', NULL, NULL, 'App\\User', 3),
(835, 762, 8, '2019-07-15 15:26:53', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(836, 763, 8, '2019-07-15 13:08:31', '2019-07-15 16:08:31', NULL, NULL, 'App\\User', 8),
(837, 751, 8, '2019-08-26 12:46:55', '2019-08-26 15:46:55', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(838, 764, 3, '2019-09-02 19:39:57', '2019-08-28 19:41:07', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(839, 765, 4, '2019-07-16 16:21:11', '2019-07-16 19:21:11', NULL, NULL, 'App\\User', 13),
(840, 729, 3, '2019-08-09 14:19:50', '2019-08-09 17:19:50', NULL, NULL, 'App\\User', 3),
(841, 729, 3, '2019-08-09 14:20:05', '2019-08-09 17:20:05', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(842, 766, 4, '2019-07-23 16:24:15', '2019-07-23 19:24:15', NULL, NULL, 'App\\User', 13),
(843, 767, 4, '2019-07-15 22:41:41', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(844, 768, 4, '2019-08-14 18:22:02', '2019-08-14 21:22:02', NULL, NULL, 'App\\User', 3);
INSERT INTO `distribuicaodemanda` (`id`, `idDemanda`, `idUsuarioDe`, `dataDistribuicao`, `dataAtendimento`, `comentarioDistribuicao`, `comentarioAtendimento`, `assignable_type`, `assignable_id`) VALUES
(845, 731, 8, '2019-07-16 16:24:56', '2019-07-16 19:24:56', NULL, NULL, 'App\\User', 8),
(846, 771, 4, '2019-08-09 13:58:51', '2019-08-09 16:58:51', NULL, NULL, 'App\\User', 3),
(847, 770, 4, '2019-07-16 18:18:07', '2019-07-16 21:18:07', NULL, NULL, 'App\\User', 4),
(848, 772, 4, '2019-07-16 18:28:14', '2019-07-16 21:28:14', NULL, NULL, 'App\\User', 5),
(849, 773, 4, '2019-07-16 19:34:18', '2019-07-16 22:34:18', NULL, NULL, 'App\\User', 3),
(850, 774, 4, '2019-07-16 18:57:27', '2019-07-16 21:57:27', NULL, NULL, 'App\\User', 13),
(851, 774, 4, '2019-07-16 21:57:18', NULL, NULL, NULL, 'App\\User', 3),
(852, 775, 4, '2019-08-08 14:21:33', '2019-08-08 17:21:33', NULL, NULL, 'App\\User', 13),
(853, 776, 8, '2019-07-24 14:17:30', '2019-07-24 17:17:30', NULL, NULL, 'App\\User', 13),
(854, 769, 8, '2019-08-30 18:45:06', '2019-08-30 21:45:06', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(855, 777, 4, '2019-08-08 14:15:27', '2019-08-08 17:15:27', NULL, NULL, 'App\\User', 13),
(856, 488, 8, '2019-07-17 20:04:14', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(857, 778, 4, '2019-08-01 18:15:30', '2019-08-01 21:15:30', NULL, NULL, 'App\\User', 13),
(858, 779, 8, '2019-07-17 17:15:30', '2019-07-17 20:15:30', NULL, NULL, 'App\\User', 8),
(859, 684, 1, '2019-07-17 20:28:54', NULL, 'CartÃ³rio de Araqui solicita identificar quais lotes devem ter a matricula anotada com interferÃªncia em terra de marinha', NULL, 'App\\User', 5),
(860, 780, 4, '2019-07-17 20:30:07', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(861, 781, 4, '2019-07-25 16:56:16', '2019-07-25 19:56:16', NULL, NULL, 'App\\User', 13),
(862, 782, 8, '2019-08-13 16:02:09', '2019-08-13 19:02:09', NULL, NULL, 'App\\User', 13),
(863, 783, 4, '2019-07-17 21:56:15', NULL, NULL, NULL, 'App\\User', 5),
(864, 784, 8, '2019-08-06 12:13:29', '2019-08-06 15:13:29', NULL, NULL, 'App\\User', 13),
(865, 785, 3, '2019-09-02 19:39:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(866, 786, 8, '2019-07-18 17:27:35', '2019-07-18 20:27:35', NULL, NULL, 'App\\User', 8),
(867, 696, 1, '2019-07-18 22:43:17', NULL, 'Encaminhado Ã  SPU-SC-NUCIP (incorporaÃ§Ã£o) para atendimento da sentenÃ§a judicial', NULL, 'App\\DivisaoOrganograma', 3),
(868, 787, 4, '2019-08-15 19:19:34', '2019-08-15 22:19:34', NULL, NULL, 'App\\User', 13),
(869, 788, 4, '2019-08-06 13:35:16', '2019-08-06 16:35:16', NULL, NULL, 'App\\User', 13),
(870, 789, 3, '2019-07-25 19:20:28', '2019-07-25 22:20:28', NULL, NULL, 'App\\User', 13),
(871, 653, 8, '2019-07-22 16:43:11', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(872, 790, 4, '2019-08-06 12:08:39', '2019-08-06 15:08:39', NULL, NULL, 'App\\User', 13),
(873, 799, 4, '2019-07-31 16:33:12', '2019-07-31 19:33:12', NULL, NULL, 'App\\User', 13),
(874, 720, 3, '2019-07-22 17:33:04', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(875, 800, 4, '2019-07-25 19:17:21', '2019-07-25 22:17:21', NULL, NULL, 'App\\User', 13),
(876, 802, 3, '2019-07-26 14:18:42', '2019-07-26 17:18:42', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(877, 803, 4, '2019-07-24 12:32:15', '2019-07-24 15:32:15', NULL, NULL, 'App\\User', 3),
(878, 804, 1, '2019-07-24 12:59:43', '2019-07-24 15:59:43', NULL, 'Em reuniÃ£o realizada no dia 23/07/2019, entre o Superintendente (Nabih), a Coordenadora (Tereza Cristina), e os lÃ­deres de nÃºcleo Niarcos (NUJUC) e Camila (NUGES), alÃ©m dos servidores Juliano e Alysson, ficou acordado que serÃ¡ enviado ofÃ­cio ao MPF solicitando mais prazo para avaliaÃ§Ã£o do acordo, uma vez que compete ao SecretÃ¡rio da SPU esse tipo de avaliaÃ§Ã£o.', 'App\\User', 5),
(879, 805, 4, '2019-08-01 12:29:31', '2019-08-01 15:29:31', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(880, 805, 4, '2019-08-01 12:29:41', '2019-08-01 15:29:41', NULL, NULL, 'App\\User', 3),
(881, 806, 8, '2019-08-21 17:24:00', '2019-08-21 20:24:00', NULL, NULL, 'App\\User', 8),
(882, 807, 4, '2019-07-26 17:26:34', '2019-07-26 20:26:34', NULL, NULL, 'App\\User', 8),
(883, 335, 1, '2019-07-23 13:38:21', '2019-07-23 16:38:21', 'Minutar resposta/encaminhamento', 'Encaminhado para DIINC', 'App\\User', 1),
(884, 333, 1, '2019-07-23 13:39:59', '2019-07-23 16:39:59', 'Minutar resposta/encaminhamento', 'encaminhado para DIINC', 'App\\User', 1),
(885, 810, 8, '2019-07-23 16:31:39', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(886, 335, 1, '2019-09-02 19:39:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(887, 333, 1, '2019-09-02 19:39:57', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(888, 814, 4, '2019-07-23 19:02:21', NULL, NULL, NULL, 'App\\User', 13),
(889, 811, 8, '2019-08-05 16:17:55', '2019-08-05 19:17:55', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(890, 820, 4, '2019-07-23 18:28:59', '2019-07-23 21:28:59', NULL, NULL, 'App\\User', 4),
(891, 821, 4, '2019-07-23 22:02:37', NULL, NULL, NULL, 'App\\User', 5),
(892, 803, 3, '2019-08-02 13:13:11', '2019-08-02 16:13:11', NULL, NULL, 'App\\DivisaoOrganograma', 7),
(893, 804, 1, '2019-07-24 21:07:46', '2019-07-25 00:07:46', 'Minutar OfÃ­cio ao MPF', 'Oficio 8828297', 'App\\User', 1),
(894, 804, 1, '2019-07-25 14:42:22', '2019-07-25 17:42:22', 'Minutar OfÃ­cio ao Gabinete da SPU/UC', 'ProvidÃªncia cancelada em virtudade da consulta a ser respondida pelo MPF (detalhes do acordo)', 'App\\User', 1),
(895, 815, 8, '2019-07-25 11:57:34', '2019-07-25 14:57:34', NULL, NULL, 'App\\User', 8),
(896, 822, 3, '2019-07-24 17:20:01', '2019-07-24 20:20:01', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(897, 823, 4, '2019-07-24 19:22:23', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(898, 825, 4, '2019-08-09 13:58:32', '2019-08-09 16:58:32', NULL, NULL, 'App\\User', 13),
(899, 824, 8, '2019-07-25 18:44:08', '2019-07-25 21:44:08', NULL, NULL, 'App\\User', 13),
(900, 827, 4, '2019-08-06 13:29:33', '2019-08-06 16:29:33', NULL, NULL, 'App\\User', 13),
(901, 776, 8, '2019-07-25 15:39:04', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(902, 837, 4, '2019-07-25 16:42:30', '2019-07-25 19:42:30', NULL, NULL, 'App\\User', 4),
(903, 809, 8, '2019-08-08 20:35:08', '2019-08-08 23:35:08', NULL, NULL, 'App\\User', 5),
(904, 818, 8, '2019-08-08 20:34:46', '2019-08-08 23:34:46', NULL, NULL, 'App\\User', 5),
(905, 836, 8, '2019-08-08 20:34:17', '2019-08-08 23:34:17', NULL, NULL, 'App\\User', 5),
(906, 834, 8, '2019-08-08 20:33:41', '2019-08-08 23:33:41', NULL, NULL, 'App\\User', 5),
(907, 835, 8, '2019-08-08 20:34:00', '2019-08-08 23:34:00', NULL, NULL, 'App\\User', 5),
(908, 828, 8, '2019-08-06 12:24:13', '2019-08-06 15:24:13', NULL, NULL, 'App\\User', 13),
(909, 829, 8, '2019-08-08 20:33:23', '2019-08-08 23:33:23', NULL, NULL, 'App\\User', 5),
(910, 830, 8, '2019-08-08 20:33:05', '2019-08-08 23:33:05', NULL, NULL, 'App\\User', 5),
(911, 831, 8, '2019-08-08 20:32:44', '2019-08-08 23:32:44', NULL, NULL, 'App\\User', 5),
(912, 335, 1, '2019-07-25 18:21:02', NULL, 'Aguardando barramento para minutar oficio de resposta (usar o modelo 8830524)', NULL, 'App\\User', 1),
(913, 832, 8, '2019-08-08 20:32:25', '2019-08-08 23:32:25', NULL, NULL, 'App\\User', 5),
(914, 833, 8, '2019-08-08 20:32:00', '2019-08-08 23:32:00', NULL, NULL, 'App\\User', 5),
(915, 817, 8, '2019-08-08 20:35:36', '2019-08-08 23:35:36', NULL, NULL, 'App\\User', 5),
(916, 838, 4, '2019-07-25 20:37:51', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(917, 816, 8, '2019-08-08 19:09:54', '2019-08-08 22:09:54', NULL, NULL, 'App\\User', 5),
(918, 839, 4, '2019-08-07 12:10:38', '2019-08-07 15:10:38', NULL, NULL, 'App\\User', 13),
(919, 826, 8, '2019-07-25 21:04:16', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(920, 840, 4, '2019-08-01 18:18:47', '2019-08-01 21:18:47', NULL, NULL, 'App\\User', 8),
(921, 824, 1, '2019-07-25 19:01:09', '2019-07-25 22:01:09', NULL, 'Encaminhado ao SPU-SC-NUCIP via Despacho SPU-SC-NUJUC 3193580', 'App\\User', 1),
(922, 824, 1, '2019-08-08 13:26:38', '2019-08-08 16:26:38', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(923, 665, 8, '2019-08-14 19:59:12', '2019-08-14 22:59:12', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(924, 819, 3, '2019-07-25 19:21:48', '2019-07-25 22:21:48', NULL, NULL, 'App\\User', 3),
(925, 841, 8, '2019-08-12 14:23:58', '2019-08-12 17:23:58', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(926, 842, 8, '2019-08-21 18:42:09', '2019-08-21 21:42:09', NULL, NULL, 'App\\User', 13),
(927, 843, 8, '2019-08-21 17:09:00', '2019-08-21 20:09:00', NULL, NULL, 'App\\User', 13),
(928, 807, 8, '2019-08-08 18:30:13', '2019-08-08 21:30:13', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(929, 813, 8, '2019-08-05 19:16:16', '2019-08-05 22:16:16', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(930, 844, 4, '2019-09-02 19:45:26', '2019-07-29 17:10:26', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(931, 845, 4, '2019-08-06 16:35:12', '2019-08-06 19:35:12', NULL, NULL, 'App\\User', 13),
(932, 846, 4, '2019-07-29 20:21:45', NULL, NULL, NULL, 'App\\User', 5),
(933, 847, 4, '2019-08-09 13:59:52', '2019-08-09 16:59:52', NULL, NULL, 'App\\User', 3),
(934, 848, 4, '2019-08-07 13:01:53', '2019-08-07 16:01:53', NULL, NULL, 'App\\User', 13),
(935, 849, 4, '2019-09-04 12:26:59', '2019-09-04 15:26:59', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(936, 850, 3, '2019-07-29 21:31:39', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(937, 851, 4, '2019-08-08 20:37:10', '2019-08-08 23:37:10', NULL, NULL, 'App\\User', 5),
(938, 852, 4, '2019-08-15 18:40:39', '2019-08-15 21:40:39', NULL, NULL, 'App\\User', 13),
(939, 853, 8, '2019-07-30 12:37:05', '2019-07-30 15:37:05', NULL, NULL, 'App\\User', 8),
(940, 854, 8, '2019-09-02 14:04:04', '2019-09-02 17:04:04', NULL, NULL, 'App\\User', 13),
(941, 855, 8, '2019-07-30 16:15:59', NULL, NULL, NULL, 'App\\User', 13),
(942, 856, 4, '2019-08-07 12:46:36', '2019-08-07 15:46:36', NULL, NULL, 'App\\User', 13),
(943, 701, 1, '2019-08-22 18:25:37', '2019-08-22 21:25:37', 'Aguardando resposta consulta CJU-SC (OFÃCIO SEI NÂº 46/2019/NUJUC/SPU-SC/SPU/SEDDM-ME)', NULL, 'App\\User', 1),
(944, 857, 4, '2019-08-15 18:32:22', '2019-08-15 21:32:22', NULL, NULL, 'App\\User', 13),
(945, 858, 4, '2019-08-09 14:02:07', '2019-08-09 17:02:07', NULL, NULL, 'App\\User', 3),
(946, 675, 1, '2019-07-30 18:16:47', '2019-07-30 21:16:47', 'Minutar resposta', 'OfÃ­cio nÂº 53770/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(947, 860, 3, '2019-08-01 18:22:39', '2019-08-01 21:22:39', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(948, 862, 4, '2019-08-07 14:37:30', '2019-08-07 17:37:30', NULL, NULL, 'App\\User', 13),
(949, 863, 4, '2019-08-13 16:27:31', '2019-08-13 19:27:31', NULL, NULL, 'App\\User', 13),
(950, 864, 4, '2019-08-14 14:11:14', '2019-08-14 17:11:14', NULL, NULL, 'App\\User', 13),
(951, 865, 3, '2019-08-05 19:40:23', '2019-08-05 22:40:23', 'Elaborado o Despacho DIGES-SPU-SC (8838475) com os encaminhamentos.', NULL, 'App\\User', 5),
(952, 866, 4, '2019-07-31 19:34:34', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(953, 867, 4, '2019-08-07 13:45:54', '2019-08-07 16:45:54', NULL, NULL, 'App\\DivisaoOrganograma', 9),
(954, 868, 4, '2019-08-08 16:58:55', '2019-08-08 19:58:55', NULL, NULL, 'App\\User', 5),
(955, 869, 4, '2019-08-08 16:50:13', '2019-08-08 19:50:13', NULL, NULL, 'App\\User', 13),
(956, 870, 4, '2019-07-31 21:12:51', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(957, 871, 4, '2019-08-14 12:34:36', '2019-08-14 15:34:36', NULL, NULL, 'App\\User', 13),
(958, 872, 4, '2019-08-13 15:55:20', '2019-08-13 18:55:20', NULL, NULL, 'App\\User', 13),
(959, 873, 4, '2019-08-26 12:54:03', '2019-08-26 15:54:03', NULL, 'OfÃ­cio nÂº 55856/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 13),
(960, 878, 4, '2019-08-26 12:47:28', '2019-08-26 15:47:28', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(961, 879, 4, '2019-08-01 19:13:47', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(962, 880, 4, '2019-08-20 17:01:02', '2019-08-20 20:01:02', NULL, NULL, 'App\\User', 13),
(963, 881, 4, '2019-08-01 17:29:49', '2019-08-01 20:29:49', NULL, NULL, 'App\\User', 4),
(964, 755, 4, '2019-09-02 19:39:57', '2019-08-28 19:40:21', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(965, 882, 4, '2019-09-02 19:39:57', '2019-08-28 19:41:34', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(966, 72, 3, '2019-08-05 19:48:35', '2019-08-05 22:48:35', 'Elaborado o Despacho DIGES-SPU-SC (8840890) com instruÃ§Ãµes para o encaminhamento', NULL, 'App\\User', 5),
(967, 883, 3, '2019-08-02 15:45:38', NULL, NULL, NULL, 'App\\User', 5),
(968, 885, 8, '2019-08-02 16:05:35', NULL, NULL, NULL, 'App\\User', 3),
(969, 886, 3, '2019-08-02 19:41:16', NULL, NULL, NULL, 'App\\User', 5),
(970, 753, 3, '2019-08-15 19:13:09', '2019-08-15 22:13:09', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(971, 888, 4, '2019-08-05 19:34:00', NULL, NULL, NULL, 'App\\User', 5),
(972, 889, 4, '2019-08-21 19:02:29', '2019-08-21 22:02:29', NULL, NULL, 'App\\User', 13),
(973, 890, 4, '2019-08-07 12:45:40', '2019-08-07 15:45:40', NULL, NULL, 'App\\User', 13),
(974, 891, 4, '2019-08-05 20:26:35', '2019-08-05 23:26:35', NULL, NULL, 'App\\User', 4),
(975, 409, 5, '2019-08-05 21:06:36', '2019-08-06 00:06:36', 'Para elaborar OfÃ­cio ao municÃ­pio, nos termos do Despacho DIGES-SPU-SC (8838761).', 'OfÃ­cio nÂº 54267/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(976, 865, 5, '2019-08-07 19:12:17', '2019-08-07 22:12:17', 'Elaborar OfÃ­cio nos termos do Despacho DIGES-SPU-SC (8838475) e falar com  o Gabinente sobre o contato com o MunicÃ­pio.', 'Prefeitura -> OfÃ­cio nÂº 54320/2019/DIGES-SPU-SC/MP\r\nAGU -> OfÃ­cio nÂº 54483/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(977, 72, 5, '2019-08-12 18:25:06', '2019-08-12 21:25:06', 'Elaborar OfÃ­cio conforme Despacho DIGES-SPU-SC (8840890). Verificar com Gabinete a cobranÃ§a ao MunicÃ­pio.', 'OfÃ­cio nÂº 54557/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(978, 409, 1, '2019-08-06 00:10:08', NULL, 'Monitorar resposta da Prefeitura de Bombinhas para oficiar o AGU', NULL, 'App\\DivisaoOrganograma', 14),
(979, 611, 3, '2019-08-06 12:46:31', '2019-08-06 15:46:31', NULL, NULL, 'App\\User', 3),
(980, 892, 8, '2019-08-08 13:27:04', '2019-08-08 16:27:04', NULL, NULL, 'App\\User', 13),
(981, 893, 3, '2019-08-06 20:27:21', NULL, NULL, NULL, 'App\\User', 8),
(982, 894, 4, '2019-08-21 12:37:15', '2019-08-21 15:37:15', NULL, NULL, 'App\\User', 13),
(983, 808, 3, '2019-08-06 19:30:09', '2019-08-06 22:30:09', NULL, NULL, 'App\\User', 3),
(984, 801, 3, '2019-08-06 19:34:58', '2019-08-06 22:34:58', NULL, NULL, 'App\\User', 3),
(985, 862, 3, '2019-08-13 17:54:50', '2019-08-13 20:54:50', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(986, 898, 4, '2019-08-16 12:34:03', '2019-08-16 15:34:03', NULL, NULL, 'App\\User', 13),
(987, 899, 8, '2019-08-07 20:09:42', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(988, 900, 4, '2019-08-16 12:22:29', '2019-08-16 15:22:29', NULL, NULL, 'App\\User', 8),
(989, 901, 4, '2019-08-21 18:37:48', '2019-08-21 21:37:48', NULL, NULL, 'App\\User', 13),
(990, 895, 8, '2019-09-03 13:09:34', '2019-09-03 16:09:34', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(991, 902, 4, '2019-08-21 16:18:45', '2019-08-21 19:18:45', NULL, NULL, 'App\\User', 13),
(992, 865, 1, '2019-08-19 13:53:24', '2019-08-19 16:53:24', 'Aguardando resultado da vistoria informada em OfÃ­cio nÂº 54483/2019/DIGES-SPU-SC/MP', 'RelatÃ³rio de FiscalizaÃ§Ã£o Individual NÂº    059/2019', 'App\\DivisaoOrganograma', 9),
(993, 903, 4, '2019-08-08 18:11:48', '2019-08-08 21:11:48', NULL, NULL, 'App\\User', 13),
(994, 887, 8, '2019-08-22 13:01:27', '2019-08-22 16:01:27', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(995, 904, 4, '2019-08-09 14:32:20', '2019-08-09 17:32:20', NULL, NULL, 'App\\User', 3),
(996, 904, 8, '2019-08-14 14:10:27', '2019-08-14 17:10:27', NULL, NULL, 'App\\DivisaoOrganograma', 1),
(997, 72, 1, '2019-08-12 18:25:47', '2019-08-12 21:25:47', 'Minutar OfÃ­cio Ã  AGU/Blumenau', NULL, 'App\\User', 1),
(998, 710, 8, '2019-08-08 20:25:44', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(999, 527, 1, '2019-08-08 20:26:49', NULL, 'Terminar Despacho DIIUP-SPU-SC 6965921', NULL, 'App\\DivisaoOrganograma', 9),
(1000, 907, 4, '2019-08-08 18:42:44', '2019-08-08 21:42:44', NULL, NULL, 'App\\User', 4),
(1001, 908, 4, '2019-08-12 14:33:03', '2019-08-12 17:33:03', NULL, NULL, 'App\\User', 13),
(1002, 771, 3, '2019-08-09 16:59:03', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1003, 847, 3, '2019-08-09 16:59:44', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1004, 652, 3, '2019-08-09 17:01:09', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 2),
(1005, 858, 3, '2019-08-14 14:03:49', '2019-08-14 17:03:49', NULL, NULL, 'App\\DivisaoOrganograma', 1),
(1006, 909, 8, '2019-08-30 16:35:14', '2019-08-30 19:35:14', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1007, 910, 4, '2019-08-12 14:32:48', '2019-08-12 17:32:48', NULL, NULL, 'App\\User', 13),
(1008, 911, 4, '2019-08-21 18:50:22', '2019-08-21 21:50:22', NULL, NULL, 'App\\User', 13),
(1009, 912, 4, '2019-08-09 16:45:56', '2019-08-09 19:45:56', NULL, NULL, 'App\\User', 4),
(1010, 485, 3, '2019-08-14 13:41:33', '2019-08-14 16:41:33', NULL, NULL, 'App\\User', 5),
(1011, 914, 8, '2019-08-12 14:10:13', '2019-08-12 17:10:13', NULL, NULL, 'App\\User', 13),
(1012, 915, 4, '2019-08-12 17:16:33', NULL, NULL, NULL, 'App\\User', 3),
(1013, 916, 4, '2019-08-12 16:43:34', '2019-08-12 19:43:34', NULL, NULL, 'App\\User', 16),
(1014, 917, 4, '2019-08-12 16:58:59', '2019-08-12 19:58:59', NULL, NULL, 'App\\User', 4),
(1015, 918, 4, '2019-08-12 17:04:20', '2019-08-12 20:04:20', NULL, NULL, 'App\\User', 4),
(1016, 919, 4, '2019-08-12 17:08:20', '2019-08-12 20:08:20', NULL, NULL, 'App\\User', 4),
(1017, 920, 4, '2019-09-04 14:17:35', '2019-09-04 17:17:35', NULL, NULL, 'App\\User', 13),
(1018, 921, 4, '2019-08-23 17:30:25', '2019-08-23 20:30:25', NULL, NULL, 'App\\User', 13),
(1019, 922, 4, '2019-08-15 13:22:56', '2019-08-15 16:22:56', NULL, NULL, 'App\\User', 3),
(1020, 736, 3, '2019-08-13 19:24:43', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(1021, 730, 4, '2019-08-13 17:00:25', '2019-08-13 20:00:25', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1022, 923, 4, '2019-08-19 12:39:24', '2019-08-19 15:39:24', NULL, NULL, 'App\\User', 13),
(1023, 924, 3, '2019-08-20 12:45:05', '2019-08-20 15:45:05', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1024, 211, 1, '2019-08-14 16:09:17', NULL, 'Contratar demoliÃ§Ã£o', NULL, 'App\\DivisaoOrganograma', 2),
(1025, 864, 3, '2019-08-30 19:38:33', '2019-08-30 22:38:33', NULL, NULL, 'App\\User', 5),
(1026, 905, 3, '2019-08-28 11:53:08', '2019-08-28 14:53:08', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1027, 466, 3, '2019-08-14 20:51:38', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1028, 926, 8, '2019-08-21 17:00:17', '2019-08-21 20:00:17', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(1029, 927, 4, '2019-08-20 17:35:19', '2019-08-20 20:35:19', NULL, NULL, 'App\\User', 13),
(1030, 928, 4, '2019-08-15 20:26:00', NULL, NULL, NULL, 'App\\User', 13),
(1031, 929, 4, '2019-08-15 18:31:29', '2019-08-15 21:31:29', NULL, NULL, 'App\\User', 4),
(1032, 930, 4, '2019-08-19 15:59:07', NULL, NULL, NULL, 'App\\User', 13),
(1033, 931, 4, '2019-08-19 16:36:30', NULL, NULL, NULL, 'App\\User', 5),
(1034, 932, 4, '2019-08-19 16:53:36', NULL, NULL, NULL, 'App\\User', 3),
(1035, 865, 1, '2019-08-19 16:53:41', NULL, 'Contratar demoliÃ§Ã£o', NULL, 'App\\DivisaoOrganograma', 2),
(1036, 933, 4, '2019-08-19 17:29:37', NULL, NULL, NULL, 'App\\User', 5),
(1037, 934, 4, '2019-08-19 19:40:51', NULL, NULL, NULL, 'App\\User', 5),
(1038, 936, 4, '2019-08-19 20:21:41', NULL, NULL, NULL, 'App\\User', 5),
(1039, 937, 4, '2019-08-19 20:47:16', NULL, NULL, NULL, 'App\\User', 13),
(1040, 938, 4, '2019-08-23 13:17:12', '2019-08-23 16:17:12', NULL, NULL, 'App\\User', 3),
(1041, 935, 8, '2019-08-23 13:57:24', '2019-08-23 16:57:24', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1042, 939, 4, '2019-09-04 14:01:52', '2019-09-04 17:01:52', NULL, NULL, 'App\\User', 13),
(1043, 940, 4, '2019-09-04 14:19:33', '2019-09-04 17:19:33', NULL, NULL, 'App\\User', 13),
(1044, 861, 8, '2019-08-20 14:01:25', '2019-08-20 17:01:25', NULL, NULL, 'App\\User', 8),
(1045, 941, 4, '2019-09-04 14:01:27', '2019-09-04 17:01:27', NULL, NULL, 'App\\User', 13),
(1046, 942, 4, '2019-08-20 17:05:44', '2019-08-20 20:05:44', NULL, NULL, 'App\\User', 4),
(1047, 943, 4, '2019-08-20 17:17:18', '2019-08-20 20:17:18', NULL, NULL, 'App\\User', 4),
(1048, 944, 4, '2019-08-20 21:07:46', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1049, 932, 3, '2019-08-20 21:55:46', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 1),
(1050, 945, 8, '2019-08-21 12:59:06', '2019-08-21 15:59:06', NULL, NULL, 'App\\User', 8),
(1051, 946, 8, '2019-08-21 20:01:11', NULL, NULL, NULL, 'App\\User', 13),
(1052, 947, 4, '2019-09-04 14:02:54', '2019-09-04 17:02:54', NULL, NULL, 'App\\User', 13),
(1053, 948, 4, '2019-09-04 12:00:09', '2019-09-04 15:00:09', NULL, NULL, 'App\\User', 13),
(1054, 949, 4, '2019-08-29 17:49:22', '2019-08-29 20:49:22', NULL, NULL, 'App\\DivisaoOrganograma', 7),
(1055, 950, 4, '2019-08-22 16:53:55', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(1056, 952, 4, '2019-08-22 20:11:08', NULL, NULL, NULL, 'App\\User', 13),
(1057, 951, 3, '2019-08-22 20:12:59', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(1058, 953, 4, '2019-08-22 20:40:00', NULL, NULL, NULL, 'App\\User', 3),
(1059, 701, 1, '2019-08-22 21:25:54', NULL, 'Definir valores e datas para alteraÃ§Ã£o dos valores', NULL, 'App\\DivisaoOrganograma', 3),
(1060, 954, 4, '2019-08-29 13:47:02', '2019-08-29 16:47:02', NULL, NULL, 'App\\User', 8),
(1061, 938, 3, '2019-08-23 13:19:28', '2019-08-23 16:19:28', NULL, NULL, 'App\\DivisaoOrganograma', 1),
(1062, 535, 3, '2019-08-23 18:49:20', '2019-08-23 21:49:20', NULL, NULL, 'App\\User', 5),
(1063, 955, 4, '2019-08-23 20:51:04', NULL, NULL, NULL, 'App\\User', 5),
(1064, 956, 4, '2019-08-23 18:07:43', '2019-08-23 21:07:43', NULL, NULL, 'App\\User', 4),
(1065, 957, 8, '2019-08-23 21:41:31', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1066, 959, 8, '2019-08-26 13:54:47', '2019-08-26 16:54:47', NULL, NULL, 'App\\DivisaoOrganograma', 7),
(1067, 960, 4, '2019-08-26 19:15:58', NULL, NULL, NULL, 'App\\User', 5),
(1068, 962, 4, '2019-08-26 20:26:06', NULL, NULL, NULL, 'App\\User', 5),
(1069, 963, 4, '2019-08-26 20:44:21', NULL, NULL, NULL, 'App\\User', 5),
(1070, 964, 4, '2019-08-26 21:28:27', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1071, 965, 4, '2019-08-26 22:07:58', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(1072, 896, 8, '2019-08-27 12:09:14', '2019-08-27 15:09:14', NULL, NULL, 'App\\User', 13),
(1073, 961, 8, '2019-08-27 15:34:20', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1074, 966, 4, '2019-08-27 13:12:24', '2019-08-27 16:12:24', NULL, NULL, 'App\\User', 13),
(1075, 966, 4, '2019-08-27 16:12:13', NULL, NULL, NULL, 'App\\User', 5),
(1076, 967, 4, '2019-08-27 16:25:45', NULL, NULL, NULL, 'App\\User', 13),
(1077, 968, 4, '2019-08-27 14:07:19', '2019-08-27 17:07:19', NULL, NULL, 'App\\User', 4),
(1078, 970, 4, '2019-08-27 19:46:45', NULL, NULL, NULL, 'App\\User', 13),
(1079, 971, 3, '2019-09-04 18:22:46', '2019-09-04 21:22:46', NULL, NULL, 'App\\User', 8),
(1080, 972, 4, '2019-08-27 20:13:19', NULL, NULL, NULL, 'App\\User', 5),
(1081, 974, 8, '2019-08-27 22:20:10', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(1082, 976, 4, '2019-08-28 19:24:43', NULL, NULL, NULL, 'App\\User', 13),
(1083, 979, 4, '2019-09-04 16:29:55', '2019-09-04 19:29:55', NULL, NULL, 'App\\User', 13),
(1084, 978, 3, '2019-09-02 14:25:21', '2019-09-02 17:25:21', NULL, NULL, 'App\\User', 5),
(1085, 981, 4, '2019-08-28 21:21:26', NULL, NULL, NULL, 'App\\User', 3),
(1086, 982, 3, '2019-08-29 15:45:55', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1087, 983, 8, '2019-08-29 16:19:45', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(1088, 984, 4, '2019-08-29 19:08:02', NULL, NULL, NULL, 'App\\User', 13),
(1089, 538, 3, '2019-08-29 19:15:33', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(1090, 985, 4, '2019-08-29 19:17:39', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(1091, 986, 4, '2019-08-29 19:40:11', NULL, NULL, NULL, 'App\\User', 13),
(1092, 987, 4, '2019-08-29 17:01:09', '2019-08-29 20:01:09', NULL, NULL, 'App\\DivisaoOrganograma', 14),
(1093, 988, 4, '2019-08-29 17:07:54', '2019-08-29 20:07:54', NULL, NULL, 'App\\DivisaoOrganograma', 14),
(1094, 989, 4, '2019-08-29 20:31:59', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(1095, 990, 4, '2019-08-29 17:51:21', '2019-08-29 20:51:21', NULL, NULL, 'App\\DivisaoOrganograma', 14),
(1096, 991, 4, '2019-08-29 17:58:55', '2019-08-29 20:58:55', NULL, NULL, 'App\\DivisaoOrganograma', 14),
(1097, 992, 4, '2019-09-02 19:45:26', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(1098, 993, 4, '2019-08-29 22:17:40', NULL, NULL, NULL, 'App\\User', 13),
(1099, 994, 4, '2019-08-29 19:28:36', '2019-08-29 22:28:36', NULL, NULL, 'App\\DivisaoOrganograma', 14),
(1100, 995, 3, '2019-08-30 15:37:14', NULL, NULL, NULL, 'App\\User', 5),
(1101, 421, 1, '2019-08-30 14:43:46', '2019-08-30 17:43:46', 'Minutar resposta', 'OFÃCIO SEI NÂº 107/2019/NUJUC/SPU-SC/SPU/SEDDM-ME', 'App\\User', 1),
(1102, 996, 8, '2019-08-30 16:48:49', '2019-08-30 19:48:49', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1103, 996, 8, '2019-08-30 19:48:55', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 1),
(1104, 997, 4, '2019-08-30 20:16:57', NULL, NULL, NULL, 'App\\User', 13),
(1105, 999, 4, '2019-08-30 21:18:13', NULL, NULL, NULL, 'App\\User', 8),
(1106, 1000, 4, '2019-08-30 21:33:43', NULL, NULL, NULL, 'App\\User', 13),
(1107, 897, 8, '2019-09-02 13:50:26', '2019-09-02 16:50:26', NULL, NULL, 'App\\User', 13),
(1108, 1001, 23, '2019-09-02 17:23:46', NULL, 'dar imediato cumprimento quanto Ã  suspensÃ£o da cobranÃ§a dos dÃ©bitos, bem como prestar as informaÃ§Ãµes para a defesa da UniÃ£o', NULL, 'App\\DivisaoOrganograma', 6),
(1109, 1002, 3, '2019-09-02 20:10:49', NULL, NULL, NULL, 'App\\User', 5),
(1110, 1003, 4, '2019-09-02 21:49:09', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(1111, 1004, 3, '2019-09-02 19:34:10', '2019-09-02 22:34:10', NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1112, 1004, 3, '2019-09-02 22:34:27', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 15),
(1113, 1005, 4, '2019-09-02 22:51:11', NULL, NULL, NULL, 'App\\User', 13),
(1114, 1006, 3, '2019-09-03 15:31:06', NULL, NULL, NULL, 'App\\User', 5),
(1115, 1007, 8, '2019-09-03 15:53:02', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1116, 998, 8, '2019-09-03 15:55:15', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1117, 621, 1, '2019-09-03 18:41:37', '2019-09-03 21:41:37', 'Minutar despacho para Superintendente e Coordenadora, para conhecimento, e NUPRIV, para providÃªncias.', 'Despacho SPU-SC-NUJUC 3820687', 'App\\User', 1),
(1118, 977, 4, '2019-09-03 17:22:45', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1119, 1008, 3, '2019-09-03 19:45:23', NULL, NULL, NULL, 'App\\User', 5),
(1120, 1009, 4, '2019-09-03 19:58:11', NULL, NULL, NULL, 'App\\User', 13),
(1121, 1010, 4, '2019-09-03 20:07:44', NULL, NULL, NULL, 'App\\User', 13),
(1122, 1011, 8, '2019-09-03 20:15:11', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1123, 457, 1, '2019-09-03 20:39:39', NULL, 'Encaminhar para NUREF', NULL, 'App\\User', 1),
(1124, 1012, 4, '2019-09-03 20:42:32', NULL, NULL, NULL, 'App\\User', 8),
(1125, 550, 1, '2019-09-03 18:25:12', '2019-09-03 21:25:12', NULL, 'Despacho SPU-SC-NUJUC 3819591', 'App\\User', 1),
(1126, 1013, 4, '2019-09-03 21:01:51', NULL, NULL, NULL, 'App\\User', 10),
(1127, 550, 1, '2019-09-03 21:25:34', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 9),
(1128, 1014, 4, '2019-09-04 18:43:06', '2019-09-04 21:43:06', NULL, NULL, 'App\\User', 13),
(1129, 925, 1, '2019-09-03 21:47:35', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 2),
(1130, 1015, 3, '2019-09-03 21:52:31', NULL, NULL, NULL, 'App\\User', 5),
(1131, 980, 23, '2019-09-03 20:32:41', '2019-09-03 23:32:41', NULL, 'OfÃ­cio nÂº 56640/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(1132, 969, 8, '2019-09-04 16:24:50', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 1),
(1133, 1016, 4, '2019-09-04 20:22:08', NULL, NULL, NULL, 'App\\User', 13),
(1134, 1017, 8, '2019-09-04 21:03:41', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 13),
(1135, 957, 23, '2019-09-04 21:03:48', NULL, 'Despacho NUREP 3777546', NULL, 'App\\User', 8),
(1136, 1018, 23, '2019-09-04 21:44:33', NULL, NULL, NULL, 'App\\User', 13),
(1137, 1019, 3, '2019-09-04 22:07:34', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3);

--
-- Acionadores `distribuicaodemanda`
--
DELIMITER $$
CREATE TRIGGER `tg_distribuicaodemanda_after_insert` AFTER INSERT ON `distribuicaodemanda` FOR EACH ROW BEGIN
        CALL proc_distribuicaodemanda_atualiza_situacao(NEW.idDemanda);
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tg_distribuicaodemanda_after_update` AFTER UPDATE ON `distribuicaodemanda` FOR EACH ROW BEGIN
        CALL proc_distribuicaodemanda_atualiza_situacao(NEW.idDemanda);
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `divisaoorganograma`
--

CREATE TABLE `divisaoorganograma` (
  `id` int(10) UNSIGNED NOT NULL,
  `idDivisaoOrganogramaPai` int(10) UNSIGNED DEFAULT NULL,
  `nome` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sigla` char(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `divisaoorganograma`
--

INSERT INTO `divisaoorganograma` (`id`, `idDivisaoOrganogramaPai`, `nome`, `sigla`, `created_at`, `updated_at`) VALUES
(1, NULL, 'SuperintendÃªncia do PatrimÃ´nio da UniÃ£o em Santa Catarina', 'SPU-SC', NULL, NULL),
(2, 1, 'NÃºcleo de GestÃ£o EstratÃ©gica e Recursos Internos', 'SPU-SC-NUGES', NULL, NULL),
(3, 1, 'NÃºcleo de CaracterizaÃ§Ã£o e IncorporaÃ§Ã£o', 'SPU-SC-NUCIP', NULL, NULL),
(4, 1, 'NÃºcleo de DestinaÃ§Ã£o Patrimonial', 'SPU-SC-NUDEP', NULL, NULL),
(6, 1, 'NÃºcleo de Receitas Patrimoniais', 'SPU-SC-NUREP', NULL, NULL),
(7, 4, 'NÃºcleo de RegularizaÃ§Ã£o FundiÃ¡ria e HabitaÃ§Ã£o', 'SPU-SC-NUREF', NULL, NULL),
(8, 3, 'DivisÃ£o de IdentificaÃ§Ã£o e Controle de UtilizaÃ§Ã£o do PatrimÃ´nia', 'DIIUP-SPU-SC', NULL, NULL),
(9, 1, 'NÃºcleo de FiscalizaÃ§Ã£o', 'SPU-SC-NUFIS', NULL, NULL),
(10, 2, 'Demanda Reprimida', 'Reprimida', NULL, NULL),
(11, 1, 'NÃºcleo Regional de GeoinformaÃ§Ã£o', 'SPU-SC-NUGEO', NULL, NULL),
(12, 1, 'NÃºcleo de UsucapiÃ£o e CertidÃ£o Dominial', 'SPU-SC-NUSUC', NULL, NULL),
(13, 1, 'CoordenaÃ§Ã£o SPU-SC', 'SPU-SC-COORD', NULL, NULL),
(14, 1, 'NÃºcleo de Demandas Judiciais e de Controle', 'SPU-SC-NUJUC', NULL, NULL),
(15, 13, 'NÃºcleo de RegularizaÃ§Ã£o para Fins Privados', 'SPU-SC-NUPRIV', NULL, NULL),
(16, 13, 'NÃºcleo de DemarcaÃ§Ã£o', 'SPU-SC-NUDEM', NULL, NULL),
(17, NULL, 'NÃºcleo de IncorporaÃ§Ã£o', 'SPU-SC-NUINC', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `geo_camada`
--

CREATE TABLE `geo_camada` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rotulo` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tabelaReferencia` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `colunaIdReferencia` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `colunaTituloReferencia` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `colunaSubTituloReferencia` char(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `geo_camada`
--

INSERT INTO `geo_camada` (`id`, `titulo`, `rotulo`, `tabelaReferencia`, `colunaIdReferencia`, `colunaTituloReferencia`, `colunaSubTituloReferencia`) VALUES
(1, 'Procedimentos Externos (NUJUC)', 'Procedimento Externo:', 'procedimentoexterno', 'id', 'procedimento', 'resumo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `geo_referencia`
--

CREATE TABLE `geo_referencia` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idCamada` bigint(20) UNSIGNED NOT NULL,
  `idReferenciado` bigint(20) UNSIGNED NOT NULL,
  `poligonais` multipolygon NOT NULL,
  `idUsuarioCriacao` int(10) UNSIGNED NOT NULL,
  `idUsuarioAlteracao` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `geo_referencia`
--

INSERT INTO `geo_referencia` (`id`, `idCamada`, `idReferenciado`, `poligonais`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`) VALUES
(1, 1, 62, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0~\0\0/¯»ZÊ;ÀÃ»¬½ð@HÀà»ôÞÊ;À\'—²ÿ@HÀˆ3VYÊ;ÀV7ÿ@HÀ`–»Ê;ÀFKPsÿ@HÀœ \'Ê;À´¯ÿ@HÀHDŠvÊ;ÀSÀãÿ@HÀ~78ËÊ;ÀI••\0AHÀŸá»Ê;À°·‹>\0AHÀ£‡+qÊ;À\\s5h\0AHÀÍqÂÊ;À«VŒ\0AHÀýã\'Ê;Àáæ°¨\0AHÀ[±ô*Ê;À¶ƒŸ¸\0AHÀŸ®W;Ê;À_e®\0AHÀ,—J\rÊ;À¡Ð<\0AHÀ²)·\\Ê;ÀA\nFZ\0AHÀ–!yÊ;ÀèU]\0AHÀ¦Ñ°¾\nÊ;ÀÑM´Øÿ@HÀªÑò\nÊ;Àè§Y”ÿ@HÀôÜf	Ê;À›²Nÿ@HÀÉg½Ê;ÀZ\"\nÿ@HÀwàˆ\rÊ;À\neÉþ@HÀyÕliÊ;À÷ëƒþ@HÀQãiÆÊ;Àl”³Vþ@HÀxsG Ê;ÀV×F þ@HÀMîÌrÊ;À‡,çíý@HÀ/¼Á¹Ê;ÀD>Áý@HÀŠSÜÊ;ÀŽ‡œý@HÀ= —ýÊ;ÀÅÙ‡ý@HÀl¤½Ê;Àæªný@HÀ`Ã?Ê;Àdÿƒ}ý@HÀPÖñ`\0Ê;À?ôÔ|ý@HÀÆ±ÿÉ;À	Vlwý@HÀïƒ4›þÉ;ÀªdTqý@HÀ^G¸ýÉ;ÀdLtý@HÀxŸ·ÛüÉ;À.\nŠý@HÀ”R\nüÉ;ÀJ`e¼ý@HÀ=·[ûÉ;À–à©ùý@HÀ0´úÉ;À×­ã7þ@HÀYK¦úÉ;ÀÃ‚vþ@HÀ´PBpùÉ;Àl.µþ@HÀî‹1ÌøÉ;À-+:óþ@HÀÆï-øÉ;À)^Û-ÿ@HÀ>Å÷É;À\'¤lhÿ@HÀÄ@GðöÉ;Àâã¢ÿ@HÀ¬•QöÉ;Àü6Ýÿ@HÀ}ùC±õÉ;À%Ø[\0AHÀèãeõÉ;À¤!N\0AHÀ»2HUôÉ;ÀŸá1}\0AHÀ«‹ëœóÉ;À‰<1¤\0AHÀm”PàòÉ;À_W~Ä\0AHÀ…ðw!òÉ;À“V	ß\0AHÀ#•—RñÉ;À5…sô\0AHÀ—æ€ðÉ;ÀeîË\0AHÀsñ¢¬ïÉ;ÀtAHÀå½²ÚîÉ;À×ö\nú\0AHÀgWáîÉ;ÀOYÓä\0AHÀ;rGíÉ;ÀôŠ5É\0AHÀ2‚ìÉ;À¤•|¬\0AHÀŒlâ½ëÉ;À×áŽ\0AHÀ÷ÈjùêÉ;ÀÅ­žp\0AHÀJ²î4êÉ;À©xìQ\0AHÀiO£‚éÉ;ÀÝ‚5\0AHÀmLçÐèÉ;ÀëôT\0AHÀzµèÉ;À¢8qúÿ@HÀ€øoçÉ;ÀEãÛÿ@HÀˆn×¾æÉ;À¤Ñ¶¼ÿ@HÀQµ;þåÉ;ÀQÊ÷ÿ@HÀáC\\åÉ;Àêoè#ÿ@HÀDaWÅäÉ;À,-¾¼þ@HÀ¤â%äÉ;À|n®^þ@HÀ(ÁNjãÉ;À–žîþ@HÀPSä–âÉ;ÀXýüý@HÀÝ¶áÉ;ÀúnKîý@HÀçÓàÉ;À^ºñý@HÀÃxôßÉ;ÀÁ@+þ@HÀ\'Ú#ßÉ;À‘Ë€.þ@HÀˆÉ(^ÞÉ;ÀÒNUcþ@HÀ ÄØ›ÝÉ;À*Þöþ@HÀR,-ÚÜÉ;Àœ©†Úþ@HÀO1iÜÉ;Àà%ÿ@HÀ.ÐMÛÉ;À±õIÿ@HÀ5‹‹ÚÉ;À-ÞÃyÿ@HÀqîËÈÙÉ;À+C·©ÿ@HÀF±ÙÉ;À>æ¾Õÿ@HÀ[üÏ;ØÉ;À’ÌÉùÿ@HÀØRŒn×É;ÀÞûÆ\0AHÀÅÎc‰ÖÉ;À6zý\0AHÀý4«¢ÕÉ;ÀŒ- \0AHÀ$9»ÔÉ;ÀOÌ\Z\0AHÀÊ;äÓÓÉ;Àaà\0AHÀÃƒíÒÉ;À\0AHÀžì@ÒÉ;ÀÔ“èøÿ@HÀT\"!ÑÉ;À\ràÓëÿ@HÀD$G;ÐÉ;À^Ê8Ýÿ@HÀ /ÏUÏÉ;À`Ìÿ@HÀ{IÚpÎÉ;À—ª¹ÿ@HÀp­Î‰ÍÉ;Àc3Žžÿ@HÀìˆ¥ÌÉ;ÀÀò»|ÿ@HÀ[‹ÂËÉ;ÀX÷õWÿ@HÀ*rZßÊÉ;À¾Nš4ÿ@HÀ{?yúÉÉ;Àÿ@HÀBÉÉ;ÀÇŒVÿ@HÀ7tZ‡ÈÉ;ÀìÖ„\nÿ@HÀZ\0tËÇÉ;Àºº>ÿ@HÀ‰\"4ÇÉ;À·1ÿ@HÀøR[ÆÉ;ÀÆ¯öþ@HÀ·µòÒÅÉ;ÀØÖÜþ@HÀœ(NÅÉ;Àzæ|¾þ@HÀ‡—rÊÄÉ;À’žþ@HÀë6FÄÉ;ÀzŒË~þ@HÀ4v¿ÃÉ;Àá±cþ@HÀÔ»ÉÂÂÉ;À Þ7þ@HÀN ÅÁÉ;À1N\rþ@HÀÓ{ŸÇÀÉ;À˜¥iãý@HÀÔ÷lÈ¿É;Àôƒ»ý@HÀw®Ç¾É;À0P?”ý@HÀXŸç½É;À!Btý@HÀ&Û½É;À\n™¨Vý@HÀùQÈ#¼É;À²M¸<ý@HÀ¸Çb@»É;À[+\'ý@HÀî@[ºÉ;À”»Þý@HÀ¦ày¹É;À`mý@HÀ¤¢–¸É;À­YSý@HÀ:?\0´·É;ÀJ· ý@HÀ*qSÑ¶É;À­Z‡*ý@HÀ…~¼îµÉ;À4­\0.ý@HÀ[Læ´É;ÀLR+ý@HÀ–w_Þ³É;À–§¥$ý@HÀ_dÑÖ²É;ÀÌÙŠý@HÀ °}Ï±É;ÀLšý@HÀHî?È°É;À^©æü@HÀßVg)°É;À2skÉü@HÀŽÎT”¯É;À:÷¡ ü@HÀïøN¯É;ÀÂ´Íoü@HÀ™yœ|®É;ÀGo:ü@HÀXöƒô­É;À‚Iü@HÀ×à¡]­É;Àˆ9·°û@HÀ7—œÞ¬É;ÀNÊÙIû@HÀ+çb¬É;À–&ãú@HÀÁªôÕ«É;Àq7Uú@HÀ\"+8#«É;À3Heú@HÀ*•aªÉ;À%BVú@HÀ>þ³Ÿ©É;ÀªyIú@HÀy¸Ý¨É;Àª•<ú@HÀ$¤Ä¨É;À\Z€0ú@HÀrØüY§É;Àb¯Ï\"ú@HÀéÕË¢¦É;À\\Läú@HÀkŠ’ë¥É;Àl<	ú@HÀÕÅc4¥É;ÀojCüù@HÀèVR}¤É;À£¢dîù@HÀ‚\rqÆ£É;À¸pßù@HÀwRý.£É;À\n£Êù@HÀ\'¢É;ÀÊ8p«ù@HÀÏ¢Ð¢É;À\rDN…ù@HÀ<Üƒ‚¡É;Àu×\\ù@HÀ°èZö É;À0Y3ù@HÀoôÌ2 É;ÀGÑZøø@HÀ!ØµsŸÉ;À`|Ü¸ø@HÀ‚( µžÉ;ÀQ(yø@HÀ4yóÉ;ÀÍ›ˆ=ø@HÀÀ\\£)É;À6§G\nø@HÀ¾QÀHœÉ;À;÷FÚ÷@HÀÛEf›É;À(8­÷@HÀRïe‚šÉ;Àï]‚÷@HÀ¾‹R™É;À%ÉY÷@HÀò¦=·˜É;À‡3÷@HÀüò§˜É;À-}W0÷@HÀ?Æ–˜É;ÀÓÜª-÷@HÀ‹Š†˜É;Ày<þ*÷@HÀ1ØNv˜É;À’›Q(÷@HÀ;$f˜É;À7û¤%÷@HÀ èvï•É;À°U›Áö@HÀ÷Z~š•É;Àë‘ªµö@HÀäNE•É;À\r¯Hªö@HÀë°Üï”É;À\"¼|Ÿö@HÀSëš”É;ÀªÇM•ö@HÀiÁ\0D”É;À>áÂ‹ö@HÀf‡c“É;ÀÜX¬uö@HÀ…N‚’É;Àæ•cö@HÀ–r ‘É;À–Û£Sö@HÀ\n;\r¾É;À>n Gö@HÀ¼Û;ÛÉ;À‘<=ö@HÀ[âöŽÉ;ÀI©4ö@HÀNˆŽÉ;ÀFh\\,ö@HÀ3)).É;À°ÝN$ö@HÀWÂIŒÉ;À¸xö@HÀXÜNe‹É;ÀxžÑö@HÀO¦K‚ŠÉ;À ùö@HÀâ,XŸ‰É;ÀšUîö@HÀ)@Y¼ˆÉ;ÀxÌXýõ@HÀ\"¯3Ù‡É;À,âöõ@HÀäIÌõ†É;À˜:3òõ@HÀãn÷†É;À-lgðõ@HÀÅæ60…É;ÀK@€ñõ@HÀ/…M„É;À¨³ˆôõ@HÀöOÜjƒÉ;À…Ã‹øõ@HÀó7ˆ‚É;À²m”üõ@HÀGŒ¥É;ÀÎ‘v\0ö@HÀe÷ãÁ€É;ÀÚŠö@HÀ“°»ÞÉ;ÀÕ¦ö@HÀ\0!’û~É;Àbƒ£ö@HÀô²e~É;À(°Xö@HÀ1GÓ5}É;Àn¾ö@HÀ´¹<S|É;Àj.âö@HÀWl¢p{É;ÀQÁ³ö@HÀÜ¿ŽzÉ;ÀÚø\"ö@HÀÒd«yÉ;À¦ö@HÀÐ6‚ÆxÉ;À	†%ö@HÀ®îáwÉ;Àm˜ýö@HÀ)Ç·üvÉ;À	Ôö@HÀ0OÐvÉ;À:0èö@HÀ›è2uÉ;ÀÍ£Üö@HÀE5;NtÉ;À°é\Zö@HÀEŸ˜isÉ;Àø²cö@HÀ*4ü„rÉ;ÀW“Òö@HÀíÙa qÉ;À²ø»ö@HÀëoÅ»pÉ;ÀJ¦ö@HÀ·…ôþoÉ;À[bö@HÀÿ¨@CoÉ;Àd‹[ôõ@HÀý®ˆnÉ;À²4»àõ@HÀâ@ÏmÉ;À­ç©Éõ@HÀ[ýmÉ;À¡rP°õ@HÀ1îxOlÉ;Àæì“õ@HÀ¢´þ‡kÉ;À±¯{wõ@HÀ;<‰ÀjÉ;À#j[õ@HÀÏùiÉ;À)…“>õ@HÀHÇ–1iÉ;ÀW<*\"õ@HÀôÁòvhÉ;ÀsÎõ@HÀÆúW¼gÉ;Àÿòíô@HÀÏŒ²gÉ;ÀyÐžÒô@HÀP•îFfÉ;Àí2¸ô@HÀY/ø‹eÉ;À}S×ô@HÀ$­dÉ;Àªñ9„ô@HÀO¾4ÌcÉ;ÀÈKôsô@HÀ‡ûèbÉ;ÀÑÜjô@HÀ®\r.bÉ;ÀÙÇfô@HÀOÜ\"aÉ;ÀMàŠeô@HÀ…ST@`É;À_×›eô@HÀ$¥^_É;ÀÎ®ðgô@HÀ]Ä |^É;Àçý$nô@HÀF£›]É;ÀÜZÔyô@HÀÃ1Ø»\\É;À‡]šŒô@HÀ Ð;Ú[É;ÀQT¤ô@HÀÉ™ÑøZÉ;À°“²»ô@HÀ>#ZÉ;À7¯wÓô@HÀè*6YÉ;À\Z<&ëô@HÀÆË·TXÉ;ÀyÎõ@HÀÕñRrWÉ;Àó3üõ@HÀ´ ôVÉ;ÀèÚ|1õ@HÀÜÈ‹­UÉ;À,ãHõ@HÀÅZ\nËTÉ;À ÿ_õ@HÀÍE`èSÉ;ÀÒW¡võ@HÀ%%SÉ;À°x‰‹õ@HÀÏ2X#RÉ;ÀË©hžõ@HÀ|&=@QÉ;ÀíÅ4°õ@HÀ¤¸]PÉ;Àü¨ãÁõ@HÀa¢+zOÉ;ÀÂ-kÔõ@HÀ/áE˜NÉ;ÀÁwùçõ@HÀÌ\rŒ¶MÉ;ÀÂ‡%üõ@HÀÏêøÔLÉ;À!¹Òö@HÀ7?‡óKÉ;Ààhä%ö@HÀ·Î1KÉ;Àÿó=;ö@HÀÁ’\".JÉ;Àño¯Vö@HÀáVMIÉ;ÀN†Éyö@HÀàVmHÉ;À·ŽŸö@HÀÿQ¯‹GÉ;Àé¥\0Ãö@HÀæé¥FÉ;À¡B\"ßö@HÀûlLÁEÉ;ÀPBòö@HÀzqÜDÉ;À\n˜ÿö@HÀMÕg÷CÉ;À¬ßG÷@HÀ%G>CÉ;Àh4v\r÷@HÀ#˜-BÉ;ÀLtG÷@HÀIs†GAÉ;À¼ô~÷@HÀZåía@É;À¿B…\r÷@HÀâ>|?É;À9Û÷÷@HÀa_~–>É;À:t\0÷@HÀ7S±°=É;ÀïÜ—÷ö@HÀ%uÓÁ<É;Àº×€ïö@HÀ¦<Ò;É;ÀÉh¹åö@HÀM‚å:É;ÀúÓö@HÀ«†éÿ9É;Àd‡°ö@HÀnïB%9É;ÀŽÚÓvö@HÀ¾Ý§„8É;ÀôMu;ö@HÀ¾Kiî7É;ÀH/óûõ@HÀmñ±]7É;À$¥dºõ@HÀ¬…¬Í6É;ÀÕàxõ@HÀa¿ƒ96É;À¦æ~9õ@HÀ¶¾—¡5É;ÀŸÔ2ûô@HÀ¾M2\n5É;Àã2Ù¼ô@HÀŒ~‰q4É;À¨”@ô@HÀceÓÕ3É;À—Œ7Cô@HÀVF53É;ÀX­Œ	ô@HÀ¾Æ¸m2É;ÀsL‹Îó@HÀ¾ÿÖœ1É;Àn;Ô ó@HÀñ9QÅ0É;À6¡X}ó@HÀñ×é/É;ÀY¦	aó@HÀœž\r/É;ÀÄqØHó@HÀ4\0+.É;ÀÃ,y1ó@HÀ³\nìH-É;ÀîK9ó@HÀéí“f,É;À89 ó@HÀ\0¦¬ƒ+É;À#_5ôò@HÀŸÿêŸ*É;À¡\'€äò@HÀSÔ¼)É;À\'|	Öò@HÀ{ñÉÙ(É;À­ø£Çò@HÀ¹à¢ö\'É;ÀÙ¢zºò@HÀ@5\'É;ÀP€¸¯ò@HÀƒhW/&É;À-–ˆ¨ò@HÀ’üpç%É;ÀÂ2ô¦ò@HÀ¡ŠŸ%É;ÀWÏ_¥ò@HÀ°$¤W%É;ÀìkË£ò@HÀ¿¸½%É;Àõ7¢ò@HÀÍL×Ç$É;ÀŠ¤¢ ò@HÀAÿa$É;À„«yxò@HÀd)T#É;À7Vò@HÀìÆ\n™\"É;À:¦3=ò@HÀ¤|âÜ!É;À\'S/ò@HÀA~!É;À˜ð£.ò@HÀ®pË` É;À<ÜB9ò@HÀ#ª0¢É;Àü}¬Hò@HÀ’)ŽãÉ;ÀðýYò@HÀîí´$É;À‹PTjò@HÀöóueÉ;À¤¹Ìvò@HÀãD¢¦É;ÀeÏ3ò@HÀuZçÉ;À«I	†ò@HÀCò\'É;À}×OŒò@HÀ–¾h\ZÉ;Àÿ(\n“ò@HÀgDªÉ;Àáî:›ò@HÀIìöÉ;À¿b«ò@HÀÚàDÉ;À‚hÄÅò@HÀ0V\'“É;À+¹ãò@HÀxâÉ;Àœî™þò@HÀ˜”*1É;Àè#Àó@HÀ\0X~É;À9¼ó@HÀ+¦ÍÉ;À/Êýò@HÀ×ø©É;ÀÒduÝò@HÀÇpmÉ;À^ãE²ò@HÀ.€¿É;ÀQšÅò@HÀë,K+É;À®A>ò@HÀ`\ní¸É;ÀÐ×êñ@HÀÓ±TÉ;ÀÈà·‘ñ@HÀºâêÉ;À?ñ@HÀËgÉ;À\\r#ÿð@HÀõPÃÉ;À6S¨Øð@HÀ\'É;À¢k©Ãð@HÀAlNÉ;Àûàxµð@HÀëZ–\rÉ;ÀEÚh£ð@HÀ«fÈðÉ;Àõ}Ë‚ð@HÀxpDdÉ;Àæy6Gð@HÀþÌèÉ;ÀQ	Ëõï@HÀ³¿‹rÉ;Àiöâï@HÀ‹í¯õ\nÉ;ÀîØNï@HÀ-ef\nÉ;Àï@HÀN_¸	É;ÀzÆ°ÿî@HÀsgôÉ;À\r½!þî@HÀ\0³Ã+É;À¿\'p\rï@HÀB‹rpÉ;Àô5µ\'ï@HÀscDÔÉ;À·\nGï@HÀ‚LÉ;À—¦Žï@HÀÅTÆÉ;ÀsK‘ð@HÀ¹Ï²AÉ;Àá¼zð@HÀxÅ”¼É;ÀPCÆð@HÀÍp5É;ÀMºð@HÀðÅÉ;ÀZºÐ~ð@HÀ\'!ºTÉ;ÀÝÝúBð@HÀ¬­_äÉ;Àÿ\rÞð@HÀn*tÉ;À¡ÄÊï@HÀr›¢É;À™îøŽï@HÀkÙ{É;À·AFï@HÀF§éô\0É;ÀP|Výî@HÀìm\0É;Àêt¡´î@HÀâ×|âÿÈ;À˜vŠlî@HÀ¹sSÿÈ;Ànïy%î@HÀ!KÑ®þÈ;ÀÃc¸öí@HÀ½‘]ñýÈ;À›è*ðí@HÀý4&ýÈ;Àôbrî@HÀ=YüÈ;À?·/\"î@HÀ¹ñ–ûÈ;À|Ê>î@HÀóFDãúÈ;ÀË“îSî@HÀ¢ið0úÈ;À£¹lî@HÀ1ëùÈ;À.+Ô…î@HÀ§XrÍøÈ;À–×ä î@HÀ‡DøÈ;Àé¬Â¼î@HÀoŸ÷È;À`óÙî@HÀB3\'÷È;Àäï@HÀë—³²öÈ;ÀÉö.ï@HÀçGAöÈ;ÀþQï@HÀ\0ÖCÒõÈ;À:¯#eï@HÀ½ÔVfõÈ;À½Íx@ï@HÀ@l,<õÈ;À§ªÖî@HÀùD&õÈ;ÀÖNNî@HÀ%ý÷ôÈ;Àøî÷Íí@HÀšÅ6ôÈ;Àª=|í@HÀ¡ý-ÑóÈ;ÀþÒOí@HÀ·4ƒóÈ;À«¹®(í@HÀÊßqdòÈ;À±µYí@HÀÈs5ªñÈ;À\rŸYìì@HÀ…d	ïðÈ;ÀJ5Øì@HÀ=²ç-ðÈ;À‡åÛÂì@HÀi“eïÈ;ÀIQ­ì@HÀ=(CžîÈ;À\'Ö¥ì@HÀQ¡/àíÈ;À”\n­ºì@HÀò#3íÈ;À¨	úì@HÀ„ìF·ìÈ;À&ôÓRí@HÀ¨ÁTjìÈ;ÀsÎ\r±í@HÀZÿ;ìÈ;Àäæïî@HÀÊÃìÈ;ÀèŒ¦vî@HÀÛ)ÊîëÈ;Àº\r^Úî@HÀ«gÌëÈ;ÀØ6?ï@HÀ	Ž½ëÈ;À©Û£¥ï@HÀDŠâ¯ëÈ;À/¾Œð@HÀÄöh‘ëÈ;À<ÎÕrð@HÀô¥\rPëÈ;À+0d×ð@HÀ§óÉ9ëÈ;À*Ççð@HÀp¿V\ZëÈ;À‡_ôð@HÀulöêÈ;ÀD¥.üð@HÀ¥[GÓêÈ;ÀXT8þð@HÀAñ]µêÈ;ÀïÂ~ùð@HÀíib êÈ;À÷ðZÂð@HÀÊžŒéÈ;ÀyÈ~ð@HÀàaàÿèÈ;À?[d0ð@HÀi‡ï‚èÈ;Àë—ËØï@HÀlá—èÈ;Àš/›yï@HÀˆaÌçÈ;À*‰Šï@HÀŠB\0‡çÈ;À«zŒ²î@HÀ)GçÈ;ÀzŽ]Nî@HÀ·»çÈ;ÀÛMºêí@HÀì›\Z¼æÈ;À*C_ˆí@HÀ‡/}oæÈ;ÀRuö\'í@HÀô%ñ\"æÈ;À	›Èì@HÀš®TÐåÈ;ÀS\"»iì@HÀúù…qåÈ;À3yì@HÀ“8c\0åÈ;À÷µë@HÀN²šzäÈ;À¥ƒgë@HÀp|åãÈ;Àœc+&ë@HÀ\"P¡CãÈ;ÀÐ\'èîê@HÀsåešâÈ;ÀÐ³¾ê@HÀÂ÷NíáÈ;Àß=ˆ’ê@HÀ´—CáÈ;Àÿsühê@HÀ¨ÚÈ˜àÈ;À0®ñ@ê@HÀ§ÍíßÈ;ÀáeP\Zê@HÀ‡»–AßÈ;À~õé@HÀP–“ÞÈ;Às3ìÐé@HÀmäÝÈ;À ¶Ù­é@HÀ=ŒR4ÝÈ;ÀÜ‡UŒé@HÀÐÐ¬ƒÜÈ;ÀfXmé@HÀ5BzÑÛÈ;ÀðÖêPé@HÀJ<ÛÈ;ÀÅ³}8é@HÀ©è^ÚÈ;ÀÒt,é@HÀÇ¸ýÙÈ;ÀWö×/é@HÀâz*ÜØÈ;À_C¥8é@HÀsDØÈ;ÀÃØ<é@HÀžË!]×È;Àv<l2é@HÀeô¦ÖÈ;À¤a”é@HÀ=¬ñÕÈ;À¡Õé@HÀ©ºk;ÕÈ;ÀG+ñè@HÀD„)†ÔÈ;À/`Ùè@HÀvDNÑÓÈ;À†Ü‡Àè@HÀ\"ê\ZÓÈ;À^¦è@HÀßàçdÒÈ;ÀŽ˜Š‹è@HÀÙ¯ÑÈ;À9tpè@HÀ#!EùÐÈ;Àz·€Uè@HÀ‘BCÐÈ;Àù\';è@HÀ èŒÏÈ;Àñm%è@HÀî	¶ÙÎÈ;Àûa9è@HÀTœ-#ÎÈ;À|¤è@HÀÏCcmÍÈ;À×µ&öç@HÀ“¦Æ¹ÌÈ;ÀrF&àç@HÀK-HÌÈ;À»?£µç@HÀá•Ö~ËÈ;À–íutç@HÀì·tðÊÈ;Àµb¢+ç@HÀk%\\ÊÈ;ÀW²,êæ@HÀ‡„ëµÉÈ;Àî¿æ@HÀH\0MÉÈ;Àh|ß¤æ@HÀ¿)nTÈÈ;ÀZ’\'‹æ@HÀCP£ÇÈ;À©=ñqæ@HÀÙ’ôñÆÈ;À.<Yæ@HÀK\\\\@ÆÈ;ÀL	Aæ@HÀÞÏ;‹ÅÈ;Àôqæ)æ@HÀX±ÕÄÈ;À˜úæ@HÀh2 ÄÈ;ÀY®½ýå@HÀÙ…™kÃÈ;ÀãWåå@HÀvÞÛ¸ÂÈ;Àþª#Éå@HÀP©ÂÈ;ÀåôA©å@HÀÛëëQÁÈ;À­\\.ˆå@HÀ•\rLŸÀÈ;ÀËd]få@HÀÉs×ì¿È;ÀËCDå@HÀ‡B:¿È;À•bU\"å@HÀ?;Š¾È;Às\'å@HÀ$\0>Ú½È;ÀÂ\"ðßä@HÀŽSR*½È;À*þœ¾ä@HÀô~z¼È;À>úä@HÀÐÊÊ»È;ÀòZ{ä@HÀLt»È;ÀHíûVä@HÀñÒÞeºÈ;À¢‘û/ä@HÀTQ•µ¹È;Àáßä@HÀ{²\"¹È;ÀJÙöÜã@HÀåW¸È;À?€b²ã@HÀ•À%§·È;À÷\"˜…ã@HÀ1ù¶È;À¨yVã@HÀ’âëK¶È;Àp:~&ã@HÀr|žµÈ;Àá÷â@HÀ·üPî´È;ÀF/ÍÉâ@HÀà…E´È;ÀÞœ¡â@HÀÌT›³È;À&Ñ{â@HÀÕodï²È;ÀÉXâ@HÀâCœB²È;À•ÚÞ5â@HÀÆä\r•±È;Àh8ôâ@HÀâèß°È;À&Šäøá@HÀäÕˆ&°È;À¨Æ£ãá@HÀÍ›âl¯È;Àd$¬Ïá@HÀ *¿µ®È;À)Øw·á@HÀ÷m2®È;Àù•á@HÀ_ý#[­È;ÀŸEzmá@HÀ®ûœ²¬È;Àþ–ÓDá@HÀœ_w\n¬È;ÀÃ´á@HÀÊb«È;Àó|Bòà@HÀó/¸ºªÈ;ÀSü¥Èà@HÀÖ>ÛªÈ;Àì¾‚žà@HÀ0:g©È;ÀÕ¢Rtà@HÀYÔy½¨È;À²õIà@HÀÜÁ¨È;Àö¢Kà@HÀC·éj§È;À¹§4ôß@HÀÞ$+Ä¦È;ÀÐÔoÇß@HÀ<n% ¦È;ÀCK›—ß@HÀ3§©~¥È;À*¼\neß@HÀÌåˆß¤È;À%Ù0ß@HÀÜ=”B¤È;À1RùÞ@HÀk„¤£È;À\Zx*¾Þ@HÀz	£È;À+!QÞ@HÀg dn¢È;À@ÑÎCÞ@HÀª¨Ó¡È;À¦úÞ@HÀÔ¤65¡È;À«S)ÌÝ@HÀ”CÎ” È;ÀâÇÖ’Ý@HÀ/váóŸÈ;ÀBöYÝ@HÀßƒRŸÈ;Àþty!Ý@HÀ<\'É°žÈ;À^SéÜ@HÀ7òÄžÈ;À–»v±Ü@HÀ*ÓºlÈ;À!ÈY{Ü@HÀ)ãîÈœÈ;ÀèíÜFÜ@HÀ}d„$œÈ;À?éõÜ@HÀ ›ž€›È;À“wšÞÛ@HÀÁÉ`ÞšÈ;ÀÅUÀ¨Û@HÀ8hxAšÈ;ÀázmÛ@HÀu•Ù«™È;Àú2^,Û@HÀ”1™È;Àeú¥èÚ@HÀ‡§-…˜È;À€é¥Ú@HÀ{ë—È;ÀÔ°QfÚ@HÀ‰ØM—È;À?Œ\n-Ú@HÀ–\nP­–È;ÀA1øÙ@HÀä+¨–È;ÀPN$ÇÙ@HÀ¼¥^•È;ÀR9C™Ù@HÀmú\r®”È;À×ìmÙ@HÀk8¶ô“È;ÀÙÜFÙ@HÀ<³æ9“È;ÀkÁç\'Ù@HÀg>ï}’È;ÀžÙ@HÀ×±Á‘È;Àb\0Ù@HÀFãÇ‘È;ÀóF÷Ø@HÀ¨¥FÈ;Àõ;>õØ@HÀD#KˆÈ;À>I,ûØ@HÀäÙÉŽÈ;Àì<(	Ù@HÀZpŽÈ;Àk8IÙ@HÀ¤1QÈ;À@^¦=Ù@HÀV=ÿ™ŒÈ;À®xIaÙ@HÀø²–ç‹È;À&™ˆÙ@HÀÎî9‹È;ÀŸ–2³Ù@HÀ^þŠÈ;À*IìãÙ@HÀf/¼ì‰È;À£†vÚ@HÀ¥8‚O‰È;ÀVÏøUÚ@HÀ* µˆÈ;ÀÝq‘Ú@HÀã|iˆÈ;ÀOÎÚ@HÀÐ¬1ˆ‡È;ÀgÓ\rÛ@HÀ[5Lõ†È;À,	üMÛ@HÀ½{d†È;ÀŸ†Û@HÀÏxÔ…È;Àu$ÑÛ@HÀêE…È;ÀbÜ@HÀ¥“}¸„È;ÀöƒWÜ@HÀ?ùZ/„È;ÀºÜ@HÀ~o«ƒÈ;ÀW2äÜ@HÀ\\^o(ƒÈ;À?+Ý@HÀœ¨¥‚È;À­S rÝ@HÀ ü°\"‚È;À{\0¹Ý@HÀŽYŸÈ;Àg\'”ÿÝ@HÀ&v+\ZÈ;Àž(,FÞ@HÀ?#•€È;Àd?­ŒÞ@HÀrØ€È;Àl´ÓÞ@HÀ\"ÿ/ŠÈ;ÀöÐ\'ß@HÀ.ˆÈ;ÀAÞÿ^ß@HÀ“8[v~È;ÀÐc£¥ß@HÀ÷ÈZå}È;Àd4êß@HÀ9É~S}È;ÀYó8.à@HÀPÊ8Ã|È;ÀÜa9sà@HÀ5]ú6|È;ÀØƒ¼ºà@HÀl\"Ó{È;À±ðûïà@HÀ­Ko{È;ÀAŠ<%á@HÀjõv{È;Àv~Zá@HÀaz£§zÈ;À;cÀá@HÀ%ÚÐCzÈ;À2Åá@HÀ1!¸yÈ;ÀÓçâ@HÀ¿í¸,yÈ;Àt?\nKâ@HÀ 0Æ¡xÈ;ÀpŽâ@HÀ‰ÙBxÈ;À×Òâ@HÀ1Ø5wÈ;ÀV1ã@HÀüÜ„wÈ;À:Ú†Zã@HÀoMzvÈ;À§ü;Ÿã@HÀ”cñuÈ;ÀUs!äã@HÀUR›huÈ;Àã)ä@HÀ¤®ÈßtÈ;ÀÙÂnä@HÀ[§¹RtÈ;ÀzM µä@HÀ‡ûÅsÈ;Àª‚Yüä@HÀ´yê9sÈ;À~þCå@HÀÓÊå®rÈ;À•¡MŒå@HÀ‡°J%rÈ;Àyå„Õå@HÀÑÎh¢qÈ;ÀÆ%½!æ@HÀ·E\'qÈ;Àƒ	ræ@HÀöp—¯pÈ;À‰*Äæ@HÀj7pÈ;Àßç@HÀ{q¹oÈ;À†èdç@HÀ4ãM7oÈ;À;Bo±ç@HÀ{O´nÈ;ÀÊu†ýç@HÀ	ý\'1nÈ;ÀŠIè@HÀÖ|‹®mÈ;ÀV5Ø•è@HÀî|,-mÈ;Àr¹Ëâè@HÀvä.«lÈ;À\\‹–1é@HÀjÇ)lÈ;Àq±€é@HÀ­â}¨kÈ;À¼ÝÏé@HÀI\'Ú&kÈ;ÀÛÙê@HÀÑ\rd¤jÈ;À·hmê@HÀ\\\n!jÈ;Às¢»ê@HÀlgFiÈ;À~i¢	ë@HÀWliÈ;À¶!gWë@HÀŠ©k”hÈ;À-âí¤ë@HÀqIhÈ;ÀÜJ4òë@HÀe¼âgÈ;À.&àì@HÀ5gAµgÈ;ÀÜ{ý0ì@HÀ˜Ü®†gÈ;À¥uƒOì@HÀFoÛVgÈ;À:imì@HÀÙ«%gÈ;ÀÇó¥Šì@HÀêföfÈ;ÀD\r‘¤ì@HÀD;ÆfÈ;Ài©½ì@HÀ$\0—•fÈ;À#”Öì@HÀÝYÐefÈ;À4Wöïì@HÀ«\n8fÈ;Àòu\ní@HÀ\05“fÈ;ÀÐ­³\"í@HÀ’œ)éeÈ;ÀÆ‹÷:í@HÀS\rÈÁeÈ;À2¯?Sí@HÀêOlšeÈ;ÀÎ‹kí@HÀL0seÈ;À÷–Øƒí@HÀ¡aàeÈ;À¸»í@HÀy›L¼dÈ;À}idóí@HÀadÈ;ÀÚN7+î@HÀ¹²dÈ;ÀÇ4Œcî@HÀÈÆ®cÈ;ÀÔ¾œî@HÀï>::cÈ;À¿`íî@HÀªÍÌbÈ;À_q»?ï@HÀäú`bÈ;À0±È“ï@HÀ¡clöaÈ;À\"‚èï@HÀ\0ˆÛ‰aÈ;À°F{;ð@HÀ+„aÈ;ÀkáQð@HÀà¨©`È;Àªhãð@HÀû–8`È;ÀKÏ×6ñ@HÀ|@È_È;Àõ«Šñ@HÀ.;>X_È;Àlþ Þñ@HÀàâè^È;Àª¬3ò@HÀ÷È/{^È;ÀØ§h‰ò@HÀá?^È;À&ýtßò@HÀ8Ö,¡]È;À ¯q5ó@HÀ*53]È;ÀsÂþŠó@HÀ¼+`Ã\\È;À»‹™Þó@HÀÇäQ\\È;Àý1ô@HÀOŸÕÝ[È;ÀT@ƒô@HÀ¥Sk[È;Àjè®Õô@HÀÏ8ûZÈ;ÀCh)õ@HÀ—å’ZÈ;Àªð&~õ@HÀ˜MÂ.ZÈ;ÀŠ{Õõ@HÀ|Ñ%ÍYÈ;À’€-ö@HÀnæ@iYÈ;À[) „ö@HÀÿÿXÈ;À(˜BÙö@HÀ{dWXÈ;ÀdE+÷@HÀK²l XÈ;À16¾|÷@HÀÇ\'¨¯WÈ;À ÙÍ÷@HÀÆd>WÈ;À=4Âø@HÀž{úÌVÈ;Àç„¥oø@HÀk[VÈ;À?úÑÀø@HÀ+w§èUÈ;ÀjÄ¸ù@HÀ«PuUÈ;À‡/bù@HÀ¸Y™\0UÈ;ÀžÖ	²ù@HÀR¶ŠTÈ;ÀZ^ú@HÀdtÉTÈ;Àg†Mú@HÀ=F¯oSÈ;Àsï’ú@HÀØÖRÈ;À8™…Óú@HÀ³çs?RÈ;À<Õ°û@HÀ~’´QÈ;ÀPc[`û@HÀ$74QÈ;ÀxUì­û@HÀ¿±IµPÈ;Àlñüû@HÀ¦å6PÈ;À†8ŠJü@HÀå’B¸OÈ;À\",Ñ˜ü@HÀÖ,¶8OÈ;ÀµÎŽæü@HÀ49³NÈ;Àú½4ý@HÀ¬ÝN+NÈ;À\"e®ý@HÀ¯ž•£MÈ;ÀˆÂÎý@HÀ¯æ«MÈ;À*ŠWþ@HÀT&0ŸLÈ;ÀdÎnþ@HÀÈž.LÈ;ÀùzÀþ@HÀ)Í­ÅKÈ;À ±aÿ@HÀCË¨`KÈ;ÀÜÝVjÿ@HÀÿKØûJÈ;À¿.]Àÿ@HÀ\\…“JÈ;À@Ðë\0AHÀš“ÂJÈ;ÀÒÿl\0AHÀ)û\'ªIÈ;Àm\\Ä\0AHÀçLˆ4IÈ;ÀÛ¾AHÀ”\0¶ÀHÈ;ÀÁVäsAHÀ&ƒPHÈ;À»ŠÍAHÀl¿kèGÈ;À+ö&AHÀC¨àƒGÈ;ÀÖ½AHÀhÕ°!GÈ;ÀÆáGÚAHÀãÔªÀFÈ;À¨B5AHÀ¢3_FÈ;À0ÇHAHÀcëuÿEÈ;À¢³éAHÀ8¼ŸEÈ;Àýq-CAHÀª”AEÈ;Àx*\'AHÀÇ\\#æDÈ;ÀÀøAHÀ+ŽDÈ;Àù&^TAHÀ(×%=DÈ;Àe\"Í±AHÀÓ‹ñCÈ;ÀÖ³›AHÀwÄ8ªCÈ;Àd	npAHÀ#g¦eCÈ;ÀÌRèÐAHÀÛvN\"CÈ;À%¾®1AHÀ4LŸÝBÈ;À!^—AHÀŽ’›BÈ;ÀÁÆ{ýAHÀ\r#˜XBÈ;À+¬œcAHÀ	Ù[BÈ;À†vUÉAHÀ§aÌAÈ;Àƒá:.	AHÀÄoÛÄAÈ;À\'–W8	AHÀ\Z7M½AÈ;À*crB	AHÀR~µµAÈ;ÀîîŠL	AHÀ­Û®AÈ;ÀKß V	AHÀïêc¦AÈ;ÀÚ³`	AHÀ9àGW@È;Àã/çç\nAHÀìÐ¨>È;ÀmMï{AHÀÈY\Z=È;ÀŸÅ\rå\rAHÀR\0N;È;Àø]7AHÀæDŒü9È;À…ã³AHÀt|Å8È;À“²>7AHÀyÛ7È;À2o»AHÀè	€N6È;ÀýE1=AHÀ·úòM5È;À3â¯ÌAHÀAU84È;À¯9YAHÀC+(4È;ÀÕ»jAHÀ\\	â2È;À!å6ÔAHÀzÖ¹1È;ÀP¦[AHÀùä©,0È;À×šÅAHÀ4Gî[.È;À-AHÀ‚\Z­u,È;À¼©v[AHÀî¥=Ã+È;ÀÄÎŒ AHÀ¿KZ+*È;À—÷7o!AHÀåID¡(È;ÀkóÕÚ\"AHÀX(\'È;À3î]K$AHÀ‹‡Öå%È;ÀFCJÌ%AHÀ2,K«$È;À—ÔN\'AHÀçWóy#È;À’RªÔ(AHÀ;\\–\"È;À}ýÈi*AHÀ˜Æ!È;À¹ï,AHÀªD…á È;Àzâë˜-AHÀ7ÎÍÈ;À\"¯/AHÀßu8È;À #0AHÀ@L<È;À/|C!2AHÀÝ{o:È;ÀBîÅ°3AHÀ,¡\'È;ÀÀ›ë=5AHÀ\0->0\ZÈ;À)fÜÏ6AHÀZ¸:1È;ÀÖ³/`8AHÀç~®öÈ;Àq\Z¹â9AHÀƒ¢Ö\0È;ÀÀ*u;AHÀÚ#÷È;Àéüc=AHÀ¤@È;À¦ƒ`™>AHÀ†ØýÈ;ÀL¿â(@AHÀ=–£ûÈ;ÀyÚ2µAAHÀÅÿôÈ;À0‚èCCAHÀ‘cÁIÈ;À­¤˜âDAHÀ¥¤}È;Àö~µ{FAHÀöNÈ;À¢iHAHÀ•ë{È;ÀÖŸŠ›IAHÀ1wÔ<\rÈ;Àßò KAHÀ³;YÈ;À??³LAHÀ.Õ³XÈ;ÀÃm–CNAHÀ>ÇOa\nÈ;À¸Ï†ÕOAHÀ›ýN	È;À„¬bQAHÀaÞxoÈ;Àæ–øRAHÀÂÃ ›È;ÀïTAHÀ\Z‹ÁÈ;À¡²2VAHÀgFÈ;ÀBqÍWAHÀy|­È;ÀÇ‘ŸmYAHÀH-oãÈ;À†Øf[AHÀ·åHÈ;ÀŒ­™¨\\AHÀÄðëlÈ;À#U?^AHÀ{‡OòÈ;Àlã_AHÀ©½%MÈ;Àèã‚aAHÀJRFÈ;ÀÞo¤aAHÀævñöÈ;ÀC)cAHÀk&¸È;À0½dAHÀÆ·ÈÿÇ;ÀÌïg>fAHÀMMÞÿþÇ;À¬àPØgAHÀ¾ƒþÇ;À¼+l|iAHÀ^NEÉýÇ;ÀY«ºkAHÀbl¶üÇ;ÀÍ±¥lAHÀa35ŽûÇ;À‚Ús,nAHÀ®¾«úÇ;À®·Ê¼oAHÀßk9ÖùÇ;ÀÎMYqAHÀkÛßùÇ;ÀéÚhñrAHÀ¾CøÇ;À÷.„tAHÀeW8Ú÷Ç;ÀÙ«‹,vAHÀr«÷Ç;À<sàÔwAHÀ°+ÁS÷Ç;ÀtÊø{yAHÀ=àfÈöÇ;ÀÁ»²{AHÀW[ ™öÇ;ÀJÆ|AHÀ¨0Ó8öÇ;À7„`l~AHÀ æ¸õÇ;Àg¯€AHÀ·As:õÇ;ÀÿÑô²AHÀm¬6áôÇ;ÀÈÁ7YƒAHÀw›Z}ôÇ;À7Ë¿þ„AHÀFMôÇ;À²³ò§†AHÀzëÆôÇ;À|©TPˆAHÀ]`àóÇ;Àm~î÷‰AHÀéë×ÆóÇ;À‘¹¡‹AHÀt÷“™óÇ;ÀS	JAHÀxBfóÇ;À\rFkòŽAHÀhlóÇ;À<…µ;AHÀB„‰wóÇ;À‰\"P‘AHÀ«&,WóÇ;À‚m“AHÀEO#óÇ;ÀÇè´7•AHÀ	R±òÇ;À«‚x;—AHÀÿç¦òÇ;À>ëÉ™AHÀ\Z`)³òÇ;À¬*?5›AHÀVb¹²òÇ;Àã`n÷œAHÀG4£òÇ;Àã40åžAHÀë|òÇ;ÀÑ¯å AHÀî>`òÇ;Às§,Ì¢AHÀ\'\rÄ8òÇ;ÀtéB¥AHÀÐÖ\"òÇ;ÀÅ/.Ï¦AHÀŸ`òÇ;À‰“…¨AHÀ‹oòÇ;ÀT­ ¿ªAHÀ|üÔñÇ;ÀOLt·¬AHÀžH„ñÇ;ÀÓC¶®AHÀŸ0ñÇ;Àž½	o°AHÀ,J:ãðÇ;À¹7H²AHÀf´ÆðÇ;ÀQd›´AHÀ.®M×ðÇ;À5	rh¶AHÀS\n¡êðÇ;Àa5¸AHÀÑƒñÇ;ÀÞlÒºAHÀÃ\nh\ZñÇ;À]Þ¼AHÀ…)(0ñÇ;À@ú\n¼¾AHÀGã¤LñÇ;ÀT›3UÁAHÀÁ¾^ñÇ;ÀõïKÃAHÀ&3kñÇ;ÀvžŒ!ÅAHÀÅŸnñÇ;ÀyÛÄ\'ÇAHÀ;~îuñÇ;Àx8CÉAHÀ|ÕbxñÇ;ÀÃc*ÔËAHÀ\rÌæ{ñÇ;À¹¥bÚÍAHÀŸÐ¡ƒñÇ;ÀsA­ÏAHÀ’Î›ñÇ;À¯Q6wÒAHÀ¡ˆ’†ñÇ;À¹I²DÔAHÀOÀ\Z)ñÇ;Àµ¸ÖAHÀÇ9—ñÇ;À%êLÖ×AHÀ¢ØÄìðÇ;ÀF2rëÙAHÀÚ¶ðÇ;Àº|çÝÛAHÀÒòi›ðÇ;À20Ÿ“ÝAHÀá‰ðÇ;Àr‚Ñ\\ßAHÀm®m‚ðÇ;À‘%ëoáAHÀª\0ðÇ;À>|KãAHÀfiãœðÇ;ÀÞU¡KåAHÀ\"©b²ðÇ;À#-×\"çAHÀuÈðÇ;ÀÛdNÖèAHÀc¿­éðÇ;ÀyŽùÒëAHÀ/W”þðÇ;À/Ø¸ÃíAHÀ15ÝñÇ;À]•<ðAHÀ™qcñÇ;À¥ú1$òAHÀ•A¾ñÇ;À]¨ôAHÀo1	uòÇ;Àë76³öAHÀ–S^þòÇ;À¦\"bvøAHÀ\\Š—óÇ;À]ôo”úAHÀ7 öóÇ;À¾Î@hüAHÀ²„FôÇ;ÀÞ«Ç-þAHÀYE³·ôÇ;ÀªíòÿAHÀ¶(¢£õÇ;À3_	BHÀ¥`$ÎöÇ;ÀxgseBHÀáÇŽ‚÷Ç;ÀPÓBHÀB\'¦õ÷Ç;ÀÉ~2âBHÀúÆµøÇ;ÀÎM‚Ô	BHÀO9Ç*øÇ;ÀœJ®BHÀ­ê™>øÇ;ÀP»C\rBHÀ¸JQøÇ;ÀÁúÃ4BHÀÈkLjøÇ;À9\\ÍmBHÀÇ4€øÇ;ÀÅd^vBHÀ‹ó’øÇ;ÀíÓ/BHÀöµDëøÇ;À%Õ	BHÀÕV5uùÇ;ÀQpD2\ZBHÀ8àKúÇ;À™¥wBHÀ’E3[ûÇ;ÀÑËzBHÀ{	æüÇ;À½\\Qx BHÀWÒ¸8üÇ;À½	0\'\"BHÀ\r|Q*ýÇ;À|x¸c$BHÀ7ŒšóþÇ;À2öG&BHÀâÓ.v\0È;À[V—\'BHÀÊ!0‰È;ÀüNQ‚)BHÀ©ÛÄÈ;ÀÿQæˆ+BHÀA¿?È;À6ëc-BHÀ,¼Ž“È;ÀßÕa/BHÀMü³.È;À‹Ø}z1BHÀž‰\'«È;Àq‰(3BHÀºÈ;È;Àó„5BHÀ]fàÈ;À%èÓ6BHÀU¤²È;ÀHuz·8BHÀ:~^¤È;Àú¡‰:BHÀZ;]‰È;À\rqd<BHÀQ˜ggÈ;ÀkjZP>BHÀQ€QV	È;À¾»T@BHÀšÊÔ-\nÈ;Àcj\0ÍABHÀ¼h`È;ÀµÌË0DBHÀb¯>~È;À§Ê\"FBHÀõU­{\rÈ;À¼¿•ÙGBHÀ)¿{WÈ;ÀB8f‡IBHÀù¤¶DÈ;À9y— KBHÀIzEÈ;ÀæÛßLBHÀ5yJÈ;ÀpÈ–NBHÀ=nÈ;À}1c«PBHÀÕ——šÈ;Àss»aRBHÀË!ÞªÈ;À¶Á•UTBHÀá…U\\È;À±h»VBHÀ È;ÀSz£³WBHÀRÿÜÈ;ÀüU+yYBHÀ%%qÈ;ÀÊ ?[BHÀ ü×È;ÀìG¤Ð\\BHÀûZ•nÈ;À¾÷à~^BHÀ6	¾\ZÈ;ÀÖ³`BHÀÒ]²ýÈ;À÷JïéaBHÀ&0PÈ;À&R’ÎcBHÀî¹hÈ;Àþ¬1seBHÀ$¬MaÈ;À®Ñ?4gBHÀbùðc È;À‹MµýhBHÀÁ©Ão!È;ÀÃ›*ôjBHÀ;j9\"È;Àa50mBHÀ“8>q#È;À2\ZpBHÀÂ‘±#È;À2”%%rBHÀJ5Õÿ#È;À¿Â±tBHÀµ3pˆ$È;À¸¤NÂuBHÀŒ\'ˆ9%È;ÀÉ”?gwBHÀ#Æp&È;Àô³¤yBHÀƒ»é°\'È;À%q4{BHÀ‹ø>)È;ÀáLG}BHÀÌ¿-Ž*È;À»lfä~BHÀ±8R¸+È;ÀSÅ7Ü€BHÀp\\þú,È;À¡fÑƒBHÀÃéJÐ-È;À¨Ü~Ò„BHÀ’âóp.È;ÀvÐ”}†BHÀ1d K/È;À³œRˆBHÀª¨Õ[0È;ÀAµ¡(ŠBHÀ×ËA1È;ÀDÍkÊ‹BHÀÖ”©ú1È;ÀÂ„;uBHÀ e/3È;Àñ\0B3BHÀ>&\'4È;À6ÄS‘BHÀoÀ—/4È;Àžx!‘BHÀ¾Šé5È;Àº#ó“BHÀŽêJf7È;ÀÀÃÏþ”BHÀäÌ}8È;À.è†¿–BHÀ²öbÆ9È;À¾tÛg˜BHÀ)@ZC;È;ÀGlÿ™BHÀÅÀré<È;Àþõ.ž›BHÀï½×t>È;Àåz\"BHÀ1$Ý@È;Àß›u§žBHÀñˆÓ±AÈ;À°t3 BHÀ(òTCÈ;Àù×¢BHÀ²S¡DÈ;ÀbÃå£BHÀÌ}7FÈ;ÀúòÞ¦BHÀÏ¥GÈ;À›éß	¨BHÀohÕ4IÈ;À)®½ù©BHÀ±¥›KÈ;À\"§™¼«BHÀžb3MÈ;ÀE°à{­BHÀš9¥óNÈ;ÀëK¯BHÀ•—KûPÈ;ÀþÆ×à°BHÀƒxsðRÈ;À¿”x³²BHÀû…×{TÈ;ÀùÂM7´BHÀxªXEVÈ;À˜S¯æµBHÀäWÈ;ÀñÄý¶BHÀÚ(Ç„WÈ;À^ÎÄý¶BHÀd!WXÈ;À8½•µ·BHÀ:ÇÃZÈ;Àù¡mv¹BHÀ”w~c\\È;ÀD^{»BHÀW\"ºî]È;ÀÀ!Pï¼BHÀÿ½Ë`È;ÀKÖÛ_¿BHÀÃðaÈ;À-8ãÜÀBHÀ‘àmcÈ;ÀŒ‰å´ÂBHÀ†‰CeÈ;À¾“ÃÒÄBHÀÿ¹yÈfÈ;Àq›sÆBHÀù[f±hÈ;À&ùBÈBHÀ¨óÂ×jÈ;À@„lÊBHÀ§(6lÈ;À#éGÌBHÀehLÐmÈ;À0ŠÜÍBHÀÚäønoÈ;Àˆ¥ÏBHÀ‹ì±GqÈ;À\'ßh1ÑBHÀ}L‘	sÈ;À—Ð-ßÒBHÀ³+]…tÈ;À§FmVÔBHÀé3ÊvÈ;ÀŠ³}˜ÖBHÀ¨0(xÈ;ÀCµ×ØBHÀÕVL‰yÈ;ÀLI¶£ÙBHÀZ,YÓ{È;À·y0¤ÛBHÀ\\¢1‚}È;ÀòÌËÝBHÀ`¹?FÈ;À¶¿CÐÞBHÀB\"oÈ;ÀXöç•àBHÀ\n9µ™‚È;ÀA÷âBHÀð¼É|„È;ÀÇ‘sÛãBHÀÝx´†È;ÀÜ§xåBHÀö‘‡È;À\\Ö,çBHÀâ#ÁE‰È;ÀO“O¬èBHÀªx„n‹È;ÀD«êXêBHÀ>…~È;À¿,|öëBHÀšóâ“È;ÀˆsøªíBHÀ»aíb‘È;ÀÃKavïBHÀO¶\"Î’È;Àp…ïðBHÀ¸|ÏÄ”È;Àkãp˜òBHÀÆ®–á–È;Àã––HôBHÀfêÌ	™È;À‘4âåõBHÀR}õšÈ;ÀZ(O÷BHÀ3Î3È;À|ÑŸÒøBHÀ\'åÛXŸÈ;À‰PúBHÀ«Ò¬ƒ¡È;À«rj>ûBHÀmw¼¦£È;ÀÅ\rÀÊüBHÀ?ÅV%¥È;Àz•<þBHÀ×“+§È;ÀplœÿBHÀ›&ñÞ©È;ÀRA0â\0CHÀ•P÷(¬È;ÀêŠQ9CHÀ¹£}ñ®È;À-ÌüCHÀû<6?±È;ÀäÙ›fCHÀ¼æ­³È;Àëš<ñCHÀÒ˜I´µÈ;ÀmPæUCHÀ®¡;¾·È;Àù˜Šó	CHÀ-‘¹È;ÀózÉ€CHÀsþ°»È;ÀMp¨&\rCHÀœ-±¼È;Àwòú\rCHÀ2é:¾È;À(Í°âCHÀÆDûÅ¿È;À.)^CHÀ:ŽºvÁÈ;Àó®ÔCHÀ	—„ÃÈ;ÀbÐµ6CHÀxg<¤ÅÈ;ÀYH“âCHÀq…üžÇÈ;À“n°~CHÀ ÉÈ;ÀÖ=#\ZCHÀ†¤ËÈ;ÀÅ5íCHÀ¾W>ÍÈ;ÀÁö¢CHÀmt•ÏÈ;À€ôò[CHÀp_ZÒÈ;Àw¶Ž!CHÀX6~zÔÈ;ÀÄå#CHÀ•+0×È;ÀXmï$CHÀ®˜WÙÈ;À©	2U&CHÀÏ¬ŠÛÈ;À¶TÈ¥\'CHÀÖ×°ÔÝÈ;À1ëü(CHÀJzàJàÈ;ÀßÃÃ…*CHÀÖ`%IâÈ;À“²4Û+CHÀ+úoäÈ;Àû£:R-CHÀ\Z	=§æÈ;À¨ïÃ.CHÀUå®ñèÈ;À¬Ò\'&0CHÀ?v²ëÈ;À&“®1CHÀÓƒƒ°íÈ;À.	Üß2CHÀfÀïÈ;ÀyU“4CHÀ‡ÓZÀñÈ;À\r;P€5CHÀi> ÏóÈ;À©Ýû6CHÀ3yÌ˜õÈ;À¾ô\\8CHÀF’ìÝ÷È;ÀŸ]tR:CHÀ¦0”«ùÈ;À=R˜÷;CHÀ¾…åîûÈ;À/¾þ>CHÀèÆÉ¨ýÈ;Àý‡Î²?CHÀ§·ÛeÿÈ;Àx{ÖYACHÀndwí\0É;À`€JBCHÀQ›ÉÉ;À8’‰CCHÀp”âÉ;Àbôï†ECHÀØõ€MÉ;ÀlOüoFCHÀfÄýÉ;ÀæcërGCHÀ+±é¸É;ÀÉ£ÉyICHÀ•ÅËUÉ;À\0ZTðJCHÀÝ‚[ñÉ;Àíh½LCHÀ­é‰ùÉ;À×çuÛLCHÀtgvÉ;Àý‡®>MCHÀ<ûÏ\ZÉ;ÀñæèÄNCHÀÄÏaåÉ;ÀÊ_§OCHÀäýüÉ;À†j°HPCHÀVöë \"É;À\0ùænQCHÀ_@$É;ÀóIÞ–RCHÀàoW^&É;ÀáÐ³¿SCHÀ…av(É;ÀìTCHÀo€{*É;ÀW°¾\"VCHÀ6T\\~,É;ÀŠYZWCHÀÉ¹n“.É;À2<dˆXCHÀn0Ùµ0É;À~Ÿ®YCHÀLR¶Ü2É;ÀÂL@ÒZCHÀVDÀ5É;À‹‘Fæ[CHÀ™á<a7É;Àc²÷\\CHÀö?¾Á9É;À58`ô]CHÀã.Œ<É;ÀÆiþ^CHÀPZ_>É;ÀÈ¥ª`CHÀö£Q}@É;Àšµ€0aCHÀ7²‚BÉ;ÀaØ=gbCHÀ«pvDÉ;À{­¦cCHÀÕâ!AFÉ;À†CNùdCHÀÂ›dûGÉ;À6RfCHÀžL‘ÇIÉ;ÀºV×£gCHÀ?bB’KÉ;ÀÚ¬xöhCHÀÚàLÉ;À=5tjCHÀ|ÆæBNÉ;À1`ÄëkCHÀK=ñOÉ;ÀÛKÈImCHÀÜ5ÐÍQÉ;Àk*”nCHÀÃ®ý–SÉ;À¬\Z3çoCHÀj­dUÉ;ÀÔ&ò8qCHÀ¶„B;WÉ;ÀŽA|…rCHÀi»m\nYÉ;À]:]ÖsCHÀ:ÆMýZÉ;ÀógÑuCHÀS#h]É;ÀË™EvCHÀNQ5_É;ÀT‘²€wCHÀ‹Ñ0aÉ;À(e¦xCHÀÁÂx˜cÉ;ÀÑ°œyCHÀP–ôeÉ;À5¹­zCHÀ‹G×DhÉ;À.þ›¥{CHÀ42éjÉ;À\'Ë_»|CHÀáá¿lÉ;À‚kýÑ}CHÀÁéoÉ;ÀÇ4öß~CHÀ¥2BqÉ;À*xv÷CHÀx†sÉ;ÀJ×	CHÀé{èuÉ;ÀW›´‚CHÀºCxÉ;À¤uÜƒCHÀmÀ½xzÉ;À´,Ñ„CHÀïôÅ|É;ÀS=!L…CHÀ¥ Î¨~É;ÀðXqx†CHÀ\0ÖQÂ€É;À6Vã£‡CHÀ¨]?ã‚É;Àc‹þÊˆCHÀ	p	…É;À´y(ë‰CHÀ\nÕ„T‡É;ÀÒ–üŠCHÀµÃ\Z‰É;À›8ŒCHÀö—+¥‹É;ÀÆPEACHÀçržÁÉ;À\rv!jŽCHÀMçÉ;À9|CHÀV®$’É;ÀgÑ@¥CHÀØöôo”É;Àª~±‘CHÀÉì²–É;ÀsBðÂ’CHÀ‹(“ë˜É;ÀD)Ü“CHÀqÆ“+›É;ÀÑìWï”CHÀWhzÉ;À»øØù•CHÀ^\0SßŸÉ;À=ªó–CHÀ*eŠ2¢É;À¼Gù—CHÀÈ{4Š¤É;ÀZàü˜CHÀ•ž@é¦É;À”fHû™CHÀln+N©É;À÷B„ôšCHÀ`³«É;À½ò™î›CHÀÈ®É;À‘äÕçœCHÀW¬ê°É;À„ŒUßCHÀu±öÞ²É;ÀOÎ½ÝžCHÀ¾i#µÉ;À>qRîŸCHÀïEG·É;À¾Ø¡CHÀi²¹É;ÀOCÂ¢CHÀY,Ÿ»É;ÀDÑŠK£CHÀÂw·½É;À½+Üw¤CHÀ]¬Ç¿É;Àžª§¥CHÀeÌÁÉ;ÀˆojÞ¦CHÀÞ!µÆÃÉ;À-­c\Z¨CHÀ;¥³ÅÉ;Àx¬R]©CHÀˆBõ­ÇÉ;À4L™ªCHÀíÚ`œÉÉ;Àšì\\Û«CHÀ=±®œËÉ;Àÿ?‘­CHÀà¨ÿ“ÍÉ;ÀÛCmR®CHÀž§å†ÏÉ;Àõš½’¯CHÀ“6¨…ÑÉ;À\ZªÌ°CHÀÎS;œÓÉ;À~w&ú±CHÀ+­¸ÕÉ;ÀB#³CHÀª€ØÉ;À£O†-´CHÀ#‚âNÚÉ;ÀD¡…;µCHÀÀØ¾šÜÉ;ÀƒGÄG¶CHÀwùoòÞÉ;ÀÄÛ7L·CHÀ\"¨AZáÉ;ÀòB¸CHÀ°_÷öãÉ;À±ˆ÷\n¹CHÀA!®æÉ;À1µÌÔ¹CHÀ†ßd*éÉ;À\në¡žºCHÀkbÅëÉ;ÀÂ5¿f»CHÀ ŠòZîÉ;À[!–6¼CHÀùu5óðÉ;Àf#½CHÀÞÛ%„óÉ;À7ä”Ô½CHÀæ¤äôõÉ;ÀóÆ¾CHÀ?Ÿ–IøÉ;À™œ]Ë¿CHÀ÷ÿúÉ;À@B7ÚÀCHÀØ¥ÉüÉ;ÀY/róÁCHÀþåûîþÉ;ÀóˆÃCHÀ	:¡ü\0Ê;ÀWaIÄCHÀpÓ4Ê;ÀøšnxÅCHÀ£µVÊ;ÀóëØªÆCHÀs=ê/Ê;À«<ÆÙÇCHÀº²¼+	Ê;ÀNz¼ÉCHÀk+$Ê;ÀmO•RÊCHÀ¨6\rÊ;À8í`‚ËCHÀ–ã{Ê;ÀŒY÷’ÌCHÀu˜ÛÊ;ÀO©ÍCHÀ6OyCÊ;ÀJ+‡ÎCHÀžœA®Ê;ÀÞË<{ÏCHÀÝf”0Ê;À«)Q\\ÐCHÀ€TJ·Ê;Àˆ~9ÑCHÀZù\'Ê;ÀßÖ(ÒCHÀÕ”v‹ Ê;Àšº¦$ÓCHÀ‡uË\"Ê;ÀÁþ×7ÔCHÀ¸Ã>Ê$Ê;ÀNorÕCHÀË\\Ÿ&Ê;À©XÀÖCHÀ‡ÈŠ(Ê;ÀÁÿMØCHÀ\\ÉMm*Ê;ÀÙbxKÙCHÀÞóXK,Ê;ÀÞ‡c•ÚCHÀSµà\'.Ê;ÀbSßÛCHÀ5o¼0Ê;À‹éÝCHÀqXƒ‹2Ê;À‘¿ÞCHÀ,[(5Ê;ÀÏwIëÞCHÀb¬“§7Ê;ÀÞ¼ßCHÀØ€QA:Ê;ÀeƒŽ‡àCHÀ×ÿ´Ó<Ê;ÀßfIXáCHÀÕ]rZ?Ê;Àþ-ê5âCHÀ»¾ ËAÊ;À;ª%ãCHÀQ[:DÊ;ÀG\"äCHÀ{é*¥FÊ;À¨åCHÀ¹ç~IÊ;À`>ÙæCHÀŸEfŒKÊ;ÀúÌbææCHÀIñ§NÊ;ÀûáÄçCHÀOBâ©PÊ;À±$—èCHÀxä·-SÊ;À“%¨péCHÀ‰Ž®UÊ;À¿»›RêCHÀ/sAXÊ;À~ž\n%ëCHÀªßZÊ;À\rä¹éëCHÀ?°{]Ê;Àm\'!°ìCHÀiÿ3`Ê;À)þ5ríCHÀáóÇbÊ;À¤KÙ*îCHÀÃveÊ;ÀCøzÝîCHÀšrýhÊ;À\\ô×ïCHÀþ	P¯jÊ;ÀYcýkðCHÀj%¢1mÊ;ÀØ$MñCHÀÃWžLoÊ;ÀŽ‰«wòCHÀéázqÊ;ÀmÊû–óCHÀ÷å+çsÊ;Àø·\n‹ôCHÀ×ÆÙ€vÊ;ÀêyTõCHÀ«w«xÊ;ÀØQrŽõCHÀßÙeñyÊ;À¸Ý:qõCHÀ#­	,{Ê;À9îéõCHÀÕÌ|}Ê;À€¿¡.÷CHÀøàrÊ;À²°Å.øCHÀò‹\Z\0‚Ê;À9|©ùCHÀ¼ni„Ê;À*uúùCHÀ@›¾†Ê;ÀEÎÿúCHÀ)ÕÊG‰Ê;À§ÞÙÚûCHÀ•\rãÒ‹Ê;ÀSòS³üCHÀ7ŒŒŽÊ;À›À\\WýCHÀÈ{Û¨“Ê;À)I•\\þCHÀGXW•–Ê;Àó°é™þCHÀ¦ñ—Ê;À‰Œ þCHÀÖÑ=Ó—Ê;ÀšbtþCHÀŒgÓšÊ;À‰Å¢ƒýCHÀ_@rá›Ê;À\rÏÖBþCHÀvIuœÊ;ÀúyÑëÿCHÀ ¦0œÊ;ÀÁÛ?/\0DHÀV¼\ZœÊ;Ày`³á\0DHÀï0BqÊ;Àí„–DHÀ=Àª0 Ê;À§ù1DHÀI%£Ê;À´)¢3DHÀÄp\\¦Ê;ÀŠ‹;ÅDHÀôžå¨Ê;ÀÑ{|\ZDHÀJ×ÎîªÊ;ÀzØODHÀ=\\¬Ê;Àg¡£ÚDHÀÿ¿?—«Ê;Àür~DHÀHJ­Ê;À~øcôDHÀÜjœš¯Ê;ÀrŠÂDHÀ$w/d²Ê;ÀÄ•øQ	DHÀƒ­´Ê;À¶U÷_\nDHÀA¿‚l·Ê;À4Gü\nDHÀœoÖ8ºÊ;ÀÅg„DHÀÛ†ø+ºÊ;Àh…¾WDHÀë¦ZUºÊ;ÀûY]zDHÀ\'#¼~ºÊ;ÀôtÇœDHÀS¯\Z¨ºÊ;À&M¿DHÀ}tÑºÊ;Àóº>âDHÀ´ÓÅúºÊ;ÀÄ‚ì\rDHÀN)xI»Ê;Àá–mn\rDHÀ¶õÇa»Ê;Àœé”ß\rDHÀ˜ó-Y»Ê;À‹b°UDHÀ×\"E»Ê;À\\ê\rÍDHÀ¼Z;»Ê;ÀHjûADHÀÈ‰1»Ê;À[-òÀDHÀéÑÍ»Ê;À@DHÀ@øž»Ê;Àëù,¿DHÀ4¾°úºÊ;ÀÛ„>DHÀÔ¥¶»Ê;Àÿ†¼DHÀƒU{,»Ê;À<þŽ÷DHÀvŒÞT»Ê;Àn50DHÀ“4Ü…»Ê;À¤^®fDHÀ\'<p»»Ê;À”´gœDHÀ2Ž–ñ»Ê;ÀÙpþÑDHÀ´_æT¼Ê;ÀÙJ.DHÀ3¾R¿¼Ê;ÀÖÐ‡DHÀ¦i)½Ê;ÀA	áDHÀÆ¹‹½Ê;À£Y<DHÀéÏÞ½Ê;Àú4DœDHÀh®¥\n¾Ê;ÀV…šÚDHÀídÌ3¾Ê;À6È…DHÀu®[¾Ê;ÀNH³XDHÀ*·ƒ¾Ê;À9OÐ—DHÀïÍQ­¾Ê;À‘&ŠÖDHÀTåÞ¾Ê;À.µÊDHÀ>1E¿Ê;À¯yÓbDHÀ®öqD¿Ê;À*,Å¨DHÀ¥zNw¿Ê;ÀË…ÀîDHÀV©¿Ê;À=æ4DHÀH8Ú¿Ê;Àç{šDHÀä´ñ¿Ê;À\"	DHÀÒ»:\0ÀÊ;À}oDHÀÓ¤\ZÀÊ;ÀÀMòØDHÀpSÀÊ;ÀSe@?DHÀÙÊ!ÁÊ;À¢\ZDHÀÕå>ÂÊ;Àìyüì\ZDHÀÀjÿAÃÊ;ÀÒÉÊ©DHÀ×.›†ÄÊ;À†TVDHÀ?»¡åÅÊ;À:lóDHÀ\0-\'ÆÊ;ÀE=fDHÀU-jjÆÊ;À– D#DHÀ{&Ú­ÆÊ;À‘‡9DHÀ{ þïÆÊ;À´q°PDHÀw<W/ÇÊ;ÀTAjDHÀžÞÔÈÊ;À“‚ÃÈDHÀ5Áý×ÈÊ;À!\n•\'DHÀìÀ«ÉÊ;ÀWÞ·†DHÀêe\rÊÊ;Àïò-æDHÀK3ÒQËÊ;ÀŠ:ùEDHÀ”ÏéÖËÊ;À½UƒDHÀ ®.[ÌÊ;À€IÁDHÀ9\ZßÌÊ;À\\ÉyÿDHÀ–Ü%cÍÊ;Àjõˆ= DHÀüËçÍÊ;À˜\Z{ DHÀ°Ûÿ¾ÎÊ;ÀD6¾Î DHÀ|ài§ÏÊ;ÀÈéš!DHÀ\'N–ÐÊ;À.‚%U!DHÀ(Æñ€ÑÊ;ÀMIÓ˜!DHÀ9Ï™\\ÒÊ;À¡Šè!DHÀ[†òÒÊ;À‚?\"DHÀ\"3éfÓÊ;Àl8©\"DHÀ¥ÎÎÑÓÊ;À-U(#DHÀ“MLIÔÊ;ÀëK™#DHÀªôãÔÊ;ÀÃ;Õ#DHÀ‘óáØÕÊ;À/>,$DHÀÍEÄÕÖÊ;À;h>|$DHÀ÷VÕ×Ê;ÀØMÊ$DHÀ7µQÒØÊ;ÀéÝ–\Z%DHÀž©qÇÙÊ;ÀÛÊ}q%DHÀŸÇÚÊ;ÀO}Ñ%DHÀœ\'ÈÛÊ;À¢Ó0&DHÀ¬êýÆÜÊ;ÀjÏû‘&DHÀlŒü¿ÝÊ;À¯o÷&DHÀæ„¯ÞÊ;À1g©c\'DHÀ}Hó¶ÞÊ;Àæè?g\'DHÀ\'<_¾ÞÊ;ÀŒ?Øj\'DHÀ÷ÉÅÞÊ;ÀÔ7qn\'DHÀu5ÍÞÊ;À…Ÿ	r\'DHÀ„\ZËÞÊ;À!È7q\'DHÀë7˜0ßÊ;À)Ð“’\'DHÀln¢•ßÊ;Àò¬ð³\'DHÀ]Q¬úßÊ;À¿ÜMÕ\'DHÀyx¶_àÊ;ÀÐÝªö\'DHÀ0xÁÄàÊ;Àö.(DHÀ¦>íWáÊ;À†J™F(DHÀkNÄíáÊ;ÀTÖdr(DHÀéKÚ…âÊ;ÀµÇÕ›(DHÀZÙÂãÊ;ÀnXÃ(DHÀÝ—»ãÊ;À¹­Wé(DHÀÜw’ƒäÊ;ÀªKF)DHÀûCMåÊ;À\rzE)DHÀi›HæÊ;ÀŠÝ©o)DHÀ†ÒÂäæÊ;ÀWè—)DHÀWÕ²çÊ;À«Ø´½)DHÀ¼§È6èÊ;ÀæKiÔ)DHÀÊÂ»èÊ;À¯­Xê)DHÀN$‰?éÊ;Àþ=\0*DHÀ,…×ÃéÊ;Àæ=é*DHÀ/ÅGêÊ;ÀBìŠ,*DHÀ>0¼ÕêÊ;ÀÛÄµE*DHÀ9€qcëÊ;À’zF_*DHÀ^àðëÊ;À‚ÀTy*DHÀ€š~ìÊ;À8Iø“*DHÀzÖ\níÊ;À^ÈH¯*DHÀ0˜°íÊ;ÀZÂtÑ*DHÀmþ¢TîÊ;À3{ðõ*DHÀ]Ãu÷îÊ;À•è(+DHÀÁY™ïÊ;À¸\0‹C+DHÀª¼n;ðÊ;Àº¸ƒk+DHÀ\'ÉžíðÊ;Àô¤——+DHÀ©fîžñÊ;Àr^«Ä+DHÀ`ÛMòÊ;ÀJÓBô+DHÀÍ}ãøòÊ;Àyðá\',DHÀÃ‰„žóÊ;ÀŠ£a,DHÀðL\\KôÊ;ÀÑ¨˜¢,DHÀ­Ç2öôÊ;Àxnå,DHÀ&t®ŸõÊ;ÀQ,)-DHÀmËuHöÊ;Àâ_om-DHÀ®G/ñöÊ;À¼mÖ±-DHÀb\rŠ÷Ê;Àxò-DHÀ2ÑÉ!øÊ;À¥õ4.DHÀŽG‡¹øÊ;Àj`ðv.DHÀ³\"§TùÊ;À„\r¶.DHÀ*ûõùÊ;À~3îï.DHÀžÆªúÊ;À‘(™*/DHÀÐ/å^ûÊ;ÀÖ\Zxd/DHÀ,üÊ;ÀAˆÛ/DHÀ’íœÉüÊ;Àí×/DHÀœžî~ýÊ;ÀÑÆq0DHÀšZ¡þÊ;Àx¶wC0DHÀ°YZÀþÊ;ÀEktv0DHÀw.aÿÊ;Àµh©0DHÀ@hé\0Ë;ÀA¾RÜ0DHÀŒ˜Ä¢\0Ë;Àô©41DHÀ°GÁHË;À]ÚÕA1DHÀ‰sJñË;ÀXÀq1DHÀØ¬œË;Àÿ!Ÿ1DHÀøHË;ÀÎG*Ê1DHÀø€˜÷Ë;À’–ó1DHÀ\'û¯Ë;Àô˜ 2DHÀÎE&lË;ÀŽ\"ø02DHÀ‰Kw*Ë;ÀvzÝH2DHÀÁô^çË;ÀQèc2DHÀÆ(ÉŸË;À6³…2DHÀ(^LË;Àn®G«2DHÀCÉ,øË;À?ê—Ò2DHÀ0p\n£	Ë;Àð±1û2DHÀÌL\nË;À‹SG%3DHÀî€Fõ\nË;ÀU\ZQ3DHÀ/N²Ë;Àè´÷„3DHÀñœßmË;À’ä|º3DHÀ™3B)\rË;À…r!ð3DHÀÛ[½å\rË;ÀØ&l$4DHÀá˜¤Ë;À½ÊãU4DHÀö…eË;À’1…4DHÀàÙ%Ë;À?Æ*´4DHÀ@·æË;ÀE\0ã4DHÀŸ‚‹§Ë;À°ïß5DHÀŸ30hË;Àsù@5DHÀÿa!Ë;À/ØÂn5DHÀîSÚË;Àñ7âœ5DHÀrV9“Ë;ÀïŒË5DHÀºJLË;À¹Ð\nù5DHÀÕ%½Ë;À†þ‡&6DHÀÆKÀË;ÀLƒŠP6DHÀÐòÈ}Ë;À¦ŒOv6DHÀz,¯<Ë;ÀHš6DHÀb?vûË;À#¾6DHÀ@¦–¸Ë;Àqe²ä6DHÀÏd\0ˆ\ZË;ÀÕ„7DHÀV_VË;Àç„@7DHÀ¦©ä#Ë;À||Šp7DHÀÄYõïË;ÀÌ3|¢7DHÀ€ƒ~ºË;ÀÍü¼Ö7DHÀL±Ë_Ë;À\\ËJ8DHÀ}‘ÌË;À·48DHÀš@¤Ë;ÀÛXde8DHÀ`CçD Ë;À·J³—8DHÀ €å Ë;À&[Ê8DHÀüÉü!Ë;À½×ÿ8DHÀ¥Pø4\"Ë;ÀàTY69DHÀV}Ú\"Ë;À*b¡n9DHÀ6³|#Ë;ÀÔZq©9DHÀÞ`–$Ë;À³Šç9DHÀi±ö´$Ë;À‰\'þ):DHÀRöÿD%Ë;ÀèŒqq:DHÀËv¾Î%Ë;À «¼:DHÀµv>T&Ë;ÀÊq\n;DHÀZ>Œ×&Ë;ÀÅ‰Y;DHÀþkéU\'Ë;À·Òë©;DHÀÂÉ\ZÏ\'Ë;À6t‡ü;DHÀ™Æ`F(Ë;À¼ü\nP<DHÀBÏû¾(Ë;À\n¿$£<DHÀ°R,<)Ë;ÀÞ\rƒô<DHÀ&”½)Ë;À}D=DHÀô-±B*Ë;À–½W‘=DHÀ–TOÎ*Ë;ÀDIÚ=DHÀ·ê;c+Ë;ÀNš™>DHÀëæC,Ë;Àf*¾X>DHÀéâ^À,Ë;ÀR§JŠ>DHÀ6?…-Ë;ÀÝã4®>DHÀ¦Ê{M.Ë;ÀsÙ€Ì>DHÀÈ¬/Ë;ÀÚ2í>DHÀ€iÒ/Ë;À€ÐM?DHÀþÎ-—0Ë;À&O?DHÀý\rm[1Ë;À¬íº†?DHÀèHœ2Ë;À£v¾?DHÀîŽ0ä2Ë;Àñ\"Áõ?DHÀíž©3Ë;À‰Ç,@DHÀC¥¨`4Ë;À@tH]@DHÀk\r5Ë;À@%&Ž@DHÀ²dÅÏ5Ë;ÀJ ¾@DHÀ·È‡6Ë;À­‹·î@DHÀö…@7Ë;À¼mADHÀlAL8Ë;ÀWj·JADHÀ½¢Ò8Ë;À¦w¨oADHÀ³æÜž9Ë;À1ÐH“ADHÀÑFãg:Ë;À·` »ADHÀâÿ‰(;Ë;Àƒ·îADHÀ@ôê;Ë;ÀÁš-BDHÀ¼íè¨<Ë;À’ú­mBDHÀ4UÝe=Ë;À•æ¯BDHÀî—¹!>Ë;ÀÂ¹óBDHÀÇIÝ>Ë;À¶Î½6CDHÀqãŒ?Ë;ÀdquCDHÀÜð:@Ë;À1Ï´CDHÀ#Vé@Ë;Àü¿÷òCDHÀTSÒ–AË;Àçæ·2DDHÀìBBË;Àóô¾sDDHÀLÀ/çBË;À›.´DDHÀÈ‰CË;À9m\röDDHÀ‘¥™*DË;Àðë8EDHÀhÜæÊDË;À¦Z|EDHÀr÷kEË;Àê¿EDHÀVhFË;Àœ÷FDHÀ–rÞ˜FË;ÀþcZHFDHÀPl.GË;Àÿ”FDHÀ»ÇGË;Àð½WÐFDHÀ:TÐeHË;À–LGDHÀþ_»	IË;ÀÓõ\\IGDHÀH¢Ç­IË;À£]N„GDHÀuèQJË;À“¢,¿GDHÀ1öJË;À1úGDHÀ,.5šKË;Àcøà4HDHÀ@`¸RLË;Àc¸#wHDHÀa0MË;À‘êk¹HDHÀZz¶ÃMË;À\\©ûHDHÀ†ùc|NË;À1ƒÊ=IDHÀ‰)R5OË;Àd×¿IDHÀœïÈäOË;À`iU·IDHÀ%û\0œPË;ÀI5¶æIDHÀñ“XQË;À’ÝéJDHÀ\ZîRË;À>ø8JDHÀ<”¿ÒRË;ÀÀNèaJDHÀ…r‡SË;Ày‚‰JDHÀÇ†D<TË;ÀŽ·Ô¯JDHÀ™uñTË;À •ÖJDHÀ«uÍ¥UË;ÀŒ‹ýJDHÀ¹äqXVË;ÀuZe\'KDHÀ„yWË;ÀUKDHÀqÖyÅWË;À§jóƒKDHÀ¡C»zXË;À2à½³KDHÀ´O„/YË;ÀÛ\"äKDHÀÊûäYË;ÀIÇÑLDHÀã‘ZË;ÀñlCLDHÀý·ð?[Ë;ÀôgûpLDHÀ¬/í[Ë;À¾:ÄŸLDHÀHÙŠ˜\\Ë;ÀÖhŒÐLDHÀ&\"í@]Ë;ÀÂuyMDHÀ°ÊXð]Ë;ÀH*b=MDHÀŒ’Ÿ^Ë;À@ÙvvMDHÀ›²N_Ë;À[…¢¯MDHÀ4áÎý_Ë;ÀI1ÐèMDHÀQº\0­`Ë;À Þê!NDHÀ¥ËŠWaË;À½¶mYNDHÀ×bË;À/ôîNDHÀoïª¬bË;ÀpâfÈNDHÀ(RWcË;ÀmÌÍÿNDHÀpðdË;Àý7ODHÀdÙ¤dË;À/ kgODHÀ¨%fJeË;ÀáAõ’ODHÀåžóeË;À?Ô\n¼ODHÀ,Ù›fË;ÀFHüäODHÀ$LÖBgË;Àd\ZPDHÀ1òôögË;À\ZÙQ@PDHÀÔûªhË;ÀÙNŸpPDHÀƒ]iË;À¦ø¢PDHÀHbejË;ÀÈTÙPDHÀÌt´jË;ÀgÔ§QDHÀ ¡ÁLkË;ÀåSËSQDHÀÀ‡\\àkË;À	5•QDHÀæ•plË;À™åwØQDHÀ`yÿlË;ÀrÔRDHÀü‚mË;ÀVoÝaRDHÀrh.\"nË;ÀæO©RDHÀáu¶nË;À´¨îðRDHÀ•3JoË;À^LÙ8SDHÀn	AÝoË;Àéf/SDHÀezopË;À$ŽÊSDHÀš•˜ópË;À–Ç!TDHÀëŠsqË;ÀØlòXTDHÀ‘•8ñqË;À½{˜¢TDHÀ­[IqrË;Àò)ëTDHÀx„örË;À%Í¼0UDHÀOl‹sË;ÀX’YzUDHÀ}BÓ-tË;À¸’ÁUDHÀ	¢ëÍtË;À}Ç¾VDHÀâ$YpuË;ÀÆˆ8JVDHÀ÷d vË;ÀËïWŒVDHÀÒsÜ­vË;À:3¤ÇVDHÀ\'ZÂHwË;À~x}WDHÀÈšäwË;À>ó:WDHÀê¼‘~xË;Àì\\uWDHÀwDþyË;À¡¤ð°WDHÀóú×ªyË;ÀçŽQíWDHÀ±™=zË;ÀœX}*XDHÀ%†$ÏzË;Àm6‘hXDHÀÀµZ_{Ë;À•]ª§XDHÀÃ»î{Ë;À5æçXDHÀÔrQ€|Ë;À8±p+YDHÀºî}Ë;Àâ¦×oYDHÀ@¢‹ }Ë;ÀGÙµYDHÀ|Ç.~Ë;ÀÕ<ûYDHÀ9…ä»~Ë;ÀÇÛAZDHÀ±¥¯LË;Àô;ZDHÀižÛË;À\"MÄÙZDHÀkzÑh€Ë;À“ZÒ&[DHÀÚEª÷€Ë;À;Ä4s[DHÀÛ_‰Ë;ÀƒéÝ½[DHÀÄ‚Ë;Àn*\\DHÀ*æ›‚Ë;À!€´C\\DHÀvÒ&ƒË;Àñ^„…\\DHÀsˆÏ²ƒË;À‹ñ Æ\\DHÀ‡š×?„Ë;ÀBv]DHÀeçøæ„Ë;ÀívR]DHÀ×Ö¡Ž…Ë;À\'Ð„]DHÀ~„7†Ë;À´Øýç]DHÀ\rKà†Ë;ÀéÎ1^DHÀV«Š‡Ë;ÀbXÚz^DHÀ®ì@*ˆË;Àu `½^DHÀ¨Ç5ËˆË;Àò˜Ùþ^DHÀ‘Rll‰Ë;ÀCx@_DHÀ´ÁÆŠË;Àîu‚_DHÀ]I\'«ŠË;ÀFGiÅ_DHÀŠm%‹Ë;À•	ú_DHÀ†¿Ùž‹Ë;À½ š/`DHÀˆ±ŒË;Àô›³d`DHÀŠ’ŒË;ÀŒÌ™`DHÀ\'£dË;ÀøäÎ`DHÀ´ì?VË;Àí½KøaDHÀï\0ïˆË;Àßö\ZbDHÀ:ŠL¼Ë;ÀnñQ-bDHÀÅ0ÉðË;ÀWëëFbDHÀõžÕ&Ë;À>!ä_bDHÀ`â^Ë;ÀâÐ5xbDHÀ/€¤úË;ÀHû.±bDHÀrdàŸ‘Ë;À/ñ%ßbDHÀMbL’Ë;ÀUÀcDHÀ}¨õý’Ë;ÀÊ£ cDHÀWóf²“Ë;À òu7cDHÀ[¨r”Ë;ÀáÅÀKcDHÀ\n:ú2•Ë;Àê9x]cDHÀh‘ó•Ë;Àƒ\Z¢lcDHÀu£ ´–Ë;À4DycDHÀL\\v—Ë;ÀÆRdƒcDHÀW×6˜Ë;ÀmAŠcDHÀ\'.ãõ˜Ë;ÀH¯cDHÀÇYÚµ™Ë;À¢úvcDHÀGÁušË;ÀÁî`”cDHÀ™q5›Ë;Àì¸u›cDHÀÚ—æœË;Àß/Ü¦cDHÀ\Zç½áœË;ÀÆé½µcDHÀ®¡ÒµË;ÀïàÊcDHÀñl\0‡žË;À3‡çcDHÀkð\"TŸË;Àør8dDHÀÓž Ë;À¡%È:dDHÀŽFô¿ Ë;Àæ`àhdDHÀÌ`/q¡Ë;À\'Pó˜dDHÀ eÿ ¢Ë;À7sÊdDHÀ7ÎªÐ¢Ë;À‘÷ÑüdDHÀÂŸr‚£Ë;Àµ~t1eDHÀ3p:4¤Ë;ÀòfeDHÀ½Aæ¤Ë;ÀH¹šeDHÀ/Ê—¥Ë;Àž\\ÏeDHÀ â‘I¦Ë;À£þfDHÀ±xó¦Ë;ÀÜ3fDHÀp®¡§Ë;À§sÃ]fDHÀ.ÌaQ¨Ë;Àz5…fDHÀYKG©Ë;À]3‰ªfDHÀu\Z¹µ©Ë;ÀÏ9âÎfDHÀÞÇdªË;À¬s2ñfDHÀ‡kO«Ë;ÀÆ¿ñgDHÀ>¸nÄ«Ë;À¾ìý1gDHÀM[\\t¬Ë;À¨È4RgDHÀš‰#­Ë;À™!tsgDHÀ[-ýß­Ë;Àá÷pœgDHÀ´}™®Ë;ÀœƒÊgDHÀÊ~çR¯Ë;ÀÎCøgDHÀe°Ë;Àb¶ó!hDHÀ¹š÷Ð°Ë;Àw[ChDHÀä©ƒ±Ë;À?YhDHÀžJ¨7²Ë;ÀªÐhhDHÀ©fzì²Ë;Àô>ÌthDHÀù½¤¡³Ë;À‚á8hDHÀ›¬V´Ë;ÀÝ¥=ŠhDHÀ¿×Ô,µË;ÀiW¯’hDHÀù6æ¶Ë;À¹Û”hDHÀe[Ü¶Ë;ÀÒMi˜hDHÀÒá­°·Ë;À,¨¥hDHÀóX¸Ë;ÀY¦OÂhDHÀÄÛü2¹Ë;ÀÄ<NçhDHÀd¼ä¹Ë;À¶iDHÀ=ët•ºË;À“Æ5iDHÀ:ßF»Ë;ÀMR]iDHÀDOM÷»Ë;ÀÃrŽ„iDHÀ¬Su©¼Ë;À>àçªiDHÀ;h§[½Ë;ÀÍ[7ÑiDHÀÆ?Ü\r¾Ë;ÀÞ˜„÷iDHÀoÀ¾Ë;ÀPJ×jDHÀV1r¿Ë;À6%7DjDHÀJÆ™#ÀË;Àþc\rljDHÀ=»~ÓÀË;ÀÏ»•jDHÀ4ÝƒÁË;ÀÂÓÀjDHÀi3ÂË;À• ·éjDHÀÊe\0æÂË;Àì’kDHÀ´[BœÃË;ÀÞf(4kDHÀ&·êUÄË;ÀXŒOkDHÀß«ÅË;À8ÝekDHÀ·nïÏÅË;ÀŽqÔukDHÀˆ4ŒŽÆË;Àæ‘CƒkDHÀY¶NÇË;À@œ”ŒkDHÀýÈË;À0Î‘kDHÀ‹.9ÎÈË;À£¦u•kDHÀm=ŽÉË;À6XškDHÀ\\ÝÞMÊË;À¾Ÿ#¢kDHÀGv\ZËË;ÀxŠ?­kDHÀðâæËË;Àmš^¹kDHÀÍTt²ÌË;À\Z¢ÕÈkDHÀcy|ÍË;ÀÉqùÝkDHÀÐ(@DÎË;ÀƒÜûkDHÀíT:ÏË;ÀK›slDHÀ¡Ðì¹ÏË;ÀÞôËHlDHÀ$F½pÐË;À¹tlDHÀJ[(ÑË;Ào¹fžlDHÀc»NâÑË;ÀñÄ˜ÄlDHÀ|$\n¥ÒË;À¶çèlDHÀ¾¡ÇgÓË;ÀZ3\rmDHÀ§+ˆ*ÔË;Àk{1mDHÀœ¹LíÔË;Àrß¼UmDHÀÿB°ÕË;À0^õymDHÀ ŸÏrÖË;À?;žmDHÀ§æ5×Ë;Àá+4ÂmDHÀèwUø×Ë;À†CGæmDHÀiµ»ØË;À.–[\nnDHÀ1Ö}ÙË;À16x.nDHÀ62yCÚË;ÀL“lVnDHÀ$\rÛË;À½†‚nDHÀ÷¤€ÈÛË;À¢.°nDHÀÄ\r‹ÜË;ÀÐÜnDHÀ»\\ÛOÝË;ÀK2ÔoDHÀÝÌVàÝË;Àcð=\ZoDHÀÃuÞË;ÀÑš$oDHÀ^L´ßË;À0ì¹*oDHÀœ,¢ßË;À©Ãn2oDHÀoÂ96àË;Àcè‰AoDHÀ ñå]áË;À{:~poDHÀu©âË;À?ˆ¨oDHÀŒ‡›ãË;À›ÌžéoDHÀy…±äË;Àxº3pDHÀÄ#§ÁåË;À4`Ñ†pDHÀa5rYæË;ÀELRÅpDHÀ±ÝßæË;ÀÜ¸qDHÀ«qÍ`çË;À))\'^qDHÀ^])èçË;Às!þ¦qDHÀ¦¦ÖèË;Àê$ÊáqDHÀžÍÍ\'éË;À¼a{rDHÀªÐéË;À\rA÷;rDHÀý×’zêË;ÀŠ?drDHÀ@ñ›\'ëË;ÀCV‰rDHÀ¯;×ëË;ÀÚ<«rDHÀêÍäœìË;Àß…¿ÏrDHÀ›ï^bíË;ÀÍæÍórDHÀU”—(îË;À3a¬sDHÀÇ\\|ðîË;À³Ÿ3sDHÀžéúºïË;À˜œìKsDHÀ½‡qðË;À¢Y]sDHÀ\Zy(ñË;À[´\0msDHÀ	ŽßñË;Àƒ¸î{sDHÀU†–òË;À<”0‹sDHÀM` MóË;À2-Ó›sDHÀSFáôË;ÀŽ3™¯sDHÀCrÜôË;À?‰ÄsDHÀ¸¯Ð£õË;ÀI ÙsDHÀ\0øjöË;ÀäØ–îsDHÀ›*å1÷Ë;À¯StDHÀ\0£µõ÷Ë;Àn4#tDHÀè!ÉµøË;À5\"AMtDHÀuuùË;À5axtDHÀŸ¬6úË;Àâ_\'™tDHÀPYvýúË;Àï¨#¦tDHÀj®J¼ûË;ÀÆâb£tDHÀIë{üË;À9StDHÀ®öÚ9ýË;Àv¥°•tDHÀX·®øýË;À’Ç7ŽtDHÀš·þË;À‡Î¤ˆtDHÀHš~vÿË;À””„tDHÀ`Ñb5\0Ì;À/w€€tDHÀ£LGô\0Ì;À|õp|tDHÀMž,³Ì;ÀnxtDHÀÏZrÌ;ÀÄttDHÀÁ¸ù0Ì;À•¶ptDHÀ³ÛáïÌ;ÀVOmtDHÀ¥æÊ®Ì;ÀèifitDHÀ÷³mÌ;ÀujÄetDHÀì.œ,Ì;À	RbtDHÀ5ÍJëÌ;ÀÝo$^tDHÀHUì©Ì;À¨Š˜YtDHÀ=ÊyhÌ;ÀðTtDHÀF0ì&	Ì;Àwì/MtDHÀa‰<å	Ì;À\"Î—DtDHÀð–ø£\nÌ;ÀŒ.P7tDHÀFRSaÌ;Àa¼ª$tDHÀ„\rÌ;À`]tDHÀƒóåÚÌ;ÀM÷­úsDHÀJgž˜\rÌ;ÀZo\nésDHÀú¿#VÌ;À†$¶ÙsDHÀ2mºÌ;ÀèöyÊsDHÀÐCŠÑÌ;Àñb¼sDHÀš»Ì;Àù~°sDHÀ<»tNÌ;Àà‹Ø§sDHÀ‹Q?\rÌ;À>¡²¡sDHÀIÌÌ;ÀÏ´QœsDHÀýCøŠÌ;ÀùûQ—sDHÀšâ×IÌ;Àâ®O’sDHÀÆ¯Ì;ÀçŒsDHÀ8«ÆÌ;Àˆ­S‡sDHÀÂ‰¤„Ì;À\\ÀsDHÀÔŽ“BÌ;ÀUàÃ{sDHÀ4p\0Ì;ÀÎ+ôtsDHÀM	2¾Ì;À±ÅçlsDHÀuõ}Ì;À«×!_sDHÀÇÒ;\ZÌ;À´ØýIsDHÀ;¶¡ø\ZÌ;Àá0sDHÀ«¯<µÌ;Àtž0sDHÀÛ³{rÌ;À<ßQ\0sDHÀ…i/Ì;À“LØírDHÀj¯<íÌ;ÀiåßÝrDHÀ]_‡«Ì;ÀA<ÏrDHÀä\'ÚiÌ;À»ä,ÀrDHÀ Æ\' Ì;ÀÎpÏ¯rDHÀ¸žpö Ì;ÀPçBrDHÀMV`µ!Ì;ÀÄP.rDHÀÉUg\"Ì;ÀÍqBÐqDHÀ¨–#Ì;Àº\\a€qDHÀbT¯#Ì;À?ðöWqDHÀ¹¹öÚ#Ì;À¤ÀÓƒqDHÀŸ*ûŽ#Ì;ÀîBüqDHÀ×3ì #Ì;Àß˜µ‘rDHÀ¥VTæ\"Ì;À„¿¡sDHÀ™¾4#Ì;Àx$zUsDHÀŽŒcð#Ì;À¸‰fcsDHÀ@a¶±$Ì;À!=(ksDHÀ„Ùàt%Ì;ÀßôÎksDHÀ|<\r6&Ì;ÀgjdsDHÀ.Ðeñ&Ì;ÀòH\nTsDHÀ/}@­\'Ì;ÀkY{6sDHÀš‡Rh(Ì;À‘ôðsDHÀ¢}#)Ì;À¥z¶årDHÀÝm¡ß)Ì;ÀÏJÃrDHÀ±ª *Ì;ÀÞÅ^¯rDHÀ6â^+Ì;À\\€ÕµrDHÀº‡,Ì;Àïf²ÒrDHÀ)Ãxá,Ì;Àg÷“÷rDHÀ\nEK£-Ì;À¯°sDHÀbhd.Ì;À˜ßsDHÀúèe!/Ì;Àè^sDHÀàÞaß/Ì;À™AYsDHÀ–e0Ì;À‚Â8îrDHÀX¹zZ1Ì;ÀÖ\rhÒrDHÀòª2Ì;ÀhÉQ³rDHÀü	DÇ2Ì;ÀÐp\nƒrDHÀN&öl3Ì;ÀnàQ>rDHÀÒ5\\\r4Ì;ÀÔeªöqDHÀÁ+¯4Ì;À~M–½qDHÀïö¯X5Ì;Àqä—¤qDHÀ°¡Å6Ì;ÀA·ø²qDHÀPÁ°6Ì;ÀGF‹ÚqDHÀ-Ñà_7Ì;ÀaÿêrDHÀÛ¶c8Ì;ÀTO³;rDHÀëgˆÅ8Ì;ÀV¢XrDHÀùêWƒ9Ì;ÀsderDHÀü¨ÀC:Ì;ÀèÇnrDHÀŒan;Ì;Àr¼ZwrDHÀÒÇ;Ì;Àˆ‡ÒrDHÀ+»G‡<Ì;Àà¢árDHÀFb¼M=Ì;À™¤rDHÀ¿s]>Ì;À—ž&»rDHÀaÁãÔ>Ì;À6Œ(×rDHÀ^!•?Ì;ÀÓûrDHÀ€eƒR@Ì;ÀUV)sDHÀ·2kAÌ;À©Ø#bsDHÀ/Žç¤AÌ;À3‹J¤sDHÀ[²Û9BÌ;Àä75îsDHÀÄÚ*ÅBÌ;À8ûN>tDHÀÞA¸ICÌ;Àð“tDHÀEÅ¾»CÌ;Àº÷ÚãtDHÀ÷ó3&DÌ;ÀBåí6uDHÀ†§DÌ;ÀyÑîŠuDHÀRW§öDÌ;À\"ÔÞuDHÀîÄeEÌ;ÀŠ‡0vDHÀ!.fäEÌ;À‹$»ŽvDHÀÔ_ÕaFÌ;À¬P\rîvDHÀKÞèFÌ;À`\0SGwDHÀåŠL„GÌ;À\Zªa“wDHÀþPí>HÌ;ÀPÄËwDHÀå þHÌ;À0<èwDHÀNPe¾IÌ;ÀXeªówDHÀ—Ï?~JÌ;À#t˜ówDHÀVi2>KÌ;ÀuEîwDHÀñ?þKÌ;À4ïéwDHÀ÷=½LÌ;ÀÜfèwDHÀ}D|MÌ;Àç‹±æwDHÀµ@;NÌ;ÀÉåèãwDHÀþNúNÌ;Àµ_%ßwDHÀ½ÀÈ¸OÌ;ÀÂ¹×wDHÀW45xPÌ;ÀÇóËwDHÀÊÊ76QÌ;À€\"b¹wDHÀµ¼óQÌ;À÷-~£wDHÀ Aø®RÌ;ÀükŠwDHÀ]”2jSÌ;À$t3owDHÀŠL­)TÌ;ÀXNKwDHÀ}dAãTÌ;À˜xuwDHÀüÂ¥šUÌ;À@–ÄìvDHÀR‘SVÌ;À:Kg¿vDHÀÍúºWÌ;Àú;Å›vDHÀ°}¯ËWÌ;À˜íóˆvDHÀt¿‰XÌ;ÀO¯·vDHÀó½IYÌ;ÀÞ;Ò~vDHÀB7ÉZÌ;ÀÑKyvDHÀ6ÁÅZÌ;À´—ivDHÀ9Ôˆ[Ì;À˜ùOvDHÀØÇK\\Ì;ÀŸ~Ú3vDHÀÒ»]Ì;ÀdÍ¯vDHÀ´›óÃ]Ì;À&²qæuDHÀ#ës^Ì;À\rï¯uDHÀÃ@û_Ì;À‡9#tuDHÀýÈ¨_Ì;ÀÐ·æ7uDHÀaÒ/?`Ì;ÀoL«útDHÀCrhÔ`Ì;À‘Û¸¼tDHÀZ‘«iaÌ;ÀÖHW~tDHÀ‰3óbÌ;ÀØ[B:tDHÀ|3v¦bÌ;À´âôsDHÀŽœ¤CcÌ;ÀèæJ¯sDHÀÿxîácÌ;À¸ˆjsDHÀ[ÖÃ‚dÌ;Àì.½\'sDHÀ–øü!eÌ;ÀeÞYórDHÀïê¸ÍeÌ;À?Ñ:ËrDHÀýÓfÌ;ÀJÙ¨rDHÀÜ=/gÌ;À¼‹®…rDHÀ)I×gÌ;À­Õ3[rDHÀo&GohÌ;ÀÀÃ$rDHÀ¯dþhÌ;ÀGgºäqDHÀxÏ‹iÌ;Àª\'ã¡qDHÀK‘¾jÌ;À7[cqDHÀÿÚ¶jÌ;ÀËœô.qDHÀ×4»nkÌ;À¹×„qDHÀ,´F2lÌ;ÀöiœùpDHÀîåùlÌ;ÀnIÞípDHÀP¾mÌ;À…kíÜpDHÀHwnÌ;À³Æl»pDHÀÃt&/oÌ;ÀÝ‹u„pDHÀY+&áoÌ;ÀÔš4EpDHÀ0’pÌ;ÀÝ<&pDHÀ\'FøFqÌ;À!ºÆÇoDHÀø3ìrÌ;Àã[’–oDHÀ¥˜EÃrÌ;ÀÓŠnoDHÀÝ­õsÌ;À$|ïFoDHÀôÐ\rAtÌ;Àû)áoDHÀ<_Ÿ\0uÌ;À§¯€ùnDHÀ#·»ÀuÌ;ÀßîÓnDHÀ°zyvÌ;À»…°nDHÀð¥b2wÌ;À²½unDHÀV9eëwÌ;ÀU¢jnDHÀ9ˆq¤xÌ;ÀLâìGnDHÀ\'Sw]yÌ;À´8%nDHÀ§BÍzÌ;À.ˆ\"nDHÀ¶¬=×zÌ;Àa†nDHÀô€E–{Ì;ÀödU÷mDHÀ³«aS|Ì;ÀBÚØmDHÀÇ}Ì;À™œZ˜mDHÀ4Fû}Ì;À†(&@mDHÀ\nŠÖ}Ì;ÀÌªÝlDHÀ<ñ«ð}Ì;À¶s#ulDHÀ†~ö}Ì;ÀÿË\nlDHÀkOý}Ì;ÀàvÜ¢kDHÀ\'‡Àß}Ì;ÀÀ½æ<kDHÀçÿ¶Œ}Ì;À©™ÖjDHÀø’95}Ì;À—bApjDHÀZ\n}Ì;ÀÖ*\njDHÀ\r`6>}Ì;ÀïåŸ¤iDHÀ¼A»}Ì;À*f@KiDHÀ­æL~Ì;ÀlIViDHÀPýÝì~Ì;ÀÝÇÆÑhDHÀ4)™Ì;Àw¯hDHÀz:ƒL€Ì;À´tLhDHÀ¢…Ž\nÌ;ÀŒxf’hDHÀŽ›ÈÌ;À=ì–‡hDHÀÞ¨†‚Ì;À\ZrÐ|hDHÀbý´DƒÌ;Àæ«rhDHÀ&t¾„Ì;À=)ghDHÀ ¾Á„Ì;À+;\\hDHÀ9öq…Ì;ÀäõIQhDHÀwéÉ=†Ì;À2¥OFhDHÀ,j ü†Ì;ÀÄAF;hDHÀªDuº‡Ì;ÀºÒ\'0hDHÀãx„ˆÌ;À±¸hDHÀO6gE‰Ì;Àå\'*ñgDHÀúJÿ‰Ì;ÀH‡XºgDHÀñ„z±ŠÌ;Àe  ygDHÀD²i]‹Ì;ÀÜC]1gDHÀ˜µºå‹Ì;À¦\ZëfDHÀ„‘[ŒÌ;À>{fDHÀuÜ>ÊŒÌ;Àa ˜LfDHÀm}=Ì;ÀãÚŠüeDHÀ›$`¿Ì;À\Zÿj±eDHÀñlV^ŽÌ;ÀîLìbeDHÀs‹\0Ì;Àcê«eDHÀðók¨Ì;À¿úÕdDHÀ„¥fXÌ;À’³)ždDHÀíè‘Ì;À¥°‰tdDHÀÁé¤Ð‘Ì;À,ØqmdDHÀÜT‘’Ì;À—#Ö‹dDHÀaáÁS“Ì;À©h»dDHÀi«¹”Ì;ÀÈ}ÛçdDHÀ#àÙ”Ì;À¤µàüdDHÀÓ4i”•Ì;À+1ÖþdDHÀ+…ÅR–Ì;À%ðtüdDHÀ®)r—Ì;Àã…¡ðdDHÀ‘wÅÍ—Ì;À)…@ÖdDHÀ>Æ…˜Ì;ÀF6¨dDHÀ”éï™Ì;À§f_ddDHÀ¿Xü†™Ì;ÀH	dDHÀ¤á™Ì;ÀŽ8]±cDHÀðR;šÌ;ÀSÃaWcDHÀ¤>n¦šÌ;Àmx4cDHÀ™šì[›Ì;ÀÆ`ÌbDHÀmŠAœÌ;ÀƒÛøbDHÀÇFE&Ì;ÀêÒobDHÀj	ØÛÌ;Àå#Å1bDHÀK*2žÌ;À/º¥ÓaDHÀ\rgP0žÌ;ÀBlaDHÀ/ÄÉžÌ;À6ïÏaDHÀÉáª×Ì;Àä§õš`DHÀ§x¡Ì;À€QÍ1`DHÀûE÷xÌ;Àâ”È_DHÀ`OýDÌ;À(ŠkZ_DHÀ÷²„ûœÌ;Àfæëê^DHÀgLôÂœÌ;À5s{^DHÀ\nô²ÁœÌ;À‚_\r^DHÀo„\'Ì;ÀEÙ¢]DHÀX†ÊÌ;À\"@^]DHÀ6±‘žÌ;À7ú{V]DHÀ\\°eŸÌ;À}Ägn]DHÀËU< Ì;Àñ[%‰]DHÀ`Gí¡Ì;ÀY{÷‰]DHÀ>áÏ¡Ì;ÀJ¨s]DHÀÞ\0v•¢Ì;À¾åà[]DHÀujE[£Ì;À“vA]DHÀ;â·¤Ì;ÀÂ–;#]DHÀ|-â¤Ì;À³T\0]DHÀÝé’¥Ì;À†vøÈ\\DHÀVªÖ0¦Ì;ÀI7~{\\DHÀË¦É¦Ì;À?õ)\\DHÀèw8k§Ì;Àê7¼æ[DHÀ¯çi#¨Ì;ÀëÈ1Ä[DHÀ¦¹œá¨Ì;À¡;Ç¹[DHÀÉ5øŸ©Ì;ÀMK1±[DHÀÜ³u^ªÌ;À\rª[DHÀ8’«Ì;Àa”Ó£[DHÀ¹)¼Û«Ì;Àìö3ž[DHÀ{ÿ–š¬Ì;À\"+™[DHÀ&ŒzY­Ì;ÀÚ~´”[DHÀaI_®Ì;À÷¾Q[DHÀ\"´=×®Ì;ÀÕ’„‹[DHÀF–¯Ì;À¬Î…[DHÀ¸CÙT°Ì;À_	‚{[DHÀñŒF±Ì;Àîˆj[DHÀïHÎ±Ì;À¦¿µT[DHÀäžì‰²Ì;ÀÏãÚ;[DHÀ¶—D³Ì;À\"ÀÊ![DHÀxµ´Ì;À‹ÿo÷ZDHÀ˜MM¼´Ì;ÀƒŸºZDHÀ((pµÌ;À|nzZDHÀ6ù¶(¶Ì;À@%õEZDHÀA²îí¶Ì;À ³I,ZDHÀ›\0­·Ì;À#·%*ZDHÀ^ƒhl¸Ì;À·~ˆ.ZDHÀ<,¹Ì;À\'ý‹5ZDHÀÍ\'§ë¹Ì;ÀÉ%J;ZDHÀÃÕ1«ºÌ;ÀòëÜ;ZDHÀÔWj»Ì;ÀcWŒ8ZDHÀœª)¼Ì;À#65ZDHÀÙóç¼Ì;À`¶Û1ZDHÀ9íÞ¦½Ì;Àux~.ZDHÀ\nóÉe¾Ì;ÀYÑ+ZDHÀæå#¿Ì;ÀƒÜ)ZDHÀ;*â¿Ì;À¶/ *ZDHÀöL< ÀÌ;À‚À.*ZDHÀ¿Ú-^ÁÌ;ÀÄL%ZDHÀTcÈÂÌ;À°6¼ZDHÀUM°¶ÂÌ;Àš%#ìYDHÀcÁÃÌ;Àð5•YDHÀn2baÃÌ;Àl|Ø%YDHÀÿDùÃÌ;Àq°î¯XDHÀ~&íçÃÌ;ÀZq\\EXDHÀˆDÄÌ;À¤ÑXDHÀð¦ï:ÄÌ;À\"-èWDHÀ…?ÂcÄÌ;Àã„\\¹WDHÀe›ÄÌ;À#¹ŠWDHÀEã•¹ÄÌ;À€T\\WDHÀt—óÄÌ;À„úY(WDHÀsy8ÅÌ;ÀR\r]÷VDHÀo‹ù‡ÅÌ;ÀÆäïÌVDHÀ,ËùáÅÌ;ÀE®¤¬VDHÀ×:OEÆÌ;À–\ršVDHÀP³K~ÆÌ;ÀvŒÌ”VDHÀáfd·ÆÌ;ÀhRVDHÀÍD†ðÆÌ;À[#1ŒVDHÀY<ž)ÇÌ;À¡¸ú‡VDHÀ}9™bÇÌ;ÀÒ\"AƒVDHÀ(ÙNØÇÌ;ÀpÔ«xVDHÀ¢=NÈÌ;À	InVDHÀÂu¹ÃÈÌ;À7ÓrcVDHÀw‘h9ÉÌ;À\"Æ³XVDHÀ¯ ¯ÉÌ;ÀñtËMVDHÀQýÛÊÌ;ÀÅ©z3VDHÀä³¸	ÌÌ;À1o©VDHÀ6MÊ5ÍÌ;À,vêûUDHÀÌf¹]ÎÌ;À¯oÐÕUDHÀ&˜\rÏÌ;À°î¢UDHÀëåÁ¸ÏÌ;À¶ú\n—UDHÀ°3vòÏÌ;À/è\'‹UDHÀv*,ÐÌ;À4ÖDUDHÀ;ÏÞeÐÌ;À:ÄasUDHÀ\0“ŸÐÌ;À²±~gUDHÀdtÄÐÌ;ÀzSUDHÀÉËŸèÐÌ;ÀoB„?UDHÀ-#&\rÑÌ;ÀA\n‡+UDHÀ‘z¬1ÑÌ;ÀŸÒ‰UDHÀõÑ2VÑÌ;ÀqšŒUDHÀ!•KäÑÌ;À(V1®TDHÀÛòShÒÌ;Àd:‚TTDHÀ²2ëÒÌ;À%¥ùSDHÀ#ÌuÓÌ;Àýò¿ SDHÀ‡FÔÌ;Àü€øLSDHÀŒîKÝÔÌ;À þ_ûRDHÀŽrÝºÕÌ;Àë\0®¾RDHÀ8Ë¥¤ÖÌ;ÀJdï’RDHÀMò•×Ì;ÀD1tRDHÀá~ˆØÌ;ÀÅ»^RDHÀ+FÙÌ;ÀwåXPRDHÀö­œÚÌ;Àv.CRDHÀ>WÏÂÚÌ;ÀêÁj7RDHÀGÛÌ;ÀŠÁz-RDHÀ•Õ%@ÜÌ;À—«É%RDHÀÎä©þÜÌ;ÀJ8°RDHÀÁ3½ÝÌ;Àg\Z\Z\ZRDHÀÎ¬¿{ÞÌ;À¥;ßRDHÀV<N:ßÌ;ÀÑ†×RDHÀ¡!ÝøßÌ;ÀˆäÚ\nRDHÀ30÷·àÌ;ÀÒí|RDHÀ	uwáÌ;ÀùƒÍýQDHÀ)™Z6âÌ;À€¸SúQDHÀÌGÑõâÌ;ÀÑ›–ýQDHÀ+”µãÌ;À<=RDHÀ_\\cäÌ;ÀAR÷:RDHÀ\"1­ãäÌ;À—\Zã’RDHÀ§rNåÌ;À£-ÔþRDHÀøò¼åÌ;Àq$¾jSDHÀ–ƒDæÌ;Àg–”ÂSDHÀA™¨ÔæÌ;Àx{TDHÀÝÚÌhçÌ;ÀéäÚ>TDHÀc¼ÔýçÌ;ÀF˜\n|TDHÀœ¯‘èÌ;À\0Æ`ºTDHÀœ)ÑéÌ;À£4ûTDHÀ74’éÌ;ÀSÅæ5UDHÀ!°ùÿéÌ;ÀÑiÇsUDHÀVu-mêÌ;ÀFv9²UDHÀ8fÛÝêÌ;À6m îUDHÀLbVëÌ;ÀäÓ_&VDHÀ,èìÌ;Àã)\'lVDHÀsÇ1¿ìÌ;À¸K¬VDHÀ°AzíÌ;À¡ÂèVDHÀ¶¦£8îÌ;À¨~#WDHÀøîÌ;ÀÙÝu^WDHÀnw	©ïÌ;ÀîZ•WDHÀŠ\\ZðÌ;ÀyÉWDHÀ@wÔ\rñÌ;Àü„ØúWDHÀõ{:ÅñÌ;ÀžÍ\'XDHÀÕW‚òÌ;Àû>QOXDHÀ_÷>=óÌ;À´LL^XDHÀÃÉüóÌ;ÀÂ\'QXDHÀØêC¾ôÌ;À6§8XDHÀ&ù~õÌ;À5ß&XDHÀ°)5<öÌ;À§‰(*XDHÀä¸þüöÌ;À=‡AXDHÀÈºB½÷Ì;À¶Œ[XDHÀ3AÙ|øÌ;À•ßwXDHÀ.`š;ùÌ;Àíï#–XDHÀ’)^ùùÌ;À÷\0¶XDHÀ/û¹«úÌ;À/WÂÚXDHÀª®ZûÌ;ÀŸÈUYDHÀµüÌ;Àµá\\2YDHÀ6~:¹üÌ;ÀÕ8yXYDHÀ9{qýÌ;À×cLrYDHÀT~ÕãýÌ;ÀNß uYDHÀ´>„VþÌ;À³ÝïmYDHÀÅ9ÉþÌ;ÀÙxÈ`YDHÀœ<ÿÌ;À=Ì¹SYDHÀ*<ý®ÿÌ;À?òRLYDHÀL‘ü€\0Í;ÀBŸ=HYDHÀér_SÍ;ÀqHØFYDHÀŸt\n&Í;À´8‰IYDHÀÚ\'âøÍ;Àš¼¶QYDHÀ8 ËËÍ;À\rÇ`YDHÀ½}YƒÍ;À1ÌøwYDHÀŸq:5Í;À[±$YDHÀ[ÚÍ;ÀÏ#RÑYDHÀL˜•jÍ;ÀÍxˆZDHÀŒ‰`ßÍ;ÀÏjZDHÀ³=z8Í;ÀßCÒZDHÀ ó,uÍ;ÀÇl°<[DHÀÝ¤Í;ÀÛ<¨[DHÀ.úÓÍ;Àvd\\DHÀNcÍ;À0±N{\\DHÀù^áQÍ;ÀôåÐ\\DHÀlBžÍ;ÀêV&]DHÀs\"ÓÍ;À€ù{]DHÀô^±	Í;À$é€Î]DHÀ‰Töp	Í;À· ^DHÀ;®ä	Í;ÀO8M|^DHÀÝ˜¬d\nÍ;Àw5`Ñ^DHÀ“û¶ñ\nÍ;À\0#\"_DHÀëÁŠÍ;À¾ee_DHÀ:ÕŽ,Í;Àƒû£_DHÀá¤ºÍ;À•\'(Õ_DHÀœéCI\rÍ;ÀÉ£ƒ`DHÀ¹^Ø\rÍ;ÀQÊ€5`DHÀ	²ÒfÍ;ÀÜ’e`DHÀ‰RõÍ;À¢-–`DHÀŸý”Í;ÀSêÌ`DHÀtŠ¨4Í;À3maDHÀ˜p¨ÓÍ;Àö`²:aDHÀÌ‘…qÍ;ÀîC·saDHÀ¸´È\rÍ;À¡Ãx¯aDHÀtlb¯Í;ÀùÌXÿaDHÀ!o4Í;ÀËÔß^bDHÀÔÁ£Í;À4!ÉbDHÀŒ9•Í;ÀF09cDHÀ+tVÍ;ÀŠb ªcDHÀyÁ¢Í;ÀÅ¸PdDHÀ®«yïÍ;À|dDHÀÉE2<Í;Àog±ådDHÀËÞêˆÍ;ÀQ¿áNeDHÀ™u£ÕÍ;À¿¸eDHÀh\\\"Í;ÀGqB!fDHÀ¡oÍ;ÀÏÊrŠfDHÀ 5Í»Í;Àp%£ófDHÀÈ…Í;Àž€Ó\\gDHÀXY>UÍ;ÀYÜÆgDHÀˆµÇ Í;À“-hDHÀ€_ìÍ;Àr‹•hDHÀ/å8Í;ÀâW™ühDHÀZïƒÍ;ÀŒŠdiDHÀ°8ÐÍ;À‘´€ËiDHÀ©…*Í;ÀÊîM2jDHÀ\\+6sÍ;Àf~ã—jDHÀ@ZÎÊÍ;À‹ã‘üjDHÀf>$\ZÍ;ÀE©`kDHÀGM\ZÍ;À-+{ÄkDHÀ~-†Ô\ZÍ;À÷!lDHÀ+á*Í;À\ZWlDHÀYnàÍ;Àää¤ÜlDHÀ}$ÊÕÍ;À¯åé9mDHÀ¼O·+Í;À	–0—mDHÀÜ6ÆÍ;ÀdæRòmDHÀ}˜0ÔÍ;À\'QMnDHÀÌŠ8)Í;À¯Ÿ#¨nDHÀá\" Í;ÀWßÂoDHÀ¶t)ÖÍ;ÀF\']oDHÀ\ZI<Í;Àá%³ºoDHÀþ¯Í;Àmš\rpDHÀ2n.Í;ÀF}CgpDHÀè-á³Í;À¤©a¸pDHÀóp×< Í;À‘øtqDHÀŒu\"Ü Í;ÀÒ‰<_qDHÀJÇ~!Í;Àdž¾´qDHÀ9:|\"\"Í;À:þt	rDHÀf÷Ä\"Í;ÀërÙ^rDHÀˆ›ïc#Í;ÀÆe¶rDHÀ¼+ðó#Í;Às<sDHÀû¹„$Í;Àæ¬ˆWsDHÀ™£%Í;Àj^…©sDHÀ¹C™%Í;À¨™ŒþsDHÀ}õÿ&Í;À»¦0XtDHÀUX&Í;Àúß‹tDHÀ¶2ªš&Í;À9YŽ¿tDHÀ8PÿÜ&Í;À3=ótDHÀÕnT\'Í;ÀÐì&uDHÀXŒ©a\'Í;ÀœæšZuDHÀ³p;(Í;À²…žvDHÀAk,)Í;ÀfŸO¦vDHÀ&í:*Í;À[öêFwDHÀ¹úó*Í;ÀKN­åwDHÀ9öÇá+Í;ÀfjÓƒxDHÀXi`,Í;ÀRåxÑxDHÀ.Wúæ,Í;ÀRK5yDHÀ†¬èo-Í;Àp_ÄcyDHÀÐ¢õ-Í;Àåæá­yDHÀï.”r.Í;ÀÓ¥IüyDHÀh«Ò.Í;À…ÜTzDHÀ~à/Í;À-|\r¸zDHÀÝ†M/Í;À{DHÀÊƒð/Í;ÀyÞK{DHÀ4—qó/Í;À]bÚØ{DHÀ¡’\rD0Í;À¬UP\r|DHÀþþv•0Í;ÀDíjA|DHÀª1*ç0Í;Àu¯cu|DHÀì~£81Í;Àè t©|DHÀ<=_‰1Í;ÀìÇÕÝ|DHÀ¬ÙB*2Í;Àÿ\\K}DHÀm Ç2Í;Àý´¿º}DHÀ¨Af3Í;Àg,†)~DHÀÕð\n4Í;ÀÞ4•~DHÀ9qwº4Í;ÀU5Qû~DHÀsgÄt5Í;ÀJ–!]DHÀ–I‹26Í;ÀÛ—¡¼DHÀEMEò6Í;ÀGlÖ\Z€DHÀ;©k²7Í;À)DÅx€DHÀ5”wq8Í;À3Qs×€DHÀ2S‘ñ8Í;ÀåÆDHÀ\r˜Œq9Í;À¡Õ$XDHÀeàMñ9Í;ÀX<¨˜DHÀÝ©¹p:Í;À¢iÙDHÀHt´ï:Í;Ànà\Z‚DHÀ¸^g^;Í;À_‡k‚DHÀÎš¦;Í;ÀIûÏË‚DHÀ@‚ðÝ;Í;À5¸\'3ƒDHÀ_9\n\Z<Í;À*\"[™ƒDHÀH±‰p<Í;À3#7öƒDHÀÆèú<Í;ÀÄc„DHÀM	\'‰=Í;ÀžÏ„DHÀî:}>Í;ÀF}Â8…DHÀÖB!º>Í;ÀIËž…DHÀbÁIa?Í;ÀxˆKþ…DHÀõôö?Í;Àk1ÆJ†DHÀ($gŽ@Í;Àgö–”†DHÀ·nX\'AÍ;ÀCýÊÝ†DHÀsõ¸½AÍ;Àno(‡DHÀØjNBÍ;Àþm‘v‡DHÀÀ«ÛÑBÍ;À3iÏÁ‡DHÀj<UCÍ;À6™\rˆDHÀø“ØCÍ;ÀUIdXˆDHÀd—ä[DÍ;ÀÆÃµ£ˆDHÀÄ€6ßDÍ;À1RïˆDHÀWƒbEÍ;À°_:‰DHÀëü·åEÍ;ÀuÀ…‰DHÀ=ÎhFÍ;À‹1Ñ‰DHÀZ?ÀëFÍ;À»S¹ŠDHÀ5ƒ†nGÍ;Àìw]hŠDHÀtÚÑGÍ;ÀôÃŠDHÀºÿ¢ÿGÍ;ÀàÀ0‹DHÀÁ…¡HÍ;À{ß‹£‹DHÀ-þd@HÍ;ÀªP‡ŒDHÀ¡úÈ”HÍ;À\'ŸuŒDHÀØGWIÍ;À\r³ÔŒDHÀ1ò œIÍ;ÀÒ	ò2DHÀ)G©!JÍ;ÀÐ&éDHÀ\"“s¦JÍ;ÀÓN\'ïDHÀ‚\")KÍ;À6ù:NŽDHÀ8¥›šKÍ;À	ù2£ŽDHÀßƒLÍ;À²k’øŽDHÀ!Š=|LÍ;Àm–NDHÀ-0OíLÍ;Àv¾`£DHÀ°\'<_MÍ;À•)<øDHÀa~ÃØMÍ;ÀŸ]ŸGDHÀ\r1¨]NÍ;ÀhÉDHÀöîwçNÍ;À-&ý×DHÀDfÀoOÍ;Àw}!‘DHÀEðOÍ;À”8q‘DHÀyN’PÍ;ÀÝKDî‘DHÀ±ˆ¢QÍ;À)‡q’DHÀGL+QÍ;À­`ú’DHÀó›îQÍ;À+©Û‡“DHÀâOZ7RÍ;Àd‡”DHÀîw@RÍ;ÀDÑÙ5”DHÀ”IRÍ;Àe°R”DHÀÂ)±RRÍ;Àk^†o”DHÀÇ(Î[RÍ;À¦\\Œ”DHÀ†íêdRÍ;Àøï2©”DHÀGŽc~RÍ;ÀŠ\'o•DHÀ&hŽRÍ;Àû¥Vt•DHÀûßŸRÍ;ÀafÚ•DHÀ	Tp³RÍ;Àµ@–DHÀ\r(bÓRÍ;À\'1ô¤–DHÀÅjÇSÍ;ÀjM¨—DHÀ¹ˆÀŠSÍ;Àké/w—DHÀXëTÍ;Àd†ª×—DHÀBþ{‰TÍ;Àå£79˜DHÀå*ÅïTÍ;ÀœÂö ˜DHÀŸx:UÍ;ÀY˜™DHÀ%Í”UÍ;ÀÀ¬	j™DHÀä…eÅUÍ;ÀÿÂËÏ™DHÀ¹˜6VÍ;ÀëŸ6šDHÀ ÕSDVÍ;ÀX­œšDHÀØn¶lVÍ;ÀÌÏô›DHÀ´ÿ:VÍ;ÀO½k›DHÀ+AyVÍ;À\n]>Ô›DHÀÿïµVÍ;À\r:ë9œDHÀÁÆWÍ;À²âd˜œDHÀÐtWÍ;À–sßñœDHÀÙë¹ñWÍ;ÀsdDDHÀ&CwXÍ;ÀšÑ’DHÀ©QsYÍ;À‘Å;ÝDHÀ½YÍ;À©\0ç\'žDHÀqƒ”ZÍ;À\n]ŒpžDHÀ2’œZÍ;À­·Ò¸žDHÀé$[Í;ÀrX	ŸDHÀóu¬[Í;À>‡IŸDHÀ¦Ž2\\Í;À„’ŸDHÀáˆ»\\Í;À8ÌÞŸDHÀö‹öB]Í;Àó+ DHÀ#\'½É]Í;À…y DHÀµ¾P^Í;Àà[Ç DHÀ¯ÞØ^Í;Àê¡DHÀ{t”b_Í;Àü	c¡DHÀ}½Ûí_Í;ÀegÐ±¡DHÀ7ËŒ`Í;À\",ü¡DHÀ«o€aÍ;À¼aC=¢DHÀAÉaÍ;À1q¢DHÀW{bÍ;À÷—¢DHÀ	ƒÃ.cÍ;Àfßw¶¢DHÀY*äcÍ;À‡ü‘Ñ¢DHÀìs5šdÍ;ÀØôÁê¢DHÀ(…|PeÍ;ÀíSb£DHÀ˜ûÈfÍ;À-ù½£DHÀ¶_ÐfÍ;ÀÌl4£DHÀtþŒgÍ;À£3½K£DHÀNhÍ;À—ýf£DHÀYaÜiÍ;À/`|‰£DHÀ\n3EµiÍ;À[Yª¯£DHÀû[B`jÍ;Ày•ž×£DHÀJ‡\nkÍ;Àñ@u\0¤DHÀü²Æ´kÍ;À,ˆJ)¤DHÀý]´_lÍ;À—:Q¤DHÀÁ=mÍ;À{zrz¤DHÀ\"æÕÈmÍ;À5–£¤DHÀ(_‚}nÍ;À…Š¡Ì¤DHÀoÀH2oÍ;À¼Q‘õ¤DHÀ;ž.çoÍ;ÀF«a¥DHÀ\n÷¹™pÍ;À¯/ùE¥DHÀÎ—(MqÍ;À¨ð:l¥DHÀkÃºrÍ;ÀÀ¼¥DHÀß½°·rÍ;ÀSp³¥DHÀ÷ÈJosÍ;ÀßÓ×Ò¥DHÀ•‚d\"tÍ;ÀìÚ!ì¥DHÀO¾×tÍ;À¤×ÿ¥DHÀÍøûuÍ;ÀmìI¦DHÀÊIÁCvÍ;ÀÆÌ#¦DHÀ\\	²÷vÍ;ÀÛ\n²:¦DHÀèg¬wÍ;ÀZ[¡U¦DHÀ(öâ`xÍ;ÀÍJ%q¦DHÀWåEyÍ;Àm‹æŒ¦DHÀ€°ÉyÍ;ÀÏÍ¨¦DHÀù¹A~zÍ;À ÃÃÃ¦DHÀ4o”2{Í;ÀÎ˜Ý¦DHÀë1ˆç{Í;Àˆ›)ö¦DHÀ°œ|Í;Àå|S§DHÀbïžQ}Í;ÀfÃó&§DHÀëñç~Í;À:¿ç@§DHÀádÁ~Í;Àý÷f§DHÀLsÍ;ÀcG’—§DHÀHd´!€Í;À]‘ìÎ§DHÀð  Ó€Í;À»Ü¨DHÀ+$LÍ;ÀNª6¨DHÀÕ[A‚Í;ÀfE‚`¨DHÀ 0w÷‚Í;Àx‘§Š¨DHÀŠH®ƒÍ;ÀK«¨DHÀF-`c„Í;À--T¸¨DHÀ…•…Í;À¨òþ¨¨DHÀkµ™É…Í;ÀcÝá…¨DHÀÄ^~†Í;Àáý)a¨DHÀÔi3‡Í;À\0å³;¨DHÀÿÑè‡Í;Àl!\\¨DHÀß(XˆÍ;ÀDÿñ§DHÀÐQoËˆÍ;À#r÷è§DHÀQÎ†ùˆÍ;Àªðß§DHÀ‡<ž\'‰Í;ÀÃgèÖ§DHÀ–:µU‰Í;À~àÍ§DHÀ¤fËƒ‰Í;À’uÖÄ§DHÀË	ŠÍ;À›ÑÁª§DHÀ§ŒÙŠÍ;À·k‘§DHÀÕÝn‹Í;À£–7x§DHÀ&þ‹Í;ÀÆ¦‚`§DHÀœl #ŒÍ;ÀßîXJ§DHÀ‰5|ÚŒÍ;À\nú®?§DHÀ@Q’Í;ÀvëS§DHÀ=…HŽÍ;ÀÎ§DHÀÇØDüŽÍ;ÀŠ~ö¸§DHÀì«Í;ÀÀk´ù§DHÀWÙRÍ;À—\'v>¨DHÀ;—(éÍ;ÀMK˜…¨DHÀýeHx‘Í;À)—Í¨DHÀˆß’Í;ÀÐï©DHÀ´<^œ’Í;À†\\Z©DHÀƒä+“Í;Àÿ…œ©DHÀÖ¿¥¹“Í;À!¶yß©DHÀ^˜K”Í;ÀˆÂªDHÀNµoå”Í;À]–-XªDHÀ¤½CŽ•Í;À½|„ªDHÀ½0T–Í;À\"o¡ªDHÀ÷]—Í;Àn}®ªDHÀ3&cè—Í;ÀœS³ªDHÀRG³˜Í;À»žò·ªDHÀO\\2|™Í;ÀÆ\noÄªDHÀòÇÐ9šÍ;À%j×ªDHÀE‚I÷šÍ;À¦@¥ëªDHÀÁ®Á´›Í;ÀkO \0«DHÀâp^rœÍ;À°BÛ«DHÀíéD0Í;ÀPÖ%«DHÀàžÍ;À%pÚ2«DHÀf£BÔžÍ;À‰X8«DHÀ%fÀ§ŸÍ;À­ú;«DHÀW){ Í;ÀkÐ?«DHÀIi®M¡Í;À~QK«DHÀÅ>	¢Í;Àv¼_«DHÀdzÁ¢Í;À’\"T}«DHÀ²øñu£Í;À¹å#¡«DHÀ%•É\'¤Í;Àì#7È«DHÀ-+ºÖ¤Í;Àè?™ï«DHÀâ8v¥Í;À[\'¬DHÀa×Œ\n¦Í;À*út¬DHÀg¨š¦Í;Àcˆ}Ä¬DHÀ¡áz-§Í;ÀP\0­DHÀFXôÉ§Í;À?\\e­DHÀ×`s¨Í;À»>9­DHÀ÷hz ©Í;Àa³ÆÞ¬DHÀVY+Ï©Í;Àh‘5°¬DHÀ¤\Z4|ªÍ;À!±­|¬DHÀÃ—Ÿ$«Í;ÀÛêVJ¬DHÀÀ.LÆ«Í;ÀQKd¬DHÀS›d¬Í;ÀÖ¸²Ü«DHÀ+‚­Í;ÀWU`¢«DHÀ`¾÷ž­Í;ÀiD‹l«DHÀ*Ôñ>®Í;Àk§Q@«DHÀËŒ£ó®Í;À›K˜(«DHÀØß¶¯Í;À½_ .«DHÀVY}°Í;À¦[M«DHÀ³b<±Í;À!â»‚«DHÀÖŠ^è±Í;À¤Ö²Ê«DHÀÔ‹³y²Í;ÀýzŠ\Z¬DHÀóã÷²Í;À8Rl¬DHÀMØph³Í;Àm»À¬DHÀ+HàÐ³Í;À\0²ˆ­DHÀ¥\0µ6´Í;ÀÆÈâq­DHÀ›\"¦¥´Í;ÀwÿõÕ­DHÀ…¿eµÍ;ÀxOÔ9®DHÀæ¿{µÍ;À!ù{ž®DHÀ\\}àµÍ;ÀU=ë¯DHÀl$k?¶Í;Àù\\ n¯DHÀ×°¿’¶Í;ÀBøúÐ¯DHÀ@Eá¶Í;À-‰ª4°DHÀóE\'·Í;ÀLµ™°DHÀŽâa·Í;Àûƒ \0±DHÀ(„äŠ·Í;ÀWéòi±DHÀ7W©·Í;ÀdˆÏ±DHÀŠÑÆ·Í;ÀÅ³15²DHÀæaâ·Í;ÀÂºâš²DHÀ§…ßþ·Í;À¾Z\0³DHÀ-£/¸Í;Àv+f³DHÀ3\rX:¸Í;Àv–ÚË³DHÀÊÖX¸Í;ÀY¸1´DHÀ?æ¯w¸Í;À—´DHÀJvë–¸Í;Àhµü´DHÀRÞŽ¶¸Í;ÀÂÐIbµDHÀîïÊÝ¸Í;ÀS#ÉµDHÀ\Z¹D¹Í;ÀWwÝ-¶DHÀ&EìS¹Í;À.}—¶DHÀIž±¢¹Í;À™¤pñ¶DHÀîÐ„þ¹Í;À-ˆP·DHÀeºÍ;Àyâ§·DHÀ\rÊ‚×ºÍ;À‹,Œ÷·DHÀZíÕS»Í;À›ÂÔA¸DHÀ‰£\nØ»Í;ÀOÞ	‰¸DHÀ  b¼Í;ÀÜ˜yÏ¸DHÀŸFî¼Í;À¦s¹DHÀµ`Y{½Í;À€^áW¹DHÀÈÏ•\r¾Í;À!•¹DHÀ¾m9©¾Í;ÀƒË¹DHÀ(½R¿Í;ÀÈîiù¹DHÀ£¿ÀÍ;À\0yŠºDHÀ’Ð=¸ÀÍ;À¦‹Z8ºDHÀ¯&	mÁÍ;À¼”äJºDHÀgI,#ÂÍ;Àê3VºDHÀun²ÚÂÍ;À1GP[ºDHÀ$§ÃÍ;À;	8]ºDHÀÑnƒsÄÍ;À¡Å¹]ºDHÀøÞ?ÅÍ;ÀB¬ä\\ºDHÀÊ6)ÆÍ;ÀYëÇZºDHÀ]¬[ØÆÍ;ÀÄ²rWºDHÀÈ{o“ÇÍ;ÀêðÉUºDHÀ:§NÈÍ;À5 3UºDHÀ5—	ÉÍ;ÀxwQºDHÀî[ÔÃÉÍ;À.}FºDHÀ63ó|ÊÍ;ÀRzü/ºDHÀÎóAËÍ;À	ÞºDHÀÃÏÿËÍ;ÀçñØä¹DHÀÝ\\y¹ÌÍ;ÀlF“¹¹DHÀä0irÍÍ;ÀÒ³Œ¹DHÀ¡á,,ÎÍ;À4~Þ_¹DHÀ\'Þ@ÙÎÍ;Àmæ5¹DHÀñ¯Œ…ÏÍ;Àw®ÿ\n¹DHÀµè1ÐÍ;ÀY+Fà¸DHÀüN-ßÐÍ;ÀzÔ¶¸DHÀ¼Û2ŽÑÍ;ÀÄ…Å¸DHÀŠ~cBÒÍ;À#Ej¸DHÀ‚U÷ÒÍ;À’èE¸DHÀ4¸©¬ÓÍ;Àsû*\"¸DHÀzábÔÍ;Àõ‡‡þ·DHÀËÕÍ;À\Z_yÚ·DHÀY$ÜËÕÍ;ÀBèµ·DHÀ\"&!€ÖÍ;ÀA;Ž·DHÀD¼H4×Í;ÀbwÝg·DHÀöÖÆè×Í;À¯¾âA·DHÀ\nbžØÍ;À\01‰·DHÀò„^ÙÍ;ÀÒ‘a·DHÀ<Ö%ÚÍ;À_KÒ·DHÀGÏRðÚÍ;ÀOMŒ·DHÀ#…KºÛÍ;ÀJ‡@%·DHÀÔ\\€ÜÍ;ÀÞçŸ8·DHÀ1-¶AÝÍ;À\"ðŒR·DHÀAÔÒÞÍ;À¤|x·DHÀ›rÁÞÍ;À†#çž·DHÀaÉ¡ßÍ;ÀÕy\'½·DHÀS¨lCàÍ;À@¬È·DHÀ+•Ÿ÷àÍ;ÀŽõ|Ã·DHÀb³\"­áÍ;À7G\r··DHÀHwëbâÍ;ÀØ“²¤·DHÀTïãÍ;ÀdÂ·DHÀ@À#ËãÍ;ÀA’s·DHÀŒuäÍ;À%)W·DHÀ¹¿º6åÍ;À9­:·DHÀì!ëåÍ;À ¦·DHÀG$ÖžæÍ;À]–\"ý¶DHÀb¶RçÍ;À\0ðÜ¶DHÀåÞWèÍ;Àžn÷¶¶DHÀX¹èÍ;Àm$¬‹¶DHÀYñ[jéÍ;À6¿ˆ_¶DHÀIzƒêÍ;À¥Ä7¶DHÀDÁ»ØêÍ;À*½£¶DHÀ6MBŒëÍ;À3´™¶DHÀlÙ@ìÍ;ÀTêhóµDHÀ½²#öìÍ;À\\\0ÈéµDHÀ²Ã«íÍ;ÀÁ˜mâµDHÀÿ[aîÍ;ÀSTÛµDHÀ]4ïÍ;À=¬×µDHÀÜÍ˜ðÍ;ÀöºSÛµDHÀ\ræ&ÛðÍ;À;ßµDHÀâ:¸­ñÍ;Àªæ°ÛµDHÀCbW~òÍ;ÀívÊµDHÀah9óÍ;À°@žªµDHÀ^óúíóÍ;Àê=­µDHÀCØmŸôÍ;ÀŸÒJTµDHÀãÓQõÍ;À{d\'µDHÀÖ¨oöÍ;ÀX[\0µDHÀOI5ºöÍ;Àœ$ÁÞ´DHÀ®èúm÷Í;ÀÕX–½´DHÀîB\"øÍ;ÀrxËœ´DHÀ	Œ×øÍ;ÀQ|´DHÀßŒZŽùÍ;Àó…\\´DHÀ¼ÁOBúÍ;ÀC,ô6´DHÀÕõ:öúÍ;ÀÅF\r´DHÀÍ<bªûÍ;À1È;é³DHÀ‘­_üÍ;Àœ®ÿÔ³DHÀ*`}ýÍ;Àžï¾Ú³DHÀ>R´RýÍ;ÀîƒUâ³DHÀK†ëýÍ;À,/ôé³DHÀ Þ\"ÏýÍ;À·D—ñ³DHÀŽ=Z\rþÍ;À_;ù³DHÀf…‘KþÍ;ÀöùÛ\0´DHÀ¹øÃþÍ;À—WC´DHÀ®^<ÿÍ;ÀÅµª´DHÀ`BÅ´ÿÍ;Àe´DHÀ³Ö+-\0Î;À“qy\n´DHÀk’¥\0Î;À4Ïà´DHÀ¡¾^Î;ÀA@¸´DHÀ¥±)Î;ÀOº1´DHÀ%®ÅÎ;À÷KS´DHÀ¹vvÎ;ÀÒñÏx´DHÀÊqZ&Î;ÀêS­´DHÀìÁ—|Î;À50³´DHÀ};ÏÎ;À4÷`Í´DHÀæ–ƒ Î;ÀHÃ_é´DHÀ¥_°rÎ;Àw°˜µDHÀp—\0ÈÎ;À\nØ¤µDHÀ¬€ƒßÎ;À÷&)µDHÀ›t Î;À5“ŒµDHÀ«UÝ0	Î;À´-g×´DHÀfÀT\nÎ;À<É»´DHÀmnÎfÎ;À•@ä×´DHÀó]±GÎ;À*êhµDHÀõ$·#\rÎ;Àâ¡]µDHÀ`Uþ\rÎ;À}³­¤µDHÀn„ÚÎ;Ài`êµDHÀ$EÙºÎ;ÀÁ*¶DHÀz#pÎ;À»ŽY¶DHÀI´Î%Î;À¤¬à‡¶DHÀC5ÜÎ;À¨G¶¶DHÀ3¥û’Î;ÀËÁ3ä¶DHÀáÕJÎ;Àù:ˆ·DHÀ]Ø&ÏÎ;ÀYÊ^0·DHÀº³ÈTÎ;ÀM·DHÀZÛÎ;À]¨ïg·DHÀœ”zbÎ;À™4¨·DHÀ{ÉéÎ;ÀúQªš·DHÀ–æ‚Î;Ào	³·DHÀ4ã„!Î;À!‰Ã·DHÀ‘÷EÂÎ;ÀýÙ9È·DHÀÐ”¨^Î;Àò\0þ¼·DHÀD.ôðÎ;ÀbÖ·DHÀ|óS‡Î;Às9j·DHÀe:ú\ZÎ;Àóóh/·DHÀ­N—\ZÎ;Àƒ“¯ï¶DHÀk€»Î;ÀÜy£¬¶DHÀk\'•Î;Àh¶DHÀ‘ÔºHÎ;À×¬þµDHÀ\rIØñÎ;Àíš‘µDHÀQÁ§™Î;Àü6#µDHÀä…QIÎ;ÀSÿ¹´DHÀÜý	Î;ÀsÑV´DHÀôÃ,šÎ;À¥X+´DHÀva•1 Î;À\"ûæ³DHÀ¸ÄÎ Î;À1×¸³DHÀ\"ËGp!Î;Àê9V³DHÀCž«\"Î;Àlòi³DHÀ0x8Ó\"Î;ÀK§MC³DHÀ‰›Q•#Î;ÀÖb²#³DHÀO€EX$Î;À{Ï\"³DHÀPœb%Î;À–„æ²DHÀ§h÷Õ%Î;À\rc½À²DHÀzo¯ž&Î;À¿J‹²DHÀ·{Â`\'Î;Àt¼…L²DHÀ7Ag (Î;À-Tn\n²DHÀhzÔá(Î;ÀËË±DHÀ>Ü@©)Î;ÀM8H”±DHÀt.YC*Î;À—/Qx±DHÀ$ëýã*Î;ÀSÑf±DHÀíWK‡+Î;Àg-ÞX±DHÀ\n¶]),Î;ÀHG±DHÀ3LQÆ,Î;À-ô+±DHÀï…ã‚-Î;À£aü°DHÀC*´5.Î;À=Æ°DHÀCÔøá.Î;ÀHI@ˆ°DHÀO\"çŠ/Î;Àµ¥çA°DHÀ•°´30Î;À#Î,ò¯DHÀ†J,[0Î;ÀÏrÝ¯DHÀ»r0Î;À`bÈ¯DHÀâ-£ž0Î;À3ÐÚ±¯DHÀ§€ð¸0Î;À6Âš¯DHÀµo(Í0Î;ÀF~£‚¯DHÀ=ˆÈ0Î;À‹\n¯DHÀ0QS0Î;ÀÃ³K¯®DHÀ:Ô®/Î;ÀÿÞÆD®DHÀ£¶$/Î;ÀkÚØ­DHÀc5¯Û.Î;Àrœãj­DHÀÃ¸çÛ.Î;ÀÝŠ@­DHÀÆgEà.Î;ÀR÷6­DHÀE›`ì.Î;ÀÂJEç¬DHÀf¯Ñ/Î;À»¬DHÀý0*/Î;ÀR~ò¬DHÀ`…0/Î;À—kM¬DHÀXÕÖØ/Î;À¾ÀI¬DHÀÍõz80Î;À‘ÄÙ«DHÀôsŸ0Î;À©»¦«DHÀÞ×1Î;À*ëûu«DHÀÆžúž1Î;ÀÄ\"·<«DHÀOkG/2Î;À¹J«DHÀÚÝúÁ2Î;À„ñ{ÓªDHÀ|“Y3Î;ÀU¥ªDHÀ}+„ö3Î;À…•Ú{ªDHÀîÈQ4Î;ÀäôfªDHÀ‚´p­4Î;À˜œSªDHÀê€Å	5Î;ÀÔÃAªDHÀ>¹\rg5Î;À‚È\\1ªDHÀI¨Å5Î;Àb	\\\"ªDHÀ}Ë›	6Î;Àa–ªDHÀ[«ÈM6Î;Àv¡²ªDHÀÜ\'’6Î;À—Ú¥ªDHÀYïÉÖ6Î;À‘e\0ªDHÀ²{¿7Î;À	xåù©DHÀ#!K±7Î;À×¡Œî©DHÀ•áãG8Î;À¶fâæ©DHÀÿ>àÞ8Î;À\\`Úâ©DHÀ¸–u9Î;À%*hâ©DHÀ¾Î]:Î;ÀT^å©DHÀg:Î;Àì#ì©DHÀ~òäÁ:Î;ÀòÌø©DHÀÌ0k;Î;Àì6)ªDHÀ\rÃùv;Î;Àð_nªDHÀc“õÑ;Î;À#€ÍªDHÀX=ç<Î;ÀXß˜ªDHÀ¢t8<Î;ÀpÑ ªDHÀ7~Bl<Î;À[;Z ªDHÀ/õŸ<Î;ÀšªDHÀß‘2Ó<Î;À×YæªDHÀ4su=Î;À»VäªDHÀÅÄ5=Î;À2ŸªDHÀZoVd=Î;ÀÅ+Œû©DHÀéW`‘=Î;Àþ!ì©DHÀ¯f½=Î;Àó/ÓÚ©DHÀr×w=>Î;ÀS\n!’©DHÀxäŸ>Î;ÀB\"<©DHÀ?²ø>Î;Àè`â¨DHÀà\"5\\?Î;ÀûK¨DHÀ(ÁÞ?Î;À/NF¨DHÀ]ÔY@Î;À3ml¨DHÀSoØ@Î;ÀŽ•Ïï§DHÀT![AÎ;Àºš¼Í§DHÀ%Æ;âAÎ;À3x³§DHÀQ‡knBÎ;Às½H¢§DHÀQ•éÌBÎ;À#Áš§DHÀc‹+CÎ;À¦ˆ²”§DHÀÒE?ŠCÎ;À\r®§DHÀœ¯õèCÎ;ÀhD§DHÀ×¨GDÎ;ÀÊï‘§DHÀ»évDÎ;À¿Î’§DHÀ.ž6¦DÎ;ÀÿSž”§DHÀRUƒÕDÎ;ÀTÁv–§DHÀ²äÎEÎ;ÀûY˜§DHÀPN4EÎ;ÀbqFš§DHÀêã4ÛEÎ;ÀI]¡§DHÀþ¬J‚FÎ;ÀSª»¨§DHÀÙC\\)GÎ;À\Zù5°§DHÀüDlÐGÎ;À7› ·§DHÀšI}wHÎ;ÀÄôÏ¾§DHÀÊ,O*IÎ;À®Å§DHÀ§–ÝIÎ;ÀnyÈ§DHÀ× JÎ;ÀÚòÄ§DHÀÊ×ºBKÎ;Àq€³´§DHÀ\"É1óKÎ;À:ùô–§DHÀ\"yªRLÎ;ÀéœÆ§DHÀfY«¬LÎ;À‚BÌe§DHÀÙCMÎ;ÀºãI§DHÀdf€XMÎ;ÀÓè,§DHÀ$óq®MÎ;Àõr¸§DHÀ5NÎ;ÀÍyá¦DHÀ7|(ºNÎ;À³}ô±¦DHÀW’½>OÎ;ÀÝ)‚¦DHÀƒéÃOÎ;ÀˆS¦DHÀ ‚ÀJPÎ;ÀºÂ%¦DHÀ“1ßóPÎ;À§‰û¥DHÀú\0f¨QÎ;À™ÁÞ¥DHÀ1j\'`RÎ;ÀÚùÕÅ¥DHÀ^äõSÎ;Às3§¥DHÀÁç£¸SÎ;À?Ey¥DHÀÊïùSÎ;Àá<&_¥DHÀä0:8TÎ;Àíh­B¥DHÀ’ÅOuTÎ;À^¶J%¥DHÀJ1ý²TÎ;À]n¥DHÀ)óTÎ;À‚‡í¤DHÀ¦ý‘UÎ;ÀVµë±¤DHÀ1ð3VÎ;À[ÚÕw¤DHÀÇÆÂÔVÎ;À¦Ê>¤DHÀhùŒuWÎ;ÀÐ`W¤DHÀ>SéXÎ;Àx|Æ£DHÀ.rÃ§XÎ;À`÷wŠ£DHÀZØ8YÎ;À”äšL£DHÀo•qÆYÎ;À¡XJ£DHÀ$²ØOZÎ;À1nëÈ¢DHÀ!?WÔZÎ;Àî?ã¢DHÀõùñZÎ;À¿_œp¢DHÀˆ¬n[Î;ÀèMÛ^¢DHÀo3Ô)[Î;Àå¥L¢DHÀõûED[Î;ÀY\0:¢DHÀ”Pà][Î;Àÿzõ&¢DHÀ£Ê[Î;Ào{ÐÒ¡DHÀcæu4\\Î;Àî ~¡DHÀ±’Mž\\Î;ÀV²\n)¡DHÀ$ù]Î;À~vmÔ DHÀ\rÑu]Î;À>´«€ DHÀ)úÏ]Î;À®+< DHÀ\\˜	*^Î;À¥´y÷ŸDHÀÚX…^Î;À›5e³ŸDHÀò@ã^Î;À–ƒpŸDHÀ\\E_Î;À4½x/ŸDHÀ\"”MÄ_Î;ÀGIzÞžDHÀNÏ˜C`Î;ÀmB‰žDHÀÀ‘ðÂ`Î;Àî7Ÿ<žDHÀ@¸HBaÎ;Àž¹µëDHÀ° •ÁaÎ;ÀTWÆšDHÀÖ11bÎ;Àü+¹SDHÀ\ZË½ bÎ;Àsß¤DHÀ³IcÎ;À^ªÅœDHÀòâcÎ;ÀHÄ~œDHÀºÀ—ïcÎ;Àbf{7œDHÀR³%ndÎ;ÀQÃì›DHÀ£Z½ôdÎ;ÀÚ¦›DHÀ±ýeÎ;ÀÇ¾ˆc›DHÀßÞfÎ;À]¿µ\"›DHÀùFÓ¡fÎ;ÀÂšÞâšDHÀWðfÎ;ÀŒ6ˆÀšDHÀ“•$?gÎ;À\n)xžšDHÀ>®2ŽgÎ;ÀU´|šDHÀi,xÝgÎ;ÀŠ\ZèZšDHÀÒæë,hÎ;ÀÛžF9šDHÀŽ-õÚhÎ;Àî×†ð™DHÀ ß#ŠiÎ;Àü5´¨™DHÀ>1:jÎ;À3›ža™DHÀµÏ×êjÎ;À½é™DHÀ‰6Ð›kÎ;ÀÇêÔ˜DHÀ9-ÔkÎ;À7]ÅÂ˜DHÀ:ä3lÎ;ÀÇc°´˜DHÀ>ãÕMlÎ;À.ÆÚ§˜DHÀ(´\\ŠlÎ;À94t™˜DHÀÃß;ÃlÎ;Àƒ[¬†˜DHÀÃ|_UmÎ;À~ïzD˜DHÀÐuÙmÎ;À\ZSû—DHÀ/‰ÈQnÎ;ÀþP„«—DHÀYwÀnÎ;À¹²W—DHÀxýp&oÎ;À\rDÿ–DHÀõ§²VoÎ;ÀÍÎ–DHÀL¤oÎ;À-ÍN–DHÀ)©oÎ;À?£@k–DHÀnsxÒoÎ;ÀD“V9–DHÀ-¼²\0pÎ;À§D–DHÀY	~pÎ;ÀÞÕ•DHÀ Î¾qÎ;À¦NM•DHÀîxƒ’qÎ;À_Äƒ¯”DHÀ“˜7rÎ;ÀßRI”DHÀz0ÿõrÎ;À|çì“DHÀæ6&sÎ;À[O>Þ“DHÀÅ#Ñ[sÎ;Àh>Ø“DHÀ¥“sÎ;ÀócÅØ“DHÀ¤g†ÊsÎ;Àm\nß“DHÀ{ŸIýsÎ;À\r˜é“DHÀ¬¶?mtÎ;À†”DHÀX°0ÝtÎ;Àws÷#”DHÀ9–¥LuÎ;À=›;B”DHÀ¾n\'»uÎ;ÀJí£a”DHÀ†B?(vÎ;À^N‚”DHÀåPÕ±vÎ;Àñ1­”DHÀ~g\';wÎ;ÀÉËØ”DHÀ†#kÄwÎ;À\\•DHÀýÖMxÎ;ÀÔ/•DHÀú×xÎ;À—)ÃY•DHÀÜ+úxÎ;ÀÀ+d•DHÀ03ùyÎ;ÀÍ	9n•DHÀßÉ?yÎ;À5DQx•DHÀBÂabyÎ;ÀQZ¤‚•DHÀÄ¼„„yÎ;À—Ìo•DHÀ²Öß›yÎ;ÀÔ]••DHÀÆôæ²yÎ;ÀI‰–•DHÀ6¯ÀÉyÎ;ÀÞŠø¥•DHÀ “àyÎ;ÀMvb®•DHÀŸU†÷yÎ;ÀÔë²¶•DHÀ¸ˆ>€zÎ;Àôæ•DHÀ¿®œ	{Î;À½Û™–DHÀ•Ön“{Î;À¨<ÆE–DHÀNƒ|Î;Àz\Z›t–DHÀän§§|Î;À`:£–DHÀTÊ8â|Î;À\\4™³–DHÀE**%}Î;À÷gš¿–DHÀ¾ši}Î;À\ZÄ–DHÀw$½¦}Î;À½€ô½–DHÀBÑ¦Ö}Î;Àk±ª–DHÀÔ,%?~Î;ÀJÁV–DHÀ:O\\™~Î;ÀÛQx\0–DHÀlk4é~Î;À¥\\Ù§•DHÀ/²•2Î;ÀHþ’M•DHÀcUhyÎ;ÀBÌSò”DHÀ¾Ù³Î;À&S§”DHÀÁ$¾íÎ;À\\DZ\\”DHÀŠ½Æ\'€Î;Àxq[”DHÀ/a€Î;ÀöHÆ“DHÀIÄš€Î;À{“DHÀõCÊÒ€Î;Àòõ¦2“DHÀ7Ô¸Î;À‚¤kê’DHÀ±ÍCÎ;À£Š¢’DHÀîsDyÎ;ÀÖY’DHÀI\\ªÎ;Àh\Z’DHÀïýwÞÎ;À9gD»‘DHÀ4±“‚Î;Àñ?ng‘DHÀ_c¯F‚Î;À6˜‘DHÀ‹Ëz‚Î;ÀîñÁ¿DHÀƒÅæ®‚Î;ÀÊëkDHÀ–1¹‚Î;ÀÙØUDHÀœÃ‚Î;À˜5Å?DHÀŠ<Í‚Î;ÀWë±)DHÀžsX×‚Î;À£¡žDHÀ—Þtá‚Î;ÀbW‹ýDHÀ\\®*jƒÎ;ÀÖ\0,9DHÀ3PI5„Î;À °/†ŽDHÀõ¿=)…Î;À9Ø«ÝDHÀaøt,†Î;À§ìµ8DHÀRõ[%‡Î;ÀbcŒDHÀ‘¡$–‡Î;ÀaÓ5ŒDHÀÁH«ˆÎ;ÀîPÒØ‹DHÀ½ÍKvˆÎ;À—’‹€‹DHÀøbüˆÎ;Àî„*4‹DHÀKïI ‰Î;ÀsˆÚúŠDHÀ\r¬MOŠÎ;Àâl×ŠDHÀ%‹Î;ÀÀ\rÀŠDHÀÌˆ¸´‹Î;À\nŽð¯ŠDHÀAŸðhŒÎ;À¿”I¢ŠDHÀúÈµÎ;ÀÂ:K’ŠDHÀ&›æÎ;Àifo€ŠDHÀMP±ŽÎ;À«ZrŠDHÀl+|Î;À–ödŠDHÀiŠ‚FÎ;ÀÇ;QŠDHÀ\'¹¬‘Î;ÀL¿Ý6ŠDHÀÞÿS¹‘Î;À_6•ŠDHÀøµ*E’Î;ÀNàÕ¾‰DHÀÑà)¶’Î;À‡4	b‰DHÀá†J“Î;À»§˜úˆDHÀ ®…S“Î;Àä±íˆDHÀT»£‡“Î;À­p¿,ˆDHÀ.ªO³“Î;À‘¤”È‡DHÀ‰ô×“Î;Àß1(d‡DHÀtkõ“Î;Àçü4ÿ†DHÀbxç\r”Î;Àëu™†DHÀBO`\"”Î;Àóf$†DHÀ”^0”Î;ÀðËn¯…DHÀI;”Î;ÀäŸ0:…DHÀWÊKH”Î;ÀPjñÄ„DHÀ;ùb[”Î;À›±ÍO„DHÀäºm”Î;À<ŸæƒDHÀDXC‚”Î;À¹ß–~ƒDHÀÄZS«”Î;À/5ÆƒDHÀéLeø”Î;ÀÖò=¶‚DHÀ9¹ªy•Î;ÀÊX‚DHÀ4]t&–Î;À\nRƒ\n‚DHÀ²Ý–Î;À ’?ÛDHÀ~°›š—Î;ÀRa¸ÂDHÀz8ƒ\\˜Î;ÀãYb¹DHÀsþ™Î;À0²·DHÀ´»Gð™Î;ÀûýŽ·DHÀ‘z“ÀšÎ;ÀäºÆ·DHÀ—à›Î;ÀÀ¸DHÀ]Ý-aœÎ;À«1¸DHÀxz1Î;À¶VÚ·DHÀqVÜ\ZžÎ;ÀÍÞÌ¶DHÀ=¡<ŸÎ;À\\µDHÀÒ\níŸÎ;À?Æå³DHÀÁ ÿÖ Î;ÀðÄ²DHÀèsfÀ¡Î;ÀÂnV²DHÀØ²³€¢Î;Àg¶¸µDHÀ¹th@£Î;Àh–A¿DHÀ…nÿ£Î;À²„ÎDHÀNÞ­½¤Î;ÀöpáDHÀ5{¥Î;ÀaløDHÀ±»L(¦Î;À;Ï‚DHÀö^&Ô¦Î;À6vŸ(‚DHÀMû§Î;À\nÈ¦B‚DHÀneƒ)¨Î;À~8®]‚DHÀ®xîÓ¨Î;Àtû~y‚DHÀ¹/ˆ©Î;Àjt˜‚DHÀkŠ;ªÎ;Àî­°·‚DHÀÖ_ZîªÎ;À+¹4Ø‚DHÀ½ßú «Î;ÀL§=ù‚DHÀ„ÇS¬Î;ÀŠy\ZƒDHÀnœ­Î;ÀtÙ<ƒDHÀ¾u^Å­Î;ÀBéaƒDHÀëmx®Î;À~dŒƒDHÀ:t&(¯Î;À×¡ÂƒDHÀ:ãèÔ¯Î;Àâ;À	„DHÀ£7f[°Î;ÀåË	c„DHÀ4fVª°Î;ÀÿNnÌ„DHÀXÍ°Î;ÀR×±=…DHÀ{ùÏ°Î;À©x˜®…DHÀ8—»°Î;ÀšDæ†DHÀg+€°Î;ÀÝ“|†DHÀŒ©°Î;À\'tá†DHÀ@KŸ¯Î;ÀN2üE‡DHÀõ—W1¯Î;Àžžª‡DHÀ£Ý¹ê®Î;À­ÏˆDHÀ&yV¾®Î;À£	Q|ˆDHÀ_Dš®Î;Àå?öˆDHÀfÁ(˜®Î;À3¯±o‰DHÀ„ªÑ®Î;À$¹µÛ‰DHÀ¶ko`¯Î;À4¾´,ŠDHÀUq?1°Î;À£e[ŠDHÀïkD±Î;ÀåJógŠDHÀh<Ó±Î;À6]^ŠDHÀŒÂ<£²Î;ÀŸ¤JŠDHÀ?ßWr³Î;À×ÌÆ8ŠDHÀ{×íA´Î;Àor\r&ŠDHÀ— =µÎ;À£0ÞŠDHÀ7`›àµÎ;À‘5£ô‰DHÀ•B[°¶Î;Àn°Æä‰DHÀlnÑ€·Î;ÀWÏ²ä‰DHÀ|û,Q¸Î;À¶,ï‰DHÀ:#!¹Î;À­Cöù‰DHÀ—¼ïñ¹Î;À;žäŠDHÀ†žRÂºÎ;À^RÊŠDHÀøŸ³’»Î;À“z\ZŠDHÀ=Yc¼Î;ÀMÄÈ$ŠDHÀ\0ˆ4½Î;À\ZÕ.ŠDHÀkÂ¾Î;Àf(ï8ŠDHÀtÐoÕ¾Î;ÀscfCŠDHÀ\n 	¦¿Î;ÀTŠNŠDHÀLÂ[ÀÎ;À`ï\\ŠDHÀWÈ1ÁÎ;ÀSrŠDHÀ”1ÀÁÎ;À7õŠŠDHÀjéâqÂÎ;À´Šþ¤ŠDHÀC¹$ÃÎ;À¡¤Q½ŠDHÀvÁÏÙÃÎ;À©ƒÅÝŠDHÀ¾öÄÎ;Àd–‹DHÀ¶ÚÍEÅÎ;À¡C60‹DHÀð^÷ÅÎ;ÀœG‹DHÀ&µØ¢ÆÎ;Àzíª?‹DHÀ®!J7ÇÎ;À¢ü´‹DHÀQÖ§ÇÎ;Àdëa¼ŠDHÀ-¶ïÈÎ;À‡É‡VŠDHÀYÂWÈÎ;À#ªüê‰DHÀ|æ“²ÈÎ;ÀŽ–‡‰DHÀJúØ\rÉÎ;À?X¶&‰DHÀøöVYÉÎ;À:~€ÄˆDHÀÌÆ¨ÉÎ;À!ubˆDHÀ¾máÊÎ;Àò \0ˆDHÀ…Ì_¢ÊÎ;À¨e\r¡‡DHÀèÆæ—ËÎ;À‘Ú³1‡DHÀ{ß9™ÌÎ;Àü’œã†DHÀXN¡ÍÎ;ÀUQH¶†DHÀç6«ÎÎ;ÀØ7©†DHÀu_±ÏÎ;À{éë»†DHÀtÐÎ;À\re³Ì†DHÀÍÖfÐÎ;À\r¿”à†DHÀôšcûÐÎ;À\ZZªõ†DHÀüohiÑÎ;ÀÑ˜\n‡DHÀ9]s×ÑÎ;À^ÞÛ‡DHÀ+¸xÒÎ;ÀÒ÷%‡DHÀv8jdÒÎ;Àü%-‡DHÀ¤Ç«ÒÎ;ÀÜ5‡DHÀt™óÒÎ;À!àä=‡DHÀ¤õ¿9ÓÎ;ÀgÁ`H‡DHÀpÔÎ;Ànw‡DHÀÁ{õÔÎ;À@´‡DHÀýœÆÁÕÎ;ÀÜzjþ‡DHÀŽ¼±„ÖÎ;ÀáŒ.TˆDHÀÓþ?×Î;ÀÎ\"´ˆDHÀ;šº×Î;Àâè>úˆDHÀ£ù*ØÎ;ÀaáB‰DHÀýJäØÎ;Àõu‰DHÀf¾$àØÎ;ÀcÝß‰DHÀßSƒÙÎ;ÀnžJ6ŠDHÀ ÂÔ=ÙÎ;À°:ílŠDHÀa1&]ÙÎ;ÀóÖ£ŠDHÀ\" w|ÙÎ;À5s2ÚŠDHÀÉ\rÉ›ÙÎ;ÀÕ‹DHÀq{\Z»ÙÎ;ÀÔ¬wG‹DHÀ^ð7ÞÙÎ;Àª!Ç`‹DHÀ2dUÚÎ;À–z‹DHÀÙr$ÚÎ;ÀÈ\nf“‹DHÀóLGÚÎ;À*€µ¬‹DHÀàÁ­jÚÎ;ÀÿôÆ‹DHÀö1ŠÚÎ;Àó2ŒDHÀÃI-AÚÎ;ÀQÌºnŒDHÀ©ôôÊÙÎ;ÀŸÔ‚ËŒDHÀbÚbÙÎ;ÀXaq(DHÀMð/DÙÎ;ÀåÇlDHÀl¶oôÙÎ;À¦&ÞoŽDHÀ©Ÿ)ÛÎ;Àp=%VDHÀÁùfxÜÎ;ÀŠÊ<DHÀ¿ÙluÝÎ;À	‰V,‘DHÀ,wXµÝÎ;À¨±Q-’DHÀ5ÌC¡ÝÎ;À*¥\\~’DHÀ£!ÝÎ;À­jÏ’DHÀxúxÝÎ;À|Èz “DHÀØdÝÎ;À¢ô‹q“DHÀzäÄPÝÎ;À/Â“DHÀñÆMNÝÎ;ÀÛÆ=”DHÀªÖKÝÎ;À^ÞG”DHÀÞ‹_IÝÎ;ÀÝõ~Š”DHÀTnèFÝÎ;ÀÍ”DHÀ±OqDÝÎ;ÀÞ$À•DHÀã-@ÝÎ;À“j•DHÀù¶©:ÝÎ;À~:RÄ•DHÀì´Î4ÝÎ;Àª®—–DHÀŸƒ/ÝÎ;À6ßx–DHÀ²°+ÝÎ;À×C-Ó–DHÀ6K+ÝÎ;Àgm‰ô–DHÀtUÜ+ÝÎ;ÀŽ³å—DHÀMÐê,ÝÎ;À×!B7—DHÀ³þ-ÝÎ;ÀÍÃžX—DHÀø‚.ÝÎ;ÀV£ûy—DHÀˆ¤\"/ÝÎ;Àu$ï—DHÀQ».ÝÎ;À\rgKd˜DHÀUZú,ÝÎ;À \rrÙ˜DHÀcnt)ÝÎ;Àe˜N™DHÀ—ÿ¼#ÝÎ;ÀTÑ¾Ã™DHÀ# Ó!ÝÎ;ÀˆÔ™DHÀzÂˆÝÎ;ÀBå™DHÀ5‡\ZÝÎ;Ài£óõ™DHÀuÆyÝÎ;À¤šDHÀ&FÝÎ;À]zZšDHÀËpÉÝÎ;ÀS%@ŒšDHÀ)ÃõÜÎ;À8y›DHÀ#óíÜÎ;ÀÁJÜv›DHÀ¬ùSéÜÎ;À¼ß@ì›DHÀ qàæÜÎ;ÀQÜ}aœDHÀvÖhíÜÎ;ÀÙÓAœœDHÀ:‘ƒÝÎ;ÀžÇÕœDHÀ5šÚ%ÝÎ;À©nú\rDHÀ/êWÝÎ;À2ÌÈDDHÀïyå•ÝÎ;ÀæzDHÀÓV@´ÝÎ;Àqê‡DHÀ¤ÃjÛÝÎ;À72“DHÀ—ñ¶ÞÎ;ÀÅU!ŒDHÀ•w-ÞÎ;Àåæœ„DHÀ‰HýLÞÎ;ÀÐð\rxDHÀÜm#’ÞÎ;ÀÝüTODHÀ$ ëÔÞÎ;ÀãŽ$DHÀ°1_ßÎ;ÀóD÷œDHÀ›rŠCßÎ;À€\0ÇœDHÀ4µwgßÎ;À›ØJ“œDHÀcK|ßÎ;À2jœDHÀ»sÉßÎ;ÀÓUAœDHÀCT/¥ßÎ;ÀQWõœDHÀ\0+¹¹ßÎ;ÀœÞî›DHÀ-r£ÎßÎ;À,´ÕÅ›DHÀ×øàóßÎ;À6æ¸}›DHÀ©{!àÎ;À2(œ5›DHÀ$u>àÎ;À­íšDHÀWìcàÎ;À?§k¥šDHÀ…~–‰àÎ;ÀI\\]šDHÀá7Ê¥àÎ;Àýü9)šDHÀ7f†ÃàÎ;Ày^õ™DHÀëû¼âàÎ;ÀDÇÁ™DHÀLê_áÎ;Àl›sŽ™DHÀØ$a%áÎ;À\Zfb[™DHÀ”¾\0^áÎ;À=êf™DHÀ1éœáÎ;ÀuüòÄ˜DHÀÐõßÞáÎ;ÀØ‡F{˜DHÀ“« âÎ;À–x¡1˜DHÀÝ_âÎ;ÀÈ¹Cç—DHÀ^tõ€âÎ;À|†¸—DHÀ¥\"ûžâÎ;ÀÇÙ‰—DHÀØñµ»âÎ;ÀS]\rY—DHÀTê¸ÙâÎ;ÀÊº\")—DHÀ—ûâÎ;ÀI›µù–DHÀ†Ä7ãÎ;ÀJdþº–DHÀ]P$‚ãÎ;Àá=÷–DHÀËÂ±×ãÎ;À%¦0M–DHÀn$™4äÎ;À·;–DHÀ2:•äÎ;À$§ê•DHÀú£ÐGåÎ;Àep-œ•DHÀâ-læÎ;ÀŸô¾Y•DHÀ–\\ñæÎ;ÀÍ©03•DHÀMïÈçÎ;ÀîW8•DHÀÐtèÎ;À3­y•DHÀ@óèÎ;À¡ü;³•DHÀ×‹áKéÎ;Às‹¨í•DHÀFÿàéÎ;À.$Y(–DHÀ‰SÆ·éÎ;À@Xc–DHÀ[b¼éÎ;À™±ž–DHÀˆÄv§éÎ;Àè¿²Ã–DHÀ&c\rƒéÎ;Àé\Zàè–DHÀ~×tWéÎ;Àa\"—DHÀrÁD-éÎ;À…Jb3—DHÀ¼\réÎ;ÀÇŽˆX—DHÀcc‡õèÎ;Àhš{—DHÀÞ<\0ÞèÎ;Àm¡—DHÀ3f~ËèÎ;ÀÉƒ£Ç—DHÀ¼ý\0ÃèÎ;À<3¿í—DHÀÓ!‡ÉèÎ;ÀÛ˜DHÀó>âëèÎ;À*iE˜DHÀVõ éÎ;À¢v˜DHÀD	®déÎ;Àú­=£˜DHÀÏýù²éÎ;À*»\"Ì˜DHÀ¤ÔÆêÎ;À´þï˜DHÀþ#aIêÎ;ÀDó2™DHÀNÔ‹êÎ;À,“Ü™DHÀYòÍêÎ;ÀÙ#H4™DHÀüëÎ;ÀµàÂH™DHÀÿ­$TëÎ;À·š\\™DHÀa®‹«ëÎ;ÀQou™DHÀªÖâìÎ;À¥Þ™DHÀCz±ZìÎ;À•ù¥¥™DHÀ–ì~³ìÎ;À\\‚¼™DHÀ\rÒ\ríÎ;À(1Ò™DHÀ#OÏŒíÎ;À¿ƒí™DHÀƒãB\rîÎ;À—èšDHÀI>îÎ;ÀO¡\ZšDHÀ“_2ïÎ;À‚²ý,šDHÀG€–ïÎ;ÀçÐî<šDHÀq|Ü*ðÎ;À¯éIšDHÀ´csÀðÎ;ÀÚðRšDHÀ,\\VñÎ;À’{›XšDHÀ,®ëñÎ;À{7´`šDHÀì€òÎ;Àš\nŽmšDHÀÄÔØ3óÎ;À±p’„šDHÀ{*çæóÎ;À«<¶ŸšDHÀ¸Tj™ôÎ;À<-v¼šDHÀ#Ž!LõÎ;ÀûÿNØšDHÀeÌÿõÎ;Àšs½ðšDHÀ¨©ºÎöÎ;Àíž›DHÀúò ÷Î;Àù¨“›DHÀ—MsøÎ;À`™›DHÀêB¡DùÎ;Àä‹¬$›DHÀW¡púÎ;À5…Ë;›DHÀ³nÄËúÎ;À›}Æ^›DHÀµûÎ;Àv\\Ô‹›DHÀ?!l/üÎ;ÀÈê\\½›DHÀ/:$àüÎ;ÀñÇí›DHÀöa”ýÎ;À¹8}œDHÀ¯ddEþÎ;À[“14œDHÀÔ\'dûþÎ;À®ØIœDHÀÆD`²ÿÎ;ÀèÛ^œDHÀ­ÃWf\0Ï;À´oxœDHÀ.§IÏ;À0fžœDHÀ;oÅ’Ï;À6ëPÄœDHÀ–Ê\"\rÏ;À²z­îœDHÀ³d¾ƒÏ;À*\Z<DHÀ!êô÷Ï;À“Î\nLDHÀ#kÏ;Àÿ\'}DHÀ%%ÜÏ;ÀAŸî¿DHÀ@¼žÏ;ÀÂ/žDHÀï»[5Ï;À2÷±GžDHÀ©úRÉÏ;ÀCQ@ŽžDHÀ_:ZÏ;À3\"£×žDHÀôø.·Ï;À»Ï7\nŸDHÀj£OÏ;Àé:y>ŸDHÀ%TÛeÏ;Ày÷rtŸDHÀÉÿ¸Ï;Àš˜0¬ŸDHÀœ/Ï;À²½åŸDHÀÜ‘vÏ;ÀÄ©!< DHÀ°6áÏ;À¯îÅ“ DHÀ é¶G	Ï;À³Àì DHÀ5¨ª	Ï;À[+(G¡DHÀO¡\n\nÏ;ÀÄˆ£¡DHÀ¹ê²;\nÏ;À\n”ÙÓ¡DHÀ3ék\nÏ;ÀZU÷¢DHÀo\"˜\nÏ;ÀÝ‘£6¢DHÀaMÂ\nÏ;Àüi¢DHÀÚæùè\nÏ;À9‡†œ¢DHÀ\'ˆ(Ï;ÀûQÿ¢DHÀ•m`Ï;À%Áƒc£DHÀÑÕ\\”Ï;À6©MÈ£DHÀ€}ÝÉÏ;À‘Þ,¤DHÀ€>Ï;À&5d¤DHÀÀŸ>Ï;Ài¹ä¤DHÀËŸzÏ;À ,8¥DHÀÝœÏ¸Ï;ÀbÏ‹¥DHÀâ¶nùÏ;ÀmêÀÝ¥DHÀ[	I;\rÏ;Àcä‹0¦DHÀÀS{\rÏ;ÀDŠ¹¦DHÀ/KÐò\rÏ;À½Ú@ë¦DHÀK(¬^Ï;ÀÔÖ	C§DHÀ¸#sÐÏ;À€ü–§DHÀ5w‰DÏ;À£×\0ç§DHÀø,ÊxÏ;ÀÕ½·ø§DHÀnÙ(ÂÏ;ÀäTœþ§DHÀmÇž\rÏ;À`]ù§DHÀ³@%HÏ;ÀJ—©è§DHÀµ^Ï;ÀÂ¯Í§DHÀ\ZÓGZÏ;ÀÃX.‹§DHÀˆ‰TÏ;Àfj¬H§DHÀW¨ÙMÏ;ÀÞ+§DHÀÆ»™FÏ;Àáš®Ã¦DHÀý–)?Ï;ÀX‡6¦DHÀ9pö1Ï;À¨ò¸¦DHÀ*1Ÿ$Ï;ÀlÆ;–¥DHÀl>Ï;ÀS·¾ ¥DHÀÐ~í	Ï;ÀzA«¤DHÀ˜ÇüÏ;ÀºÂÃ5¤DHÀ.ÿ,àÏ;Àµ9ìÀ£DHÀÇáâ·Ï;À‚Š<L£DHÀÑ A¡Ï;ÀÉo^×¢DHÀH¡¹Ï;ÀÚ¥ûa¢DHÀ&8[Ï;ÀÐæ½ë¡DHÀÚú©Ï;À7Ž¡DHÀBúÈCÏ;ÀÖ3E¡DHÀÎdMæÏ;À:¬¡DHÀçŒÏ;À–ÕÂï DHÀ$L˜/Ï;À[ÇÎá DHÀµÞ\'	Ï;À‡Nè DHÀæëçÏ;ÀhÊ¨	¡DHÀÃžÅÏ;À,Ü)F¡DHÀl±Ô Ï;À«&áž¡DHÀ1ætÏ;ÀŸK­¢DHÀ;‡ïÓÏ;À:«¡g¢DHÀ%‰µüÏ;À¨’\\»¢DHÀ³lÏ;ÀÐï®£DHÀ¶¨IüÏ;ÀY³id£DHÀûÏ;À·Ë]¹£DHÀ‚œM÷Ï;ÀáÀ¿5¤DHÀûÙÝÏ;À™T«²¤DHÀPÀÏ;ÀÈ\'­/¥DHÀO„ÿ³Ï;ÀuÜQ¬¥DHÀüÌÏ;À½&(¦DHÀ	î#Ï;ÀX¡4ˆ¦DHÀkÆSWÏ;Àðd]á¦DHÀÁèÄÏ;ÀAwí2§DHÀy#HÏ;À%ð1|§DHÀ¤7ÝÏ;À?åw¼§DHÀÈR<Ï;ÀŠ~O(¨DHÀÎú’RÏ;À<[gƒ¨DHÀ™Ï\"’Ï;ÀŽÍÓ¨DHÀHÓÔÏ;Àš)©DHÀaÄŠ\Z Ï;À6A½l©DHÀžPÖ Ï;À…j]¡©DHÀƒ˜”š!Ï;À¿r(Ü©DHÀ®\Z|^\"Ï;À\rÇªDHÀÂA*#Ï;Àíá\"ªDHÀw¾ÂÁ#Ï;ÀØÅ!ªDHÀùfa$Ï;À1\"»©DHÀÐGÍ$Ï;À‹ÍKC©DHÀ@aé%Ï;À¸•¸·¨DHÀŠùÔl%Ï;À¦I^)¨DHÀbÊåÒ%Ï;À*·;©§DHÀlîµ)&Ï;À4ÆûU§DHÀoU[‰&Ï;ÀMIGü¦DHÀühGì&Ï;ÀAª§¦DHÀ\"ëL\'Ï;ÀÜ°c¦DHÀV*¹¥\'Ï;Àêää;¦DHÀ§Ê„a(Ï;ÀØÛ5¦DHÀøjP)Ï;ÀIËÒ/¦DHÀ/\nÙ)Ï;Àë½É)¦DHÀ€ªç”*Ï;ÀŽ°À#¦DHÀÑJ³P+Ï;À0£·¦DHÀZ.åê,Ï;ÀþŽ¦DHÀ@ y-Ï;Àýøü¦DHÀ\\˜ã-Ï;À„=Id§DHÀãîÊI.Ï;Àp‡AË§DHÀýÑ™.Ï;ÀÌQ|8¨DHÀ„eÛ.Ï;Àgu#™¨DHÀ¼ã!/Ï;Àö[Ó¨DHÀ¡JŒ`/Ï;À!žÔ¨DHÀ‚	^‰/Ï;ÀŸRq‘¨DHÀ¥¶Ÿž/Ï;Ào\Z!¨DHÀ‹A­/Ï;ÀR-¥§DHÀSITÉ/Ï;À:=+§DHÀÉ¢	0Ï;À3ô*¸¦DHÀ>+·z0Ï;À•x§X¦DHÀ:¦•1Ï;ÀX}Å¦DHÀé@NÐ1Ï;À´ù¦DHÀWÆTJ2Ï;À_3U¦DHÀÛšŽv2Ï;À:,«½¦DHÀ7Ša2Ï;ÀÒ3§DHÀqˆ,2Ï;À³uŠ¥§DHÀh\Z!\n2Ï;À%ºü\r¨DHÀòCM2Ï;À,•ßW¨DHÀÅ!³d2Ï;À6.õ]¨DHÀtnéê2Ï;Àb§O\'¨DHÀfp3Ï;ÀÖÁÿî§DHÀìh4Ï;Àkj\"Ì§DHÀŒµÓ/5Ï;À5Õ¡§DHÀüO„æ5Ï;ÀBa`§DHÀŠ‘6Ï;À.’ý§DHÀ³æ1;7Ï;ÀaF@È¦DHÀq/ó7Ï;ÀŠÑ¾¦DHÀ„k³8Ï;Àz†cœ¦DHÀ–ë›H9Ï;ÀbF|ª¦DHÀ¼Sª•9Ï;À¤R¨³¦DHÀpå¾9Ï;À‹Kº¦DHÀ„†å9Ï;À´<…Á¦DHÀ8m²:Ï;ÀþƒÊ¦DHÀqøU:Ï;Àç£íÔ¦DHÀc|š:Ï;Àf»Rá¦DHÀ€mÞ:Ï;Àû¥ð¦DHÀÀ;Ï;À/pÌ§DHÀõÆR;Ï;À$l§DHÀkßPz;Ï;À·…7@§DHÀ¹»¡;Ï;ÀDmf§DHÀ	Ímš;Ï;ÀÞ7îŽ§DHÀÄ³Ïž;Ï;À°>_¸§DHÀrOÙ¡;Ï;À].¾á§DHÀ~\'¯¦;Ï;À’Ü\n¨DHÀ‚‘±;Ï;Àh83¨DHÀyc2Ç;Ï;À‘Þ°Y¨DHÀŸÝ ì;Ï;À¾\0Hy¨DHÀtÐÔ#<Ï;ÀË¼¹‹¨DHÀ õ\rh<Ï;Àãæ@¨DHÀ2Bº­<Ï;Ài+‰¨DHÀ(áêï<Ï;À{!2y¨DHÀŒ±r-=Ï;À³m\'c¨DHÀd éb=Ï;ÀA[âG¨DHÀí\"‰‹=Ï;Àm3â&¨DHÀ\r„§=Ï;À›B¨DHÀÉÔ™»=Ï;À¥eoÙ§DHÀ·O‘Ê=Ï;À›\nÒ°§DHÀà-Ö=Ï;ÀÁÔ‡§DHÀ¼lqà=Ï;À´¼^§DHÀå3Æë=Ï;Àˆ¥¸5§DHÀ¶ù=Ï;ÀVþõ§DHÀøç­\n>Ï;ÀL¥ä¦DHÀ ‘ö>Ï;À„íä¼¦DHÀHw¾6>Ï;ÀðÎµ•¦DHÀHnR>Ï;À „*o¦DHÀKÁÎp>Ï;ÀˆtI¦DHÀ !å“>Ï;ÀOH%¦DHÀam¾>Ï;Àxd=¦DHÀ¥»?Ï;ÀxÆáß¥DHÀ…}Ÿ?Ï;À{ó^ ¥DHÀ²÷—š@Ï;ÀÊŽ­?¥DHÀŸÇz‡AÏ;À)êjé¤DHÀâØBÏ;Àõp3¿¤DHÀæ½W`BÏ;ÀtöO°¤DHÀÇRW¨BÏ;À§\\¨¤DHÀòFMñBÏ;Àó–ý¡¤DHÀþþº:CÏ;Àwuu¤DHÀ½`„CÏ;ÀÇ@ñ™¤DHÀiÎCÏ;ÀH²\"—¤DHÀ‚ZÑDÏ;À8ë•¤DHÀT`–aDÏ;Àäh”¤DHÀFf«DÏ;ÀBªG”¤DHÀc=õDÏ;À¼Â•¤DHÀ-Kö>EÏ;À_\\%˜¤DHÀ[ËjˆEÏ;À¼wãš¤DHÀ(ÌÑEÏ;À´þ¬¤DHÀraß\ZFÏ;Àë¦Ð ¤DHÀº5^FÏ;ÀÂø¨¤DHÀ²¼—FÏ;À<Wr¼¤DHÀê4ÔÒFÏ;ÀÇ¢ºÛ¤DHÀï!W)GÏ;À-Ì!¥DHÀ&Y9’GÏ;À¿æ¿5¥DHÀ®!mñGÏ;Àøã9r¥DHÀwá\"CHÏ;Àû8¶¥DHÀïh9–HÏ;À«Ðlú¥DHÀmÝºöHÏ;ÀŸþ4¦DHÀüìOmIÏ;ÀýVZ¦DHÀÁåi÷IÏ;ÀJ§¢g¦DHÀ%N˜‡JÏ;ÀÊtåb¦DHÀƒxïKÏ;À7+HS¦DHÀÖ |¦KÏ;À¤9Ò@¦DHÀi­§6LÏ;À(¡¹3¦DHÀnzcÆLÏ;À{cO4¦DHÀÏ5RMÏ;Às0G¦DHÀ¬Ã:ÓMÏ;À¿AÀj¦DHÀ—ß1INÏ;À“$&š¦DHÀäf£¿NÏ;ÀoÀ3Ê¦DHÀá¿=OÏ;ÀÑ7ô¦DHÀHØ¿OÏ;À÷Í?§DHÀÆ‡á?PÏ;ÀôJîC§DHÀ—oHµPÏ;ÀùØs§DHÀ†\"ðQÏ;ÀêÎñ®§DHÀ¥Q;[QÏ;ÀÑô§DHÀR“QÏ;À·©ßA¨DHÀ‚v¥QÏ;À©Á¨DHÀ¥^#ßQÏ;À¶Ö8Û¨DHÀn]0RÏ;À}e©DHÀ³M“RÏ;Àl÷çZ©DHÀ<’ßSÏ;Àù®\"Ž©DHÀÏ°}SÏ;À|ÄP¹©DHÀ™4Û\0TÏ;ÀO•â©DHÀëö´zTÏ;Àÿ´ªDHÀ]|íTÏ;À«ÛžDªDHÀu:XUÏ;À«:}ªDHÀS7y½UÏ;Àq¿G¹ªDHÀ§NVÏ;À9ÀŒ÷ªDHÀCH†}VÏ;Àwr7«DHÀ6:ÙVÏ;ÀsÓŠx«DHÀ«‚,5WÏ;À±<?¹«DHÀŒkp–WÏ;À=Ôs÷«DHÀ/UEþWÏ;Àâ$J2¬DHÀ>%ÅkXÏ;À‰)Ði¬DHÀºÛXÏ;ÀW\' ¬DHÀ¤PÑEYÏ;ÀVäØ¬DHÀLÒ; YÏ;ÀÛ:}­DHÀÐcPÛYÏ;Àtzè^­DHÀe·ZÏ;Àœ¨fª­DHÀ{A 2ZÏ;ÀB©Nî­DHÀ¹Æ«}ZÏ;À3¼#®DHÀHÚàßZÏ;À¡$\"I®DHÀ¸@ŒT[Ï;À×n.^®DHÀ´\"Ø[Ï;ÀSÙc®DHÀêe\\Ï;À\0ü2`®DHÀZÛ÷\\Ï;Àò’ `®DHÀÌ§*ˆ]Ï;Àé;Fk®DHÀu«\0^Ï;Àð3€®DHÀ }Ìž^Ï;ÀË¶Â®DHÀôðY_Ï;ÀwÃÄ®DHÀZö¬’_Ï;ÀÇý1ö®DHÀÙçPð_Ï;ÀSþò2¯DHÀôu 6`Ï;À ÛÇy¯DHÀ bu`Ï;À>ˆTÄ¯DHÀZÈ¢¼`Ï;À›Û°DHÀO!aÏ;ÀT©J°DHÀªä†aÏ;ÀÑ!V{°DHÀÞ •	bÏ;ÀÓtÜ˜°DHÀšø)–bÏ;ÀTÑÔŸ°DHÀÅÃ°#cÏ;À¡T£’°DHÀŒŠ°ªcÏ;À= `u°DHÀÁG+dÏ;À y¡M°DHÀÌtû¦dÏ;Àº.ê °DHÀ30å eÏ;À¢îAò¯DHÀYs<›eÏ;À»­Ã¯DHÀÖ×‡fÏ;ÀvŒÜ•¯DHÀn¡¹’fÏ;À&i¯DHÀ\"­gÏ;ÀXÂ>¯DHÀW|ŠgÏ;À|‡\r¯DHÀŽí\\hÏ;À¾g£ê®DHÀN	„hÏ;ÀwbÊ¹®DHÀÔ†<òhÏ;À\ZP\nƒ®DHÀF1~]iÏ;À›<J®DHÀæ§ûÊiÏ;À¼®DHÀŠQ@jÏ;À²Ú.á­DHÀÔ$¿jÏ;ÀÆc¬»­DHÀË™~GkÏ;Àª­DHÀßà4ÉkÏ;À<È@³­DHÀJT‰(lÏ;À•=Ý­DHÀ.HalÏ;ÀË<_\"®DHÀ|Ü€†lÏ;À›#r®DHÀ gwªlÏ;À8?ñÁ®DHÀ5\"ÝlÏ;Àã…W¯DHÀª¤!mÏ;ÀP.ûV¯DHÀ-8kmÏ;Àm8êž¯DHÀÂñé²mÏ;Àãmxç¯DHÀ‰ËSýmÏ;Àúä/°DHÀ™«ùQnÏ;À¢H(p°DHÀ.·¼nÏ;Àó|Àž°DHÀ=?oÏ;ÀØö(²°DHÀ:nFÆoÏ;À¹w©°DHÀ~ž+FpÏ;ÀS™¯ˆ°DHÀåˆùÆpÏ;ÀT<Kc°DHÀÒ{äOqÏ;ÀvjH°DHÀàÃÞqÏ;ÀEÖ¤:°DHÀ±µ1nrÏ;ÀÕ\'=°DHÀXPórÏ;ÀynõS°DHÀÏñ¥csÏ;Àª·°DHÀZ§¨´sÏ;À~`\rÁ°DHÀNÒ:ãsÏ;ÀË“Q±DHÀûÆŒùsÏ;ÀƒQ¸]±DHÀkyÌtÏ;ÀÖ¶=°±DHÀÅÎ±tÏ;À»ÅÙ²DHÀÒçÚtÏ;À‘TU²DHÀ#}-tÏ;Àót¥²DHÀ½Û|`tÏ;À<8ð²DHÀE× ´tÏ;ÀŠG™.³DHÀW¾—\'uÏ;ÀgXZ³DHÀÉÂ­uÏ;À?ƒz³DHÀ‘ª€5vÏ;À™nå˜³DHÀµš¾vÏ;À7,£µ³DHÀ1dVLwÏ;ÀÓ8pÉ³DHÀÀŒ!ÞwÏ;À0üÕ³DHÀJÕpxÏ;À0‹âÝ³DHÀu¯yÏ;À¹9(è³DHÀ’Iä’yÏ;À€	_÷³DHÀNïX zÏ;À–h\r´DHÀé\rZ©zÏ;À\"‹+´DHÀ™ÿ%{Ï;Àv‹\'S´DHÀR…êˆ{Ï;ÀUîyŠ´DHÀQiiÇ{Ï;À’Ð´DHÀìÅäÙ{Ï;ÀãzêµDHÀìø!¾{Ï;Ài\\iµDHÀU$x{Ï;À“ïá¬µDHÀµÎ{Ï;ÀÂ£äãµDHÀÊ¾—zÏ;Àáf¶DHÀØÈ{zÏ;Àö¾z8¶DHÀÝ3àyÏ;ÀF[¶DHÀ†ãµyÏ;ÀPù|¶DHÀ\n*™xÏ;Àx Hž¶DHÀ9U)xÏ;ÀUöðÃ¶DHÀÐMj¤wÏ;À+NÐ÷¶DHÀÈNÑ{wÏ;Àl^”9·DHÀoošwÏ;ÀìÊ”o·DHÀ\"xÏ;À¤§,‡·DHÀ°ç”xÏ;À¥ËnŠ·DHÀ¦%Š#yÏ;Àqç=†·DHÀ	}¶yÏ;À^>·DHÀ3ÚºHzÏ;Àê[n}·DHÀP+ÕzÏ;ÀB^Op·DHÀ³QgV{Ï;ÀëO·DHÀ‘GÍ{Ï;Àãò± ·DHÀ-&=|Ï;ÀR¾·ë¶DHÀ~±|Ï;À_¾¶DHÀ‰Fq5}Ï;Ày}¤¶DHÀ*2	Â}Ï;À\Z¬¢¶DHÀž ³K~Ï;Àí.`µ¶DHÀëg6Ñ~Ï;À^Ö¶DHÀ˜ZqUÏ;Àxµäú¶DHÀ§*tÙÏ;À®µ¸·DHÀ1h]€Ï;Àº¸èD·DHÀÌÁ=á€Ï;À?Ó[j·DHÀ¯°dÏ;Àsþ·DHÀ\\.…æÏ;Àà¦\r··DHÀ„ñÜd‚Ï;ÀB±’á·DHÀþ†Ý‚Ï;ÀsÄò¸DHÀ{INƒÏ;ÀHÚþE¸DHÀ.%¸ƒÏ;À:®¸DHÀ‡¹¹„Ï;À[¬{»¸DHÀ†0y„„Ï;Àº÷¸DHÀ¿‚Éê„Ï;À{X3¹DHÀARW…Ï;À‘³.g¹DHÀ\rŽÒ…Ï;À!Ø…¹DHÀ-e%R†Ï;Àv‘®„¹DHÀˆ:Ó±†Ï;À{i`¹DHÀã¶iá†Ï;Àÿ©¹DHÀþóï†Ï;À¸æË¸DHÀ\0_¥ì†Ï;ÀhÂ¹y¸DHÀkêî†Ï;Àãâ|\'¸DHÀaT®‡Ï;À	¥‚Ö·DHÀÂ1‡Ï;À8Ôå‰·DHÀqæ±|‡Ï;ÀIF·DHÀÞÐ×ä‡Ï;Àù1ý·DHÀ¹ÒfeˆÏ;À³#Wñ¶DHÀëpóˆÏ;ÀAÙ]ß¶DHÀ•åk…‰Ï;À*=´Ö¶DHÀ4ÞÄŠÏ;ÀWß\nÔ¶DHÀ—X¬ŠÏ;Àª*Õ¶DHÀ*—ª?‹Ï;Àƒ?Ù¶DHÀ1©pÒ‹Ï;À=±ºà¶DHÀK\ndŒÏ;ÀnŽë¶DHÀ”öŒÏ;ÀSßù¶DHÀì\\†Ï;ÀG·DHÀ—þŽÏ;À??\"·DHÀOüŸŽÏ;À¸!ð;·DHÀïºˆ*Ï;Àø–8X·DHÀ°Ê´Ï;ÀPCZv·DHÀ\rå½<Ï;ÀœÊ§•·DHÀdÒÅÏ;À°Ë“µ·DHÀœ®DM‘Ï;ÀdH¦Õ·DHÀ¥yÕ‘Ï;À®ô¥õ·DHÀ½3²]’Ï;ÀüÊw¸DHÀß>\'æ’Ï;À)xñ4¸DHÀº,&o“Ï;Àú‘åS¸DHÀ¥\0€ø“Ï;Àµ™or¸DHÀ33·”Ï;ÀÉÜ¸DHÀ…è•\n•Ï;Àœˆ¯¸DHÀ¼!“•Ï;À£÷ÌÎ¸DHÀJy –Ï;ÀK_î¸DHÀ U‹¤–Ï;À¥Ód\r¹DHÀÅ‚.—Ï;À’+¹DHÀ3¥ü·—Ï;À6Ë,I¹DHÀÐB˜Ï;ÀYf¹DHÀžÌ˜Ï;Àf*Ûƒ¹DHÀÔ^äU™Ï;À¥P¡¹DHÀ7•Ïß™Ï;Àe§³¾¹DHÀïþÿišÏ;À’KøÛ¹DHÀ¢7PôšÏ;À¸Mù¹DHÀÑ`v~›Ï;ÀãâöºDHÀÂïôœÏ;ÀWY5ºDHÀ“€œÏ;À4Ù¹TºDHÀÍ\'8Ï;À\rìuºDHÀûxIŸÏ;À¥°|–ºDHÀšSß%žÏ;À?|¡¸ºDHÀ•.¬žÏ;À:·5ÛºDHÀD+…2ŸÏ;À„A~ýºDHÀ®vØµŸÏ;ÀR:»DHÀ‘â( Ï;Àëç9»DHÀL2V‚ Ï;À  N»DHÀÏ%ÒÍ Ï;Àä-J^»DHÀC\rž ¡Ï;À¸$m»DHÀ(ÞÂ¤¡Ï;À‘sÜƒ»DHÀXV\'|¢Ï;À]D±ª»DHÀNÜ‡£Ï;À&8“Þ»DHÀÅœ›¤Ï;À(â‘¼DHÀw‹­¥Ï;ÀjwjW¼DHÀü¿ý½¦Ï;ÀU6–¼DHÀ¾»nÁ§Ï;ÀËj¸ß¼DHÀ½µ*¨¨Ï;Àâ{Ù@½DHÀ•J4g©Ï;À÷Ö]º½DHÀ‡©÷©Ï;À×¥ÌD¾DHÀÑdªÏ;À¿Á¾DHÀÚó‰ÀªÏ;ÀŠaÀ¿DHÀy¥é!«Ï;Ài¼¦¿DHÀÅw«Ï;ÀtTð¾DHÀE}ùE¬Ï;À\0<ÆÂ¾DHÀQ*­Ï;ÀŒ[«¾DHÀˆðx<®Ï;ÀØ™øµ¾DHÀU[X¯Ï;À_÷Û¾DHÀã‰±o°Ï;À ¡¿DHÀw\"‹±Ï;ÀF%17¿DHÀzL«²Ï;ÀŽ{X¿DHÀ^ÁµÉ³Ï;Àhuu}¿DHÀ˜	á´Ï;À3V7°¿DHÀ¡ÂiîµÏ;À˜…¹ñ¿DHÀ1àgì¶Ï;À)í“CÀDHÀ>ÄxÒ·Ï;Àƒ¤)¨ÀDHÀŒ,ž¤¸Ï;ÀÓa­\ZÁDHÀ;]þz¹Ï;ÀµîðŠÁDHÀi¼mdºÏ;ÀR3ÄîÁDHÀ˜†¤[»Ï;À$Ï¥HÂDHÀ3½FZ¼Ï;ÀwúAœÂDHÀÞ$\\½Ï;Àÿ|ïìÂDHÀV·T^¾Ï;À™¡;=ÃDHÀKoS`¿Ï;À¦‰èÃDHÀRjRbÀÏ;ÀîŸåÞÃDHÀU•|eÁÏ;À¬ú“.ÄDHÀˆTjÂÏ;ÀÍã|ÄDHÀû›±nÃÏ;ÀÊÕÉÄDHÀvÿ<oÄÏ;À,¡4ÅDHÀ\rO5fÅÏ;Àí¨tÅDHÀ~3ºNÆÏ;À¦ÙÅDHÀ³üC*ÇÏ;À>+0HÆDHÀd3þûÇÏ;À+ôö¼ÆDHÀÉláÆÈÏ;ÀËë”5ÇDHÀÇÌIŽÉÏ;ÀkyÇ¯ÇDHÀìêGXÊÏ;ÀhP^(ÈDHÀçuø*ËÏ;Àä³HœÈDHÀšÛÇÌÏ;ÀO_¼ÉDHÀ{èEÝÌÏ;À»£CxÉDHÀ˜ÊÔcÍÏ;À âÑâÉDHÀ[¯ê=ÍÏ;ÀŸå¾JÊDHÀÄ9ÞÇÌÏ;À?y¢ÊDHÀ•T7¸ÌÏ;ÀÈ˜×ÊDHÀBFSÍÏ;ÀºçôÊDHÀáŒužÍÏ;ÀìVÝËDHÀ\'ÚþÍÏ;À÷|5FËDHÀ7™²\"ÎÏ;À¿I}ËDHÀ‹“\'ÎÏ;À1”UºËDHÀ½TÎÏ;ÀØšTÌDHÀ«úÎÏ;Àé~OÌDHÀÈŸ\'ÎÏ;ÀLVxœÌDHÀ¦(cÎÏ;ÀÀpðÜÌDHÀ®A0ŸÎÏ;ÀäÆ·ÍDHÀA ÌÎÏ;ÀV°ÍDHÀ|ä™éÎÏ;Àj\"ÇåÌDHÀã%áþÎÏ;ÀOkñ©ÌDHÀbaY#ÏÏ;Àþ$šbÌDHÀŒ¼fÏÏ;ÀÔpÌDHÀÚõåÊÏÏ;ÀSSëËDHÀ‚?KÐÏ;À3~lÎËDHÀ±“ZÙÐÏ;ÀÎ€\0ÆËDHÀs‘iÑÏ;À/l–ÎËDHÀtuÂõÑÏ;Àu>|äËDHÀ@g{ÒÏ;ÀB™‰ýËDHÀÆxòÒÏ;Àl±2ÿËDHÀ´o­SÓÏ;À\r#H×ËDHÀ‘ÝÌÓÏ;À¾Éæ“ËDHÀMRa¥ÓÏ;À GFËDHÀ¡Ú°ÓÏ;À2íõÊDHÀuVÓÓÏ;À •«ÊDHÀ¿ŒãÔÏ;À¬ê¥ÊDHÀòýwÔÏ;À¼Ù‡ÊDHÀ‰$UÙÔÏ;À†\rV¸ÊDHÀsqÌÕÏ;Àµ•ýÊDHÀ:IÕÏ;ÀÊ%KËDHÀÍ|xrÕÏ;ÀÈô™ËDHÀ—c’¯ÕÏ;À	s,ÞËDHÀi³ãÖÏ;Àµ\"\rÌDHÀç1[™ÖÏ;ÀZ’è)ÌDHÀ„\\’\'×Ï;ÀÙJó=ÌDHÀ×3\0³×Ï;Ày[\'TÌDHÀŒE33ØÏ;À¼QuwÌDHÀ8;½™ØÏ;À‹½“«ÌDHÀ›á»ÖØÏ;À/ÃŠïÌDHÀ„³õØÏ;Àà&ø=ÍDHÀðe}ÙÏ;ÀP¾mŽÍDHÀ€Û%IÙÏ;ÀNœ ×ÍDHÀßŸ(¡ÙÏ;À™ëxÎDHÀ\rv3ÚÏ;Àªi¡(ÎDHÀˆ•¿+ÚÏ;À[“²ÎDHÀy \ZÚÏ;À’‚\ZÕÍDHÀœmGþÙÏ;ÀÊ……ÍDHÀ‰kíþÙÏ;ÀÅTL7ÍDHÀn+Õ0ÚÏ;ÀËñ8ôÌDHÀÍèÝ•ÚÏ;ÀÍQ	ÄÌDHÀÑ·ÛÏ;ÀØÒ[¬ÌDHÀÔL¢žÛÏ;Àâê\0±ÌDHÀý“bÜÏ;ÀØ10ÓÌDHÀmšìfÜÏ;ÀÉ·qÍDHÀ\Zœ˜ÜÏ;ÀïrZÍDHÀò3­ÜÏ;Àù•ôªÍDHÀíÉ°ÜÏ;Àg‚‹ýÍDHÀ˜†0©ÜÏ;À¼NœOÎDHÀÐtŒÜÏ;À7 ÌžÎDHÀ”Ô›TÜÏ;Àë©ðéÎDHÀ¯R-ÜÏ;Àpåý2ÏDHÀ·Ï\rÉÛÏ;Àœ?Þ{ÏDHÀL–ƒÛÏ;À–»ÄÏDHÀ#Kø>ÛÏ;ÀÂíç\rÐDHÀ¼©wÛÏ;À»™‰YÐDHÀ)TÝ÷ÚÏ;À­LÏ¨ÐDHÀ~Øˆ\nÛÏ;Àýe÷ÐDHÀt	¬DÛÏ;À‰ü?ÑDHÀR?Ÿ™ÛÏ;À²gPÑDHÀþ,úÛÏ;ÀÅdÅ¿ÑDHÀž:\'aÜÏ;Àà*ûÑDHÀ‰æÌÜÏ;ÀÇnž3ÒDHÀþG=;ÝÏ;ÀTJ—jÒDHÀƒ£y©ÝÏ;ÀÈÛ¶¡ÒDHÀ’ŠÞÏ;Àþ…ÛÒDHÀóZ4pÞÏ;ÀPdÁ\ZÓDHÀÛ-ó»ÞÏ;Ààâa`ÓDHÀËvðÞÏ;À§f,¬ÓDHÀ;ˆ»ßÏ;ÀüoûÓDHÀFUúDßÏ;ÀÓ@âIÔDHÀªÛ÷„ßÏ;Àí¤’ÔDHÀŽzßßÏ;ÀiÐÔDHÀhÓNOàÏ;À1‹úÕDHÀ¯{ãÈàÏ;À&Ýƒ2ÕDHÀÒ,AáÏ;ÀÄ\\’aÕDHÀlûN°áÏ;ÀÝU©–ÕDHÀÝCâÏ;ÀLÒÕDHÀPp\\{âÏ;À ·jÖDHÀkwüçâÏ;À²xBÖDHÀ.³òcãÏ;ÀåãaÖDHÀäzÏïãÏ;À§ëìfÖDHÀ:ÌùäÏ;ÀÌ†’_ÖDHÀ9ûåÏ;À½ÛUÖDHÀá¢¥åÏ;ÀØ#RÖDHÀ¨\0â/æÏ;ÀðÏ\\ÖDHÀ[×æÏ;À!œX€ÖDHÀÍuáæÏ;À›‡¿ÖDHÀŸºþæÏ;Àr˜p\r×DHÀ‚}IûæÏ;À¢ÏR^×DHÀö7ßÝæÏ;À€%W®×DHÀšÜ‘­æÏ;ÀŒáû×DHÀ]žtæÏ;ÀiFHØDHÀÏ]O<æÏ;À:µ•ØDHÀ7J	æÏ;ÀG@üâØDHÀ}ÏÈÜåÏ;À‰\\/2ÙDHÀtW™´åÏ;Àõ’‚ÙDHÀÔÇ‹åÏ;ÀðEaÑÙDHÀdÉ+UåÏ;ÀA5\"ÚDHÀcy<\nåÏ;ÀfCäbÚDHÀ…CQ´äÏ;ÀÚrì¥ÚDHÀªÎ=eäÏ;À×Ó»êÚDHÀÐ^!8äÏ;ÀñUã1ÛDHÀÖ-QGäÏ;ÀÐ§¹yÛDHÀ‚ÂäÏ;ÀYQ»ÛDHÀ}ùäÏ;ÀŠYàíÛDHÀÐÇÇzåÏ;À…¹ÜDHÀB«øæÏ;À2)\"ÜDHÀQ÷G–æÏ;ÀT—sÜDHÀßä4$çÏ;Àj-£öÛDHÀ;?q®çÏ;À§]ÚÛDHÀ@\\4èÏ;À›j+¸ÛDHÀÀaÉ¸èÏ;À¤§š”ÛDHÀ\Zõ@éÏ;ÀÒCjvÛDHÀ?ŠkÎéÏ;ÀnZïaÛDHÀQðg_êÏ;ÀÙ—BYÛDHÀ–YyñêÏ;ÀIÐ\\ÛDHÀh¥­ëÏ;À8akÛDHÀÒk¼ìÏ;À¯¤‚ÛDHÀ¢øJ™ìÏ;À‘!ŸÛDHÀ_!\"íÏ;Àmü(¾ÛDHÀgu\rªíÏ;À\0\'1ÞÛDHÀÀ4ë0îÏ;À%w2ÿÛDHÀàç2µîÏ;À]ü@#ÜDHÀ“!d7ïÏ;ÀsÝIÜDHÀ<¨»ïÏ;ÀÔmÜDHÀ‘jßDðÏ;ÀÐ}óŠÜDHÀ1®ÒðÏ;À{–êŸÜDHÀ7EýcñÏ;À˜TÛ¬ÜDHÀ8]éöñÏ;ÀŽ³h´ÜDHÀïí‰òÏ;ÀË“¹ÜDHÀæÃóÏ;ÀÀeg¿ÜDHÀu’T¯óÏ;ÀH™*ÈÜDHÀªúqAôÏ;ÀJNºÓÜDHÀèÃÒôÏ;ÀÒaèáÜDHÀ[ØfbõÏ;À!ÀùóÜDHÀÈ8×îõÏ;ÀujÐÝDHÀH#`töÏ;ÀS´ƒ,ÝDHÀŸ½èîöÏ;ÀŸÁXÝDHÀÈª&[÷Ï;ÀYD¾ÝDHÀû´·÷Ï;ÀïpyÏÝDHÀz&øÏ;ÀÜºÞDHÀZàÄMøÏ;Àñn]ÞDHÀŸ¼’øÏ;À´¥ä¦ÞDHÀRÄˆÖøÏ;ÀF9ðÞDHÀ,¼ŽùÏ;ÀWi8ßDHÀ\r.mùÏ;ÀÔç…~ßDHÀ+ÔÃùÏ;À@£„ÁßDHÀ#6Ý#úÏ;À¢Õ1\0àDHÀoñŽúÏ;À~18àDHÀPQûûÏ;À‰dKfàDHÀ\rÌ›ŠûÏ;À¨T…àDHÀ\r%üÏ;ÀÆ¤VàDHÀë’\Z¦üÏ;ÀI}·‡àDHÀa¥E7ýÏ;Àü7&yàDHÀ¾œüÇýÏ;À5ÃÞhàDHÀßÚXþÏ;À*•äVàDHÀâ?^çþÏ;À€ÜZCàDHÀ7ò7vÿÏ;À°3».àDHÀ@VÃ\0Ð;ÀIUƒàDHÀ#3“\0Ð;ÀCê3àDHÀÐ˜ô!Ð;Àî9ÐïßDHÀ òÂ±Ð;ÀËÜÞßDHÀ³¶BÐ;À\ZÒßDHÀ´0®ÓÐ;ÀèêÐßDHÀÒ}ýQÐ;À„ËÐÔßDHÀ²hˆ‹Ð;ÀB(aÄßDHÀ¦SgÐ;Àdl!•ßDHÀÙBÊÐ;ÀÊ³`ßDHÀ‰áØ‰Ð;ÀKš7ßDHÀI¨\ZÐ;ÀPº+ßDHÀØ—ò‚Ð;À’víÞDHÀ¥-Ð;Àj}7ÄÞDHÀ«kƒ\0Ð;ÀmŒÎšÞDHÀû0Ä\0Ð;Àx÷ÞsÞDHÀ ¶:~ÿÏ;ÀeºOÞDHÀc8óÿÏ;ÀŸàÃ%ÞDHÀ\rúe¡þÏ;Àt[­íÝDHÀJ\ndiþÏ;Àn?®©ÝDHÀ<ÛhjþÏ;À=Ôæ^ÝDHÀ1ä¬–þÏ;ÀÆû–ÝDHÀO(ÚþÏ;À§9åÉÜDHÀá‚V1ÿÏ;À%($‰ÜDHÀ×RûÿÏ;ÀávTÜDHÀôH\Z\0Ð;À+E,ÜDHÀ3o¥\0Ð;À=tYÜDHÀlC5Ð;ÀxÑúÜDHÀc¸ÕÇÐ;ÀÐ“¹ÜDHÀôaR[Ð;ÀçO\0ÜDHÀ’jûîÐ;À \n+ÜDHÀs\'‚Ð;ÀÛoÜDHÀ’Ð@Ð;À.diüÛDHÀÇ-¥Ð;ÀTyyîÛDHÀ›25Ð;À)¶ÝÛDHÀëxöÄÐ;Àä~ÊÛDHÀ+¬cUÐ;À• \'¹ÛDHÀF@¬æÐ;À%`Þ©ÛDHÀÀ§OxÐ;À(\'œÛDHÀN5\nÐ;À=Â†ÛDHÀCt¶œÐ;À¸Ž¾ˆÛDHÀR¶.	Ð;À»WˆÛDHÀÌ±0½	Ð;Àzoø”ÛDHÀ…JD\nÐ;ÀÌÿm±ÛDHÀóË%¿\nÐ;ÀfB#ÜÛDHÀc¯#+Ð;À½_ŸÜDHÀŒÐ†‰Ð;À.@QÜDHÀw™®ÛÐ;ÀlJû•ÜDHÀp}\"Ð;À°…ÞÜDHÀW5È^Ð;Àëô)ÝDHÀûßj‘Ð;ÀÝ¬žwÝDHÀÚ1ö»Ð;ÀúàÆÝDHÀ¡÷ÉáÐ;À!}ÞDHÀ¯·\rÐ;ÀkegÞDHÀ&‘Ô*\rÐ;Àák´·ÞDHÀ*hœR\rÐ;ÀzçsßDHÀë—ƒ\rÐ;Àm¾dUßDHÀ\r;À\rÐ;À@‡¶žßDHÀ¤;Ú	Ð;ÀñE‘äßDHÀ‚ÌH\\Ð;Àâ©9\'àDHÀ6SµÐ;ÀœÍgàDHÀ€òÐ;Àš™ã¤àDHÀð`«qÐ;ÀêrWâàDHÀqÏqÌÐ;Àb—!áDHÀ®U\"Ð;ÀÃ¸&cáDHÀ™ÞrÐ;À‘³™¦áDHÀ¨:ªÁÐ;À³ÔÎêáDHÀÙ¥Ð;À.âDHÀÛRcjÐ;À!³2nâDHÀËŸ—ÍÐ;ÀË~ç§âDHÀvú£<Ð;À—¢žÑâDHÀ Ú²Ð;ÀV\r³ÚâDHÀ3@\"Ð;À¥ƒ½âDHÀ}´pÐ;ÀÏû„âDHÀA“ŽÐ;ÀÖœ,<âDHÀ-ýi‰Ð;ÀïÉÎìáDHÀ·…¢lÐ;ÀÚ)\0žáDHÀçê°>Ð;Àž±=QáDHÀW¨Ð;ÀJ¦ùáDHÀ¯§ÕÁÐ;Àøôî¾àDHÀuyÐ;À& ¦xàDHÀN·Ê,Ð;Àeci3àDHÀ!çSßÐ;À=sîßDHÀ5Ê]“Ð;ÀŸ7ý¨ßDHÀªDÀLÐ;Àt0bßDHÀßf°Ð;ÀvÁÅßDHÀ‚[|þÐ;À¬È¤ËÞDHÀí¥´Ð;À™å.}ÞDHÀ™”¸0Ð;ÀTí1ÞDHÀâ­ÐyÐ;À™a®ñÝDHÀÓ$äÐ;Ày¿-ÆÝDHÀ—ïggÐ;ÀýŒ²ÝDHÀèH*óÐ;ÀÄó³ÝDHÀSp!~Ð;ÀÉÅÝDHÀ5ÝjÐ;À\0‹ÞÝDHÀ‹wBÐ;ÀéßùÝDHÀBØÐ;ÀX?…ÞDHÀ´šÎžÐ;Àà?V1ÞDHÀý¢&Ð;ÀZç¢MÞDHÀ$ß­Ð;Àˆ¾ûjÞDHÀýÂr4Ð;Àÿ/I‰ÞDHÀ¹ˆºÐ;Ào•\'¨ÞDHÀâSÏ@Ð;À¿¸”ÆÞDHÀ÷ÇÐ;À XãÞDHÀjSAPÐ;ÀƒšþÞDHÀS¥¼ÙÐ;ÀÒ“ŒßDHÀw‡öc\ZÐ;ÀÑmk/ßDHÀäXî\ZÐ;À,áGßDHÀU|xÐ;ÀiÀ=`ßDHÀ²„Ð;ÀÜh¶yßDHÀ¶¤B‹Ð;Àñ±“ßDHÀ¯úKÐ;Àäµ×­ßDHÀ;Ð;À˜ ,ÈßDHÀñÁç%Ð;À‚œøâßDHÀF°®Ð;ÀºVþßDHÀCq5Ð;À¬Ì‘àDHÀvÔ˜»Ð;Àì6C:àDHÀ>&@ Ð;Àž[àDHÀ­¢Â Ð;À«„\Z~àDHÀZkC!Ð;ÀÕ£àDHÀÕÙ¡Â!Ð;ÀÙQÉÉàDHÀŠæ”@\"Ð;ÀnÀñàDHÀ]d¡½\"Ð;Àw	¢\ZáDHÀà)?:#Ð;Àío\rDáDHÀEÏ¶#Ð;ÀÆ¡±máDHÀwÁ_3$Ð;À·§m—áDHÀ¦KÎ¯$Ð;À¦ÚIÁáDHÀŒçn+%Ð;À×@ÏëáDHÀYp¥%Ð;ÀÝ‘âDHÀký&Ð;ÀÝ<¶DâDHÀn¼¾”&Ð;À”7:sâDHÀÿÆÐ	\'Ð;Àpu£âDHÀ—y-}\'Ð;ÀØSÔâDHÀ.Áî\'Ð;À‚*ãDHÀçhÈ](Ð;ÀS-°:ãDHÀ3KõÉ(Ð;ÀlôÇpãDHÀ3}?2)Ð;À“í©ãDHÀèxR—)Ð;ÀHµ#ããDHÀ°8û)Ð;ÀÈGÓäDHÀ$®`_*Ð;ÀghgXäDHÀ“ÖwÄ*Ð;À*ˆ’’äDHÀ›`n*+Ð;À\0ÔbÌäDHÀë”5+Ð;À:†`åDHÀ’²õ+Ð;ÀÆ\ZÝ@åDHÀu+Y,Ð;ÀWø´{åDHÀýŠ¼,Ð;ÀGË¶åDHÀCo;-Ð;Ài/2òåDHÀ¯t®€-Ð;À­@.æDHÀ}7œÞ-Ð;À(í\rlæDHÀ#W)6.Ð;ÀÂ¬æDHÀ1Éxƒ.Ð;À@N&ñæDHÀYøsÃ.Ð;ÀoÙ¥9çDHÀó=kø.Ð;À×þ2…çDHÀ ýµ&/Ð;À÷FÒçDHÀ\0wT/Ð;ÀÒaèDHÀK>+ˆ/Ð;ÀÅkèDHÀòmrÄ/Ð;ÀE“º´èDHÀLÎa	0Ð;ÀÓúûèDHÀLKŒQ0Ð;À~¢XBéDHÀ«ôî“0Ð;Àç~mŠéDHÀTµ,Ì0Ð;Àˆ£0ÕéDHÀg=Mú0Ð;À@)\"êDHÀ%! $1Ð;À¦oêDHÀÖ}³U1Ð;ÀÖûZ»êDHÀa<†–1Ð;À×a\'ëDHÀSç1Ð;À’d²EëDHÀÑš¤D2Ð;Àúš«‚ëDHÀ^³à§2Ð;Àºµ‹»ëDHÀ¤93Ð;ÀWžñëDHÀ{®n3Ð;À&÷R%ìDHÀHÒ3Ð;À=ÖŽVìDHÀ¹_Ô14Ð;À»ñƒìDHÀ1mµW4Ð;ÀCe^•ìDHÀ {˜4Ð;À@A‡²ìDHÀ1Báå4Ð;Àõ.ÔìDHÀø‚†@5Ð;À­ÂøìDHÀ$-­5Ð;Àlû€íDHÀ9Ó\'6Ð;ÀsÃ¬BíDHÀ?ØŠ¨6Ð;À=ÀfeíDHÀ%8+7Ð;À¥Ýó…íDHÀ0Q®7Ð;ÀS)¦íDHÀY918Ð;À\rU÷ÆíDHÀy˜³8Ð;ÀwÅyèíDHÀÜ59Ð;À/¤t\nîDHÀ=˜þ·9Ð;Àl$L,îDHÀ[F::Ð;ÀÍ¹MîDHÀs´\'½:Ð;Àn\ZÄmîDHÀ\'Þø@;Ð;ÀíŒîDHÀ¨²ÄÅ;Ð;ÀQ«îDHÀqËqK<Ð;À‚´>ÈîDHÀfÁ–Ñ<Ð;À¥_ÈäîDHÀÌýÓW=Ð;À^Fà\0ïDHÀì	5Þ=Ð;À>¨ïDHÀ*\nÞd>Ð;ÀEò˜7ïDHÀ³§Úë>Ð;À°ÉZRïDHÀ[9s?Ð;À>ŸmïDHÀ\n%ú?Ð;ÀŠðUˆïDHÀy÷\'€@Ð;ÀHß¤ïDHÀžzAÐ;À&=iÃïDHÀáç„†AÐ;ÀœY¥äïDHÀ×ûMBÐ;À7BðDHÀòBk„BÐ;Àôqo.ðDHÀì26CÐ;ÀP	âUðDHÀ	ƒ³|CÐ;Àh¼Þ~ðDHÀE$ªöCÐ;Àf?n©ðDHÀã“€nDÐ;Àm¨ÕðDHÀ¨MÖãDÐ;ÀìñDHÀfõæVEÐ;ÀMiQ3ñDHÀkôÚÇEÐ;ÀKÂdñDHÀCãR6FÐ;ÀæÓð—ñDHÀ5Î¡FÐ;ÀHªìÌñDHÀM³	GÐ;À³\0òDHÀR\0AmGÐ;À{è“=òDHÀäÊGÐ;Àëƒ%zòDHÀJïc HÐ;À	LºòDHÀóL‹hHÐ;ÀÕ_ÏþòDHÀ|gHÐ;À¹ïqHóDHÀºÎÃ¾HÐ;Àõt(–óDHÀ®©DÔHÐ;ÀY£–åóDHÀyË>çHÐ;ÀËîé4ôDHÀvPIÐ;Àk\0æ‚ôDHÀÔ$A0IÐ;À5ÏôDHÀ«á#eIÐ;À\n:ÍõDHÀóÇdŸIÐ;À³ä6cõDHÀ~v\ZáIÐ;À\'GqªõDHÀµ,JÐ;Às_îõDHÀ-å„JÐ;À£Çm-öDHÀR—PæJÐ;À@NgöDHÀ¢Ü”JKÐ;À zV öDHÀäPð¥KÐ;À[ÁTÝöDHÀ`7‡íKÐ;ÀÙ g ÷DHÀä¾¬\ZLÐ;ÀPþài÷DHÀvíÚCLÐ;ÀüS³÷DHÀ€é,‰LÐ;À]Köó÷DHÀùÆ}îLÐ;ÀªLD(øDHÀõU\ZgMÐ;À€FPøDHÀZåMÐ;ÀIAGsøDHÀvËîYNÐ;ÀuZøøDHÀg…”½NÐ;À2ö]ÕøDHÀÎOÐ;À°–1ùDHÀDFíNOÐ;ÀFø=]ùDHÀÛEl‚OÐ;ÀìPú§ùDHÀ UÔ­OÐ;ÀŠ·uôùDHÀ¶RÕOÐ;ÀzÆÌAúDHÀaIúOÐ;ÀÉÝ‹úDHÀÌò½PÐ;À¥nÞúDHÀ¦ôÅ%PÐ;ÀPÌÃ-ûDHÀ-û*PÐ;À–#~ûDHÀËÍ£)PÐ;ÀÝõkÎûDHÀÈ×PÐ;À÷aÔüDHÀ_¼îOÐ;À§ç¿güDHÀÓXI¸OÐ;À4ùG±üDHÀ„¶‘‹OÐ;À¼îüüDHÀ šåpOÐ;À­-KýDHÀÀÉ¼gOÐ;À‡Î¥šýDHÀæ8ˆjOÐ;Àý;›êýDHÀj=ÅoOÐ;Àîßà:þDHÀ4srOÐ;Àª…V‹þDHÀçÚÖpOÐ;À±äÛþDHÀŒàjOÐ;ÀOE,ÿDHÀŒûXOÐ;Àðüè{ÿDHÀÏ5ú7OÐ;ÀoO+ÉÿDHÀßÖQÿNÐ;À½¤6\0EHÀB*ÚªNÐ;À0J\0EHÀ‰—\'ANÐ;ÀÑch\0EHÀ|ÃÇMÐ;ÀÆ–_\0EHÀ\Z7ëRMÐ;Àºk6\0EHÀRòLÐ;À5öÿÿDHÀ€@ LÐ;À™tàÿDHÀœyLSLÐ;À¦þgøÿDHÀ|ÚLÐ;À˜è8\0EHÀk½ÝKÐ;Àp¯ñ…\0EHÀ\0	Û¼KÐ;ÀZ\\Ö\0EHÀÜIªKÐ;ÀŽ¨w(EHÀfzU¥KÐ;À¯ò!{EHÀ%zô­KÐ;ÀºÖˆÍEHÀÆŸëÀKÐ;ÀùÅ}EHÀOÛ”ÙKÐ;ÀÆR%qEHÀËÙõKÐ;À\\ŠŽÂEHÀ¶š\0LÐ;ÀÁø¾EHÀù¨/4LÐ;ÀdÍìdEHÀÅq<OLÐ;À\\¡l¶EHÀ’ÃdLÐ;ÀT&cEHÀ	*œuLÐ;À”uÍZEHÀ{ÜƒLÐ;À\'åŒ­EHÀiÿŽLÐ;ÀEk\0EHÀYy×šLÐ;À‹ó=SEHÀæz¨LÐ;ÀÑÛç¥EHÀ¥êû¶LÐ;ÀÕbeøEHÀÓŸ ÇLÐ;À•NÏJEHÀÆ”5ÙLÐ;À,%EHÀª=àïLÐ;À(|ïEHÀZŠËMÐ;ÀÑl}@EHÀT<ò/MÐ;ÀWf‘EHÀÓ¿îZMÐ;À³ÔùßEHÀxYx’MÐ;ÀË\0,EHÀÆFÛMÐ;Àc•ÈrEHÀæ.38NÐ;ÀÏ”:°EHÀ­¢NÐ;ÀöÁ®ÚEHÀ±³V÷NÐ;À¦²ÿÛEHÀæ‡…OÐ;À«M©EHÀîqß$OÐ;ÀÄîÿZEHÀkŒsOÐ;ÀW9îEHÀ(8…OÐ;ÀY­¶EHÀÍ¿³OÐ;ÀþâIdEHÀz|OÐ;ÀÒ9fEHÀ<X¸>OÐ;Àvg·ÅEHÀ˜å¿}OÐ;À>”½{EHÀZÌOÐ;À¤Áî6EHÀÝ6\r/PÐ;ÀQ„ÿEHÀ#ê\r«PÐ;ÀŽè?ÜEHÀõ8QÐ;À½ýïËEHÀÆÄÉQÐ;ÀÝBšÈEHÀX·ÔZRÐ;ÀéÕ±ÐEHÀ\r_¸èRÐ;Àzº äEHÀñ¸rSÐ;À\'ð&EHÀ„È…õSÐ;Àcž§%EHÀ‹7žkTÐ;À ¨­SEHÀQc:ÊTÐ;Àl~EHÀUA\rUÐ;À`*UÖEHÀµÿ\Z4UÐ;À´èl$EHÀx‡f9UÐ;À™‘ûsEHÀ>UÐ;À0ž¿EHÀZÎáÍTÐ;ÀËEHÀN(;vTÐ;ÀoS4HEHÀÒÂTÐ;ÀfÈb‰EHÀ–?ÉÅSÐ;À¤ôˆÌEHÀþÈ}SÐ;À™DÇ	EHÀè#MSÐ;ÀÑNø_	EHÀrx”=SÐ;Àiÿ®	EHÀn«XSÐ;ÀÉ73û	EHÀ>êmSÐ;ÀoðÒ@\nEHÀÈµ\0üSÐ;ÀÙÝ+\nEHÀ.<]fTÐ;ÀW-Â·\nEHÀÆ§RÓTÐ;À“bOï\nEHÀÎA<UÐ;ÀÜ6‚)EHÀSÿ\"UÐ;ÀÆ¥ŠgEHÀ”«5öUÐ;À>¶X©EHÀÁLVÐ;ÀÍÂÃìEHÀld°£VÐ;ÀÅW/EHÀÃ‡\0WÐ;À\\êìoEHÀTçrdWÐ;ÀÎúÜ¬EHÀÍ¼=ÍWÐ;À¿æSçEHÀéÒa8XÐ;À$y \rEHÀ²ã¹¤XÐ;À/êX\rEHÀk‚qYÐ;ÀÖü\"‘\rEHÀ²”Ñ}YÐ;ÀP7É\rEHÀ‰ÏPéYÐ;ÀZD{EHÀÃÞTZÐ;À™(¼;EHÀŽ¯o¾ZÐ;ÀáÏuEHÀd˜([Ð;À£ü~®EHÀÄ|­’[Ð;Àþ‘èEHÀ\Zxü[Ð;À@s\"EHÀ\r‘e\\Ð;À¦àY\\EHÀSBÍ\\Ð;À¸I—EHÀ=ï32]Ð;ÀµÛîÓEHÀÌ*¸”]Ð;ÀNâ§EHÀùõýô]Ð;ÀÇK|PEHÀ÷$S^Ð;ÀÆZEHÀÊ&¯^Ð;À«AÑEHÀwïÎ_Ð;ÀVÛ1EHÀ=€¶__Ð;À9\"3VEHÀÛ·²_Ð;À„ŸšEHÀ[6&\0`Ð;À)áEHÀç›G`Ð;Àt¦)EHÀc‚n‡`Ð;ÀJ=tEHÀ•ÌûÁ`Ð;À;%iÀEHÀ”Çœø`Ð;À)Å\rEHÀb1¿,aÐ;À%G[EHÀé×E_aÐ;À èT©EHÀeýŠaÐ;À ñ›÷EHÀ»¦>ÀaÐ;ÀƒÕFEHÀùV±íaÐ;ÀØó”EHÀÇt¸bÐ;ÀƒÓnäEHÀö=bÐ;ÀéÆ›4EHÀÚ}abÐ;À…EHÀNf¯ƒbÐ;À¶©ÕEHÀÊD¦bÐ;À‹·4&EHÀîÈÊbÐ;À!¥vEHÀX¡XòbÐ;À²ÆEHÀm·cÐ;ÀZ»EHÀü9OcÐ;Àd&=dEHÀüf†cÐ;ÀÂIø°EHÀB®ŽÄcÐ;ÀªþûEHÀJ£Ò	dÐ;À”pEEHÀ§bVdÐ;À6hÔ‹EHÀ6Ñõ©dÐ;ÀßÇÐEHÀ#1leÐ;ÀT˜ŒEHÀ‡ÒU^eÐ;À,$sSEHÀ¾ØÁeÐ;ÀÀ×EHÀû1fÐ;Àp1\"ÃEHÀl]B¯fÐ;À«åæäEHÀâ68gÐ;À~´îEHÀ,†œÈgÐ;À’ÿèEHÀÏÓu[hÐ;ÀåwhäEHÀ›îhÐ;À!3IæEHÀÃºj€iÐ;ÀÚ.¬îEHÀÄmÜ	jÐ;À¼H\ZEHÀkjjÐ;À¸ß¶+\ZEHÀî™NèjÐ;ÀÁ#çd\ZEHÀq>xDkÐ;À7 ’¥\ZEHÀ¼¶Æ™kÐ;ÀyTEé\ZEHÀå¢ÕékÐ;À!/EHÀÂ}6lÐ;ÀÅÐøuEHÀHÌÍlÐ;À¥P½EHÀæÄÍlÐ;À ÝUEHÀô@mÐ;À$´oJEHÀÇ”nmÐ;À~\\YEHÀ÷êÂmÐ;Àî\'*ÓEHÀ…†únÐ;À¼Í*EHÀF™íqnÐ;ÀU×XEHÀQ•ÊnÐ;ÀïX3›EHÀS\0_%oÐ;À]–ÜEHÀÎOvƒoÐ;À\nèpEHÀÛÿlåoÐ;À,ÞpZEHÀ`òKpÐ;Àý×–EHÀ@m\0¸pÐ;ÀK®QÎEHÀ~ˆ¯)qÐ;ÀméEHÀn\Z-ŸqÐ;ÀMÝ4EHÀ‰CÓrÐ;À“V1eEHÀªjúrÐ;À_ûv”EHÀ>d4\nsÐ;ÀäÃEHÀy¯J…sÐ;Àóè\nñEHÀõ½þ\0tÐ;Àöo} EHÀèøØ|tÐ;ÀH_ÀK EHÀ?àeøtÐ;À™1y EHÀÀŽlsuÐ;À\n±\n§ EHÀ4™éíuÐ;Àb1]Õ EHÀQƒ‡hvÐ;ÀoXŸ!EHÀøÄ	ävÐ;ÀQ.+1!EHÀ¤¡¿`wÐ;À8Áž]!EHÀøÀÞwÐ;À½ýÃˆ!EHÀUí³]xÐ;À¼zé²!EHÀùy#ÝxÐ;À\'›…Ü!EHÀÝJì\\yÐ;À|¡Í\"EHÀÛ ÝyÐ;À¥à.\"EHÀé=]zÐ;Àj\rX\"EHÀ†è¦äzÐ;À·)„\"EHÀ:•Ã{Ð;ÀMð\0Î\"EHÀ-Bb}Ð;À¿\nX#EHÀîáLVÐ;ÀÛÿ#EHÀ–£\0¼€Ð;ÀÝ¤âv$EHÀÎP·uÐ;À&M±´$EHÀúGaøÐ;À^ß“Ý$EHÀ)f¿{‚Ð;Àb©­%EHÀAt^\0ƒÐ;Àúý\'%EHÀ‰3ù„ƒÐ;À…PÔK%EHÀßN„Ð;Ào?q%EHÀÓ\0‹„Ð;ÀÑ€¹—%EHÀJ·Á…Ð;Àïcâ»%EHÀÐóœ—…Ð;À#˜JÜ%EHÀ·Í]!†Ð;À&›*ú%EHÀÅ¦î«†Ð;À\'oµ&EHÀ	J6‡Ð;À4Õ2&EHÀ±ÎÁ‡Ð;À:£%O&EHÀ•\\KˆÐ;À§®Êk&EHÀ?þÕÕˆÐ;À’z‹ˆ&EHÀ\0\r#a‰Ð;À—¬¤&EHÀÄ0ŠÐ;Àœ,Æ&EHÀ`j‹Ð;ÀðQÙ\'EHÀ—$™‚Ð;À£p`\'EHÀR{*yÐ;À`ß!·\'EHÀ˜Jõ™Ð;ÀxàÆç\'EHÀãÏ:‘Ð;ÀÍ~ì(EHÀí+pÈ‘Ð;ÀÄ	\0(EHÀk£‰V’Ð;À¤¼D0(EHÀ	ú|Ï’Ð;ÀHëÁC(EHÀ‹ÎmH“Ð;À%ž+V(EHÀ-UÂ“Ð;Àatäf(EHÀÊDº<”Ð;ÀM¢Ìu(EHÀ¸”Ð;ÀXi(ƒ(EHÀ^€¥3•Ð;Ài¥(EHÀ’ë®•Ð;À¥qãœ(EHÀ¿õ7)–Ð;À\0|¬(EHÀWËc¢–Ð;Àgï˜¾(EHÀwë„\Z—Ð;À¶¹°Ò(EHÀ†Ãž‘—Ð;ÀÙJzè(EHÀÉ	™˜Ð;ÀSD\r\0)EHÀ©/o|˜Ð;Àï‹j)EHÀve…ð˜Ð;ÀÒ—4)EHÀxfd™Ð;À¬aÿN)EHÀòz1Ù™Ð;À£¨¿g)EHÀ«‚ŽPšÐ;Àj ïy)EHÀYG\ZËšÐ;ÀnŒ\'‚)EHÀLpF›Ð;Àu\0Å)EHÀp¿›Ð;ÀÐÛvr)EHÀ7°˜+œÐ;À¶©9X)EHÀ°ìXœÐ;Àu\n.)EHÀ„=Ž¶œÐ;ÀÞ°ô(EHÀîçÜœÐ;ÀfwÅ²(EHÀ…nEÿœÐ;Àƒ+6o(EHÀ|–(Ð;Àí¢.(EHÀ¤ÖbÐ;À!÷ò\'EHÀEç°Ð;À%/½\'EHÀ¿Æþ\ržÐ;Àn1 \'EHÀZEužÐ;À;`¸i\'EHÀ&\n\"åžÐ;Àù¼K\'EHÀ!n¬ZŸÐ;ÀþT×5\'EHÀ¨JÔŸÐ;Àvhã&\'EHÀÂe0P Ð;ÀÚêÛ\'EHÀ#ñýÌ Ð;À˜x\'EHÀ”S.J¡Ð;À86ø\'EHÀ‚TÇ¡Ð;ÀÉ(\'EHÀ6$pA¢Ð;À2G€\'EHÀÚy1¶¢Ð;À\\ü¼3\'EHÀ80\"£Ð;À”T\'EHÀ·¶‚£Ð;Àj0\'EHÀ\rÉãÒ£Ð;ÀLzà²\'EHÀ¶M:¤Ð;ÀoYí\'EHÀGo!F¤Ð;À_À5-(EHÀx\'i¤Ð;Àøp(EHÀWè¤Ð;Ào{ô´(EHÀì¤L‹¤Ð;ÀË\\Ûú(EHÀJÉŽ¤Ð;ÀqÝLA)EHÀ”›z¤Ð;À¢É‡)EHÀÖ…’¤Ð;À†6ÿÌ)EHÀàwJ«¤Ð;Àä**EHÀ9ý~ß¤Ð;ÀúuíJ*EHÀø².¥Ð;ÀL÷‰z*EHÀ+SO”¥Ð;ÀYæf™*EHÀ‰ù	¦Ð;Àš{A©*EHÀø¹¡…¦Ð;À²Ãµ­*EHÀïÃ#§Ð;Àùcþ©*EHÀxÔ^~§Ð;À•ˆû *EHÀÓüŸù§Ð;ÀpÛê”*EHÀ…øüs¨Ð;ÀSúH†*EHÀ¶Ÿí¨Ð;À}\Z9u*EHÀÝ\Zf©Ð;À¿qa*EHÀªÜ©Ð;À²±jJ*EHÀSVÍPªÐ;Àð,ë/*EHÀ³%|ÂªÐ;ÀÐ´B*EHÀ—Ôê1«Ð;Ào^úñ)EHÀ‚e «Ð;À‚ò•Ð)EHÀø”¬Ð;À2ì¯)EHÀV1w€¬Ð;À„z8‘)EHÀQó¬Ð;ÀÆFu)EHÀÝˆCh­Ð;À6Ñ[)EHÀ¿Eß­Ð;ÀQ£_E)EHÀ¯›VW®Ð;Àßy1)EHÀ³\"ÌÐ®Ð;À‡É¼)EHÀ®K¯Ð;Àð¿­)EHÀôzåÅ¯Ð;À÷î\0)EHÀåå\0A°Ð;ÀFXó(EHÀ\\µ4½°Ð;À{½¬æ(EHÀaLB±Ð;À\"FÇÙ(EHÀõÛ±Ð;À1Ë(EHÀ<:ï¥²Ð;ÀoÊe·(EHÀ1FIÕ³Ð;À5^™(EHÀ^±!`¶Ð;Àš5-R(EHÀy<v­·Ð;À9~(EHÀ×ë™¸Ð;À÷}ä\'EHÀŸ5pl¹Ð;ÀA%Gµ\'EHÀq¾À<ºÐ;À|‡i‹\'EHÀ×\n»Ð;Àx‰gd\'EHÀ675á»Ð;À@¶	=\'EHÀÔ˜D²¼Ð;À¡¨\r\'EHÀþ€î½Ð;À=ˆé&EHÀÒØ9P¾Ð;À¼&EHÀ\'?Y¿Ð;À·¾Z&EHÀúü›é¿Ð;Àç¦q]&EHÀÜr}µÀÐ;À@e÷,&EHÀq!­‚ÁÐ;À“þ%EHÀù‡rSÂÐ;À½çÕ%EHÀKÞw(ÃÐ;ÀÒ“mµ%EHÀÂ¹@ÄÐ;Àmž%EHÀ\\ÂÜÄÐ;Àc|ª%EHÀŽdŽ¹ÅÐ;ÀŒó‰%EHÀñÄÊ–ÆÐ;ÀfŽ‡%EHÀëï&tÇÐ;ÀØn	†%EHÀpn}QÈÐ;À„¨Éƒ%EHÀ™Ð.ÉÐ;ÀaÆ%EHÀVÜ\"ÊÐ;À=v~%EHÀ÷-zéÊÐ;Àâ›M|%EHÀzÖÆËÐ;À®þ£z%EHÀâ#0¤ÌÐ;ÀIØÑx%EHÀRlÍÐ;À˜—u%EHÀ¯1?^ÎÐ;À0\ZÏn%EHÀoŠþ5ÏÐ;ÀRÈ*^%EHÀÂ…YüÏÐ;Àª_36%EHÀ–KªÐÐ;ÀW˜\nñ$EHÀ/\"EÑÐ;À{U²™$EHÀûl°×ÑÐ;Àï}=$EHÀ8Ì)vÒÐ;À¸cê#EHÀã^6.ÓÐ;Ààò©#EHÀZ/øÓÐ;À.ú˜y#EHÀ»’¥ÊÔÐ;À½<U#EHÀÆ¡ÕÐ;À÷Ad9#EHÀ9{ÖÐ;ÀŸÿÖ##EHÀÐPV×Ð;À€Cƒ#EHÀ0”È1ØÐ;ÀwÚ³#EHÀéÛæ\rÙÐ;Àê‚öõ\"EHÀ¤©êÙÐ;ÀÝ‹ è\"EHÀÌtDÆÚÐ;À›ìÚ\"EHÀÐul¢ÛÐ;ÀöôîË\"EHÀÇ®j~ÜÐ;À¡ì‰½\"EHÀÌiZÝÐ;ÀRi£®\"EHÀ3‹5ÞÐ;ÀsLŸ\"EHÀ9èéßÐ;ÀÖ \"EHÀïzìßÐ;Àw\"EHÀËîÆàÐ;À?Ý´l\"EHÀ¡áÐ;À\ZÛyW\"EHÀ¾‘zâÐ;À>äE>\"EHÀ=±hQãÐ;À\Z+é \"EHÀ!³»&äÐ;ÀGª¿ÿ!EHÀsßÃùäÐ;ÀJ”·Ú!EHÀÂÄÊåÐ;À6Ø{±!EHÀšp&™æÐ;ÀÊn¢„!EHÀÕm$fçÐ;ÀÃì‰U!EHÀTS…2èÐ;ÀÀì%!EHÀOEæÿèÐ;À½…Ñ÷ EHÀóoÏéÐ;À&Í EHÀV,\Z¢êÐ;À;lh§ EHÀtº·wëÐ;ÀLL‡ EHÀ];€OìÐ;À ùk EHÀmU­(íÐ;À@ZZT EHÀ®.©îÐ;À-? EHÀ‡\"(ÝîÐ;À_ª€+ EHÀ“ØP¸ïÐ;À![ø EHÀÙ8”ðÐ;ÀÇ- EHÀÌó½pñÐ;À\"ØŸÿEHÀ°R±MòÐ;ÀÝ“øEHÀVÉ*óÐ;Àóe^÷EHÀ$ÌôÐ;ÀÏ¼ûEHÀ\\a°äôÐ;Àß\Z EHÀÉï@ÁõÐ;Àþ` EHÀÞ]¹œöÐ;À¦ÞúEHÀåŠt÷Ð;Àß<jåEHÀóÆ(=øÐ;Àß»EHÀ~ ûîøÐ;Àq¤’wEHÀÈî‹ùÐ;ÀDƒ!EHÀÀ¿úÐ;À=|ÁEHÀEÒd•úÐ;ÀÌá\\EHÀßÛ%ûÐ;ÀJœŸõEHÀÙ‚›ûÐ;ÀÌJÏ–EHÀéž@üÐ;Àõ¹IEHÀE\nÿüÐ;ÀÕÖÀEHÀ`ÏýÐ;À]»XðEHÀ„€¨þÐ;À™7žçEHÀüÁ€ÿÐ;À ·šôEHÀH–¤W\0Ñ;Àí%sEHÀL\Z.Ñ;Àž%É-EHÀzZÑ;ÀÕòJEHÀïŒgÞÑ;À†ûäaEHÀLbÐ¸Ñ;À!w˜vEHÀ¸÷=“Ñ;Àð}±‹EHÀ‡Q˜mÑ;Ài{Q EHÀœ\'¶HÑ;ÀüâW°EHÀ)+Ô$Ñ;À^`ºEHÀˆbžÑ;Àþü½EHÀ„¨XÞÑ;Àg.!»EHÀÚêã¹	Ñ;ÀDw-¯EHÀ‰>+“\nÑ;À£P™EHÀjéiÑ;À3mzEHÀm©Š4Ñ;À6xOEHÀ‡EŸçÑ;ÀÿxEHÀ9 \0ƒ\rÑ;À™nç¹EHÀ•‰CÑ;À‡ªÆbEHÀCÌÉÑ;ÀS eEHÀ•ã˜‚Ñ;À¿\'ÓEHÀ›.GÑ;ÀZÜšEHÀ¤2šÑ;ÀkË]hEHÀj3èÏÑ;À÷\03EHÀºÜSÑ;Àh	¡è\ZEHÀ”†ƒzÑ;ÀJ÷Œ\ZEHÀÈCÄHÑ;À‹»Û\ZEHÀtˆšÙÑ;Àá7g´EHÀ/]‹wÑ;À)ÁäREHÀ¯qøaÑ;Àä/^ãEHÀa&ñÑ;À(°ínEHÀAp`ïÑ;À€)ÎEHÀ1€sÑ;À¢Û\0¡EHÀ+âåÑ;À\níPEHÀ^g»ÏÑ;À‚$\nEHÀNŽPžÑ;Àãë\nEHÀÞÀ$xÑ;À0ŽQEHÀ¨a„TÑ;À5\nœEHÀ—nì0Ñ;À%¤*EHÀ‹èO\rÑ;À†w]8EHÀ©ÕSéÑ;ÀÀ‰>GEHÀbÈƒÄÑ;À7ÏõWEHÀÊÖž\ZÑ;À§BkEHÀ‡ txÑ;ÀþäEHÀZQÑ;ÀÕ¼sšEHÀ­óT(Ñ;À3;¤·EHÀùD7þÑ;ÀC8ØEHÀÙz9ÓÑ;À×hvúEHÀ`a¾§Ñ;Àáª¦EHÀ¹À| Ñ;ÀÀ–Š@EHÀÍëáP!Ñ;À¼¢\nbEHÀÀâ&\"Ñ;Àè˜EHÀLúþ\"Ñ;À”\ZžEHÀ+÷xÕ#Ñ;ÀNÙ”ºEHÀž%¬$Ñ;À¡«ÐEHÀš(%Ñ;À¡•™ÎEHÀKþñT&Ñ;Àá»&´EHÀ¸üÍ)\'Ñ;À‘’EHÀcð((Ñ;À‘dŽvEHÀ˜±ØÚ(Ñ;À\\|lbEHÀ‚`E¶)Ñ;ÀÚŸWEHÀjO’*Ñ;À©ƒ¼WEHÀë¶Ál+Ñ;À¥ÏdEHÀØu@A,Ñ;ÀŸ\0ÖEHÀkW[-Ñ;À‹”š°EHÀ))Ç-Ñ;Àò§¿ïEHÀ¢Nr.Ñ;ÀÖ¬ã<EHÀ0Št/Ñ;À%)”EHÀc¢¢¡/Ñ;ÀÓÝSðEHÀy¿“90Ñ;À0wI\ZEHÀÚdãâ0Ñ;ÀÔ­š—\ZEHÀï¶³ž1Ñ;À¯›‘Õ\ZEHÀŽY^j2Ñ;ÀêeGEHÀ@Úz>3Ñ;ÀhðX#EHÀðŠ‡4Ñ;À3æ‹EEHÀ°Ç,è4Ñ;À&«–hEHÀn£ù¼5Ñ;Ài¡ŠEHÀþÇ\Z’6Ñ;À<Ò«EHÀOå–g7Ñ;ÀœÝâÌEHÀfPj=8Ñ;À°FlíEHÀ·ÞŠ9Ñ;Àó’¯EHÀ’6Ýé9Ñ;À\r5+EHÀ²LBÀ:Ñ;À¿©‰IEHÀ«*Ê–;Ñ;À1?hEHÀ§ý’m<Ñ;ÀòI‡EHÀ“¹&D=Ñ;Àp¤~¦EHÀs”½>Ñ;ÀÃvYÇEHÀö&cî>Ñ;À`Ë¨éEHÀïâ Â?Ñ;À0ÙàEHÀ ÿ‰@Ñ;Àa•šEHÀœu©1AÑ;À=LqùEHÀdo\"¥AÑ;ÀðPm£EHÀàÙ-ÒAÑ;ÀvèK4EHÀîžfÆAÑ;ÀÇò¼EHÀÁ\nh²AÑ;ÀWABEHÀå,:ºAÑ;À%NûÇ\ZEHÀàHgïAÑ;ÀW¸)T\ZEHÀª«§ZBÑ;ÀX‡XðEHÀ K|ùBÑ;Àˆ@µ¬EHÀ\n&\\ÀCÑ;À¯‘EHÀH\"6–DÑ;ÀCž–EHÀàåiEÑ;Àç¥I³EHÀì;FÑ;Àà×ñÙEHÀXýGÑ;À´\ZEHÀ&VàGÑ;À÷Ÿ\'\ZEHÀx!Œ²HÑ;ÀO\ZEHÀ·IÑ;ÀýpH{\ZEHÀ€ýJJÑ;ÀÌ¨®\ZEHÀºÐ@KÑ;À÷VDæ\ZEHÀCNÖKÑ;ÀŽÖEHÀNR›LÑ;Àf¡YWEHÀvyÆ_MÑ;À\\Í°EHÀ \'Ã#NÑ;ÀýÔøÉEHÀ9—\0èNÑ;ÀÜ`EHÀì”Ÿ­OÑ;ÀÂr;EHÀŸáuPÑ;ÀÐ¬3pEHÀräBQÑ;ÀÓoŸEHÀ0:1RÑ;ÀÁˆdÇEHÀÞíçRÑ;À|Þ¹éEHÀ<+¾SÑ;Àx§a	EHÀi6<”TÑ;Àbq)EHÀ*«ÉhUÑ;À{JKEHÀôqÏ;VÑ;À„SúoEHÀæð\rWÑ;Àd——EHÀ§)eßWÑ;Àf˜¿EHÀzÙ(°XÑ;À©‡åèEHÀâ\n;€YÑ;À0õïEHÀ-Š•OZÑ;ÀÜˆ:>EHÀ;Ž[Ñ;Àü_¸kEHÀ\\€þè[Ñ;À0Œ«œEHÀjË±\\Ñ;ÀÇcËÑEHÀkù$u]Ñ;ÀëbEHÀŽKÿ1^Ñ;À7¡^KEHÀãa±á^Ñ;À~’Z•EHÀw©|_Ñ;ÀG)ºëEHÀ°Qåù_Ñ;À,8GO EHÀJˆV^`Ñ;Àm_½¼ EHÀÇ£Á`Ñ;À½¡+!EHÀU]÷3aÑ;À©•!EHÀG¸aÑ;ÀÌa[ø!EHÀbbÿPbÑ;ÀÞÖŽL\"EHÀ[Q\ZcÑ;ÀPW”€\"EHÀãóÓcÑ;À‘Ûã‹\"EHÀ±pªdÑ;Àý™@z\"EHÀò=}eÑ;À ;X\"EHÀ 1KMfÑ;ÀJk‡.\"EHÀs¸gÑ;Àá>\"EHÀ#ëgÑ;ÀŽèÖ!EHÀu+r¹hÑ;ÀÆ\r©!EHÀ‚—…iÑ;Àiòx!EHÀB&OjÑ;À•\rÔE!EHÀvï‚kÑ;ÀJ—ÿ!EHÀp`?ØkÑ;À²ÝüÓ EHÀñl—lÑ;À–à=• EHÀßü»RmÑ;À–ÔS EHÀ–]nÑ;ÀŸ± EHÀÃ&²nÑ;ÀMô;½EHÀiRoÑ;ÀÑëôgEHÀ~KsêoÑ;ÀA´–EHÀUÄŠpÑ;À¯„\r¿EHÀTq¡FqÑ;À*ëWŠEHÀ“åUrÑ;ÀMåÍtEHÀ¢ÑRïrÑ;À[4ë{EHÀÌèàÅsÑ;À,a¶•EHÀŸ¨HœtÑ;ÀÓà×´EHÀ<“’ruÑ;Àõü0ÔEHÀÀç—HvÑ;ÀDbÝóEHÀ%•awÑ;À_ñEHÀæÎèówÑ;ÀÔ°ª4EHÀµšÐÅxÑ;À¤¾FZEHÀvlçyÑ;ÀC¸.ŒEHÀõ©DzÑ;ÀN(œÎEHÀ¥e²ázÑ;À7ˆ\" EHÀuÊ­d{Ñ;À2O+… EHÀ0 )Ö{Ñ;ÀpÏï EHÀ»ó-C|Ñ;ÀÂ¦–[!EHÀmû§½|Ñ;Àáx¥Á!EHÀ¸UøQ}Ñ;À\\Ós\"EHÀ<~Ñ;À¨!5X\"EHÀ¾÷îÐ~Ñ;Àmùqz\"EHÀ3»°ªÑ;ÀfPàˆ\"EHÀmŠ)‡€Ñ;À®?Œ\"EHÀLirdÑ;À²vK‹\"EHÀØA‚Ñ;À¸½µŠ\"EHÀcFHƒÑ;ÀÕ“K‹\"EHÀA œüƒÑ;À¯èö\"EHÀAIÙ„Ñ;À×÷\'•\"EHÀï­´…Ñ;Àiöÿ¢\"EHÀUŽ†Ñ;ÀÞF¸\"EHÀo2ae‡Ñ;ÀîÁÓ\"EHÀÿÃë;ˆÑ;À¶Tò\"EHÀH‰Ñ;Àö®n#EHÀH£)ê‰Ñ;ÀGS.#EHÀvNiÀŠÑ;ÀÅÇ?N#EHÀÈhS•‹Ñ;Àƒ\".p#EHÀãhiŒÑ;À“Åö“#EHÀÝÊð=Ñ;ÀR×&³#EHÀ¹hšŽÑ;À¤ÓÄ#EHÀžój¾ŽÑ;ÀŠ½#EHÀÄ\ZÑ;À5OQ‘#EHÀÐ‚þ8Ñ;Àì&)K#EHÀ¿PgIÑ;À3}÷û\"EHÀ\rÌiÑ;ÀÒ­Ô®\"EHÀßz®Ñ;À+áXk\"EHÀ^‰çÑ;ÀÄçW6\"EHÀ¹Ô–Ñ;Àî–\"EHÀcoð!‘Ñ;À¸o1ý!EHÀ‘qç²‘Ñ;À¦¹½ï!EHÀ®=E’Ñ;Àk,\Zç!EHÀõzTØ’Ñ;À­:²â!EHÀäëÍk“Ñ;ÀÝ¹€á!EHÀioÿ“Ñ;À‚%â!EHÀŒ\Z“”Ñ;Àê_¸ã!EHÀzJÌ&•Ñ;À(Úfæ!EHÀÏ\'º•Ñ;À¨^ë!EHÀulL–Ñ;À±z-õ!EHÀÅ,!Ý–Ñ;À²\\½\"EHÀ¿1l—Ñ;ÀÖ=¼\"EHÀ±Ø”ù—Ñ;À“t$0\"EHÀÑBG…˜Ñ;ÀœJ\"EHÀ/ûE™Ñ;À¬Îg\"EHÀñ‰—™Ñ;ÀŸg[‡\"EHÀ ÞKšÑ;À¨Ÿgª\"EHÀ?T˜šÑ;À\nÈÕ\"EHÀ½Ð\n›Ñ;À€qÍ	#EHÀ¡url›Ñ;ÀS…F#EHÀäñÆ›Ñ;Àgât‡#EHÀ.%MœÑ;À5|ƒÌ#EHÀõEâ`œÑ;À´•o$EHÀæK) œÑ;À_$EHÀ(aÖœÑ;À£f>¬$EHÀk„\"Ñ;ÀšBÀú$EHÀ¢÷4Ñ;À ¤£I%EHÀUùZÑ;ÀIœe™%EHÀ7SðsÑ;À±«ê%EHÀ)»F‚Ñ;ÀA£=&EHÀ—ß²ŠÑ;À5ªË&EHÀ|&î‘Ñ;ÀÆšâ&EHÀßSpžÑ;Àç&4\'EHÀKs\"ÂÑ;Àsþ\'EHÀÆ¥/žÑ;À¼Ûl¾\'EHÀ¼žÑ;Àé‘ î\'EHÀÍ˜è\rŸÑ;ÀE`î(EHÀÁs¢ Ñ;ÀÙ§„C(EHÀ6˜—á¡Ñ;À¶\Zó—(EHÀÄº)¤Ñ;À¦üý(EHÀþ²¤¥Ñ;À¹YI)EHÀtÔm¦Ñ;ÀÛfÜs)EHÀwØ÷¦Ñ;À†>”)EHÀ>µ¸§Ñ;ÀU/?´)EHÀòÈ¨Ñ;Àø«Õ)EHÀ ²Ø‹¨Ñ;ÀUêù)EHÀ€€m©Ñ;À\"°4*EHÀ“0­Ž©Ñ;ÀVÆèG*EHÀmyg\rªÑ;À°SZr*EHÀIa‹ªÑ;À\Z¯*EHÀNE	«Ñ;ÀÂiÉ*EHÀ€ŒD‡«Ñ;À)Bkô*EHÀ%\0é¬Ñ;À	»# +EHÀ5¾^¬Ñ;À•îüL+EHÀ­ZSû¬Ñ;ÀxÙ{+EHÀªëq­Ñ;À\\8­+EHÀ	9å­Ñ;À_âà+EHÀ‡ksU®Ñ;ÀÂ8‘,EHÀŽïÂ®Ñ;ÀÝœN,EHÀz Ô-¯Ñ;ÀÁ­:‡,EHÀéÑÚ•¯Ñ;À÷ŽÂ,EHÀïÒ5ú¯Ñ;À_ìºþ,EHÀàÕÜX°Ñ;ÀêY>-EHÀ!q°°Ñ;ÀuÏÃ€-EHÀZÙ ÿ°Ñ;À—ªnÆ-EHÀ˜VZH±Ñ;Àqy.EHÀ)CS±Ñ;À\n¶ÆW.EHÀÑ\0Ò±Ñ;À\'¦1¡.EHÀc-	²Ñ;Àûbêé.EHÀ—¬e²Ñ;À²Úª0/EHÀèQ¾²Ñ;ÀÃjUq/EHÀ“.ú(³Ñ;Àq\nx¥/EHÀTàã³Ñ;Àbµ¾/EHÀ7E<´Ñ;ÀF©ª¬/EHÀ­h|´Ñ;ÀDn{/EHÀÛÀÜ´Ñ;ÀÎ	=/EHÀ A¹=µÑ;À@+â\0/EHÀQî°µÑ;ÀY²Ñ.EHÀTZ×3¶Ñ;Àrzãµ.EHÀðzú¿¶Ñ;ÀÌ‹°.EHÀ¤Í\ZO·Ñ;Àÿm¼.EHÀ¬‚Þ·Ñ;ÀÁw\"Ï.EHÀL¹îm¸Ñ;ÀÈ\'ná.EHÀ)\rÖþ¸Ñ;À\'Ÿî.EHÀµ`A‘¹Ñ;ÀëÑ-ô.EHÀÎf$ºÑ;ÀO}ñ.EHÀž7‘¶ºÑ;À)vŸè.EHÀ‹)I»Ñ;À{ž9Þ.EHÀÖÆWÛ»Ñ;À°‹×.EHÀïl¼Ñ;À+~EÚ.EHÀ™Âý¼Ñ;À0&Hè.EHÀ&ª‹Š½Ñ;À¶þ.EHÀ2ý\n¾Ñ;À“©a\Z/EHÀ®ÀC¾Ñ;À¹òã9/EHÀá$¿Ñ;Àsz[/EHÀ…t…ª¿Ñ;Àã½Ó}/EHÀ‘­,1ÀÑ;Àñ /EHÀ~œô·ÀÑ;ÀÀ²æÁ/EHÀ£¤¤>ÁÑ;À!\Z”ã/EHÀ×;ÅÁÑ;À±›¶0EHÀR½…pÂÑ;À@®40EHÀjñœÆÃÑ;Àëw+–0EHÀÛ¤wøÅÑ;ÀûÐ;1EHÀ.›ÞÈÑ;ÀÃiñÚ1EHÀc‰q?ÉÑ;ÀÏª72EHÀmw°×ÉÑ;À¥š5i2EHÀŒï1UÊÑ;À#q”2EHÀp·‡ÒÊÑ;ÀÚÏ¿2EHÀd„OËÑ;ÀÇíë2EHÀ4=ÖËËÑ;ÀIÒ3EHÀw¦#GÌÑ;À}mF3EHÀêÁÁÌÑ;Àyu3EHÀ3d9ÍÑ;À<K>¥3EHÀÌ°ÍÑ;À˜~°Ö3EHÀ\'	S%ÎÑ;À„†	4EHÀ˜å™ÎÑ;Àªz<4EHÀÞnÏÑ;À\nZ\0q4EHÀ½¤Õ{ÏÑ;À›ça¦4EHÀ¡«\rìÏÑ;ÀÅË#Ü4EHÀlvG\\ÐÑ;ÀÉö5EHÀSOüÌÐÑ;À¹ú©G5EHÀçr>ÑÑ;Àô9}5EHÀó[	¯ÑÑ;À`Þ¹²5EHÀ‹ï- ÒÑ;Àéüç5EHÀOW’ÒÑ;À¹0˜6EHÀ¦¢vÓÑ;À\'‡ÓO6EHÀ’Ú—}ÓÑ;À¼c¦€6EHÀgà{ùÓÑ;À|ñ¬6EHÀ’‹|ÔÑ;ÀƒøwÑ6EHÀ¡MåÕÑ;À#ùê6EHÀÕæô•ÕÑ;À\nZOö6EHÀwà?\'ÖÑ;ÀÖü½ó6EHÀb}¸ÖÑ;À±=è6EHÀÝwå=×Ñ;ÀÆá6EHÀ‡3J×Ñ;À›QÂ÷6EHÀ•ÁôÎ×Ñ;ÀºOk57EHÀ?oÝí×Ñ;ÀG\0…7EHÀ×C,ØÑ;ÀwÔ7EHÀMï.MØÑ;Àò678EHÀµë£ØÑ;ÀU\r^8EHÀßÏÈÙÑ;À\"‘‰8EHÀ¡’–ÙÑ;À©üâ°8EHÀ;¡{#ÚÑ;À\'™Ç8EHÀ^9³ÚÑ;ÀÈÉèØ8EHÀ²j—DÛÑ;Ànå8EHÀç¤l×ÛÑ;ÀÁí8EHÀÄIÿjÜÑ;ÀŸTNð8EHÀø¼þÜÑ;ÀôØï8EHÀ¥ ×‘ÝÑ;ÀD\nì8EHÀéÌ¨$ÞÑ;Àõå8EHÀiUÔ¶ÞÑ;ÀVšŸÚ8EHÀ9êHßÑ;ÀÚ•:Ì8EHÀ]Æ±×ßÑ;À–Ø¡¹8EHÀÀ>ÌdàÑ;ÀV’¢8EHÀÅ¬îàÑ;Àk˜G†8EHÀŸËŽtáÑ;À\'£d8EHÀ /3÷áÑ;À¼ÁJ=8EHÀò¡wâÑ;À\"5Q8EHÀM›vöâÑ;ÀÍËê7EHÀP¡\ntãÑ;ÀÊêv¾7EHÀ/jðãÑ;À_qÉ‘7EHÀ3ùÎkäÑ;À2Ÿ\rd7EHÀˆ^åäÑ;À0C57EHÀý3]åÑ;Àqèœ7EHÀ:m;ÕåÑ;ÀXgÏÔ6EHÀBtvRæÑ;À\ZÎª©6EHÀ³å%ÖæÑ;À;½„6EHÀ!^çÑ;À{›d6EHÀ\0øØèçÑ;À~·ÁH6EHÀOŽuèÑ;À|Ä…06EHÀäPéÑ;À½Y6EHÀŸtÏ”éÑ;À(66EHÀ)“h\'êÑ;Àœ’¶6EHÀMÃBºêÑ;ÀšÆ-6EHÀ{ tLëÑ;Àk«#6EHÀ½WÞëÑ;Às5d06EHÀ{ÀGpìÑ;Àz><6EHÀ£ŸlíÑ;ÀÉg€A6EHÀí)Š”íÑ;Àºðº<6EHÀÅ™%îÑ;ÀWÙý/6EHÀhùß´îÑ;Àëí«6EHÀš(œBïÑ;À§ß16EHÀ\nÿIÏïÑ;ÀZÜî5EHÀ	¥¤[ðÑ;À†¡Ô5EHÀùä@èðÑ;ÀB(\0»5EHÀ÷\ruñÑ;À2U]¢5EHÀÉ†òÑ;À0›²ˆ5EHÀ\'½ˆòÑ;ÀøƒMi5EHÀŠÍ¿óÑ;ÀG§Õ?5EHÀ¡.ìxóÑ;ÀÿE\r5EHÀ2°áóÑ;ÀÜ)Ó4EHÀQTCôÑ;Àxöú”4EHÀâ”\"£ôÑ;À>ˆhV4EHÀþ\0jõÑ;Àöä¡!4EHÀEx€ŠõÑ;Àß‚4EHÀXVOöÑ;ÀXixô3EHÀEcªöÑ;À[·¬ó3EHÀ#¿<÷Ñ;À²òìù3EHÀÏ÷Ñ;ÀíMS4EHÀ“¢``øÑ;À¡°Œ4EHÀ`òÑîøÑ;À¡cÕ$4EHÀà®wùÑ;À¿³+B4EHÀÖ‡Å÷ùÑ;À6ú‚i4EHÀebÁoúÑ;ÀNUú˜4EHÀ€~MãúÑ;ÀðŠÌ4EHÀä*²VûÑ;ÀIÁ\'\05EHÀi©ÎûÑ;À&Ñ/5EHÀ«TNüÑ;À&eXW5EHÀDÈLÖüÑ;À´ˆr5EHÀ’ÁòeýÑ;À»éV5EHÀŽrÔøýÑ;À\'mˆ5EHÀÔ/ŒþÑ;ÀˆgjŠ5EHÀÑàUÿÑ;Àˆµñ†5EHÀœ—æ±ÿÑ;Àôøs~5EHÀ½™ÃC\0Ò;ÀŠãr5EHÀu¤Õ\0Ò;À0¸æe5EHÀ%£fÒ;ÀqX5EHÀè)šøÒ;À®åJ5EHÀdŠÒ;À—Ÿ²<5EHÀÐzÒ;À\0úK-5EHÀjyÈ«Ò;À·r5EHÀ\nÁ;5Ò;Àô5›5EHÀâ˜á¡Ò;À‰vß4EHÀI¾˜àÒ;ÀÖ¶SŸ4EHÀ§Ê¾öÒ;Àæ=êP4EHÀgDÚîÒ;ÀÞtÑÿ3EHÀž¨ÖÒ;À!Ah®3EHÀ‰¬ºÒ;ÀÒâë\\3EHÀ¿!e Ò;À‹´83EHÀ¹‹Ò;À6º%¹2EHÀ’³‚Ò;Àæ]èf2EHÀ\'„ŒÒ;ÀZQ92EHÀfÛ®Ò;À\r?Ç1EHÀ:MñÒ;ÀB][€1EHÀ\\\\QÒ;À+ÃÏE1EHÀ	£ÉÒ;Àg’1EHÀ¼{íQÒ;ÀE–gþ0EHÀàÒ;Àß1)è0EHÀxÚCpÒ;ÀÇJq×0EHÀÓb?Ò;À8“YÍ0EHÀè°2•Ò;Àù¹RÊ0EHÀÅí\'	Ò;À¡kŒÎ0EHÀSë\\·	Ò;ÀplÜ0EHÀŸý?\nÒ;ÀâCº÷0EHÀœRÁº\nÒ;ÀãIM!1EHÀ‰Íï%Ò;ÀzŽW1EHÀüe~Ò;ÀÐá)˜1EHÀò\\æÃÒ;Àì¦4à1EHÀê¿iùÒ;À¿¶-2EHÀ\Z%%Ò;À§G|2EHÀCÜLÒ;À½ÂfÌ2EHÀTÃqÒ;À³3EHÀ[“šÒ;ÀŸëkl3EHÀ»P ÊÒ;À04šº3EHÀÞƒX\rÒ;À#4EHÀ¯Õk]\rÒ;À[èD4EHÀX“Ì\rÒ;ÀÏ‰?v4EHÀaÑNÒ;Àè “4EHÀ×8œÜÒ;À-¹œ4EHÀ`D†oÒ;À$rÂš4EHÀLÙÒ;ÀëøN•4EHÀ/3©•Ò;ÀÕU4EHÀQ€™\'Ò;ÀM¼4EHÀþK¸Ò;À†²r4EHÀM/GÒ;Àt9_4EHÀG0ÓÒ;À§Õ\rF4EHÀœYQZÒ;À¹ÍÊ%4EHÀ”\"ÙÒ;ÀMîü3EHÀLÄåLÒ;Àz§ÙÊ3EHÀw=&¹Ò;ÀÞî’3EHÀsŸ\"Ò;À…$Y3EHÀÂg‹Ò;À\'Í3EHÀ	‹ÛôÒ;À•Œä2EHÀÒ3aÒ;À,bù«2EHÀ	€TÒÒ;À¬jw2EHÀ|{JÒ;À.\nöG2EHÀÞ7õÊÒ;À/ß!2EHÀEFSÒ;À7¾ý2EHÀþ»áÒ;ÀÞ¤‰ú1EHÀÑäqÒ;Àæ»Šÿ1EHÀ‡‡æýÒ;Àž)2EHÀøA\ZÒ;À¶q‡62EHÀ0—ˆø\ZÒ;Àíe2EHÀ|Ý³bÒ;À n22EHÀµ»‰ÀÒ;À]¥ŠÜ2EHÀC¿jÒ;ÀÛó 3EHÀ¨aJ]Ò;ÀÀµh3EHÀ£@¢Ò;À,R\n²3EHÀi@^èÒ;À·!û3EHÀ¾Ô3Ò;ÀN¾ÎB4EHÀr9‚Ò;Àz$¦ˆ4EHÀl™¹ÖÒ;ÀÑÌ4EHÀ³Lè.Ò;À°–Î5EHÀv^[‹Ò;ÀZa.O5EHÀ+Ë®íÒ;ÀË»Œ5EHÀúˆhWÒ;ÀŠp=Æ5EHÀNºÉÒ;À¢7\'ú5EHÀ°iìD Ò;ÀH§<\'6EHÀá–Ç Ò;Àð]ñL6EHÀ[ÝôO!Ò;ÀIð–k6EHÀ÷¸õÛ!Ò;À3e?…6EHÀ;”ÊŒ\"Ò;À°• 6EHÀ÷±‹Ý#Ò;À[†«Ë6EHÀÙ¹¾û%Ò;À=’\r7EHÀ€1(Ò;À›ßG7EHÀÑËE9)Ò;À9Oa7EHÀÖ(ä)Ò;ÀïkŠf7EHÀ_Û­*Ò;ÀÚng7EHÀO^[-*Ò;ÀnGmh7EHÀˆ/R*Ò;ÀÆÃ†i7EHÀíÌÛv*Ò;À\'¹j7EHÀb´©›*Ò;ÀÒl7EHÀÇc}À*Ò;À.3cm7EHÀYTå*Ò;À¹&Øn7EHÀñ,\n+Ò;À”`p7EHÀ¨:/+Ò;À8!ûq7EHÀöÒÕS+Ò;Àûm¦s7EHÀ‚s¦x+Ò;ÀXau7EHÀ\"·s+Ò;À_Â)w7EHÀd5=Â+Ò;Àÿx7EHÀ‰ç+Ò;À‰ßz7EHÀøJÃ,Ò;ÀjåÉ|7EHÀ®0,Ò;À»¼~7EHÀæÇIU,Ò;À˜%¸€7EHÀÁÁf{,Ò;À\"}Ò‚7EHÀOÿ¥,Ò;Àw73…7EHÀÙQÔ,Ò;À‚:ˆ7EHÀt@…-Ò;ÀFmg‹7EHÀ‚AÑL-Ò;À¬µŠ7EHÀL‚hš-Ò;À,ú“”7EHÀçÿ}ö-Ò;À<!«š7EHÀ´2c.Ò;ÀOáö¡7EHÀ{Áêß.Ò;À°Àoª7EHÀÑç{h/Ò;ÀgDÒ³7EHÀºø/Ò;À»ðÖ½7EHÀ‹0Ò;ÀLH6È7EHÀœæ>1Ò;ÀÕÎ¨Ò7EHÀ4j-©1Ò;ÀƒçÜ7EHÀ„ñ*2Ò;À†u©æ7EHÀ×\\&ž2Ò;À«¾¨ï7EHÀOVE\03Ò;À_º÷7EHÀ‡ÍòR3Ò;Àˆòþ7EHÀc˜3Ò;ÀÃœo8EHÀ£(ÌÒ3Ò;ÀÅôN8EHÀ³…a4Ò;À*®8EHÀUX/4Ò;ÀTØª8EHÀ*RåU4Ò;À3™b\Z8EHÀ‰8=z4Ò;Àðó8EHÀ\"È6ž4Ò;ÀÄu#8EHÀIÁ0Â4Ò;ÀÑôî\'8EHÀ›æ+æ4Ò;ÀFb,8EHÀ›ù(\n5Ò;Àc–Ð08EHÀæ¼(.5Ò;À¿x;58EHÀ\Zó+R5Ò;À€¤98EHÀÓ^3v5Ò;À_>\r>8EHÀ{À?š5Ò;ÀíEwB8EHÀ8žQ¾5Ò;ÀÑäF8EHÀ“²gâ5Ò;ÀÒÀTK8EHÀJè6Ò;ÀLÊO8EHÀ2+˜*6Ò;À³ÊDT8EHÀ<h®N6Ò;ÀKÎÅX8EHÀ$ŠÀr6Ò;ÀûæM]8EHÀ¿|Ì–6Ò;ÀåÝa8EHÀÌ*Ðº6Ò;À™vf8EHÀÎ¨ÉÞ6Ò;ÀÀk8EHÀ‰A¹7Ò;ÀÉÄo8EHÀÝú &7Ò;À.wt8EHÀÀæ‚J7Ò;Àš1y8EHÀÝan7Ò;ÀŽnð}8EHÀD•=’7Ò;ÀÒ´‚8EHÀ¹z\Z¶7Ò;ÀüÕz‡8EHÀ\ZÕùÙ7Ò;ÀãqCŒ8EHÀ}hÞý7Ò;À\rÒ‘8EHÀD8æ!8Ò;ÀXäÙ•8EHÀ\Z¯RF8Ò;À$Õ²š8EHÀ/’gk8Ò;À÷* Ÿ8EHÀè¨h‘8Ò;ÀÎkª¤8EHÀÄ»™¸8Ò;À¼Ú©8EHÀÛŽ>á8Ò;ÀIÊ7¯8EHÀÄëš9Ò;ÀXóË´8EHÀ%õò79Ò;ÀG/Ÿº8EHÀŸ}Øf9Ò;ÀRÅÀ8EHÀç¢Š™9Ò;ÀC‚iÇ8EHÀ	ö_Ñ9Ò;À,ñ»Î8EHÀ¯:Ò;À¨ëÖ8EHÀ(kÎU:Ò;ÀUú\'à8EHÀ<¯¥:Ò;À*< ê8EHÀ[eØþ:Ò;Àñ¿ƒö8EHÀ«pd;Ò;À/Ù9EHÀç¨_AÒ;ÀDÒo:EHÀñ%»>CÒ;ÀÉÝ,Ð:EHÀ¨3DÒ;ÀfúSú:EHÀdœEÒ;À	9¼!;EHÀÚÏÝEÒ;Àù»I;EHÀ¤Ãº®FÒ;ÀU&¡p;EHÀ-%‚GÒ;À“yE”;EHÀõ¿:XHÒ;À¨Ò±;EHÀt=Ž1IÒ;Àêª)Ç;EHÀ¨î\rJÒ;Àúü]Ö;EHÀ1·2éJÒ;À°\r>ã;EHÀÔHÅKÒ;ÀòÝtï;EHÀf[¡LÒ;À¤{sû;EHÀŒnj}MÒ;ÀJ)ù<EHÀBoYNÒ;Àh×-<EHÀTh5OÒ;À«þ<EHÀ¬tYPÒ;ÀNF!<EHÀ¯}kíPÒ;ÀÕÞ\n<EHÀúÕâÉQÒ;À@:À<EHÀÊ\'¿¦RÒ;ÀNAþ;EHÀŠ¾ƒSÒ;ÀB¤âú;EHÀAË½`TÒ;À×`÷;EHÀ„¥¾=UÒ;À>\nô;EHÀÕÅ\ZVÒ;ÀFðeñ;EHÀ\Z7Ù÷VÒ;ÀäD!ð;EHÀOàíÔWÒ;Àb(öð;EHÀ\0`à±XÒ;À5P«ô;EHÀìå•ŽYÒ;ÀÞ	|û;EHÀJkZÒ;Àïƒ¶<EHÀÊ-*G[Ò;À])É<EHÀ_r#\\Ò;ÀRû<EHÀ;9—þ\\Ò;ÀÉKž*<EHÀWtÚ]Ò;ÀYÚã8<EHÀ”P‡µ^Ò;Àã0ÇE<EHÀï{‘_Ò;ÀÑ›N<EHÀ” n`Ò;À·Q<EHÀEf&KaÒ;Àü½%Q<EHÀáÿ3(bÒ;À*x5O<EHÀk*;cÒ;ÀçÔL<EHÀëP>âcÒ;À«j{I<EHÀo©>¿dÒ;ÀGPF<EHÀ$U=œeÒ;À_K„B<EHÀß¦<yfÒ;ÀÛe?<EHÀ”–@VgÒ;À5<<EHÀ³T3hÒ;À\0šÊ:<EHÀ&¤}iÒ;Àmæ½<<EHÀ\rR|íiÒ;Ài‘B<EHÀž©õÉjÒ;ÀòÂ¡J<EHÀ=6–¥kÒ;À6W<EHÀÃ0òlÒ;Àör‡h<EHÀ‹„WmÒ;À`[ˆ<EHÀÞ*)*nÒ;Àø\\\n¥<EHÀ£ÙõnÒ;ÀÜÊëÓ<EHÀÇ«°¸oÒ;ÀpSš\r=EHÀi‡qpÒ;À[Q=EHÀLLãqÒ;À¿*âœ=EHÀëRÅqÒ;Àõ§ï=EHÀ!§erÒ;À¤»ËD>EHÀÅPlsÒ;ÀŒû˜œ>EHÀ3ç\Z›sÒ;ÀbÛÈõ>EHÀ:¾>2tÒ;À0ÃMP?EHÀsÆtÒ;Àá7¸¬?EHÀ<zðTuÒ;À›…£@EHÀoø¦ÜuÒ;Àr«m@EHÀ·Ò~\\vÒ;ÀE‰ÙÒ@EHÀ–N{ÖvÒ;À(\'Y:AEHÀ¦…3MwÒ;ÀÀs&£AEHÀžÝÃwÒ;ÀÁêBEHÀ2C¥=xÒ;À@ëÓsBEHÀÑ½|½xÒ;ÀQY(ÙBEHÀë\ZÎDyÒ;ÀõŒa;CEHÀò£aÑyÒ;À‰`a›CEHÀâµazÒ;À”¯ùCEHÀ„)÷zÒ;Àš-UDEHÀa·“”{Ò;À¦¬DEHÀÙ9†=|Ò;Àƒ¥ïúDEHÀ7fô|Ò;Àî›]?EEHÀsãËµ}Ò;ÀýÁzEEHÀ_d}~Ò;À!Zk¯EEHÀ	ÒIÒ;À1Û,ßEEHÀâÑQ€Ò;ÀNÙ£FEHÀÐ©ç€Ò;ÀÄm	6FEHÀ‡ S·Ò;ÀcÕ‰_FEHÀž‡‚Ò;ÀN/Ó‰FEHÀ0\\@UƒÒ;ÀöÀ¶FEHÀ04C „Ò;ÀIfýçFEHÀ¶æ„Ò;ÀÿH»GEHÀ4“4ª…Ò;À>J‰XGEHÀ‘™pn†Ò;ÀtEb‘GEHÀ†è3‡Ò;ÀLÆÈGEHÀÖA‡ù‡Ò;ÀìDE\0HEHÀã^î¾ˆÒ;Àí¡O8HEHÀn:„‰Ò;ÀÿpHEHÀÊ5ìHŠÒ;À\Z„h©HEHÀ¡,‹Ò;ÀÈvÑãHEHÀN\Z²Ì‹Ò;À•¡ IEHÀ{ EŠŒÒ;Àçé†`IEHÀFEzDÒ;Àé|¡£IEHÀ\"©sûÒ;À®{éIEHÀ{n¯ŽÒ;ÀÓ^«1JEHÀoA¿`Ò;ÀMÞä{JEHÀšÒ;ÀT·ùÇJEHÀTê¼Ò;ÀŒæKEHÀ1šf‘Ò;À©ÿ{eKEHÀ¹,’Ò;À‚¸C¶KEHÀH=Ú´’Ò;À¬|µLEHÀ\\.G[“Ò;ÀÞ9YLEHÀG‹N”Ò;À²dgªLEHÀAfª”Ò;À\rTJûLEHÀò¨8S•Ò;ÀeKZKMEHÀ¤tm\0–Ò;Àêit˜MEHÀPÆw³–Ò;Àþ~áMEHÀˆ7èj—Ò;ÀZžU&NEHÀ÷_%˜Ò;À¢#iNEHÀpÛã˜Ò;À|¨NEHÀq”§™Ò;ÀaÞKáNEHÀ1ò¦pšÒ;À/\\OEHÀ×Ó¹>›Ò;ÀaBAOEHÀïn«œÒ;ÀlhOEHÀR?;åœÒ;Àgð‰OEHÀhŽÔ»Ò;À7…(§OEHÀ# )”žÒ;Àód–¿OEHÀCB0nŸÒ;À\"\nÑOEHÀç3âI Ò;À¹’1ÙOEHÀa€x&¡Ò;ÀX9‡ØOEHÀ8;â¢Ò;ÀëOÑOEHÀ«™ÃÞ¢Ò;Àå4ÅOEHÀö‰!º£Ò;À?µOEHÀvË”¤Ò;ÀP²Ú¡OEHÀgäpn¥Ò;À”ŒOEHÀ@›G¦Ò;ÀGê¸sOEHÀØ‡¹§Ò;À>È­XOEHÀTõ§Ò;À•½\Z;OEHÀJÅ:Ë¨Ò;À£ÈxOEHÀ”rèŸ©Ò;ÀÃEúNEHÀ¸lµsªÒ;À50ÇÖNEHÀÐF«Ò;ÀôWõ±NEHÀRÀi¬Ò;Àõ­ŒNEHÀ»Ï‰ë¬Ò;ÀœE4eNEHÀQ§½­Ò;ÀR†L=NEHÀMj®®Ò;ÀçùNEHÀ@òT]¯Ò;À¬{GéMEHÀû\'Û+°Ò;À#Ê¼MEHÀ(Aù°Ò;ÀàŽMEHÀ—¥ÁÅ±Ò;ÀÂì_MEHÀ/E’²Ò;À1_~0MEHÀn-¦^³Ò;ÀqW8MEHÀÀNÞ+´Ò;Ày•ÞÒLEHÀºìù´Ò;À¶Ÿ¦LEHÀ´„\'ÉµÒ;Àè\n÷zLEHÀüýÃ™¶Ò;À)g­QLEHÀ¤.k·Ò;À:—L*LEHÀê”>¸Ò;Àõ(ØLEHÀî®¹Ò;À½àþàKEHÀÂ“ùºÒ;ÀÓ|¹KEHÀ?Rß»Ò;ÀLd‘sKEHÀšˆ\"¿Ò;ÀnûJEHÀOÕšÂÒ;ÀÓmÑJEHÀà¸ÏÆÄÒ;Àß&:JEHÀ5«˜âÅÒ;À,Õ§!JEHÀ°-¢¾ÆÒ;À8YJEHÀ	èßšÇÒ;À÷Ã}JEHÀ(†wÈÒ;Àê†^JEHÀà+nTÉÒ;À„µJEHÀ¤±i1ÊÒ;À<Î0JEHÀ³çgËÒ;ÀAÐÿIEHÀ=ÎiëËÒ;À…3XüIEHÀÃ£tÈÌÒ;À·i\ZúIEHÀ©£Ž¥ÍÒ;Ài^±ùIEHÀy`¢‚ÎÒ;Àâ\\ûIEHÀ*æ…_ÏÒ;À“ÍÿIEHÀx^\'<ÐÒ;ÀôÎÍJEHÀ²5ŠÑÒ;À[\ZJEHÀh\Z–ôÑÒ;Ào~mJEHÀÇdÐÒÒ;Àê›¥-JEHÀ;L(«ÓÒ;ÀqŒÁ=JEHÀ[“?†ÔÒ;À¤÷øMJEHÀWNeaÕÒ;ÀÜÉx^JEHÀ‹ª<ÖÒ;Àd¾ºpJEHÀŠ#­×Ò;À]^Ç…JEHÀÂ_î×Ò;ÀW3ÌJEHÀí$áÅØÒ;ÀUé-¹JEHÀ#Ú“›ÙÒ;À	êÙØJEHÀj>/oÚÒ;ÀöüJEHÀŒ8AÛÒ;À’0Ý#KEHÀŽß˜ÜÒ;Àï¢ÛJKEHÀE<xÑÜÒ;À:1mKEHÀ“ë~ÝÒ;Àñ¯‰KEHÀ¦¹ÞÒ;ÀÞÆ!¦KEHÀu\0íÞÒ;À¶ÉKEHÀíÁÞÞÒ;ÀD‘eæKEHÀ£%9ùÞÒ;ÀøŠÄöKEHÀX2±ßÒ;À¬„#LEHÀ?).ßÒ;À`~‚LEHÀÃK¡HßÒ;À xá\'LEHÀ_WcßÒ;ÀTr@8LEHÀJ»‰nßÒ;À>ï£@LEHÀ™¹wßÒ;ÀaÂáILEHÀÂx9ßÒ;ÀnÙÀSLEHÀ¤á™…ßÒ;Àû ^LEHÀà[k‹ßÒ;À …~hLEHÀ²—E“ßÒ;ÀNG{wLEHÀ3\nšßÒ;ÀZÙ{†LEHÀsïŸßÒ;ÀŸ‚•LEHÀPKÖ¡ßÒ;ÀÂú‘¤LEHÀŽD ¡ßÒ;À­O¬³LEHÀ‰ÏâœßÒ;ÀU„oÔLEHÀ7ü–ßÒ;À£•7õLEHÀ!óßÒ;ÀÈbMEHÀž2zˆßÒ;ÀõÊÍ6MEHÀ4«B€ßÒ;Àç­—WMEHÀ\ZrrßÒ;ÀêDô‰MEHÀ/]bßÒ;Àµ¿¼MEHÀ‡L[RßÒ;ÀSDîMEHÀ(JCßÒ;Àû1 NEHÀîe6ßÒ;À>	wRNEHÀèò0ßÒ;À:µ¿sNEHÀ;:/ßÒ;À\\Ê;•NEHÀæ °0ßÒ;ÀC£Ê¶NEHÀ;Ê4ßÒ;Àþ™KØNEHÀ›…ý:ßÒ;À·	žùNEHÀ‘-\0?ßÒ;Àï¡þ	OEHÀ›ÐDßÒ;À™ÂE\ZOEHÀyÜJßÒ;À×†w*OEHÀ·¼óPßÒ;À‹˜:OEHÀúÝÒXßÒ;Àdo«JOEHÀ<CnaßÒ;Àæ›ZOEHÀ	±jßÒ;ÀQjOEHÀî+ÁtßÒ;Àf£ÒyOEHÀ<¤ÄßÒ;À4\Z\'‰OEHÀ@ká‹ßÒ;À 3U˜OEHÀZ6\Z¦ßÒ;ÀJåô¶OEHÀGpÁßÒ;À1ì!ÕOEHÀ7‰ÞßÒ;À.?¢òOEHÀè¤\nþßÒ;ÀuÓ;PEHÀ-)š àÒ;ÀÆž´*PEHÀ5ÓƒWàÒ;À}°JSPEHÀV~mŽàÒ;À4Âà{PEHÀw)WÅàÒ;ÀxÔv¤PEHÀÓ@üàÒ;À¼æÍPEHÀ‡}*3áÒ;À\0ù¢õPEHÀ¿ŸÚoáÒ;À`­wQEHÀöÁŠ¬áÒ;ÀKbLAQEHÀã:éáÒ;À7!gQEHÀLë%âÒ;À#ÌõŒQEHÀj&›bâÒ;ÀœÊ²QEHÀNiŒâÒ;À”œÊQEHÀY·D¸âÒ;ÀC´àQEHÀ\'XÞæâÒ;ÀÊ(nõQEHÀX“GãÒ;À©Þ&	REHÀp¯ùHãÒ;À?ÿ:REHÀT,ŽaãÒ;ÀVtð$REHÀ$¥zãÒ;À¬ËÓ,REHÀR2O”ãÒ;À‚4REHÀmkš®ãÒ;ÀJ¦:REHÀ•–ÉãÒ;ÀÕ\nÖ@REHÀÿïäãÒ;Àê|FREHÀcÛi\0äÒ;ÀãtlKREHÀ1¬äÒ;Àè¥OREHÀq!8äÒ;À;€%SREHÀSŒTäÒ;À‘rêUREHÀæ|äÒ;À’ÃGZREHÀªhÁÊäÒ;ÀÊÅ5]REHÀ’kåÒ;À²|6^REHÀ9õ@åÒ;ÀSìË\\REHÀ\r8{åÒ;ÀxXREHÀ]O‹ÓåÒ;À)¡NREHÀJu¤+æÒ;ÀÑÂ½CREHÀW®ƒæÒ;À|¨p8REHÀ¬×ÓÛæÒ;À*\\-REHÀaÙ?4çÒ;À\re$#REHÀwqXŒçÒ;ÀÛL²REHÀËú‹äçÒ;À\0T~REHÀo¢Ú<èÒ;ÀC¯REHÀ“–D•èÒ;ÀŽákÿQEHÀ|ÊíèÒ;À™øÚ÷QEHÀ¶éÒ;ÀÇÍÿõQEHÀ\"—°(éÒ;ÀË!%õQEHÀ%˜YFéÒ;ÀLHõQEHÀN¤÷céÒ;À•¥föQEHÀ\0©géÒ;À]†}øQEHÀ› ½éÒ;ÀžîþQEHÀGøéÒ;À×Q3REHÀa3êÒ;À,¤REHÀaHOnêÒ;À4Ù¤REHÀÁIÃ¨êÒ;À)æREHÀY{\0ëÒ;À‡˜q(REHÀÙXëÒ;À¦ú5REHÀ0òª¯ëÒ;ÀÉ—ŠCREHÀÃEìÒ;ÀöQREHÀ·¯ù^ìÒ;ÀtIM^REHÀ?•¼¶ìÒ;ÀXQkREHÀ?è”íÒ;À|\\*xREHÀá”vfíÒ;À…|ò„REHÀ„U¾íÒ;ÀúñÄ‘REHÀ¨Ÿ%îÒ;À³¼žREHÀ!fmîÒ;À¬REHÀz7ÄîÒ;À¡>ºREHÀ>‰…\ZïÒ;ÀçbÉREHÀJ/<pïÒ;À@ø¶ÙREHÀ×JGÅïÒ;ÀìoëREHÀœõ>ðÒ;À\ZÊÊþREHÀÖmÎkðÒ;À7©¼SEHÀ_œ½ðÒ;Àe‹*SEHÀõhX\rñÒ;Àòo™ASEHÀY»¤\\ñÒ;ÀÐWZSEHÀdnÍ«ñÒ;ÀD+sSEHÀ¾{ëúñÒ;Àî?ŒSEHÀ=·ýIòÒ;À€y\\¥SEHÀéö™òÒ;Àóm†¾SEHÀ±úçòÒ;Àgº¿×SEHÀ•_à6óÒ;Ào>ñSEHÀy¸…óÒ;ÀSåc\nTEHÀèŒÔóÒ;À¶aÁ#TEHÀ£ïc#ôÒ;Àc=TEHÀŠIrôÒ;ÀÅœiVTEHÀ<mÁôÒ;ÀqÚ;oTEHÀxÍ6õÒ;ÀsˆU‡TEHÀù#—aõÒ;À—ÿØžTEHÀé¡~²õÒ;À4™èµTEHÀŠËÝöÒ;À‰­¦ÌTEHÀÀMVöÒ;À:âTEHÀ[‘‹©öÒ;ÀÈ’õTEHÀC1þöÒ;À«KtUEHÀ|5ÞS÷Ò;ÀÈ4.UEHÀð‚qª÷Ò;Àv-(UEHÀØ¾QøÒ;À• ü6UEHÀ‘³‘XøÒ;ÀN1\0DUEHÀy5h°øÒ;À·IOUEHÀ\Z	ùÒ;Àæ‹èXUEHÀ•5´bùÒ;Àcéï`UEHÀŒ.¦¼ùÒ;À\nzgUEHÀµ¨úÒ;À8kUEHÀè¥púÒ;À`¯$mUEHÀäæ‡ÊúÒ;ÀSmGmUEHÀ\'Í8$ûÒ;À	ÿžkUEHÀx³¶AûÒ;ÀbgƒjUEHÀH/)_ûÒ;À¨ÖÞhUEHÀò‘|ûÒ;À\rÌ¸fUEHÀÏ$ñ™ûÒ;ÀPÇdUEHÀ <I·ûÒ;À¥GaUEHÀè]òûÒ;ÀŠÕ×YUEHÀ½÷¢,üÒ;Àd	šQUEHÀ%GfüÒ;À»¡=HUEHÀ$\nyŸüÒ;Àÿ[³=UEHÀ·qgØüÒ;À_øë1UEHÀ]ªaýÒ;À¹ %UEHÀ³­¯DýÒ;ÀØ¶UEHÀ8¤‹xýÒ;ÀÐ_ôUEHÀ€·/«ýÒ;Àa·õTEHÀ;ÖÜýÒ;À4öâTEHÀüËzôýÒ;À¤}&ÙTEHÀQŽ\ZþÒ;Àj¯äÎTEHÀ#Û þÒ;Àþ/(ÄTEHÀÜåá5þÒ;À/‚è¸TEHÀhÚTJþÒ;Àè)­TEHÀDáI^þÒ;À@ˆ÷ TEHÀ“Y‰qþÒ;ÀrÐž”TEHÀ}JÛƒþÒ;ÀÁ¤í‡TEHÀG¼•þÒ;À©¾zTEHÀ¶Ö¤þÒ;À/€ìlTEHÀÕÔÆÂþÒ;ÀE­OTEHÀvO#ßþÒ;À2TEHÀ%0FúþÒ;À	tBTEHÀ&‚‰ÿÒ;ÀfË.öSEHÀ¼PG.ÿÒ;À#Ùë×SEHÀ#œñRÿÒ;Àøz·©SEHÀVôtÿÒ;Àe]èzSEHÀI31–ÿÒ;À,_áKSEHÀ	8‹¸ÿÒ;À_SEHÀÖ‹äÝÿÒ;ÀÓ;·îREHÀCbFùÿÒ;À—¢ÜÑREHÀÀH\0Ó;ÀjÚk¶REHÀšæ¬:\0Ó;À0,œREHÀ04`\0Ó;À‡ñä‚REHÀå–Ÿˆ\0Ó;Àl]jREHÀWÄóœ\0Ó;À»„b_REHÀ¿è,²\0Ó;ÀÁþnUREHÀÒ‚dÈ\0Ó;ÀúYLREHÀ)´ß\0Ó;ÀÀ—úCREHÀ’5ø\0Ó;À*÷\'<REHÀïµyÓ;ÀGë4REHÀNó*Ó;À\Z…~.REHÀáÌDÓ;À½yí(REHÀ\\õ2_Ó;ÀõìC$REHÀ¯QzÓ;À¶¦ REHÀN´Ó;Àšòˆ\ZREHÀö\"/ïÓ;À²#(REHÀNÞ)Ó;Àà‰REHÀ~¨dÓ;ÀÜÌÌREHÀ®BðžÓ;ÀREHÀÂË¿øÓ;Àš¹ÜREHÀ¹Ü°RÓ;ÀiŸREHÀ4În¬Ó;ÀËuü\"REHÀlô¤Ó;À™}š+REHÀé¦þ]Ó;À#ï7REHÀïAÚµÓ;ÀçMxDREHÀ=-@\rÓ;ÀÏ	RREHÀÁ~YdÓ;À—Í_REHÀOKO»Ó;À1ò¾mREHÀî©JÓ;À„gØ{REHÀ}ZhÓ;Àbv(ŠREHÀTR\"¾Ó;À5ôÓ˜REHÀa¹èÓ;À}i˜§REHÀ®lòiÓ;À0^3¶REHÀCœ„ÀÓ;À][bÄREHÀŸF¸ÝÓ;À‹‹ÈREHÀ£÷>ûÓ;À‰ÊËREHÀçÓ;Àr-+ÎREHÀÀæ6Ó;Àg¹ÏREHÀÚƒØTÓ;À[ÐREHÀ$ÛµÓ;À‡Ø»ÐREHÀèR¢ÌÓ;ÀÓoëÏREHÀ$«Š	Ó;Àê@ÎREHÀ¦[D	Ó;À§MíËREHÀ‘€	Ó;Àî !ÉREHÀ«úéÙ	Ó;À\Z—ÃREHÀ‡Ç±3\nÓ;À;Ì¼REHÀ¾£m\nÓ;À¯×;µREHÀžÅ1ç\nÓ;À»\\w®REHÀ§eAÓ;ÀP}V©REHÀðG[šÓ;ÀF™¦REHÀïóÓ;À˜T$¦REHÀÛo¬MÓ;ÀÐüÓ§REHÀ>;r§Ó;À\\¦ƒ«REHÀô-\rÓ;À9ô±REHÀÚêÙ\rÓ;À‡OŠ³REHÀ3%=<\rÓ;ÀŽ`ª¶REHÀõ_Y\rÓ;ÀƒôdºREHÀ¾tYv\rÓ;ÀœØ¯¾REHÀI¼@“\rÓ;ÀÚ€ÃREHÀ˜T§Ì\rÓ;À©¸ÎREHÀ¼ØÓ;ÀÙŽÙREHÀ<Á<Ó;ÀØ€éåREHÀ‹ésÓ;À8o/óREHÀš.ÈªÓ;ÀgeSEHÀ‘;RûÓ;À7çSEHÀÐƒÎIÓ;À5çâ/SEHÀ’I–Ó;À8%£ISEHÀàøÍàÓ;ÀÉqeSEHÀÛ<i)Ó;ÀLß˜ƒSEHÀc4™@Ó;À¥gAŽSEHÀ›H´VÓ;À!=d™SEHÀøyÚkÓ;Àô1¥SEHÀŠÄ+€Ó;À ±SEHÀá)È“Ó;À-Ë¼½SEHÀ9bºÓ;À%NÎ×SEHÀúùßÓ;À»M òSEHÀ½>KÓ;ÀríãTEHÀþf\'Ó;ÀtRJ(TEHÀCîHÓ;Àw¢„DTEHÀŽÉewÓ;ÀlpTEHÀ˜³.¥Ó;ÀN½œTEHÀžÌÚÑÓ;À#gAÈTEHÀ+8âýÓ;ÀbŸÆôTEHÀ{½)Ó;À‚Š!UEHÀ­/¹DÓ;À†òÍ=UEHÀ,•–^Ó;À—÷GZUEHÀ|—nwÓ;ÀA1wUEHÀ†ZÓ;ÀŸ¿”UEHÀ_±s¦Ó;ÀÈÂ_±UEHÀ!YO®Ó;ÀèZ\0¾UEHÀtk%³Ó;À¶H=ËUEHÀ’•µÓ;ÀPÂØUEHÀì†´Ó;ÀL6;æUEHÀ¤ë^°Ó;ÀI¾SóUEHÀìµHªÓ;À4Ÿ\0VEHÀ`R¢Ó;À·ñjVEHÀ±‘¯˜Ó;ÀÝÑVEHÀöÔ’Ó;ÀZp$VEHÀÆo/Ó;ÀÎ¦0VEHÀå„`Ó;ÀMÏIVEHÀÕ¤=Ó;À ]¦aVEHÀ¤&˜Ó;À2ñäxVEHÀVåìôÓ;À%$ÞVEHÀ”YØÓÓ;À^åªVEHÀ»¬o¸Ó;Àn’ÅVEHÀóü§ Ó;ÀŸûßVEHÀŠXŒÓ;À)!LûVEHÀ–X{Ó;À+×WEHÀ=dmÓ;Àj3d2WEHÀ¿’jÓ;ÀÍGa<WEHÀs½jÓ;Àæ6ºFWEHÀ[nÓ;Àû*QWEHÀÐoÄuÓ;Ànãm[WEHÀQÙRÓ;À‰À?eWEHÀ—N˜Ó;ÀwWßmWEHÀkæºžÓ;À§¬tWEHÀ‡UÉ®Ó;À+µÐyWEHÀZMÒ¿Ó;À‰t}WEHÀ·ƒäÑÓ;À¡)ÁWEHÀÙœèÓ;ÀÈM²ƒWEHÀÈ²K>Ó;Àã-Ÿ…WEHÀ\"Á—tÓ;ÀŠ\Z=…WEHÀ†ÃVªÓ;ÀˆfA‚WEHÀ¬¶ßÓ;Àæaa|WEHÀ:\0N6Ó;ÀAOÛoWEHÀU€Ó;ÀÐÝcWEHÀP²ŠäÓ;Àóü­UWEHÀÝO;Ó;Àïš¬GWEHÀl±‘Ó;À?¨Ò8WEHÀ>¬ýçÓ;ÀUYï(WEHÀ(ÑÈ=Ó;À‚çpWEHÀ¿(w“Ó;ÀQßÏWEHÀœüléÓ;ÀMÍ„÷VEHÀ£™@Ó;ÀŽ>èVEHÀ™&@—Ó;Àûä\nÚVEHÀÓØïÓ;À¬´ÍVEHÀ«E\\GÓ;ÀŠ:ÇÂVEHÀaF Ó;À0¹VEHÀL¡ÁùÓ;À†:°VEHÀ“|SÓ;ÀrÇ¨VEHÀ\0Ž­Ó;ÀÀ7B£VEHÀÃŸËÓ;À-ÄŸVEHÀ<&	bÓ;Àq’džVEHÀÌÈ\Z¼Ó;ÀÌú;ŸVEHÀC\ZÓ;À{Ûë¡VEHÀä8\\p\ZÓ;À°Ç	¦VEHÀC]Ê\ZÓ;ÀDøŸ«VEHÀXd<$Ó;À%§¸²VEHÀ.ñ}Ó;À*\r^»VEHÀ‹ž×Ó;À,ýÄVEHÀµ!„0Ó;À-@ÏVEHÀ¥l‰Ó;ÀßzÉÙVEHÀT[RáÓ;À÷[åVEHÀÕÊM9Ó;ÀÎ#÷ñVEHÀõaÙÓ;ÀŠ)YÿVEHÀ%tèÓ;À6+-\rWEHÀ!	ó>Ó;À\nA|WEHÀ‹\'™•Ó;À°‚O*WEHÀ×\nìÓ;Ày	°9WEHÀÆSEBÓ;Àf­IWEHÀø˜Ó;Àwð?ZWEHÀ¥¤yíÓ;À±^kWEHÀäœB Ó;ÀV¯\0}WEHÀº}Œ— Ó;ÀóWEHÀp×éë Ó;Àœ!ñ¡WEHÀ…Jm?!Ó;ÀÌ±¿µWEHÀy.2’!Ó;À˜ã€ÊWEHÀ–ØSä!Ó;À¯ù,àWEHÀt¡í5\"Ó;À5¼öWEHÀ¿DŽ†\"Ó;ÀíìAXEHÀ¤3ÝÕ\"Ó;ÀÀÍê&XEHÀ+Bà##Ó;ÀÂÄ@XEHÀFCp#Ó;À~áÜ[XEHÀ1\r\Z¼#Ó;À$AxXEHÀrQÄ$Ó;ÀX†•XEHÀ„¨ P$Ó;À	E³XEHÀ“Xm™$Ó;À3„·ÑXEHÀÌ§èà$Ó;Ày¥ñXEHÀŽÞÐ&%Ó;À1X•YEHÀÑ0Çk%Ó;À¡ÝÈ2YEHÀRŸ°%Ó;À0É\rTYEHÀÿlõ%Ó;Àz\'XuYEHÀ¹ôC:&Ó;À\Zœ–YEHÀ§î7&Ó;ÀTpÍ·YEHÀpþ<Ä&Ó;ÀåêØYEHÀŠ›K	\'Ó;Àa¥úYEHÀ½†fN\'Ó;ÀÇZEHÀ:…“\'Ó;À%‡<ZEHÀâXÌØ\'Ó;Àõh]ZEHÀÛGÄ(Ó;ÀŽzƒ}ZEHÀÌ?ðe(Ó;ÀçaZEHÀ•Ÿÿ­(Ó;ÀVÕ¼ZEHÀÆ¡ö(Ó;ÀMŒªÚZEHÀ\'†?)Ó;À±=+ùZEHÀQLöˆ)Ó;À$æÿ[EHÀ·£Ó)Ó;ÀHð£3[EHÀÑ‡*Ó;ÀhžHO[EHÀÏÑšl*Ó;ÀD2j[EHÀCØÖº*Ó;À)îX„[EHÀùN/\n+Ó;ÀÖø[EHÀŒF	[+Ó;Àí£³[EHÀçY|­+Ó;Àf8&È[EHÀ(& ,Ó;ÀXFÐÚ[EHÀ…IŒW,Ó;ÀòÑë[EHÀ’>®,Ó;À/kû[EHÀâéÙ-Ó;À\ri,\\EHÀÆ]-Ó;À%d\\\\EHÀ_ku¶-Ó;ÀÚB£\\EHÀ–Å.Ó;ÀÄí$\\EHÀëM_j.Ó;ÀìP#*\\EHÀb.¢Ä.Ó;Àuý/\\EHÀ%å/Ó;Àb0·2\\EHÀy¥,y/Ó;À\'&±4\\EHÀ£”}Ó/Ó;ÀÄÆ4\\EHÀ¡æ-0Ó;Àµ_€3\\EHÀÈÒUˆ0Ó;ÀUü~1\\EHÀèù½â0Ó;ÀŽóœ.\\EHÀ»ê=1Ó;À`Hµ*\\EHÀÀuD—1Ó;À&ü¢%\\EHÀD…ñ1Ó;À%…¹\\EHÀÛù’K2Ó;À„~d\\EHÀ\0±y¥2Ó;ÀMå–\\EHÀÆÚDÿ2Ó;À ·C\\EHÀª\r\0Y3Ó;Àó]\\EHÀ6›²3Ó;ÀVøû[EHÀd!4Ó;À5pò[EHÀÇ‚7e4Ó;ÀÑ)é[EHÀ‹¾4Ó;Àh›ùÞ[EHÀÓŠž5Ó;À8k›Ó[EHÀ`Èïn5Ó;À¨\"DÇ[EHÀq-îÆ5Ó;ÀLœcº[EHÀÉiŸ6Ó;À^/ù¬[EHÀÁ(	v6Ó;À¿4Ÿ[EHÀé1Í6Ó;ÀM„[EHÀR$7Ó;ÀÂ³[EHÀC™õz7Ó;Àú\ZÐr[EHÀ’èÍÑ7Ó;Àÿæc[EHÀ†7ª(8Ó;À•^U[EHÀë’8Ó;Àõ\'<F[EHÀ3!€Ö8Ó;À`$•7[EHÀ%L{-9Ó;Àš!)[EHÀG»|„9Ó;À³òƒ\Z[EHÀ(}Û9Ó;À‡hý[EHÀNu2:Ó;À™UeýZEHÀ@¬±ˆ:Ó;À‘H\\îZEHÀ—}Þ:Ó;ÀJˆÞZEHÀdò3;Ó;ÀB1ÎZEHÀþ*‰;Ó;À—U½ZEHÀ{¥=Þ;Ó;À@è`¬ZEHÀ9T­0<Ó;Àï™ZEHÀ6]S€<Ó;Àeû_‚ZEHÀF™-Ï<Ó;À>¥`jZEHÀ£å9=Ó;ÀY†=SZEHÀlvr=Ó;Àâ7?ZEHÀ(bMÈ=Ó;ÀâÉÑ.ZEHÀE’>Ó;Àê\r‘!ZEHÀYc³v>Ó;Àô‹ZEHÀù‰ÿÎ>Ó;ÀnË7ZEHÀð¼Ú\'?Ó;ÀÄS¦	ZEHÀyß‚c?Ó;ÀÕå?ZEHÀ YŸ?Ó;ÀþZEHÀ1*DÛ?Ó;À@¿èZEHÀÖ«*@Ó;ÀÈãZEHÀ“PóR@Ó;ÀPëZEHÀÄ ‚p@Ó;À…>d\nZEHÀžÅð@Ó;À—SRZEHÀ®±F«@Ó;À¡ÁZEHÀW‹È@Ó;ÀÀ<¼ZEHÀÙ+Æå@Ó;Àø—OZEHÀfZAÓ;À-QµZEHÀüiÌWAÓ;Àx\'ZEHÀ±ÀDAÓ;ÀpX­2ZEHÀ·½êÅAÓ;Àç§j?ZEHÀ(æûAÓ;À¾€ÅMZEHÀÍ»*BÓ;À3™UZEHÀ/É–/BÓ;Àªûï]ZEHÀÞTWHBÓ;ÀKúÆfZEHÀ7ˆ™`BÓ;ÀÆMpZEHÀ™ŒŠxBÓ;ÀúêyZEHÀ)œ\0BÓ;ÀÖ„ZEHÀ¢À¦BÓ;ÀÓYŽZEHÀšVá¼BÓ;À `™ZEHÀpyÒBÓ;Àž¤ZEHÀù¦ŸçBÓ;Àš]W°ZEHÀ%íƒCÓ;ÀFÍâÈZEHÀÕ¤Ú6CÓ;À¡\"@âZEHÀH­ñZCÓ;ÀS\ZŽüZEHÀVá}CÓ;Àvpë[EHÀX!˜CÓ;À²áv4[EHÀ^Á­ÊCÓ;À„Ä`[EHÀºÑpòCÓ;Àê‰Æ[EHÀÛ—DÓ;ÀîÆÁ»[EHÀ(Ö4DÓ;À;ûê[EHÀ,ããPDÓ;Àò2·\\EHÀç-“`DÓ;À.=<\\EHÀÂØlDÓ;Àt|ž\\\\EHÀ@fÁuDÓ;Àß%.}\\EHÀG+^{DÓ;ÀsmÃ\\EHÀ¥G½}DÓ;ÀÛˆT¾\\EHÀ¨\r%}DÓ;Ànk¯Í\\EHÀ\\µzDÓ;À\\Ý\\EHÀ¨ÂŠvDÓ;Àƒwhì\\EHÀÚÍÁpDÓ;ÀùœÂû\\EHÀQwiDÓ;À¸]EHÀsZLKDÓ;ÀÇª$7]EHÀp¹$DÓ;ÀÐ®K`]EHÀ$(JûCÓ;À¤s€ˆ]EHÀLaŠÔCÓ;À£áµ±]EHÀ¢ö¶CÓ;À+áÞÝ]EHÀ•Ä®CÓ;ÀG­í]EHÀ(-©CÓ;À.uLü]EHÀ¼\0Z¥CÓ;À¯òƒ^EHÀ)—c£CÓ;À!à´\Z^EHÀÙ×b£CÓ;ÀÆöÙ)^EHÀˆˆÙ¥CÓ;À\\Á>^EHÀN˜ªCÓ;ÀØß=R^EHÀ±×´±CÓ;À\0A`f^EHÀ½ÑD»CÓ;À™Óvz^EHÀ¬ì]ÇCÓ;ÀÃ„€Ž^EHÀ*6fÎCÓ;ÀWºF˜^EHÀOLÖCÓ;ÀçÞ™¡^EHÀDÞCÓ;Àô²˜ª^EHÀ1+×çCÓ;À¤øa³^EHÀ%™òCÓ;Àq¼^EHÀänDÓ;À(ÜÈ^EHÀ¥\r™DÓ;ÀÓ«úÔ^EHÀg¶%DÓ;À`_Žà^EHÀø8DÓ;À¤µë^EHÀ]ÇMDÓ;À„ÜŽö^EHÀÍô\r{DÓ;Àì\r_EHÀ3;Ï©DÓ;Àñ·9\"_EHÀ`ò›ÚDÓ;ÀÍHü4_EHÀZt<EÓ;ÀI§#D_EHÀÙyEEÓ;À$Ý„N_EHÀŽÁº¿EÓ;À\"a˜]_EHÀ¸oO:FÓ;À\rKk_EHÀ½hµFÓ;ÀÙ(³w_EHÀôž/GÓ;Àyˆ}„_EHÀ Wð©GÓ;ÀüøG’_EHÀä¡ý‡IÓ;À\'Ý’¿_EHÀÄ­mKÓ;À&v¦â_EHÀÓÒNMÓ;À€,Ê`EHÀïà>OÓ;ÀÓiEO`EHÀ’ýÃÒPÓ;Àf™_»`EHÀnkkQÓ;ÀS¸ì`EHÀÊ°ýRÓ;À•ÉaEHÀ1„œRÓ;ÀÔŸ‡OaEHÀY5SÓ;Àvxó€aEHÀÁTÓ;Àõ?Œ°aEHÀü¼ûUÓ;À>xÑaEHÀÖ¨ß`UÓ;ÀœÀfòaEHÀé¥Á°UÓ;ÀNéVbEHÀ´s£\0VÓ;Àð,G4bEHÀÖ†PVÓ;ÀQ-6UbEHÀ´¤†VÓ;ÀÏŽÂjbEHÀŒËQ¼VÓ;À†ÐbEHÀÒžÂòVÓ;Àª%°”bEHÀät)WÓ;ÀÉQ±©bEHÀ× ¹^WÓ;À$¿bEHÀp#÷ WÓ;À[§=ÝbEHÀ^;ßWÓ;Àö4þbEHÀU`XÓ;ÀKj; cEHÀ®Ú0XXÓ;À1ú.BcEHÀ•7×—XÓ;À²™zbcEHÀ:ÕßÕXÓ;À´µÁ~cEHÀ¥SBYÓ;À(­™cEHÀ£ÈyVYÓ;ÀS°2³cEHÀ¶FšYÓ;ÀS\rHËcEHÀÞåSàYÓ;À¦ÿâácEHÀ†…“ZÓ;À• NñcEHÀèOZÓ;ÀÔ–qþcEHÀm¢E‰ZÓ;ÀÜr‚	dEHÀZ‹ ÃZÓ;À\nÄµdEHÀÑõìþZÓ;À×š@\ZdEHÀÉ ÛP[Ó;Àc¯M!dEHÀÃr£[Ó;À¦âZ%dEHÀY­/ö[Ó;À{(dEHÀ>¯‘H\\Ó;À~Ã,dEHÀAðš\\Ó;À½¥D4dEHÀ“Ü7]Ó;À\rVàHdEHÀÆhÔ]Ó;À¶±ê_dEHÀÑ*p^Ó;ÀaUâxdEHÀ\0Ž_Ó;ÀEÞE“dEHÀÕ§_Ó;À%ê“®dEHÀÿ0`Ó;À,œÉdEHÀ¨Ý¥¶`Ó;ÀiµçdEHÀgzå:aÓ;ÀißÀeEHÀžd&½aÓ;ÀÑÄ“*eEHÀÊ›²=bÓ;À¹ÔNeEHÀ\nÖˆ~bÓ;ÀD76oeEHÀ½st«bÓ;ÀmêáœeEHÀÑºªÑbÓ;À­îÎeEHÀ0ñ`þbÓ;À~½qüeEHÀÈ\\Ì>cÓ;À?ÁƒfEHÀÆá¥³cÓ;À\ZQA,fEHÀ2K	3dÓ;ÀhÈ²&fEHÀ“”¶dÓ;ÀßïfEHÀV¸í5eÓ;À\"\rfEHÀé°®«eÓ;À¼ß##fEHÀx¼äËeÓ;À,fEHÀ\r™ìeÓ;À?Ž^5fEHÀ3¾¨fÓ;À¸R?fEHÀ\\¢k*fÓ;ÀàÈ+JfEHÀ.¾çGfÓ;À]*VfEHÀrìB…fÓ;ÀÜqlqfEHÀHÎÝÁfÓ;ÀEˆØŒfEHÀÆrÎýfÓ;Àõ’„¨fEHÀêç*9gÓ;À¤Ù†ÄfEHÀÌ<	tgÓ;À•¤õàfEHÀ8É#ügÓ;À´Pú&gEHÀ“]õhÓ;À¶ŒvogEHÀˆrþiÓ;ÀÎˆ¸gEHÀ„¿ˆiÓ;ÀõŠO\0hEHÀ¹jÓ;À\Z7éDhEHÀ¹pÎXjÓ;Àã*ÌahEHÀÅ·# jÓ;ÀRu½{hEHÀ¸¾/êjÓ;À€+“hEHÀai6kÓ;ÀŽ¶„¨hEHÀKzG„kÓ;ÀÙ7¼hEHÀPókÓ;ÀÔ°4ÖhEHÀÖŠNblÓ;ÀWÁîhEHÀÓ12ÒlÓ;Àz±iEHÀTŠ¾BmÓ;À~+iEHÀ´mÓ;À­x[1iEHÀpêmÓ;ÀZ:iEHÀtû!nÓ;Àª(BiEHÀ•×ÁXnÓ;À\\–IiEHÀFè¹nÓ;À„rQiEHÀ¹fôÅnÓ;À¾”ŠZiEHÀGÐë)oÓ;À±{riEHÀup‰oÓ;Àd5¶iEHÀ³1šçoÓ;Àð	d¯iEHÀm,ƒGpÓ;ÀÊ?\"ÍiEHÀ,D¬pÓ;ÀñäiEHÀ+¨qÓ;À`NtjEHÀ˜¿prÓ;ÀÃ%ê.jEHÀn¦UsÓ;ÀÉ„ULjEHÀ@}<tÓ;À‘K¹djEHÀ¹‰a%uÓ;À•XxjEHÀŒÕù¸uÓ;ÀwÚõjEHÀäÌ’LvÓ;ÀtcSŠjEHÀº,8àvÓ;À²D‘jEHÀÑ¯õswÓ;À<†Ý–jEHÀ;×xÓ;Àðœ1›jEHÀñÂ£xÓ;ÀR?žjEHÀ\'‹ >yÓ;Àu¹m jEHÀ°)ÚyÓ;À/x¨ŸjEHÀE2iuzÓ;ÀÍçR›jEHÀÐv{Ó;Àtr’jEHÀñ`€{Ó;À¨:þ‡jEHÀÝp¢ï{Ó;À(q\rzjEHÀã¿]|Ó;ÀÈÀzijEHÀ:ÊVË|Ó;À:Ò WjEHÀúÙ8}Ó;À¸NÚCjEHÀËÿ.Õ}Ó;ÀÕ(jEHÀFžMp~Ó;À\"#}jEHÀC•	Ó;ÀþÝ¬ìiEHÀ÷We Ó;ÀWšBÊiEHÀäG4€Ó;À°Û¢iEHÀçs±&Ó;Àµ¾}TiEHÀ\'x‚Ó;Àvä×ýhEHÀ¢â—ô‚Ó;À¨°[¤hEHÀ*7ÜƒÓ;ÀÉ³zMhEHÀá€|Ì„Ó;À#|¦þgEHÀ5úÊ‰…Ó;À90«ÆgEHÀCn&G†Ó;À¾\0»ŽgEHÀg=‡‡Ó;Àô\'ÐVgEHÀ4ÊåÁ‡Ó;À‘ßägEHÀu:ˆÓ;ÀbbóæfEHÀw™ò‰Ó;Àøõµ•fEHÀ–LW¢ŠÓ;ÀF;0DfEHÀýcÉ³‹Ó;À^ªòeEHÀ[¶©ÅŒÓ;ÀÓ‹l¡eEHÀzYØÓ;Àuï¾PeEHÀ(ä[ZŽÓ;Àî´-9eEHÀ”<åŽÓ;À6eEHÀüñtÓ;Àho\Z@eEHÀÿQoÓ;ÀòOéOeEHÀÛ3­’Ó;Àh%)^eEHÀ=ë}‘Ó;ÀF\\øfeEHÀ‹i~‘Ó;Àýä²oeEHÀ\"[êó‘Ó;ÀîLëyeEHÀt¥zh’Ó;À”\"4‡eEHÀÔ±”Û’Ó;ÀÛó™eEHÀä*ÐZ“Ó;Àa?±eEHÀ&“lØ“Ó;À‚iÀÊeEHÀ21óT”Ó;ÀÉ!HåeEHÀÑMíÐ”Ó;ÀHž{\0fEHÀ›/äL•Ó;ÀÉñÿfEHÀj¹a°•Ó;ÀùŠ93fEHÀ€§ô–Ó;À-Ñ±KfEHÀ´êfu–Ó;À/nVdfEHÀÁr‚Ø–Ó;ÀÌ|fEHÀ™1=—Ó;ÀèTÛ‘fEHÀèŒ9\0˜Ó;ÀçÒù°fEHÀ$fÈ˜Ó;À–vÅfEHÀQæù’™Ó;À¹Y?ÔfEHÀßÃW]šÓ;Àl”LäfEHÀ½©â$›Ó;Àä?:ûfEHÀýn+™›Ó;ÀŸ’…gEHÀ´ÈÃœÓ;ÀîJgEHÀ¸>€œÓ;ÀlÝK3gEHÀûY5ñœÓ;À?¿gIgEHÀm£·aÓ;À\\c¿agEHÀ‰¶ÛÓ;ÀÜl©gEHÀï$\ZOžÓ;À{Þu¦gEHÀ¬kÁžÓ;ÀgÊ‰ÍgEHÀýÙŠ5ŸÓ;À^CJôgEHÀð„¯ŸÓ;À[hEHÀ\n±šýŸÓ;Àól/,hEHÀëëL Ó;À0ïD>hEHÀ ¸œ Ó;ÀE\ZÉMhEHÀò;Áì Ó;ÀÚ\'(ZhEHÀ¾+Æ<¡Ó;ÀïOÎbhEHÀW’­Þ¡Ó;À…kcdhEHÀN¨‚‚¢Ó;ÀoM­RhEHÀÆÉ‰&£Ó;ÀLk®3hEHÀçRÉ£Ó;À*:i\rhEHÀí ?h¤Ó;À/àågEHÀÌ¿Ó¤Ó;ÀtÙŸ¼gEHÀ`ä1¥Ó;ÀÀEƒgEHÀ-	¯Š¥Ó;ÀjT3HgEHÀ#æ¥Ó;ÀÜÎgEHÀMDL¦Ó;À€šxgEHÀøÞ¼¦Ó;Àl)gEHÀ&ð_2§Ó;ÀSšqgEHÀç(ª§Ó;À˜\'\r9gEHÀ–—t!¨Ó;ÀF\rYgEHÀ1¸•¨Ó;ÀL†R{gEHÀ$ÝcÞ¨Ó;ÀX•2gEHÀðÕ§\'©Ó;Àê“ ¢gEHÀDól©Ó;À‚ª·gEHÀMOµ©©Ó;À,ÃÐgEHÀ/ ]Ù©Ó;ÀòÃEògEHÀëohCªÓ;Àíñi_hEHÀõK,¤ªÓ;ÀjßÈÍhEHÀ=Ð&ÿªÓ;ÀˆÍü<iEHÀ˜ÖW«Ó;ÀÙüŸ¬iEHÀÂ;¸±«Ó;À|®LjEHÀwÍÒä«Ó;Àn\',]jEHÀº9ª¬Ó;ÀÆ”ržjEHÀ×’¢F¬Ó;ÀZJÆßjEHÀ„ïz¬Ó;À‘œÍ kEHÀó`†²¬Ó;Àêà.akEHÀ—ê¬Ó;Àƒ¾LkEHÀ7ws2­Ó;Àþ,W±kEHÀÁ¨††­Ó;À{‰ÌÎkEHÀðŠá­Ó;À¥1+çkEHÀ˜=®Ó;À¶ƒñûkEHÀC£ð¹®Ó;À©=šlEHÀ)¶Q8¯Ó;Àêlj\'lEHÀhqÝ¶¯Ó;À[8\Z:lEHÀl:4°Ó;À°ÄaNlEHÀ$\r¯°Ó;ÀË8ùflEHÀÁ\0=±Ó;Àè³Ú‡lEHÀWÊ±Ó;À‘©lEHÀÐ\ZW²Ó;ÀÖ/ÌlEHÀVã²Ó;ÀƒÄïlEHÀê³o³Ó;ÀÊèamEHÀé ñ³Ó;À‘Á:7mEHÀ”GÂr´Ó;Àé@	[mEHÀ¨ºñ´Ó;ÀùÝmEHÀnÁDmµÓ;ÀþªmEHÀÍ=äµÓ;À8RÅØmEHÀ¼Œ@ƒ¶Ó;ÀSA#nEHÀÓî{·Ó;À  tnEHÀ]Ý¤·Ó;ÀÌ=JÈnEHÀÙýì1¸Ó;ÀŒ0ðoEHÀáöKÆ¸Ó;Àð}ooEHÀ»™«P¹Ó;À³%9ºoEHÀýpÛ¹Ó;À\n\rpEHÀõ3\\iºÓ;ÀuÑ¢OpEHÀQR-ýºÓ;À[	ŽpEHÀj¤™»Ó;À$cR¼pEHÀ{¼Ñ¼Ó;Àç+LÁpEHÀïAóu¼Ó;ÀR#©pEHÀ”y™è¼Ó;À_¤u‚pEHÀçåT\\½Ó;À×YpEHÀ1¶Ï½Ó;À)¨~:pEHÀ¿Û)¾Ó;ÀK%¤%pEHÀÛß<ˆ¾Ó;Àï5lpEHÀ}ùšæ¾Ó;À=ØøoEHÀ\0·@¿Ó;À@	˜ñoEHÀTZT’¿Ó;À!ÇUpEHÀ2T;°¿Ó;ÀÃ¿pEHÀ_\"#Ã¿Ó;ÀÂE»+pEHÀJÿ•Ð¿Ó;ÀVEpEHÀ|&Þ¿Ó;ÀÈú†^pEHÀ™ÔEñ¿Ó;À <çupEHÀÜýÃÀÓ;ÀôÛ¯4qEHÀRã}—ÁÓ;À8}nóqEHÀôgökÂÓ;Àgý²rEHÀìá—AÃÓ;Ào9qpsEHÀÏÏ’ÄÓ;Àä‡.tEHÀÓyÄÓ;ÀÖ0‡tEHÀV{×ÄÓ;ÀÓàtEHÀlÓ8ÅÓ;ÀùŽ°7uEHÀ$Ck¤ÅÓ;À×ãoŒuEHÀÍ£úÆÓ;À‰”ÜuEHÀ¹þ¨ÆÓ;À&“žvEHÀíÑâAÇÓ;ÀÏÎhMvEHÀÊÝ¸äÇÓ;ÀÒ’‰tvEHÀÌ’‹ÈÓ;Àd±——vEHÀK‚0ÉÓ;ÀÓý)¼vEHÀÒGN@ÊÓ;À¨/¿ývEHÀ7ŽìOËÓ;À)¿¤>wEHÀc$`ÌÓ;ÀQÏ•~wEHÀ%Í›qÍÓ;ÀÁ„M½wEHÀM*…ÎÓ;Àç‡úwEHÀ ç¼ÑÎÓ;À«Ž\nxEHÀ*@¯ÏÓ;ÀfÈOxEHÀHöVlÏÓ;À/Ù&xEHÀ¦	»ÏÓ;ÀÑ¶93xEHÀéêÐÓ;Àæ3€>xEHÀº>œ,ÐÓ;ÀewøAxEHÀKDNÐÓ;À„lÑCxEHÀÓ{ÿoÐÓ;À€âDxEHÀ;¸‘ÐÓ;À~§€DxEHÀ¡ôX³ÐÓ;À-ŠDDxEHÀÙºÒÐÓ;À®ÐCxEHÀäöñÐÓ;ÀîÿxBxEHÀ–	ÑÓ;À|ð¼?xEHÀÝ\0ó/ÑÓ;À<=;xEHÀ«D°NÑÓ;À»Q4xEHÀ=éÑÓ;ÀÄ¼á\"xEHÀ²“à­ÑÓ;Àæxú\rxEHÀsÂ/ÓÑÓ;ÀÔcÇõwEHÀ}oòÑÓ;Àé\\ºÚwEHÀÏ§8ÒÓ;ÀòBE½wEHÀ³j«(ÒÓ;À¸½×”wEHÀn@ÒÓ;À»eblwEHÀ8Ë®SÒÓ;À{½®CwEHÀÝ™›bÒÓ;ÀvG†\ZwEHÀWœbmÒÓ;ÀD‡²ðvEHÀ5†õ{ÒÓ;Àd‡¦vEHÀâ¥ˆÒÓ;Àb\\vEHÀ^k“ÒÓ;À-7<vEHÀ#èšÒÓ;À{¤ÈuEHÀ‡ÀŸÒÓ;ÀI5È}uEHÀPï9žÒÓ;À‹8uEHÀXøŒ–ÒÓ;ÀJ™KòtEHÀc</ÒÓ;Àg	‰¬tEHÀnS–†ÒÓ;ÀV†ÄftEHÀÖ7‡ÒÓ;Àj¹þ tEHÀkí¼“ÒÓ;Àû§8ÅsEHÀÖŠÅ©ÒÓ;À(jjsEHÀŸ¼ÈÒÓ;ÀSò›sEHÀàðÒÓ;Àj3µrEHÀƒýÓÓ;À[ \\rEHÀ.bPIÓÓ;À¤ârEHÀ¹‹vÓÓ;À“ñÏqEHÀ¿7V§ÓÓ;ÀÆýŠqEHÀ™7ÜÓÓ;Àž¼ÖFqEHÀ3rµÔÓ;À‘\"àqEHÀûUÔÓ;ÀJ[Æ¾pEHÀ?oª—ÔÓ;ÀxG¸zpEHÀëG‡ÛÔÓ;ÀA1`7pEHÀfLÝ ÕÓ;ÀËbhôoEHÀ€3VgÕÓ;À®%{±oEHÀ¤1j‘ÕÓ;ÀRb~ŠoEHÀRÜ™¼ÕÓ;À&Ø|doEHÀ:ÏþéÕÓ;ÀøF\'?oEHÀï¤²\ZÖÓ;Àn.\ZoEHÀøÎOÖÓ;À2\rCõnEHÀ¶k/‹ÖÓ;À4A>ÎnEHÀ7ÏÌÖÓ;À€Ó¨nEHÀ£´Á×Ó;ÀRî³ˆnEHÀv²œ[×Ó;Ào¼vnEHÀÇZô¨×Ó;À¹iìunEHÀÁ`vù×Ó;ÀnT8‚nEHÀ‡gJØÓ;À©øÓnEHÀi¸ÀšØÓ;ÀsÕžnEHÀ¸œ‘ëØÓ;ÀÑiD¬nEHÀÃ]…<ÙÓ;À?4¾¹nEHÀ6KÆÙÓ;ÀuÜ¿ÏnEHÀGPPÚÓ;ÀË¦ÐånEHÀVîîÙÚÓ;Àl¡ÃûnEHÀàÇîcÛÓ;ÀóÙkoEHÀ´#îÛÓ;À‰^œ&oEHÀ&½‡vÜÓ;À³µ½6oEHÀGG+ÝÓ;ÀÖ*AoEHÀ{¬jŒÝÓ;ÀÂÔûIoEHÀJ¢ÞÓ;Àx†MUoEHÀz.žÞÓ;ÀÞ•9goEHÀdªÛÞÓ;À·ˆ¯qoEHÀØ!ÌßÓ;Àüºj|oEHÀõdTßÓ;Àˆ’]‡oEHÀØ<çßÓ;À2uz’oEHÀþ]ÍßÓ;ÀFÈ³oEHÀKJItàÓ;Àš î¼oEHÀ”5\ráÓ;À•hXÜoEHÀIT¸ÁáÓ;ÀëèäûoEHÀZ$ZhâÓ;Àlë…pEHÀ6)ãÓ;ÀÎ¸-;pEHÀ“©™ãÓ;Ài.VpEHÀc‚\"\"äÓ;ÀÌÑ³rpEHÀ 	ªäÓ;À‰õöpEHÀ_„µ0åÓ;À2¤/±pEHÀP¶åÓ;Àþû•ÓpEHÀjW½åÓ;À@ßÖpEHÀ-\n½ÁåÓ;À¬u’ÛpEHÀ›í¢ÅåÓ;À?GÐàpEHÀîŠÊåÓ;ÀžÍ¸åpEHÀh”ÐåÓ;ÀUElépEHÀLÝ¹<æÓ;ÀwèÈ\rqEHÀì\\6«æÓ;À‰,D0qEHÀã˜\ZçÓ;ÀñòRqEHÀ\Zm‰çÓ;À¢rtqEHÀ¨CöçÓ;À’˜qEHÀ|æpDèÓ;ÀÀ¡ã²qEHÀÇ©\n“èÓ;ÀöšÆÌqEHÀXQ™àèÓ;À—I¢çqEHÀå9¥+éÓ;À—}ÝrEHÀXÂ¶réÓ;ÀÐß%rEHÀ}×‚ÏéÓ;À†¢*[rEHÀ‚ÙŠ\"êÓ;À¤kj”rEHÀ÷$ùnêÓ;À[ñ]ÐrEHÀêø·êÓ;ÀMÃÄ\rsEHÀµ÷±\0ëÓ;À©q^KsEHÀ/»]ëÓ;ÀpËšsEHÀŠÂh·ëÓ;À42\\ésEHÀ(\'üìÓ;À²’â8tEHÀ ÿ(kìÓ;À0ÚˆtEHÀ¡aFÇìÓ;ÀÞôdÖtEHÀ°UHíÓ;Àbž6uEHÀÉîÔíÓ;À¡O’‘uEHÀR¼òcîÓ;À	/hëuEHÀÍNlðîÓ;À<9FHvEHÀ¡5rïÓ;ÀóR¬vEHÀ:x›©ïÓ;ÀS«%ávEHÀ–HØ×ïÓ;À`€wEHÀ}3üïÓ;À8pšPwEHÀ¸ÅÅðÓ;ÀŠ{¤ŠwEHÀ\rŒ!$ðÓ;À{¢ÓÅwEHÀ//—.ðÓ;ÀoÈ¡xEHÀ¶6ðÓ;À¹DykxEHÀ\nù<ðÓ;À©ËW¾xEHÀ‡ÍP?ðÓ;ÀÏ;yEHÀœƒ@ðÓ;ÀÃ dyEHÀÙ¶â>ðÓ;ÀzÎìöyEHÀ‹¬:ðÓ;ÀÖ?À‰zEHÀ¼Hô5ðÓ;À¾•{EHÀ[¤Í2ðÓ;À¤\0e¯{EHÀX\\L3ðÓ;ÀŸ$*B|EHÀù[®6ðÓ;À»Š`‰|EHÀ	ÝÅ=ðÓ;ÀI§Ð|EHÀ\"â_HðÓ;À$ýŠ}EHÀônIVðÓ;À±†^}EHÀg‰OgðÓ;ÀYbt¥}EHÀ¨Ê{ðÓ;ÀPà-æ}EHÀ(Þç•ðÓ;À&~EHÀðÇ³ðÓ;ÀÝ#he~EHÀÆ‹ÓðÓ;ÀœR›¤~EHÀ½©SóðÓ;ÀÏþã~EHÀ†ØñÓ;À{Û\"EHÀa÷T5ñÓ;ÀÄÓ¢`EHÀ$‡à]ñÓ;Àð7MEHÀŸ½’ñÓ;ÀÝÓØEHÀ #ƒÍñÓ;À ›.€EHÀÇ¦\rîñÓ;ÀAá$€EHÀaM©òÓ;À£›”-€EHÀ©ÞÇIòÓ;ÀIÉÈ/€EHÀ‹$ÛwòÓ;ÀŸgô*€EHÀÁæTòÓ;À„sP€EHÀ·ÙßòÓ;À¢²ýEHÀ« óÓ;À²%·ØEHÀón3aóÓ;ÀY°³EHÀüÛ¢óÓ;À¤ÛXEHÀY£\nçóÓ;ÀÍ8mEHÀe¼ŒôÓ;À\"s#!EHÀÍTü2õÓ;À¨¹Ö~EHÀîå;ÚõÓ;À\\NçŠ~EHÀpì)€öÓ;ÀUtµ>~EHÀÉâ%#÷Ó;Àm‰ð}EHÀx‹_U÷Ó;À«®1×}EHÀ{‹††÷Ó;ÀýND½}EHÀ#g¶÷Ó;ÀÇÃ¶¢}EHÀ\r¦¦å÷Ó;À¹~‡}EHÀ‰Ì¤øÓ;ÀG\0‘k}EHÀßZHøÓ;À÷Æ~I}EHÀ{\\âzøÓ;ÀÚ)&}EHÀ4×´«øÓ;ÀÕ‰é}EHÀLàKÛøÓ;À˜EÁÞ|EHÀÕ\r!\nùÓ;Àa¼Aº|EHÀˆ¼ÜQùÓ;À7~|EHÀ™7‘”ùÓ;ÀÐß@|EHÀŒEÕùÓ;À;\Z]|EHÀ5Î\0úÓ;ÀÄJ¤Â{EHÀJÊ\\úÓ;ÀÖË„{EHÀ·Ü›úÓ;ÀâÓe{EHÀ8Dß£úÓ;ÀÔi¯C{EHÀk:ÌúÓ;À\"+¤%{EHÀnMRûúÓ;ÀA¬Ã{EHÀ°Í3ûÓ;Àæ~ì{EHÀ†loûÓ;ÀÙŠ@{EHÀˆ\n«ûÓ;ÀÍ–”{EHÀ›ô¨æûÓ;ÀÁ¢è{EHÀ%aG\"üÓ;À(®<{EHÀ¯Íå]üÓ;Àº{EHÀN+ÛÈüÓ;À\\;z{EHÀŠÐ3ýÓ;À(½c;{EHÀ¤çÅžýÓ;Àõ>MW{EHÀCE»	þÓ;ÀÁÀ6s{EHÀû£°tþÓ;À\ZC {EHÀ°ÛógÿÓ;Àð(Í{EHÀLQ`\\\0Ô;ÀµWx	|EHÀº[QÔ;ÀM±;E|EHÀe/IFÔ;À$äœ|EHÀQ¸:Ô;ÀÄ¬Æ¿|EHÀ¯» Ô;Àïö%à|EHÀë¸NûÔ;À\\ó}EHÀ\\½LÔ;ÀfH9}EHÀTØ”Ô;À$’o}EHÀ|OÔÔ;ÀuZ@«}EHÀÜÖ{ìÔ;ÀØ´2Í}EHÀÍçøÔ;À¸ÝŒð}EHÀIšSüÔ;ÀÞ­X~EHÀ™%·ùÔ;ÀÖ\0 7~EHÀÎV	ôÔ;Àh¯lY~EHÀQ1ÜÔ;Àèú~EHÀÛY ±Ô;Àgþ¼Â~EHÀ6\\èÔ;À\ncŒ÷~EHÀzšZÔ;À¦‡B,EHÀXFIÔ;ÀvÞ¸`EHÀ¦wYLÔ;À˜ðÛ‰EHÀ…@/ZÔ;À¨Ö³EHÀÒünuÔ;À7öÜEHÀ„ù¿ Ô;ÀÔ´M€EHÀB€ÉÞÔ;ÀBz^+€EHÀÆ\"€XÔ;ÀHâ×^€EHÀ2ÒÔ;Àìý}€EHÀ6ãOKÔ;Àär´‘€EHÀ2-FÄÔ;ÀPß¢€EHÀˆƒÙ<Ô;ÀK_bº€EHÀÞLÏÔ;À_æÝ€EHÀŽbÔ;Àö$ü\0EHÀ±*µôÔ;ÀUñc$EHÀåI}†	Ô;À+ÞHEHÀþ„ß\nÔ;Àè¤*oEHÀÞ›÷\rÔ;À@ÌˆµEHÀo¡Ô;À\"¶òþEHÀ;V>ôÔ;À+JJ‚EHÀ±y²å\rÔ;Àòp–‚EHÀ^ÌŠ×Ô;ÀdÒHâ‚EHÀåáBÔ;ÀâtSƒEHÀd­Ô;ÀÝÇ8ÅƒEHÀ°éÔ;ÀB§÷7„EHÀÄZEÔ;Àˆ/¬„EHÀª0LæÔ;Àìå!…EHÀÚ0õ<Ô;À*”¹@…EHÀT/¡Ô;ÀÎña…EHÀÙÂrâÔ;ÀÄ»„…EHÀŒ3Ô;À.F¨…EHÀÛ…Ô;ÀaUÂË…EHÀ©©ÉæÔ;À Øõ…EHÀDÕjEÔ;À¦šD†EHÀ*H¡Ô;ÀÐ/K†EHÀó\nµúÔ;À¸\'æ|†EHÀ:@RÔ;À!Îµ†EHÀ{c«Ô;À.{h‡EHÀ¤ß8ëÔ;À?lôO‡EHÀ[oã\ZÔ;À±/s ‡EHÀ*Á/\ZÔ;ÀT\ræñ‡EHÀû0=\ZÔ;À‡MNCˆEHÀ’ÓÓ<\ZÔ;Àâ»MzˆEHÀ˜zQ1\ZÔ;Àë#è±ˆEHÀÆ‡\ZÔ;À¦Ò³éˆEHÀeuU\0\ZÔ;ÀrG!‰EHÀfD™ÞÔ;À:28X‰EHÀÞ\r–Ô;ÀèÔ¡‰EHÀ±Ã1Ô;À+Êà‰EHÀ@B¤ÅÔ;À×ñ¬ŠEHÀë™eÔ;ÀzåÍYŠEHÀ‚wŽ%Ô;ÀŽÃNŠEHÀÃ¨Ô;ÀšÖAÛŠEHÀc\0\nÔ;ÀèüP‹EHÀ¤iÔ;ÀÏéc‹EHÀJg0<Ô;ÀKRÚ¥‹EHÀ„©BrÔ;ÀÉê_ã‹EHÀ¬˜Ô;Àâ\\4ŒEHÀèUÀÔ;ÀK*i#ŒEHÀ]ò$ìÔ;Àçþ@ŒEHÀÍ˜Ô;À…[ŒEHÀ„,ÚRÔ;À÷inrŒEHÀ„y¤ \ZÔ;À³êqºŒEHÀ³\'cò\ZÔ;ÀUïÜûŒEHÀ-6ÅÔ;ÀQ«:EHÀ±‚=–Ô;ÀçØzEHÀÊ™bÔ;Àp‹aÀEHÀA¿æúÔ;À5\\ùEHÀ4éÔ;ÀI,4ŽEHÀ\"`\\$Ô;ÀÀeêpŽEHÀ‰üü´Ô;Àz0­¯ŽEHÀ5‡B Ô;À ŒðŽEHÀ/çÀ« Ô;À-ÌÀ3EHÀ|¿ü Ô;ÀÅ:„ƒEHÀ|q[F!Ô;À4TøÖEHÀäCm™!Ô;Às‚>%EHÀrÍ\"Ô;Àf.xeEHÀÈ!”\"Ô;Àþå˜EHÀÈ\\µ*#Ô;Àö-ÄEHÀûõ#Å#Ô;À¶\'ìEHÀQ@^$Ô;ÀYü¦‘EHÀÓ/ýï$Ô;À-ù€E‘EHÀŠúg%Ô;À§BÁr‘EHÀÐÝ%Ô;ÀC*4¡‘EHÀncˆQ&Ô;ÀZ\n•Ñ‘EHÀ¾»Á&Ô;À@Ÿ’EHÀÍ_-\'Ô;ÀÏ\';’EHÀ×êî¹\'Ô;ÀMÝ–’EHÀ3~à.(Ô;Ày ‰ý’EHÀÑ›™(Ô;ÀñÚŠh“EHÀ¾ûˆ)Ô;ÀìµXÑ“EHÀ†)Ô;À7éj1”EHÀÍ=ï*Ô;Àe´2s”EHÀ8Ð‘Ž*Ô;À|Þ¬”EHÀ¶åZ +Ô;ÀÉã#ä”EHÀ˜­«+Ô;ÀZ}¸•EHÀdí$,Ô;À–æQb•EHÀÞÑ	¬,Ô;Àƒà Ù•EHÀMü\r-Ô;À6y&\\–EHÀ@ ±c-Ô;ÀB+Lå–EHÀ1öÆ-Ô;À7q{n—EHÀJzN.Ô;ÀÀÆñ—EHÀFÐÿ.Ô;ÀÆ-]˜EHÀ`æÙ¶.Ô;ÀH¡C˜EHÀr#ï.Ô;ÀHœHh˜EHÀ!t[%/Ô;Àí°1˜EHÀyV/Ô;À\r;€˜EHÀÔ§‡/Ô;À”y^j˜EHÀnØœ¸/Ô;ÀX•G˜EHÀÏ‘æ/Ô;À\"–˜EHÀ¬Ð\r0Ô;ÀG‹î—EHÀÙ4²*0Ô;ÀÝÓÀ—EHÀ×Ý=o0Ô;À$YøE—EHÀ8Ø”³0Ô;À Ë–EHÀ*³Ê÷0Ô;ÀiÛAP–EHÀÁüò;1Ô;À·2fÕ•EHÀC!€1Ô;ÀÎ‰Z•EHÀàó[­1Ô;Àƒyñù”EHÀé›%Ò1Ô;À—áY™”EHÀùû1Ô;ÀÀ³¼8”EHÀäÇ¨42Ô;À„Ø“EHÀKÅƒ‹2Ô;ÀgLXw“EHÀ¢WõÆ2Ô;ÀGá«Y“EHÀþ^ï3Ô;ÀÆØQ“EHÀz‹m3Ô;ÀÃÊ\nW“EHÀpáÈ3Ô;ÀGÀm`“EHÀæÉ4Ô;Àýu-e“EHÀÓïÞ4Ô;Àïäd“EHÀ6´5Ô;Àð;Îb“EHÀúŒ›5Ô;À}Õb“EHÀ ˜j\Z6Ô;À,\r„b“EHÀAoN™6Ô;À{=Ød“EHÀdŒ·R7Ô;À§çl“EHÀ8¢08Ô;À:(tx“EHÀß†Ã8Ô;ÀC°‹‡“EHÀGÊz9Ô;À]1˜“EHÀx\r¦2:Ô;À°]ª“EHÀÂ›ç¯:Ô;ÀŒ·“EHÀ	Ï,;Ô;ÀRé[Å“EHÀü§º¦;Ô;À=²âÖ“EHÀã\"®<Ô;ÀA&.í“EHÀU?”–<Ô;À¢‚Å	”EHÀäyN=Ô;À«z‚C”EHÀ7Ìø=Ô;ÀäMý…”EHÀÕ ™>Ô;ÀY*ÛÎ”EHÀm¶Ë4?Ô;À>Á•EHÀG„Î?Ô;À˜¶Tj•EHÀ—Ä>µ@Ô;Àwæ½è•EHÀAÐ»AÔ;ÀaÖl–EHÀ„†gBÔ;À\0Ûò–EHÀVDCÔ;ÀZv—EHÀŽlŸ0DÔ;À’8ó—EHÀABDÔ;ÀUÎl ˜EHÀ\r)5ñDÔ;À=XK˜EHÀµÃXEÔ;À8ô5q˜EHÀþ´­ÄEÔ;À	åA˜EHÀ©Ÿ\n8FÔ;Ào·¢˜EHÀ@–3ªFÔ;ÀS*ÿ®˜EHÀ±«tGÔ;Àh©º˜EHÀžbÁŽGÔ;À·ˆÆ˜EHÀ	B\rHÔ;ÀíìZÑ˜EHÀ«ÍKsHÔ;À\0õüÜ˜EHÀ´[IÔ;ÀêF4í˜EHÀ@ÍÍ°IÔ;ÀÀ!:ý˜EHÀà[kOJÔ;À÷ê²\r™EHÀ	@üíJÔ;À9\nC™EHÀµˆŒKÔ;ÀläŽ2™EHÀ\nÁK\rLÔ;À4¥ÿR™EHÀ(óyLÔ;À&| ‹™EHÀüd ÎLÔ;À`0]Ô™EHÀ©ótMÔ;Àuˆ!%šEHÀ…M’MÔ;ÀßIÙušEHÀîô~\ZMÔ;ÀJy6›EHÀ0W‰MÔ;ÀÊ/›EHÀÛ¼òLÔ;ÀÅŽQœEHÀã¢!ÔLÔ;Àþu,¥œEHÀ¼Ä³LÔ;ÀÃEN0EHÀ\nd™LÔ;À@µ+‹EHÀ<5wLÔ;À-ÃïåEHÀ3³TLÔ;Àè@žEHÀåë\Z8LÔ;À3öšžEHÀ¦•ø\'LÔ;À»ÓõžEHÀ;WX6LÔ;Àh\\KŸEHÀ%qøjLÔ;Àx€ûŸEHÀ§g½LÔ;À*IlíŸEHÀPZ4%MÔ;À~: EHÀ•ƒí™MÔ;Àù7‚„ EHÀgÑÙHNÔ;ÀÎŠå EHÀULíûNÔ;À\n 6¡EHÀXVùµOÔ;ÀÇ_|¡EHÀ‚RÏyPÔ;ÀÏ—¼¡EHÀÌ¢@JQÔ;Às°û¡EHÀ \"\"RÔ;À>¢EHÀ«šºSÔ;À5Ò¼€¢EHÀ\rh“áSÔ;À—Ãi²¢EHÀëçé¹TÔ;ÀÅ®°Ã¢EHÀMvƒUÔ;À›]º¤¢EHÀ+\"ïUÔ;À\'}€¢EHÀ‡ª>ZVÔ;À™stY¢EHÀ}á÷ÄVÔ;À»	1¢EHÀŽeá/WÔ;ÀêÇ£¢EHÀðßŽ›WÔ;À»i­á¡EHÀÿXÔ;ÀKÊ³¡EHÀ2Ã´¢XÔ;Àb¿	†¡EHÀ¾\'YÔ;ÀDç¯X¡EHÀŸ&¬YÔ;À¨\'\0,¡EHÀA¦3ZÔ;À¹>\0¡EHÀ5í—ZÔ;ÀW\nÇæ EHÀ„í[Ô;ÀëŒtÖ EHÀËÆ;r[Ô;ÀNX#Ð EHÀqžà[Ô;Àè)°Ô EHÀÆî†G\\Ô;À«¿÷ä EHÀ•J÷\\Ô;ÀX·\r¡EHÀpq‚¦]Ô;ÀØIÁ7¡EHÀå2U^Ô;À‚£éb¡EHÀãR`_Ô;ÀÍr¡EHÀ±_Ô;À†Åå»¡EHÀT÷öâ`Ô;À¹–½	¢EHÀj—bÔ;Àˆï#V¢EHÀqÌÜFcÔ;ÀÒÆÌ£¢EHÀÙt³tdÔ;Àµlõ¢EHÀ »eÔ;ÀÄµM£EHÀôjAKfÔ;ÀNMÉ‡£EHÀ,‡§õfÔ;À+Å£EHÀ h2žgÔ;À©Q$¤EHÀ’fÚFhÔ;ÀW½ûB¤EHÀAØ—ñhÔ;Àôºù¤EHÀÀÊ4jÔ;Àh°lï¤EHÀiœ7xkÔ;ÀØ²^¥EHÀ7Z¼lÔ;ÀÉš¡Í¥EHÀÖY\\\0nÔ;ÀJI<¦EHÀŸ_EoÔ;ÀmïÞ©¦EHÀõÐÈËoÔ;Àw 1Ö¦EHÀ\n-SpÔ;ÀÍŽ§EHÀe?ÛpÔ;Àÿ+x,§EHÀâaâbqÔ;À§sW§EHÀ¦f1êqÔ;À[ƒ§EHÀãF¾PrÔ;ÀF¥§EHÀž\r¶rÔ;À„ È§EHÀ¾FðsÔ;À+é}ì§EHÀ•\Z7|sÔ;À¿{¨EHÀ6ô²ÜsÔ;À¬i:¨EHÀ\Z÷YvtÔ;À©$¨EHÀÉ™†uÔ;À\"Ô®Ì¨EHÀ\"0Ø‘uÔ;ÀV¾©EHÀÑîvÔ;À?_hn©EHÀ¶€g˜vÔ;ÀIT°Â©EHÀ°U%wÔ;Ào†³\"ªEHÀœ®wÔ;À„ªEHÀÉ_6xÔ;À ÌæªEHÀUÙ»¾xÔ;À¹êG«EHÀ×ÅÒIyÔ;À*þ»¨«EHÀüú±yÔ;À¥8þí«EHÀ*äÄzÔ;ÀgVÝ1¬EHÀí’ŠzÔ;À’“`t¬EHÀÿâùzÔ;Àë-µ¬EHÀ”¢l{Ô;À”apõ¬EHÀfõ!|Ô;ÀVÊ:­EHÀ÷[ô|Ô;ÀÌÑJg­EHÀrÆÏÑ}Ô;À¬ö§‹­EHÀ¶e¥~Ô;ÀÇ—¸­EHÀpü\r[Ô;Àî’Íþ­EHÀW	¶Ô;À?4®EHÀ¼±˜€Ô;À9–·k®EHÀU-Ì\\€Ô;ÀÈœF¥®EHÀßé³ª€Ô;ÀK¯Wà®EHÀN`ö€Ô;À®T¯EHÀ¢Ö–FÔ;À.Vc¯EHÀ%ÃÔ;Ào?J¬¯EHÀª¦×Ô;ÀÓÃ½õ¯EHÀF€\0$‚Ô;Àø>°EHÀ¾¬“z‚Ô;Àë¬ƒ°EHÀ€©÷­‚Ô;ÀÂƒ¤°EHÀ?÷æ‚Ô;À¸\"ÀÁ°EHÀ³ôj$ƒÔ;À»¯Ü°EHÀ\"O+eƒÔ;ÀBÞôó°EHÀ Ö¨ƒÔ;À$4\n±EHÀÒ`Ê¬„Ô;À°ÒG±EHÀ½énÃ…Ô;À\rRän±EHÀ<ˆ0Ü†Ô;ÀªŠ?‘±EHÀôPAç‡Ô;À•q¸À±EHÀÁZÓÔˆÔ;ÀÃ·#²EHÀ‹UÃz‰Ô;À¸14]²EHÀ£QŠÔ;À¶ÑÜ¬²EHÀÔþÿÀŠÔ;ÀÞZý²EHÀ‚\"Pd‹Ô;ÀLÝL³EHÀˆÇÃ	ŒÔ;À4)›³EHÀö!ˆŒÔ;ÀûeÕ³EHÀ\"â¿Ô;À>X€´EHÀÉ}p…Ô;À¼Þ“I´EHÀŽÔ;ÀÔˆ¸ƒ´EHÀ®´G‚ŽÔ;Àæ6¾´EHÀ…\\\ZÔ;À‰àµEHÀV¼œ®Ô;ÀžÔ¿TµEHÀ1‘«AÔ;À/“0¢µEHÀUš¿ÖÔ;À|ž[îµEHÀŸ’êp‘Ô;ÀwB7¶EHÀ×(’Ô;ÀÉV\"|¶EHÀcY•í’Ô;À0LT´¶EHÀVD©¹“Ô;À¾7Èæ¶EHÀÍF„”Ô;Àßùm\Z·EHÀƒâuE•Ô;ÀŒs5V·EHÀÙÝ.–Ô;ÀÑéx·EHÀ8!T¸–Ô;À®“vé·EHÀóym—Ô;À÷<[7¸EHÀÒ0#˜Ô;À²S„¸EHÀèÜ˜Ô;ÀÍ¾ŒÍ¸EHÀB´í ™Ô;ÀD¹â¸EHÀ8•-j™Ô;À:Ï½ò¸EHÀ¡Áµ™Ô;À\\ø¹EHÀjrÑþ™Ô;Àn!¹EHÀgßµDšÔ;À¬V\Z-¹EHÀrýÔþšÔ;ÀW\n¹EHÀ r¥˜›Ô;À\Z[*ú¹EHÀ¨öœÔ;Àï•ÇpºEHÀy˜nœÔ;À\':ïºEHÀñX¬œÔ;À1øVs»EHÀçÍœÔ;À0”8ë»EHÀsDºÝœÔ;À@„Åc¼EHÀÀF}áœÔ;ÀöûžÜ¼EHÀ˜ü%ßœÔ;Àtç½EHÀ\Z)ÙyÔ;À´ÚØq½EHÀf@8Q{Ô;À`¼öÂ¼EHÀ²À_²aÔ;À+0²û°EHÀ]n×]Ô;ÀØ\n`c±EHÀ·Â%ZÔ;À™*½±EHÀ$t=@WÔ;ÀÓô­•±EHÀîÇŽ]TÔ;À¤r%u±EHÀk9]ƒQÔ;ÀR·j.±EHÀÙ¾ã·NÔ;À%DÂ°EHÀê =LÔ;ÀO¶\Z1°EHÀä°VeIÔ;ÀYÄ®|¯EHÀãMãéFÔ;ÀA‡^¦®EHÀ˜¯¦z<Ô;ÀRþTÀªEHÀH\\•ó:Ô;ÀB}€ ªEHÀXIÃ…9Ô;ÀJåÃn©EHÀóÆ38Ô;ÀÄ¯`¬¨EHÀü.\07Ô;À[t¶Ú§EHÀÀ ¡ì5Ô;ÀÊj@û¦EHÀ÷Ä3Ô;ÀuN#F§EHÀ©N’1Ô;À§Ë u§EHÀ=]ßZ/Ô;ÀR,\\‰§EHÀÚŒ¼\"-Ô;À$í.§EHÀâ	î*Ô;À)]§EHÀÇ<Á(Ô;ÀÉÌ§EHÀJ‰\Z &Ô;ÀæiâÂ¦EHÀXÜF$Ô;ÀÙçÎM¦EHÀ&ž ’\"Ô;ÀÚ:¿¥EHÀ|Õ® Ô;Àåš<¥EHÀû‘1åÔ;À÷/\ZZ¤EHÀÅqÉ_Ô;À†9Ù EHÀ„]\"ŸÔ;À$—p#ŸEHÀß¾)Ô;À2»,žEHÀã\\•Ô;ÀMžÒ!EHÀ[4ÝRÔ;ÀânüœEHÀ)ii@Ô;ÀÒJ¥ØšEHÀ÷ƒW`\rÔ;À±ž[Ÿ™EHÀ÷Á´Ô;ÀUÊ[˜EHÀÔz-TÔ;ÀÉ‚—EHÀa9-ÇÔ;Àzw’EHÀÿÝé‘Ô;À˜VI‘EHÀ\'Ä@u\0Ô;ÀRòê~EHÀž£›rÿÓ;Àn3ü©EHÀ?üþ¶ôÓ;À#&zEHÀ—×RòÓ;À§!1_EHÀ†\"îõïÓ;ÀbCè#EHÀf(¥¥íÓ;À¼¥ÒÈŽEHÀ#oBgëÓ;À3Ý¿NŽEHÀËïâ?éÓ;À‹Æ¶EHÀK1o4çÓ;Àd¿?EHÀÞúÍäÓ;À•X6ŒEHÀ‹¸àõâÓ;À¿*tP‹EHÀW^´?áÓ;ÀÛÑyrŠEHÀÜß¯ßÓ;Àœë‰EHÀ×j:GÞÓ;ÀÈTxˆEHÀEb+ÝÓ;ÀÑ›P`‡EHÀ$zýÛÓ;ÀÔ*\\9†EHÀgš] ÛÓ;À Àâ…EHÀ™Ë/QÙÓ;Àýž[…EHÀ4ŽÂv×Ó;À†hùš…EHÀÀô~”ÕÓ;Àa)€Ã…EHÀ€Ü­ÓÓ;ÀKÃçÔ…EHÀbºZÆÑÓ;À3/Ï…EHÀíÉzáÏÓ;ÀI.²…EHÀÉû¸ÎÓ;À¶6ù}…EHÀZ†-ÌÓ;ÀO3…EHÀoXBeÊÓ;ÀõÒ„EHÀŸÔ ÁÓ;ÀÔ\\Ç™‚EHÀthÊÕ¾Ó;ÀÐMñüEHÀAA£¼Ó;ÀÊ­äEEHÀ8ïéŒºÓ;ÀÕu€EHÀõfF–¸Ó;Àð< ŽEHÀX£Â¶Ó;À uK~EHÀrµÓ;ÀãU~}EHÀXÀw±Ó;ÀEpüzEHÀ:¶ Ú¢Ó;À¨ ì¢uEHÀÿš½;Ó;ÀYè°2tEHÀ‡}þ£ŒÓ;Àÿ³^†uEHÀ˜Ê]ŠÓ;À0Ù-JvEHÀ1­û‡Ó;Àÿ˜ñvEHÀN	Þ‚…Ó;À±hm{wEHÀªÄ›÷‚Ó;À1®æwEHÀL¢^€Ó;Àœð—2xEHÀ@$|¼}Ó;À©yž^xEHÀýX4{Ó;À‚qjxEHÀÿ’pxÓ;À.cûUxEHÀè§qÐuÓ;À¿›a!xEHÀüÍŸ:sÓ;ÀçÍwEHÀ\'Ú³pÓ;ÀºÎ~YwEHÀ©YÁ@nÓ;Àr	¤ÇvEHÀœâédÓ;À6…š§tEHÀXÙñcÓ;Àç\\•ktEHÀÕQýbÓ;Àb!Ì)tEHÀûü\rbÓ;À¿õ[âsEHÀe<¬’QÓ;À~¿ZµnEHÀ?écAÓ;À2áFNlEHÀks¬6Ó;ÀJë*·jEHÀ2[+5Ó;Àg¾ŒÙjEHÀLc2Ó;Ào‡kEHÀke´/Ó;ÀXÛ~kEHÀì--Ó;Àà1gîjEHÀ˜öo`*Ó;ÀNq³jEHÀ“\'Å\'Ó;Àõ\nXjEHÀÖ!8:%Ó;ÀÏ’àÜiEHÀ))«\rÓ;À¥Ç‘ÃdEHÀ¬A…„Ó;À¯¡YdEHÀ!up	Ó;À‚eÕcEHÀñ‹sÓ;Àu¬Â6cEHÀÚB/Ó;ÀN+€bEHÀSÎ’ËÓ;À\rQ²aEHÀÙ[tÓÓ;À&«¼bEHÀ\0kÍÿÒ;ÀÚåZobEHÀÙ½½ýÒ;À.õš©bEHÀcÙ¥ûÒ;ÀòÃËbEHÀÆ7™‹ùÒ;À,¥“ÓbEHÀÀ.ñq÷Ò;ÀÌ¹ÃbEHÀø©\\õÒ;À¹™bEHÀ%kOóÒ;À`\\WWbEHÀ^R-MñÒ;ÀwžùüaEHÀŸîÛïÒ;ÀqáL²aEHÀ+LlÞÞÒ;À\n›E^EHÀ±sÊEØÒ;ÀL¸hð\\EHÀ ©KÑÒÒ;ÀMÁ±Ö[EHÀuëB©ÑÒ;À¼Í<—[EHÀ`äé…ÐÒ;À˜„AQ[EHÀ‹ì´gÏÒ;ÀiØÛ[EHÀe{ÿœÆÒ;ÀÈ±\'XEHÀ¹+/I²Ò;ÀÎö\\EHÀl®r¯Ò;ÀýÝ°}]EHÀƒq€ˆ¬Ò;Àáø¸Ý]EHÀKßq‘©Ò;À»Q^EHÀŒêk”¦Ò;Àni÷#^EHÀ³\"þ™Ò;À•äY	^EHÀ&š}}–Ò;À¥bÂô]EHÀ´ÃKë“Ò;ÀÅ)ZÁ]EHÀ­ýìb‘Ò;ÀTŽ{o]EHÀ¤eÔèŽÒ;À†g¶ÿ\\EHÀ\\ŒÒ;À9Ïr\\EHÀ))½0ŠÒ;ÀG\'½É[EHÀàûû‡Ò;Àè§©[EHÀ(¸ÇÕ^Ò;Ày­gKEHÀlÚ¼Ò;À¿”iÇCEHÀž3¬ÇÞÑ;Àk¬pøDEHÀFµÜÑ;ÀíN.÷DEHÀ×ßðuÚÑ;À\nxnÛDEHÀ‡|^TØÑ;À¢d¥DEHÀN\Zò<ÖÑ;ÀauUDEHÀ\"ãŒ3ÔÑ;ÀÀý3ìCEHÀ?ýõ;ÒÑ;ÀÃ´djCEHÀ:ƒÓYÐÑ;Àäû÷ÐBEHÀä?¼Ñ;ÀSˆÃ¶;EHÀã~¤³Ñ;À“Y0>;EHÀ{Vqü°Ñ;ÀÎc>;EHÀO\n0ê®Ñ;À4d4Ó:EHÀúø‘ã¬Ñ;ÀÇˆx:EHÀXÁ3ìªÑ;À²+Û:EHÀ^Ò–©Ñ;Àú{9EHÀ4*9§Ñ;ÀÑ›ÚÛ8EHÀËQùƒ¥Ñ;ÀuFš&8EHÀ×g˜žÑ;ÀPœÇ5EHÀ¾r€ kÑ;À.[’\".EHÀÔGaÉhÑ;À PQS.EHÀ\\J¬±fÑ;À¿N>r.EHÀÙã@—dÑ;ÀÁÅ\'x.EHÀ®âÎ}bÑ;À¹Ze.EHÀ¢_i`Ñ;À¯œò8.EHÀK‡\\^Ñ;ÀtËBô-EHÀÁï[\\Ñ;ÀKOl—-EHÀê¾jZÑ;ÀYæ#-EHÀ¯\\ŒXÑ;À9†ÿ—,EHÀ÷@²eOÑ;À`\rP¨)EHÀ^\r2HÑ;À,õ¬\'(EHÀÕÑÓPEÑ;À`_´~(EHÀÚ^LdBÑ;ÀÐVt®(EHÀ§Õ\Zs?Ñ;ÀK¶(EHÀAÝãƒ<Ñ;Àn[È–(EHÀ7Æ\"%*Ñ;À;™»R\'EHÀ†3ËÅ(Ñ;Àƒ…\"(EHÀ¹žG\'Ñ;À\'–ýß(EHÀÃ¬%Ñ;À€¨‰)EHÀœ^õ÷#Ñ;Àº#/*EHÀ”4\'.\"Ñ;ÀAègœ*EHÀÜþQÑ;Àwõ\0,EHÀ^›‹^\ZÑ;Àöbúv,EHÀ	\r+Ñ;ÀÎ9àÐ,EHÀÕv™ëÑ;ÀU›ì\r-EHÀ®§¤Ñ;À–ö --EHÀApÿZÑ;ÀØ’»/-EHÀÒ`Ñ;À28-EHÀ/5…ÒÑ;Àè‰OÛ,EHÀw’\nÑ;Àhðw…,EHÀ3¯wÑ;ÀCBc,EHÀò2×ÞÿÐ;À¸é=S,EHÀªöûNþÐ;À«\' -EHÀ?¢üÐ;Àëö­Ù-EHÀ9ï–ÛúÐ;À\"mŠ~.EHÀ,Ð\'þøÐ;ÀÓ˜\r/EHÀ¸B>\r÷Ð;ÀÜ…/EHÀÐGIõÐ;À×Šæ/EHÀ-DÔþòÐ;À1/Ø.0EHÀž¶€èðÐ;À­f^0EHÀÏÿÌîÐ;ÀæÕt0EHÀo•…§ßÐ;Àö%$»0EHÀDÒ\nÉÐ;À·—·¨3EHÀ’èåÎÇÐ;ÀöÃ§U4EHÀCä´ÅÐ;ÀÇd[5EHÀ%ÃsÃÐ;ÀðKE6EHÀÉ+\rÁÐ;À˜E†7EHÀÔï‘Ž¾Ð;À‘x¾7EHÀ]ô»Ð;À¼™ÆJ8EHÀbô«F¹Ð;ÀPÞUµ8EHÀ*NãŠ¶Ð;À¼ÑOý8EHÀ½#„Æ³Ð;À`‰#\"9EHÀPÊ ÿ°Ð;Àxá†#9EHÀž§Q:®Ð;Àow9EHÀ«¸_ ˆÐ;À–66EHÀ8ñìŒ…Ð;À=eö5EHÀ{¸HƒÐ;À‡í‰—5EHÀk*õ€Ð;À\Z6§\Z5EHÀLW+~Ð;À]x›€4EHÀ¼@¯á{Ð;ÀW:yÊ3EHÀ[wZL[Ð;À4Lž¢(EHÀ.T°ðXÐ;Ào27¾\'EHÀÑnO¼VÐ;ÀB#þ»&EHÀ³zÜ³TÐ;Àïþž%EHÀI¢ŸÛRÐ;ÀHûÏf$EHÀ“‡{7QÐ;ÀÂ­Ä#EHÀU½¿7;Ð;ÀbaÎEHÀV.Ü9Ð;ÀG=~EHÀ&$µ8Ð;Às\rEHÀU Å7Ð;À¨©ž²EHÀÙsæ!5Ð;Àâª=EHÀdÓz¿4Ð;Àƒ+[EHÀn^Ko4Ð;À®e›EHÀþŽ“14Ð;ÀÂxÙEHÀCvyð3Ð;Àó\0mEHÀ÷ñ|ð3Ð;ÀüÑ³þEHÀiú14Ð;Ài™<’\0EHÀz›®4Ð;À\r¾6ÿDHÀØŸe5Ð;ÀÁ]¥ãýDHÀ\rÂ³V6Ð;À0é œüDHÀ:bþ~7Ð;Àï=CcûDHÀâå{7Ð;À¢Å¬÷úDHÀ|¬14Ð;ÀzÛ‘6úDHÀÀ[ÿ	/Ð;ÀÑ»ÃÛøDHÀ–½\\Ò,Ð;ÀÒË6øDHÀœà³*Ð;ÀQÊñx÷DHÀ½(ü±(Ð;ÀÆj£öDHÀW#òÏ&Ð;Àui·õDHÀoÎ%Ð;À­d¯ôDHÀû™¤a#Ð;ÀÈƒü’óDHÀk9Dé!Ð;À\'-?dòDHÀ	ÑÜŒÐ;ÀMspïDHÀ±®tÞ\ZÐ;ÀÎØ‚îDHÀ²dÃçÐ;Àœ%†ÐîDHÀc° æÐ;ÀÑ¬HïDHÀoôCßÐ;À=…³ïDHÀ¶©ñÕÐ;À?9‘ïDHÀÔjòÎÐ;À¹,ä\0ïDHÀóì‰ÎÐ;À˜æÊîDHÀ	îØÐ;Àh\n{îDHÀ#â=ò\nÐ;ÀØöîDHÀR4y	Ð;À®\"‰íDHÀHôwaÐ;ÀOÒ÷ìDHÀÇ/â¾Ð;À&~IìDHÀ²ÜõPÐ;ÀÆ9ÄìDHÀ¡ß&Ó\0Ð;À/Ä<\"íDHÀìuÄIþÏ;ÀQ©ybíDHÀÜâ1¹ûÏ;ÀÏ„íDHÀæÙÞ%ùÏ;À³-ˆíDHÀwÍ?”öÏ;À2¿8míDHÀBÆôÏ;ÀH4íDHÀTbóçÏ;ÀúêéÚëDHÀþ¾fåÏ;ÀÚžúëDHÀC—ŸéâÏ;ÀU•¨\nëDHÀ\0?{€àÏ;À¬äÉuêDHÀž5¥/ÞÏ;Àš¨iÄéDHÀC\"EûÛÏ;ÀI!Æ÷èDHÀäšOçÙÏ;À«xNèDHÀã÷×Ï;ÀÊ. çDHÀ1	M/ÖÏ;Àâ6„ýåDHÀ¤ì‘ÔÏ;ÀQ¿ëÓäDHÀLËA\"ÓÏ;À¡¸ì—ãDHÀÁááâÑÏ;ÀÁ¾KâDHÀ ´ŠÉÏ;À„¹¬ØDHÀà¿&ÉÏ;Àòôy–ØDHÀåî†‡ÆÏ;Àjx©ì×DHÀeÏÄÏ;Àü÷ ×DHÀ¨>þ©ÁÏ;À:±5ÖDHÀ.+v¿Ï;À|Õ\r+ÕDHÀD)p½Ï;À‚åÔDHÀ>$œ»Ï;À¤ˆœÅÒDHÀ:!ŠûµÏ;ÀÂ3ÍŒÎDHÀ ½Và¢Ï;À\\ˆe7ÊDHÀ\0ÈÇ§¢Ï;À}`m*ÊDHÀP4fo¢Ï;ÀçQ7ÊDHÀ_×27¢Ï;À£ŽÃÊDHÀ]$‚‹Ï;À!¡‘ÄDHÀ§mR}‰Ï;À°*-ÓÄDHÀ´æ÷o‡Ï;À¨‹³ùÄDHÀ¯Š^…Ï;À|”àÅDHÀ-‡MƒÏ;À»þ›ôÄDHÀ›flAÏ;Àí#	ÉÄDHÀðütÏ;ÀYš<WÃDHÀ<Kñ@rÏ;ÀA¡€ÃDHÀâ¯*spÏ;À}„ÁÂDHÀëÌö³nÏ;Àö¦åUÂDHÀžˆmÏ;Àe7iÕÁDHÀ\'‘òmkÏ;ÀÎ|ú@ÁDHÀ?ê íiÏ;ÀbL©™ÀDHÀBfÔ†hÏ;À¯¨à¿DHÀH1=gÏ;À°›I¿DHÀ1ÖfÏ;ÀN²þ>¾DHÀ®» eÏ;ÀqSY½DHÀÓ¬à&dÏ;À–qìg¼DHÀ_\\bÏ;À	mŒt¼DHÀÞ r\0`Ï;ÀßÙ…e¼DHÀ ùò]Ï;Àµœù:¼DHÀ£†îì[Ï;Àæ×Dõ»DHÀ4-tõYÏ;À\r\0•»DHÀëìðXÏ;ÀÚ)þ\Z»DHÀpt‹@VÏ;À0JˆºDHÀu±\n5BÏ;À»ª({³DHÀBm,?Ï;ÀÕþí´DHÀgŽt\r<Ï;À—ô@’´DHÀm\\ß8Ï;À»ú9ã´DHÀ«™Ù§5Ï;Àn>=µDHÀÐCm2Ï;ÀÓûµDHÀo\"a5/Ï;ÀUNtå´DHÀ”Ó,Ï;À1Çò•´DHÀ¤’o	*Ï;À|…Kù´DHÀ.¶Xþ\'Ï;ÀA-ÃBµDHÀ4\"µé%Ï;Àè“ÄqµDHÀ;`¾Ï#Ï;À§Hð…µDHÀÇ¸´!Ï;À2XµDHÀ9ÓêœÏ;À¨žY]µDHÀz”ŒÏ;À0­é µDHÀb†æ‡Ï;À>=HÊ´DHÀ˜ú’Ï;À8%Z´DHÀ–ºÏ;ÀT˜ž4³DHÀ›uèÏ;Àýk99³DHÀÀû Ï;À!å·g³DHÀ¦” TÏ;Àþ‹M€³DHÀÞ9…Ï;À#ôÌ‚³DHÀZž·\rÏ;À#€1o³DHÀ£îÏ;À!mŸE³DHÀ\0–”-\nÏ;À+c³DHÀ¨±°wÏ;ÀÅÁò±²DHÀÚ¤ ÐÏ;À%éH²DHÀ--ó9Ï;À*ŸÌ±DHÀüè¸Ï;ÀÊ,8<±DHÀèTMÏ;ÀÍš°DHÀúŒKü\0Ï;ÀÝwè¯DHÀP®iÇÿÎ;À|Ó+&¯DHÀãê°þÎ;Àkã<V®DHÀþ€ÏºýÎ;ÀÆêÂy­DHÀ\nÏð“ùÎ;À±•a©DHÀÐSˆhìÎ;Àä¨8¦DHÀdEžëÎ;ÀÄÅUå¦DHÀ0rT¡éÎ;À–Ø¨€§DHÀ=õr\ZèÎ;À\0Žj	¨DHÀÿ›íæÎ;Àax’~¨DHÀš+ÞÔäÎ;À»>ß¨DHÀ*d~ãÎ;Àgm²*©DHÀ\\Å!ZáÎ;À¥©]`©DHÀ/‘ßÎ;À²\0Ø©DHÀoóÅÝÎ;Àî•äˆ©DHÀËã[ùÛÎ;À—ëq{©DHÀ‘àm1ÚÎ;À7šW©DHÀzÁpØÎ;À¹,¢©DHÀd9ººÖÎ;À…}úÍ¨DHÀ1§ÕÎ;ÀØü<i¨DHÀ­¼{ÓÎ;ÀKt,ð§DHÀ½)~_ÒÎ;À“é’§DHÀ°QÍÐÎ;À­¤Òÿ¦DHÀ$^TÏÎ;ÀöjMY¦DHÀH­»÷ÍÎ;ÀHUM ¥DHÀ)ˆDºÌÎ;À¤:VÖ¤DHÀô?’žËÎ;ÀŠ‚ý£DHÀ†“÷¦ÊÎ;À°­@£DHÀ\\”{ÕÉÎ;Ài™Í#¢DHÀÐnÕ+ÉÎ;À8²\'¡DHÀÉh«ÈÎ;ÀÝ\0$ DHÀÜÜBUÈÎ;À…Ö\ZŸDHÀÍE*ÈÎ;ÀaÛažDHÀ|C*ÈÎ;À´ØÔ\0DHÀ-Ô¢ÈÎ;ÀÕ±‘3—DHÀñÉÅYÅÎ;Àpû(—DHÀçÉÂÎ;À”[ó–DHÀ‹I`Ý¾Î;À÷¨±”–DHÀÑ6‹´ºÎ;ÀK„ÿ•DHÀ÷©Æ|°Î;Ào\\f=–DHÀ¯Ñž®Î;ÀQÛ<6–DHÀLp‰¬Î;À™×ø–DHÀ;•„˜ªÎ;À™ÚÜ•DHÀ€Z\\²¨Î;ÀçS‹•DHÀ2%ßÚ¦Î;À-)\"•DHÀÓ&¸¥Î;Àh Æ¡”DHÀWnf£Î;À+I”DHÀÜã[Ð¡Î;À	Ú`“DHÀNšªV Î;À‡r¢’DHÀ%=Ò“Î;À©T³rDHÀ•ë’Î;À5ÞÿpžDHÀ\rš\'‘Î;ÀÊ}æ^ŸDHÀóÑœÎ;Àn«: DHÀ‰s#òÎ;À¶¼´¡DHÀœ­*ŒÎ;À˜Gµ¡DHÀÄz¿IŠÎ;À2sçQ¢DHÀ2×ÛRˆÎ;À/™ŸÖ¢DHÀU3¬I†Î;À¶)¾B£DHÀUÁü1„Î;À\Zxy•£DHÀß½´‚Î;À]27Î£DHÀÉ+ÏæÎ;ÀÞ‚ì£DHÀ˜bS»}Î;ÀÔCð£DHÀ–ŒM‘{Î;ÀÆ:SÙ£DHÀÇlyÎ;À}ƒæ§£DHÀc—ó\\Î;ÀÃß°DHÀ²S[Î;Àò\"ÝP±DHÀýÌF%YÎ;ÀOs(û±DHÀIùCWÎ;À?`‹²DHÀ\\ QòTÎ;Àœ¯X\0³DHÀ$à½RÎ;ÀÝIY³DHÀñ`LÎ;Àâ­[-´DHÀÒBÜ[-Î;ÀÒu{ÂDHÀs¨S +Î;À¸Å÷6ÃDHÀ^nÊ)Î;À)sfÜÃDHÀLcbÜ\'Î;À†ÆµjÄDHÀÔ¿úÚ%Î;ÀÑÝàÄDHÀy‹É#Î;Àz|\0>ÅDHÀYtí«!Î;À\'ÛrÅDHÀ´†Î;À5´¶ªÅDHÀ	ò[Î;À_G¹ÅDHÀ>Rš1Î;À8±­ÅDHÀý{ÅAûÍ;ÀýÜ:ÄDHÀâR\\¥ÝÍ;À	MþñÉDHÀ¤¬úÚÍ;ÀRuþbÊDHÀ“³Û@ØÍ;ÀçÀ†±ÊDHÀ4}i}ÕÍ;ÀôøÜÊDHÀÕäæµÒÍ;ÀÓ…ýäÊDHÀ$›íïÏÍ;À‚Q„ÉÊDHÀksªç¾Í;Ààå³ÉDHÀ%\ZI¯¼Í;À£Ñ`€ÉDHÀî£ºÍ;À£¥1ÉDHÀusa¸Í;Àl÷~ÇÈDHÀúÒœT¶Í;ÀÂNÁBÈDHÀ:_®^´Í;À½bv¤ÇDHÀ†Ý”ƒ²Í;ÀÉÛíÆDHÀ9\\Ç°Í;Ààð\\ ÆDHÀÅ,¯Í;ÀïR—=ÅDHÀƒä3·­Í;Àf0PGÄDHÀJþj¬Í;À\\Št?ÃDHÀ¢ô«G«Í;À‘(ÂDHÀÙPRªÍ;ÀW‡_ÁDHÀ‘²Ê‘¥Í;ÀwêJ ºDHÀû×ƒ‰Í;ÀzZ\"Ì·DHÀ	.›†Í;ÀÐ·DHÀ§ä!†Í;À÷€Gt·DHÀ5Â©…Í;À ­zf·DHÀßª»0…Í;Ài*£W·DHÀáÙº„Í;À¬`íG·DHÀìKºC„Í;Àl747·DHÀMéÍƒÍ;À¬x%·DHÀfÔË*bÍ;À7¿åí±DHÀûÞG¶^Í;À®ìM±DHÀ%uÌ\\[Í;ÀÈ¹„°DHÀÚj$XÍ;À‹A¹“¯DHÀIkõUÍ;ÀóÞ |®DHÀ½{ü-RÍ;À<DiA­DHÀwß¼zOÍ;À)*Mä«DHÀ¨\ZþLÍ;Àf¨ÄgªDHÀ¥á”¼JÍ;À¨¹€Î¨DHÀÖÇBºHÍ;Àa]f§DHÀA¥Ò?Í;À[¬pžDHÀî¡ÿò>Í;À²ÎƒDHÀŽ8>Í;À`O…œDHÀü¢=Í;À{ˆ+ƒ›DHÀh³û4=Í;ÀN½ézšDHÀóùÆî<Í;À|fn™DHÀ0lÜÐ<Í;ÀËí…_˜DHÀ—áÇ<Í;À*áÈM—DHÀ\rÍëÍ;À¨Wüf{DHÀ-Y#‚Í;À²6†yDHÀ¨§.Í;À;-ŠwDHÀ@!Í;ÀéãuuDHÀAT¤ÅÍ;À	ÒîkDHÀõ|“Í;À¹K×ÙjDHÀ¡¢(XÍ;À¡ˆºªjDHÀmÈjÍ;À{G	jDHÀ1©{ËÍ;À\Z,WjDHÀ<~PýÌ;À‡Ûþ%hDHÀ/øÃöûÌ;À‚MlqgDHÀkÔ²úÌ;ÀœŠœ°fDHÀº¾i…ùÌ;ÀgÓ_äeDHÀU{\Z^êÌ;ÀsgÉcDHÀÉ/èÌ;ÀÞQ‘gcDHÀˆ¸#ßåÌ;Àß[çbDHÀÇoðÀãÌ;ÀjKåIbDHÀ|hZ¿áÌ;À²r’aDHÀ™¯åÞßÌ;À°½`DHÀÔ…<oÞÌ;À¾¢ønaDHÀÑæ5æÜÌ;À”hßbDHÀv¸FÛÌ;ÀQ¿”›bDHÀâùh“ÙÌ;À=[cDHÀ?g°Ï×Ì;Àj¹ŽwcDHÀIÍªþÕÌ;ÀW¯BÅcDHÀc6§#ÔÌ;ÀB´¦ücDHÀyÞBÒÌ;À½åUdDHÀa7]ÐÌ;Àèº\'dDHÀÑªxÎÌ;À uÑdDHÀ™d[ìÌÌ;À*_×ªdDHÀÞÇ2LËÌ;ÀÇ–)eDHÀ%›ÉÌ;À­¥“eDHÀ¶´ÛÇÌ;ÀÓ4ÛéeDHÀ;ÅQÆÌ;À%þ+fDHÀIQó>ÄÌ;À@úVfDHÀ³Ð¿gÂÌ;Àî¬&mfDHÀõ«æŽÀÌ;ÀÌL|mfDHÀ“¤}ö¾Ì;Àæ§SdfDHÀònØº¼Ì;ÀCÌndfDHÀ½¥ºÌ;À²\rY~fDHÀÙLÑL¸Ì;À^’ç±fDHÀAÂ!¶Ì;ÀÓÅþfDHÀU.x´Ì;À÷•rdgDHÀ7£sõ±Ì;À[âGâgDHÀ¦úµL«Ì;À´€BRlDHÀù°¢Ù©Ì;À»Ÿ`5mDHÀ\'?ÝE¨Ì;ÀßnnDHÀfæC”¦Ì;ÀŒT\0ÃnDHÀò(ëÇ¤Ì;ÀÖ®joDHÀè+ä¢Ì;ÀîùûoDHÀ‰Å:ì Ì;À(¯ÖupDHÀÑï³f—Ì;ÀÛE%rDHÀÝÈM‘Ì;À¯äÔuDHÀó%sÌ;ÀiÂ£uDHÀõ¦€ÈŽÌ;ÀÀ!*vDHÀg¿ÉsÌ;Àø¼œ§vDHÀ4ÈZõsÌ;À®2ˆDHÀ¡ðØqÌ;Àñ»4€DHÀTëŒ¤oÌ;À-Ð&É€DHÀ˜ÆM^mÌ;Àó‘DDHÀoxËkÌ;Àbí;¦DHÀÍ¼ÀOÌ;À ‡\\x…DHÀFœ\"MÌ;ÀR\nQÅ…DHÀU6C{JÌ;ÀÃÊäñ…DHÀuY¡ÏGÌ;ÀÖÒÄý…DHÀ¯$EÌ;À§\nÛè…DHÀEŠcBÌ;ÀJaN³…DHÀ.O«ä?Ì;À4„‚]…DHÀ‹úé&Ì;ÀáEäŽ€DHÀe´¡¨Ì;À‘MÞ€DHÀ4dÌ;À†$â€DHÀÃ, Ì;Àµ{è€DHÀ\Z»÷ÜÌ;À©cJñ€DHÀï3¯¼ÓË;À B_ŒDHÀ²¾¿ÑË;ÀEÚ¨bŒDHÀ/e+\\ÏË;Àt±[ŒŒDHÀù®D#ÍË;À¹&šŒDHÀ{—fêÊË;À€ìì‹ŒDHÀ\"ìµÈË;Àé-ÌaŒDHÀne\'ŠÆË;ÀeŒDHÀ¸ÛYkÄË;À3T»‹DHÀmH«]ÂË;Àu=C@‹DHÀ›ô!eÀË;À·Ô«ŠDHÀÑ´š…¾Ë;Àl‹+ÿ‰DHÀK]ÁÂ¼Ë;À‚!š;‰DHÀi|8²©Ë;ÀÁ\'\'0€DHÀÒ­…“Ë;À â‹DHÀXa}»‘Ë;Àðy´cŒDHÀdÑË;ÀH]#!DHÀMóÊË;Àx™ÄDHÀ	Á‡ª‹Ë;À˜¹LŽDHÀû¨5w‰Ë;ÀšÙ^¸ŽDHÀ{ûÁ4‡Ë;ÀA¤DHÀÎfè„Ë;Àe¯â6DHÀ·¡â•‚Ë;À©	²HDHÀvãYC€Ë;À»ì;DHÀ3	¡eË;Àù»xùDHÀ?zcË;Àæ^	ÒDHÀ±NöZaË;ÀYRSDHÀª+ÝG_Ë;Àþ%Ñ4DHÀ‚Y”D]Ë;À…-ÀŒDHÀÓöhZË;À·EËŒDHÀ ÿ¿WË;Àrw|ŒDHÀ‹YãÔUË;À:¦$ÆŒDHÀmïáSË;Àê2úŒDHÀAÐKéQË;ÀÅDHÀ<ô	îOË;Àö»ÙDHÀgŽ=Ë;À¡˜òÿŒDHÀ\0z¬­:Ë;ÀŒNëŒDHÀE‹1F8Ë;ÀGÃ×´ŒDHÀ\'Áê5Ë;À´,È]ŒDHÀiíâ 3Ë;ÀŽÉ­æ‹DHÀ<Cõm1Ë;À© P‹DHÀcÆ».Ë;À÷¸GŠDHÀCSÚ,Ë;À¬1uá‰DHÀ\ZkC+Ë;Àtx+‰DHÀÍÅ¸i)Ë;À{H_ˆDHÀË\r×à\'Ë;Àƒ˜Æ‡DHÀˆ„{&Ë;À]#$Ž†DHÀŠb<%Ë;Àœì(Œ…DHÀ¬\0Í%$Ë;À´¼{„DHÀŒzÑ9#Ë;Àïß^ƒDHÀA‰-z\"Ë;ÀRh®7‚DHÀ§Kè!Ë;À)ÙTDHÀ¸e=…!Ë;À~ÓDHÀã®¿Q!Ë;Àzè\'š~DHÀ€3N!Ë;ÀyJë_}DHÀµm~)\"Ë;ÀÊŸà8pDHÀ´wWX\"Ë;À¸CªônDHÀ&W7º\"Ë;À*¶´mDHÀXN#Ë;À¢ylDHÀ8Û$Ë;À5ôÕGkDHÀIÖI%Ë;À­‘!jDHÀªÙœ*&Ë;Àù´»iDHÀW†;x\'Ë;À«—ûýgDHÀ*é‚î(Ë;À¼ßðgDHÀÕÉ}Š*Ë;À\Z`‘!fDHÀ¬êH,Ë;À½ «ReDHÀÖcB&.Ë;À¸àšdDHÀÈ4¿0Ë;À?ü¥ûcDHÀP{d.2Ë;ÀO=vcDHÀJkøBË;ÀÓOÇÆ_DHÀ”®#ûEË;Àï	1_DHÀÁ„IË;À1_/¾^DHÀª\\™3LË;ÀOûÅn^DHÀXW_OË;ÀÐ~[C^DHÀw¦ŽRË;À²5<^DHÀì^mLRË;À\0^ª\"^DHÀ…ìÑRË;ÀŠ²K\n^DHÀï›äÃQË;ÀŒÄó]DHÀLÊoRË;Àðna–MDHÀ\Z”<èË;À‚°sMDHÀÊAj~Ë;À1{¢PMDHÀŒÓùË;ÀÏ®7-MDHÀ’ÏõÅË;À8ÊêûFDHÀ@¦¤ùÊ;À¯v?CDHÀ¬}îo÷Ê;À³3Ÿ¹BDHÀÌ¦TõÊ;À=ëBDHÀ}IïVóÊ;ÀòsXADHÀ‡7L{ñÊ;À»è@DHÀ¶×èÊ;À©æKÃ;DHÀ¥‡àÔÞÊ;ÀŸ]º9DHÀ?]&ˆÏÊ;À×ÔPW6DHÀ,9–ÍÊ;ÀœkRÛ5DHÀ„{z¸ËÊ;À[O[H5DHÀv¯BòÉÊ;À•órŸ4DHÀßÿ¿FÈÊ;ÀŽ Èá3DHÀ›Æð¸ÆÊ;ÀÑÕ®3DHÀfU\Z­Ê;Àß(l$DHÀíÇ„¯«Ê;Àï“ÊŠ#DHÀQi:gªÊ;ÀÕD™\"DHÀFSºC©Ê;À_B™!DHÀ‘G¨Ê;À?†‡Œ DHÀ9àr§Ê;À\ZïtDHÀ†M¼È¦Ê;ÀÖ\ZgTDHÀ@ÇI¦Ê;ÀjRí,DHÀÅáö¥Ê;ÀÇÑ‹\0DHÀ»QžÐ¥Ê;ÀíQUÑ\ZDHÀ\r\rT‡¥Ê;À˜ª~RDHÀà.Þå…Ê;ÀÑ‹½WDHÀÓgptÊ;À1þ¶CDHÀÕûÌlÊ;ÀãNtDHÀ«¡©jÊ;À©uuDHÀ´°ÎXgÊ;Àð’TDHÀ):¶§dÊ;ÀŽÒ“DHÀ-bÊ;Àã.­DHÀÝÁ¦q_Ê;À¨¤â\'DHÀØ‰Óö\\Ê;À–iö‚DHÀ’¤ö—ZÊ;Àâe”¿DHÀJ—¥DÊ;À\0’ÕòüCHÀÈ`vûBÊ;À\níLüCHÀ6ˆLnAÊ;ÀøãLûCHÀü•×\0@Ê;À*”:ÁúCHÀ¸\0¶>Ê;À¹r{àùCHÀ¿û©=Ê;À\nÉãïøCHÀ‡!¬/Ê;Àž2{õCHÀ+ÒRk,Ê;ÀMþcÃôCHÀZü[Õ)Ê;ÀJ`íóCHÀP1`\'Ê;ÀLV¸ùòCHÀçª8%Ê;À_ŽôþñCHÀVN÷ÂÊ;À‚6XñïCHÀ¬£šÊ;À»¤…ïCHÀ0^»…Ê;À!®‚þîCHÀE=‹ˆÊ;ÀG8	]îCHÀ#/§Ê;À”ë…¢íCHÀäp‰åÊ;ÀzÐìCHÀ>þ:G\rÊ;Àö–—èëCHÀ!¦›ÏÊ;Àï{½ìêCHÀÍ·ž	Ê;Àr¡‹vêCHÀåkˆƒÊ;À]—ÛãéCHÀ1Øž‚Ê;Àƒ~ë5éCHÀ‡lS Ê;À‘4nèCHÀÅ\Z¼àÊ;À‰îgŽçCHÀ>”£G\0Ê;Àøñj˜æCHÀÄØþÉ;À2SŽåCHÀçµp–ýÉ;À>oaräCHÀo-„üÉ;ÀñÅýFãCHÀ	×ê‘ùÉ;ÀìËL©ßCHÀ½€îâøÉ;À|šêÞCHÀfUøÉ;ÀÖê5ÞCHÀ=*÷É;À[^ÑŒÝCHÀu$öÉ;À2¶ÇðÜCHÀ\"‰`õÉ;À²T*cÜCHÀ®bÐóÉ;À¾z5åÛCHÀzìÖ‡òÉ;ÀŽqxÛCHÀÁ†tÂÐÉ;Àí«òhÑCHÀ,SÏÉ;ÀûÅœÑCHÀÛøöSÍÉ;ÀÈkÈ¹ÑCHÀõÁ°–ËÉ;ÀÂ˜àÁÑCHÀÕóÖÙÉÉ;À¡ÅI´ÑCHÀ+¿ ÈÉ;À‘ÑCHÀË·nÆÉ;ÀaØ XÑCHÀK­ÇÄÉ;À£>ÑCHÀoÜÉ,ÃÉ;À;ä‹©ÐCHÀ0~#£ÁÉ;ÀÇD4ÐCHÀÝï-ÀÉ;À?H¬ÏCHÀ¢3Í¾É;ÀCUÏCHÀˆZ†½É;ÀY5jhÎCHÀØééZ¼É;À£uõ®ÍCHÀñT!M»É;À\\ô¢çÌCHÀAö_ºÉ;À”)ñÌCHÀp¯`’¹É;ÀLv5ËCHÀî1ºè¸É;ÀÊCÝMÊCHÀ‚9²É;À{+Áµ¿CHÀ±cA!É;À„¶X¦¦CHÀÇÞSÁ€É;ÀNNt¦CHÀŸb€É;À(B¦CHÀ`\'€É;À£jÎ¦CHÀô5WÉ!É;Àú¯qCHÀÅÐ`!É;À}âtqCHÀˆåîù É;ÀOî™8qCHÀjñ·” É;ÀÆÐÍûpCHÀ^*\ZhÝÈ;À	‹,\0HCHÀ„ÉÜÈ;À4…ùœGCHÀ™^_/ÜÈ;Àòƒ–7GCHÀ\'Ã™ÛÈ;À™ÐFCHÀœnÒÒyÈ;Àøc5kCHÀ?2¯uxÈ;ÀaC*c\0CHÀd¥6wÈ;À‡×“OÿBHÀÊvÈ;ÀØç{1þBHÀùØéx<È;ÀaðÙÀBHÀG\\€&4È;À@¶¹BHÀšÑ®þ1È;ÀÜ°Âý¶BHÀU|<y!È;À|S’q§BHÀˆ(¨ È;À%z^¢¦BHÀÁ‘gçÈ;À	%Î¥BHÀ #¿7È;À~yQõ¤BHÀ%»Â$È;Àã¯f…BHÀ0öÈ;À¨îŠL…BHÀ&¦hýÈ;Àô÷V2…BHÀ5…\ZêÈ;ÀJ.…BHÀ…ÕˆõÇ;ÀFmBHÀNcÔÕôÇ;À”Ãñ<lBHÀ6(<ôÇ;Àëå.kBHÀéÐ»óÇ;ÀRƒ¦jBHÀ<í:ÜÇ;Àôr\\Ï1BHÀG\"ÜÇ;À‰Ñ¾‡1BHÀnºæÜÇ;À^Âé?1BHÀ¾kèÛÇ;Àºà÷0BHÀoOèKËÇ;À€\"D\0BHÀj¥eòÊÇ;À?…IÿAHÀê®·¹ÊÇ;À·ÔÒýAHÀgÏ¢ÊÇ;ÀÈYk–üAHÀ¥Ì4ÉÇ;ÀWT?]¸AHÀÝ×9\ZÉÇ;À9Å±·AHÀ{ƒ\0%ÉÇ;ÀQþe·AHÀü…9ÉÇ;ÀëõN[¶AHÀb\'ÛØÐÇ;ÀôÐxƒAHÀw×¢ÑÇ;À•AHÀa…tÑÇ;À¢× €AHÀûiãÑÇ;À‚±­~AHÀ÷PsÛÇ;À´~¤aAHÀ ÜÞÜÇ;À¹Z0ó_AHÀ~TyÜÇ;ÀHzL¼_AHÀ(ÜÇ;À¢E……_AHÀÿ¤º<ÜÇ;À§CÜN_AHÀ¸:RÜÇ;ÀÊD±_AHÀ¸hÜÇ;ÀM§â^AHÀœx5€ÜÇ;Àž¿¬^AHÀ“-Þ¯åÇ;ÀÎEõ\rJAHÀR©±æÇ;Àš`AIAHÀ¾ÕƒæÇ;ÀF&wHAHÀe9çÇ;À®Ã˜¯GAHÀ^éÊpÈ;À¥;{vAHÀÿ‚m\rÈ;ÀR(˜ AHÀ¦0ŽÈ;À˜ÇÓ\rAHÀ$HÑÈ;À‰E8‘AHÀ/ët#È;ÀmEú@HÀÂŽ(4È;À×Ö´ê@HÀK58È;À?kïæ@HÀŽ†\\S;È;À×Õº@ä@HÀü1ðÇ>È;À§ã»´á@HÀçA-ŽBÈ;ÀavNß@HÀ?zª\"[È;Àr#ÔÆÐ@HÀhµÄ=^È;À2¢§Ï@HÀ(C.™aÈ;À®k‘Í@HÀàA.eÈ;Àëí$7Ì@HÀ‰ÒæõhÈ;À¹Ë@HÀ|0¢èlÈ;À3ÑÊ@HÀGu¢þpÈ;ÀŠàIÉ@HÀg˜Ð/uÈ;Ày¤ªµÈ@HÀzÀßsyÈ;ÀMGãWÈ@HÀ³]Â}È;À)}i0È@HÀÃ‚È;Àu‹?È@HÀº¢†\\†È;À´>+…È@HÀ›j)—ŠÈ;Àé¿\0É@HÀWPLºŽÈ;Àš%R±É@HÀ.B¾½’È;À{‡•Ê@HÀ?îŒ™–È;À¬Î™«Ë@HÀ|uZi«È;Àr0Ò@HÀ’ÏÁ¬ÐÈ;À·åÈ÷Û@HÀ¹ß	HêÈ;ÀWÛGTÞ@HÀw!™ÜêÈ;ÀNžÉbÞ@HÀ—¥pëÈ;ÀÙŸÜrÞ@HÀ¸”!ìÈ;Ààl„Þ@HÀ’ØÉ;ÀˆUçã@HÀn‡J\"É;À8‡éã@HÀø?º3É;Àµ¾ëã@HÀ*¶\'EÉ;ÀQaûíã@HÀÿ}0EÉ;ÀV©™Õé@HÀåÕ7ø^É;À†ûç@HÀƒgà`É;ÀðÙÌ`ç@HÀ.üËbÉ;ÀE·iTç@HÀ³ØE¶dÉ;ÀÆã\\ç@HÀá¸a¦”É;À#‰é5é@HÀ{œ–É;ÀNæETé@HÀS\ZŒ˜É;À9%eˆé@HÀ”?bsšÉ;À›÷Ñé@HÀÔ0ÑÉ;À‰Œ–`ó@HÀKkÏÉÞÉ;ÀSÇŠ7ò@HÀ{Æ>ÖàÉ;À€Töò@HÀe¦¦åâÉ;Àáá_ò@HÀ?‹ôäÉ;ÀSãÕò@HÀÛÍ‚ÿæÉ;ÀIW>Eò@HÀ/néÉ;ÀÂìV„ò@HÀcÜÔûêÉ;ÀzµÚò@HÀ™Ò¦ìÉ;À5‹.ó@HÀ‰–õŒõÉ;À×¶}ð@HÀk)hr÷É;ÀÆtøï@HÀ/»iùÉ;ÀNÜåŠï@HÀ|yoûÉ;À2õ*5ï@HÀ¾M€ýÉ;ÀVÚ÷î@HÀo:ã—ÿÉ;Àø_Óî@HÀªÆ<³Ê;À.üÇî@HÀ9<iÎÊ;À…ÅÂÕî@HÀö2³åÊ;À¿¿›üî@HÀ\\lõÊ;À#¡B<ï@HÀ­¹òù	Ê;À}VG”ï@HÀK`ÆÊ;À<RÃéð@HÀ/¯»ZÊ;ÀÃ»¬½ð@HÀ', 1, 1, '2019-09-02 21:34:25', '2019-09-02 21:34:25');
INSERT INTO `geo_referencia` (`id`, `idCamada`, `idReferenciado`, `poligonais`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`) VALUES
(2, 1, 643, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0q\0\0ã¸…´u¥;À‹9§»n;HÀ,D¹-u¥;ÀNÄX`;HÀ¤^áâu¥;ÀÂû+¡`;HÀ/nšÝv¥;À qa;HÀ\rSRÙw¥;À†Ä\0ia;HÀ:@×x¥;ÀÐúËa;HÀXVÍ×y¥;À‚Z_\'b;HÀ£P]ßz¥;ÀYQ}b;HÀðwlë{¥;Àš²Ïb;HÀö¨ù|¥;ÀÚ#¯c;HÀ<j½~¥;À\rjVnc;HÀ¦•Ø¥;ÀÆn½c;HÀ“½f%€¥;ÀJËÛ\nd;HÀÑùg5¥;À~ÉWd;HÀà^ÜD‚¥;À¤@a¥d;HÀ¥ÄRƒ¥;ÀeÍôd;HÀSä°`„¥;À…ŒáEe;HÀ¬sm…¥;Àéf˜e;HÀÑ‘v†¥;À€Aîe;HÀ<Êy‡¥;ÀÚTIf;HÀösˆ¥;À ¼ƒ«f;HÀå)c ˆ¥;ÀŽ¼¾f;HÀÇHÐÌˆ¥;Àï»™Ðf;HÀªg=ùˆ¥;ÀO»$ãf;HÀŒ†ª%‰¥;À=»¯õf;HÀo¥R‰¥;À+»:g;HÀp^Š¥;Àö§$`g;HÀ6¤ãŠ¥;À¸|9¹g;HÀ–Ëñ©‹¥;À¿Òh;HÀŠmqŒ¥;ÀÌFGlh;HÀÛg9¥;À-ðñÄh;HÀœÌ4ø¥;À¹?i;HÀªÀ˜¸Ž¥;À!rÚhi;HÀ£™z¥;ÀYŒý¸i;HÀB)>>¥;À ‘êj;HÀE‘¥;ÀO„¡Uj;HÀ–ï¾s’¥;Àñ1ãj;HÀMˆ¨æ“¥;À>–\"nk;HÀhê:\\•¥;À¤Éök;HÀ4gÔ–¥;ÀP*}l;HÀ@€O˜¥;ÀÆ‹\\m;HÀÊy™¥;À·¼Ènm;HÀã!\rÑš¥;À‘÷Ûm;HÀúŒœ¥;À‘ÁÏFn;HÀ\rÈT¥;ÀôŸç²n;HÀf¨e•ž¥;Àƒ o;HÀ.Ïr›Ÿ¥;À ßÆzo;HÀÅ	Ž  ¥;À$Á\\Öo;HÀŸÜé¤¡¥;À;J›2p;HÀ~Ï¸¨¢¥;ÀÝQp;HÀ\ni-¬£¥;À¸yLìp;HÀÛé:3¤¥;À€’& q;HÀ8×~¶¤¥;À/Ë,Wq;HÀX¼Í8¥¥;À¯6\0q;HÀr$ü¼¥¥;ÀéAÅq;HÀŠ˜ÞE¦¥;À‰ô’÷q;HÀë<O§¥;ÀËzzKr;HÀñŽ\"_¨¥;À•”¡˜r;HÀTÿq©¥;Àª½âr;HÀ^+B„ª¥;ÀÍ\"„-s;HÀS[’«¥;Àhª|s;HÀ\Zc*¬¥;ÀuÎÝÏs;HÀ»@Í¦­¥;À‚Þ=$t;HÀaàí®®¥;Àä\\zt;HÀ;46µ¯¥;ÀG·Ñt;HÀ’/P¹°¥;Àp¸i+u;HÀÚy]½±¥;ÀüÄñu;HÀYýµ²¥;À“‡\0v;HÀ7•ó«³¥;À`ž(qv;HÀô¨´¥;ÀÀ©äÜv;HÀª?ò²µ¥;ÀßG¿;w;HÀ6­Ø¶¥;Àd ¦–w;HÀˆþ·¥;ÀÑykñw;HÀ¾}q$¹¥;À*·!Lx;HÀ­‡WJº¥;Àã:Û¦x;HÀji(p»¥;Àÿgªy;HÀ+l&{¼¥;À <Ty;HÀ]Õ%†½¥;À;»Ë¦y;HÀÃÐ‘¾¥;Àqgùy;HÀjõ›¿¥;À{DLz;HÀ{;¬¦À¥;ÀCûžz;HÀ™xt¬Á¥;À‡ žùz;HÀ§«â¦Â¥;ÀFrT^{;HÀÍØî›Ã¥;ÀÅÙÇ{;HÀK‘‘Ä¥;ÀP¦é0|;HÀ/4ÁÅ¥;À,¢?”|;HÀ“K¥¯Æ¥;À.¨û|;HÀþMÕÇ¥;Àw±*`};HÀfÓ\'ûÈ¥;À]¹(Ä};HÀqpÊ¥;À·Ó*~;HÀG¿ò=Ë¥;À‚Ž”~;HÀ^_Ì¥;ÀÒ‚Oë~;HÀ¢ŸÔõÌ¥;ÀÜÿvD;HÀ\0—äÏÍ¥;ÀkÄ,ž;HÀg\\«Î¥;Àe	÷;HÀÞåˆÏ¥;À²#¦M€;HÀ¸ˆ<êÏ¥;ÀÐ	Ÿr€;HÀ.¥KÐ¥;Àh¤—€;HÀb\0­Ð¥;À…Nn¼€;HÀ‘>·Ñ¥;À/c+á€;HÀpÑ¥;Àþ=»;HÀƒªøÔ¥;À·ïü;HÀÉþd¯Ö¥;ÀÁvò‚;HÀöÓNÙ¥;À5¬Ñèƒ;HÀSÞCîÛ¥;À÷+ß„;HÀ¸Þ¥;À’gÕ…;HÀÕý\0ß¥;À#Þ1†;HÀÀá’à¥;ÀeŸì‹†;HÀàRg˜á¥;Àœ€„ä†;HÀz¢žâ¥;À\n}<‡;HÀ„¶Ÿ¤ã¥;ÀÜ™­”‡;HÀÃVªä¥;ÀƒÑóì‡;HÀ}±°å¥;ÀÓ¹Dˆ;HÀœÑA·æ¥;Àû‘œˆ;HÀÂa¾ç¥;À†Wíòˆ;HÀÏÎäÅè¥;À¢‰rI‰;HÀO\"Ðé¥;À‡û[œ‰;HÀ@¹“ßê¥;ÀñÎóê‰;HÀ²ltïë¥;À•{¬8Š;HÀý«üì¥;À\rxøˆŠ;HÀ0—³î¥;Ài:JßŠ;HÀ¿.ôï¥;ÀF:‹;HÀö^}	ð¥;À8pp–‹;HÀbº»ñ¥;ÀíÝ”ò‹;HÀ«Ôò¥;À*²šNŒ;HÀ_@\nó¥;À\rO\"ªŒ;HÀÂÞô¥;À›Íˆ;HÀa õ¥;À6Óî`;HÀSé+ö¥;ÀLT¼;HÀã…8!÷¥;À9\"¹Ž;HÀ\rûE%ø¥;ÀLAsŽ;HÀ•\"¸\'ù¥;ÀðãÎŽ;HÀš*ú¥;ÀÊô(;HÀxÜ—,û¥;À¥/Óƒ;HÀ¿oE/ü¥;ÀÖZ†Þ;HÀ˜ÏF2ý¥;À*àò8;HÀY2(8þ¥;ÀO~Ð;HÀû\rBÿ¥;À ¤Óä;HÀ”Ú_N\0¦;ÀñÂ€6‘;HÀYS‹[¦;ÀýG\\‡‘;HÀ{úg¦;À¢êØ‘;HÀ1s¦;À|‡Y+’;HÀ6~¦;ÀÏÏ}’;HÀ¹/Ž‰¦;À…zÐ’;HÀ”o•¦;Àá¦!“;HÀkS\"¢¦;Àûwur“;HÀ™×°¦;ÀOÜºÁ“;HÀï´f¿	¦;ÀìN‰”;HÀ*D_Ï\n¦;ÀLž\\”;HÀQáUß¦;À¶z¶©”;HÀ„éî¦;À‹¿÷”;HÀÅ+]ý\r¦;À3“:F•;HÀÞ½¦;Àd|D••;HÀzë§¦;Àc3Ïä•;HÀ™E\'¦;Àçoü4–;HÀ¯Ù·3¦;Àéí…–;HÀ¹ª?¦;À_)¤Ø–;HÀ!\"H¦;À:±¯-—;HÀÏÝúN¦;ÀZÔ„—;HÀ“æÞS¦;À$þÕÝ—;HÀ	ûW¦;Àüvx8˜;HÀÌ»ÁY¦;ÀÛÞh”˜;HÀœ$Æ[¦;Àñ}èð˜;HÀz¡,]\Z¦;ÀmMêM™;HÀ¶¡^¦;À}Fa«™;HÀ8…^¦;À5a@	š;HÀ›w_¦;ÀmÚÄgš;HÀ€Vó^¦;À¼ÀÆš;HÀ²6l^¦;Àî&›;HÀË] ¦;ÀZº…›;HÀ±s\\!¦;Àêeˆå›;HÀ2hfY\"¦;ÀZ6eHœ;HÀŒR#¦;À ê¹®œ;HÀÜ„wI$¦;À¼!;HÀ”PwB%¦;ÀŽâ7|;HÀÌê@&¦;Àª•—Þ;HÀa“üC\'¦;Àt-¾7ž;HÀÒäHP(¦;ÀÙ!;‰ž;HÀÛàx_)¦;ÀœÛØž;HÀ ˆl*¦;À5ÀE)Ÿ;HÀÙ³p+¦;Ài8ÚŸ;HÀèöq,¦;Àä{àŸ;HÀ7ºq-¦;Àw*Z? ;HÀæ[»p.¦;ÀFuˆž ;HÀ,õo/¦;À¬,\Zþ ;HÀ)¡n0¦;Àê¹\"^¡;HÀŽæm1¦;À–4“¾¡;HÀIVk2¦;ÀvV¢;HÀXy›i3¦;À-®¢;HÀ, úg4¦;ÀáÆ&à¢;HÀŸé‘f5¦;Àò0p@£;HÀy÷—e6¦;ÀK- £;HÀ\Z	@e7¦;Àäaÿ£;HÀ&0e8¦;À\0[^¤;HÀZe9¦;ÀlŸe½¤;HÀYÜd:¦;À|ÆÎ¥;HÀ{\"c;¦;À\\ý~}¥;HÀa<¦;ÀÐoß¥;HÀÏúR]=¦;À½ÛiB¦;HÀ/òX>¦;À¾½5¦¦;HÀO6S?¦;ÀÔœ\n§;HÀî{ÝJ@¦;ÀöÏTs§;HÀgHÞ<A¦;Àw}sà§;HÀ€’O-B¦;Àøi»N¨;HÀ´My C¦;À\Zãïº¨;HÀ³o£\ZD¦;Àe5Ô!©;HÀ4\"›E¦;ÀnÜƒ©;HÀÜÔF¦;Àw bä©;HÀM2G¦;À‚ˆ©Dª;HÀäBH¦;Àªœ„¤ª;HÀÍ”ºI¦;Àšå!«;HÀScJ¦;ÀÌ*ãc«;HÀf@K¦;À9Ã«;HÀi$L¦;ÀCô\"¬;HÀÄ; M¦;À“‰¬;HÀÛ6rN¦;À£ß¬;HÀp*9O¦;À[m	9­;HÀŠË] P¦;ÀÛ¶ô­;HÀà—ò(Q¦;ÀC¢‹å­;HÀ+\r\n1R¦;ÀãÛ–;®;HÀÓ¥¶6S¦;À÷ß“®;HÀ¿=:T¦;ÀY/î®;HÀ	R=U¦;ÀÉô·H¯;HÀ}ã@V¦;À¸s§£¯;HÀpÝBW¦;À&ÁËþ¯;HÀž<ïDX¦;ÀŸò\nZ°;HÀH£EY¦;À8äÏ·°;HÀúÂwCZ¦;À\n†)±;HÀºé}A[¦;À„vTx±;HÀ×ùÆB\\¦;ÀqRÕ±;HÀ¡.dJ]¦;À?¸-²;HÀ‰’V^¦;ÀAÜÁ~²;HÀˆ<*e_¦;ÀDð¶Í²;HÀ8Ou`¦;ÀÿŸì\Z³;HÀuy#†a¦;À–_g³;HÀDzÉ–b¦;ÀÂ~´³;HÀ=,§c¦;Àá)¼\0´;HÀD¦é·d¦;ÀQ¯M´;HÀ6Æ‹Èe¦;ÀŸ\rl™´;HÀÀÿ›Øf¦;ÀtDræ´;HÀ¦á£çg¦;À]R›4µ;HÀjþ0h¦;À~XJµ;HÀHHXzh¦;À+_k_µ;HÀ\'|²Ãh¦;ÀØeÓtµ;HÀë®\ri¦;À†l;Šµ;HÀÉâfVi¦;À3s£Ÿµ;HÀˆÊíxy¦;ÀhÀ=Jº;HÀnqÐ&‰¦;À‚*=¿;HÀaÄôš¦;À »õöÃ;HÀiû«¦;ÀÊnÙÈ;HÀXý:´¦;ÀûlmË;HÀŠºº»¦;ÀÉ•tÍ;HÀ!¤Ê¦;ÀK:oWÓ;HÀ–ÃÖtÙ¦;Ài^úgÙ;HÀ‡£†Òé¦;ÀqÞ;HÀgbéÒù¦;Àªó8ã;HÀs8å	§;ÀZp®¹è;HÀSz|§;ÀÝ˜¨ùî;HÀ’È¥(§;ÀÏÄš¯ô;HÀ&…H8§;ÀéTù;HÀ¡=uH§;Àqõý;HÀ  -X§;ÀPî‰c<HÀcK9èh§;ÀÈKãP<HÀw’Pûx§;À10ì<HÀFÁ6z§;À¢ã9<HÀ…p·W‰§;Àò\\™<HÀhi!˜§;À÷Zê<HÀ£‘X3™§;À\nDC<HÀ,Å_C©§;ÀH·›Ý<HÀÖ†Ž(ê§;À€TD+<HÀ0É.)¨;Àžr¥3<HÀE¾9ÿ3¨;ÀS‘K€@<HÀÇšU±8¨;À(”áA<HÀ€ÃbÙ>¨;À˜pÝ¯C<HÀq(¼Žh¨;Àà¡ƒëO<HÀ¹ˆòC§¨;À¥8Y·a<HÀë$êç¨;À©òogs<HÀ€ø¨;À‰Ã+˜w<HÀ&³¶V©;À¥r>°|<HÀJßÕ‘©;ÀM®›<HÀPüÂê(©;ÀKžÌ=„<HÀVè8©;À¨ûF‰<HÀ’ z´I©;ÀˆU©Œ<HÀÊ5Ô^V©;À€05<HÀWÄj…Z©;Àœ•þ\n<HÀñÛ¼j©;À¢J7”<HÀ-sÈÝz©;Àˆ×å÷˜<HÀEP$ÏŠ©;À§Ž~ž<HÀ,ˆ$œ©;ÀYéNÖ <HÀ^4‘Í¬©;À{‰\"¥<HÀ˜zqË¼©;Àsò¾©<HÀÊ‘÷HÍ©;ÀTšâ®<HÀ¥ÿÕ9Ý©;Àb\nÍ™²<HÀdãðî©;À·Ë\'-µ<HÀçV0¼þ©;ÀšF5º<HÀªƒ\\ª;À\r©i¼½<HÀ‹½â ª;À®;>Á<HÀhé\Z0ª;À ‡ëÅ<HÀ!±p@ª;Àœ6‹Ê<HÀ]ñjFª;ÀÓ1p©Ë<HÀXà…HQª;À$½«±Í<HÀ!)%bª;À¹-ÝÐ<HÀ}Kšærª;À°·´Ô<HÀ\Zð^ªª;Àü\"úv×<HÀ:NÅ©”ª;À×··Ø<HÀ4êEžª;À”NžwÙ<HÀÒE¹S¥ª;À8LE2Ú<HÀ%Öj&«ª;ÀZd¡ÇÛ<HÀv™6»°ª;ÀWýäÜ<HÀFPG·ª;ÀZlê²Ý<HÀ¯()½ª;ÀZTÏƒÞ<HÀP±B+Ãª;À?úNß<HÀÈ×^ìÈª;Àmcªà<HÀIÏª;Àïœ¬¯á<HÀÇË„Ôª;À9Ù\\ã<HÀ¹QYÚª;ÀyÈåã<HÀ¤Þ­Þª;À^(ä<HÀOë¿‰àª;ÀŸ)gûä<HÀðÿ*æª;ÀfHuæ<HÀÔ1…ëª;ÀÊ\"®ñç<HÀR„Ð6ñª;À²Ž`é<HÀ &U÷ª;À¾£è¤ê<HÀñ¶ ¬ýª;Àw5ë<HÀÑ(P2«;À0L‹\0ì<HÀ=L“·	«;À\'fAí<HÀKð?«;ÀÞz…Òî<HÀ£WÂ«;ÀØ`Cfð<HÀpq¥\Z«;À2’@ò<HÀWpºñ«;À-¸5“ó<HÀmÐ²%«;ÀÑnõ<HÀ(=½+«;ÀL÷Oõ<HÀº%2«;ÀÖ¥àÀõ<HÀS?b7«;À[ç¢ö<HÀ´K\nZ=«;ÀÒ 3Rø<HÀh¿“C«;ÀÕ¤Êéù<HÀÈ2tI«;À\r×ì…ú<HÀÈtú®O«;Àð“’Eû<HÀüôµ4U«;À’Š ¸ü<HÀ~\Z‚Z«;ÀÃ9ïIþ<HÀ/0=`«;À5oñÿ<HÀŠæ9f«;Àú¤¼=HÀc\n_k«;À—%ó!=HÀÀ]¤\nq«;Àpº½=HÀ´ ‡@w«;ÀÐ}™=HÀšœG}«;À‹kA=HÀ¾Ûlƒ«;À[†!=HÀõƒg	Š«;À…¡:^=HÀí´R«;ÀœÖ§ß=HÀð½/`•«;ÀÌYJH=HÀˆî›«;À[ßyÜ=HÀ_È¡«;Àö/‹t\n=HÀŠTÃ§«;ÀWâ\n=HÀ¨øÇ­«;Àdò¸Å=HÀ¤ck³«;À\rr¦ =HÀäPj‚¹«;À{N™=HÀúGa¿«;ÀŸŠ=ç\r=HÀÚ˜Ž“Ä«;ÀÓù)t=HÀf!RÊ«;À\0{!=HÀÛ¡tuÐ«;ÀL&=ž=HÀÚ {TÖ«;À<’P½=HÀCÁ¬^Ü«;À6v¯ž=HÀ*8œpâ«;À†JÁ1=HÀwœ Nè«;ÀOÂ±=HÀêî«;Àä­i®=HÀ—óúò«;ÀG\n8=HÀ1“¡\'ô«;Àòß£”=HÀiò \0ú«;À×	Sa=HÀªc¬À¬;ÀÕÐQÉ=HÀÓ1L¬;Àë«Ò==HÀ–#À!.¬;Àõ#§y!=HÀVßm†?¬;ÀY†O$=HÀË‘+?Q¬;À©0£&=HÀ²@©1c¬;À¬Œ(=HÀ±0o@t¬;ÀGNl+=HÀD:Ù\r†¬;À£f0,=HÀfÚŸÀ˜¬;ÀøäsŠ,=HÀ-PÀ¨¬;À>¦b7/=HÀ}õ¯U¹¬;Àõäå2=HÀàiÄ!Ê¬;À«j6=HÀ[˜:oÛ¬;À¯þÎ®9=HÀ¼v^í¬;Àd¦àÙ;=HÀ¼ê+þ¬;ÀôÝu?=HÀ…Ttû­;À\"xƒ½A=HÀØ’°®!­;À%Â³BC=HÀÃµÓ3­;ÀÔËÜB=HÀù€D­;Àý¯¢@=HÀèÓŽäE­;Àòg™ž@=HÀÃÐ_“W­;À„Ó”ýA=HÀæ`îg­;Àû<áE=HÀ\'ˆyTx­;Àö7‹yJ=HÀú­¶Z‰­;Àl6PM=HÀ@\'Ø\\‰­;ÀãÒ†PM=HÀ}áˆ@›­;À”°˜‰M=HÀŽÁu]­­;À\Z$éêL=HÀô[êž²­;À§m6M=HÀ¿ÎŽ-À­;À±Š’$N=HÀÙ‘¾Ñ­;À#kÚÿQ=HÀ#$\rÕð­;ÀQ8!V=HÀ’ó4®;ÀÙ_‡&[=HÀqêA®;À$e\\=HÀlw@+h®;ÀH€»\\=HÀár­ý‹®;À‰\r]^=HÀñ@\\µ®;Àú]m”a=HÀE£Ä\Zß®;ÀXä5Ód=HÀÃÝ\n¯;À€L÷f=HÀ±Ní%¯;À}KIg=HÀ3yøÅ<¯;Àt»:þi=HÀÅ¡Z¯;Àç](Žm=HÀ½Xlë¯;Àiïcsv=HÀƒ©èŽ¯;ÀvÙ½Nw=HÀÕˆû‹—¯;À,ßÃªw=HÀZ”\Z¦¯;ÀêjÐx=HÀGø†¾¯;Àñèë_{=HÀ4zYÊ¯;ÀkSóò|=HÀ´\n—$ú¯;Àp¯aƒ=HÀmõÔê-°;ÀèÈõP‹=HÀ1÷L	4°;À \0Ôï‹=HÀ*Ø	ªU°;ÀœÕX=HÀbwæ<{°;ÀùI¸÷’=HÀßtT°;ÀCÄ‰˜=HÀùÏÍ·°;À[(,O=HÀˆz;Ø°;À\nRX£=HÀ®ªý°;À¼*	â§=HÀx‹­¸]±;À°òg·=HÀãî™Ÿb±;ÀzûgQ¸=HÀØÜ2n±;À‚>Òº=HÀœ†És±;ÀÉ_:¼=HÀ§ù]\\v±;À½=HÀQ3áw±;Àø¥¸†½=HÀµ/\0q|±;Àûu1h¿=HÀ€?JG€±;Àb‹üÀ=HÀ(¾Šæ‚±;À‰*Â=HÀŸa4:š±;À“ØDtÌ=HÀ™…Q›±;À§Ê·Í=HÀrÅÈ›±;ÀôÜVÍ=HÀ– wfœ±;À’aþÍ=HÀ|B!±;À¢+ÚÎ=HÀ§ìt£±;Àú}E„Ø=HÀšM9£±;ÀÔ£=Ù=HÀ¸å£±;Àd7>´Ù=HÀYD@¤±;À·k6Ú=HÀ<_Ÿ\0¥±;À2a‘ÌÚ=HÀ(ix¨±;Àh ¡°Ý=HÀ¾ÈiM©±;À³E åÞ=HÀà0Ãä©±;Àj¤æŠß=HÀ~ õª±;À.¥Õß=HÀ>²Úª±;ÀMÙ’à=HÀßª±;Àõ¤i…à=HÀÚ©0Â©±;Àgç1á=HÀxöc©±;À³ÀE	â=HÀJ+7¨±;Àäklä=HÀ†ar§±;Àv=]>æ=HÀÓÿô¦±;Àkºd¢ç=HÀ»¤¢¦±;ÀÑ\0cé=HÀ¦tÂ¥¦±;ÀæAÐwé=HÀžRG\n§±;À?ƒê=HÀ!&ï§±;ÀU\r²ê=HÀTrj©±;À³ÖsÅë=HÀsd‘¬±;ÀÏ†€«í=HÀ\n–·Ì°±;À“–›ð=HÀ³Í˜Ì²±;ÀÎÓò=HÀúUŸ´±;À€^Ü‹ó=HÀ=¥_‘µ±;À©Jhô=HÀkÏ¶±;ÀÇ¯š†õ=HÀªˆÆªº±;ÀµÝšÄù=HÀøÊþ°¿±;À<’S?ÿ=HÀ\\cËÅ±;À+\n]>HÀì0ÆÌ±;ÀÏ%ó	>HÀS»Æ>Ó±;À¿ÚN>HÀ°òÜÕ±;À’Wfç>HÀÌà‡òÖ±;À5Íêð>HÀ¶2™×±;À µ_a>HÀP¡Ø±;ÀsÁá>HÀï?oÛ±;À›¸Ý1>HÀÔ¤ºåß±;À¢pÇ>HÀŽR>â±;ÀE/Ô¶>HÀr×uã±;ÀMÑT\Z>HÀ¸Zä±;Àö‹Çß\Z>HÀmå±;Àèû>HÀï€šLí±;Àt¡3#>HÀo}^ó±;ÀS2ªÅ(>HÀÚW\'¢ô±;À†Øý)>HÀi±Ñaø±;À/Ù–,>HÀ¯Þ)Üù±;ÀÊ¦Þ4.>HÀ/q\';ú±;À‡Ê,ê.>HÀ¸›¿Aý±;ÀÎ×sS3>HÀoO7þ±;À€%Ÿo4>HÀ²˜µøþ±;À”Ž©F5>HÀ—š	²;À•ÙÙ<>HÀt {²;À/ò\\ýC>HÀ.¨A—²;À¦_®I>HÀ¥,¥]&²;ÀcÇ‡œO>HÀNð^E.²;À0SôïQ>HÀó÷/²;À÷œ‰R>HÀÙéjŒ0²;À.‘5ÇR>HÀfV^p2²;Àb,†ÞS>HÀ-i4²;À‡tTÝT>HÀ,Ø…a6²;À…‹f¾V>HÀ^)c7²;ÀmÊÌ¾W>HÀ$h‡M8²;À™P³X>HÀDRó8²;ÀkãÌ™Y>HÀPª6?:²;ÀwE[>HÀY2<²;À¤žþ]>HÀ{\n‚=²;Àr08Ó^>HÀŽó\0?²;À?_¥`>HÀ¿Â³B²;À&Ü¼kb>HÀ§Í£J²;À?Ã~ôg>HÀ?à\"[²;ÀŒ˜%t>HÀwÕ~˜s²;À	éBK†>HÀ‰\'l•²;Àû	 >HÀâš©\\—²;Àl1›X¡>HÀjVQ&š²;ÀÃÞ¥â¢>HÀ/í²”°²;ÀÔ§w®>HÀaûqä¸²;ÀÊ&Í²>HÀ`´nÀ²;ÀŠeî¶>HÀIûˆãÂ²;À˜˜¸>HÀÞn”‡Ó²;ÀüRkÂÁ>HÀb\Z¶Þ²;À4O\"È>HÀR‘ªë²;Àmc„EÏ>HÀÀg£³;À.W]ÕÚ>HÀä·l³;À`bâ>HÀNCÔL³;À“µ–ié>HÀl)Õ/³;À|}1šö>HÀÓ\\Ô°@³;À»s®¯þ>HÀ£…¿Up³;ÀúŽ?HÀŒš;Ê“³;Àð0»É!?HÀ–ü0!Ò³;À|à–??HÀÊÇÓ!ì³;Àc6•*K?HÀ¦t&Dø³;À·RDQ?HÀA‘•\0´;À$[?HÀÆ×‡B!´;ÀJšíbb?HÀh;´$´;ÀfPÚ^c?HÀˆê¤\'´;À\n-îWd?HÀOÄ*´;À6é.xe?HÀ/É¢M-´;ÀR8j(g?HÀì~•½/´;À¿Ó8Òh?HÀ©ùfÂ2´;ÀÝpù:j?HÀ\Zfu6´;ÀêÄýIk?HÀz×ôß9´;Àšë˜pl?HÀÊ’=´;ÀRù¶_m?HÀ3¬F~@´;ÀJXen?HÀãVÙC´;ÀËÇqo?HÀ;×²ÅF´;À\0©»ƒp?HÀ›àI´;ÀïÑ:r?HÀï\Z‘K´;Àµ`\rÚs?HÀXZLN´;ÀØD†fu?HÀÐ-*»N´;Àìô§–u?HÀýY|WQ´;À¿W[v?HÀgZhQ´;ÀqwÜ_v?HÀú#ìU´;À‚n”w?HÀŒÌ²ªX´;ÀÇ¥~w?HÀþë[´;ÀÍôþRx?HÀ”›ÇŒ_´;À,Úvy?HÀË«†¨b´;À~”N¦z?HÀÒ´Ä”e´;Àu~e|?HÀŒmóÅh´;ÀJR>j}?HÀ<Šók´;ÀÕd_~?HÀÿw2în´;ÀÂØ¿²?HÀ°„ÌUq´;ÀaÈ¸%?HÀÇ¡Î&t´;ÀsnÈ‚?HÀvÝ‰jw´;À‚6+„?HÀ—¹ˆöz´;ÀÌ§cD…?HÀ¯¹×.~´;À6F¼8†?HÀt²’—´;ÀÀc9‡?HÀ\"y¦Ô„´;À&ñ2\'ˆ?HÀÏmˆ´;À(¥1‰?HÀ[DVŒ´;ÀO&½Š?HÀ-]è^´;ÀbÚåŠ?HÀ¥—=“´;ÀE¼™‘‹?HÀ§¯5–´;À0XŒ?HÀüê&š´;À¯õ^?HÀ?÷¯È´;ÀªX®|Ž?HÀôÕÕü ´;À\Zî3s?HÀŽ¼¿^¤´;ÀÀ¨w?HÀ7ø	Õ§´;À@þ‡‘?HÀ©F÷ª´;À%¸÷w’?HÀ˜$ž®´;ÀÎ	æ“?HÀx‘¹±´;ÀbŽ„”?HÀ„i²º´´;ÀiÈPƒ•?HÀ­qD·´;À}v	—?HÀ¥ûäº´;ÀyñØ]˜?HÀõ¾>-½´;ÀÑn/^™?HÀ¯9šó¿´;À½Þm«š?HÀN«½vÂ´;ÀI‡™?œ?HÀý”Î•Å´;À#—A?HÀ9S È´;À…l³~ž?HÀ™\Z\'+Ë´;ÀAÑ¼èŸ?HÀ]X³Î´;Àß÷ƒ¡?HÀc¥ÎÑ´;Àí®ä¢?HÀ9Œ—wÕ´;À™eU/£?HÀMÛÐ$Ù´;ÀÁ,B¤?HÀ¿ÞùcÜ´;À[Š¥?HÀ›ðÄ”ß´;ÀogVó¥?HÀ‡Öªâ´;Àßœaê¦?HÀØe”±å´;ÀvdÚö§?HÀm–’³è´;ÀÄ~\0©?HÀy˜Šë´;ÀÝff1ª?HÀl6;î´;À!„0Ø«?HÀOa˜Íñ´;ÀýÖàå¬?HÀÊØü÷ô´;ÀKxÎ­?HÀrz\'Xø´;ÀæÿTÐ®?HÀ£×¾û´;À}rŸã¯?HÀ¨üjÿ´;Àœfq9±?HÀ\\¶r¥µ;ÀZëÊò²?HÀ‘Q\"µ;Àrð÷´?HÀ¯,òDµ;Àƒ•Lµ?HÀO0M³µ;À2š@¶?HÀ…ÉTµ;À¾eˆÚ·?HÀæ­µ;Àm{X¹?HÀ¸	åÔµ;ÀAà5º?HÀ¹íÙ;µ;À,Fèº?HÀÛ	Fµ;ÀMÊÙ•»?HÀÉè¾œµ;Àãá›Ž¼?HÀìÿÚ£!µ;ÀSx[ ½?HÀß5ãF%µ;ÀÈ¾¾?HÀ9Ei(µ;ÀÜ¼¯¿?HÀu¡Ó+µ;ÀÖâ\Z£À?HÀ†Ì./µ;ÀÏ§ì¹Á?HÀÍ»Ü=2µ;À6½Â?HÀá·”S5µ;Àq+¼Ã?HÀÕKg8µ;ÀÀöµÄ?HÀè†ˆM;µ;À.ö~ýÅ?HÀ]Žq“>µ;À§\'ZÇ?HÀÙueqAµ;ÀÄh\\šÈ?HÀ<5›œDµ;À>È¨ŒÉ?HÀª\Z¹Gµ;À¨{[‚Ê?HÀk&üÐJµ;À^:&zË?HÀ=6Nµ;ÀKÉs™Ì?HÀ×WPµ;À?1#Î?HÀÁëì”Rµ;ÀR%€ÀÏ?HÀï¦ïÕUµ;À0ÍØÐ?HÀÅ‡Yµ;À€éÑ?HÀ@žÖ&]µ;À‘û”Ó?HÀ ¨ND`µ;Àñ¾þÓ?HÀ¢ŸÕcµ;ÀÁýgÕ?HÀp;šfµ;À<qlÖ?HÀÖWŸdiµ;À¢åöÄ×?HÀ8ï…Ûlµ;À\0\nØ?HÀc®¸Žpµ;À-©«}Ø?HÀÝ¿Îsµ;Àà‹Þ‚Ù?HÀŒF;¢vµ;À.Zß±Ú?HÀÛyµ;ÀyAñSÜ?HÀxÕôªyµ;ÀÈ˜‡Ü?HÀ.¨¤êµ;ÀkÛöQÞ?HÀOf”f„µ;Àé£ªà?HÀµŠÄd‰µ;À©“Éóá?HÀKW†‰µ;ÀaLÿá?HÀá#L§‰µ;ÀwÎ\nâ?HÀwðÈ‰µ;À\\éPâ?HÀ\r½Óé‰µ;À[Ó!â?HÀ¢‰Šµ;ÀWÍU-â?HÀÞCnŠµ;ÀDÒÛQâ?HÀÓi†ÎŠµ;ÀÕ›Ðxâ?HÀO· -‹µ;ÀÛ)¡â?HÀí1Q‹‹µ;Àõ\rÚÉâ?HÀ”Wê‹µ;Àj}Øñâ?HÀ£4´qŒµ;À¿U)ã?HÀµùŒµ;ÀYÒÑ`ã?HÀN}r€µ;À.rM˜ã?HÀ&†ÑŽµ;À|YÉÏã?HÀ©/Žµ;ÀEDFä?HÀ\Z’æ’µ;ÀÒ„&ä?HÀÛ$V‡µ;À±å?HÀdHâx‘µ;À ë†å?HÀ+yïs’µ;ÀÍFæ?HÀ2â„“µ;ÀµÜ®qæ?HÀ„çŒ`”µ;Àà°G¹æ?HÀgQp?•µ;À‚Ouýæ?HÀ¥À–µ;Àžb@ç?HÀà²ÿ–µ;Àö–\rƒç?HÀ¹ëxÝ—µ;À—7Èç?HÀnÔ“®˜µ;ÀÊ»Îè?HÀ°£x™µ;À°äŸOè?HÀªN]Pšµ;Àø%u“è?HÀ·Ìw!›µ;ÀÑ“×è?HÀ7þò›µ;ÀÜAT\Zé?HÀ!tàœµ;ÀÌéxeé?HÀ­é¸Îµ;À4qÂ¯é?HÀK‰£½žµ;À#cfùé?HÀÎ\Z­Ÿµ;À¨JšBê?HÀ©¸Æœ µ;À/±“‹ê?HÀ–<I¡µ;À|V¿ê?HÀ¸¡žö¡µ;ÀÉÖÅñê?HÀC½¥¢µ;ÀªKa\"ë?HÀ‹zÛV£µ;À›b¨Pë?HÀÜŸ_\n¤µ;À«¤\Z|ë?HÀêˆMŒ¤µ;Àcú^˜ë?HÀE­¥µ;À»¹O²ë?HÀgüµ“¥µ;À\0K.Ëë?HÀØž¦µ;Àš<äë?HÀþžš¦µ;ÀI‡ºþë?HÀV†;§µ;À†A-!ì?HÀÔÿÛ§µ;ÀQA>Dì?HÀ¯ú{¨µ;À·hì?HÀ<]c©µ;À ÑŒì?HÀ™Þ)º©µ;ÀF¿ú±ì?HÀ‡ÙÍ_ªµ;À“§µÝì?HÀ23«µ;ÀZ˜Xí?HÀ7|¶ «µ;ÀÁ\'Aí?HÀüB\\A¬µ;À’ísí?HÀ¹å¬µ;Àóy¡í?HÀAý‚R­µ;À›Gµ¼í?HÀ`«À­µ;ÀBAºÕí?HÀ…¥I0®µ;À£!Yìí?HÀŸ1u¡®µ;Àíœb\0î?HÀ—kE¯µ;ÀØg§î?HÀÒÆ¦¶¯µ;Àšbk#î?HÀûµZ°µ;ÀÏ„ô.î?HÀDX†ÿ°µ;À¾“Ê7î?HÀa±0¤±µ;ÀXVuAî?HÀž/ÊG²µ;Àq’|Oî?HÀ_$ƒÖ²µ;À©id]î?HÀÖþe³µ;À\"Whkî?HÀtOó³µ;ÀèàG}î?HÀ/³…{´µ;ÀzŒÂ–î?HÀ-‚´û´µ;Àpà—»î?HÀÂ{ãµµ;ÀkEJï?HÀ<ìÅ¶µ;ÀëLÞiï?HÀVž‹£·µ;À[¡ÚÃï?HÀáá¦¸µ;ÀzëÅð?HÀ™dZb¹µ;ÀÔ&vð?HÀ±›[ºµ;Àñ½:»ð?HÀåsfÊºµ;Ài\0ñ?HÀ0/ý~»µ;ÀŸŸDñ?HÀw¢4¼µ;ÀLÖµˆñ?HÀ„Q×ë¼µ;À¶¹>Ìñ?HÀÓa…X½µ;À–.ˆïñ?HÀ®a“Ê½µ;À-:âò?HÀu”¸@¾µ;ÀŽý!%ò?HÀðA¬¹¾µ;À<™9ò?HÀN«%4¿µ;À`/§Iò?HÀÙ¹=ã¿µ;Àù‡ÎWò?HÀÓ¢D”Àµ;À3S®[ò?HÀÇHFÁµ;Ài|[ò?HÀòŠ†÷Áµ;ÀQ]m]ò?HÀ®Iu§Âµ;ÀG©·gò?HÀSÎÃÃµ;ÀìÇqò?HÀŒp†Ãµ;Àô¯á|ò?HÀëlôÃµ;Àå€±‹ò?HÀ¨Wd]Äµ;ÀÑéã ò?HÀi7ë¿Äµ;ÀIw%¿ò?HÀB˜éÅµ;À¡žÞò?HÀ‘]Åµ;À;ôÿò?HÀÝ#ªÅµ;À)Æó?HÀ¼…‘öÅµ;Àúa@ó?HÀ¹ÉEDÆµ;ÀÀ L`ó?HÀ·Î8ïÆµ;À»>v¤ó?HÀ\"“PšÇµ;À“T†èó?HÀR»EÈµ;À-ßb,ô?HÀ\0I§ñÈµ;ÀäZòoô?HÀ<¶BžÉµ;ÀD³ô?HÀä…32Êµ;À}^Úéô?HÀ\\=ÉÊµ;ÀÊ@dõ?HÀ%o«bËµ;À‰ºžNõ?HÀ½­ïþËµ;ÀÙ›o~õ?HÀÚ·Ìµ;ÀL´¼­õ?HÀg^ƒÍµ;À§=êÊõ?HÀ£üWsÍµ;ÀlSäõ?HÀÀ–;áÍµ;ÀiÎùõ?HÀpU4QÎµ;À[1ö?HÀ´dHÃÎµ;ÀXlRö?HÀ	âZwÏµ;Àñ*ö?HÀ¼xB,Ðµ;À—™ö?HÀÆ…˜áÐµ;À]I`ö?HÀ†jö–Ñµ;ÀJãLûõ?HÀ\'†õKÒµ;ÀÒJ%øõ?HÀ2…P¹Òµ;À!õ°ùõ?HÀO Q\'Óµ;À#Øûõ?HÀ\\\0”Óµ;À£ö?HÀÓhýÓµ;ÀCðö?HÀÅ½aÔµ;À÷ÏÜ2ö?HÀ({Õµ;ÀöÀžö?HÀ7ž[Õµ;À62)Òö?HÀÚÓ¢\rÖµ;À²¯O\'÷?HÀèÁŠÖµ;ÀôÅå{÷?HÀÄX(×µ;Àƒ¿Ì÷?HÀÉ…Eo×µ;Àâ\"ÿ÷?HÀKìÌ×µ;ÀŽât1ø?HÀòž*Øµ;ÀŽÖpcø?HÀ,ÿŠØµ;ÀsaÏ”ø?HÀŒ{ëØµ;À¸ñIÅø?HÀ¶ÐìœÙµ;ÀäNù?HÀ9ñTÚµ;À›XHaù?HÀÅÜÛµ;ÀÏÅt§ù?HÀ$ª×ÖÛµ;ÀL¢êù?HÀ:\r­ŸÜµ;Àd`*ú?HÀÝX“ôÜµ;À“u`Cú?HÀÉ,ÜJÝµ;À6 °Yú?HÀ‰{©¢Ýµ;ÀÆVmú?HÀŽ6üÝµ;ÀœÇ[~ú?HÀzQYWÞµ;ÀK†ÆŒú?HÀh+)4ßµ;ÀJÍ£ú?HÀøàµ;ÀŽÈI¯ú?HÀy]úôàµ;Àã:J¶ú?HÀ#udÕáµ;ÀëÛ¿ú?HÀù¶j³âµ;À_Óú?HÀòãµ;ÀÅ1˜Üú?HÀ;ºWãµ;ÀÝòæú?HÀýL¨ãµ;À˜çóú?HÀ|Dgõãµ;Àd˜Aû?HÀÆn==äµ;À”Ìû?HÀ´ã†¶äµ;À‹»ÔMû?HÀ”U¸-åµ;À’AŒû?HÀü“|£åµ;À“Õ±û?HÀ°p~æµ;Àw·‘äû?HÀy½hæµ;ÀšŽ¤ü?HÀv­¿\'çµ;ÀÕ*[ü?HÀ¹Âçµ;ÀM–xžü?HÀ™8\\èµ;À;mùáü?HÀ-\nöèµ;À1J²%ý?HÀèÁkéµ;ÀóÉÁiý?HÀ±ŽW=êµ;ÀnýÛ¹ý?HÀóùèêµ;ÀQÃþ?HÀåô™‘ëµ;ÀNÞ7_þ?HÀÁpú;ìµ;ÀŽÏ±þ?HÀ½^6éìµ;À7ÿ?HÀdµ/5íµ;À‹Ä\Z$ÿ?HÀ4p‚íµ;Àk¬Dÿ?HÀ{ÂÐíµ;ÀŽžkdÿ?HÀº)ñîµ;ÀªÅ€ƒÿ?HÀLßÆoîµ;À[¢ÿ?HÀ‹¦&Zïµ;À«úõÿ?HÀdŽJðµ;À‹æÓB\0@HÀ²<î;ñµ;À9Ù¡\0@HÀMW/)òµ;À#ßÐß\0@HÀ@†?\róµ;À³7@HÀI\r^óµ;À—,ºY@HÀû£À®óµ;ÀYÊÔ{@HÀ{_gÿóµ;Àr¾ø@HÀ?HPôµ;À»íÀ@HÀ„%Æ ôµ;ÀM:4â@HÀÂ>Eõµ;ÀTE\Z+@HÀB}¾çõµ;À]÷Ev@HÀjV‹öµ;À8Á9À@HÀÑ9P4÷µ;À²x@HÀ($©æ÷µ;À%`ƒB@HÀ*;Cøµ;À£O^@HÀ÷)ƒŸøµ;À›×ëy@HÀ‡‰üøµ;À\r\rn•@HÀŸð²Xùµ;Àöé°@HÀöAµùµ;À¢ÛsÌ@HÀ\nÐ¥8úµ;Àð3£ó@HÀpû	¼úµ;À{6Ò\Z@HÀìm?ûµ;ÀåyB@HÀ¬ÑÂûµ;Àê•1i@HÀ	í2Füµ;À¸!c@HÀï©üµ;À<îh®@HÀŠ´U\rýµ;ÀtóÇÌ@HÀoô~pýµ;ÀØfë@HÀ§ƒÓýµ;ÀÕC,\n@HÀ\n8z6þµ;ÀŽÞþ(@HÀZ7¤þµ;À§BK@HÀsCÖÿµ;À®l¢m@HÀ«—cÿµ;À¾„@HÀvëìÿµ;ÀKÙŒ²@HÀC„xZ\0¶;ÀäïÿÔ@HÀª“ À\0¶;ÀGió@HÀ7‡{(¶;Àª…ä@HÀ›i7¶;À2r›-@HÀ¢Fò¶;Àª]„N@HÀÉ&\nN¶;ÀPvât@HÀr÷Px¶;À¡Ò(‰@HÀðo¢¶;ÀoÎ„@HÀƒuÌ¶;À6Yí±@HÀuö¶;ÀqbYÆ@HÀ\Z[€ ¶;À´Ú¿Ú@HÀ%xc{¶;À©[@HÀsXôÔ¶;ÀÉ.î6@HÀ•ï,/¶;Àz7e@HÀê.Œ¶;ÀnŽ2‘@HÀ\n}í¶;ÀRþº@HÀe°ØJ¶;ÀùQû¢@HÀaR4¨	¶;À†¯ô‹	@HÀöï¶;Àkît\n@HÀ\rˆëb¶;À5‡ç]@HÀy¥=c¶;À`	‰H@HÀqè†Q¶;ÀÕÙ$w@HÀ“Pµ¶;À«ZÄ%@HÀäáÇr¶;ÀS¡@HÀªû³\"¶;À}o@HÀ7üÌ.(¶;À\'=5š@HÀ*b`³)¶;À?ÐÆ•@HÀ|Îki*¶;ÀôÞ¸Î@HÀŸ²ž§*¶;Àå¨H@HÀ,¥ó~+¶;À@2±s@HÀIÙb,¶;ÀÙ\'r›@HÀ_’Uë,¶;À·æy¦@HÀ~~\nû-¶;ÀŒ7ÆË@HÀP[³ñ.¶;ÀÖ §@HÀgPÖÍ/¶;À.¬¥T@HÀÛ°H3¶;ÀÉƒí4@HÀh?æW3¶;ÀŸRöf@HÀZ¥Á3¶;Àˆ.u@HÀ”G15¶;À¦¸í@HÀÃùåb7¶;À*€¿@HÀnø-8¶;ÀÐ!)ê@HÀç^Út=¶;ÀÄæ\\@HÀÏr?¶;À÷`X@HÀû_óq@¶;À\n½=è@HÀÉ5ÚêB¶;Àˆ~œ¬@HÀúÚvVF¶;ÀSÔF@HÀœro±G¶;Àg³@HÀà^&O¶;À1¯$C@HÀ	RâdS¶;À‘;ö½\Z@HÀ\Z‹PT¶;ÀA†ÿ@HÀuw»MV¶;ÀðGé@HÀMü¿W¶;Àx>¨¥@HÀ`çAX¶;Àè°¼Ô@HÀ¿r¯™Z¶;ÀpY}-@HÀªøª[¶;ÀBQz@HÀ£½ä¥\\¶;À3Õ?È@HÀ]\\bâ^¶;Àøø¯ñ@HÀ›À²`¶;ÀÂ Û@HÀ#^q=c¶;ÀÎe‘å@HÀ¯¥åDd¶;À=Þ-?@HÀ°FÅd¶;ÀÒ´Y~@HÀs;x›e¶;Àæ>¼÷@HÀ\"ã—?f¶;ÀyD@HÀøGU&g¶;À4º@HÀf»ñ›g¶;À^\"ù@HÀ<Í#h¶;À~y}[ @HÀÎ„Àh¶;Àèž´ @HÀQÌgUm¶;ÀÂéÕ\"@HÀEên¶;À™+#@HÀñ#ñbo¶;À_õ6N#@HÀÏª;µo¶;À&Ñ.Y#@HÀeÒ²tp¶;À*[Éu#@HÀDÜsvq¶;ÀŠºž#@HÀ&ÄÒ‡r¶;Àåy˜Ô#@HÀLÞôr¶;À¹-jó#@HÀIf$t¶;Àl!c?$@HÀ.À%u¶;Àß]z$@HÀ¶{w¶;ÀeÓüì$@HÀZF¼ÿw¶;À]OÜ\Z%@HÀ]hß¶x¶;À¹ïºT%@HÀV{ã~¶;À¤_N%@HÀÜææÓ¶;ÀX8óW%@HÀ\ní€¶;À¿m%@HÀÑ—ÈÃ¶;À,+=…%@HÀÕZ„‚¶;ÀÝWB¢%@HÀ9YƒÜƒ¶;À@\'ä%@HÀb8³ß„¶;À.I&@HÀ“¿|¢…¶;ÀSNÆ&@HÀ?µ¡Ð…¶;À—º2\'@HÀa²;\r†¶;À6\"qÂ\'@HÀƒD¡P†¶;À_à&,(@HÀX3}£†¶;ÀäKñt(@HÀw/\0Œ‰¶;À%†Ö)@HÀŸ’¤ÀŠ¶;ÀÞ­9:*@HÀFÉ^5‹¶;ÀW0\\*@HÀns§ª‹¶;Àôl*@HÀ•0(¶;ÀÁ\0è°*@HÀÖžsŽ¶;À6„ü¡*@HÀ®¥~¶;ÀwhR*@HÀ:ºëã‘¶;Àý%;6*@HÀú÷Ëâ’¶;Àß?ô^*@HÀÀâÞ“¶;ÀjT‘*@HÀŠÚÔf–¶;ÀåŠõ°+@HÀW=ã¼—¶;Àd!{J,@HÀÑu\'™¶;ÀÃz\r-@HÀ¢÷°`›¶;ÀâøUT.@HÀÀª=œ¶;ÀC‹LÕ.@HÀÑj¨E¶;À€‡r /@HÀ²ÏeŸ¶;À‹N¯@/@HÀ”#ò× ¶;À|# þ.@HÀÝän¤¶;ÀInHV/@HÀ˜k[~¥¶;À½)Åƒ/@HÀŽA‘)¨¶;À§ùŽk0@HÀ‘Ò?«¶;ÀF232@HÀXq¬¶;ÀÔvgð2@HÀ«,i­¶;À»[\'3@HÀý¦¯0­¶;À‡3@HÀHä	®¶;Àî`f3@HÀ¥­2Æ®¶;À6¼¦3@HÀÊ‚¯¶;À¢eç3@HÀÖvÏ>°¶;ÀÏ•t\'4@HÀÉÙû°¶;ÀÇÐg4@HÀ¦,\"Â±¶;ÀtX`´4@HÀ³ð+~²¶;Àb.­	5@HÀ*u^5³¶;À/xîb5@HÀ^\nÝí³¶;À/e[»5@HÀqþÊ­´¶;ÀA%+6@HÀÃLFµ¶;Àâi˜I6@HÀƒÑlàµ¶;ÀÞà„ƒ6@HÀÍO|¶¶;ÀN¡ó»6@HÀpW\Z·¶;ÀòÃçò6@HÀ¢Žã¹·¶;ÀV_d(7@HÀõr¸¶;ÀæGc7@HÀéÖ+¹¶;ÀÓ¡Ï›7@HÀ”èˆç¹¶;À+m0Ò7@HÀ^pN¥º¶;À@#Ÿ8@HÀüYe»¶;ÀN P98@HÀ(ˆ¼¶;À§Fe8@HÀåÇgË¼¶;ÀHÈŽ8@HÀÚ¥ÿ€½¶;À§?$µ8@HÀŠV8¾¶;ÀÔÄØ8@HÀ´<sñ¾¶;Àñ÷Ìù8@HÀ…˜¤¿¶;À·Ô 9@HÀÍ¼ZÀ¶;ÀnóÙ(9@HÀ”ƒÁ¶;À‡’Š;9@HÀ¥½NÆÁ¶;ÀñÄO9@HÀÍêzÂ¶;ÀNMi9@HÀbFj9Ã¶;À»±M‰9@HÀïéN÷Ã¶;Àu(ä«9@HÀÔå\n³Ä¶;À‘–ÜÑ9@HÀ	FøkÅ¶;ÀðÞ4ü9@HÀ¹q!Æ¶;Àæê+:@HÀDjÎÆ¶;Àè¢^:@HÀ°ÊûwÇ¶;À¾’:@HÀ5:ÝÈ¶;ÀíÌÇ:@HÀ&º2ÆÈ¶;À€ãîþ:@HÀ£I…kÉ¶;ÀðVQ7;@HÀWÀ°Ê¶;ÀÊÏs;@HÀ¹T¹Ê¶;À2Îy²;@HÀÙE¶^Ë¶;À]Kñ;@HÀœw\ZÌ¶;ÀEr@.<@HÀ.^Æ±Ì¶;ÀgUg<@HÀgí*YÍ¶;ÀâÐ…š<@HÀ<ÌÎ¶;ÀHQÌ<@HÀ¢`«Î¶;À[,ý<@HÀÓ-œUÏ¶;À!;\'-=@HÀ8Y6\0Ð¶;À}3é\\=@HÀKQÔ©Ð¶;ÀÓ\Z5Œ=@HÀ#ë¢SÑ¶;À6B\'»=@HÀ×±àýÑ¶;ÀéÃ’é=@HÀd/Ì¨Ò¶;À‡¸J>@HÀúï£TÓ¶;À«8\"D>@HÀÌ†iÔ¶;À…†o>@HÀ\0Ëè³Ô¶;À\rv˜>@HÀžWçeÕ¶;ÀnPB¿>@HÀþÊ*Ö¶;ÀÓ7ä>@HÀ)ÀxÍÖ¶;Àyš¥?@HÀ±Dy×¶;ÀB+\'?@HÀ½Ú)&Ø¶;Àª~´D?@HÀå|ÓØ¶;À§žfa?@HÀW÷Ž€Ù¶;À*Yf~?@HÀ|¶,Ú¶;À\'‹Øœ?@HÀ&ÍÝÚ¶;À§ÇÀ?@HÀÞ‰¿ŒÛ¶;À]}è?@HÀOq;Ü¶;ÀÎQ@@HÀÅTìÜ¶;À,‘5@@HÀZ¿A Ý¶;ÀëwT@@HÀ±ØÒ^Þ¶;Àm@@HÀ–Œß¶;Àù‚@@HÀÿ‡ßÞß¶;ÀcÑ1—@@HÀG><Ÿà¶;Àæ\0Y«@@HÀI_á¶;Àd“ýÀ@@HÀnXÊ.â¶;À.³	Ú@@HÀ`.þâ¶;À§¼žó@@HÀm[DÍã¶;À\0”\nA@HÀ4*œä¶;Àj›)A@HÀ½f jå¶;À=žFA@HÀáâ2æ¶;Àú¡ØiA@HÀ–íiôæ¶;ÀÃ&€—A@HÀ8ž¯ç¶;ÀYäÍA@HÀ¾èdè¶;À»ÐSB@HÀ)5°é¶;À]—NB@HÀý¸ ªé¶;À¦DB@HÀ= ¶7ê¶;À7ÕÕB@HÀÏ‰ŽÂê¶;À;2C@HÀ\0ÅOë¶;ÀÉ¬OaC@HÀëväë¶;À‘¡C@HÀHº+„ì¶;Àÿ•£ÝC@HÀAÈë%í¶;ÀøuÀD@HÀOiÈí¶;À(ŽSSD@HÀˆˆUjî¶;ÀW<EŽD@HÀÌ0c\nï¶;À¾Ý}ÊD@HÀ˜yÍ®ï¶;Àm·\rE@HÀãÚNð¶;À\\&ITE@HÀ…EEîð¶;Àµ¢›E@HÀUºËñ¶;Àˆ2áE@HÀwÝ):ò¶;À)¯e\"F@HÀ÷KÙò¶;ÀfVÜUF@HÀ~öh~ó¶;À~0óF@HÀÄ{\'(ô¶;À”¨F@HÀ›%.Õô¶;ÀûÙ’ÉF@HÀä“#„õ¶;ÀÖXäçF@HÀðzIö¶;À;÷þG@HÀ‚ò7÷¶;ÀUh« G@HÀÉ5×÷¶;ÀgÊ^:G@HÀALø¶;Àœ:ŽUG@HÀpSaù¶;À‘Õ®tG@HÀhú¶;ÀCkV•G@HÀàl½ú¶;ÀVÏ²¸G@HÀ±Ôsjû¶;ÀœþÂÜG@HÀñV1ü¶;À÷…ÿG@HÀæP¯Çü¶;ÀjµúH@HÀzh	ˆý¶;ÀpÖ<H@HÀ„Jþ¶;Àm¯ÂUH@HÀßòÒÿ¶;ÀìÛ)nH@HÀW;Ïÿ¶;Àøk‡H@HÀ»K\0·;Àºž«£H@HÀ ¿âY·;À 2âÃH@HÀ×EÒ\"·;ÀÖWåH@HÀúºSê·;À|\04	I@HÀò3¡¯·;ÀÊ£0I@HÀóÃôq·;ÀùLÎ\\I@HÀ­Iî·;ÀVÉˆI@HÀ CÌ·;À¸­¶I@HÀˆkXw·;ÀºvåI@HÀ½yš\"·;Àû¢J@HÀÈ&ÆÎ·;Àrº£AJ@HÀG…·;Àp²¼nJ@HÀŸ$>	·;ÀŠÏÆ™J@HÀšpö	·;À_MÈÄJ@HÀsßÑ­\n·;ÀvfÇñJ@HÀÀ!b·;ÀùVÊ\"K@HÀéq\n·;ÀwFXK@HÀ˜f/¬·;ÀO³Ž“K@HÀÈ{mI\r·;À*AÂÒK@HÀ‰Fä\r·;ÀÉx\0L@HÀþâÒ~·;Àc©hUL@HÀî·;À>q\'—L@HÀRH¼±·;Àc?ñÙL@HÀ(÷ÂI·;À¯J&M@HÀòÿ>â·;ÀÏÇ&`M@HÀàe?|·;À¡íR¢M@HÀˆõe·;À	HhßM@HÀq3¤·;À¨Ì(\ZN@HÀÉÎ¥<·;À?S/RN@HÀî€½Ú·;À´‡N@HÀòOy€·;ÀýÆy¸N@HÀZ‡½1·;ÀÒÓÎãN@HÀf¡ç·;ÀòðµO@HÀ4ß“Ÿ·;À@CûO@HÀ«\\Z·;À…îj*O@HÀéÃ‡·;ÀÑ0O@HÀ±_ Ë·;ÀXñ2O@HÀ@É´·;À½îb4O@HÀÕYF4\Z·;Àf8X5O@HÀ/pÖè\Z·;Àq76O@HÀŒef·;ÀüÄ™6O@HÀ¢íd·;ÀÌi{5O@HÀhÙ©*·;Àa›;2O@HÀkãMñ·;Àœ¿/O@HÀ>Æù··;ÀÏ;ý-O@HÀ‰=²~·;ÀôvQ1O@HÀ¼Š¼. ·;ÀWïOO@HÀ?ŸFÅ ·;ÀÆ±\Z“O@HÀ‰m¡P!·;Àƒ\0ýçO@HÀ^ëß!·;À`ÖÀ;P@HÀ4\r\"·;À¢{P@HÀ\'¾6-#·;À§¥ªP@HÀh4KÜ#·;À1ËÙP@HÀ@!¦‹$·;À’¤]Q@HÀÜ6£:%·;Àµ6Q@HÀT&žè%·;Àd\r‡eQ@HÀ=x‹¡&·;À-)4šQ@HÀí\"!Y\'·;Àç7ÐQ@HÀ\'@¸(·;ÀŸ†R@HÀxç©É(·;Àó\Z<R@HÀY/O…)·;Àâ4èoR@HÀUf3*·;À×¥e™R@HÀ>0oæ*·;ÀæéåºR@HÀ1/@+·;À¦!ÕR@HÀKÅ¯V,·;À9n«èR@HÀGc”-·;À6ðNöR@HÀä8†Þ-·;À³Ç»ÿR@HÀÄÒ¶«.·;Àc®‚S@HÀ÷y/·;À™R¦	S@HÀXEF0·;ÀÛd)S@HÀÝH\\1·;Àñ’S@HÀÌŽ*Í1·;ÀcS@HÀ«øÁ†2·;ÀÈ#S@HÀ°äë?3·;À‡eÑ,S@HÀ“«qø3·;À9ß<S@HÀpª°4·;ÀÇ×¨SS@HÀRM\"e5·;À{…«xS@HÀ6À6·;Àê%iªS@HÀIŸ¯6·;À ¹åS@HÀ\'ŠK7·;À\r>Ñ$T@HÀÇ$‹å7·;À0´ÙeT@HÀ@„8·;ÀxFr©T@HÀ2ù@ 9·;À¤]îT@HÀ½) »9·;Àø¨3U@HÀe„W:·;ÀÖÓwU@HÀ/ðMõ:·;À¨“¾»U@HÀŽ†;·;ÀÔ(åûU@HÀ*<·;À‹Æ<V@HÀÇ}2¨<·;Àm\"CzV@HÀ[Ú“E=·;ÀW;°V@HÀ¨ž.ó=·;Àr‘ÚV@HÀSÎÜÃ>·;À\"0÷V@HÀÃl§”?·;À7ËXW@HÀLJ†e@·;À«ßÍÿV@HÀ\\8q6A·;ÀïéùV@HÀz	`B·;À¤h’óV@HÀOl½B·;À:…lðV@HÀ,UosC·;À(5ìV@HÀ¯^o)D·;ÀäÏUçV@HÀì¬rßD·;Às­ýâV@HÀ„•E·;À¿$ØßV@HÀ#RPF·;ÀÊüõÛV@HÀ¹MG·;ÀÔ*ÞØV@HÀCËxÅG·;À™;aÜV@HÀ*d8H·;ÀÖ»OìV@HÀ÷á8I·;Àd9zW@HÀ§F¢öI·;À~WšIW@HÀé\\œJ·;ÀxïL’W@HÀë1K·;À”“…ãW@HÀQJÍÁK·;À»×78X@HÀøNUL·;À0NW‹X@HÀ‚ËöÎL·;ÀâôKÖX@HÀ.Üé:M·;À±yZ&Y@HÀ	4é¨M·;ÀËvY@HÀ|âµ(N·;À¶èµÁY@HÀqñÊN·;À7ûZ@HÀþ4ª1P·;ÀùP)[Z@HÀN}ˆ˜Q·;ÀæÞ£…Z@HÀKÊþR·;Àe{™ŽZ@HÀ= ŽdT·;Àè¿8‚Z@HÀl}òÉU·;ÀH°lZ@HÀ”tð~V·;À>7ç_Z@HÀX|×3W·;ÀÜúPZ@HÀgð»èW·;ÀhŠAZ@HÀW+²X·;ÀÉ®53Z@HÀ½‡ÎRY·;Àª‘›\'Z@HÀTêÔZ·;Àê[”Z@HÀÙ·v¿Z·;À6HòZ@HÀ˜Òrv[·;Àà[ºZ@HÀ¯\Zˆ-\\·;ÀãñZ@HÀiruä\\·;À­Z@HÀÃ‚8¤]·;ÀÜ_ìZ@HÀjPc^·;ÀpdðZ@HÀº¸!_·;ÀñEšZ@HÀ®dlß_·;À)Û5Z@HÀŠÌhœ`·;ÀÌ2¤VZ@HÀðÔ®Xa·;Àçïí‚Z@HÀó		b·;À‡ÂÉ·Z@HÀ¢|\'±b·;À	åìòZ@HÀÛºTc·;Àš2[@HÀÄõp÷c·;À™üÝr[@HÀpv&ƒd·;ÀðŸÒ³[@HÀ_ì\\e·;ÀŸÇü[@HÀH¶òe·;ÀxfàE\\@HÀ5Æf·;ÀNoe‹\\@HÀ‡Çµ¡f·;ÀÙÓÛÆ\\@HÀáÄ¢Og·;ÀQ>Éö\\@HÀŽ<h·;ÀÁ¬~]@HÀ²x©¶h·;ÀÑº4]@HÀ§Åni·;ÀÏy9B]@HÀwl \'j·;ÀòËºC]@HÀ!Á:ùj·;ÀN6€>]@HÀªnTËk·;À5Õ59]@HÀ´nl·;ÀQæ3]@HÀ­Xˆom·;ÀÛQœ.]@HÀÕ£An·;Àíb)]@HÀMÕ¬÷n·;ÀÎæ$]@HÀø¶­o·;À3n ]@HÀ†c¿cp·;ÀQÇø]@HÀ(âÈq·;Àz’‡]@HÀb}ÒÏq·;ÀÐý\Z]@HÀ²ì_ˆr·;ÀìZô]@HÀâÄÀ@s·;ÀÔ~™]@HÀùs·;ÀQ\0A]@HÀ°,±t·;Àu!(]@HÀÃOiu·;À_sq:]@HÀl\'¶1v·;ÀyÚV]@HÀ½:sóv·;ÀQ˜|]@HÀz\'B¯w·;Àeòª]@HÀ)Þex·;ÀáÁŸß]@HÀh8y·;ÀÀ0±\Z^@HÀ| Åy·;À¡¢Y^@HÀ¤S©nz·;ÀÃVè˜^@HÀ€«{·;Ào¯ýÙ^@HÀä3»{·;ÀF\rÚ_@HÀ‹/R`|·;À‘Ò^_@HÀ(efë|·;ÀäCÏž_@HÀ\\×³l}·;ÀÆ3üå_@HÀilï}·;À5	Ö,`@HÀ”†À~~·;À *–l`@HÀ=Ïâ%·;À’ÿuž`@HÀ?\"\0Ù·;ÀÖ£¢º`@HÀ¬é²‹€·;À‰÷ÅÃ`@HÀ=Ò>·;ÀBñÀ`@HÀ•‡kð·;À•‡°·`@HÀ<´º¢‚·;À±×¯`@HÀcëvƒ·;ÀG¬¨`@HÀ¡JI„·;ÀK¨ `@HÀ¥£‰…·;ÀÑU—`@HÀ	)Óï…·;À(C§`@HÀ|\"2Ã†·;ÀmÝIŠ`@HÀèìy‡·;À^oˆ`@HÀSqÀ0ˆ·;ÀùÐ‰`@HÀFs§çˆ·;À:ÁÅ‹`@HÀè¤œž‰·;Àè`ú`@HÀ¢»šUŠ·;À‹:7•`@HÀ:Å»‹·;À\0{î›`@HÀÐ	Ï‹·;À\Zl¦`@HÀž°Í‰Œ·;À²G‰·`@HÀ“ÝÖA·;À4Ò`@HÀ´µEö·;Àù`@HÀ?k±Ž·;À.a@HÀøñÌa·;À?vha@HÀ•.é·;ÀØàÛ¦a@HÀêÏ²·;ÀL<¿ça@HÀÅ`éY‘·;Àà–§)b@HÀÒ%ú‘·;À:Kˆkb@HÀ’ÿ§–’·;À=®Ý¯b@HÀÈÁ»2“·;À{Æpôb@HÀ2ó¬Ñ“·;À¡›\n7c@HÀuoÇv”·;À?4tuc@HÀT»d•·;À`IR©c@HÀ_×´•·;À„´qØc@HÀ\'Ú…X–·;À›\"d@HÀWÛ#\0—·;À\r\"µ)d@HÀ³ó†ª—·;À7nyLd@HÀød˜·;ÀòÞod@HÀÍF¥™·;À-×_’d@HÀáô¼Ú™·;ÀmÈæ³d@HÀŒzo–š·;Àª[Ôd@HÀÅ´ìR›·;À€²¤ód@HÀ‘Pœ·;ÀfÅze@HÀR7Ï·œ·;ÀÁ+ï,e@HÀ	ÛŠj·;Àƒ,ÍHe@HÀo¦¥ž·;Ààce@HÀ¹ÊAÑž·;Àèó}e@HÀê>ˆŸ·;À>—•e@HÀºÜþ@ ·;À®\n3ªe@HÀ¤Þù ·;ÀVØ½e@HÀSyB²¡·;Àý?™Òe@HÀ)jOi¢·;ÀÁ‰êe@HÀú¼ú!£·;Àx^öf@HÀ]ªŽÙ£·;ÀÚ¼·%f@HÀ¾bÔ¤·;À¥á!Ef@HÀŠ•H¥·;À\nz‰cf@HÀ,ö™¦·;ÀÅ3Cf@HÀþ\"¼¸¦·;ÀÕŸ˜f@HÀÓÊïo§·;Àä¬Ö±f@HÀ²ñ2\'¨·;À‰ëÊf@HÀo™ƒÞ¨·;À6\\áãf@HÀõÄß•©·;ÀhN»üf@HÀ|S‘Lª·;ÀoI%g@HÀÉg«·;Ày–4-g@HÀptDº«·;À…€7Eg@HÀŒ£q¬·;À9T|]g@HÀT¦•\'­·;À“\\Qvg@HÀƒnÙà­·;ÀôÓ‰‘g@HÀUð˜®·;Àe/¯g@HÀú+DP¯·;À¶­]Îg@HÀkY@°·;ÀÒ2îg@HÀï7O¾°·;ÀqÜÈ\rh@HÀivx±·;ÀÀÞÙ.h@HÀ…á0²·;À.­•Qh@HÀ¥YRé²·;Àb	uh@HÀj´Š£³·;Àuô@˜h@HÀØ`La´·;À(Jºh@HÀIÌ4l¶·;À¼,„i@HÀ|ñ6y¸·;ÀÅai@HÀTá\'‡º·;À~Hœi@HÀ«Ü”¼·;À\n*Ðºi@HÀ;a*¡¾·;ÀŠÏ³i@HÀ¤ˆl*¿·;À®ôV©i@HÀ}CÓ³¿·;ÀÌHœi@HÀ\n=À·;ÀÉ²Œi@HÀqWÌÅÀ·;ÀU{i@HÀÛ ½MÁ·;À3üõhi@HÀÿ¯¸Á·;ÀzÔ@Zi@HÀ\\¢#Â·;À5¬‹Ki@HÀ#¹”ŽÂ·;ÀïƒÖ<i@HÀL‡ùÂ·;Àª[!.i@HÀ\\tydÃ·;À×2li@HÀ½ÝŽ®Ã·;Àºüìi@HÀ¿è¤øÃ·;À›r\Zi@HÀ×»BÄ·;ÀŽ”øi@HÀzåÐŒÄ·;Àëlzi@HÀØåÖÄ·;Àhªói@HÀ™@5Å·;Àt­5i@HÀ-BÆ·;ÀÈdâöh@HÀ:‚öÆ·;Àôjâh@HÀºèªÇ·;À.Ð<Îh@HÀEé`È·;ÀõÊ½h@HÀœa•É·;ÀÆÍ±h@HÀ\0lÉÉ·;Às»¸§h@HÀoÈ~Ê·;À+qožh@HÀÒþ3Ë·;ÀM†Õ”h@HÀ=\0õèË·;ÀW˜Î‰h@HÀæûŸÌ·;ÀÚ	\r~h@HÀRKßVÍ·;ÀUuYqh@HÀdP’Î·;À¿SÒ`h@HÀXÀÎ·;Àõ–Ih@HÀ§²3pÏ·;ÀKÃ(h@HÀæ¾K*Ð·;Àóù]üg@HÀ®öõÞÐ·;À²-ÎËg@HÀ«<ãÑ·;À‹7/˜g@HÀówÄ>Ò·;À­gœbg@HÀ~ŽJíÒ·;Àb1,g@HÀ£½ŸÓ·;ÀÓª”ôf@HÀ˜&RÔ·;À=.ð¼f@HÀ:‡Õ·;ÀÐ#K…f@HÀÉ…ú¶Õ·;À¾­Mf@HÀo­uiÖ·;À9Žf@HÀ–‘x×·;À’àe@HÀš®ÌÇ×·;ÀÚ¿[ªe@HÀÚMwØ·;À‹dŽte@HÀ±¸Ñ%Ù·;ÀìœA>e@HÀ8·ÓÙ·;Àëe@HÀ+ÍÎzÚ·;À³´VÏd@HÀó\ZƒÛ·;Àdo•d@HÀ´«àÂÛ·;ÀXLZd@HÀ1ôeÜ·;Àžµâd@HÀ/¹É	Ý·;ÀK=)äc@HÀü†`§Ý·;ÀK•T«c@HÀÉÓDÞ·;Àcs·qc@HÀdLaáÞ·;Àh\\¼8c@HÀ´ž,ß·;ÀÔÖÍc@HÀ8t%à·;À{gVÎb@HÀ“bKÓà·;À€å‚ b@HÀãÕ·†á·;ÀŒÐñyb@HÀñ†=â·;ÀÔ›gWb@HÀT,çóâ·;À£»¨5b@HÀ¢|©ã·;À-£yb@HÀ«¨eVä·;À{úìa@HÀÅv¡å·;À^`Æa@HÀÉöÖ°å·;ÀÜ-¢ a@HÀÅ:&^æ·;À}Ê{a@HÀHO¯ç·;Àï“×Ua@HÀá9ˆÈç·;ÀõSÀ1a@HÀÚ¶yˆè·;Àlþa@HÀŽàJé·;À(‚õö`@HÀ¾Õ¦ê·;ÀþÍ™Ú`@HÀõ²âËê·;ÀÄÐ)»`@HÀXš’zë·;ÀxFÖ™`@HÀÒ%ì·;À Š^t`@HÀPÇ‘Ìì·;ÀBã\ZJ`@HÀòÊ“rí·;Àï™c\Z`@HÀÍHìçí·;Àè\r™ô_@HÀ;2	ï·;ÀñÚµ_@HÀòŸH+ð·;ÀÅp“_@HÀÕ×9Nñ·;À8Ž£‚_@HÀÁIrò·;ÀïÎÀx_@HÀ	UÖ–ó·;Àk_@HÀ–ûciô·;À­zk^_@HÀh!<õ·;À-Ô#S_@HÀ•Ðáö·;À…ï\rH_@HÀjixáö·;Àœ¦û;_@HÀ²g¸³÷·;À[Ó¾-_@HÀÍ\n»jø·;ÀSì_@HÀÝ\"Ô ù·;À7kƒ_@HÀ\0\'Öù·;Àýª÷^@HÀ<SŠú·;ÀsOà^@HÀ|Ê¾=û·;ÀTÝÅ^@HÀèÁôû·;À\'X&¥^@HÀP°q¦ü·;ÀJ-r~^@HÀ…´_Wý·;À<¡xU^@HÀÀñP	þ·;À{Çñ-^@HÀÔ†½¾þ·;À÷²•^@HÀcÞ[pÿ·;Àdtï]@HÀEt»\"\0¸;ÀÊKØÕ]@HÀë£Ö\0¸;À7¡¥¾]@HÀxÅ¯Š¸;ÀD¿©]@HÀ(2½@¸;À\0O	—]@HÀp¸8ö¸;À	/;†]@HÀÍù+¬¸;À¢ãÕw]@HÀóqYb¸;ÀÀQgm]@HÀx›ƒ¸;ÀW^}h]@HÀòlÎ¸;Àuï¥j]@HÀ¶ru„¸;Àq}–r]@HÀ¬ø|:¸;À@$}]@HÀWˆƒð¸;Àbi¿ˆ]@HÀk)‰¦¸;ÀÇÑJ”]@HÀLà\\	¸;À{ã\\ž]@HÀÞŽ}\n¸;À¨xè¤]@HÀ›ÞÈ\n¸;Àã—¤¨]@HÀ~È^¸;ÀÍQ¬]@HÀOÏ®5¸;À¹¥°²]@HÀ#q}ë¸;À\Z¬¾]@HÀr \r¸;ÀÂ~àÕ]@HÀÔ\rN¸;À’¢ù]@HÀÐÔÁ÷¸;À9td%^@HÀì/MŸ¸;ÀÛyÅT^@HÀh£ÙF¸;À(cƒ^@HÀÈk¼í¸;Àªª)¶^@HÀy\n.¸;À\Z­ï^@HÀ®9J0¸;À£î\'_@HÀæ¶,Ö¸;À½IZ_@HÀˆ>ñ…¸;À¢ß_@HÀÅpF;¸;Àý1™_@HÀh`pò¸;À\rr­_@HÀ.×nª¸;À\r8¿_@HÀ¸Ab¸;À¡2Ñ_@HÀ©|è¸;Àà·¶å_@HÀš<GÏ¸;ÀÒfTþ_@HÀ½PÉ„¸;ÀµSá`@HÀˆ:¸;Ào3`@HÀ Ãœñ¸;À¸3L`@HÀ\ZÍ «\Z¸;À<LÓ``@HÀUÅÏ`¸;Àþõ1o`@HÀlÄØ¸;ÀeYÆw`@HÀšòÍ¸;ÀF-´{`@HÀxyƒ¸;À*|`@HÀ}Ñ9¸;ÀÔ+z`@HÀv¥¸¸;À/øîv`@HÀ1MŸß¸;À‚Uœs`@HÀÓ…² ¸;ÀËp1p`@HÀÏwi…!¸;ÀF˜¬l`@HÀJ$LX\"¸;Àgi`@HÀÝp#¸;À}ØÀe`@HÀdÉ’Ä#¸;Àd¤Kb`@HÀ£ê³z$¸;Àì/Ä^`@HÀIÕ0%¸;À‰,B[`@HÀV÷æ%¸;À¯KÝW`@HÀÇF¨µ&¸;À1V¤Y`@HÀ<i`„\'¸;Àÿb`@HÀ0‡ôR(¸;Àtkµn`@HÀYi9!)¸;Àë0w`@HÀ»Ûï)¸;ÀETx`@HÀñN€«*¸;ÀLw™g`@HÀb\"ªc+¸;ÀO¿òE`@HÀP	v\Z,¸;ÀÄG*`@HÀ0¹ØÒ,¸;Àï<\nû_@HÀ^æÆ-¸;À¡Ë\\ç_@HÀ×E.¸;À¨8›ß_@HÀ‹“`ú.¸;À¿\n8Ø_@HÀí¹È¯/¸;À—aÑ_@HÀØËDe0¸;À…VDË_@HÀ¥t4¸;À`õ‡«_@HÀÖÉß04¸;ÀwÇ]¬_@HÀX\0FN4¸;ÀÈe­_@HÀH§k4¸;ÀÍlš®_@HÀØ¤‰4¸;ÀáÏú¯_@HÀ[¦4¸;Àñò‚±_@HÀ—n]5¸;À\Zw©½_@HÀGÇ6¸;ÀcÏÛÌ_@HÀr«ÔÉ6¸;À‰;\\Ý_@HÀ¸I€7¸;ÀIûlí_@HÀd©Ë68¸;À]NPû_@HÀb÷zì8¸;À=…Ì`@HÀáW¢9¸;À8»`@HÀ?%ZX:¸;ÀD(R\Z`@HÀÃ8~;¸;À¶\"`@HÀäm½Ä;¸;À„‚í)`@HÀYIz<¸;ÀÏ „-`@HÀ§30=¸;ÀX§,`@HÀw~0æ=¸;Àî©*`@HÀ÷x÷›>¸;À{Ý*`@HÀÈã=Q?¸;Àu{•0`@HÀMX2@¸;À¡H<`@HÀVà‹¾@¸;À€»ÖJ`@HÀº~¦tA¸;À7Š•Z`@HÀN6Þ*B¸;ÀÏÚi`@HÀÑáB¸;ÀøKüv`@HÀer—C¸;Àp%L‚`@HÀbŸÂMD¸;À?(`@HÀ®DE¸;À`™F—`@HÀÈxºE¸;À2] `@HÀc¼qF¸;Àº\"¨`@HÀ÷Q´&G¸;ÀL_¬`@HÀ.œÜG¸;Àn¬`@HÀƒ…”’H¸;À¸‚øª`@HÀ:>\\HI¸;Àê¾«`@HÀfÄ³ýI¸;ÀºðV±`@HÀæ7	´J¸;ÀïW–º`@HÀoSjK¸;À-âÄ`@HÀû™ L¸;ÀÙ]ÆÍ`@HÀÛ–àÖL¸;Àsšb×`@HÀÜÀ0M¸;ÀífÉà`@HÀÈ`$CN¸;ÀÆñé`@HÀîùN¸;À¾mýò`@HÀñ¯O¸;ÀH²òû`@HÀÙ#eP¸;ÀŒå×a@HÀ%ÍQ¸;À‘Z³\ra@HÀÌD_îQ¸;À…KŒa@HÀ³¢ƒÂR¸;ÀmlS\ra@HÀ~…³–S¸;Àr\Za@HÀŽ\"jT¸;Àõlña@HÀ]<U¸;Àåêa@HÀ•ÀöU¸;À«:Ø.a@HÀ…ßÂ®V¸;À’õ¡Ka@HÀ<\'ZeW¸;Àœ¹Íja@HÀWÕX¸;À*á‰a@HÀÃYƒÓX¸;Àêa¦a@HÀ<þcŠY¸;À0Ñ¿a@HÀ^,ÎAZ¸;À®mØa@HÀ7(]ùZ¸;Àõ\nâða@HÀÕ5¬°[¸;ÀNÜ	b@HÀ²MzÇ[¸;Àôn \rb@HÀè¡˜X\\¸;ÀÛÜÁq@HÀÄÏ.@I¸;À:„To@HÀº›ÞÒ9¸;À$¼1<p@HÀÈ	õW8¸;ÀVŒ#Np@HÀÖšÜ6¸;À@˜”Wp@HÀgùÑ_5¸;ÀêXp@HÀ2¢‚4¸;Àn–Up@HÀÿXÆ©ú·;À‘~˜Ôo@HÀomÃRú·;ÀvV×Õo@HÀíC:üù·;ÀuÛo@HÀeÀ¦ù·;À¿ÄRäo@HÀ…éRù·;ÀITvño@HÀt‚Fù·;À\rolp@HÀ•md²ø·;À‰Æp@HÀÂ–Ëfø·;À¤¢T/p@HÀ…žþø·;À	\"ùJp@HÀiá}òÂ·;ÀV_]‡@HÀ@žZÁ·;Àãê±‡@HÀ)ó¿«¿·;Àê=ˆ@HÀ„²\Zé½·;ÀÃd×²ˆ@HÀ\Z¼·;Àê5K‰@HÀäã6º·;À–â»Z‰@HÀØÞ¾L¸·;À îž‹‰@HÀüq½]¶·;ÀBä–¤‰@HÀÐø¾l´·;À	t¥‰@HÀH•y}²·;Ày¹4Ž‰@HÀn\" “°·;ÀJf_‰@HÀÇÛ²®·;À\'F@‰@HÀžÁÞ¬·;Àm¦lºˆ@HÀv“Ò\Z«·;À7è=Fˆ@HÀ2úmj©·;Ài*’¼‡@HÀÒsÎÐ§·;ÀŸp‡@HÀ|Q¦·;ÀÄ—m†@HÀ­éí¤·;À<?ª©…@HÀu)ª£·;ÀÎÕ„@HÀ1,ˆ¢·;À9óƒ@HÀ9Š¡·;Àäç	ƒ@HÀÔTí„ž·;À€%Û@HÀhTmr3·;ÀR÷5di@HÀ[Óê!2·;À8yÕ\Zi@HÀ2ÞÔ0·;Àð¢Ìh@HÀXù~‹/·;À\nÈ¨yh@HÀ>\Z?ö“¶;ÀvY¦í?@HÀb>ù{’¶;Àç0‡?@HÀÛBO‘¶;ÀEOo\Z?@HÀf–˜¶;ÀØŠ{§>@HÀMk½9¶;Àô2NÊ\"@HÀ¬§¬I9¶;ÀXï@¦\"@HÀÓ·OÔ8¶;ÀBRP„\"@HÀäò]8¶;ÀÄl…d\"@HÀü-«Î¶;À¨ßg@HÀæ)å”¶;ÀøFÂ@HÀTìW^¶;À³…[u@HÀ¸1+¶;À¯\Z$@HÀ¨ižÆ\0¶;Àçz¿@HÀ50Hgÿµ;À0¥ŒT@HÀŠjw\rþµ;À²nä@HÀ$Gê”èµ;À‡Ž„³\r@HÀ@*]’ãµ;À“’vH@HÀQä†d‰µ;Àû˜Áò?HÀŸ<Glµ;À<+×ƒê?HÀ½w¥ÿjµ;À[y$ê?HÀà*¤¼iµ;ÀÄ-~¿é?HÀC¤q~hµ;À™2Vé?HÀ¾Ì.Þ·´;ÀAQK­?HÀ N‹¶´;À7E	¨¬?HÀE@˜>µ´;À\'k+¬?HÀ/îQø³´;À.„Š©«?HÀ\'J˜h´;ÀUÂø¾Œ?HÀÔ«ckh´;ÀüÛÐ¬Œ?HÀ\\<>h´;À€Î\0›Œ?HÀwùKh´;À.o‰‰Œ?HÀê4<Üã³;À˜=®ÎZ?HÀI‘ã³;À!¸[‚Z?HÀÃ/6Pâ³;À	_!4Z?HÀöÙÊá³;ÀräY?HÀEoÁæ“³;À»êêP9?HÀ&ýu¢’³;Àû§µÄ8?HÀe‘³;ÀxÌC38?HÀÐMQ0³;ÀjÑ´œ7?HÀmwú.³;À\r·)ëï>HÀ:8LÀÿ²;À¹ª,ï>HÀ. á]þ²;ÀÉ%ûfî>HÀKn+ý²;À±\\[ší>HÀí5jâã²;ÀÜ{ÿÝ>HÀ6yËâ²;ÀB_qbÝ>HÀ‡¥Ôšá²;ÀÊF2ÕÜ>HÀN‰USà²;À`\"YÜ>HÀ›bÔ¶Þ²;À\nä©ÌÛ>HÀèŸ™Ô²;ÀZ±÷ZØ>HÀ>ÿ\n§Î²;ÀkÑ|TÖ>HÀc®ÜÊ²;À’dbêÔ>HÀ-\\òJÇ²;À•ÄqTÓ>HÀJ\ZøÃ²;ÀXÙr•Ñ>HÀÓñùéÀ²;Àà‰u°Ï>HÀWÀ˜¦²;À_ò½>HÀÂ`(:¦²;Àõz™²½>HÀç¥ƒ\"¦²;Àÿqã¢½>HÀ÷y\n¦²;ÀU7^“½>HÀèˆò¥²;À˜\n„½>HÀoÚ„L›²;Àoömî¶>HÀ¤òµò_²;À5ç9’>HÀuÔE_²;ÀMljË‘>HÀ\"\'vŸ^²;ÀéLÑY‘>HÀŽmÈÿ]²;À4¼:å>HÀðhm²±;À¤)\Z>HÀiÛÉX±;ÀÕ9Ü£Ù=HÀl¬K\nW±;ÀÔó\rÙ=HÀ…ÒêÜU±;À›_‡Ø=HÀí.TšT±;ÀÞÉSØ=HÀ0ÜdES±;À®ÖÛ¬×=HÀf¡#áQ±;À]ÜZ×=HÀNZ™GP°;ÀÿÁCâ£=HÀ×–ßN°;ÀSŠ•¤£=HÀõ4ÜmM°;ÀwÔy£=HÀ;OA÷K°;À¯]\\b£=HÀ9Ñ~	4°;À\'Ÿ‚¢=HÀ{Ø‚°;Àã]xR¡=HÀwB¬°;À(Ô#¡=HÀk¤½ß°;ÀooN½ =HÀî\nQ!°;À\"En9 =HÀÔ:Ø¸×¯;À4>‹˜=HÀÛ™Ÿ?Ö¯;ÀÍ\Z\ZZ˜=HÀXŠÐ¿Ô¯;Àµñ<=˜=HÀ÷gÝ<Ó¯;À.òè4˜=HÀ-ÒÁ¶¯;À\n@ [˜=HÀßF¶¯;ÀC‚Áp˜=HÀ›ˆgËµ¯;Àœ¥™=HÀN©8bµ¯;ÀÊ;~Õš=HÀ\n0{Ë´¯;À‰Íÿ›=HÀSÔD´¯;À®íÜ!=HÀø;ý³¯;Àô–9ž=HÀZg[²¯;ÀükõDŸ=HÀå„bÃ°¯;À¯“B =HÀ“@^_¯¯;À,,/¡=HÀ5ÞØ­¯;ÀÍ‘B\n¢=HÀä¸²2¬¯;À$ëÒ¢=HÀ{±äoª¯;À4…£=HÀWø²“¨¯;ÀoEü!¤=HÀOÞŠ¡¦¯;Àm¦§¤=HÀÓ+¤¯;ÀK¥=HÀGµžC[¯;ÀÊô©²=HÀ®»ò(X¯;À(\'³=HÀoŽÚýT¯;À¦\"ë}³=HÀxgkÈQ¯;Àýë­³=HÀYÎŽN¯;Àôq´³=HÀx~4WK¯;À¢8÷’³=HÀ[ý	ò¯;À&Q\\Ò®=HÀð‚õÃ®;Àä æ¯=HÀSÇÂ®;ÀÀËpâ¯=HÀ1£1À®;ÀL¹Æ¯=HÀDmKV¾®;ÀH*“¯=HÀ‚P’…¼®;À’ë*H¯=HÀGI„Âº®;Àò7Sæ®=HÀ\\Ä®¹®;À,0hn®=HÀ\Zv|s·®;À[ž[á­=HÀßw.îµ®;ÀåI@­=HÀ¶´Õƒ´®;ÀƒÅwŒ¬=HÀ¿L7³®;À­ÏOÇ«=HÀx\r2²®;À†_òª=HÀ¥±â±®;À˜>Tª=HÀö˜u°®;Àm½÷©=HÀ%Q·_¯®;Àº,&¨=HÀÍh&Ê®®;Àû‚ê#§=HÀðoð]®®;À!:¦=HÀr’ï®®;À$#1¥=HÀ™ã¨®®;À–÷íþ£=HÀÚRK®®;ÀF‹“ï¢=HÀÐG¯V®®;À3øDâ¡=HÀû÷V¿®®;ÀÑ8!Ù =HÀ¨ä®\r²®;Àxjð™=HÀ„$Úœ²®;À¹ò˜=HÀr\\íR³®;À›û—=HÀ‰?†.´®;ÀO¨—=HÀ_ù-µ®;À·œ.–=HÀ,\nVO¶®;ÀBŸƒZ•=HÀ^Òh·®;À“fä•”=HÀ~Áî¸®;ÀCŒ¹á“=HÀ_µgº®;Àœ¥a?“=HÀ€Tgø»®;ÀÊ˜°’=HÀ¤\"Ì½®;ÀY7õ4’=HÀ‰„¯T¿®;ÀòçÎ‘=HÀüs»Á®;ÀÌã´~‘=HÀ½`~éÂ®;À—úD‘=HÀMßqÀÄ®;À›(\"‘=HÀÌBD¯;ÀD:·<=HÀÂq¹‘¯;À\n£J)=HÀÆ„¯;ÀüaÛ.=HÀ8Q!¦¯;ÀBÓbM=HÀ×·_F¯;À\r‰ý=HÀ¿	2°r¯;Àä>óˆ=HÀ2o\r3s¯;À“ÃÛø…=HÀ±Gcub¯;À…«‚=HÀ¬6à™)¯;À.z=HÀCÎ×í­;ÀÚaÂüf=HÀU´½­;À;B”a=HÀŸ €Z‰­;À’ÞZ×[=HÀ>I@z9­;À›©QûR=HÀ¥ ét9­;À}¥¹úR=HÀéC“o9­;ÀøÊ úR=HÀ3=j9­;À\Z‡ùR=HÀ§Ãö–ð¬;À\00ËòK=HÀˆ×–ï¬;À&ØK=HÀsÀ˜î¬;À€ge¹K=HÀrúší¬;Àä*×–K=HÀµójr«;ÀM!À=HÀ{>O‘q«;À¶,„›=HÀ\róû¢p«;ÀÄŠes=HÀÎšš¶o«;À dÌG=HÀ“	¬­Þª;À¤YYø<HÀ^ã_«ª;À3„¼wî<HÀžÅ&©ª;ÀÏ™þí<HÀÅº’ü¦ª;À\\>Rqí<HÀ$UŽã¤ª;À1yÐì<HÀ#° ß—ª;ÀnMAœè<HÀp¦ëƒª;ÀFí™å<HÀ}bÌ‚ª;Àu—£aå<HÀ$Óý9ª;Àñh\"å<HÀã2¸çª;À\'Ûä<HÀ·‘óë©;Àî	rÄ<HÀ/N¾ê©;ÀuQTÈÃ<HÀ|\' ‹é©;Àù‡ZÃ<HÀ«ƒ#[è©;ÀË‰3Ã<HÀ2á7í«©;ÀY…TÑ³<HÀÜQÍîÝ©;ÀÜ. dÈ<HÀãSÃtß©;Àp3É<HÀgÈ\ZÞà©;ÀˆÕÖÉ<HÀ\rý(â©;Àzï¨Ê<HÀËÛ?Pã©;ÀGb\n‹Ë<HÀ½¾RTä©;ÀåY»zÌ<HÀ’ÅZ2å©;Àè2vÍ<HÀÐ™ªèå©;ÀwÏŠ{Î<HÀð·áuæ©;À,¹ÉˆÏ<HÀ5ïØæ©;À²ç›Ð<HÀç©;Àº½Î²Ñ<HÀVFáç©;Àü“eËÒ<HÀBÔ@ÿæ©;ÀjûŒãÓ<HÀìúlµæ©;ÀÏ<\'ùÔ<HÀÿ|ô@æ©;ÀP\nÖ<HÀFŽ¸¢å©;ÀÈ*Z×<HÀÜ&ëÛä©;ÀÏ;àØ<HÀÙëBHä©;À2¼mÀØ<HÀ&kã©;À›1Ò¥Ù<HÀ„ÀÒjâ©;ÀÔúqÚ<HÀ²BªIá©;À$– KÛ<HÀqÃ	à©;Àè÷ËÜ<HÀ\"æ’­Þ©;À£¦µÜ<HÀœ†Ç7Ý©;Àc“gPÝ<HÀâç@«Û©;À³ºRØÝ<HÀÞÎÚ©;Àt}5LÞ<HÀ¯Ä[ZØ©;ÀW­+«Þ<HÀÀ¿„œÖ©;ÀOzôÞ<HÀ¢ôÔÔ©;À‘\'ß<HÀào,Ó©;À›MDß<HÀj¹6Ñ©;À±Iß<HÀz.gÏ©;Àw	w8ß<HÀy/œÍ©;À¾Rß<HÀEÌ4´©;À×¢	5Ü<HÀµË6°©;ÀþgÛ¨Û<HÀ¸âBQ¬©;À¹è$íÚ<HÀHÜ2‹¨©;ÀŽ:7Ú<HÀŠºaë¤©;ÀÆo¶ìØ<HÀ‚Qx¡©;À›¤–«×<HÀŸÜ38ž©;ÀØ{BÖ<HÀãÂ¶áx©;À4ñ–Ä<HÀ@Ž€v©;ÀO[Ã<HÀÀÈKRt©;ÀøºÂ<HÀé%[r©;À>ü\n“À<HÀ©xäžp©;À)íØ\n¿<HÀ€ ôn©;À\\zá•¼<HÀ_a[d6©;ÀÆj²ª<HÀˆƒ®3©;ÀS©<HÀ÷t\"1©;À‚Ç°ÿ§<HÀ¥\"\ZÅ.©;À#Ž•Â¦<HÀ^H›,©;À¢/i¥<HÀg·]¨*©;À5˜ö£<HÀ9Ãëð(©;ÀŸ–l¢<HÀ~ýw\'©;Àµñ9Î <HÀµQj@&©;Àâm‡Ÿ<HÀüŒ‹L%©;À±:Gc<HÀëÎ7ž$©;ÀX±Òœ›<HÀNÂ„»!©;ÀjŒæ’<HÀáoÿ3¨;À:o\"S<HÀˆ›µ\n,¨;À-uÿP<HÀÑ8ªà+¨;ÀýIôP<HÀ¨¤ª¶+¨;Àd‡éP<HÀ&ë¶Œ+¨;À®ÆÝP<HÀèµDY+¨;ÀPŒØÏP<HÀi“ä%+¨;À 	ÖÁP<HÀóœ–ò*¨;À¹”¾³P<HÀßþ9£ì§;ÀM>º†?<HÀÇÅÚNì§;À˜÷\no?<HÀ‡T\Zûë§;À›ˆ¬V?<HÀ6)ý§ë§;ÀUB =?<HÀe\ns:Ê§;À>Q¡ý4<HÀ«¡|ÒÉ§;Àƒ;Ý4<HÀqWškÉ§;À)k»4<HÀýÔÉ§;À(ýº˜4<HÀØh§§;À©¹óæ(<HÀ˜Â\'¤§;À_`™Î\'<HÀkXEØ §;ÀÙª3Ä&<HÀ {§;Àu=þÇ%<HÀt­f§;ÀäÝ!<HÀw	ÜÕe§;ÀðR%<HÀ(3›e§;ÀR9A\0<HÀºå²`e§;ÀÕî0ï<HÀá2¦4e§;ÀÏž2â<HÀÀ\r±e§;ÀÉ@Õ<HÀm£ÓÜd§;ÀõáêÇ<HÀ%VC<E§;À±ºë9<HÀÌÄÏ÷\r§;À\re¯‡û;HÀQ8Ê~§;ÀÍàÙû;HÀô@N\n§;À\'Úƒ™ú;HÀÙ‚‡š	§;À}ˆ»ú;HÀwÌ1ÕÐ¦;Àx³Ê8æ;HÀ·yMÐ¦;ÀÜª\næ;HÀe`vÄÏ¦;ÀaÜå;HÀ†02:Ï¦;À{µC°å;HÀsÌª14¦;ÀF‚ë´;HÀ]G*v2¦;À—\nÏ[´;HÀÍQÁ0¦;À)ÒÅ³;HÀpeg/¦;ÀÃz¤)³;HÀ´¿Tí‘¥;ÀŠHCxx;HÀ£c…‘¥;ÀÇôQx;HÀ>‘¥;ÀH4^,x;HÀ„J³¥;Àªx;HÀ€ÇR‰¥;À@¸ú|u;HÀã¸…´u¥;À‹9§»n;HÀ', 1, 1, '2019-09-02 22:26:07', '2019-09-02 22:26:07');

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_07_27_190714_create_tipoprocesso_table', 1),
(4, '2018_12_03_190346_cria_tipo_processo', 1),
(5, '2018_12_03_190627_cria_tipo_documento', 1),
(6, '2018_12_03_191356_popula_tipo_documento', 1),
(7, '2018_12_04_135119_cria_cargo', 1),
(8, '2018_12_04_135354_cria_orgao', 1),
(9, '2018_12_04_190954_cria_demanda', 1),
(10, '2018_12_04_192350_cria_autor_demanda', 1),
(11, '2019_01_09_192830_demanda__cria__f_k__autor_demanda', 1),
(12, '2019_01_10_192845_create_divisao_organogramas_table', 1),
(13, '2019_01_10_193549_create_demanda_movimentacaos_table', 1),
(16, '2019_02_13_004643_create_permissao', 2),
(17, '2019_02_13_004908_cria__usuario_permissao', 2),
(19, '2019_02_18_202321_cria_situacao_demanda', 3),
(20, '2019_02_20_141050_demanda_cria_coluna_snsentencajucial', 4),
(21, '2019_02_20_205749_cria_categoriademanda', 5),
(22, '2019_02_20_210615_cria_procedimentoexterno', 6),
(24, '2019_02_20_211001_cria_tipoprocedimentoexterno', 7),
(26, '2019_02_21_204256_popular_permissoes', 8),
(27, '2019_02_22_145252_procedimentoexterno_drop_polopassivo', 9),
(28, '2019_02_22_184120_cria_polo_procedimento_externo', 10),
(30, '2019_02_22_184558_popula_polo_procedimento_externo', 11),
(34, '2019_02_22_200241_procedimento_externo_cria_resumo_descricao_chave', 12),
(35, '2019_02_28_025348_cria_distribuicao_demanda', 13),
(38, '2019_02_28_140423_demanda__alterar_relacionamento_para', 14),
(39, '2019_03_01_141013_autor_demanda__telefone_null', 15),
(40, '2019_03_12_170445_demanda_cria_id_usuario_criacao', 16),
(41, '2019_03_12_174340_demanda_popula_id_usuario_criacao', 16),
(42, '2019_03_13_151710_situacao_demanda_registro__pronta', 17),
(43, '2019_03_15_095340_cria_indices_unicos', 18),
(44, '2019_04_03_094106_users_cria_cpf_telefone', 19),
(45, '2019_04_22_114947_situacao_demanda_add_novas_situacoes', 20),
(46, '2019_04_22_154126_demanda__coluna_data_resposta', 20),
(47, '2019_05_09_171950_orgao__cria_orgao_pai', 21),
(48, '2019_06_04_200624_permissao_popula_demanda_demanda_cadastrar', 22),
(49, '2019_06_25_202311_demanda_cria_coluna_sei_mp', 23),
(51, '2019_07_03_173731_demanda_cria_coluna_resumo_situacao', 24),
(52, '2019_06_29_015622_cria_conteudo', 25),
(53, '2019_08_01_010110_cria_geo_referencia', 26),
(54, '2019_08_12_134656_cria_tabela_natureza_orgao', 26),
(55, '2019_08_28_182246_geo_camada__coluna_rotulo', 27);

-- --------------------------------------------------------

--
-- Estrutura da tabela `naturezaorgao`
--

CREATE TABLE `naturezaorgao` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `natureza` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `naturezaorgao`
--

INSERT INTO `naturezaorgao` (`id`, `natureza`, `created_at`, `updated_at`) VALUES
(1, 'Judicial', NULL, NULL),
(2, 'MinistÃ©rio PÃºblico Federal', NULL, NULL),
(3, 'MinistÃ©rio PÃºblico Estadual', NULL, NULL),
(4, 'PolÃ­cia Federal', NULL, NULL),
(5, 'Outros', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `orgao`
--

CREATE TABLE `orgao` (
  `id` int(10) UNSIGNED NOT NULL,
  `idOrgaoPai` int(10) UNSIGNED DEFAULT NULL,
  `idNaturezaOrgao` bigint(20) UNSIGNED DEFAULT NULL,
  `orgao` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sigla` char(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` char(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone` char(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `orgao`
--

INSERT INTO `orgao` (`id`, `idOrgaoPai`, `idNaturezaOrgao`, `orgao`, `sigla`, `email`, `telefone`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'JUSTIÃ‡A FEDERAL - SEÃ‡ÃƒO JUDICIÃRIA DE SANTA CATARINA', 'TRF4/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(2, 64, 1, 'Advocacia-Geral da UniÃ£o - Procuradoria da UniÃ£o no Estado de Santa Catarina', 'AGU/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:26', '2019-07-17 21:58:52'),
(3, NULL, 5, 'SuperintendÃªncia do PatrimÃ´nio da UniÃ£o em Santa Caratina', 'SPU/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(5, NULL, 1, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DE SANTA CATARINA', 'PFN/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(7, 5, 1, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM CHAPECÃ“', 'PFN/PSFN/CHAPC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:26', '2019-07-18 00:04:28'),
(11, 5, 1, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM JOINVILLE', 'PFN/PSFN/JOINV', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:26', '2019-07-18 00:04:41'),
(12, 5, 1, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM LAGES', 'PFN/PSFN/LAGES', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:26', '2019-07-18 00:04:54'),
(40, NULL, 5, 'PREFEITURA MUNICIPAL DE SÃƒO JOSÃ‰', 'PM/SAO JOSE', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(44, 2, 1, 'ADVOCACIA-GERAL DA UNIÃƒO - SECCIONAL DE BLUMENAU', 'AGU/PSU/BNU/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:26', '2019-07-17 21:58:10'),
(45, 2, 1, 'ADVOCACIA-GERAL DA UNIÃƒO - SECCIONAL DE CHAPECÃ“', 'AGU/PSU/CCO/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:26', '2019-07-17 21:58:26'),
(46, 2, 1, 'ADVOCACIA-GERAL DA UNIÃƒO - SECCIONAL DE CRICIÃšMA', 'AGU/PSU/CCM/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 21:59:05'),
(47, 2, 1, 'ADVOCACIA-GERAL DA UNIÃƒO - SECCIONAL DE JOINVILLE', 'AGU/PSU/JVE/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 21:59:15'),
(48, NULL, 2, 'PROCURADORIA DA REPÃšBLICA EM SANTA CATARINA', 'MPF/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(49, 48, 2, 'PROCURADORIA DA REPÃšBLICA - BLUMENAU - SC', 'MPF/PRM/BNU/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:58:27'),
(50, 48, 2, 'PROCURADORIA DA REPÃšBLICA - CAÃ‡ADOR - SC', 'MPF/PRM/CCD/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:58:47'),
(51, 48, 2, 'PROCURADORIA DA REPÃšBLICA - CHAPECÃ“ - SC', 'MPF/PRM/CCO/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:59:12'),
(53, 48, 2, 'PROCURADORIA DA REPÃšBLICA - CRICIÃšMA - SC', 'MPF/PRM/CCM/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:59:53'),
(54, 48, 2, 'PROCURADORIA DA REPÃšBLICA - ITAJAÃ - SC', 'MPF/PRM/ITA/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:00:13'),
(56, 48, 2, 'PROCURADORIA DA REPÃšBLICA - JOAÃ‡ABA - SC', 'MPF/PRM/JBA/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:00:32'),
(57, 48, 2, 'PROCURADORIA DA REPÃšBLICA - JOINVILLE - SC', 'MPF/PRM/JVE/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:00:56'),
(59, 48, 2, 'PROCURADORIA DA REPÃšBLICA - MAFRA - SC', 'MPF/PRM/MFA/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:01:13'),
(60, 48, 2, 'PROCURADORIA DA REPÃšBLICA - RIO DO SUL - SC', 'MPF/PRM/RSL/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:01:40'),
(62, 48, 2, 'PROCURADORIA DA REPÃšBLICA - TUBARÃƒO- SC', 'MPF/PRM/TBO/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:01:59'),
(63, 64, 1, 'Advocacia-Geral da UniÃ£o - Procuradoria da UniÃ£o no Estado do ParanÃ¡', 'AGU/PR', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:56:25'),
(64, NULL, 1, 'Advocacia-Geral da UniÃ£o', 'AGU/DF', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(67, NULL, 3, 'Min.PÃºblico do Estado de Santa Catarina', 'MPE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(69, 79, 4, 'Delegacia de PolÃ­cia Federal em Joinville', 'DPF/JVE', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:02:49'),
(75, 79, 4, 'Delegacia de PolÃ­cia Federal em ItajaÃ­', 'DPF/IJI/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:57:56'),
(79, NULL, 4, 'DEPARTAMENTO DE POLÃCIA FEDERAL - SUPERINTENDÃŠNCIA REGIONAL EM SANTA CATARINA', 'SR/DPF/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(80, 118, 5, 'DEFENSORIA PÃšBLICA DA UNIÃƒO EM JOINVILLE', 'DPU/JOINVILLE', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:57:25'),
(82, 64, 1, 'Advocacia-Geral da UniÃ£o - Procuradoria da UniÃ£o no Estado do Rio Grande do Sul', 'AGU/RS', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-17 23:56:35'),
(83, NULL, 1, 'Procuradoria da UniÃ£o no Estado de Santa Catarina', 'PU/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(84, NULL, 1, 'PROCURADORIA REGIONAL DA UNIAO 4 REGIÃƒO', 'PRU4', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(85, 67, 3, 'MINISTÃ‰RIO PÃšBLICO DE SC - PROMOTORIA DE JUSTIÃ‡A DE LAGUNA', 'MPE/PJ/LAGUNA/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:03:34'),
(87, NULL, 1, '1Âª Vara Comarca de Porto Belo', 'JE-PJ/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(88, NULL, 1, 'Procuradoria Seccional da UniÃ£o em Santa Maria-RS', 'AGU SMA', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(97, NULL, 5, 'SUPERINTENDÃŠNCIA DO PATRIMÃ”NIO DA UNIÃƒO NO PARANÃ', 'SPU/PR', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(100, NULL, 1, 'TJSC/Itapema - 2Âª VARA CÃVEL', 'TJSC/Itapema - 2Âª VARA CÃVEL', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(101, 67, 3, 'MINISTÃ‰RIO PÃšBLICO DE SC - PROMOTORIA DE JUSTIÃ‡A DE JOINVILLE', 'MPE/PJ/JOINVILLE/SC', 'a_cadastrar@naoinformado.br', 'null', '2019-01-22 21:55:27', '2019-07-18 00:03:17'),
(103, NULL, 5, 'NÃƒO DEFINIDO', 'NÃƒO DEFINIDO', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(104, NULL, 1, 'JUSTIÃ‡A DO ESTADO DE SANTA CATARINA', 'JE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(107, NULL, 1, 'JustiÃ§a Federal- SeÃ§Ã£o JudiciÃ¡ria do Rio Grande do Sul', 'TRF4', 'rscar01sec@jfrs.jud.br', 'undefined', '2019-03-18 19:28:44', '2019-03-18 19:28:44'),
(108, NULL, 1, 'Poder JudiciÃ¡rio de Santa Catarina- Comarca de TubarÃ£o- 1Âª Vara Criminal', 'TJ/SC', 'tubarao.criminal1@tjsc.jus.br', '(48) 3621-1535', '2019-04-03 18:14:10', '2019-04-03 18:14:10'),
(110, 1, 1, '3Âª Vara Federal de ItajaÃ­', '3Âª Vara Federal de ItajaÃ­', 'scitaOS@jfsc.jus.br', '(47) 3341-5800', '2019-04-05 18:24:29', '2019-07-17 22:00:03'),
(111, NULL, 4, 'PolÃ­cia Federal', 'PF', 'delemaph.srsc@pf.gov.br', '(48)32816500', '2019-04-10 13:54:54', '2019-04-10 13:54:54'),
(112, NULL, 5, '7Âª Defensoria PÃºblica de ChapecÃ³', 'DPE/SC', 'renandesouza@defensoria.sc.gov.br', '(49) 2049-7621', '2019-04-10 18:10:42', '2019-04-10 18:10:42'),
(113, NULL, 1, 'VARA CÃVEL E DA FAZENDA PÃšBLICA DE PINHAIS - PARANÃ', 'TJ/PR', 'fksc@tjpr.jus.br', '41 3033-4606', '2019-04-23 13:46:35', '2019-04-23 13:46:35'),
(114, NULL, 1, 'Procuradoria da Fazenda Nacional em Curitiba', 'PFN/PR', 'luciano.bogo@pgfn.gov.br', '(41) 3310-3010', '2019-05-03 12:39:42', '2019-05-03 12:39:42'),
(115, 79, 4, 'DELEGACIA DE POLÃCIA FEDERAL EM CRICIÃšMA', 'DPF', 'dpf.cm.ccm.srsc@dpf.gov.br', '48 3461-8600', '2019-05-03 18:44:32', '2019-07-18 00:02:37'),
(116, 5, 1, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM CAXIAS/RS', 'PSFN-CXI-RS', 'thiago.costa@pgfn.gov.br', 'undefined', '2019-05-07 16:54:02', '2019-07-18 00:04:12'),
(117, NULL, 1, 'VARA DO TRABALHO DE IMBITUBA', 'Vara de Imbituba', 'vara_ima@trtl2.jus.br', '(48) 3255-0520', '2019-05-14 12:53:32', '2019-05-14 12:53:32'),
(118, NULL, 5, 'DEFENSORIA PÃšBLICA DA UNIÃƒO EM SANTA CATARINA', 'DPU/SC', 'dpu.sc@dpu.def.br', '(48) 3221-9400', '2019-06-04 14:03:05', '2019-06-04 14:03:05'),
(119, 1, 1, '6Âª VARA FEDERAL DE FLORIANÃ“POLIS', 'JF', 'scflp06@jfsc.jus.br', '048-3251-2565', '2019-06-04 16:22:10', '2019-06-04 16:22:10'),
(120, 64, 1, 'PROCURADORIA-REGIONAL DA UNIÃƒO DA 4Âª REGIÃƒO', 'PRU4', 'sadi.tolfo@agu.gov.br', '(51) 3511-6557', '2019-06-04 19:33:28', '2019-06-04 19:33:28'),
(121, NULL, 1, 'COORDENAÃ‡ÃƒO-GERAL JURÃDICA DE CONTENCIOSO JUDICIAL E ADMINISTRATIVO', 'CONJUR-PDG', 'nÃ£o@nÃ£o.br', '(00) 000000000', '2019-07-24 16:06:05', '2019-07-24 16:06:05'),
(122, 1, 1, '1Âª Vara Federal de Blumenau', 'SCBLU01', 'scblu01@jfsc.jus.br', '(47) 3231-6800', '2019-08-06 20:19:03', '2019-08-06 20:19:03');

-- --------------------------------------------------------

--
-- Estrutura da tabela `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissao`
--

CREATE TABLE `permissao` (
  `id` int(10) UNSIGNED NOT NULL,
  `permissao` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `permissao`
--

INSERT INTO `permissao` (`id`, `permissao`, `descricao`, `created_at`, `updated_at`) VALUES
(2, 'DEMANDA_ORGAO_CADASTRAR', 'Permite cadastrar/editar Ã³rgÃ£os', NULL, NULL),
(3, 'DEMANDA_PROCEDIMENTO_CADASTRAR', 'Permite cadastrar/editar procedimentos', NULL, NULL),
(4, 'DEMANDA_AUTOR_CADASTRAR', 'Permite gerenciar o cadastro de demandantes', NULL, NULL),
(5, 'DEMANDA_DEMANDA_CADASTRAR', 'Permite cadastrar/editar demandas', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `poloprocedimentoexterno`
--

CREATE TABLE `poloprocedimentoexterno` (
  `id` int(10) UNSIGNED NOT NULL,
  `polo` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `poloprocedimentoexterno`
--

INSERT INTO `poloprocedimentoexterno` (`id`, `polo`, `created_at`, `updated_at`) VALUES
(1, 'Indefinido', NULL, NULL),
(2, 'Interessado', NULL, NULL),
(3, 'Ativo', NULL, NULL),
(4, 'Passivo', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `procedimentoexterno`
--

CREATE TABLE `procedimentoexterno` (
  `id` int(10) UNSIGNED NOT NULL,
  `idTipoProcedimentoExterno` int(10) UNSIGNED DEFAULT NULL,
  `idPoloProcedimentoExterno` int(10) UNSIGNED NOT NULL,
  `procedimento` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `resumo` char(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `chave` char(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `procedimentoexterno`
--

INSERT INTO `procedimentoexterno` (`id`, `idTipoProcedimentoExterno`, `idPoloProcedimentoExterno`, `procedimento`, `resumo`, `descricao`, `chave`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '1.33.005.000766/2018-85', NULL, NULL, NULL, NULL, '2019-02-22 23:25:12'),
(2, 3, 1, '017717-19.2014.4.04.7204', NULL, NULL, NULL, NULL, '2019-02-22 23:22:28'),
(3, 3, 1, '5004586-17.2018.4.04.7210', NULL, NULL, NULL, '2019-02-22 17:54:08', '2019-02-22 23:22:38'),
(5, 1, 1, '00000000', 'Procedimento FictÃ­cio', 'Procedimento FictÃ­cio', NULL, '2019-02-22 23:55:01', '2019-03-06 18:42:51'),
(7, 3, 3, '5001006-63.2015.4.04.7216', 'DemoliÃ§Ã£o de Quiosque em Garopaba', 'DemoliÃ§Ã£o de Quiosque em Garopaba', '218229081115', '2019-03-06 18:01:56', '2019-03-07 14:20:08'),
(8, 1, 1, '1.33.005.000535/2017-31', 'Ranchos no CondomÃ­nio Village III - Lagoa da ConceiÃ§Ã£o', 'Encaminha recomendaÃ§Ã£o pelo cancelamento do RIP nÂº 8105.0005837-59', 'undefined', '2019-03-06 18:10:28', '2019-03-06 18:10:28'),
(9, 3, 1, '0300584-69.2016.8.24.0040', 'UsucapiÃ£o - Angela Cristina de Oliveira', 'undefined', 'UZFOQK', '2019-03-06 18:25:31', '2019-03-06 18:25:31'),
(10, 1, 1, '1.33.008.000491/2016-98', 'Irregularidades na Praia Central de BalneÃ¡rio CamboriÃº - Quiosques na Orla', 'undefined', 'undefined', '2019-03-06 18:30:26', '2019-03-06 18:30:26'),
(11, 3, 1, '50000776920114047216', 'Loteamento Praia da Galheta', 'undefined', '723199534411', '2019-03-06 18:36:56', '2019-03-06 18:36:56'),
(12, 1, 1, '5018749-51.2017.4.04.7205', 'Gaspar/SC x Osmar Goedert e Outros', 'Gaspar/SC x Osmar Goedert e Outros', 'undefined', '2019-03-06 18:47:38', '2019-03-06 18:47:38'),
(13, 2, 3, '5000504-22.2018.4.04.7216', 'MPF e UniÃ£o x MunicÃ­pio de Laguna/SC e Ravena Cassino Hotel', 'undefined', '447906024518', '2019-03-06 19:03:24', '2019-03-06 19:03:24'),
(14, 3, 1, '5000380-18.2017.4.04.7202', 'UsucapiÃ£o - LAIR BIESEK E OUTROS', 'UsucapiÃ£o - LAIR BIESEK E OUTROS', '932128540917', '2019-03-06 19:09:29', '2019-03-06 19:09:29'),
(15, 1, 1, '1.33.005.000088/2016-99', 'Carcinicultura - JosÃ© EugÃªnio Thuon', 'undefined', NULL, '2019-03-06 19:15:00', '2019-03-14 12:58:04'),
(16, 3, 1, '5024540-79.2018.4.04.7200', 'UsucapiÃ£o - FLORISBELA BECKER', 'undefined', '297938811118', '2019-03-07 13:47:17', '2019-03-07 13:47:17'),
(17, 2, 4, '50048399820194047200', NULL, 'Requer em pedido liminar o embargo das obras na regiÃ£o do Monumento Natural Municipal da Galheta, bem como para que a empresa rÃ© se abstenha de realizar qualquer ato que\ndescaracterize o entorno do parque municipal da Galheta,', 'undefined', '2019-03-07 17:56:52', '2019-03-07 17:56:52'),
(18, 2, 3, '5006478-25.2017.4.04.7200', NULL, 'Objetiva determinar que a rÃ© ocupante de edificaÃ§Ã£o Ã s margens da Lagoa da ConceiÃ§Ã£o, seja impedida de promover novas construÃ§Ãµes ou reformas que impliquem\r\nacrÃ©scimo da Ã¡rea edificada jÃ¡ existente.', '172433201217', '2019-03-07 18:10:49', '2019-03-21 13:19:59'),
(19, 3, 4, '5000076-06.2019.4.04.7216', 'UsucapiÃ£o- Mirta Raquel Melo de Souza', 'UsucapiÃ£o Federal', '272149259319', '2019-03-08 12:57:50', '2019-03-08 13:00:07'),
(20, 3, 4, '5000479-03.2018.4.04.7218', 'Autor- Cecilia Terezinha Medeiros Hinsching', 'AÃ§Ã£o de DemarcaÃ§Ã£o/DivisÃ£o', 'undefined', '2019-03-08 16:53:02', '2019-03-08 16:57:37'),
(21, 1, 4, '1.33.005.000365/2016-63', 'Ilha dos Barcos, na BaÃ­a da Babitonga, SÃ£o Francisco do Sul', 'InquÃ©rito para apurar falta de resposta a demanda do MPF (04972.004280/2016-64)', 'undefined', '2019-03-11 12:56:46', '2019-06-07 22:37:03'),
(22, 2, 4, '5007306-47.2019.4.04.7201', 'Casa de OraÃ§Ã£o ao Deus Vivo do CÃ©u - SÃ£o Francisco do Sul', 'demoliÃ§Ã£o de estrutura metÃ¡lica echalÃ©s em Ã¡rea de preservaÃ§Ã£o permanente localizada na Rodovia Duque de Caxias, 344, em Ubatuba, SÃ£oFrancisco   do   Sul,   Ã s   margens   do   Rio   AcaraÃ­,   bem   como   a   recuperaÃ§Ã£o   ambiental   da   referida   Ã¡rea   e   acondenaÃ§Ã£o dos rÃ©us no pagamento de indenizaÃ§Ã£o pelos danos causados ao meio ambiente.', '285382332819', '2019-03-11 13:40:59', '2019-06-03 19:48:19'),
(23, 3, 4, '5009506-58.2018.4.04.7202', 'Autor: Heitor Pasqualotto', 'Requer a exclusÃ£o da condiÃ§Ã£o de ocupante do terreno de marinha- RIP 8111.0000472-15.', 'undefined', '2019-03-11 13:52:09', '2019-03-11 13:52:09'),
(24, 1, 1, '1.33.000.002302/2017-72', 'Quilombola Vidal Martins', 'Versa sobre as dificuldades enfrentadas por membros da Comunidade Tradicional Quilombola Vidal Martins, localizada no Rio Vermelho, para trabalhar com artesanato cultural, nas\npraias dessa capitai durante a temporada de verÃ£o.', 'undefined', '2019-03-11 17:18:42', '2019-03-11 17:18:42'),
(25, 3, 4, '5024429-95.2018.4.04.7200', 'Autor : Florisbela Becker', 'UsucapiÃ£o Federal.', '246318530218', '2019-03-11 17:28:10', '2019-03-11 17:29:11'),
(26, 3, 4, '5001852-75.2018.4.04.7216', 'Autor: Daniel Pedro Cardoso', 'UsucapiÃ£o Federal', '826249574818', '2019-03-11 17:38:32', '2019-03-11 17:38:32'),
(27, 3, 4, '5000938-19.2019.4.04.7202', 'Autor : Reinaldo Benedetti', 'UsucapiÃ£o Federal', 'undefined', '2019-03-11 17:56:49', '2019-03-11 17:56:49'),
(28, 3, 1, '5017217-23.2018.4.04.7200', 'BiguaÃ§u x AndrÃ© Teixeira', 'ManifestaÃ§Ã£o sobre interesse da UniÃ£o', '441871867018', '2019-03-11 18:02:38', '2019-03-11 18:02:38'),
(29, 2, 4, '5020980-03.2016.4.04.7200', 'Autor : MPF', 'ConstruÃ§Ã£o irregular em terreno de marinha na Rod. Baldicero Filomeno, em FlorianÃ³polis', '451015618316', '2019-03-11 18:29:27', '2019-05-17 19:03:08'),
(30, 3, 2, '5026977-93.2018.4.04.7200', 'UsucapiÃ£o - Orides Nervis', 'AÃ§Ã£o de usucapiaÃ£o COM interesse de UniÃ£o.', '851786178118', '2019-03-11 18:30:18', '2019-03-11 18:30:18'),
(31, 3, 2, '5021829-04.2018.4.04.7200', 'UsucapiÃ£o - Saturnino Pedro da Silva.PalhoÃ§a', 'UsucapiÃ£o Federal', '247129634118', '2019-03-11 18:36:31', '2019-05-17 17:36:29'),
(32, 3, 1, '5000236-58.2019.4.04.7207', 'Registro de ImÃ³vel da ex-RFFSA - CartÃ³rio de TubarÃ£o 2Âº OfÃ­cio', 'Em que pese a SPU aparentemente jÃ¡ tenha se negado administrativamente a requerer aabertura da matrÃ­cula, requer-se informar, no prazo de 20 dias, se reconsidera ou se mantÃ©m a mesma posiÃ§Ã£o', '932893631619', '2019-03-11 19:25:17', '2019-03-11 19:25:17'),
(33, 3, 2, '5017252-80.2018.4.04.7200', 'MunicÃ­pio de BiguaÃ§u x JosÃ© Pedro FabrÃ­cio', 'MunicÃ­pio de BiguaÃ§u x JosÃ© Pedro FabrÃ­cio', '283774910718', '2019-03-12 12:43:56', '2019-03-12 12:43:56'),
(34, 3, 1, '5006002-94.2011.4.04.7200', 'CÃ¡lculo de IndenizaÃ§Ã£o - PrÃ©dio ao lado da sede da PUSC - ImobiliÃ¡ria AcrÃ³pole', 'undefined', '260303422411', '2019-03-12 14:00:55', '2019-03-12 14:00:55'),
(35, 2, 2, '5012709-68.2017.4.04.7200', 'ConstruÃ§Ãµes em APP no PÃ¢ntano do Sul - MPF x Messias Seroa Mota e Outros', 'undefined', '722644037817', '2019-03-12 14:56:51', '2019-03-12 14:56:51'),
(36, 3, 4, '5020687-67.2015.4.04.7200', 'NEZITA APARECIDA DE ANDRADE x ANTONIO CURCIO, UNIÃƒO E OUTROS', 'NEZITA APARECIDA DE ANDRADE x ANTONIO CURCIO, UNIÃƒO E OUTROS', '143728697215', '2019-03-12 18:16:25', '2019-03-12 18:16:25'),
(37, 3, 4, '5011516-18.2017.4.04.7200', 'Autor : FlorianÃ³polis VeÃ­culos S.A', 'RetificaÃ§Ã£o do valor cobrado a tÃ­tulo de taxa de ocupaÃ§Ã£o.', 'undefined', '2019-03-13 17:18:00', '2019-03-13 17:18:00'),
(38, 3, 3, '5013253-46.2014.4.04.7205', 'RFFSA', 'Decretar a nulidade de todos os atos processuais posteriores Ã  citaÃ§Ã£o e da sentenÃ§a prolatada no\nprocesso de RetificaÃ§Ã£o de Registro ImobiliÃ¡rio nÂ° 1.899/1992 (031.92.000091-7)', '535017622314', '2019-03-13 18:16:03', '2019-03-13 18:16:03'),
(39, 3, 4, '5001356-36.2019.4.04.7208', 'SolicitaÃ§Ã£o de subsÃ­dios para defesa da UniÃ£o em processo de revisÃ£o cadastral.', 'O ocupante questiona a data adotada para a revisÃ£o do cadastro.\nProjeto Orla de Bombinhas/SC', 'undefined', '2019-03-13 18:22:26', '2019-03-13 18:22:26'),
(40, 3, 4, '5001817-63.2018.4.04.7201', 'Autor : Anete Ivanete Do Rosario', 'UsucapiÃ£o Federal', '197738078318', '2019-03-13 18:53:25', '2019-03-13 18:53:25'),
(41, 2, 1, '5010704-49.2017.4.04.7208', 'Dano Ambiental. Porto Belo', 'DemoliÃ§Ã£o de edificaÃ§Ã£o que ocupa ilegalmente  Ã¡rea de preservaÃ§Ã£o permanente (APP) e terreno de marinha, a recuperaÃ§Ã£o da Ã¡rea degradada e a regularizaÃ§Ã£o da ocupaÃ§Ã£o perante a Secretaria do PatrimÃ´nio da UniÃ£o (SPU) ou, subsidiariamente, o pagamento de indenizaÃ§Ã£o compensatÃ³ria', '518991930417', '2019-03-13 19:51:19', '2019-03-13 19:51:19'),
(42, 2, 4, '5002003-33.2011.4.04.7201', 'Dano ambiental, Responsabilidade civil', 'Solicita indicaÃ§Ã£o de assistente tÃ©cnico e apresentaÃ§Ã£o de quesitos no que toca a perÃ­cia de engenharia.\nO feito tem conexÃ£o com os autos da aÃ§Ã£o civil pÃºblica n. 5001840-53.2011.404.7201.', '642517598711', '2019-03-14 11:39:31', '2019-03-14 11:39:31'),
(43, 3, 4, '5022976-65.2018.4.04.7200', 'USUCAPIÃƒO - IMÃ“VEL EM TERRENOS DE MARINHA E SEUS ACRESCIDOS', 'ManifestaÃ§Ã£o de interesse da UniÃ£o.', '398453667818', '2019-03-14 11:56:18', '2019-03-14 11:56:18'),
(44, 3, 2, '5000569-95.2019.4.04.7211', 'UsucapiÃ£o em imÃ³vel que possui o INCRA como um dos confinantes.', 'SolicitaÃ§Ã£o de manifestaÃ§Ã£o de eventual interesse na lide.', '736916805919', '2019-03-14 12:05:56', '2019-03-14 12:05:56'),
(45, 3, 4, '5003695-12.2012.4.04.7208', 'Autor : CondomÃ­nio EdifÃ­cio Residencial ItambeÃ­', 'Decretada a nulidade do procedimento demarcatÃ³rio por ausÃªncia de intimaÃ§Ã£o pessoal dos interessados.', 'undefined', '2019-03-14 13:25:46', '2019-03-14 13:25:46'),
(46, 3, 4, '5011921-51.2017.4.04.7201', 'Autor : Lourival Bertotti e Maria Delourdes Soethe Bertotti', 'UsucapiÃ£o Federal', '598191586217', '2019-03-14 13:48:13', '2019-06-07 19:52:17'),
(47, 3, 4, '5003134-02.2018.4.04.7200', 'Autor : Germano Alves Filho', 'UsucapiÃ£o Federal', '590623337518', '2019-03-14 14:20:42', '2019-03-14 14:20:42'),
(48, 2, 3, '5011583-90.2016.4.04.7208', 'Cumprimento de sentenÃ§a-DemoliÃ§Ã£o BalneÃ¡rio CamboriÃº', 'Cumprimento de sentenÃ§a que determinou a DemoliÃ§Ã£o de imÃ³vel localizado Ã s margens do rio CamboriÃº, Rua Dom Afonso, 750,  BalneÃ¡rio CamboriÃº.', '123666724816', '2019-03-14 17:27:24', '2019-03-14 17:27:24'),
(50, 2, 1, '5024723-84.2017.4.04.7200', 'Desfazimento de construÃ§Ãµes- Lagoa da ConceiÃ§Ã£o', 'ACP promovida pelo MUNICÃPIO DE FLORIANÃ“POLIS em face de CRISTINA CORSETTI e outro, que objetiva o desfazimento de construÃ§Ãµes na Lagoa da ConceiÃ§Ã£o.', '737986474117', '2019-03-14 18:15:38', '2019-03-14 18:15:38'),
(51, 2, 4, '5017111-66.2015.4.04.7200', 'Dano Ambiental- Lagoa da ConceiÃ§Ã£o', 'Esta demanda, alÃ©m do cumprimento das obrigaÃ§Ãµes decorrentes da decisÃ£o proferida nos autos da AÃ§Ã£o Civil PÃºblica nÂº 2003.72.00.007539-1 (autos digitais n.Â° 5025133-50.2014.404.7200), movida pelo MinistÃ©rio PÃºblico Federal em face do MunicÃ­pio de FlorianÃ³polis, cuja sentenÃ§a foi mantida pelo Tribunal Regional da 4Âª RegiÃ£o, tem por objetivo a proteÃ§Ã£o ambiental, recuperaÃ§Ã£o da Ã¡rea degradada e a promoÃ§Ã£o do livre acesso pÃºblico Ã s margens da Lagoa da ConceiÃ§Ã£o.', '672617577915', '2019-03-14 18:36:18', '2019-03-14 18:36:18'),
(52, 3, 4, '5015140-41.2018.4.04.7200', 'UsucapiÃ£o- Betina Maria Adams', 'UsucapiÃ£o Federal', '687178837918', '2019-03-14 19:21:42', '2019-03-14 19:21:42'),
(53, 3, 2, '5002753-34.2013.4.04.7211', 'ReintegraÃ§Ã£o de Posse- ALL', 'AÃ§Ã£o de ReintegraÃ§Ã£o / ManutenÃ§Ã£o De Posse nÂº 5002753-34.2013.4.04.7211, proposta por ALL - AMERICA LATINA LOGISTICA MALHA SUL S.A em face de FRANCISCO SARTOR.', '520960228913', '2019-03-14 19:41:15', '2019-03-14 19:41:15'),
(54, 2, 3, '5022064-05.2017.4.04.7200', 'ConstruÃ§Ã£o irregular na Ponta do Papagaio, em PalhoÃ§a/SC.', 'ManifestaÃ§Ã£o acerca do Laudo Pericial', '817266433917', '2019-03-15 11:52:40', '2019-03-15 11:52:40'),
(55, 3, 4, '5013946-06.2018.4.04.7200', 'USUCAPIÃƒO - IMÃ“VEL EM TERRENOS DE MARINHA E SEUS ACRESCIDOS', 'subsÃ­dios de fato e de direito para a defesa da UniÃ£o na aÃ§Ã£o de usucapiÃ£o, especialmente ratificando\nou retificando o parecer tÃ©cnico nÂº COCAP-SP-SC 0105862.', '788825671818', '2019-03-15 12:28:23', '2019-03-15 12:28:23'),
(56, 1, 1, '1.33.000.002571/2016-58', 'Pratica ilegal de pesca na Ponte Colombo Sales', 'Pratica ilegal de pesca na Ponte Colombo Sales', 'undefined', '2019-03-15 14:20:21', '2019-03-15 14:20:21'),
(58, 3, 4, '5006608-41.2019.4.04.7201', 'UsucapiÃ£o. Antonio Pedro de Oliveira', 'UsucapiÃ£o Federal', '621438588819', '2019-03-15 19:05:07', '2019-03-15 19:05:07'),
(59, 3, 4, '5002944-90.2019.4.04.7204', 'UsucapiÃ£o. Everaldo GonÃ§alves De Borba', 'UsucapiÃ£o Federal', '959072475519', '2019-03-15 19:13:55', '2019-03-15 19:13:55'),
(60, 3, 3, '5003076-54.2018.4.04.7214', 'RFFSA. ReintegraÃ§Ã£o.', 'ReintegraÃ§Ã£o de posse ajuizada pela extinta Rede FerroviÃ¡ria Federal S.A -\nRFFSA, cumulada com indenizaÃ§Ã£o.', '338577871718', '2019-03-15 19:20:44', '2019-03-15 19:20:44'),
(61, 3, 4, '5017188-70.2018.4.04.7200', 'UsucapiÃ£o em Terreno de Marinha', 'Terreno com Ã¡rea de 360,00 m2, situada na Rua Capistrano, Ponte do Imaruim, PalhoÃ§a, SC.', '688507309018', '2019-03-18 16:12:15', '2019-03-18 16:12:15'),
(62, 2, 4, '5015022-02.2017.4.04.7200', 'Zona Costeira PÃ¢ntano do Sul', 'Zona Costeira PÃ¢ntano do Sul - atÃ© a Praia do Saquinho', '956781482417', '2019-03-18 17:29:56', '2019-03-18 17:35:01'),
(63, 2, 4, '5005552-80.2013.4.04.7201', 'Cumprimento de SentenÃ§a. Elaborar PRAD. Av. AtlÃ¢ntica, nÂº 1225, Praia de Enseada, MunicÃ­pio de SÃ£o Francisco do Sul/SC', 'Condenar o MunicÃ­pio de SÃ£o Francisco do Sul e a UniÃ£o nas obrigaÃ§Ãµes de fazer consistentes:a.1) na elaboraÃ§Ã£o de Plano de RecuperaÃ§Ã£o da Ãrea Degradada - PRAD, a ser submetido ao crivo do IBAMA e da FATMA, o qual deverÃ¡ prever a integral recuperaÃ§Ã£o ambiental; a.2) na adoÃ§Ã£o de todas as medidas afetas ao seu poder de polÃ­cia, para assegurar o efetivo cumprimento do PRAD e impedir novas interferÃªncias no local dos fatos, sem a observÃ¢ncia dos requisitos legais necessÃ¡rios para tanto; b) condenar todos os rÃ©us, solidariamente, na obrigaÃ§Ã£o de fazer consistente na efetiva execuÃ§Ã£o do PRAD a ser elaborado.', '473243210613', '2019-03-18 18:34:54', '2019-07-05 19:46:55'),
(64, 3, 1, '0307365-45.2018.8.24.0038', 'IndenizaÃ§Ã£o por Danos Materiais. Joinville', 'IndenizaÃ§Ã£o por danos materiais causados pela passagem de tubulaÃ§Ã£o que percorreu o\nimÃ³vel do autor.', 'undefined', '2019-03-18 19:21:23', '2019-03-18 19:21:23'),
(65, 3, 1, '5003250-94.2017.4.04.7118', 'Pedido de Quebra de Sigilo de dados', 'Pedido de Quebra de Sigilo de dados', 'undefined', '2019-03-18 19:32:32', '2019-03-18 19:34:07'),
(66, 3, 4, '5002736-06.2019.4.04.7205', 'UsucapiÃ£o - Terreno de Marinha', 'undefined', '287388354119', '2019-03-19 11:38:53', '2019-03-19 11:38:53'),
(67, 3, 2, '5007764-04.2018.4.04.7200', 'AÃ§Ã£o Penal Ã¡rea de preservaÃ§Ã£o permanente situada na EstaÃ§Ã£o EcolÃ³gica de CarijÃ³s.', 'undefined', '665048777518', '2019-03-19 11:57:28', '2019-03-19 11:57:28'),
(68, 3, 3, '0001690-49.2014.8.24.0125', 'AÃ§Ã£o Penal. Itapema', 'Declarada a perda em favor da UniÃ£o do ImÃ³vel registrado sob a matrÃ­cula de nÂº 1482 do ofÃ­cio do registro de imÃ³veis de Itapema, constituÃ­do pelo apartamento nÂº 302,  CondomÃ­nio EdifÃ­cio Apolonia.', 'undefined', '2019-03-19 13:04:07', '2019-03-19 13:04:07'),
(71, 2, 3, '5011483-62.2016.4.04.7200', 'Dano Ambiental. Enseada do Brito. PalhoÃ§a', 'DesocupaÃ§Ã£o da Ã¡rea e a recuperaÃ§Ã£o do meio ambiente.', '186966330016', '2019-03-19 13:31:54', '2019-03-19 13:31:54'),
(72, 3, 3, '5017354-05.2018.4.04.7200', 'Embargo de Obra. BiguaÃ§u', 'Embargo judicial da obra, no imÃ³vel do Requerido, localizado na ServidÃ£o Ana Clara de Oliveira Vitorino, esquina com a Rua Pery Cabral, Bairro Prado de Baixo â€“BiguaÃ§u/SC.', '745483721718', '2019-03-19 14:06:55', '2019-03-19 14:06:55'),
(73, 2, 4, '5006587-39.2017.4.04.7200', 'Dano Ambiental. JurerÃª. FlorianÃ³polis', 'DesocupaÃ§Ã£o e demoliÃ§Ã£o de construÃ§Ãµes em terrenos de marinha.', '966058141817', '2019-03-19 14:20:41', '2019-03-19 14:20:41'),
(74, 2, 3, '5003268-39.2017.4.04.7208', 'Dano Ambiental. Bombinhas', 'CondenaÃ§Ã£o dos demandados na demoliÃ§Ã£o de edificaÃ§Ã£o irregular em Ã¡rea de preservaÃ§Ã£o   permanente e a recuperaÃ§Ã£o  de vegetaÃ§Ã£o de restinga, mediante a apresentaÃ§Ã£o e execuÃ§Ã£o de Projeto de RecuperaÃ§Ã£o Ambiental (PRAD), a ser submetido a licenciamento ambiental perante a FAMAB, alÃ©m da regularizaÃ§Ã£o da ocupaÃ§Ã£o perante a SPU.', '864157664517', '2019-03-19 18:27:49', '2019-03-19 18:27:49'),
(75, 2, 2, '5010681-06.2017.4.04.7208', 'Dano Ambiental. Rio Santa Luzia. Porto Belo', 'ObtenÃ§Ã£o de provimento judicial determinando a demoliÃ§Ã£o de edificaÃ§Ã£o que ocupa ilegalmente Ã¡rea de preservaÃ§Ã£o permanente (APP) e terreno de marinha, a recuperaÃ§Ã£o da Ã¡rea degradada e a regularizaÃ§Ã£o da ocupaÃ§Ã£o perante a Secretaria do PatrimÃ´nio da UniÃ£o (SPU) ou, subsidiariamente, o pagamento de indenizaÃ§Ã£o compensatÃ³ria', '255894199217', '2019-03-19 18:52:01', '2019-03-19 18:52:01'),
(76, 3, 2, '5027026-76.2014.4.04.7200', 'Trata-se de anÃ¡lise e aprovaÃ§Ã£o de PRAD - Projeto de RecuperaÃ§Ã£o Ambiental de Ãrea Degradada e Enriquecimento Florestal', 'undefined', '480755503814', '2019-03-20 14:04:11', '2019-03-20 14:04:11'),
(77, 3, 4, '5006281-09.2018.4.04.7209', 'UsucapiÃ£o. Vitoria Maria Pinto Cortes', 'UsucapiÃ£o Federal.', '283701813618', '2019-03-20 17:50:48', '2019-03-20 17:50:48'),
(78, 2, 4, '5010762-18.2013.4.04.7200', 'ConstruÃ§Ã£o irregular na Praia das Cordas - Gov. Celso Ramos', 'ConstruÃ§Ã£o irregular na Praia das Cordas - Gov. Celso Ramos\r\nMPF x UniÃ£o, MunicÃ­pio e Artino Severiano da Silva', 'undefined', '2019-03-21 13:26:55', '2019-03-21 13:26:55'),
(79, 4, 1, '1.33.000.000410/2019-72', 'Reveillon PrivillÃ©gio Ano I - Cachoeira do Bom Jesus - FlorianÃ³polis/SC', 'Instaurada para apurar ocupaÃ§Ã£o de bem da UniÃ£o para realizaÃ§Ã£o da festa de reveillon \"Reveillon PrivillÃ©gio Ano l - Open  Bar /Open  Food\" ocorrida entre  31/12/2018  e 01/02/2019 na faixa de areia prÃ³xima Ã  Rua Jardim Giselle e a ServidÃ£o da Enseada, na Cachoeira do Bom Jesus, em FlorianÃ³polis/SC, sob a responsabilidade de Flow Eventos - Floripa e Life Club Floripa.', 'undefined', '2019-03-21 17:14:45', '2019-03-21 17:14:45'),
(80, 3, 4, '5008656-92.2018.4.04.7205', 'UsucapiÃ£o - ImÃ³vel em Ã¡reas de defesa das vias federais de comunicaÃ§Ã£o', 'undefined', '696735746618', '2019-03-25 12:29:04', '2019-03-25 12:29:04'),
(81, 2, 3, '5015193-27.2015.4.04.7200', 'ACP - Praia de Fora - PalhoÃ§a/SC', 'HomologaÃ§Ã£o de acordo.', '716980133515', '2019-03-25 13:28:55', '2019-03-25 13:28:55'),
(82, 2, 1, '5010689-80.2017.4.04.7208', 'Dano Ambiental Porto Belo, Rio Santa Luzia', 'Interromper a degradaÃ§Ã£o ambiental â€“ poluiÃ§Ã£o do rio Santa Luzia, localizado em Porto Belo â€“ que resulta da atividade comercial de peixarias e de outros estabelecimentos comerciais.', '645212937617', '2019-03-25 17:44:46', '2019-03-25 17:44:46'),
(83, 4, 1, '1.33.008.000067/2019-96', 'Avarias em ImÃ³vel tombado. Receita Federal. ItajaÃ­', 'NotÃ­cia de Fato autuada a partir de encaminhamento pelo MinistÃ©rio PÃºblico Estadual de cÃ³pia de auto de constataÃ§Ã£o DC nÂº 12-19, cujo conteÃºdo narra a existÃªncia de avarias em imÃ³vel possivelmente tombado pelo patrimÃ´nio histÃ³rico e artÃ­stico nacional, onde funciona a Receita Federal DO Brasil, no MunicÃ­pio de ItajaÃ­/SC.', 'undefined', '2019-03-25 18:09:08', '2019-03-25 18:09:08'),
(84, 3, 2, '5021739-64.2016.4.04.7200', 'Arresto de Direito de OcupaÃ§Ã£o', 'undefined', 'undefined', '2019-03-26 11:39:17', '2019-03-26 11:39:17'),
(85, 3, 2, '5002269-33.2015.4.04.7216', 'Arresto de Direito de OcupaÃ§Ã£o', 'undefined', 'undefined', '2019-03-26 12:58:56', '2019-03-26 12:58:56'),
(86, 3, 2, '5003626-28.2017.4.04.7200', 'Arresto de direito de ocupaÃ§Ã£o', 'undefined', 'undefined', '2019-03-26 13:00:50', '2019-03-26 13:00:50'),
(87, 3, 2, '5010253-48.2017.4.04.7200', 'Arresto de direito de ocupaÃ§Ã£o', 'undefined', 'undefined', '2019-03-26 13:01:06', '2019-03-26 13:01:06'),
(88, 2, 3, '5015139-56.2018.4.04.7200', 'Dano Ambiental. Praia dos Ingleses.', 'DemoliÃ§Ã£o de edificaÃ§Ã£o que ocupa ilegalmente Ã¡rea de preservaÃ§Ã£o permanente (APP) e a recuperaÃ§Ã£o da Ã¡rea degradada.', '98922632223818', '2019-03-26 13:56:11', '2019-03-26 13:56:11'),
(89, 3, 4, '5016699-77.2016.4.04.7208', 'CondomÃ­nio Residencial  Ernesto ChÃª Guevara. Maria Isabel Oliveira', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o', '203780049716', '2019-03-26 16:32:37', '2019-03-26 16:32:37'),
(90, 3, 1, '0300079-26.2017.8.24.0143â€‹', 'ServidÃ£o Mineral', 'undefined', 'undefined', '2019-03-26 16:39:46', '2019-03-26 16:39:46'),
(91, 3, 4, '5016314-32.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Ricardo de Oliveira', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '650931770016', '2019-03-26 16:40:12', '2019-03-26 16:40:12'),
(93, 3, 4, '5016287-49.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Rafaela Coelho', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o', '848585940116', '2019-03-26 16:45:14', '2019-03-26 16:49:03'),
(94, 3, 4, '5016274-50.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Everton Voitena', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '247758643416', '2019-03-26 16:51:47', '2019-03-26 16:51:47'),
(95, 3, 4, '5017393-46.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Chaiane Rute da Silva', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '703249808516', '2019-03-26 16:57:40', '2019-03-26 16:57:40'),
(96, 3, 4, '5016268-43.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. VinÃ­cius Freitas', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '207361433016', '2019-03-26 17:26:33', '2019-03-26 17:26:33'),
(97, 3, 4, '5017163-04.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Simoni do Nascimento da Costa', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '519804573416', '2019-03-26 17:31:53', '2019-03-26 17:31:53'),
(98, 3, 4, '5017156-12.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '731077706216', '2019-03-26 17:35:38', '2019-03-26 17:35:38'),
(99, 3, 4, '5017161-34.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Gabriela Steil Andriani', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '345626800316', '2019-03-26 17:56:47', '2019-03-26 17:56:47'),
(101, 3, 4, '5016270-13.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Nauef Miranda de Jesus', 'SuspensÃ£o daeficÃ¡cia da clÃ¡usula sexta do contrato de doaÃ§Ã£o com encargo, firmado entre o MunicÃ­pio de Tijucas e a UniÃ£o, registrado perante a SPU-SC no livro nÂº SC-014- TERMOS DIVERSOS E ESCRITURAS Ã s fls. 68/70, atÃ© que os ajustes de prorrogaÃ§Ã£o estejam concluÃ­dos.', '461666744816', '2019-03-26 18:27:24', '2019-03-26 18:27:24'),
(102, 3, 4, '50171613420164047208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Gabriela Steil  Andriani', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '345626800316', '2019-03-26 18:35:46', '2019-03-26 18:35:46'),
(103, 3, 4, '5017395-16.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Olaria Eufrasia da Silva', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '262566792216', '2019-03-26 18:54:09', '2019-03-26 18:54:09'),
(104, 3, 4, '5017131-96.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Francielli Petry Kossmann', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '340246718116', '2019-03-26 19:08:04', '2019-03-26 19:08:04'),
(105, 3, 4, '5017390-91.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Gesica Dutra', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o', '230804232116', '2019-03-26 19:52:43', '2019-03-26 19:52:43'),
(106, 1, 1, '1.33.005.00297/2016-32', 'FiscalizaÃ§Ã£o Ambiental em ItapoÃ¡/SC', 'undefined', 'undefined', '2019-03-27 18:06:06', '2019-03-27 18:06:06'),
(108, 3, 4, '5016313-47.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara', 'cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '651012442516', '2019-03-27 18:26:23', '2019-03-27 18:26:23'),
(110, 1, 1, '1.33.000.001085/2015-31', 'SituaÃ§Ã£o do projeto habitacional aos integrantes da \"OcupaÃ§Ã£o Contestado\"', NULL, NULL, '2019-03-27 18:41:08', '2019-03-27 18:43:23'),
(111, 3, 4, '5000591-34.2016.4.04.7220', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara', 'cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '964446190016', '2019-03-27 18:45:15', '2019-03-27 18:45:15'),
(112, 3, 4, '5016700-62.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Eulalio Furtado Junior', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '218789634916', '2019-03-27 18:54:59', '2019-03-27 18:54:59'),
(113, 3, 4, '5016332-53.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. PERLA DOS SANTOS', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '329495060116', '2019-03-27 18:59:20', '2019-03-27 18:59:55'),
(114, 3, 4, '5016331-68.20164047208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Romildo Amaral Ferreira', 'cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '885823780416', '2019-03-27 19:05:53', '2019-03-27 19:05:53'),
(115, 1, 1, '1.33.003.000506/2017-49', 'Loteamento Clandestino. Ouro Verde. Luiz Cesar Quartiero. Gaivota/SC.', NULL, 'undefined', '2019-03-27 19:10:54', '2019-03-27 19:10:54'),
(116, 3, 4, '5016330-83.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Doris Cristina Venier', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '358567116316', '2019-03-27 19:23:40', '2019-03-27 19:23:40'),
(117, 3, 4, '5017158-79.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara.  Claudete Dietrich', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '455091746116', '2019-03-27 19:34:01', '2019-03-27 19:34:01'),
(118, 3, 4, '5017021-97.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara.  Francielle Caroline Rebello Cherobin', 'Cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o.', '237402793716', '2019-03-27 19:40:53', '2019-03-27 19:40:53'),
(119, 4, 1, '1.33.000.002314/2018-88', 'Desmatamento de restinga pela Prefeitura. Enseada de Brito, PalhoÃ§a/SC', 'Desmatamento de restinga pela Prefeitura. Enseada de Brito, PalhoÃ§a/SC', 'undefined', '2019-03-27 19:57:23', '2019-03-27 19:57:23'),
(120, 3, 4, '5017153-57.2016.4.04.7208/', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara. Catiane Pezzini', 'cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o', '522050705116', '2019-03-27 20:16:23', '2019-03-27 20:16:23'),
(121, 3, 4, '5016709-24.2016.4.04.7208', 'CondomÃ­nio Residencial Ernesto ChÃª Guevara.  FlÃ¡via LuÃ­sa Meira Cordeiro', 'cumprimento do Contrato de DoaÃ§Ã£o da UniÃ£o, firmado com o MUNICÃPIO DE TIJUCAS, contrato esse lavrado no Livro nÂº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imÃ³vel de domÃ­nio da UniÃ£o', '649823404816', '2019-03-27 20:35:24', '2019-03-27 20:36:23'),
(122, 2, 4, '5001578-14.2018.4.04.7216', 'Dano Ambiental. Praia da Barra. Garopaba', 'Visa Ã  demoliÃ§Ã£o de obra e a completa recuperaÃ§Ã£o da Ã¡rea de preservaÃ§Ã£o permanente (APP) localizada na Praia da Barra, municÃ­pio de Garopaba/SC.', '778101790718', '2019-03-28 18:09:36', '2019-03-28 18:09:36'),
(123, 3, 4, '5025790-55.2015.4.04.7200', 'Rever o Cancelamento da OcupaÃ§Ã£o. RIP 8143010014148', 'AÃ§Ã£o declaratÃ³ria de nulidade de ato jurÃ­dico para rever o Cancelamento da OcupaÃ§Ã£o. RIP 8143010014148.', '898076716415', '2019-04-01 13:35:28', '2019-04-01 13:35:28'),
(124, 3, 4, '5021680-44.2014.4.04.7201', 'UsucapiÃ£o Federal. Dalva Vieira de FranÃ§a', 'undefined', '725115042514', '2019-04-01 14:20:34', '2019-04-01 14:20:34'),
(125, 2, 3, '5010761-43.2012.404.7208', 'Dano Ambiental. BalneÃ¡rio CamboriÃº', 'DemoliÃ§Ã£o de construÃ§Ã£o realizada em Ã¡rea de preservaÃ§Ã£o permanente e terreno de marinha, bem como a prestaÃ§Ã£o de indenizaÃ§Ã£o pelo dano ambiental sofrido.', '326895718312', '2019-04-01 16:41:15', '2019-04-01 16:41:15'),
(126, 2, 4, '5008851-39.2011.4.04.7200', 'Dano Ambiental. Praia de MagalhÃ£es.Governador Celso Ramos', 'DemoliÃ§Ã£o de construÃ§Ã£o em terras da UniÃ£o Federal caracterizadas como Ãrea de PreservaÃ§ao Ambiental, na Praia do MagalhÃ£es, no interior da APA de Anhatomirim, municÃ­pio de Governador Celso Ramos, bem como a restauraÃ§Ã£o da Ã¡rea degradada.', 'undefined', '2019-04-01 17:01:40', '2019-04-01 17:01:40'),
(127, 5, 1, '08.2019.00070195-2', 'Dano Ambiental. Antonio Donizete da Silva Goes. Ulysses GuimarÃ£es, Joinville', NULL, 'undefined', '2019-04-01 18:55:06', '2019-04-01 18:55:06'),
(128, 3, 1, '5008534-70.2013.4.04.7200', 'UsucapiÃ£o. Canto do Lamin, Papaquara, Canasvieiras - JosÃ© Sobreira de Alencar e outro', 'undefined', '965780188213', '2019-04-01 19:24:17', '2019-04-01 19:24:17'),
(130, 3, 4, '5003358-50.2017.4.04.7207', 'Contrato SARP A-TC-5072â€‹', 'undefined', '795136425517', '2019-04-01 19:39:54', '2019-04-01 19:39:54'),
(132, 2, 2, '5026884-72.2014.4.04.7200', 'Ranchos de Pesca na Tapera - FlorianÃ³polis - ICP 1.33.000.007186/2002-00', 'Da inicial: OcupaÃ§Ã£o ilÃ­cita, clandestina e desordenada de Ã¡rea de praia e que constitui terra de marinha, nem como APP, na Praia da Tapera em FlorianÃ³polis. Barracos utilizados para moradia de veraneio sob pretexto de serem ranchos de pesca.', '901644162114', '2019-04-01 20:51:18', '2019-04-01 20:51:49'),
(134, 2, 3, '5009015-67.2017.4.04.7208', 'Dano Ambiental. Bombinhas', 'DemoliÃ§Ã£o da edificaÃ§Ã£o e de todas as benfeitorias, atÃ© o limite de 14 metros a partir da linha preamar mÃ©dia de 1831, e Ã  completa recuperaÃ§Ã£o da respectiva Ã¡rea em imÃ³vel localizado na Rua Sardinha, nÂº 42, Centro, Bombinhas/SC.', '397971993317', '2019-04-02 13:24:12', '2019-04-02 13:24:12'),
(135, 2, 1, '5010039-91.2016.404.7200', 'Zona Costeira - Trecho Sul de SÃ£o JosÃ©', 'undefined', 'undefined', '2019-04-02 13:34:30', '2019-05-28 19:05:59'),
(136, 1, 1, '1.33.005.000244/2009-92', 'Dano Ambiental. SÃ£o Francisco do Sul', 'Dano Ambiental. EdificaÃ§Ã£o construÃ­da na Avenida Tripoli, 557, Praia ItaguaÃ§u, Bairro ItaguaÃ§u, SÃ£o Francisco do Sul', 'undefined', '2019-04-02 13:45:47', '2019-04-02 13:45:47'),
(137, 2, 4, '5004976-80.2019.4.04.7200', 'OcupaÃ§Ã£o irregular em terras indÃ­genas', 'O OfÃ­cio 454/2019 - NUP 04972.002177/2019-22, trata de terras indÃ­genas e a UniÃ£o foi condenada na obrigaÃ§Ã£o de fazer consistente na adoÃ§Ã£o das providÃªncias administrativas e judiciais necessÃ¡rias para impedir obras e invasÃµes na terra indÃ­gena Cambirela, na PalhoÃ§a, bem como demolir  as construÃ§Ãµes ilegais jÃ¡ implantadas e recuperaÃ§Ã£o ambiental.', '3322396639119', '2019-04-02 16:33:17', '2019-04-02 16:33:17'),
(139, 2, 1, '5004981-78.2014.4.04.7200', 'Abertura de acessos Ã  praia - MunicÃ­pio de Governador Celso Ramos', 'O OfÃ­cio 455/2019 - NUP 04972.002119/2019-07, trata da abertura de acessos em Governador Celso Ramos. O MunicÃ­pio alegou que a UniÃ£o (SPU) nÃ£o estava cumprindo a parte dela e o juiz determinou que a UniÃ£o em 15 dias informe quais sÃ£o as inscriÃ§Ãµes e/ou aforamentos de terras de marinha cuja manutenÃ§Ã£o pela UniÃ£o estariam impedindo a abertura dos acessos, bem como que fosse informadas eventuais ocupaÃ§Ãµes irregulares.', '312236886214', '2019-04-02 16:46:28', '2019-04-02 16:46:28'),
(140, 3, 4, '5013419-64.2017.4.04.7208', 'Nulidade de Processo de DemarcaÃ§Ã£o. RIP 8 8265.0000259-77', 'AÃ§Ã£o DeclaratÃ³ria com Pedido de RepetiÃ§Ã£o de IndÃ©bito e de Tutela Antecipada, em face da UNIÃƒO, postulando, em apertado resumo: [i] a declaraÃ§Ã£o de nulidade do processo administrativo de demarcaÃ§Ã£o de terras de marinha e, por decorrÃªncia lÃ³gica, das taxas de ocupaÃ§Ã£o cobradas em face do imÃ³vel objeto do Registro ImobiliÃ¡rio Patrimonial nÂº 8265.0000259-77.', '134201307217', '2019-04-02 17:38:00', '2019-04-02 17:38:00'),
(142, 3, 4, '5003097-69.2018.4.04.7201', 'UsucapiÃ£o Federal. Alceu Antonio Fhynbeen', 'undefined', '160235661518', '2019-04-02 18:15:23', '2019-04-02 18:15:23'),
(143, 3, 1, '5011170-17.2019.4.04.7000', 'ExecuÃ§Ã£o Fiscal. Taxa de OcupaÃ§Ã£o. Hauer Empreendimentos ImobiliÃ¡rios. BiguaÃ§u', 'ExecuÃ§Ã£o Fiscal. Taxa de OcupaÃ§Ã£o. Hauer Empreendimentos ImobiliÃ¡rios. BiguaÃ§u. RÃ©u alega que a cobranÃ§a Ã© indevida por ter transferido o terreno em 1979 e 1980.', '116924815619', '2019-04-02 18:20:01', '2019-04-02 18:20:01'),
(144, 3, 4, '5001417-72.2016.4.04.7216', 'UsucapiÃ£o Federal.', 'undefined', '502012053216', '2019-04-02 18:54:38', '2019-04-02 18:54:38'),
(145, 3, 4, '5000162-50.2014.4.04.7216', 'UsucapiÃ£o', 'Aferir a existÃªncia de registro em cartÃ³rio de imÃ³vel pertencente Ã  UniÃ£o em nome de terceiros como proprietÃ¡rios.', '842354754314', '2019-04-03 12:09:30', '2019-04-03 12:09:30'),
(146, 3, 1, '0005949-48.2011.8.24.0075', 'AÃ§Ã£o Penal - Procedimento OrdinÃ¡rio', 'undefined', 'undefined', '2019-04-03 18:25:31', '2019-04-03 18:25:31'),
(147, 3, 2, '5006746-89.2016.4.04.7208', 'DesapropriaÃ§Ã£o Indireta', 'undefined', '299242662116', '2019-04-03 18:35:35', '2019-04-03 18:35:35'),
(148, 3, 2, '5003585-78.2019.4.04.7204', 'undefined', 'Interesse na lide.', '110118087119', '2019-04-03 18:46:59', '2019-04-03 18:46:59'),
(149, 3, 2, '5001379-84.2016.4.04.7208', 'DesapropriaÃ§Ã£o Indireta', 'undefined', '764014760916', '2019-04-03 19:28:34', '2019-04-03 19:28:34'),
(152, 3, 4, '5015894-77.2018.4.04.7201', 'UsucapiÃ£o', 'interesse federal na causa', 'undefined', '2019-04-03 19:37:52', '2019-04-03 19:37:52'),
(153, 2, 2, '5018585-67.2018.4.04.7200', 'AÃ‡ÃƒO CIVIL PÃšBLICA - CONDOMÃNIO RESIDENCIAL E COMERCIO PORTO DA LAGOA', 'undefined', '636161096818', '2019-04-03 19:52:12', '2019-04-03 19:52:12'),
(154, 5, 1, '07.2017.00039377-0', 'Cancelamento de matrÃ­cula de terreno de marinha. Itapema. Alcino Pasqualotto Neto', 'ManifestaÃ§Ã£o sobre o cancelamento da matrÃ­cula 10.241, solicitada pelo interventor do cartÃ³rio de registro de imÃ³veis em funÃ§Ã£o da negativa da legal de registro e abertura de matrÃ­culas de ocupaÃ§Ã£o de terreno da UniÃ£o, execetuando-se os casos de aforamento.\r\nRefere-se ao RIP 8163.0000291-04', 'undefined', '2019-04-03 20:27:26', '2019-04-03 20:27:26'),
(155, 3, 4, '5012582-72.2018.4.04.7208', 'Ambiental', 'Requer que seja reconhecido que o local especÃ­fico no qual fora instalada passagem de acesso Ã  Praia Grande, no MunicÃ­pio de Penha, nÃ£o constitui APP (Ã¡rea de preservaÃ§Ã£o permanente).', '508740758418', '2019-04-04 11:24:55', '2019-04-04 11:24:55'),
(156, 3, 3, '0024324-98.1984.4.04.7200', 'Mandados de ImissÃ£o na Posse', 'ImÃ³vel em Laguna.', 'undefined', '2019-04-04 11:32:22', '2019-04-04 11:32:22'),
(158, 3, 4, '5016606-67.2018.4.04.7201', 'UsucapiÃ£o', 'Manifestar se hÃ¡ interesse no feito.', 'undefined', '2019-04-04 11:42:15', '2019-04-04 11:42:15'),
(159, 3, 4, '5022387-78.2015.4.04.7200', 'UsucapiÃ£o', 'manifestaÃ§Ã£o acerca do Laudo Pericial complementar', '437071396215', '2019-04-04 12:20:46', '2019-04-04 12:20:46'),
(160, 3, 3, '5000070-67.2017.4.04.7216', 'ReintegraÃ§Ã£o de Posse', 'ImÃ³vel da RFFSA', '922053331117', '2019-04-04 12:40:36', '2019-04-04 12:40:36'),
(162, 3, 4, '5004510-79.2016.4.04.7204', 'UsucapiÃ£o', 'indicaÃ§Ã£o de assistente tÃ©cnico', '981565022716', '2019-04-04 13:20:29', '2019-04-04 13:20:29'),
(163, 3, 1, '0304261-90.2018.8.24.0023', 'DesapropriaÃ§Ã£o', 'DesapropriaÃ§Ã£o movida pela CASAN em face de particular', 'undefined', '2019-04-04 14:12:58', '2019-04-04 14:12:58'),
(164, 3, 2, '0308178-20.2018.8.24.0023', 'DesapropriaÃ§Ã£o', 'undefined', 'undefined', '2019-04-04 16:46:41', '2019-04-04 16:46:41'),
(165, 3, 3, '5002845-60.2014.4.04.7216', 'DesapropriaÃ§Ã£o', 'Porto de Laguna.', '208748051214', '2019-04-04 17:21:22', '2019-04-04 17:21:22'),
(166, 3, 3, '5001957-23.2016.4.04.7216', 'UsucapiÃ£o', 'undefined', '519315644216', '2019-04-04 18:03:09', '2019-04-04 18:03:09'),
(167, 2, 3, '5008751-45.2015.4.04.7200', 'AÃ§Ã£o Civil PÃºblica - ImÃ³vel em Canasvieiras', 'undefined', '381284688615', '2019-04-05 12:01:20', '2019-04-05 12:01:20'),
(168, 3, 4, '5001945-77.2014.4.04.7216/SC', 'TERRENO DE MARINHA. LAUDÃŠMIO. PRESCRIÃ‡ÃƒO', 'undefined', 'undefined', '2019-04-05 13:05:07', '2019-04-05 13:05:07'),
(169, 2, 4, '5031473-10.2014.4.04.7200', 'Dano Ambiental', 'undefined', '345303018914', '2019-04-05 13:25:03', '2019-04-05 13:25:03'),
(170, 3, 2, '5026035-95.2017.4.04.7200', 'UsucapiÃ£o', 'undefined', '378389110517', '2019-04-05 13:36:28', '2019-04-05 13:36:28'),
(171, 1, 1, '1.33.001.000157/2015-13', 'Loteamento Green Ville, localizado na Rodovia Jorge Lacerda, Km 12,4, Ilhota/SC', 'Verificar regularidade.', 'undefined', '2019-04-05 16:09:23', '2019-04-05 16:09:23'),
(172, 1, 1, '1.33.000.002581/2018-55', 'Obra de arrimo das margens do RibeirÃ£o a Capela e reconstruÃ§Ã£o de ponte de concreto.', 'undefined', 'undefined', '2019-04-05 17:16:50', '2019-04-05 17:16:50'),
(173, 6, 1, '0085/2019-4-SR/PF/SC', 'InformaÃ§Ã£o sobre bens da UniÃ£o.', 'Informar se o Ã¡rea localizada na Estrada Intendente AntÃ³nio Damasco, s/nÂ°, ao Iaco doj \"Trevo\'s Bar\", Ratones, FlorianÃ³polis/SC, coordenadas de referÃªncia Datum WGS -84 -27.489785Â°S / -48.493368Â°O, incide em terrenos de marinha e seus acrescidos.', 'undefined', '2019-04-05 17:31:51', '2019-04-05 17:31:51'),
(174, 1, 1, '1.33.008.000015/2017-58', 'undefined', 'Marina PatrÃ­cio, localizada na Rua Luis Joaquim dos Santos, bairro SÃ£o Pedro, no MunicÃ­pio de Navegantes/SC, Ã s margens do Rio ItajaÃ­-AÃ§u', 'undefined', '2019-04-05 17:37:25', '2019-04-05 17:37:25'),
(175, 2, 4, '5014004-09.2018.4.04.7200', 'CessÃ£o da barragem oeste (TaiÃ³)', 'undefined', '150147097218', '2019-04-05 17:41:26', '2019-04-05 17:41:26'),
(176, 1, 1, '1.33.000.001328/2007-21', 'undefined', 'Solicita informaÃ§Ãµes se jÃ¡ houve a conclusÃ£o dos trabalhos referentes a regularizaÃ§Ã£o da delimitaÃ§Ã£o da Linha de Preamar MÃ©dia/1831 e, em caso negativo, quais as medidas adotadas para a referida\nregularizaÃ§Ã£o.', 'undefined', '2019-04-05 17:48:25', '2019-04-05 17:48:25'),
(178, 3, 4, '5014307-67.2016.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do CondomÃ­nio Habitacional Ernesto Che Guevara', '737120895016', '2019-04-05 18:19:36', '2019-04-05 18:19:36'),
(179, 3, 4, '5003387-53.2019.4.04.7200', 'MANDADO DE SEGURANÃ‡A. RemiÃ§Ã£o de aforamento', 'undefined', '80390625619', '2019-04-08 12:12:04', '2019-04-08 12:12:04'),
(180, 3, 3, '5008272-35.2018.4.04.7204', 'ReintegraÃ§Ã£o de Posse', 'ImÃ³vel funcional situado na Rua Engenheiro FiÃºza da Rocha, 84, Centro, no MunicÃ­pio de CriciÃºma/SC, com Ã¡rea de 452,23 mÂ², sobre o qual se encontra edificada uma casa de alvenaria de 126,69 mÂ², registrado no 1Â° Oficio do Registro de ImÃ³veis da Comarca de CriciÃºma, sob a matrÃ­cula de nÂº 2.108.', '312135651218', '2019-04-08 12:19:39', '2019-04-08 12:19:39'),
(181, 2, 4, '5026745-81.2018.4.04.7200', 'ACP', NULL, '342678531818', '2019-04-08 12:33:36', '2019-04-08 12:34:22'),
(182, 3, 4, '5001494-44.2017.4.04.7217', 'UsucapiÃ£o', 'undefined', '557405466217', '2019-04-08 13:54:42', '2019-04-08 13:54:42'),
(183, 3, 4, '5006734-41.2017.4.04.7208', 'undefined', 'Reabertura de prazo para entrega de tÃ­tulos CondomÃ­nio Habitacional Ernesto Che Guevara', '60029786817', '2019-04-08 14:08:14', '2019-04-08 14:08:14'),
(184, 3, 4, '5003278-83.2017.4.04.7208/SC', 'undefined', 'reabertura de prazo para entrega de tÃ­tulos CondomÃ­nio Habitacional Ernesto Che Guevara', '323037441517', '2019-04-08 14:11:25', '2019-04-08 14:11:25'),
(185, 3, 3, '5001735-74.2019.4.04.7208', 'USUCAPIÃƒO EXTRAORDINÃRIA', 'undefined', 'undefined', '2019-04-08 16:39:44', '2019-04-08 16:39:44'),
(186, 3, 1, '0313746-17.2018.8.24.0023', 'DesapropriaÃ§Ã£o. Loteamento Santos Dumont.', 'DesapropriaÃ§Ã£o efetivada pelo DEINFRA.', 'undefined', '2019-04-08 16:57:58', '2019-04-08 16:57:58'),
(187, 3, 4, '5007782-93.2016.4.04.7200', NULL, 'UsucapiÃ£o Federal', '535133090816', '2019-04-08 17:43:47', '2019-04-08 17:43:47'),
(188, 3, 4, '5000895-79.2010.4.04.7208', 'undefined', 'undefined', '656236623210', '2019-04-08 18:19:14', '2019-04-08 18:19:14'),
(189, 1, 1, '1.33.005.000662/2016-17', 'TAUS -  Praia do Forte, em SÃ£o Francisco do Sul/SC', 'undefined', 'undefined', '2019-04-09 11:33:53', '2019-04-09 11:33:53'),
(191, 1, 1, '1.33.005.000032/2019-87', 'Verificar interferÃªncia com Ã¡rea da UniÃ£o.', 'undefined', 'undefined', '2019-04-09 13:02:50', '2019-04-09 13:02:50'),
(192, 1, 1, '1.33.003.000105/2018-70', 'CessÃ£o onerosa da Plataforma de Pesca Entremares AraranguÃ¡', 'undefined', 'undefined', '2019-04-09 13:26:17', '2019-06-03 17:16:55'),
(194, 3, 3, '5021998-93.2015.4.04.7200', 'DemoliÃ§Ã£o de casas na Praia do Forte', 'A UniÃ£o deverÃ¡ providenciar a demoliÃ§Ã£o de casas na Praia do Forte', '856775037515', '2019-04-09 16:26:56', '2019-04-09 16:26:56'),
(195, 3, 3, '5017717-19.2014.4.04.7204', 'RESTITUIÃ‡ÃƒO DE ÃREA', 'UniÃ£o noticiou ao JuÃ­zo que aquele Ã³rgÃ£o concluiu pela renÃºncia Ã \r\ndÃ­vida do Sr. Santos de Souza, diante do interesse social, restando ainda a questÃ£o da destinaÃ§Ã£o do bem que, conforme\r\na SPU, seria analisada em conjunto com as demais situaÃ§Ãµes existentes na Rua Campos ElÃ­sios, sendo aguardado o\r\nlaudo ambiental para que a DIRFH analise a possibilidade de RegularizaÃ§Ã£o FundiÃ¡ria de Interesse Social.', '825570237214', '2019-04-09 16:51:22', '2019-04-09 16:51:22'),
(196, 3, 4, '5011418-04.2015.4.04.7200', 'UsucapiÃ£o', 'undefined', '300726583715', '2019-04-09 17:19:19', '2019-04-09 17:19:19'),
(197, 3, 1, '0303012-89.2017.8.24.0007', 'undefined', 'undefined', 'qwyucd', '2019-04-09 17:30:14', '2019-04-09 17:30:14'),
(198, 3, 1, '5015326-61.2018.4.04.7201', 'undefined', 'undefined', '667199124918', '2019-04-09 18:01:52', '2019-04-09 18:01:52'),
(199, 3, 1, '0001868-55.2014.5.12.0004', 'AÃ§Ã£o Trabalhista - Indisponibilidade de Bens e Direitos', 'undefined', 'undefined', '2019-04-10 12:20:54', '2019-04-10 12:20:54'),
(200, 6, 1, '0125/2019-4-SR/PF/SC', 'Verificar se Ã¡rea interfere com bem da UniÃ£o.', 'undefined', 'undefined', '2019-04-10 13:49:57', '2019-04-10 13:49:57'),
(201, 6, 1, '0125/2019-4', 'undefined', 'informar se o local onde foi lavrado o AUTO DE INFRAÃ‡ÃƒO 032211 B encontra-se inserido em Ã¡rea de marinha e seus acrescidos.', 'undefined', '2019-04-10 13:59:53', '2019-04-10 13:59:53'),
(202, 1, 1, '1.33.005.000522/2015-50', 'undefined', 'undefined', 'undefined', '2019-04-10 14:06:31', '2019-04-10 14:06:31'),
(203, 6, 1, '0064/2019-4', 'undefined', 'undefined', 'undefined', '2019-04-10 15:58:58', '2019-04-10 15:58:58'),
(204, 6, 1, '0613/2018-4', 'undefined', 'undefined', 'undefined', '2019-04-10 16:10:39', '2019-04-10 16:10:39'),
(205, 1, 1, '1.33.001.000514/2018-96', 'CessÃ£o', 'ImÃ³vel situado na Rua ItajaÃ­, 1115, Blumenau/SC, antigo prÃ©dio do MinistÃ©rio do Trabalho.', 'undefined', '2019-04-10 16:45:20', '2019-04-10 16:45:20'),
(206, 3, 3, '5009455-05.2013.4.04.7208', 'ConstruÃ§Ã£o irregular em Bombinhas - DemoliÃ§Ã£o de Trapiche - Leonidas AntÃ´nio Sochas', 'undefined', '919591244413', '2019-04-10 17:30:39', '2019-07-10 16:05:02'),
(207, 8, 1, '0105/108', 'Defensoria PÃºblica Estadual', 'DocumentaÃ§Ã£o INCRA', 'undefined', '2019-04-10 18:13:30', '2019-04-10 18:13:30'),
(208, 1, 1, '1.33.000.002268/2013-11', 'undefined', 'undefined', 'undefined', '2019-04-11 13:39:57', '2019-04-11 13:39:57'),
(209, 1, 1, '1.33.000.000723/2019-21', NULL, 'informaÃ§Ãµes a respeito do quanto noticiado, em suma, sobre suposto abandono do terreno da UniÃ£o localizado na Rua JosÃ© da Costa Moellman, em frente ao Tribunal de Contas do Estado.', 'undefined', '2019-04-11 16:53:41', '2019-04-11 16:53:41'),
(210, 6, 1, '0077/2018-4', 'undefined', 'Eventual ocupaÃ§Ã£o irregular imÃ³vel da UniÃ£o denominado \"Ilha Grande\" (ou \"Ilha Quinta dos Ganchos\"), situada no municÃ­pio de Governador Celso Ramos/SC', 'undefined', '2019-04-11 16:59:07', '2019-04-11 16:59:07'),
(211, 8, 1, '1.33.005.000271/2017-7', 'TAUS', 'undefined', 'undefined', '2019-04-11 17:06:12', '2019-04-11 17:06:12'),
(212, 1, 1, '1.33.000.001547/2011-97', 'TAUS', 'informaÃ§Ãµes atualizadas sobre o andamento da concessÃ£o de Termos de AutorizaÃ§Ã£o de Uso SustentÃ¡vel (TAUS) para os ranchos de pesca situados no Bairro do AbraÃ£o', 'undefined', '2019-04-11 17:13:10', '2019-04-11 17:13:10'),
(213, 1, 1, '1.33.005.000449/2015-16', 'TAUS', 'TAUS - BalneÃ¡rio Barra Sul', 'undefined', '2019-04-11 17:20:40', '2019-04-11 17:20:40'),
(214, 1, 1, '1.33.000.000626/2013-42', 'undefined', 'TAUS na regiÃ£o do Rio ImaruÃ­m, PalhoÃ§a/SC', 'undefined', '2019-04-11 17:34:08', '2019-04-11 17:34:08'),
(215, 8, 1, '1.33.016.000013/2019-21', 'undefined', 'Solicita cÃ³pia do processo', 'undefined', '2019-04-11 17:46:40', '2019-04-11 17:46:40'),
(216, 3, 1, '0300658-20.2016.8.24.0139', 'undefined', 'ReintegraÃ§Ã£o / ManutenÃ§Ã£o de Posse', 'undefined', '2019-04-11 18:37:37', '2019-04-11 18:37:37'),
(217, 3, 4, '5002031-11.2019.404.7204', 'ContestaÃ§Ã£o de CobranÃ§a - Clube AtlÃ©tico TubarÃ£o', 'ContestaÃ§Ã£o de CobranÃ§a, alegaÃ§Ã£o de ilegitimidade passiva - Clube AtlÃ©tico TubarÃ£o', '938760091919', '2019-04-12 14:33:28', '2019-04-12 14:33:28'),
(218, 7, 3, '91.6.16.014713-5', 'undefined', 'undefined', 'undefined', '2019-04-12 16:38:32', '2019-04-12 16:38:32'),
(219, 1, 1, '06.2015.00003216-1', 'Dano Ambiental. Garopaba', 'undefined', 'undefined', '2019-04-12 16:55:10', '2019-04-12 16:55:10'),
(220, 4, 1, '00435.000437/2019-51', 'TAUS - ImÃ³vel no RibeirÃ£o da Ilha', 'undefined', 'undefined', '2019-04-12 17:11:43', '2019-04-12 17:11:43'),
(221, 3, 1, '5006649-11.2019.4.04.7200', 'Interdito ProibitÃ³rio', 'undefined', 'undefined', '2019-04-12 17:38:12', '2019-04-12 17:38:12'),
(222, 2, 4, '5002875-27.2016.4.04.7216', 'Dano Ambiental. Garopaba', 'undefined', '168766448616', '2019-04-12 17:47:15', '2019-04-12 17:47:15'),
(223, 3, 4, '5015296-73.2016.4.04.7208', 'CondomÃ­nio Habitacional Ernesto Che Guevara.', 'undefined', '690342849616', '2019-04-15 13:24:48', '2019-04-15 13:24:48'),
(224, 3, 4, '5003408-04.2011.4.04.7202', 'UsucapiÃ£o Federal', 'undefined', '8394674163 11', '2019-04-15 17:01:00', '2019-04-15 17:01:00'),
(225, 3, 4, '0004330-20.2008.4.04.7208', 'AUMENTO DE TAXA DE OCUPAÃ‡ÃƒO - IMÃ“VEL RIP 8161.0000103-00', 'Trata-se de aÃ§Ã£o judicial em que a parte autora pretendia invalidar aumento no valor da taxa de ocupaÃ§Ã£o dos exercÃ­cios de 2007 e 2008.', 'undefined', '2019-04-15 17:09:49', '2019-04-15 17:09:49'),
(226, 3, 3, '0001772-96.1971.4.04.7200', 'DNER', 'AdjudicaÃ§Ã£o em favor da UniÃ£o ( DNER)', 'undefined', '2019-04-15 17:28:48', '2019-04-15 17:30:00'),
(227, 2, 3, '5000818-21.2015.4.04.7200', 'Dano Ambiental. Rua Baldicero Filomeno, ao lado do nÂº 19.790, RibeirÃ£o da Ilha, FlorianÃ³polis, SC.', 'AÃ§Ã£o civil pÃºblica que alega terem os rÃ©us construÃ­do irregularmente em Terreno de Marinha (APP)', '992385556415', '2019-04-15 17:38:43', '2019-04-15 17:38:43'),
(228, 2, 4, '5009439-33.2017.4.04.7201', 'Dano Ambiental. Joinville', 'RegularizaÃ§Ã£o e fiscalizaÃ§Ã£o na Ã¡rea de preservaÃ§Ã£o permanente localizada no final da rua senador Lauro Fagundes dos Reis, no bairro jardim IririÃº, no MunicÃ­pio de Joinville.', '791998026617', '2019-04-15 18:05:41', '2019-04-15 18:05:41');
INSERT INTO `procedimentoexterno` (`id`, `idTipoProcedimentoExterno`, `idPoloProcedimentoExterno`, `procedimento`, `resumo`, `descricao`, `chave`, `created_at`, `updated_at`) VALUES
(229, 3, 4, '5002990-96.2012.4.04.7213', 'UsucapiÃ£o Federal', 'undefined', '964430110712', '2019-04-15 19:09:07', '2019-04-15 19:09:07'),
(230, 2, 4, '5008047-90.2019.404.7200', 'Ãndios Guaranis. Mercado PÃºblico FlorianÃ³polis', 'undefined', 'undefined', '2019-04-16 16:41:20', '2019-04-16 16:41:20'),
(231, 3, 4, '03007288220178240048', 'UsucapiÃ£o Estadual', 'undefined', 'undefined', '2019-04-16 17:08:16', '2019-04-16 17:08:16'),
(232, 2, 1, '0918895-10.2017.8.24.0045', 'PalhoÃ§a', 'Objetiva, entre outros pedidos, o lacre e interdiÃ§Ã£o de uso da edificaÃ§Ã£o e das obras descritas, determinando Ã  primeira requerida que paralise imediatamente toda e qualquer atividade desenvolvida na Ã¡rea objeto do pedido', 'undefined', '2019-04-16 17:20:14', '2019-04-16 17:20:14'),
(233, 1, 1, '1.33.005.000154/2011-16', 'JosÃ© AntÃ´nio da Cunha - Dano Ambiental . SÃ£o Francisco do Sul', NULL, 'undefined', '2019-04-17 13:41:29', '2019-05-24 14:30:20'),
(234, 3, 4, '5012727-55.2018.4.04.7200', 'RetificaÃ§Ã£o de registro', 'undefined', '803241842818', '2019-04-17 13:57:24', '2019-04-17 13:57:24'),
(235, 3, 3, '5017233-74.2018.4.04.7200', 'Dano Ambiental. BiguaÃ§u', 'undefined', '248587921518', '2019-04-17 14:09:27', '2019-04-17 14:09:27'),
(236, 3, 1, '0018447-70.2013.8.24.0023', 'UsucapiÃ£o Estadual', 'undefined', 'undefined', '2019-04-17 17:37:20', '2019-04-17 17:37:20'),
(237, 2, 4, '5002902-53.2019.4.04.7200', 'Dano Ambiental. Ilha do Papagaio', 'undefined', '579843626719', '2019-04-17 18:23:11', '2019-04-17 18:23:11'),
(238, 1, 1, '1.33.008.000395/2013-05', 'Dano Ambiental.BalneÃ¡rio Camboriu', 'undefined', 'undefined', '2019-04-18 17:54:46', '2019-04-18 17:54:46'),
(239, 2, 1, '5004544-49.2019.4.04.7204', 'IdentificaÃ§Ã£o de Ã¡rea', 'Informar se a Ã¡rea em questÃ£o, localizada na Rodovia SC 100 Canto da Lagoa - Laguna, coordenadas 22J 713601/ 6837445, estÃ¡ situada em terrenos de marinha.', 'undefined', '2019-04-22 13:00:57', '2019-04-22 13:00:57'),
(240, 1, 1, '1.33.001.000129/2019-20', 'undefined', 'Regularidade do imÃ³vel \"Jardim das DÃ¡lias\"', 'undefined', '2019-04-22 13:16:55', '2019-04-22 13:16:55'),
(246, 3, 4, '5012050-25.2018.4.04.7200', 'UsucapiÃ£o. Evaldo JosÃ© Lago', 'undefined', '3723230313818', '2019-04-22 13:53:46', '2019-04-22 13:53:46'),
(250, 3, 4, '5001018-68.2019.4.04.7206', 'MajoraÃ§Ã£o da taxa de ocupaÃ§Ã£o', 'undefined', '14915010619', '2019-04-22 17:08:45', '2019-04-22 17:08:45'),
(252, 3, 4, '5007645-09.2019.4.04.7200', 'Obter autorizaÃ§Ã£o para reforma de edificaÃ§Ã£o', 'undefined', '950326714019', '2019-04-22 17:31:53', '2019-04-22 17:31:53'),
(254, 3, 4, '0301144-13.2016.8.24.0007', 'UsucapiÃ£o. JosÃ© JoÃ£o Ferreira', 'undefined', 'undefined', '2019-04-22 17:49:59', '2019-04-22 17:49:59'),
(255, 8, 1, '0312043-56.2015.8.24.0023-000', 'undefined', 'undefined', 'undefined', '2019-04-22 18:12:52', '2019-04-22 18:12:52'),
(256, 3, 4, '5000836-82.2019.4.04.7206', 'Objetiva a demoliÃ§Ã£o de construÃ§Ã£o', 'undefined', '822089215319', '2019-04-22 19:47:41', '2019-04-22 19:47:41'),
(257, 3, 1, '003957-79.2006.8.16.0033', 'undefined', 'undefined', 'undefined', '2019-04-23 13:48:46', '2019-04-23 13:48:46'),
(258, 2, 4, '5008465-28.2019.4.04.7200', 'Nulidade da matrÃ­cula de imÃ³vel', 'undefined', '692311726419', '2019-04-23 16:52:01', '2019-04-23 16:52:01'),
(259, 3, 1, '5018644-02.2016.4.04.7208', 'Receita federal ItajaÃ­', 'undefined', 'undefined', '2019-04-23 18:33:35', '2019-04-23 18:33:35'),
(260, 3, 4, '5017236Â­63.2017.4.04.7200/SC', 'UsucapiÃ£o', 'Rejeitado o pedido de usucapiÃ£o.', 'undefined', '2019-04-23 18:49:08', '2019-04-23 18:49:08'),
(261, 3, 4, '5009770-57.2018.4.04.7208', 'undefined', 'Requer declaraÃ§Ã£o de ser o imÃ³vel de 339,53m2 Ã¡rea nÃ£o pertencente Ã  UniÃ£o (marinha), mas particular (alodial), de posse do Requerente, anular a certidÃ£o de ocupaÃ§Ã£o expedida pela UniÃ£o sob o nÂº RIP 8245 0000045-84 e determinar a anulaÃ§Ã£o do cadastro municipal nÂº 13888, inscriÃ§Ã£o imobiliÃ¡ria 01.06.046.007.', '632702254718', '2019-04-23 19:11:01', '2019-04-23 19:11:01'),
(262, 2, 4, '5017734-28.2018.4.04.7200', 'AAAB FlorianÃ³polis', 'Visa Ã  condenaÃ§Ã£o dos RÃ©us (entes pÃºblicos subsidiariamente) em obrigaÃ§Ãµes de fazer, consistentes na adoÃ§Ã£o de medidas que faÃ§am cessar ocupaÃ§Ã£o irregular de um espaÃ§o protegido de costÃ£o/promontÃ³rio, ambiente de restinga e de faixa de praia, bens da UniÃ£o localizados no imÃ³vel sito na Rua Desembargador Pedro Silva, 2809, Bairro Coqueiros, nesta Capital/SC, atravÃ©s do desfazimento/retirada/demoliÃ§Ã£o das construÃ§Ãµes lÃ¡ erigidas, bem como na recuperaÃ§Ã£o ambiental integral da Ã¡rea e na abertura/estabelecimento de franco e livre acesso Ã  praia e ao costÃ£o.', '367365326518', '2019-04-24 18:12:54', '2019-04-24 18:12:54'),
(263, 3, 4, '5047812-71.2018.4.04.0000', 'MajoraÃ§Ã£o da Taxa de OcupaÃ§Ã£o. FlorianÃ³polis', 'undefined', '717334800510', '2019-04-24 18:36:34', '2019-04-24 18:41:02'),
(264, 3, 4, '5000606-21.2016.4.04.7214', 'DesapropriaÃ§Ã£o. TrÃªs Barras', 'undefined', '698432182616', '2019-04-24 19:39:02', '2019-04-24 19:39:02'),
(266, 8, 4, '5008044-38.2019.4.04.7200', 'Mandado de SeguranÃ§Ã£o - Determina a conclusÃ£o do processo de revisÃ£o de Ã¡rea em 60 dias - Local Itapema/SC', 'relacionado ao RIP 8163.0000343-61, o qual recebeu nÃºmero de atendimento SC 02789/2017 (Processo 04972.008469/2017-15),', '847867684919', '2019-04-25 14:29:35', '2019-04-25 14:29:35'),
(267, 3, 4, '5013141-60.2012.4.04.7201', 'Nulidade do Processo de DemarcaÃ§Ã£o. RIP 8179.0102286-70, 8179.0102337-54 8179.0102383-90 e 8179.0102283-27', 'undefined', '333071402912', '2019-04-26 13:31:25', '2019-04-26 13:31:25'),
(268, 3, 4, '0000458-06.2013.8.24.0135', 'UsucapiÃ£o. Altamir Seberino da Silva', 'undefined', 'undefined', '2019-04-26 14:02:19', '2019-04-26 14:02:19'),
(269, 3, 4, '5017790-32.2016.4.04.7200', 'UsucapiÃ£o. Plabo Moritz', 'undefined', '561255207716', '2019-04-26 16:52:20', '2019-04-26 16:52:20'),
(270, 3, 1, '5009050-27.2012.4.04.7200', 'ExecuÃ§Ã£o fiscal', 'undefined', '5814264490412', '2019-04-26 17:35:37', '2019-04-26 17:35:37'),
(271, 3, 4, '5000531-39.2017.4.04.7216', 'UsucapiÃ£o. Fernando Martins Da Costa Barros', 'undefined', '126089427217', '2019-04-26 18:00:51', '2019-04-26 18:00:51'),
(272, 1, 1, '1.33.000.000939/2016-43', 'Regularidade de OcupaÃ§Ã£o', 'ImÃ³vel na Rua Silva Jardim, nÂ° 1278, Bairro Prainha, em FlorianÃ³polis/SC.', 'undefined', '2019-04-29 12:20:03', '2019-04-29 12:20:03'),
(273, 3, 1, '5008486-48.2017.4.04.7208', 'IncorporaÃ§Ã£o e entrega do imÃ³vel perdido em favor da UniÃ£o. BalneÃ¡rio CamboriÃº', 'undefined', 'undefined', '2019-04-29 13:56:39', '2019-04-29 13:59:12'),
(274, 3, 4, '5016741-79.2018.4.04.7201', 'UsucapiÃ£o. Neri Agostinho da Cruz', 'undefined', '718776303618', '2019-04-29 16:40:29', '2019-04-29 16:40:29'),
(275, 3, 4, '5015092-82.2018.4.04.7200', 'UsucapiÃ£o. Jose Nieto LourenÃ§o', 'undefined', '568090275518', '2019-04-29 17:42:11', '2019-04-29 17:42:11'),
(276, 3, 4, '5000135-62.2017.4.04.7216', 'UsucapiÃ£o. Dorvaci Martins', 'undefined', '782776116817', '2019-04-29 19:50:13', '2019-04-29 19:50:13'),
(277, 1, 1, '1.33.000.002012/2018-18', 'undefined', 'ImÃ³vel na Praia do Ingleses FlorianÃ³polis/SC - Restaurante CamarÃ£o Dourado', 'undefined', '2019-04-30 12:27:10', '2019-04-30 12:27:10'),
(278, 3, 4, '5008934-16.2015.4.04.7200', 'UsucapiÃ£o. Arminio Motta Collier', 'undefined', '763521887115', '2019-04-30 14:07:29', '2019-04-30 14:07:29'),
(279, 3, 4, '5001087-94.2019.4.04.7208', 'RIP 8265.0000401 - 86. Porto Belo', 'AÃ‡ÃƒO DECLARATÃ“RIA DE INEXIGIBILIDADE DE DÃ‰BITO C/C REVISÃƒO DE TAXA DE OCUPAÃ‡ÃƒO.', '403713207519', '2019-04-30 17:33:02', '2019-04-30 17:33:02'),
(280, 3, 1, '03129454920188240008', 'RetificaÃ§Ã£o de Registro ImobiliÃ¡rio - R. ItajaÃ­', 'AnÃ¡lise de interferÃªncia de Ã¡rea, objeto de AÃ§Ã£o de RetificaÃ§Ã£o de Ã¡rea, com as terras da UniÃ£o.', 'undefined', '2019-04-30 17:46:27', '2019-04-30 17:46:27'),
(281, 3, 4, '5002575-13.2016.4.04.7201', 'Nulidade de Processe DemarcatÃ³rio. Barra Velha', 'undefined', '393196074016', '2019-04-30 18:10:03', '2019-04-30 18:10:03'),
(282, 3, 1, '0301100-56.2015.8.24.0030', 'undefined', 'undefined', 'undefined', '2019-05-02 13:10:15', '2019-05-02 13:10:15'),
(283, 3, 2, '5009514-07.2019.4.04.7200', 'PRAD.  Rodovia AÃ§oriana â€“ Tapera â€“ FlorianÃ³polis', 'AlteraÃ§Ã£o da delimitaÃ§Ã£o imposta ao bem imÃ³vel de propriedade da REQUERENTE e objeto do PRAD, de 30 (trinta) metros para 05 (cinco) metros de recomposiÃ§Ã£o de Ã¡rea de APP a partir do curso dâ€™agua,', 'undefined', '2019-05-02 17:10:25', '2019-05-02 17:10:25'),
(284, 3, 4, '5030689-33.2014.4.047200', 'UsucapiÃ£o. Portozelo Atacadista Ltda', 'undefined', '714693383114', '2019-05-02 19:14:43', '2019-05-02 19:14:43'),
(285, 2, 4, '5018427-09.2018.4.04.7201', 'Dano Ambiental. BalneÃ¡rio Rosa dos Ventos, ItapoÃ¡/SC', 'DemoliÃ§Ã£o das edificaÃ§Ãµes (casa, muros, \"deck\" e quiosque) existentes na propriedade do primeiro demandado, localizada na rua Jacarezinho em BalneÃ¡rio Rosa dos Ventos, ItapoÃ¡/SC, com a reparaÃ§Ã£o da Ã¡rea degradada e a condenaÃ§Ã£o dos rÃ©us ao pagamento de indenizaÃ§Ã£o pelo dano causado ao meio ambiente. Requereu, ainda, que os entes pÃºblicos, dentro das atribuiÃ§Ãµes afetas ao seu poder de polÃ­cia administrativa, adotem as medidas necessÃ¡rias Ã  preservaÃ§Ã£o da Ã¡rea', '172929667418', '2019-05-02 20:03:06', '2019-05-02 20:03:06'),
(286, 3, 4, '5009025-64.2019.4.04.7201', 'UsucapiÃ£o. MARIELA DAS GRACAS PIERUCCINI DELGOBBO', 'undefined', 'undefined', '2019-05-02 20:56:09', '2019-05-02 20:56:09'),
(287, 3, 4, '5001486-26.2019.4.04.7208', 'UsucapiÃ£o. JOCELMO SANTOS', 'undefined', 'undefined', '2019-05-02 21:10:48', '2019-05-02 21:10:48'),
(288, 8, 4, '5049144-59.2017.4.04.7000', 'EMBARGOS Ã€ EXECUÃ‡ÃƒO FISCAL NÂº 5049144-59.2017.4.04.7000/PR', 'Trata-se de embargos Ã¡ execuÃ§Ã£o fiscal em que a embargante visa\r\ndesconstituir as certidÃµes de dÃ­vida ativa 9061400161002, 9061101856050, 9061600066666,\r\nreferentes a taxa de ocupaÃ§Ã£o do RIP 8041.0000434-60 no perÃ­odo de 1988 a 2013 e a\r\ncertidÃ£o de dÃ­vida ativa 9061600066747 referente a taxa de ocupaÃ§Ã£o do RIP 8245.0000178-\r\n05 no perÃ­odo de 2009 a 2013.', 'undefined', '2019-05-03 12:46:03', '2019-05-03 12:46:03'),
(289, 3, 4, '5000344-02.2010.4.04.7208', 'Nulidade de Processo de DemarcaÃ§Ã£o. s RIP\'s 8265.0000221-02, 8265.0000222-85 e 8265.0000762-96', 'undefined', 'undefined', '2019-05-03 14:13:29', '2019-05-03 14:13:29'),
(290, 3, 4, '5004123-81.2018.4.04.7208', 'RevisÃ£o do valor cobrado a tÃ­tulo de taxa de ocupaÃ§Ã£o RIP nÂ° 8161.0000769-12 e 8161.0000773-07', 'undefined', '231573566918', '2019-05-03 17:08:58', '2019-05-03 17:08:58'),
(291, 2, 1, '5000828-93.2019.4.04.7210', 'Dano Ambiental. Rio Uruguai, MunicÃ­pio de MondaÃ­/SC', 'o desfazimento da edificaÃ§Ã£o na Ã¡rea de preservaÃ§Ã£o permanente marginal ao Rio Uruguai, na propriedade deste, localizada na Linha Mondaizinho, interior do MunicÃ­pio de MondaÃ­/SC, matriculada no CartÃ³rio de Registro de ImÃ³veis da Comarca de MondaÃ­, SC, sob n. 2.326, bem como a retirada de todos os equipamentos que alteram aquela Ã¡rea e impedem a sua regeneraÃ§Ã£o natural', '125152241919', '2019-05-03 17:59:47', '2019-05-03 17:59:47'),
(292, 3, 1, '0302403-80.2017.8.24.0048', 'RIP ns. 8245.0100030-33 e 8245.0100031-14', 'AÃ§Ã£o de obrigaÃ§Ã£o de fazer visando a regularizaÃ§Ã£o dos imÃ³veis junto Ã  SPU, bem como a condenaÃ§Ã£o do rÃ©u em indenizaÃ§Ã£o por dano.', 'undefined', '2019-05-03 18:19:25', '2019-05-03 18:19:25'),
(293, 6, 1, '0169/2017-4', 'ocupaÃ§Ã£o irregular.  Estrada Geral de acesso ao BalneÃ¡rio Figueirinha, em Jaguaruna/SC', 'undefined', 'undefined', '2019-05-03 18:41:39', '2019-05-03 18:41:39'),
(294, 1, 1, '1.33.005.000307/2017-75', 'Apurar regularidade da ocupaÃ§Ã£o da Ilha dos Herdeiros - BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'Ilha dos Herdeiros, com RIP 83190000094-60, R!P 83190000181-08, RIP 83190000186-12 e RIP 83190000505-08', 'undefined', '2019-05-06 11:51:14', '2019-06-07 16:18:27'),
(295, 1, 1, '1.33.000.000165/2016-51', 'Despejo de efluentes nÃ£o tratados na rede pluvial. Praia do Campeche,', 'undefined', 'undefined', '2019-05-06 14:03:27', '2019-05-06 14:03:27'),
(296, 1, 1, '1.33.007.000250/2018-11', 'undefined', 'AÃ§Ã£o de RetificaÃ§Ã£o de Registro ImobiliÃ¡rio n. 0300068-51.2019.8.24.0167, por Beatriz Albano de Abreu, para retificaÃ§Ã£o da Ã¡rea constante da matrÃ­cula n. 4.072 do Registro de ImÃ³veis da Comarca de Garopaba/SC, para que conste a Ã¡rea de 3.450 mÂ²m em razÃ£o do erro material na sentenÃ§a proferida nos autos n. 0000025-57.2000.8.24.0167', 'undefined', '2019-05-06 14:17:59', '2019-05-06 14:17:59'),
(297, 2, 4, '5011128-18.2017.4.04.7200', 'Zona Costeira da Parte Continental. FlorianÃ³polis.', 'IdentificaÃ§Ã£o, a delimitaÃ§Ã£o e a caracterizaÃ§Ã£o jurÃ­dica e tÃ©cnica de todas as intervenÃ§Ãµes ilegais efetuadas sobre bens da UniÃ£o na Zona Costeira da Parte Continental. FlorianÃ³polis.', '167898315517', '2019-05-06 17:31:27', '2019-05-06 17:31:27'),
(298, 3, 2, '0001371-08.2012.8.24.0075', 'UsucapiÃ£o', 'MunicÃ­pio de Pedras Grandes/SC', 'undefined', '2019-05-07 12:36:31', '2019-05-07 12:36:31'),
(299, 3, 3, '84.00.23567-3', 'DesapropriaÃ§Ã£o em nome da UniÃ£o.', 'undefined', 'undefined', '2019-05-07 13:07:24', '2019-05-07 13:07:24'),
(300, 1, 1, '1.33.005.000072/2014-14', 'EdificaÃ§Ã£o realizada por Eliezer Flores Dias, Avenida AtlÃ¢ntica, BalneÃ¡rio SaÃ­ Mirim, ItapoÃ¡/SC', 'undefined', 'undefined', '2019-05-07 13:07:43', '2019-05-07 13:07:43'),
(301, 3, 1, '82.00.17502-2', 'DesapropriaÃ§Ã£o de imÃ³vel em nome da UniÃ£o.', 'undefined', 'undefined', '2019-05-07 13:30:14', '2019-05-07 13:30:14'),
(302, 1, 1, '1.33.005.000375/2016-07', 'OcupaÃ§Ã£o Irregular - Gleydis Elisabeth Favero - BalneÃ¡rio Princesa do Mar- ItapoÃ¡', 'undefined', 'undefined', '2019-05-07 14:14:17', '2019-05-07 14:14:17'),
(303, 1, 1, '1.33.005.000844/2016-80', 'Irregularidades no bairro Guanabara, Joinville - Entre as ruas Nacar e dos Cravos', 'undefined', 'undefined', '2019-05-07 16:16:24', '2019-05-07 16:16:24'),
(304, 1, 1, '1.33.005.000925/2016-80', 'PossÃ­vel invasÃ£o em APP, rua Natanael Amorim Vieira, Bairro Paranaguamirim, Joinville', 'procedimento instaurado para apurar possÃ­vel invasÃ£o em Ã¡rea de preservaÃ§Ã£o permanente, na rua Natanael Amorim Vieira, Bairro Paranaguamirim, particularmente sobre o caso em tela, localizado no ponto de coordenadas 7083242/ 722641, conforme informado no Boletim de FiscalizaÃ§Ã£o nÂº 006472 da Secretaria do Meio Ambiente da Prefeitura Municipal de Joinville/SC', 'undefined', '2019-05-07 16:24:18', '2019-05-07 16:24:18'),
(305, 1, 1, '1.33.005.000325/2016-11', 'Regularidades em 3 loteamentos no MunicÃ­pio de ItapoÃ¡', 'descriÃ§Ã£o referentes Ã s Ã¡reas geograficamente apontadas  (Loteamento01:  26Â°04\'34.04\"S,  48Â°36\'39.94\"0;  Loteamento  02:  26Â°04\'24.90\"S,  48Â°36\'09.82\"0;  Loteamento  03:  26Â°03\'54.40\"S,  48Â°36\'39.95\"O),  notadamentese  estas  pertencem  Ã   UniÃ£o   e  se  abrangem   terras   de  marinha   e  seusacrecidos;(ii)   em  caso  de  resposta  afirmativa  em  relaÃ§Ã£o  ao item  anterior  (i),   sejainformado  se hÃ¡  registros  de  ocupaÃ§Ãµes  regulares  na Ã¡rea  perante  a  SPU equem  Ã©/sÃ£o o(s) titular(es);(iii)  em  caso  de  resposta  negativa  em  relaÃ§Ã£o  ao  item  (i),   se  a  SPU foinotificada  pelo  MunicÃ­pio  de  ItapoÃ¡   ou  por  outra  fonte  a  respeito  deeventuais  ocupaÃ§Ãµes irregulares das citadas  Ã¡reas', 'undefined', '2019-05-07 16:57:00', '2019-05-07 16:57:00'),
(307, 7, 4, '5015010720-78.2018.4.04.7107', 'embargos Ã  execuÃ§Ã£o fiscal', 'embargos Ã  execuÃ§Ã£o fiscal nÂº 5015010720-78.2018.4.04.7107 (chave eletrÃ´nica do\r\nprocesso 203975010318) no qual o contribuinte questiona a dÃ­vida inscrita sob o nÂº 0061600096337 e 0061602101508. Dentre\r\noutros argumentos, a parte embargante suscitou a nulidade da inscriÃ§Ã£o por suposta ausÃªncia de notificaÃ§Ã£o do lanÃ§amento.', '203975010318', '2019-05-07 16:58:58', '2019-05-07 16:58:58'),
(312, 1, 1, '1.33.005.000088/2011-84', 'Av. Principal, sn - Pontal da Figueira - ItapoÃ¡', 'undefined', 'undefined', '2019-05-07 17:14:06', '2019-05-07 17:14:06'),
(313, 9, 4, '5002607-47.2018.4.04.7201', 'HACASA ADMINISTRACAO E EMPREENDIMENTOS IMOBILIARIOS S/A 8179.0001357-09, 8179.0001365-19, 8179.0003251-68, 8179.0003530-21, 8179.0100144-40 e 8179.000', 'SuspensÃ£o de dÃ©bitos inscritos em DAU, sob o fundamento de que apresentou impugnaÃ§Ã£o administra)va referente aos RIP\'s 8179.0001357-09, 8179.0001365-19, 8179.0003251-68, 8179.0003530-21, 8179.0100144-40 e 8179.0003254-00.', '494234428918', '2019-05-07 17:26:24', '2019-05-07 17:26:24'),
(314, 3, 4, '5000704-98.2019.4.04.7214', 'USUCAPIÃƒO.  ADILSON DOS SANTOS', NULL, '923881140019', '2019-05-07 17:44:07', '2019-05-07 17:44:07'),
(315, 3, 4, '5015095-37.2018.4.04.7200', 'UsucapiÃ£o. GENESIO JORGE DOS SANTOS', 'undefined', '178657228818', '2019-05-07 17:59:27', '2019-05-07 17:59:27'),
(316, 3, 4, '5000965-57.2019.4.04.7216', 'UsucapiÃ£o. CLAUDIA JULIANA OCHS MACIE', 'undefined', '247445992919', '2019-05-07 18:46:26', '2019-05-07 18:47:15'),
(317, 3, 3, '5007982-59.2014.4.04.7204', 'AÃ§Ã£o de Interdito ProibitÃ³rio. loteamento Miramar Zona Velha, Avenida Waldemar Carlos Petrini, no municÃ­pio de BalneÃ¡rio RincÃ£o/SC', 'undefined', 'undefined', '2019-05-07 19:58:20', '2019-05-07 19:58:20'),
(318, 3, 4, '5004183-44.2019.4.04.7200', 'UsucapiÃ£o. Marcia Firmina Goulart', 'undefined', '405760876719', '2019-05-07 20:27:29', '2019-05-07 20:27:29'),
(319, 6, 1, '0029/2019-4 - SR/PF/SC', 'undefined', 'ImÃ³vel localizado entre as ruas Antenor Borges e a esquina Vasco de Oliveira Gondin, em Canasvieiras, FlorianÃ³polois/SC.', 'undefined', '2019-05-08 12:04:25', '2019-05-08 12:04:25'),
(320, 1, 1, '1.33.005.000096/2016-35', 'undefined', 'BalneÃ¡rio Barra do Sul - ImÃ³vel na Rua Camilo de Oliveira.', 'undefined', '2019-05-08 12:16:12', '2019-05-08 12:16:12'),
(321, 5, 1, '06.2013.00005891-0', 'undefined', 'Prestar os seguintes esclarecimentos: a) se as Ã¡reas atualmente ocupadas pela Locadora de DVD\'s e Ketty Lanches (PraÃ§a Vereador Halley Capanema), pelo Ney Lanches (Avenida Governador Celso Ramos) e pela ME Bar e Lanchonete (PraÃ§a Cel. Serafim da Silva Matos) se encontram em terrenos de marinha; b) e, em caso positivo, se existe procedimento de cessÃ£o de uso referente as Ã¡reas descritas no item anterior.', 'undefined', '2019-05-08 12:33:38', '2019-05-08 12:33:38'),
(323, 5, 1, '06.2019.00000608-0', 'undefined', 'ImÃ³vel em Joinville/SC.', 'undefined', '2019-05-08 16:59:56', '2019-05-08 16:59:56'),
(324, 3, 4, '5005406-17.2019.4.04.7205', 'UsucapiÃ£o.  LUCIA DE MATOS', 'undefined', 'undefined', '2019-05-08 17:29:07', '2019-05-08 17:29:07'),
(325, 3, 4, '5000203-46.2011.4.04.7208', 'AnulaÃ§Ã£o do Processo DemarcatÃ³rio. BalneÃ¡rio CamboriÃº', 'AÃ§Ã£o ordinÃ¡ria visando anular a inscriÃ§Ã£o dos terrenos do autores como de marinha, tornando inexigÃ­vel a cobranÃ§a de laudÃªmio/taxa de ocupaÃ§Ã£o, com repetiÃ§Ã£o dos valores pagos', 'undefined', '2019-05-08 17:54:17', '2019-05-08 17:54:17'),
(326, 9, 4, '5017860-78.2018.4.04.7200', 'Nulidade do aumento da taxa de OcupaÃ§Ã£o. RIP 8039.0002024-00 E 8039.0002612-53', 'undefined', 'undefined', '2019-05-08 18:44:20', '2019-05-08 18:44:20'),
(327, 4, 1, '1.33.008.000537/2018-31', 'undefined', 'ImÃ³vel localizado na Rua JosÃ© Medeiros Vieira, 1538, Praia Brava, ItajaÃ­/SC', 'undefined', '2019-05-09 12:49:30', '2019-05-09 12:49:30'),
(328, 1, 1, '1.33.000.000326/2017-97', 'undefined', 'Projeto Orla e o gerenciamento costeiro, em FlorianÃ³polis -  Barra da Lagoa da ConceiÃ§Ã£o.', 'undefined', '2019-05-09 13:11:42', '2019-05-09 13:11:42'),
(329, 3, 4, '5002024-07.2019.4.04.7208', 'UsucapiÃ£o. Felix Felipe Euflorzinho', 'undefined', 'undefined', '2019-05-09 13:41:08', '2019-05-09 13:41:08'),
(330, 2, 1, '5002226-60.2019.4.04.7215', 'Dano Ambiental.  Parque Nacional da Serra do ItajaÃ­', 'DemoliÃ§Ã£o de obras e Ã  completa recuperaÃ§Ã£o ambiental de Ã¡rea localizada na Zona de Amortecimento do Parque Nacional da Serra do ItajaÃ­', 'undefined', '2019-05-09 16:52:11', '2019-05-09 16:52:11'),
(331, 3, 4, '5009330-48.2019.4.04.7201', 'LaudÃªmio. RIP 8041.0000499-06', 'aÃ§Ã£o ajuizada sob o procedimento comum por Edson JosÃ© Jacobi em face da UniÃ£o visando ao reconhecimento da decadÃªncia do direito da UniÃ£o ao lanÃ§amento de laudÃªmio, Ã  declaraÃ§Ã£o de nulidade do lanÃ§amento de laudÃªmio, Ã  determinaÃ§Ã£o para que o cÃ¡lculo do laudÃªmio se dÃª sobre o valor da avaliaÃ§Ã£o do terreno de marinha, Ã  determinaÃ§Ã£o para que a UniÃ£o se abstenha de inscrever o nome do autor em cadastros de proteÃ§Ã£o ao crÃ©dito e de executar o referido crÃ©dito, bem como continue a lhe fornecer certidÃ£o negativa de dÃ©bito', '142364079219', '2019-05-09 20:01:27', '2019-05-09 20:01:27'),
(332, 9, 4, '5013737-37.2018.4.04.7200', 'LUIZ ROBERTO OSSANI MENDONCA -', 'Concluir a anÃ¡lise dos pedidos de  averbaÃ§Ã£o de transferÃªncia  n. 04972.004186/2009-86,protocolizado   em   16/10/2009,   e   dos   pedidos   de   outorga   gratuita   de   aforamentons.   04972.007791/2013-95   e   04972.207127/2015-14,', '509796007218', '2019-05-10 18:59:25', '2019-05-10 18:59:25'),
(333, 9, 4, '5010405-28.2019.4.04.7200', 'ALTAMIRO ROGÃ‰RIO PHILIPPI E OUTROS. AÃ§Ã£o contra decisÃ£o que indeferiu pedido de cancelamento de dÃ©bitos de laudÃªmio por prescriÃ§Ã£o', 'undefined', '565402628519', '2019-05-13 20:33:19', '2019-05-13 20:33:19'),
(334, 3, 1, '189.09.000472-5', 'UsucapiÃ£o', 'o imÃ³vel estÃ¡ situado em local prÃ³ximo Ã  rodovia municipal PGR-104, no municÃ­pio de Praia Grande/SC.', 'undefined', '2019-05-14 11:59:29', '2019-05-14 11:59:29'),
(336, 3, 2, '0043300-44.2008.5.12.0043', 'AÃ‡ÃƒO TRABALHISTA', 'Penhora de imÃ³vel que esteja em nome da empresa Imbituba Empreendimentos e ParticipaÃ§Ãµes S/A, CNPJ 27.276.211/0001-08', 'undefined', '2019-05-14 12:56:11', '2019-05-14 12:56:11'),
(337, 3, 1, '5000883-65.2019.4.04.7203', 'AÃ‡ÃƒO DE RETIFICAÃ‡ÃƒO DE ÃREA E REGISTRO', 'undefined', 'undefined', '2019-05-14 17:02:45', '2019-05-14 17:02:45'),
(338, 3, 4, '5010572-26.2011.4.04.7200', 'UsucapiÃ£o Federal.Mandarim Comercio de PeÃ§as e AcessÃ³rios Ltda', 'undefined', '712838609311', '2019-05-14 17:14:03', '2019-05-14 17:14:03'),
(339, 9, 4, '5010278-90.2019.4.04.7200', 'Multa de TransferÃªncia. RIP 8105.0002093-93', 'undefined', ': 666855601819', '2019-05-14 17:44:31', '2019-05-14 17:44:31'),
(341, 3, 4, '5009765-25.2019.4.04.7200', 'AÃ§Ã£o de InventÃ¡rio. RIP 8105.0001110-75', 'SUBSÃDIOS DE FATO E DE DIREITO para a defesa da UniÃ£o, especialmente se Ã© necessÃ¡rio processo judicial de arrolamento para a transferÃªncia da ocupaÃ§Ã£o RIP nÂº 8105.0001110-75 para a requerente', 'undefined', '2019-05-14 18:33:08', '2019-05-14 18:33:08'),
(342, 1, 1, '1.33.001.000535/2017-21', 'undefined', 'Regularidade do empreendimento \"Spazio Bauhaus\" - localizado na Rua Heinrich Hemmer, nÂ° 1900, Bairro Badenfurt, municÃ­pio de Blumenau.', 'undefined', '2019-05-15 12:26:42', '2019-05-15 12:26:42'),
(343, 1, 1, '1.33.008.000015/2018-39', 'undefined', 'Regularidade da posse exercida nos lotes 4, 5, 6, 8, 11/12 e 20/21, do Loteamento Jardim das Gaivotas, no MunicÃ­pio de Itapema.', 'undefined', '2019-05-15 12:42:39', '2019-05-15 12:42:39'),
(344, 2, 1, '5010110-88.2019.4.04.7200', 'ConstruÃ§Ã£o de Antena. Praia da Galheta . FlorianÃ³polis', 'Suspender a execuÃ§Ã£o do Contrato nÂº CT-01071/2018/SSP-FUMPOM, de construÃ§Ã£o de Torre de RÃ¡dio, na Rod. Jorn. Manoel de Menezes - SC-406, prÃ³xima ao reservatÃ³rio da CASAN, no morro da Praia da Galheta, bairro Lagoa da ConceiÃ§Ã£o, FlorianÃ³polis/SC', '691005818119', '2019-05-15 13:53:26', '2019-05-15 13:53:26'),
(345, 1, 1, '1.33.000.000002/2007-87', 'DemoliÃ§Ã£o de trapiche em Coqueiros, FlorianÃ³polis/SC - LR Amorim Administradora de Bens LTDA', 'undefined', 'undefined', '2019-05-15 18:52:19', '2019-05-15 18:52:19'),
(346, 8, 1, '1.33.005.000788/2018-45', 'Supostas fraudes em aÃ§Ãµes de UsucapiÃ£o no MunicÃ­pio de Barra Velha', 'undefined', 'undefined', '2019-05-15 19:01:40', '2019-05-15 19:01:40'),
(347, 2, 3, '5014056-83.2015.4.04.7208', 'DANO AMBIENTAL', 'recuperaÃ§Ã£o ambiental da Ã¡rea tida como APP, em local denominado Canto do Morcego, Praia Brava, no MunicÃ­pio de\r\nItajaÃ­', '386195764815', '2019-05-16 12:50:53', '2019-05-16 12:50:53'),
(348, 3, 4, '5012648-23.2016.4.04.7208', 'IsenÃ§Ã£o de Taxa', 'undefined', 'undefined', '2019-05-16 13:01:09', '2019-05-16 13:01:09'),
(351, 3, 4, '5003297-89.2017.4.04.7208/SC', 'undefined', 'Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-16 18:23:12', '2019-05-16 18:23:12'),
(352, 3, 4, '5003816-64.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC.', 'undefined', '2019-05-16 18:26:35', '2019-05-16 18:26:35'),
(353, 3, 4, '5003295-22.2017.4.04.7208/SC', 'undefined', 'Ã  prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-16 18:29:03', '2019-05-16 18:29:03'),
(355, 3, 4, '5003801-95.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-16 18:31:29', '2019-05-16 18:31:29'),
(356, 3, 4, '5005666-56.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/S', 'undefined', '2019-05-16 18:34:52', '2019-05-16 18:34:52'),
(357, 3, 4, '5003271-91.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-16 18:37:42', '2019-05-16 18:37:42'),
(358, 3, 4, '5003276-16.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-16 18:40:09', '2019-05-16 18:40:09'),
(359, 1, 1, '1.33.000.001630/2014-17', 'Apura possÃ­veis danos ambientais provocados por construÃ§Ãµes em APP na Praia do Matadeiro, FlorianÃ³polis/SC', 'Apura possÃ­veis danos ambientais provocados por construÃ§Ãµes em APP na Praia do Matadeiro, FlorianÃ³polis/SC', 'undefined', '2019-05-16 20:31:00', '2019-05-16 20:31:00'),
(360, 2, 1, '5014152-88.2016.4.04.7200', 'Enseada do Brito, na PalhoÃ§a/SC', 'Proposta pelo MinistÃ©rio PÃºblico Federal contra Manoel Carvalho e Outros, tendo por objeto possÃ­vel terreno de marinha na Enseada do Brito, na PalhoÃ§a/SC, que estÃ¡ sendo ambientalmente danificada pelo rÃ©u. O objeto da aÃ§Ã£o, portanto, Ã© a recuperaÃ§Ã£o do meio ambiente', '595891167616', '2019-05-17 13:37:02', '2019-05-17 13:37:02'),
(361, 3, 4, '5019483-17.2017.4.04.7200', 'UsucapiÃ£o.Passagem do MassiambÃº, PalhoÃ§a/SC', 'undefined', '223986228917', '2019-05-17 14:28:11', '2019-05-17 14:28:11'),
(362, 3, 4, '5004092-27.2019.4.04.7208', 'AÃ‡ÃƒO ANULATÃ“RIA DE PROCESSO DE DEMARCAÃ‡ÃƒO. ITAJAÃ', 'undefined', '159470983319', '2019-05-17 17:17:28', '2019-05-17 17:17:28'),
(364, 3, 4, '0000503-21.2007.8.24.0167', 'UsucapiÃ£o. Garopaba', 'undefined', 'undefined', '2019-05-17 18:13:02', '2019-05-17 18:13:02'),
(365, 3, 4, '5003285-75.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-17 18:42:26', '2019-05-17 18:42:26'),
(366, 3, 4, '5003299-59.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:16:35', '2019-05-20 12:16:35'),
(367, 3, 4, '5003287-45.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 12:20:15', '2019-05-20 12:20:15'),
(368, 3, 4, '5003573-23.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:22:28', '2019-05-20 12:22:28'),
(369, 3, 4, '5003570-68.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:53:58', '2019-05-20 12:53:58'),
(370, 3, 4, '5003563-76.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:55:48', '2019-05-20 12:55:48'),
(371, 3, 4, '5003808-87.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 12:59:01', '2019-05-20 12:59:01'),
(372, 3, 4, '5003813-12.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 13:09:42', '2019-05-20 13:09:42'),
(374, 3, 4, '5003814-94.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 13:11:57', '2019-05-20 13:11:57'),
(375, 3, 4, '5004340-61.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 13:13:43', '2019-05-20 13:13:43'),
(376, 3, 4, '5003273-61.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 13:15:40', '2019-05-20 13:15:40'),
(377, 3, 3, '5024465-74.2017.4.04.7200', 'AÃ§Ã£o DemolitÃ³ria. Campeche. FlorianÃ³polis', 'AÃ§Ã£o DemolitÃ³ria. Campeche. FlorianÃ³polis', 'undefined', '2019-05-20 14:12:04', '2019-05-20 14:12:04'),
(378, 3, 4, '5000408-70.2019.4.04.7216', 'UsucapiÃ£o. JOSE ALCEBIADES DA SILVA', 'undefined', '725969139919', '2019-05-20 16:37:01', '2019-05-20 16:37:01'),
(379, 3, 4, '5001421-74.2014.4.04.7218', 'Interdito ProibitÃ³rio. Araquari', 'AÃ§Ã£o de Interdito ProibitÃ³rio nÂº 5001421-74.2014.4.04.7218, proposta por Alex Sandro de FranÃ§a, em face da UniÃ£o, em trÃ¢mite na Sexta Vara Federal da SubseÃ§Ã£o JudiciÃ¡ria de Joinville, SeÃ§Ã£o JudiciÃ¡ria de Santa Catarina, tendo por objeto, em apertado resumo, inclusive liminarmente, buscando uma ordem liminar para que a rÃ© se abstenha de turbar sua posse em relaÃ§Ã£o ao imÃ³vel localizado na Rua JoÃ£o Pessoa, s/nÂº, poste 1, Centro, Araquari/SC', 'undefined', '2019-05-20 18:16:19', '2019-05-20 18:17:40'),
(380, 3, 3, '5017705-05.2014.4.04.7204', 'ReintegraÃ§Ã£o de Posse.Rua Campos ElÃ­seos, s/n, Bairro Coloninha, Orleans/SC', 'Cumprimento de sentenÃ§a movido pela UniÃ£o em face de Feliciano Barbosa Dias, com objetivo de obter a reintegraÃ§Ã£o na posse do imÃ³vel \"localizado na Rua Campos ElÃ­seos, s/n, Bairro Coloninha, Orleans/SC, com Ã¡rea de 171,30 mÂ², e DETERMINAR a reintegraÃ§Ã£o da Rede FerroviÃ¡ria Federal - RFFSA (sucedida pela UniÃ£o) na posse do imÃ³vel\".', '591884905814', '2019-05-20 19:24:27', '2019-05-20 19:24:27'),
(381, 3, 4, '5001655-57.2012.4.04.7208', 'Nulidade de Processo DemarcatÃ³rio. CondomÃ­nio Vivaldi. Itapema', 'AÃ§Ã£o ordinÃ¡ria, na qual o autor, CONDOMÃNIO RESIDENCIAL VIVALDI busca provimento jurisdicional para o fim anular as inscriÃ§Ãµes de ocupaÃ§Ã£o e a cobranÃ§a de taxas de ocupaÃ§Ã£o, laudÃªmios e multas de transferÃªncia.', 'undefined', '2019-05-21 14:28:36', '2019-05-21 14:28:36'),
(382, 3, 4, '5001241-30.2010.4.04.7208', 'inexistÃªncia de obrigaÃ§Ã£o de pagar o laudÃªmio e multa por atraso na transferÃªncia. BalneÃ¡rio CamboriÃº', 'Objetiva seja declarada a inexistÃªncia de obrigaÃ§Ã£o de pagar o laudÃªmio e multa por atraso na transferÃªncia de imÃ³vel sob o regime de ocupaÃ§Ã£o.', 'undefined', '2019-05-21 16:54:58', '2019-05-21 16:54:58'),
(383, 1, 2, '1.33.005.000184/2016-07', 'undefined', 'Verificar regularidade e interferÃªncia da Ã¡rea com bem da UniÃ£o, casa e trapiche, localizadas na Rua JosÃ© Dobrotinick, esquina com a Avenida Lindolfo de Freitas Ledoux (coordenadas: 26Â°14\'50.53\"S/48Â°4228.081D)', 'undefined', '2019-05-21 18:19:10', '2019-05-21 18:19:10'),
(384, 3, 4, '5001558-28.2019.4.04.7203', 'Declarar nula a MatrÃ­cula nÂº 23.313, do CartÃ³rio do Registro de ImÃ³veis do 1Âº OfÃ­cio da Comarca de JoaÃ§aba.', 'undefined', '608358385119', '2019-05-21 18:19:24', '2019-05-21 18:19:24'),
(386, 3, 4, '5000642-64.2019.4.04.7212', 'USUCAPIÃƒO.  Linha Sede Floresta, Distrito de CaraÃ­ba, Seara/SC', 'undefined', 'undefined', '2019-05-21 18:46:11', '2019-05-21 18:46:11'),
(387, 2, 3, '5009822-82.2015.4.04.7200', 'Marina. Clube NÃ¡utico Sainth Barth. CacupÃ©. FlorianÃ³polis', 'ConstruÃ§Ã£o de uma Marina. Clube NÃ¡utico Sainth Barth. CacupÃ©. FlorianÃ³polis', 'undefined', '2019-05-21 20:35:24', '2019-05-21 20:35:24'),
(388, 1, 4, '1.33.005.000924/2016-35', 'undefined', 'quanto Ã  eventual concessÃ£o de registro de ocupaÃ§Ã£o em nome de JosÃ© Vanderlei dos Santos, CPF nÂ°. 603.484.709-59 - atividade de carcinicultura.', 'undefined', '2019-05-22 12:03:55', '2019-05-22 12:03:55'),
(392, 3, 2, '5008368-43.2015.4.04.7208', 'AÃ§Ã£o demolitÃ³ria', 'LimitaÃ§Ã£o administrativa - imÃ³vel localizado na Av. Aroeira da Praia, Mariscal, ao lado do n. 1527 - Bombinhas/SC', '264432311616', '2019-05-22 17:29:53', '2019-05-22 17:29:53'),
(393, 3, 4, '5002149-72.2019.4.04.7208', 'Valor da taxa de ocupaÃ§Ã£o- RIP 8265.0000568-56', 'undefined', 'undefined', '2019-05-22 17:47:55', '2019-05-22 17:47:55'),
(394, 3, 2, '5000800-37.2019.4.04.7207', 'REINTEGRAÃ‡ÃƒO DE POSSE', 'Informar eventual interesse da UniÃ£o na lide - Jaguaruna.', 'undefined', '2019-05-23 18:02:15', '2019-05-23 18:02:15'),
(395, 7, 4, '5045111-40.2018.4.04.0000', 'CessÃ£o de Uso. Trapiche. Clube NÃ¡utico Saint Barth. 8105.00417.500-0', 'Trata-se de agravo de instrumento interposto por CLUBE NÃUTICO SAINT BARTH em face de decisÃ£o que conheceu em parte da exceÃ§Ã£o de prÃ©-executividade oposta e, na parte conhecida, rejeitou as alegaÃ§Ãµes de ocorrÃªncia de prescriÃ§Ã£o e decadÃªncia.', 'undefined', '2019-05-23 18:33:07', '2019-05-23 18:33:07'),
(396, 2, 2, '2000.72.00.005294-8', 'undefined', 'Embargos de Obras', 'undefined', '2019-05-23 19:25:29', '2019-05-23 19:25:29'),
(397, 1, 2, '1.33.000.001271/2018-13', 'ConstruÃ§Ã£o irregular e supressÃ£o de vegetaÃ§Ã£o', 'Costa da Lagoa, nÂ° 47 - FlorianÃ³polis/SC', 'undefined', '2019-05-24 12:28:48', '2019-05-24 12:28:48'),
(400, 1, 1, '1.33.005.000308/2013-31', 'Ilha do Corisco - BaÃ­a da Babitonga', 'undefined', 'undefined', '2019-05-24 18:02:06', '2019-05-24 18:02:06'),
(401, 1, 1, '1.33.005.000062/2015-60', 'Nestor Domingo Roque FÃ©ssia - Barra Velha/SC', 'undefined', 'undefined', '2019-05-24 18:12:23', '2019-05-24 18:12:23'),
(402, 1, 1, '1.33.005.000343/2017-84', 'JosÃ© Loureiro I e II - Bairro Ulysses GuimarÃ£es - Joinville', 'undefined', 'undefined', '2019-05-24 19:15:58', '2019-05-24 19:15:58'),
(403, 1, 1, '1.33.005.000181/2017-84', 'OcupaÃ§Ã£o no loteamento JosÃ© Loureiro II - Bairro Ulysses GuimarÃ£es - Joinville/SC', 'OcupaÃ§Ãµes irregulares no loteamento JosÃ© Loureiro II, bairro Ulysses GuimarÃ£es.', 'undefined', '2019-05-24 19:47:05', '2019-05-24 19:47:05'),
(404, 3, 2, '06.2016.00001878-5', 'undefined', 'informaÃ§Ã£o/notÃ­cia de possÃ­vel utilizaÃ§Ã£o indevida de parte de terreno/acrescido de marinha cedido pela UniÃ£o ao MunicÃ­pio de SÃ£o JosÃ©/SC, em local denominado Angra de SÃ£o JosÃ© (Aterro hidrÃ¡ulico)', 'undefined', '2019-05-27 12:13:52', '2019-05-27 12:13:52'),
(405, 3, 4, '5005394-27.2019.4.04.7003', 'DeclaraÃ§Ã£o de inexistÃªncia de dÃ©bitos. RIP  8039.0001201-96', 'Trata-se de aÃ§Ã£o objetivando â€œb) julgar totalmente procedente a presente demanda com declaraÃ§Ã£o de inexistÃªncia de dÃ©bitos, condenando-se o Requerido ao ressarcimento dos valores cobrados indevidamente na importÃ¢ncia de R$ 1.663,44 (um mil seiscentos e sessenta e trÃªs reais e quarenta e seis centavos), cumulado com o pagamento de verba indenizatÃ³ria a tÃ­tulo de Danos Morais no importe de R$ 20.000,00 (vinte mil reais)â€', '663730364119', '2019-05-27 14:28:20', '2019-05-27 14:28:20'),
(406, 2, 2, '5004006-32.2014.404.7208/SC', 'undefined', 'Direito Ambiental', 'undefined', '2019-05-27 16:25:17', '2019-05-27 16:25:17'),
(407, 3, 1, '0000781-48.2007.4.04.7204', 'RegularizaÃ§Ã£o. Murialdo de Farias Alves', 'undefined', 'undefined', '2019-05-27 16:47:29', '2019-05-27 16:47:29'),
(408, 6, 1, '380/2019-4', 'Apura a prÃ¡tica do crime.  L.A.P Rodesindo Pavan, bairro Estaleiro, em BalneÃ¡rio CamboriÃº/SC', 'Apura a prÃ¡tica do crime previsto no Arts. 38, 39, 50 e/ou 64, todos da Lei nÂ° 9.605/98 , solicita-se a Vossa Senhoria que informe se a Ã¡rea onde se encontra um \"rancho\" para embarcaÃ§Ãµes em Ãrea de PreservaÃ§Ã£o Permanente situado prÃ³ximo a L.A.P. Rodesindo Pavan, bairro Estaleiro, em BalneÃ¡rio CamboriÃº/SC, e tambÃ©m prÃ³ximo Ã  subida da L.A.P. entre a Praia do Estaleiro e a Praia do Pinho, sem licenÃ§a do Ã³rgÃ£o ambiental, identificÃ¡vel nos documentos carreados na NF. 1.33.008.000458/2018-20', 'undefined', '2019-05-27 17:12:42', '2019-05-27 17:12:42'),
(409, 6, 1, '383/2019-4', 'Apura a prÃ¡tica do crime. Praia de Laranjeiras, prÃ³ximo ao trapiche que serve aos \"barcos piratas\", em BalneÃ¡rio CamboriÃº/SC', 'apura a prÃ¡tica do crime previsto no Arts. 38, 38~A, 48, 50, 63 e/ou 64, todos da Lei nÂ° 9.605/98, solicita-se a Vossa Senhoria que informe se a Ã¡rea onde se encontra o estabelecimento comercial situado na Praia de Laranjeiras, prÃ³ximo ao trapiche que serve aos \"barcos piratas\", em BalneÃ¡rio CamboriÃº/SC, apontado na NotÃ­cia de Fato nÂ° 1.33.008.000042/2019-92', 'undefined', '2019-05-27 17:25:33', '2019-05-27 17:25:33'),
(410, 6, 2, 'IPL n. 0497/2018-4', 'undefined', 'Dados cartogrÃ¡ficos acerca do rio ItajaÃ­-AÃ§u.', 'undefined', '2019-05-28 12:09:41', '2019-05-28 12:09:41'),
(412, 3, 3, '5000554-89.2015.4.04.7204', 'ReintegraÃ§Ã£o de Posse. ISALTINO ESTEVAM. rua Campo ElÃ­sios, 185, Orleans', 'pedido formulado pela Rede FerroviÃ¡ria Federal S.A. (a qual foi sucedida pela UniÃ£o) em desfavor de Isaltivo Estevam foi acolhido, \"para o fim de declarar rescindido o contrato de cessÃ£o e transferÃªncia de posse da Ã¡rea de terras firmado entre as partes, e, em consequÃªncia, reintegrar a autora na posse da Ã¡rea objeto do contrato\". A aÃ§Ã£o diz respeito a imÃ³vel situado na rua Campo ElÃ­sios, 185, Orleans/SC, no ramal erradicado TubarÃ£o - Lauro MÃ¼ller.', 'undefined', '2019-05-28 16:37:42', '2019-05-28 16:37:42'),
(413, 2, 4, '5012541-66.2017.4.04.7200', 'Dano Ambiental. Rua Laurindo JosÃ© de Souza, 1155, Fortaleza da Barra', 'Visa Ã  condenaÃ§Ã£o dos rÃ©us,solidariamente, em obrigaÃ§Ã£o de fazer, para cessar ocupaÃ§Ã£o de Ã¡rea de preservaÃ§Ã£o permanente localizada em terreno de marinha (faixa marginal do Canal da Barra da Lagoa â€” APP de 50m), mais especificamente na Rua Laurindo JosÃ© de Souza, 1155, Fortaleza da Barra, nesta Capital/SC, assim como pretende a demoliÃ§Ã£o e a remoÃ§Ã£o das estruturas ilegalmente erigidas naquela Ã¡rea non aedificandi e, finalmente, sua recuperaÃ§Ã£o ambiental.', '640141220217', '2019-05-28 17:27:11', '2019-05-28 17:27:11'),
(414, 8, 4, '223/2019 Â­ DPU JOINVILLE/CARTÃ“RIO JOI', 'undefined', 'SolicitaÃ§Ã£o de RegularizaÃ§Ã£o de TransferÃªncia - Joinville/SC', 'undefined', '2019-05-28 17:34:01', '2019-05-28 17:34:01'),
(415, 3, 4, '5022582-58.2018.4.04.7200', 'UsucapiÃ£o. Estrada Jornalista  Jaime de Arruda Ramos, 1459, Ponta das Canas, em  FlorianÃ³polis', 'UsucapiÃ£o. Estrada Jornalista  Jaime de Arruda Ramos, 1459, Ponta das Canas, em  FlorianÃ³polis', '645928863118', '2019-05-28 17:50:44', '2019-05-28 17:50:44'),
(417, 8, 1, '16814.100448/2018-25', 'Engemede ComÃ©rcio e ConstruÃ§Ãµes Ltda', 'Processo Administrativo PGFN 16814.100448/2018-25', 'undefined', '2019-05-28 17:58:49', '2019-05-28 17:58:49'),
(418, 3, 1, '5005798-66.2019.4.04.7201', 'PAULINA HERONDINA WAGNER E OUTROS', 'undefined', 'undefined', '2019-05-28 18:30:52', '2019-05-28 18:30:52'),
(419, 2, 4, '5010039-91.2016.4.04.7200', 'Dano Ambiental. SÃ£o JosÃ©, entre o Rio AarÃºjo e o Rio Maruim', 'Dano Ambiental. SÃ£o JosÃ©, entre o Rio AarÃºjo e o Rio Maruim', '185263663116', '2019-05-28 18:53:07', '2019-05-28 18:53:07'),
(420, 3, 3, '5046511-89.2018.4.04.0000', 'AÃ§Ã£o rescisÃ³ria. RIP 8179.0003114-50', 'AÃ§Ã£o rescisÃ³ria nÂº 2009.04.00.015065-7 (5046511-89.2018.4.04.0000 - numeraÃ§Ã£o nova) em face de DIACIR DAS DORES CORDEIRO REINERT, a fim de desconstituir julgado proferido nos autos da aÃ§Ã£o ordinÃ¡ria nÂº 2003.72.01003475-0.', '347451512018', '2019-05-29 18:07:01', '2019-05-29 18:07:01'),
(421, 7, 4, '5002985-55.2018.4.04.7216', 'Embargos Ã  ExecuÃ§Ã£o. Fazenda Ponta da Ilha', 'undefined', 'undefined', '2019-05-29 19:16:02', '2019-05-29 19:16:02'),
(422, 2, 3, '5015868-53.2016.4.04.7200', 'Dano Ambiental.  Rua Osni Ortiga, 2145, bairro da Lagoa da ConceiÃ§Ã£o, FlorianÃ³polis, SC', 'visa Ã  condenaÃ§Ã£o do rÃ©u em obrigaÃ§Ãµes de fazer, consistentes na desocupaÃ§Ã£o de terreno de marinha caracterizado como Ã¡rea de preservaÃ§Ã£o permanente, na Rua Vereador Osni Ortiga (ao lado do imÃ³vel n. 2267), no distrito da Lagoa da ConceiÃ§Ã£o, nesta Capital, bem como na integral e efetiva recuperaÃ§Ã£o ambiental da Ã¡rea', '289926608316', '2019-05-30 13:43:07', '2019-05-30 13:43:07'),
(423, 2, 4, '5012227-71.2018.4.04.7205', 'Barragens Oeste, Sul e Norte, localizadas no Alto Vale do ItajaÃ­, nos municÃ­pios de TaiÃ³, Ituporanga e JosÃ© Boiteux', 'Trata-se de AÃ§Ã£o Civil PÃºblica em fase de cumprimento de sentenÃ§a contra a UNIÃƒO e o ESTADO DE SANTA CATARINA em razÃ£o de terem sido condenados solidariamente a realizarem diversos serviÃ§os de manutenÃ§Ã£o e recuperaÃ§Ã£o nos sistemas das barragens Oeste, Sul e Norte, localizadas no Alto Vale do ItajaÃ­, nos municÃ­pios de TaiÃ³, Ituporanga e JosÃ© Boiteux, respectivamente.', '350775856418', '2019-05-30 14:25:50', '2019-05-30 14:25:50'),
(424, 9, 4, '5008035-13.2018.4.04.7200', 'TransferÃªncia. RIP 8265.0100190-07. Porto Belo', 'Determinar Ã  autoridade coatora que realize todos os atos administrativos necessÃ¡rios Ã  transferÃªncia de titularidade da ocupaÃ§Ã£o do terreno de marinha matriculado sob o Registro ImobiliÃ¡rio Patrimonial n. 8265.0100190-07.', 'undefined', '2019-05-30 17:50:07', '2019-05-30 17:50:07'),
(425, 1, 1, '1.33.007.000053/2016-30', 'Lagoa de ImaruÃ­, na Rua JoÃ£o Madalena, TaquaraÃ§utuba, ImaruÃ­/SC', 'Verificar a existÃªncia de barracos de pesca, supostamente irregulares,\nsituados Ã  beira da Lagoa de ImaruÃ­.', 'undefined', '2019-05-30 18:06:33', '2019-05-30 18:06:33'),
(426, 1, 1, '1.33.007.000180/2015-58', 'Ranchos de pesca. Praia Norte de Itapiruba em Imbituba/SC', 'CONSTRUÃ‡ÃƒO EM ÃREA DE PRAIA MARÃTIMA. PRAIA DE ITAPIRUBA. IMBITUBA-SC', 'undefined', '2019-05-30 18:26:09', '2019-05-30 18:26:09'),
(427, 3, 4, '5002407-11.2016.4.04.7201', 'UsucapiÃ£o', 'Pagamento de perÃ­cia.', 'undefined', '2019-05-31 15:21:03', '2019-05-31 15:21:03'),
(429, 3, 4, '5002519-47.2016.4.04.7211', 'UsucapiÃ£o', 'Pagamento de honorÃ¡rios periciais.', 'undefined', '2019-05-31 15:28:38', '2019-05-31 15:28:38'),
(430, 9, 4, '5004754-88.2019.4.04.7208', 'TERRENO DE MARINHA - AVENIDA REPUBLICA ARGENTINA, S/N -  ITAJAI, SC - RIP 8161 0100112-36', 'a parte autora requer em CARÃTER LIMINAR, o pedido de tutela de urgÃªncia, para\r\nque a Requerida promova a reativaÃ§Ã£o da RIP nÂ°8161.0100112-36, junto ao processo administrativo nÃºmero\r\n10983.003074/8561, expedindo a guia para recolhimento da taxa de laudÃªmio e a consequente transferÃªncia de domÃ­nio\r\nÃºtil em nome do Requerente, no prazo mÃ¡ximo de 30 (trinta) dias, impondo-se multa diÃ¡ria no valor de R$ 1.000,00 (um\r\nmil reais), em caso de inadimplemento, nos termos do Artigo 300 do CPC', '993895322919', '2019-05-31 17:01:36', '2019-05-31 17:01:36'),
(431, 3, 4, '5013537-32.2015.4.04.7201', 'Nulidade do Procedimento DemarcatÃ³rio. Joinville', 'Se declarar nÃ£o ser o imÃ³vel objeto da matrÃ­cula nÂº 9.357 do 1Âº OfÃ­cio de Registro de ImÃ³veis de Joinville - e inscriÃ§Ãµes imobiliÃ¡rias constantes do Anexo IV - patrimÃ´nio da UniÃ£o, na qualidade de \'terreno de marinha\' e, por consequÃªncia, o reconhecimento a inexigibilidade dos dÃ©bitos relativos Ã  taxa de ocupaÃ§Ã£o e do laudÃªmio para a transferÃªncia onerosa do aludido imÃ³vel', '347453147115', '2019-05-31 20:51:54', '2019-05-31 20:51:54'),
(432, 3, 4, '5001588-11.2015.4.04.7201/SC', 'undefined', 'Trata-se de aÃ§Ã£o ordinÃ¡ria ajuizada contra a UniÃ£o objetivando a nulidade do processo de demarcaÃ§Ã£o dos terrenos de marinha, por desrespeitar a LPM de 1831 e por ausÃªncia de intimaÃ§Ã£o pessoal no processo administrativo, com a decorrente inexigibilidade dos valores devidos a tal tÃ­tulo.', 'undefined', '2019-06-03 16:03:04', '2019-06-03 16:03:04'),
(433, 9, 4, '5016609-25.2018.4.04.7200', 'Ultimar o processo 04972.000232.2009-78 em 60 dias', 'DEFERIU: \"(...) Ã \r\nautoridade impetrada o derradeiro prazo de 60 (sessenta) dias, ciente das\r\ndificuldades enfrentadas pela Secretaria de PatrimÃ´nio da UniÃ£o, para que ultime\r\na anÃ¡lise da documentaÃ§Ã£o apresentada e CONCLUA o Processo Administrativo\r\nprotocolado sob o n. 04972.000232.2009-78, sob pena de aplicaÃ§Ã£o de multa\r\ndiÃ¡ria em face de eventual descumprimento, que fixo em R$ 500,00 (quinhentos\r\nreais), tendo como dies a quo o primeiro dia Ãºtil apÃ³s o decurso do prazo acima\r\nconcedido (...)\".', '400123926818', '2019-06-03 19:55:59', '2019-06-03 19:55:59'),
(434, 2, 3, '5010973-83.2015.4.04.7200', 'Danos Ambientais. Praia de Palmas. Governador Celso Ramos', 'undefined', 'undefined', '2019-06-03 20:04:41', '2019-06-03 20:04:41'),
(435, 1, 1, '1.33.000.002031/2014-11', '\"Lava-Car Boto\", Fazenda da ArmaÃ§Ã£o, Governador Celso Ramos, TAUS.', '\"Lava-Car Boto\", Fazenda da ArmaÃ§Ã£o, Governador Celso Ramos, TAUS.', 'undefined', '2019-06-03 21:41:33', '2019-06-03 21:41:33'),
(436, 1, 1, '1.33.005.000371/2016-11', 'AveriguaÃ§Ã£o de regularidade de ocupaÃ§Ãµes na Ilha AraÃºjo de Fora - BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-06-03 23:11:35', '2019-06-03 23:11:35'),
(438, 1, 1, '1.33.005.000369/2016-41', 'Averiguar regularidade de ocupaÃ§Ã£o na Ilha AraÃºjo de Dentro, BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-06-03 23:21:37', '2019-06-03 23:21:37'),
(439, 1, 1, '1.33.005.000367/2016-52', 'Averiguar regularidade da ocupaÃ§Ã£o da Ilha dos Negros, na BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-06-03 23:29:03', '2019-06-03 23:29:03'),
(440, 8, 1, 'PAJ 2017/031-00133', 'DPU/SC x Fechamento acesso ao mar Barra da Lagoa x Barra NÃ¡utica Marina Escola', 'Vem solicitar informaÃ§Ãµes sobre o fechamento do acesso ao mar em ponto localizado Ã  R. HemÃ³genes Coelho, Barra da Lagoa, CEP 88.061-048, em tese, pela empresa Barra NÃ¡utica Marina Escola.', 'undefined', '2019-06-04 14:23:14', '2019-06-04 15:50:33'),
(441, 1, 1, '1.33.000.001391/2016-59', 'MPFx Fornecimento de Ã¡gua e energia elÃ©trica em Rancho de pesca, BiguaÃ§u', 'Requisito de manifestaÃ§Ã£o da SPU/SC sobre ranchos de pesca identificados pela FAMABI - FundaÃ§Ã£o Municipal de Meio Ambiente de BiguaÃ§u', 'undefined', '2019-06-04 14:56:34', '2019-06-04 15:53:22'),
(442, 8, 3, '5026348-22.2018.4.04.7200', 'undefined', 'AnotaÃ§Ã£o de indisponibilidade de transferÃªncia RIP  8327 0000129-76', 'undefined', '2019-06-04 15:46:58', '2019-06-04 15:46:58'),
(443, 1, 1, '1.33.008.000064/2011-03', 'Rio Bombinhas - HomolagaÃ§Ã£o de LPM - Bombinhas/SC', 'InformaÃ§Ã£o acerca da homologaÃ§Ã£o do restante das linhas do preamar mÃ©dio de 1831 e do limite dos terrenos de marinha no rio Bombinhas, assim como informe quanto a eventuais ocupaÃ§Ãµes irregulares existentes em bens da UniÃ£o naquele local, incluindo os terrenos de marinha e seus\nacrescidos.', 'undefined', '2019-06-04 16:20:08', '2019-06-04 16:20:08'),
(444, 9, 4, '5012052-58.2019.4.04.7200', 'mandado de seguranÃ§a proposto pela autarquia municipal SUPERINTENDÃŠNCIA DO PORTO DE ITAJAÃ', 'Trata-se de mandado de seguranÃ§a proposto pela autarquia municipal em face\r\ndo Superintendente da Secretaria de PatrimÃ´nio da UniÃ£o em que requer a suspensÃ£o do\r\nprocesso administrativo n. 04972.007208/2017-70 da Secretaria do PatrimÃ´nio da UniÃ£o em\r\nde Santa Catarina e para que desconstituÃ­do ato da autoridade coatora que concluiu pela\r\nlavratura de Contrato de CessÃ£o da Ã¡rea de 5.829,70 mÂ² ao MunicÃ­pio de Navegantes. Alega\r\nfalta de observÃ¢ncia ao contraditÃ³rio e de motivaÃ§Ã£o. Narrou que requereu a revisÃ£o do ato de\r\ncessÃ£o, pois a atual gestÃ£o \"tomou ciÃªncia de invasÃµes de grande parcela da Ã¡rea objeto de\r\ncessÃ£o, sem olvidar o necessÃ¡rio resguardo do imÃ³vel para atender as suas finalidades\", mas\r\nnÃ£o obteve Ãªxito. Apontou que a Ã¡rea leste do terreno objeto de cessÃ£o foi invadida em Ã¡rea\r\nde dez quilÃ´metros de extensÃ£o de praia. Disse ter tomado medidas para impedir a invasÃ£o,\r\nmas foram edificadas seis construÃ§Ãµes no local, em relaÃ§Ã£o as quais nÃ£o se sabe sobre a\r\nexistÃªncia de saneamento bÃ¡sico.', '272408424219', '2019-06-04 16:26:03', '2019-06-04 16:26:03'),
(445, 1, 1, '1.33.005.000093/2016-00', 'MPF x Rua Divina ProvidÃªncia - Bairro Comasa - Joinville', 'Solicita InformaÃ§Ãµes sobre terras de marinha e seus acrescidos, no entorno da Rua Divina ProvidÃªncia, Bairro Comasa, em Joinville; seja informado se hÃ¡ registro de ocupaÃ§Ã£o regular na Ã¡rea perante a SPU e quem Ã© o titular;  informado se a SPU foi notificada pelo MunicÃ­pio de Joinville ou outra fonte a respeito de possÃ­veis infraÃ§Ãµes no local e, tendo havido a aludida notificaÃ§Ã£o, quais medidas foram adotadas.', 'undefined', '2019-06-04 16:30:56', '2019-06-04 16:30:56');
INSERT INTO `procedimentoexterno` (`id`, `idTipoProcedimentoExterno`, `idPoloProcedimentoExterno`, `procedimento`, `resumo`, `descricao`, `chave`, `created_at`, `updated_at`) VALUES
(446, 1, 1, '1.33.007.00117/2013-50', 'Cancelamento de Cadastro - Praia de Ilhota - Laguna/SC', 'solicita manifestaÃ§Ã£o acerca do cancelamento dos RIPs na Praia da Ilhota, em Laguna/SC', 'undefined', '2019-06-04 16:35:16', '2019-06-04 16:35:16'),
(448, 2, 1, '0900104-95.2014.8.24.0045', 'Dano Ambiental. Ponta do Papagaio. PalhoÃ§a', 'undefined', 'undefined', '2019-06-04 16:46:28', '2019-06-04 16:46:28'),
(449, 1, 1, '1.33.008.000017/2016-66', 'Cancelamento de Cadastro - Parque Residencial Porto Belo - Porto Belo/SC', 'busca o cancelamento dos registros de ocupaÃ§Ã£o concernentes a terrenos de marinha localizados no Parque Residencial Porto Belo.', 'undefined', '2019-06-04 16:51:39', '2019-06-04 16:51:39'),
(450, 1, 1, '1.33.000.001713/2005-15', 'TAUS - Praia da Enseada do Brito - PalhoÃ§a/SC', 'solicita informaÃ§Ãµes sobre o atual andamento do caso das irregularidades nos ranchos de pesca localizados na Praia da Enseada do Brito, PalhoÃ§a/SC', 'undefined', '2019-06-04 17:00:49', '2019-06-04 17:00:49'),
(451, 1, 1, '1.33.000.000741/2017-41', 'FiscalizaÃ§Ã£o - Praia de Naufragados - FlorianÃ³polis/SC', 'Requisita a realizaÃ§Ã£o de vistoria no local e elaboraÃ§Ã£o de documento tÃ©cnico informando se as ocupaÃ§Ãµes, inclusive edificaÃ§Ã£o do SR. AMÃ‚NCIO LIDOMAR DA SILVA VARREIRA.', 'undefined', '2019-06-04 17:11:28', '2019-06-04 17:11:28'),
(453, 1, 1, '1.33.008.000582/2014-61', 'InterferÃªncia com terras da UniÃ£o - Via GastronÃ´mica da Praia de ArmaÃ§Ã£o do Itapocoroy - Penha/SC', 'Via GastronÃ´mica da Praia de ArmaÃ§Ã£o do Itapocoroy', 'undefined', '2019-06-04 19:30:29', '2019-06-04 19:30:29'),
(454, 9, 4, '5001010-24.2010.404.7201', 'aÃ§Ã£o rescisÃ³ria ajuizada por CARIN HUHN, CONRADO HUHN e DIANA MARA GONÃ‡ALVES HUHN em face da UniÃ£o - 5008938-80.2019.4.04.0000', 'Cuida-se de aÃ§Ã£o rescisÃ³ria ajuizada por CARIN HUHN, CONRADO HUHN e DIANA\r\nMARA GONÃ‡ALVES HUHN em face da UniÃ£o, buscando a rescisÃ£o de acÃ³rdÃ£o proferido nos autos da\r\napelaÃ§Ã£o nÂº 5001010-24.2010.404.7201/SC, que deu provimento o apelo da ora rÃ© e Ã  remessa oficial, para\r\nreconhecer como terreno de marinha o imÃ³vel da parte autora objeto da discussÃ£o (ev. 1).', 'undefined', '2019-06-04 19:37:05', '2019-06-04 19:37:05'),
(455, 1, 1, '1.33.008.000009/2016-10', 'Regularidade Cadastral - PiÃ§arras/SC', 'situaÃ§Ã£o atual do registro imobiliÃ¡rio das ilhas Feias e Itacolumis (Norte e Sul)', 'undefined', '2019-06-04 19:41:51', '2019-06-04 19:41:51'),
(456, 1, 1, '1.33.007.000311/2016-88', 'TAUS -  Praia da Vila - Imbituba/SC', 'Regularidade de ranchos de pesca', 'undefined', '2019-06-04 19:47:57', '2019-06-04 19:47:57'),
(459, 1, 1, '1.33.005.000888/2017-91', 'Regularidade Cadastral - Praia do Ervino, SÃ£o Francisco do Sul', 'informe a respeito de eventual anuÃªncia da SuperintendÃªncia do PatrimÃ´nio da UniÃ£o para utilizaÃ§Ã£o da Ã¡rea onde foi instalado o estacionamento para veÃ­culos, situada na esquina da Rua Caramuru com a Avenida AtlÃ¢ntica, na Praia do Ervino, SÃ£o Francisco do Sul', 'undefined', '2019-06-04 20:01:07', '2019-06-04 20:01:07'),
(460, 1, 1, '1.33.008.000193/2014-36', 'Muro em terreno de Marinha. Praia da ArmaÃ§Ã£o. Penha', 'undefined', 'undefined', '2019-06-04 20:22:56', '2019-06-04 20:22:56'),
(461, 1, 1, '1.33.000.000535/2017-31', 'TAUS - Lagoa da ConceiÃ§Ã£o - FlorianÃ³polis/SC', 'Ranchos de pesca em terras de marinha Ã s margens da Lagoa da ConceiÃ§Ã£o - FlorianÃ³polis/SC', 'undefined', '2019-06-04 20:30:27', '2019-06-04 20:30:27'),
(463, 1, 1, '1.33.007.000127/2017-19', 'Regularidade Cadastral - Barra de Ibiraquera - Imbituba/SC', 'terreno de marinha em nome de Ã‰dio Marques da Silva (Restaurante Tartaruga), para a localidade da Barra de Ibiraquera, municÃ­pio de Imbituba/SC', 'undefined', '2019-06-04 20:44:48', '2019-06-04 20:44:48'),
(464, 1, 1, '1.33.005.000864/2016-51', 'Regularidade Cadastral - Canal do Linguado -  SÃ£o Francisco do Sul e Araquari', 'Regularidade as ocupaÃ§Ãµes, cessÃµes e aforamentos existentes e realize fiscalizaÃ§Ã£o na Ã¡rea dos trapiches Ã s margens do Canal do Linguado, no\nlimite dos MunicÃ­pios de SÃ£o Francisco do Sul e Araquari, construÃ­dos, supostamente, em Ã¡rea da UniÃ£o e sem autorizaÃ§Ã£o do Ã³rgÃ£o ambiental competente', 'undefined', '2019-06-04 20:54:09', '2019-06-04 20:54:09'),
(465, 1, 1, '1.33.015.000078/2016-34', 'DestinaÃ§Ã£o dos bens imÃ³veis da UniÃ£o em Mafra/SC', 'Demanda destinada ao servidor Tullio, solicita informaÃ§Ãµes atualizadas sobre imÃ³veis em MAFRA, visando a incorporaÃ§Ã£o dos imÃ³veis. Demanda que jÃ¡ vem sendo tratada desde 2016.', 'undefined', '2019-06-04 20:57:59', '2019-06-04 20:57:59'),
(466, 3, 3, '5017897-76.2016.4.04.7200', 'DeclaratÃ³ria de nulidade de sentenÃ§a proferida em usucapiÃ£o estadual. BiguaÃ§u', 'undefined', '245674584016', '2019-06-04 21:02:40', '2019-06-04 21:02:40'),
(467, 1, 1, '1.33.005.000942/2016-17', 'Informa sobre a AÃ§Ã£o de Interdito ProibitÃ³rio n. 0300325-79.2016.8.24.0006.', 'undefined', 'undefined', '2019-06-04 21:03:58', '2019-06-04 21:03:58'),
(468, 1, 1, '1.33.005.000458/2010-01', 'Regularidade Cadastral - ImÃ³vel localizado na Rua JoÃ£o Luzia, n. 162 - Barra do Sul/SC', 'informaÃ§Ãµes acerca das providÃªncias adotadas a partir da notÃ­cia de irregularidade na ocupaÃ§Ã£o do imÃ³vel localizado na Rua JoÃ£o Luzia, n. 162, em Barra do Sul, e se existem dÃ©bitos pendentes.', 'undefined', '2019-06-04 21:11:37', '2019-06-04 21:11:37'),
(469, 1, 1, '1.33.000.002405/2014-90', 'MPF x ContruÃ§Ã£o do prÃ©dio Ilha do Arvoredo-Palmas-Gov. Celso Ramos x Construtora Sanluzzi', 'Requisitar informaÃ§Ãµes sobre intervenÃ§Ã£o em bens da UniÃ£o, existÃªncia e regularidade de inscriÃ§Ã£o de ocupaÃ§Ã£o da construÃ§Ã£o de um prÃ©dio denominado Ilha do Arvoredo, na Praia de Palmas, em Governador Celso Ramos/SC, de responsabilidade atribuÃ­da Ã  construtora Sanluzzi.', 'undefined', '2019-06-04 21:30:53', '2019-06-04 21:30:53'),
(475, 6, 4, '0069/2019-4', 'Regularidade Cadastral - Ilhas da BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'sobre quais as medidas adotadas para fiscalizaÃ§Ã£o e proteÃ§Ã£o do patrimÃ´nio da UniÃ£o nas ilhas da BaÃ­a da Babitonga.', 'undefined', '2019-06-04 21:33:50', '2019-06-04 21:33:50'),
(476, 1, 1, '1.33.009.000091/2015-91', 'Processo de cessÃ£o, IPHAN,  preservaÃ§Ã£o do ArmazÃ©m FerroviÃ¡rio, localizado no MunicÃ­pio de Matos Costa', 'Encaminhar cÃ³pia do despacho de instruÃ§Ã£o, solicita que informe em qual fase estÃ¡ o processo de cessÃ£o dos referidos bens ao IPHAN e como pretende dar maior celeridade para que a cessÃ£o seja efetivada.\r\nAinda, que esclareÃ§a quais as providÃªncias jÃ¡ adotou e que pretende adotar para a preservaÃ§Ã£o do ArmazÃ©m FerroviÃ¡rio, localizado no MunicÃ­pio de Matos Costa que estÃ¡ com risco de ruÃ­na em razÃ£o de graves danos na estrutura de telhado. Informo que o local Ã© ocupado por catador de reciclÃ¡veis, consoante o informado pelo IPHAN no Parecer TÃ©cnico nÂ° 219/2017, e que a ruÃ­na causa risco de graves ferimentos e atÃ© morte Ã quela pessoa.', 'undefined', '2019-06-04 21:36:46', '2019-06-04 21:36:46'),
(478, 1, 1, '1.33.009.000090/2015-47', 'CessÃ£o, Extinta RFFSA, MunicÃ­pio Porto UniÃ£o, ReiteraÃ§Ã£o', 'InformaÃ§Ãµes sobre o andamento e conclusÃ£o do processo de cessÃ£o dos bens imÃ³veis da extinta RFFSA existentes no MunicÃ­pio de Porto UniÃ£o.', 'undefined', '2019-06-04 21:53:32', '2019-06-04 21:53:32'),
(479, 2, 1, '5026468-07.2014.4.04.7200', 'MPF x Restaurante La Serena - JurerÃª Internacional', 'Requisitar informaÃ§Ãµes e o embargo/interdiÃ§Ã£o do local no prazo de 24 horas por razÃ£o de comunicaÃ§Ã£o de obra de concretagem caracterizando apropriaÃ§Ã£o de Ã¡rea comum do povo (praia), considerando anterior decisÃ£o judicial nos autos da ACP n.Âº 5026468-07.2014.4.04.7200 (Beach Clubs).', 'undefined', '2019-06-04 22:05:59', '2019-06-04 22:05:59'),
(480, 1, 1, '1.33.015.000076/2016-45', 'Assentamento IndÃ­gena, concessÃ£o de Ã¡rea, Mafra, Mafra/SC', 'InquÃ©rito Civil supracitado foi instaurado para acompanhar a solicitaÃ§Ã£o de um grupo de indÃ­genas residentes na cidade de Mafra/SC, que pleiteiam a concessÃ£o de uma Ã¡rea para assentamento indÃ­gena. Etnia kaigang.', 'undefined', '2019-06-04 22:50:32', '2019-06-04 22:50:32'),
(483, 1, 1, '1.33.000.001912/2017-59', 'MPF x Ilha do Campeche - Empresa Pioneira da Costa S/A', 'Destacar as informaÃ§Ãµes sobre a ausÃªncia de regularidade e de posse direta pela Empresa Pioneira da Costa S/A, para requisitar, visto o OfÃ­cio nÂ° 84467/2018, informaÃ§Ãµes sobre a soluÃ§Ã£o porventura encontrada para a ocupaÃ§Ã£o de fato existente na ilha na Ã¡rea inscrita para a referida empresa, e a possibilidade de sua regularizaÃ§Ã£o, inclusive ouvido o IPHAN.', 'undefined', '2019-06-04 22:53:29', '2019-06-04 22:53:29'),
(485, 4, 1, '1.33.007.000247/2018-05', 'RegularizaÃ§Ã£o FundiÃ¡ria, ImÃ³vel RFFSA, Projeto Lar Legal, Pedras Grandes/SC', 'Trata o presente do OfÃ­cio PRMT/N0 987/2018-GAB1, referente ao encaminhamento da NotÃ­cia de Fato nÂ° 1.33.007.000247/2018-05, que encaminha cÃ³pia do procedimento para ciÃªncia e adoÃ§Ã£o das providÃªncias quanto Ã  RegularizaÃ§Ã£o FundiÃ¡ria de imÃ³vel da extinta RFFSA.', 'undefined', '2019-06-04 23:05:13', '2019-06-04 23:05:13'),
(486, 1, 1, '1.33.000.002168/2003-12', 'MPF X Ilha do Campeche x SIGIC', 'MPF recomenda cancelamento de todas as inscriÃ§Ãµes de ocupaÃ§Ã£o sobre a APP em nome da AssociaÃ§Ã£o Couto de Magalhaes ou qualquer outra pessoa ou associaÃ§Ã£o. Requisita identificaÃ§Ã£o das Ã¡reas APP e medidas para os cancelamentos, bem como recuperaÃ§Ã£o ambiental.', 'undefined', '2019-06-05 15:26:05', '2019-06-05 15:26:05'),
(487, 1, 1, '1.33.000.000024/2007-47', 'Regularidade Cadastral - Loteamento Residencial GÃªnova - BiguaÃ§u/SC', 'Regularidade do Loteamento Residencial GÃªnova pela empresa Pantanal ConstruÃ§Ãµes e Incorporadora Ltda., BiguaÃ§u/SC', 'undefined', '2019-06-05 15:31:19', '2019-06-05 15:31:19'),
(488, 2, 4, '5009727-52.2015.4.04.7200', 'Regularidade Cadastral - Barra da Lagoa - FlorianÃ³polis/SC', 'informaÃ§Ãµes atualizadas quanto as providÃªncias adotadas nas inscriÃ§Ãµes de ocupaÃ§Ã£o na Ã¡rea do empreendimento localizado na Barra da Lagoa, cadastrados sob os RIP\'s 81050000383-00, 81050004883-30 e 81050005597-00', 'undefined', '2019-06-05 15:37:00', '2019-06-05 15:37:00'),
(489, 1, 1, '1.33.000.001112/2018-19', 'Regularidade do contrato de cessÃ£o de uso do Processo nÂ° 04972.003671/2016-61', 'Versa sobre obras de revitalizaÃ§Ã£o da orla da praia de Ganchos do Meio e da pretensa vedaÃ§Ã£o de uso de trapiche', 'undefined', '2019-06-05 15:45:44', '2019-06-05 15:45:44'),
(491, 1, 1, '1.33.003.000348/2011-31', 'MPF x Rio AraranguÃ¡ x Termo de Ajustamento de Conduta', 'Investiga existÃªncia de balsas pesqueiras instaladas no Rio AraranguÃ¡.', 'undefined', '2019-06-05 16:44:31', '2019-06-05 16:44:31'),
(492, 1, 1, '1.33.000.001803/2014-99', 'Regularidade de Cadastros - SÃ£o JosÃ©/SC', 'Manifestar sobre quais as providÃªncias adotadas para regularizar a Ã¡rea invadida em SÃ£o JosÃ©/SC', 'undefined', '2019-06-05 16:55:39', '2019-06-05 16:55:39'),
(494, 1, 1, '1.33.000.001198/2013-75', 'Regularidade Cadastral -  Caieira da Barra do Sul - FlorianÃ³polis/SC', 'Irregularidade na construÃ§Ã£o de edificaÃ§Ã£o situada na Rodovia Baldicero Filomeno, nÂ° 19.794, Bairro Caieira da Barra do Sul, em FlorianÃ³polis/SC', 'undefined', '2019-06-05 17:07:47', '2019-06-05 17:07:47'),
(495, 3, 4, '5000124-04.2010.4.04.7208', 'LaudÃªmio. RIP 8039-0104405-41', 'undefined', 'undefined', '2019-06-05 19:47:56', '2019-06-05 19:47:56'),
(496, 1, 1, '1.33 .000 .003576/2000-31', 'Regularidade Cadastral - Praia do Campeche - FlorianÃ³polis', 'Instaurado para verificar a regularidade de ocupaÃ§Ãµes em terrenos da UniÃ£o na praia do Campeche, em FlorianÃ³polis/SC', 'undefined', '2019-06-05 19:54:43', '2019-06-05 19:54:43'),
(497, 2, 4, '5003826-84.2012.4.04.7208', 'INDENIZAÃ‡ÃƒO POR DANO AMBIENTAL', 'INDENIZAÃ‡ÃƒO POR DANO AMBIENTAL', '929008805512', '2019-06-05 19:58:51', '2019-06-05 19:58:51'),
(498, 5, 1, '040.91.000014-0', 'AÃ§Ã£o Popular,  JoÃ£o Batista de Bassi Filho, ConvÃ©nio, MunicÃ­pio de Laguna, Ravena Cassino Hote, CessÃ£o', 'Informar da AÃ§Ã£o Popular, instaurada por JoÃ£o Batista de Bassi Filho e outros em face do MunicÃ­pio de Laguna e outros, autuada sob o n. 040.91.000014-0 (0000014-36.1991.8.24.0040), que foi julgada procedente em 31/3/1999, para decretar a nulidade do Decreto Legislativo n. 04/89 e do ConvÃªnio firmado entre MunicÃ­pio de Laguna e Ravena Cassino Hotel Ltda, e todos os atos deles decorrentes, especialmente o registro do novo loteamento, voltando ao patrimÃ´nio municipal as Ã¡reas objetos da CessÃ£o sob o Regime de aforamento conforme matrÃ­cula n. 13.204.\r\n.', 'undefined', '2019-06-05 20:58:17', '2019-06-05 20:58:17'),
(499, 1, 1, '1.33.000.001362/2015-14', 'ConstruÃ§Ã£o irregular - RibeirÃ£o da Ilha - FlorianÃ³polis/SC', 'DemoliÃ§Ã£o de muro - construÃ§Ã£o irregular - RibeirÃ£o da Ilha - FlorianÃ³polis/SC', 'undefined', '2019-06-05 21:03:32', '2019-06-05 21:03:32'),
(500, 1, 1, '1.33.007.000128/2017-63', 'INSTALAÃ‡ÃƒO DE DOIS CONTÃŠINERES EM ÃREA DE MARINHA. RICARDO JUCHEN SEFTON. IBIRAQUERA', 'RecomendaÃ§Ã£o 8/2017 para que promova imediatamente a instauraÃ§Ã£o do processoadministrativo cabÃ­vel para o cancelamento do RIP n. 81430000417-70 e remoÃ§Ã£o dos conteineres, em nome de Ricardo Juchen Sefton, para a localidade da Praia do Luz, em Imbituba, tendo em vista a impossibilidade legal de permanÃªncia dessa inscriÃ§Ã£o', 'undefined', '2019-06-05 21:10:50', '2019-06-05 21:10:50'),
(501, 1, 1, '1.33.000.002740/2011-45', 'Contrato de cessÃ£o, CessÃ£o, Ã¡rea ocupada catadores, FLORAM', 'Soilcita informaÃ§Ãµes sobre a aprovaÃ§Ã£o e conclusÃ£o do contrato de cessÃ£o da Ã¡rea ocupada pelos cataelores, onde estarÃ£o dispostas as condicionantes indicadas pela FLORAM (Parecer TÃ©cnico nÂ° 424/2018-DlLlC).', 'undefined', '2019-06-05 21:17:21', '2019-06-05 21:17:21'),
(505, 1, 1, '1.33.005.000943/2016-61', 'Irregularidades na utilizaÃ§Ã£o do espaÃ§o das praias - SÃ£o Francisco do Sul/SC', 'Irregularidades na utilizaÃ§Ã£o do espaÃ§o das praias - SÃ£o Francisco do Sul/SC', 'undefined', '2019-06-05 21:43:58', '2019-06-05 21:43:58'),
(506, 3, 4, '5004253-37.2019.4.04.7208', 'RestituiÃ§Ã£o. CondomÃ­nio Edifico Itambei', 'CondenaÃ§Ã£o da UniÃ£o Ã  restituiÃ§Ã£o da quantia de R$ 173.237,72 (cento e setenta e trÃªs mil, duzentos e trinta e sete reais e setenta e dois centavos', '317408741719', '2019-06-05 21:49:26', '2019-06-05 21:49:26'),
(507, 1, 1, '1.33.000.002141/2017-17', 'Regularidade cadastral - Canasvieiras - FlorianÃ³polis/SC', 'invasÃ£o e ocupaÃ§Ã£o de terreno de marinha e faixa de praia pelo restaurante ChapÃ©u de Palha, no final da Rua do\nKalifa, em Canasvieiras, FlorianÃ³polis/SC', 'undefined', '2019-06-05 22:12:16', '2019-06-05 22:12:16'),
(508, 1, 1, '1.33.000.001091/2006-06', 'OcupaÃ§Ã£o faixa de praia, cessÃ£o de uso, decks, Santo AntÃ´nio de Lisboa, Sambaqui', 'RegulamentaÃ§Ã£o de obras para a implantaÃ§Ã£o de decks nos bairros Santo AntÃ´nio de Lisboa e Sambaqui. Existe aÃ§Ã£o civil pÃºblica relacionada - 5026745-81.2018.404.7200', 'undefined', '2019-06-05 22:33:26', '2019-06-05 22:33:26'),
(509, 1, 1, '1.33.000.000585/2011-22', 'Beira Mar SÃ£o JosÃ©, Trecho Barreiros', 'InquÃ©rito Civil que fiscaliza o licenciamento ambiental das obras da Beira Mar de SÃ£o JosÃ©, Trecho Barreiros.', 'undefined', '2019-06-05 22:43:13', '2019-06-05 22:43:13'),
(510, 1, 1, '1.33.005.000555/2013-38', 'MPF x Vila da Gloria - SÃ£o Francisco do Sul', 'MPF questiona SPU quanto medidas adotadas apÃ³s contrataÃ§Ã£o de imÃ³vel inserido em terras de marinha sem registro de inscriÃ§Ã£o de ocupaÃ§Ã£o, em Vila da Gloria - SÃ£o Francisco do Sul.', 'undefined', '2019-06-05 22:44:33', '2019-06-05 22:44:33'),
(511, 1, 1, '1.33.000.002151/2015-91', 'PARQUE URBANO, MARINA DA BEIRA-MAR, Avenida Beira-Mar Norte', 'InquÃ©rito instaurado para acompanhar o projeto de implantaÃ§Ã£o do empreendimento denominado PARQUE URBANO DA BEIRA MAR, na Avenida Beira-Mar Norte, Centro, em FlorianÃ³polis/SC.', 'undefined', '2019-06-05 22:54:10', '2019-06-05 22:54:10'),
(513, 1, 1, '1.33.000.001036/2013-37', 'DoaÃ§Ã£o de ImÃ³veis, Barragens de conteÃ§Ã£o de Ã¡guas, TaiÃ³, Ituporanga', 'Solicito seja informado se houve finalizaÃ§Ã£o dos processos nÂ° 03120.000157/96-55 e 04972.001632/2014-68, que vem tratando das doaÃ§Ãµes dos imÃ³veis correspondentes Ã s instalaÃ§Ãµes dos complexos das barragens de contenÃ§Ã£o de Ã¡guas nos municÃ­pios de TaiÃ³ e Ituporanga.', 'undefined', '2019-06-05 23:12:42', '2019-06-05 23:12:42'),
(514, 2, 1, '5006921-03.2013.4.04.7204/SC', 'Fase de execuÃ§Ã£o da sentenÃ§a', 'Informar sobre o atual estÃ¡gio de regularizaÃ§Ã£o fundiÃ¡ria - BalneÃ¡rio RincÃ£o/SC', 'undefined', '2019-06-06 15:14:42', '2019-06-06 15:14:42'),
(515, 3, 4, '5002365-67.2018.4.04.7208', 'Inexigibilidade da cobranÃ§a da taxa de ocupaÃ§Ã£o. RIP 8265.0001247-97 E 5537.0000041-36', 'Inexigibilidade da cobranÃ§a da taxa de ocupaÃ§Ã£o efetuada pela Requerida sobre a totalidade da Ã¡rea de 495mÂ² de cada um dos terrenos de marinha que o Requerente Ã© o titular da cessÃ£o e transferÃªncia de ocupaÃ§Ã£o, tendo em vista que impossibilitada a ocupaÃ§Ã£o de sua Ã¡rea.', 'undefined', '2019-06-06 16:11:31', '2019-06-06 16:11:31'),
(517, 1, 1, '1.33.007.000102/2016-34', 'ConstruÃ§Ã£o.  Estreito, municÃ­pio de Laguna/SC', 'undefined', 'undefined', '2019-06-06 19:42:29', '2019-06-06 19:42:29'),
(518, 1, 1, '1.33.000.000746/2013-40', 'Regularidade Cadastral - Costa da Lagoa - FlorianÃ³polis/SC', 'execuÃ§Ã£o da decisÃ£o nos autos da ACP n. 2000.72.00.004772-2, com obrigaÃ§Ãµes assumidas para combater a desordem urbanÃ­stica e a poluiÃ§Ã£o na\nBacia HidrogrÃ¡fica da Lagoa da ConceiÃ§Ã£o, na localidade da Costa da Lagoa, em frente Ã  Igreja CatÃ³lica', 'undefined', '2019-06-06 20:44:46', '2019-06-06 20:44:46'),
(519, 1, 1, '1.33.005.000368/2016-05', 'Apurar regularidade das ocupaÃ§Ãµes - Ilha das Claras - BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-06-07 00:24:38', '2019-06-07 00:24:38'),
(520, 2, 4, '5027305-62.2014.404.7200', 'ExecuÃ§Ã£o de tÃ­tulo extrajudicial 5027305-62.2014.404.7200', 'Requisitar a adoÃ§Ã£o das providÃªncias administrativas para o cancelamento do RIP nÂ° 8105.00309.000-1 inscrito em favor de Arlindo Isaac da Costa, para o imÃ³vel localizado na ServidÃ£o Ivo D\'Aquino nÂ°133, Ponta da Areia, margens da Lagoa da ConceiÃ§Ã£o (Marina Ponta da Areia Bar e Restaurante) - FlorianÃ³polis/SC', 'undefined', '2019-06-07 15:14:47', '2019-06-07 15:14:47'),
(521, 1, 1, '1.33.008.000118/2014-75', 'Identificar interferÃªncia com Ã¡rea da UniÃ£o.', 'Obras de dragagem realizadas no Rio GravatÃ¡ pela Prefeitura de Navegantes/SC', 'undefined', '2019-06-07 15:29:57', '2019-06-07 15:29:57'),
(522, 2, 4, '5004772-51.2010.4.04.7200', 'Cancelamento de Cadastro - Lagoa da ConceiÃ§Ã£o - FlorianÃ³polis/SC', 'Cancelamento de Cadastro - RIP 8105.0003562-64 - Lagoa da ConceiÃ§Ã£o - FlorianÃ³polis/SC', 'undefined', '2019-06-07 15:42:37', '2019-06-07 15:42:37'),
(523, 1, 1, '1.33.005.000314/2013-99', 'Apurar regularidade ocupaÃ§Ã£o da Ilha Redonda - BaÃ­a da Babitonga - SÃ£o Francisco', 'undefined', 'undefined', '2019-06-07 16:00:22', '2019-06-07 16:00:22'),
(524, 2, 4, '5000077-69.2011.4.04.7216', 'MPF x desapossamento ou cadastramento x Loteamento Praia da Galheta, no BalneÃ¡rio Galheta, em Laguna/SC', 'ACP atinente ao desapossamento e/ou cadastramento de todos o  imÃ³veis localizados em terrenos de marinha abrangidos pelo Loteamento da Galheta, no BalneÃ¡rio Galheta, em Laguna/SC.', '723199534411', '2019-06-07 16:01:52', '2019-06-07 16:01:52'),
(525, 1, 4, '1.33.000.001921/2017-40', 'Cancelamento de Cadastro - Praia dos Ingleses - ACP n. 5014640-14.2014.4.04.7200 - FlorianÃ³polis/SC', 'informaÃ§Ãµes sobre inscriÃ§Ã£o em nome de particular; e, em caso positivo, recomendo providÃªncias para cancelamento', 'undefined', '2019-06-07 16:03:33', '2019-06-07 16:03:33'),
(527, 5, 1, '1.33.007.000705/2002-31', 'MPF x CondomÃ­nio cabo de Santa Marta - Praia do Cardoso, Laguna/SC', 'MPF TubarÃ£o solicita vistoria no empreendimento CondomÃ­nio cabo de Santa Marta - Praia do Cardoso, Laguna/SC para constatar ocupaÃ§Ã£o de Ã¡rea de marinha, informar a existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o ou posse', 'undefined', '2019-06-07 17:01:45', '2019-06-07 17:01:45'),
(528, 3, 4, '5006921-03.2013.4.04.7204', 'RegularizaÃ§Ã£o fundiÃ¡ria- BalneÃ¡rio RincÃ£o', 'undefined', '303648244113', '2019-06-07 19:25:45', '2019-06-07 19:25:45'),
(530, 3, 4, '5001737-43.2016.4.04.7210', 'cancelamento das averbaÃ§Ãµes/registros/cessÃµes/doaÃ§Ãµes junto ao Registro de ImÃ³veis de DionÃ­sio Cerqueira/SC', 'declaraÃ§Ã£o de nulidade de qualquer ato administrativo tendente ao cancelamento das averbaÃ§Ãµes/registros/cessÃµes/doaÃ§Ãµes junto ao Registro de ImÃ³veis de DionÃ­sio Cerqueira/SC.', '673644192616', '2019-06-07 20:00:16', '2019-06-07 20:00:16'),
(531, 3, 3, '5007396-92.2018.4.04.7200', 'DESAPROPRIAÃ‡ÃƒO', 'RIP nÂº 81050002369-51 (aforamento) e nÂº 81050000607-30 (ocupaÃ§Ã£o)', 'undefined', '2019-06-07 20:01:04', '2019-06-07 20:01:04'),
(532, 2, 4, '5000130-85.2017.4.04.7201', 'Dano Ambiental.Praia da Enseada. SÃ£o Francisco do Sul', 'promoverem a demoliÃ§Ã£o, com a consequente retirada dos entulhos decorrentes, da construÃ§Ã£o identificada como â€œcasa bege de madeiraâ€, edificada sobre as areias da praia da Enseada (bem pertencente Ã  UniÃ£o e de uso comum do povo) e situada integralmente em Ã¡rea de preservaÃ§Ã£o permanente (restinga), na Avenida AtlÃ¢ntica, nÂº 1.247, imÃ³vel matriculado no 1Âº OfÃ­cio de Registro de ImÃ³veis de SÃ£o Francisco do Sul sob o nÂº 74711, na Praia da Enseada, no MunicÃ­pio de SÃ£o Francisco do Sul/SC, bem como a compensaÃ§Ã£o pecuniÃ¡ria pelos danos causados ao meio ambiente e Ã  coletividade, inerentes ao uso ilegal da Ã¡rea.', '268481988117', '2019-06-07 20:09:37', '2019-06-07 20:09:37'),
(534, 1, 1, '1.33.001.000191/2017-50', 'Regularidade Cadastral - ItajaÃ­-AÃ§u - Blumenau/SC', 'Informar se o imÃ³vel em questÃ£o encontra-se em Ã¡rea pertencente Ã  UniÃ£o (terreno de marinha) ou se possui alguma influÃªncia com terrenos de marinha', 'undefined', '2019-06-07 20:51:41', '2019-06-07 20:51:41'),
(535, 1, 1, '1.33.005.000370/2016-76', 'Verificar regularidade de ocupaÃ§Ã£o da Ilha da Queimada - BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-06-07 21:57:17', '2019-06-07 21:57:17'),
(536, 1, 1, '1.33.005.000366/2016-16', 'Verificar regularidade das ocupaÃ§Ãµes na Ilha das Flores (ou Ilha do Chico Pedro) - BaÃ­a da Babitonga - SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-06-07 22:11:16', '2019-06-07 22:11:16'),
(537, 1, 1, '1.33.008.000492/2015-51', 'TAUS - Comunidade Tradicional de Pescadores da Vila do AraÃ§Ã¡. Porto Belo/SC', 'Requisita informaÃ§Ãµes sobre qual o posicionamento da SPU em relaÃ§Ã£o Ã s solicitaÃ§Ãµes encaminhadas pelo MinistÃ©rio PÃºblico Federal, por meio do OfÃ­cio nÂ° 497/2015 - RBM (cÃ³pia em anexo), de 10 de setembro de 2015, referentes Ã  Comunidade Tradicional de Pescadores da Vila do AraÃ§Ã¡, Porto Belo/SC.', 'undefined', '2019-06-10 15:10:40', '2019-06-10 15:10:40'),
(538, 1, 1, '1.33.000.002049/2012-42', 'TAUS - Rancho de Pescadores na Prainha - FlorianÃ³polis/SC', 'RegularizaÃ§Ã£o da situaÃ§Ã£o de Rancho de Pescadores na Prainha - FlorianÃ³polis/SC', 'undefined', '2019-06-10 15:24:20', '2019-06-10 15:24:20'),
(540, 1, 1, '1.33008.000384/2008-50', 'Cancelamento de cadastro', 'Cancelamento e destinaÃ§Ã£o - Ilha JoÃ£o Cunha - Porto Belo/SC', 'undefined', '2019-06-10 16:10:28', '2019-06-10 16:10:28'),
(541, 1, 4, '1.33.000.003419/2012-69', 'Regularidade Cadastral dos imÃ³veis em APPs de BiguaÃ§u/SC.', 'Cumprimento da recomendaÃ§Ã£o n. 86/2014.  APPs de BiguaÃ§u/SC', 'undefined', '2019-06-10 16:27:33', '2019-06-10 16:27:33'),
(542, 1, 1, '1.33.000.001567/2015-91', 'Regularidade cadastral dos imÃ³veis localizados na orla de Coqueiros - FlorianÃ³polis/SC', NULL, 'undefined', '2019-06-10 16:45:17', '2019-06-10 16:45:17'),
(543, 2, 4, '5010198-97.2017.4.04.7200', 'Dano Ambiental. Rodovia Francisco Thomaz dos Santos (SC 406), 6413, FlorianÃ³polis', 'aÃ§Ã£o civil pÃºblica que visa a reparaÃ§Ã£o de danos ambientais causados por construÃ§Ã£o e manutenÃ§Ã£o de edificaÃ§Ãµes sobre bens da UniÃ£o (Terras e Acrescidos de Marinha) e Ãrea de PreservaÃ§Ã£o Permanente â€“ APP, em um terreno de cerca de 3.039m2, situado na Rodovia Francisco Thomaz dos Santos (SC 406), 6413, e reconstituir o ecossistema degradado. Visa, ainda, a responsabilizaÃ§Ã£o solidÃ¡ria da UniÃ£o, FATMA, MunicÃ­pio de FlorianÃ³polis e FLORAM.', 'undefined', '2019-06-10 17:20:26', '2019-06-10 17:20:26'),
(544, 1, 1, '1.33.008.000213/2017-11', 'Rua JacarandÃ¡, n. 35, Taquaras, BalneÃ¡rio CamboriÃº/SC', NULL, 'undefined', '2019-06-10 19:26:32', '2019-06-10 19:26:32'),
(545, 9, 4, '2008.72.00.007032-9', 'ReavaliaÃ§Ã£o do valor do ImÃ³vel. RIP 5537.0000132-08', 'undefined', 'undefined', '2019-06-10 20:06:47', '2019-06-10 20:06:47'),
(546, 6, 1, '407/2018-4', 'FiscalizaÃ§Ã£o de Ã¡rea de domÃ­nio da UniÃ£o, FiscalizaÃ§Ã£o de Ã¡rea de domÃ­nio da UniÃ£o', 'undefined', 'undefined', '2019-06-10 20:43:42', '2019-06-10 20:43:42'),
(547, 1, 1, '1.33.000.007472/2002-67', 'Regularidade Cadastral - PÃ¢ntano do Sul em FlorianÃ³polis/SC', 'InformaÃ§Ãµes atualizadas sobre as providÃªncias que a SPU/SC adotou para as edificaÃ§Ãµes feitas em APPs e em bens da UniÃ£o na localidade do PÃ¢ntano do Sul em FlorianÃ³polis/SC', 'undefined', '2019-06-10 21:07:33', '2019-06-10 21:07:33'),
(548, 1, 1, '1.33.008.000057/2015-27', 'Uso indevido de faixa de areia - Praia de ArmaÃ§Ã£o - Penha/SC', 'noticia a existÃªncia de um trailer, que estaria parado na faixa de areia, na Praia de ArmaÃ§Ã£o, em possÃ­vel ocupaÃ§Ã£o indevida, para que adote eventual medida considerada adequada Ã  defesa do patrimÃ´nio da UniÃ£o.', 'undefined', '2019-06-10 21:31:40', '2019-06-10 21:31:40'),
(549, 3, 3, '5017722-41.2014.4.04.7204', 'ReintegraÃ§Ã£o-  NP  6200239  (antiga  estaÃ§Ã£o  ferroviÃ¡ria, localizado Ã  margem da Rodovia SC 438, no MunicÃ­pio de Lauro Muller/SC)', 'undefined', '433610395014', '2019-06-10 21:38:47', '2019-06-10 21:38:47'),
(551, 3, 4, '5021287-88.2015.4.04.7200', 'DeclaraÃ§Ã£o de isenÃ§Ã£o da taxa de ocupaÃ§Ã£o referente ao RIP 8111000051085', 'AÃ§Ã£o sob o procedimento comum visando Ã  anulaÃ§Ã£o da cobranÃ§a do valor de R$ 21.569,41 e Ã  declaraÃ§Ã£o de isenÃ§Ã£o da taxa de ocupaÃ§Ã£o referente ao RIP 8111000051085. SentenÃ§a de procedÃªncia confirmada pelo Tribunal Regional Federal da 4Âª RegiÃ£o. TrÃ¢nsito em julgado favorÃ¡vel ao auto', '414285711715', '2019-06-11 16:50:54', '2019-06-11 16:50:54'),
(552, 1, 1, '1.33.000.000954/2005-39', 'MPF x construÃ§Ã£o em Ã¡rea de marinha, Praia do Antenor, Ilha de Anhatomirim, GOvernador Celso Ramos-SC', 'Considerando a informaÃ§Ã£o recebida de construÃ§Ã£o em Ã¡rea de marinha, especificamente na Praia do Antenor, na Ilha de Anhatomirim, municÃ­pio de Governador Celso Ramos, neste Estado, solicito a Vossa Senhoria informar acerca da: 1) existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o de terrenos de marinha relativa ao local onde situado o Restaurante SPADART, edificado no entorno das coordenadas UTM 22 J 739783 6963991 na ponta oeste da localidade da praia do Antenor; 2) existÃªncia de inscriÃ§Ã£o de ocupaÃ§Ã£o de terrenos de marinha em nome de SÃ©rgio de Souza ou Antenor JÃºlio de Souza na localidade indicada.', 'undefined', '2019-06-11 17:05:15', '2019-06-11 17:05:15'),
(553, 2, 4, '5015079-88.2015.4.04.7200', 'Dano Ambiental. ArmaÃ§Ã£o do PÃ¢ntano do Sul', 'Trata-se de aÃ§Ã£o civil pÃºblica ajuizada pelo MPF visando Ã  condenaÃ§Ã£o dos rÃ©us Ã  remoÃ§Ã£o de edificaÃ§Ãµes erigidas em Ã¡rea de marinha tambÃ©m caracterizada como Ã¡rea de preservaÃ§Ã£o permanente â€“ APP, localizada Ã s margens do Rio Sangradouro, na Praia da ArmaÃ§Ã£o.', '503530584415', '2019-06-11 17:23:49', '2019-06-11 17:23:49'),
(555, 2, 1, '5001159-75.2019.4.04.7210', 'Dano Ambiental. Rio Uruguai, Linha Mondaizinho, interior do MunicÃ­pio de MondaÃ­/SC', 'Desfazimento da edificaÃ§Ã£o na Ã¡rea de preservaÃ§Ã£o permanente marginal ao Rio Uruguai, na propriedade deste, localizada na Linha Mondaizinho, interior do MunicÃ­pio de MondaÃ­/SC, matriculada no CartÃ³rio de Registro de ImÃ³veis da Comarca de MondaÃ­, SC, sob n. 2.326, bem como a retirada de todos os equipamentos que alteram aquela Ã¡rea e impedem a sua regeneraÃ§Ã£o natura', '656354225719', '2019-06-11 19:30:17', '2019-06-11 19:30:17'),
(556, 3, 4, '5003246-15.2011.404.7200', 'UsucapiÃ£o. SC 401 s/nÂº, Monte Verde â€“ Saco Grande, FlorianÃ³polis/SC', 'undefined', 'undefined', '2019-06-11 19:42:18', '2019-06-11 19:42:18'),
(557, 3, 4, '0300599-37.2017.8.24.0029', 'RetificaÃ§Ã£o de Registro de ImÃ³vel. LAGOA DO IMARUÃ', 'undefined', 'undefined', '2019-06-11 20:07:27', '2019-06-11 20:07:27'),
(558, 6, 1, '0001911-24.2013.8.24.0139', 'MPSC x Rio da VovÃ³ - Porto Belo/SC', 'InquÃ©rito Policial referente a degradaÃ§Ã£o ambiental na margem do Rio da VovÃ³ - Porto Belo. MPSC solicita informaÃ§Ãµes sobre possÃ­vel caracterizaÃ§Ã£o de Ã¡rea de marinha, bem como informar sobre demarcaÃ§Ã£o da Ã¡rea.', 'undefined', '2019-06-11 20:26:23', '2019-06-11 20:26:23'),
(560, 2, 3, '5007249-71.2015.4.04.7200', 'Dano Ambiental. Loteamento Por de Sol,  Praia Brava, FlorianÃ³polis', 'undefined', '924181280215', '2019-06-11 20:35:15', '2019-06-11 20:35:15'),
(562, 1, 1, '1.33.008.000041.2016-03', 'MPF x bar Sabor do Mar, na praia da Sepultura, MunicÃ­pio de Bombinhas', 'referente Ã  InquÃ©rito Civil, requisita informar acerca da regularidade da ocupaÃ§Ã£o do imÃ³vel em que funciona o bar Sabor do Mar, na praia da Sepultura, MunicÃ­pio de Bombinhas.', 'undefined', '2019-06-11 21:32:17', '2019-06-11 21:32:17'),
(564, 1, 1, '1.33.008.000183/2015-81', 'MPF x Marinas Porto Belo Resort Hotel S/A', 'MPF solicita seja iniciado procedimento de cancelamento da inscriÃ§Ã£o de ocupaÃ§Ã£o referente ao RIP 8265.0000770-04 em nome de Marinas Porto Belo Resort Hotel S/A.', 'undefined', '2019-06-11 21:58:40', '2019-06-11 21:58:40'),
(566, 3, 3, '5000446-60.2015.4.04.7204', 'ReintegraÃ§Ã£o de Posse. RFFSA. lauro Muller', 'undefined', 'undefined', '2019-06-11 22:03:01', '2019-06-11 22:03:01'),
(567, 1, 1, '1.33.000.000820/2011-66', 'MPF x Projeto SESC-LER, Bairro da PraÃ§a, Tijucas/SC', 'MPF, Referente a InquÃ©rito Civil solicita informaÃ§Ãµes quanto a regularizaÃ§Ã£o do imÃ³vel do Projeto SESC-LER, Bairro da PraÃ§a, Tijucas/SC.', 'undefined', '2019-06-11 22:28:52', '2019-06-11 22:28:52'),
(568, 3, 4, '5017268-19.2018.4.04.7205', 'DesapropriaÃ§Ã£o. Rua RepÃºblica Argentina, 1590, Ponta Aguda, Blumenau/SC. RIP 8047 0000412-62', 'undefined', '787458274518', '2019-06-12 19:35:52', '2019-06-12 19:35:52'),
(569, 3, 3, '5001344-10.2014.4.04.7204', 'ReintegraÃ§Ã£o de Posse. RFFSA. rua Campos ElÃ­sios, 179, bairro Coloninha, Orleans/SC', 'undefined', 'undefined', '2019-06-12 20:12:42', '2019-06-12 20:12:42'),
(570, 1, 1, '1.33.000.002307201291', 'MPF x Ranchos de Pesca - Bairro Capoeiras/Furnas -  MunicÃ­pio de FlorianÃ³polis/SC', 'MPF solicita que informe quais as medidas serÃ£o adotadas face a nÃ£o apresentaÃ§Ã£o dos documentos requisitados aos detentores dos Ranchos de Pescadores nÂ° 04 (04972.001566/2016-98 - Luiz Carlos Costa), 06 (04972.001573/2016-90 - Ademir da ConceiÃ§Ã£o) e 09 (04972.001574/2016-34 - EdilmÃ¡rio Flor da Silva). Qual o procedimento adolado pela SPU nestes casos?', 'undefined', '2019-06-12 20:15:21', '2019-06-12 20:15:21'),
(571, 3, 4, '5007941-46.2015.4.04.7208', 'UsucapiÃ£o. DEIVID RODRIGUES. BalneÃ¡rio CamboriÃº', 'undefined', '711231806015', '2019-06-12 20:56:06', '2019-06-12 20:56:06'),
(572, 3, 4, '5009501-52.2017.4.04.7208', 'IndenizaÃ§Ã£o por danos morais- IsenÃ§Ã£o- RIP 80390001952-85', 'undefined', '905812313517', '2019-06-13 16:47:24', '2019-06-13 16:47:24'),
(573, 3, 4, '5004720-55.2015.4.04.7208', 'indenizaÃ§Ã£o por apossamento administrativo (desapropriaÃ§Ã£o indireta). Itapema', 'undefined', '805159971415', '2019-06-13 21:11:54', '2019-06-13 21:11:54'),
(574, 3, 4, '003182047.2008.8.24.0023', 'UsucapiÃ£o', 'undefined', 'undefined', '2019-06-13 21:11:58', '2019-06-13 21:11:58'),
(575, 2, 4, '5018572-68.2018.4.04.7200', 'Dano Ambiental - APP - ZONA COSTEIRA DA ARMAÃ‡ÃƒO E DA ARMAÃ‡ÃƒO DO PÃ‚NTANO DO SUL', 'DelimitaÃ§Ã£o e a caracterizaÃ§Ã£o jurÃ­dica e tÃ©cnica (patrimonial, ambiental e cultural) de todas as intervenÃ§Ãµes ilegais (sobretudo obras de construÃ§Ã£o, reforma e manutenÃ§Ã£o de edificaÃ§Ãµes ou acessÃµes) efetuadas sobre BENS DA UNIÃƒO (por exemplo, sÃ­tios arqueolÃ³gicos, TERRENOS e ACRESCIDOS DE MARINHA), APPs â€“ ÃREAS DE PRESERVAÃ‡ÃƒO PERMANENTE e bens de uso comum do povo, na regiÃ£o que especificou: â€œregiÃ£o geogrÃ¡fica situada ao longo da ZONA COSTEIRA DA ARMAÃ‡ÃƒO E DA ARMAÃ‡ÃƒO DO PÃ‚NTANO DO SUL - FlorianÃ³polis/SC', 'undefined', '2019-06-14 17:13:38', '2019-06-14 17:13:38'),
(576, 3, 4, '5001579-62.2019.4.04.7216', 'Dano Ambiental.  Lagoa de Santo AntÃ´nio dos Anjos, Laguna/SC', 'undefined', '339926806719', '2019-06-17 16:26:08', '2019-06-17 16:26:08'),
(577, 2, 4, '5027866-47.2018.4.04.7200', 'Quadras de beach tennis na orla da Lagoa da ConceiÃ§Ã£o.', 'undefined', 'undefined', '2019-06-17 16:58:43', '2019-06-17 16:58:43'),
(578, 2, 4, '5013528-53.2018.4.04.7205', 'IndenizaÃ§Ã£o a Comunidade IndÃ­gena da Tribo LÃ£-KlÃ£no. Barragem Norte- Comunidade IndÃ­gena da Tribo LÃ£-KlÃ£no', 'o cumprimento da sentenÃ§a em AÃ‡ÃƒO CIVIL PÃšBLICA (autos fÃ­sicos 2003.72.05.006252-5/SC), proposta pelo MINISTÃ‰RIO PÃšBLICO FEDERAL, na data de 14/11/2003, representando a Comunidade IndÃ­gena da Tribo LÃ£-KlÃ£no, situada em JosÃ© Boiteux/SC, em face da UNIÃƒO, ESTADO DE SANTA CATARINA e da FUNAI, objetivando, indenizaÃ§Ã£o por danos coletivos, culturais, materiais e morais causados Ã s etnias indÃ­genas Xokleng, Guarani e Kaingang que habitavam territÃ³rio onde foram realizadas obras pÃºblicas.', '861566562218', '2019-06-17 17:22:14', '2019-06-17 17:22:14'),
(579, 9, 4, '5028068-08.2019.4.04.7000', 'Nulidade da CobranÃ§a. RIP  8319.01000141-56', 'undefined', 'undefined', '2019-06-17 20:00:15', '2019-06-17 20:00:15'),
(580, 9, 4, '5011885-38.2019.4.04.7201', 'declaraÃ§Ã£o de inexistÃªncia de dÃ©bito e nulidade de processo demarcatÃ³rio. RIP 8319 0100147-41', 'a declaraÃ§Ã£o de inexistÃªncia de dÃ©bito e nulidade de processo demarcatÃ³rio e lanÃ§amento de taxas de ocupaÃ§Ã£o, laudÃªmio e multa por transferÃªncia, relativas ao imÃ³vel sito Ã  Av. Tripoli, s/n, Loteamento Jardim AtlÃ¢ntico, Q-3-III, Lote-10, Bairro Ubatuba, em SÃ£o Francisco do Sul/SC, CEP 89240-000, cujo RIP Ã© 8319 0100147-41, devidamente matriculado junto ao 1Âº OfÃ­cio de Registro de ImÃ³veis de SÃ£o Francisco do Sul sob o n.Â° 13.870.', 'undefined', '2019-06-17 20:19:05', '2019-06-17 20:19:05'),
(581, 2, 1, '200472080051730', 'MPF x Laerte Kohler - Bairro AraÃ§Ã¡, Porto Belo/SC', 'ACP para retirada da obra construida, recuperaÃ§Ã£o de Ã¡rea degradada, e indenizaÃ§Ã£o por danos ao meio ambiente em APP, em Ã¡rea da uniÃ£o. Bairro AraÃ§Ã¡, Porto Belo/SC', 'undefined', '2019-06-17 20:54:18', '2019-06-17 20:54:18'),
(583, 3, 4, '0302313-29.2017.8.24.0030', 'UsucapiÃ£o Estadual. Rua Limoeiro, Bairro Ibiraquera, Imbituba/SC', 'undefined', 'undefined', '2019-06-17 21:54:05', '2019-06-17 21:54:05'),
(584, 1, 1, '1.33.0005.000367/2010-67', 'MPF x Rio do BraÃ§o-SC', 'MPF solicita informaÃ§Ã£o sobre Rio do BraÃ§o, localizado na regiÃ£o nordeste de SC', 'undefined', '2019-06-17 22:08:10', '2019-06-17 22:08:10'),
(585, 1, 1, '1.33.005.000358/2011-57', 'MPF x margem da Lagoa de Barra Velha- MunicÃ­pio de ItapoÃ¡/SC', 'MPF solicita identificaÃ§Ã£o dos proprietÃ¡rios dos imÃ³veis localizados em Ã¡rea de praia no MunicÃ­pio de ItapoÃ¡, referente Ã s ocupaÃ§Ãµes irregulares Ã  margem da lagoa de Barra Velha.', 'undefined', '2019-06-17 22:21:56', '2019-06-17 22:21:56'),
(586, 1, 1, '1.33.007.000280/2016-65', 'SUPRESSÃƒO DE VEGETAÃ‡ÃƒO. BEIRA DA LAGOA DE SANTA MARTA PEQUENA. ATERRO. CONSTRUÃ‡ÃƒO IRREGULAR. POR ROSANE TASCA', 'SolicitaÃ§Ã£o do MPF sobre informar se hÃ¡ (ou houve) processo de regularizaÃ§Ã£o de um aterro e construÃ§Ã£o Ã  beira da Lagoa de Santa Marta Pequena, em Laguna, em nome de Rosane Tasca, CPF n. 437.769.579-72', 'undefined', '2019-06-17 23:04:50', '2019-06-17 23:04:50'),
(587, 1, 1, '1.33.007.000048/2017-16', 'CONSTRUÃ‡ÃƒO EM APP. INSTALAÃ‡ÃƒO DE CAMPINO E INVASÃƒO DE TERRENOS DE MARINHA. CÃ‰LIO DAMIANI. PONTA DA BARRA, LAGUNA/SC', 'Procedimento que instrui e solicita manifestaÃ§Ã£o sobre a e a regularidade de todas as ocupaÃ§Ãµes (nÃ£o somente ao restaurante) por CÃ©lio Damiani, na localidade da Ponta da Barra, em Laguna.', 'undefined', '2019-06-17 23:18:45', '2019-06-17 23:18:45'),
(588, 3, 4, '5022392-95.2018.4.04.7200', 'UsucapiÃ£o. Canasvieiras. FlorianÃ³polis', 'undefined', '176692215218', '2019-06-18 16:13:23', '2019-06-18 16:13:23'),
(589, 2, 1, '5013232-12.2019.4.04.7200', 'Dano Ambiental.EstaÃ§Ã£o EcolÃ³gica CarijÃ³s. FlorianÃ³polis', 'visa Ã  condenaÃ§Ã£o do RÃ©us em obrigaÃ§Ã£o de fazer, consistente na remoÃ§Ã£o de construÃ§Ã£o e na recuperaÃ§Ã£o da Ã¡rea degradada por supressÃ£o de mata nativa (mata atlÃ¢ntica), em terreno de marinha, com impacto indireto em unidade de conservaÃ§Ã£o federal de proteÃ§Ã£o integral (ESEC) EstaÃ§Ã£o EcolÃ³gica CarijÃ³s), nesta Capital.', 'undefined', '2019-06-18 16:43:36', '2019-06-18 16:43:36'),
(590, 2, 3, '5017073-54.2015.4.04.7200', 'ProteÃ§Ã£o ambiental, recuperaÃ§Ã£o da Ã¡rea degradada e a promoÃ§Ã£o do livre acesso pÃºblico Ã s margens da Lagoa da ConceiÃ§Ã£o/ FlorianÃ³polis', 'undefined', 'undefined', '2019-06-18 17:36:27', '2019-06-18 17:36:27'),
(591, 1, 1, '1.33.007.000315/2014-02', 'Dano Ambiental. Lagoa Doce, Imbituba', 'undefined', 'undefined', '2019-06-18 19:47:32', '2019-06-18 19:47:32'),
(592, 2, 3, '5009907-68.2015.4.04.7200', 'Dano Ambiental. Costa da Lagoa, FlorianÃ³polis', 'visa a condenaÃ§Ã£o do rÃ©u particular a adotar medidas que faÃ§am cessar danos ecolÃ³gicos em Ã¡rea de preservaÃ§Ã£o permanente, bem da UniÃ£o Federal e de uso comum do povo, na Costa da Lagoa da ConceiÃ§Ã£o, nesta capital, a demolir obras realizadas sobre a aludida Ã¡rea e a restaurar o local ambientalmente agredido.', 'undefined', '2019-06-18 20:06:24', '2019-06-18 20:06:24'),
(593, 2, 4, '5003594-33.2011.4.04.7200', 'Dano Ambiental. Coqueiros, FlorianÃ³polis', 'undefined', '845737522311', '2019-06-18 20:43:57', '2019-06-18 20:43:57'),
(594, 1, 1, '1.33.001.000231/2015-00', 'Regularidade de imÃ³vel,  extinta RFFSA', 'O MinistÃ©rio PÃºblico Federal, com fundamento no arÃ­. 8Â°, inciso II, da Lei Complementar nÂ° 75/93, requisita a Vossa Senhoria que informe se o imÃ³vel objeto dos autos epigrafados estÃ¡ regularizado em face de UniÃ£o.', 'undefined', '2019-06-18 21:07:17', '2019-06-18 21:07:17'),
(595, 1, 1, '1.33.007.000251/2017-84', 'ReintegraÃ§Ã£o/ManutenÃ§Ã£o de Posse nÂ° 5003342- 62.2018.4.04.72 37', 'InquÃ©rito Civil instaurado para apurar suposta mÃ¡ utilizaÃ§Ã£o do ESTÃDIO DOMINGOS SILVEIRA GONZALES. TubarÃ£o. extinta RFFSA', 'undefined', '2019-06-18 21:19:14', '2019-06-18 21:19:14'),
(598, 1, 1, '1.33.008.000368201324', 'MPF x Paulo CÃ©sar Mendes Borges - Pousada GaÃºcha; Pousada Vila OceÃ¢nica Bombinhas/SC', 'Encaminhar ao MPF relatÃ³rio e demais documentos comprobatÃ³rios de vistoria in loco.', 'undefined', '2019-06-18 22:01:08', '2019-06-18 22:01:08'),
(599, 1, 1, '1.33.000.001039/2016-13', 'MPF x Ranchos de pesca nas margens do Rio AririÃº, em PalhoÃ§a/SC', 'O MinistÃ©rio PÃºblico Federal, visando instruir o expediente em epÃ­grafe, vem requisitar no prazo de 20 (vinte) dias informaÃ§Ãµes atualizadas sobre ranchos de pesca situados Ã s margens do Rio AririÃº, no final da Rua OtÃ¡vio Garcia, no MunicÃ­pio de PalhoÃ§a e, em especial, o penÃºltimo rancho de pesca que, supostamente, estÃ¡ sendo reformado em alvenaria com ampliaÃ§Ã£o mediante aterro em Ã¡rea de mangue, conforme documentos anexos.', 'undefined', '2019-06-18 22:52:55', '2019-06-18 22:52:55'),
(601, 3, 2, '500733547.2017.4.04.7208/SC', 'undefined', 'prorrogaÃ§Ã£o do prazo para a entrega dos tÃ­tulos aos beneficiÃ¡rios finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-06-19 15:00:33', '2019-06-19 15:00:33'),
(602, 3, 4, '5009369-45.2019.4.04.7201', 'AÃ§Ã£o de RetificaÃ§Ã£o de Registro de ImÃ³vel', 'SubsÃ­dios para defesa da UniÃ£o.', 'undefined', '2019-06-19 20:16:59', '2019-06-19 20:16:59'),
(603, 3, 4, '5001383-34.2010.4.04.7208', 'Invalidade da intimaÃ§Ã£o editalÃ­cia', 'invalidade da intimaÃ§Ã£o editalÃ­cia de interessado certo e com endereÃ§o conhecido, como no caso dos autos e, excluir o pagamento das taxas de ocupaÃ§Ã£o.', 'undefined', '2019-06-19 20:20:08', '2019-06-19 20:20:08'),
(604, 3, 4, '5002153-12.2019.4.04.7208', 'Reajuste da Taxa de OcupaÃ§Ã£o', 'undefined', 'undefined', '2019-06-19 20:33:43', '2019-06-19 20:34:27'),
(605, 3, 4, '5028276-76.2016.4.04.7200', 'UsucapiÃ£o. PalhoÃ§a/SC', 'undefined', 'undefined', '2019-06-19 21:02:44', '2019-06-19 21:02:44'),
(606, 3, 3, '5012335-78.2019.4.04.7201', 'SuscitaÃ§Ã£o de DÃºvida. cancelamento do aforamento do imÃ³vel averbado em nome da RELOJOARIA RUBI LTDA', 'undefined', 'undefined', '2019-06-19 21:46:36', '2019-06-19 21:46:36'),
(607, 2, 1, '5013642-70.2019.4.04.7200', 'Dano Ambiental. ua AcÃ¡cio Melo, 5, JurerÃª,, FlorianÃ³polis', 'undefined', 'undefined', '2019-06-19 22:20:01', '2019-06-19 22:20:01'),
(608, 3, 4, '2004.72.01.003959-4', 'Cancelamento de DemarcatÃ³ria - Joinville/SC', 'Cancelamento do RIP: 8179.0002766- 04', 'undefined', '2019-06-21 15:10:40', '2019-06-21 15:10:40'),
(609, 1, 4, '1.33.008.000332/2014-21', 'UtilizaÃ§Ã£o irregular', 'Apurar fatos noticiados referente a irregularidades na execuÃ§Ã£o de projetos de urbanizaÃ§Ã£o nas avenidas das praias do trapiche, vermelha e Grande, todas no MunicÃ­pio de Penha/SC.', 'undefined', '2019-06-21 15:53:50', '2019-06-21 15:53:50'),
(610, 4, 1, '1.33.000.001019/2019-95', 'Regularidade Cadastral', 'informaÃ§Ãµes sobre a regularidade da ocupaÃ§Ã£o do terreno de marinha situado na Rodovia SC 401, n. 5309, Distrito de Santo AntÃ´nio de Lisboa prÃ³ximo ao Trevo de CacupÃ© - FlorianÃ³polis/SC', 'undefined', '2019-06-21 16:42:13', '2019-06-21 16:42:13'),
(611, 3, 4, '5010190-93.2012.404.7201', 'Cancelamento de Cadastro', 'inexistÃªncia de relaÃ§Ã£o jurÃ­dica que obrigue o autor a pagar Ã  UniÃ£o laudÃªmio e taxa de ocupaÃ§Ã£o relacionados aos imÃ³veis cadastrados no PatrimÃ´nio da UniÃ£o, sob os RIP\'s de nÃºmeros 8041 0000325-07 e 8041 0000350-18 (objetos das matrÃ­culas 5.547 e 5.548 do Registro de ImÃ³veis da 2\" CircunscriÃ§Ã£o de SÃ£o Francisco do Sul).', 'undefined', '2019-06-21 16:54:01', '2019-06-21 16:54:01'),
(612, 3, 4, '5014680-88.2017.4.04.7200', 'UsucapiÃ£o. Estrada Manoel LeÃ´ncio de Souza Brito, na Vargem Pequena, em FlorianÃ³polis,', 'undefined', '920742867417', '2019-06-21 19:16:01', '2019-06-21 19:16:01'),
(613, 3, 4, '0004085-42.2013.8.24.0030', 'UsucapiÃ£o. Imbituba', 'undefined', 'undefined', '2019-06-21 19:41:50', '2019-06-21 19:42:33'),
(614, 2, 4, '5008067-28.2012.4.04.7200', 'RecomendaÃ§Ã£o', 'Recomenda que seja executada a sentenÃ§a da aÃ§Ã£o, especialmente em relaÃ§Ã£o ao cancelamento das inscriÃ§Ãµes de ocupaÃ§Ã£o localizadas na praia da ArmaÃ§Ã£o do PÃ¢ntano do Sul - FlorianÃ³polis/SC', 'undefined', '2019-06-21 20:09:02', '2019-06-21 20:09:02'),
(615, 1, 4, '1.33.005.000320/2015-16', 'Regularidade de Cadastro', 'Pede providÃªncias em relaÃ§Ã£o Ã  ocupaÃ§Ã£o irregular em imÃ³vel da UniÃ£o localizado na Rua Carlos Tost, n9 129, Centro, BalneÃ¡rio Barra do Sul/SC', 'undefined', '2019-06-21 20:13:22', '2019-06-21 20:13:22'),
(616, 1, 1, '1.33.005.000926/2016-24', 'Regularidade de Cadastro', 'VerificaÃ§Ã£o de regularidade cadastral - imÃ³vel em Joinville-SC', 'undefined', '2019-06-21 20:20:36', '2019-06-21 20:20:36'),
(617, 7, 4, '5004642-24.2011.404.7201', 'Nulidade do Processo DemarcatÃ³rio RIP 8179.0003545-08', 'undefined', 'undefined', '2019-06-21 20:27:50', '2019-06-21 20:27:50'),
(618, 1, 4, '1.33.000.002351/2006-52', 'undefined', 'Apurar possÃ­vel prÃ¡tica de ilÃ­citos ambientais na localidade do BalneÃ¡rio do PÃ¢ntano do Sul, em FlorianÃ³polis/SC', 'undefined', '2019-06-21 21:02:52', '2019-06-21 21:02:52'),
(619, 1, 1, '1.33.000.001385/2017-82', 'MPF x ConstruÃ§Ã£o irregular de rancho de pesca, Ã¡rea de preservaÃ§Ã£o permanente, faixa de areia, Praia do Sonho-PalhoÃ§a/SC', 'MPF Requisita informaÃ§Ãµes sobre regularidade de de rancho de pesca, Ã¡rea de preservaÃ§Ã£o permanente, faixa de areia, Praia do Sonho-PalhoÃ§a/SC.', 'undefined', '2019-06-24 14:37:46', '2019-06-24 14:37:46'),
(620, 8, 1, '1.33.007.000135/2017-65', 'MPF x Maurino Lemos - ConstruÃ§Ã£o de trapiche e rancho de pesca dentro da Lagoa Mirim, Laguna/SC.', 'MPF solicita informar se Maurino Lemos  possui Termo de AutorizaÃ§Ã£o de Uso SustentÃ¡vel e/ou CessÃ£o em Espelho D\'Ã¡gua, para a construÃ§Ã£o de rancho de pesca dentro da lagoa do Mirim, em Laguna/SC e, em caso negativo, a viabilidade de concessÃ£o deles. Para subsidiar a resposta encaminho cÃ³pia do TCAnÂ° 03.05.016/17-03.', 'undefined', '2019-06-24 14:53:08', '2019-06-24 14:53:08'),
(622, 1, 1, '1.33.007.000152/2019-64', 'Dano Ambiental. Garopaba', 'undefined', 'undefined', '2019-06-24 15:57:20', '2019-06-24 15:57:20'),
(623, 3, 4, '5000669-50.2010.4.04.7216', 'Reajuste da Taxa de OcupaÃ§Ã£o. RIP 8185.0001075-05', 'undefined', 'undefined', '2019-06-24 16:18:52', '2019-06-24 16:18:52'),
(624, 3, 4, '5018941-59.2018.4.04.7201', 'undefined', 'AÃ§Ã£o Finalizada - Cumprimento de sentenÃ§a - Aguardando conversÃ£o dos valores.', 'undefined', '2019-06-24 16:37:27', '2019-06-24 16:37:27'),
(625, 1, 1, '1.33.007.000141/2019-84', 'Loteamento Praia da Ilhota, no municÃ­pio de Laguna', 'undefined', 'undefined', '2019-06-24 16:42:50', '2019-06-24 16:42:50'),
(626, 2, 1, '5023965-71.2018.4.04.7200', 'Dano Ambiental. Rio Papaquara, no Bairro Vargem  Grande, FlorianÃ³polis', 'undefined', '510044207418', '2019-06-24 17:27:31', '2019-06-24 17:27:31'),
(627, 3, 4, '5032942-27.2019.4.04.7100', 'RIP 8039.0000749-09. BalneÃ¡rio CamboriÃº', 'undefined', '249059210219', '2019-06-24 20:25:07', '2019-06-24 20:25:07'),
(628, 3, 4, '5005001-50.2011.4.04.7208', 'Nulidade do Processo de DemarcaÃ§Ã£o. BalneÃ¡rio CamboriÃº', 'undefined', 'undefined', '2019-06-24 20:53:11', '2019-06-24 20:53:11'),
(629, 2, 4, '5007625-37.2018.4.04.7205', 'Dano Ambiental. Bairro Figueira, MunicÃ­pio de Gaspar/SC', 'undefined', '445408651918', '2019-06-24 21:13:28', '2019-06-24 21:13:28'),
(630, 3, 3, '5012190-44.2018.4.04.7205', 'REINTEGRAÃ‡ÃƒO/MANUTENÃ‡ÃƒO DE POSSE - RAFAEL GUBER e OUTROS - Posto AgropecuÃ¡rio de Indaial', 'undefined', '191845567418', '2019-06-24 21:48:07', '2019-06-24 21:49:14'),
(631, 3, 4, '5003655-83.2019.4.04.7208', 'DESAPROPRIAÃ‡ÃƒO INDIRETA. MunicÃ­pio de Navegantes/SC', 'undefined', '286729261119', '2019-06-24 21:48:12', '2019-06-24 21:48:12'),
(632, 1, 1, '1.33.000.0020372015-61', 'MPF x atividades das prÃ¡ticas da temporada da safra da tainha - encaminha recomendaÃ§Ã£o 59/2017', 'RecomendaÃ§Ã£o nÂ° 59/2017 - Pesca da Tainha - Refere IC para fiscalizar te, interferem na realizaÃ§Ã£o das prÃ¡ticas da temporada da SAFRA DA TAINHA, sobretudo a modalidade de pesca praticada pelas COMUNIDADES TRADICIONAIS, bem como a extensÃ£o marÃ­tima em que Ã© possÃ­vel e se permite a atividade.', 'undefined', '2019-06-24 22:20:35', '2019-06-24 22:20:35'),
(634, 3, 4, '5012425-86.2019.4.04.7201', 'UsucapiÃ£o. Rua CaraÃ­pe, s/nÂº., Bairro Figueira do Pontal, ItapoÃ¡/SC', 'undefined', '907107243019', '2019-06-24 22:34:54', '2019-06-24 22:34:54'),
(635, 3, 3, '5010704-58.2017.4.04.7205', 'DemoliÃ§Ã£o de edificaÃ§Ã£o construÃ­da semalvarÃ¡ - Rio ItajaÃ­ AÃ§u - Gaspar/SC', 'undefined', '531130008017', '2019-06-24 22:56:44', '2019-06-24 22:56:44'),
(636, 1, 1, '1.33.005.000285/2009-89', 'MPF x Orla MarÃ­tima - Barra Velha/SC', 'MPF solicita informaÃ§Ãµes sobre regularidade de ocupaÃ§Ã£o Rua Oscar Galm, 137 - Itajuba - Barra Velha (SC) pois trata-se de Ã¡rea adjacente Ã  acrescido de marinha e APP.', 'undefined', '2019-06-24 23:00:27', '2019-06-24 23:00:27'),
(637, 3, 1, '5001424-68.2019.4.04.7213', 'RetificaÃ§Ã£o de registro de imÃ³vel. Rio do Sul', 'undefined', '202610795519', '2019-06-24 23:16:45', '2019-06-24 23:16:45'),
(638, 3, 4, '5002882-38.2014.4.04.7200', 'UsucapiÃ£o. CacupÃ©, FlorianÃ³polis', 'undefined', '879026664914', '2019-06-25 16:17:28', '2019-06-25 16:17:28'),
(639, 2, 2, '5012355-69.2019.4.04.7201', 'Impugna o processo de revisÃ£o do Plano diretor de SÃ£o Francisco do Sul/SC', 'undefined', '970512575519', '2019-06-25 20:01:39', '2019-06-25 20:01:39'),
(640, 3, 4, '5016681-77.2016.4.04.7201', 'UsucapiÃ£o. Joinville', 'undefined', '834918781716', '2019-06-25 20:26:12', '2019-06-25 20:26:12'),
(641, 1, 1, '1.33.008.000012/2015-52', 'OcupaÃ§Ãµes irregulares entre as praias de SÃ£o Miguel e da Galheta, no municÃ­pio de Penha/SC', 'undefined', 'undefined', '2019-06-25 21:58:23', '2019-06-25 21:58:23'),
(642, 1, 4, '1.33.000.001749/2018-13', 'Regularidade de UtilizaÃ§Ã£o', 'Versa sobre invasÃ£o e uso da faixa de praia na Barra da Lagoa - FlorianÃ³polis/SC', 'undefined', '2019-06-26 15:12:22', '2019-06-26 15:12:22'),
(643, 2, 4, '5025563-31.2016.4.04.7200', 'Zona Costeira do Campeche', NULL, 'undefined', '2019-06-26 16:55:20', '2019-06-26 23:22:46'),
(644, 3, 4, '5004926-64.2018.4.04.7208', 'MajoraÃ§Ã£o da PVG', 'retende seja reconhecida a inexigibilidade dos dÃ©bitos cobrados pela SPU a tÃ­tulo de taxa de ocupaÃ§Ã£o, juros e multa, desde 2007 (inclusive)', 'undefined', '2019-06-26 21:15:54', '2019-06-26 21:15:54'),
(645, 3, 1, '5012889-55.2015.4.04.7200', 'RegularizaÃ§Ã£o de Ã¡reas de rancho de pesca e uma moradia - Praia do Riso - Coqueiros - FlorianÃ³polis/SC', 'undefined', '695699960615', '2019-06-26 21:21:02', '2019-06-26 21:21:02'),
(646, 3, 1, '5004114-28.2018.4.04.7206', 'ex-RFFSA e MunicÃ­pio de Lages - RegularizaÃ§Ã£o FundiÃ¡ria', 'undefined', '273916096418', '2019-06-26 21:34:49', '2019-06-26 21:34:49'),
(647, 1, 1, '1.33.007.000182/2019-71', 'Rancho de pesca sobre as dunas frontais da Praia da Barra de Ibiraquera, em Imbituba', 'undefined', 'undefined', '2019-06-26 21:54:01', '2019-06-26 21:54:01'),
(648, 3, 1, '5023336-36.2014.404.7201', 'Araquari/SC - RegularizaÃ§Ã£o FundiÃ¡ria - Reurb -  ConciliaÃ§Ã£o', 'undefined', 'undefined', '2019-06-26 21:59:30', '2019-06-26 22:00:58'),
(649, 1, 1, '1.33.005.000441/2007-40', 'ImÃ³vel cedido ao MunicÃ­pio de Joinville - Aforamento Gratuito -  Localidade do Espinheiros', 'undefined', 'undefined', '2019-06-26 22:32:49', '2019-06-26 22:32:49'),
(650, 3, 4, '5018153-82.2017.4.04.7200', 'WILSON JOSÃ‰ LOPES DARELLA - Cancelamento RIP Rancho de Pesca - Praia do Cardoso - Farol de Santa Marta - Laguna', 'undefined', '161418802017', '2019-06-26 23:09:07', '2019-06-26 23:09:07'),
(651, 2, 4, '5027598-32.2014.404.7200', 'Campo de AviaÃ§Ã£o do Campeche', 'undefined', '140863392514', '2019-06-26 23:25:53', '2019-07-10 21:39:53'),
(652, 2, 1, '5020944-87.2018.4.04.7200', 'Dano Ambiental, Rio Tavares, FlorianÃ³polis', 'undefined', '688683317818', '2019-06-27 17:10:49', '2019-06-27 17:10:49');
INSERT INTO `procedimentoexterno` (`id`, `idTipoProcedimentoExterno`, `idPoloProcedimentoExterno`, `procedimento`, `resumo`, `descricao`, `chave`, `created_at`, `updated_at`) VALUES
(653, 2, 4, '5018586-52.2018.4.04.7200', 'ÃREA DE PRESERVAÃ‡ÃƒO PERMANENTE', 'ÃREA DE PRESERVAÃ‡ÃƒO PERMANENTE', '650531711718', '2019-06-27 19:26:38', '2019-06-27 19:26:38'),
(654, 3, 2, '5001721-83.2011.4.04.7204', 'Cumprimento de SentenÃ§a. RFFSA, AraranguÃ¡', 'undefined', '532647088311', '2019-06-27 20:29:58', '2019-06-27 20:29:58'),
(655, 2, 3, '5021103-30.2018.4.04.7200', 'Dano Ambiental, Caminho da Costa da Lagoa da ConceiÃ§Ã£o, FlorianÃ³polis', 'undefined', '375177004118', '2019-06-27 21:14:50', '2019-06-27 21:14:50'),
(656, 1, 4, '1.33.007.000075/2011-95', 'Rancho de Pesca - Praia do Cardoso - Cabo de Santa Marta - Laguna', 'undefined', 'undefined', '2019-06-27 21:26:27', '2019-06-27 21:26:27'),
(657, 1, 4, '1.33.007.000169/2014-15', 'RecomendaÃ§Ã£o 45/2014 - Restaurante CasarÃ£o e Parador Swell - Praia do Rosa - Imbituba/SC', 'undefined', 'undefined', '2019-06-27 21:43:49', '2019-06-27 21:43:49'),
(658, 3, 4, '0001482-77.2008.8.24.0189', 'UsucapiÃ£o. Passo de Torres', 'undefined', 'undefined', '2019-06-27 23:04:14', '2019-06-27 23:04:14'),
(659, 1, 1, '1.33.007.000147/2014-47', 'TRAPICHE,  LAGOA DA CIGANA. LAGUNA/SC', 'undefined', 'undefined', '2019-06-27 23:43:47', '2019-06-27 23:43:47'),
(660, 1, 4, '1.33.005.000065/2017-65', 'Loteamento  Portal  da  Barra - Barra do Itapocu - Araquari/SC', 'undefined', 'undefined', '2019-06-28 19:58:40', '2019-06-28 19:58:40'),
(661, 3, 4, '5007054-15.2017.4.04.7201', 'UsucapiÃ£o. bairro Paulas, municÃ­pio de SÃ£o Francisco do Sul/SC', 'undefined', 'undefined', '2019-07-02 17:27:29', '2019-07-02 17:27:29'),
(662, 2, 4, '5017756-33.2011.4.04.7200', 'TAUS - regularidade cadastral', 'Proximidades da Ponte HercÃ­lio Luz, Estreito, MunicÃ­pio de FlorianÃ³polis/SC', 'undefined', '2019-07-02 20:30:19', '2019-07-02 20:30:19'),
(664, 3, 2, '0005421-28.2001.8.24.0022', 'Penhora', 'manifestaÃ§Ã£o dessa SuperintendÃªncia a respeito do imÃ³vel em questÃ£o, especialmente sobre eventual validade do ajuste intitulado \"Termo Particular de CessÃ£o de Direito e de Posse de Ilha MarÃ­tima\" firmado entre particulares e juntado aos autos', 'undefined', '2019-07-02 20:34:17', '2019-07-02 20:34:17'),
(665, 9, 4, '5014018-56.2019.4.04.7200', 'ConclusÃ£o do Processo nÂº 05022.004512/2003 - 61', 'undefined', 'undefined', '2019-07-02 20:36:17', '2019-07-02 20:36:17'),
(666, 3, 4, '5013374-16.2019.4.04.7200', 'Anular os dÃ©bitos referentes ao RIP 82330100037-90', 'undefined', 'undefined', '2019-07-02 22:08:08', '2019-07-02 22:08:08'),
(667, 3, 4, '5010366-33.2016.4.04.7201', 'RIPs 8025.0000533-59 e RIP 8025.0000534-30', 'undefined', 'undefined', '2019-07-03 16:49:08', '2019-07-03 16:49:08'),
(668, 9, 4, '5007601-24.2018.4.04.7200', 'Aforamento- RIP 8265.0001208-80', 'undefined', 'undefined', '2019-07-03 17:32:44', '2019-07-03 17:32:44'),
(669, 3, 2, '5011320-50.2014.404.7201', 'UsucapiÃ£o - RFFSA - km  24+000, distante 74,16 metros da Rua AntÃ´nio Ramos Alvim, Araquari', NULL, '131871511314', '2019-07-03 19:53:00', '2019-07-18 16:20:05'),
(670, 9, 4, '5001196-17.2019.4.04.7206', 'FinalizaÃ§Ã£o do processo administrativo 04972.008831/2018-21', 'undefined', 'undefined', '2019-07-03 20:23:31', '2019-07-03 20:23:31'),
(671, 6, 1, '529/2018-4', 'InterferÃªncia com Ã¡rea da UniÃ£o', 'informe se o Ã¡rea localizada nas coordenadas: latitude 27Â°36\'05\" 5 - longitude 48Â°35\'54\" W, foco da denÃºncia, de propriedade da Senhora Florisbela Becker (CPF 599.324.309-00), setenta e nove anos, incide em terrenos de marinha e seus acrescidos.', 'undefined', '2019-07-04 22:26:51', '2019-07-04 22:26:51'),
(672, 3, 4, '5014737-72.2018.4.04.7200', 'Encaminha Parecer de ForÃ§a ExecutÃ³ria', 'undefined', '449606643018', '2019-07-04 22:29:53', '2019-07-04 22:29:53'),
(673, 1, 2, '1.33.008.000064/2009-81', 'MPF ItajaÃ­ x empreeendimentos em Ã¡rea da uniÃ£o em BalneÃ¡rio CamboriÃº', 'MPF solicito informar se os empreendimentos listados estÃ£o ocupando Ã¡rea pertencente Ã  UniÃ£o e, em caso afirmativo, se possuem autorizaÃ§Ã£o de ocupaÃ§Ã£o:1) Sky Beach (RMG Restaurante Ltda.), Rua Higino JoÃ£o Pio, 400,Praia do Estaleirinho, BalneÃ¡rio CamboriÃº/SC; 2) Parador Beach Club (Mini resort Estaleirinho Ltda.), Rua Victorio Fornerolli, 654, Praia do Estaleirinho, BalneÃ¡rio CamboriÃº/SC; 3) Vitali Beach Lounge, Av. Rodesino Pavan, 10.205 e 4) Dreams Beach Club, Av. Interpraias, s/n, BalneÃ¡rio CamboriÃº.', 'undefined', '2019-07-04 22:42:22', '2019-07-04 22:42:22'),
(675, 1, 1, '1.33.009.000092/2015-36', 'MPF CaÃ§ador x ocupaÃ§Ã£o de casas da extinta RFFSA - Rio das Antas', 'MPF solicita adoÃ§Ã£o das medidas que entender necessÃ¡rias no tocante Ã  ocupaÃ§Ã£o das 8 (oito) casas da extinta RFFSA em Rio das Antas.', 'undefined', '2019-07-04 22:56:19', '2019-07-04 22:56:19'),
(676, 1, 1, '1.33.005.000458/2015-15', 'OcupaÃ§Ãµes Ã s margens do Rio IcaraÃ­, bairro Ubatuba - SÃ£o Francisco do Sul', NULL, 'undefined', '2019-07-05 16:18:01', '2019-07-05 16:19:03'),
(677, 1, 1, '1.33.005.000120/2017-17', 'MPF x Woldport Desenvolvimento PortuÃ¡rio S/A', 'MPF  solicita informaÃ§Ãµes atualizadas quanto Ã  anÃ¡lise do pedido de inscriÃ§Ã£o de ocupaÃ§Ã£o da Ã¡rea efetuado pela empresa Worldport Desenvolvimento PortuÃ¡rio S/A., bem como se hÃ¡ solicitaÃ§Ã£o de cessÃ£o de espelho d\'Ã¡gua.', 'undefined', '2019-07-05 17:03:51', '2019-07-05 17:03:51'),
(678, 1, 1, '06.2010.00005713-3', 'MPFx construÃ§Ãµes irregulares Rio da Madre - TubarÃ£o/SC', 'requisita que se manifeste sobre o interesse relativo a existÃªncia de construÃ§Ãµes irregulares (casas, pontes e etc.) em Ã¡rea de preservaÃ§Ã£o permanente, ao longo do Rio da Madre, situado em TubarÃ£o, para a adoÃ§Ã£o de medidas judiciais e extrajudiciais, nos termos do despacho de arquivamento anexo ao ofÃ­cio acima referenciado.', 'undefined', '2019-07-05 17:15:57', '2019-07-05 17:15:57'),
(680, 4, 1, '05.2019.00037892-1', 'Danos ambientais em Ã¡rea de mangue', 'imÃ³vel, localizado na rua Costancio Visentainer, n. 1171, bairro Aventureiro. Joinville/SC', 'undefined', '2019-07-05 19:36:19', '2019-07-05 19:36:19'),
(681, 9, 4, '5014077-44.2019.4.04.7200', 'a parte impetrante pretende seja concedida a medida liminar para o fim de ser suspensa a exigibilidade das taxas geradas a partir da inscriÃ§Ã£o da impe', 'a parte impetrante pretende seja concedida a medida liminar para o fim de ser suspensa a exigibilidade das taxas geradas a partir da inscriÃ§Ã£o da impetrante como ocupante da Ã¡rea de marinha correspondente ao RIP 8113.0000168-80', '708606264819', '2019-07-05 19:45:37', '2019-07-05 19:45:37'),
(682, 3, 4, '5001667-29.2011.4.04.7201', 'OcupaÃ§Ã£o irregular - Rua Blandina Steiner Beckhauser, Capri, SÃ£o Francisco do Sul. Agostinho Ramos Alves', 'undefined', '339321697311', '2019-07-05 20:00:18', '2019-07-05 20:00:18'),
(683, 1, 1, '1.33.005.00113/2015-53', 'MPF Joinville x depÃ³sito de rejeitos da construÃ§Ã£o civil na Rua Prefeito Baltazar Buschle, Joinville/SC.', 'MPF solicita informaÃ§Ãµes sobre a Ã¡rea apontada no Auto de ConstataÃ§Ã£o nÂ° 053/23 Cia/BPMA/2015, localizada a Rua Prefeito Baltazar Buschle, Joinville/SC, Coordenadas UTM 22J 0720448-70908898, localiza-se, ao menos parcialmente, em Ã¡reas de terras de marinha e seus acrecidos (LPM/1831), nos termos do art. 2Â°,\"a\", do Decreto-Lei nÂ° 9.760/46', 'undefined', '2019-07-05 20:25:41', '2019-07-05 20:25:41'),
(685, 1, 1, '1.33.005.001113/2015-53', 'MPF Joinville x depÃ³sito de rejeitos da construÃ§Ã£o civil  localizada a Rua Prefeito Baltazar Buschle, Joinville/SC.', 'MPF solicita informaÃ§Ãµes sobre a Ã¡rea apontada no Auto de ConstataÃ§Ã£o nÂ° 053/23 Cia/BPMA/2015, localizada a Rua Prefeito Baltazar Buschle, Joinville/SC, Coordenadas UTM 22J 0720448-70908898, localiza-se, ao menos parcialmente, em Ã¡reas de terras de marinha e seus acrecidos (LPM/1831), nos termos do art. 2Â°,\"a\", do Decreto-Lei nÂ° 9.760/46', 'undefined', '2019-07-05 20:31:43', '2019-07-05 20:31:43'),
(686, 3, 4, '5002208-60.2019.4.04.7208', 'TAXA DE OCUPAÃ‡ÃƒO e LAUDÃŠMIO- RIP 8245.0000430-59', 'aÃ§Ã£o ordinÃ¡ria declaratÃ³ria na qual se buscava:1) declarar a nulidade do processo de demarcaÃ§Ã£o dos terrenos de marinha e afastar a exigibilidade da cobranÃ§a da taxa de ocupaÃ§Ã£o e laudÃªmio, com a condenaÃ§Ã£o da rÃ© a repetir os valores pagos indevidamente; 2) declarar a nulidade do processo administrativo de majoraÃ§Ã£o da taxa de ocupaÃ§Ã£o; 3) declarar a inexigibilidade do laudÃªmio sobre a transferÃªncia do imÃ³vel, considerando que se encontra sob o regime de ocupaÃ§Ã£o.', '907693790919', '2019-07-05 21:13:32', '2019-07-05 21:13:32'),
(687, 8, 1, '503627381.2014.4.04.7200', 'MPF x OperaÃ§Ã£o Moeda Verde Florianopolis/SC', 'MPF x solicita que em relaÃ§Ã£o ao documento em que Annito Zeno Petry e Habitasul cedem terras ao MunicÃ­pio, informaÃ§Ã£o detalhada quanto ao encaminhamento, no Ã¢mbito do ServiÃ§o do PatrimÃ³nio da UniÃ£o, que foi dado a tal cessÃ£o, desde 31/7/1990 atÃ© hoje; informaÃ§Ã£o trazendo a relaÃ§Ã£o dos fatos que estejam registrados e que liguem os documentos com a sua localizaÃ§Ã£o atualizada, e seja informado se o ServiÃ§o do PatrimÃ³nio da UniÃ£o tem registrado o conceito de postos de praia.', 'undefined', '2019-07-05 21:43:48', '2019-07-05 21:43:48'),
(688, 1, 1, '1.33.005.000449/2016-35', 'MPF Joinville x Rua dos Pescadores\", lateral da Estrada Geral do Frias, Bairro Frias, MunicÃ­pio e ao Francisco do Sul/SC', 'MPF solicita o encaminhamento e  informaÃ§Ãµes/documentos sobre a Ã¡rea localizada na \"Rua dos Pescadores\", lateral da Estrada Geral do Frias, Bairro Frias, MunicÃ­pio e ao Francisco do Sul,  se pertence Ã  UniÃ£o, notadamente se abrange terras de marinha e seus acrescidos.', 'undefined', '2019-07-05 21:54:28', '2019-07-05 21:54:28'),
(689, 1, 1, '1.33.007.000009/2017-19', 'Regularidade Cadastral - Jaguaruna/SC', 'Informar se os imÃ³veis de propriedade de Denise Neves da Silva Machado, construÃ­dos entre as localidades conhecidas como \"Arroio Corrente\" e \n Campo Bom\", no municÃ­pio de Jaguaruna (coordenadas geogrÃ¡ficas: ImÃ³vel 1 - 28Â°42\"28.13\"S 49Â°02\"24.57\"W; ImÃ³vel 2 - 28Â°42\"27.79\"S 49Â°02\"24.81\"W), estÃ£o situados total ou parcialmente em terrenos de marinha e/ou acrescidos. Jaguaruna/SC.', 'undefined', '2019-07-08 15:06:13', '2019-07-08 15:06:13'),
(690, 1, 4, '1.33.007.000348/2014-44', 'Regularidade Cadastral - FiscalizaÃ§Ã£o -  Garopaba/SC', 'RecomendaÃ§Ã£o para fiscalizar e evitar a construÃ§Ã£o em Ã¡rea nÃ£o edificÃ¡vel. Garopaba/SC', 'undefined', '2019-07-08 15:25:16', '2019-07-08 15:25:16'),
(691, 1, 1, '1.33.007.000177/2019-68', 'Regularidade Cadastral - Imbituba/SC', 'Verificar a inserÃ§Ã£o em bens da UniÃ£o e a regularidade cadastral do imÃ³vel (coordenadas UTM 22J 0721582 - 6865421).', 'undefined', '2019-07-08 15:57:11', '2019-07-08 15:57:11'),
(692, 3, 2, '0009421-29.2018.8.24.0005', 'SuscitaÃ§Ã£o de DÃºvida 1Âº OfÃ­cio de Registro de ImÃ³veis BalneÃ¡rio CamboriÃº/SC.', 'DÃºvida envolvendo as matrÃ­culas do EdifÃ­cio Infinity Coast Residence. BalneÃ¡rio CamboriÃº/SC.', 'undefined', '2019-07-08 16:47:01', '2019-07-08 16:47:01'),
(693, 2, 4, '5010855-05.2018.4.04.7200', 'Dano Ambiental.Praia Fazenda da  ArmaÃ§Ã£o no municÃ­pio de Governador Celso Ramos', 'undefined', '928117204918', '2019-07-08 16:53:17', '2019-07-08 16:53:17'),
(694, 1, 4, '1.33.007.000179/2017-95', 'EDIFICAÃ‡Ã•ES NO MORRO DO Gl. LADO NORTE. LAGUNA/SC', 'RECOMENDAÃ‡ÃƒO nÂ° 16/2019 - mediante processo administrativo, realize o desapossamento de todos os imÃ³veis inseridos em terrenos de marinha e/ou acrescidos na localidade da Praia do Gi (lado norte), no municÃ­pio de Laguna, visto que situados em Ã¡rea de preservaÃ§Ã£o permanente e proceda o cancelamento dos RIPs jÃ¡ emitidos, nos termos do art. 9Â°, inciso II a e art. 10, ambos da Lei n. 9.636/98, devendo, ainda, ainda abster-se de deferir inscriÃ§Ã£o de ocupaÃ§Ã£o para imÃ³veis situados naquela localidade.', 'undefined', '2019-07-08 19:13:58', '2019-07-08 19:13:58'),
(695, 3, 1, '5002193-94.2019.4.04.7207', 'UsucapiÃ£o', 'manifestar interesse em integrar a lide', 'undefined', '2019-07-08 21:01:29', '2019-07-08 21:01:29'),
(696, 3, 4, '5010087-89.2017.4.04.7208', 'Nulidade do reajuste da taxa de OcupaÃ§Ã£o. RIP 8265.0000201-50', 'undefined', '939786191217', '2019-07-08 23:06:32', '2019-07-08 23:06:32'),
(697, 8, 1, '1.33.005.000494/2015-71', 'MPF x CLUBE NÃUTICO CANTO DO RIO E OUTROS  ; MARINA KALEMAR;  GALPÃƒO PARA BARCOS DO SR. EDORI- Joinville/SC', 'MPF a fim de instruir o Procedimento PreparatÃ³rio solicita informaÃ§Ãµes/documentos sobre os imÃ³veis objeto da presente apuraÃ§Ã£o, notadamente se as Ã¡reas descritas pertencem Ã  UniÃ£o e se abrangem terras de marinha e seus acrescidos.', 'undefined', '2019-07-09 15:35:21', '2019-07-09 15:35:21'),
(699, 4, 1, '1.33.000.001176/2016-58', 'MPF x ConstruÃ§Ã£o de edificaÃ§Ãµes na localidade de Ponta de Baixo, SÃ£o JosÃ©/SC', 'No interesse da NF nÂ° 1.33.000.001176/2016-58, instaurada com base em noticia de possÃ­vel irregularidade na construÃ§Ã£o de edificaÃ§Ã£o e realizaÃ§Ã£o de aterro no costÃ£o ao final da Rua Edmundo JosÃ© Dutra, Bairro Ponta de Baixo, em SÃ£o JosÃ©/SC, encaminho-lhe cÃ³pia da representaÃ§Ã£o e REQUISITO, em 10DIAS, esclarecimentos sobre a regularidade das obras e ocupaÃ§Ã£o na Ã¡rea, sobretudo se pertence Ã  UNIÃƒO ou a alguma autarquia federal, bem como a delimitaÃ§Ã£o da LPM/1831 no local, a fim de verificar os limites da Ã¡rea de marinha e se as interferÃªncias estÃ£o sendo realizadas sobre Ã¡rea de bem de uso comum do povo. Em caso de confirmaÃ§Ã£o de irregularidade na execuÃ§Ã£o das obras de aterro e construÃ§Ã£o, a S PU deverÃ¡ informar quais medidas pretende adotar no Ã¢mbito de sua competÃªncia.', 'undefined', '2019-07-09 15:59:45', '2019-07-09 15:59:45'),
(700, 1, 1, '1.33.005.000487/2017-31', 'Regularidade Cadastral', 'Estrada Geral da Barra do ItapocÃº, Bairro ItapocÃº, em Araquari/SC', 'undefined', '2019-07-09 16:06:55', '2019-07-09 16:06:55'),
(701, 3, 4, '5013635-88.2013.4.04.7200', 'MajoraÃ§Ã£o da Taxa de OcupaÃ§Ã£o. RIP  8111 0000117-09.', 'undefined', '390465007613', '2019-07-09 19:44:49', '2019-07-09 19:44:49'),
(702, 3, 1, '5005924-95.2019.4.04.7208', 'SEQUESTRO - MEDIDAS ASSECURATÃ“RIAS', 'undefined', 'undefined', '2019-07-09 20:13:26', '2019-07-09 20:13:26'),
(703, 7, 4, '5003803-94.2019.4.04.7208', 'A responsÃ¡vel pelo imÃ³vel matriculado sob o RIP n. 8221010004318, pretende o reconhecimento de direito de isenÃ§Ã£o', 'Nos autos do processo acima mencionado, a parte autora, DALVA MARIA\r\nSÃ“CRATES (CPF n. 008.080.459-46), responsÃ¡vel pelo imÃ³vel matriculado sob o RIP n.\r\n8221010004318, pretende o reconhecimento do direito Ã  isenÃ§Ã£o de taxa de ocupaÃ§Ã£o\r\nprevista no art. 1Âº do Decreto-Lei n. 1.876/81, bem como, por conseguinte a deconstituiÃ§Ã£o\r\ndos dÃ©bitos existentes em seu nome atualmente inscritos em DAU. Alega que, desde\r\n2014, jÃ¡ formulou diversos pedidos de reconhecimento do direito Ã  isenÃ§Ã£o perante a SPU\r\n(Protocolos n. 04972010318201476 , 04972205703201581, 04972004580201813\r\ne 04972007660201812), mas nunca obteve resposta. Em anexo, segue a petiÃ§Ã£o inicial.', 'undefined', '2019-07-09 20:22:57', '2019-07-09 20:22:57'),
(704, 3, 4, '5002188-50.2016.4.04.7216', 'UsucapiÃ£o- Imbituba', 'undefined', '626792358816', '2019-07-09 21:12:17', '2019-07-09 21:12:17'),
(705, 3, 1, '5000732-17.2019.8.24.0023/SC', 'indisponibilidade de transferÃªncia do direito de ocupaÃ§Ã£o do imÃ³vel cadastrado sob o RIP 8105 0100474-00', 'undefined', 'undefined', '2019-07-09 22:01:53', '2019-07-09 22:01:53'),
(706, 1, 1, '1.33.005.000050/2016-16', 'MPF x a Lombok ParticipaÃ§Ãµes e Consultoria Empresarial Ltda., Miranda, SÃ£o Francisco do Sul/SC', 'MPF solicita que informe quais foram as providÃªncias adotadas/ no Ã¢mbito de seu poder-dever de polÃ­cia administrativa, a partir da notÃ­cia da inexistÃªncia de registros de regularizaÃ§Ã£o da atividade desempenhada pela empresa Lombok ParticipaÃ§Ãµes e Consultoria Empresarial Ltda.', 'undefined', '2019-07-10 17:13:28', '2019-07-10 17:13:28'),
(707, 1, 1, '1.33.000.003188/2013-74', 'CondomÃ­nio VilIas Gregas, Costeira da ArmaÃ§Ã£o  da Piedade, Governador Celso Ramos', 'InquÃ©rito Civil  que versa sobre pretensÃ£o de implantaÃ§Ã£o do empreendimento denominado CondomÃ­nio VilIas Gregas, localidade da Costeira da ArmaÃ§Ã£o da Piedade, municÃ­pio de Governador Celso Ramos/SC, de interesse da empresa Forma EspaÃ§os ImobiliÃ¡rios LTDA.', 'undefined', '2019-07-10 17:18:23', '2019-07-10 17:18:23'),
(708, 3, 4, '5001396-96.2016.4.04.7216', 'UsucapiÃ£o. Imbituba', 'undefined', 'undefined', '2019-07-10 20:21:37', '2019-07-10 20:21:37'),
(711, 1, 1, '1.33.000.000412/2018-81', 'Barra do AririÃº, PalhoÃ§a/SC, imÃ³vel Rua Nossa Senhora dos Navegantes, nÃºmero 171', 'I.C que versa sobre informaÃ§Ãµes acerca do imÃ³vel  localizado no bairro Barra do AririÃº, PalhoÃ§a/SC, na Rua Nossa Senhora dos Navegantes, nÃºmero 171, em nome de MÃ¡rcia AnÃ©zia Martins, para verificar se encontra-se em Ã¡rea de marinha e/ou praia e se estÃ¡ regularizado perante a UniÃ£o', 'undefined', '2019-07-10 20:26:20', '2019-07-10 20:27:23'),
(714, 1, 1, '1.33.001.000413/2017-34', 'imÃ³vel rua ItajaÃ­, bairro Vorstadt, Blumenau/SC, autorizaÃ§Ã£o para ocupaÃ§Ã£o/venda imÃ³vel', 'I.C que versa sobre a verificaÃ§Ã£o de informaÃ§Ãµes acerca de autorizaÃ§Ã£o ocupaÃ§Ã£o/venda de imÃ³vel em Blumenau/SC', 'undefined', '2019-07-10 20:51:49', '2019-07-10 20:51:49'),
(715, 1, 4, '1.33.007.000036/2012-79', 'RegularizaÃ§Ã£o FundiÃ¡ria', 'MunicÃ­pio de Laguna/SC, sobre a regularizaÃ§Ã£o fundiÃ¡ria que serÃ¡ realizada entre os bairros de Vila VitÃ³ria e Ponta das Pedras', 'undefined', '2019-07-10 21:17:33', '2019-07-10 21:17:33'),
(718, 1, 1, '1.33.000.000630/2018-15', 'MPF x Canal da Barra da Lagoa/FlorianÃ³polis (possivle fechamento de acesso aos banhistas)', 'MPF requisita adoÃ§Ã£o de medidas para a regularizaÃ§Ã£o da utilizaÃ§Ã£o de rancho de pesca artesanal, tendo em vista possÃ­vel fechamento de acesso de banhistas canal da Barra da Lagoa/FlorianÃ³polis.', 'undefined', '2019-07-10 21:33:29', '2019-07-10 21:33:29'),
(719, 1, 1, '1.33.008.000345/2013-10', 'Praia do Atalaia. ItajaÃ­/SC, ocupaÃ§Ãµes irregulares', 'Procedimento instaurado para apurar os danos ambientais causados por ocupaÃ§Ãµes irregulares na Praia do Atalaia.', 'undefined', '2019-07-10 21:39:43', '2019-07-10 21:39:43'),
(720, 1, 1, '1.33.008.000039/2017-15', 'MPF x DenÃºncia de edificaÃ§Ã£o sobre espelho d\'agua, AraÃ§Ã¡ Porto Belo/SC.', 'Denuncia de de edificaÃ§Ã£o sobre espelho d\'agua, AraÃ§Ã¡ Porto Belo/SC. Procedimento PreparatÃ³rio convertido em InquÃ©rito Civil.', 'undefined', '2019-07-10 21:44:45', '2019-07-10 21:44:45'),
(724, 9, 1, '5013266-81.2019.4.04.7201', 'ZONA COSTEIRA E OUTROS - SubsÃ­dios', 'subsidiando a defesa da UniÃ£o em juÃ­zo e em especial subsÃ­dios sobre o pedido liminar - Verificar se estÃ¡ em Ã¡rea da UniÃ£o', '874493384919', '2019-07-11 15:19:45', '2019-07-11 15:19:45'),
(725, 3, 4, '5014102-57.2019.4.04.7200', 'Multa de TransferÃªncia. RIP  8105.0000226-41,', 'undefined', '110030491219', '2019-07-11 16:16:54', '2019-07-11 16:16:54'),
(726, 1, 1, '1.33.000.001018/2012-74', 'MPF x EdificaÃ§Ã£o irregular -  Canto da Feiticeira - Praia dos Ingleses/FlorianÃ³polis-SC', 'MPF requisita informaÃ§Ãµes sobre providencias adotadas referente a edificaÃ§Ã£o irregular em faixa de areia no Canto da Feiticeira, Praia dos Ingleses.', 'undefined', '2019-07-11 17:21:42', '2019-07-11 17:21:42'),
(728, 8, 1, '00553.001589/2016-82', 'ATIVIDADE MEIO - PRM - JOINVILLE (CHEFE-MPF-JOI) Dano Ambiental em APP', 'solicitar informaÃ§Ãµes atualizadas quanto Ã s providÃªncias adotadas posteriormente, a respeito das ocupaÃ§Ãµes em Ã¡rea da UniÃ£o. Para que possamos responder aos questionamentos do MPF.', 'undefined', '2019-07-12 21:21:10', '2019-07-12 21:21:10'),
(729, 3, 2, '0016064-53.2002.8.24.0008', 'AnotaÃ§Ã£o de Indisponibilidade RIP 8265 0001168-59', 'undefined', 'undefined', '2019-07-12 21:55:58', '2019-07-12 21:55:58'),
(730, 7, 3, '5010696- 47.2018.4.04.7205', 'DAU', 'ALBOR SA REPRESENTAÃ‡Ã•ES E COMERCIO, CNPJ 84.663.549/0001-18', 'undefined', '2019-07-15 15:20:11', '2019-07-15 15:20:11'),
(731, 3, 4, '5016314-32.2016.4.04.7208/SC', 'RegularizaÃ§Ã£o FundiÃ¡ria', 'ProrrogaÃ§Ã£o da data final da doaÃ§Ã£o do imÃ³vel (Conjunto Habitacional Ernesto Che Guevara) da UniÃ£o ao MunicÃ­pio de Tijucas/SC', 'undefined', '2019-07-15 16:05:09', '2019-07-15 16:05:09'),
(732, 3, 4, '5001581-42.2013.4.04.7216', 'UsucapiÃ£o. Laguna', 'undefined', 'undefined', '2019-07-15 21:39:35', '2019-07-15 21:39:35'),
(733, 2, 2, '5008825-19.2017.4.04.7204', 'Dano Ambiental. AraranguÃ¡, no distrito de HercÃ­lio Luz', 'undefined', '986457013317', '2019-07-15 22:05:58', '2019-07-15 22:05:58'),
(734, 3, 4, '5009510-82.2010.4.04.7200', 'Ilha do Frances. RIP 8105.0000275-20', 'undefined', '688775065910', '2019-07-16 20:31:35', '2019-07-16 20:31:35'),
(735, 3, 4, '5006689-06.2018.4.04.7207', 'BalneÃ¡rio Camacho, Jaguaruna', 'undefined', '679401326518', '2019-07-16 21:25:40', '2019-07-16 21:25:40'),
(736, 2, 1, '0904987-87.2015.8.24.0033', 'ausÃªncia de delimitaÃ§Ã£o das Ã¡reas urbanas consolidadas, Navegantes.', 'undefined', 'undefined', '2019-07-16 21:35:03', '2019-07-16 21:35:03'),
(737, 3, 1, '5000239-62.2019.8.24.0048', 'AÃ§Ã£o AnulatÃ³ria - LicenÃ§a para construÃ§Ã£o - MunicÃ­pio de Penha/SC', 'undefined', 'undefined', '2019-07-17 15:01:07', '2019-07-17 15:01:07'),
(738, 3, 4, '0003405-95.2012.8.24.0061', 'UsucapiÃ£o. SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-07-17 20:09:10', '2019-07-17 20:09:10'),
(739, 2, 4, '5007761-69.2011.4.04.7208', 'FiscalizaÃ§Ã£o efetiva da Ã¡rea e e a recuperarem a Ã¡rea degradada. ITAJAÃ, margens do Rio ItajaÃ­-AÃ§u', 'undefined', 'undefined', '2019-07-17 20:25:44', '2019-07-17 20:25:44'),
(741, 3, 4, '5006980-78.2019.4.04.7204', 'UsucapiÃ£o. Arroio do Silva', 'undefined', 'undefined', '2019-07-17 21:06:26', '2019-07-17 21:06:26'),
(742, 6, 1, '2019.0000871', 'REPRESSÃƒO CRIMES CONTRA MEIO AMBIENTE E PATRIM. HISTÃ“RICO', 'Verificar interferÃªncia com Ã¡reas da UniÃ£o.', 'undefined', '2019-07-17 21:40:01', '2019-07-17 21:40:01'),
(743, 6, 1, '2019.0000392-SR/PF/SC', 'REPRESSÃƒO CRIMES CONTRA MEIO AMBIENTE', 'Verificar interferÃªncia.', 'undefined', '2019-07-17 21:56:17', '2019-07-17 21:56:17'),
(744, 2, 2, '5013220-92.2019.4.04.7201', 'PRAD - indenizaÃ§Ã£o pelos danos ambientais e morais causados em decorrÃªncia de vazamento de Ã³leo de xisto que ocasionou poluiÃ§Ã£o de solo e hÃ­drica.', 'RIP 81790003545-08 - Joinville/SC', 'undefined', '2019-07-18 16:27:58', '2019-07-18 16:27:58'),
(745, 3, 2, '0003779-51.2013.8.24.0005', 'Nulidade de Escritura de Compra e Venda', 'Apartamento n. 1605, do EdifÃ­cio RepÃºblica Argentina, localizado na Avenida Brasil, n. 2801 - BalneÃ¡rio CamboriÃº/SC', 'undefined', '2019-07-18 19:55:54', '2019-07-18 19:55:54'),
(746, 1, 1, '1.33.003.000326/2010-91', 'IncoraÃ§Ã£o de imÃ³vel ao patrimÃ³nio da UniÃ£o', 'Solicita, em reiteraÃ§Ã£o ao OfÃ­cio nÂ° 419/2019. que informe se o imÃ³vel encontra-se devidamente incorporado ao patrimÃ´nio da UniÃ£o, sob tutela desta Secretaria e, caso positivo, que informe em que estÃ¡gio se encontra o processo e as tratativas para transferÃªncia do bem ao MunicÃ­pio de CriciÃºma, conforme anteriormente informado no RelatÃ³rio de Vistoria.', 'undefined', '2019-07-18 20:00:03', '2019-07-18 20:00:03'),
(747, 6, 1, '0077/2019-4', 'coordenadas geogrÃ¡ficas aproximadas de 26Â°19\"07.71\"S/ 48Â°48\"38.53\"0', 'undefined', 'undefined', '2019-07-19 21:20:33', '2019-07-19 21:20:33'),
(748, 3, 2, '5002734-82.2018.4.04.7201', 'AÃ‡ÃƒO DE NUNCIAÃ‡ÃƒO DE OBRA NOVA, Estrada CubatÃ£o, no Bairro CubatÃ£o, no MunicÃ­pio de Joinville/SC', 'undefined', '110271420318', '2019-07-19 21:46:12', '2019-07-19 21:46:12'),
(749, 3, 1, '5010311-11.2018.4.04.7202', 'UsucapiÃ£o', 'Manivest5aÃ§Ã£o de interesse', '788767438318', '2019-07-22 16:32:41', '2019-07-22 16:32:41'),
(753, 3, 4, '5002346-61.2013.4.04.7200', 'UsucapiÃ£o. RibeirÃ£o da Ilha , FlorianÃ³polis', 'undefined', 'undefined', '2019-07-22 17:04:14', '2019-07-22 17:04:14'),
(755, 3, 1, '0904029-52.2016.8.24.0038', 'Dano Ambiental. Joinville', 'undefined', 'undefined', '2019-07-22 17:25:41', '2019-07-22 17:25:41'),
(757, 3, 4, '5013080-61.2019.4.04.7200', 'Requer a a suspensÃ£o do ato administrativo (NotificaÃ§Ã£o n.5121910-SPU/SC) que determinou a demoliÃ§Ã£o de construÃ§Ã£o', 'undefined', '519459609319', '2019-07-22 20:00:59', '2019-07-22 20:00:59'),
(759, 7, 3, '0000884-71.2012.8.24.0064', 'DAU - CobrnaÃ§a RIP 83270000533-03', 'Na execuÃ§Ã£o fiscal n. 0000884-71.2012.8.24.0064 na qual estÃ¡ sendo cobrada a taxa de ocupaÃ§Ã£o dos perÃ­odos de 2007, 2008, 2009 e 2010 do imÃ³vel RIP 8327000053303 (processo administrativo 04972 601063/2011-11) o executado opÃ´s exceÃ§Ã£o de prÃ©-executividade alegando que efetuou o depÃ³sito dos valores dos dÃ©bitos no mandado de seguranÃ§a n. 2007.72.00.010312-4, os quais foram transformados em pagamento definitivo para a UniÃ£o.', 'undefined', '2019-07-22 20:16:51', '2019-07-22 20:16:51'),
(761, 3, 2, '5005697-13.2011.4.04.7200', 'Rua Rodovia  Baldissero  Filomeno ,  nÂ°  5731 , FlorianÃ³polis', 'undefined', '842807913211', '2019-07-22 20:25:35', '2019-07-22 20:25:35'),
(762, 7, 3, '5008428-69.2017.4.04.7200', 'Embargos Ã  ExecuÃ§Ã£o Fiscal', 'RIP 8327.0000374-56 \nExclusÃ£o da APP das cobranÃ§as', 'undefined', '2019-07-22 21:21:02', '2019-07-22 21:21:02'),
(763, 3, 4, '5014486-30.2018.4.04.7208', 'aÃ§Ã£o foi julgada procedente para  declarar a nulidade do processo de demarcaÃ§Ã£o das Ã¡reas de terreno de marinha e afastar a exigibilidade do laudÃªm', 'undefined', 'undefined', '2019-07-22 21:45:38', '2019-07-22 21:45:38'),
(765, 3, 2, '5012214-68.2015.4.04.7208', 'Cumprimento de SentenÃ§a Autos nÂº 2004.72.08.005173-0,', 'undefined', '725881333915', '2019-07-22 22:40:06', '2019-07-22 22:40:06'),
(766, 3, 4, '5016324-95.2019.4.04.7200', 'abertura de acesso a pedestres Ã  Praia da Caieira do Norte da ArmaÃ§Ã£o,Governador Celso Ramos', 'undefined', '251686444619', '2019-07-23 16:23:54', '2019-07-23 16:23:54'),
(768, 1, 1, '1.33.000.001245/2019-76', 'RequisiÃ§Ã£o de FiscalizaÃ§Ã£o', 'requisiÃ§Ã£o de fiscalizaÃ§Ã£o da construÃ§Ã£o da nova ponte sobre o Canal da Barra da Lagoa, nesta Capital/SC, em especial, para verificar a ocorrÃªncia de novos danos ambientais na Ã¡rea de preservaÃ§Ã£o permanente localizada sobre terreno de marinha.', 'undefined', '2019-07-23 16:28:42', '2019-07-23 16:28:42'),
(769, 3, 3, '5020936-23.2012.4.04.7200', 'ReintegraÃ§Ã£o de Posse. Av. Gov. Irineu Bornhausen,  nÂº 4972,  Bairro AgronÃ´mica, FlorianÃ³polis/SC', 'undefined', '166474395612', '2019-07-23 16:49:53', '2019-07-23 16:49:53'),
(771, 2, 3, '5020633-96.2018.4.04.7200', 'Dano Ambiental. Fazenda da ArmaÃ§Ã£o, no municÃ­pio de  Governador Celso Ramos', 'undefined', '218968275518', '2019-07-23 17:19:28', '2019-07-23 17:19:28'),
(772, 3, 4, '5014176-14.2019.4.04.7200', 'UsucapiÃ£o', 'undefined', 'undefined', '2019-07-23 19:00:26', '2019-07-23 19:00:26'),
(774, 2, 2, '5024801-78.2017.4.04.7200', 'cumprimento da decisÃ£o-ACP nÂº 2003.72.00.007539 - 1. cesso pÃºblico Ã s margens da Lagoa da ConceiÃ§Ã£o', 'undefined', 'undefined', '2019-07-23 19:40:08', '2019-07-23 19:40:08'),
(775, 2, 4, '5016328-35.2019.4.04.7200', 'Acesso Ã  praia da Caieira do Norte, Governador Celso Ramos', 'undefined', 'undefined', '2019-07-23 20:07:20', '2019-07-23 20:07:20'),
(777, 3, 4, '5016333-57.2019.4.04.7200', 'Acesso Ã  Praia da Caieira, Governador Celso Ramos', 'undefined', 'undefined', '2019-07-23 20:34:26', '2019-07-23 20:34:26'),
(778, 3, 4, '5016325-80.2019.4.04.7200', 'Acesso Ã  Praia da Caieira, Governador Celso Ramos', 'undefined', 'undefined', '2019-07-23 20:49:06', '2019-07-23 20:49:06'),
(779, 7, 4, '5012394-69.2019.4.04.7200', 'Embargos a ExecuÃ§Ã£o. RIP 8105.000240-08', 'undefined', 'undefined', '2019-07-23 21:16:16', '2019-07-23 21:16:16'),
(780, 7, 4, '5008277-23.2019.4.04.7204', 'DÃVIDA ATIVA', 'execuÃ§Ã£o fiscal movida pelo MUNICÃPIO DE TUBARÃƒO em face da Rede FerroviÃ¡ria\r\nFederal SA - RFFSA, sucedida pela UNIÃƒO, objetivando a cobranÃ§a de IPTU sobre o imÃ³vel descrito na CertidÃ£o de\r\nDÃ­vida Ativa anexa (seq. 3 - fls. 2).', 'undefined', '2019-07-24 16:09:17', '2019-07-24 16:09:17'),
(781, 3, 4, '5002066-71.2015.4.04.7216', 'PrescriÃ§Ã£o LaudÃªmio RIP: 8185.0100194-12', 'undefined', 'undefined', '2019-07-24 19:19:06', '2019-07-24 19:19:06'),
(782, 4, 1, '1.33.009.000087/2019-57', 'Dano Ambiental. Rua EugÃªnio Fantin, Bairro CibrazÃ©m, em Videira/SC', 'undefined', 'undefined', '2019-07-24 19:37:46', '2019-07-24 19:37:46'),
(783, 3, 4, '5000671-35.2019.4.04.7206', 'UsucapiÃ£o. PalhoÃ§a', 'undefined', '937974638319', '2019-07-24 20:09:17', '2019-07-24 20:09:17'),
(784, 1, 1, '1.33.007.000102/2019-87', 'Praia do Porto, no municÃ­pio de Imbituba', 'undefined', 'undefined', '2019-07-24 20:28:37', '2019-07-24 20:28:37'),
(785, 3, 4, '0003401-24.2012.8.24.0040', 'UsucapiÃ£o. Laguna', 'undefined', 'undefined', '2019-07-24 20:41:23', '2019-07-24 20:41:23'),
(786, 2, 2, '5002241-50.2019.4.04.7208', 'Reabertura da Estrada Ercelina Vieira, BalneÃ¡rio CamboriÃº', 'undefined', 'undefined', '2019-07-24 21:13:40', '2019-07-24 21:13:40'),
(787, 3, 4, '5016336-12.2019.4.04.7200', 'Acesso Ã  praia de Ponta dos Ganchos. Governador Celso Ramos', 'undefined', '110795347519', '2019-07-24 21:43:27', '2019-07-24 21:43:27'),
(788, 3, 4, '5016323-13.2019.4.04.7200', 'Acesso Ã  praia da ArmaÃ§Ã£o de Piedade, Governador Celso Ramos', 'undefined', '536190526319', '2019-07-24 22:09:12', '2019-07-24 22:09:12'),
(789, 3, 4, '5016322-28.2019.4.04.7200', 'Acesso Ã  Praia da ArmaÃ§Ã£o da Piedade', 'undefined', '425876302319', '2019-07-24 23:27:21', '2019-07-24 23:27:21'),
(790, 3, 4, '5016320-58.2019.4.04.7200', 'Acesso Ã  Praia da armaÃ§Ã£o da piedade, Governador Celso Ramos', 'undefined', 'undefined', '2019-07-24 23:44:55', '2019-07-24 23:44:55'),
(791, 3, 4, '5016327-50.2019.4.04.7200', 'Acesso Ã  praia da ArmaÃ§Ã£o da Piedade. Governador Celso Ramos', 'undefined', 'undefined', '2019-07-25 00:02:15', '2019-07-25 00:02:15'),
(792, 3, 4, '5016339-64.2019.4.04.7200', 'Acesso Ã  praia. Governador Celso Ramos', 'undefined', '963776982619', '2019-07-25 19:03:21', '2019-07-25 19:03:21'),
(794, 3, 4, '5016335-27.2019.4.04.7200', 'Acesso Ã  Praia, Governador Celso Ramos', 'undefined', '323833291519', '2019-07-25 19:11:27', '2019-07-25 19:11:27'),
(795, 3, 4, '5016330-05.2019.4.04.7200', 'Acesso Ã  praia. Governador Celso Ramos', 'undefined', '489366345219', '2019-07-25 19:29:26', '2019-07-25 19:29:26'),
(796, 2, 4, '5004821-12.2012.4.04.7204', 'Plataforma de Pesca de BalneÃ¡rio RincÃ£o, no municÃ­pio de IÃ§ara', 'undefined', 'undefined', '2019-07-25 20:34:12', '2019-07-25 20:34:12'),
(797, 1, 1, '1.33.007.000189/2019-92', 'ImÃ³veis construÃ­dos na Rua Manoel Ãlvaro de AraÃºjo, n. 193 (frente e fundos), municÃ­pio de Garopaba', 'undefined', 'undefined', '2019-07-25 20:58:01', '2019-07-25 20:58:01'),
(798, 3, 4, '5022161-78.2012.4.04.7200', 'ExpropriaÃ§Ã£o do Bem, Avenida Engenheiro Max de Souza, 680, Bairro Coqueiros, FlorianÃ³polis, RIP 8105.0000141-18', 'undefined', 'undefined', '2019-07-25 22:01:25', '2019-07-25 22:01:25'),
(799, 6, 1, '2019.0001385-SR/PF/SC', 'Verificar interferÃªncia da Ã¡rea com bens da UniÃ£o.', 'undefined', 'undefined', '2019-07-26 15:37:29', '2019-07-26 15:37:29'),
(800, 6, 1, '2019.0001386-SR/PF/SC', 'verificaÃ§Ã£o de interferÃªncia da Ã¡rea com bens da UniÃ£o.', 'undefined', 'undefined', '2019-07-26 15:44:35', '2019-07-26 15:44:35'),
(801, 2, 4, '5021655-97.2015.4.04.7200', 'Dano Ambiental. Rodovia Baldicero Filomeno, 15.126, FlorianÃ³polis', 'undefined', 'undefined', '2019-07-29 19:55:22', '2019-07-29 19:55:22'),
(802, 3, 3, '5017521-90.2016.4.04.7200', 'entrega de dados cadastrais de contribuintes ocupantes de terreno de marinha na Ilha de Santa Catarina, FlorianÃ³polis', 'undefined', 'undefined', '2019-07-29 20:19:38', '2019-07-29 20:19:38'),
(803, 3, 4, '0301106-63.2017.8.24.0072', 'UsucapiÃ£o. Canelinha', 'undefined', 'undefined', '2019-07-29 20:54:15', '2019-07-29 20:54:15'),
(804, 2, 4, '5021445-80.2014.4.04.7200', 'Ranchos de Pesca - FlorianÃ³polis Bloco 7', 'DemoliÃ§Ã£o ou regularizaÃ§Ã£o de Ranchos de Pesca', '488437036614', '2019-07-29 21:27:32', '2019-07-29 21:27:32'),
(805, 3, 4, '5016334-42.2019.4.04.7200', 'Acesso Ã  praia, Governador Celso Ramos', 'undefined', 'undefined', '2019-07-29 21:28:45', '2019-07-29 21:28:45'),
(807, 1, 1, '1.33.007.000195/2019-40', 'Dano Ambiental, Rua Geral da gamboa, Garopaba', 'undefined', 'undefined', '2019-07-29 21:59:15', '2019-07-29 21:59:15'),
(808, 3, 1, '0301655-03.2019.8.24.0008', 'Regularidade Cadastral', 'Solicita informaÃ§Ãµes sobre a situaÃ§Ã£o do imÃ³vel de matricula n. 42.706, registrado no Oficio de Registro de ImÃ³veis da Comarca de BalneÃ¡rio PiÃ§arras', 'undefined', '2019-07-30 15:35:12', '2019-07-30 15:35:12'),
(809, 6, 1, '2019.0001384', 'Regularidade Cadastral', 'Verificar interferÃªncia com bens da UniÃ£o', 'undefined', '2019-07-30 15:46:14', '2019-07-30 15:46:14'),
(810, 6, 1, '2019.0001383', 'Regularidade Cadastral', 'Verificar se o imÃ³vel estÃ¡ inserido em Ã¡rea de marinha e seus acrescidos.', 'undefined', '2019-07-30 16:13:15', '2019-07-30 16:13:15'),
(811, 3, 4, '0001584-90.2011.8.24.0061', 'UsucapiÃ£o. SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-07-30 19:48:27', '2019-07-30 19:48:27'),
(813, 9, 4, '5016764-91.2019.4.04.7200', 'ConclusÃ£o da AnÃ¡lise de Requerimento de IncriÃ§Ã£o de OcupaÃ§Ã£o - Avenida AntÃ´nio Joaquim Tavares, S/N, ArmaÃ§Ã£o, 88385-000, no MunicÃ­pio de Penha/SC', 'ConclusÃ£o da AnÃ¡lise de Requerimento de IncriÃ§Ã£o de OcupaÃ§Ã£o - Avenida AntÃ´nio Joaquim Tavares, S/N, ArmaÃ§Ã£o, 88385-000, no MunicÃ­pio de Penha/SC', '306848779819', '2019-07-30 20:24:30', '2019-07-30 20:24:30'),
(814, 3, 4, '5014229-89.2019.4.04.7201', 'Duplicidade de CobranÃ§a. RIP  8179 0001448-80 E  8179 0002357-62', 'undefined', '994756070219', '2019-07-30 20:49:12', '2019-07-30 20:49:12'),
(815, 3, 4, '5002680-64.2019.4.04.7207', 'UsucapiÃ£o. TubarÃ£o', 'undefined', '636841889319', '2019-07-30 21:06:19', '2019-07-30 21:06:19'),
(816, 3, 4, '5000471-14.2017.4.04.7201', 'UsucapiÃ£o. Joinville', 'undefined', 'undefined', '2019-07-31 22:11:11', '2019-07-31 22:11:11'),
(818, 3, 4, '5013899-05.2013.4.04.7201', 'UsucapiÃ£o. Araquari', 'undefined', '837360691313', '2019-07-31 22:51:34', '2019-07-31 22:51:34'),
(819, 3, 4, '5004328-08.2016.4.04.7200', 'MajoraÃ§Ã£o da taxa de ocupaÃ§Ã£o. RIP 8327.0000002-93', 'undefined', 'undefined', '2019-08-01 19:11:11', '2019-08-01 19:11:11'),
(820, 3, 4, '5002707-54.2018.4.04.7216', 'UsucapiÃ£o. Imbituba', 'undefined', 'undefined', '2019-08-01 19:35:37', '2019-08-01 19:35:37'),
(822, 2, 2, '5001529-80.2012.4.04.7216', 'Praia da Galheta. Laguna/SC', 'undefined', '517624411512', '2019-08-01 20:26:00', '2019-08-01 20:26:00'),
(823, 6, 1, '078/2019-4', 'InvasÃ£o - Rua Wendelim Metzger, entre as Ruas Oscar de Castilho e EuzÃ©bio Piermann, bairro ~cÃ­lio Dias, municÃ­pio de Canoinhas/SC', 'InvasÃ£o - Rua Wendelim Metzger, entre as Ruas Oscar de Castilho e EuzÃ©bio Piermann, bairro ~cÃ­lio Dias, municÃ­pio de Canoinhas/SC', 'undefined', '2019-08-02 15:42:23', '2019-08-02 15:42:23'),
(824, 7, 3, '5031720-63.2015.4.04.7100', 'Embargos Ã  ExecuÃ§Ã£o', 'Alega-se que nÃ£o hÃ¡ valor em imÃ³vel inserido em APP.\nImÃ³vel em Ponta das Canas - FlorianÃ³polis/SC\nJuiz determinou produÃ§Ã£o de prova pericial.', 'undefined', '2019-08-02 15:52:20', '2019-08-02 15:52:20'),
(825, 1, 1, '1.33.001.000431/2016-35', 'RequisiÃ§Ã£o de InformaÃ§Ãµes', 'requisita que informe quais os procedimentos administrativos que tramitam nesta Secretaria acerca de edificaÃ§Ãµes irregulares em terrenos de marinha Ã s margens do Rio ItajaÃ­-AÃ§u no municÃ­pio de Blumenau, nos termos do OfÃ­cio nÂ° 175/2018 anexo.', 'undefined', '2019-08-02 19:38:54', '2019-08-02 19:38:54'),
(826, 3, 4, '5002154-51.2011.4.04.7216', 'MajoraÃ§Ã£o da Taxa de OcupaÃ§Ã£o- RIP 8113.0000168-80', 'undefined', '744700334419', '2019-08-05 18:57:50', '2019-08-05 18:57:50'),
(827, 1, 1, '1.33.007.000030/2019-78', 'Cabo de Santa Marta, municÃ­pio de Laguna', 'undefined', 'undefined', '2019-08-05 20:26:56', '2019-08-05 20:26:56'),
(828, 1, 1, '1.33.007.000305/2018-92', 'Praia do Luz. Imbituba', 'undefined', 'undefined', '2019-08-05 20:46:28', '2019-08-05 20:46:28'),
(829, 6, 1, '1.33.007.000259/2018-21', 'Mercado PÃºblico. ImaruÃ­', 'undefined', 'undefined', '2019-08-05 21:07:34', '2019-08-05 21:07:34'),
(831, 1, 1, '1.33.007.000243/2017-38', 'LAGOA SANTO ANTÃ“NIO. MUNICÃPIO DE LAGUNA/SC', 'undefined', 'undefined', '2019-08-06 21:23:56', '2019-08-06 21:23:56'),
(832, 3, 4, '5009857-88.2019.4.04.7204', 'AdjudicaÃ§Ã£o CompulsÃ³ria, RFFSSA, CriciÃºma', 'undefined', '93296055221', '2019-08-06 21:55:31', '2019-08-06 21:55:31'),
(833, 2, 2, '5000407-90.2011.4.04.7208', 'MARINA BEACH TOWER, MUNICÃPIO DE BALNEÃRIO CAMBORIÃš/SC', 'undefined', '88941405931', '2019-08-06 22:18:09', '2019-08-06 22:18:09'),
(834, 3, 4, '5011519-41.2015.4.04.7200', 'UsucapiÃ£o. ServidÃ£o Caranguejo, Canasvieiras, FlorianÃ³polis', 'undefined', '646683126515', '2019-08-07 17:39:42', '2019-08-07 17:39:42'),
(835, 3, 4, '0002793-97.2012.8.24.0081', 'UsucapiÃ£o. XAXIM', 'undefined', 'undefined', '2019-08-07 19:09:55', '2019-08-07 19:09:55'),
(836, 3, 4, '5006211-95.2018.4.04.7207/SC', 'TransferÃªncia de ocupaÃ§Ã£o e nulidade das cobranÃ§as - RIP 81850100485-10', 'TransferÃªncia de OcupaÃ§Ã£o - Ocupante falecido - Nulidade das cobranÃ§as apÃ³s o falecimento', 'undefined', '2019-08-07 20:05:44', '2019-08-07 20:05:44'),
(837, 3, 4, '5002050-39.2018.4.04.7208', 'RIP 8030.04885.000-3', 'undefined', '429058434618', '2019-08-07 20:39:03', '2019-08-07 20:39:03'),
(839, 3, 4, '5002748-14.2019.4.04.7207', 'UsucapiÃ£o. Praia Redonda, TubarÃ£o', 'undefined', '645941944619', '2019-08-07 20:59:04', '2019-08-07 20:59:04'),
(842, 2, 3, '5007201-49.2019.4.04.7208', 'demoliÃ§Ã£o de obra e Ã  completa recuperaÃ§Ã£o  (APP) ,margens do rio Passa Vinte, municÃ­pio de Bombinhas/SC', 'undefined', '868596139419', '2019-08-07 22:14:26', '2019-08-07 22:14:26'),
(843, 2, 3, '5026412-71.2014.4.04.7200', 'RegularizaÃ§Ã£o das margens do rio Furadinho e manguezal , Praia do Pontal, em PalhoÃ§a.', 'undefined', '454525743314', '2019-08-07 22:42:47', '2019-08-07 22:42:47'),
(844, 1, 1, '1.33.007.000199/2015-05', 'Lagoa de Ibiraquera, Imbituba', 'undefined', 'undefined', '2019-08-08 20:13:52', '2019-08-08 20:13:52'),
(846, 3, 4, '5008316-54.2018.4.04.7204', 'UsucapiÃ£o. SÃ£o JoÃ£o do Sul', 'undefined', '583301557718', '2019-08-08 20:33:08', '2019-08-08 20:33:08'),
(847, 2, 3, '5005474-11.2012.4.04.7205', 'Dano Ambiental. Ilhota.', 'undefined', 'undefined', '2019-08-08 21:39:57', '2019-08-08 21:39:57'),
(848, 2, 1, '5007007-49.2019.4.04.7208', 'Zona de Amortecimento do Parque Nacional da Serra do ItajaÃ­', 'undefined', '812754452019', '2019-08-08 22:15:23', '2019-08-08 22:15:23'),
(849, 3, 2, '0017223-38.2011.8.24.0033', 'TransferÃªncia de ocupaÃ§Ã£o.', 'Solicita informaÃ§Ãµes sobre os procedimentos adotados pela SPU/SC.', 'undefined', '2019-08-09 17:03:06', '2019-08-09 17:03:06'),
(850, 2, 1, '5007006-64.2019.4.04.7208', 'Zona de Amortecimento do Parque Nacional da Serra do ItajaÃ­', 'undefined', 'undefined', '2019-08-09 17:22:21', '2019-08-09 17:22:21'),
(851, 2, 4, '5005918-46.2018.4.04.720', 'Quadra 08, lote 02, no bairro BalneÃ¡rio SaÃ­-Mirim, em ItapoÃ¡', 'undefined', '129618740118', '2019-08-09 19:21:22', '2019-08-09 19:21:22'),
(852, 3, 4, '5004523-32.2012.4.04.7200', 'UsucapiÃ£o. Carlos Salles, n. 130, Campeche, FlorianÃ³polis', 'undefined', 'undefined', '2019-08-09 19:42:50', '2019-08-09 19:42:50'),
(853, 1, 1, '1.33.015.000017/2015-96', 'InvasÃ£o de terras da UniÃ£o no Distrito de MarcÃ­lio Dias, no municÃ­pio de Canoinhas/SC', 'undefined', 'undefined', '2019-08-12 17:13:43', '2019-08-12 17:13:43'),
(854, 3, 2, '5000094-36.2019.8.24.0038', 'RevogaÃ§Ã£o/AnulaÃ§Ã£o de multa ambiental, Joinville', 'undefined', '720832143519', '2019-08-13 20:55:59', '2019-08-13 20:55:59'),
(855, 7, 4, '5011551-07.2019.4.04.7200', 'Taxa de Coleta de ResÃ­duos SÃ³lidos', 'undefined', 'undefined', '2019-08-14 22:12:33', '2019-08-14 22:12:33'),
(856, 4, 1, '1.33.009.000082/2019-24', 'Regularidade cadastral', 'Envolve Ã¡rea da extinta Rede FerroviÃ¡ria S/A - Cidade de Videira/SC.', 'undefined', '2019-08-15 15:30:24', '2019-08-15 15:30:24'),
(858, 3, 1, '0304501-97.2019.8.24.0038', 'DemoliÃ§Ã£o, Bairro IririÃº, Joinville', 'undefined', 'undefined', '2019-08-15 16:31:45', '2019-08-15 16:31:45'),
(859, 2, 2, '5006688-76.2017.4.04.7200', 'Rodovia   SC- 401, nÂ° 14.889, Vargem Pequena, FlorianÃ³polis', 'undefined', 'undefined', '2019-08-15 20:22:45', '2019-08-15 20:22:45'),
(860, 3, 4, '5005265-13.2019.4.04.7200', 'ReintegraÃ§Ã£o de Posse. BalneÃ¡rio CamboriÃº', 'undefined', 'undefined', '2019-08-15 21:28:04', '2019-08-15 21:28:04'),
(861, 2, 4, '5000295-97.2011.4.04.7216', 'Praia da Barra, Garopaba', 'SentenÃ§a que JULGOU PROCEDENTE o pedido contido na inicial, para CONDENAR a rÃ© UNIÃƒO Ã  obrigaÃ§Ã£o de fazer atravÃ©s de regular processo administrativo, no prazo de 90 dias, a efetiva preservaÃ§Ã£o das Ã¡reas ocupadas ou nÃ£o, com a demarcaÃ§Ã£o das mesmas, cadastramento e fiscalizaÃ§Ã£o, por intermÃ©dio da SPU/SC, sobre todos os imÃ³veis localizados em terrenos de marinha e acrescidos, abrangidos na Ã¡rea PRAIA DA BARRA, GAROPABA/SC, sob pena de fixaÃ§Ã£o de multa diÃ¡ria de R$ 500,00 (quinhentos reais) para o caso de descumprimento, sem prejuÃ­zo da verificaÃ§Ã£o das sanÃ§Ãµes cÃ­veis e criminais no caso.', 'undefined', '2019-08-19 16:19:09', '2019-08-19 16:19:09'),
(862, 3, 3, '5012042-48.2018.4.04.7200', 'Trapiche,  Rodovia Gilson da Costa Xavier, n. 1546, Bairro Sambaqui, FlorianÃ³polis', 'undefined', 'undefined', '2019-08-19 16:51:07', '2019-08-19 16:51:07'),
(865, 3, 4, '5016337-94.2019.4.04.7200', 'abertura de acesso a pedestres Ã  Praia do Antenor,Governador Celso Ramos', 'undefined', '769846069419', '2019-08-19 17:22:26', '2019-08-19 17:22:26'),
(866, 3, 1, '5016329-20.2019.4.04.7200', 'Acesso Ã  Praia Canto dos Ganchos, Governador Celso Ramos', 'undefined', '806261395519', '2019-08-19 19:36:02', '2019-08-19 19:36:02'),
(867, 9, 4, '5017863-96.2019.4.04.7200', 'Multa de TransferÃªncia. RIP 8161.0000738-16', 'undefined', '497389674719', '2019-08-19 20:06:11', '2019-08-19 20:06:11'),
(868, 3, 4, '5016319-73.2019.4.04.7200', 'Acesso Ã  praia da costeira da armaÃ§Ã£o, Governador Celso Ramos', 'undefined', '934681372819', '2019-08-19 20:19:13', '2019-08-19 20:19:13'),
(869, 2, 3, '5006484-32.2017.404.7200', 'Rua Laurindo JanuÃ¡rio da Silveira nÂº 2.391, Lagoa da ConceiÃ§Ã£o, no MunicÃ­pio de FlorianÃ³polis/SC', 'undefined', 'undefined', '2019-08-19 20:43:34', '2019-08-19 20:43:34'),
(870, 3, 4, '5016744-37.2018.4.04.7200', 'INDENIZAÃ‡ÃƒO POR DANOS MORAIS', 'undefined', '439265829118', '2019-08-19 21:17:45', '2019-08-19 21:17:45'),
(871, 2, 4, '5005091-40.2015.4.04.7201', 'Dano Ambiental. SÃ£o Francisco do Sul', 'undefined', 'undefined', '2019-08-20 16:09:01', '2019-08-20 16:09:01'),
(872, 2, 3, '5009477-24.2017.4.04.7208', 'Dano Ambiental, Rua SebastiÃ£o FelÃ­cio de Melo, edifÃ­cio Sea Sky, Av. AtÃ­lio Fontana, 2.085, bairro PerequÃª, Porto Belo/SC', 'undefined', '669106633717', '2019-08-20 20:02:29', '2019-08-20 20:02:29'),
(873, 2, 3, '5007068-02.2017.4.04.7200', 'Dano Ambiental. Lagoa da ConceiÃ§Ã£o', 'undefined', '624333917117', '2019-08-20 20:14:58', '2019-08-20 20:14:58'),
(874, 3, 1, '0311786-31.2015.8.24.0023', 'Verificar interferÃªncia com bens da UniÃ£o.', 'undefined', 'undefined', '2019-08-21 19:44:59', '2019-08-21 19:44:59'),
(875, 1, 1, '1.33.005.000676/2017-1', 'Verificar interferÃªncia em bens da UniÃ£o', 'undefined', 'undefined', '2019-08-21 19:58:57', '2019-08-21 19:58:57'),
(876, 3, 4, '5014319-81.2016.4.04.7208', 'UsucapiÃ£o. Tijucas.', 'undefined', '726793866816)', '2019-08-21 20:52:51', '2019-08-21 20:52:51'),
(877, 1, 1, '1.33.007.000211/2019-02', 'Garopaba do Sul, no municÃ­pio de Jaguaruna', 'undefined', 'undefined', '2019-08-22 16:51:51', '2019-08-22 16:51:51'),
(878, 2, 3, '5003740-50.2011.4.04.7208', 'Dano Ambiental, Bairro  GravatÃ¡,  MunicÃ­pio  de  Penha', 'undefined', 'undefined', '2019-08-22 20:37:26', '2019-08-22 20:37:26'),
(879, 3, 4, '5015489-07.2019.4.04.7201', 'Nulidade de Processo DemarcatÃ³rio. ap 102  Ed.AzÃ¡lea,  rua  EugÃªnio Moreira,  153,  bairro  Anita  Garibaldi,  Joinville', 'undefined', '107883048719', '2019-08-22 22:00:22', '2019-08-22 22:00:22'),
(880, 3, 4, '5022481-55.2017.4.04.7200', 'UsucapiÃ£o. Rua Canoas, nÂº 32 , no bairro Rio Grande, MunicÃ­pio de PalhoÃ§a', 'undefined', '705552804017', '2019-08-23 20:44:23', '2019-08-23 20:44:23'),
(882, 2, 2, '5007067-85.2015.4.04.7200', 'Dano Ambiental. Passagem do Maciambu.', 'undefined', '954392704615', '2019-08-23 21:03:17', '2019-08-23 21:03:17'),
(883, 3, 1, '0022575-23.2009.8.24.0008', 'InformaÃ§Ãµes sobre dÃ©bitos do RIP 8265.0100005-94', 'undefined', 'undefined', '2019-08-23 21:37:11', '2019-08-23 21:37:11'),
(885, 3, 4, '5019530-88.2017.4.04.7200', 'LaudÃªmio. RIP 8105 0103863-79,  8105 0103962-50, 8105 0103963-31, 8105 0103964-12, 8105 0103965-01, RIP n. 8105 0104197-2', 'undefined', '565608996317', '2019-08-23 22:09:04', '2019-08-23 22:09:04'),
(886, 2, 1, '5007005-79.2019.4.04.7208', 'Parque Nacional da Serra do ItajaÃ­/SC', 'undefined', '925724626219', '2019-08-26 19:13:56', '2019-08-26 19:13:56'),
(887, 3, 2, '5000983-20.2015.4.04.7216', 'Nulidade de ato jurÃ­dico. Laguna.', 'undefined', '431355380415', '2019-08-26 19:56:59', '2019-08-26 19:56:59'),
(888, 2, 1, '5007004-94.2019.4.04.7208', 'Zona de amortecimento do Parque Nacional da Serra do ItajaÃ­', 'undefined', 'undefined', '2019-08-26 20:22:23', '2019-08-26 20:22:23'),
(890, 2, 1, '5003788-46.2019.4.04.7202', 'Dano Ambiental. Alto Capinzal, interior do MunicÃ­pio de ChapecÃ³', 'undefined', '576412040819', '2019-08-26 20:43:04', '2019-08-26 20:43:04'),
(894, 3, 4, '5003587-54.2019.4.04.7202', 'UsucapiÃ£o. Avenida  Doutor  JosÃ©  leal  Filho,  municÃ­pio  de  Sul  Brasil', 'undefined', '156281265219', '2019-08-27 16:06:11', '2019-08-27 16:06:11'),
(896, 1, 1, '1.33.007.000230/2019-21', 'Rancho de pesca. Garopaba (coordenadas UTM 22J 74868 / 6895672)', 'undefined', 'undefined', '2019-08-27 16:23:23', '2019-08-27 16:23:23'),
(897, 3, 1, '0000439-69.2000.8.24.0033', 'InventÃ¡rio. Campo Grande, Bombinhas', 'undefined', 'undefined', '2019-08-27 19:40:25', '2019-08-27 19:40:25'),
(898, 9, 4, '5015883-17.2019.4.04.7200', 'Mandado de SeguranÃ§a constra Multa de TransferÃªncia', 'mandado de seguranÃ§a contra ato atribuÃ­do ao SUPERINTENDENTE DA SECRETARIA DO PATRIMÃ”NIO DA UNIÃƒO EM FLORIANÃ“POLIS, por meio da qual pretende a declaraÃ§Ã£o de inexigibilidade de sanÃ§Ã£o que lhe foi imposta pela Secretaria do PatrimÃ´nio da UniÃ£o - SPU. - Multa de transferÃªncia - terreno de marinha registrado na Secretaria de PatrimÃ´nio da UniÃ£o (SPU) sob o n. 8265000002179 - Porto Belo - SC', '992354980919', '2019-08-27 19:56:30', '2019-08-27 19:56:30'),
(899, 3, 1, '0318887-69.2018.8.24.0038', 'DemoliÃ§Ã£o de ImÃ³vel. Bairro FÃ¡tima, Joinville', 'undefined', 'undefined', '2019-08-27 20:12:09', '2019-08-27 20:12:09'),
(900, 3, 4, '2008.72.08.002234-5', 'Inexigibilidade de LaudÃªmio.', 'undefined', 'undefined', '2019-08-27 20:44:07', '2019-08-27 20:44:07'),
(903, 3, 1, '0000439-69.2000.8.24.0033-0040', 'AÃ§Ã£o de InventÃ¡rio - AcÃ¡cio CristÃ³vÃ£o Pereira', NULL, 'undefined', '2019-08-28 16:03:28', '2019-08-28 16:04:31'),
(904, 1, 1, '1.33.007.000069/2017-23', 'Praia do Sol, em Laguna/SC', 'undefined', 'undefined', '2019-08-28 19:22:30', '2019-08-28 19:22:30'),
(905, 2, 2, '5003976-89.2017.4.04.7208', 'Dano Ambiental. Itapema', 'undefined', '427579101517', '2019-08-28 19:38:44', '2019-08-28 19:38:44'),
(906, 2, 1, '5017348-61.2019.4.04.7200', 'Dano Ambiental. PalhoÃ§a', 'undefined', 'undefined', '2019-08-28 20:31:48', '2019-08-28 20:31:48'),
(907, 1, 1, '1.33.007.000080/2014-41', 'TRAPICHE NA LAGOA DO MIRIM. LOCALIDADE DE TAMBORETE. MUNICÃPIO DE IMARUÃ/SC', 'undefined', 'undefined', '2019-08-28 20:46:22', '2019-08-28 20:46:22'),
(908, 1, 1, '1.33.001.000183/2017-11', 'Reitera o OfÃ­cio nÂº 837/2018', 'Requisita informaÃ§Ãµes quanto Ã  previsÃ£o para adoÃ§Ã£o das medidas necessÃ¡rias ao cumprimento da norma prevista no Art. 22-A, da Lei 9.636/98 na rua Tocantins, nÂº 56, Centro, Blumenau/SC.', 'undefined', '2019-08-29 15:43:33', '2019-08-29 15:43:33'),
(909, 3, 4, '5002156-79.2010.4.04.7208â€‹', 'Nulidade da demarcaÃ§Ã£o - Inexigibilidade de laudÃªmio.', 'undefined', 'undefined', '2019-08-29 16:17:55', '2019-08-29 16:17:55'),
(910, 3, 4, '5006176-22.2019.4.04.7201', 'Nulidade Processo de DemarcaÃ§Ã£o. Joinville', 'undefined', 'undefined', '2019-08-29 18:54:59', '2019-08-29 18:54:59'),
(911, 2, 4, '5012500-02.2017.4.04.7200', 'Danos Ambientais.PÃ¢ntano do Sul, em FlorianÃ³polis/SC', 'undefined', '630611915917', '2019-08-29 19:38:13', '2019-08-29 19:38:13'),
(912, 3, 2, '5000385-46.2017.404.7208', 'ReintegraÃ§Ã£o de posse â€“ BiguaÃ§u/SC', 'undefined', 'undefined', '2019-08-29 19:59:16', '2019-08-29 19:59:16'),
(913, 2, 3, '5006476-55.2017.4.04.7200', 'Dano Ambiental. Lagoa da ConceiÃ§Ã£o', 'undefined', '108701690217', '2019-08-29 20:05:59', '2019-08-29 20:05:59'),
(914, 2, 3, '5009838-36.2015.4.04.7200', 'Bar do Deca, Praia Mole, FlorianÃ³polis', 'undefined', 'undefined', '2019-08-29 20:49:15', '2019-08-29 20:49:15'),
(915, 2, 2, '5009584-29.2016.4.04.7200', 'Dano Ambiental, Enseada de Brito, PalhoÃ§a', 'undefined', 'undefined', '2019-08-29 20:56:37', '2019-08-29 20:56:37'),
(916, 3, 1, '0314682-42.2018.8.24.0023', 'ReintegraÃ§Ã£o de Posse.', 'undefined', 'undefined', '2019-08-29 22:16:14', '2019-08-29 22:16:14'),
(917, 2, 3, '5027066-58.2014.4.04.7200', 'Dano ambiental', 'undefined', 'undefined', '2019-08-30 19:45:59', '2019-08-30 19:45:59'),
(918, 3, 4, '5011573-12.2017.4.04.7208', 'DesapropriaÃ§Ã£o. Navegantes', 'undefined', '581921686217', '2019-08-30 20:43:12', '2019-08-30 20:43:12'),
(919, 3, 4, '5017600-98.2018.8.24.0045', 'UsucapiÃ£o. Pinheira, PalhoÃ§a', 'undefined', 'undefined', '2019-08-30 21:30:52', '2019-08-30 21:30:52'),
(920, 9, 4, '5019734-64.2019.4.04.7200', 'Taxa de ocupaÃ§Ã£o - interessado Carlos Rodolfo Schneider', 'Taxa de ocupaÃ§Ã£o - interessado Carlos Rodolfo Schneider', '426339706419', '2019-09-02 17:02:48', '2019-09-02 17:02:48'),
(921, 2, 1, '5014215-16.2016.4.04.7200', 'AnÃ¡lise de Laudo Complementar que trata de tratamento de esgoto na Bacia do Itacorubi - FlorianÃ³polis/SC', 'AnÃ¡lise de Laudo Complementar que trata de tratamento de esgoto na Bacia do Itacorubi - FlorianÃ³polis/SC', '603907021516', '2019-09-02 19:58:07', '2019-09-02 19:58:07'),
(922, 2, 3, '5006423-74.2017.4.04.7200', 'Dano Ambiental. Lagoa da ConceiÃ§Ã£o, FlorianÃ³polis', 'undefined', 'undefined', '2019-09-02 21:45:37', '2019-09-02 21:45:37');
INSERT INTO `procedimentoexterno` (`id`, `idTipoProcedimentoExterno`, `idPoloProcedimentoExterno`, `procedimento`, `resumo`, `descricao`, `chave`, `created_at`, `updated_at`) VALUES
(923, 9, 4, '5001894-90.2019.4.04.7216', 'determinar Ã  autoridade coatora que proceda Ã  conclusÃ£o da anÃ¡lise do pedido de ocupaÃ§Ã£o, referente ao processo n. 04972.005344/2014-82, no prazo de a', 'determinar Ã  autoridade coatora\r\nque proceda Ã  conclusÃ£o da anÃ¡lise do pedido de ocupaÃ§Ã£o, referente ao processo n.\r\n04972.005344/2014-82, no prazo de atÃ© 30 dias, sob pena de multa diÃ¡ria de R$ 1.000,00\r\n(mil reais).', '324816376719', '2019-09-02 22:26:33', '2019-09-02 22:26:33'),
(924, 2, 1, '5005136-02.2019.4.04.7202', 'Dano Ambiental, Rio  Uruguai,  no MunicÃ­pio de MondaÃ­/SC', 'undefined', 'undefined', '2019-09-02 22:46:47', '2019-09-02 22:46:47'),
(925, 3, 1, '0301905-72.2016.8.24.0030', 'UsucapiÃ£o', 'informar se hÃ¡ interferÃªncia do imÃ³vel usucapiendo com patrimÃ´nio da UniÃ£o', 'undefined', '2019-09-03 19:43:09', '2019-09-03 19:43:09'),
(927, 3, 4, '5002124-35.2019.4.04.7216', 'UsucapiÃ£o,  Rua JosÃ© Costa Pereira, nÂº. 359, Portinho, Laguna/SC', 'undefined', 'undefined', '2019-09-03 19:52:49', '2019-09-03 19:52:49'),
(928, 4, 1, '1.33.000.001626/2019-55', 'undefined', 'InformaÃ§Ãµes atualizadas sobre a regularidade do estabelecimento Marina Santo Antonio, situada na Rodovia Gilson da Costa Xavier n. 21, Sambaqui, FlorianÃ³polis/SC (S 27Â° 30 387, W 048Â° 31 314), no tocante ao uso da orla de praia.', 'undefined', '2019-09-03 20:12:19', '2019-09-03 20:12:19'),
(929, 3, 4, '5015224-78.2014.4.04.7201', 'Nulidade do Processo de DemarcaÃ§Ã£o. RIP 8179.0100037-59', 'undefined', 'undefined', '2019-09-03 20:30:32', '2019-09-03 20:30:32'),
(930, 6, 1, '92.19.00107', 'Rua Senador Rodrigo Lobo, 2379, Bairro IririÃº, Joinville', 'undefined', 'undefined', '2019-09-03 21:36:00', '2019-09-03 21:36:00'),
(931, 2, 4, '5002117-96.2016.4.04.7200', 'ACP dano ambiental Praia da ArmaÃ§Ã£o', 'A AGU estÃ¡ solicitando, por meio do OfÃ­cio 58/2019, informaÃ§Ãµes atualizadas quanto Ã  ACP 50021179620164047200, que versa sobre  a degradaÃ§Ã£o ambiental em Ã¡rea de terrenos de marinha e de preservaÃ§Ã£o permanente no Bairro da ArmaÃ§Ã£o (ServidÃ£o EugÃªnio Amaro Duarte) - NUP SEI-ME 04972.001858/2016-21. Prazo 05/09/2019.', '946888041716', '2019-09-03 21:50:20', '2019-09-03 21:50:20'),
(932, 6, 1, '0014917-03.2019.8.24.0038', 'Rua ConstÃ¢ncio Visentainer, 1171, Bairro Aventureiro, Joinville', 'undefined', 'undefined', '2019-09-04 20:20:58', '2019-09-04 20:20:58'),
(933, 1, 1, '1.33.005.000660/2018-81', 'CesÃ£o de imÃ³vel - Horto Florestal Flor de Lay - Araquari/SC', 'undefined', 'undefined', '2019-09-04 20:52:19', '2019-09-04 20:52:19'),
(934, 3, 1, '030416-89.2018.8.24.0010', 'UsucapiÃ£o - Lucia Pacheco', 'Objetivando oportunizar a defesa dos interesses da UniÃ£o na AÃ§Ã£o de UsucapiÃ£o relacionada solicito que essa SuperintendÃªncia informe, atÃ© o dia 14/10/2019, se hÃ¡ interferÃªncia do imÃ³vel usucapiendo em Ã¡rea de domÃ­nio pÃºblico federal.', 'undefined', '2019-09-04 21:38:33', '2019-09-04 21:38:33'),
(938, 3, 4, '0300416-89.2018.8.24.0010', 'UsucapiÃ£o - Lucia Pacheco', 'Informar se hÃ¡ interferÃªncia do imÃ³vel usucapiendo em Ã¡rea de domÃ­nio pÃºblico federal. Prazo: 14/10/2019', 'undefined', '2019-09-04 21:42:01', '2019-09-04 21:42:01');

-- --------------------------------------------------------

--
-- Estrutura da tabela `situacaodemanda`
--

CREATE TABLE `situacaodemanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `situacao` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `situacaodemanda`
--

INSERT INTO `situacaodemanda` (`id`, `situacao`, `created_at`, `updated_at`) VALUES
(1, 'Nova', NULL, NULL),
(2, 'Em anÃ¡lise', NULL, NULL),
(3, 'Resolvida', NULL, NULL),
(4, 'Cancelada', NULL, NULL),
(5, 'Pronta', NULL, NULL),
(6, 'Aguardando assinatura', NULL, NULL),
(7, 'Aguardando AR', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipodocumento` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `tipodocumento`
--

INSERT INTO `tipodocumento` (`id`, `tipodocumento`, `created_at`, `updated_at`) VALUES
(1, 'OfÃ­cio', NULL, NULL),
(2, 'E-mail', NULL, NULL),
(3, 'Memorando', NULL, NULL),
(4, 'OfÃ­cio', NULL, NULL),
(5, 'Carta', NULL, NULL),
(6, 'Outros', NULL, NULL),
(7, 'RecomendaÃ§Ã£o', NULL, NULL),
(8, 'Mandado de NotificaÃ§Ã£o', NULL, NULL),
(9, 'Mandado de IntimaÃ§Ã£o', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipoprocedimentoexterno`
--

CREATE TABLE `tipoprocedimentoexterno` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipoprocedimento` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `tipoprocedimentoexterno`
--

INSERT INTO `tipoprocedimentoexterno` (`id`, `tipoprocedimento`, `created_at`, `updated_at`) VALUES
(1, 'InquÃ©rito Civil', NULL, NULL),
(2, 'AÃ§Ã£o Civil PÃºblica', NULL, NULL),
(3, 'Processo Judicial', NULL, NULL),
(4, 'NotÃ­cia de Fato', NULL, NULL),
(5, 'Procedimento MPSC', NULL, NULL),
(6, 'InquÃ©rito Policial', NULL, NULL),
(7, 'ExecuÃ§Ã£o Fiscal', NULL, NULL),
(8, 'Outros', NULL, NULL),
(9, 'Mandado de SeguranÃ§a', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipoprocesso`
--

CREATE TABLE `tipoprocesso` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descricao` char(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `telefone` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `cpf`, `password`, `remember_token`, `created_at`, `updated_at`, `telefone`) VALUES
(1, 'Alysson Marques', 'alyssonmarques@gmail.com', '00715334948', '$2y$10$1WPN1L8YLrDsjhPxlIERmOw6cK0szMhZ11zzovMLpyJN94un/RjIy', 'kNKpEvkxhIN7FVr4L6ylaA1or7CmmycDqsRba2omC2FnbrCrUDZSOhYmkmrX', '2019-01-22 21:55:15', '2019-09-05 14:10:45', '(48)3251-8274'),
(3, 'Niarcos Wall Thomaz de Almeida', 'niarcos.almeida@planejamento.gov.br', '02338607970', '$2y$10$LBu5JGtmfSDpR9jH6ipMOOAby.ClDFezkCd3Qw3wF/edcT4UmZZLK', '3zpwByynLWsVv4SXRq84QFXlwXHkHgEZRQVYLmKD3ma83MWTxRqTjKAbKvca', '2019-03-07 12:45:54', '2019-09-04 21:22:15', '(48)3224-5399'),
(4, 'Rafael Nascimento Montemor', 'rafael.montemor@planejamento.gov.br', '02794094947', '$2y$10$zcy7Pi9MaR8eqFE7fKMi9u3RTWYmvR1FCpsviaMgfPrtRbcJxQKrG', 'TIb9SGxmAfqXeK8fJB6fpvnU1DGhB3S9QXnWGe5LqsAH3P6La3i14G86JDni', '2019-03-07 12:57:21', '2019-09-04 22:29:09', '(48)3224-5399'),
(5, 'Juliano Luiz Pinzetta', 'juliano.pinzetta@planejamento.gov.br', '03760336906', '$2y$10$Nrg8M3ys8YGsl68JsPWbROxKPnPJgSvym/1N2VdsgbmejSXCAIvZy', NULL, '2019-03-07 12:59:35', '2019-08-30 22:37:12', '(48)3224-5399'),
(8, 'Robson Castanho', 'robson.castanho@planejamento.gov.br', '69200033172', '$2y$10$wRvdasJ8377KNNs7PeAvKOjuOn.dn/Rl9esHhnVUWdDkZXGxaEZZG', NULL, '2019-03-12 14:16:19', '2019-09-04 20:10:55', '(48)3224-5399'),
(9, 'Sistema', 'assessoria.spu.sc@planejamento.gov.br', '', 'aaaaaa', NULL, NULL, NULL, NULL),
(10, 'Camila Porto Fasolo', 'camila.fasolo@planejamento.gov.br', '05309676937', '$2y$10$Dm1jg/iAvOTPErCa3t4Ma.KqqSjJOdzkVvdW1MmMQCORlBRhVO5W6', 'CwyOz8hQtlyFRu9tE6fK3K7RRMfXx9s8Zq400YlMEcrnIa83qd4pBKX8J3mC', '2019-03-18 14:20:23', '2019-07-17 23:18:57', '(48)3223-1596'),
(13, 'Manglio Ortiz de Almeida', 'manglio.almeida@planejamento.gov.br', '64447960087', '$2y$10$ZwGr5ZVMd39JwLxJLfBBQej5EicPxTGsRvyIS3mXeB./jStCXTBhC', 'BU5Nv8enfpF10V6XkMjg5j4Rizj7VYPWIqNzNdILUYv0tAlN3YFPDrWMd481', '2019-04-01 14:33:40', '2019-09-04 20:55:44', '(48)999259910'),
(14, 'Luiz Carlos da Costa', 'luiz.carlos@planejamento.gov.br', '76822150978', '$2y$10$Lgnv1WrIu3Nm.G5H1RTpaO.sotm7k0nZzbV9IC3DRp7EUGLjPvIGy', NULL, '2019-05-08 12:57:21', '2019-05-08 12:57:21', '(48)3224-5399'),
(15, 'Nildo Azevedo', 'nildo.azevedo@planejamento.gov.br', '48499234968', '$2y$10$hpd62gm/.1aHvnc75WNIm.MBs7xayeCFZfLzqRiOFBgF3LOuvjWfW', NULL, '2019-05-10 16:16:33', '2019-05-10 16:16:33', '(61)2020-1457'),
(16, 'Carlos Jose Bauer', 'carlos.bauer@planejamento.gov.br', '07069456972', '$2y$10$mjbsPE5NARgz8lO9s6z5KOow.rjrCIcfP1ffAVieSR6yMfHtdUuyG', NULL, '2019-05-30 23:33:45', '2019-05-30 23:33:45', '(48)3224-5399'),
(17, 'Clarissa Pereira Antunes', 'clarissa.antunes@planejamento.gov.br', '91079918000', '$2y$10$F7wrR5yvbDYlTwZUizu4mu.9MqPkgr1Ya77/w2MBI1lvhk7UYEr0.', NULL, '2019-06-03 22:17:51', '2019-07-12 18:23:31', '(48)3251-8210'),
(18, 'Luciana Velasquez Lopes', 'luciana.lopes@planejamento.gov.br', '00383931070', '$2y$10$gGaVgdERf/YKlHaLHAQCN.AJtfDKnZi3lEkyObA7ALfMdLTRRavFm', NULL, '2019-06-03 22:18:16', '2019-07-10 19:54:49', '(48)3224-5399'),
(19, 'Luiz Franca Silva', 'luiz-franca.silva@planejamento.gov.br', '11167980778', '$2y$10$TENYIkbezSHW2K5pkPxBnujWg3iigvmYSyyfxhx0WhKEnh3kxX3E2', NULL, '2019-06-07 01:05:00', '2019-06-07 15:39:21', '(48)3251-8204'),
(20, 'Nabih Henrique Chraim', 'nabih.chraim@planejamento.gov.br', '03117540903', '$2y$10$gNJOdMBZAxTsqungKI1f3uLGhhtKzrxXWuFVi.h05mBYLNI2puOfa', NULL, '2019-07-08 17:57:10', '2019-07-09 19:36:44', '(48)3251-8210'),
(21, 'Flavia Helena de Oliveira Duque', 'flavia.duque@planejamento.gov.br', '54999510634', '$2y$10$xrX5L6V/f5zLn.an90hadeha7w5.97QRtoyEl7.piapscwIxeO0/m', NULL, '2019-07-09 16:33:21', '2019-07-25 21:57:25', '(48)3224-5399'),
(22, 'Julio Carlos Santos Lima', 'julio.lima@planejamento.gov.br', '90768116600', '$2y$10$0Y0u/gNQBB8u4gkxym41OOWKib/fIq.RfV.omae0C52wESmqtoVGO', NULL, '2019-08-20 23:10:13', '2019-09-03 23:30:46', '(31) 3218-6063'),
(23, 'Luciana Mara de Oliveira', 'luciana-m.oliveira@planejamento.gov.br', '70561150125', '$2y$10$QS9KWZTIkCZ/CuVHdEH/ee/lDmgRKOO/pYrIp2.zuLF8f29G4YJpO', NULL, '2019-09-02 16:48:49', '2019-09-04 21:40:16', '(48)3224-5399'),
(24, 'Krislaine de Moraes Ferreira', 'krislaine.ferreira@planejamento.gov.br', '05834157920', '$2y$10$mCKYlV.gTOjVHbdoBwmiA.DKWqF.uC6hcXOSetnhA987KYJWcVWK.', NULL, '2019-09-04 15:17:22', '2019-09-04 15:17:22', '(48)3223-1279');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuariopermissao`
--

CREATE TABLE `usuariopermissao` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `idPermissao` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `usuariopermissao`
--

INSERT INTO `usuariopermissao` (`id`, `created_at`, `updated_at`, `idUsuario`, `idPermissao`) VALUES
(1, NULL, NULL, 1, 3),
(2, NULL, NULL, 1, 2),
(3, NULL, NULL, 1, 4),
(4, NULL, NULL, 3, 2),
(5, NULL, NULL, 3, 3),
(7, NULL, NULL, 3, 4),
(9, NULL, NULL, 4, 2),
(10, NULL, NULL, 4, 3),
(11, NULL, NULL, 4, 4),
(12, NULL, NULL, 5, 2),
(13, NULL, NULL, 5, 3),
(14, NULL, NULL, 5, 4),
(15, NULL, NULL, 8, 4),
(16, NULL, NULL, 8, 2),
(17, NULL, NULL, 8, 3),
(18, NULL, NULL, 13, 4),
(19, NULL, NULL, 13, 2),
(20, NULL, NULL, 13, 3),
(21, NULL, NULL, 17, 4),
(22, NULL, NULL, 17, 2),
(23, NULL, NULL, 17, 3),
(24, NULL, NULL, 18, 2),
(25, NULL, NULL, 18, 3),
(26, NULL, NULL, 18, 4),
(27, NULL, NULL, 8, 5),
(28, NULL, NULL, 4, 5),
(31, NULL, NULL, 17, 5),
(32, NULL, NULL, 18, 5),
(33, NULL, NULL, 3, 5),
(34, NULL, NULL, 5, 5),
(35, NULL, NULL, 13, 5),
(36, NULL, NULL, 1, 5),
(37, NULL, NULL, 23, 4),
(38, NULL, NULL, 23, 5),
(39, NULL, NULL, 23, 2),
(40, NULL, NULL, 23, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `autordemanda`
--
ALTER TABLE `autordemanda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autordemanda_idorgao_foreign` (`idOrgao`),
  ADD KEY `autordemanda_idcargo_foreign` (`idCargo`);

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categoriademanda`
--
ALTER TABLE `categoriademanda`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conteudo`
--
ALTER TABLE `conteudo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `demanda`
--
ALTER TABLE `demanda`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `demanda_idprocedimentoexterno_documentoexterno_unique` (`idProcedimentoExterno`,`documentoExterno`),
  ADD KEY `demanda_idtipodocumento_foreign` (`idTipoDocumento`),
  ADD KEY `demanda_idautordemanda_foreign` (`idAutorDemanda`),
  ADD KEY `demanda_idsituacaodemanda_foreign` (`idSituacaoDemanda`),
  ADD KEY `demanda_idcategoriademanda_foreign` (`idCategoriaDemanda`),
  ADD KEY `demanda_idusuariocriacao_foreign` (`idUsuarioCriacao`),
  ADD KEY `demanda_idusuarioalteracao_foreign` (`idUsuarioAlteracao`);

--
-- Indexes for table `demandamovimentacao`
--
ALTER TABLE `demandamovimentacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `demandamovimentacao_iddemanda_foreign` (`idDemanda`),
  ADD KEY `demandamovimentacao_iddivisaoorganogramaorigem_foreign` (`idDivisaoOrganogramaOrigem`),
  ADD KEY `demandamovimentacao_iddivisaoorganogramadestino_foreign` (`idDivisaoOrganogramaDestino`),
  ADD KEY `demandamovimentacao_idusuario_foreign` (`idUsuario`);

--
-- Indexes for table `distribuicaodemanda`
--
ALTER TABLE `distribuicaodemanda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `distribuicaodemanda_iddemanda_foreign` (`idDemanda`),
  ADD KEY `distribuicaodemanda_idusuariode_foreign` (`idUsuarioDe`),
  ADD KEY `distribuicaodemanda_entidadepara_type_entidadepara_id_index` (`assignable_type`,`assignable_id`);

--
-- Indexes for table `divisaoorganograma`
--
ALTER TABLE `divisaoorganograma`
  ADD PRIMARY KEY (`id`),
  ADD KEY `divisaoorganograma_iddivisaoorganogramapai_foreign` (`idDivisaoOrganogramaPai`);

--
-- Indexes for table `geo_camada`
--
ALTER TABLE `geo_camada`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `geo_referencia`
--
ALTER TABLE `geo_referencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `geo_referencia_idcamada_foreign` (`idCamada`),
  ADD KEY `geo_referencia_idusuariocriacao_foreign` (`idUsuarioCriacao`),
  ADD KEY `geo_referencia_idusuarioalteracao_foreign` (`idUsuarioAlteracao`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `naturezaorgao`
--
ALTER TABLE `naturezaorgao`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orgao`
--
ALTER TABLE `orgao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orgao_idorgaopai_foreign` (`idOrgaoPai`),
  ADD KEY `orgao_idnaturezaorgao_foreign` (`idNaturezaOrgao`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissao`
--
ALTER TABLE `permissao`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `poloprocedimentoexterno`
--
ALTER TABLE `poloprocedimentoexterno`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `procedimentoexterno`
--
ALTER TABLE `procedimentoexterno`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `procedimentoexterno_procedimento_unique` (`procedimento`),
  ADD KEY `procedimentoexterno_idtipoprocedimentoexterno_foreign` (`idTipoProcedimentoExterno`),
  ADD KEY `procedimentoexterno_idpoloprocedimentoexterno_foreign` (`idPoloProcedimentoExterno`);

--
-- Indexes for table `situacaodemanda`
--
ALTER TABLE `situacaodemanda`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipoprocedimentoexterno`
--
ALTER TABLE `tipoprocedimentoexterno`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipoprocesso`
--
ALTER TABLE `tipoprocesso`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_cpf_unique` (`cpf`) USING BTREE;

--
-- Indexes for table `usuariopermissao`
--
ALTER TABLE `usuariopermissao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idUsuario` (`idUsuario`,`idPermissao`),
  ADD KEY `usuariopermissao_idpermissao_foreign` (`idPermissao`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `autordemanda`
--
ALTER TABLE `autordemanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=325;

--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `categoriademanda`
--
ALTER TABLE `categoriademanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conteudo`
--
ALTER TABLE `conteudo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `demanda`
--
ALTER TABLE `demanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1020;

--
-- AUTO_INCREMENT for table `demandamovimentacao`
--
ALTER TABLE `demandamovimentacao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `distribuicaodemanda`
--
ALTER TABLE `distribuicaodemanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1138;

--
-- AUTO_INCREMENT for table `divisaoorganograma`
--
ALTER TABLE `divisaoorganograma`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `geo_camada`
--
ALTER TABLE `geo_camada`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `geo_referencia`
--
ALTER TABLE `geo_referencia`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `naturezaorgao`
--
ALTER TABLE `naturezaorgao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orgao`
--
ALTER TABLE `orgao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `permissao`
--
ALTER TABLE `permissao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `poloprocedimentoexterno`
--
ALTER TABLE `poloprocedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `procedimentoexterno`
--
ALTER TABLE `procedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=939;

--
-- AUTO_INCREMENT for table `situacaodemanda`
--
ALTER TABLE `situacaodemanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tipoprocedimentoexterno`
--
ALTER TABLE `tipoprocedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tipoprocesso`
--
ALTER TABLE `tipoprocesso`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `usuariopermissao`
--
ALTER TABLE `usuariopermissao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `autordemanda`
--
ALTER TABLE `autordemanda`
  ADD CONSTRAINT `autordemanda_idcargo_foreign` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`id`),
  ADD CONSTRAINT `autordemanda_idorgao_foreign` FOREIGN KEY (`idOrgao`) REFERENCES `orgao` (`id`);

--
-- Limitadores para a tabela `demanda`
--
ALTER TABLE `demanda`
  ADD CONSTRAINT `demanda_idautordemanda_foreign` FOREIGN KEY (`idAutorDemanda`) REFERENCES `autordemanda` (`id`),
  ADD CONSTRAINT `demanda_idcategoriademanda_foreign` FOREIGN KEY (`idCategoriaDemanda`) REFERENCES `categoriademanda` (`id`),
  ADD CONSTRAINT `demanda_idprocedimentoexterno_foreign` FOREIGN KEY (`idProcedimentoExterno`) REFERENCES `procedimentoexterno` (`id`),
  ADD CONSTRAINT `demanda_idsituacaodemanda_foreign` FOREIGN KEY (`idSituacaoDemanda`) REFERENCES `situacaodemanda` (`id`),
  ADD CONSTRAINT `demanda_idtipodocumento_foreign` FOREIGN KEY (`idTipoDocumento`) REFERENCES `tipodocumento` (`id`),
  ADD CONSTRAINT `demanda_idusuarioalteracao_foreign` FOREIGN KEY (`idUsuarioAlteracao`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `demanda_idusuariocriacao_foreign` FOREIGN KEY (`idUsuarioCriacao`) REFERENCES `users` (`id`);

--
-- Limitadores para a tabela `demandamovimentacao`
--
ALTER TABLE `demandamovimentacao`
  ADD CONSTRAINT `demandamovimentacao_iddemanda_foreign` FOREIGN KEY (`idDemanda`) REFERENCES `demanda` (`id`),
  ADD CONSTRAINT `demandamovimentacao_iddivisaoorganogramadestino_foreign` FOREIGN KEY (`idDivisaoOrganogramaDestino`) REFERENCES `divisaoorganograma` (`id`),
  ADD CONSTRAINT `demandamovimentacao_iddivisaoorganogramaorigem_foreign` FOREIGN KEY (`idDivisaoOrganogramaOrigem`) REFERENCES `divisaoorganograma` (`id`),
  ADD CONSTRAINT `demandamovimentacao_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`);

--
-- Limitadores para a tabela `distribuicaodemanda`
--
ALTER TABLE `distribuicaodemanda`
  ADD CONSTRAINT `distribuicaodemanda_iddemanda_foreign` FOREIGN KEY (`idDemanda`) REFERENCES `demanda` (`id`),
  ADD CONSTRAINT `distribuicaodemanda_idusuariode_foreign` FOREIGN KEY (`idUsuarioDe`) REFERENCES `users` (`id`);

--
-- Limitadores para a tabela `divisaoorganograma`
--
ALTER TABLE `divisaoorganograma`
  ADD CONSTRAINT `divisaoorganograma_iddivisaoorganogramapai_foreign` FOREIGN KEY (`idDivisaoOrganogramaPai`) REFERENCES `divisaoorganograma` (`id`);

--
-- Limitadores para a tabela `geo_referencia`
--
ALTER TABLE `geo_referencia`
  ADD CONSTRAINT `geo_referencia_idcamada_foreign` FOREIGN KEY (`idCamada`) REFERENCES `geo_camada` (`id`),
  ADD CONSTRAINT `geo_referencia_idusuarioalteracao_foreign` FOREIGN KEY (`idUsuarioAlteracao`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `geo_referencia_idusuariocriacao_foreign` FOREIGN KEY (`idUsuarioCriacao`) REFERENCES `users` (`id`);

--
-- Limitadores para a tabela `orgao`
--
ALTER TABLE `orgao`
  ADD CONSTRAINT `orgao_idnaturezaorgao_foreign` FOREIGN KEY (`idNaturezaOrgao`) REFERENCES `naturezaorgao` (`id`),
  ADD CONSTRAINT `orgao_idorgaopai_foreign` FOREIGN KEY (`idOrgaoPai`) REFERENCES `orgao` (`id`);

--
-- Limitadores para a tabela `procedimentoexterno`
--
ALTER TABLE `procedimentoexterno`
  ADD CONSTRAINT `procedimentoexterno_idpoloprocedimentoexterno_foreign` FOREIGN KEY (`idPoloProcedimentoExterno`) REFERENCES `poloprocedimentoexterno` (`id`),
  ADD CONSTRAINT `procedimentoexterno_idtipoprocedimentoexterno_foreign` FOREIGN KEY (`idTipoProcedimentoExterno`) REFERENCES `tipoprocedimentoexterno` (`id`);

--
-- Limitadores para a tabela `usuariopermissao`
--
ALTER TABLE `usuariopermissao`
  ADD CONSTRAINT `usuariopermissao_idpermissao_foreign` FOREIGN KEY (`idPermissao`) REFERENCES `permissao` (`id`),
  ADD CONSTRAINT `usuariopermissao_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
