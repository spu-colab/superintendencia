-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 15/06/2020 às 20:13
-- Versão do servidor: 8.0.11
-- Versão do PHP: 7.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS=0;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Estrutura para tabela `atend_assunto`
--

DROP TABLE IF EXISTS `atend_assunto`;
CREATE TABLE `atend_assunto` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `assunto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atend_atendimento`
--

DROP TABLE IF EXISTS `atend_atendimento`;
CREATE TABLE `atend_atendimento` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `idtipo` bigint(20) UNSIGNED NOT NULL,
  `atendido` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dataHoraInicio` datetime NOT NULL,
  `dataHoraFim` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atend_atendimento_atend_assunto`
--

DROP TABLE IF EXISTS `atend_atendimento_atend_assunto`;
CREATE TABLE `atend_atendimento_atend_assunto` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idatendimento` bigint(20) UNSIGNED NOT NULL,
  `idassunto` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atend_comentario`
--

DROP TABLE IF EXISTS `atend_comentario`;
CREATE TABLE `atend_comentario` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idatendimento` bigint(20) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `comentario` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataHora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atend_tipo`
--

DROP TABLE IF EXISTS `atend_tipo`;
CREATE TABLE `atend_tipo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tipo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `autordemanda`
--

DROP TABLE IF EXISTS `autordemanda`;
CREATE TABLE `autordemanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `idOrgao` int(10) UNSIGNED NOT NULL,
  `idCargo` int(10) UNSIGNED NOT NULL,
  `nome` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` char(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_categoria`
--

DROP TABLE IF EXISTS `bens_categoria`;
CREATE TABLE `bens_categoria` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descricao` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idUser` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_conservacao`
--

DROP TABLE IF EXISTS `bens_conservacao`;
CREATE TABLE `bens_conservacao` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descricao` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_levantamento`
--

DROP TABLE IF EXISTS `bens_levantamento`;
CREATE TABLE `bens_levantamento` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descricao` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_patrimonio`
--

DROP TABLE IF EXISTS `bens_patrimonio`;
CREATE TABLE `bens_patrimonio` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` int(11) NOT NULL,
  `descricao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `preco` decimal(8,2) NOT NULL,
  `garantia` date DEFAULT NULL,
  `idSala` bigint(20) UNSIGNED NOT NULL,
  `idCategoria` bigint(20) UNSIGNED NOT NULL,
  `idSituacao` bigint(20) UNSIGNED NOT NULL DEFAULT '4',
  `idDesfazimento` bigint(20) UNSIGNED DEFAULT NULL,
  `idConservacao` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `idLevantamento` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `idUser` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_responsavel`
--

DROP TABLE IF EXISTS `bens_responsavel`;
CREATE TABLE `bens_responsavel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idUserResp` int(10) UNSIGNED NOT NULL,
  `idPatrimonio` bigint(20) UNSIGNED NOT NULL,
  `idUser` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_sala`
--

DROP TABLE IF EXISTS `bens_sala`;
CREATE TABLE `bens_sala` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idDivisaoOrganograma` int(10) UNSIGNED NOT NULL,
  `descricao` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idUser` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_situacao`
--

