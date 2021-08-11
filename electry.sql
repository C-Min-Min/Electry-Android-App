-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 11, 2021 at 02:43 PM
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
  `DEV_NAME` text NOT NULL,
  `DEV_DESC` text NOT NULL DEFAULT 'You haven\'t still given a description about this device',
  `IMAGE_PATH` varchar(20) NOT NULL DEFAULT 'lightbulb',
  `DEV_STATE` tinyint(1) DEFAULT 0,
  `DEV_FAV` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`DEV_ID`, `DEV_NAME`, `DEV_DESC`, `IMAGE_PATH`, `DEV_STATE`, `DEV_FAV`) VALUES
(1, 'Bedroom Lights', 'Wow, this is a description of Bedroom Lights', 'lightbulb', 1, 1),
(2, 'Bedroom PC', 'You haven\'t still given a description about this device', 'pc', 0, 1),
(3, 'Living Room Lights', 'Wow, I added this description of Living Room Lights', 'lightbulb', 0, 0),
(4, 'Bedroom PS4', 'You haven\'t still given a description about this device', 'console', 0, 0),
(6, 'Bathroom Lights', 'You haven\'t still given a description about this device', 'lightbulb', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`DEV_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `DEV_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
