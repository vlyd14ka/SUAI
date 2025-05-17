-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: sportsclub
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `buy_sub`
--

DROP TABLE IF EXISTS `buy_sub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_sub` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `purchase_date` datetime NOT NULL,
  `subscription_id` int DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscription` (`subscription_id`),
  KEY `fk_phone_buy_sub_new` (`phone`),
  CONSTRAINT `fk_phone_buy_sub_new` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_subscription` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_sub`
--

LOCK TABLES `buy_sub` WRITE;
/*!40000 ALTER TABLE `buy_sub` DISABLE KEYS */;
INSERT INTO `buy_sub` VALUES (1,'Абонемент на 12 месяцев',27000.00,'2024-12-15 18:29:19',NULL,NULL),(2,'Абонемент на 12 месяцев',27000.00,'2024-12-15 18:29:59',NULL,NULL),(3,'Абонемент на 12 месяцев',27000.00,'2024-12-15 18:31:48',NULL,NULL),(4,'Абонемент на 6 месяцев',15000.00,'2024-12-15 18:33:38',NULL,NULL),(5,'Абонемент на 12 месяцев',27000.00,'2024-12-15 19:58:53',NULL,NULL),(6,'Абонемент на 12 месяцев',27000.00,'2024-12-15 19:58:53',NULL,NULL),(7,'Абонемент на 12 месяцев',27000.00,'2024-12-15 19:58:53',NULL,NULL),(8,'Абонемент на 12 месяцев',27000.00,'2024-12-15 19:58:53',NULL,NULL),(9,'Абонемент на 12 месяцев',27000.00,'2024-12-15 21:59:49',NULL,NULL),(10,'Абонемент на 1 месяц',3000.00,'2024-12-15 22:27:35',NULL,NULL),(11,'Абонемент на 12 месяцев',27000.00,'2024-12-15 23:14:09',NULL,NULL),(12,'Абонемент на 12 месяцев',27000.00,'2024-12-17 17:48:39',NULL,NULL),(13,'Абонемент на 1 месяц',3000.00,'2024-12-17 18:02:30',NULL,NULL);
/*!40000 ALTER TABLE `buy_sub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coaches`
--

DROP TABLE IF EXISTS `coaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `bio` text,
  `sport` varchar(255) DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_coach_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaches`
--

LOCK TABLES `coaches` WRITE;
/*!40000 ALTER TABLE `coaches` DISABLE KEYS */;
INSERT INTO `coaches` VALUES (1,'ivan ivanov','Мастер спорта по плаванию, победитель чемпионатов России. Преподает плавание более 10 лет. Дает как групповые, так и индивидуальные занятия. Особое внимание уделяет технике и физической подготовке.','Плавание',10,'img/trener_plovets.jpg'),(2,'elena smirnova','Профессиональная тренер по йоге с 15-летним стажем. Преподавала в Индии и Таиланде. Вдохновляет на занятия йогой людей всех возрастов, помогает достигать внутренней гармонии.','Йога',15,'img/trener_yoga.jpg'),(3,'sergey kuznetsov','Чемпион России по силовым упражнениям. С 8 лет тренирует людей, добиваясь отличных результатов в увеличении силы и выносливости. Специалист по функциональным тренировкам.','Силовые тренировки',15,'img/trener_silovye.jpg'),(4,'anna petrova','Тренер по фитнесу с более чем 10-летним стажем. Победительница множества международных соревнований по аэробике. Преподает кардио и фитнес-тренировки, работает с людьми любого уровня подготовки.','Фитнес',10,'img/trener_fitnes.jpg'),(5,'olga vorontsova','Мастерица по функциональным тренировкам, разработчик уникальной методики тренировок для восстановления после травм. Прошла обучение у ведущих специалистов США и Европы.','Функциональные тренировки',12,'img/trener_funktsional.jpg'),(6,'marina sidorova','Профессиональный тренер по кардио и пилатесу. Победительница международных соревнований. Составляет персональные тренировки для достижения максимальных результатов и восстановления после родов.','Кардио',10,'img/trener_kardio.jpeg');
/*!40000 ALTER TABLE `coaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_trainings`
--

DROP TABLE IF EXISTS `group_trainings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_trainings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `coach_id` int DEFAULT NULL,
  `dow` varchar(255) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coach_id` (`coach_id`),
  CONSTRAINT `group_trainings_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coaches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_trainings`
--

LOCK TABLES `group_trainings` WRITE;
/*!40000 ALTER TABLE `group_trainings` DISABLE KEYS */;
INSERT INTO `group_trainings` VALUES (1,'Йога 19:00-20:00',2,'Пн, Чт, Вс','19:00:00','20:00:00'),(2,'Кардио 21:00-21:30',6,'Вт, Ср, Пт','21:00:00','21:30:00'),(3,'Силовые тренировки 20:00-22:00',3,'Вс, Ср, Пт','20:00:00','22:00:00'),(4,'Фитнес 21:00-22:30',4,'Пн, Вт, Чт','21:00:00','22:30:00'),(5,'Плавание 20:00-22:00',1,'Пн, Вт, Чт, Вс','20:00:00','22:00:00'),(6,'Функциональные тренировки 21:00-22:00',5,'Пн, Вт, Ср, Чт, Пт, Сб, Вс','21:00:00','22:00:00');
/*!40000 ALTER TABLE `group_trainings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grouptraining_categories`
--

DROP TABLE IF EXISTS `grouptraining_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grouptraining_categories` (
  `training_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`training_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `grouptraining_categories_ibfk_1` FOREIGN KEY (`training_id`) REFERENCES `group_trainings` (`id`),
  CONSTRAINT `grouptraining_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `training_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grouptraining_categories`
