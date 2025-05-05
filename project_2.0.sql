-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 05, 2025 at 10:51 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Project_2.0`
--

-- --------------------------------------------------------

--
-- Table structure for table `AREA`
--

CREATE TABLE `AREA` (
  `area_id` int(11) NOT NULL,
  `area_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `AREA`
--

INSERT INTO `AREA` (`area_id`, `area_name`) VALUES
(1, 'Uttara'),
(2, 'Farmgate'),
(3, 'Motijheel'),
(4, 'Rampura'),
(5, 'Dhanmondi'),
(6, 'Khilgaon'),
(7, 'Badda');

-- --------------------------------------------------------

--
-- Table structure for table `BOOKING`
--

CREATE TABLE `BOOKING` (
  `booking_id` int(11) NOT NULL,
  `booking_time` datetime NOT NULL DEFAULT current_timestamp(),
  `arrival_time` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `payment` decimal(10,2) DEFAULT NULL,
  `free_parking` tinyint(1) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `BOOKING`
--

INSERT INTO `BOOKING` (`booking_id`, `booking_time`, `arrival_time`, `status`, `payment`, `free_parking`, `user_id`, `location_id`) VALUES
(1, '2025-05-05 21:54:03', NULL, 'cancelled', 50.00, 0, 1, 1),
(2, '2025-05-05 22:07:15', NULL, 'cancelled', 50.00, 0, 1, 2),
(3, '2025-05-05 22:17:57', NULL, 'completed', 50.00, 0, 1, 3),
(4, '2025-05-05 22:18:11', NULL, 'completed', 50.00, 0, 1, 8),
(5, '2025-05-05 22:25:23', NULL, 'completed', 50.00, 0, 1, 10),
(6, '2025-05-05 22:26:58', NULL, 'cancelled', 50.00, 0, 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `PARKING_LOCATION`
--

CREATE TABLE `PARKING_LOCATION` (
  `location_id` int(11) NOT NULL,
  `mall_name` varchar(100) NOT NULL,
  `total_spot` int(11) NOT NULL,
  `available_spot` int(11) NOT NULL,
  `address` text DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `PARKING_LOCATION`
--

INSERT INTO `PARKING_LOCATION` (`location_id`, `mall_name`, `total_spot`, `available_spot`, `address`, `area_id`) VALUES
(1, 'Rajlokkhi Complex', 50, 50, 'Rajlokkhi Complex, Uttara, Dhaka', 1),
(2, 'Mascot Plaza', 40, 40, 'Mascot Plaza, Sector 7, Uttara', 1),
(3, 'Uttara Square', 30, 29, 'Uttara Square, Sector 3, Dhaka', 1),
(4, 'Farmview Super Market', 25, 25, 'Farmgate, Dhaka', 2),
(5, 'Shezan Point', 20, 20, 'Kazi Nazrul Islam Ave, Farmgate', 2),
(6, 'Fakirapool Market', 35, 35, 'Fakirapool, Motijheel', 3),
(7, 'Baitul Mukarram Market', 50, 50, 'Baitul Mukarram, Dhaka', 3),
(8, 'Eastern Banabithi Shopping Complex', 20, 19, 'Rampura, Dhaka', 4),
(9, 'Metro Shopping Mall', 40, 40, 'Dhanmondi 32, Dhaka', 5),
(10, 'Bashundhara City Shopping Complex', 60, 59, 'Panthapath, Dhaka', 5),
(11, 'iNFINITY Mega Mall', 30, 30, 'Khilgaon, Dhaka', 6),
(12, 'Khilgaon Taltola Market', 25, 25, 'Taltola, Khilgaon', 6),
(13, 'Suvastu Nazar Valley Shopping Mall', 40, 40, 'Badda, Dhaka', 7);

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `user_id` int(11) NOT NULL,
  `Fname` varchar(50) DEFAULT NULL,
  `Lname` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`user_id`, `Fname`, `Lname`, `email`, `password`, `points`) VALUES
(1, 'Aryan', 'Rafsanjany', 'aryanrafsanjany@gmail.com', '$2y$10$iENGt58Tyy33CZB/6RyU7.SuI7U.XYaELn1KVmLOGfHLdSNSgqO7.', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AREA`
--
ALTER TABLE `AREA`
  ADD PRIMARY KEY (`area_id`);

--
-- Indexes for table `BOOKING`
--
ALTER TABLE `BOOKING`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `PARKING_LOCATION`
--
ALTER TABLE `PARKING_LOCATION`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AREA`
--
ALTER TABLE `AREA`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `BOOKING`
--
ALTER TABLE `BOOKING`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `PARKING_LOCATION`
--
ALTER TABLE `PARKING_LOCATION`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `USER`
--
ALTER TABLE `USER`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `BOOKING`
--
ALTER TABLE `BOOKING`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `USER` (`user_id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `PARKING_LOCATION` (`location_id`);

--
-- Constraints for table `PARKING_LOCATION`
--
ALTER TABLE `PARKING_LOCATION`
  ADD CONSTRAINT `parking_location_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `AREA` (`area_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
