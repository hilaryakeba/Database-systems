-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: Destination_Management
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Activity`
--

DROP TABLE IF EXISTS `Activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Activity` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `destination_id` int(11) NOT NULL,
  `activity_name` varchar(150) NOT NULL,
  `activity_type` enum('Wildlife','Adventure','Cultural','Water','Scenic') NOT NULL,
  `price_per_person_usd` decimal(8,2) NOT NULL,
  `difficulty_level` enum('Easy','Moderate','Challenging','Extreme') NOT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `fk_act_dest` (`destination_id`),
  CONSTRAINT `fk_act_dest` FOREIGN KEY (`destination_id`) REFERENCES `Destination` (`destination_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Activity`
--

LOCK TABLES `Activity` WRITE;
/*!40000 ALTER TABLE `Activity` DISABLE KEYS */;
INSERT INTO `Activity` VALUES (1,1,'Game Drive Safari','Wildlife',45.00,'Easy'),(2,1,'Nile Boat Cruise','Water',30.00,'Easy'),(3,2,'Gorilla Trekking','Wildlife',700.00,'Challenging'),(4,4,'Heritage City Walk','Cultural',25.00,'Easy');
/*!40000 ALTER TABLE `Activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Booking`
--

DROP TABLE IF EXISTS `Booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `tourist_id` int(11) NOT NULL,
  `booking_date` date NOT NULL DEFAULT curdate(),
  `travel_date` date NOT NULL,
  `num_participants` int(11) NOT NULL DEFAULT 1,
  `total_amount_usd` decimal(10,2) NOT NULL,
  `booking_status` enum('Pending','Confirmed','Cancelled','Completed') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`booking_id`),
  KEY `fk_book_tourist` (`tourist_id`),
  CONSTRAINT `fk_book_tourist` FOREIGN KEY (`tourist_id`) REFERENCES `Tourist` (`tourist_id`) ON UPDATE CASCADE,
  CONSTRAINT `chk_travel_date` CHECK (`travel_date` >= `booking_date`),
  CONSTRAINT `chk_participants` CHECK (`num_participants` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking`
--

LOCK TABLES `Booking` WRITE;
/*!40000 ALTER TABLE `Booking` DISABLE KEYS */;
INSERT INTO `Booking` VALUES (1,1,'2026-05-05','2026-06-01',2,150.00,'Confirmed'),(2,2,'2026-05-05','2026-07-15',1,700.00,'Pending');
/*!40000 ALTER TABLE `Booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Destination`
--

DROP TABLE IF EXISTS `Destination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Destination` (
  `destination_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `destination_name` varchar(150) NOT NULL,
  `region` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `entry_fee_usd` decimal(8,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`destination_id`),
  KEY `fk_dest_cat` (`category_id`),
  CONSTRAINT `fk_dest_cat` FOREIGN KEY (`category_id`) REFERENCES `DestinationCategory` (`category_id`) ON UPDATE CASCADE,
  CONSTRAINT `chk_entry_fee` CHECK (`entry_fee_usd` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Destination`
--

LOCK TABLES `Destination` WRITE;
/*!40000 ALTER TABLE `Destination` DISABLE KEYS */;
INSERT INTO `Destination` VALUES (1,4,'Murchison Falls NP','Northern','Nwoya','Home to the world\'s most powerful waterfall.',40.00),(2,5,'Bwindi Impenetrable NP','Western','Kanungu','A UNESCO site famous for gorilla trekking.',50.00),(3,6,'Lake Bunyonyi','Western','Kabale','A beautiful freshwater lake with 29 islands.',5.00),(4,3,'Kampala City Tour','Central','Kampala','A cultural journey through the capital city.',0.00);
/*!40000 ALTER TABLE `Destination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DestinationCategory`
--

DROP TABLE IF EXISTS `DestinationCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DestinationCategory` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `category_description` text DEFAULT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`category_name`),
  KEY `fk_parent_cat` (`parent_category_id`),
  CONSTRAINT `fk_parent_cat` FOREIGN KEY (`parent_category_id`) REFERENCES `DestinationCategory` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DestinationCategory`
--

LOCK TABLES `DestinationCategory` WRITE;
/*!40000 ALTER TABLE `DestinationCategory` DISABLE KEYS */;
INSERT INTO `DestinationCategory` VALUES (1,'National Parks','Protected wildlife areas managed by UWA',NULL,1),(2,'Lakes & Wetlands','Freshwater lakes, rivers, and wetland sites',NULL,1),(3,'Urban & Cultural','City tours, heritage sites, cultural experiences',NULL,1),(4,'Savanna Parks',NULL,1,1),(5,'Forest Reserves',NULL,1,1),(6,'Great Lakes',NULL,2,1);
/*!40000 ALTER TABLE `DestinationCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tourist`
--

DROP TABLE IF EXISTS `Tourist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tourist` (
  `tourist_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `email` varchar(150) NOT NULL,
  `nationality` varchar(80) NOT NULL,
  `passport_number` varchar(40) DEFAULT NULL,
  `registration_date` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`tourist_id`),
  UNIQUE KEY `uq_tourist_email` (`email`),
  UNIQUE KEY `uq_passport` (`passport_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tourist`
--

LOCK TABLES `Tourist` WRITE;
/*!40000 ALTER TABLE `Tourist` DISABLE KEYS */;
INSERT INTO `Tourist` VALUES (1,'John','Smith','john.smith@example.com','British','BK123456','2026-05-05'),(2,'Amina','Nakato','amina.n@example.ug','Ugandan','UA987654','2026-05-05');
/*!40000 ALTER TABLE `Tourist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-07  2:27:30
