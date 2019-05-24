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
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autordemanda`
--

LOCK TABLES `autordemanda` WRITE;
/*!40000 ALTER TABLE `autordemanda` DISABLE KEYS */;
INSERT INTO `autordemanda` VALUES (1,2,2,'Débora Beal Thaís de Córdova','[email_nao_fornecido]','(48)32036380','2019-01-23 20:05:26','2019-01-23 20:05:26'),(2,2,34,'Dalvani Luzia Propodoski Rocha Vieira Jank','[email_nao_fornecido]','(48)32036380','2019-01-23 20:05:26','2019-01-23 20:05:26'),(3,5,33,'Felipe Dulac Goulart','[email_nao_fornecido]','(48)38212000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(4,5,35,'Flávio Camozzato','[email_nao_fornecido]','(48)38212000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(5,5,35,'Luiz Henrique Teixeira da Silva','[email_nao_fornecido]','(48)38212000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(6,6,39,'Alfeu Gomes dos Santos','[email_nao_fornecido]','(47)33228915','2019-01-23 20:05:26','2019-01-23 20:05:26'),(7,6,37,'Eleandro Ângelo Biondo','[email_nao_fornecido]','(47)33228915','2019-01-23 20:05:26','2019-01-23 20:05:26'),(8,6,39,'Márcio Santos de Freitas','[email_nao_fornecido]','(47)33228915','2019-01-23 20:05:26','2019-01-23 20:05:26'),(9,7,37,'Daniel Sbeghen','[email_nao_fornecido]','(49)33224433','2019-01-23 20:05:26','2019-01-23 20:05:26'),(10,7,39,'Fábio João Szinwelski','[email_nao_fornecido]','(49)33224433','2019-01-23 20:05:26','2019-01-23 20:05:26'),(11,7,39,'Joubert Farley Eger','[email_nao_fornecido]','(49)33224433','2019-01-23 20:05:26','2019-01-23 20:05:26'),(12,8,37,'Vinícius Garcia','[email_nao_fornecido]','(48)34331235','2019-01-23 20:05:26','2019-01-23 20:05:26'),(13,8,39,'André Afeche Pimenta','[email_nao_fornecido]','(48)34331235','2019-01-23 20:05:26','2019-01-23 20:05:26'),(14,8,39,'Alessandro Schlemper Kiquio','[email_nao_fornecido]','(48)34331235','2019-01-23 20:05:26','2019-01-23 20:05:26'),(15,9,37,'Márcio da Silva Florêncio','[email_nao_fornecido]','(47)33482735','2019-01-23 20:05:26','2019-01-23 20:05:26'),(16,9,40,'Gabriela Cabral Soares Modesto','[email_nao_fornecido]','(47)33482735','2019-01-23 20:05:26','2019-01-23 20:05:26'),(17,10,38,'Bruna Machado Lucas Gomes','[email_nao_fornecido]','(49)35222289','2019-01-23 20:05:26','2019-01-23 20:05:26'),(18,10,40,'Nathalia Hoffmann Monteiro de Castro','[email_nao_fornecido]','(49)35222289','2019-01-23 20:05:26','2019-01-23 20:05:26'),(19,11,37,'Cidinei Bogo Chatt','[email_nao_fornecido]','(47)34226367','2019-01-23 20:05:26','2019-01-23 20:05:26'),(20,11,39,'Jackson Torres','[email_nao_fornecido]','(47)34226367','2019-01-23 20:05:26','2019-01-23 20:05:26'),(21,11,39,'Márcio Poderoso de Araújo','[email_nao_fornecido]','(47)35222289','2019-01-23 20:05:26','2019-01-23 20:05:26'),(22,12,37,'Francisco José Tarso de Sabóia','[email_nao_fornecido]','(49)32241989','2019-01-23 20:05:26','2019-01-23 20:05:26'),(23,12,39,'Daniel Oliveira Teles de Menezes','[email_nao_fornecido]','(49)32241989','2019-01-23 20:05:26','2019-01-23 20:05:26'),(24,13,41,'JOÃO PEDRO WOITEXEM','[email_nao_fornecido]','(47)34477737','2019-01-23 20:05:26','2019-01-23 20:05:26'),(25,14,41,'SANDRO ROBERTO MACIEL','[email_nao_fornecido]','(48)35210922','2019-01-23 20:05:26','2019-01-23 20:05:26'),(26,15,41,'EVANDRO SCAINI','[email_nao_fornecido]','(48)35261445','2019-01-23 20:05:26','2019-01-23 20:05:26'),(27,16,41,'Ademar Henrique Borges','[email_nao_fornecido]','(47)34481043','2019-01-23 20:05:26','2019-01-23 20:05:26'),(28,17,42,'LUZIA LOURDES COPPI MATHIAS','[email_nao_fornecido]','(47)33659500','2019-01-23 20:05:26','2019-01-23 20:05:26'),(29,18,41,'RONALDO PEREIRA DA SILVA','[email_nao_fornecido]','(48)35831408','2019-01-23 20:05:26','2019-01-23 20:05:26'),(30,19,41,'SÉRGIO FERREIRA DE AGUIAR','[email_nao_fornecido]','(47)34438813','2019-01-23 20:05:26','2019-01-23 20:05:26'),(31,20,41,'LEONEL JOSÉ MARTINS','[email_nao_fornecido]','(47)33474707','2019-01-23 20:05:26','2019-01-23 20:05:26'),(32,21,41,'CLAUDEMIR MATIAS FRANCISCO','[email_nao_fornecido]','(47)34467700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(33,22,41,'JOSÉ CASTELO DESCHAMPS','[email_nao_fornecido]','(48)32798000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(34,23,42,'ANA PAULA DA SILVA','[email_nao_fornecido]','(47)33939500','2019-01-23 20:05:26','2019-01-23 20:05:26'),(35,24,41,'CESAR SOUZA JÚNIOR','[email_nao_fornecido]','(48)32516066','2019-01-23 20:05:26','2019-01-23 20:05:26'),(36,25,41,'LUIZ CARLOS LUIZ','[email_nao_fornecido]','(48)32548100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(37,29,41,'JANDIR BELLINI','[email_nao_fornecido]','(47)33416000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(38,30,41,'RODRIGO COSTA','[email_nao_fornecido]','(47)32688000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(39,31,41,'LUIZ ARNALDO NAPOLI','[email_nao_fornecido]','(48)36240138','2019-01-23 20:05:26','2019-01-23 20:05:26'),(40,32,41,'UDO DOHLER','[email_nao_fornecido]','(47)34313233','2019-01-23 20:05:26','2019-01-23 20:05:26'),(41,34,41,'ROBERTO CARLOS DE SOUZA','[email_nao_fornecido]','(47)33429500','2019-01-23 20:05:26','2019-01-23 20:05:26'),(42,35,41,'CAMILO NAZARENO PAGANI MARTINS','[email_nao_fornecido]','(48)32791700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(43,36,41,'JUAREZ GODINHO SCHEFFER','[email_nao_fornecido]','(48)35480035','2019-01-23 20:05:26','2019-01-23 20:05:26'),(44,37,41,'EVANDRO EREDES DOS NAVEGANTES','[email_nao_fornecido]','(47)33450200','2019-01-23 20:05:26','2019-01-23 20:05:26'),(45,38,41,'EVALDO JOSÉ GUERREIRO FILHO','[email_nao_fornecido]','(47)33694111','2019-01-23 20:05:26','2019-01-23 20:05:26'),(46,39,41,'LUIZ ROBERTO DE OLIVEIRA','[email_nao_fornecido]','(47)34712222','2019-01-23 20:05:26','2019-01-23 20:05:26'),(47,40,42,'ADELIANA DAL PONT','[email_nao_fornecido]','(48)33810000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(48,41,41,'VALÉRIO TOMAZI','[email_nao_fornecido]','(48)32688100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(49,42,41,'DÉCIO GOMES GÓES','[email_nao_fornecido]','(48)34681068','2019-01-23 20:05:26','2019-01-23 20:05:26'),(50,43,41,'EVANDRO JOÃO DOS SANTOS','[email_nao_fornecido]','(48)88490000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(51,33,41,'EVERALDO DOS SANTOS','[email_nao_fornecido]','(48)36448700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(52,28,41,'JAISON CARDOSO DE  SOUZA','[email_nao_fornecido]','(48)33558135','2019-01-23 20:05:26','2019-01-23 20:05:26'),(53,27,41,'JULIANO DUARTE CAMPOS','[email_nao_fornecido]','(48)32620131','2019-01-23 20:05:26','2019-01-23 20:05:26'),(54,44,37,'CAIO ALEXANDRE WOLFF','[email_nao_fornecido]','(47)33228918','2019-01-23 20:05:26','2019-01-23 20:05:26'),(55,45,37,'MÁRCIO WESSNER','[email_nao_fornecido]','(49)33231455','2019-01-23 20:05:26','2019-01-23 20:05:26'),(56,46,37,'DIOGO CAVALLI','[email_nao_fornecido]','(48)34334174','2019-01-23 20:05:26','2019-01-23 20:05:26'),(57,47,37,'CIRO CARVALHO MIRANDA','[email_nao_fornecido]','(47)21079700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(58,48,33,'MARCELO DA MOTA','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(59,50,5,'ANDERSON LODETTI CUNHA DE OLIVEIRA','[email_nao_fornecido]','(49)34212100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(60,51,5,'RENATO DE REZENDE GOMES','[email_nao_fornecido]','(49)33131200','2019-01-23 20:05:26','2019-01-23 20:05:26'),(61,52,5,'CARLOS HUMBERTO PROLA JÚNIOR','[email_nao_fornecido]','(49)34411806','2019-01-23 20:05:26','2019-01-23 20:05:26'),(62,53,5,'DARLAN AIRTON DIAS','[email_nao_fornecido]','(48)34112500','2019-01-23 20:05:26','2019-01-23 20:05:26'),(63,54,5,'PEDRO PAULO REINALDIN','[email_nao_fornecido]','(47)34045150','2019-01-23 20:05:26','2019-01-23 20:05:26'),(64,55,5,'CLAUDIO VALENTIM CRISTANI','[email_nao_fornecido]','(47)35012100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(65,56,5,'MÁRIO ROBERTO DOS SANTOS','[email_nao_fornecido]','(49)32027000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(66,57,5,'DAVY LINCOLN ROCHA','[email_nao_fornecido]','(47)34417200','2019-01-23 20:05:26','2019-01-23 20:05:26'),(67,58,5,'NAZARENO JORGEALEM WOLFF','[email_nao_fornecido]','(49)21012300','2019-01-23 20:05:26','2019-01-23 20:05:26'),(68,59,5,'RUI MAURÍCIO RIBAS RUCINSKI','[email_nao_fornecido]','(47)36415400','2019-01-23 20:05:26','2019-01-23 20:05:26'),(69,60,6,'LUCYANA MARINA PEPE AFFONSO','[email_nao_fornecido]','(47)34112255','2019-01-23 20:05:26','2019-01-23 20:05:26'),(70,61,6,'CAMILA BORTOLOTTI','[email_nao_fornecido]','(49)36312700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(71,61,5,'EDSON RESTANHO','[email_nao_fornecido]','(49)36312700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(72,62,5,'DANIEL RICKEN','[email_nao_fornecido]','(48)33021000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(73,62,5,'ELOI FRANCISCO ZATTI FACCIONI','[email_nao_fornecido]','(48)33021000','2019-01-23 20:05:26','2019-01-23 20:05:26'),(74,49,5,'ANDREI MATTIUZI BALVEDI','[email_nao_fornecido]','(47)33211700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(75,49,5,'MICHAEL VON MUHLEN DE BARROS GONÇALVES','[email_nao_fornecido]','(47)33211700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(76,49,6,'RAFAELLA ALBERICI','[email_nao_fornecido]','(47)33211700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(77,49,5,'RICARDO KLING DONINI','[email_nao_fornecido]','(47)33211700','2019-01-23 20:05:26','2019-01-23 20:05:26'),(78,53,5,'FÁBIO DE OLIVEIRA','[email_nao_fornecido]','(48)34112500','2019-01-23 20:05:26','2019-01-23 20:05:26'),(79,53,6,'PATRÍCIA MUXFELDT','[email_nao_fornecido]','(48)34112500','2019-01-23 20:05:26','2019-01-23 20:05:26'),(80,54,5,'RAFAEL BRUM MIRON','[email_nao_fornecido]','(47)34045150','2019-01-23 20:05:26','2019-01-23 20:05:26'),(81,54,5,'RICARDO MARTINS BAPTISTA','[email_nao_fornecido]','(47)34045150','2019-01-23 20:05:26','2019-01-23 20:05:26'),(82,57,5,'FLÁVIO PAVLOV DA SILVEIRA','[email_nao_fornecido]','(47)34417200','2019-01-23 20:05:26','2019-01-23 20:05:26'),(83,57,5,'MÁRIO SÉRGIO GHANNAGE BARBOSA','[email_nao_fornecido]','(47)34417200','2019-01-23 20:05:26','2019-01-23 20:05:26'),(84,57,5,'RODRIGO JOAQUIM LIMA','[email_nao_fornecido]','(47)34417200','2019-01-23 20:05:26','2019-01-23 20:05:26'),(85,57,5,'TIAGO ALZUGUIR GUTIERREZ','[email_nao_fornecido]','(47)34417200','2019-01-23 20:05:26','2019-01-23 20:05:26'),(86,48,6,'ANALÚCIA DE ANDRADE HARTMANN','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(87,48,5,'ANDRÉ STEFANI BERTUOL','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(88,48,5,'CARLOS AUGUSTO DE AMORIM DUTRA','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(89,48,6,'DANIELE CARDOSO ESCOBAR','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(90,48,5,'EDUARDO BARRAGAN SEROA DA MOTTA','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(91,48,5,'JOÃO MARQUES BRANDÃO NETO','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(92,48,5,'MARCO AURÉLIO DUTRA AYDOS','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:26','2019-01-23 20:05:26'),(93,48,5,'ROGER FABRE','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:27','2019-01-23 20:05:27'),(94,48,5,'MAURÍCIO PESSUTTO','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:27','2019-01-23 20:05:27'),(95,48,5,'WALMOR ALVES MOREIRA','[email_nao_fornecido]','(48)21076100','2019-01-23 20:05:27','2019-01-23 20:05:27'),(96,44,39,'CLAUDINEI MOSER','[email_nao_fornecido]','(47)33228918','2019-01-23 20:05:27','2019-01-23 20:05:27'),(97,44,1,'MARCELO CONCEIÇÃO ANDRETTA','[email_nao_fornecido]','(47)33228918','2019-01-23 20:05:27','2019-01-23 20:05:27'),(98,44,1,'OSVALDO GRAVINA FILHO','[email_nao_fornecido]','(47)33228918','2019-01-23 20:05:27','2019-01-23 20:05:27'),(99,44,1,'ULISSES VETTORELLO','[email_nao_fornecido]','(47)33228918','2019-01-23 20:05:27','2019-01-23 20:05:27'),(100,45,40,'MARILES WICHROSKI DOS SANTOS','[email_nao_fornecido]','(49)33231455','2019-01-23 20:05:27','2019-01-23 20:05:27'),(101,45,2,'FRANCEELLE SOARES','[email_nao_fornecido]','(49)33231455','2019-01-23 20:05:27','2019-01-23 20:05:27'),(102,45,1,'ADAUTO JOSE SILVA FILHO','[email_nao_fornecido]','(49)33231455','2019-01-23 20:05:27','2019-01-23 20:05:27'),(103,46,1,'VICTOR KLAFKE RIBEIRO','[email_nao_fornecido]','(48)34334174','2019-01-23 20:05:27','2019-01-23 20:05:27'),(104,46,2,'LEILA MILENE ZILLI DOS SANTOS','[email_nao_fornecido]','(48)34334174','2019-01-23 20:05:27','2019-01-23 20:05:27'),(105,47,39,'FÁBIO CRISTIANO WOERNER GALLE','[email_nao_fornecido]','(47)21079700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(106,47,2,'MARIA LUCIA HOLANDA GURGEL PEREIRA','[email_nao_fornecido]','(47)21079700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(107,47,2,'VIVIANE FENRICH','[email_nao_fornecido]','(47)21079700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(108,47,1,'DANIEL CARLOS ANDRADE','[email_nao_fornecido]','(47)21079700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(109,47,1,'JOSÉ OLIVEIRA DA SILVA','[email_nao_fornecido]','(47)21079700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(110,63,33,'CLÊNIO LUIZ PARIZOTTO','[email_nao_fornecido]','(41)32045700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(111,63,44,'CLAUDETE SIRLEI DE SOUZA','[email_nao_fornecido]','(41)32045700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(112,2,43,'César Augusto Bedin','[email_nao_fornecido]','(48)32036380','2019-01-23 20:05:27','2019-01-23 20:05:27'),(113,2,1,'JOSÉ WANDERLEY KOZIMA','[email_nao_fornecido]','(48)32036355','2019-01-23 20:05:27','2019-01-23 20:05:27'),(114,2,1,'Emedi Camilo Vizzotto','[email_nao_fornecido]','(48)32036355','2019-01-23 20:05:27','2019-01-23 20:05:27'),(115,2,31,'JOYCE WOLFF','[email_nao_fornecido]','(48)32036349','2019-01-23 20:05:27','2019-01-23 20:05:27'),(116,85,5,'Diogo André Matsuoka Azevedo dos Santos','[email_nao_fornecido]','(48)36448314','2019-01-23 20:05:27','2019-01-23 20:05:27'),(117,2,31,'JOYCE WOLFF','[email_nao_fornecido]','(48)32036349','2019-01-23 20:05:27','2019-01-23 20:05:27'),(118,2,1,'Fábio Gomes Pina','[email_nao_fornecido]','(48)32036355','2019-01-23 20:05:27','2019-01-23 20:05:27'),(119,57,38,'FÁBIO GALLE','[email_nao_fornecido]','(47)34220590','2019-01-23 20:05:27','2019-01-23 20:05:27'),(120,45,1,'Ângelo Madar Piva','[email_nao_fornecido]','(49)33231455','2019-01-23 20:05:27','2019-01-23 20:05:27'),(121,47,15,'Andréa Rocha','[email_nao_fornecido]','(48)34220590','2019-01-23 20:05:27','2019-01-23 20:05:27'),(122,5,5,'Dinemar Zoccoli','[email_nao_fornecido]','(48)32512000','2019-01-23 20:05:27','2019-01-23 20:05:27'),(123,47,31,'SID JOSÉ FAVERO','[email_nao_fornecido]','(47)21079700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(124,2,20,'Celita Helena Kalbusch de Souza','[email_nao_fornecido]','(48)32036340','2019-01-23 20:05:27','2019-01-23 20:05:27'),(125,68,3,'Daniel Natividade Rodrigues de Oliveira','[email_nao_fornecido]','(48)32552206','2019-01-23 20:05:27','2019-01-23 20:05:27'),(126,2,5,'André Luiz de Córdova','[email_nao_fornecido]','(48)32036349','2019-01-23 20:05:27','2019-01-23 20:05:27'),(127,51,5,'Carlos Humberto Prola Junior','[email_nao_fornecido]','(49)33131200','2019-01-23 20:05:27','2019-01-23 20:05:27'),(128,67,50,'Luciano Trierweiller Naschenweng','[email_nao_fornecido]','(48)33302128','2019-01-23 20:05:27','2019-01-23 20:05:27'),(129,69,15,'Rômulo Humberto Torres de Castro Osta','[email_nao_fornecido]','(47)34316800','2019-01-23 20:05:27','2019-01-23 20:05:27'),(130,70,11,'Maria das Graças Albert','[email_nao_fornecido]','(48)32236452','2019-01-23 20:05:27','2019-01-23 20:05:27'),(131,71,11,'Vereador Celso Francisco Sandrini','[email_nao_fornecido]','(48)30275700','2019-01-23 20:05:27','2019-01-23 20:05:27'),(132,72,15,'Clovis Roldão Machado de Barros','[email_nao_fornecido]','(48)32816500','2019-01-23 20:05:27','2019-01-23 20:05:27'),(133,73,15,'Luis Ernesto Trein','[email_nao_fornecido]','(47)34333760','2019-01-23 20:05:27','2019-01-23 20:05:27'),(134,62,9,'Andrey Luciano F Miranda','[email_nao_fornecido]','(48)33021045','2019-01-23 20:05:27','2019-01-23 20:05:27'),(135,1,17,'Antônio Augusto Teixeira Diniz','[email_nao_fornecido]','(48)32512536','2019-01-23 20:05:27','2019-01-23 20:05:27'),(136,67,50,'Mário Waltrick do Amarante','[email_nao_fornecido]','(48)33302132','2019-01-23 20:05:27','2019-01-23 20:05:27'),(137,74,19,'Eduardo Cardoso','[email_nao_fornecido]','(48)32517410','2019-01-23 20:05:27','2019-01-23 20:05:27'),(138,75,15,'Luciana de Castro Ribeiro','[email_nao_fornecido]','(47)32496799','2019-01-23 20:05:27','2019-01-23 20:05:27'),(139,72,15,'Alessandre Mauro Tomaz','[email_nao_fornecido]','(48)32816500','2019-01-23 20:05:27','2019-01-23 20:05:27'),(140,2,1,'JOSÉ OLIVEIRA DA SILVA','[email_nao_fornecido]','(47)34226689','2019-01-23 20:05:27','2019-01-23 20:05:27'),(141,2,1,'PEDRO AUGUSTO RODRIGUES COSTA','[email_nao_fornecido]','(48)32036377','2019-01-23 20:05:27','2019-01-23 20:05:27'),(142,1,17,'JULIANO AYRES DA ROCHA','[email_nao_fornecido]','(48)32512546','2019-01-23 20:05:27','2019-01-23 20:05:27'),(143,47,1,'ANDRÉ LUIZ DE CÓRDOVA','[email_nao_fornecido]','(48)39011380','2019-01-23 20:05:27','2019-01-23 20:05:27'),(144,11,6,'Catia Rosane Viertel Crestani','[email_nao_fornecido]','(47)34226367','2019-01-23 20:05:27','2019-01-23 20:05:27'),(145,11,6,'Larissa Keil Marinelli','[email_nao_fornecido]','(47)34226367','2019-01-23 20:05:27','2019-01-23 20:05:27'),(146,1,17,'Juliano Ayres da Rocha','[email_nao_fornecido]','(48)32512546','2019-01-23 20:05:27','2019-01-23 20:05:27'),(147,56,55,'MÁRCIA YAMAGUTI','[email_nao_fornecido]','(49)32027000','2019-01-23 20:05:27','2019-01-23 20:05:27'),(148,76,15,'SILVIO DE SOUZA JUNIOR','[email_nao_fornecido]','(48)32822163','2019-01-23 20:05:28','2019-01-23 20:05:28'),(149,77,3,'MÔNANI MENINE PEREIRA','[email_nao_fornecido]','(48)32638030','2019-01-23 20:05:28','2019-01-23 20:05:28'),(150,78,5,'CARLOS HUMBERTO PROLA JÚNIOR','[email_nao_fornecido]','(49)34411800','2019-01-23 20:05:28','2019-01-23 20:05:28'),(151,79,52,'HELIO SANT ANNA E SILVA JUNIO','[email_nao_fornecido]','(48)32816500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(152,80,31,'ANTÔNIO ARAÚJO SEGUNDO','[email_nao_fornecido]','(48)11111111','2019-01-23 20:05:28','2019-01-23 20:05:28'),(153,9,6,'Gabriela Cabral Soares Modesto','[email_nao_fornecido]','(47)33482735','2019-01-23 20:05:28','2019-01-23 20:05:28'),(154,81,15,'Francisco de Assis Beltrame','[email_nao_fornecido]','(48)36262486','2019-01-23 20:05:28','2019-01-23 20:05:28'),(155,69,52,'Júnior Aparecido Taglialenha','[email_nao_fornecido]','(47)34316800','2019-01-23 20:05:28','2019-01-23 20:05:28'),(156,72,52,'Helio Santanna e Silva Junior','[email_nao_fornecido]','(48)32816500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(157,2,1,'CIRO CARVALHO MIRANDA','[email_nao_fornecido]','(47)34220590','2019-01-23 20:05:28','2019-01-23 20:05:28'),(158,82,60,'LISIANE FERRAZO RIBEIRO','[email_nao_fornecido]','(51)35116500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(159,82,57,'ADALBERTO JOSÉ KASPARY FILHO','[email_nao_fornecido]','(51)35116500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(160,83,1,'José Wanderley Kozima','[email_nao_fornecido]','(48)99999999','2019-01-23 20:05:28','2019-01-23 20:05:28'),(161,1,3,'MARCELO KRÁS BORGES','[email_nao_fornecido]','(48)32036349','2019-01-23 20:05:28','2019-01-23 20:05:28'),(162,84,2,'Sabrina Fontoura da Silva','[email_nao_fornecido]','(51)35116500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(163,80,15,'Célio Alexandre John','[email_nao_fornecido]','(47)33333333','2019-01-23 20:05:28','2019-01-23 20:05:28'),(164,79,52,'Maurício Manica Gossling','[email_nao_fornecido]','(48)32816500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(165,6,6,'RAFAELA FRANCO ABREU','[email_nao_fornecido]','(61)20255202','2019-01-23 20:05:28','2019-01-23 20:05:28'),(166,2,1,'Dauton Luis de Andrade','[email_nao_fornecido]','(48)32036365','2019-01-23 20:05:28','2019-01-23 20:05:28'),(167,2,1,'Márcio Wesnner','[email_nao_fornecido]','(48)32036349','2019-01-23 20:05:28','2019-01-23 20:05:28'),(168,86,1,'Dr. Arnaldo Aparecido de Melo','[email_nao_fornecido]','(55)32229216','2019-01-23 20:05:28','2019-01-23 20:05:28'),(169,87,15,'Soraia Joselita Depin','[email_nao_fornecido]','(47)33697149','2019-01-23 20:05:28','2019-01-23 20:05:28'),(170,1,17,'MARCELO DONINI','[email_nao_fornecido]','(48)32512663','2019-01-23 20:05:28','2019-01-23 20:05:28'),(171,67,49,'Luciana Rosa','[email_nao_fornecido]','(48)39012796','2019-01-23 20:05:28','2019-01-23 20:05:28'),(172,88,1,'Arnaldo Aparecido de Melo','[email_nao_fornecido]','(55)32229216','2019-01-23 20:05:28','2019-01-23 20:05:28'),(173,64,2,'SARA MARTINS GOMES LOPES','[email_nao_fornecido]','(61)20268008','2019-01-23 20:05:28','2019-01-23 20:05:28'),(174,67,49,'Lenice Born da Silva','[email_nao_fornecido]','(47)33697195','2019-01-23 20:05:28','2019-01-23 20:05:28'),(175,79,52,'Alessandre Mauro Tomaz','[email_nao_fornecido]','(48)32816500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(176,89,31,'ELTON ZIEHLSDORFF','[email_nao_fornecido]','(47)33451771','2019-01-23 20:05:28','2019-01-23 20:05:28'),(177,1,3,'Diógenes Tarcísio Marcelino Teixeira','[email_nao_fornecido]','(48)300000000','2019-01-23 20:05:28','2019-01-23 20:05:28'),(178,90,3,'Flávio André Paz de Brum','[email_nao_fornecido]','(48)32245399','2019-01-23 20:05:28','2019-01-23 20:05:28'),(179,5,15,'GILBERTO OURIQUES','[email_nao_fornecido]','(48)38212062','2019-01-23 20:05:28','2019-01-23 20:05:28'),(180,91,18,'Paula Mônica Pulga','[email_nao_fornecido]','(49)35611900','2019-01-23 20:05:28','2019-01-23 20:05:28'),(181,4,13,'SAMUEL DA SILVA CARDOSO','[email_nao_fornecido]','(61)20201705','2019-01-23 20:05:28','2019-01-23 20:05:28'),(182,67,49,'Analú Liberato Longo','[email_nao_fornecido]','(48)33302131','2019-01-23 20:05:28','2019-01-23 20:05:28'),(183,92,9,'Valmi dos Santos FiIlho','[email_nao_fornecido]','(48)0','2019-01-23 20:05:28','2019-01-23 20:05:28'),(184,67,50,'HENRIQUE DA ROSA ZIESEMER','[email_nao_fornecido]','(0)0','2019-01-23 20:05:28','2019-01-23 20:05:28'),(185,48,5,'FÁBIO DE OLIVEIRA','[email_nao_fornecido]','(48)34112500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(186,82,2,'Sabrina Fontoura da Silva','[email_nao_fornecido]','(51)33330000','2019-01-23 20:05:28','2019-01-23 20:05:28'),(187,79,51,'TATIANA NUNES LIMA','[email_nao_fornecido]','(48)32816500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(188,67,49,'REJANE GULARTE QUEIROZ BEILNER','[email_nao_fornecido]','(48)36438003','2019-01-23 20:05:28','2019-01-23 20:05:28'),(189,93,5,'FÁBIO DE OLIVEIRA','[email_nao_fornecido]','(48)34112500','2019-01-23 20:05:28','2019-01-23 20:05:28'),(190,94,4,'MARIA DE LOURDES SIMAS PORTO','[email_nao_fornecido]','(48)33558038','2019-01-23 20:05:28','2019-01-23 20:05:28'),(191,95,4,'ELAINE CRISTINA DE SOUZA FREITAS','[email_nao_fornecido]','(48)32548300','2019-01-23 20:05:28','2019-01-23 20:05:28'),(192,96,19,'Osmar Jacobsen Filho','[email_nao_fornecido]','(48)39524609','2019-01-23 20:05:28','2019-01-23 20:05:28'),(193,97,7,'DINARTE ANTONIO VAZ','[email_nao_fornecido]','(41)32546365','2019-01-23 20:05:28','2019-01-23 20:05:28'),(194,1,17,'REGINALDO SOETHE','[email_nao_fornecido]','(47)33415800','2019-01-23 20:05:28','2019-01-23 20:05:28'),(195,98,1,'Jorge Alexandre Moreira','[email_nao_fornecido]','(48)39011390','2019-01-23 20:05:28','2019-01-23 20:05:28'),(196,99,6,'Thais Alvez Bruch','[email_nao_fornecido]','(48)34330558','2019-01-23 20:05:28','2019-01-23 20:05:28'),(197,96,19,'MÁárcio Macedo Mussi','[email_nao_fornecido]','(48)0','2019-01-23 20:05:28','2019-01-23 20:05:28'),(198,67,50,'Alceu Rocha','[email_nao_fornecido]','(48)33302128','2019-01-23 20:05:28','2019-01-23 20:05:28'),(199,2,1,'LUCIANO CARDOSO BACKER','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(200,46,2,'PATRICIA CORREA GARCIA RODRIGUES','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(201,47,2,'ANDREA DA SILVEIRA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(202,2,2,'CRISTIANE REGINA BORTOLINI','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(203,47,1,'CID JOSÉ FAVERO','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(204,2,2,'PATRÍCIA MONNHRAT MULIM','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(205,63,1,'RODRIGO DE SOUZA AGUIAR','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(206,64,2,'NATANNE LIRA DE MORAIS','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(207,44,1,'MARCELO COENCIÇÃO ANDRETTA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(208,45,1,'MARCOS LUIZ VALMORBIDA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(209,82,1,'HÉCIO BENDER DE OLIVEIRA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(210,2,1,'RICARDO GEWEHR SPOHR','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(211,100,4,'ANUSKA FELSKI DA SILVA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(212,79,52,'LUCAS DE PAULA RODRIGUES DA SILVA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(213,5,6,'ANGELA ROBERTA KRUGER BOSENBECKER','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(214,5,6,'ANA CLAUDIA FARIA CAFIERO','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(215,5,6,'IOLANDA MOREIRA DE JESUS','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(216,101,49,'SIMONE CRISTINA SCHULTZ CORRÊA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(217,50,5,'DANIEL LUIS DALBERTO','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(218,79,52,'JOSÉ ANTÔNIO AMARAL NETO','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(219,67,49,'LETÍCIA VINOTTI DA SILVA','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(220,102,3,'GUSTAVO DIAS DE BARCELLOS','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(221,102,3,'RODRIGO COSTA MEDEIROS','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(222,103,31,'NÃO DEFINIDO','[email_nao_fornecido]','()','2019-01-23 20:05:29','2019-01-23 20:05:29'),(223,83,1,'Emedi Camilo Vizzotto','[email_nao_fornecido]','(48)32036303','2019-01-23 20:05:29','2019-01-23 20:05:29'),(224,2,2,'Virgínia Brodbeck Bolzani','[email_nao_fornecido]','(48)32036355','2019-01-23 20:05:29','2019-01-23 20:05:29'),(225,54,5,'Andrei Mattiuzi Balvedi','[email_nao_fornecido]','(48)99999999','2019-01-23 20:05:29','2019-01-23 20:05:29'),(226,83,2,'Virgínia Brodbeck Bolzani','[email_nao_fornecido]','(48)32036355','2019-01-23 20:05:29','2019-01-23 20:05:29'),(227,49,5,'Ercias Rodrigues de Souza','[email_nao_fornecido]','(47)33211700','2019-01-23 20:05:29','2019-01-23 20:05:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demanda`
--