--

LOCK TABLES `grouptraining_categories` WRITE;
/*!40000 ALTER TABLE `grouptraining_categories` DISABLE KEYS */;
INSERT INTO `grouptraining_categories` VALUES (1,1),(1,2),(2,2),(3,3),(4,4),(5,5),(6,6);
/*!40000 ALTER TABLE `grouptraining_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_bookings`
--

DROP TABLE IF EXISTS `individual_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `coach_id` int NOT NULL,
  `training_time` time NOT NULL,
  `training_date` date NOT NULL,
  `coach` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_individual_booking` (`coach_id`,`training_date`,`training_time`),
  KEY `fk_individual_bookings_users` (`phone`),
  CONSTRAINT `fk_individual_bookings_users` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `individual_bookings_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coaches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_bookings`
--

LOCK TABLES `individual_bookings` WRITE;
/*!40000 ALTER TABLE `individual_bookings` DISABLE KEYS */;
INSERT INTO `individual_bookings` VALUES (19,'Владислав','+79533587397',1,'10:00:00','2024-12-26','ivan ivanov'),(20,'Владислав','+79533587397',1,'10:00:00','2024-12-28','ivan ivanov');
/*!40000 ALTER TABLE `individual_bookings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prevent_duplicate_booking` BEFORE INSERT ON `individual_bookings` FOR EACH ROW BEGIN
    -- Проверяем, есть ли уже запись на это время с этим тренером
    DECLARE duplicate_count INT;
    
    SELECT COUNT(*) INTO duplicate_count
    FROM individual_bookings
    WHERE coach_id = NEW.coach_id 
    AND training_date = NEW.training_date
    AND training_time = NEW.training_time;

    IF duplicate_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Это время уже занято. Пожалуйста, выберите другое время.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `description` text,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Сумка тренажёрная','Аксессуары',2000.00,'Удобная сумка для переноски спортивного инвентаря.',10),(2,'Футболка спортивная','Одежда',1200.00,'Спортивная футболка из дышащего материала, подходит для тренировок.',15),(3,'Шорты спортивные','Одежда',1500.00,'Лёгкие и комфортные спортивные шорты для активных тренировок.',20),(4,'Массажный пистолет','Аксессуары',5500.00,'Массажный пистолет для расслабления мышц после тренировок.',5),(5,'Гантели','Инвентарь',2500.00,'Набор гантелей с регулируемым весом, идеально подходит для силовых тренировок.',8),(6,'Коврик для йоги','Инвентарь',1000.00,'Коврик для йоги с антипоскользящей поверхностью.',12),(7,'Спортивная обувь','Одежда',3500.00,'Удобная спортивная обувь для бега и тренировок.',25),(8,'Протеин','Спортивное питание',3000.00,'Протеин для быстрого восстановления после тренировок.',30),(9,'Спортивная бутылка','Аксессуары',800.00,'Бутылка для воды с защитой от проливов, идеальна для тренировки.',50);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `purchase_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `product_id` int DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product` (`product_id`),
  KEY `fk_phone_purchases` (`phone`),
  CONSTRAINT `fk_phone_purchases` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES (1,'Общая покупка',0.00,1,0.00,'2024-12-15 15:52:33',NULL,NULL),(2,'Общая покупка',0.00,1,0.00,'2024-12-15 15:52:54',NULL,NULL),(3,'Общая покупка',0.00,1,0.00,'2024-12-15 15:53:21',NULL,NULL),(4,'Общая покупка',0.00,1,0.00,'2024-12-15 15:54:16',NULL,NULL),(5,'Общая покупка',0.00,1,0.00,'2024-12-15 15:54:37',NULL,NULL),(6,'Общая покупка',0.00,1,0.00,'2024-12-15 15:56:43',NULL,NULL),(7,'Общая покупка',0.00,1,0.00,'2024-12-15 15:56:43',NULL,NULL),(8,'Общая покупка',0.00,1,0.00,'2024-12-15 15:56:52',NULL,NULL),(9,'Общая покупка',0.00,1,0.00,'2024-12-15 15:58:41',NULL,NULL),(10,'Общая покупка',0.00,1,0.00,'2024-12-15 15:58:59',NULL,NULL),(11,'Общая покупка',0.00,1,0.00,'2024-12-15 16:00:04',NULL,NULL),(12,'Общая покупка',0.00,1,0.00,'2024-12-15 16:01:11',NULL,NULL),(13,'Общая покупка',0.00,1,0.00,'2024-12-15 16:04:22',NULL,NULL),(14,'Общая покупка',0.00,1,0.00,'2024-12-15 16:06:11',NULL,NULL),(15,'Общая покупка',0.00,1,0.00,'2024-12-15 16:09:14',NULL,NULL),(16,'Общая покупка',0.00,1,0.00,'2024-12-15 16:14:51',NULL,NULL),(17,'Общая покупка',0.00,1,0.00,'2024-12-15 16:16:03',NULL,NULL),(18,'Шорты спортивные',800.00,1,800.00,'2024-12-15 16:30:14',NULL,NULL),(19,'Шорты спортивные',800.00,1,800.00,'2024-12-15 16:30:35',NULL,NULL),(20,'Шорты спортивные',800.00,1,800.00,'2024-12-15 16:30:35',NULL,NULL),(21,'Шорты спортивные',800.00,1,800.00,'2024-12-15 16:30:35',NULL,NULL),(22,'Шорты спортивные',800.00,1,800.00,'2024-12-15 16:30:35',NULL,NULL),(23,'Шорты спортивные',800.00,5,4000.00,'2024-12-15 16:33:14',NULL,NULL),(24,'Футболка спортивная',1200.00,1,1200.00,'2024-12-15 16:46:37',NULL,NULL),(25,'Шорты спортивные',800.00,4,3200.00,'2024-12-15 17:04:39',NULL,NULL),(26,'Футболка спортивная',1200.00,1,1200.00,'2024-12-15 19:00:15',NULL,NULL),(27,'Футболка спортивная',1200.00,1,1200.00,'2024-12-15 19:27:47',NULL,NULL),(28,'Шорты спортивные',800.00,3,2400.00,'2024-12-16 01:15:54',NULL,NULL),(29,'Футболка спортивная',1200.00,3,3600.00,'2024-12-16 01:15:54',NULL,NULL),(30,'Коврик для йоги',1200.00,2,2400.00,'2024-12-16 01:15:54',NULL,NULL),(31,'Шорты спортивные',800.00,4,3200.00,'2024-12-16 01:16:33',NULL,NULL);
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item` varchar(255) DEFAULT NULL,
  `rental_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_phone_rentals` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (21,'Зал 2 - Фитнес','2024-12-15','2024-12-15','+79533587397'),(23,'Зал 2 - Фитнес','2024-12-15','2024-12-15','+54785'),(28,'Зал 2 - Фитнес','2024-12-15','2024-12-15','+7953587'),(29,'Зал 1 - Силовые тренировки','2024-12-17','2024-12-17','+7953'),(30,'Зал 1 - Силовые тренировки','2024-12-17','2024-12-17','+793'),(31,'Зал 1 - Силовые тренировки','2024-12-18','2024-12-18','+794537');
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reviewer_name` varchar(255) NOT NULL,
  `review_rating` int NOT NULL,
  `review_text` text NOT NULL,
  `review_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_phone_reviews` (`phone`),
  CONSTRAINT `fk_phone_reviews` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`),
  CONSTRAINT `reviews_chk_1` CHECK ((`review_rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'Владислав',5,'Всё здорово','2024-12-08 06:27:40',NULL),(2,'Владислав',3,'','2024-12-15 14:07:02',NULL);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `training_id` int DEFAULT NULL,
  `dow` varchar(255) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `training_id` (`training_id`),
  CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`training_id`) REFERENCES `group_trainings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,1,'Пн','19:00:00','20:00:00'),(2,1,'Чт','19:00:00','20:00:00'),(3,1,'Вс','19:00:00','20:00:00'),(4,2,'Вт','21:00:00','21:30:00'),(5,2,'Ср','21:00:00','21:30:00'),(6,2,'Пт','21:00:00','21:30:00'),(7,3,'Вс','20:00:00','22:00:00'),(8,3,'Ср','20:00:00','22:00:00'),(9,3,'Пт','20:00:00','22:00:00'),(10,4,'Пн','21:00:00','22:30:00'),(11,4,'Вт','21:00:00','22:30:00'),(12,4,'Чт','21:00:00','22:30:00'),(13,5,'Пн','20:00:00','22:00:00'),(14,5,'Вт','20:00:00','22:00:00'),(15,5,'Чт','20:00:00','22:00:00'),(16,5,'Вс','20:00:00','22:00:00'),(17,6,'Пн','21:00:00','22:00:00'),(18,6,'Вт','21:00:00','22:00:00'),(19,6,'Ср','21:00:00','22:00:00'),(20,6,'Чт','21:00:00','22:00:00'),(21,6,'Пт','21:00:00','22:00:00'),(22,6,'Сб','21:00:00','22:00:00'),(23,6,'Вс','21:00:00','22:00:00');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (1,'Абонемент на 1 месяц','Подходит для тех, кто хочет попробовать клуб или посещает редко.',3000.00),(2,'Абонемент на 6 месяцев','Подходит для тех, кто планирует посещать клуб регулярно.',15000.00),(3,'Абонемент на 12 месяцев','Идеален для тех, кто серьезно настроен на длительные тренировки.',27000.00);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_categories`
--

DROP TABLE IF EXISTS `training_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_categories`
--

LOCK TABLES `training_categories` WRITE;
/*!40000 ALTER TABLE `training_categories` DISABLE KEYS */;
INSERT INTO `training_categories` VALUES (2,'Cardio'),(4,'Fitness'),(6,'Functional Training'),(3,'Strength Training'),(5,'Swimming'),(1,'Yoga');
/*!40000 ALTER TABLE `training_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_registrations`
--

DROP TABLE IF EXISTS `training_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_registrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `training_category` varchar(50) NOT NULL,
  `training_type` varchar(50) NOT NULL,
  `training_day` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `training_category` (`training_category`),
  KEY `fk_training_registrations_users` (`phone`),
  CONSTRAINT `fk_training_registrations_users` FOREIGN KEY (`phone`) REFERENCES `users` (`phone`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `training_registrations_ibfk_1` FOREIGN KEY (`training_category`) REFERENCES `training_categories` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_registrations`
--

LOCK TABLES `training_registrations` WRITE;
/*!40000 ALTER TABLE `training_registrations` DISABLE KEYS */;
INSERT INTO `training_registrations` VALUES (29,'Владислав','+7 (953) 358-73-97','cardio','group',1,'2024-12-18 12:21:19'),(30,'Владислав','+7 (953) 358-73-97','yoga','group',2,'2024-12-18 12:21:24'),(31,'Владислав','+7 (953) 358-73-97','swimming','group',1,'2024-12-18 12:21:27'),(32,'Владислав','+7 (953) 358-73-97','fitness','group',1,'2024-12-18 12:21:30');
/*!40000 ALTER TABLE `training_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `activity` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `rental_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_phone_users` (`phone`),
  KEY `fk_rental_user` (`rental_id`),
  CONSTRAINT `fk_rental_user` FOREIGN KEY (`rental_id`) REFERENCES `rentals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (22,'Тарапанов Владислав Андреевич',21,'Санкт-Петербург','Бокс','+79533587397',NULL),(23,'Владислав',3,'г Санкт-Петербург','ккк','+7 (953) 358-73-97',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sportsclub'
--

--
-- Dumping routines for database 'sportsclub'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_review`(
    IN reviewerName VARCHAR(255),
    IN reviewRating INT,
    IN reviewText TEXT,
    IN reviewDate DATETIME
)
BEGIN
    INSERT INTO reviews (reviewer_name, review_rating, review_text, review_date)
    VALUES (reviewerName, reviewRating, reviewText, reviewDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `book_individual_training` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `book_individual_training`(
    IN fullName VARCHAR(255),
    IN phone VARCHAR(20),
    IN coach VARCHAR(255),
    IN trainingDate DATE,
    IN trainingTime TIME
)
BEGIN
    DECLARE coachId INT;

    -- Получаем ID тренера
    SELECT id INTO coachId FROM Coaches WHERE name COLLATE utf8mb4_unicode_ci = coach;

    -- Проверяем доступность времени
    IF EXISTS (
        SELECT 1 FROM individual_bookings 
        WHERE coach_id = coachId AND training_date = trainingDate AND training_time = trainingTime
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Это время уже занято. Пожалуйста, выберите другое время.';
    ELSE
        -- Добавляем запись на занятие
        INSERT INTO individual_bookings (full_name, phone, coach_id, training_time, training_date, coach)
        VALUES (fullName, phone, coachId, trainingTime, trainingDate, coach);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_for_training` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_for_training`(
    IN fullName VARCHAR(255),
    IN phone VARCHAR(20),
    IN trainingCategory VARCHAR(255),
    IN trainingType VARCHAR(255),
    IN trainingDay VARCHAR(20)
)
BEGIN
    DECLARE categoryId INT;

    -- Проверка существования категории
    SELECT id INTO categoryId FROM Training_Categories WHERE category_name = trainingCategory;

    -- Если категория не существует, добавляем её
    IF categoryId IS NULL THEN
        INSERT INTO Training_Categories (category_name) VALUES (trainingCategory);
        SELECT LAST_INSERT_ID() INTO categoryId;
    END IF;

    -- Добавляем запись на тренировку
    INSERT INTO training_registrations (full_name, phone, training_category, training_type, training_day)
    VALUES (fullName, phone, trainingCategory, trainingType, trainingDay);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-18 17:04:27
