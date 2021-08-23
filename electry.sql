-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 23, 2021 at 06:20 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `electry`
--

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `DEV_ID` int(11) NOT NULL,
  `DEV_NAME` text NOT NULL DEFAULT 'DEVICE',
  `DEV_DESC` text NOT NULL DEFAULT 'No Description',
  `IMAGE_PATH` varchar(20) NOT NULL DEFAULT 'lightbulb',
  `DEV_STATE` tinyint(1) DEFAULT 0,
  `DEV_FAV` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`DEV_ID`, `DEV_NAME`, `DEV_DESC`, `IMAGE_PATH`, `DEV_STATE`, `DEV_FAV`) VALUES
(3, 'Living Room Lights', 'Wow, I added this description of Living Room Lights', 'lightbulb', 1, 0),
(4, 'Bedroom PS4', 'This is a description of Bedroom PS4', 'console', 0, 0),
(7, 'Bedroom Lights', 'No Description', 'lightbulb', 1, 0),
(8, 'Bedroom PC', 'No Description', 'pc', 1, 1),
(9, 'Bathroom Lights', 'No Description', 'lightbulb', 0, 0),
(10, 'Living Room PC', 'No Description', 'pc', 0, 0),
(11, 'DEVICE', 'No Description', 'lightbulb', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `measurements_00001`
--

CREATE TABLE `measurements_00001` (
  `id` int(1) NOT NULL,
  `consumer_id` int(1) NOT NULL,
  `timestamp` datetime NOT NULL,
  `power` int(1) NOT NULL,
  `state` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `measurements_00001`
--

INSERT INTO `measurements_00001` (`id`, `consumer_id`, `timestamp`, `power`, `state`) VALUES
(1, 3, '2021-09-16 00:00:00', 40, 1),
(2, 4, '2021-09-16 00:23:35', 1600, 1),
(3, 4, '2021-09-16 01:00:24', 986, 0),
(4, 8, '2021-09-16 01:30:50', 700, 1),
(5, 3, '2021-09-16 01:40:00', 67, 0),
(6, 8, '2021-09-16 01:50:28', 229, 0),
(7, 8, '2021-09-16 05:21:48', 700, 1),
(8, 8, '2021-09-16 05:50:08', 330, 0),
(9, 8, '2021-09-16 13:03:34', 700, 1),
(10, 8, '2021-09-16 13:21:07', 205, 0),
(11, 8, '2021-09-16 19:45:50', 700, 1),
(12, 3, '2021-09-16 19:43:07', 41, 1),
(13, 4, '2021-09-16 01:46:29', 1600, 1),
(14, 4, '2021-09-16 19:50:23', 104, 0),
(15, 8, '2021-09-16 20:03:40', 208, 0),
(16, 3, '2021-09-16 20:50:00', 45, 0),
(18, 8, '2021-09-17 00:03:40', 700, 1),
(19, 8, '2021-09-17 01:23:00', 280, 0);

-- --------------------------------------------------------

--
-- Table structure for table `voltage_00001`
--

CREATE TABLE `voltage_00001` (
  `id` int(1) NOT NULL,
  `timestamp` datetime NOT NULL,
  `voltage` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `voltage_00001`
--

INSERT INTO `voltage_00001` (`id`, `timestamp`, `voltage`) VALUES
(1, '2021-09-15 23:57:42', 220),
(2, '2021-09-16 01:53:25', 223),
(3, '2021-09-16 03:39:42', 229),
(4, '2021-09-16 04:00:00', 218),
(5, '2021-09-16 07:21:56', 220),
(6, '2021-09-16 17:43:19', 215),
(7, '2021-09-16 23:24:41', 225),
(8, '2021-09-16 23:47:01', 226);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`DEV_ID`);

--
-- Indexes for table `measurements_00001`
--
ALTER TABLE `measurements_00001`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voltage_00001`
--
ALTER TABLE `voltage_00001`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `DEV_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `measurements_00001`
--
ALTER TABLE `measurements_00001`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `voltage_00001`
--
ALTER TABLE `voltage_00001`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
