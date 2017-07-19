-- MySQL dump 10.13  Distrib 5.6.26, for Win64 (x86_64)
--
-- Host: localhost    Database: posisdb_csharp
-- ------------------------------------------------------
-- Server version	5.6.26-log

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
-- Table structure for table `attransactiondetails`
--

DROP TABLE IF EXISTS `attransactiondetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attransactiondetails` (
  `ATTDID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ATPrice` double NOT NULL DEFAULT '0',
  `Quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `ProductName` varchar(64) NOT NULL DEFAULT '',
  `ATInvoiceNo` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`ATTDID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attransactiondetails`
--

LOCK TABLES `attransactiondetails` WRITE;
/*!40000 ALTER TABLE `attransactiondetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `attransactiondetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atvoucher`
--

DROP TABLE IF EXISTS `atvoucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atvoucher` (
  `ATVoucherID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Supplier` varchar(45) NOT NULL DEFAULT '',
  `Product` varchar(45) NOT NULL DEFAULT '',
  `VoucherNo` varchar(45) NOT NULL DEFAULT '',
  `ExpiryDate` varchar(45) NOT NULL DEFAULT '',
  `PINNo` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`ATVoucherID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atvoucher`
--

LOCK TABLES `atvoucher` WRITE;
/*!40000 ALTER TABLE `atvoucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `atvoucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `CategoryNo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(45) NOT NULL DEFAULT '',
  `Description` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`CategoryNo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'ALIMENTO','ALIMENTO'),(2,'JUGUETES','JUGUETES'),(3,'CAMAS Y TRANSPORTADORAS','CAMAS Y TRANSPORTADORAS'),(4,'HIGIENE','HIGIENE'),(5,'ALIMENTADORES','ALIMENTADORES'),(6,'ENTRENAMIENTO','ENTRENAMIENTO'),(7,'ACCESORIOS','ACCESORIOS'),(8,'ACUARIO  Y OTRAS MASCOTAS','ACUARIO  Y OTRAS MASCOTAS');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `CompanyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(250) NOT NULL DEFAULT '',
  `Address` varchar(250) DEFAULT '',
  `PhoneNo` varchar(45) DEFAULT '',
  `Email` varchar(100) DEFAULT '',
  `Website` varchar(100) DEFAULT '',
  `TINNumber` varchar(100) DEFAULT '',
  PRIMARY KEY (`CompanyID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Hachiko Tienda Para Mascotas','Alhelies 132, Ecatepec, Edo. Mexico ','55 7693 8030','hachikoventas@gmail.com','http://www.hachiko.mypets.ws','');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `paymentNo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `InvoiceNo` int(10) unsigned NOT NULL DEFAULT '0',
  `Cash` double NOT NULL DEFAULT '0',
  `PChange` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`paymentNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,2,20,3.5);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `ProductNo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ProductCode` varchar(45) NOT NULL DEFAULT '',
  `Description` varchar(200) NOT NULL DEFAULT '',
  `Barcode` varchar(50) NOT NULL DEFAULT '',
  `UnitPrice` double NOT NULL DEFAULT '0',
  `UnitCost` double NOT NULL DEFAULT '1',
  `WholesalePrice` double DEFAULT NULL,
  `StocksOnHand` double NOT NULL DEFAULT '0',
  `ReorderLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `CategoryNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ProductNo`),
  UNIQUE KEY `ProductCode` (`ProductCode`)
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'1','Pedigree cahorro Pollo ','706460249361',9,7.9,NULL,6,2,1),(2,'2','Pedigree cachorro Res','706460249316',9,7.9,NULL,6,2,1),(3,'3','Pedigree adulto balance N. Res','706460249248',9,7.9,NULL,6,2,1),(4,'4','Pedigree adulto Res','706460249279',9,7.9,NULL,6,2,1),(5,'5','Pedigree lata adulto Res','706460235920',28,25,NULL,1,2,1),(6,'6','Pedigree lata adulto Pollo','706460236101',28,25,NULL,2,2,1),(7,'7','Lata Pro Plan Critical Nutrition','',35,26.6,NULL,6,2,1),(8,'8','Lata Pro Plan adulto','38100026743',45,33.15,NULL,6,2,1),(9,'9','Lata Pro Plan puppy','38100026712',45,33.15,NULL,0,2,1),(10,'10','Snacks Premios Hills Pollo','52742187501',120,96,NULL,1,2,1),(11,'11','Snacks Premios Hills Manzana','52742187303',120,96,NULL,1,2,1),(12,'12','Snacks Premios Hills Arandano','52742187204',120,96,NULL,1,2,1),(13,'13','Crackers Premios res PETS','7501556439144',33,18,NULL,1,2,1),(14,'14','Doggies Premios salchichas PETS','7501556437485',49,34,NULL,1,2,1),(15,'15','Premios  pollo YUMMY','7501556438420',0,0,NULL,0,2,1),(16,'16','Premios  chocolate YUMMY','7501556438413',26,14,NULL,1,2,1),(17,'17','Abrazzos Purina Mix del campo','17800158169',0,0,NULL,0,2,1),(18,'18','Abrazzos Purina Empanaditas ','17800158190',0,0,NULL,0,2,1),(19,'19','Abrazzos Purina Stars','17800170888',48,36,NULL,3,2,1),(20,'20','Smoochies PURINA','38100175175',55,42.5,NULL,6,2,1),(21,'21','Palitos de Carnaza PETS','',43,30,NULL,1,2,1),(22,'22','nupec razas pequeñas','7503008553279',78,475,620,8,2,1),(23,'23','nupec adulto ','7503008553231',68,930,1209,20,2,1),(24,'24','nupec cachorro','7503008553033',80,1100,1430,20,2,1),(25,'25','nupec senior','7503008553965',240,185,240,1,2,1),(26,'26','nupec weight control','7503008553477',247,190,247,1,2,1),(27,'27','Dog chow adulto Razas pequeñas','',0,0,NULL,0,2,1),(28,'28','Dog chow adulto  Razas medianas y grandes','',33,720,820,24.5,2,1),(29,'29','dog chow cachorro','7501072207333',39,675,780,19.5,2,1),(30,'30','campeon adulto','',25,520,650,25,2,1),(31,'31','cat chow','',37,630,730,20,2,1),(32,'32','minino','',29,354,454,15,2,1),(33,'33','Minino Plus','',38,319,410,0,2,1),(34,'34','Diamond premium  Adult','74198010400',83,1002,1350,1,2,1),(35,'35','Diamond puppy','74198002405',92,1110,1450,1,2,1),(36,'36','Diamond Puppy 8 lbs','74198002085',340,262,340,1,2,1),(37,'37','Diamond Naturals','74198608164',907,698,907,1,2,1),(38,'38','Proplan adulto','7501072204691',95,1090,1470,1,2,1),(39,'39','proplan cachorro','7501072204585',110,1260,1638,1,2,1),(40,'40','sobre whiskas  Pollo','706460000658',0,0,NULL,0,2,1),(41,'41','sobre whiskas  Mixto','706460000740',0,0,NULL,0,2,1),(42,'42','sobre whiskas  Pavo ','706460000672',0,0,NULL,0,2,1),(43,'43','sobre whiskas  Atún','706460000665',0,235,9,32,2,1),(44,'44','Don can bachoco','7503018223292',17,305,425,25,2,1),(45,'45','sobres dog chow ','17800171267',11,200,11,24,2,1),(46,'46','pedigree adulto','',32,695,800,25,2,1),(47,'47','pedigree cachorro','',36,620,720,20,2,1),(48,'48','Ganador Adulto premium','',39,648,780,20,2,1),(49,'49','Ganador Estándar','',30,631,750,0,2,1),(50,'50','kitten bolsa 500grs','7501777034586',38,360,38,0,2,1),(51,'51','lata proplan kitten 85 grs','38100026903',21,0,NULL,0,2,1),(52,'52','lata proplan urinary 85 grs','38100173409',21,0,NULL,0,2,1),(53,'53','minino plus','',380,319,38,10,2,1),(54,'54','Huesos Medianos de carnaza','98765432170215',130,105,NULL,12,2,1),(55,'55','Nerf balon ','846998080910',120,92,NULL,1,2,2),(56,'56','Nerf pelota p/jalar Nylon y cuerda','846998080941',195,146,NULL,1,2,2),(57,'57','Nerf Bala','846998021982',195,140,NULL,1,2,2),(58,'58','Kong Gyro CH','35585034188',295,211,NULL,1,2,2),(59,'59','Kong extreme M','35585111148',270,197,NULL,1,2,2),(60,'60','Kong Classic CH','35585111315',175,125,NULL,1,2,2),(61,'61','Pera Pet Sport Mojo cherry','713080400706',0,0,NULL,0,2,2),(62,'62','Pera Pet Sport Mojo blueberry','713080400706',185,142,NULL,2,2,2),(63,'63','Jaladera Godzilla','29695520396',345,260,NULL,1,2,2),(64,'64','Angry birds','32700130114',95,64,NULL,1,2,2),(65,'65','Dolly M','8141994440501',175,116,NULL,1,2,2),(66,'66','Dolly CH','8141994440426',145,97,NULL,1,2,2),(67,'67','Nudos G','7501556472578',40,20,NULL,1,2,2),(68,'68','Nudos M','7501556472561',40,20,NULL,1,2,2),(69,'69','Nudos CH','7501556472561',40,20,NULL,1,2,2),(70,'70','Nudo con pelota SEVEN PET','7502271358543',60,40,NULL,1,2,2),(71,'71','Pelota tejida con cuerda','7812235529',100,78,NULL,1,2,2),(72,'72','juguete de hilo','7501556472868',0,0,NULL,0,2,2),(73,'73','cama chica','',130,91,NULL,2,2,3),(74,'74','cama mediana','',145,101,NULL,2,2,3),(75,'75','cama grande','',165,115,NULL,2,2,3),(76,'76','cama extra grande','',185,100,NULL,2,2,3),(77,'77','tapete 1','',70,49,NULL,1,2,3),(78,'78','tapete 2','',80,56,NULL,1,2,3),(79,'79','tapete 3','',110,77,NULL,1,2,3),(80,'80','tapete 4','',160,112,NULL,1,2,3),(81,'81','tapete 5','',200,140,NULL,1,2,3),(82,'82','tapete 6','',230,161,NULL,1,2,3),(83,'83','tapete 7','',250,175,NULL,1,2,3),(84,'84','Transportadora 7502','',350,250,NULL,0,2,3),(85,'85','Transportadora 7504','',690,520,NULL,0,2,3),(86,'86','Transportadora 7506','',1090,763,NULL,1,2,3),(87,'87','Transportadora 7508','',1705,1200,NULL,1,2,3),(88,'88','tansportadoras tela CH','',160,150,NULL,1,2,3),(89,'89','tansportadoras tela M','',200,150,NULL,1,2,3),(90,'90','tansportadoras tela G','',250,150,NULL,1,2,3),(91,'91','Carda Plástico Ch Verde','',35,0,NULL,2,2,4),(92,'92','Carda Plástico Med Azul','',45,0,NULL,2,2,4),(93,'93','Cepillo doble de puntas redondas HARTZ','',135,100,NULL,2,2,4),(94,'94','Cepillo doble de puntas redondas le salon','',205,155,NULL,1,2,4),(95,'95','Cepillo doble de puntas redondas  CH','',55,0,NULL,1,2,4),(96,'96','Cepillo de puntas redondas','',40,0,NULL,1,2,4),(97,'97','Cepillo \"T\" quita nudos','',85,0,NULL,1,2,4),(98,'98','Carda Pro','',110,0,NULL,2,2,4),(99,'99','Furminator short hair','',930,714,NULL,1,2,4),(100,'100','Furminator long hair','',950,714,NULL,1,2,4),(101,'101','Removedor de pelo muerto le salon ','',270,179,NULL,1,2,4),(102,'102','Bolsas Poop-off','',45,34,NULL,3,2,4),(103,'103','Dispensador para bolsas','',25,15,NULL,3,2,4),(104,'104','Toallas humedas ','',39,25,NULL,4,2,4),(105,'105','Asuntol jabón','',56,43,NULL,2,2,4),(106,'106','Jabón de avena','',35,24,NULL,2,2,4),(107,'107','Jabón Vetriderm  dermatológico','',80,60,NULL,2,2,4),(108,'108','Lassy Jaboón medicado','',60,47,NULL,2,2,4),(109,'109','Bolfo talco','',120,90,NULL,2,2,4),(110,'110','Talco antipulgas','',70,44,NULL,2,2,4),(111,'111','Dental refrescante ','',36,24,NULL,2,2,4),(112,'112','Desenredante Spray ','',45,0,NULL,1,2,4),(113,'113','Protector para muebles ','',40,0,NULL,1,2,4),(114,'114','Perfume para cachorro','',75,0,NULL,2,2,4),(115,'115','Perfume para perro Hembra','',75,0,NULL,2,2,4),(116,'116','Perfume para perro Macho','',75,0,NULL,2,2,4),(117,'117','Shampoo p/perro pelo Dorado','',32,0,NULL,1,2,4),(118,'118','Shampoo p/perro pelo Blanco','',32,0,NULL,1,2,4),(119,'119','Shampoo p/perro pelo Negro','',32,0,NULL,1,2,4),(120,'120','Shampoo p/perro aroma Coco','',32,0,NULL,1,2,4),(121,'121','Shampoo p/perro aroma Cítrico','',30,0,NULL,2,2,4),(122,'122','Shampoo p/perro aroma Uva','',32,0,NULL,2,2,4),(123,'123','Shampoo cachorro aroma Manzana ','',30,0,NULL,2,2,4),(124,'124','Spray Super Bolfo','',140,108,NULL,1,2,4),(125,'125','Recogedor para arenero','',30,19,NULL,1,2,4),(126,'126','arena para gatos Biomaa','',27,20,NULL,10,2,4),(127,'127','arena para gatos alfa 5 kg','',38,30,NULL,6,2,4),(128,'128','arenero grande ','',95,75,NULL,1,2,4),(129,'129','arenero chico','',50,30,NULL,1,2,4),(130,'130','Alimentador 2.3 kg','7501556484878',230,175,NULL,1,2,5),(131,'131','Comedero reforzado doble Tily','7501857040568',55,35,NULL,3,2,5),(132,'132','Comedero Tily','7501857070541',55,35,NULL,3,2,5),(133,'133','Comedero Tily Jumbo','7501857070565',60,0,NULL,3,2,5),(134,'134','Plato redondo Grande ','620141230131',34,20,NULL,5,2,5),(135,'135','Plato redondo Mediano ','620141230129',25,16,NULL,5,2,5),(136,'136','Plato Nanuc 22cm','7812235490',30,20,NULL,5,2,5),(137,'137','Comederos acero inox. Doble M','7501556471168',210,0,NULL,1,2,5),(138,'138','Comederos acero inox. Doble CH','7501556471151',125,0,NULL,1,2,5),(139,'139','Plato aluminio Cocker CH','620141230141',105,69,NULL,2,2,5),(140,'140','Plato doble ceramica','8154580580130',45,31,NULL,3,2,5),(141,'141','Plato de acero Inox.  8 Oz.','7501556471014',30,21,NULL,1,2,5),(142,'142','Plato de acero Inox. 16 Oz','7501556471021',46,35,NULL,1,2,5),(143,'143','Plato de acero Inox. 24 Oz','7501556471038',53,43,NULL,1,2,5),(144,'144','Plato de acero Inox. 32 Oz','7501556471045',75,55,NULL,1,2,5),(145,'145','Plato de acero Inox. 64 Oz','7501556471052',105,79,NULL,1,2,5),(146,'146','Plato de acero Inox. 96 Oz','7501556471069',135,102,NULL,1,2,5),(147,'147','alimentador mini rojo','3260545050626',135,105,NULL,1,2,5),(148,'148','happy hunting ','8138112280330',100,70,NULL,1,2,5),(149,'149','Plato para comer despacio Economico','8145600240134',55,25,NULL,3,2,5),(150,'150','Bebedero automatico 3lts.','79441007039',195,146,NULL,1,2,5),(151,'151','Bebedero automatico 5.7lts.','29695244179',325,250,NULL,1,2,5),(152,'152','Taco Dolly Gde.','',550,416,NULL,1,2,6),(153,'153','Taco Dolly Ch','',265,170,NULL,1,2,6),(154,'154','Taco Dolly Mini','',227,151,NULL,1,2,6),(155,'155','Collar de intervención Silverado G','602177005',222,152,NULL,1,2,6),(156,'156','Collar de intervención Silverado M','601093203',222,152,NULL,1,2,6),(157,'157','Collar de intervención Silverado CH','601072501',222,152,NULL,1,2,6),(158,'158','Collar  \"Zetina\" c/fieltro','859574852121',180,120,NULL,1,2,6),(159,'159','Collar tosko agitación 3cmt3','CA3CMT3',146,0,NULL,1,2,6),(160,'160','Collar tosko agitación/fiel 3cmt2 c/fieltro','AF3CMT2',168,0,NULL,1,2,6),(161,'161','Bozal \"Zetina\" Nylon/Fiel 0','859574852164',70,46.5,NULL,1,2,6),(162,'162','Bozal \"Zetina\" Nylon/Fiel 1','859574852165',80,53,NULL,1,2,6),(163,'163','Bozal \"Zetina\" Nylon/Fiel 2','859574852166',90,58,NULL,1,2,6),(164,'164','Bozal \"Zetina\" Nylon/Fiel 3','',100,64,NULL,1,2,6),(165,'165','','',105,69.99,NULL,0,2,6),(166,'166','Bozal \"Zetina\" Nylon/Fiel 5','5',115,75,NULL,3,2,6),(167,'167','','',120,0,NULL,0,2,6),(168,'168','Bozal \"Zetina\" Nylon/Fiel 7','859574852171',130,87,NULL,1,2,6),(169,'169','Halter Ch','',172,132,NULL,1,2,6),(170,'170','Halter M','',172,132,NULL,1,2,6),(171,'171','Halter G','',172,132,NULL,1,2,6),(172,'172','Cadena de castigo 2mmx55cm ','7806722312055',75,0,NULL,4,2,6),(173,'173','Cadena de castigo 2mmx40cm','2782257457612',70,0,NULL,2,2,6),(174,'174','Cadena de castigo 2mmx35cm','2782457457610',60,0,NULL,2,2,6),(175,'175','Cadena de castigo 2.5mmx55cm','7080672812555',80,0,NULL,4,2,6),(176,'176','cadena de castigo 3.5mmx75cm','7080062813575',100,0,NULL,2,2,6),(177,'177','cadena de castigo 3.5mmx70cm','7080067813570',100,0,NULL,2,2,6),(178,'178','cadena de castigo 3mmx65cm','2782757457624',100,0,NULL,2,2,6),(179,'179','cadena de castigo 3mmx45cm','2782657457618',85,0,NULL,2,2,6),(180,'180','Correa de cuero 1.80','7812233469',255,172.5,NULL,1,2,6),(181,'181','Correa de cuero fina 1.80','7201400278',219,146,NULL,1,2,6),(182,'182','Maniquera \"Zetina\" ','',105,82,NULL,1,2,6),(183,'183','Collar de semiahorque CH','',120,80,NULL,1,2,6),(184,'184','Collar de semiahorque M','',130,85,NULL,1,2,6),(185,'185','Collar de semiahorque G','',180,120,NULL,1,2,6),(186,'186','Cinturon de seguridad ','',80,60.5,NULL,2,2,7),(187,'187','correa 1.20 c/resorte','',165,110,NULL,2,2,7),(188,'188','pechera azul decorada','8138280470502',160,110,NULL,1,2,7),(189,'189','Pechera nylon reforzada de colores','8138280230601',165,110,NULL,3,2,7),(190,'190','Pechera de piel ajustable c/fieltro Mini','301283801',100,74,NULL,1,2,7),(191,'191','Collar Nylon Cachorro Decorado','98765432102215',35,24.5,NULL,11,2,7),(192,'192','Collar Nylon Mediano Decorado','7812235335',55,36.5,NULL,12,2,7),(193,'193','Correa Flexi CH','4000498003541',330,262,NULL,1,2,7),(194,'194','Cable de paseo c/asa Silverado','205201200',75,55,NULL,2,2,7),(195,'195','repuesto tapete doggy race','7501556479935',185,0,NULL,1,2,7),(196,'196','Tapete de baño Doggy Race ','7501556479928',450,360,NULL,1,2,7),(197,'197','Correa Nylon Red 3x120cm','',119,77,NULL,1,2,7),(198,'198','Correa Nylon redonda 19x1.20','',155,103,NULL,1,2,7),(199,'199','Plato portatil ','',55,36,NULL,4,2,7),(200,'200','Correa doble \"Tosko\"','',157,104,NULL,2,2,7),(201,'201','Cadena p/perro \"Wolfox\" 3.0x1.20mts','',30,20,NULL,1,2,7),(202,'202','Cadena p/perro \"Wolfox\" 3.5x1.20mts','',40,25,NULL,2,2,7),(203,'203','Correa cadena Tibet piel 1.20mts','',220,176,NULL,1,2,7),(204,'204','Collar de piel con huellitas 1','',20,0,NULL,1,2,7),(205,'205','Collar de piel con huellitas 2','',30,0,NULL,1,2,7),(206,'206','Collar de piel con huellitas 3','',40,0,NULL,1,2,7),(207,'207','Collar de piel con huellitas 4','',50,0,NULL,1,2,7),(208,'208','Collar de piel con huellitas 5','',65,0,NULL,1,2,7),(209,'209','Collar de piel con huellitas 6','',75,0,NULL,1,2,7),(210,'210','Collar de piel con huellitas 7','',85,0,NULL,1,2,7),(211,'211','Collares media Nylon','',20,13,NULL,4,2,7),(212,'212','Pecheras media Nylon','',30,19,NULL,6,2,7),(213,'213','Collares 3/4 Nylon','',32,22,NULL,5,2,7),(214,'214','Pecheras 3/4 Nylon ','',45,33,NULL,5,2,7),(215,'215','Camisa Algodón c/moño #1','7812233244',110,95,NULL,1,2,7),(216,'216','Camisa Algodón c/moño #3','7812233246',145,116,NULL,1,2,7),(217,'217','Camisa Algodón c/moño #5','7812233248',180,149,NULL,1,2,7),(218,'218','esquinero de gato','',300,225,NULL,1,2,7),(219,'219','Pechera 0','',75,53,NULL,1,2,7),(220,'220','Pechera 00','',115,91,NULL,1,2,7),(221,'221','Pechera 1','',155,113,NULL,1,2,7),(222,'222','Pechera 2','',210,154,NULL,1,2,7),(223,'223','Pechera 2.5','',240,181,NULL,1,2,7),(224,'224','Pechera 3','',330,240,NULL,1,2,7),(225,'225','Pechera 4','',360,251,NULL,1,2,7),(226,'226','Collar de nylon tipo Hartz','',70,46,NULL,2,2,7),(227,'227','Correa alpinista delgada ','',65,45,NULL,2,2,7),(228,'228','Beta pack ','',110,74,NULL,0,2,8),(229,'229','Termostato 50 W','7502271350028',120,80,NULL,0,2,8),(230,'230','Termostato 75 W','7502271355955',120,80,NULL,0,2,8),(231,'231','Bomba de aire ','7502271351193',70,48,NULL,0,2,8),(232,'232','Filtro interno de poder ','7501049341107',220,160,NULL,0,2,8),(233,'233','Difusor de aire 6','',25,16.5,NULL,0,2,8),(234,'234','Difusor de aire 8','7502215301918',30,22,NULL,0,2,8),(235,'235','Difusor de aire 10','7502215321916',35,27,NULL,0,2,8),(236,'236','Termometro vidrio ','7501369931804',24,15.5,NULL,2,2,8),(237,'237','Sifón Azul mini con perilla','7505500762777',55,38.5,NULL,1,2,8),(238,'238','Grava p/pecera ','',30,20,NULL,2,2,8),(239,'239','Alimento p/peces fin de semana ','7500211001122',10,7,NULL,1,2,8),(240,'240','Calcio para tortugas ','7500211003553',15,9,NULL,1,2,8),(241,'241','Red 2','7505500764467',10,5.5,NULL,0,2,8),(242,'242','Red 3','7505500764474',11,6.5,NULL,0,2,8),(243,'243','red 4','7505500764481',12,7.5,NULL,0,2,8),(244,'244','Red maternidad CH','',25,15.5,NULL,0,2,8),(245,'245','Alimento para cuyos RedKite','7501556440102',70,53,NULL,0,2,8),(246,'246','Mazuri alimento aves grandes','7503013897252',170,129,NULL,0,2,8),(247,'247','Mazuri alimento aves pequeñas','7503013897269',100,75,NULL,0,2,8),(248,'248','alimento para hamster Redkite','7501556404500',55,39,NULL,0,2,8),(249,'249','alimento para finches y canarios azul redkite','7501556440126',50,37,NULL,0,2,8),(250,'250','alimento para loritos y ninfas amarillo','7501556440119',50,37,NULL,0,2,8),(251,'251','alimento para conejo AZUL','7505500765228',22,15.5,NULL,0,2,8),(252,'252','alimento para  cuyos azul 450 g','7505500765235',36,27.5,NULL,0,2,8),(253,'253','alimento para hamster azul 250 grs','7505500765211',10,5,NULL,0,2,8),(254,'254','alimento para hamster azul 500 grs','7505500765204',15,10,NULL,0,2,8),(255,'255','Tortuguetas Minibits ','7502217850193',23,16,NULL,3,2,8),(256,'256','Tortuguetas inicio','7502217850100',23,16,NULL,3,2,8),(257,'257','Tortuguetas normal','7502217850018',23,16,NULL,3,2,8),(258,'258','all blue','7500211002327',10,6,NULL,0,2,8),(259,'259','clorokill','7500211001719',8,5,NULL,0,2,8),(260,'260','pentabiocare','7500211001795',11,7,NULL,0,2,8),(261,'261','permaseptic','7500211002235',12,8,NULL,0,2,8),(262,'262','hojuelas basicas para peces 10grs','7501556450033',12,0,NULL,0,2,8),(263,'263','hojuelas basicas para peces 20grs','7501556450026',17,0,NULL,0,2,8),(264,'264','hojuelas basicas para peces 30grs','7501556450019',23,0,NULL,0,2,8);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `StaffID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Lastname` varchar(45) NOT NULL DEFAULT '',
  `Firstname` varchar(45) NOT NULL DEFAULT '',
  `MI` varchar(1) NOT NULL DEFAULT '',
  `Street` varchar(45) NOT NULL DEFAULT '',
  `Barangay` varchar(45) NOT NULL DEFAULT '',
  `City` varchar(45) NOT NULL DEFAULT '',
  `Province` varchar(45) NOT NULL DEFAULT '',
  `ContactNo` varchar(45) NOT NULL DEFAULT '',
  `Username` varchar(45) NOT NULL DEFAULT '',
  `Role` varchar(45) NOT NULL DEFAULT '',
  `UPassword` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`StaffID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'System','Admin','','Alhelies','132','Ecatepec','Mexico','55 7693 8030','admin','Admin','admin'),(2,'jesus','','','','','','','','jesus','Cashier','1234');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockin`
--

DROP TABLE IF EXISTS `stockin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockin` (
  `StockInNo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ProductNo` int(10) unsigned NOT NULL DEFAULT '0',
  `Quantity` double NOT NULL DEFAULT '0',
  `DateIn` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`StockInNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockin`
--

LOCK TABLES `stockin` WRITE;
/*!40000 ALTER TABLE `stockin` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactiondetails`
--

DROP TABLE IF EXISTS `transactiondetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactiondetails` (
  `TDetailNo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `InvoiceNo` varchar(50) NOT NULL DEFAULT '',
  `ProductNo` int(10) unsigned NOT NULL DEFAULT '0',
  `ItemPrice` double NOT NULL DEFAULT '0',
  `Quantity` double NOT NULL DEFAULT '0',
  `Discount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`TDetailNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactiondetails`
--

LOCK TABLES `transactiondetails` WRITE;
/*!40000 ALTER TABLE `transactiondetails` DISABLE KEYS */;
INSERT INTO `transactiondetails` VALUES (1,'1',29,39,0.5,0),(2,'2',28,33,0.5,0);
/*!40000 ALTER TABLE `transactiondetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `InvoiceNo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TDate` varchar(45) NOT NULL DEFAULT '',
  `TTime` varchar(45) NOT NULL DEFAULT '',
  `NonVatTotal` double NOT NULL DEFAULT '0',
  `VatAmount` double NOT NULL DEFAULT '0',
  `TotalAmount` varchar(45) NOT NULL DEFAULT '',
  `StaffID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`InvoiceNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'04/27/2017','23:17:37 p. m.',19.5,0,'19.5',1),(2,'04/27/2017','23:18:32 p. m.',16.5,0,'16.5',1);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vatsetting`
--

DROP TABLE IF EXISTS `vatsetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vatsetting` (
  `VatID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `VatPercent` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`VatID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vatsetting`
--

LOCK TABLES `vatsetting` WRITE;
/*!40000 ALTER TABLE `vatsetting` DISABLE KEYS */;
INSERT INTO `vatsetting` VALUES (1,16);
/*!40000 ALTER TABLE `vatsetting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-27 23:22:57
