-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: docman
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add building',7,'add_building'),(26,'Can change building',7,'change_building'),(27,'Can delete building',7,'delete_building'),(28,'Can view building',7,'view_building'),(29,'Can add project',8,'add_project'),(30,'Can change project',8,'change_project'),(31,'Can delete project',8,'delete_project'),(32,'Can view project',8,'view_project'),(33,'Can add document status',9,'add_documentstatus'),(34,'Can change document status',9,'change_documentstatus'),(35,'Can delete document status',9,'delete_documentstatus'),(36,'Can view document status',9,'view_documentstatus'),(37,'Can add document',10,'add_document'),(38,'Can change document',10,'change_document'),(39,'Can delete document',10,'delete_document'),(40,'Can view document',10,'view_document');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$zLCasEEhhonIMpz1PJHhqY$vmylLlyg04hyUytp3b4IvIRX/OXSgAGNwOSDF1SqnR8=','2023-07-07 10:11:04.000000',1,'admin','','','admin@mail.ru',1,1,'2023-07-07 10:10:00.000000'),(2,'pbkdf2_sha256$600000$SgONpiNVHQicAG7zyoIKx1$q5g3DmYhcFIpWoQ6G85ZiRSL5arNLITO268g/fvbGvM=',NULL,0,'EKChizhov','Эдуард','Чижов','',0,1,'2023-07-07 11:49:32.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-07-07 10:11:15.798715','1','admin',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(2,'2023-07-07 10:30:41.915299','1','Project object (1)',1,'[{\"added\": {}}]',8,1),(3,'2023-07-07 10:31:06.132552','2','Project object (2)',1,'[{\"added\": {}}]',8,1),(4,'2023-07-07 10:33:38.231706','3','БАЭС',1,'[{\"added\": {}}]',8,1),(5,'2023-07-07 11:46:55.430341','1','Создан',1,'[{\"added\": {}}]',9,1),(6,'2023-07-07 11:47:02.871980','2','Разработан',1,'[{\"added\": {}}]',9,1),(7,'2023-07-07 11:47:46.799676','3','На согласовании',1,'[{\"added\": {}}]',9,1),(8,'2023-07-07 11:47:52.067561','4','Согласован',1,'[{\"added\": {}}]',9,1),(9,'2023-07-07 11:47:59.058307','5','Действующий',1,'[{\"added\": {}}]',9,1),(10,'2023-07-07 11:48:02.962175','6','Аннулирован',1,'[{\"added\": {}}]',9,1),(11,'2023-07-07 11:48:41.845531','1','10UJA',1,'[{\"added\": {}}]',7,1),(12,'2023-07-07 11:48:53.474603','2','10UKD',1,'[{\"added\": {}}]',7,1),(13,'2023-07-07 11:49:32.221885','2','EKChizhov',1,'[{\"added\": {}}]',4,1),(14,'2023-07-07 11:49:59.070307','2','EKChizhov',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]',4,1),(15,'2023-07-07 11:54:50.270065','1','10ELA',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',7,1),(16,'2023-07-07 11:54:56.074078','2','10EKD',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',7,1),(17,'2023-07-07 12:06:41.580571','1','BLT.D.0001.1.0UJA00&&&&&&.012.DC.0001',1,'[{\"added\": {}}]',10,1),(18,'2023-07-07 12:06:58.111181','1','10UJA',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',7,1),(19,'2023-07-07 12:07:04.824348','2','10UKD',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',7,1),(20,'2023-07-07 12:07:09.039829','1','BLT.D.0001.1.0UJA00&&&&&&.012.DC.0001',2,'[]',10,1),(21,'2023-07-10 11:12:57.203448','1','10NJA',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',7,1),(22,'2023-07-10 11:13:01.520205','2','10NKD',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',7,1),(23,'2023-07-10 11:13:24.463580','1','BLT.D.0001.1.0NJA00&&&&&&.001.DC.0001',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',10,1),(24,'2023-07-10 11:14:06.327297','2','BLT.D.0001.1.0NJA00&&&&&&.001.DC.0002',1,'[{\"added\": {}}]',10,1),(25,'2023-07-10 13:30:55.319592','3','БАЭС',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',8,1),(26,'2023-07-10 13:30:59.886106','2','БелАЭС',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',8,1),(27,'2023-07-10 13:31:10.294361','1','ЛАЭС',2,'[{\"changed\": {\"fields\": [\"Code\"]}}]',8,1),(28,'2023-07-10 14:29:00.610893','1','ЛАЭС',2,'[]',8,1),(29,'2023-07-10 14:29:02.261018','2','БелАЭС',2,'[]',8,1),(30,'2023-07-10 14:29:03.818428','3','БАЭС',2,'[]',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'doc_manager','building'),(10,'doc_manager','document'),(9,'doc_manager','documentstatus'),(8,'doc_manager','project'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-07-07 10:07:11.540280'),(2,'auth','0001_initial','2023-07-07 10:07:11.697119'),(3,'admin','0001_initial','2023-07-07 10:07:11.735176'),(4,'admin','0002_logentry_remove_auto_add','2023-07-07 10:07:11.741178'),(5,'admin','0003_logentry_add_action_flag_choices','2023-07-07 10:07:11.746176'),(6,'contenttypes','0002_remove_content_type_name','2023-07-07 10:07:11.772176'),(7,'auth','0002_alter_permission_name_max_length','2023-07-07 10:07:11.791177'),(8,'auth','0003_alter_user_email_max_length','2023-07-07 10:07:11.803177'),(9,'auth','0004_alter_user_username_opts','2023-07-07 10:07:11.808177'),(10,'auth','0005_alter_user_last_login_null','2023-07-07 10:07:11.826177'),(11,'auth','0006_require_contenttypes_0002','2023-07-07 10:07:11.827176'),(12,'auth','0007_alter_validators_add_error_messages','2023-07-07 10:07:11.832175'),(13,'auth','0008_alter_user_username_max_length','2023-07-07 10:07:11.852177'),(14,'auth','0009_alter_user_last_name_max_length','2023-07-07 10:07:11.871176'),(15,'auth','0010_alter_group_name_max_length','2023-07-07 10:07:11.882177'),(16,'auth','0011_update_proxy_permissions','2023-07-07 10:07:11.888176'),(17,'auth','0012_alter_user_first_name_max_length','2023-07-07 10:07:11.909178'),(18,'sessions','0001_initial','2023-07-07 10:07:11.921176'),(19,'doc_manager','0001_initial','2023-07-07 10:29:34.546684'),(20,'doc_manager','0002_documentstatus_document','2023-07-07 11:32:45.072180'),(21,'doc_manager','0003_project_code_alter_document_date_creation_and_more','2023-07-10 13:30:08.322990');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('u9no8rjubibpvnif8cy3xiisna25s5xg','.eJxVjMsOwiAQRf-FtSEIHR4u3fcbmgFmpGogKe3K-O_apAvd3nPOfYkJt7VMW6dlmrO4iLM4_W4R04PqDvId663J1Oq6zFHuijxol2PL9Lwe7t9BwV6-dXDeKGYTyAFFdEZnHdFnUB5gsOgtWW20jyEnIvYhDhaYAUAxaWvE-wPdWjfJ:1qHiQa:X2DhzQsL3XYWkqfHZ0N1FBd11cSTNWIte3yBGBPKWjA','2023-07-21 10:11:04.329111');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_manager_building`
--

DROP TABLE IF EXISTS `doc_manager_building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doc_manager_building` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(5) NOT NULL,
  `name` varchar(45) NOT NULL,
  `project_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doc_manager_building_project_id_882a5803_fk_doc_manag` (`project_id`),
  CONSTRAINT `doc_manager_building_project_id_882a5803_fk_doc_manag` FOREIGN KEY (`project_id`) REFERENCES `doc_manager_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_manager_building`
--

LOCK TABLES `doc_manager_building` WRITE;
/*!40000 ALTER TABLE `doc_manager_building` DISABLE KEYS */;
INSERT INTO `doc_manager_building` VALUES (1,'10NJA','Здание реактора',3),(2,'10NKD','Здание безопасности',3);
/*!40000 ALTER TABLE `doc_manager_building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_manager_document`
--

DROP TABLE IF EXISTS `doc_manager_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doc_manager_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date_creation` datetime(6) NOT NULL,
  `date_update` datetime(6) DEFAULT NULL,
  `building_id` bigint NOT NULL,
  `developer_id` int NOT NULL,
  `status_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doc_manager_document_building_id_26381625_fk_doc_manag` (`building_id`),
  KEY `doc_manager_document_developer_id_9f339b6d_fk_auth_user_id` (`developer_id`),
  KEY `doc_manager_document_status_id_8efe34d7_fk_doc_manag` (`status_id`),
  CONSTRAINT `doc_manager_document_building_id_26381625_fk_doc_manag` FOREIGN KEY (`building_id`) REFERENCES `doc_manager_building` (`id`),
  CONSTRAINT `doc_manager_document_developer_id_9f339b6d_fk_auth_user_id` FOREIGN KEY (`developer_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `doc_manager_document_status_id_8efe34d7_fk_doc_manag` FOREIGN KEY (`status_id`) REFERENCES `doc_manager_documentstatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_manager_document`
--

LOCK TABLES `doc_manager_document` WRITE;
/*!40000 ALTER TABLE `doc_manager_document` DISABLE KEYS */;
INSERT INTO `doc_manager_document` VALUES (1,'BLT.D.0001.1.0NJA00&&&&&&.001.DC.0001','Здание реактора. Перекрытие на отметке 0.000','2023-07-07 12:06:41.579779','2023-07-10 11:13:24.462580',1,2,1),(2,'BLT.D.0001.1.0NJA00&&&&&&.001.DC.0002','Здание реактора. Стены на отметке 0.000','2023-07-10 11:14:06.324871','2023-07-10 11:14:06.324871',1,2,1);
/*!40000 ALTER TABLE `doc_manager_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_manager_documentstatus`
--

DROP TABLE IF EXISTS `doc_manager_documentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doc_manager_documentstatus` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_manager_documentstatus`
--

LOCK TABLES `doc_manager_documentstatus` WRITE;
/*!40000 ALTER TABLE `doc_manager_documentstatus` DISABLE KEYS */;
INSERT INTO `doc_manager_documentstatus` VALUES (1,'Создан'),(2,'Разработан'),(3,'На согласовании'),(4,'Согласован'),(5,'Действующий'),(6,'Аннулирован');
/*!40000 ALTER TABLE `doc_manager_documentstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_manager_project`
--

DROP TABLE IF EXISTS `doc_manager_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doc_manager_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_short` varchar(45) NOT NULL,
  `name_full` varchar(120) NOT NULL,
  `country` varchar(120) NOT NULL,
  `code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_manager_project`
--

LOCK TABLES `doc_manager_project` WRITE;
/*!40000 ALTER TABLE `doc_manager_project` DISABLE KEYS */;
INSERT INTO `doc_manager_project` VALUES (1,'ЛАЭС','Ленинградская АЭС','Россия','LN'),(2,'БелАЭС','Белорусская АЭС','Белоруссия','BLR'),(3,'БАЭС','Балтийская АЭС','Россия','BLT');
/*!40000 ALTER TABLE `doc_manager_project` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-10 18:01:21
