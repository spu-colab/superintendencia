-- MySQL dump 10.16  Distrib 10.1.28-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: spu-sc
-- ------------------------------------------------------
-- Server version	10.1.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `spu-sc`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `spu-sc` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `spu-sc`;

--
-- Table structure for table `autordemanda`
--

DROP TABLE IF EXISTS `autordemanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autordemanda` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idOrgao` int(10) unsigned NOT NULL,
  `idCargo` int(10) unsigned NOT NULL,
  `nome` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` char(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `autordemanda_idorgao_foreign` (`idOrgao`),
  KEY `autordemanda_idcargo_foreign` (`idCargo`),
  CONSTRAINT `autordemanda_idcargo_foreign` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`id`),
  CONSTRAINT `autordemanda_idorgao_foreign` FOREIGN KEY (`idOrgao`) REFERENCES `orgao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autordemanda`
--

LOCK TABLES `autordemanda` WRITE;
/*!40000 ALTER TABLE `autordemanda` DISABLE KEYS */;
/*!40000 ALTER TABLE `autordemanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cargo` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES (1,'Advogado','2019-01-22 22:00:01','2019-01-22 22:00:01'),(2,'Advogada','2019-01-22 22:00:01','2019-01-22 22:00:01'),(3,'Juíz','2019-01-22 22:00:01','2019-01-22 22:00:01'),(4,'Juíza','2019-01-22 22:00:01','2019-01-22 22:00:01'),(5,'Procurador','2019-01-22 22:00:01','2019-01-22 22:00:01'),(6,'Procuradora','2019-01-22 22:00:01','2019-01-22 22:00:01'),(7,'Superintendente','2019-01-22 22:00:01','2019-01-22 22:00:01'),(8,'Superintendente','2019-01-22 22:00:01','2019-01-22 22:00:01'),(9,'Gerente','2019-01-22 22:00:01','2019-01-22 22:00:01'),(10,'Gerente','2019-01-22 22:00:01','2019-01-22 22:00:01'),(11,'Presidente','2019-01-22 22:00:01','2019-01-22 22:00:01'),(12,'Presidente','2019-01-22 22:00:01','2019-01-22 22:00:01'),(13,'Coordenador','2019-01-22 22:00:01','2019-01-22 22:00:01'),(14,'Coordenadora','2019-01-22 22:00:01','2019-01-22 22:00:01'),(15,'Chefe','2019-01-22 22:00:01','2019-01-22 22:00:01'),(16,'Chefe','2019-01-22 22:00:01','2019-01-22 22:00:01'),(17,'Diretor','2019-01-22 22:00:01','2019-01-22 22:00:01'),(18,'Diretora','2019-01-22 22:00:01','2019-01-22 22:00:01'),(19,'Secretário','2019-01-22 22:00:01','2019-01-22 22:00:01'),(20,'Secretária','2019-01-22 22:00:01','2019-01-22 22:00:01'),(21,'Ministro','2019-01-22 22:00:01','2019-01-22 22:00:01'),(22,'Ministra','2019-01-22 22:00:02','2019-01-22 22:00:02'),(23,'Assessor','2019-01-22 22:00:02','2019-01-22 22:00:02'),(24,'Assessora','2019-01-22 22:00:02','2019-01-22 22:00:02'),(25,'Secretário-Adjunto','2019-01-22 22:00:02','2019-01-22 22:00:02'),(26,'Secretária-Adjunta','2019-01-22 22:00:02','2019-01-22 22:00:02'),(27,'Coordenador-Geral','2019-01-22 22:00:02','2019-01-22 22:00:02'),(28,'Coordenadora-Geral','2019-01-22 22:00:02','2019-01-22 22:00:02'),(29,'Chefe de Gabinete','2019-01-22 22:00:02','2019-01-22 22:00:02'),(30,'Chefe de Gabinete','2019-01-22 22:00:02','2019-01-22 22:00:02'),(31,'','2019-01-22 22:00:02','2019-01-22 22:00:02'),(32,'','2019-01-22 22:00:02','2019-01-22 22:00:02'),(33,'Procurador-Chefe','2019-01-22 22:00:02','2019-01-22 22:00:02'),(34,'Procuradora-Chefe','2019-01-22 22:00:02','2019-01-22 22:00:02'),(35,'Procurador Substituto','2019-01-22 22:00:02','2019-01-22 22:00:02'),(36,'Procuradora Substituta','2019-01-22 22:00:02','2019-01-22 22:00:02'),(37,'Procurador Seccional','2019-01-22 22:00:02','2019-01-22 22:00:02'),(38,'Procuradora Seccional','2019-01-22 22:00:02','2019-01-22 22:00:02'),(39,'Procurador Seccional Subst.','2019-01-22 22:00:02','2019-01-22 22:00:02'),(40,'Procuradora Seccional Subst.','2019-01-22 22:00:02','2019-01-22 22:00:02'),(41,'Prefeito Municipal','2019-01-22 22:00:02','2019-01-22 22:00:02'),(42,'Prefeita Municipal','2019-01-22 22:00:02','2019-01-22 22:00:02'),(43,'Procurador-Chefe Substituto','2019-01-22 22:00:02','2019-01-22 22:00:02'),(44,'Procuradora-Chefe Substituta','2019-01-22 22:00:02','2019-01-22 22:00:02'),(45,'Procurador-Geral Federal','2019-01-22 22:00:02','2019-01-22 22:00:02'),(46,'Procuradora-Geral Federal','2019-01-22 22:00:02','2019-01-22 22:00:02'),(47,'Subprocurador-Geral Federal','2019-01-22 22:00:02','2019-01-22 22:00:02'),(48,'Subprocuradora-Geral Federal','2019-01-22 22:00:02','2019-01-22 22:00:02'),(49,'Promotora','2019-01-22 22:00:02','2019-01-22 22:00:02'),(50,'Promotor','2019-01-22 22:00:02','2019-01-22 22:00:02'),(51,'Delegada','2019-01-22 22:00:02','2019-01-22 22:00:02'),(52,'Delegado','2019-01-22 22:00:02','2019-01-22 22:00:02'),(53,'Vereadora','2019-01-22 22:00:02','2019-01-22 22:00:02'),(54,'Vereador','2019-01-22 22:00:02','2019-01-22 22:00:02'),(55,'Técnica','2019-01-22 22:00:02','2019-01-22 22:00:02'),(56,'Técnico','2019-01-22 22:00:02','2019-01-22 22:00:02'),(57,'Subprocurador Regional','2019-01-22 22:00:02','2019-01-22 22:00:02'),(58,'Subprocuradora Regional','2019-01-22 22:00:02','2019-01-22 22:00:02'),(59,'Procurador Regional','2019-01-22 22:00:02','2019-01-22 22:00:02'),(60,'Procuradora Regional','2019-01-22 22:00:02','2019-01-22 22:00:02');
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demanda`
--

DROP TABLE IF EXISTS `demanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demanda` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idTipoDocumento` int(10) unsigned NOT NULL,
  `documentoExterno` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nupSEI` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `demanda` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataDocumento` date DEFAULT NULL,
  `dataPrazo` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `idAutorDemanda` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `demanda_idtipodocumento_foreign` (`idTipoDocumento`),
  KEY `demanda_idautordemanda_foreign` (`idAutorDemanda`),
  CONSTRAINT `demanda_idautordemanda_foreign` FOREIGN KEY (`idAutorDemanda`) REFERENCES `autordemanda` (`id`),
  CONSTRAINT `demanda_idtipodocumento_foreign` FOREIGN KEY (`idTipoDocumento`) REFERENCES `tipodocumento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demanda`
--

LOCK TABLES `demanda` WRITE;
/*!40000 ALTER TABLE `demanda` DISABLE KEYS */;
/*!40000 ALTER TABLE `demanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demandamovimentacao`
--

DROP TABLE IF EXISTS `demandamovimentacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demandamovimentacao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idDemanda` int(10) unsigned NOT NULL,
  `idDivisaoOrganogramaOrigem` int(10) unsigned NOT NULL,
  `idDivisaoOrganogramaDestino` int(10) unsigned NOT NULL,
  `idUsuario` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `demandamovimentacao_iddemanda_foreign` (`idDemanda`),
  KEY `demandamovimentacao_iddivisaoorganogramaorigem_foreign` (`idDivisaoOrganogramaOrigem`),
  KEY `demandamovimentacao_iddivisaoorganogramadestino_foreign` (`idDivisaoOrganogramaDestino`),
  KEY `demandamovimentacao_idusuario_foreign` (`idUsuario`),
  CONSTRAINT `demandamovimentacao_iddemanda_foreign` FOREIGN KEY (`idDemanda`) REFERENCES `demanda` (`id`),
  CONSTRAINT `demandamovimentacao_iddivisaoorganogramadestino_foreign` FOREIGN KEY (`idDivisaoOrganogramaDestino`) REFERENCES `divisaoorganograma` (`id`),
  CONSTRAINT `demandamovimentacao_iddivisaoorganogramaorigem_foreign` FOREIGN KEY (`idDivisaoOrganogramaOrigem`) REFERENCES `divisaoorganograma` (`id`),
  CONSTRAINT `demandamovimentacao_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demandamovimentacao`
--

LOCK TABLES `demandamovimentacao` WRITE;
/*!40000 ALTER TABLE `demandamovimentacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `demandamovimentacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `divisaoorganograma`
--

DROP TABLE IF EXISTS `divisaoorganograma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `divisaoorganograma` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idDivisaoOrganogramaPai` int(10) unsigned DEFAULT NULL,
  `nome` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sigla` char(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `divisaoorganograma_iddivisaoorganogramapai_foreign` (`idDivisaoOrganogramaPai`),
  CONSTRAINT `divisaoorganograma_iddivisaoorganogramapai_foreign` FOREIGN KEY (`idDivisaoOrganogramaPai`) REFERENCES `divisaoorganograma` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `divisaoorganograma`
--

LOCK TABLES `divisaoorganograma` WRITE;
/*!40000 ALTER TABLE `divisaoorganograma` DISABLE KEYS */;
/*!40000 ALTER TABLE `divisaoorganograma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2018_07_27_190714_create_tipoprocesso_table',1),(4,'2018_12_03_190346_cria_tipo_processo',1),(5,'2018_12_03_190627_cria_tipo_documento',1),(6,'2018_12_03_191356_popula_tipo_documento',1),(7,'2018_12_04_135119_cria_cargo',1),(8,'2018_12_04_135354_cria_orgao',1),(9,'2018_12_04_190954_cria_demanda',1),(10,'2018_12_04_192350_cria_autor_demanda',1),(11,'2019_01_09_192830_demanda__cria__f_k__autor_demanda',1),(12,'2019_01_10_192845_create_divisao_organogramas_table',1),(13,'2019_01_10_193549_create_demanda_movimentacaos_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orgao`
--

DROP TABLE IF EXISTS `orgao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orgao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orgao` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sigla` char(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` char(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone` char(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orgao`
--

LOCK TABLES `orgao` WRITE;
/*!40000 ALTER TABLE `orgao` DISABLE KEYS */;
INSERT INTO `orgao` VALUES (1,'JUSTIÇA FEDERAL - SEÇÃO JUDICIÁRIA DE SANTA CATARINA','TRF4/SC',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(2,'Advocacia-Geral da União - Procuradoria da União no Estado de Santa Catarina','AGU/SC',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(3,'Superintendência do Patrimônio da União em Santa Caratina','SPU/SC',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(4,'Secretaria do patrimônio da União - MPOG','SPU/MPOG',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(5,'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DE SANTA CATARINA','PFN/SC',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(6,'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM BLUMENAU','PFN/PSFN/BLUME',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(7,'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM CHAPECÓ','PFN/PSFN/CHAPC',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(8,'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM CRICIÚMA','PFN/PSFN/CRICI',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(9,'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM ITAJAÍ','PFN/PSFN/ITAJA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(10,'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM JOAÇABA','PFN/PSFN/JOAÇA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(11,'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM JOINVILLE','PFN/PSFN/JOINV',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(12,'PROCURADORIA SECCIONAL DA FAZENDA NACIONAL EM LAGES','PFN/PSFN/LAGES',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(13,'PREFEITURA MUNICIPAL DE ARAQUARI','PM/ARAQUARI',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(14,'PREFEITURA MUNICIPAL DE ARARANGUÁ','PM/ARARANGUÁ',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(15,'PREFEITURA MUNICIPAL DE BALNEÁRIO ARROIO DO SILVA','PM/BALN A. DO SILVA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(16,'PREFEITURA MUNICIPAL DE BALNEÁRIO BARRA DO SUL','PM/BALN BARRA DO SUL',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(17,'PREFEITURA MUNICIPAL DE BALNEÁRIO CAMBORIÚ','PM/BALN CAMBORIÚ',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(18,'PREFEITURA MUNICIPAL DE BALNEÁRIO GAIVOTA','PM/BALN GAIVOTA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(19,'PREFEITURA MUNICIPAL DE ITAPOÁ','PM/ITAPOÁ',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(20,'PREFEITURA MUNICIPAL DE BALNEÁRIO PIÇARRAS','PM/BALN PIÇARRAS',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(21,'PREFEITURA MUNICIPAL DE BARRA VELHA','PM/BARRA VELHA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(22,'PREFEITURA MUNICIPAL DE BIGUAÇU','PM/BIGUAÇU',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(23,'PREFEITURA MUNICIPAL DE BOMBINHAS','PM/BOMBINHAS',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(24,'PREFEITURA MUNICIPAL DE FLORIANÓPOLIS','PM/FLORIANÓPOLIS',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(25,'PREFEITURA MUNICIPAL DE GAROPABA','PM/GAROPABA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(26,'PREFEITURA MUNICIPAL DE GARUVA','PM/GARUVA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(27,'PREFEITURA MUNICIPAL DE GOVERNADOR CELSO RAMOS','PM/GOV CELSO RAMOS',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(28,'PREFEITURA MUNICIPAL DE IMBITUBA','PM/IMBITUBA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(29,'PREFEITURA MUNICIPAL DE ITAJAÍ','PM/ ITAJAÍ',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(30,'PREFEITURA MUNICIPAL DE ITAPEMA','PM/ ITAPEMA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(31,'PREFEITURA MUNICIPAL DE JAGUARUNA','PM/JAGUARUNA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(32,'PREFEITURA MUNICIPAL DE JOINVILLE','PM/JOINVILLE',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(33,'PREFEITURA MUNICIPAL DE LAGUNA','PM/LAGUNA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(34,'PREFEITURA MUNICIPAL DE NAVEGANTES','PM/NAVEGANTES',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(35,'PREFEITURA MUNICIPAL DE PALHOÇA','PM/PALHOÇA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(36,'PREFEITURA MUNICIPAL DE PASSO DE TORRES','PM/PASSO DE TORRES',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(37,'PREFEITURA MUNICIPAL DE PENHA','PM/PENHA',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(38,'PREFEITURA MUNICIPAL DE PORTO BELO','PM/PORTO BELO',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(39,'PREFEITURA MUNICIPAL DE SÃO FRANCISCO DO SUL','PM/S F DO SUL',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(40,'PREFEITURA MUNICIPAL DE SÃO JOSÉ','PM/SAO JOSE',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(41,'PREFEITURA MUNICIPAL DE TIJUCAS','PM/TIJUCAS',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(42,'PREFEITURA MUNICIPAL DE BALNEÁRIO RINCÃO','PM/BALN RINCÃO',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(43,'PREFEITURA MUNICIPAL DE PAULO LOPES','PM/PAULO LOPES',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(44,'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE BLUMENAU','AGU/PSU/BNU/SC',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(45,'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE CHAPECÓ','AGU/PSU/CCO/SC',NULL,NULL,'2019-01-22 21:55:26','2019-01-22 21:55:26'),(46,'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE CRICIÚMA','AGU/PSU/CCM/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(47,'ADVOCACIA-GERAL DA UNIÃO - SECCIONAL DE JOINVILLE','AGU/PSU/JVE/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(48,'PROCURADORIA DA REPÚBLICA EM SANTA CATARINA','MPF/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(49,'PROCURADORIA DA REPÚBLICA - BLUMENAU - SC','MPF/PRM/BNU/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(50,'PROCURADORIA DA REPÚBLICA - CAÇADOR - SC','MPF/PRM/CCD/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(51,'PROCURADORIA DA REPÚBLICA - CHAPECÓ - SC','MPF/PRM/CCO/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(52,'PROCURADORIA DA REPÚBLICA - CONCÓRDIA - SC','MPF/PRM/CDA/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(53,'PROCURADORIA DA REPÚBLICA - CRICIÚMA - SC','MPF/PRM/CCM/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(54,'PROCURADORIA DA REPÚBLICA - ITAJAÍ - SC','MPF/PRM/ITA/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(55,'PROCURADORIA DA REPÚBLICA - JARAGUÁ DO SUL - SC','MPF/PRM/JRG/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(56,'PROCURADORIA DA REPÚBLICA - JOAÇABA - SC','MPF/PRM/JBA/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(57,'PROCURADORIA DA REPÚBLICA - JOINVILLE - SC','MPF/PRM/JVE/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(58,'PROCURADORIA DA REPÚBLICA - LAGES - SC','MPF/PRM/LGS/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(59,'PROCURADORIA DA REPÚBLICA - MAFRA - SC','MPF/PRM/MFA/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(60,'PROCURADORIA DA REPÚBLICA - RIO DO SUL - SC','MPF/PRM/RSL/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(61,'PROCURADORIA DA REPÚBLICA - SÃO MIGUEL DO OESTE - SC','MPF/PRM/SMO/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(62,'PROCURADORIA DA REPÚBLICA - TUBARÃO- SC','MPF/PRM/TBO/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(63,'Advocacia-Geral da União - Procuradoria da União no Estado do Paraná','AGU/PR',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(64,'Advocacia-Geral da União','AGU/DF',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(65,'Advocacia-Geral da União - Procuradoria-Geral da União','AGU/PGU/DF',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(66,'Advocacia-Geral da União - Procuradoria-Geral Federal','AGU/PGF/DF',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(67,'Min.Público do Estado de Santa Catarina','MPE/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(68,'Vara do Trabalho de Imbituba','TRT/ Imbituba',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(69,'Delegacia de Polícia Federal em Joinville','DPF/JVE',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(70,'Sindicato dos Trabalhadores no Serviço Público Federal em SC','Sintrafesc',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(71,'Câmara Municipal de Florianópolis','CM/FLORIANÓPOLIS/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(72,'Supetintendência Polícia Federal SC','MJ-PF',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(73,'Instituto Brasileiro de Meio Ambiente e dos Recursos Renováveis','IBAMA',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(74,'Tribunal Regional Eleitoral SC','TRE/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(75,'Delegacia de Polícia Federal em Itajaí','DPF/IJI/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(76,'INSTITUTO CHICO MENDES DE CONSERVAÇÃO DA BIODIVERSIDADE','ICMBIO',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(77,'COMARCA DE TIJUCAS - 2ª VARA CÍVEL','TJ/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(78,'PROCURADORIA DA REPÚBLICA EM CONCÓRDIA','MPF/SC CONCÓRDIA',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(79,'DEPARTAMENTO DE POLÍCIA FEDERAL - SUPERINTENDÊNCIA REGIONAL EM SANTA CATARINA','SR/DPF/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(80,'DEFENSORIA PÚBLICA DA UNIÃO EM JOINVILLE','DPU/JOINVILLE',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(81,'Avalienge Engenharia Ambiental','Avalienge',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(82,'Advocacia-Geral da União - Procuradoria da União no Estado do Rio Grande do Sul','AGU/RS',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(83,'Procuradoria da União no Estado de Santa Catarina','PU/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(84,'PROCURADORIA REGIONAL DA UNIAO 4 REGIÃO','PRU4',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(85,'MINISTÉRIO PÚBLICO DE SC - PROMOTORIA DE JUSTIÇA DE LAGUNA','MPE/PJ/LAGUNA/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(86,'Procuradoria Seccional da União em Santa Maria/RS','PSU/SMA',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(87,'1ª Vara Comarca de Porto Belo','JE-PJ/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(88,'Procuradoria Seccional da União em Santa Maria-RS','AGU SMA',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(89,'OFÍCIO DE REGISTRO DE IMÓVEIS BALNEÁRIO PIÇARRAS','RI BAL PIÇARRAS',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(90,'PODER JUDICIARIO DE SANTA CATARINA 2ª VARA DA FAMÍLIA','POD. JUD. 2 V.F.',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(91,'Justiça Federal - 1ª Vara de Caçador','VF-Caçador',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(92,'Campeche Camping e Promoções LTDA','Campache Camping',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(93,'Ministério Público Federal de Criciúma/SC','MPF-Criciúma',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(94,'COMARCA DE IMBITUBA - 1ª VARA','1ª VARA DE IMBITUBA',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(95,'COMARCA GAROPABA VARA ÚNICA','VARA ÚNICA GAROPABA',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(96,'Tribunal de contas da União','TCU',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(97,'SUPERINTENDÊNCIA DO PATRIMÔNIO DA UNIÃO NO PARANÁ','SPU/PR',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(98,'Consultoria Jurídica da União em Santa Catarina','CJU/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(99,'Ministério Público do Trabalho  - Procuradoria do Trabalho em Criciúma','MPT-CCM',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(100,'TJSC/Itapema - 2ª VARA CÍVEL','TJSC/Itapema - 2ª VARA CÍVEL',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(101,'MINISTÉRIO PÚBLICO DE SC - PROMOTORIA DE JUSTIÇA DE JOINVILLE','MPE/PJ/JOINVILLE/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(102,'JUSTIÇA FEDERAL - SEÇÃO JUDICIÁRIA DE SANTA CATARINA','JF/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(103,'NÃO DEFINIDO','NÃO DEFINIDO',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27'),(104,'JUSTIÇA DO ESTADO DE SANTA CATARINA','JE/SC',NULL,NULL,'2019-01-22 21:55:27','2019-01-22 21:55:27');
/*!40000 ALTER TABLE `orgao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipodocumento`
--

DROP TABLE IF EXISTS `tipodocumento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipodocumento` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipodocumento` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipodocumento`
--

LOCK TABLES `tipodocumento` WRITE;
/*!40000 ALTER TABLE `tipodocumento` DISABLE KEYS */;
INSERT INTO `tipodocumento` VALUES (1,'Ofício',NULL,NULL);
/*!40000 ALTER TABLE `tipodocumento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoprocesso`
--

DROP TABLE IF EXISTS `tipoprocesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoprocesso` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descricao` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoprocesso`
--

LOCK TABLES `tipoprocesso` WRITE;
/*!40000 ALTER TABLE `tipoprocesso` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipoprocesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alysson Marques','alyssonmarques@gmail.com','$2y$10$NAr/rtTg7KLGMoQZ/zHPse5tX5MY6VJ4qap69zvPiirAVW2ryvZu6',NULL,'2019-01-22 21:55:15','2019-01-22 21:55:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-22 18:04:35
