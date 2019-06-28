-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 28, 2019 at 03:21 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ajdutdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `establecimientos`
--

CREATE TABLE `establecimientos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `certificado` varchar(255) DEFAULT NULL,
  `vigente` varchar(10) DEFAULT 's',
  `logo` varchar(255) DEFAULT NULL,
  `rubroId` int(11) DEFAULT NULL,
  `fechaUltimaModificacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `establecimientos`
--

INSERT INTO `establecimientos` (`id`, `nombre`, `direccion`, `telefono`, `certificado`, `vigente`, `logo`, `rubroId`, `fechaUltimaModificacion`) VALUES
(2, 'Open Kosher2', 'Moldes ', '', '', 's', '1560361194.png', 2, '2019-06-12 11:21:05'),
(4, 'Grido', 'Moldes', '', '1560365454.pdf', 'undefined', '1560363070.jpg', 1, '2019-06-12 13:10:49'),
(6, 'otro', 'basf', '', '1560431584.pdf', 'undefined', '1560362613.jpg', 1, '2019-06-12 14:57:54'),
(7, 'asdfg', 'szfgbfdxbz', '', '', 'undefined', '', 2, '2019-06-12 15:03:25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `establecimientos`
--
ALTER TABLE `establecimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_establecimientotipo` (`rubroId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `establecimientos`
--
ALTER TABLE `establecimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `establecimientos`
--
ALTER TABLE `establecimientos`
  ADD CONSTRAINT `FK_establecimientotipo` FOREIGN KEY (`rubroId`) REFERENCES `tipoestablecimiento` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
