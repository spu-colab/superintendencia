-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 24-Maio-2019 às 23:04
-- Versão do servidor: 10.1.28-MariaDB
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

                        SELECT id INTO v_IdSituacaoEmAtendimento FROM situacaodemanda WHERE situacao = "Em análise";
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
(1, 2, 2, 'Débora Beal Thaís de Córdova', '[email_nao_fornecido]', '(48)32036380', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(2, 2, 34, 'Dalvani Luzia Propodoski Rocha Vieira Jank', '[email_nao_fornecido]', '(48)32036380', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(3, 5, 33, 'Felipe Dulac Goulart', '[email_nao_fornecido]', '(48)38212000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(4, 5, 35, 'Flávio Camozzato', '[email_nao_fornecido]', '(48)38212000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(5, 5, 35, 'Luiz Henrique Teixeira da Silva', '[email_nao_fornecido]', '(48)38212000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(6, 6, 39, 'Alfeu Gomes dos Santos', '[email_nao_fornecido]', '(47)33228915', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(7, 6, 37, 'Eleandro Ângelo Biondo', '[email_nao_fornecido]', '(47)33228915', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(8, 6, 39, 'Márcio Santos de Freitas', '[email_nao_fornecido]', '(47)33228915', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(9, 7, 37, 'Daniel Sbeghen', '[email_nao_fornecido]', '(49)33224433', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(10, 7, 39, 'Fábio João Szinwelski', '[email_nao_fornecido]', '(49)33224433', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(11, 7, 39, 'Joubert Farley Eger', '[email_nao_fornecido]', '(49)33224433', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(12, 8, 37, 'Vinícius Garcia', '[email_nao_fornecido]', '(48)34331235', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(13, 8, 39, 'André Afeche Pimenta', '[email_nao_fornecido]', '(48)34331235', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(14, 8, 39, 'Alessandro Schlemper Kiquio', '[email_nao_fornecido]', '(48)34331235', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(15, 9, 37, 'Márcio da Silva Florêncio', '[email_nao_fornecido]', '(47)33482735', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(16, 9, 40, 'Gabriela Cabral Soares Modesto', '[email_nao_fornecido]', '(47)33482735', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(17, 10, 38, 'Bruna Machado Lucas Gomes', '[email_nao_fornecido]', '(49)35222289', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(18, 10, 40, 'Nathalia Hoffmann Monteiro de Castro', '[email_nao_fornecido]', '(49)35222289', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(19, 11, 37, 'Cidinei Bogo Chatt', '[email_nao_fornecido]', '(47)34226367', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(20, 11, 39, 'Jackson Torres', '[email_nao_fornecido]', '(47)34226367', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(21, 11, 39, 'Márcio Poderoso de Araújo', '[email_nao_fornecido]', '(47)35222289', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(22, 12, 37, 'Francisco José Tarso de Sabóia', '[email_nao_fornecido]', '(49)32241989', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(23, 12, 39, 'Daniel Oliveira Teles de Menezes', '[email_nao_fornecido]', '(49)32241989', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(24, 13, 41, 'JOÃO PEDRO WOITEXEM', '[email_nao_fornecido]', '(47)34477737', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(25, 14, 41, 'SANDRO ROBERTO MACIEL', '[email_nao_fornecido]', '(48)35210922', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(26, 15, 41, 'EVANDRO SCAINI', '[email_nao_fornecido]', '(48)35261445', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(27, 16, 41, 'Ademar Henrique Borges', '[email_nao_fornecido]', '(47)34481043', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(28, 17, 42, 'LUZIA LOURDES COPPI MATHIAS', '[email_nao_fornecido]', '(47)33659500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(29, 18, 41, 'RONALDO PEREIRA DA SILVA', '[email_nao_fornecido]', '(48)35831408', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(30, 19, 41, 'SÉRGIO FERREIRA DE AGUIAR', '[email_nao_fornecido]', '(47)34438813', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(31, 20, 41, 'LEONEL JOSÉ MARTINS', '[email_nao_fornecido]', '(47)33474707', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(32, 21, 41, 'CLAUDEMIR MATIAS FRANCISCO', '[email_nao_fornecido]', '(47)34467700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(33, 22, 41, 'JOSÉ CASTELO DESCHAMPS', '[email_nao_fornecido]', '(48)32798000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(34, 23, 42, 'ANA PAULA DA SILVA', '[email_nao_fornecido]', '(47)33939500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(35, 24, 41, 'CESAR SOUZA JÚNIOR', '[email_nao_fornecido]', '(48)32516066', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(36, 25, 41, 'LUIZ CARLOS LUIZ', '[email_nao_fornecido]', '(48)32548100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(37, 29, 41, 'JANDIR BELLINI', '[email_nao_fornecido]', '(47)33416000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(38, 30, 41, 'RODRIGO COSTA', '[email_nao_fornecido]', '(47)32688000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(39, 31, 41, 'LUIZ ARNALDO NAPOLI', '[email_nao_fornecido]', '(48)36240138', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(40, 32, 41, 'UDO DOHLER', '[email_nao_fornecido]', '(47)34313233', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(41, 34, 41, 'ROBERTO CARLOS DE SOUZA', '[email_nao_fornecido]', '(47)33429500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(42, 35, 41, 'CAMILO NAZARENO PAGANI MARTINS', '[email_nao_fornecido]', '(48)32791700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(43, 36, 41, 'JUAREZ GODINHO SCHEFFER', '[email_nao_fornecido]', '(48)35480035', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(44, 37, 41, 'EVANDRO EREDES DOS NAVEGANTES', '[email_nao_fornecido]', '(47)33450200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(45, 38, 41, 'EVALDO JOSÉ GUERREIRO FILHO', '[email_nao_fornecido]', '(47)33694111', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(46, 39, 41, 'LUIZ ROBERTO DE OLIVEIRA', '[email_nao_fornecido]', '(47)34712222', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(47, 40, 42, 'ADELIANA DAL PONT', '[email_nao_fornecido]', '(48)33810000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(48, 41, 41, 'VALÉRIO TOMAZI', '[email_nao_fornecido]', '(48)32688100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(49, 42, 41, 'DÉCIO GOMES GÓES', '[email_nao_fornecido]', '(48)34681068', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(50, 43, 41, 'EVANDRO JOÃO DOS SANTOS', '[email_nao_fornecido]', '(48)88490000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(51, 33, 41, 'EVERALDO DOS SANTOS', '[email_nao_fornecido]', '(48)36448700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(52, 28, 41, 'JAISON CARDOSO DE  SOUZA', '[email_nao_fornecido]', '(48)33558135', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(53, 27, 41, 'JULIANO DUARTE CAMPOS', '[email_nao_fornecido]', '(48)32620131', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(54, 44, 37, 'CAIO ALEXANDRE WOLFF', '[email_nao_fornecido]', '(47)33228918', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(55, 45, 37, 'MÁRCIO WESSNER', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(56, 46, 37, 'DIOGO CAVALLI', '[email_nao_fornecido]', '(48)34334174', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(57, 47, 37, 'CIRO CARVALHO MIRANDA', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(58, 48, 33, 'MARCELO DA MOTA', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(59, 50, 5, 'ANDERSON LODETTI CUNHA DE OLIVEIRA', '[email_nao_fornecido]', '(49)34212100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(60, 51, 5, 'RENATO DE REZENDE GOMES', '[email_nao_fornecido]', '(49)33131200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(61, 52, 5, 'CARLOS HUMBERTO PROLA JÚNIOR', '[email_nao_fornecido]', '(49)34411806', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(62, 53, 5, 'DARLAN AIRTON DIAS', '[email_nao_fornecido]', '(48)34112500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(63, 54, 5, 'PEDRO PAULO REINALDIN', '[email_nao_fornecido]', '(47)34045150', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(64, 55, 5, 'CLAUDIO VALENTIM CRISTANI', '[email_nao_fornecido]', '(47)35012100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(65, 56, 5, 'MÁRIO ROBERTO DOS SANTOS', '[email_nao_fornecido]', '(49)32027000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(66, 57, 5, 'DAVY LINCOLN ROCHA', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(67, 58, 5, 'NAZARENO JORGEALEM WOLFF', '[email_nao_fornecido]', '(49)21012300', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(68, 59, 5, 'RUI MAURÍCIO RIBAS RUCINSKI', '[email_nao_fornecido]', '(47)36415400', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(69, 60, 6, 'LUCYANA MARINA PEPE AFFONSO', '[email_nao_fornecido]', '(47)34112255', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(70, 61, 6, 'CAMILA BORTOLOTTI', '[email_nao_fornecido]', '(49)36312700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(71, 61, 5, 'EDSON RESTANHO', '[email_nao_fornecido]', '(49)36312700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(72, 62, 5, 'DANIEL RICKEN', '[email_nao_fornecido]', '(48)33021000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(73, 62, 5, 'ELOI FRANCISCO ZATTI FACCIONI', '[email_nao_fornecido]', '(48)33021000', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(74, 49, 5, 'ANDREI MATTIUZI BALVEDI', '[email_nao_fornecido]', '(47)33211700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(75, 49, 5, 'MICHAEL VON MUHLEN DE BARROS GONÇALVES', '[email_nao_fornecido]', '(47)33211700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(76, 49, 6, 'RAFAELLA ALBERICI', '[email_nao_fornecido]', '(47)33211700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(77, 49, 5, 'RICARDO KLING DONINI', '[email_nao_fornecido]', '(47)33211700', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(78, 53, 5, 'FÁBIO DE OLIVEIRA', '[email_nao_fornecido]', '(48)34112500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(79, 53, 6, 'PATRÍCIA MUXFELDT', '[email_nao_fornecido]', '(48)34112500', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(80, 54, 5, 'RAFAEL BRUM MIRON', '[email_nao_fornecido]', '(47)34045150', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(81, 54, 5, 'RICARDO MARTINS BAPTISTA', '[email_nao_fornecido]', '(47)34045150', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(82, 57, 5, 'FLÁVIO PAVLOV DA SILVEIRA', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(83, 57, 5, 'MÁRIO SÉRGIO GHANNAGE BARBOSA', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(84, 57, 5, 'RODRIGO JOAQUIM LIMA', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(85, 57, 5, 'TIAGO ALZUGUIR GUTIERREZ', '[email_nao_fornecido]', '(47)34417200', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(86, 48, 6, 'ANALÚCIA DE ANDRADE HARTMANN', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(87, 48, 5, 'ANDRÉ STEFANI BERTUOL', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(88, 48, 5, 'CARLOS AUGUSTO DE AMORIM DUTRA', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(89, 48, 6, 'DANIELE CARDOSO ESCOBAR', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(90, 48, 5, 'EDUARDO BARRAGAN SEROA DA MOTTA', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(91, 48, 5, 'JOÃO MARQUES BRANDÃO NETO', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(92, 48, 5, 'MARCO AURÉLIO DUTRA AYDOS', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:26', '2019-01-23 20:05:26'),
(93, 48, 5, 'ROGER FABRE', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(94, 48, 5, 'MAURÍCIO PESSUTTO', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(95, 48, 5, 'WALMOR ALVES MOREIRA', '[email_nao_fornecido]', '(48)21076100', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(96, 44, 39, 'CLAUDINEI MOSER', '[email_nao_fornecido]', '(47)33228918', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(97, 44, 1, 'MARCELO CONCEIÇÃO ANDRETTA', '[email_nao_fornecido]', '(47)33228918', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(98, 44, 1, 'OSVALDO GRAVINA FILHO', '[email_nao_fornecido]', '(47)33228918', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(99, 44, 1, 'ULISSES VETTORELLO', '[email_nao_fornecido]', '(47)33228918', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(100, 45, 40, 'MARILES WICHROSKI DOS SANTOS', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(101, 45, 2, 'FRANCEELLE SOARES', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(102, 45, 1, 'ADAUTO JOSE SILVA FILHO', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(103, 46, 1, 'VICTOR KLAFKE RIBEIRO', '[email_nao_fornecido]', '(48)34334174', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(104, 46, 2, 'LEILA MILENE ZILLI DOS SANTOS', '[email_nao_fornecido]', '(48)34334174', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(105, 47, 39, 'FÁBIO CRISTIANO WOERNER GALLE', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(106, 47, 2, 'MARIA LUCIA HOLANDA GURGEL PEREIRA', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(107, 47, 2, 'VIVIANE FENRICH', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(108, 47, 1, 'DANIEL CARLOS ANDRADE', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(109, 47, 1, 'JOSÉ OLIVEIRA DA SILVA', '[email_nao_fornecido]', '(47)21079700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(110, 63, 33, 'CLÊNIO LUIZ PARIZOTTO', '[email_nao_fornecido]', '(41)32045700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(111, 63, 44, 'CLAUDETE SIRLEI DE SOUZA', '[email_nao_fornecido]', '(41)32045700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(112, 2, 43, 'César Augusto Bedin', '[email_nao_fornecido]', '(48)32036380', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(113, 2, 1, 'JOSÉ WANDERLEY KOZIMA', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(114, 2, 1, 'Emedi Camilo Vizzotto', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(116, 85, 5, 'Diogo André Matsuoka Azevedo dos Santos', '[email_nao_fornecido]', '(48)36448314', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(118, 2, 1, 'Fábio Gomes Pina', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(119, 57, 38, 'FÁBIO GALLE', '[email_nao_fornecido]', '(47)34220590', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(120, 45, 1, 'Ângelo Madar Piva', '[email_nao_fornecido]', '(49)33231455', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(121, 47, 15, 'Andréa Rocha', '[email_nao_fornecido]', '(48)34220590', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(122, 5, 5, 'Dinemar Zoccoli', '[email_nao_fornecido]', '(48)32512000', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(124, 2, 20, 'Celita Helena Kalbusch de Souza', '[email_nao_fornecido]', '(48)32036340', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(125, 68, 3, 'Daniel Natividade Rodrigues de Oliveira', '[email_nao_fornecido]', '(48)32552206', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(126, 2, 5, 'André Luiz de Córdova', '[email_nao_fornecido]', '(48)32036349', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(127, 51, 5, 'Carlos Humberto Prola Junior', '[email_nao_fornecido]', '(49)33131200', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(128, 67, 50, 'Luciano Trierweiller Naschenweng', '[email_nao_fornecido]', '(48)33302128', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(129, 69, 15, 'Rômulo Humberto Torres de Castro Osta', '[email_nao_fornecido]', '(47)34316800', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(130, 70, 11, 'Maria das Graças Albert', '[email_nao_fornecido]', '(48)32236452', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(131, 71, 11, 'Vereador Celso Francisco Sandrini', '[email_nao_fornecido]', '(48)30275700', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(132, 72, 15, 'Clovis Roldão Machado de Barros', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(133, 73, 15, 'Luis Ernesto Trein', '[email_nao_fornecido]', '(47)34333760', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(134, 62, 9, 'Andrey Luciano F Miranda', '[email_nao_fornecido]', '(48)33021045', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(135, 1, 17, 'Antônio Augusto Teixeira Diniz', '[email_nao_fornecido]', '(48)32512536', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(136, 67, 50, 'Mário Waltrick do Amarante', '[email_nao_fornecido]', '(48)33302132', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(137, 74, 19, 'Eduardo Cardoso', '[email_nao_fornecido]', '(48)32517410', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(138, 75, 15, 'Luciana de Castro Ribeiro', '[email_nao_fornecido]', '(47)32496799', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(139, 72, 15, 'Alessandre Mauro Tomaz', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(140, 2, 1, 'JOSÉ OLIVEIRA DA SILVA', '[email_nao_fornecido]', '(47)34226689', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(141, 2, 1, 'PEDRO AUGUSTO RODRIGUES COSTA', '[email_nao_fornecido]', '(48)32036377', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(142, 1, 17, 'JULIANO AYRES DA ROCHA', '[email_nao_fornecido]', '(48)32512546', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(143, 47, 1, 'ANDRÉ LUIZ DE CÓRDOVA', '[email_nao_fornecido]', '(48)39011380', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(144, 11, 6, 'Catia Rosane Viertel Crestani', '[email_nao_fornecido]', '(47)34226367', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(145, 11, 6, 'Larissa Keil Marinelli', '[email_nao_fornecido]', '(47)34226367', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(146, 1, 17, 'Juliano Ayres da Rocha', '[email_nao_fornecido]', '(48)32512546', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(147, 56, 55, 'MÁRCIA YAMAGUTI', '[email_nao_fornecido]', '(49)32027000', '2019-01-23 20:05:27', '2019-01-23 20:05:27'),
(148, 76, 15, 'SILVIO DE SOUZA JUNIOR', '[email_nao_fornecido]', '(48)32822163', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(149, 77, 3, 'MÔNANI MENINE PEREIRA', '[email_nao_fornecido]', '(48)32638030', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(150, 78, 5, 'CARLOS HUMBERTO PROLA JÚNIOR', '[email_nao_fornecido]', '(49)34411800', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(151, 79, 52, 'HELIO SANT ANNA E SILVA JUNIO', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(153, 9, 6, 'Gabriela Cabral Soares Modesto', '[email_nao_fornecido]', '(47)33482735', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(154, 81, 15, 'Francisco de Assis Beltrame', '[email_nao_fornecido]', '(48)36262486', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(155, 69, 52, 'Júnior Aparecido Taglialenha', '[email_nao_fornecido]', '(47)34316800', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(156, 72, 52, 'Helio Santanna e Silva Junior', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(157, 2, 1, 'CIRO CARVALHO MIRANDA', '[email_nao_fornecido]', '(47)34220590', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(158, 82, 60, 'LISIANE FERRAZO RIBEIRO', '[email_nao_fornecido]', '(51)35116500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(159, 82, 57, 'ADALBERTO JOSÉ KASPARY FILHO', '[email_nao_fornecido]', '(51)35116500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(160, 83, 1, 'José Wanderley Kozima', '[email_nao_fornecido]', '(48)99999999', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(161, 1, 3, 'MARCELO KRÁS BORGES', '[email_nao_fornecido]', '(48)32036349', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(162, 84, 2, 'Sabrina Fontoura da Silva', '[email_nao_fornecido]', '(51)35116500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(163, 80, 15, 'Célio Alexandre John', '[email_nao_fornecido]', '(47)33333333', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(164, 79, 52, 'Maurício Manica Gossling', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(165, 6, 6, 'RAFAELA FRANCO ABREU', '[email_nao_fornecido]', '(61)20255202', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(166, 2, 1, 'Dauton Luis de Andrade', '[email_nao_fornecido]', '(48)32036365', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(167, 2, 1, 'Márcio Wesnner', '[email_nao_fornecido]', '(48)32036349', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(168, 86, 1, 'Dr. Arnaldo Aparecido de Melo', '[email_nao_fornecido]', '(55)32229216', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(169, 87, 15, 'Soraia Joselita Depin', '[email_nao_fornecido]', '(47)33697149', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(170, 1, 17, 'MARCELO DONINI', '[email_nao_fornecido]', '(48)32512663', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(171, 67, 49, 'Luciana Rosa', '[email_nao_fornecido]', '(48)39012796', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(172, 88, 1, 'Arnaldo Aparecido de Melo', '[email_nao_fornecido]', '(55)32229216', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(173, 64, 2, 'SARA MARTINS GOMES LOPES', '[email_nao_fornecido]', '(61)20268008', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(174, 67, 49, 'Lenice Born da Silva', '[email_nao_fornecido]', '(47)33697195', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(175, 79, 52, 'Alessandre Mauro Tomaz', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(177, 1, 3, 'Diógenes Tarcísio Marcelino Teixeira', '[email_nao_fornecido]', '(48)300000000', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(178, 90, 3, 'Flávio André Paz de Brum', '[email_nao_fornecido]', '(48)32245399', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(179, 5, 15, 'GILBERTO OURIQUES', '[email_nao_fornecido]', '(48)38212062', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(180, 91, 18, 'Paula Mônica Pulga', '[email_nao_fornecido]', '(49)35611900', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(181, 4, 13, 'SAMUEL DA SILVA CARDOSO', '[email_nao_fornecido]', '(61)20201705', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(182, 67, 49, 'Analú Liberato Longo', '[email_nao_fornecido]', '(48)33302131', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(183, 92, 9, 'Valmi dos Santos FiIlho', '[email_nao_fornecido]', '(48)0', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(184, 67, 50, 'HENRIQUE DA ROSA ZIESEMER', '[email_nao_fornecido]', '(0)0', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(185, 48, 5, 'FÁBIO DE OLIVEIRA', '[email_nao_fornecido]', '(48)34112500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(186, 82, 2, 'Sabrina Fontoura da Silva', '[email_nao_fornecido]', '(51)33330000', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(187, 79, 51, 'TATIANA NUNES LIMA', '[email_nao_fornecido]', '(48)32816500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(188, 67, 49, 'REJANE GULARTE QUEIROZ BEILNER', '[email_nao_fornecido]', '(48)36438003', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(189, 93, 5, 'FÁBIO DE OLIVEIRA', '[email_nao_fornecido]', '(48)34112500', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(190, 94, 4, 'MARIA DE LOURDES SIMAS PORTO', '[email_nao_fornecido]', '(48)33558038', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(191, 95, 4, 'ELAINE CRISTINA DE SOUZA FREITAS', '[email_nao_fornecido]', '(48)32548300', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(192, 96, 19, 'Osmar Jacobsen Filho', '[email_nao_fornecido]', '(48)39524609', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(193, 97, 7, 'DINARTE ANTONIO VAZ', '[email_nao_fornecido]', '(41)32546365', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(194, 1, 17, 'REGINALDO SOETHE', '[email_nao_fornecido]', '(47)33415800', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(195, 98, 1, 'Jorge Alexandre Moreira', '[email_nao_fornecido]', '(48)39011390', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(196, 99, 6, 'Thais Alvez Bruch', '[email_nao_fornecido]', '(48)34330558', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(197, 96, 19, 'MÁárcio Macedo Mussi', '[email_nao_fornecido]', '(48)0', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(198, 67, 50, 'Alceu Rocha', '[email_nao_fornecido]', '(48)33302128', '2019-01-23 20:05:28', '2019-01-23 20:05:28'),
(199, 2, 1, 'LUCIANO CARDOSO BACKER', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(200, 46, 2, 'PATRICIA CORREA GARCIA RODRIGUES', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(201, 47, 2, 'ANDREA DA SILVEIRA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(202, 2, 2, 'CRISTIANE REGINA BORTOLINI', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(203, 47, 1, 'CID JOSÉ FAVERO', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(204, 2, 2, 'PATRÍCIA MONNHRAT MULIM', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(205, 63, 1, 'RODRIGO DE SOUZA AGUIAR', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(206, 64, 2, 'NATANNE LIRA DE MORAIS', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(207, 44, 1, 'MARCELO COENCIÇÃO ANDRETTA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(208, 45, 1, 'MARCOS LUIZ VALMORBIDA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(209, 82, 1, 'HÉCIO BENDER DE OLIVEIRA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(210, 2, 1, 'RICARDO GEWEHR SPOHR', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(211, 100, 4, 'ANUSKA FELSKI DA SILVA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(212, 79, 52, 'LUCAS DE PAULA RODRIGUES DA SILVA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(213, 5, 6, 'ANGELA ROBERTA KRUGER BOSENBECKER', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(214, 5, 6, 'ANA CLAUDIA FARIA CAFIERO', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(215, 5, 6, 'IOLANDA MOREIRA DE JESUS', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(216, 101, 49, 'SIMONE CRISTINA SCHULTZ CORRÊA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(217, 50, 5, 'DANIEL LUIS DALBERTO', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(218, 79, 52, 'JOSÉ ANTÔNIO AMARAL NETO', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(219, 67, 49, 'LETÍCIA VINOTTI DA SILVA', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(220, 102, 3, 'GUSTAVO DIAS DE BARCELLOS', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(221, 102, 3, 'RODRIGO COSTA MEDEIROS', '[email_nao_fornecido]', '()', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(223, 83, 1, 'Emedi Camilo Vizzotto', '[email_nao_fornecido]', '(48)32036303', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(224, 2, 2, 'Virgínia Brodbeck Bolzani', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(225, 54, 5, 'Andrei Mattiuzi Balvedi', '[email_nao_fornecido]', '(48)99999999', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(226, 83, 2, 'Virgínia Brodbeck Bolzani', '[email_nao_fornecido]', '(48)32036355', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(227, 49, 5, 'Ercias Rodrigues de Souza', '[email_nao_fornecido]', '(47)33211700', '2019-01-23 20:05:29', '2019-01-23 20:05:29'),
(228, 44, 61, 'SINEMÉSIA MENDES DE OLIVEIRA', '', '', NULL, NULL),
(231, 7, 5, 'Igor Aragão Brilhante', 'divida.sc.chapeco.psfn@pgfn.gov.br', '(49) 3329-9288', '2019-03-11 13:43:11', '2019-03-11 13:43:11'),
(232, 107, 3, 'Cesar Augusto Vieira', 'rscar01@jfrs.jus.br', NULL, '2019-03-18 19:30:46', '2019-03-18 19:30:46'),
(233, 1, 3, 'Eduardo Didonet Teixeira', 'scflp09@jfsc.jus.br', '(48) 3251-2933', '2019-03-26 12:48:30', '2019-03-26 12:48:30'),
(234, 2, 2, 'VIRGINIA BRODBECK BOLZANI', 'distribuicao.pusc@agu.gov.br', NULL, '2019-03-27 19:14:33', '2019-03-27 19:14:33'),
(235, 40, 56, 'Marcos Sebastiani', 'marcos.sebastani@pmsj.sc.gov.br', NULL, '2019-04-02 13:55:16', '2019-04-02 13:55:16'),
(236, 63, 1, 'Rogério Lopez Garcia', 'pupr.protocolo@agu.gov.br', '(41) 3204-5700', '2019-04-02 18:23:39', '2019-04-02 18:23:39'),
(237, 108, 3, 'Guilherme Mattei Borsoi', 'tubarao.criminal1@tjsc.jus.br', '(48) 3621-1535', '2019-04-03 18:23:08', '2019-04-03 18:23:08'),
(238, 108, 3, 'Guilherme Mattei Borsoi', 'tubarao.criminal1@tjsc.jus.br', '(48) 3621-1535', '2019-04-03 18:23:41', '2019-04-03 18:23:41'),
(239, 60, 5, 'ALISSON NELICIO CIRILO CAMPOS', 'prsc-prmriodosul@mpf.mp.br', '47 3411-2255', '2019-04-05 17:50:26', '2019-04-05 17:50:26'),
(240, 110, 18, 'DENIZE DIAS SCHAEFER', 'scitaOS @jfsc.jus.br', '(47) 3341-5800', '2019-04-08 14:03:47', '2019-04-08 14:03:47'),
(241, 62, 5, 'MÁRIO ROBERTO DOS SANTOS', 'prsc-tubarao@mpf.mp.br', '(48)3302-1000', '2019-04-09 13:29:31', '2019-04-09 13:29:31'),
(242, 2, 1, 'André Luiz de Córdova', 'distribuicao.pusc@agu.gov.br', NULL, '2019-04-09 16:24:13', '2019-04-09 16:24:13'),
(243, 2, 2, 'SINEMÉSIA MENDES DE OLIVEIRA', 'psu.cco@agu.gov.br', NULL, '2019-04-09 16:50:02', '2019-04-09 16:50:02'),
(244, 103, 3, 'Cesar Nadal Souza', '1vara_jve@trt12.jus.br', '47 3431-4910', '2019-04-10 12:24:52', '2019-04-10 12:24:52'),
(245, 111, 52, 'JOSÉ LEANDRO DA SILVA', 'delemaph.srsc@pf.gov.br', '(48)32816500', '2019-04-10 13:56:14', '2019-04-10 13:56:14'),
(246, 111, 51, 'VALERIA BORBA DA SILVA', 'delemaph.srsc@pf.gov.br', '(48)32816500', '2019-04-10 15:58:38', '2019-04-10 15:58:38'),
(247, 111, 51, 'VALERIA BORBA DA SILVA', 'delemaph.srsc@pf.gov.br', '(48)32816500', '2019-04-10 15:58:38', '2019-04-10 15:58:38'),
(248, 111, 51, 'PRISCILLA BURLACENKO', 'delemaph.srsc@pf.gov.br', '(48) 32816500', '2019-04-10 16:13:48', '2019-04-10 16:13:48'),
(249, 111, 51, 'PRISCILLA BURLACENKO', 'delemaph.srsc@pf.gov.br', '(48) 32816500', '2019-04-10 16:13:56', '2019-04-10 16:13:56'),
(250, 112, 62, 'RENAN SOARES DE SOUZA', 'renandesouza@defensoria.sc.gov.be', '(49) 2049-7621', '2019-04-10 18:12:16', '2019-04-10 18:12:16'),
(251, 111, 52, 'GIUSEPPE BORSATO CAVAGNARI', 'delinst.srsc@dpf.gov.br', '(48)32816431', '2019-04-11 17:01:06', '2019-04-11 17:01:06'),
(252, 87, 3, 'André Luiz Anrain Trentini', 'portobelo.vara1@tjsc.jus.br', '47 33697148', '2019-04-11 18:42:14', '2019-04-11 18:42:14'),
(253, 5, 6, 'Jaqueline Araújo de Oliveira', 'jacqueline.oliveira@pgfn.gov.br', NULL, '2019-04-12 14:30:37', '2019-04-12 14:30:37'),
(254, 5, 6, 'RENATA REINALDO SELINGER', 'apoio.se.criciuma.psfn@pgfn.gov.br', '(48) 3433-1235', '2019-04-12 16:40:25', '2019-04-12 16:40:25'),
(255, 67, 50, 'Luis Felippe Fonseca Católico', 'garopaba01PJ@mpsc.mp.br', '48 3254-7901', '2019-04-12 16:54:20', '2019-04-12 16:54:20'),
(256, 1, 3, 'Inezil Penna Marinho Junior', 'sctijua01@jfsg.jus.br', NULL, '2019-04-15 16:52:37', '2019-04-15 16:52:37'),
(257, 48, 5, 'Dermeval Ribeiro Vianna Filho', 'prsc-tubarao@mpf.mp.br', '48 3302-1000', '2019-04-22 13:03:23', '2019-04-22 13:03:23'),
(258, 104, 3, 'Vitoraldo Bridi', 'capital.civel2@tjsc.jus.br', NULL, '2019-04-22 18:15:39', '2019-04-22 18:15:39'),
(259, 113, 4, 'Fabiane Kruetzmann Schapinsky', 'fksc@tjpr.jus.br', '(41) 3033-4606', '2019-04-23 13:47:29', '2019-04-23 13:47:29'),
(260, 84, 2, 'Anúbia Secco Giaretta', 'pru4.corepam@agu.gov.br', NULL, '2019-04-24 18:39:35', '2019-04-24 18:39:35'),
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
(272, 84, 5, 'Júlio Cesar Alves Rodrigues Júnior', 'julio.junior@pgfn.gov.br', NULL, '2019-05-23 18:53:18', '2019-05-23 18:53:18');

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
(3, 'Juíz', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(4, 'Juíza', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(5, 'Procurador', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(6, 'Procuradora', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(7, 'Superintendente', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(8, 'Superintendente', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(9, 'Gerente', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(10, 'Gerente', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(11, 'Presidente', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(12, 'Presidente', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(13, 'Coordenador', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(14, 'Coordenadora', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(15, 'Chefe', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(16, 'Chefe', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(17, 'Diretor', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(18, 'Diretora', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(19, 'Secretário', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(20, 'Secretária', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(21, 'Ministro', '2019-01-22 22:00:01', '2019-01-22 22:00:01'),
(22, 'Ministra', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(23, 'Assessor', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(24, 'Assessora', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(25, 'Secretário-Adjunto', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(26, 'Secretária-Adjunta', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(27, 'Coordenador-Geral', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(28, 'Coordenadora-Geral', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(29, 'Chefe de Gabinete', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(30, 'Chefe de Gabinete', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(31, '', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(32, '', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(33, 'Procurador-Chefe', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(34, 'Procuradora-Chefe', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(35, 'Procurador Substituto', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(36, 'Procuradora Substituta', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(37, 'Procurador Seccional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(38, 'Procuradora Seccional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(39, 'Procurador Seccional Subst.', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(40, 'Procuradora Seccional Subst.', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(41, 'Prefeito Municipal', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(42, 'Prefeita Municipal', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(43, 'Procurador-Chefe Substituto', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(44, 'Procuradora-Chefe Substituta', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(45, 'Procurador-Geral Federal', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(46, 'Procuradora-Geral Federal', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(47, 'Subprocurador-Geral Federal', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(48, 'Subprocuradora-Geral Federal', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(49, 'Promotora', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(50, 'Promotor', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(51, 'Delegada', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(52, 'Delegado', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(53, 'Vereadora', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(54, 'Vereador', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(55, 'Técnica', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(56, 'Técnico', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(57, 'Subprocurador Regional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(58, 'Subprocuradora Regional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(59, 'Procurador Regional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(60, 'Procuradora Regional', '2019-01-22 22:00:02', '2019-01-22 22:00:02'),
(61, 'Chefe de Divisão', NULL, NULL),
(62, 'Outro', NULL, NULL);

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
-- Estrutura da tabela `demanda`
--

CREATE TABLE `demanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `idTipoDocumento` int(10) UNSIGNED NOT NULL,
  `documentoExterno` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nupSEI` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `demanda` text COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `demanda`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(1, 1, '02313/2018', '04972.005144/2017-72', 'apresentar nos autos o exato posicionamento dos terrenos e acrescidos de marinha nas áreas compreendidas nas transcrições nº 12.480, nº 12.481 e nº 3.386 (evento 1, OUT35, fls. 16-33) e na matrícula nº 13.204 (evento 1, OUT35, fls. 13-15) do Cartório de Registro de Imóveis de Laguna, a fim de facilitar o deslinde do feito', NULL, '2019-01-30', '2019-04-23 12:52:45', 9, 3, '2019-01-23 20:13:55', '2019-04-24 16:50:49', 224, 3, 0, NULL, 13),
(2, 1, '01024/2017', '04972.205757/2015-46', 'informar quanto aos desdobramentos das medidas administrativas tendentes à demolição do imóvel em questão, além de realização de diligência no local para esclarecer as dúvidas suscitadas pelo Sr. Oficial de Justiça-Avaliador no Evento 54, a fim de demonstrar de modo inequívoco qual é o bem objeto da demolição', NULL, '2018-06-18', NULL, 9, NULL, '2019-02-14 21:38:39', '2019-03-06 18:03:52', 114, 2, 1, NULL, 7),
(3, 1, '01530/2018', '04972.010691/2018-51', 'prestar informações sobre o interesse da União na causa,tendo em consideração, os documentos juntados nos ev. 49, 51 e 54 do e-proc', NULL, '2019-01-07', '2019-05-09 18:59:39', 9, 8, '2019-02-14 21:41:45', '2019-05-09 18:59:40', 100, 3, 0, NULL, 12),
(4, 1, '02321/2018', '04972.008386/2018-07', 'demanda resolvida antes da entrada deste sistema em produção', NULL, '2018-11-13', '2019-03-06 18:23:20', 9, NULL, '2019-02-14 21:44:01', '2019-03-06 18:23:20', 226, 3, 0, NULL, 5),
(5, 1, '02477/2018', '04972.005805/2017-60', 'informar se há interesse da União no feito', NULL, '2018-11-20', '2019-05-09 18:57:17', 9, 8, '2019-02-14 21:46:09', '2019-05-09 18:57:18', 226, 3, 0, NULL, 9),
(6, 1, '02705/2018', '05022.000974/2002-29', 'esclarecer a divergência entre os 73 imóveis/processos administrativos relatados no Ofício 105133/2018-MP, contra as 120 (cento e vinte) edificações naquele local, conforme a Nota  Técnica  nº  9558/2016-MP', NULL, '2018-12-14', NULL, 9, NULL, '2019-02-14 21:47:54', '2019-03-06 18:39:10', 100, 2, 0, NULL, 11),
(7, 1, '04264/2018', '04972.005990/2018-73', 'manifestar expressamente sobre a aceitação ou não da Recomendação nº 23/2018', NULL, '2018-10-09', NULL, 9, 8, '2019-02-14 21:49:55', '2019-05-10 12:50:37', 86, 2, 0, NULL, 8),
(8, 1, '05979/2018', '04972.002880/2013-45', 'demanda atendida antes da entrada deste sistema em produção', NULL, '2019-02-04', '2019-03-06 19:06:12', 9, NULL, '2019-02-14 21:50:59', '2019-03-06 19:06:12', 89, 3, 0, NULL, 5),
(9, 1, '00009/2019', '04972.003497/2017-38', 'fornecer manifestação conclusiva acerca do pedido de usucapião, considerando os novos documentos apresentados pela parte autora no ev. 69, do E-proc, que acompanhou o Ofício 9/2018 (7768034)', NULL, '2019-01-23', '2019-03-06 18:53:28', 9, NULL, '2019-02-14 21:53:51', '2019-03-06 18:53:28', 100, 3, 0, NULL, 5),
(10, 1, '00030/2019', '00552.000186/2015-45', 'demanda resolvida', NULL, '2019-01-24', '2019-03-06 17:47:52', 9, NULL, '2019-02-14 21:55:29', '2019-03-06 17:47:52', 100, 3, 0, NULL, 5),
(11, 1, '00035/2019', '04972.000697/2019-09', 'manifestar eventual interesse da União na lide', NULL, '2019-02-08', '2019-05-10 12:18:02', 9, 8, '2019-02-14 21:58:34', '2019-05-10 12:18:03', 99, 3, 0, NULL, 14),
(12, 1, '00037/2019', '04972.000529/2019-13', 'demanda atendida antes da entrada em produção deste sistema', NULL, '2019-02-05', '2019-03-06 19:07:32', 9, NULL, '2019-02-14 21:59:53', '2019-03-06 19:07:32', 100, 3, 0, NULL, 5),
(13, 1, '00073/2019', '04972.206605/2015-61', 'prestar informações sobre vistoria realizada no local e possível regularização da ocupação/atividade', NULL, '2019-02-23', '2019-05-08 14:05:08', 9, 1, '2019-02-14 22:01:30', '2019-05-08 14:05:09', 82, 3, 0, NULL, 15),
(14, 1, '01193/2018', '04972.006141/2017-56', 'informar quais as medidas adotadas para sanar as irregularidades constantes no item \"5\" da Nota Técnica n.20285/2017-MP, pois coincidem com o objeto do procedimento em epígrafe (anexos seguem os ofícios enviados e a referida Nota Técnica).', NULL, '2018-12-03', '2019-03-15 14:41:50', 9, 1, '2019-02-14 22:04:02', '2019-03-15 14:41:50', 225, 3, 0, NULL, 10),
(16, 1, '123/2018', '0000000000011111', 'asdasdasd', NULL, '2019-02-21', NULL, 9, NULL, '2019-02-21 16:21:04', '2019-03-01 13:38:50', 224, 4, 0, NULL, 5),
(17, 1, '127/2019', '04972.001010/2019-44', '', NULL, '2019-03-04', '2019-02-21 21:14:08', 9, NULL, '2019-02-21 20:31:49', '2019-02-21 21:14:08', 82, 3, 0, NULL, 1),
(18, 1, '00081/2019', '04972.206525/2015-13', '', NULL, '2019-03-14', NULL, 9, 3, '2019-02-21 21:27:31', '2019-04-24 18:11:21', 228, 4, 1, NULL, 2),
(19, 1, '01057/2018', '04972.010712/2018-38', 'informar se há interesse da União na ação judicial', NULL, '2019-01-07', '2019-03-06 18:52:15', 9, NULL, '2019-02-22 17:55:34', '2019-03-06 18:52:15', 121, 3, 0, NULL, 3),
(20, 1, '23131', '04972.000000000', 'informar sobre interesse da União', NULL, '2019-03-13', NULL, 9, NULL, '2019-02-28 16:43:55', '2019-03-06 18:04:19', 3, 4, 1, NULL, 1),
(21, 1, '12312', '9999999999999999', 'era apenas um teste', NULL, NULL, NULL, 9, NULL, '2019-03-01 13:50:10', '2019-03-06 17:49:28', 1, 4, 0, NULL, 1),
(22, 1, '2755/2018', '04972.010715/2018-71', 'informar sobre interesse da União na área objeto da lide', NULL, '2018-12-26', '2019-03-26 18:45:11', 9, 1, '2019-03-07 13:48:31', '2019-03-26 18:45:11', 126, 3, 0, NULL, 16),
(23, 1, '55/2019', '04972.001594/2019-58', 'Prestar as informações para a defesa judicial da União no caso concreto', NULL, '2019-03-11', '2019-03-26 18:54:13', 9, 1, '2019-03-07 17:59:05', '2019-03-26 18:54:13', 224, 3, 0, NULL, 17),
(24, 1, '300/2019', '04972.001526/2017-27', 'Ciência acerca do acordo celebrado nos autos.', NULL, NULL, '2019-04-12 16:53:55', 9, 8, '2019-03-07 18:49:25', '2019-04-12 16:53:55', 126, 3, 1, NULL, 18),
(25, 1, '320/2019', '04972.001644/2019-05', 'Manifestação quanto à interferência da área.', NULL, '2019-03-22', '2019-04-08 14:02:51', 9, 4, '2019-03-08 13:03:19', '2019-04-08 14:02:51', 114, 3, 0, NULL, 19),
(26, 1, '123/2019', '04972.001654/2019-32', 'Cópia integral do processo administrativo referente ao RIP 8319.0000038-52.', NULL, '2019-03-18', '2019-05-09 18:53:22', 9, 8, '2019-03-08 16:55:18', '2019-05-09 18:53:23', 201, 3, 0, NULL, 20),
(27, 1, '040/2019', '04972.000143/2019-01', 'A sentença condena  o réu particular nos itens a, b, em síntese, nas obrigações de  elaboração do PRAD,  na retirada das edificações existentes, bem como a recuperação da área degradada em até 90 (noventa) dias do trânsito em julgado da presente ação. Também no item c a regularização da inscrição de ocupação da área junto à SPU. No entanto, sentencia também no item 2, que em caso de não execução do PRAD, caberá a União Federal cumprir a determinação judicial (sentença), nos termos do réu particular. Por fim, no item 2.1 determina que a União providencie a averbação junto ao Cartório de Registro de Imóveis competente, da informação de que os imóveis que compõem a área objeto da ação são pertencentes União e constituem áreas de preservação.', NULL, NULL, '2019-03-12 14:45:43', 9, NULL, '2019-03-11 13:48:24', '2019-03-12 14:45:43', 201, 3, 1, NULL, 22),
(28, 1, '196/2019', '04972.001694/2019-84', 'Cumprimento da decisão Liminar para suspensão da exigibilidade e imediata retirada do nome do autor da titularidade do RIP : 8111.0000472-15.', NULL, '2019-03-20', '2019-05-09 18:42:25', 9, 8, '2019-03-11 13:58:49', '2019-05-09 18:42:27', 231, 3, 1, NULL, 23),
(29, 1, '632/2019', '04972.001197/2019-86', 'A adoção de providências para viabilizar o cadastramento da comunidade Quilombola Vidal Martins.', NULL, NULL, '2019-03-11 17:22:01', 9, NULL, '2019-03-11 17:22:01', '2019-03-11 17:22:01', 86, 3, 0, NULL, 24),
(30, 1, '34/2019', '04972.001156/2019-90', 'Manifestação sobre interesse.', NULL, NULL, '2019-03-11 17:30:50', 9, NULL, '2019-03-11 17:30:50', '2019-03-11 17:30:50', 224, 3, 0, NULL, 25),
(31, 1, '21/2019', '04972.205163/2015-35', 'Análise de nova documentação.', NULL, '2019-02-08', '2019-03-11 17:41:13', 9, NULL, '2019-03-11 17:41:13', '2019-03-11 17:41:13', 224, 3, 0, NULL, 26),
(32, 1, '131/2019', '04972.001751/2019-25', 'Manifestação de Interesse- Usucapião Federal.', NULL, '2019-03-23', '2019-04-08 18:40:47', 9, 1, '2019-03-11 17:59:17', '2019-04-08 18:40:47', 121, 3, 0, NULL, 27),
(33, 1, '00047/2019', '04972.008875/2018-51', 'Informar se há interesse da União. Já existe manifestação prévia, porém inconclusiva por falta de delimitação mínima da área.', NULL, '2019-03-05', '2019-03-27 18:10:35', 9, 1, '2019-03-11 18:05:10', '2019-03-27 18:10:35', 224, 3, 0, NULL, 28),
(34, 1, '334/2019', '04972.005401/2016-95', 'Manifestação sobre Laudo Pericial.', NULL, '2019-03-21', '2019-03-26 19:13:05', 9, 1, '2019-03-11 18:32:02', '2019-03-26 19:13:05', 126, 3, 0, NULL, 29),
(35, 1, '00020/2019', '00638304220118240023', 'apresentar memorial/planta legível com coordenadas UTM em que demonstre a interferência com área de marinha', NULL, '2019-03-18', '2019-03-19 14:17:39', 9, 1, '2019-03-11 18:32:30', '2019-03-19 14:17:39', 224, 3, 0, NULL, 30),
(36, 1, '00031/2019', '03002583120158240045', 'apresentar memorial/planta legível com coordenadas UTM em que demonstre a interferênciacom área de marinha', NULL, '2019-02-26', '2019-03-15 14:14:38', 9, 3, '2019-03-11 18:37:36', '2019-03-15 14:14:38', 224, 3, 0, NULL, 31),
(37, 1, '00050/2019', '04972.008783/2018-71', 'Analisar o levantamento topográfico fornecido pelo Município de Biguaçu e produzir manifestação sobre interesse da União no feito.', NULL, '2019-03-11', '2019-03-19 14:14:36', 9, 1, '2019-03-12 12:52:09', '2019-03-19 14:14:36', 224, 3, 0, NULL, 33),
(38, 1, '00021/2019', '04972.205163/2015-35', 'Demanda atendida antes do seu cadastramento', NULL, '2019-02-08', '2019-03-12 13:52:44', 9, NULL, '2019-03-12 13:52:44', '2019-03-12 13:52:44', 224, 3, 0, NULL, 26),
(39, 1, '00028/2019', '04972.004990/2016-94', 'manifestação sobre o laudo pericial complementar juntado, prova pericial cujo objetivo é encontrar o cálculo da indenização devida pela União relacionada ao prédio localizado na Avenida Irineu Bornhausen, 5034', NULL, '2019-03-12', '2019-03-15 17:16:31', 9, 1, '2019-03-12 14:03:46', '2019-03-15 17:16:31', 224, 3, 0, NULL, 34),
(40, 1, '00042/2019', '04972.004792/2017-10', 'indicar assistente técnico e formular quesitos', NULL, '2019-03-08', '2019-03-15 14:09:35', 9, 3, '2019-03-12 14:59:04', '2019-03-15 14:09:35', 224, 3, 0, NULL, 35),
(41, 1, '00008/2019', '04972.006449/2016-11', 'adotar eventuais providências decorrentes da sentença proferida no procedimento referenciado', NULL, NULL, NULL, 9, NULL, '2019-03-12 18:19:25', '2019-03-12 18:19:25', 224, 2, 0, NULL, 36),
(42, 3, '123/2019', '04972.000000/0000-00', 'asd asd asd asd 2 2', NULL, NULL, NULL, 1, 1, '2019-03-12 21:00:21', '2019-03-13 14:15:08', 159, 4, 0, NULL, 5),
(43, 1, '7/2019', '04972.006143/2017-45', 'Manifestação sobre Laudo Pericial.', NULL, '2019-03-21', '2019-05-10 12:19:31', 4, 8, '2019-03-13 17:19:46', '2019-05-10 12:20:06', 214, 3, 0, NULL, 37),
(44, 1, '386/2017', '04972.001699/2017-45', 'Informa o trânsito em julgado da sentença para decretar a nulidade de todo os atos processuais posteriores à citação e da sentença prolatada no processo de Retificação de Registro Imobiliário n° 1.899/1992(031.92.000091-7), que tramitou junto a 2ª Vara da Comarca de Indaial -Santa Catarina, atingidos ainda todos os atos processuais subsequentes, bem como as averbações deles decorrentes.', NULL, NULL, '2019-05-09 18:41:02', 4, 8, '2019-03-13 18:20:04', '2019-05-09 18:41:03', 99, 3, 1, NULL, 38),
(45, 2, '8088493', '04972.001471/2019-17', 'subsídios para defesa dos interesses da União no curso da Ação, especificamente em relação a data de início da revisão financeira em virtude de revisão cadastral de imóvel inserido parcialmente na cessão ao Município de Bombinhas/SC (Projeto Orla).', NULL, '2019-03-13', '2019-03-13 18:26:55', 8, NULL, '2019-03-13 18:26:55', '2019-03-13 18:26:55', 22, 3, 0, NULL, 39),
(46, 1, '241/2019', '04972.003786/2018-18', 'Manifestação sobre nova documentação', NULL, NULL, '2019-04-23 17:00:14', 4, 4, '2019-03-13 19:00:23', '2019-04-23 17:00:26', 100, 3, 0, NULL, 40),
(48, 1, '00011/2019', '04972.000452/2019-73', 'assistente técnico e apresentação de quesitos no que toca a perícia de engenharia.\r\nO feito tem conexão com os autos da ação civil pública n. 5001840-53.2011.404.7201.', NULL, '2019-02-04', '2019-03-27 17:26:29', 8, 1, '2019-03-14 11:42:34', '2019-03-27 17:26:29', 228, 3, 0, NULL, 42),
(49, 1, '00091/2019', '04972.000532/2019-29', 'manifestação em defesa dos interesses da União quanto à interferência da área.', NULL, '2019-02-07', '2019-03-19 13:15:41', 8, 4, '2019-03-14 11:58:41', '2019-03-19 13:15:41', 114, 3, 0, NULL, 43),
(50, 1, '00043/2019', '04972.000807/2019-24', 'manifestação de eventual interesse na lide.', NULL, '2019-02-13', '2019-03-27 20:33:11', 8, 1, '2019-03-14 12:39:45', '2019-03-27 20:33:11', 228, 3, 0, NULL, 44),
(51, 1, '260/2019', '04972.001801/2019-74', 'Encaminha  o Parecer de Força Executória 22/2019, informando a nulidade do procedimento demarcatório por ausência de intimação pessoal dos ora interessados em relação às unidades do Condomínio Edifício Itambei, com sede na Rua 153, esquina com a Avenida Beira Mar, Centro, na cidade de Itapema – SC , ressalvando a possibilidade de realização de novo procedimento demarcatório.', NULL, NULL, NULL, 4, NULL, '2019-03-14 13:32:14', '2019-03-14 13:32:14', 100, 2, 1, NULL, 45),
(53, 1, '13/2019', '04972.006827/2018-28', 'Indicação de assistente Técnico e quesitos.', NULL, '2019-03-21', '2019-03-27 17:42:24', 4, 1, '2019-03-14 14:24:07', '2019-03-27 17:42:24', 126, 3, 0, NULL, 47),
(54, 1, '1609/2018', '04972.006827/2018-28', 'Manifestação de Interesse', NULL, NULL, '2019-03-14 16:36:30', 4, NULL, '2019-03-14 16:36:30', '2019-03-14 16:36:30', 114, 3, 0, NULL, 47),
(55, 1, '276/2019', '04972.006225/2018-71', 'Fornecimento de documentos solicitados pelo Perito.', NULL, '2019-03-27', '2019-04-10 14:33:52', 4, 1, '2019-03-14 16:45:20', '2019-04-10 14:33:52', 100, 3, 0, NULL, 46),
(56, 1, '725/2018', '04972.006225/2018-71', 'Cópia do Procedimento Demarcatório.', NULL, NULL, '2019-03-14 16:47:37', 4, NULL, '2019-03-14 16:47:37', '2019-03-14 16:47:37', 100, 3, 0, NULL, 46),
(57, 1, '24/2019', '04972.000320/2019-41', 'Proceder à demolição da edificação em questão, devendo contatar diretamente o IMA – Instituto do meio ambiente de Santa Catarina para acompanhar o processo de remoção do material.', NULL, '2019-03-20', '2019-04-08 18:37:37', 4, 1, '2019-03-14 17:34:03', '2019-04-08 18:37:37', 100, 3, 1, NULL, 48),
(58, 1, '21/2019', '04972.000600/2019-50', 'Manifestação de Interesse.', NULL, '2019-02-01', '2019-03-14 18:01:56', 4, 4, '2019-03-14 17:54:05', '2019-03-14 18:01:56', 228, 3, 0, NULL, 41),
(59, 1, '282/2019', '04972.009330/2018-61', 'Indicação de assistente técnico e quesitos.', NULL, '2019-03-04', '2019-03-14 18:17:56', 4, NULL, '2019-03-14 18:17:56', '2019-03-14 18:17:56', 143, 3, 0, NULL, 50),
(60, 1, '203/2019', '04972.001196/2019-31', 'Indicação de assistente técnico e quesitos.', NULL, '2019-02-18', '2019-03-14 18:50:28', 4, NULL, '2019-03-14 18:50:28', '2019-03-14 18:50:28', 143, 3, 0, NULL, 51),
(61, 1, '78/2019', '04972.000516/2019-36', 'Manifestação acerca da interferência da área da União.', NULL, '2019-02-28', '2019-03-14 19:30:18', 4, NULL, '2019-03-14 19:30:18', '2019-03-14 19:30:18', 143, 3, 0, NULL, 52),
(62, 1, '29/2019', '04972.205274/2015-41', 'Manifestação sobre Laudo Pericial.', NULL, '2019-02-20', '2019-03-14 19:46:05', 4, NULL, '2019-03-14 19:46:05', '2019-03-14 19:46:05', 228, 3, 0, NULL, 53),
(63, 1, '00045/2019', '04972.001385/2018-23', 'manifestação acerca do Laudo Pericial.\r\nConstrução irregular na Ponta do Papagaio, em Palhoça/SC', NULL, '2019-03-15', '2019-03-26 19:38:18', 8, 3, '2019-03-15 11:54:52', '2019-03-26 19:38:18', 224, 3, 0, NULL, 54),
(64, 1, '0165/2019', '04972.200783/2015-88', 'subsídios de fato e de direito para a defesa da União na ação de usucapião, especialmente ratificando\nou retificando o parecer técnico nº COCAP-SP-SC 0105862.', NULL, '2019-02-15', '2019-03-26 19:10:57', 8, 1, '2019-03-15 12:30:20', '2019-03-26 19:10:57', 126, 3, 0, NULL, 55),
(65, 1, '3766/2018', '04972.006191/2018-14', 'Informação acerca de como o projeto orla trata da pesca em pontes', NULL, NULL, '2019-03-27 14:10:02', 3, 3, '2019-03-15 14:23:02', '2019-03-27 14:10:02', 90, 3, 0, NULL, 56),
(66, 1, '99999', '9999999999999999', '999999999', NULL, '2019-03-09', '2019-03-15 17:46:26', 1, 1, '2019-03-15 17:25:03', '2019-03-15 17:46:26', 159, 3, 0, NULL, 5),
(67, 1, '144/2019', '04972.001824/2019-89', 'Manifestação de Interesse', NULL, '2019-03-29', '2019-04-08 18:31:43', 4, 1, '2019-03-15 19:08:50', '2019-04-08 18:31:43', 228, 3, 0, NULL, 58),
(68, 1, '146/2019', '04972.001826/2019-78', 'Manifestação de Interesse', NULL, '2019-03-29', '2019-04-08 18:32:10', 4, 1, '2019-03-15 19:15:35', '2019-04-08 18:32:10', 228, 3, 0, NULL, 59),
(69, 1, '2624/2018', '04972.010279/2018-31', 'manifestação quanto à interferência da área em questão.', NULL, '2018-12-03', '2019-03-20 17:05:45', 8, 1, '2019-03-18 16:14:19', '2019-03-20 17:05:45', 114, 3, 0, NULL, 61),
(70, 1, '00277/2019', '04972.004678/2017-81', 'Elaboração de Documento Técnico Conjunto que registre todas as intervenções, edificações ou acessões feitas até agora sobre os bens da União na região definida no item 1.\r\nMulta diária de R$ 10.000,00', NULL, '2019-03-11', NULL, 1, NULL, '2019-03-18 17:33:43', '2019-03-18 17:33:43', 114, 2, 1, NULL, 62),
(71, 1, '140/2019', '04972.006757/2011-31', 'informar se  tem interesse em cumprir a ordem de reintegração de posse do imóvel e se já há definição na destinação do imóvel e se há viabilidade de o ocupante adquirir o imóvel, informando as condições e procedimento, neste caso.', NULL, '2019-03-29', '2019-05-10 17:08:53', 4, 3, '2019-03-18 18:19:35', '2019-05-10 17:08:55', 228, 3, 0, NULL, 60),
(72, 1, '141/2019', '04972.001828/2019-67', 'Cumprimento de sentença consistente na  elaboração de Plano de Recuperação da Área Degradada - PRAD, a ser submetido aocrivo do IBAMA e da FATMA, o qual deverá prever a integral recuperação ambiental.', NULL, '2019-06-27', NULL, 4, 1, '2019-03-18 18:39:15', '2019-04-08 18:16:39', 99, 2, 1, NULL, 63),
(73, 1, '143/2018', '04972.001829/2019-10', 'Manifestação de Interesse.', NULL, NULL, '2019-05-09 17:33:19', 4, 1, '2019-03-18 19:23:16', '2019-05-09 17:33:29', 121, 3, 0, NULL, 64),
(74, 1, '366/2019', '04972.001831/2019-81', 'Informar se o imóvel de inscrição imobiliária n° 40.15.072.0805.001-852, está situado em terreno de marinha, e caso positivo, informe sobre a possível cessão de direitos de ocupação de terreno de marinha, bem como sobre os responsáveis pelo pagamento do respectivo laudêmio.', NULL, '2019-03-25', '2019-04-11 13:14:39', 4, 4, '2019-03-18 19:36:44', '2019-04-11 13:14:39', 232, 3, 0, NULL, 65),
(75, 1, '0153/2019', '04972.001420/2019-95', 'manifestação de interesse na lide.', NULL, '2019-03-20', NULL, 8, 5, '2019-03-19 11:42:53', '2019-04-03 19:36:39', 100, 2, 0, NULL, 66),
(76, 1, '2467/2018', '04972.009450/2018-69', 'aferir se a área descrita na denúncia interfere com propriedade da União.', NULL, NULL, NULL, 8, NULL, '2019-03-19 11:59:07', '2019-03-19 11:59:07', 224, 2, 1, NULL, 67),
(77, 1, '92/2019', '04972.001854/2019-95', 'Informações e documentos referentes ao referido bem imóvel.', NULL, NULL, NULL, 4, NULL, '2019-03-19 13:07:36', '2019-03-19 13:07:36', 103, 2, 0, NULL, 68),
(78, 1, '2673/2016', '04972.003900/2016-48', 'Manifestação de Interesse.', NULL, NULL, '2019-03-19 13:37:58', 4, 4, '2019-03-19 13:37:49', '2019-03-19 13:37:58', 167, 3, 0, NULL, 71),
(79, 1, '588/2018', '04972.003900/2016-48', 'Indicação de assistente técnico e quesitos.', NULL, NULL, '2019-03-19 13:39:52', 4, 4, '2019-03-19 13:39:45', '2019-03-19 13:39:52', 224, 3, 0, NULL, 71),
(80, 1, '2774/2018', '04972.003900/2016-48', 'Manifestação sobre Laudo Pericial', NULL, NULL, '2019-03-19 13:42:29', 4, 4, '2019-03-19 13:42:27', '2019-03-19 13:42:29', 114, 3, 0, NULL, 71),
(81, 1, '2182/2018', '04972.008923/2018-19', 'Manifestação de Interesse.', NULL, NULL, '2019-03-19 14:08:48', 4, 4, '2019-03-19 14:08:45', '2019-03-19 14:08:48', 224, 3, 0, NULL, 72),
(82, 1, '40/2019', '04972.008923/2018-19', 'Manifestação de Interesse.', NULL, NULL, '2019-03-19 14:10:28', 4, 4, '2019-03-19 14:10:20', '2019-03-19 14:10:28', 224, 3, 0, NULL, 72),
(83, 1, '1173/2017', '04972.001675/2017-96', 'Informações para a defesa judicial da União no caso concreto, notadamente sobre a alegação de essa SPU ter-se quedado inerte diante da notícia da ilegalidade perpetrada pelo réu pessoa física, bem como os desdobramentos da recomendação do MPF.', NULL, NULL, '2019-03-19 14:23:08', 4, 4, '2019-03-19 14:22:53', '2019-03-19 14:23:08', 167, 3, 0, NULL, 73),
(84, 1, '2671/2017', '04972.001675/2017-96', 'Subsídios de fato e de direito que possam ser empregados na defesa da\nUnião no feito.', NULL, NULL, '2019-03-19 14:28:33', 4, 4, '2019-03-19 14:28:30', '2019-03-19 14:28:33', 199, 3, 0, NULL, 73),
(85, 1, '571/2017', '04972.001712/2017-66', 'Manifestação de Interesse.', NULL, NULL, '2019-03-19 18:30:43', 4, 4, '2019-03-19 18:30:39', '2019-03-19 18:30:43', 119, 3, 0, NULL, 74),
(86, 1, '152/2019', '04972.001712/2017-66', 'Designar servidor para audiência.', NULL, '2019-04-22', '2019-04-29 20:18:15', 4, 1, '2019-03-19 18:33:39', '2019-04-29 20:18:18', 121, 3, 0, NULL, 74),
(87, 1, '1660/2017', '04972.007162/2017-99', 'Manifestação de Interesse.', NULL, NULL, '2019-03-19 18:58:06', 4, 4, '2019-03-19 18:57:31', '2019-03-19 18:58:06', 119, 3, 0, NULL, 75),
(89, 1, '24/2019', '04972.007162/2017-99', 'Manifestação de Interesse.', NULL, '2019-03-01', '2019-03-19 19:00:00', 4, 4, '2019-03-19 18:59:55', '2019-03-19 19:00:00', 228, 3, 0, NULL, 75),
(90, 1, '0211/2019', '04972.002267/2016-71', 'indicação de preposto para representar a SPU na audiência designada para a data de 11/04/2019, às 14 horas.', NULL, '2019-04-08', '2019-04-02 12:19:59', 8, 8, '2019-03-20 14:06:09', '2019-04-02 12:19:59', 114, 3, 0, NULL, 76),
(91, 1, '1574/2018', '04972.010714/2018-27', 'Manifestação de Interesse', NULL, NULL, '2019-03-20 17:52:27', 4, 4, '2019-03-20 17:52:23', '2019-03-20 17:52:27', 100, 3, 0, NULL, 77),
(94, 1, '955/2019', '04972.001755/2019-11', 'Informar sobre autorização para realização do evento descrito no Procedimento Externo relacionado.', NULL, '2019-03-26', '2019-03-21 17:16:47', 1, 1, '2019-03-21 17:16:38', '2019-03-21 17:16:47', 95, 3, 0, NULL, 79),
(95, 1, '00164/2019', '04972.001447/2019-88', 'informar sobre o interesse da União na lide.', NULL, '2019-03-23', '2019-04-10 14:27:35', 8, 1, '2019-03-25 12:30:42', '2019-04-10 14:27:35', 100, 3, 0, NULL, 80),
(96, 1, '2402/2018/PU/SC', '04972.000966/2017-67', 'acompanhamento para cumprimento do acordo homologado.', NULL, NULL, '2019-04-03 18:12:19', 8, 8, '2019-03-25 13:30:42', '2019-04-03 18:12:19', 143, 3, 1, NULL, 81),
(97, 1, '33/2019', '04972.000689/2019-54', 'Manifestação de Interesse.', NULL, NULL, '2019-03-25 17:46:35', 4, 4, '2019-03-25 17:46:31', '2019-03-25 17:46:35', 121, 3, 0, NULL, 82),
(98, 1, '180/2019', '04972.001951/2019-88', 'Providências administrativas que entender pertinentes.', NULL, NULL, NULL, 4, NULL, '2019-03-25 18:14:53', '2019-03-25 18:14:53', 225, 2, 0, NULL, 83),
(99, 6, '01', '04972.010624/2018-36', 'Anotação de Indisponibilidade do Direito de Ocupação', NULL, NULL, '2019-03-26 12:57:54', 8, 8, '2019-03-26 12:57:50', '2019-03-26 12:57:54', 233, 3, 1, NULL, 84),
(100, 6, '01', '04972.010624/2018-36', 'Anotação de Indisponibilidade do Direito de Ocupação', NULL, NULL, '2019-03-26 13:00:00', 8, 8, '2019-03-26 12:59:57', '2019-03-26 13:00:00', 233, 3, 1, NULL, 85),
(101, 6, '01', '04972.010624/2018-36', 'Anotação de Indisponibilidade do Direito de Ocupação', NULL, NULL, '2019-03-26 13:01:49', 8, 8, '2019-03-26 13:01:47', '2019-03-26 13:01:49', 233, 3, 1, NULL, 87),
(102, 6, '01', '04972.010624/2018-36', 'Anotação de Indisponibilidade do Direito de Ocupação', NULL, NULL, '2019-03-26 13:03:16', 8, 8, '2019-03-26 13:03:15', '2019-03-26 13:03:16', 233, 3, 1, NULL, 86),
(103, 1, '37/2019', '04972.001325/2019-91', 'Manifestação de Interesse.', NULL, '2019-03-08', '2019-03-26 13:57:52', 4, 4, '2019-03-26 13:57:42', '2019-03-26 13:57:52', 224, 3, 0, NULL, 88),
(104, 1, '1548/2016', '04972.006197/2016-20', 'Subsídios de fato e direito.', NULL, NULL, '2019-03-26 16:35:08', 4, 4, '2019-03-26 16:34:21', '2019-03-26 16:35:08', 107, 3, 0, NULL, 89),
(105, 1, '00400/2018', '04972.010399/2018-38', 'manifestação se o imóvel objeto da lide interfere com patrimônio da União.', NULL, '2019-03-26', '2019-03-26 16:42:00', 8, 8, '2019-03-26 16:41:46', '2019-03-26 16:42:00', 228, 3, 0, NULL, 90),
(106, 1, '1505/2016', '04972.006077/2016-22', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 16:43:20', 4, 4, '2019-03-26 16:43:17', '2019-03-26 16:43:20', 119, 3, 0, NULL, 91),
(107, 1, '1566/2016', '04972.006199/2016-19', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 16:46:46', 4, 4, '2019-03-26 16:46:43', '2019-03-26 16:46:46', 107, 3, 0, NULL, 93),
(108, 1, '1607/2016', '04972.006348/2016-40', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 16:54:47', 4, 4, '2019-03-26 16:54:45', '2019-03-26 16:54:47', 107, 3, 0, NULL, 94),
(109, 1, '1617/2016', '04972.006397/2016-82', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 17:00:03', 4, 4, '2019-03-26 16:59:58', '2019-03-26 17:00:03', 107, 3, 0, NULL, 95),
(110, 1, '1644/2016', '04972.006463/2016-14', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 17:28:27', 4, 4, '2019-03-26 17:28:25', '2019-03-26 17:28:27', 105, 3, 0, NULL, 96),
(111, 1, '1648/2016', '04972.006466/2016-58', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 17:33:17', 4, 4, '2019-03-26 17:33:16', '2019-03-26 17:33:17', 105, 3, 0, NULL, 97),
(112, 1, '1647/2016', '04972.006467/2016-01', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 17:40:54', 4, 4, '2019-03-26 17:40:50', '2019-03-26 17:40:54', 105, 3, 0, NULL, 98),
(113, 1, '1685/2016', '04972.006551/2016-16', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-26 17:58:32', 4, 4, '2019-03-26 17:58:30', '2019-03-26 17:58:32', 121, 3, 0, NULL, 99),
(114, 1, '1690/2016', '04972.006577/2016-64', 'Suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014- TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-26 18:12:55', 4, 4, '2019-03-26 18:12:50', '2019-03-26 18:12:55', 107, 3, 0, NULL, 94),
(115, 1, '1693/2016', '04972.006587/2016-08', 'Suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014- TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluído.', NULL, NULL, '2019-03-26 18:31:06', 4, 4, '2019-03-26 18:31:04', '2019-03-26 18:31:06', 107, 3, 0, NULL, 101),
(116, 1, '1699/2016', '04972.006624/2016-70', 'Determinar a suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014-TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-26 18:50:12', 4, 4, '2019-03-26 18:50:10', '2019-03-26 18:50:12', 57, 3, 0, NULL, 99),
(117, 1, '1694/2016', '04972.006605/2016-43', 'Suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014- TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-26 19:02:18', 4, 4, '2019-03-26 19:02:00', '2019-03-26 19:02:18', 107, 3, 0, NULL, 103),
(118, 1, '1698/2016', '04972.006623/2016-25', 'Suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014-TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-26 19:46:09', 4, 4, '2019-03-26 19:12:42', '2019-03-26 19:46:09', 57, 3, 0, NULL, 104),
(119, 1, '1708/2016', '04972.006653/2016-31', 'Suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014- TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-26 19:56:37', 4, 4, '2019-03-26 19:56:35', '2019-03-26 19:56:37', 107, 3, 0, NULL, 105),
(120, 1, '154/2019', '04972.001356/2017-81', 'Reitera solicitação de resposta ao Ofício 845/2017-GABPRM5-FPS (3838831), de 15/05/2017, reiterado pelo Ofício nº 865/2018-GABPRM5-FPS (6272981), de 16/05/2018.', NULL, '2019-03-11', '2019-03-27 18:08:04', 1, 1, '2019-03-27 18:08:01', '2019-03-27 18:08:04', 82, 3, 0, NULL, 106),
(121, 1, '1700/2016', '04972.006625/2016-14', 'determinar a suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPUSC no livro nº SC-014-TERMOS DIVERSOS E ESCRITURA às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-27 18:32:52', 4, 4, '2019-03-27 18:32:50', '2019-03-27 18:32:52', 57, 3, 0, NULL, 108),
(122, 1, '1405/2019', '04972.001956/2019-19', 'Prestar informações sobre a atual situação do projeto habitacional aos integrantes da \'Ocupação Contestado\'', NULL, '2019-04-12', '2019-05-09 18:32:52', 1, 1, '2019-03-27 18:46:37', '2019-05-09 18:32:53', 58, 3, 0, NULL, 110),
(123, 1, '1720/2016', '04972.006685/2016-37', 'suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014-TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-27 18:46:46', 4, 4, '2019-03-27 18:46:44', '2019-03-27 18:46:46', 107, 3, 0, NULL, 111),
(124, 1, '1722/2016', '04972.006682/2016-01', 'Suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União.', NULL, NULL, '2019-03-27 18:57:18', 4, 4, '2019-03-27 18:56:54', '2019-03-27 18:57:18', 107, 3, 0, NULL, 112),
(125, 1, '1723/2016', '04972.006732/2016-42', 'suspensão daeficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014- TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-27 19:02:21', 4, 4, '2019-03-27 19:02:20', '2019-03-27 19:02:21', 107, 3, 0, NULL, 113),
(126, 1, '1520/2016', '04972.006120/2016-50', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-27 19:09:38', 4, 4, '2019-03-27 19:09:34', '2019-03-27 19:09:38', 121, 3, 0, NULL, 114),
(127, 7, '03/2019', '04972.001957/2019-55', 'RECOMENDA ao SUPERINTENDENTE DO PATRIMÓNIO DA UNIÃO EM SANTA CATARINA - SPU/SC, na pessoa de seu Superintendente Substituto - Senhor Carlos José Bauer, que:\r\n1) adote medidas para identificação dos ocupantes e adoção das medidas administrativas e/ou judiciais necessárias para desocupação dos imóveis da União no loteamento Ouro Verde, município de Balneário Gaivota/SC, localizados em áreas de preservação permanente;\r\n2) proceda a anulação de eventuais inscrições de ocupação já deferida se para que se abstenha de deferir novas inscrições,  por se tratar de Área de Preservação Permanente, nos termos da alínea \"a\" do inciso l do §1° da Lei n.9.636/98.', NULL, '2019-04-25', NULL, 1, NULL, '2019-03-27 19:13:28', '2019-03-27 19:13:28', 65, 2, 0, NULL, 115),
(128, 1, '1518/2016', '04972.006086/2016-13', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-27 19:31:28', 4, 4, '2019-03-27 19:31:27', '2019-03-27 19:31:28', 121, 3, 0, NULL, 116),
(129, 1, '1703/2016', '04972.000215/2017-41', 'suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014-TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos', NULL, NULL, '2019-03-27 19:37:19', 4, 4, '2019-03-27 19:37:11', '2019-03-27 19:37:19', 109, 3, 0, NULL, 117),
(130, 1, '115/2017', '04972.000528/2017-07', 'suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPUSC no livro nº SC-014-TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', NULL, NULL, '2019-03-27 19:43:23', 4, 4, '2019-03-27 19:43:21', '2019-03-27 19:43:23', 121, 3, 0, NULL, 118),
(131, 1, '971/2019', '04972.001641/2019-63', 'prestar informações sobre eventual autorização desta Superintendência para obras de desmatamento na área indicada na representação', NULL, '2019-04-08', '2019-03-27 20:31:02', 1, 1, '2019-03-27 19:58:24', '2019-03-27 20:31:02', 95, 3, 0, NULL, 119),
(132, 1, '17///2016', '04972.000105/2017-89', 'suspensão da eficáciada cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014-TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos', NULL, NULL, '2019-03-27 20:26:08', 4, 4, '2019-03-27 20:26:04', '2019-03-27 20:26:08', 109, 3, 0, NULL, 120),
(133, 1, '1712/2016', '04972.000107/2017-78', 'suspensão da eficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União', NULL, NULL, '2019-03-27 20:40:13', 4, 4, '2019-03-27 20:40:11', '2019-03-27 20:40:13', 109, 3, 0, NULL, 121),
(134, 1, '1853/2018', '04972.007633/2018-40', 'Subsídios à defesa da União.', NULL, NULL, '2019-03-28 18:12:10', 4, 4, '2019-03-28 18:11:34', '2019-03-28 18:12:10', 126, 3, 0, NULL, 122),
(135, 1, '427/2019', '04972.007633/2018-40', 'Indicação de assistente técnico e quesitos.', NULL, '2019-04-08', '2019-04-22 13:10:03', 4, 1, '2019-03-28 18:14:16', '2019-04-22 13:10:03', 126, 3, 0, NULL, 122),
(136, 1, '4875/2019', '04972.207030/2015-01', 'Elementos para a defesa/manifestação sobre o pedido de liminar, em ação objetivando a decretação da nulidade da decisão administrativa proferida nos autos do processo 04972.200918/2015-13.', NULL, NULL, '2019-04-01 13:37:52', 4, 4, '2019-04-01 13:37:41', '2019-04-01 13:37:52', 113, 3, 0, NULL, 123),
(137, 1, '4058/2016', '04972.207030/2015-01', 'Indicação de assistente técnica e formulação de quesitos.', NULL, NULL, '2019-04-01 13:39:42', 4, 4, '2019-04-01 13:39:35', '2019-04-01 13:39:42', 126, 3, 0, NULL, 123),
(138, 1, '1446/2018', '04972.207030/2015-01', 'Manifestação acerca do laudo pericial.', NULL, NULL, '2019-04-01 13:42:08', 4, 4, '2019-04-01 13:41:37', '2019-04-01 13:42:08', 143, 3, 0, NULL, 123),
(139, 1, '2253/2018', '04972.207030/2015-01', 'Manifestação sobre laudo pericial.', NULL, NULL, '2019-04-01 13:44:02', 4, 4, '2019-04-01 13:43:58', '2019-04-01 13:44:02', 143, 3, 0, NULL, 123),
(140, 1, '428/2019', '04972.207030/2015-01', 'Manifestação sobre laudo complementar.', NULL, '2019-04-08', '2019-04-10 14:22:09', 4, 1, '2019-04-01 13:46:08', '2019-04-10 14:22:09', 143, 3, 0, NULL, 123),
(141, 1, '173/2019', '04972.002116/2019-65', 'Manifestação sobre laudo técnico.', NULL, '2019-04-15', '2019-04-26 12:21:53', 4, 4, '2019-04-01 14:22:06', '2019-04-29 19:23:34', 228, 3, 0, NULL, 124),
(142, 1, '630/2018', '04972.006106/2018-18', 'Indicação de assistente técnico e quesitos.', NULL, NULL, '2019-04-01 16:42:57', 4, 4, '2019-04-01 16:42:55', '2019-04-01 16:42:57', 100, 3, 0, NULL, 125),
(143, 1, '390/2019', '04972.006106/2018-18', 'Informa a data da perícia.', NULL, NULL, '2019-04-01 16:46:42', 4, 4, '2019-04-01 16:46:39', '2019-04-01 16:46:42', 100, 3, 0, NULL, 125),
(144, 1, '4810/2015', '04972.206943/2015-01', 'Informa a data da perícia.', NULL, NULL, '2019-04-01 17:03:55', 4, 4, '2019-04-01 17:03:18', '2019-04-01 17:03:55', 55, 3, 0, NULL, 126),
(145, 1, '2969/2017', '04972.206943/2015-01', 'Manifestação sobre laudo pericial.', NULL, NULL, '2019-04-01 17:06:42', 4, 4, '2019-04-01 17:06:40', '2019-04-01 17:06:42', 199, 3, 0, NULL, 126),
(146, 1, '1034/2018', '04972.206943/2015-01', 'Informa a data da perícia.', NULL, NULL, '2019-04-01 17:09:31', 4, 4, '2019-04-01 17:09:28', '2019-04-01 17:09:31', 114, 3, 0, NULL, 126),
(147, 1, '19/2019', '04972.206943/2015-01', 'Informa a data da perícia.', NULL, NULL, '2019-04-01 17:14:39', 4, 4, '2019-04-01 17:14:36', '2019-04-01 17:14:39', 114, 3, 0, NULL, 126),
(148, 1, '14/2019', '04972.206943/2015-01', 'Informa a data da perícia.', NULL, NULL, '2019-04-01 17:16:01', 4, 4, '2019-04-01 17:15:59', '2019-04-01 17:16:01', 234, 3, 0, NULL, 126),
(149, 1, '424/2019', '04972.206943/2015-01', 'Informa a data da perícia.', NULL, NULL, '2019-04-01 17:18:43', 4, 4, '2019-04-01 17:18:41', '2019-04-01 17:18:43', 114, 3, 0, NULL, 126),
(150, 1, '0108/2019', '04972.001591/2019-14', 'manifestar acerca do interesse da União em relação ao local atingido pelo dano ambiental', NULL, '2019-03-15', '2019-04-02 12:59:02', 1, 1, '2019-04-01 18:58:24', '2019-04-02 12:59:02', 216, 3, 0, NULL, 127),
(151, 1, '00049/2019', '04972.206919/2015-63', 'manifestação acerca dos documentos juntados pela parte autora no evento 227 (novo memorial descritivo).', NULL, '2019-03-15', '2019-04-08 18:39:24', 1, 1, '2019-04-01 19:27:38', '2019-04-08 18:39:24', 224, 3, 0, NULL, 128),
(152, 1, '00177/2019', '04972.010806/2018-15', 'esclarecer a situação do imóvel objeto da controvérsia (RFFSA), em defesa da nossa posição jurídica eventualmente tangida', NULL, '2019-04-01', '2019-04-02 12:56:10', 1, 1, '2019-04-01 19:46:41', '2019-04-02 12:56:10', 106, 3, 0, NULL, 130),
(153, 1, '1488/2017', '04972.006326/2017-61', 'Subsídios à defesa da União.', NULL, NULL, '2019-04-02 13:27:31', 4, 4, '2019-04-02 13:27:29', '2019-04-02 13:27:31', 105, 3, 0, NULL, 134),
(154, 1, '170/2019', '04972.006326/2017-61', 'Informe se os requeridos regularizam a ocupação do imóvel objeto da lide, nos termos do acordo do ev. 69.', NULL, NULL, '2019-04-02 13:31:21', 4, 4, '2019-04-02 13:31:19', '2019-04-02 13:31:21', 228, 3, 0, NULL, 134),
(155, 1, '6/2019', '04972.003727/2018-40', 'prestar informações sobre o processo administrativo n° 04972.003727/2018-40, da Prefeitura Municipal de São José, relacionado com os dados dos  imóveis sobre terras de marinha, localizados entre a foz do Rio Maruim e a foz do Rio Araújo, tendo em vista o teor do relatório de execução do diagnóstico socio ambiental apresentado pela FMADS (anexo ao ofício)', NULL, '2019-02-01', NULL, 1, NULL, '2019-04-02 13:40:35', '2019-04-02 13:40:35', 90, 2, 0, NULL, 135),
(156, 2, '01/04/2019', '04972.003727/2018-40', 'fornecer informações cartográficas (mapa, planta, carta topográfica, etc, preferencialmente em meiodigital), contendo a delimitação dos lotes na área de estudo (Terras de Marinha na Orla Sul do Município de São José,situados entre a foz do rio Maruim e a foz do rio Araújo), com a respectiva identificação dos RIPs. Pede-se que a referida cartografia deve ter escala adequada para que seja possível identificar cada um dos imóveis.', NULL, '2019-04-09', NULL, 1, NULL, '2019-04-02 13:58:22', '2019-04-02 13:58:22', 235, 2, 0, NULL, 135),
(157, 1, '454/2019', '04972.002177/2019-22', 'o Ofício 454/2019 - NUP 04972.002177/2019-22, trata de terras indígenas e a União foi condenada na obrigação de fazer consistente na adoção das providências administrativas e judiciais necessárias para impedir obras e invasões na terra indígena Cambirela, na Palhoça, bem como demolir  as construções ilegais já implantadas e recuperação ambiental.', NULL, '2019-04-16', NULL, 3, 1, '2019-04-02 16:40:59', '2019-04-23 13:50:57', 114, 4, 0, NULL, 1),
(158, 1, '455/2019', '04972.007530/2013-75', 'o Ofício 455/2019 - NUP 04972.002119/2019-07, trata da abertura de acessos em Governador Celso Ramos. O Município alegou que a União (SPU) não estava cumprindo a parte dela e o juiz determinou que a União em 15 dias informe quais são as inscrições e/ou aforamentos de terras de marinha cuja manutenção pela União estariam impedindo a abertura dos acessos, bem como que fosse informadas eventuais ocupações irregulares.\r\n\r\nO NUP 04972.001952/2017-61 que trata do pedido de retificação efetuado pelo Município de Governador Celso Ramos está sendo tratado pelo Eng. Marcelo.\r\nO NUP 04972.007530/2013-75 trata dos procedimentos adotados até o momento pela SPU/SC para  a execução da sentença.', NULL, '2019-04-16', '2019-04-29 19:25:54', 3, 1, '2019-04-02 16:49:18', '2019-05-15 14:05:40', 114, 3, 1, NULL, 139),
(159, 1, '66/2018', '04972.008437/2017-10', '[i] seja informado, por meio de planilha descritiva [mês a mês], os valores devidos no período compreendido entre 2006 a 2018, levando em conta a nova forma de reajuste determinado pelo provimento jurisdicional antes referido [aplicação de índices inflacionários]; [ii] informar o valor a ser abatido do valor depositado em juízo, e cuja devolução está sendo requerida pela demandante, de acordo com os extratos juntados aos autos, a fim de que a União possa impugnar a execução do julgado se for o caso.', NULL, NULL, '2019-04-02 17:43:40', 4, 4, '2019-04-02 17:41:49', '2019-04-02 17:43:40', 102, 3, 0, NULL, 140),
(160, 1, '373/2019', '04972.008437/2017-10', 'Demonstrativo administrativo atualizado do débito controvertido, a fim de se aferir a necessidade de ajustes dos cálculos.', NULL, '2019-03-26', '2019-04-02 17:53:13', 4, 4, '2019-04-02 17:53:08', '2019-04-02 17:53:13', 100, 3, 0, NULL, 140),
(161, 1, '385/2018', '04972.004256/2018-97', 'Manifestação de interesse.', NULL, NULL, '2019-04-02 18:16:55', 4, 4, '2019-04-02 18:16:53', '2019-04-02 18:16:55', 107, 3, 0, NULL, 142),
(162, 1, '21/2018', '04972.004256/2018-97', 'Manifestação de interesse.', NULL, NULL, '2019-04-02 18:18:33', 4, 4, '2019-04-02 18:18:31', '2019-04-02 18:18:33', 99, 3, 0, NULL, 142),
(163, 1, '424/2019', '04972.004256/2018-97', 'Manifestação sobre a alegada inconsistência de coordenadas.', NULL, '2019-04-08', '2019-04-10 14:31:09', 4, 1, '2019-04-02 18:32:27', '2019-04-10 14:31:09', 100, 3, 0, NULL, 142),
(164, 1, '00072/2019', '04972.602771/2013-22', 'prestar subsídios aptos a demonstrar a regularidade da cobrança da taxa de ocupação', NULL, '2019-04-12', NULL, 1, 1, '2019-04-02 18:33:27', '2019-04-02 18:35:59', 236, 2, 0, NULL, 143),
(165, 1, '3177/2017', '04972.007519/2017-39', 'Indicação de assistente e formulação de quesitos.', NULL, NULL, '2019-04-02 18:55:59', 4, 4, '2019-04-02 18:55:57', '2019-04-02 18:55:59', 199, 3, 0, NULL, 144),
(166, 1, '1240/2018', '04972.004416/2016-36', 'aferir a existência de registro em cartório de imóvel pertencente à União em nome de terceiros como proprietários.', NULL, NULL, '2019-04-03 12:11:20', 8, 8, '2019-04-03 12:10:34', '2019-04-03 12:11:20', 199, 3, 1, NULL, 145),
(167, 1, 'n. 0005949-48.2011.8.24.0075-0005', '04972.001765/2019-49', 'solicita que seja manifestado interesse nos seguintes bens: 2 aros de liga leve para automóveis', NULL, '2019-04-22', '2019-04-05 19:08:09', 4, 4, '2019-04-03 18:30:23', '2019-04-05 19:08:09', 237, 3, 0, NULL, 146),
(168, 1, '00191/2019', '50067468920164047208', 'análise laudo pericial.', NULL, '2019-04-12', '2019-05-09 17:18:59', 8, 4, '2019-04-03 18:37:47', '2019-05-16 17:54:09', 106, 3, 0, NULL, 147),
(169, 1, '00180/2019', '04972.000415/2017-01', 'Aeroporto de Navegantes', NULL, '2019-04-08', '2019-05-09 17:21:09', 8, 4, '2019-04-03 19:30:50', '2019-05-15 12:34:08', 228, 3, 0, NULL, 149),
(170, 1, '00335/2018', '04972.009642/2018-75', 'manifestação de interesse federal na causa', NULL, '2018-11-26', '2019-04-22 13:06:51', 8, 1, '2019-04-03 19:39:33', '2019-04-22 13:06:51', 201, 3, 0, NULL, 152),
(171, 1, '00209/2019', '04972.009778/2018-85', 'manifestação sobre proposta de acordo.', NULL, '2019-02-18', '2019-04-08 17:51:45', 8, 5, '2019-04-03 19:53:51', '2019-04-08 17:51:45', 143, 3, 0, NULL, 153),
(172, 2, '23/04/2018', '04972.004802/2018-90', 'Pede manifestação sobre o pedido de cancelamento feito pelo registro de imóveis', NULL, NULL, '2019-04-26 13:15:19', 1, 3, '2019-04-03 20:30:23', '2019-04-26 13:15:19', 211, 7, 0, NULL, 154),
(173, 1, '00419/2018', '5012582-72.2018.4.04', 'subsídios e informa liminar.', NULL, '2019-01-15', NULL, 8, 8, '2019-04-04 11:27:07', '2019-04-04 11:30:07', 201, 2, 0, NULL, 155),
(174, 1, '2316/2018', '04972.006506/2017-42', 'acompanhamento em imissão na posse de imóvel em Laguna.', NULL, NULL, NULL, 8, NULL, '2019-04-04 11:34:49', '2019-04-04 11:34:49', 234, 2, 1, NULL, 156),
(175, 1, '00365/2018', '04972.010249/2018-24', 'manifestar interesse no feito.', NULL, '2019-01-21', '2019-04-08 18:35:58', 8, 4, '2019-04-04 11:43:49', '2019-04-08 18:35:58', 201, 3, 0, NULL, 158),
(176, 1, '00063/2019', '04972.002491/2016-62', 'manifestação acerca do Laudo Pericial complementar', NULL, '2019-04-10', '2019-04-23 14:17:39', 8, 1, '2019-04-04 12:21:38', '2019-04-30 14:43:31', 234, 3, 0, NULL, 159),
(177, 1, '00386/2019', '04972.001056/2017-00', 'indicar servidor para acompanhar imissão na posse.', NULL, '2019-04-01', NULL, 8, NULL, '2019-04-04 12:42:32', '2019-04-04 12:42:32', 126, 2, 0, NULL, 160),
(178, 1, '00068/2019', '04972.007519/2017-39', 'manifestação acerca de Laudo pericial complementar', NULL, '2019-04-15', '2019-05-06 14:12:02', 8, 1, '2019-04-04 13:08:30', '2019-05-08 14:56:16', 234, 3, 0, NULL, 144),
(179, 1, '00184/2019', '04972.002117/2019-18', 'indicação de assistente técnico', NULL, '2019-04-12', '2019-04-23 17:15:40', 8, 4, '2019-04-04 13:21:46', '2019-04-23 17:15:48', 106, 3, 0, NULL, 162),
(180, 1, '2456/2019', '04972.009454/2018-47', 'Manifestação de Interesse.', NULL, NULL, '2019-04-04 14:15:49', 4, 4, '2019-04-04 14:15:42', '2019-04-04 14:15:49', 114, 3, 0, NULL, 163),
(181, 1, '00472/2019', '04972.007816/2018-65', 'informar se há cessão da área.', NULL, '2019-04-05', '2019-04-08 18:32:32', 8, 1, '2019-04-04 16:51:54', '2019-04-08 18:32:32', 126, 3, 0, NULL, 164),
(182, 1, '0470/2019', '04972.203332/2015-01', 'reintegração de posse. Porto de laguna', NULL, '2019-04-15', '2019-05-07 13:44:33', 8, 1, '2019-04-04 17:24:09', '2019-05-07 13:44:35', 143, 3, 0, NULL, 165),
(183, 1, '00059/2019', '04972.001400/2017-52', 'ciência de perícia.', NULL, '2019-05-20', '2019-04-04 18:04:21', 8, 8, '2019-04-04 18:04:16', '2019-04-04 18:04:21', 234, 3, 0, NULL, 166),
(184, 1, '00456/2019', '04972.202317/2015-37', 'manifestação sobre Laudo complementar', NULL, '2019-04-11', '2019-05-21 18:56:17', 8, 3, '2019-04-05 12:02:56', '2019-05-21 19:21:59', 114, 3, 0, NULL, 167),
(185, 1, '00439/2019', '04972.006484/2017-11', 'retirar suspensão. Ação julgada improcedente.', NULL, NULL, '2019-04-05 13:06:37', 8, 8, '2019-04-05 13:06:16', '2019-04-05 13:06:37', 114, 3, 1, NULL, 168),
(186, 1, '00429', '04972.002933/2018-32', 'ciência de vistoria técnica.', NULL, '2019-04-25', '2019-04-05 13:26:37', 8, 8, '2019-04-05 13:26:27', '2019-04-05 13:26:37', 126, 3, 0, NULL, 169),
(187, 1, '00441/2019', '04972.003787/2018-62', 'indicação de assistente técnico e formulação de quesitos.', NULL, '2019-04-15', '2019-04-23 14:34:16', 8, 1, '2019-04-05 13:40:25', '2019-04-30 18:02:01', 126, 3, 0, NULL, 170),
(188, 1, '104/2019', '04972.001589/2019-45', 'informar a situação cadastral Loteamento Green Ville, localizado na Rodovia Jorge Lacerda, Km 12,4, Ilhota/SC', NULL, '2019-03-29', '2019-04-15 18:41:31', 8, 3, '2019-04-05 17:14:47', '2019-04-15 18:41:31', 76, 3, 0, NULL, 171),
(189, 1, '981/2019', '04972.001754/2019-69', 'informação se a Obra de arrimo das margens do Ribeirão Capela e reconstrução de ponte de concreto. Ratones, Florianópolis/SC, interfere com bens da União.', NULL, '2019-03-29', '2019-04-10 14:13:41', 8, 1, '2019-04-05 17:20:09', '2019-04-10 14:13:41', 95, 3, 0, NULL, 172),
(190, 1, '0613/2019', '04972.001800/2019-20', 'Informar se o área localizada na Estrada Intendente António Damasco, s/n°, ao Iaco doj \"Trevo\'s Bar\", Ratones, Florianópolis/SC, coordenadas de referência Datum WGS -84 -27.489785°S / -48.493368°O, incide em terrenos de marinha e seus acrescidos.', NULL, '2019-04-22', '2019-04-10 14:44:19', 8, 1, '2019-04-05 17:33:36', '2019-04-10 14:44:19', 187, 3, 0, NULL, 173),
(191, 1, '146/2019', '04972.000663/2017-44', 'informação sobre a regularidade cadastral Marina Patrício, localizada na Rua Luis Joaquim dos Santos, bairro São Pedro, no Município de Navegantes/SC, às margens do Rio Itajaí-Açu.', NULL, '2019-04-18', NULL, 8, 8, '2019-04-05 17:39:07', '2019-04-05 17:39:23', 74, 2, 0, NULL, 174),
(192, 1, '00069/2019', '04972.006391/2018-77', 'informação atualizada sobre a efetivação da transferência do imóvel (barragem oeste Taió/SC)', NULL, '2019-05-06', '2019-04-26 12:43:51', 8, 3, '2019-04-05 17:43:06', '2019-04-26 12:43:56', 234, 3, 0, NULL, 175),
(193, 1, '51/2019', '04972.206928/2015-54', 'informações se já houve a conclusão dos trabalhos referentes a regularização da delimitação da Linha de Preamar Média/1831 e, em caso negativo, quais as medidas adotadas para a referida\nregularização.', NULL, '2019-04-09', NULL, 8, 8, '2019-04-05 17:52:30', '2019-04-05 17:53:10', 239, 2, 0, NULL, 176),
(194, 1, '00073/2019', '04972.008923/2018-19', 'informações complementares à NT 5876/2016', NULL, '2019-04-29', '2019-05-06 13:55:28', 8, 1, '2019-04-05 17:59:23', '2019-05-08 14:50:05', 224, 3, 0, NULL, 72);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `demanda`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(195, 1, '00454/2019', '04972.002177/2019-22', 'LIMINAR para a adoção das providências administrativas e judiciais para impedir obras e invasões na terra indígena Cambirela, Município de palhoça.', NULL, '2019-04-16', '2019-04-24 14:11:59', 8, 1, '2019-04-08 12:00:18', '2019-04-25 17:49:42', 114, 3, 1, NULL, 137),
(196, 1, '00477/2019', '04972.002279/2019-48', 'subsídios para MS. Pedido de remição de aforamento em análise.', NULL, '2019-04-08', '2019-05-06 13:40:47', 8, 3, '2019-04-08 12:13:44', '2019-05-06 13:40:50', 114, 3, 0, NULL, 179),
(197, 1, '00007/2019', '04972.002280/2019-72', 'que seja confirmada a Reintegração de posse do imóvel funcional situado na Rua Engenheiro Fiúza da Rocha, 84, Centro, no Município de Criciúma/SC, com área de 452,23 m², sobre o qual se encontra edificada uma casa de alvenaria de 126,69 m², registrado no 1° Oficio do Registro de Imóveis da Comarca de Criciúma, sob a matrícula de nº 2.108.', NULL, '2019-04-15', NULL, 8, 8, '2019-04-08 12:21:54', '2019-04-08 12:22:44', 99, 2, 0, NULL, 180),
(198, 1, '00384/219', '04972.001885/2019-46', 'indicar servidor para conciliação, audiência em 04/06/2019', NULL, '2019-06-04', '2019-04-11 13:29:30', 8, 4, '2019-04-08 12:41:18', '2019-04-11 13:29:30', 126, 3, 0, NULL, 181),
(199, 1, '00446/2019', '04972.001815/2018-15', 'informar se a identificação do imóvel levada a efeito pela SPU (evento 101 - INF2) implica cancelamento, ainda que parcial, da enfiteuse que recai sobre o imóvel ocupado pelo autor e, em consequência, restituição de taxa de ocupação por ele paga a maior.', NULL, '2019-04-29', '2019-05-09 17:22:19', 8, 4, '2019-04-08 13:56:13', '2019-05-15 12:50:36', 100, 3, 0, NULL, 182),
(200, 1, '720004508095', '04972.002282/2019-61', 'reabertura de prazo para entrega de títulos Condomínio Habitacional Ernesto Che Guevara', NULL, NULL, '2019-04-08 14:05:31', 8, 8, '2019-04-08 14:05:06', '2019-04-08 14:05:31', 240, 3, 1, NULL, 178),
(201, 1, '720004557498', '04972.002283/2019-14', 'reabertura de prazo para entrega de títulos Condomínio Habitacional Ernesto Che Guevara', NULL, NULL, '2019-04-08 14:10:01', 8, 8, '2019-04-08 14:09:46', '2019-04-08 14:10:01', 240, 3, 1, NULL, 183),
(202, 1, '720004505970', '04972.002284/2019-51', 'reabertura de prazo para entrega de títulos Condomínio Habitacional Ernesto Che Guevara', NULL, NULL, '2019-04-08 14:12:35', 8, 8, '2019-04-08 14:12:20', '2019-04-08 14:12:35', 240, 3, 1, NULL, 184),
(203, 1, '00192/2019', '04972.002207/2019-09', 'elementos de fato e de direito relativos ao caso.\nTerreno de 7.793,40 m2, situado na Rodovia L.A.P, Rodesindo Pavan - Avenida Interpraias, s/n, Bairro Estaleiro, Balneário Camboriú-SC, tendo o\nJuízo Estadual declinado da competência em razão de manifestação de interesse da União.', NULL, '2019-04-22', '2019-04-22 18:19:17', 8, 4, '2019-04-08 16:42:37', '2019-04-22 18:19:17', 106, 3, 0, NULL, 185),
(204, 1, '400/2019', '04972.001955/2019-66', 'Manifestação de Interesse.', NULL, '2019-04-03', '2019-04-08 17:00:17', 4, 4, '2019-04-08 17:00:09', '2019-04-08 17:00:17', 126, 3, 0, NULL, 186),
(205, 1, '290/2019', '04972.001861/2019-97', 'Subsídios à defesa da União.', NULL, '2019-04-03', '2019-04-10 19:39:10', 4, 1, '2019-04-08 17:08:25', '2019-04-10 19:39:10', 100, 3, 0, NULL, 148),
(206, 1, '65/2019', '04972.001953/2019-77', 'Manifestação de interesse', NULL, '2019-04-12', '2019-04-08 17:45:05', 4, 4, '2019-04-08 17:45:04', '2019-04-08 17:45:05', 234, 3, 0, NULL, 187),
(207, 1, '00189/2019', '04972.008114/2017-18', 'subsídios em relação ao parecer 7344936 e a possível restituição de valores.', NULL, '2019-04-22', '2019-05-15 12:12:39', 8, 3, '2019-04-08 18:26:54', '2019-05-16 17:22:44', 106, 3, 0, NULL, 188),
(208, 1, '457/2019', '04972.002404/2019-10', 'informações acerca da regularidade do rancho de pesca instalado na Praia do Forte, em São Francisco do Sul/SC, objeto da AuA n2 41/2017 e Parecer Técnico Interno n. 730/2017 (cópias anexas), ern nome de Hugo da Silva Oliveira, CPF 024.127.109-61.', NULL, '2019-05-10', '2019-05-15 12:44:01', 8, 1, '2019-04-09 11:39:56', '2019-05-15 12:44:02', 85, 3, 0, NULL, 189),
(209, 1, '319/2019', '04972.001862/2019-31', 'verificação de interferência com área da União.', NULL, '2019-04-22', '2019-04-15 19:18:12', 8, 3, '2019-04-09 13:04:24', '2019-04-15 19:18:12', 82, 3, 0, NULL, 191),
(210, 1, '68/2019', '00556.001729/2016-92', 'informações sobre o andamento da cessão onerosa da Plataforma de Pesca Entremares Araranguá', NULL, '2019-04-22', '2019-04-25 19:07:54', 8, 3, '2019-04-09 13:31:56', '2019-04-25 19:07:56', 241, 3, 0, NULL, 192),
(211, 1, '376/2019', '04972.000285/2017-07', 'Demolição de Casas na Praia do Forte\r\nO Ofício da AGU foi respondido, mas ainda falta liberação dos recursos para o cumprimento da sentença que determinou a demolição das casas.', NULL, '2019-04-23', NULL, 3, 3, '2019-04-09 16:29:50', '2019-04-17 12:29:04', 242, 2, 1, NULL, 194),
(212, 1, '81/2019', '04972.206525/2015-13', 'a União noticiou ao Juízo que aquele órgão concluiu pela renúncia à\r\ndívida do Sr. Santos de Souza, diante do interesse social, restando ainda a questão da destinação do bem que, conforme\r\na SPU, seria analisada em conjunto com as demais situações existentes na Rua Campos Elísios, sendo aguardado o\r\nlaudo ambiental para que a DIRFH analise a possibilidade de Regularização Fundiária de Interesse Social.', NULL, '2019-04-11', '2019-05-07 13:40:15', 3, 1, '2019-04-09 16:53:25', '2019-05-07 13:40:17', 228, 3, 0, NULL, 195),
(213, 1, '00515/2019', '04972.205855/2015-83', 'manifestação acerca do novo memorial descritivo.', NULL, '2019-04-22', '2019-04-22 14:02:56', 8, 4, '2019-04-09 17:21:25', '2019-04-22 14:02:56', 143, 3, 0, NULL, 196),
(214, 1, '79/2019', '04972.006467/2018-64', 'manifestação de interesse no feito.', NULL, '2019-04-17', '2019-04-22 18:15:51', 8, 4, '2019-04-09 17:31:39', '2019-04-22 18:15:51', 234, 3, 0, NULL, 197),
(215, 1, '00197/2019', '04972.003918/2016-40', 'informação atualizada acerca dos trabalhos da Comissão de Demarcação designada pela portaria SPU n. 211/2010, da linha de Preamar Média de 1831 (LPM/1831), no Município de Joinville (SC).', NULL, '2019-04-22', '2019-05-14 13:03:53', 8, 1, '2019-04-09 18:04:04', '2019-05-16 18:54:59', 201, 3, 0, NULL, 198),
(216, 6, '985', '04972.002444/2019-61', 'informações sobre existência de cadastro.', NULL, '2019-05-03', '2019-04-10 12:26:09', 8, 8, '2019-04-10 12:25:55', '2019-04-10 12:26:09', 244, 3, 0, NULL, 199),
(217, 1, '0720/2019', '04972.002001/2019-71', 'informar se o local onde foi lavrado o AUTO DE INFRAÇÃO 032211 B encontra-se inserido em área de marinha e seus acrescidos.', NULL, '2019-04-23', '2019-04-29 20:23:54', 8, 1, '2019-04-10 14:00:43', '2019-04-29 20:23:56', 245, 3, 0, NULL, 200),
(218, 1, '407/2019', '04972.001863/2019-86', 'informação sobre projeto da rodovia que liga o chamado \"trevo de Jaraguá do Sul\"', NULL, '2019-04-12', '2019-04-23 14:30:34', 8, 1, '2019-04-10 14:08:40', '2019-04-23 14:30:36', 85, 3, 0, NULL, 202),
(219, 1, '0807/2019', '04972.002002/2019-15', 'informar se a área objeto do Auto de Infração de n° 48885, em anexo, incide em terreno de marinha e seus acréscimos ou área de preservação permanente.', NULL, '2019-04-22', NULL, 8, NULL, '2019-04-10 16:00:11', '2019-04-10 16:00:11', 247, 2, 0, NULL, 203),
(220, 4, '0833/2019', '04972.007746/2018-45', 'informar interferência com terrenos de marinha e se há qualquer procedimento administrativo envolvendo a área.', NULL, '2019-04-22', NULL, 8, NULL, '2019-04-10 16:30:40', '2019-04-10 16:30:40', 248, 2, 0, NULL, 204),
(221, 1, '309/2019', '04972.002000/2019-26', 'a cessão do imóvel situado na Rua Itajaí, 1115, Blumenau/SC, antigo prédio do Ministério do Trabalho,', NULL, '2019-04-29', '2019-05-02 17:03:37', 8, 3, '2019-04-10 16:46:42', '2019-05-02 17:24:06', 69, 3, 0, NULL, 205),
(222, 1, '187/2018', '04972.006238/2018-40', 'Sentença condena União e ao Município de Bombinhas a demolirem o deck/trapiche', NULL, '2019-03-25', NULL, 1, NULL, '2019-04-10 17:33:08', '2019-04-10 17:33:08', 100, 2, 1, NULL, 206),
(223, 1, '016/2019', '04972.001958/2019-08', 'informar sobre documentação do INCRA.', NULL, '2019-04-30', '2019-04-10 18:14:29', 8, 8, '2019-04-10 18:14:14', '2019-04-10 18:14:29', 250, 3, 0, NULL, 207),
(224, 1, '1023/2019', '04972.203240/2015-12', 'o envio de mapa atualizado com a linha de marinha incidente sobre a orla de praia do Bairro João Paulo, nessa Capita', NULL, '2019-04-15', NULL, 8, NULL, '2019-04-11 13:41:34', '2019-04-11 13:41:34', 95, 2, 0, NULL, 208),
(225, 1, '1653/2019', '04972.002467/2019-76', 'informações a respeito do quanto noticiado, em suma, sobre suposto abandono do terreno da União localizado na Rua José da Costa Moellman, em frente ao Tribunal de Contas do Estado.', NULL, '2019-04-22', NULL, 8, 8, '2019-04-11 16:54:44', '2019-04-11 16:55:15', 87, 2, 0, NULL, 209),
(226, 1, '1029/2019', '04972.002466/2019-21', 'disponibilizar cópia integrai do procedimento relativo ao requerimento de JAIME ANTÓNIO PEREIRA, CPF n° 226.812.059-72, para utilização/regularização do imóvel da União denominado \"Ilha Grande\" (ou \"Ilha Quinta dos Ganchos\"), situada no município de Governador Celso Ramos/SC', NULL, '2019-04-26', '2019-04-29 12:28:50', 8, 8, '2019-04-11 17:03:24', '2019-04-29 12:28:52', 251, 3, 0, NULL, 210),
(227, 1, '473/2019', '04972.002448/2019-40', 'sobre procedimentos de TAUS.', NULL, '2019-05-10', '2019-05-22 19:52:42', 8, 1, '2019-04-11 17:07:20', '2019-05-22 19:52:44', 85, 3, 0, NULL, 211),
(228, 1, '1549/2019', '04972.002135/2017-20', 'informações atualizadas sobre o andamento da concessão de Termos de Autorização de Uso Sustentável (TAUS) para os ranchos de pesca situados no Bairro do Abraão', NULL, '2019-05-08', '2019-05-14 13:38:31', 8, 1, '2019-04-11 17:14:19', '2019-05-14 13:38:34', 95, 3, 0, NULL, 212),
(229, 1, '436/2019', '04972.002309/2016-73', 'informar sobre TAUS na Ilha do Linguado, Município de Balneário Barra do Sul.', NULL, '2019-05-07', '2019-05-14 13:20:05', 8, 1, '2019-04-11 17:22:07', '2019-05-14 13:20:05', 85, 7, 0, NULL, 213),
(230, 1, '1559/2019', '04972.200588/2015-58', 'informações sobre TAUS na região do Rio Imaruím, Palhoça/SC', NULL, '2019-05-08', '2019-05-15 18:14:18', 8, 3, '2019-04-11 17:35:55', '2019-05-15 18:14:20', 95, 3, 0, NULL, 214),
(231, 1, '83/2019', '04972.004078/2013-90', 'cópia do processo.', NULL, '2019-04-23', NULL, 8, 8, '2019-04-11 17:47:35', '2019-04-11 17:48:40', 239, 2, 0, NULL, 215),
(232, 1, '0300658-20.2016.8.24.0139-0004', '04972.003824/2017-51', 'a descrição completa do imóvel, com RIP n° 8265 0000695-91', NULL, NULL, NULL, 4, 4, '2019-04-11 18:44:36', '2019-04-11 18:44:52', 252, 2, 0, NULL, 216),
(233, 2, 's/n', '04972.002528/2019-03', 'Contestação de Cobrança, alegação de ilegitimidade passiva - Clube Atlético Tubarão', NULL, '2019-04-30', '2019-04-30 13:53:33', 3, 1, '2019-04-12 14:36:45', '2019-04-30 13:53:33', 253, 7, 0, NULL, 217),
(234, 1, '16/2019', '04972.629583/2008-84', 'confirmação de cancelamento de DAU.', NULL, '2019-04-12', '2019-04-12 16:41:42', 8, 8, '2019-04-12 16:41:40', '2019-04-12 16:41:42', 254, 3, 0, NULL, 218),
(235, 1, '498/2019', '04972.002532/2019-63', 'Esclareça se o local apontado interfere com terreno de marinha.', NULL, '2019-04-17', '2019-04-30 13:46:45', 4, 4, '2019-04-12 16:57:35', '2019-05-03 12:49:15', 255, 3, 0, NULL, 219),
(236, 1, '00501/2019', '04972.002525/2019-61', 'informações sobre TAUS, imóvel no ribeirão, em nome de Rita de Cássia Rodrigues', NULL, '2019-04-22', '2019-05-16 18:57:48', 8, 4, '2019-04-12 17:13:30', '2019-05-16 19:00:48', 114, 3, 0, NULL, 220),
(237, 1, '00076/2019', '04972.002397/2019-56', 'informar sobre as atuais ocupações na área objeto da lide.', NULL, '2019-05-03', '2019-05-09 12:53:45', 8, 1, '2019-04-12 17:39:40', '2019-05-13 13:01:10', 234, 3, 0, NULL, 221),
(238, 1, '561/2017', '04972.000971/2017-70', 'Subsídios para a defesa da União.', NULL, NULL, '2019-04-15 13:13:25', 4, 4, '2019-04-15 13:13:22', '2019-04-15 13:13:25', 143, 3, 0, NULL, 222),
(239, 1, '843/2017', '04972.000971/2017-70', 'Indicação de assistente técnico e quesitos.', NULL, NULL, '2019-04-15 13:14:45', 4, 4, '2019-04-15 13:14:44', '2019-04-15 13:14:45', 143, 3, 0, NULL, 222),
(240, 1, '2016/2018', '04972.000971/2017-70', 'Disponibilização de arquivo no formato digital “DWG”, conforme requerido pelo Perito no item 4\nda petição do evento 133.', NULL, NULL, '2019-04-15 13:16:16', 4, 4, '2019-04-15 13:16:11', '2019-04-15 13:16:16', 143, 3, 0, NULL, 222),
(241, 1, '524/2019', '04972.000971/2017-70', 'Informa a data da perícia.', NULL, NULL, NULL, 4, NULL, '2019-04-15 13:18:23', '2019-04-15 13:18:23', 126, 2, 0, NULL, 222),
(242, 1, '1407/2016', '04972.005864/2016-57', 'Subsídios de fato e de direito à defesa da União', NULL, NULL, '2019-04-15 13:26:00', 4, 4, '2019-04-15 13:25:56', '2019-04-15 13:26:00', 107, 3, 0, NULL, 223),
(243, 6, 'N/I', '04972.005864/2016-57', 'Informe a respeito da prorrogação do convênio.', NULL, '2019-05-20', NULL, 4, NULL, '2019-04-15 16:56:00', '2019-04-15 16:56:00', 256, 2, 0, NULL, 223),
(244, 1, '741/2017', '04972.004273/2017-43', 'esclarecer se a informação produzida de estar o imóvel situado em zona de segurança se deve ao fato de estar situado em faixa de fronteira ou se por outro motivo.', NULL, NULL, NULL, 4, 1, '2019-04-15 17:05:24', '2019-05-22 13:16:44', 172, 6, 0, NULL, 224),
(245, 1, '205/2019', '04972.002536/2019-41', 'Solicita dados para a conversão em renda dos valores depositados em juízo.', NULL, NULL, NULL, 4, 4, '2019-04-15 17:12:31', '2019-04-15 17:13:41', 243, 2, 0, NULL, 225),
(246, 1, '80/2019', '04972.002553/2019-89', 'Informações acerca do registro da área expropriada.', NULL, NULL, '2019-05-15 12:49:47', 4, 1, '2019-04-15 17:31:27', '2019-05-15 13:04:38', 224, 3, 0, NULL, 226),
(247, 1, '4108/2016', '04972.005172/2016-17', 'Informações acerca da ocupação de área de marinha por RODRIGO MAURO DA SILVA (CPF 019.358.069-12) e ZENILDA JOAQUINA JOAQUIM (CPF 022.026.819-30), principalmente, se são ocupantes regularizados junto à SPU/SC.', NULL, NULL, '2019-04-15 17:41:34', 4, 4, '2019-04-15 17:41:05', '2019-04-15 17:41:34', 126, 3, 0, NULL, 227),
(248, 1, '86/2018', '04972.005172/2016-17', 'Indique assistente técnico e formule quesitos para a defesa da União.', NULL, NULL, '2019-04-15 17:43:08', 4, 4, '2019-04-15 17:43:06', '2019-04-15 17:43:08', 126, 3, 0, NULL, 227),
(249, 1, '1025/2018', '04972.005172/2016-17', 'Manifestação acerca do laudo pericial.', NULL, NULL, '2019-04-15 17:46:26', 4, 4, '2019-04-15 17:46:24', '2019-04-15 17:46:26', 126, 3, 0, NULL, 227),
(250, 1, '556/2018', '04972.005172/2016-17', 'Manifestação acerca do laudo pericial.', NULL, '2019-04-22', '2019-04-23 16:38:17', 4, 1, '2019-04-15 17:48:35', '2019-04-30 18:06:05', 126, 3, 0, NULL, 227),
(251, 1, '1164/2017', '04972.004810/2017-55', 'Subsídios à defesa da União.', NULL, NULL, '2019-04-15 18:08:04', 4, 4, '2019-04-15 18:08:00', '2019-04-15 18:08:04', 121, 3, 0, NULL, 228),
(252, 1, '211/2019', '04972.004810/2017-55', 'Solicita a indicação de representante desse órgão para acompanhar a audiência junto ao juízo federal de Florianópolis, por videoconferência, que será realizada em 12/06/2019, às 14h00.', NULL, '2019-06-10', NULL, 4, NULL, '2019-04-15 18:13:08', '2019-04-15 18:13:08', 228, 2, 0, NULL, 228),
(253, 1, '213/2019', '04972.002554/2019-23', 'Encaminha o PARECER DE FORÇA EXECUTÓRIA n. 00013/2019/CARPS/PUSC/PGU/AGU', NULL, NULL, '2019-04-22 14:32:40', 4, 8, '2019-04-15 19:11:43', '2019-04-22 14:32:40', 228, 3, 0, NULL, 229),
(254, 1, '559/2019', '04972.002581/2019-04', 'Subsídios à defesa da União.', NULL, '2019-05-03', '2019-05-07 13:57:22', 4, 1, '2019-04-16 16:43:27', '2019-05-07 13:57:23', 166, 3, 0, NULL, 230),
(255, 1, '214/2019', '04972.003436/2018-51', 'Requer seja vistoriado o imóvel pela SPU e acaso esteja em terras de marinha seja feita a inscrição de Ofício com comunicado ao Cartório competente para averbação na matrícula', NULL, NULL, NULL, 4, NULL, '2019-04-16 17:09:57', '2019-04-16 17:09:57', 121, 2, 0, NULL, 231),
(256, 1, '563/2019', '04972.002583/2019-95', 'Informe se há interferência com área de domínio da União e se há interesse em participar do polo ativo da ACP.', NULL, '2019-04-22', '2019-05-15 12:56:33', 4, 4, '2019-04-16 17:21:45', '2019-05-15 12:56:34', 126, 3, 0, NULL, 232),
(257, 1, '1790/2015', '04972.205157/2015-88', 'Informações sobre terreno de marinha.', NULL, NULL, '2019-04-17 13:43:23', 4, 4, '2019-04-17 13:43:18', '2019-04-17 13:43:23', 82, 3, 0, NULL, 233),
(258, 1, '970/2016', '04972.205157/2015-88', 'Reiteração de Ofício.', NULL, NULL, '2019-04-17 13:51:54', 4, 4, '2019-04-17 13:51:52', '2019-04-17 13:51:54', 82, 3, 0, NULL, 233),
(259, 1, '11/2019', '04972.003480/2018-61', 'Subsídios para contestação.', NULL, NULL, '2019-04-17 13:58:25', 4, 4, '2019-04-17 13:58:21', '2019-04-17 13:58:25', 224, 3, 0, NULL, 234),
(260, 1, '2256/2018', '04972.008840/2018-11', 'Manifestação de interesse.', NULL, NULL, '2019-04-17 14:11:08', 4, 4, '2019-04-17 14:11:06', '2019-04-17 14:11:08', 126, 3, 0, NULL, 235),
(261, 1, '92/2019', '04972.008840/2018-11', 'Manifestação sobre levantamento planimétrico.', NULL, NULL, '2019-04-17 14:17:46', 4, 4, '2019-04-17 14:17:42', '2019-04-17 14:17:46', 143, 3, 0, NULL, 235),
(262, 1, '387/2019', '04972.008840/2018-11', 'Indicação de assistente técnico e quesitos.', NULL, NULL, '2019-04-17 14:19:35', 4, 4, '2019-04-17 14:19:30', '2019-04-17 14:19:35', 126, 3, 0, NULL, 235),
(263, 1, '82/2019', '04972.002597/2019-17', 'Manifestação de interesse.', NULL, '2019-05-15', NULL, 4, NULL, '2019-04-17 17:38:39', '2019-04-17 17:38:39', 234, 2, 0, NULL, 236),
(264, 1, '44/2019', '04972.003056/2016-55', 'Subsídios para defesa da União', NULL, NULL, '2019-04-17 18:26:45', 4, 4, '2019-04-17 18:26:39', '2019-04-17 18:26:45', 234, 3, 0, NULL, 237),
(265, 1, '269/2019', '04972.002622/2019-54', 'Verifique se os DICs 41380, 35330 e 43643, e a área indicada na fl. 201, de fato, se encontram em terreno de marinha, e, posteriormente, caso positivo, apurar eventual irregularidade na ocupação da área dos lotes parcialmente inseridos em bem da União,', NULL, '2019-05-15', '2019-05-23 20:17:53', 4, 1, '2019-04-18 17:57:27', '2019-05-23 20:17:54', 225, 3, 0, NULL, 238),
(266, 1, '154/2019', '04972.002595/2019-10', 'informar se a área em questão, localizada na Rodovia SC 100 Canto da Lagoa - Laguna, coordenadas 22J 713601/ 6837445, está situada em terrenos de marinha.', NULL, '2019-04-29', '2019-04-30 14:50:42', 8, 1, '2019-04-22 13:04:43', '2019-04-30 14:50:44', 257, 3, 0, NULL, 239),
(267, 1, '347/2019', '04972.002302/2019-02', 'averiguar a regularidade ambiental do empreendimento imobiliário \"Jardim das Dálias\", localizado na Rua Elsbeth Feddersen, s/n, Bairro Salto do Norte, município de Blumenau, CEP 89065-430, potencialmente em área de preservação permanente em virtude da proximidade com o Rio Itajaí-Açu.', NULL, '2019-04-24', '2019-05-10 17:03:27', 8, 1, '2019-04-22 13:19:35', '2019-05-10 17:03:28', 75, 3, 0, NULL, 240),
(268, 1, '0204/2019', '04972.004273/2017-43', 'esclarecer a informação produzida de estar o imóvel situado em zona de segurança se deve ao fato de estar situado em faixa de fronteira ou se por outro motivo.', NULL, '2019-05-10', '2019-05-24 13:41:36', 8, 3, '2019-04-22 13:26:21', '2019-05-24 18:57:13', 228, 3, 0, NULL, 224),
(269, 1, '225/2019', '04972.001237/2019-90', 'Manifestação de interesse.', NULL, NULL, '2019-04-22 13:54:59', 4, 4, '2019-04-22 13:54:57', '2019-04-22 13:54:59', 114, 3, 0, NULL, 246),
(270, 1, '577/2019', '04972.001237/2019-90', 'Manifestação sobre novos documentos.', NULL, '2019-05-01', '2019-05-06 13:53:50', 4, 1, '2019-04-22 13:56:27', '2019-05-08 14:53:33', 126, 3, 0, NULL, 246),
(271, 1, '578/2019', '04972.002684/2019-66', 'Subsídios à defesa da União', NULL, '2019-04-30', '2019-05-06 12:17:27', 4, 8, '2019-04-22 17:12:42', '2019-05-06 12:17:27', 126, 7, 0, NULL, 250),
(272, 1, '579/2019', '04972.002686/2019-55', 'Manifestação de Interesse.', NULL, '2019-04-30', '2019-04-30 18:29:20', 4, 1, '2019-04-22 17:36:47', '2019-04-30 18:58:03', 126, 3, 0, NULL, 252),
(273, 1, '94/2019', '03011441320168240007', 'Manifestação sobre novos documentos.', NULL, NULL, '2019-05-09 17:31:46', 4, 4, '2019-04-22 17:51:01', '2019-05-15 13:30:11', 234, 3, 0, NULL, 254),
(274, 1, '01/2019', '04972.002668/2018-92', 'cópia do processo administrativo n. 04972.003180/2010-25.', NULL, '2019-05-13', NULL, 8, NULL, '2019-04-22 18:17:31', '2019-04-22 18:17:31', 258, 2, 0, NULL, 255),
(275, 1, '00584/2019', '04972.002694/2019-00', 'manifestação de interesse em integrar o polo ativo.', NULL, '2019-04-26', '2019-05-06 14:22:16', 8, 1, '2019-04-23 13:05:15', '2019-05-08 14:57:28', 126, 3, 0, NULL, 256),
(276, 1, '0523/2019', '04972.007301/2011-99', 'Verificar se há documentação hábil para a realização da transferência do RIP 8105.0005756-59.', NULL, '2019-05-31', '2019-04-25 12:08:21', 8, 8, '2019-04-23 13:50:51', '2019-04-25 12:08:22', 259, 3, 0, NULL, 257),
(277, 1, '594/2019', '04972.002731/2019-71', 'Manifestação de Interesse.', NULL, '2019-04-26', '2019-04-25 18:24:45', 4, 3, '2019-04-23 16:53:51', '2019-04-25 18:57:35', 126, 3, 0, NULL, 258),
(278, 1, '220/2019', '04972.002739/2019-38', 'Informações e documentos referentes ao imóvel.', NULL, '2019-05-06', '2019-05-09 17:30:15', 4, 4, '2019-04-23 18:36:13', '2019-05-09 17:30:16', 106, 3, 0, NULL, 259),
(279, 1, '2425/2018', '04972.009286/2018-90', 'encaminhar ao setor de cadastro para futuro cadastramento.', NULL, NULL, '2019-04-29 14:12:08', 8, 8, '2019-04-23 18:54:25', '2019-04-29 14:12:09', 114, 3, 1, NULL, 260),
(280, 1, '256/2018', '04972.008544/2018-11', 'Subsídios á defesa da União.', NULL, NULL, '2019-04-23 19:13:43', 4, 4, '2019-04-23 19:13:07', '2019-04-23 19:13:44', 121, 3, 0, NULL, 261),
(281, 1, '221/2019', '04972.008544/2018-11', 'Manifestar-se acerca da proposta de acordo e trazer mapa', NULL, NULL, '2019-05-09 17:32:18', 4, 4, '2019-04-23 19:15:33', '2019-05-15 12:39:04', 121, 3, 0, NULL, 261),
(282, 1, '60/2019', '10983.004479/8922', 'Subsídios à defesa da União.', NULL, '2019-04-17', '2019-05-03 18:55:18', 4, 4, '2019-04-24 18:14:31', '2019-05-03 18:55:22', 224, 3, 0, NULL, 262),
(283, 1, '118/2019', '04972.201016/2015-96', 'Encaminha o Parecer de força executória 9/2019.', NULL, NULL, NULL, 4, 4, '2019-04-24 18:43:03', '2019-04-24 18:44:56', 260, 2, 0, NULL, 263),
(284, 1, '1345/2016', '04972.005692/2016-11', 'Subsídios à defesa da União', NULL, NULL, '2019-04-24 19:41:22', 4, 4, '2019-04-24 19:40:57', '2019-04-24 19:41:24', 109, 3, 0, NULL, 264),
(285, 1, '223/2019', '04972.005692/2016-11', 'Informações sobre Permissão de Uso.', NULL, NULL, '2019-05-17 13:07:54', 4, 3, '2019-04-24 19:43:28', '2019-05-17 13:28:01', 121, 3, 0, NULL, 264),
(286, 6, 'MANDADO DE SEGURANÇA Nº 5008044-38.2019.4.04.7200/SC', '04972.002791/2019-94', 'liminar, concedendo o prazo de 60 (sessenta) dias, para que a autoridade coatora promova análise do Pedido de Retificação de Área, requerimento/processo administrativo sob nº 0497.2008.469/2017-\r\n15. Município de Itapema/SC. Prestar informações até 09/05/2019.', NULL, NULL, '2019-05-07 16:35:40', 3, 3, '2019-04-25 14:39:16', '2019-05-07 16:35:48', 261, 3, 1, NULL, 266),
(287, 1, '1045/2018', '04902.001135/2018-17', 'suspensão da exigibilidade da cobrança.', NULL, NULL, '2019-04-26 13:34:17', 4, 4, '2019-04-26 13:33:52', '2019-04-26 13:34:20', 260, 3, 0, NULL, 267),
(288, 1, '2377/2018', '04902.001135/2018-17', 'informa que as determinações da decisão de Evento 33 dos autos de 2º Grau (expedição de Certidão Negativa de Débito em nome do requerente) não mais geram efeitos e não necessitam mais serem cumpridas.', NULL, NULL, '2019-04-26 13:37:51', 4, 4, '2019-04-26 13:37:20', '2019-04-26 13:37:52', 209, 3, 0, NULL, 267),
(289, 1, '125/2019', '04902.001135/2018-17', 'seja informado se o comprovante de pagamento anexo (data limite de pagamento 11/04/2019) é suficiente para o pagamento do débito do autor vinculada aos imóveis matriculados sob os nº s 81.682, 81.687, 81.712 e 81.713 e objeto da ação judicial nº 5013141-60.2012.4.04.7201.', NULL, '2019-05-03', '2019-04-30 14:31:55', 4, 1, '2019-04-26 13:39:31', '2019-04-30 14:31:55', 260, 7, 0, NULL, 267),
(290, 1, '226/2019', '04972.002882/2019-20', 'Manifestação de interesse.', NULL, NULL, '2019-05-21 19:07:32', 4, 3, '2019-04-26 14:07:15', '2019-05-21 19:07:32', 121, 7, 0, NULL, 268),
(291, 1, '509/2017', '04972.000898/2017-36', 'Manifestação de Interesse.', NULL, NULL, '2019-04-26 16:54:16', 4, 4, '2019-04-26 16:54:04', '2019-04-26 16:54:17', 55, 3, 0, NULL, 269),
(292, 1, '307/2018', '04972.000898/2017-36', 'Manifestação sobre novos documentos.', NULL, NULL, NULL, 4, 4, '2019-04-26 16:55:46', '2019-04-26 16:55:53', 199, 4, 0, NULL, 269),
(294, 1, '359/2018', '04972.000898/2017-36', 'solicita que este órgão analise os documentos colacionados aos autos de matrícula no registro de imóveis ou outros documentos do processo que entender pertinentes, visando aferir a existência de registro de imóvel pertencente à União em nome de terceiros', NULL, NULL, '2019-04-26 17:00:21', 4, 4, '2019-04-26 17:00:03', '2019-04-26 17:00:23', 199, 3, 0, NULL, 269),
(295, 1, '469/2019', '04972.000898/2017-36', 'Manifestação sobre novos documentos.', NULL, '2019-04-19', '2019-05-06 14:10:13', 4, 1, '2019-04-26 17:04:09', '2019-05-08 14:55:01', 143, 3, 0, NULL, 269),
(296, 1, '630/2019', '04972.002922/2019-33', 'Comunica acerca de editais de leilão', NULL, NULL, NULL, 4, NULL, '2019-04-26 17:37:00', '2019-04-26 17:37:00', 143, 2, 0, NULL, 270),
(297, 1, '632/2019', '04972.001677/2017-85', 'Manifestação sobre laudo complementar.', NULL, '2019-05-06', '2019-05-09 17:22:46', 4, 4, '2019-04-26 18:03:22', '2019-05-15 13:20:40', 114, 3, 0, NULL, 271),
(298, 1, '1841/2019-GAB-EB', '04972.005810/2016-91', 'informação acerca dos procedimentos adotados para regularizar o imóvel localizado na Rua Silva Jardim, n° 1278, Bairro Prainha, em Florianópolis.', NULL, '2019-05-13', NULL, 8, NULL, '2019-04-29 12:22:13', '2019-04-29 12:22:13', 95, 2, 0, NULL, 272),
(299, 1, '227/2019', '04972.004198/2017-11', 'Comprovação quanto a conclusão do Processo de Incorporação.', NULL, '2019-05-03', '2019-05-24 19:01:47', 4, 3, '2019-04-29 14:01:07', '2019-05-24 19:01:49', 121, 3, 0, NULL, 273),
(300, 1, '561/2019', '04972.003557/2018-01', 'Informa a data da realização de Perícia.', NULL, NULL, '2019-04-29 16:42:58', 4, 4, '2019-04-29 16:42:40', '2019-04-29 16:42:59', 100, 3, 0, NULL, 274),
(301, 1, '85/2019', '00439993720138240023', 'Manifestação de interesse', NULL, NULL, '2019-05-09 17:32:43', 4, 4, '2019-04-29 17:43:29', '2019-05-15 12:53:41', 224, 3, 0, NULL, 275),
(302, 1, '86/2019', '04972.002791/2019-94', 'subsídios para a elaboração de defesa contra a decisão, caso haja interesse da SPU.', NULL, NULL, '2019-05-07 16:37:22', 4, 3, '2019-04-29 19:19:29', '2019-05-07 16:37:22', 224, 7, 0, NULL, 266),
(303, 1, '2346/2018', '04972.008984/2018-78', 'Subsídios à defesa da União', NULL, NULL, '2019-04-29 19:54:11', 4, 4, '2019-04-29 19:53:44', '2019-04-29 19:54:11', 126, 3, 0, NULL, 276),
(304, 1, '650/2019', '04972.008984/2018-78', 'Indicação de assistente técnico e quesitos', NULL, '2019-05-06', '2019-05-09 17:26:27', 4, 4, '2019-04-29 19:55:54', '2019-05-15 13:12:50', 143, 3, 0, NULL, 276),
(305, 1, '1884/2019', '04972.003069/2019-77', 'informar a regularidade do imóvel localizado na Rua João Becker, 1777 - Praia dos Ingleses - Florianópolis/SC', NULL, '2019-05-29', NULL, 8, NULL, '2019-04-30 12:29:29', '2019-04-30 12:29:29', 95, 5, 0, NULL, 277),
(306, 1, '652/2019', '04972.003072/2019-91', 'Manifestação de interesse.', NULL, '2019-04-08', '2019-05-10 17:05:35', 4, 4, '2019-04-30 14:08:54', '2019-05-15 14:15:51', 114, 3, 0, NULL, 278),
(307, 1, '87/2019', '04972.001675/2017-96', 'Que sejam adotadas as providências para o cumprimento do acordo.', NULL, NULL, NULL, 4, NULL, '2019-04-30 16:50:50', '2019-04-30 16:50:50', 224, 2, 0, NULL, 73),
(308, 2, 's/n', '04972.003074/2019-80', 'Subsídios à defesa da União', NULL, '2019-05-15', '2019-05-14 16:59:42', 4, 3, '2019-04-30 17:35:14', '2019-05-14 16:59:45', 22, 3, 0, NULL, 279),
(309, 2, 'Processo SPU 03129454920188240008', '04972.002600/2019-94', 'reitero a solicitação de manifestação dessa SPU quando à retificação de registro imobiliário com base nos dados que constam nos autos, já que a União foi citada e deverá contestar dentro do prazo processual. Reencaminho a planta, agora legível, onde o sr. poderá encontrar as coordenadas. Ressalto que conforme consta na inicial, o pedido se restringe', NULL, '2019-04-30', '2019-04-30 18:55:44', 1, 1, '2019-04-30 17:49:02', '2019-04-30 19:11:57', 228, 3, 0, NULL, 280),
(310, 1, '449/2016', '04972.002869/2016-28', 'Subsídios à defesa da União.', NULL, '2019-04-22', '2019-04-30 18:12:42', 4, 4, '2019-04-30 18:11:36', '2019-04-30 18:12:42', 121, 7, 0, NULL, 281),
(311, 1, '378/2018', '04972.002869/2016-28', 'Informe se existem ou se já existiram ocupações em terreno de marinha registradas em nome das seguintes pessoas:\nJAIME CORREA (002.899.499-04) ;\nBEATRIZ DE MACEDO CORREA (511.122.059-34);\nPAULO CESAR CORREA (392.958.939-72);\nROSANA CORREA LOPES (457.511.299-20).', NULL, NULL, '2019-04-30 18:19:15', 4, 4, '2019-04-30 18:18:08', '2019-04-30 18:19:15', 228, 7, 0, NULL, 281),
(312, 1, '380/2018', '04972.002869/2016-28', 'Cópia integral do processo administrativo em que a empresa autora pediu a revisão da posição da LPM - 1831 - processo 11452.001088-73 - protocolo 04972.005842/2010-00.', NULL, NULL, '2019-04-30 18:23:29', 4, 4, '2019-04-30 18:21:44', '2019-04-30 18:23:30', 228, 3, 0, NULL, 281),
(313, 1, '01/2019', '04972.003071/2019-46', 'usucapião imóvel localizado', NULL, '2019-05-15', '2019-05-06 14:28:44', 8, 1, '2019-05-02 13:14:47', '2019-05-08 14:59:37', 262, 3, 0, NULL, 282),
(314, 1, '89/2019', '04972.003121/2019-95', 'Manifestação de interesse.', NULL, '2019-05-03', '2019-05-06 17:43:15', 4, 3, '2019-05-02 17:11:31', '2019-05-07 18:38:14', 234, 3, 0, NULL, 283),
(315, 1, '2922/2016', '04972.004026/2016-66', 'Manifestação de Interesse.', NULL, NULL, '2019-05-02 19:16:29', 4, 4, '2019-05-02 19:16:13', '2019-05-02 19:16:29', 126, 7, 0, NULL, 284),
(316, 1, '92/2019', '04972.004026/2016-66', 'Informa a data da perícia.', NULL, NULL, NULL, 4, NULL, '2019-05-02 19:17:58', '2019-05-02 19:17:58', 234, 2, 0, NULL, 284),
(317, 1, '238/2019', '04972.003136/2019-53', 'subsídios de defesa, informando em especial se a área é ocupada regularmente pelos réus e/ou terceiros, e em caso negativo, se foram tomadas providências para a regularização do imóvel ou medidas fiscalizatórios ou protetivas de defesa do patrimônio nacional', NULL, '2019-05-23', '2019-05-23 20:20:19', 4, 1, '2019-05-02 20:05:12', '2019-05-24 13:21:23', 228, 3, 0, NULL, 285),
(318, 1, '577/2019', '00008290220108240126', 'Manifestação de Interesse.', NULL, NULL, NULL, 4, NULL, '2019-05-02 20:57:46', '2019-05-02 20:57:46', 100, 2, 0, NULL, 286),
(319, 1, '150/2019', '04972.004898/2017-13', 'Manifestação de Interesse.', NULL, '2019-05-10', '2019-05-09 17:22:21', 4, 4, '2019-05-02 21:12:06', '2019-05-09 17:22:24', 121, 3, 0, NULL, 287),
(320, 2, 's/n', '04972.003139/2019-97', 'Trata-se de embargos á execução fiscal em que a embargante visa\r\ndesconstituir as certidões de dívida ativa 9061400161002, 9061101856050, 9061600066666,\r\nreferentes a taxa de ocupação do RIP 8041.0000434-60 no período de 1988 a 2013 e a\r\ncertidão de dívida ativa 9061600066747 referente a taxa de ocupação do RIP 8245.0000178-\r\n05 no período de 2009 a 2013.', NULL, '2019-06-03', NULL, 3, 3, '2019-05-03 12:50:35', '2019-05-03 12:50:49', 263, 2, 0, NULL, 288),
(321, 1, '2/2019', '04972.003142/2019-19', 'apenas para ciência e arquivamento', NULL, NULL, NULL, 4, NULL, '2019-05-03 14:18:18', '2019-05-03 14:18:18', 264, 2, 0, NULL, 289),
(322, 1, '658/2018', '04972.006287/2018-82', 'Subsídios à defesa da União.', NULL, NULL, '2019-05-03 17:11:19', 4, 4, '2019-05-03 17:10:08', '2019-05-03 17:11:20', 121, 3, 0, NULL, 290),
(323, 1, '293/2018', '04972.006287/2018-82', 'Indicação de assistente técnico e quesitos.', NULL, NULL, '2019-05-03 17:13:29', 4, 4, '2019-05-03 17:13:02', '2019-05-03 17:13:30', 121, 3, 0, NULL, 290),
(324, 1, '256/2019', '04972.006287/2018-82', 'envie o arquivo digital no formato .dwg\" com a linha preamar que passa sobre o imóvel em questão, que esta informação/arquivo seja enviado para o e-mail: \"topograforicardo@gmail.com\" e que seja enviada junto a informação do DATUM no qual a linha se encontra (se o DATUM SAD69 ou o DATUM SIRGAS2000), bem como a informação se esta mesma linha preamar já se encontra Homologada e qual a sua data de Homologação.', NULL, NULL, '2019-05-06 17:44:38', 4, 3, '2019-05-03 17:15:57', '2019-05-06 17:44:38', 121, 7, 0, NULL, 290),
(325, 1, '245/2019', '04972.003145/2019-44', 'Manifestação de Interesse.', NULL, '2019-05-30', NULL, 4, NULL, '2019-05-03 18:04:46', '2019-05-03 18:04:46', 228, 2, 0, NULL, 291),
(326, 1, '253/2019', '04972.003150/2019-57', 'informe em nome de quem estão registrados os imóveis em referência nesse órgão e qual a conduta prevista na lei no caso de transferência entre particulares, manifestando eventual interesse em integrar a lide.', NULL, '2019-05-17', NULL, 4, NULL, '2019-05-03 18:21:10', '2019-05-03 18:21:10', 228, 2, 0, NULL, 292),
(327, 1, '453/2019', '04972.002126/2017-39', 'prestem informações acerca da regularidade das ocupações apontadas nos autos, eventuais providências adotadas (enviando cópias dos procedimentos pertinentes), e, acaso não tenha havido autuação, sugerindo realização de fiscalização das irregularidades aventadas em sede de Inquérito Civil levada efeito pelo MPF ter-se-ia constatado suposta implantação irregular de loteamento no município de Jaguaruna/SC', NULL, '2019-05-03', NULL, 4, NULL, '2019-05-03 18:47:55', '2019-05-03 18:47:55', 265, 2, 0, NULL, 293),
(328, 1, '641/2019', '04972.003140/2019-11', 'informar sobre a adoção das medidas cabíveis, principalmente no que diz à notícia de venda da ilha pela Proconsult Projeto Consultoria e Construção Ltda.  Ilha dos Herdeiros, com RIP 83190000094-60, R!P 83190000181-08, RIP83190000186-12 e RIP 83190000505-08.', NULL, '2019-07-02', NULL, 8, NULL, '2019-05-06 11:54:24', '2019-05-06 11:54:24', 85, 2, 0, NULL, 294),
(329, 1, '321/2019', '04972.000758/2019-20', 'esclarecimentos sobre:\n1. a notícia de contaminação do Aquífero do Campeche;\n2. a contaminação dos cursos d\"água que desaguam no\nmar e a regularidade das obras de macrodrenagem na região\nda Rua dos Eucaliptos/Lagoa da Chica, com deságue no mar.', NULL, NULL, '2019-05-06 14:05:22', 4, 4, '2019-05-06 14:05:04', '2019-05-06 14:05:23', 90, 3, 0, NULL, 295),
(330, 1, '197/2019', '04972.003169/2019-01', 'Informa para ciência e acompanhamento ajuizamento da Ação de Retificação de Registro Imobiliário n. 0300068-51.2019.8.24.0167, por Beatriz Albano de Abreu, para retificação da área constante da matrícula n. 4.072 do Registro de Imóveis da Comarca de Garopaba/SC, para que conste a área de 3.450 m²m em razão do erro material na sentença proferida nos autos n. 0000025-57.2000.8.24.0167.', NULL, NULL, '2019-05-10 12:16:57', 4, 4, '2019-05-06 14:21:03', '2019-05-15 14:11:39', 65, 3, 0, NULL, 296),
(331, 1, '686/2019', '04972.003536/2017-05', 'adotadas as medidas necessárias para cumprir a r. decisão do Evento 154 (Intimem-se os reús para se manifestarem, no prazo de 15 (quinze) dias, acerca das informações lançadas na petição do Evento 152, sobretudo quanto a veracidade e comprovando as devidas providências) que faria menção a ocupação irregular noticiada (cópia anexa) por particular de parte da área objeto do presente feito.', NULL, '2019-05-17', NULL, 4, 5, '2019-05-06 17:37:41', '2019-05-22 16:38:52', 114, 2, 1, NULL, 297),
(332, 1, '1041/2018', '00013710820128240075', 'informar interferência do imóvel com área da União. Pedras Grandes/SC', NULL, '2019-05-07', '2019-05-08 12:35:55', 8, 8, '2019-05-07 12:38:08', '2019-05-08 12:35:58', 103, 3, 0, NULL, 298),
(333, 1, '91/2019', '04972.003163/2009-54', 'Informar se houve registro do imóvel em nome da União no cartório de registro de imóveis.', NULL, NULL, NULL, 4, NULL, '2019-05-07 13:09:09', '2019-05-07 13:09:09', 224, 2, 0, NULL, 299),
(334, 1, '1646/2017', '04972.000307/2017-21', 'informar acerca de quais medidas/providências/intervenções/medidas fiscalizatórias foram adotadas ou programadas pela SPU no caso concreto, no âmbito de seu poder de polícia, após a expedição do Ofício n° 15169/2017-MP ao Ministério Público Federal', NULL, '2017-10-27', '2019-05-08 14:00:46', 1, 1, '2019-05-07 13:10:22', '2019-05-08 14:00:48', 82, 3, 0, NULL, 300),
(335, 1, '90/2019', '04972.009358/2018-07', 'Informar se houve registro do imóvel no cartório em nome da União.', NULL, NULL, NULL, 4, NULL, '2019-05-07 13:32:52', '2019-05-07 13:32:52', 234, 2, 0, NULL, 301),
(336, 1, '852/2018', '04972.201364/2015-63', 'informar quanto a data em que esta SPU-SC tomou ciência das irregularidades relatadas e quanto à quais medidas fiscalizatórias foram adotadas', NULL, '2018-07-02', '2019-05-14 13:00:30', 1, 1, '2019-05-07 14:15:49', '2019-05-14 13:00:31', 82, 3, 0, NULL, 302),
(337, 1, '253/2019', '04972.002156/2016-64', 'prestar informações sobre ciência das regularidades apontadas (Bairro Guanabara, Joinville, entre as ruas Nacar e dos Cravos), quais medidas foram adotadas, existência de algum laudo, parecer, etc e se os imóveis situados na área estão cadastrados na SPU', NULL, '2019-03-22', NULL, 1, NULL, '2019-05-07 16:18:55', '2019-05-07 16:18:55', 82, 2, 0, NULL, 303),
(338, 1, '267/2019', '04972.005842/2016-97', 'informar sobre a data da ciência das ocupações e quais medidas, inclusive de fiscalização, foram tomadas até o momento', NULL, '2019-03-25', NULL, 1, NULL, '2019-05-07 16:27:40', '2019-05-07 16:27:40', 82, 2, 0, NULL, 304),
(339, 2, 's/n', '04972.003192/2019-98', 'o envio da cópia do aviso de recebimento com o fim de instruir recurso contra sentença que decretou a\r\nnulidade do lançamento pela suposta falta de notificação, nos autos do processo acima referenciado.\r\nProcessos administrativos de nº 04972.600373/2016-14 e 04972.603827/2016-17.', NULL, '2019-05-16', '2019-05-15 19:09:25', 3, 3, '2019-05-07 17:04:02', '2019-05-15 19:09:26', 266, 3, 0, NULL, 307),
(340, 1, '368/2019', '04972.005802/2016-45', 'informar sobre quais os limites exatos da área de dominialidade da União e/ou de interferência com bens de seu domínio do local descrito nos anteditos ofícios (ver 2º e 3º documentos do NUP 04972.005802/2016-45)', NULL, '2019-05-08', NULL, 1, NULL, '2019-05-07 17:04:39', '2019-05-07 17:04:39', 82, 2, 0, NULL, 305),
(341, 1, '855/2017', '04972.005318/2012-92', 'informar sobre as providências adotadas após a fiscalização realizada (Auto de Infração nº 103/COIF/SPU/SC/2013)', NULL, NULL, NULL, 1, NULL, '2019-05-07 17:19:48', '2019-05-07 17:19:48', 82, 2, 0, NULL, 312),
(342, 1, '2/2019', '04972.005203/2018-93', 'solicita que, com a finalização dos respectivos recursos administrativos, nos termos da fundamentação do julgado, seja informada a Procuradoria de Joinville para eventual levantamento da suspensão.', NULL, NULL, NULL, 4, NULL, '2019-05-07 17:32:44', '2019-05-07 17:32:44', 267, 2, 0, NULL, 313),
(343, 1, '261/2019', '04972.003233/2019-46', 'Manifestação de Interesse.', NULL, '2019-06-04', NULL, 4, 4, '2019-05-07 17:49:42', '2019-05-07 17:50:19', 228, 2, 0, NULL, 314),
(344, 1, '700/2019', '00099919720148240023', 'Manifestação de interesse.', NULL, '2019-05-21', NULL, 4, NULL, '2019-05-07 18:00:39', '2019-05-07 18:00:39', 126, 2, 0, NULL, 315),
(345, 1, '699/2019', '04972.005966/2018-34', 'Manifestação de Interesse.', NULL, '2019-05-21', '2019-05-23 20:24:01', 4, 1, '2019-05-07 18:48:33', '2019-05-24 13:22:45', 126, 3, 0, NULL, 316),
(347, 1, '596/2019', '04972.200075/2015-47', 'MAPAS OFICIAIS da demarcação para o então distrito do Município de Içara (atual Município de Balneário Rincão) para CONFRONTO, ou seja, o mapa anterior para o qual serviu de revisão para o ano 2000', NULL, '2019-05-15', '2019-05-24 13:30:41', 4, 3, '2019-05-07 19:59:45', '2019-05-24 13:35:56', 100, 3, 0, NULL, 317),
(348, 1, '691/2019', '03025240820158240007', 'Manifestação de Interesse.', NULL, '2019-05-31', NULL, 4, NULL, '2019-05-07 20:30:15', '2019-05-07 20:30:15', 143, 2, 0, NULL, 318),
(349, 1, '173/2019', '04972.001092/2019-27', 'informar a regularidade do imóvel localizado entre as ruas Antenor Borges e a esquina Vasco de Oliveira Gondin, em Canasvieiras, Florianópolois/SC', NULL, '2019-03-29', NULL, 8, 8, '2019-05-08 12:06:00', '2019-05-08 12:06:16', 248, 6, 0, NULL, 319),
(350, 1, '172/2017', '04972.000805/2017-73', 'fiscalização em área localizado na Rua Camilo de Oliveira, em Balneário Barra do Sul/SC.', NULL, '2019-05-09', '2019-05-08 14:05:56', 8, 8, '2019-05-08 12:20:26', '2019-05-08 14:05:58', 85, 3, 0, NULL, 320),
(351, 1, '0105/2019', '04972.003723/2018-61', 'Informar se as áreas atualmente ocupadas pela Locadora de DVD\'s e Ketty Lanches (Praça Vereador Halley Capanema), pelo Ney Lanches \n(Avenida Governador Celso Ramos) e pela ME Bar e Lanchonete (Praça Cel. Serafim da Silva Matos) se encontram em terrenos de marinha.', NULL, '2019-03-29', '2019-05-09 12:26:04', 8, 8, '2019-05-08 12:42:01', '2019-05-09 12:26:04', 268, 7, 0, NULL, 321),
(352, 1, '0120/2019', '04972.001328/2019-25', 'informar se a área indicada é de interesse da União. Área localizada em Joinville/SC', NULL, '2019-03-15', '2019-05-09 12:45:04', 8, 4, '2019-05-08 17:08:29', '2019-05-15 14:04:19', 269, 3, 0, NULL, 323),
(353, 1, '258/2019', '04972.003265/2019-41', 'Manifestação de Interesse.', NULL, '2019-05-17', NULL, 4, NULL, '2019-05-08 17:30:24', '2019-05-08 17:30:24', 121, 2, 0, NULL, 324),
(354, 1, '229/2019', '04972.206116/2015-17', 'Atesta-se a força executória do acórdão de apelação que julgou improcedentes os pedidos autorais, não havendo óbice no bojo do referido processo judicial para a cobrança das receitas patrimoniais afetas aos imóveis objetos da lide.', NULL, NULL, '2019-05-08 17:57:06', 4, 4, '2019-05-08 17:56:16', '2019-05-08 17:57:09', 99, 3, 0, NULL, 325),
(355, 1, '710/2019', '04972.006867/2018-70', 'manifestação conclusiva acerca da petição do impetrante do evento 12.', NULL, '2019-05-14', '2019-05-21 17:35:04', 4, 4, '2019-05-08 18:48:59', '2019-05-21 17:35:05', 143, 3, 0, NULL, 326),
(356, 1, '71/2019', '04972.001230/2019-78', 'confirmação de interferência da área com bens da União. Imóvel localizado na Rua José Medeiros Vieira, 1538, Praia Brava, Itajaí/SC.', NULL, '2019-03-08', '2019-05-09 18:04:35', 8, 4, '2019-05-09 12:51:31', '2019-05-14 18:05:54', 74, 3, 0, NULL, 327),
(357, 4, '1981/2019', '04972.003269/2019-20', 'informações acerca da regulamentação e fiscalização do uso desse bem da União, levando em consideração as tratativas do Projeto Orla e o gerenciamento costeiro, em Florianópolis - Barra da Lagoa da Conceição.', NULL, '2019-05-20', NULL, 8, NULL, '2019-05-09 13:13:38', '2019-05-09 13:13:38', 86, 2, 0, NULL, 328),
(360, 1, '265/2019', '04972.003271/2019-07', 'Manifestação de Interesse.', NULL, '2019-05-29', NULL, 4, NULL, '2019-05-09 13:42:39', '2019-05-09 13:42:39', 228, 5, 0, NULL, 329),
(361, 1, '264/2019', '04972.003273/2019-98', 'Manifestação de Interesse.', NULL, '2019-05-14', '2019-05-21 18:43:26', 4, 1, '2019-05-09 16:55:09', '2019-05-21 19:15:57', 121, 3, 0, NULL, 330),
(362, 1, '268/2019', '04972.003287/2019-10', 'Subsídios à defesa da União.', NULL, NULL, NULL, 4, 4, '2019-05-09 20:03:00', '2019-05-09 20:03:34', 121, 2, 0, NULL, 331),
(363, 1, '489/2019', '04972.004280/2016-64', 'informar acerca da regularidade da ocupação da Ilha dos Barcos perante a SPU', NULL, '2019-05-09', '2019-05-13 14:03:23', 1, 1, '2019-05-10 17:49:37', '2019-05-13 14:03:24', 85, 3, 0, NULL, 21),
(364, 9, '5013737-37.2018.4.04.7200', '04972.008389/2018-32', 'DETERMINO à autoridade impetrada queconclua a análise  do pedidos  de  averbação de transferência  n. 04972.004186/2009-86,protocolizado   em   16/10/2009,   e   dos   pedidos   de   outorga   gratuita   de   aforamentons.   04972.007791/2013-95   e   04972.207127/2015-14,   protocolizados,   respectivamente,em 21/08/2013 e 29/12/2015, no prazo máximo de 180 dias, a contar da intimação destasentença, devendo envidar todos os esforços para que essa conclusão ocorra no menor tempopossível, cobrando da AGU, de forma devidamente comprovada, a breve manifestação acercada questão abstrata pendente', NULL, '2019-11-03', NULL, 1, NULL, '2019-05-10 19:04:31', '2019-05-10 19:04:31', 261, 2, 1, NULL, 332),
(365, 9, '5010405-28.2019.4.04.7200', '04972.003350/2019-18', 'O MS foi impetrado por Altamiro Rogério Philippi e demais filhos do senhor Arlindo Francisco Philippi, já falecido, foreiro do imóvel de RIP nº 0983.009682/82-47, situado na Rua Francisco Tolentino, 657, em Florianópolis/SC.\r\n\r\nEm resumo, contestam a decisão administrativa proferida na Nota Técnica nº 27122/2018-MP (7454936), acolhida no Despacho SEREP-SPU-SC nº 8555990, integrantes  do processo nº 0983.009862/82-47 (a este relacionado), que indeferiu pedido de cancelamento de débitos de laudêmio por prescrição.', NULL, '2019-05-23', NULL, 1, NULL, '2019-05-13 20:34:46', '2019-05-13 20:34:46', 161, 2, 1, NULL, 333),
(366, 1, '1052/2017', '04972.004413/2017-83', 'informar interferência com área da União o imóvel está situado em local próximo à rodovia municipal PGR-104, no município de Praia Grande/SC.', NULL, '2017-09-26', '2019-05-14 12:01:52', 8, 8, '2019-05-14 12:01:39', '2019-05-14 12:01:53', 56, 3, 0, NULL, 334),
(367, 9, '01/2019', '04972.001960/2019-79', 'a penhora DO DOMÍNIO ÚTIL ou direito real de uso que a executada, Imbituba Empreendimentos e Participações S/A, CNPJ 27.276.211/0001-08, detém sobre o imóvel matriculado sob o n.° 14.808', NULL, '2019-05-10', '2019-05-20 11:58:19', 8, 8, '2019-05-14 12:58:22', '2019-05-20 11:58:21', 270, 3, 0, NULL, 336),
(368, 1, '266/2019', '04972.003388/2019-82', 'Manifestação de Interesse.', NULL, '2019-05-28', NULL, 4, NULL, '2019-05-14 17:04:04', '2019-05-14 17:04:04', 121, 2, 0, NULL, 337),
(369, 1, '94/2019', '04972.202955/2015-58', 'Manifestação sobre nova documentação.', NULL, '2019-05-24', NULL, 4, NULL, '2019-05-14 17:15:32', '2019-05-14 17:15:32', 224, 5, 0, NULL, 338),
(370, 1, '719/2019', '04972.207030/2015-01', 'Informação sobre a área compreendida no RIP nº 8143.0000141-02', NULL, '2019-05-24', NULL, 4, 5, '2019-05-14 17:31:05', '2019-05-22 17:47:18', 126, 5, 0, NULL, 123),
(371, 1, '718/2019', '04972.003389/2019-27', 'Prestar Informações em Mandado de Segurança.', NULL, '2019-05-20', '2019-05-15 12:57:22', 4, 3, '2019-05-14 17:55:30', '2019-05-15 12:57:34', 143, 3, 0, NULL, 339),
(372, 1, '719/2019', '04972.003396/2019-29', 'Subsídios à defesa da União.', NULL, '2019-05-24', '2019-05-20 13:46:50', 4, 3, '2019-05-14 18:35:35', '2019-05-20 13:46:52', 126, 3, 0, NULL, 341),
(373, 1, '334/2019', '04972.003432/2019-54', 'que seja informada a regularidade do empreendimento \"Spazio Bauhaus\", localizado na Rua Heinrich Hemmer, n° 1900, Bairro Badenfurt, município de Blumenau', NULL, '2019-05-29', NULL, 8, 8, '2019-05-15 12:30:50', '2019-05-15 12:34:32', 76, 5, 0, NULL, 342),
(374, 1, '340/2019', '04972.003433/2019-07', 'informar sobre a regularidade da posse exercida nos lotes 4, 5, 6, 8, 11/12 e 20/21, do Loteamento Jardim das Gaivotas, no Município de Itapema.', NULL, '2019-06-14', NULL, 8, NULL, '2019-05-15 12:44:14', '2019-05-15 12:44:14', 74, 2, 0, NULL, 343),
(375, 1, '696/2019', '04972.003230/2019-11', 'Manifestação de Interesse.', NULL, '2019-05-10', '2019-05-15 13:55:06', 4, 4, '2019-05-15 13:54:49', '2019-05-15 13:55:06', 126, 7, 0, NULL, 344),
(376, 1, '5555/2018-GAB-WAM', '04972.001477/2010-56', 'informar sobre situação do processo de regularização da área (demolição das benfeitorias e aterro irregular/trapiche) em Coqueiros, Florianópolis/SC. LR Amorim Administradora de Bens LTDA', NULL, '2019-01-02', '2019-05-21 13:35:40', 1, 1, '2019-05-15 18:54:23', '2019-05-21 13:35:41', 95, 3, 0, NULL, 345),
(377, 1, '150/2019', '04972.003439/2019-76', 'Seja verificado se há intervenção em imóveis da União, especialmente, em terreno de marinha, solicitando que caso a SPU verifique alguma ocorrência de fraude ou interesse da União em determinada ação de usucapião, em trâmite no Município de Barra Velha, a Procuradoria Seccional da União em Joinville seja comunicada para as providências cabíveis', NULL, NULL, NULL, 4, NULL, '2019-05-15 19:30:50', '2019-05-15 19:30:50', 103, 2, 0, NULL, 346),
(378, 1, '292/2019', '04972.005743/2018-77', 'indicação de assistente técnico e apresentação de\r\nquesitos, no prazo de 10 dias.', NULL, '2019-05-25', NULL, 3, NULL, '2019-05-16 12:53:20', '2019-05-16 12:53:20', 228, 2, 0, NULL, 347),
(379, 1, '0193/2019', '04972.007420/2014-94', 'registro da  isenção do pagamento da taxa de ocupação do imóvel cadastrado sob o RIP nº 8265.0000123-01, exclusivamente para as competências 2007 a 2013', NULL, '2019-05-23', '2019-05-16 16:42:41', 8, 8, '2019-05-16 13:03:09', '2019-05-16 16:42:43', 243, 3, 1, NULL, 348),
(380, 1, '720004585493', '04972.003464/2019-50', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC.', NULL, NULL, '2019-05-17 17:33:37', 8, 8, '2019-05-16 18:25:25', '2019-05-17 17:33:38', 240, 3, 1, NULL, 351),
(381, 1, '720004596359', '04972.003461/2019-16', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-17 17:19:46', 8, 8, '2019-05-16 18:27:41', '2019-05-17 17:19:47', 240, 3, 1, NULL, 352);
INSERT INTO `demanda` (`id`, `idTipoDocumento`, `documentoExterno`, `nupSEI`, `demanda`, `dataDocumento`, `dataPrazo`, `dataResposta`, `idUsuarioCriacao`, `idUsuarioAlteracao`, `created_at`, `updated_at`, `idAutorDemanda`, `idSituacaoDemanda`, `sentencajudicial`, `idCategoriaDemanda`, `idProcedimentoExterno`) VALUES
(382, 1, '72000458550', '04972.003462/2019-61', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/S', NULL, NULL, '2019-05-17 17:20:13', 8, 8, '2019-05-16 18:30:07', '2019-05-17 17:20:14', 240, 3, 1, NULL, 353),
(383, 1, '72000458545', '04972.003463/2019-13', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-17 17:20:35', 8, 8, '2019-05-16 18:33:16', '2019-05-17 17:20:36', 240, 3, 1, NULL, 355),
(384, 1, '720004583502', '04972.003460/2019-71', 'à prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/S', NULL, NULL, '2019-05-17 12:20:51', 8, 8, '2019-05-16 18:36:00', '2019-05-17 12:20:56', 240, 3, 1, NULL, 356),
(385, 1, '720004589712', '04972.003466/2019-49', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-16 19:27:59', 8, 8, '2019-05-16 18:39:10', '2019-05-16 19:28:00', 240, 3, 1, NULL, 357),
(386, 1, '720004584845', '04972.003465/2019-02', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, NULL, '2019-05-17 18:03:08', 8, 8, '2019-05-16 18:41:04', '2019-05-17 18:03:09', 240, 3, 1, NULL, 358),
(387, 1, '2873/2018', '04972.006553/2018-77', 'informar sobre:\r\n\r\n    a delimitação da LPM/1831 para toda a localidade do Morro e da Praia do Matadeiro, isto é, na fração de terras existente entre a ponte localizada ao final da Rua Fernando Beck (coordenadas N=6927571 E=745992 — Google Earth), e a Ponta do Quebra Remo, (coordenadas N=6927351 E=747562 — Google Earth);\r\n     \r\n    a identificação de cada uma das edificações que ocupam terreno de marinha;\r\n\r\n    as providências técnicas de retirada do molhe que une a margem esquerda da foz do Rio Quincas Antônio à Ponta das Campanhas, a fim de possibilitar o restabelecimento do fluxo de\r\n    sedimentos entre a Praia da Armaçãoo do Pântano do Sul e a Praia do Matadeiro; e\r\n\r\n    a demolição das construções que ocupam ilegalmente bens da UNIÃO no local.', NULL, '2018-07-25', NULL, 1, 1, '2019-05-16 20:32:20', '2019-05-16 20:33:40', 90, 2, 0, NULL, 359),
(388, 1, '97/2019', '04972.000611/2017-78', 'Manifestação sobre laudo pericial', NULL, '2019-05-30', NULL, 4, NULL, '2019-05-17 13:39:03', '2019-05-17 13:39:03', 224, 2, 0, NULL, 360),
(389, 1, '290/2019', '04972.010806/2018-15', 'análise e manifestação quanto possibilidade de perdão da dívida', NULL, '2019-05-24', NULL, 4, NULL, '2019-05-17 14:10:07', '2019-05-17 14:10:07', 106, 2, 0, NULL, 130),
(390, 1, '749/2019', '04972.200914/2015-27', 'Indique assistente técnico e formule quesitos para a defesa da União', NULL, '2019-05-24', NULL, 4, NULL, '2019-05-17 14:30:04', '2019-05-17 14:30:04', 126, 2, 0, NULL, 361),
(391, 1, '289/2019', '04972.003500/2019-85', 'Subsídios à defesa da União', NULL, '2019-06-05', NULL, 4, NULL, '2019-05-17 17:21:34', '2019-05-17 17:21:34', 228, 2, 0, NULL, 362),
(392, 1, '98/2019', '03002583120158240045', 'Indicação de assistente técnico e formulação de quesitos', NULL, '2019-05-31', NULL, 4, NULL, '2019-05-17 17:38:31', '2019-05-17 17:38:31', 234, 2, 0, NULL, 31),
(393, 1, '756/2019', '04972.003502/2019-74', 'Manifestação de Interesse.', NULL, '2019-05-21', NULL, 4, NULL, '2019-05-17 18:15:27', '2019-05-17 18:15:27', 126, 2, 0, NULL, 364),
(394, 1, '720004589812', '04972.003467/2019-93', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-17 18:46:25', 8, 8, '2019-05-17 18:43:46', '2019-05-17 18:46:26', 240, 3, 1, NULL, 365),
(395, 1, '763/2019', '04972.005401/2016-95', 'Manifestação sobre laudo Pericial', NULL, '2019-05-30', NULL, 4, NULL, '2019-05-17 19:10:34', '2019-05-17 19:10:34', 126, 2, 0, NULL, 29),
(396, 1, '720004589845', '04972.003475/2019-30', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, NULL, '2019-05-20 16:37:09', 8, 8, '2019-05-20 12:17:26', '2019-05-20 16:37:10', 240, 3, 1, NULL, 366),
(397, 1, '720004589783', '04972.003476/2019-84', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, NULL, '2019-05-20 16:45:26', 8, 8, '2019-05-20 12:21:12', '2019-05-20 16:45:27', 240, 3, 1, NULL, 367),
(398, 1, '720004588388', '04972.003477/2019-29', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-20 19:06:44', 8, 8, '2019-05-20 12:23:13', '2019-05-20 19:06:45', 240, 3, 1, NULL, 368),
(399, 1, '720004589764', '04972.003478/2019-73', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-22 11:39:36', 8, 8, '2019-05-20 12:54:50', '2019-05-22 11:39:37', 240, 3, 1, NULL, 369),
(400, 1, '720004585474', '04972.003479/2019-18', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-22 11:39:04', 8, 8, '2019-05-20 12:57:06', '2019-05-22 11:39:05', 240, 3, 1, NULL, 370),
(401, 1, '720004584770', '04972.003480/2019-42', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-21 18:26:08', 8, 8, '2019-05-20 12:59:43', '2019-05-21 18:26:09', 240, 3, 1, NULL, 371),
(402, 1, '720004584754', '04972.003481/2019-97', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-21 11:21:37', 8, 8, '2019-05-20 13:10:51', '2019-05-21 11:21:38', 240, 3, 1, NULL, 372),
(403, 1, '720004584673', '04972.003482/2019-31', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-21 11:20:45', 8, 8, '2019-05-20 13:12:42', '2019-05-21 11:20:46', 240, 3, 1, NULL, 374),
(404, 1, '72000458406', '04972.003483/2019-86', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', NULL, NULL, '2019-05-21 11:19:47', 8, 8, '2019-05-20 13:14:48', '2019-05-21 11:19:48', 240, 3, 1, NULL, 375),
(405, 1, '720004584808', '04972.003484/2019-21', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', NULL, NULL, '2019-05-20 17:25:46', 8, 8, '2019-05-20 13:16:23', '2019-05-20 17:25:47', 240, 3, 1, NULL, 376),
(406, 1, '761/2019', '04972.003534/2019-70', 'Vistoria no local e se verifique se a sentença foi cumprida no que se refere à demolição', NULL, '2019-05-31', NULL, 4, NULL, '2019-05-20 14:14:37', '2019-05-20 14:14:37', 126, 2, 0, NULL, 377),
(407, 1, '760/2019', '04972.007460/2017-89', 'Manifestação de Interesse.', NULL, '2019-05-30', NULL, 4, NULL, '2019-05-20 16:39:03', '2019-05-20 16:39:03', 126, 2, 0, NULL, 378),
(408, 1, '663/2019', '04972.205274/2015-41', 'Manifestação sobre laudo complementar', NULL, '2019-06-05', NULL, 4, NULL, '2019-05-20 16:50:23', '2019-05-20 16:50:23', 100, 2, 0, NULL, 53),
(409, 1, '665/2019', '04972.006238/2018-40', 'Informa sobre a concessão da dilação do prazo, em 30 (trinta) dias, para o cumprimento da obrigação de fazer', NULL, '2019-06-10', NULL, 4, NULL, '2019-05-20 17:04:49', '2019-05-20 17:04:49', 100, 2, 0, NULL, 206),
(410, 1, '2021/2019', '04972.008373/2017-49', 'informe, no prazo de 15 (quinze) dias úteis, a atual situação do projeto habitacional aos integrantes da \' Ocupação Contestado \' .', NULL, '2019-05-25', '2019-05-20 17:25:16', 4, 4, '2019-05-20 17:24:49', '2019-05-20 17:25:17', 58, 3, 0, NULL, 110),
(411, 1, '664/2019', '04972.003536/2019-69', 'Indicação de assistente técnico e quesitos', NULL, '2019-06-07', NULL, 4, NULL, '2019-05-20 18:19:24', '2019-05-20 18:19:24', 100, 2, 0, NULL, 379),
(412, 1, '678/2019', '00556.001083/2015-62', 'informar ao juízo acerca do andamento do processo administrativo nº 04972.004901/2010-14, objeto da ação', NULL, '2019-06-07', NULL, 4, NULL, '2019-05-20 19:26:50', '2019-05-20 19:26:50', 100, 2, 0, NULL, 380),
(413, 1, '669/2019', '04972.003552/2019-51', 'Encaminha o o PARECER DE FORÇA EXECUTÓRIA n.00059/2019/PSUCCO/PGU/AGU, que atesta que á a SPU cumprir a decisão, deixando de exigir eventuais taxas de ocupação, laudêmio e/ou multa por atraso na transferência, enquanto não concluído o regular procedimento administrativo demarcatório das terras de marinha e inscritos os referidos imóveis.', NULL, NULL, NULL, 4, NULL, '2019-05-21 14:31:05', '2019-05-21 14:31:05', 100, 5, 0, NULL, 381),
(414, 1, '662/2019', '04972.003553/2019-04', 'Encaminha  O PARECER DE FORÇA EXECUTÓRIA n.00058/2019/PSUCCO/PGU/AGU, atestando a força executória plena do acórdão proferido pelo TRF da 4ª Região, podendo\na SPU/SC exigir do autor da ação o laudêmio e a multa devidos no caso concreto.', NULL, NULL, NULL, 4, 4, '2019-05-21 17:02:05', '2019-05-21 17:02:29', 100, 4, 0, NULL, 382),
(415, 1, '300/2019', '04972.001438/2019-97', 'Verificar regularidade e interferência da área com bem da União, casa e trapiche, localizadas na Rua José Dobrotinick, esquina com a Avenida Lindolfo de Freitas Ledoux (coordenadas: 26°14\'50.53\"S/48°4228.081\"O)', NULL, '2019-03-29', NULL, 8, NULL, '2019-05-21 18:20:46', '2019-05-21 18:20:46', 85, 2, 0, NULL, 383),
(416, 1, '287/2019', '04972.003560/2019-06', 'Manifestação de Interesse', NULL, '2019-06-03', NULL, 4, NULL, '2019-05-21 18:21:15', '2019-05-21 18:21:15', 201, 2, 0, NULL, 384),
(417, 1, '285/2019', '04972.003568/2019-64', 'Manifestação de Interesse.', NULL, '2019-06-26', NULL, 4, NULL, '2019-05-21 18:47:29', '2019-05-21 18:47:29', 121, 2, 0, NULL, 386),
(418, 1, '95/2019', '04972.205738/2015-10', 'Manifestação sobre proposta de acordo.', NULL, '2019-05-30', NULL, 4, NULL, '2019-05-21 20:37:52', '2019-05-21 20:37:52', 224, 2, 0, NULL, 387),
(419, 1, '255', '04972.003265/2016-07', 'informar regularidade do imóvel e a possibilidade atividade de carcinicultura realizada por José Vanderlei dos Santos na citada área é passível de registro de ocupação.', NULL, '2019-03-25', NULL, 8, 8, '2019-05-22 12:05:41', '2019-05-22 12:07:03', 82, 2, 0, NULL, 388),
(420, 1, '00070/2019', '04972.004030/2016-24', 'participação em audiência 27/06/2019', NULL, '2019-06-27', '2019-05-22 17:01:07', 8, 8, '2019-05-22 16:59:47', '2019-05-22 17:01:08', 224, 3, 0, NULL, 132),
(421, 1, '00142/2019', '04902.000813/2019-13', 'Limitação administrativa - imóvel localizado na Av. Aroeira da Praia, Mariscal, ao lado do n. 1527 - Bombinhas/SC', NULL, '2019-05-24', NULL, 8, NULL, '2019-05-22 17:30:56', '2019-05-22 17:30:56', 271, 2, 0, NULL, 392),
(422, 1, '608/2019', '04972.003629/2019-93', 'Encaminha  PARECER DE FORÇA EXECUTÓRIA n.00050/2019/PSUCCO/PGU/A G U', NULL, NULL, '2019-05-22 17:49:33', 4, 4, '2019-05-22 17:49:14', '2019-05-22 17:49:34', 100, 3, 0, NULL, 393),
(423, 1, '00153/2019', '04972.001860/2019-42', 'informar eventual interesse da União na lide.', NULL, '2019-04-01', NULL, 8, 8, '2019-05-23 18:03:32', '2019-05-23 18:04:44', 228, 2, 0, NULL, 394),
(424, 1, '1/2019', '04972.007847/2013-10', 'Para ciência e adoção de providências.', NULL, NULL, NULL, 4, NULL, '2019-05-23 19:02:34', '2019-05-23 19:02:34', 272, 2, 0, NULL, 395),
(425, 1, '1751/2019', '04972.003663/2019-68', 'informar a existência de inscrição de ocupação em favor do Sr. Wendell Ferreira da Silva, CPF 257.319.408-60.', NULL, '2019-06-03', NULL, 8, NULL, '2019-05-24 12:30:58', '2019-05-24 12:30:58', 86, 2, 0, NULL, 397),
(426, 1, '19/2019', '04972.006143/2017-45', 'Manifestação acerca do laudo pericial complementar.', NULL, '2019-06-05', NULL, 4, NULL, '2019-05-24 17:58:42', '2019-05-24 17:58:42', 122, 2, 0, NULL, 37),
(427, 1, '750/2019', '04972.004280/2016-64', 'Demandante fornece cópia do IC 1.33.005.000308/2013-31', NULL, NULL, NULL, 1, 1, '2019-05-24 18:04:10', '2019-05-24 18:04:16', 85, 2, 0, NULL, 400),
(428, 1, '238/2018', '04972.205664/2015-11', 'informações  e  encaminhamento  dedocumentos  a  respeito  da  edificação,  situada  na Av. Dr. Armando Petrelli,  n°  142,  centro,de  Barra  Velha/SC, Coordenadas UTM:  22J  730894  7025159,  matriculado  sob o  n°  1945 noCartório  de  Registro  de  Imóveis  da  Comarca de  Barra  Velha,  cujo  proprietário  é  NestorDomingo  Roque Féssia, inscrito   no  CPF sob  o  n°  948.092.839-68, notadamente  acerca  dequais  providências/intervenções/medidas  fiscalizatórias  foram  adotadas pela  SPU em  facede   Nestor  Domingo  Roque   Féssia.   no  âmbito  de  seu  poder   de  polícia,  para  evitar  aconstrução da aludida edificação  no  local.', NULL, '2018-04-09', '2019-05-24 18:14:26', 1, 1, '2019-05-24 18:13:52', '2019-05-24 18:14:28', 82, 3, 0, NULL, 401),
(429, 1, '333/2019', '04972.005807/2016-78', '(i) Quais foram as medidas  adotadas  pela  Secretaria  de  Património  daUnião,  no âmbito  de seu poder  de polícia,  a fim  de impedir  as  edificações,em terras  de domínio da União,  localizadas  nos loteamentos  José Loureiro le  II,  no Bairro  Ulysses Guimarães,  em Joinville; e\r\n(ii.)  quais  foram  as  medidas  adotadas  pela  Secretaria  de  Património  daUnião,   no  âmbito   de  seu  poder   de  polícia,   após  ter   sido   constatado,inequivocamente,   a  existência   de  imóveis  interferindo  em  terreno  demarinha   e  acrescidos,  conforme   Ofício   n.   73949/2016-MP  e  Ofício   n°66144/2018-MP (anexos).', NULL, '2019-04-05', NULL, 1, NULL, '2019-05-24 19:27:44', '2019-05-24 19:27:44', 82, 2, 0, NULL, 402),
(430, 1, '351/2019', '04972.003689/2019-14', 'infomar quais foram as medidas adotadas pela Secretaria de Património da União, no âmbito de seu poder de polícia, a fim de impedir as edificações, em terras de domínio da União,  localizadas  no loteamento  José Loureiro  II,no Bairro  Ulysses Guimarães,  em Joinville; e(ii.)  quais  foram  as  medidas   adotadas   pela  Secretaria  de  Património  daUnião,   no  âmbito  de  seu  poder   de  polícia,   após  ter   sido   constatado,inequivocamente,    a  existência   de  imóveis   interferindo  em  terreno  demarinha   e  acrescidos,  conforme   Ofício   n.   73949/2016-MP (2842113 - NUP 04972.006136/2016-62)', NULL, '2019-05-30', NULL, 1, 1, '2019-05-24 19:48:47', '2019-05-24 19:49:43', 82, 2, 0, NULL, 403);

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
(5, 22, 1, '2019-03-26 16:59:49', '2019-03-26 16:59:49', 'Juliano, o Advogado da União ligou hoje para cá cobrando essa resposta. Deixou o telefone dele 99935-3732', NULL, 'App\\User', 5),
(6, 23, 4, '2019-03-26 17:21:43', '2019-03-26 17:21:43', NULL, NULL, 'App\\User', 5),
(7, 2, 1, '2019-03-11 13:08:16', NULL, 'Atualizando as atribuições de acordo com os andamentos no SEI', NULL, 'App\\User', 5),
(8, 27, 1, '2019-03-11 13:49:25', '2019-03-11 13:49:25', NULL, 'Atribuição duplicada', 'App\\User', 1),
(9, 27, 1, '2019-03-12 14:44:53', '2019-03-12 14:44:53', NULL, 'Respondia pelo Ofício 18539/2019', 'App\\User', 1),
(10, 33, 1, '2019-03-26 17:01:38', '2019-03-26 17:01:38', 'Informar se área incide com bens da União com base na informação prestada pelo Município (planta)', NULL, 'App\\User', 5),
(11, 35, 1, '2019-03-19 14:17:37', '2019-03-19 14:17:37', 'Apresentar memorial/planta legível com coordenadas UTM em que demonstre a interferência com área de marinha', 'Respondido pelo Ofício nº 19374/2019/DIGES-SPU-SC/MP', 'App\\User', 5),
(12, 36, 1, '2019-03-15 14:14:10', '2019-03-15 14:14:10', NULL, 'Nota Técnica nº 5855/2019-MP', 'App\\User', 5),
(13, 37, 1, '2019-03-19 14:14:31', '2019-03-19 14:14:31', 'Analisar o levantamento topográfico fornecido pelo Município de Biguaçu e produzir manifestação sobre interesse da União no feito.', 'Respondido pelo Ofício nº 19209/2019/DIGES-SPU-SC/MP', 'App\\User', 5),
(14, 1, 1, '2019-04-15 19:47:19', '2019-04-15 19:47:19', 'apresentar o exato posicionamento dos terrenos e acrescidos de marinha nas áreas compreendidas nas transcrições nº 12.480, nº 12.481 e nº 3.386 (evento 1, OUT35, fls. 16-33) e na matrícula nº 13.204 (evento 1, OUT35, fls. 13-15)', NULL, 'App\\User', 5),
(15, 39, 1, '2019-03-15 17:15:35', '2019-03-15 17:15:35', 'Minutar ofício de resposta', 'Ofício nº 18987/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(16, 40, 1, '2019-03-15 14:08:25', '2019-03-15 14:08:25', 'indicar assistente técnico e formular quesitos', 'Atendido pela Nota Técnica 5948/2019 - 8153476', 'App\\User', 5),
(17, 34, 1, '2019-03-26 17:20:13', '2019-03-26 17:20:13', 'produzir manifestação sobre laudo pericial', NULL, 'App\\User', 5),
(18, 41, 1, '2019-03-12 18:23:12', NULL, 'para ciência e eventuais providências decorrentes da sentença proferida na ação', NULL, 'App\\User', 5),
(19, 48, 8, '2019-03-26 16:58:22', '2019-03-26 16:58:22', NULL, NULL, 'App\\User', 5),
(20, 53, 4, '2019-03-26 17:04:38', '2019-03-26 17:04:38', NULL, NULL, 'App\\User', 5),
(21, 14, 1, '2019-03-15 14:39:46', '2019-03-15 14:39:46', 'Minutar Ofício ao Município para demolição dos quiosques', 'Ofício nº 20223/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(22, 65, 3, '2019-03-15 14:23:21', NULL, NULL, NULL, 'App\\User', 3),
(23, 66, 1, '2019-03-15 17:29:05', '2019-03-15 17:29:05', '9999999999999', NULL, 'App\\User', 1),
(24, 66, 1, '2019-03-15 17:46:10', '2019-03-15 17:46:10', NULL, NULL, 'App\\User', 1),
(25, 69, 8, '2019-03-18 16:25:58', '2019-03-18 16:25:58', 'Processo em fase avançada. Tramitou sem manifestação da SPU/SC.', NULL, 'App\\User', 8),
(26, 75, 8, '2019-04-03 19:36:19', '2019-04-03 19:36:19', NULL, NULL, 'App\\User', 5),
(27, 76, 8, '2019-03-19 11:59:24', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 3),
(28, 49, 4, '2019-03-19 13:15:38', '2019-03-19 13:15:38', NULL, NULL, 'App\\User', 4),
(29, 57, 1, '2019-03-19 13:41:55', '2019-03-19 13:41:55', 'Oficiar AGU para que consulte o juíz da ação sobre eventual cumprimento por parte do réu, dado que recebemos informações de que haveria uma demolição em curso.', 'Enviado o Ofício nº 20969/2019/SPU-SC/MP', 'App\\User', 10),
(30, 57, 1, '2019-04-08 18:37:33', '2019-04-08 18:37:33', 'Monitorar resposta da AGU para providênciais.', 'Aguardando resposta ao Ofício nº 20969/2019/SPU-SC/MP (8171987)', 'App\\User', 1),
(31, 41, 1, '2019-03-19 14:20:10', '2019-03-19 14:20:10', 'Favor ignorar essa distribuição: apenas para atualizar a situação de demanda', NULL, 'App\\User', 1),
(32, 64, 1, '2019-03-26 14:01:10', '2019-03-26 14:01:10', 'Resposta cobrada por telefone e email para PUSC em 22/03/2019 - 15:45h. Prazo ePROC 27/03/2017', NULL, 'App\\User', 5),
(33, 95, 8, '2019-04-03 18:30:08', '2019-04-03 18:30:08', NULL, 'Atribuido ao Manglio', 'App\\User', 5),
(34, 64, 1, '2019-03-26 19:10:56', '2019-03-26 19:10:56', 'Aguardar assinatura do SPU-SC para envio do Ofício nº 23845/2019/DIGES-SPU-SC/MP', NULL, 'App\\User', 1),
(35, 48, 5, '2019-03-26 16:58:16', '2019-03-26 16:58:16', NULL, NULL, 'App\\User', 5),
(36, 63, 3, '2019-03-26 19:37:31', '2019-03-26 19:37:31', NULL, NULL, 'App\\User', 3),
(37, 50, 5, '2019-03-27 16:47:28', '2019-03-27 16:47:28', NULL, NULL, 'App\\User', 5),
(38, 50, 1, '2019-03-27 20:33:09', '2019-03-27 20:33:09', 'Aguardando assinatura do SPU-SC', 'Atendida através do Ofício nº 24506/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(39, 98, 1, '2019-04-24 17:43:42', '2019-04-24 17:43:42', 'Tomar ciência do fato, além das providências pertinentes para a solução dos problemas referidos no Auto de Constatação (avarias no prédio). Comunicar ao MPF sobre as medidas que serão adotadas.', 'Conversei com Antonio da CODES-SPU-SC para dar tratamento à demanda.', 'App\\User', 1),
(40, 122, 1, '2019-03-27 19:00:45', '2019-03-27 19:00:45', 'Encaminhar à CODES-SPU-SC', 'Encaminhado através do Despacho DIGES-SPU-SC nº 8239769', 'App\\User', 1),
(41, 122, 1, '2019-05-09 18:31:19', '2019-05-09 18:31:19', 'Prestar informações sobre a atual situação do projeto habitacional aos integrantes da \'Ocupação Contestado\'', 'E-mail DIRFH-SPU-SC 8245444', 'App\\DivisaoOrganograma', 4),
(42, 127, 1, '2019-03-27 19:24:18', NULL, 'Juliano, estou encaminhando para você essa demanda para você tratar com o setor de fiscalização', NULL, 'App\\User', 5),
(43, 131, 1, '2019-03-27 20:31:00', '2019-03-27 20:31:00', 'Aguardando assinatura do Bauer para envio do Ofício 24636', 'Ofício 246636 enviado.', 'App\\User', 1),
(44, 70, 1, '2019-03-27 20:36:20', NULL, NULL, NULL, 'App\\User', 5),
(45, 96, 1, '2019-04-03 18:12:02', '2019-04-03 18:12:02', 'Para acompanhamento (por estar o NUP SEI atribuído ao mesmo CPF)', NULL, 'App\\User', 8),
(46, 51, 1, '2019-03-27 20:41:56', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 5),
(47, 72, 1, '2019-04-01 13:46:43', '2019-04-01 13:46:43', 'Distribuindo ao mesmo CPF ao qual o NUP SEI está atribuído', NULL, 'App\\User', 3),
(48, 25, 1, '2019-04-03 21:01:21', '2019-04-03 21:01:21', 'Prestar informação sobre interferência da área sobre bens da União.', 'Nota Técnica nº 7699/2019-MP', 'App\\User', 13),
(49, 32, 1, '2019-04-03 12:49:17', '2019-04-03 12:49:17', 'Prestar informação sobre interferência da área sobre bens da União.', NULL, 'App\\User', 13),
(50, 74, 1, '2019-04-03 18:39:10', '2019-04-03 18:39:10', 'Informar se o imóvel localizado na Servidão LuízaMaria dos Santos (Dona Zinha) nº 255, São João do Rio Vermelho, CEP: 88060-435, município de Florianópolis/SC, está localizado em terreno de marinha', NULL, 'App\\User', 5),
(51, 55, 1, '2019-04-08 17:30:07', '2019-04-08 17:30:07', 'Fornecer documentos solicitados pelo perito. Ver Ofício 276/2019 (8147765)', 'Fazer o Ofício encaminhando o Anexo: Cartas Topográficas 747-096 e 748-096. Não tem necessidade de fazer Nota Técnica.', 'App\\User', 5),
(52, 67, 1, '2019-04-03 20:59:34', '2019-04-03 20:59:34', 'informar se há, também, interesse da União no referido processo deoposição', 'Nota Técnica nº 7869/2019-MP', 'App\\User', 13),
(53, 68, 1, '2019-04-03 20:55:42', '2019-04-03 20:55:42', 'informar sobre a ação de usucapião de imóvel acima identificada esolicito que essa SPU/SC manifeste eventual interesse em intervir na lide', 'Atendido por meio da Nota Técnica nº 7927/2019-MP', 'App\\User', 13),
(54, 71, 1, '2019-05-09 13:11:17', '2019-05-09 13:11:17', 'Encaminhado conforme Despacho DIINC-SPU-SC 8227231', 'Ofício nº 36448/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(55, 90, 1, '2019-04-02 11:50:53', '2019-04-02 11:50:53', 'Encaminhado conforme Despacho DIGES-SPU-SC 7970003', 'Foi indicado para participar da audiência o servidor João José dos Santos, CPF 542.170.249-91, Matrícula SIAPE 1021974.', 'App\\User', 8),
(56, 73, 1, '2019-04-03 21:00:29', '2019-04-03 21:00:29', 'informar  sobre  o  predicado  público –ou  não,  da  terra  discutida,  dando  a  saber  a (in)existência  de  pedido  de  ocupação/aforamento/autorização/cessão  (etc)  junto  à  SPU,  e  o interesse  da  mesma  na  figuração  da  UF  nos  autos,  em  defesa  de  sua  posição  jurídica eventualmente tangida', 'Nota Técnica nº 7783/2019-MP', 'App\\User', 13),
(57, 77, 1, '2019-03-28 14:28:18', NULL, 'Encaminhada conforme Despacho DIGES-SPU-SC nº 8234112', NULL, 'App\\DivisaoOrganograma', 4),
(58, 135, 4, '2019-04-08 16:18:33', '2019-04-08 16:18:33', NULL, NULL, 'App\\User', 4),
(59, 72, 1, '2019-04-10 17:00:05', '2019-04-10 17:00:05', 'Assumindo a demanda para tratar com Bauer/Camila/Marina/Juliano', 'Distribuindo ao Niarcos por estar saindo de férias', 'App\\User', 1),
(60, 46, 5, '2019-04-08 18:52:35', '2019-04-08 18:52:35', NULL, NULL, 'App\\User', 13),
(61, 150, 1, '2019-04-02 12:58:59', '2019-04-02 12:58:59', 'aguardando assinatura do SPU-SC para envio da resposta', 'Respondida através do Ofício 26099/2019', 'App\\User', 1),
(62, 151, 1, '2019-04-03 12:16:46', '2019-04-03 12:16:46', 'manifestação acerca dos documentos juntados pela parte autora no evento 227 (novo memorial descritivo)\r\nSolicitamos dilaçao de prazo em 01/04/2019', NULL, 'App\\User', 5),
(63, 152, 1, '2019-04-02 12:56:05', '2019-04-02 12:56:05', 'aguardando assinatura do SPU-SC para envio da resposta', 'Respondida através do Ofício 26202/2019', 'App\\User', 1),
(64, 155, 1, '2019-04-02 13:41:53', NULL, 'Demanda distribuída conforme carga atual do SEI (aberta na COCAI no seu CPF)', NULL, 'App\\User', 5),
(65, 156, 1, '2019-04-02 14:00:02', NULL, 'Existem duas demandas abertas para esse NUP, uma do MPF (Ofício 6/2019 do Eduardo Barrgan) e esta, da Prefeitura de São José (enviado por email, anexado ao processo).', NULL, 'App\\User', 5),
(66, 157, 3, '2019-04-22 14:22:53', '2019-04-22 14:22:53', 'A questão envolve terras indígenas no Cambirela - Palhoça', NULL, 'App\\User', 5),
(67, 158, 3, '2019-04-22 16:59:55', '2019-04-22 16:59:55', 'Abertura de acessos - Governador Celso Ramos', NULL, 'App\\User', 5),
(68, 158, 3, '2019-04-24 18:47:50', '2019-04-24 18:47:50', 'Acessos  -Governador Celso Ramos', NULL, 'App\\User', 5),
(69, 164, 1, '2019-04-04 19:33:23', '2019-04-04 19:33:23', 'Conversar com o Juliano para entender o que falta para fazer a transferência e dar o encaminhamento necessário', 'enviei e-mail para o Juliano a atribuí o processo SEI a ele', 'App\\User', 1),
(70, 166, 8, '2019-04-03 12:11:07', '2019-04-03 12:11:07', 'Despachar para setor técnico.', NULL, 'App\\User', 8),
(71, 95, 5, '2019-04-08 14:24:12', '2019-04-08 14:24:12', 'Verificar a interferência com bens da União.', 'Encaminhada à Ex DIINC por tratar-se de área da RFFSA', 'App\\User', 13),
(72, 167, 4, '2019-04-03 19:13:57', '2019-04-03 19:13:57', NULL, NULL, 'App\\User', 4),
(73, 168, 8, '2019-04-22 12:40:52', '2019-04-22 12:40:52', 'Análise de laudo.', NULL, 'App\\User', 5),
(74, 140, 8, '2019-04-08 17:06:26', '2019-04-08 17:06:26', NULL, NULL, 'App\\User', 5),
(75, 74, 5, '2019-04-03 20:51:52', '2019-04-03 20:51:52', NULL, NULL, 'App\\User', 13),
(76, 76, 8, '2019-04-03 18:42:11', NULL, 'informar se há interesse da União no feito', NULL, 'App\\User', 13),
(77, 141, 8, '2019-04-24 16:37:30', '2019-04-24 16:37:30', NULL, NULL, 'App\\User', 5),
(78, 169, 8, '2019-05-07 18:56:40', '2019-05-07 18:56:40', NULL, NULL, 'App\\User', 5),
(79, 75, 5, '2019-04-03 19:36:28', NULL, NULL, NULL, 'App\\User', 13),
(80, 170, 8, '2019-04-05 13:27:25', '2019-04-05 13:27:25', NULL, NULL, 'App\\User', 13),
(81, 171, 8, '2019-04-08 17:50:50', '2019-04-08 17:50:50', 'manifestação sobre proposta de acordo.', 'A AGU já peticionou nos autos e a proposta de acordo foi recusada pelo autor MPF. Dessa forma, resta apenas a conclusão do processo até nova manifestação da AGU.', 'App\\User', 5),
(82, 172, 1, '2019-04-26 13:15:15', '2019-04-26 13:15:15', 'Esta demanda estava no bloco interno que você criou com processos a serem cadastrados. Distribuí para você por estar o processo SEI na sua carga.', NULL, 'App\\User', 5),
(83, 173, 8, '2019-04-04 11:27:43', NULL, 'Subsídios em ação ambiental e informação de liminar.', NULL, 'App\\User', 5),
(84, 174, 8, '2019-04-04 11:35:29', NULL, 'acompanhamento em imissão na posse de imóvel em Laguna.', NULL, 'App\\User', 5),
(85, 175, 8, '2019-04-05 17:45:28', '2019-04-05 17:45:28', 'Análise de usucapião.', NULL, 'App\\User', 13),
(86, 176, 8, '2019-04-17 18:23:14', '2019-04-17 18:23:14', 'Laudo complementar', NULL, 'App\\User', 5),
(87, 163, 8, '2019-04-08 16:40:06', '2019-04-08 16:40:06', NULL, NULL, 'App\\User', 5),
(88, 177, 8, '2019-04-04 12:43:30', NULL, 'Indicação de servidor para acompanhar desocupação RFFSA', NULL, 'App\\User', 3),
(89, 151, 1, '2019-04-08 14:06:46', '2019-04-08 14:06:46', 'Aguardando confirmação de recebimento', NULL, 'App\\User', 1),
(90, 25, 4, '2019-04-05 18:07:55', '2019-04-05 18:07:55', 'minutar resposta', NULL, 'App\\User', 4),
(91, 67, 1, '2019-04-08 18:31:41', '2019-04-08 18:31:41', 'Aguardando confirmação de recebimento', '8313530', 'App\\User', 1),
(92, 178, 8, '2019-04-30 14:16:08', '2019-04-30 14:16:08', 'Laudo complementar', NULL, 'App\\User', 5),
(93, 32, 4, '2019-04-08 14:16:53', '2019-04-08 14:16:53', 'Minutar resposta', NULL, 'App\\User', 4),
(94, 74, 1, '2019-04-08 18:30:42', '2019-04-08 18:30:42', 'Minutar resposta', 'Ofício nº 27198/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(95, 179, 8, '2019-04-17 12:46:16', '2019-04-17 12:46:16', 'indicação de assistente técnico', NULL, 'App\\User', 5),
(96, 68, 1, '2019-04-08 18:32:08', '2019-04-08 18:32:08', 'Aguardando confirmação de recebimento', '8314745', 'App\\User', 1),
(97, 73, 1, '2019-04-11 13:10:54', '2019-04-11 13:10:54', 'Aguardando confirmação de recebimento', NULL, 'App\\User', 1),
(98, 167, 1, '2019-04-05 18:09:02', '2019-04-05 18:09:02', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 4),
(99, 86, 1, '2019-04-26 16:42:18', '2019-04-26 16:42:18', 'Designar servidor para audiência por videoconferência no dia 24/04/2019', NULL, 'App\\User', 5),
(100, 181, 8, '2019-04-05 20:10:50', '2019-04-05 20:10:50', 'Verificar a existência de cessão.', 'Atendido pelo Despacho DIGES-SPU-SC 8298154', 'App\\DivisaoOrganograma', 4),
(101, 182, 8, '2019-05-07 13:44:28', '2019-05-07 13:44:28', NULL, '8332764', 'App\\DivisaoOrganograma', 4),
(102, 135, 4, '2019-04-08 16:18:25', '2019-04-08 16:18:25', NULL, NULL, 'App\\User', 5),
(103, 164, 1, '2019-04-04 19:34:19', NULL, 'Favor olhar esse caso. Trata-se de um cancelamento que era pra ter sido feito e a SPU continua cobrando taxa de ocupação, inclusive foi para DAU por isso.', NULL, 'App\\User', 5),
(104, 184, 8, '2019-05-21 12:49:44', '2019-05-21 12:49:44', 'Laudo complementar.', NULL, 'App\\User', 5),
(105, 185, 8, '2019-04-05 13:06:35', '2019-04-05 13:06:35', NULL, NULL, 'App\\User', 8),
(106, 187, 8, '2019-04-17 13:02:04', '2019-04-17 13:02:04', 'assistente técnico e formulação de quesito', NULL, 'App\\User', 5),
(107, 188, 8, '2019-04-08 14:10:09', '2019-04-08 14:10:09', NULL, NULL, 'App\\User', 13),
(108, 189, 8, '2019-04-08 16:37:39', '2019-04-08 16:37:39', NULL, NULL, 'App\\User', 13),
(109, 190, 8, '2019-04-08 17:49:20', '2019-04-08 17:49:20', NULL, NULL, 'App\\User', 13),
(110, 191, 8, '2019-04-05 17:39:21', NULL, NULL, NULL, 'App\\User', 5),
(111, 192, 8, '2019-04-26 12:43:47', '2019-04-26 12:43:47', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(112, 193, 8, '2019-04-05 17:53:05', NULL, 'Sequência a NT 8217', NULL, 'App\\User', 5),
(113, 194, 8, '2019-04-30 16:42:46', '2019-04-30 16:42:46', 'informações complementares à NT 5876/2016.', NULL, 'App\\User', 5),
(114, 181, 1, '2019-04-08 18:32:30', '2019-04-08 18:32:30', 'Aguardando confirmação de recebimento', '8313372', 'App\\User', 1),
(115, 195, 8, '2019-04-22 18:03:28', '2019-04-22 18:03:28', NULL, NULL, 'App\\User', 8),
(116, 197, 8, '2019-04-08 12:22:39', NULL, NULL, NULL, 'App\\User', 5),
(117, 196, 8, '2019-05-06 13:40:40', '2019-05-06 13:40:40', 'Aguardando manifestação da CODES no processo 04972.008375/2017-38.', NULL, 'App\\User', 3),
(118, 198, 8, '2019-04-11 13:29:25', '2019-04-11 13:29:25', 'Fazer ofício indicando servidor e atribuir à CODES', NULL, 'App\\User', 8),
(119, 24, 4, '2019-04-12 16:53:51', '2019-04-12 16:53:51', NULL, NULL, 'App\\User', 8),
(120, 199, 8, '2019-05-08 17:41:16', '2019-05-08 17:41:16', NULL, NULL, 'App\\User', 5),
(121, 200, 8, '2019-04-08 14:05:28', '2019-04-08 14:05:28', NULL, NULL, 'App\\User', 8),
(122, 201, 8, '2019-04-08 14:09:58', '2019-04-08 14:09:58', NULL, NULL, 'App\\User', 8),
(123, 202, 8, '2019-04-08 14:12:34', '2019-04-08 14:12:34', NULL, NULL, 'App\\User', 8),
(124, 95, 5, '2019-04-08 14:24:50', '2019-04-08 14:24:50', NULL, NULL, 'App\\DivisaoOrganograma', 5),
(125, 203, 8, '2019-04-09 14:45:38', '2019-04-09 14:45:38', NULL, NULL, 'App\\User', 13),
(126, 205, 4, '2019-04-10 18:59:18', '2019-04-10 18:59:18', NULL, NULL, 'App\\User', 4),
(127, 170, 4, '2019-04-15 18:34:32', '2019-04-15 18:34:32', NULL, NULL, 'App\\User', 4),
(128, 74, 1, '2019-04-11 13:14:19', '2019-04-11 13:14:19', 'Aguardando confirmação do recebimento', NULL, 'App\\User', 1),
(129, 55, 1, '2019-04-10 14:33:49', '2019-04-10 14:33:49', 'Aguardando confirmação de recebimento', 'Ofício nº 28485/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(130, 188, 4, '2019-04-15 18:40:50', '2019-04-15 18:40:50', 'Minutar ofício de resposta', NULL, 'App\\User', 4),
(131, 189, 1, '2019-04-10 14:13:38', '2019-04-10 14:13:38', 'Aguardando confirmação do recebimento', 'Ofício nº 28513/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(132, 135, 4, '2019-04-17 13:30:26', '2019-04-17 13:30:26', 'Minutar resposta', NULL, 'App\\User', 4),
(133, 140, 1, '2019-04-10 14:22:06', '2019-04-10 14:22:06', 'Aguardando confirmação do recebimento', 'Ofício nº 28526/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(134, 163, 1, '2019-04-10 14:31:03', '2019-04-10 14:31:03', 'Aguardando confirmação de recebimento', 'Nota Técnica nº 8315/2019-MP', 'App\\User', 1),
(135, 95, 1, '2019-04-10 14:27:34', '2019-04-10 14:27:34', 'Aguardando confirmação de recebimento', 'Ofício nº 28547/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(136, 208, 8, '2019-05-14 14:21:49', '2019-05-14 14:21:49', 'TAUS.', '8552347', 'App\\DivisaoOrganograma', 4),
(137, 209, 8, '2019-04-09 18:56:33', '2019-04-09 18:56:33', NULL, NULL, 'App\\User', 13),
(138, 190, 1, '2019-04-10 14:44:18', '2019-04-10 14:44:18', 'Aguardando confirmação de recebimento', 'Oficio 28824/2019', 'App\\User', 1),
(139, 46, 1, '2019-04-16 17:45:04', '2019-04-16 17:45:04', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(140, 210, 8, '2019-04-25 19:07:48', '2019-04-25 19:07:48', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(141, 211, 3, '2019-04-17 12:09:55', '2019-04-17 12:09:55', 'Aguardand manifestação do setor de fiscalização da SPU - Verificar com a Camila', NULL, 'App\\User', 3),
(142, 212, 3, '2019-05-07 13:39:57', '2019-05-07 13:39:57', NULL, '8330633', 'App\\DivisaoOrganograma', 5),
(143, 213, 8, '2019-04-09 18:55:55', '2019-04-09 18:55:55', NULL, NULL, 'App\\User', 13),
(144, 214, 8, '2019-04-11 16:30:03', '2019-04-11 16:30:03', NULL, NULL, 'App\\User', 5),
(145, 215, 8, '2019-05-10 18:00:20', '2019-05-10 18:00:20', NULL, NULL, 'App\\User', 5),
(146, 216, 8, '2019-04-10 12:26:06', '2019-04-10 12:26:06', NULL, NULL, 'App\\User', 8),
(147, 217, 8, '2019-04-11 16:28:54', '2019-04-11 16:28:54', NULL, NULL, 'App\\User', 13),
(148, 218, 8, '2019-04-22 17:40:17', '2019-04-22 17:40:17', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(149, 219, 8, '2019-04-11 16:29:22', '2019-04-11 16:29:22', NULL, NULL, 'App\\User', 13),
(150, 220, 8, '2019-04-10 16:33:56', NULL, NULL, NULL, 'App\\User', 13),
(151, 221, 8, '2019-05-02 17:03:27', '2019-05-02 17:03:27', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(152, 72, 1, '2019-04-23 19:42:25', '2019-04-23 19:42:25', 'Niarcos, estou distribuindo para você acompanhar pois estou saindo de férias', 'Retornando acompanhamento para o Alysson', 'App\\User', 3),
(153, 222, 1, '2019-04-10 17:34:13', NULL, 'Monitorar o cumprimento da sentença, conforme orientações em:\r\nhttp://10.209.232.158/wordpress/gabinete/reuniao-sobre-demolicoes-acoes-judiciais/', NULL, 'App\\User', 3),
(154, 223, 8, '2019-04-10 18:14:27', '2019-04-10 18:14:27', NULL, NULL, 'App\\User', 8),
(155, 224, 8, '2019-04-11 13:41:41', NULL, NULL, NULL, 'App\\User', 13),
(156, 225, 8, '2019-04-11 16:55:07', NULL, NULL, NULL, 'App\\User', 3),
(157, 226, 8, '2019-04-29 12:27:59', '2019-04-29 12:27:59', NULL, NULL, 'App\\User', 8),
(158, 227, 8, '2019-05-14 18:37:05', '2019-05-14 18:37:05', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(159, 228, 8, '2019-05-14 13:38:26', '2019-05-14 13:38:26', NULL, 'Nota Técnica nº 11051/2019-MP', 'App\\DivisaoOrganograma', 4),
(160, 229, 8, '2019-05-09 18:47:32', '2019-05-09 18:47:32', NULL, 'Nota Técnica nº 11248/2019-MP', 'App\\DivisaoOrganograma', 4),
(161, 230, 8, '2019-05-15 18:14:12', '2019-05-15 18:14:12', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(162, 231, 8, '2019-04-11 17:47:58', NULL, 'Acesso externo', NULL, 'App\\User', 3),
(163, 232, 4, '2019-04-11 18:44:42', NULL, NULL, NULL, 'App\\User', 4),
(164, 233, 3, '2019-04-29 20:08:23', '2019-04-29 20:08:23', NULL, NULL, 'App\\User', 3),
(165, 195, 8, '2019-04-22 14:21:28', '2019-04-22 14:21:28', 'Até 16/04/2019\r\nLIMINAR - TERRAS INDÍGENAS CAMBIRELA - PALHOÇA/SC.\r\nVERIFICAR COMPETÊNCIA DA SPU', NULL, 'App\\User', 5),
(166, 235, 4, '2019-04-26 17:14:09', '2019-04-26 17:14:09', NULL, NULL, 'App\\User', 13),
(167, 236, 8, '2019-05-14 13:27:01', '2019-05-14 13:27:01', NULL, 'Ofício nº 37490/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(168, 237, 8, '2019-05-08 18:44:29', '2019-05-08 18:44:29', 'Ocupação Amarildo da Silva', NULL, 'App\\User', 5),
(169, 241, 4, '2019-04-15 13:18:29', NULL, NULL, NULL, 'App\\User', 4),
(170, 213, 3, '2019-04-15 16:51:38', '2019-04-15 16:51:38', NULL, NULL, 'App\\User', 3),
(171, 243, 4, '2019-04-15 16:56:08', NULL, NULL, NULL, 'App\\User', 4),
(172, 246, 4, '2019-05-14 14:12:35', '2019-05-14 14:12:35', NULL, 'Ofício nº 38129/2019/DIGES-SPU-SC/MP', 'App\\DivisaoOrganograma', 4),
(173, 250, 4, '2019-04-17 19:27:00', '2019-04-17 19:27:00', NULL, NULL, 'App\\User', 5),
(174, 252, 4, '2019-04-15 18:14:33', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(175, 254, 4, '2019-05-07 13:57:14', '2019-05-07 13:57:14', NULL, '8384310', 'App\\DivisaoOrganograma', 4),
(176, 255, 4, '2019-04-16 17:10:06', NULL, NULL, NULL, 'App\\User', 5),
(177, 256, 4, '2019-05-15 12:56:24', '2019-05-15 12:56:24', NULL, NULL, 'App\\User', 5),
(178, 263, 4, '2019-04-17 17:39:19', NULL, 'Aguarda envio de documentos que não acompanharam o Ofício 82/2019.', NULL, 'App\\User', 4),
(179, 265, 4, '2019-05-10 18:12:55', '2019-05-10 18:12:55', NULL, 'Atribuído ao Arq. Manglio', 'App\\User', 5),
(180, 168, 5, '2019-04-22 12:41:22', '2019-04-22 12:41:22', NULL, NULL, 'App\\User', 13),
(181, 168, 5, '2019-05-09 12:43:59', '2019-05-09 12:43:59', NULL, NULL, 'App\\User', 5),
(182, 170, 1, '2019-04-22 13:06:49', '2019-04-22 13:06:49', 'Minutar resposta', 'Resposta já havia sido dada, inclusive com AR', 'App\\User', 1),
(183, 1, 1, '2019-04-23 12:52:37', '2019-04-23 12:52:37', 'Aguardando confirmação de recebimento', 'Marcando como atendida para adequar a situação da demanda', 'App\\User', 1),
(184, 135, 1, '2019-04-22 13:10:01', '2019-04-22 13:10:01', 'Minutar resposta', 'Resposta já havia sido enviada, inclusive com AR registrado no SEI.', 'App\\User', 1),
(185, 266, 8, '2019-04-26 17:14:47', '2019-04-26 17:14:47', NULL, NULL, 'App\\User', 13),
(186, 176, 1, '2019-04-22 13:32:38', '2019-04-22 13:32:38', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(187, 179, 1, '2019-04-23 17:15:29', '2019-04-23 17:15:29', 'Aguardando confirmação do recebimento (email 8386714)', NULL, 'App\\User', 3),
(188, 187, 1, '2019-04-22 19:57:50', '2019-04-22 19:57:50', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(189, 214, 1, '2019-04-22 18:15:07', '2019-04-22 18:15:07', 'Aguardando AR', NULL, 'App\\User', 3),
(190, 267, 8, '2019-05-06 17:20:00', '2019-05-06 17:20:00', NULL, NULL, 'App\\User', 13),
(191, 268, 8, '2019-05-10 18:01:19', '2019-05-10 18:01:19', NULL, NULL, 'App\\User', 5),
(192, 176, 1, '2019-04-22 19:59:27', '2019-04-22 19:59:27', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(193, 211, 1, '2019-04-26 18:30:43', '2019-04-26 18:30:43', 'Atribuída para monitoramento da resposta do Órgão Central.\r\n\r\nEm vista disso, e considerando que esta SPU-SC depende da descentralização dos recursos por parte de sua Unidade Central para adoção das providências de contratação do serviço de demolição, informamos que, tão logo sejam liberados tais recursos, daremos continuidade as providências para o cumprimento da sentença.', NULL, 'App\\User', 1),
(194, 203, 1, '2019-04-22 18:19:12', '2019-04-22 18:19:12', 'Aguardando confirmação de recebimento', NULL, 'App\\User', 3),
(195, 219, 1, '2019-04-22 14:06:42', NULL, 'Aguardando confirmação de recebimento', NULL, 'App\\User', 3),
(196, 250, 1, '2019-04-22 19:56:35', '2019-04-22 19:56:35', 'Aguardando assinatura do SPU-SC', NULL, 'App\\User', 1),
(197, 253, 8, '2019-04-22 14:32:31', '2019-04-22 14:32:31', NULL, NULL, 'App\\User', 8),
(198, 270, 4, '2019-04-26 17:15:58', '2019-04-26 17:15:58', NULL, NULL, 'App\\User', 13),
(199, 272, 4, '2019-04-26 17:15:10', '2019-04-26 17:15:10', NULL, NULL, 'App\\User', 13),
(200, 273, 4, '2019-04-29 11:43:32', '2019-04-29 11:43:32', NULL, NULL, 'App\\User', 13),
(201, 274, 8, '2019-04-22 18:17:53', NULL, 'Fornecer acesso externo.', NULL, 'App\\User', 3),
(202, 218, 1, '2019-04-23 13:19:50', '2019-04-23 13:19:50', 'Minutar resposta', 'Ofício nº 32484/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(203, 157, 1, '2019-04-23 13:50:52', '2019-04-23 13:50:52', 'Minutar resposta', 'Demanda duplicada', 'App\\User', 1),
(204, 195, 1, '2019-04-23 13:50:22', '2019-04-23 13:50:22', 'Minutar resposta', 'Ofício nº 32523/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(205, 275, 8, '2019-04-23 13:36:05', '2019-04-23 13:36:05', 'Fazer ofício confirmando interesse em integrar o polo ativo.', NULL, 'App\\User', 8),
(206, 276, 8, '2019-04-23 14:16:53', '2019-04-23 14:16:53', 'Fazer despacho para a DIREP verificar a transferência do RIP 8105.0005756-59', NULL, 'App\\User', 8),
(207, 277, 4, '2019-04-25 18:24:16', '2019-04-25 18:24:16', NULL, NULL, 'App\\User', 5),
(208, 207, 8, '2019-05-14 18:20:39', '2019-05-14 18:20:39', 'Consultar a DIREP sobre pagamento a maior', 'Aguardando resposta da DIREP', 'App\\User', 8),
(209, 279, 8, '2019-04-29 14:12:04', '2019-04-29 14:12:04', 'Fazer despacho para DIIUP', NULL, 'App\\User', 8),
(210, 280, 4, '2019-04-23 19:13:22', '2019-04-23 19:13:22', NULL, NULL, 'App\\User', 8),
(211, 281, 4, '2019-05-08 17:41:44', '2019-05-08 17:41:44', NULL, NULL, 'App\\User', 5),
(212, 72, 1, '2019-04-23 19:42:36', NULL, 'Acompanhar ação de demolição', NULL, 'App\\User', 1),
(213, 98, 1, '2019-04-24 17:44:04', NULL, 'Combinado que o Antonio daria tratamento à demanda', NULL, 'App\\DivisaoOrganograma', 4),
(214, 212, 3, '2019-05-07 13:39:48', '2019-05-07 13:39:48', NULL, '8005406', 'App\\DivisaoOrganograma', 4),
(215, 212, 3, '2019-05-07 13:39:39', '2019-05-07 13:39:39', NULL, 'Despacho CODES-SPU-SC', 'App\\DivisaoOrganograma', 4),
(216, 282, 4, '2019-05-02 18:32:28', '2019-05-02 18:32:28', NULL, NULL, 'App\\User', 5),
(217, 282, 4, '2019-05-02 18:30:42', '2019-05-02 18:30:42', NULL, NULL, 'App\\User', 4),
(218, 283, 4, '2019-04-24 18:51:00', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(219, 284, 4, '2019-04-24 19:41:16', '2019-04-24 19:41:16', NULL, NULL, 'App\\User', 4),
(220, 285, 4, '2019-05-17 13:07:45', '2019-05-17 13:07:45', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(221, 286, 3, '2019-05-07 16:35:36', '2019-05-07 16:35:36', NULL, NULL, 'App\\User', 3),
(222, 278, 8, '2019-05-07 13:59:45', '2019-05-07 13:59:45', NULL, '8452629', 'App\\DivisaoOrganograma', 4),
(223, 287, 4, '2019-04-26 13:34:12', '2019-04-26 13:34:12', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(224, 288, 4, '2019-04-26 13:37:48', '2019-04-26 13:37:48', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(225, 289, 4, '2019-04-29 19:35:22', '2019-04-29 19:35:22', NULL, 'Despacho DIREP-SPU-SC 8452847', 'App\\DivisaoOrganograma', 6),
(226, 271, 8, '2019-05-02 12:24:32', '2019-05-02 12:24:32', 'PGV e Isenção', NULL, 'App\\User', 8),
(227, 290, 4, '2019-05-21 19:07:27', '2019-05-21 19:07:27', 'Aguarda envio de documentação', NULL, 'App\\User', 4),
(228, 263, 4, '2019-04-30 14:22:54', '2019-04-30 14:22:54', NULL, NULL, 'App\\User', 13),
(229, 86, 5, '2019-04-29 20:18:09', '2019-04-29 20:18:09', 'Trata de audiência de conciliação, creio que deve ser encaminhado ao ponto focal da Ex. CODES.\r\nFavor verificar a divergência entre o Anexo 1_INIC1(7)pdf (3671524) e Anexo 1_INIC (8219927). Creio que tratam de ações diferentes.', 'Demanda encaminhada à CODES através do Despacho DIGES-SPU-SC 8458228', 'App\\User', 1),
(230, 291, 4, '2019-04-26 16:54:14', '2019-04-26 16:54:14', NULL, NULL, 'App\\User', 4),
(231, 292, 4, '2019-04-26 16:55:51', NULL, NULL, NULL, 'App\\User', 4),
(232, 294, 4, '2019-04-26 17:00:14', '2019-04-26 17:00:14', NULL, NULL, 'App\\User', 4),
(233, 295, 4, '2019-04-29 16:38:08', '2019-04-29 16:38:08', NULL, NULL, 'App\\User', 13),
(234, 296, 4, '2019-04-26 17:37:05', NULL, NULL, NULL, 'App\\User', 4),
(235, 297, 4, '2019-04-29 18:49:15', '2019-04-29 18:49:15', NULL, NULL, 'App\\User', 13),
(236, 211, 1, '2019-04-26 18:31:19', NULL, 'Atribuída para monitoramento da resposta do Órgão Central.\r\n\r\nEm vista disso, e considerando que esta SPU-SC depende da descentralização dos recursos por parte de sua Unidade Central para adoção das providências de contratação do serviço de demolição, informamos que, tão logo sejam liberados tais recursos, daremos continuidade as providências para o cumprimento da sentença.', NULL, 'App\\User', 1),
(237, 298, 8, '2019-04-29 12:23:34', NULL, 'Assunto tratado parcialmente pela DIIUP NT 12559, falta a CODES verificar a correta concessão na utilização da ocupação.', NULL, 'App\\DivisaoOrganograma', 4),
(238, 299, 4, '2019-05-24 19:01:38', '2019-05-24 19:01:38', NULL, NULL, 'App\\DivisaoOrganograma', 5),
(239, 300, 4, '2019-04-29 16:42:53', '2019-04-29 16:42:53', NULL, NULL, 'App\\User', 4),
(240, 301, 4, '2019-05-02 18:51:03', '2019-05-02 18:51:03', NULL, NULL, 'App\\User', 13),
(241, 158, 1, '2019-04-29 19:25:43', '2019-04-29 19:25:43', 'Minutar resposta', 'Ofício nº 33063/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(242, 235, 1, '2019-04-30 13:45:13', '2019-04-30 13:45:13', 'Minutar resposta', 'Ofício nº 33546/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(243, 295, 1, '2019-04-29 19:50:58', '2019-04-29 19:50:58', 'Minutar resposta', 'Ofício nº 34242/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(244, 217, 1, '2019-04-29 20:23:51', '2019-04-29 20:23:51', 'Minutar resposta', 'Já havia sido minuta a resposta, assinada, enviada e registrado AR. Faltava só atualizar a situação da demanda', 'App\\User', 1),
(245, 266, 1, '2019-04-29 20:24:43', '2019-04-29 20:24:43', 'Minutar resposta', 'Ofício nº 33552/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(246, 302, 4, '2019-05-07 16:37:17', '2019-05-07 16:37:17', NULL, NULL, 'App\\User', 3),
(247, 289, 1, '2019-04-30 13:43:02', '2019-04-30 13:43:02', 'Minutar resposta', 'Ofício nº 34404/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(248, 303, 4, '2019-04-29 19:54:05', '2019-04-29 19:54:05', NULL, NULL, 'App\\User', 4),
(249, 304, 4, '2019-04-30 17:51:34', '2019-04-30 17:51:34', NULL, NULL, 'App\\User', 13),
(250, 305, 8, '2019-05-07 18:06:53', '2019-05-07 18:06:53', NULL, NULL, 'App\\User', 13),
(251, 233, 1, '2019-04-30 13:22:16', '2019-04-30 13:22:16', 'Minutar resposta', 'Ofício nº 34383/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(252, 306, 4, '2019-05-02 16:24:42', '2019-05-02 16:24:42', NULL, NULL, 'App\\User', 13),
(253, 307, 4, '2019-04-30 16:50:59', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 7),
(254, 308, 4, '2019-05-14 16:59:34', '2019-05-14 16:59:34', NULL, NULL, 'App\\User', 3),
(255, 309, 1, '2019-04-30 18:51:56', '2019-04-30 18:51:56', 'Manifestar sobre possível sobreposição de imóvel em terras da União', 'Nota Técnica nº 10489/2019-MP', 'App\\User', 13),
(256, 310, 4, '2019-04-30 18:12:38', '2019-04-30 18:12:38', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(257, 311, 4, '2019-04-30 18:19:11', '2019-04-30 18:19:11', NULL, NULL, 'App\\User', 4),
(258, 312, 4, '2019-04-30 18:23:26', '2019-04-30 18:23:26', NULL, NULL, 'App\\User', 10),
(259, 178, 1, '2019-04-30 18:50:22', '2019-04-30 18:50:22', 'Minutar resposta', 'Ofício nº 34606/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(260, 194, 1, '2019-04-30 19:10:01', '2019-04-30 19:10:01', 'Minutar resposta', 'Ofício nº 34640/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(261, 309, 1, '2019-04-30 18:55:41', '2019-04-30 18:55:41', 'Minutar resposta', 'E-mail (8466237) 04972.002600/2019-94 - Resposta ao e-mail PSU-BNU-SC (Processo 0312945-49.2018.8.24.0008)', 'App\\User', 1),
(262, 270, 1, '2019-04-30 19:22:17', '2019-04-30 19:22:17', 'Minutar resposta', 'Ofício nº 34654/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(263, 313, 8, '2019-05-02 13:37:39', '2019-05-02 13:37:39', 'Já respondido - Parecer 3877884\nFazer ofício', NULL, 'App\\User', 8),
(264, 314, 4, '2019-05-03 14:23:59', '2019-05-03 14:23:59', NULL, NULL, 'App\\User', 13),
(265, 290, 4, '2019-05-07 12:07:13', '2019-05-07 12:07:13', NULL, NULL, 'App\\User', 13),
(266, 282, 4, '2019-05-02 18:32:38', '2019-05-02 18:32:38', NULL, NULL, 'App\\User', 3),
(267, 315, 4, '2019-05-02 19:16:27', '2019-05-02 19:16:26', NULL, NULL, 'App\\User', 4),
(268, 316, 4, '2019-05-02 19:18:03', NULL, NULL, NULL, 'App\\User', 4),
(269, 317, 4, '2019-05-10 18:37:42', '2019-05-10 18:37:42', NULL, NULL, 'App\\User', 13),
(270, 318, 4, '2019-05-02 20:57:54', NULL, NULL, NULL, 'App\\User', 13),
(271, 319, 4, '2019-05-03 18:56:13', '2019-05-03 18:56:13', NULL, NULL, 'App\\User', 13),
(272, 320, 3, '2019-05-03 12:50:45', NULL, NULL, NULL, 'App\\User', 3),
(273, 321, 4, '2019-05-03 14:18:30', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(274, 322, 4, '2019-05-03 17:11:15', '2019-05-03 17:11:15', NULL, NULL, 'App\\User', 8),
(275, 323, 4, '2019-05-03 17:13:26', '2019-05-03 17:13:26', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(276, 324, 4, '2019-05-06 17:20:20', '2019-05-06 17:20:20', NULL, NULL, 'App\\User', 13),
(277, 325, 4, '2019-05-03 18:05:04', NULL, NULL, NULL, 'App\\User', 13),
(278, 326, 4, '2019-05-03 18:21:23', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(279, 327, 4, '2019-05-03 18:48:17', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 8),
(280, 328, 8, '2019-05-06 12:00:52', NULL, 'Verificar a resposta dada ao IBAMA, protocolo 04972.005401/2018-57, e responder ao MPF.', NULL, 'App\\DivisaoOrganograma', 4),
(281, 329, 4, '2019-05-06 14:05:19', '2019-05-06 14:05:19', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(282, 331, 4, '2019-05-06 17:37:48', NULL, NULL, NULL, 'App\\User', 5),
(283, 314, 3, '2019-05-06 17:43:00', '2019-05-06 17:43:00', NULL, NULL, 'App\\User', 3),
(284, 324, 3, '2019-05-06 17:44:34', '2019-05-06 17:44:34', NULL, NULL, 'App\\User', 3),
(285, 13, 1, '2019-05-07 18:21:04', '2019-05-07 18:21:04', 'Minutar ofício de resposta', 'Ofício nº 36268/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(286, 332, 8, '2019-05-07 12:38:20', '2019-05-07 12:38:20', NULL, NULL, 'App\\User', 8),
(287, 333, 4, '2019-05-07 13:09:33', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(288, 334, 1, '2019-05-07 18:45:57', '2019-05-07 18:45:57', 'Minutar resposta', 'Ofício nº 36316/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(289, 335, 4, '2019-05-07 13:33:03', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(290, 122, 1, '2019-05-09 18:31:28', '2019-05-09 18:31:28', 'Monitorar resposta da CODES-SPU-SC', NULL, 'App\\User', 1),
(291, 71, 1, '2019-05-09 13:11:04', '2019-05-09 13:11:04', 'Monitorar resposta da CODES-SPU-SC', 'Ofício nº 36448/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(292, 236, 1, '2019-05-14 13:26:54', '2019-05-14 13:26:54', 'Monitorar resposta da CODES-SPU-SC', 'Ofício nº 37490/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(293, 278, 1, '2019-05-09 17:30:10', '2019-05-09 17:30:10', 'Minutar Ofício de resposta', NULL, 'App\\User', 3),
(294, 229, 1, '2019-05-09 18:47:26', '2019-05-09 18:47:26', 'Minutar resposta da CODES-SPU-SC', 'Nota Técnica nº 11248/2019-MP', 'App\\User', 1),
(295, 336, 1, '2019-05-13 18:33:49', '2019-05-13 18:33:49', NULL, 'Despacho DIIUP-SPU-SC 8554631', 'App\\DivisaoOrganograma', 8),
(296, 336, 1, '2019-05-13 19:04:46', '2019-05-13 19:04:46', 'Minutar resposta', 'Ofício nº 37874/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(297, 13, 1, '2019-05-07 17:39:25', '2019-05-07 17:39:25', NULL, 'Despacho DIIUP-SPU-SC 8500338', 'App\\DivisaoOrganograma', 8),
(298, 334, 1, '2019-05-07 18:30:18', '2019-05-07 18:30:18', NULL, 'Despacho DIIUP-SPU_SC', 'App\\DivisaoOrganograma', 8),
(299, 337, 1, '2019-05-07 16:19:23', NULL, 'prestar as informações solicitadas (ver descrição da demanda)', NULL, 'App\\User', 5),
(300, 338, 1, '2019-05-07 16:28:03', NULL, 'informar sobre a data da ciência das ocupações e quais medidas, inclusive de fiscalização, foram tomadas até o momento', NULL, 'App\\User', 5),
(301, 302, 3, '2019-05-07 16:36:30', '2019-05-07 16:36:30', NULL, NULL, 'App\\User', 3),
(302, 339, 3, '2019-05-15 19:09:07', '2019-05-15 19:09:07', NULL, NULL, 'App\\User', 3),
(303, 340, 1, '2019-05-07 17:04:50', NULL, NULL, NULL, 'App\\User', 5),
(304, 339, 3, '2019-05-15 19:09:16', '2019-05-15 19:09:16', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(305, 341, 1, '2019-05-07 17:20:54', NULL, NULL, NULL, 'App\\User', 5),
(306, 342, 4, '2019-05-07 17:32:50', NULL, NULL, NULL, 'App\\User', 8),
(307, 343, 4, '2019-05-07 17:49:49', NULL, NULL, NULL, 'App\\User', 13),
(308, 344, 4, '2019-05-09 14:27:42', '2019-05-09 14:27:42', NULL, NULL, 'App\\User', 13),
(309, 345, 4, '2019-05-08 18:48:22', '2019-05-08 18:48:22', NULL, NULL, 'App\\User', 13),
(310, 347, 4, '2019-05-22 17:41:19', '2019-05-22 17:41:19', NULL, NULL, 'App\\User', 5),
(311, 348, 4, '2019-05-07 20:30:24', NULL, NULL, NULL, 'App\\User', 13),
(312, 349, 8, '2019-05-08 12:06:10', '2019-05-08 12:06:10', NULL, NULL, 'App\\User', 8),
(313, 350, 8, '2019-05-08 12:21:23', '2019-05-08 12:21:23', NULL, NULL, 'App\\User', 8),
(314, 351, 8, '2019-05-08 12:57:22', '2019-05-08 12:57:22', NULL, NULL, 'App\\User', 8),
(315, 352, 8, '2019-05-08 17:17:40', '2019-05-08 17:17:40', NULL, NULL, 'App\\User', 8),
(316, 353, 4, '2019-05-08 17:30:44', NULL, NULL, NULL, 'App\\User', 13),
(317, 354, 4, '2019-05-08 17:56:56', '2019-05-08 17:56:56', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(318, 354, 4, '2019-05-08 17:57:03', '2019-05-08 17:57:02', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(319, 355, 4, '2019-05-21 17:34:51', '2019-05-21 17:34:51', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(320, 356, 8, '2019-05-09 13:04:15', '2019-05-09 13:04:15', NULL, NULL, 'App\\User', 8),
(321, 357, 8, '2019-05-09 13:15:04', NULL, 'Projeto Orla em Florianópolis', NULL, 'App\\DivisaoOrganograma', 4),
(322, 360, 4, '2019-05-17 18:40:25', '2019-05-17 18:40:25', NULL, NULL, 'App\\User', 13),
(323, 244, 8, '2019-05-10 18:02:22', '2019-05-10 18:02:22', 'Imóvel localizado em Xanxerê -SC.\r\nVerificar a informação de imóvel situado em Zona de Segurança Nacional.', NULL, 'App\\User', 5),
(324, 245, 8, '2019-05-09 13:49:02', NULL, 'RIP 8161.0000103-00\nConversão em renda dos valores depositados em juízo', NULL, 'App\\DivisaoOrganograma', 6),
(325, 361, 4, '2019-05-10 18:06:29', '2019-05-10 18:06:29', NULL, 'Atribuída ao Arq. Manglio.', 'App\\User', 5),
(326, 330, 8, '2019-05-10 12:05:55', '2019-05-10 12:05:55', NULL, NULL, 'App\\User', 8),
(327, 306, 1, '2019-05-09 18:28:48', '2019-05-09 18:28:48', 'Minutar resposta', 'Ofício nº 37089/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(328, 169, 1, '2019-05-09 17:21:04', '2019-05-09 17:21:04', 'Minutar resposta', 'Ofício nº 36631/2019/DIGES-SPU-SC/MP', 'App\\User', 3),
(329, 267, 1, '2019-05-09 18:43:42', '2019-05-09 18:43:42', 'Minutar resposta', 'Ofício nº 37125/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(330, 344, 1, '2019-05-09 17:31:08', NULL, 'Minutar resposta', NULL, 'App\\User', 1),
(331, 44, 8, '2019-05-09 18:40:59', '2019-05-09 18:40:59', NULL, NULL, 'App\\User', 8),
(332, 28, 8, '2019-05-09 18:42:23', '2019-05-09 18:42:23', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(333, 229, 1, '2019-05-14 13:20:01', '2019-05-14 13:20:01', 'Minutar resposta', 'Nota Técnica nº 11317/2019-MP', 'App\\User', 1),
(334, 26, 8, '2019-05-09 18:53:19', '2019-05-09 18:53:19', NULL, NULL, 'App\\User', 8),
(335, 5, 8, '2019-05-09 18:57:11', '2019-05-09 18:57:11', NULL, NULL, 'App\\User', 8),
(336, 3, 8, '2019-05-09 18:59:36', '2019-05-09 18:59:36', NULL, NULL, 'App\\User', 4),
(337, 362, 4, '2019-05-09 20:03:19', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(338, 362, 4, '2019-05-09 20:03:24', NULL, NULL, NULL, 'App\\User', 4),
(339, 11, 8, '2019-05-10 12:17:58', '2019-05-10 12:17:58', NULL, NULL, 'App\\User', 5),
(340, 43, 8, '2019-05-10 12:19:22', '2019-05-10 12:19:22', NULL, NULL, 'App\\DivisaoOrganograma', 3),
(341, 6, 8, '2019-05-10 12:22:18', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 8),
(342, 7, 8, '2019-05-10 12:50:14', '2019-05-10 12:50:14', 'Recomendação de cancelamento do RIP 8105.0005837-59.\nRanchos de pesca em terreno de marinha às margens da Lagoa da Conceição.', NULL, 'App\\User', 5),
(343, 7, 8, '2019-05-10 12:50:45', '2019-05-10 12:50:45', 'Recomendação de cancelamento do RIP 8105.0005837-59.\nRanchos de pesca em terreno de marinha às margens da Lagoa da Conceição.', NULL, 'App\\DivisaoOrganograma', 4),
(344, 7, 8, '2019-05-10 12:50:55', NULL, 'Recomendação de cancelamento do RIP 8105.0005837-59.\nRanchos de pesca em terreno de marinha às margens da Lagoa da Conceição.', NULL, 'App\\DivisaoOrganograma', 4),
(345, 71, 3, '2019-05-10 17:08:48', '2019-05-10 17:08:48', NULL, NULL, 'App\\User', 3),
(346, 71, 3, '2019-05-10 17:08:24', '2019-05-10 17:08:24', NULL, NULL, 'App\\User', 3),
(347, 363, 1, '2019-05-10 18:20:26', '2019-05-10 18:20:26', 'Minutar resposta', 'Ofício nº 37475/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(348, 361, 5, '2019-05-14 14:10:59', '2019-05-14 14:10:59', NULL, NULL, 'App\\User', 13),
(349, 265, 5, '2019-05-14 14:03:53', '2019-05-14 14:03:53', NULL, NULL, 'App\\User', 13),
(350, 364, 1, '2019-05-10 19:15:57', NULL, 'Sentença determina a conclusão da análise dos   pedidos   de   outorga   gratuita   de   aforamentons.   04972.007791/2013-95   e   04972.207127/2015-14', NULL, 'App\\DivisaoOrganograma', 4),
(351, 364, 1, '2019-05-10 20:36:29', '2019-05-10 20:36:29', 'Sentença determina a conclusão da análise do pedido de averbação de transferência  n. 04972.004186/2009-86', 'Cancelando distribuição', 'App\\User', 5),
(352, 364, 1, '2019-05-10 20:54:11', NULL, 'Continuar Despacho 8546808', NULL, 'App\\User', 1),
(353, 364, 1, '2019-05-13 14:42:07', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(354, 215, 1, '2019-05-13 17:31:00', '2019-05-13 17:31:00', 'Minutar resposta', 'Ofício nº 37799/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(355, 365, 1, '2019-05-13 20:34:54', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(356, 365, 1, '2019-05-13 20:35:09', NULL, 'Monitorar resposta DIREP-SPU-SC', NULL, 'App\\User', 1),
(357, 366, 8, '2019-05-14 12:01:48', '2019-05-14 12:01:48', NULL, NULL, 'App\\User', 8),
(358, 367, 8, '2019-05-14 13:44:00', '2019-05-14 13:44:00', NULL, NULL, 'App\\User', 8),
(359, 208, 1, '2019-05-14 14:36:33', '2019-05-14 14:36:33', 'Minutar resposta', 'Ofício nº 38152/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(360, 368, 4, '2019-05-14 17:04:12', NULL, NULL, NULL, 'App\\User', 13),
(361, 369, 4, '2019-05-15 16:50:34', '2019-05-15 16:50:34', NULL, NULL, 'App\\User', 13),
(362, 370, 4, '2019-05-22 17:47:27', '2019-05-22 17:47:27', NULL, 'Atribuída ao Arq. Manglio', 'App\\User', 5),
(363, 371, 4, '2019-05-14 18:28:56', '2019-05-14 18:28:56', NULL, NULL, 'App\\User', 3),
(364, 372, 4, '2019-05-20 13:46:47', '2019-05-20 13:46:47', NULL, NULL, 'App\\User', 8),
(365, 373, 8, '2019-05-17 18:39:18', '2019-05-17 18:39:18', NULL, NULL, 'App\\User', 13),
(366, 374, 8, '2019-05-15 12:44:27', NULL, NULL, NULL, 'App\\User', 13),
(367, 375, 4, '2019-05-15 13:55:03', '2019-05-15 13:55:03', NULL, NULL, 'App\\User', 13),
(368, 230, 3, '2019-05-15 18:14:02', '2019-05-15 18:14:02', NULL, NULL, 'App\\User', 3),
(369, 230, 3, '2019-05-15 18:13:50', '2019-05-15 18:13:50', NULL, NULL, 'App\\User', 3),
(370, 376, 1, '2019-05-21 13:35:23', '2019-05-21 13:35:23', 'Minutar resposta ao MPF', 'Ofício nº 39868/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(371, 376, 1, '2019-05-20 13:47:22', '2019-05-20 13:47:22', 'Minutar despacho para SCGPU para reexame da decisão', NULL, 'App\\User', 1),
(372, 377, 4, '2019-05-15 19:31:00', NULL, NULL, NULL, 'App\\User', 8),
(373, 378, 3, '2019-05-16 12:53:35', NULL, NULL, NULL, 'App\\User', 5),
(374, 379, 8, '2019-05-16 13:03:33', '2019-05-16 13:03:33', NULL, NULL, 'App\\User', 8),
(375, 355, 3, '2019-05-21 17:33:55', '2019-05-21 17:33:55', NULL, NULL, 'App\\User', 3),
(376, 380, 8, '2019-05-17 17:33:35', '2019-05-17 17:33:35', NULL, NULL, 'App\\User', 8),
(377, 381, 8, '2019-05-17 17:19:40', '2019-05-17 17:19:40', NULL, NULL, 'App\\User', 8),
(378, 382, 8, '2019-05-17 17:20:07', '2019-05-17 17:20:07', NULL, NULL, 'App\\User', 8),
(379, 383, 8, '2019-05-17 17:20:32', '2019-05-17 17:20:32', NULL, NULL, 'App\\User', 8),
(380, 384, 8, '2019-05-17 12:20:49', '2019-05-17 12:20:49', NULL, NULL, 'App\\User', 8),
(381, 385, 8, '2019-05-16 19:27:55', '2019-05-16 19:27:55', NULL, NULL, 'App\\User', 8),
(382, 386, 8, '2019-05-17 18:02:56', '2019-05-17 18:02:56', NULL, NULL, 'App\\User', 8),
(383, 387, 1, '2019-05-16 20:32:29', NULL, NULL, NULL, 'App\\User', 5),
(384, 388, 4, '2019-05-17 13:39:13', NULL, NULL, NULL, 'App\\User', 13),
(385, 389, 4, '2019-05-22 13:12:58', '2019-05-22 13:12:58', NULL, NULL, 'App\\DivisaoOrganograma', 4),
(386, 390, 4, '2019-05-17 14:30:17', NULL, NULL, NULL, 'App\\User', 13),
(387, 391, 4, '2019-05-17 17:21:42', NULL, NULL, NULL, 'App\\User', 5),
(388, 392, 4, '2019-05-17 17:38:42', NULL, NULL, NULL, 'App\\User', 13),
(389, 393, 4, '2019-05-17 18:15:36', NULL, NULL, NULL, 'App\\User', 4),
(390, 394, 8, '2019-05-17 18:46:23', '2019-05-17 18:46:23', NULL, NULL, 'App\\User', 8),
(391, 395, 4, '2019-05-17 19:10:42', NULL, NULL, NULL, 'App\\User', 13),
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
(402, 406, 4, '2019-05-20 14:14:51', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 8),
(403, 407, 4, '2019-05-20 16:39:12', NULL, NULL, NULL, 'App\\User', 13),
(404, 408, 4, '2019-05-20 16:50:32', NULL, NULL, NULL, 'App\\User', 5),
(405, 409, 4, '2019-05-20 17:04:59', NULL, NULL, NULL, 'App\\User', 3),
(406, 410, 4, '2019-05-20 17:25:08', '2019-05-20 17:25:08', NULL, NULL, 'App\\DivisaoOrganograma', 7),
(407, 411, 4, '2019-05-20 18:19:34', NULL, NULL, NULL, 'App\\User', 13),
(408, 412, 4, '2019-05-20 19:26:58', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 5),
(409, 413, 4, '2019-05-21 14:31:18', '2019-05-21 14:31:18', NULL, NULL, 'App\\DivisaoOrganograma', 6),
(410, 414, 4, '2019-05-21 17:02:26', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(411, 227, 1, '2019-05-22 19:52:40', '2019-05-22 19:52:40', 'Minutar resposta', 'Ofício nº 40236/2019/DIRFH-SPU-SC/MP', 'App\\User', 1),
(412, 265, 1, '2019-05-21 18:29:16', '2019-05-21 18:29:16', 'Atribuir demanda', 'Ofício nº 40248/2019/DIGES-SPU-SC/MP e Despacho DIGES-SPU-SC 8604570', 'App\\User', 1),
(413, 184, 1, '2019-05-21 18:56:12', '2019-05-21 18:56:12', 'Minutar resposta', NULL, 'App\\User', 3),
(414, 415, 8, '2019-05-21 18:20:52', NULL, NULL, NULL, 'App\\User', 13),
(415, 416, 4, '2019-05-21 18:21:27', NULL, NULL, NULL, 'App\\User', 13),
(416, 268, 1, '2019-05-24 13:41:30', '2019-05-24 13:41:30', 'Minutar resposta', NULL, 'App\\User', 3),
(417, 345, 1, '2019-05-21 19:13:43', '2019-05-21 19:13:43', NULL, 'Ofício nº 40313/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(418, 417, 4, '2019-05-21 18:47:40', NULL, NULL, NULL, 'App\\User', 13),
(419, 290, 3, '2019-05-21 19:06:16', '2019-05-21 19:06:16', NULL, NULL, 'App\\User', 3),
(420, 290, 3, '2019-05-21 19:07:09', '2019-05-21 19:07:09', NULL, NULL, 'App\\User', 3),
(421, 418, 4, '2019-05-21 20:38:04', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(422, 419, 8, '2019-05-22 12:05:58', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(423, 389, 3, '2019-05-22 13:13:08', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 5),
(424, 317, 1, '2019-05-22 14:35:41', '2019-05-22 14:35:41', 'Minutar resposta', 'Ofício nº 40494/2019/DIGES-SPU-SC/MP', 'App\\User', 1),
(425, 420, 8, '2019-05-22 17:01:05', '2019-05-22 17:01:05', 'Indicado o servidor Humberto para participar da audiência em 27/06/2019', NULL, 'App\\DivisaoOrganograma', 4),
(426, 421, 8, '2019-05-22 17:41:19', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 4),
(427, 370, 5, '2019-05-24 19:20:02', '2019-05-24 19:20:02', 'Efetuar a locação do RIP cancelado', NULL, 'App\\User', 13),
(428, 422, 4, '2019-05-22 17:49:29', '2019-05-22 17:49:29', NULL, NULL, 'App\\DivisaoOrganograma', 6);
INSERT INTO `distribuicaodemanda` (`id`, `idDemanda`, `idUsuarioDe`, `dataDistribuicao`, `dataAtendimento`, `comentarioDistribuicao`, `comentarioAtendimento`, `assignable_type`, `assignable_id`) VALUES
(429, 423, 8, '2019-05-23 18:03:43', NULL, NULL, NULL, 'App\\User', 13),
(430, 424, 4, '2019-05-23 19:02:46', NULL, NULL, NULL, 'App\\DivisaoOrganograma', 6),
(431, 425, 8, '2019-05-24 12:31:06', NULL, NULL, NULL, 'App\\User', 13),
(432, 426, 4, '2019-05-24 17:58:53', NULL, NULL, NULL, 'App\\User', 5),
(433, 427, 1, '2019-05-24 18:06:49', '2019-05-24 18:06:49', NULL, NULL, 'App\\User', 1),
(434, 427, 1, '2019-05-24 18:06:41', NULL, 'Para conhecimento da cópia do IC 1.33.005.000308/2013-3 (Ilha do Corisco) enviada pelo MPF/Joinville (8620736)', NULL, 'App\\DivisaoOrganograma', 8),
(435, 428, 1, '2019-05-24 18:14:19', '2019-05-24 18:14:19', 'Ofício nº 20915/2019/DIGES-SPU-SC/MP', 'Ofício nº 20915/2019/DIGES-SPU-SC/MP', 'App\\User', 3),
(436, 429, 1, '2019-05-24 19:33:01', NULL, 'Elaborar processo de trabalho para cadastramento ex-ofício:\r\nMinutar Ofício Sec. Ambiente Joinville (parecer sobre a área, dano ambiental)\r\nMinutar Ofício Prefeitura Joinville (cadastro dos responsáveis pelos imóveis)', NULL, 'App\\User', 1),
(437, 429, 1, '2019-05-24 19:33:09', NULL, 'Elaborar processo de trabalho para cadastramento ex-ofício:\r\nMinutar Ofício Sec. Ambiente Joinville (parecer sobre a área, dano ambiental)\r\nMinutar Ofício Prefeitura Joinville (cadastro dos responsáveis pelos imóveis)', NULL, 'App\\User', 5),
(438, 430, 1, '2019-05-24 19:53:10', NULL, 'Verificar que no NUP 04972.006136/2016-62 já consta manifestação sobre a área (a investigação do MPE/SC deve ter migrado para o MPF/Joinville).\r\nNaquele NUP, o Oficio do MPE traz manifestacao da Secretaria do Meio Ambiente de Joinville sobre a realização de diversas vistorias, notificações, etc.\r\nElaborar procedimento padrão para esse tipo de caso (ocupação irregular, dano ambiental, linha homologada(?))', NULL, 'App\\User', 5),
(439, 430, 1, '2019-05-24 19:53:22', NULL, 'Verificar que no NUP 04972.006136/2016-62 já consta manifestação sobre a área (a investigação do MPE/SC deve ter migrado para o MPF/Joinville).\r\nNaquele NUP, o Oficio do MPE traz manifestacao da Secretaria do Meio Ambiente de Joinville sobre a realização de diversas vistorias, notificações, etc.\r\nElaborar procedimento padrão para esse tipo de caso (ocupação irregular, dano ambiental, linha homologada(?))', NULL, 'App\\User', 1);

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
(1, NULL, 'Superintendência do Patrimônio da União em Santa Catarina', 'SPU-SC', NULL, NULL),
(2, 1, 'Divisão de Gestão Estratégica e Recursos Internos', 'DIGES-SPU-SC', NULL, NULL),
(3, 1, 'Coordenação da Caracterização e Incorporação', 'COCAI-SPU-SC', NULL, NULL),
(4, 1, 'Coordenação de Destinação', 'CODES-SPU-SC', NULL, NULL),
(5, 3, 'Divisão de Incorporação', 'DIINC-SPU-SC', NULL, NULL),
(6, 1, 'Divisão de Receitas Patrimoniais', 'DIREP-SPU-SC', NULL, NULL),
(7, 4, 'Divisão de Regularização Fundiária e Habitação', 'DIRFH-SPU-SC', NULL, NULL),
(8, 3, 'Divisão de Identificação e Controle de Utilização do Patrimônia', 'DIIUP-SPU-SC', NULL, NULL);

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
(47, '2019_05_09_171950_orgao__cria_orgao_pai', 21);

-- --------------------------------------------------------

--
-- Estrutura da tabela `orgao`
--

CREATE TABLE `orgao` (
  `id` int(10) UNSIGNED NOT NULL,
  `idOrgaoPai` int(10) UNSIGNED DEFAULT NULL,
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

INSERT INTO `orgao` (`id`, `idOrgaoPai`, `orgao`, `sigla`, `email`, `telefone`, `created_at`, `updated_at`) VALUES
(1, NULL, 'JUSTIÇA FEDERAL - SEÇÃO JUDICIÁRIA DE SANTA CATARINA', 'TRF4/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(2, NULL, 'Advocacia-Geral da União - Procuradoria da União no Estado de Santa Catarina', 'AGU/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(3, NULL, 'Superintendência do Patrimônio da União em Santa Caratina', 'SPU/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(4, NULL, 'Secretaria do patrimônio da União - MPOG', 'SPU/MPOG', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(5, NULL, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DE SANTA CATARINA', 'PFN/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(6, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM BLUMENAU', 'PFN/PSFN/BLUME', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(7, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM CHAPECÓ', 'PFN/PSFN/CHAPC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(8, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM CRICIÚMA', 'PFN/PSFN/CRICI', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(9, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM ITAJAÍ', 'PFN/PSFN/ITAJA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(10, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM JOAÇABA', 'PFN/PSFN/JOAÇA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(11, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM JOINVILLE', 'PFN/PSFN/JOINV', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(12, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM LAGES', 'PFN/PSFN/LAGES', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(13, NULL, 'PREFEITURA MUNICIPAL DE ARAQUARI', 'PM/ARAQUARI', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(14, NULL, 'PREFEITURA MUNICIPAL DE ARARANGUÁ', 'PM/ARARANGUÁ', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(15, NULL, 'PREFEITURA MUNICIPAL DE BALNEÁRIO ARROIO DO SILVA', 'PM/BALN A. DO SILVA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(16, NULL, 'PREFEITURA MUNICIPAL DE BALNEÁRIO BARRA DO SUL', 'PM/BALN BARRA DO SUL', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(17, NULL, 'PREFEITURA MUNICIPAL DE BALNEÁRIO CAMBORIÚ', 'PM/BALN CAMBORIÚ', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(18, NULL, 'PREFEITURA MUNICIPAL DE BALNEÁRIO GAIVOTA', 'PM/BALN GAIVOTA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(19, NULL, 'PREFEITURA MUNICIPAL DE ITAPOÁ', 'PM/ITAPOÁ', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(20, NULL, 'PREFEITURA MUNICIPAL DE BALNEÁRIO PIÇARRAS', 'PM/BALN PIÇARRAS', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(21, NULL, 'PREFEITURA MUNICIPAL DE BARRA VELHA', 'PM/BARRA VELHA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(22, NULL, 'PREFEITURA MUNICIPAL DE BIGUAÇU', 'PM/BIGUAÇU', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(23, NULL, 'PREFEITURA MUNICIPAL DE BOMBINHAS', 'PM/BOMBINHAS', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(24, NULL, 'PREFEITURA MUNICIPAL DE FLORIANÓPOLIS', 'PM/FLORIANÓPOLIS', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(25, NULL, 'PREFEITURA MUNICIPAL DE GAROPABA', 'PM/GAROPABA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(26, NULL, 'PREFEITURA MUNICIPAL DE GARUVA', 'PM/GARUVA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(27, NULL, 'PREFEITURA MUNICIPAL DE GOVERNADOR CELSO RAMOS', 'PM/GOV CELSO RAMOS', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(28, NULL, 'PREFEITURA MUNICIPAL DE IMBITUBA', 'PM/IMBITUBA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(29, NULL, 'PREFEITURA MUNICIPAL DE ITAJAÍ', 'PM/ ITAJAÍ', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(30, NULL, 'PREFEITURA MUNICIPAL DE ITAPEMA', 'PM/ ITAPEMA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(31, NULL, 'PREFEITURA MUNICIPAL DE JAGUARUNA', 'PM/JAGUARUNA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(32, NULL, 'PREFEITURA MUNICIPAL DE JOINVILLE', 'PM/JOINVILLE', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(33, NULL, 'PREFEITURA MUNICIPAL DE LAGUNA', 'PM/LAGUNA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(34, NULL, 'PREFEITURA MUNICIPAL DE NAVEGANTES', 'PM/NAVEGANTES', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(35, NULL, 'PREFEITURA MUNICIPAL DE PALHOÇA', 'PM/PALHOÇA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(36, NULL, 'PREFEITURA MUNICIPAL DE PASSO DE TORRES', 'PM/PASSO DE TORRES', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(37, NULL, 'PREFEITURA MUNICIPAL DE PENHA', 'PM/PENHA', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(38, NULL, 'PREFEITURA MUNICIPAL DE PORTO BELO', 'PM/PORTO BELO', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(39, NULL, 'PREFEITURA MUNICIPAL DE SÃO FRANCISCO DO SUL', 'PM/S F DO SUL', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(40, NULL, 'PREFEITURA MUNICIPAL DE SÃO JOSÉ', 'PM/SAO JOSE', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(41, NULL, 'PREFEITURA MUNICIPAL DE TIJUCAS', 'PM/TIJUCAS', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(42, NULL, 'PREFEITURA MUNICIPAL DE BALNEÁRIO RINCÃO', 'PM/BALN RINCÃO', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(43, NULL, 'PREFEITURA MUNICIPAL DE PAULO LOPES', 'PM/PAULO LOPES', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(44, NULL, 'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE BLUMENAU', 'AGU/PSU/BNU/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(45, NULL, 'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE CHAPECÓ', 'AGU/PSU/CCO/SC', NULL, NULL, '2019-01-22 21:55:26', '2019-01-22 21:55:26'),
(46, NULL, 'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE CRICIÚMA', 'AGU/PSU/CCM/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(47, NULL, 'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE JOINVILLE', 'AGU/PSU/JVE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(48, NULL, 'PROCURADORIA DA REPÚBLICA EM SANTA CATARINA', 'MPF/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(49, NULL, 'PROCURADORIA DA REPÚBLICA - BLUMENAU - SC', 'MPF/PRM/BNU/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(50, NULL, 'PROCURADORIA DA REPÚBLICA - CAÇADOR - SC', 'MPF/PRM/CCD/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(51, NULL, 'PROCURADORIA DA REPÚBLICA - CHAPECÓ - SC', 'MPF/PRM/CCO/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(52, NULL, 'PROCURADORIA DA REPÚBLICA - CONCÓRDIA - SC', 'MPF/PRM/CDA/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(53, NULL, 'PROCURADORIA DA REPÚBLICA - CRICIÚMA - SC', 'MPF/PRM/CCM/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(54, NULL, 'PROCURADORIA DA REPÚBLICA - ITAJAÍ - SC', 'MPF/PRM/ITA/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(55, NULL, 'PROCURADORIA DA REPÚBLICA - JARAGUÁ DO SUL - SC', 'MPF/PRM/JRG/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(56, NULL, 'PROCURADORIA DA REPÚBLICA - JOAÇABA - SC', 'MPF/PRM/JBA/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(57, NULL, 'PROCURADORIA DA REPÚBLICA - JOINVILLE - SC', 'MPF/PRM/JVE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(58, NULL, 'PROCURADORIA DA REPÚBLICA - LAGES - SC', 'MPF/PRM/LGS/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(59, NULL, 'PROCURADORIA DA REPÚBLICA - MAFRA - SC', 'MPF/PRM/MFA/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(60, NULL, 'PROCURADORIA DA REPÚBLICA - RIO DO SUL - SC', 'MPF/PRM/RSL/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(61, NULL, 'PROCURADORIA DA REPÚBLICA - SÃO MIGUEL DO OESTE - SC', 'MPF/PRM/SMO/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(62, NULL, 'PROCURADORIA DA REPÚBLICA - TUBARÃO- SC', 'MPF/PRM/TBO/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(63, NULL, 'Advocacia-Geral da União - Procuradoria da União no Estado do Paraná', 'AGU/PR', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(64, NULL, 'Advocacia-Geral da União', 'AGU/DF', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(65, NULL, 'Advocacia-Geral da União - Procuradoria-Geral da União', 'AGU/PGU/DF', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(66, NULL, 'Advocacia-Geral da União - Procuradoria-Geral Federal', 'AGU/PGF/DF', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(67, NULL, 'Min.Público do Estado de Santa Catarina', 'MPE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(68, NULL, 'Vara do Trabalho de Imbituba', 'TRT/ Imbituba', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(69, NULL, 'Delegacia de Polícia Federal em Joinville', 'DPF/JVE', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(70, NULL, 'Sindicato dos Trabalhadores no Serviço Público Federal em SC', 'Sintrafesc', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(71, NULL, 'Câmara Municipal de Florianópolis', 'CM/FLORIANÓPOLIS/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(72, NULL, 'Supetintendência Polícia Federal SC', 'MJ-PF', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(73, NULL, 'Instituto Brasileiro de Meio Ambiente e dos Recursos Renováveis', 'IBAMA', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(74, NULL, 'Tribunal Regional Eleitoral SC', 'TRE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(75, NULL, 'Delegacia de Polícia Federal em Itajaí', 'DPF/IJI/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(76, NULL, 'INSTITUTO CHICO MENDES DE CONSERVAÇÃO DA BIODIVERSIDADE', 'ICMBIO', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(77, NULL, 'COMARCA DE TIJUCAS - 2ª VARA CÍVEL', 'TJ/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(78, NULL, 'PROCURADORIA DA REPÚBLICA EM CONCÓRDIA', 'MPF/SC CONCÓRDIA', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(79, NULL, 'DEPARTAMENTO DE POLÍCIA FEDERAL - SUPERINTENDÊNCIA REGIONAL EM SANTA CATARINA', 'SR/DPF/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(80, NULL, 'DEFENSORIA PÚBLICA DA UNIÃO EM JOINVILLE', 'DPU/JOINVILLE', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(81, NULL, 'Avalienge Engenharia Ambiental', 'Avalienge', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(82, NULL, 'Advocacia-Geral da União - Procuradoria da União no Estado do Rio Grande do Sul', 'AGU/RS', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(83, NULL, 'Procuradoria da União no Estado de Santa Catarina', 'PU/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(84, NULL, 'PROCURADORIA REGIONAL DA UNIAO 4 REGIÃO', 'PRU4', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(85, NULL, 'MINISTÉRIO PÚBLICO DE SC - PROMOTORIA DE JUSTIÇA DE LAGUNA', 'MPE/PJ/LAGUNA/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(86, NULL, 'Procuradoria Seccional da União em Santa Maria/RS', 'PSU/SMA', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(87, NULL, '1ª Vara Comarca de Porto Belo', 'JE-PJ/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(88, NULL, 'Procuradoria Seccional da União em Santa Maria-RS', 'AGU SMA', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(89, NULL, 'OFÍCIO DE REGISTRO DE IMÓVEIS BALNEÁRIO PIÇARRAS', 'RI BAL PIÇARRAS', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(90, NULL, 'PODER JUDICIARIO DE SANTA CATARINA 2ª VARA DA FAMÍLIA', 'POD. JUD. 2 V.F.', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(91, NULL, 'Justiça Federal - 1ª Vara de Caçador', 'VF-Caçador', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(92, NULL, 'Campeche Camping e Promoções LTDA', 'Campache Camping', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(93, NULL, 'Ministério Público Federal de Criciúma/SC', 'MPF-Criciúma', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(94, NULL, 'COMARCA DE IMBITUBA - 1ª VARA', '1ª VARA DE IMBITUBA', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(95, NULL, 'COMARCA GAROPABA VARA ÚNICA', 'VARA ÚNICA GAROPABA', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(96, NULL, 'Tribunal de contas da União', 'TCU', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(97, NULL, 'SUPERINTENDÊNCIA DO PATRIMÔNIO DA UNIÃO NO PARANÁ', 'SPU/PR', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(98, NULL, 'Consultoria Jurídica da União em Santa Catarina', 'CJU/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(99, NULL, 'Ministério Público do Trabalho  - Procuradoria do Trabalho em Criciúma', 'MPT-CCM', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(100, NULL, 'TJSC/Itapema - 2ª VARA CÍVEL', 'TJSC/Itapema - 2ª VARA CÍVEL', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(101, NULL, 'MINISTÉRIO PÚBLICO DE SC - PROMOTORIA DE JUSTIÇA DE JOINVILLE', 'MPE/PJ/JOINVILLE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(102, NULL, 'JUSTIÇA FEDERAL - SEÇÃO JUDICIÁRIA DE SANTA CATARINA', 'JF/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(103, NULL, 'NÃO DEFINIDO', 'NÃO DEFINIDO', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(104, NULL, 'JUSTIÇA DO ESTADO DE SANTA CATARINA', 'JE/SC', NULL, NULL, '2019-01-22 21:55:27', '2019-01-22 21:55:27'),
(105, NULL, 'testeteste2', 'teste', 'teste@teste.com', 'undefined', '2019-02-22 17:14:45', '2019-02-22 17:15:37'),
(106, NULL, 'testetesteteste', 'teste', 'teste@teste.com', 'undefined', '2019-02-22 17:23:36', '2019-02-22 17:23:36'),
(107, NULL, 'Justiça Federal- Seção Judiciária do Rio Grande do Sul', 'TRF4', 'rscar01sec@jfrs.jud.br', 'undefined', '2019-03-18 19:28:44', '2019-03-18 19:28:44'),
(108, NULL, 'Poder Judiciário de Santa Catarina- Comarca de Tubarão- 1ª Vara Criminal', 'TJ/SC', 'tubarao.criminal1@tjsc.jus.br', '(48) 3621-1535', '2019-04-03 18:14:10', '2019-04-03 18:14:10'),
(109, NULL, 'Poder Judiciário de Santa Catarina- Comarca de Tubarão- 1ª Vara Criminal', 'TJ/SC', 'tubarao.criminal1@tjsc.jus.br', '(48) 3621-1535', '2019-04-03 18:16:21', '2019-04-03 18:16:21'),
(110, NULL, '3ª Vara Federal de Itajaí', '3ª Vara Federal de Itajaí', 'scitaOS@jfsc.jus.br', '(47) 3341-5800', '2019-04-05 18:24:29', '2019-04-05 18:24:29'),
(111, NULL, 'Polícia Federal', 'PF', 'delemaph.srsc@pf.gov.br', '(48)32816500', '2019-04-10 13:54:54', '2019-04-10 13:54:54'),
(112, NULL, '7ª Defensoria Pública de Chapecó', 'DPE/SC', 'renandesouza@defensoria.sc.gov.br', '(49) 2049-7621', '2019-04-10 18:10:42', '2019-04-10 18:10:42'),
(113, NULL, 'VARA CÍVEL E DA FAZENDA PÚBLICA DE PINHAIS - PARANÁ', 'TJ/PR', 'fksc@tjpr.jus.br', '41 3033-4606', '2019-04-23 13:46:35', '2019-04-23 13:46:35'),
(114, NULL, 'Procuradoria da Fazenda Nacional em Curitiba', 'PFN/PR', 'luciano.bogo@pgfn.gov.br', '(41) 3310-3010', '2019-05-03 12:39:42', '2019-05-03 12:39:42'),
(115, NULL, 'DELEGACIA DE POLÍCIA FEDERAL EM CRICIÚMA', 'DPF', 'dpf.cm.ccm.srsc@dpf.gov.br', '48 3461-8600', '2019-05-03 18:44:32', '2019-05-03 18:44:32'),
(116, NULL, 'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM CAXIAS/RS', 'PSFN-CXI-RS', 'thiago.costa@pgfn.gov.br', 'undefined', '2019-05-07 16:54:02', '2019-05-07 16:54:02'),
(117, NULL, 'VARA DO TRABALHO DE IMBITUBA', 'Vara de Imbituba', 'vara_ima@trtl2.jus.br', '(48) 3255-0520', '2019-05-14 12:53:32', '2019-05-14 12:53:32');

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
(2, 'DEMANDA_ORGAO_CADASTRAR', 'Permite cadastrar/editar órgãos', NULL, NULL),
(3, 'DEMANDA_PROCEDIMENTO_CADASTRAR', 'Permite cadastrar/editar procedimentos', NULL, NULL),
(4, 'DEMANDA_AUTOR_CADASTRAR', 'Permite gerenciar o cadastro de demandantes', NULL, NULL);

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
(5, 1, 1, '00000000', 'Procedimento Fictício', 'Procedimento Fictício', NULL, '2019-02-22 23:55:01', '2019-03-06 18:42:51'),
(7, 3, 3, '5001006-63.2015.4.04.7216', 'Demolição de Quiosque em Garopaba', 'Demolição de Quiosque em Garopaba', '218229081115', '2019-03-06 18:01:56', '2019-03-07 14:20:08'),
(8, 1, 1, '1.33.005.000535/2017-31', 'Ranchos no Condomínio Village III - Lagoa da Conceição', 'Encaminha recomendação pelo cancelamento do RIP nº 8105.0005837-59', 'undefined', '2019-03-06 18:10:28', '2019-03-06 18:10:28'),
(9, 3, 1, '0300584-69.2016.8.24.0040', 'Usucapião - Angela Cristina de Oliveira', 'undefined', 'UZFOQK', '2019-03-06 18:25:31', '2019-03-06 18:25:31'),
(10, 1, 1, '1.33.008.000491/2016-98', 'Irregularidades na Praia Central de Balneário Camboriú - Quiosques na Orla', 'undefined', 'undefined', '2019-03-06 18:30:26', '2019-03-06 18:30:26'),
(11, 3, 1, '50000776920114047216', 'Loteamento Praia da Galheta', 'undefined', '723199534411', '2019-03-06 18:36:56', '2019-03-06 18:36:56'),
(12, 1, 1, '5018749-51.2017.4.04.7205', 'Gaspar/SC x Osmar Goedert e Outros', 'Gaspar/SC x Osmar Goedert e Outros', 'undefined', '2019-03-06 18:47:38', '2019-03-06 18:47:38'),
(13, 2, 3, '5000504-22.2018.4.04.7216', 'MPF e União x Município de Laguna/SC e Ravena Cassino Hotel', 'undefined', '447906024518', '2019-03-06 19:03:24', '2019-03-06 19:03:24'),
(14, 3, 1, '5000380-18.2017.4.04.7202', 'Usucapião - LAIR BIESEK E OUTROS', 'Usucapião - LAIR BIESEK E OUTROS', '932128540917', '2019-03-06 19:09:29', '2019-03-06 19:09:29'),
(15, 1, 1, '1.33.005.000088/2016-99', 'Carcinicultura - José Eugênio Thuon', 'undefined', NULL, '2019-03-06 19:15:00', '2019-03-14 12:58:04'),
(16, 3, 1, '5024540-79.2018.4.04.7200', 'Usucapião - FLORISBELA BECKER', 'undefined', '297938811118', '2019-03-07 13:47:17', '2019-03-07 13:47:17'),
(17, 2, 4, '50048399820194047200', NULL, 'Requer em pedido liminar o embargo das obras na região do Monumento Natural Municipal da Galheta, bem como para que a empresa ré se abstenha de realizar qualquer ato que\ndescaracterize o entorno do parque municipal da Galheta,', 'undefined', '2019-03-07 17:56:52', '2019-03-07 17:56:52'),
(18, 2, 3, '5006478-25.2017.4.04.7200', NULL, 'Objetiva determinar que a ré ocupante de edificação às margens da Lagoa da Conceição, seja impedida de promover novas construções ou reformas que impliquem\r\nacréscimo da área edificada já existente.', '172433201217', '2019-03-07 18:10:49', '2019-03-21 13:19:59'),
(19, 3, 4, '5000076-06.2019.4.04.7216', 'Usucapião- Mirta Raquel Melo de Souza', 'Usucapião Federal', '272149259319', '2019-03-08 12:57:50', '2019-03-08 13:00:07'),
(20, 3, 4, '5000479-03.2018.4.04.7218', 'Autor- Cecilia Terezinha Medeiros Hinsching', 'Ação de Demarcação/Divisão', 'undefined', '2019-03-08 16:53:02', '2019-03-08 16:57:37'),
(21, 1, 4, '1.33.005.000365/2016-63', 'Ilha dos Barcos, Ilha da Queimada, na Baia da Babitonga', 'Inquérito para apurar falta de resposta a demanda do MPF (04972.004280/2016-64)', 'undefined', '2019-03-11 12:56:46', '2019-05-24 14:34:15'),
(22, 2, 4, '2007.72.01.000525-1/SC', 'Casa de Oração ao Deus Vivo do Céu - São Francisco do Sul', 'demolição de estrutura metálica echalés em área de preservação permanente localizada na Rodovia Duque de Caxias, 344, em Ubatuba, SãoFrancisco   do   Sul,   às   margens   do   Rio   Acaraí,   bem   como   a   recuperação   ambiental   da   referida   área   e   acondenação dos réus no pagamento de indenização pelos danos causados ao meio ambiente.', 'undefined', '2019-03-11 13:40:59', '2019-03-11 13:40:59'),
(23, 3, 4, '5009506-58.2018.4.04.7202', 'Autor: Heitor Pasqualotto', 'Requer a exclusão da condição de ocupante do terreno de marinha- RIP 8111.0000472-15.', 'undefined', '2019-03-11 13:52:09', '2019-03-11 13:52:09'),
(24, 1, 1, '1.33.000.002302/2017-72', 'Quilombola Vidal Martins', 'Versa sobre as dificuldades enfrentadas por membros da Comunidade Tradicional Quilombola Vidal Martins, localizada no Rio Vermelho, para trabalhar com artesanato cultural, nas\npraias dessa capitai durante a temporada de verão.', 'undefined', '2019-03-11 17:18:42', '2019-03-11 17:18:42'),
(25, 3, 4, '5024429-95.2018.4.04.7200', 'Autor : Florisbela Becker', 'Usucapião Federal.', '246318530218', '2019-03-11 17:28:10', '2019-03-11 17:29:11'),
(26, 3, 4, '5001852-75.2018.4.04.7216', 'Autor: Daniel Pedro Cardoso', 'Usucapião Federal', '826249574818', '2019-03-11 17:38:32', '2019-03-11 17:38:32'),
(27, 3, 4, '5000938-19.2019.4.04.7202', 'Autor : Reinaldo Benedetti', 'Usucapião Federal', 'undefined', '2019-03-11 17:56:49', '2019-03-11 17:56:49'),
(28, 3, 1, '5017217-23.2018.4.04.7200', 'Biguaçu x André Teixeira', 'Manifestação sobre interesse da União', '441871867018', '2019-03-11 18:02:38', '2019-03-11 18:02:38'),
(29, 2, 4, '5020980-03.2016.4.04.7200', 'Autor : MPF', 'Construção irregular em terreno de marinha na Rod. Baldicero Filomeno, em Florianópolis', '451015618316', '2019-03-11 18:29:27', '2019-05-17 19:03:08'),
(30, 3, 2, '5026977-93.2018.4.04.7200', 'Usucapião - Orides Nervis', 'Ação de usucapiaão COM interesse de União.', '851786178118', '2019-03-11 18:30:18', '2019-03-11 18:30:18'),
(31, 3, 2, '5021829-04.2018.4.04.7200', 'Usucapião - Saturnino Pedro da Silva.Palhoça', 'Usucapião Federal', '247129634118', '2019-03-11 18:36:31', '2019-05-17 17:36:29'),
(32, 3, 1, '5000236-58.2019.4.04.7207', 'Registro de Imóvel da ex-RFFSA - Cartório de Tubarão 2º Ofício', 'Em que pese a SPU aparentemente já tenha se negado administrativamente a requerer aabertura da matrícula, requer-se informar, no prazo de 20 dias, se reconsidera ou se mantém a mesma posição', '932893631619', '2019-03-11 19:25:17', '2019-03-11 19:25:17'),
(33, 3, 2, '5017252-80.2018.4.04.7200', 'Município de Biguaçu x José Pedro Fabrício', 'Município de Biguaçu x José Pedro Fabrício', '283774910718', '2019-03-12 12:43:56', '2019-03-12 12:43:56'),
(34, 3, 1, '5006002-94.2011.4.04.7200', 'Cálculo de Indenização - Prédio ao lado da sede da PUSC - Imobiliária Acrópole', 'undefined', '260303422411', '2019-03-12 14:00:55', '2019-03-12 14:00:55'),
(35, 2, 2, '5012709-68.2017.4.04.7200', 'Construções em APP no Pântano do Sul - MPF x Messias Seroa Mota e Outros', 'undefined', '722644037817', '2019-03-12 14:56:51', '2019-03-12 14:56:51'),
(36, 3, 4, '5020687-67.2015.4.04.7200', 'NEZITA APARECIDA DE ANDRADE x ANTONIO CURCIO, UNIÃO E OUTROS', 'NEZITA APARECIDA DE ANDRADE x ANTONIO CURCIO, UNIÃO E OUTROS', '143728697215', '2019-03-12 18:16:25', '2019-03-12 18:16:25'),
(37, 3, 4, '5011516-18.2017.4.04.7200', 'Autor : Florianópolis Veículos S.A', 'Retificação do valor cobrado a título de taxa de ocupação.', 'undefined', '2019-03-13 17:18:00', '2019-03-13 17:18:00'),
(38, 3, 3, '5013253-46.2014.4.04.7205', 'RFFSA', 'Decretar a nulidade de todos os atos processuais posteriores à citação e da sentença prolatada no\nprocesso de Retificação de Registro Imobiliário n° 1.899/1992 (031.92.000091-7)', '535017622314', '2019-03-13 18:16:03', '2019-03-13 18:16:03'),
(39, 3, 4, '5001356-36.2019.4.04.7208', 'Solicitação de subsídios para defesa da União em processo de revisão cadastral.', 'O ocupante questiona a data adotada para a revisão do cadastro.\nProjeto Orla de Bombinhas/SC', 'undefined', '2019-03-13 18:22:26', '2019-03-13 18:22:26'),
(40, 3, 4, '5001817-63.2018.4.04.7201', 'Autor : Anete Ivanete Do Rosario', 'Usucapião Federal', '197738078318', '2019-03-13 18:53:25', '2019-03-13 18:53:25'),
(41, 2, 1, '5010704-49.2017.4.04.7208', 'Dano Ambiental. Porto Belo', 'Demolição de edificação que ocupa ilegalmente  área de preservação permanente (APP) e terreno de marinha, a recuperação da área degradada e a regularização da ocupação perante a Secretaria do Patrimônio da União (SPU) ou, subsidiariamente, o pagamento de indenização compensatória', '518991930417', '2019-03-13 19:51:19', '2019-03-13 19:51:19'),
(42, 2, 4, '5002003-33.2011.4.04.7201', 'Dano ambiental, Responsabilidade civil', 'Solicita indicação de assistente técnico e apresentação de quesitos no que toca a perícia de engenharia.\nO feito tem conexão com os autos da ação civil pública n. 5001840-53.2011.404.7201.', '642517598711', '2019-03-14 11:39:31', '2019-03-14 11:39:31'),
(43, 3, 4, '5022976-65.2018.4.04.7200', 'USUCAPIÃO - IMÓVEL EM TERRENOS DE MARINHA E SEUS ACRESCIDOS', 'Manifestação de interesse da União.', '398453667818', '2019-03-14 11:56:18', '2019-03-14 11:56:18'),
(44, 3, 2, '5000569-95.2019.4.04.7211', 'Usucapião em imóvel que possui o INCRA como um dos confinantes.', 'Solicitação de manifestação de eventual interesse na lide.', '736916805919', '2019-03-14 12:05:56', '2019-03-14 12:05:56'),
(45, 3, 4, '5003695-12.2012.4.04.7208', 'Autor : Condomínio Edifício Residencial Itambeí', 'Decretada a nulidade do procedimento demarcatório por ausência de intimação pessoal dos interessados.', 'undefined', '2019-03-14 13:25:46', '2019-03-14 13:25:46'),
(46, 3, 4, '5011921-51.2017.4.04.7201', 'Autor : Lourival Bertotti e Maria Delourdes Soethe Bertotti', 'Usucapião Federal', '598191586217)', '2019-03-14 13:48:13', '2019-03-14 13:48:13'),
(47, 3, 4, '5003134-02.2018.4.04.7200', 'Autor : Germano Alves Filho', 'Usucapião Federal', '590623337518', '2019-03-14 14:20:42', '2019-03-14 14:20:42'),
(48, 2, 3, '5011583-90.2016.4.04.7208', 'Cumprimento de sentença-Demolição Balneário Camboriú', 'Cumprimento de sentença que determinou a Demolição de imóvel localizado às margens do rio Camboriú, Rua Dom Afonso, 750,  Balneário Camboriú.', '123666724816', '2019-03-14 17:27:24', '2019-03-14 17:27:24'),
(50, 2, 1, '5024723-84.2017.4.04.7200', 'Desfazimento de construções- Lagoa da Conceição', 'ACP promovida pelo MUNICÍPIO DE FLORIANÓPOLIS em face de CRISTINA CORSETTI e outro, que objetiva o desfazimento de construções na Lagoa da Conceição.', '737986474117', '2019-03-14 18:15:38', '2019-03-14 18:15:38'),
(51, 2, 4, '5017111-66.2015.4.04.7200', 'Dano Ambiental- Lagoa da Conceição', 'Esta demanda, além do cumprimento das obrigações decorrentes da decisão proferida nos autos da Ação Civil Pública nº 2003.72.00.007539-1 (autos digitais n.° 5025133-50.2014.404.7200), movida pelo Ministério Público Federal em face do Município de Florianópolis, cuja sentença foi mantida pelo Tribunal Regional da 4ª Região, tem por objetivo a proteção ambiental, recuperação da área degradada e a promoção do livre acesso público às margens da Lagoa da Conceição.', '672617577915', '2019-03-14 18:36:18', '2019-03-14 18:36:18'),
(52, 3, 4, '5015140-41.2018.4.04.7200', 'Usucapião- Betina Maria Adams', 'Usucapião Federal', '687178837918', '2019-03-14 19:21:42', '2019-03-14 19:21:42'),
(53, 3, 2, '5002753-34.2013.4.04.7211', 'Reintegração de Posse- ALL', 'Ação de Reintegração / Manutenção De Posse nº 5002753-34.2013.4.04.7211, proposta por ALL - AMERICA LATINA LOGISTICA MALHA SUL S.A em face de FRANCISCO SARTOR.', '520960228913', '2019-03-14 19:41:15', '2019-03-14 19:41:15'),
(54, 2, 3, '5022064-05.2017.4.04.7200', 'Construção irregular na Ponta do Papagaio, em Palhoça/SC.', 'Manifestação acerca do Laudo Pericial', '817266433917', '2019-03-15 11:52:40', '2019-03-15 11:52:40'),
(55, 3, 4, '5013946-06.2018.4.04.7200', 'USUCAPIÃO - IMÓVEL EM TERRENOS DE MARINHA E SEUS ACRESCIDOS', 'subsídios de fato e de direito para a defesa da União na ação de usucapião, especialmente ratificando\nou retificando o parecer técnico nº COCAP-SP-SC 0105862.', '788825671818', '2019-03-15 12:28:23', '2019-03-15 12:28:23'),
(56, 1, 1, '1.33.000.002571/2016-58', 'Pratica ilegal de pesca na Ponte Colombo Sales', 'Pratica ilegal de pesca na Ponte Colombo Sales', 'undefined', '2019-03-15 14:20:21', '2019-03-15 14:20:21'),
(58, 3, 4, '5006608-41.2019.4.04.7201', 'Usucapião. Antonio Pedro de Oliveira', 'Usucapião Federal', '621438588819', '2019-03-15 19:05:07', '2019-03-15 19:05:07'),
(59, 3, 4, '5002944-90.2019.4.04.7204', 'Usucapião. Everaldo Gonçalves De Borba', 'Usucapião Federal', '959072475519', '2019-03-15 19:13:55', '2019-03-15 19:13:55'),
(60, 3, 3, '5003076-54.2018.4.04.7214', 'RFFSA. Reintegração.', 'Reintegração de posse ajuizada pela extinta Rede Ferroviária Federal S.A -\nRFFSA, cumulada com indenização.', '338577871718', '2019-03-15 19:20:44', '2019-03-15 19:20:44'),
(61, 3, 4, '5017188-70.2018.4.04.7200', 'Usucapião em Terreno de Marinha', 'Terreno com área de 360,00 m2, situada na Rua Capistrano, Ponte do Imaruim, Palhoça, SC.', '688507309018', '2019-03-18 16:12:15', '2019-03-18 16:12:15'),
(62, 2, 4, '5015022-02.2017.4.04.7200', 'Zona Costeira Pântano do Sul', 'Zona Costeira Pântano do Sul - até a Praia do Saquinho', '956781482417', '2019-03-18 17:29:56', '2019-03-18 17:35:01'),
(63, 2, 4, '5005552-80.2013.4.04.7201', 'Cumprimento de Sentença. Elaborar PRAD. São Francisco do Sul', 'Condenar o Município de São Francisco do Sul e a União nas obrigações de fazer consistentes:a.1) na elaboração de Plano de Recuperação da Área Degradada - PRAD, a ser submetido ao crivo do IBAMA e da FATMA, o qual deverá prever a integral recuperação ambiental; a.2) na adoção de todas as medidas afetas ao seu poder de polícia, para assegurar o efetivo cumprimento do PRAD e impedir novas interferências no local dos fatos, sem a observância dos requisitos legais necessários para tanto; b) condenar todos os réus, solidariamente, na obrigação de fazer consistente na efetiva execução do PRAD a ser elaborado.', '473243210613', '2019-03-18 18:34:54', '2019-03-18 18:34:54'),
(64, 3, 1, '0307365-45.2018.8.24.0038', 'Indenização por Danos Materiais. Joinville', 'Indenização por danos materiais causados pela passagem de tubulação que percorreu o\nimóvel do autor.', 'undefined', '2019-03-18 19:21:23', '2019-03-18 19:21:23'),
(65, 3, 1, '5003250-94.2017.4.04.7118', 'Pedido de Quebra de Sigilo de dados', 'Pedido de Quebra de Sigilo de dados', 'undefined', '2019-03-18 19:32:32', '2019-03-18 19:34:07'),
(66, 3, 4, '5002736-06.2019.4.04.7205', 'Usucapião - Terreno de Marinha', 'undefined', '287388354119', '2019-03-19 11:38:53', '2019-03-19 11:38:53'),
(67, 3, 2, '5007764-04.2018.4.04.7200', 'Ação Penal área de preservação permanente situada na Estação Ecológica de Carijós.', 'undefined', '665048777518', '2019-03-19 11:57:28', '2019-03-19 11:57:28'),
(68, 3, 3, '0001690-49.2014.8.24.0125', 'Ação Penal. Itapema', 'Declarada a perda em favor da União do Imóvel registrado sob a matrícula de nº 1482 do ofício do registro de imóveis de Itapema, constituído pelo apartamento nº 302,  Condomínio Edifício Apolonia.', 'undefined', '2019-03-19 13:04:07', '2019-03-19 13:04:07'),
(71, 2, 3, '5011483-62.2016.4.04.7200', 'Dano Ambiental. Enseada do Brito. Palhoça', 'Desocupação da área e a recuperação do meio ambiente.', '186966330016', '2019-03-19 13:31:54', '2019-03-19 13:31:54'),
(72, 3, 3, '5017354-05.2018.4.04.7200', 'Embargo de Obra. Biguaçu', 'Embargo judicial da obra, no imóvel do Requerido, localizado na Servidão Ana Clara de Oliveira Vitorino, esquina com a Rua Pery Cabral, Bairro Prado de Baixo –Biguaçu/SC.', '745483721718', '2019-03-19 14:06:55', '2019-03-19 14:06:55'),
(73, 2, 4, '5006587-39.2017.4.04.7200', 'Dano Ambiental. Jurerê. Florianópolis', 'Desocupação e demolição de construções em terrenos de marinha.', '966058141817', '2019-03-19 14:20:41', '2019-03-19 14:20:41'),
(74, 2, 3, '5003268-39.2017.4.04.7208', 'Dano Ambiental. Bombinhas', 'Condenação dos demandados na demolição de edificação irregular em área de preservação   permanente e a recuperação  de vegetação de restinga, mediante a apresentação e execução de Projeto de Recuperação Ambiental (PRAD), a ser submetido a licenciamento ambiental perante a FAMAB, além da regularização da ocupação perante a SPU.', '864157664517', '2019-03-19 18:27:49', '2019-03-19 18:27:49'),
(75, 2, 2, '5010681-06.2017.4.04.7208', 'Dano Ambiental. Rio Santa Luzia. Porto Belo', 'Obtenção de provimento judicial determinando a demolição de edificação que ocupa ilegalmente área de preservação permanente (APP) e terreno de marinha, a recuperação da área degradada e a regularização da ocupação perante a Secretaria do Patrimônio da União (SPU) ou, subsidiariamente, o pagamento de indenização compensatória', '255894199217', '2019-03-19 18:52:01', '2019-03-19 18:52:01'),
(76, 3, 2, '5027026-76.2014.4.04.7200', 'Trata-se de análise e aprovação de PRAD - Projeto de Recuperação Ambiental de Área Degradada e Enriquecimento Florestal', 'undefined', '480755503814', '2019-03-20 14:04:11', '2019-03-20 14:04:11'),
(77, 3, 4, '5006281-09.2018.4.04.7209', 'Usucapião. Vitoria Maria Pinto Cortes', 'Usucapião Federal.', '283701813618', '2019-03-20 17:50:48', '2019-03-20 17:50:48'),
(78, 2, 4, '5010762-18.2013.4.04.7200', 'Construção irregular na Praia das Cordas - Gov. Celso Ramos', 'Construção irregular na Praia das Cordas - Gov. Celso Ramos\r\nMPF x União, Município e Artino Severiano da Silva', 'undefined', '2019-03-21 13:26:55', '2019-03-21 13:26:55'),
(79, 4, 1, '1.33.000.000410/2019-72', 'Reveillon Privillégio Ano I - Cachoeira do Bom Jesus - Florianópolis/SC', 'Instaurada para apurar ocupação de bem da União para realização da festa de reveillon \"Reveillon Privillégio Ano l - Open  Bar /Open  Food\" ocorrida entre  31/12/2018  e 01/02/2019 na faixa de areia próxima à Rua Jardim Giselle e a Servidão da Enseada, na Cachoeira do Bom Jesus, em Florianópolis/SC, sob a responsabilidade de Flow Eventos - Floripa e Life Club Floripa.', 'undefined', '2019-03-21 17:14:45', '2019-03-21 17:14:45'),
(80, 3, 4, '5008656-92.2018.4.04.7205', 'Usucapião - Imóvel em áreas de defesa das vias federais de comunicação', 'undefined', '696735746618', '2019-03-25 12:29:04', '2019-03-25 12:29:04'),
(81, 2, 3, '5015193-27.2015.4.04.7200', 'ACP - Praia de Fora - Palhoça/SC', 'Homologação de acordo.', '716980133515', '2019-03-25 13:28:55', '2019-03-25 13:28:55'),
(82, 2, 1, '5010689-80.2017.4.04.7208', 'Dano Ambiental Porto Belo, Rio Santa Luzia', 'Interromper a degradação ambiental – poluição do rio Santa Luzia, localizado em Porto Belo – que resulta da atividade comercial de peixarias e de outros estabelecimentos comerciais.', '645212937617', '2019-03-25 17:44:46', '2019-03-25 17:44:46'),
(83, 4, 1, '1.33.008.000067/2019-96', 'Avarias em Imóvel tombado. Receita Federal. Itajaí', 'Notícia de Fato autuada a partir de encaminhamento pelo Ministério Público Estadual de cópia de auto de constatação DC nº 12-19, cujo conteúdo narra a existência de avarias em imóvel possivelmente tombado pelo patrimônio histórico e artístico nacional, onde funciona a Receita Federal DO Brasil, no Município de Itajaí/SC.', 'undefined', '2019-03-25 18:09:08', '2019-03-25 18:09:08'),
(84, 3, 2, '5021739-64.2016.4.04.7200', 'Arresto de Direito de Ocupação', 'undefined', 'undefined', '2019-03-26 11:39:17', '2019-03-26 11:39:17'),
(85, 3, 2, '5002269-33.2015.4.04.7216', 'Arresto de Direito de Ocupação', 'undefined', 'undefined', '2019-03-26 12:58:56', '2019-03-26 12:58:56'),
(86, 3, 2, '5003626-28.2017.4.04.7200', 'Arresto de direito de ocupação', 'undefined', 'undefined', '2019-03-26 13:00:50', '2019-03-26 13:00:50'),
(87, 3, 2, '5010253-48.2017.4.04.7200', 'Arresto de direito de ocupação', 'undefined', 'undefined', '2019-03-26 13:01:06', '2019-03-26 13:01:06'),
(88, 2, 3, '5015139-56.2018.4.04.7200', 'Dano Ambiental. Praia dos Ingleses.', 'Demolição de edificação que ocupa ilegalmente área de preservação permanente (APP) e a recuperação da área degradada.', '98922632223818', '2019-03-26 13:56:11', '2019-03-26 13:56:11'),
(89, 3, 4, '5016699-77.2016.4.04.7208', 'Condomínio Residencial  Ernesto Chê Guevara. Maria Isabel Oliveira', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União', '203780049716', '2019-03-26 16:32:37', '2019-03-26 16:32:37'),
(90, 3, 1, '0300079-26.2017.8.24.0143​', 'Servidão Mineral', 'undefined', 'undefined', '2019-03-26 16:39:46', '2019-03-26 16:39:46'),
(91, 3, 4, '5016314-32.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Ricardo de Oliveira', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '650931770016', '2019-03-26 16:40:12', '2019-03-26 16:40:12'),
(93, 3, 4, '5016287-49.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Rafaela Coelho', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União', '848585940116', '2019-03-26 16:45:14', '2019-03-26 16:49:03'),
(94, 3, 4, '5016274-50.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Everton Voitena', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '247758643416', '2019-03-26 16:51:47', '2019-03-26 16:51:47'),
(95, 3, 4, '5017393-46.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Chaiane Rute da Silva', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '703249808516', '2019-03-26 16:57:40', '2019-03-26 16:57:40'),
(96, 3, 4, '5016268-43.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Vinícius Freitas', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '207361433016', '2019-03-26 17:26:33', '2019-03-26 17:26:33'),
(97, 3, 4, '5017163-04.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Simoni do Nascimento da Costa', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '519804573416', '2019-03-26 17:31:53', '2019-03-26 17:31:53'),
(98, 3, 4, '5017156-12.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '731077706216', '2019-03-26 17:35:38', '2019-03-26 17:35:38'),
(99, 3, 4, '5017161-34.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Gabriela Steil Andriani', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '345626800316', '2019-03-26 17:56:47', '2019-03-26 17:56:47'),
(101, 3, 4, '5016270-13.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Nauef Miranda de Jesus', 'Suspensão daeficácia da cláusula sexta do contrato de doação com encargo, firmado entre o Município de Tijucas e a União, registrado perante a SPU-SC no livro nº SC-014- TERMOS DIVERSOS E ESCRITURAS às fls. 68/70, até que os ajustes de prorrogação estejam concluídos.', '461666744816', '2019-03-26 18:27:24', '2019-03-26 18:27:24'),
(102, 3, 4, '50171613420164047208', 'Condomínio Residencial Ernesto Chê Guevara. Gabriela Steil  Andriani', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '345626800316', '2019-03-26 18:35:46', '2019-03-26 18:35:46'),
(103, 3, 4, '5017395-16.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Olaria Eufrasia da Silva', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '262566792216', '2019-03-26 18:54:09', '2019-03-26 18:54:09'),
(104, 3, 4, '5017131-96.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Francielli Petry Kossmann', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '340246718116', '2019-03-26 19:08:04', '2019-03-26 19:08:04'),
(105, 3, 4, '5017390-91.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Gesica Dutra', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União', '230804232116', '2019-03-26 19:52:43', '2019-03-26 19:52:43'),
(106, 1, 1, '1.33.005.00297/2016-32', 'Fiscalização Ambiental em Itapoá/SC', 'undefined', 'undefined', '2019-03-27 18:06:06', '2019-03-27 18:06:06'),
(108, 3, 4, '5016313-47.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara', 'cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '651012442516', '2019-03-27 18:26:23', '2019-03-27 18:26:23'),
(110, 1, 1, '1.33.000.001085/2015-31', 'Situação do projeto habitacional aos integrantes da \"Ocupação Contestado\"', NULL, NULL, '2019-03-27 18:41:08', '2019-03-27 18:43:23'),
(111, 3, 4, '5000591-34.2016.4.04.7220', 'Condomínio Residencial Ernesto Chê Guevara', 'cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '964446190016', '2019-03-27 18:45:15', '2019-03-27 18:45:15'),
(112, 3, 4, '5016700-62.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Eulalio Furtado Junior', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '218789634916', '2019-03-27 18:54:59', '2019-03-27 18:54:59'),
(113, 3, 4, '5016332-53.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. PERLA DOS SANTOS', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '329495060116', '2019-03-27 18:59:20', '2019-03-27 18:59:55'),
(114, 3, 4, '5016331-68.20164047208', 'Condomínio Residencial Ernesto Chê Guevara. Romildo Amaral Ferreira', 'cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '885823780416', '2019-03-27 19:05:53', '2019-03-27 19:05:53'),
(115, 1, 1, '1.33.003.000506/2017-49', 'Loteamento Clandestino. Ouro Verde. Luiz Cesar Quartiero. Gaivota/SC.', NULL, 'undefined', '2019-03-27 19:10:54', '2019-03-27 19:10:54'),
(116, 3, 4, '5016330-83.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara. Doris Cristina Venier', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '358567116316', '2019-03-27 19:23:40', '2019-03-27 19:23:40'),
(117, 3, 4, '5017158-79.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara.  Claudete Dietrich', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '455091746116', '2019-03-27 19:34:01', '2019-03-27 19:34:01'),
(118, 3, 4, '5017021-97.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara.  Francielle Caroline Rebello Cherobin', 'Cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União.', '237402793716', '2019-03-27 19:40:53', '2019-03-27 19:40:53'),
(119, 4, 1, '1.33.000.002314/2018-88', 'Desmatamento de restinga pela Prefeitura. Enseada de Brito, Palhoça/SC', 'Desmatamento de restinga pela Prefeitura. Enseada de Brito, Palhoça/SC', 'undefined', '2019-03-27 19:57:23', '2019-03-27 19:57:23'),
(120, 3, 4, '5017153-57.2016.4.04.7208/', 'Condomínio Residencial Ernesto Chê Guevara. Catiane Pezzini', 'cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União', '522050705116', '2019-03-27 20:16:23', '2019-03-27 20:16:23'),
(121, 3, 4, '5016709-24.2016.4.04.7208', 'Condomínio Residencial Ernesto Chê Guevara.  Flávia Luísa Meira Cordeiro', 'cumprimento do Contrato de Doação da União, firmado com o MUNICÍPIO DE TIJUCAS, contrato esse lavrado no Livro nº 14 - Termos Diversos Escrituras da SPU/SC, sob fls. 68/70, em 17/12/2015,  do imóvel de domínio da União', '649823404816', '2019-03-27 20:35:24', '2019-03-27 20:36:23'),
(122, 2, 4, '5001578-14.2018.4.04.7216', 'Dano Ambiental. Praia da Barra. Garopaba', 'Visa à demolição de obra e a completa recuperação da área de preservação permanente (APP) localizada na Praia da Barra, município de Garopaba/SC.', '778101790718', '2019-03-28 18:09:36', '2019-03-28 18:09:36'),
(123, 3, 4, '5025790-55.2015.4.04.7200', 'Rever o Cancelamento da Ocupação. RIP 8143010014148', 'Ação declaratória de nulidade de ato jurídico para rever o Cancelamento da Ocupação. RIP 8143010014148.', '898076716415', '2019-04-01 13:35:28', '2019-04-01 13:35:28'),
(124, 3, 4, '5021680-44.2014.4.04.7201', 'Usucapião Federal. Dalva Vieira de França', 'undefined', '725115042514', '2019-04-01 14:20:34', '2019-04-01 14:20:34'),
(125, 2, 3, '5010761-43.2012.404.7208', 'Dano Ambiental. Balneário Camboriú', 'Demolição de construção realizada em área de preservação permanente e terreno de marinha, bem como a prestação de indenização pelo dano ambiental sofrido.', '326895718312', '2019-04-01 16:41:15', '2019-04-01 16:41:15'),
(126, 2, 4, '5008851-39.2011.4.04.7200', 'Dano Ambiental. Praia de Magalhães.Governador Celso Ramos', 'Demolição de construção em terras da União Federal caracterizadas como Área de Preservaçao Ambiental, na Praia do Magalhães, no interior da APA de Anhatomirim, município de Governador Celso Ramos, bem como a restauração da área degradada.', 'undefined', '2019-04-01 17:01:40', '2019-04-01 17:01:40'),
(127, 5, 1, '08.2019.00070195-2', 'Dano Ambiental. Antonio Donizete da Silva Goes. Ulysses Guimarães, Joinville', NULL, 'undefined', '2019-04-01 18:55:06', '2019-04-01 18:55:06'),
(128, 3, 1, '5008534-70.2013.4.04.7200', 'Usucapião. Canto do Lamin, Papaquara, Canasvieiras - José Sobreira de Alencar e outro', 'undefined', '965780188213', '2019-04-01 19:24:17', '2019-04-01 19:24:17'),
(130, 3, 4, '5003358-50.2017.4.04.7207', 'Contrato SARP A-TC-5072​', 'undefined', '795136425517', '2019-04-01 19:39:54', '2019-04-01 19:39:54'),
(132, 2, 2, '5026884-72.2014.4.04.7200', 'Ranchos de Pesca na Tapera - Florianópolis - ICP 1.33.000.007186/2002-00', 'Da inicial: Ocupação ilícita, clandestina e desordenada de área de praia e que constitui terra de marinha, nem como APP, na Praia da Tapera em Florianópolis. Barracos utilizados para moradia de veraneio sob pretexto de serem ranchos de pesca.', '901644162114', '2019-04-01 20:51:18', '2019-04-01 20:51:49'),
(134, 2, 3, '5009015-67.2017.4.04.7208', 'Dano Ambiental. Bombinhas', 'Demolição da edificação e de todas as benfeitorias, até o limite de 14 metros a partir da linha preamar média de 1831, e à completa recuperação da respectiva área em imóvel localizado na Rua Sardinha, nº 42, Centro, Bombinhas/SC.', '397971993317', '2019-04-02 13:24:12', '2019-04-02 13:24:12'),
(135, 2, 1, '5010039-1.2016.404.7200', 'Zona Costeira - Trecho Sul de São José', 'undefined', 'undefined', '2019-04-02 13:34:30', '2019-04-02 13:34:30'),
(136, 1, 1, '1.33.005.000244/2009-92', 'Dano Ambiental. São Francisco do Sul', 'Dano Ambiental. Edificação construída na Avenida Tripoli, 557, Praia Itaguaçu, Bairro Itaguaçu, São Francisco do Sul', 'undefined', '2019-04-02 13:45:47', '2019-04-02 13:45:47'),
(137, 2, 4, '5004976-80.2019.4.04.7200', 'Ocupação irregular em terras indígenas', 'O Ofício 454/2019 - NUP 04972.002177/2019-22, trata de terras indígenas e a União foi condenada na obrigação de fazer consistente na adoção das providências administrativas e judiciais necessárias para impedir obras e invasões na terra indígena Cambirela, na Palhoça, bem como demolir  as construções ilegais já implantadas e recuperação ambiental.', '3322396639119', '2019-04-02 16:33:17', '2019-04-02 16:33:17'),
(139, 2, 1, '5004981-78.2014.4.04.7200', 'Abertura de acessos à praia - Município de Governador Celso Ramos', 'O Ofício 455/2019 - NUP 04972.002119/2019-07, trata da abertura de acessos em Governador Celso Ramos. O Município alegou que a União (SPU) não estava cumprindo a parte dela e o juiz determinou que a União em 15 dias informe quais são as inscrições e/ou aforamentos de terras de marinha cuja manutenção pela União estariam impedindo a abertura dos acessos, bem como que fosse informadas eventuais ocupações irregulares.', '312236886214', '2019-04-02 16:46:28', '2019-04-02 16:46:28'),
(140, 3, 4, '5013419-64.2017.4.04.7208', 'Nulidade de Processo de Demarcação. RIP 8 8265.0000259-77', 'Ação Declaratória com Pedido de Repetição de Indébito e de Tutela Antecipada, em face da UNIÃO, postulando, em apertado resumo: [i] a declaração de nulidade do processo administrativo de demarcação de terras de marinha e, por decorrência lógica, das taxas de ocupação cobradas em face do imóvel objeto do Registro Imobiliário Patrimonial nº 8265.0000259-77.', '134201307217', '2019-04-02 17:38:00', '2019-04-02 17:38:00'),
(142, 3, 4, '5003097-69.2018.4.04.7201', 'Usucapião Federal. Alceu Antonio Fhynbeen', 'undefined', '160235661518', '2019-04-02 18:15:23', '2019-04-02 18:15:23'),
(143, 3, 1, '5011170-17.2019.4.04.7000', 'Execução Fiscal. Taxa de Ocupação. Hauer Empreendimentos Imobiliários. Biguaçu', 'Execução Fiscal. Taxa de Ocupação. Hauer Empreendimentos Imobiliários. Biguaçu. Réu alega que a cobrança é indevida por ter transferido o terreno em 1979 e 1980.', '116924815619', '2019-04-02 18:20:01', '2019-04-02 18:20:01'),
(144, 3, 4, '5001417-72.2016.4.04.7216', 'Usucapião Federal.', 'undefined', '502012053216', '2019-04-02 18:54:38', '2019-04-02 18:54:38'),
(145, 3, 4, '5000162-50.2014.4.04.7216', 'Usucapião', 'Aferir a existência de registro em cartório de imóvel pertencente à União em nome de terceiros como proprietários.', '842354754314', '2019-04-03 12:09:30', '2019-04-03 12:09:30'),
(146, 3, 1, '0005949-48.2011.8.24.0075', 'Ação Penal - Procedimento Ordinário', 'undefined', 'undefined', '2019-04-03 18:25:31', '2019-04-03 18:25:31'),
(147, 3, 2, '5006746-89.2016.4.04.7208', 'Desapropriação Indireta', 'undefined', '299242662116', '2019-04-03 18:35:35', '2019-04-03 18:35:35'),
(148, 3, 2, '5003585-78.2019.4.04.7204', 'undefined', 'Interesse na lide.', '110118087119', '2019-04-03 18:46:59', '2019-04-03 18:46:59'),
(149, 3, 2, '5001379-84.2016.4.04.7208', 'Desapropriação Indireta', 'undefined', '764014760916', '2019-04-03 19:28:34', '2019-04-03 19:28:34'),
(152, 3, 4, '5015894-77.2018.4.04.7201', 'Usucapião', 'interesse federal na causa', 'undefined', '2019-04-03 19:37:52', '2019-04-03 19:37:52'),
(153, 2, 2, '5018585-67.2018.4.04.7200', 'AÇÃO CIVIL PÚBLICA - CONDOMÍNIO RESIDENCIAL E COMERCIO PORTO DA LAGOA', 'undefined', '636161096818', '2019-04-03 19:52:12', '2019-04-03 19:52:12'),
(154, 5, 1, '07.2017.00039377-0', 'Cancelamento de matrícula de terreno de marinha. Itapema. Alcino Pasqualotto Neto', 'Manifestação sobre o cancelamento da matrícula 10.241, solicitada pelo interventor do cartório de registro de imóveis em função da negativa da legal de registro e abertura de matrículas de ocupação de terreno da União, execetuando-se os casos de aforamento.\r\nRefere-se ao RIP 8163.0000291-04', 'undefined', '2019-04-03 20:27:26', '2019-04-03 20:27:26'),
(155, 3, 4, '5012582-72.2018.4.04.7208', 'Ambiental', 'Requer que seja reconhecido que o local específico no qual fora instalada passagem de acesso à Praia Grande, no Município de Penha, não constitui APP (área de preservação permanente).', '508740758418', '2019-04-04 11:24:55', '2019-04-04 11:24:55'),
(156, 3, 3, '0024324-98.1984.4.04.7200', 'Mandados de Imissão na Posse', 'Imóvel em Laguna.', 'undefined', '2019-04-04 11:32:22', '2019-04-04 11:32:22'),
(158, 3, 4, '5016606-67.2018.4.04.7201', 'Usucapião', 'Manifestar se há interesse no feito.', 'undefined', '2019-04-04 11:42:15', '2019-04-04 11:42:15'),
(159, 3, 4, '5022387-78.2015.4.04.7200', 'Usucapião', 'manifestação acerca do Laudo Pericial complementar', '437071396215', '2019-04-04 12:20:46', '2019-04-04 12:20:46'),
(160, 3, 3, '5000070-67.2017.4.04.7216', 'Reintegração de Posse', 'Imóvel da RFFSA', '922053331117', '2019-04-04 12:40:36', '2019-04-04 12:40:36'),
(162, 3, 4, '5004510-79.2016.4.04.7204', 'Usucapião', 'indicação de assistente técnico', '981565022716', '2019-04-04 13:20:29', '2019-04-04 13:20:29'),
(163, 3, 1, '0304261-90.2018.8.24.0023', 'Desapropriação', 'Desapropriação movida pela CASAN em face de particular', 'undefined', '2019-04-04 14:12:58', '2019-04-04 14:12:58'),
(164, 3, 2, '0308178-20.2018.8.24.0023', 'Desapropriação', 'undefined', 'undefined', '2019-04-04 16:46:41', '2019-04-04 16:46:41'),
(165, 3, 3, '5002845-60.2014.4.04.7216', 'Desapropriação', 'Porto de Laguna.', '208748051214', '2019-04-04 17:21:22', '2019-04-04 17:21:22'),
(166, 3, 3, '5001957-23.2016.4.04.7216', 'Usucapião', 'undefined', '519315644216', '2019-04-04 18:03:09', '2019-04-04 18:03:09'),
(167, 2, 3, '5008751-45.2015.4.04.7200', 'Ação Civil Pública - Imóvel em Canasvieiras', 'undefined', '381284688615', '2019-04-05 12:01:20', '2019-04-05 12:01:20'),
(168, 3, 4, '5001945-77.2014.4.04.7216/SC', 'TERRENO DE MARINHA. LAUDÊMIO. PRESCRIÇÃO', 'undefined', 'undefined', '2019-04-05 13:05:07', '2019-04-05 13:05:07'),
(169, 2, 4, '5031473-10.2014.4.04.7200', 'Dano Ambiental', 'undefined', '345303018914', '2019-04-05 13:25:03', '2019-04-05 13:25:03'),
(170, 3, 2, '5026035-95.2017.4.04.7200', 'Usucapião', 'undefined', '378389110517', '2019-04-05 13:36:28', '2019-04-05 13:36:28'),
(171, 1, 1, '1.33.001.000157/2015-13', 'Loteamento Green Ville, localizado na Rodovia Jorge Lacerda, Km 12,4, Ilhota/SC', 'Verificar regularidade.', 'undefined', '2019-04-05 16:09:23', '2019-04-05 16:09:23'),
(172, 1, 1, '1.33.000.002581/2018-55', 'Obra de arrimo das margens do Ribeirão a Capela e reconstrução de ponte de concreto.', 'undefined', 'undefined', '2019-04-05 17:16:50', '2019-04-05 17:16:50'),
(173, 6, 1, '0085/2019-4-SR/PF/SC', 'Informação sobre bens da União.', 'Informar se o área localizada na Estrada Intendente António Damasco, s/n°, ao Iaco doj \"Trevo\'s Bar\", Ratones, Florianópolis/SC, coordenadas de referência Datum WGS -84 -27.489785°S / -48.493368°O, incide em terrenos de marinha e seus acrescidos.', 'undefined', '2019-04-05 17:31:51', '2019-04-05 17:31:51'),
(174, 1, 1, '1.33.008.000015/2017-58', 'undefined', 'Marina Patrício, localizada na Rua Luis Joaquim dos Santos, bairro São Pedro, no Município de Navegantes/SC, às margens do Rio Itajaí-Açu', 'undefined', '2019-04-05 17:37:25', '2019-04-05 17:37:25'),
(175, 2, 4, '5014004-09.2018.4.04.7200', 'Cessão da barragem oeste (Taió)', 'undefined', '150147097218', '2019-04-05 17:41:26', '2019-04-05 17:41:26'),
(176, 1, 1, '1.33.000.001328/2007-21', 'undefined', 'Solicita informações se já houve a conclusão dos trabalhos referentes a regularização da delimitação da Linha de Preamar Média/1831 e, em caso negativo, quais as medidas adotadas para a referida\nregularização.', 'undefined', '2019-04-05 17:48:25', '2019-04-05 17:48:25'),
(178, 3, 4, '5014307-67.2016.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Condomínio Habitacional Ernesto Che Guevara', '737120895016', '2019-04-05 18:19:36', '2019-04-05 18:19:36'),
(179, 3, 4, '5003387-53.2019.4.04.7200', 'MANDADO DE SEGURANÇA. Remição de aforamento', 'undefined', '80390625619', '2019-04-08 12:12:04', '2019-04-08 12:12:04'),
(180, 3, 3, '5008272-35.2018.4.04.7204', 'Reintegração de Posse', 'Imóvel funcional situado na Rua Engenheiro Fiúza da Rocha, 84, Centro, no Município de Criciúma/SC, com área de 452,23 m², sobre o qual se encontra edificada uma casa de alvenaria de 126,69 m², registrado no 1° Oficio do Registro de Imóveis da Comarca de Criciúma, sob a matrícula de nº 2.108.', '312135651218', '2019-04-08 12:19:39', '2019-04-08 12:19:39'),
(181, 2, 4, '5026745-81.2018.4.04.7200', 'ACP', NULL, '342678531818', '2019-04-08 12:33:36', '2019-04-08 12:34:22'),
(182, 3, 4, '5001494-44.2017.4.04.7217', 'Usucapião', 'undefined', '557405466217', '2019-04-08 13:54:42', '2019-04-08 13:54:42'),
(183, 3, 4, '5006734-41.2017.4.04.7208', 'undefined', 'Reabertura de prazo para entrega de títulos Condomínio Habitacional Ernesto Che Guevara', '60029786817', '2019-04-08 14:08:14', '2019-04-08 14:08:14'),
(184, 3, 4, '5003278-83.2017.4.04.7208/SC', 'undefined', 'reabertura de prazo para entrega de títulos Condomínio Habitacional Ernesto Che Guevara', '323037441517', '2019-04-08 14:11:25', '2019-04-08 14:11:25'),
(185, 3, 3, '5001735-74.2019.4.04.7208', 'USUCAPIÃO EXTRAORDINÁRIA', 'undefined', 'undefined', '2019-04-08 16:39:44', '2019-04-08 16:39:44'),
(186, 3, 1, '0313746-17.2018.8.24.0023', 'Desapropriação. Loteamento Santos Dumont.', 'Desapropriação efetivada pelo DEINFRA.', 'undefined', '2019-04-08 16:57:58', '2019-04-08 16:57:58'),
(187, 3, 4, '5007782-93.2016.4.04.7200', NULL, 'Usucapião Federal', '535133090816', '2019-04-08 17:43:47', '2019-04-08 17:43:47'),
(188, 3, 4, '5000895-79.2010.4.04.7208', 'undefined', 'undefined', '656236623210', '2019-04-08 18:19:14', '2019-04-08 18:19:14'),
(189, 1, 1, '1.33.005.000662/2016-17', 'TAUS -  Praia do Forte, em São Francisco do Sul/SC', 'undefined', 'undefined', '2019-04-09 11:33:53', '2019-04-09 11:33:53'),
(191, 1, 1, '1.33.005.000032/2019-87', 'Verificar interferência com área da União.', 'undefined', 'undefined', '2019-04-09 13:02:50', '2019-04-09 13:02:50'),
(192, 1, 1, '1.33.003.000105/2018-7', 'Cessão onerosa da Plataforma de Pesca Entremares Araranguá', 'undefined', 'undefined', '2019-04-09 13:26:17', '2019-04-09 13:26:17'),
(194, 3, 3, '5021998-93.2015.4.04.7200', 'Demolição de casas na Praia do Forte', 'A União deverá providenciar a demolição de casas na Praia do Forte', '856775037515', '2019-04-09 16:26:56', '2019-04-09 16:26:56'),
(195, 3, 3, '5017717-19.2014.4.04.7204', 'RESTITUIÇÃO DE ÁREA', 'União noticiou ao Juízo que aquele órgão concluiu pela renúncia à\r\ndívida do Sr. Santos de Souza, diante do interesse social, restando ainda a questão da destinação do bem que, conforme\r\na SPU, seria analisada em conjunto com as demais situações existentes na Rua Campos Elísios, sendo aguardado o\r\nlaudo ambiental para que a DIRFH analise a possibilidade de Regularização Fundiária de Interesse Social.', '825570237214', '2019-04-09 16:51:22', '2019-04-09 16:51:22'),
(196, 3, 4, '5011418-04.2015.4.04.7200', 'Usucapião', 'undefined', '300726583715', '2019-04-09 17:19:19', '2019-04-09 17:19:19'),
(197, 3, 1, '0303012-89.2017.8.24.0007', 'undefined', 'undefined', 'qwyucd', '2019-04-09 17:30:14', '2019-04-09 17:30:14'),
(198, 3, 1, '5015326-61.2018.4.04.7201', 'undefined', 'undefined', '667199124918', '2019-04-09 18:01:52', '2019-04-09 18:01:52'),
(199, 3, 1, '0001868-55.2014.5.12.0004', 'Ação Trabalhista - Indisponibilidade de Bens e Direitos', 'undefined', 'undefined', '2019-04-10 12:20:54', '2019-04-10 12:20:54'),
(200, 6, 1, '0125/2019-4-SR/PF/SC', 'Verificar se área interfere com bem da União.', 'undefined', 'undefined', '2019-04-10 13:49:57', '2019-04-10 13:49:57'),
(201, 6, 1, '0125/2019-4', 'undefined', 'informar se o local onde foi lavrado o AUTO DE INFRAÇÃO 032211 B encontra-se inserido em área de marinha e seus acrescidos.', 'undefined', '2019-04-10 13:59:53', '2019-04-10 13:59:53'),
(202, 1, 1, '1.33.005.000522/2015-50', 'undefined', 'undefined', 'undefined', '2019-04-10 14:06:31', '2019-04-10 14:06:31'),
(203, 6, 1, '0064/2019-4', 'undefined', 'undefined', 'undefined', '2019-04-10 15:58:58', '2019-04-10 15:58:58'),
(204, 6, 1, '0613/2018-4', 'undefined', 'undefined', 'undefined', '2019-04-10 16:10:39', '2019-04-10 16:10:39'),
(205, 1, 1, '1.33.001.000514/2018-96', 'Cessão', 'Imóvel situado na Rua Itajaí, 1115, Blumenau/SC, antigo prédio do Ministério do Trabalho.', 'undefined', '2019-04-10 16:45:20', '2019-04-10 16:45:20'),
(206, 3, 4, '5009455-05.2013.4.04.7208', 'Construção irregular em Bombinhas - Demolição de Trapiche - Leonidas Antônio Sochas', 'undefined', '919591244413', '2019-04-10 17:30:39', '2019-04-10 17:30:39'),
(207, 8, 1, '0105/108', 'Defensoria Pública Estadual', 'Documentação INCRA', 'undefined', '2019-04-10 18:13:30', '2019-04-10 18:13:30'),
(208, 1, 1, '1.33.000.002268/2013-11', 'undefined', 'undefined', 'undefined', '2019-04-11 13:39:57', '2019-04-11 13:39:57'),
(209, 1, 1, '1.33.000.000723/2019-21', NULL, 'informações a respeito do quanto noticiado, em suma, sobre suposto abandono do terreno da União localizado na Rua José da Costa Moellman, em frente ao Tribunal de Contas do Estado.', 'undefined', '2019-04-11 16:53:41', '2019-04-11 16:53:41'),
(210, 6, 1, '0077/2018-4', 'undefined', 'Eventual ocupação irregular imóvel da União denominado \"Ilha Grande\" (ou \"Ilha Quinta dos Ganchos\"), situada no município de Governador Celso Ramos/SC', 'undefined', '2019-04-11 16:59:07', '2019-04-11 16:59:07'),
(211, 8, 1, '1.33.005.000271/2017-7', 'TAUS', 'undefined', 'undefined', '2019-04-11 17:06:12', '2019-04-11 17:06:12'),
(212, 1, 1, '1.33.000.001547/2011-97', 'TAUS', 'informações atualizadas sobre o andamento da concessão de Termos de Autorização de Uso Sustentável (TAUS) para os ranchos de pesca situados no Bairro do Abraão', 'undefined', '2019-04-11 17:13:10', '2019-04-11 17:13:10'),
(213, 1, 1, '1.33.005.000449/2015-16', 'TAUS', 'TAUS - Balneário Barra Sul', 'undefined', '2019-04-11 17:20:40', '2019-04-11 17:20:40'),
(214, 1, 1, '1.33.000.000626/2013-42', 'undefined', 'TAUS na região do Rio Imaruím, Palhoça/SC', 'undefined', '2019-04-11 17:34:08', '2019-04-11 17:34:08'),
(215, 8, 1, '1.33.016.000013/2019-21', 'undefined', 'Solicita cópia do processo', 'undefined', '2019-04-11 17:46:40', '2019-04-11 17:46:40'),
(216, 3, 1, '0300658-20.2016.8.24.0139', 'undefined', 'Reintegração / Manutenção de Posse', 'undefined', '2019-04-11 18:37:37', '2019-04-11 18:37:37'),
(217, 3, 4, '5002031-11.2019.404.7204', 'Contestação de Cobrança - Clube Atlético Tubarão', 'Contestação de Cobrança, alegação de ilegitimidade passiva - Clube Atlético Tubarão', '938760091919', '2019-04-12 14:33:28', '2019-04-12 14:33:28'),
(218, 7, 3, '91.6.16.014713-5', 'undefined', 'undefined', 'undefined', '2019-04-12 16:38:32', '2019-04-12 16:38:32'),
(219, 1, 1, '06.2015.00003216-1', 'Dano Ambiental. Garopaba', 'undefined', 'undefined', '2019-04-12 16:55:10', '2019-04-12 16:55:10'),
(220, 4, 1, '00435.000437/2019-51', 'TAUS - Imóvel no Ribeirão da Ilha', 'undefined', 'undefined', '2019-04-12 17:11:43', '2019-04-12 17:11:43'),
(221, 3, 1, '5006649-11.2019.4.04.7200', 'Interdito Proibitório', 'undefined', 'undefined', '2019-04-12 17:38:12', '2019-04-12 17:38:12'),
(222, 2, 4, '5002875-27.2016.4.04.7216', 'Dano Ambiental. Garopaba', 'undefined', '168766448616', '2019-04-12 17:47:15', '2019-04-12 17:47:15'),
(223, 3, 4, '5015296-73.2016.4.04.7208', 'Condomínio Habitacional Ernesto Che Guevara.', 'undefined', '690342849616', '2019-04-15 13:24:48', '2019-04-15 13:24:48'),
(224, 3, 4, '5003408-04.2011.4.04.7202', 'Usucapião Federal', 'undefined', '8394674163 11', '2019-04-15 17:01:00', '2019-04-15 17:01:00'),
(225, 3, 4, '0004330-20.2008.4.04.7208', 'AUMENTO DE TAXA DE OCUPAÇÃO - IMÓVEL RIP 8161.0000103-00', 'Trata-se de ação judicial em que a parte autora pretendia invalidar aumento no valor da taxa de ocupação dos exercícios de 2007 e 2008.', 'undefined', '2019-04-15 17:09:49', '2019-04-15 17:09:49'),
(226, 3, 3, '0001772-96.1971.4.04.7200', 'DNER', 'Adjudicação em favor da União ( DNER)', 'undefined', '2019-04-15 17:28:48', '2019-04-15 17:30:00'),
(227, 2, 3, '5000818-21.2015.4.04.7200', 'Dano Ambiental. Rua Baldicero Filomeno, ao lado do nº 19.790, Ribeirão da Ilha, Florianópolis, SC.', 'Ação civil pública que alega terem os réus construído irregularmente em Terreno de Marinha (APP)', '992385556415', '2019-04-15 17:38:43', '2019-04-15 17:38:43'),
(228, 2, 4, '5009439-33.2017.4.04.7201', 'Dano Ambiental. Joinville', 'Regularização e fiscalização na área de preservação permanente localizada no final da rua senador Lauro Fagundes dos Reis, no bairro jardim Iririú, no Município de Joinville.', '791998026617', '2019-04-15 18:05:41', '2019-04-15 18:05:41'),
(229, 3, 4, '5002990-96.2012.4.04.7213', 'Usucapião Federal', 'undefined', '964430110712', '2019-04-15 19:09:07', '2019-04-15 19:09:07');
INSERT INTO `procedimentoexterno` (`id`, `idTipoProcedimentoExterno`, `idPoloProcedimentoExterno`, `procedimento`, `resumo`, `descricao`, `chave`, `created_at`, `updated_at`) VALUES
(230, 2, 4, '5008047-90.2019.404.7200', 'Índios Guaranis. Mercado Público Florianópolis', 'undefined', 'undefined', '2019-04-16 16:41:20', '2019-04-16 16:41:20'),
(231, 3, 4, '03007288220178240048', 'Usucapião Estadual', 'undefined', 'undefined', '2019-04-16 17:08:16', '2019-04-16 17:08:16'),
(232, 2, 1, '0918895-10.2017.8.24.0045', 'Palhoça', 'Objetiva, entre outros pedidos, o lacre e interdição de uso da edificação e das obras descritas, determinando à primeira requerida que paralise imediatamente toda e qualquer atividade desenvolvida na área objeto do pedido', 'undefined', '2019-04-16 17:20:14', '2019-04-16 17:20:14'),
(233, 1, 1, '1.33.005.000154/2011-16', 'José Antônio da Cunha - Dano Ambiental . São Francisco do Sul', NULL, 'undefined', '2019-04-17 13:41:29', '2019-05-24 14:30:20'),
(234, 3, 4, '5012727-55.2018.4.04.7200', 'Retificação de registro', 'undefined', '803241842818', '2019-04-17 13:57:24', '2019-04-17 13:57:24'),
(235, 3, 3, '5017233-74.2018.4.04.7200', 'Dano Ambiental. Biguaçu', 'undefined', '248587921518', '2019-04-17 14:09:27', '2019-04-17 14:09:27'),
(236, 3, 1, '0018447-70.2013.8.24.0023', 'Usucapião Estadual', 'undefined', 'undefined', '2019-04-17 17:37:20', '2019-04-17 17:37:20'),
(237, 2, 4, '5002902-53.2019.4.04.7200', 'Dano Ambiental. Ilha do Papagaio', 'undefined', '579843626719', '2019-04-17 18:23:11', '2019-04-17 18:23:11'),
(238, 1, 1, '1.33.008.000395/2013-05', 'Dano Ambiental.Balneário Camboriu', 'undefined', 'undefined', '2019-04-18 17:54:46', '2019-04-18 17:54:46'),
(239, 2, 1, '5004544-49.2019.4.04.7204', 'Identificação de área', 'Informar se a área em questão, localizada na Rodovia SC 100 Canto da Lagoa - Laguna, coordenadas 22J 713601/ 6837445, está situada em terrenos de marinha.', 'undefined', '2019-04-22 13:00:57', '2019-04-22 13:00:57'),
(240, 1, 1, '1.33.001.000129/2019-20', 'undefined', 'Regularidade do imóvel \"Jardim das Dálias\"', 'undefined', '2019-04-22 13:16:55', '2019-04-22 13:16:55'),
(246, 3, 4, '5012050-25.2018.4.04.7200', 'Usucapião. Evaldo José Lago', 'undefined', '3723230313818', '2019-04-22 13:53:46', '2019-04-22 13:53:46'),
(250, 3, 4, '5001018-68.2019.4.04.7206', 'Majoração da taxa de ocupação', 'undefined', '14915010619', '2019-04-22 17:08:45', '2019-04-22 17:08:45'),
(252, 3, 4, '5007645-09.2019.4.04.7200', 'Obter autorização para reforma de edificação', 'undefined', '950326714019', '2019-04-22 17:31:53', '2019-04-22 17:31:53'),
(254, 3, 4, '0301144-13.2016.8.24.0007', 'Usucapião. José João Ferreira', 'undefined', 'undefined', '2019-04-22 17:49:59', '2019-04-22 17:49:59'),
(255, 8, 1, '0312043-56.2015.8.24.0023-000', 'undefined', 'undefined', 'undefined', '2019-04-22 18:12:52', '2019-04-22 18:12:52'),
(256, 3, 4, '5000836-82.2019.4.04.7206', 'Objetiva a demolição de construção', 'undefined', '822089215319', '2019-04-22 19:47:41', '2019-04-22 19:47:41'),
(257, 3, 1, '003957-79.2006.8.16.0033', 'undefined', 'undefined', 'undefined', '2019-04-23 13:48:46', '2019-04-23 13:48:46'),
(258, 2, 4, '5008465-28.2019.4.04.7200', 'Nulidade da matrícula de imóvel', 'undefined', '692311726419', '2019-04-23 16:52:01', '2019-04-23 16:52:01'),
(259, 3, 1, '5018644-02.2016.4.04.7208', 'Receita federal Itajaí', 'undefined', 'undefined', '2019-04-23 18:33:35', '2019-04-23 18:33:35'),
(260, 3, 4, '5017236­63.2017.4.04.7200/SC', 'Usucapião', 'Rejeitado o pedido de usucapião.', 'undefined', '2019-04-23 18:49:08', '2019-04-23 18:49:08'),
(261, 3, 4, '5009770-57.2018.4.04.7208', 'undefined', 'Requer declaração de ser o imóvel de 339,53m2 área não pertencente à União (marinha), mas particular (alodial), de posse do Requerente, anular a certidão de ocupação expedida pela União sob o nº RIP 8245 0000045-84 e determinar a anulação do cadastro municipal nº 13888, inscrição imobiliária 01.06.046.007.', '632702254718', '2019-04-23 19:11:01', '2019-04-23 19:11:01'),
(262, 2, 4, '5017734-28.2018.4.04.7200', 'AAAB Florianópolis', 'Visa à condenação dos Réus (entes públicos subsidiariamente) em obrigações de fazer, consistentes na adoção de medidas que façam cessar ocupação irregular de um espaço protegido de costão/promontório, ambiente de restinga e de faixa de praia, bens da União localizados no imóvel sito na Rua Desembargador Pedro Silva, 2809, Bairro Coqueiros, nesta Capital/SC, através do desfazimento/retirada/demolição das construções lá erigidas, bem como na recuperação ambiental integral da área e na abertura/estabelecimento de franco e livre acesso à praia e ao costão.', '367365326518', '2019-04-24 18:12:54', '2019-04-24 18:12:54'),
(263, 3, 4, '5047812-71.2018.4.04.0000', 'Majoração da Taxa de Ocupação. Florianópolis', 'undefined', '717334800510', '2019-04-24 18:36:34', '2019-04-24 18:41:02'),
(264, 3, 4, '5000606-21.2016.4.04.7214', 'Desapropriação. Três Barras', 'undefined', '698432182616', '2019-04-24 19:39:02', '2019-04-24 19:39:02'),
(266, 8, 4, '5008044-38.2019.4.04.7200', 'Mandado de Seguranção - Determina a conclusão do processo de revisão de área em 60 dias - Local Itapema/SC', 'relacionado ao RIP 8163.0000343-61, o qual recebeu número de atendimento SC 02789/2017 (Processo 04972.008469/2017-15),', '847867684919', '2019-04-25 14:29:35', '2019-04-25 14:29:35'),
(267, 3, 4, '5013141-60.2012.4.04.7201', 'Nulidade do Processo de Demarcação. RIP 8179.0102286-70, 8179.0102337-54 8179.0102383-90 e 8179.0102283-27', 'undefined', '333071402912', '2019-04-26 13:31:25', '2019-04-26 13:31:25'),
(268, 3, 4, '0000458-06.2013.8.24.0135', 'Usucapião. Altamir Seberino da Silva', 'undefined', 'undefined', '2019-04-26 14:02:19', '2019-04-26 14:02:19'),
(269, 3, 4, '5017790-32.2016.4.04.7200', 'Usucapião. Plabo Moritz', 'undefined', '561255207716', '2019-04-26 16:52:20', '2019-04-26 16:52:20'),
(270, 3, 1, '5009050-27.2012.4.04.7200', 'Execução fiscal', 'undefined', '5814264490412', '2019-04-26 17:35:37', '2019-04-26 17:35:37'),
(271, 3, 4, '5000531-39.2017.4.04.7216', 'Usucapião. Fernando Martins Da Costa Barros', 'undefined', '126089427217', '2019-04-26 18:00:51', '2019-04-26 18:00:51'),
(272, 1, 1, '1.33.000.000939/2016-43', 'Regularidade de Ocupação', 'Imóvel na Rua Silva Jardim, n° 1278, Bairro Prainha, em Florianópolis/SC.', 'undefined', '2019-04-29 12:20:03', '2019-04-29 12:20:03'),
(273, 3, 1, '5008486-48.2017.4.04.7208', 'Incorporação e entrega do imóvel perdido em favor da União. Balneário Camboriú', 'undefined', 'undefined', '2019-04-29 13:56:39', '2019-04-29 13:59:12'),
(274, 3, 4, '5016741-79.2018.4.04.7201', 'Usucapião. Neri Agostinho da Cruz', 'undefined', '718776303618', '2019-04-29 16:40:29', '2019-04-29 16:40:29'),
(275, 3, 4, '5015092-82.2018.4.04.7200', 'Usucapião. Jose Nieto Lourenço', 'undefined', '568090275518', '2019-04-29 17:42:11', '2019-04-29 17:42:11'),
(276, 3, 4, '5000135-62.2017.4.04.7216', 'Usucapião. Dorvaci Martins', 'undefined', '782776116817', '2019-04-29 19:50:13', '2019-04-29 19:50:13'),
(277, 1, 1, '1.33.000.002012/2018-18', 'undefined', 'Imóvel na Praia do Ingleses Florianópolis/SC - Restaurante Camarão Dourado', 'undefined', '2019-04-30 12:27:10', '2019-04-30 12:27:10'),
(278, 3, 4, '5008934-16.2015.4.04.7200', 'Usucapião. Arminio Motta Collier', 'undefined', '763521887115', '2019-04-30 14:07:29', '2019-04-30 14:07:29'),
(279, 3, 4, '5001087-94.2019.4.04.7208', 'RIP 8265.0000401 - 86. Porto Belo', 'AÇÃO DECLARATÓRIA DE INEXIGIBILIDADE DE DÉBITO C/C REVISÃO DE TAXA DE OCUPAÇÃO.', '403713207519', '2019-04-30 17:33:02', '2019-04-30 17:33:02'),
(280, 3, 1, '03129454920188240008', 'Retificação de Registro Imobiliário - R. Itajaí', 'Análise de interferência de área, objeto de Ação de Retificação de área, com as terras da União.', 'undefined', '2019-04-30 17:46:27', '2019-04-30 17:46:27'),
(281, 3, 4, '5002575-13.2016.4.04.7201', 'Nulidade de Processe Demarcatório. Barra Velha', 'undefined', '393196074016', '2019-04-30 18:10:03', '2019-04-30 18:10:03'),
(282, 3, 1, '0301100-56.2015.8.24.0030', 'undefined', 'undefined', 'undefined', '2019-05-02 13:10:15', '2019-05-02 13:10:15'),
(283, 3, 2, '5009514-07.2019.4.04.7200', 'PRAD.  Rodovia Açoriana – Tapera – Florianópolis', 'Alteração da delimitação imposta ao bem imóvel de propriedade da REQUERENTE e objeto do PRAD, de 30 (trinta) metros para 05 (cinco) metros de recomposição de área de APP a partir do curso d’agua,', 'undefined', '2019-05-02 17:10:25', '2019-05-02 17:10:25'),
(284, 3, 4, '5030689-33.2014.4.047200', 'Usucapião. Portozelo Atacadista Ltda', 'undefined', '714693383114', '2019-05-02 19:14:43', '2019-05-02 19:14:43'),
(285, 2, 4, '5018427-09.2018.4.04.7201', 'Dano Ambiental. Balneário Rosa dos Ventos, Itapoá/SC', 'Demolição das edificações (casa, muros, \"deck\" e quiosque) existentes na propriedade do primeiro demandado, localizada na rua Jacarezinho em Balneário Rosa dos Ventos, Itapoá/SC, com a reparação da área degradada e a condenação dos réus ao pagamento de indenização pelo dano causado ao meio ambiente. Requereu, ainda, que os entes públicos, dentro das atribuições afetas ao seu poder de polícia administrativa, adotem as medidas necessárias à preservação da área', '172929667418', '2019-05-02 20:03:06', '2019-05-02 20:03:06'),
(286, 3, 4, '5009025-64.2019.4.04.7201', 'Usucapião. MARIELA DAS GRACAS PIERUCCINI DELGOBBO', 'undefined', 'undefined', '2019-05-02 20:56:09', '2019-05-02 20:56:09'),
(287, 3, 4, '5001486-26.2019.4.04.7208', 'Usucapião. JOCELMO SANTOS', 'undefined', 'undefined', '2019-05-02 21:10:48', '2019-05-02 21:10:48'),
(288, 8, 4, '5049144-59.2017.4.04.7000', 'EMBARGOS À EXECUÇÃO FISCAL Nº 5049144-59.2017.4.04.7000/PR', 'Trata-se de embargos á execução fiscal em que a embargante visa\r\ndesconstituir as certidões de dívida ativa 9061400161002, 9061101856050, 9061600066666,\r\nreferentes a taxa de ocupação do RIP 8041.0000434-60 no período de 1988 a 2013 e a\r\ncertidão de dívida ativa 9061600066747 referente a taxa de ocupação do RIP 8245.0000178-\r\n05 no período de 2009 a 2013.', 'undefined', '2019-05-03 12:46:03', '2019-05-03 12:46:03'),
(289, 3, 4, '5000344-02.2010.4.04.7208', 'Nulidade de Processo de Demarcação. s RIP\'s 8265.0000221-02, 8265.0000222-85 e 8265.0000762-96', 'undefined', 'undefined', '2019-05-03 14:13:29', '2019-05-03 14:13:29'),
(290, 3, 4, '5004123-81.2018.4.04.7208', 'Revisão do valor cobrado a título de taxa de ocupação RIP n° 8161.0000769-12 e 8161.0000773-07', 'undefined', '231573566918', '2019-05-03 17:08:58', '2019-05-03 17:08:58'),
(291, 2, 1, '5000828-93.2019.4.04.7210', 'Dano Ambiental. Rio Uruguai, Município de Mondaí/SC', 'o desfazimento da edificação na área de preservação permanente marginal ao Rio Uruguai, na propriedade deste, localizada na Linha Mondaizinho, interior do Município de Mondaí/SC, matriculada no Cartório de Registro de Imóveis da Comarca de Mondaí, SC, sob n. 2.326, bem como a retirada de todos os equipamentos que alteram aquela área e impedem a sua regeneração natural', '125152241919', '2019-05-03 17:59:47', '2019-05-03 17:59:47'),
(292, 3, 1, '0302403-80.2017.8.24.0048', 'RIP ns. 8245.0100030-33 e 8245.0100031-14', 'Ação de obrigação de fazer visando a regularização dos imóveis junto à SPU, bem como a condenação do réu em indenização por dano.', 'undefined', '2019-05-03 18:19:25', '2019-05-03 18:19:25'),
(293, 6, 1, '0169/2017-4', 'ocupação irregular.  Estrada Geral de acesso ao Balneário Figueirinha, em Jaguaruna/SC', 'undefined', 'undefined', '2019-05-03 18:41:39', '2019-05-03 18:41:39'),
(294, 1, 1, '1.33.005.000307/2017-75', 'undefined', 'Ilha dos Herdeiros, com RIP 83190000094-60, R!P 83190000181-08, RIP 83190000186-12 e RIP 83190000505-08', 'undefined', '2019-05-06 11:51:14', '2019-05-06 11:51:14'),
(295, 1, 1, '1.33.000.000165/2016-51', 'Despejo de efluentes não tratados na rede pluvial. Praia do Campeche,', 'undefined', 'undefined', '2019-05-06 14:03:27', '2019-05-06 14:03:27'),
(296, 1, 1, '1.33.007.000250/2018-11', 'undefined', 'Ação de Retificação de Registro Imobiliário n. 0300068-51.2019.8.24.0167, por Beatriz Albano de Abreu, para retificação da área constante da matrícula n. 4.072 do Registro de Imóveis da Comarca de Garopaba/SC, para que conste a área de 3.450 m²m em razão do erro material na sentença proferida nos autos n. 0000025-57.2000.8.24.0167', 'undefined', '2019-05-06 14:17:59', '2019-05-06 14:17:59'),
(297, 2, 4, '5011128-18.2017.4.04.7200', 'Zona Costeira da Parte Continental. Florianópolis.', 'Identificação, a delimitação e a caracterização jurídica e técnica de todas as intervenções ilegais efetuadas sobre bens da União na Zona Costeira da Parte Continental. Florianópolis.', '167898315517', '2019-05-06 17:31:27', '2019-05-06 17:31:27'),
(298, 3, 2, '0001371-08.2012.8.24.0075', 'Usucapião', 'Município de Pedras Grandes/SC', 'undefined', '2019-05-07 12:36:31', '2019-05-07 12:36:31'),
(299, 3, 3, '84.00.23567-3', 'Desapropriação em nome da União.', 'undefined', 'undefined', '2019-05-07 13:07:24', '2019-05-07 13:07:24'),
(300, 1, 1, '1.33.005.000072/2014-14', 'Edificação realizada por Eliezer Flores Dias, Avenida Atlântica, Balneário Saí Mirim, Itapoá/SC', 'undefined', 'undefined', '2019-05-07 13:07:43', '2019-05-07 13:07:43'),
(301, 3, 1, '82.00.17502-2', 'Desapropriação de imóvel em nome da União.', 'undefined', 'undefined', '2019-05-07 13:30:14', '2019-05-07 13:30:14'),
(302, 1, 1, '1.33.005.000375/2016-07', 'Ocupação Irregular - Gleydis Elisabeth Favero - Balneário Princesa do Mar- Itapoá', 'undefined', 'undefined', '2019-05-07 14:14:17', '2019-05-07 14:14:17'),
(303, 1, 1, '1.33.005.000844/2016-80', 'Irregularidades no bairro Guanabara, Joinville - Entre as ruas Nacar e dos Cravos', 'undefined', 'undefined', '2019-05-07 16:16:24', '2019-05-07 16:16:24'),
(304, 1, 1, '1.33.005.000925/2016-80', 'Possível invasão em APP, rua Natanael Amorim Vieira, Bairro Paranaguamirim, Joinville', 'procedimento instaurado para apurar possível invasão em área de preservação permanente, na rua Natanael Amorim Vieira, Bairro Paranaguamirim, particularmente sobre o caso em tela, localizado no ponto de coordenadas 7083242/ 722641, conforme informado no Boletim de Fiscalização nº 006472 da Secretaria do Meio Ambiente da Prefeitura Municipal de Joinville/SC', 'undefined', '2019-05-07 16:24:18', '2019-05-07 16:24:18'),
(305, 1, 1, '1.33.005.000325/2016-11', 'Regularidades em 3 loteamentos no Município de Itapoá', 'descrição referentes às áreas geograficamente apontadas  (Loteamento01:  26°04\'34.04\"S,  48°36\'39.94\"0;  Loteamento  02:  26°04\'24.90\"S,  48°36\'09.82\"0;  Loteamento  03:  26°03\'54.40\"S,  48°36\'39.95\"O),  notadamentese  estas  pertencem  à  União   e  se  abrangem   terras   de  marinha   e  seusacrecidos;(ii)   em  caso  de  resposta  afirmativa  em  relação  ao item  anterior  (i),   sejainformado  se há  registros  de  ocupações  regulares  na área  perante  a  SPU equem  é/são o(s) titular(es);(iii)  em  caso  de  resposta  negativa  em  relação  ao  item  (i),   se  a  SPU foinotificada  pelo  Município  de  Itapoá   ou  por  outra  fonte  a  respeito  deeventuais  ocupações irregulares das citadas  áreas', 'undefined', '2019-05-07 16:57:00', '2019-05-07 16:57:00'),
(307, 7, 4, '5015010720-78.2018.4.04.7107', 'embargos à execução fiscal', 'embargos à execução fiscal nº 5015010720-78.2018.4.04.7107 (chave eletrônica do\r\nprocesso 203975010318) no qual o contribuinte questiona a dívida inscrita sob o nº 0061600096337 e 0061602101508. Dentre\r\noutros argumentos, a parte embargante suscitou a nulidade da inscrição por suposta ausência de notificação do lançamento.', '203975010318', '2019-05-07 16:58:58', '2019-05-07 16:58:58'),
(312, 1, 1, '1.33.005.000088/2011-84', 'Av. Principal, sn - Pontal da Figueira - Itapoá', 'undefined', 'undefined', '2019-05-07 17:14:06', '2019-05-07 17:14:06'),
(313, 9, 4, '5002607-47.2018.4.04.7201', 'HACASA ADMINISTRACAO E EMPREENDIMENTOS IMOBILIARIOS S/A 8179.0001357-09, 8179.0001365-19, 8179.0003251-68, 8179.0003530-21, 8179.0100144-40 e 8179.000', 'Suspensão de débitos inscritos em DAU, sob o fundamento de que apresentou impugnação administra)va referente aos RIP\'s 8179.0001357-09, 8179.0001365-19, 8179.0003251-68, 8179.0003530-21, 8179.0100144-40 e 8179.0003254-00.', '494234428918', '2019-05-07 17:26:24', '2019-05-07 17:26:24'),
(314, 3, 4, '5000704-98.2019.4.04.7214', 'USUCAPIÃO.  ADILSON DOS SANTOS', NULL, '923881140019', '2019-05-07 17:44:07', '2019-05-07 17:44:07'),
(315, 3, 4, '5015095-37.2018.4.04.7200', 'Usucapião. GENESIO JORGE DOS SANTOS', 'undefined', '178657228818', '2019-05-07 17:59:27', '2019-05-07 17:59:27'),
(316, 3, 4, '5000965-57.2019.4.04.7216', 'Usucapião. CLAUDIA JULIANA OCHS MACIE', 'undefined', '247445992919', '2019-05-07 18:46:26', '2019-05-07 18:47:15'),
(317, 3, 3, '5007982-59.2014.4.04.7204', 'Ação de Interdito Proibitório. loteamento Miramar Zona Velha, Avenida Waldemar Carlos Petrini, no município de Balneário Rincão/SC', 'undefined', 'undefined', '2019-05-07 19:58:20', '2019-05-07 19:58:20'),
(318, 3, 4, '5004183-44.2019.4.04.7200', 'Usucapião. Marcia Firmina Goulart', 'undefined', '405760876719', '2019-05-07 20:27:29', '2019-05-07 20:27:29'),
(319, 6, 1, '0029/2019-4 - SR/PF/SC', 'undefined', 'Imóvel localizado entre as ruas Antenor Borges e a esquina Vasco de Oliveira Gondin, em Canasvieiras, Florianópolois/SC.', 'undefined', '2019-05-08 12:04:25', '2019-05-08 12:04:25'),
(320, 1, 1, '1.33.005.000096/2016-35', 'undefined', 'Balneário Barra do Sul - Imóvel na Rua Camilo de Oliveira.', 'undefined', '2019-05-08 12:16:12', '2019-05-08 12:16:12'),
(321, 5, 1, '06.2013.00005891-0', 'undefined', 'Prestar os seguintes esclarecimentos: a) se as áreas atualmente ocupadas pela Locadora de DVD\'s e Ketty Lanches (Praça Vereador Halley Capanema), pelo Ney Lanches (Avenida Governador Celso Ramos) e pela ME Bar e Lanchonete (Praça Cel. Serafim da Silva Matos) se encontram em terrenos de marinha; b) e, em caso positivo, se existe procedimento de cessão de uso referente as áreas descritas no item anterior.', 'undefined', '2019-05-08 12:33:38', '2019-05-08 12:33:38'),
(323, 5, 1, '06.2019.00000608-0', 'undefined', 'Imóvel em Joinville/SC.', 'undefined', '2019-05-08 16:59:56', '2019-05-08 16:59:56'),
(324, 3, 4, '5005406-17.2019.4.04.7205', 'Usucapião.  LUCIA DE MATOS', 'undefined', 'undefined', '2019-05-08 17:29:07', '2019-05-08 17:29:07'),
(325, 3, 4, '5000203-46.2011.4.04.7208', 'Anulação do Processo Demarcatório. Balneário Camboriú', 'Ação ordinária visando anular a inscrição dos terrenos do autores como de marinha, tornando inexigível a cobrança de laudêmio/taxa de ocupação, com repetição dos valores pagos', 'undefined', '2019-05-08 17:54:17', '2019-05-08 17:54:17'),
(326, 9, 4, '5017860-78.2018.4.04.7200', 'Nulidade do aumento da taxa de Ocupação. RIP 8039.0002024-00 E 8039.0002612-53', 'undefined', 'undefined', '2019-05-08 18:44:20', '2019-05-08 18:44:20'),
(327, 4, 1, '1.33.008.000537/2018-31', 'undefined', 'Imóvel localizado na Rua José Medeiros Vieira, 1538, Praia Brava, Itajaí/SC', 'undefined', '2019-05-09 12:49:30', '2019-05-09 12:49:30'),
(328, 1, 1, '1.33.000.000326/2017-97', 'undefined', 'Projeto Orla e o gerenciamento costeiro, em Florianópolis -  Barra da Lagoa da Conceição.', 'undefined', '2019-05-09 13:11:42', '2019-05-09 13:11:42'),
(329, 3, 4, '5002024-07.2019.4.04.7208', 'Usucapião. Felix Felipe Euflorzinho', 'undefined', 'undefined', '2019-05-09 13:41:08', '2019-05-09 13:41:08'),
(330, 2, 1, '5002226-60.2019.4.04.7215', 'Dano Ambiental.  Parque Nacional da Serra do Itajaí', 'Demolição de obras e à completa recuperação ambiental de área localizada na Zona de Amortecimento do Parque Nacional da Serra do Itajaí', 'undefined', '2019-05-09 16:52:11', '2019-05-09 16:52:11'),
(331, 3, 4, '5009330-48.2019.4.04.7201', 'Laudêmio. RIP 8041.0000499-06', 'ação ajuizada sob o procedimento comum por Edson José Jacobi em face da União visando ao reconhecimento da decadência do direito da União ao lançamento de laudêmio, à declaração de nulidade do lançamento de laudêmio, à determinação para que o cálculo do laudêmio se dê sobre o valor da avaliação do terreno de marinha, à determinação para que a União se abstenha de inscrever o nome do autor em cadastros de proteção ao crédito e de executar o referido crédito, bem como continue a lhe fornecer certidão negativa de débito', '142364079219', '2019-05-09 20:01:27', '2019-05-09 20:01:27'),
(332, 9, 4, '5013737-37.2018.4.04.7200', 'LUIZ ROBERTO OSSANI MENDONCA -', 'Concluir a análise dos pedidos de  averbação de transferência  n. 04972.004186/2009-86,protocolizado   em   16/10/2009,   e   dos   pedidos   de   outorga   gratuita   de   aforamentons.   04972.007791/2013-95   e   04972.207127/2015-14,', '509796007218', '2019-05-10 18:59:25', '2019-05-10 18:59:25'),
(333, 9, 4, '5010405-28.2019.4.04.7200', 'ALTAMIRO ROGÉRIO PHILIPPI E OUTROS. Ação contra decisão que indeferiu pedido de cancelamento de débitos de laudêmio por prescrição', 'undefined', '565402628519', '2019-05-13 20:33:19', '2019-05-13 20:33:19'),
(334, 3, 1, '189.09.000472-5', 'Usucapião', 'o imóvel está situado em local próximo à rodovia municipal PGR-104, no município de Praia Grande/SC.', 'undefined', '2019-05-14 11:59:29', '2019-05-14 11:59:29'),
(336, 3, 2, '0043300-44.2008.5.12.0043', 'AÇÃO TRABALHISTA', 'Penhora de imóvel que esteja em nome da empresa Imbituba Empreendimentos e Participações S/A, CNPJ 27.276.211/0001-08', 'undefined', '2019-05-14 12:56:11', '2019-05-14 12:56:11'),
(337, 3, 1, '5000883-65.2019.4.04.7203', 'AÇÃO DE RETIFICAÇÃO DE ÁREA E REGISTRO', 'undefined', 'undefined', '2019-05-14 17:02:45', '2019-05-14 17:02:45'),
(338, 3, 4, '5010572-26.2011.4.04.7200', 'Usucapião Federal.Mandarim Comercio de Peças e Acessórios Ltda', 'undefined', '712838609311', '2019-05-14 17:14:03', '2019-05-14 17:14:03'),
(339, 9, 4, '5010278-90.2019.4.04.7200', 'Multa de Transferência. RIP 8105.0002093-93', 'undefined', ': 666855601819', '2019-05-14 17:44:31', '2019-05-14 17:44:31'),
(341, 3, 4, '5009765-25.2019.4.04.7200', 'Ação de Inventário. RIP 8105.0001110-75', 'SUBSÍDIOS DE FATO E DE DIREITO para a defesa da União, especialmente se é necessário processo judicial de arrolamento para a transferência da ocupação RIP nº 8105.0001110-75 para a requerente', 'undefined', '2019-05-14 18:33:08', '2019-05-14 18:33:08'),
(342, 1, 1, '1.33.001.000535/2017-21', 'undefined', 'Regularidade do empreendimento \"Spazio Bauhaus\" - localizado na Rua Heinrich Hemmer, n° 1900, Bairro Badenfurt, município de Blumenau.', 'undefined', '2019-05-15 12:26:42', '2019-05-15 12:26:42'),
(343, 1, 1, '1.33.008.000015/2018-39', 'undefined', 'Regularidade da posse exercida nos lotes 4, 5, 6, 8, 11/12 e 20/21, do Loteamento Jardim das Gaivotas, no Município de Itapema.', 'undefined', '2019-05-15 12:42:39', '2019-05-15 12:42:39'),
(344, 2, 1, '5010110-88.2019.4.04.7200', 'Construção de Antena. Praia da Galheta . Florianópolis', 'Suspender a execução do Contrato nº CT-01071/2018/SSP-FUMPOM, de construção de Torre de Rádio, na Rod. Jorn. Manoel de Menezes - SC-406, próxima ao reservatório da CASAN, no morro da Praia da Galheta, bairro Lagoa da Conceição, Florianópolis/SC', '691005818119', '2019-05-15 13:53:26', '2019-05-15 13:53:26'),
(345, 1, 1, '1.33.000.000002/2007-87', 'Demolição de trapiche em Coqueiros, Florianópolis/SC - LR Amorim Administradora de Bens LTDA', 'undefined', 'undefined', '2019-05-15 18:52:19', '2019-05-15 18:52:19'),
(346, 8, 1, '1.33.005.000788/2018-45', 'Supostas fraudes em ações de Usucapião no Município de Barra Velha', 'undefined', 'undefined', '2019-05-15 19:01:40', '2019-05-15 19:01:40'),
(347, 2, 3, '5014056-83.2015.4.04.7208', 'DANO AMBIENTAL', 'recuperação ambiental da área tida como APP, em local denominado Canto do Morcego, Praia Brava, no Município de\r\nItajaí', '386195764815', '2019-05-16 12:50:53', '2019-05-16 12:50:53'),
(348, 3, 4, '5012648-23.2016.4.04.7208', 'Isenção de Taxa', 'undefined', 'undefined', '2019-05-16 13:01:09', '2019-05-16 13:01:09'),
(351, 3, 4, '5003297-89.2017.4.04.7208/SC', 'undefined', 'Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-16 18:23:12', '2019-05-16 18:23:12'),
(352, 3, 4, '5003816-64.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC.', 'undefined', '2019-05-16 18:26:35', '2019-05-16 18:26:35'),
(353, 3, 4, '5003295-22.2017.4.04.7208/SC', 'undefined', 'à prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-16 18:29:03', '2019-05-16 18:29:03'),
(355, 3, 4, '5003801-95.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-16 18:31:29', '2019-05-16 18:31:29'),
(356, 3, 4, '5005666-56.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/S', 'undefined', '2019-05-16 18:34:52', '2019-05-16 18:34:52'),
(357, 3, 4, '5003271-91.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-16 18:37:42', '2019-05-16 18:37:42'),
(358, 3, 4, '5003276-16.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-16 18:40:09', '2019-05-16 18:40:09'),
(359, 1, 1, '1.33.000.001630/2014-17', 'Apura possíveis danos ambientais provocados por construções em APP na Praia do Matadeiro, Florianópolis/SC', 'Apura possíveis danos ambientais provocados por construções em APP na Praia do Matadeiro, Florianópolis/SC', 'undefined', '2019-05-16 20:31:00', '2019-05-16 20:31:00'),
(360, 2, 1, '5014152-88.2016.4.04.7200', 'Enseada do Brito, na Palhoça/SC', 'Proposta pelo Ministério Público Federal contra Manoel Carvalho e Outros, tendo por objeto possível terreno de marinha na Enseada do Brito, na Palhoça/SC, que está sendo ambientalmente danificada pelo réu. O objeto da ação, portanto, é a recuperação do meio ambiente', '595891167616', '2019-05-17 13:37:02', '2019-05-17 13:37:02'),
(361, 3, 4, '5019483-17.2017.4.04.7200', 'Usucapião.Passagem do Massiambú, Palhoça/SC', 'undefined', '223986228917', '2019-05-17 14:28:11', '2019-05-17 14:28:11'),
(362, 3, 4, '5004092-27.2019.4.04.7208', 'AÇÃO ANULATÓRIA DE PROCESSO DE DEMARCAÇÃO. ITAJAÍ', 'undefined', '159470983319', '2019-05-17 17:17:28', '2019-05-17 17:17:28'),
(364, 3, 4, '0000503-21.2007.8.24.0167', 'Usucapião. Garopaba', 'undefined', 'undefined', '2019-05-17 18:13:02', '2019-05-17 18:13:02'),
(365, 3, 4, '5003285-75.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-17 18:42:26', '2019-05-17 18:42:26'),
(366, 3, 4, '5003299-59.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:16:35', '2019-05-20 12:16:35'),
(367, 3, 4, '5003287-45.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 12:20:15', '2019-05-20 12:20:15'),
(368, 3, 4, '5003573-23.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:22:28', '2019-05-20 12:22:28'),
(369, 3, 4, '5003570-68.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:53:58', '2019-05-20 12:53:58'),
(370, 3, 4, '5003563-76.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 12:55:48', '2019-05-20 12:55:48'),
(371, 3, 4, '5003808-87.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 12:59:01', '2019-05-20 12:59:01'),
(372, 3, 4, '5003813-12.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 13:09:42', '2019-05-20 13:09:42'),
(374, 3, 4, '5003814-94.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 13:11:57', '2019-05-20 13:11:57'),
(375, 3, 4, '5004340-61.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de Tijucas/SC', 'undefined', '2019-05-20 13:13:43', '2019-05-20 13:13:43'),
(376, 3, 4, '5003273-61.2017.4.04.7208/SC', 'undefined', 'prorrogação do prazo para a entrega dos títulos aos beneficiários finais, do Conjunto Habitacional Ernesto Che Guevara, localizado na cidade de\nTijucas/SC', 'undefined', '2019-05-20 13:15:40', '2019-05-20 13:15:40'),
(377, 3, 3, '5024465-74.2017.4.04.7200', 'Ação Demolitória. Campeche. Florianópolis', 'Ação Demolitória. Campeche. Florianópolis', 'undefined', '2019-05-20 14:12:04', '2019-05-20 14:12:04'),
(378, 3, 4, '5000408-70.2019.4.04.7216', 'Usucapião. JOSE ALCEBIADES DA SILVA', 'undefined', '725969139919', '2019-05-20 16:37:01', '2019-05-20 16:37:01'),
(379, 3, 4, '5001421-74.2014.4.04.7218', 'Interdito Proibitório. Araquari', 'Ação de Interdito Proibitório nº 5001421-74.2014.4.04.7218, proposta por Alex Sandro de França, em face da União, em trâmite na Sexta Vara Federal da Subseção Judiciária de Joinville, Seção Judiciária de Santa Catarina, tendo por objeto, em apertado resumo, inclusive liminarmente, buscando uma ordem liminar para que a ré se abstenha de turbar sua posse em relação ao imóvel localizado na Rua João Pessoa, s/nº, poste 1, Centro, Araquari/SC', 'undefined', '2019-05-20 18:16:19', '2019-05-20 18:17:40'),
(380, 3, 3, '5017705-05.2014.4.04.7204', 'Reintegração de Posse.Rua Campos Elíseos, s/n, Bairro Coloninha, Orleans/SC', 'Cumprimento de sentença movido pela União em face de Feliciano Barbosa Dias, com objetivo de obter a reintegração na posse do imóvel \"localizado na Rua Campos Elíseos, s/n, Bairro Coloninha, Orleans/SC, com área de 171,30 m², e DETERMINAR a reintegração da Rede Ferroviária Federal - RFFSA (sucedida pela União) na posse do imóvel\".', '591884905814', '2019-05-20 19:24:27', '2019-05-20 19:24:27'),
(381, 3, 4, '5001655-57.2012.4.04.7208', 'Nulidade de Processo Demarcatório. Condomínio Vivaldi. Itapema', 'Ação ordinária, na qual o autor, CONDOMÍNIO RESIDENCIAL VIVALDI busca provimento jurisdicional para o fim anular as inscrições de ocupação e a cobrança de taxas de ocupação, laudêmios e multas de transferência.', 'undefined', '2019-05-21 14:28:36', '2019-05-21 14:28:36'),
(382, 3, 4, '5001241-30.2010.4.04.7208', 'inexistência de obrigação de pagar o laudêmio e multa por atraso na transferência. Balneário Camboriú', 'Objetiva seja declarada a inexistência de obrigação de pagar o laudêmio e multa por atraso na transferência de imóvel sob o regime de ocupação.', 'undefined', '2019-05-21 16:54:58', '2019-05-21 16:54:58'),
(383, 1, 2, '1.33.005.000184/2016-07', 'undefined', 'Verificar regularidade e interferência da área com bem da União, casa e trapiche, localizadas na Rua José Dobrotinick, esquina com a Avenida Lindolfo de Freitas Ledoux (coordenadas: 26°14\'50.53\"S/48°4228.081D)', 'undefined', '2019-05-21 18:19:10', '2019-05-21 18:19:10'),
(384, 3, 4, '5001558-28.2019.4.04.7203', 'Declarar nula a Matrícula nº 23.313, do Cartório do Registro de Imóveis do 1º Ofício da Comarca de Joaçaba.', 'undefined', '608358385119', '2019-05-21 18:19:24', '2019-05-21 18:19:24'),
(386, 3, 4, '5000642-64.2019.4.04.7212', 'USUCAPIÃO.  Linha Sede Floresta, Distrito de Caraíba, Seara/SC', 'undefined', 'undefined', '2019-05-21 18:46:11', '2019-05-21 18:46:11'),
(387, 2, 3, '5009822-82.2015.4.04.7200', 'Marina. Clube Náutico Sainth Barth. Cacupé. Florianópolis', 'Construção de uma Marina. Clube Náutico Sainth Barth. Cacupé. Florianópolis', 'undefined', '2019-05-21 20:35:24', '2019-05-21 20:35:24'),
(388, 1, 4, '1.33.005.000924/2016-35', 'undefined', 'quanto à eventual concessão de registro de ocupação em nome de José Vanderlei dos Santos, CPF n°. 603.484.709-59 - atividade de carcinicultura.', 'undefined', '2019-05-22 12:03:55', '2019-05-22 12:03:55'),
(392, 3, 2, '5008368-43.2015.4.04.7208', 'Ação demolitória', 'Limitação administrativa - imóvel localizado na Av. Aroeira da Praia, Mariscal, ao lado do n. 1527 - Bombinhas/SC', '264432311616', '2019-05-22 17:29:53', '2019-05-22 17:29:53'),
(393, 3, 4, '5002149-72.2019.4.04.7208', 'Valor da taxa de ocupação- RIP 8265.0000568-56', 'undefined', 'undefined', '2019-05-22 17:47:55', '2019-05-22 17:47:55'),
(394, 3, 2, '5000800-37.2019.4.04.7207', 'REINTEGRAÇÃO DE POSSE', 'Informar eventual interesse da União na lide - Jaguaruna.', 'undefined', '2019-05-23 18:02:15', '2019-05-23 18:02:15'),
(395, 7, 4, '5045111-40.2018.4.04.0000', 'Cessão de Uso. Trapiche. Clube Náutico Saint Barth. 8105.00417.500-0', 'Trata-se de agravo de instrumento interposto por CLUBE NÁUTICO SAINT BARTH em face de decisão que conheceu em parte da exceção de pré-executividade oposta e, na parte conhecida, rejeitou as alegações de ocorrência de prescrição e decadência.', 'undefined', '2019-05-23 18:33:07', '2019-05-23 18:33:07'),
(396, 2, 2, '2000.72.00.005294-8', 'undefined', 'Embargos de Obras', 'undefined', '2019-05-23 19:25:29', '2019-05-23 19:25:29'),
(397, 1, 2, '1.33.000.001271/2018-13', 'Construção irregular e supressão de vegetação', 'Costa da Lagoa, n° 47 - Florianópolis/SC', 'undefined', '2019-05-24 12:28:48', '2019-05-24 12:28:48'),
(400, 1, 1, '1.33.005.000308/2013-31', 'Ilha do Corisco - Baía da Babitonga', 'undefined', 'undefined', '2019-05-24 18:02:06', '2019-05-24 18:02:06'),
(401, 1, 1, '1.33.005.000062/2015-60', 'Nestor Domingo Roque Féssia - Barra Velha/SC', 'undefined', 'undefined', '2019-05-24 18:12:23', '2019-05-24 18:12:23'),
(402, 1, 1, '1.33.005.000343/2017-84', 'José Loureiro I e II - Bairro Ulysses Guimarães - Joinville', 'undefined', 'undefined', '2019-05-24 19:15:58', '2019-05-24 19:15:58'),
(403, 1, 1, '1.33.005.000181/2017-84', 'Ocupação no loteamento José Loureiro II - Bairro Ulysses Guimarães - Joinville/SC', 'Ocupações irregulares no loteamento José Loureiro II, bairro Ulysses Guimarães.', 'undefined', '2019-05-24 19:47:05', '2019-05-24 19:47:05');

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
(2, 'Em análise', NULL, NULL),
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
(1, 'Ofício', NULL, NULL),
(2, 'E-mail', NULL, NULL),
(3, 'Memorando', NULL, NULL),
(4, 'Ofício', NULL, NULL),
(5, 'Carta', NULL, NULL),
(6, 'Outros', NULL, NULL),
(7, 'Recomendação', NULL, NULL),
(8, 'Mandado de Notificação', NULL, NULL),
(9, 'Mandado de Intimação', NULL, NULL);

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
(1, 'Inquérito Civil', NULL, NULL),
(2, 'Ação Civil Pública', NULL, NULL),
(3, 'Processo Judicial', NULL, NULL),
(4, 'Notícia de Fato', NULL, NULL),
(5, 'Procedimento MPSC', NULL, NULL),
(6, 'Inquérito Policial', NULL, NULL),
(7, 'Execução Fiscal', NULL, NULL),
(8, 'Outros', NULL, NULL),
(9, 'Mandado de Segurança', NULL, NULL);

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
(1, 'Alysson Marques', 'alyssonmarques@gmail.com', '00715334948', '$2y$10$q/o2Z1BdMKvt3bqb.A3i2.nsImp8yRQKDM4wLEJpEkEUtM0Fa1xvW', 'kNKpEvkxhIN7FVr4L6ylaA1or7CmmycDqsRba2omC2FnbrCrUDZSOhYmkmrX', '2019-01-22 21:55:15', '2019-05-24 17:27:11', '(48)3224-5399'),
(3, 'Niarcos Wall Thomaz de Almeida', 'niarcos.almeida@planejamento.gov.br', '02338607970', '$2y$10$3eQuMVjOSJw6bYVhoZIvQuAz696A2CtFiN9Q/HsZKS9WZIznI6qkq', '3zpwByynLWsVv4SXRq84QFXlwXHkHgEZRQVYLmKD3ma83MWTxRqTjKAbKvca', '2019-03-07 12:45:54', '2019-05-24 18:09:15', '(48)3224-5399'),
(4, 'RAFAEL NASCIMENTO MONTEMOR', 'rafael.montemor@planejamento.gov.br', '02794094947', '$2y$10$oqBAzFR4W4AT/SLszAph0eJLvbOMmh7CMdHudE3RcXeB0RgGXOWtm', 'TIb9SGxmAfqXeK8fJB6fpvnU1DGhB3S9QXnWGe5LqsAH3P6La3i14G86JDni', '2019-03-07 12:57:21', '2019-05-24 17:55:20', '(48)3224-5399'),
(5, 'Juliano Luiz Pinzetta', 'juliano.pinzetta@planejamento.gov.br', '03760336906', '$2y$10$1hHxoFnNJAQq8I0rcEOLTu5iVvXZqBY8ovqi.2M27oN2g/eJ6kSG2', NULL, '2019-03-07 12:59:35', '2019-05-24 20:27:11', '(48)3224-5399'),
(8, 'Robson Castanho', 'robson.castanho@planejamento.gov.br', '69200033172', '$2y$10$d3yfyaODTNt98TkuwSLb6.Iw8OM40sve24Ncqu4Qrk3ShTzgwmwsu', NULL, '2019-03-12 14:16:19', '2019-05-24 12:26:34', '(48)3224-5399'),
(9, 'Sistema', 'assessoria.spu.sc@planejamento.gov.br', '', 'aaaaaa', NULL, NULL, NULL, NULL),
(10, 'Camila Porto Fasolo', 'camila.fasolo@planejamento.gov.br', '05309676937', '$2y$10$3vkErfEicBc6nZ5cJpa6Ge0O30iq9ErRLV9S0lS4FYDafE.Ty6xOq', 'CwyOz8hQtlyFRu9tE6fK3K7RRMfXx9s8Zq400YlMEcrnIa83qd4pBKX8J3mC', '2019-03-18 14:20:23', '2019-05-09 20:43:16', '(48)3223-1596'),
(13, 'Manglio Ortiz de Almeida', 'manglio.almeida@planejamento.gov.br', '64447960087', '$2y$10$n9U1yNMV5AX9zL8N0Al4eeW232Zj7nGDki4nmtFALAp2T1gC87.Mi', 'BU5Nv8enfpF10V6XkMjg5j4Rizj7VYPWIqNzNdILUYv0tAlN3YFPDrWMd481', '2019-04-01 14:33:40', '2019-05-24 19:19:48', '(48)999259910'),
(14, 'Luiz Carlos da Costa', 'luiz.carlos@planejamento.gov.br', '76822150978', '$2y$10$Lgnv1WrIu3Nm.G5H1RTpaO.sotm7k0nZzbV9IC3DRp7EUGLjPvIGy', NULL, '2019-05-08 12:57:21', '2019-05-08 12:57:21', '(48)3224-5399'),
(15, 'Nildo Azevedo', 'nildo.azevedo@planejamento.gov.br', '48499234968', '$2y$10$hpd62gm/.1aHvnc75WNIm.MBs7xayeCFZfLzqRiOFBgF3LOuvjWfW', NULL, '2019-05-10 16:16:33', '2019-05-10 16:16:33', '(61)2020-1457');

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
(20, NULL, NULL, 13, 3);

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
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orgao`
--
ALTER TABLE `orgao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orgao_idorgaopai_foreign` (`idOrgaoPai`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=273;

--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `categoriademanda`
--
ALTER TABLE `categoriademanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `demanda`
--
ALTER TABLE `demanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=431;

--
-- AUTO_INCREMENT for table `demandamovimentacao`
--
ALTER TABLE `demandamovimentacao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `distribuicaodemanda`
--
ALTER TABLE `distribuicaodemanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=440;

--
-- AUTO_INCREMENT for table `divisaoorganograma`
--
ALTER TABLE `divisaoorganograma`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `orgao`
--
ALTER TABLE `orgao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `permissao`
--
ALTER TABLE `permissao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `poloprocedimentoexterno`
--
ALTER TABLE `poloprocedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `procedimentoexterno`
--
ALTER TABLE `procedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=404;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `usuariopermissao`
--
ALTER TABLE `usuariopermissao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
-- Limitadores para a tabela `orgao`
--
ALTER TABLE `orgao`
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