DROP TABLE IF EXISTS `bens_situacao`;
CREATE TABLE `bens_situacao` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `descricao` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bens_termo_desfazimento`
--

DROP TABLE IF EXISTS `bens_termo_desfazimento`;
CREATE TABLE `bens_termo_desfazimento` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `concluido_em` datetime DEFAULT NULL,
  `destino` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processo` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oficio` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `despacho` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` char(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idUser` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargo`
--

DROP TABLE IF EXISTS `cargo`;
CREATE TABLE `cargo` (
  `id` int(10) UNSIGNED NOT NULL,
  `cargo` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoriademanda`
--

DROP TABLE IF EXISTS `categoriademanda`;
CREATE TABLE `categoriademanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `categoria` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `conteudo`
--

DROP TABLE IF EXISTS `conteudo`;
CREATE TABLE `conteudo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conteudo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `demanda`
--

DROP TABLE IF EXISTS `demanda`;
CREATE TABLE `demanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `idTipoDocumento` int(10) UNSIGNED NOT NULL,
  `documentoExterno` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nupSEI` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seiMP` tinyint(1) NOT NULL DEFAULT '0',
  `demanda` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `resumoSituacao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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

-- --------------------------------------------------------

--
-- Estrutura para tabela `demandamovimentacao`
--

DROP TABLE IF EXISTS `demandamovimentacao`;
CREATE TABLE `demandamovimentacao` (
  `id` int(10) UNSIGNED NOT NULL,
  `idDemanda` int(10) UNSIGNED NOT NULL,
  `idDivisaoOrganogramaOrigem` int(10) UNSIGNED NOT NULL,
  `idDivisaoOrganogramaDestino` int(10) UNSIGNED NOT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `demar_demarcacao`
--

DROP TABLE IF EXISTS `demar_demarcacao`;
CREATE TABLE `demar_demarcacao` (
  `id_demarcacao` bigint(20) UNSIGNED NOT NULL,
  `id_tipodemarcacao` bigint(20) UNSIGNED NOT NULL,
  `id_situacaodemarcacao` bigint(20) UNSIGNED NOT NULL,
  `id_trechodemarcacao` bigint(20) UNSIGNED NOT NULL,
  `processo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtrecho` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lpm_ltm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fonte` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `edital` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `datahomologacao` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `demar_situacaodemarcacao`
--

DROP TABLE IF EXISTS `demar_situacaodemarcacao`;
CREATE TABLE `demar_situacaodemarcacao` (
  `id_situacaodemarcacao` bigint(20) UNSIGNED NOT NULL,
  `situacaodemarcacao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `demar_tipodemarcacao`
--

DROP TABLE IF EXISTS `demar_tipodemarcacao`;
CREATE TABLE `demar_tipodemarcacao` (
  `id_tipodemarcacao` bigint(20) UNSIGNED NOT NULL,
  `tipodemarcacao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `demar_trechodemarcacao`
--

DROP TABLE IF EXISTS `demar_trechodemarcacao`;
CREATE TABLE `demar_trechodemarcacao` (
  `id_trechodemarcacao` bigint(20) UNSIGNED NOT NULL,
  `trechodemarcacao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `distribuicaodemanda`
--

DROP TABLE IF EXISTS `distribuicaodemanda`;
CREATE TABLE `distribuicaodemanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `idDemanda` int(10) UNSIGNED NOT NULL,
  `idUsuarioDe` int(10) UNSIGNED NOT NULL,
  `dataDistribuicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dataAtendimento` timestamp NULL DEFAULT NULL,
  `comentarioDistribuicao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `comentarioAtendimento` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `assignable_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `assignable_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `divisaoorganograma`
--

DROP TABLE IF EXISTS `divisaoorganograma`;
CREATE TABLE `divisaoorganograma` (
  `id` int(10) UNSIGNED NOT NULL,
  `idDivisaoOrganogramaPai` int(10) UNSIGNED DEFAULT NULL,
  `nome` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sigla` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `snSuperintendencia` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `origem` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '{{ORIGEM_PADRAO}}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `geo_camada`
--

DROP TABLE IF EXISTS `geo_camada`;
CREATE TABLE `geo_camada` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rotulo` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tabelaReferencia` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `colunaIdReferencia` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `colunaTituloReferencia` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `colunaSubTituloReferencia` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rotaFrontEnd` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `geo_referencia`
--

DROP TABLE IF EXISTS `geo_referencia`;
CREATE TABLE `geo_referencia` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idCamada` bigint(20) UNSIGNED NOT NULL,
  `idReferenciado` bigint(20) UNSIGNED NOT NULL,
  `poligonais` geometrycollection NOT NULL,
  `idUsuarioCriacao` int(10) UNSIGNED NOT NULL,
  `idUsuarioAlteracao` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_avaliacao`
--

DROP TABLE IF EXISTS `govern_avaliacao`;
CREATE TABLE `govern_avaliacao` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idperiodoavaliacao` bigint(20) UNSIGNED NOT NULL,
  `idmetaespecificaunidade` bigint(20) UNSIGNED NOT NULL,
  `previsto` decimal(14,2) NOT NULL,
  `realizado` decimal(14,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_indicador`
--

DROP TABLE IF EXISTS `govern_indicador`;
CREATE TABLE `govern_indicador` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idunidademedida` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_meta`
--

DROP TABLE IF EXISTS `govern_meta`;
CREATE TABLE `govern_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idplanejamentoestrategico` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_metaespecifica`
--

DROP TABLE IF EXISTS `govern_metaespecifica`;
CREATE TABLE `govern_metaespecifica` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idmeta` bigint(20) UNSIGNED NOT NULL,
  `idindicador` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_metaespecificaunidade`
--

DROP TABLE IF EXISTS `govern_metaespecificaunidade`;
CREATE TABLE `govern_metaespecificaunidade` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idmetaespecifica` bigint(20) UNSIGNED NOT NULL,
  `iddivisaoorganograma` int(10) UNSIGNED NOT NULL,
  `idusuarioresponsavel` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_periodoavaliacao`
--

DROP TABLE IF EXISTS `govern_periodoavaliacao`;
CREATE TABLE `govern_periodoavaliacao` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idplanejamentoestrategico` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date NOT NULL,
  `dataInicioCaptacao` date NOT NULL,
  `dataFimCaptacao` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_planejamentoestrategico`
--

DROP TABLE IF EXISTS `govern_planejamentoestrategico`;
CREATE TABLE `govern_planejamentoestrategico` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `govern_unidademedida`
--

DROP TABLE IF EXISTS `govern_unidademedida`;
CREATE TABLE `govern_unidademedida` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `naturezaorgao`
--

DROP TABLE IF EXISTS `naturezaorgao`;
CREATE TABLE `naturezaorgao` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `natureza` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `orgao`
--

DROP TABLE IF EXISTS `orgao`;
CREATE TABLE `orgao` (
  `id` int(10) UNSIGNED NOT NULL,
  `idOrgaoPai` int(10) UNSIGNED DEFAULT NULL,
  `idNaturezaOrgao` bigint(20) UNSIGNED DEFAULT NULL,
  `orgao` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sigla` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone` char(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissao`
--

DROP TABLE IF EXISTS `permissao`;
CREATE TABLE `permissao` (
  `id` int(10) UNSIGNED NOT NULL,
  `permissao` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `poloprocedimentoexterno`
--

DROP TABLE IF EXISTS `poloprocedimentoexterno`;
CREATE TABLE `poloprocedimentoexterno` (
  `id` int(10) UNSIGNED NOT NULL,
  `polo` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `procedimentoexterno`
--

DROP TABLE IF EXISTS `procedimentoexterno`;
CREATE TABLE `procedimentoexterno` (
  `id` int(10) UNSIGNED NOT NULL,
  `idTipoProcedimentoExterno` int(10) UNSIGNED DEFAULT NULL,
  `idPoloProcedimentoExterno` int(10) UNSIGNED NOT NULL,
  `procedimento` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `resumo` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `chave` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `situacaodemanda`
--

DROP TABLE IF EXISTS `situacaodemanda`;
CREATE TABLE `situacaodemanda` (
  `id` int(10) UNSIGNED NOT NULL,
  `situacao` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipodocumento`
--

DROP TABLE IF EXISTS `tipodocumento`;
CREATE TABLE `tipodocumento` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipodocumento` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipoprocedimentoexterno`
--

DROP TABLE IF EXISTS `tipoprocedimentoexterno`;
CREATE TABLE `tipoprocedimentoexterno` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipoprocedimento` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipoprocesso`
--

DROP TABLE IF EXISTS `tipoprocesso`;
CREATE TABLE `tipoprocesso` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descricao` char(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `origem` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '{{ORIGEM_PADRAO}}',
  `telefone` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuariodivisaoorganograma`
--

DROP TABLE IF EXISTS `usuariodivisaoorganograma`;
CREATE TABLE `usuariodivisaoorganograma` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `idDivisaoOrganograma` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuariopermissao`
--

DROP TABLE IF EXISTS `usuariopermissao`;
CREATE TABLE `usuariopermissao` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `idPermissao` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `atend_assunto`
--
ALTER TABLE `atend_assunto`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `atend_atendimento`
--
ALTER TABLE `atend_atendimento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `atend_atendimento_idusuario_foreign` (`idusuario`),
  ADD KEY `atend_atendimento_idtipo_foreign` (`idtipo`);

--
-- Índices de tabela `atend_atendimento_atend_assunto`
--
ALTER TABLE `atend_atendimento_atend_assunto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `atend_atendimento_atend_assunto_idatendimento_foreign` (`idatendimento`),
  ADD KEY `atend_atendimento_atend_assunto_idassunto_foreign` (`idassunto`);

--
-- Índices de tabela `atend_comentario`
--
ALTER TABLE `atend_comentario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `atend_comentario_idusuario_foreign` (`idusuario`),
  ADD KEY `atend_comentario_idatendimento_foreign` (`idatendimento`);

--
-- Índices de tabela `atend_tipo`
--
ALTER TABLE `atend_tipo`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `autordemanda`
--
ALTER TABLE `autordemanda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autordemanda_idorgao_foreign` (`idOrgao`),
  ADD KEY `autordemanda_idcargo_foreign` (`idCargo`);

--
-- Índices de tabela `bens_categoria`
--
ALTER TABLE `bens_categoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bens_categoria_iduser_foreign` (`idUser`);

--
-- Índices de tabela `bens_conservacao`
--
ALTER TABLE `bens_conservacao`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `bens_levantamento`
--
ALTER TABLE `bens_levantamento`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `bens_patrimonio`
--
ALTER TABLE `bens_patrimonio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bens_patrimonio_codigo_unique` (`codigo`),
  ADD KEY `bens_patrimonio_iduser_foreign` (`idUser`),
  ADD KEY `bens_patrimonio_idsala_foreign` (`idSala`),
  ADD KEY `bens_patrimonio_idcategoria_foreign` (`idCategoria`),
  ADD KEY `bens_patrimonio_idsituacao_foreign` (`idSituacao`),
  ADD KEY `bens_patrimonio_iddesfazimento_foreign` (`idDesfazimento`),
  ADD KEY `bens_patrimonio_idlevantamento_foreign` (`idLevantamento`),
  ADD KEY `bens_patrimonio_idconservacao_foreign` (`idConservacao`);

--
-- Índices de tabela `bens_responsavel`
--
ALTER TABLE `bens_responsavel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bens_responsavel_iduserresp_foreign` (`idUserResp`),
  ADD KEY `bens_responsavel_iduser_foreign` (`idUser`),
  ADD KEY `bens_responsavel_idpatrimonio_foreign` (`idPatrimonio`);

--
-- Índices de tabela `bens_sala`
--
ALTER TABLE `bens_sala`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bens_sala_iddivisaoorganograma_foreign` (`idDivisaoOrganograma`),
  ADD KEY `bens_sala_iduser_foreign` (`idUser`);

--
-- Índices de tabela `bens_situacao`
--
ALTER TABLE `bens_situacao`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `bens_termo_desfazimento`
--
ALTER TABLE `bens_termo_desfazimento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bens_termo_desfazimento_iduser_foreign` (`idUser`);

--
-- Índices de tabela `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `categoriademanda`
--
ALTER TABLE `categoriademanda`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `conteudo`
--
ALTER TABLE `conteudo`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `demanda`
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
-- Índices de tabela `demandamovimentacao`
--
ALTER TABLE `demandamovimentacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `demandamovimentacao_iddemanda_foreign` (`idDemanda`),
  ADD KEY `demandamovimentacao_iddivisaoorganogramaorigem_foreign` (`idDivisaoOrganogramaOrigem`),
  ADD KEY `demandamovimentacao_iddivisaoorganogramadestino_foreign` (`idDivisaoOrganogramaDestino`),
  ADD KEY `demandamovimentacao_idusuario_foreign` (`idUsuario`);

--
-- Índices de tabela `demar_demarcacao`
--
ALTER TABLE `demar_demarcacao`
  ADD PRIMARY KEY (`id_demarcacao`),
  ADD KEY `demar_demarcacao_id_tipodemarcacao_foreign` (`id_tipodemarcacao`),
  ADD KEY `demar_demarcacao_id_situacaodemarcacao_foreign` (`id_situacaodemarcacao`),
  ADD KEY `demar_demarcacao_id_trechodemarcacao_foreign` (`id_trechodemarcacao`);

--
-- Índices de tabela `demar_situacaodemarcacao`
--
ALTER TABLE `demar_situacaodemarcacao`
  ADD PRIMARY KEY (`id_situacaodemarcacao`);

--
-- Índices de tabela `demar_tipodemarcacao`
--
ALTER TABLE `demar_tipodemarcacao`
  ADD PRIMARY KEY (`id_tipodemarcacao`);

--
-- Índices de tabela `demar_trechodemarcacao`
--
ALTER TABLE `demar_trechodemarcacao`
  ADD PRIMARY KEY (`id_trechodemarcacao`);

--
-- Índices de tabela `distribuicaodemanda`
--
ALTER TABLE `distribuicaodemanda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `distribuicaodemanda_iddemanda_foreign` (`idDemanda`),
  ADD KEY `distribuicaodemanda_idusuariode_foreign` (`idUsuarioDe`),
  ADD KEY `distribuicaodemanda_entidadepara_type_entidadepara_id_index` (`assignable_type`,`assignable_id`);

--
-- Índices de tabela `divisaoorganograma`
--
ALTER TABLE `divisaoorganograma`
  ADD PRIMARY KEY (`id`),
  ADD KEY `divisaoorganograma_iddivisaoorganogramapai_foreign` (`idDivisaoOrganogramaPai`);

--
-- Índices de tabela `geo_camada`
--
ALTER TABLE `geo_camada`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `geo_referencia`
--
ALTER TABLE `geo_referencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `geo_referencia_idcamada_foreign` (`idCamada`),
  ADD KEY `geo_referencia_idusuariocriacao_foreign` (`idUsuarioCriacao`),
  ADD KEY `geo_referencia_idusuarioalteracao_foreign` (`idUsuarioAlteracao`);

--
-- Índices de tabela `govern_avaliacao`
--
ALTER TABLE `govern_avaliacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `govern_avaliacao_idperiodoavaliacao_foreign` (`idperiodoavaliacao`),
  ADD KEY `govern_avaliacao_idmetaespecificaunidade_foreign` (`idmetaespecificaunidade`);

--
-- Índices de tabela `govern_indicador`
--
ALTER TABLE `govern_indicador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `govern_indicador_idunidademedida_foreign` (`idunidademedida`);

--
-- Índices de tabela `govern_meta`
--
ALTER TABLE `govern_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `govern_meta_idplanejamentoestrategico_foreign` (`idplanejamentoestrategico`);

--
-- Índices de tabela `govern_metaespecifica`
--
ALTER TABLE `govern_metaespecifica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `govern_metaespecifica_idmeta_foreign` (`idmeta`),
  ADD KEY `govern_metaespecifica_idindicador_foreign` (`idindicador`);

--
-- Índices de tabela `govern_metaespecificaunidade`
--
ALTER TABLE `govern_metaespecificaunidade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `govern_metaespecificaunidade_idmetaespecifica_foreign` (`idmetaespecifica`),
  ADD KEY `govern_metaespecificaunidade_iddivisaoorganograma_foreign` (`iddivisaoorganograma`),
  ADD KEY `govern_metaespecificaunidade_idusuarioresponsavel_foreign` (`idusuarioresponsavel`);

--
-- Índices de tabela `govern_periodoavaliacao`
--
ALTER TABLE `govern_periodoavaliacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `govern_periodoavaliacao_idplanejamentoestrategico_foreign` (`idplanejamentoestrategico`);

--
-- Índices de tabela `govern_planejamentoestrategico`
--
ALTER TABLE `govern_planejamentoestrategico`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `govern_unidademedida`
--
ALTER TABLE `govern_unidademedida`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `naturezaorgao`
--
ALTER TABLE `naturezaorgao`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `orgao`
--
ALTER TABLE `orgao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orgao_idorgaopai_foreign` (`idOrgaoPai`),
  ADD KEY `orgao_idnaturezaorgao_foreign` (`idNaturezaOrgao`);

--
-- Índices de tabela `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Índices de tabela `permissao`
--
ALTER TABLE `permissao`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `poloprocedimentoexterno`
--
ALTER TABLE `poloprocedimentoexterno`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `procedimentoexterno`
--
ALTER TABLE `procedimentoexterno`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `procedimentoexterno_procedimento_unique` (`procedimento`),
  ADD KEY `procedimentoexterno_idtipoprocedimentoexterno_foreign` (`idTipoProcedimentoExterno`),
  ADD KEY `procedimentoexterno_idpoloprocedimentoexterno_foreign` (`idPoloProcedimentoExterno`);

--
-- Índices de tabela `situacaodemanda`
--
ALTER TABLE `situacaodemanda`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tipoprocedimentoexterno`
--
ALTER TABLE `tipoprocedimentoexterno`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tipoprocesso`
--
ALTER TABLE `tipoprocesso`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_cpf_unique` (`cpf`) USING BTREE;

--
-- Índices de tabela `usuariodivisaoorganograma`
--
ALTER TABLE `usuariodivisaoorganograma`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuariodivisaoorganograma_idusuario_foreign` (`idUsuario`),
  ADD KEY `usuariodivisaoorganograma_iddivisaoorganograma_foreign` (`idDivisaoOrganograma`);

--
-- Índices de tabela `usuariopermissao`
--
ALTER TABLE `usuariopermissao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idUsuario` (`idUsuario`,`idPermissao`),
  ADD KEY `usuariopermissao_idpermissao_foreign` (`idPermissao`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `atend_assunto`
--
ALTER TABLE `atend_assunto`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atend_atendimento`
--
ALTER TABLE `atend_atendimento`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atend_atendimento_atend_assunto`
--
ALTER TABLE `atend_atendimento_atend_assunto`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atend_comentario`
--
ALTER TABLE `atend_comentario`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atend_tipo`
--
ALTER TABLE `atend_tipo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `autordemanda`
--
ALTER TABLE `autordemanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_categoria`
--
ALTER TABLE `bens_categoria`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_conservacao`
--
ALTER TABLE `bens_conservacao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_levantamento`
--
ALTER TABLE `bens_levantamento`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_patrimonio`
--
ALTER TABLE `bens_patrimonio`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_responsavel`
--
ALTER TABLE `bens_responsavel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_sala`
--
ALTER TABLE `bens_sala`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_situacao`
--
ALTER TABLE `bens_situacao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bens_termo_desfazimento`
--
ALTER TABLE `bens_termo_desfazimento`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categoriademanda`
--
ALTER TABLE `categoriademanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `conteudo`
--
ALTER TABLE `conteudo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `demanda`
--
ALTER TABLE `demanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `demandamovimentacao`
--
ALTER TABLE `demandamovimentacao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `demar_demarcacao`
--
ALTER TABLE `demar_demarcacao`
  MODIFY `id_demarcacao` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `demar_situacaodemarcacao`
--
ALTER TABLE `demar_situacaodemarcacao`
  MODIFY `id_situacaodemarcacao` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `demar_tipodemarcacao`
--
ALTER TABLE `demar_tipodemarcacao`
  MODIFY `id_tipodemarcacao` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `demar_trechodemarcacao`
--
ALTER TABLE `demar_trechodemarcacao`
  MODIFY `id_trechodemarcacao` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `distribuicaodemanda`
--
ALTER TABLE `distribuicaodemanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `divisaoorganograma`
--
ALTER TABLE `divisaoorganograma`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `geo_camada`
--
ALTER TABLE `geo_camada`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `geo_referencia`
--
ALTER TABLE `geo_referencia`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_avaliacao`
--
ALTER TABLE `govern_avaliacao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_indicador`
--
ALTER TABLE `govern_indicador`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_meta`
--
ALTER TABLE `govern_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_metaespecifica`
--
ALTER TABLE `govern_metaespecifica`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_metaespecificaunidade`
--
ALTER TABLE `govern_metaespecificaunidade`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_periodoavaliacao`
--
ALTER TABLE `govern_periodoavaliacao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_planejamentoestrategico`
--
ALTER TABLE `govern_planejamentoestrategico`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `govern_unidademedida`
--
ALTER TABLE `govern_unidademedida`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `naturezaorgao`
--
ALTER TABLE `naturezaorgao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `orgao`
--
ALTER TABLE `orgao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `permissao`
--
ALTER TABLE `permissao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `poloprocedimentoexterno`
--
ALTER TABLE `poloprocedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `procedimentoexterno`
--
ALTER TABLE `procedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `situacaodemanda`
--
ALTER TABLE `situacaodemanda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipoprocedimentoexterno`
--
ALTER TABLE `tipoprocedimentoexterno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipoprocesso`
--
ALTER TABLE `tipoprocesso`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuariodivisaoorganograma`
--
ALTER TABLE `usuariodivisaoorganograma`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuariopermissao`
--
ALTER TABLE `usuariopermissao`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `atend_atendimento`
--
ALTER TABLE `atend_atendimento`
  ADD CONSTRAINT `atend_atendimento_idtipo_foreign` FOREIGN KEY (`idtipo`) REFERENCES `atend_tipo` (`id`),
  ADD CONSTRAINT `atend_atendimento_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `atend_atendimento_atend_assunto`
--
ALTER TABLE `atend_atendimento_atend_assunto`
  ADD CONSTRAINT `atend_atendimento_atend_assunto_idassunto_foreign` FOREIGN KEY (`idassunto`) REFERENCES `atend_assunto` (`id`),
  ADD CONSTRAINT `atend_atendimento_atend_assunto_idatendimento_foreign` FOREIGN KEY (`idatendimento`) REFERENCES `atend_atendimento` (`id`);

--
-- Restrições para tabelas `atend_comentario`
--
ALTER TABLE `atend_comentario`
  ADD CONSTRAINT `atend_comentario_idatendimento_foreign` FOREIGN KEY (`idatendimento`) REFERENCES `atend_atendimento` (`id`),
  ADD CONSTRAINT `atend_comentario_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `autordemanda`
--
ALTER TABLE `autordemanda`
  ADD CONSTRAINT `autordemanda_idcargo_foreign` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`id`),
  ADD CONSTRAINT `autordemanda_idorgao_foreign` FOREIGN KEY (`idOrgao`) REFERENCES `orgao` (`id`);

--
-- Restrições para tabelas `demanda`
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
-- Restrições para tabelas `demandamovimentacao`
--
ALTER TABLE `demandamovimentacao`
  ADD CONSTRAINT `demandamovimentacao_iddemanda_foreign` FOREIGN KEY (`idDemanda`) REFERENCES `demanda` (`id`),
  ADD CONSTRAINT `demandamovimentacao_iddivisaoorganogramadestino_foreign` FOREIGN KEY (`idDivisaoOrganogramaDestino`) REFERENCES `divisaoorganograma` (`id`),
  ADD CONSTRAINT `demandamovimentacao_iddivisaoorganogramaorigem_foreign` FOREIGN KEY (`idDivisaoOrganogramaOrigem`) REFERENCES `divisaoorganograma` (`id`),
  ADD CONSTRAINT `demandamovimentacao_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `distribuicaodemanda`
--
ALTER TABLE `distribuicaodemanda`
  ADD CONSTRAINT `distribuicaodemanda_iddemanda_foreign` FOREIGN KEY (`idDemanda`) REFERENCES `demanda` (`id`),
  ADD CONSTRAINT `distribuicaodemanda_idusuariode_foreign` FOREIGN KEY (`idUsuarioDe`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `divisaoorganograma`
--
ALTER TABLE `divisaoorganograma`
  ADD CONSTRAINT `divisaoorganograma_iddivisaoorganogramapai_foreign` FOREIGN KEY (`idDivisaoOrganogramaPai`) REFERENCES `divisaoorganograma` (`id`);

--
-- Restrições para tabelas `geo_referencia`
--
ALTER TABLE `geo_referencia`
  ADD CONSTRAINT `geo_referencia_idcamada_foreign` FOREIGN KEY (`idCamada`) REFERENCES `geo_camada` (`id`),
  ADD CONSTRAINT `geo_referencia_idusuarioalteracao_foreign` FOREIGN KEY (`idUsuarioAlteracao`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `geo_referencia_idusuariocriacao_foreign` FOREIGN KEY (`idUsuarioCriacao`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `govern_avaliacao`
--
ALTER TABLE `govern_avaliacao`
  ADD CONSTRAINT `govern_avaliacao_idmetaespecificaunidade_foreign` FOREIGN KEY (`idmetaespecificaunidade`) REFERENCES `govern_metaespecificaunidade` (`id`),
  ADD CONSTRAINT `govern_avaliacao_idperiodoavaliacao_foreign` FOREIGN KEY (`idperiodoavaliacao`) REFERENCES `govern_periodoavaliacao` (`id`);

--
-- Restrições para tabelas `govern_indicador`
--
ALTER TABLE `govern_indicador`
  ADD CONSTRAINT `govern_indicador_idunidademedida_foreign` FOREIGN KEY (`idunidademedida`) REFERENCES `govern_unidademedida` (`id`);

--
-- Restrições para tabelas `govern_meta`
--
ALTER TABLE `govern_meta`
  ADD CONSTRAINT `govern_meta_idplanejamentoestrategico_foreign` FOREIGN KEY (`idplanejamentoestrategico`) REFERENCES `govern_planejamentoestrategico` (`id`);

--
-- Restrições para tabelas `govern_metaespecifica`
--
ALTER TABLE `govern_metaespecifica`
  ADD CONSTRAINT `govern_metaespecifica_idindicador_foreign` FOREIGN KEY (`idindicador`) REFERENCES `govern_indicador` (`id`),
  ADD CONSTRAINT `govern_metaespecifica_idmeta_foreign` FOREIGN KEY (`idmeta`) REFERENCES `govern_meta` (`id`);

--
-- Restrições para tabelas `govern_metaespecificaunidade`
--
ALTER TABLE `govern_metaespecificaunidade`
  ADD CONSTRAINT `govern_metaespecificaunidade_iddivisaoorganograma_foreign` FOREIGN KEY (`iddivisaoorganograma`) REFERENCES `divisaoorganograma` (`id`),
  ADD CONSTRAINT `govern_metaespecificaunidade_idmetaespecifica_foreign` FOREIGN KEY (`idmetaespecifica`) REFERENCES `govern_metaespecifica` (`id`),
  ADD CONSTRAINT `govern_metaespecificaunidade_idusuarioresponsavel_foreign` FOREIGN KEY (`idusuarioresponsavel`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `govern_periodoavaliacao`
--
ALTER TABLE `govern_periodoavaliacao`
  ADD CONSTRAINT `govern_periodoavaliacao_idplanejamentoestrategico_foreign` FOREIGN KEY (`idplanejamentoestrategico`) REFERENCES `govern_planejamentoestrategico` (`id`);

--
-- Restrições para tabelas `orgao`
--
ALTER TABLE `orgao`
  ADD CONSTRAINT `orgao_idnaturezaorgao_foreign` FOREIGN KEY (`idNaturezaOrgao`) REFERENCES `naturezaorgao` (`id`),
  ADD CONSTRAINT `orgao_idorgaopai_foreign` FOREIGN KEY (`idOrgaoPai`) REFERENCES `orgao` (`id`);

--
-- Restrições para tabelas `procedimentoexterno`
--
ALTER TABLE `procedimentoexterno`
  ADD CONSTRAINT `procedimentoexterno_idpoloprocedimentoexterno_foreign` FOREIGN KEY (`idPoloProcedimentoExterno`) REFERENCES `poloprocedimentoexterno` (`id`),
  ADD CONSTRAINT `procedimentoexterno_idtipoprocedimentoexterno_foreign` FOREIGN KEY (`idTipoProcedimentoExterno`) REFERENCES `tipoprocedimentoexterno` (`id`);

--
-- Restrições para tabelas `usuariodivisaoorganograma`
--
ALTER TABLE `usuariodivisaoorganograma`
  ADD CONSTRAINT `usuariodivisaoorganograma_iddivisaoorganograma_foreign` FOREIGN KEY (`idDivisaoOrganograma`) REFERENCES `divisaoorganograma` (`id`),
  ADD CONSTRAINT `usuariodivisaoorganograma_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `usuariopermissao`
--
ALTER TABLE `usuariopermissao`
  ADD CONSTRAINT `usuariopermissao_idpermissao_foreign` FOREIGN KEY (`idPermissao`) REFERENCES `permissao` (`id`),
  ADD CONSTRAINT `usuariopermissao_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`);

SET FOREIGN_KEY_CHECKS=1;

COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