LOCK TABLES `demanda` WRITE;
/*!40000 ALTER TABLE `demanda` DISABLE KEYS */;
INSERT INTO `demanda` VALUES (1,1,'02313/2018','04972.005144/2017-72','informar sobre a situação tal',NULL,'2019-01-30','2019-01-23 20:13:55','2019-02-14 21:39:23',224),(2,1,'01024/2017','04972.205757/2015-46','undefined',NULL,'2018-06-18','2019-02-14 21:38:39','2019-02-14 21:38:39',114),(3,1,'01530/2018','04972.010691/2018-51','undefined',NULL,'2019-01-07','2019-02-14 21:41:45','2019-02-14 21:41:45',100),(4,1,'02321/2018','04972.008386/2018-07','undefined',NULL,'2018-11-13','2019-02-14 21:44:01','2019-02-14 21:44:01',226),(5,1,'02477/2018','04972.005805/2017-60','undefined',NULL,'2018-11-20','2019-02-14 21:46:09','2019-02-14 21:46:09',226),(6,1,'02705/2018','05022.000974/2002-29','undefined',NULL,'2018-12-14','2019-02-14 21:47:54','2019-02-14 21:47:54',100),(7,1,'04264/2018','04972.005990/2018-73','undefined',NULL,'2018-10-09','2019-02-14 21:49:55','2019-02-14 21:49:55',86),(8,1,'05979/2018','04972.002880/2013-45','undefined',NULL,'2019-02-04','2019-02-14 21:50:59','2019-02-14 21:50:59',89),(9,1,'00009/2019','04972.003497/2017-38','undefined',NULL,'2019-01-23','2019-02-14 21:53:51','2019-02-14 21:53:51',100),(10,1,'00030/2019','00552.000186/2015-45','undefined',NULL,'2019-01-24','2019-02-14 21:55:29','2019-02-14 21:55:29',100),(11,1,'00035/2019','04972.000697/2019-09','undefined',NULL,'2019-02-08','2019-02-14 21:58:34','2019-02-14 21:58:34',99),(12,1,'00037/2019','04972.000529/2019-13','undefined',NULL,'2019-02-05','2019-02-14 21:59:53','2019-02-14 21:59:53',100),(13,1,'00073/2019','04972.206605/2015-61','undefined',NULL,'2019-02-23','2019-02-14 22:01:30','2019-02-14 22:01:30',82),(14,1,'01193/2018','04972.006141/2017-56','undefined',NULL,'2018-12-03','2019-02-14 22:04:02','2019-02-14 22:04:02',225);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demandamovimentacao`
--

LOCK TABLES `demandamovimentacao` WRITE;
/*!40000 ALTER TABLE `demandamovimentacao` DISABLE KEYS */;
INSERT INTO `demandamovimentacao` VALUES (1,1,2,3,1,'2019-01-23 20:13:55','2019-01-23 20:13:55'),(2,1,2,4,1,'2019-01-23 20:13:55','2019-01-23 20:13:55'),(3,2,2,3,1,'2019-02-14 21:38:39','2019-02-14 21:38:39'),(4,3,2,3,1,'2019-02-14 21:41:45','2019-02-14 21:41:45'),(5,4,2,3,1,'2019-02-14 21:44:01','2019-02-14 21:44:01'),(6,5,2,3,1,'2019-02-14 21:46:09','2019-02-14 21:46:09'),(7,6,2,3,1,'2019-02-14 21:47:54','2019-02-14 21:47:54'),(8,7,2,3,1,'2019-02-14 21:49:55','2019-02-14 21:49:55'),(9,8,2,3,1,'2019-02-14 21:50:59','2019-02-14 21:50:59'),(10,9,2,3,1,'2019-02-14 21:53:51','2019-02-14 21:53:51'),(11,10,2,3,1,'2019-02-14 21:55:29','2019-02-14 21:55:29'),(12,11,2,3,1,'2019-02-14 21:58:34','2019-02-14 21:58:34'),(13,12,2,3,1,'2019-02-14 21:59:53','2019-02-14 21:59:53'),(14,13,2,3,1,'2019-02-14 22:01:30','2019-02-14 22:01:30'),(15,14,2,3,1,'2019-02-14 22:04:02','2019-02-14 22:04:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `divisaoorganograma`
--

LOCK TABLES `divisaoorganograma` WRITE;
/*!40000 ALTER TABLE `divisaoorganograma` DISABLE KEYS */;
INSERT INTO `divisaoorganograma` VALUES (1,NULL,'Superintendência do Patrimônio da União em Santa Catarina','SPU-SC',NULL,NULL),(2,1,'Divisão de Gestão Estratégica e Recursos Internos','DIGES-SPU-SC',NULL,NULL),(3,1,'Coordenação da Caracterização e Incorporação','COCAI-SPU-SC',NULL,NULL),(4,1,'Coordenação de Destinação','CODES-SPU-SC',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2018_07_27_190714_create_tipoprocesso_table',1),(4,'2018_12_03_190346_cria_tipo_processo',1),(5,'2018_12_03_190627_cria_tipo_documento',1),(6,'2018_12_03_191356_popula_tipo_documento',1),(7,'2018_12_04_135119_cria_cargo',1),(8,'2018_12_04_135354_cria_orgao',1),(9,'2018_12_04_190954_cria_demanda',1),(10,'2018_12_04_192350_cria_autor_demanda',1),(11,'2019_01_09_192830_demanda__cria__f_k__autor_demanda',1),(12,'2019_01_10_192845_create_divisao_organogramas_table',1),(13,'2019_01_10_193549_create_demanda_movimentacaos_table',1),(14,'2019_02_13_004643_create_permissao',2),(15,'2019_02_13_004908_cria__usuario_permissao',2);
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
-- Table structure for table `permissao`
--

DROP TABLE IF EXISTS `permissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permissao` char(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissao`
--

LOCK TABLES `permissao` WRITE;
/*!40000 ALTER TABLE `permissao` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissao` ENABLE KEYS */;
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

--
-- Table structure for table `usuariopermissao`
--

DROP TABLE IF EXISTS `usuariopermissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuariopermissao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `idUsuario` int(10) unsigned NOT NULL,
  `idPermissao` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usuariopermissao_idusuario_foreign` (`idUsuario`),
  KEY `usuariopermissao_idpermissao_foreign` (`idPermissao`),
  CONSTRAINT `usuariopermissao_idpermissao_foreign` FOREIGN KEY (`idPermissao`) REFERENCES `permissao` (`id`),
  CONSTRAINT `usuariopermissao_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariopermissao`
--

LOCK TABLES `usuariopermissao` WRITE;
/*!40000 ALTER TABLE `usuariopermissao` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuariopermissao` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-15 16:50:20
