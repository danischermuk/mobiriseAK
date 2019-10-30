-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 30-10-2019 a las 20:23:45
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ajdutdb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pesaj`
--

CREATE TABLE `pesaj` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `ListaProductos` varchar(510) NOT NULL,
  `Halajot` varchar(510) NOT NULL,
  `Hejsher` varchar(510) NOT NULL,
  `mostrar` varchar(10) NOT NULL DEFAULT 'No',
  `intro` longtext DEFAULT NULL,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pesaj`
--

INSERT INTO `pesaj` (`id`, `nombre`, `ListaProductos`, `Halajot`, `Hejsher`, `mostrar`, `intro`, `fechaUltimaModificacion`) VALUES
(2, 'Pesaj 5780', '', '', '', 'No', '<p><span style=\"background-color: rgb(0, 255, 255);\">pesaj</span> <span style=\"background-color: rgb(255, 255, 0);\">5780</span></p>', '2019-10-30 19:22:30');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pesaj`
--
ALTER TABLE `pesaj`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pesaj`
--
ALTER TABLE `pesaj`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
