-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  2 авг 2021 в 07:22
-- Версия на сървъра: 10.4.17-MariaDB
-- Версия на PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `electry`
--

-- --------------------------------------------------------

--
-- Структура на таблица `devices`
--

CREATE TABLE `devices` (
  `DEV_ID` int(11) NOT NULL,
  `DEV_DESC` text NOT NULL,
  `IMAGE_PATH` varchar(20) NOT NULL,
  `DEV_STATE` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Схема на данните от таблица `devices`
--

INSERT INTO `devices` (`DEV_ID`, `DEV_DESC`, `IMAGE_PATH`, `DEV_STATE`) VALUES
(1, 'Bedroom Lights', 'Lights', NULL),
(2, 'Bedroom PC', 'Computer', NULL),
(3, 'Living Room Lights', 'Lights', NULL);

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `devices`
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
  MODIFY `DEV_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
