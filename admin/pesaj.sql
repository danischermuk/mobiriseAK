-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-03-2020 a las 16:15:41
-- Versión del servidor: 10.1.32-MariaDB
-- Versión de PHP: 7.2.5

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
  `intro` longtext,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pesaj`
--

INSERT INTO `pesaj` (`id`, `nombre`, `ListaProductos`, `Halajot`, `Hejsher`, `mostrar`, `intro`, `fechaUltimaModificacion`) VALUES
(2, 'Pesaj 5780', 'CT-540.pdf', '', '', 'Si', '<p>Aqui va la guía de Pesaj. Es una descripción que puede tenre texto, imágenes, formato, videos, lo que quieran....</p><p><br></p>', '2020-03-19 14:38:01');

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
