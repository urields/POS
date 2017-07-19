-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.18-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema posisdb_csharp
--

/*CREATE DATABASE /*!32312 IF NOT EXISTS*/ posisdb_csharp;
USE posisdb_csharp;*/

--
-- Table structure for table `posisdb_csharp`.`attransactiondetails`
--

DROP TABLE IF EXISTS `attransactiondetails`;
CREATE TABLE `attransactiondetails` (
  `ATTDID` int(10) unsigned NOT NULL auto_increment,
  `ATPrice` double NOT NULL default '0',
  `Quantity` int(10) unsigned NOT NULL default '0',
  `ProductName` varchar(64) NOT NULL default '',
  `ATInvoiceNo` varchar(45) NOT NULL default '',
  PRIMARY KEY  (`ATTDID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `posisdb_csharp`.`atvoucher`
--

DROP TABLE IF EXISTS `atvoucher`;
CREATE TABLE `atvoucher` (
  `ATVoucherID` int(10) unsigned NOT NULL auto_increment,
  `Supplier` varchar(45) NOT NULL default '',
  `Product` varchar(45) NOT NULL default '',
  `VoucherNo` varchar(45) NOT NULL default '',
  `ExpiryDate` varchar(45) NOT NULL default '',
  `PINNo` varchar(45) NOT NULL default '',
  PRIMARY KEY  (`ATVoucherID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `posisdb_csharp`.`category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CategoryNo` int(10) unsigned NOT NULL auto_increment,
  `CategoryName` varchar(45) NOT NULL default '',
  `Description` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`CategoryNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `posisdb_csharp`.`company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `CompanyID` int(10) unsigned NOT NULL auto_increment,
  `Name` varchar(250) NOT NULL default '',
  `Address` varchar(250) default '',
  `PhoneNo` varchar(45) default '',
  `Email` varchar(100) default '',
  `Website` varchar(100) default '',
  `TINNumber` varchar(100) default '',
  PRIMARY KEY  (`CompanyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posisdb_csharp`.`company`
--

!40000 ALTER TABLE `company` DISABLE KEYS ;
INSERT INTO `company` (`CompanyID`,`Name`,`Address`,`PhoneNo`,`Email`,`Website`,`TINNumber`) VALUES 
 (1,'HACHIKO Tienda Para Mascotas','Ecatepec, Edo. de Mexico','55 7693 8030','hachikoventas@gmail.com','www.cvss.com','0');
!40000 ALTER TABLE `company` ENABLE KEYS ;


--
-- Table structure for table `posisdb_csharp`.`payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `paymentNo` int(10) unsigned NOT NULL auto_increment,
  `InvoiceNo` int(10) unsigned NOT NULL default '0',
  `Cash` double NOT NULL default '0',
  `PChange` double NOT NULL default '0',
  PRIMARY KEY  (`paymentNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `posisdb_csharp`.`product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ProductNo` int(10) unsigned NOT NULL auto_increment,
  `ProductCode` varchar(45) NOT NULL default '',
  `Description` varchar(200) NOT NULL default '',
  `Barcode` varchar(50) NOT NULL default '',
  `UnitPrice` double NOT NULL default '0',
  `StocksOnHand` double NOT NULL default '0',
  `ReorderLevel` int(10) unsigned NOT NULL default '0',
  `CategoryNo` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ProductNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table product add column WholesalePrice double after UnitPrice;
alter table product add column UnitCost double NOT NULL default 1 after UnitPrice;
alter table product add UNIQUE (ProductCode);

--
-- Table structure for table `posisdb_csharp`.`staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `StaffID` int(10) unsigned NOT NULL auto_increment,
  `Lastname` varchar(45) NOT NULL default '',
  `Firstname` varchar(45) NOT NULL default '',
  `MI` varchar(1) NOT NULL default '',
  `Street` varchar(45) NOT NULL default '',
  `Barangay` varchar(45) NOT NULL default '',
  `City` varchar(45) NOT NULL default '',
  `Province` varchar(45) NOT NULL default '',
  `ContactNo` varchar(45) NOT NULL default '',
  `Username` varchar(45) NOT NULL default '',
  `Role` varchar(45) NOT NULL default '',
  `UPassword` varchar(45) NOT NULL default '',
  PRIMARY KEY  (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



--
-- Table structure for table `posisdb_csharp`.`stockin`
--

DROP TABLE IF EXISTS `stockin`;
CREATE TABLE `stockin` (
  `StockInNo` int(10) unsigned NOT NULL auto_increment,
  `ProductNo` int(10) unsigned NOT NULL default '0',
  `Quantity` double NOT NULL default '0',
  `DateIn` varchar(45) NOT NULL default '',
  PRIMARY KEY  (`StockInNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `posisdb_csharp`.`transactiondetails`
--

DROP TABLE IF EXISTS `transactiondetails`;
CREATE TABLE `transactiondetails` (
  `TDetailNo` int(10) unsigned NOT NULL auto_increment,
  `InvoiceNo` varchar(50) NOT NULL default '',
  `ProductNo` int(10) unsigned NOT NULL default '0',
  `ItemPrice` double NOT NULL default '0',
  `Quantity` double NOT NULL default '0',
  `Discount` double NOT NULL default '0',
  PRIMARY KEY  (`TDetailNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `posisdb_csharp`.`transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `InvoiceNo` int(10) unsigned NOT NULL auto_increment,
  `TDate` varchar(45) NOT NULL default '',
  `TTime` varchar(45) NOT NULL default '',
  `NonVatTotal` double NOT NULL default '0',
  `VatAmount` double NOT NULL default '0',
  `TotalAmount` varchar(45) NOT NULL default '',
  `StaffID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`InvoiceNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `posisdb_csharp`.`vatsetting`
--

DROP TABLE IF EXISTS `vatsetting`;
CREATE TABLE `vatsetting` (
  `VatID` int(10) unsigned NOT NULL auto_increment,
  `VatPercent` double NOT NULL default '0',
  PRIMARY KEY  (`VatID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posisdb_csharp`.`vatsetting`
--

/*!40000 ALTER TABLE `vatsetting` DISABLE KEYS */;
/*INSERT INTO `vatsetting` (`VatID`,`VatPercent`) VALUES 
 (2,20);*/
/*!40000 ALTER TABLE `vatsetting` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
