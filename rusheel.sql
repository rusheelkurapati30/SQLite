
CREATE TABLE `Bill_Detail` (
  `Bill_Number` varchar(10) NOT NULL,
  `Item_ID` varchar(10) NOT NULL,
  `Sold_Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Bill_Number`,`Item_ID`)
) 

LOCK TABLES `Bill_Detail` WRITE;
/*!40000 ALTER TABLE `Bill_Detail` DISABLE KEYS */;
INSERT INTO `Bill_Detail` VALUES ('BN1201','HL01',1),('BN1201','HN01',1),('BN1201','KR21',2),('BN1202','SS55',5),('BN1203','PS15',3),('BN1204','MJ1L',1),('BN1205','HL01',2),('BN1206','PS15',5),('BN1207','HL01',2),('BN1207','PS15',2);
/*!40000 ALTER TABLE `Bill_Detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER check_stock_quantity_before_insert_on_bill_detail
BEFORE INSERT
ON Bill_Detail FOR EACH ROW
BEGIN
DECLARE errorMessage VARCHAR(150);
SET errorMessage = 'Insufficient stock';
IF (SELECT Stock_Quantity FROM Items WHERE Items.Item_ID = new.Item_ID) < new.Sold_Quantity
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = errorMessage;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE TRIGGER after_insert_on_bill_detail
AFTER INSERT
ON Bill_Detail FOR EACH ROW
UPDATE Bill_Detail, Items SET Stock_Quantity = Stock_Quantity - Sold_Quantity WHERE GET_LATEST_BILL_NUMBER() = Bill_Number AND Bill_Detail.Item_ID = Items.Item_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Bill_Header`
--

DROP TABLE IF EXISTS `Bill_Header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bill_Header` (
  `Bill_Number` varchar(10) NOT NULL,
  `Bill_Date` varchar(10) NOT NULL,
  `Customer_ID` varchar(10) NOT NULL,
  `Cashier_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Bill_Number`),
  CONSTRAINT `Bill_Header` FOREIGN KEY (`Customer_ID`) REFERENCES `Customer` (`Customer_ID`),
  CONSTRAINT `Bill_Header` FOREIGN KEY (`Cashier_ID`) REFERENCES `Cashier` (`Cashier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bill_Header`
--

LOCK TABLES `Bill_Header` WRITE;
/*!40000 ALTER TABLE `Bill_Header` DISABLE KEYS */;
INSERT INTO `Bill_Header` VALUES ('BN1201','02/Oct/20','102','c1003'),('BN1202','02/Oct/20','104','c1001'),('BN1203','03/Oct/20','103','c1001'),('BN1204','04/Oct/20','102','c1004'),('BN1205','05/Oct/20','101','c1002'),('BN1206','10/Oct/20','105','c1004'),('BN1207','10/Oct/20','105','c1004');
/*!40000 ALTER TABLE `Bill_Header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cashier`
--

DROP TABLE IF EXISTS `Cashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cashier` (
  `Cashier_ID` varchar(20) NOT NULL,
  `Cashier_Name` varchar(25) NOT NULL,
  PRIMARY KEY (`Cashier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cashier`
--

LOCK TABLES `Cashier` WRITE;
/*!40000 ALTER TABLE `Cashier` DISABLE KEYS */;
INSERT INTO `Cashier` VALUES ('c1001','RAKESH'),('c1002','BALAKRISHNA'),('c1003','VENU'),('c1004','BHASKER'),('c1005','SRINIVAS');
/*!40000 ALTER TABLE `Cashier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `Customer_ID` varchar(20) NOT NULL,
  `Customer_Name` varchar(25) NOT NULL,
  PRIMARY KEY (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES ('101','RAMU'),('102','TEJA'),('103','RAMESH'),('104','DINESH'),('105','PRANAY'),('106','PHANINDRA');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEES`
--

DROP TABLE IF EXISTS `EMPLOYEES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EMPLOYEES` (
  `ID` varchar(10) NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `AGE` int(11) NOT NULL,
  `SALARY` float NOT NULL,
  `ADDRESS` varchar(20) NOT NULL,
  `MOBILENUMBER` varchar(12) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEES`
--

LOCK TABLES `EMPLOYEES` WRITE;
/*!40000 ALTER TABLE `EMPLOYEES` DISABLE KEYS */;
INSERT INTO `EMPLOYEES` VALUES ('3499','RUSHEEL',22,1430,'MOULA-ALI','8686664502'),('3500','AKHIL',23,1830,'ECIL','9447884582');
/*!40000 ALTER TABLE `EMPLOYEES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Items`
--

DROP TABLE IF EXISTS `Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Items` (
  `Item_ID` varchar(10) NOT NULL,
  `Item_Description` varchar(50) NOT NULL,
  `Unit_Price` float NOT NULL,
  `Stock_Quantity` int(11) NOT NULL,
  `Supplier_ID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Item_ID`),
  CONSTRAINT `Items_ibfk_1` FOREIGN KEY (`Supplier_ID`) REFERENCES `Supplier` (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Items`
--

LOCK TABLES `Items` WRITE;
/*!40000 ALTER TABLE `Items` DISABLE KEYS */;
INSERT INTO `Items` VALUES ('HL01','Horlicks 1kg',150,54,'s106'),('HN01','Honey 500g',220,18,'s106'),('KR21','Kohinoor Rice 50kg',2500,21,'s103'),('MJ1L','Milton Steel Flask',700,38,'s102'),('NB100','Ruled Note Book 200pgs',60,5,'s101'),('PS15','Pepsi 1L',62,87,'s105'),('SS55','Santoor Soap 125g',30,20,'s104');
/*!40000 ALTER TABLE `Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `SHOW_SALES_REPORT`
--

DROP TABLE IF EXISTS `SHOW_SALES_REPORT`;
/*!50001 DROP VIEW IF EXISTS `SHOW_SALES_REPORT`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `SHOW_SALES_REPORT` AS SELECT 
 1 AS `Bill_Number`,
 1 AS `Bill_Date`,
 1 AS `Item_ID`,
 1 AS `Item_Description`,
 1 AS `Unit_Price`,
 1 AS `Sold_Quantity`,
 1 AS `Total_Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Supplier`
--

DROP TABLE IF EXISTS `Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Supplier` (
  `Supplier_ID` varchar(10) NOT NULL,
  `Supplier_Name` varchar(25) NOT NULL,
  PRIMARY KEY (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplier`
--

LOCK TABLES `Supplier` WRITE;
/*!40000 ALTER TABLE `Supplier` DISABLE KEYS */;
INSERT INTO `Supplier` VALUES ('s101','Devi Book Traders'),('s102','Home Need Agency'),('s103','All Rice Brands Ltd'),('s104','Soap Factory Exports'),('s105','Soft Drinks Enterprises'),('s106','Food Products Ltd');
/*!40000 ALTER TABLE `Supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `show_sales_report`
--

DROP TABLE IF EXISTS `show_sales_report`;
/*!50001 DROP VIEW IF EXISTS `show_sales_report`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `show_sales_report` AS SELECT 
 1 AS `Bill_Number`,
 1 AS `Bill_Date`,
 1 AS `Item_ID`,
 1 AS `Item_Description`,
 1 AS `Unit_Price`,
 1 AS `Sold_Quantity`,
 1 AS `Total_Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `SHOW_SALES_REPORT`
--

/*!50001 DROP VIEW IF EXISTS `SHOW_SALES_REPORT`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `SHOW_SALES_REPORT` AS select `Bill_Detail`.`Bill_Number` AS `Bill_Number`,`GET_BILL_DATE`(`Bill_Detail`.`Bill_Number`) AS `Bill_Date`,`Bill_Detail`.`Item_ID` AS `Item_ID`,`GET_ITEM_DESCRIPTION`(`Bill_Detail`.`Item_ID`) AS `Item_Description`,`GET_UNIT_PRICE`(`Bill_Detail`.`Item_ID`) AS `Unit_Price`,`Bill_Detail`.`Sold_Quantity` AS `Sold_Quantity`,(`GET_UNIT_PRICE`(`Bill_Detail`.`Item_ID`) * `Bill_Detail`.`Sold_Quantity`) AS `Total_Price` from `Bill_Detail` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_sales_report`
--

/*!50001 DROP VIEW IF EXISTS `show_sales_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_sales_report` AS select `Bill_Detail`.`Bill_Number` AS `Bill_Number`,`GET_BILL_DATE`(`Bill_Detail`.`Bill_Number`) AS `Bill_Date`,`Bill_Detail`.`Item_ID` AS `Item_ID`,`GET_ITEM_DESCRIPTION`(`Bill_Detail`.`Item_ID`) AS `Item_Description`,`GET_UNIT_PRICE`(`Bill_Detail`.`Item_ID`) AS `Unit_Price`,`Bill_Detail`.`Sold_Quantity` AS `Sold_Quantity`,(`GET_UNIT_PRICE`(`Bill_Detail`.`Item_ID`) * `Bill_Detail`.`Sold_Quantity`) AS `Total_Price` from `Bill_Detail` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-12 16:01:19
