-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2019 at 09:38 PM
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
-- Database: `ajdutdbvacia`
--

-- --------------------------------------------------------

--
-- Table structure for table `alertas`
--

CREATE TABLE `alertas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` mediumtext,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mostrar` varchar(10) DEFAULT 's'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `codigo`
--

CREATE TABLE `codigo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(5000) DEFAULT NULL,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fechaBaja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `codigo`
--

INSERT INTO `codigo` (`id`, `nombre`, `codigo`, `descripcion`, `fechaUltimaModificacion`, `fechaBaja`) VALUES
(1, 'Mehadrin', 'M', NULL, '2019-05-31 13:24:04', NULL),
(5, 'Bitul 60', 'B60', NULL, '2019-05-31 13:24:52', NULL),
(6, 'NO KOSHER', 'NK', NULL, '2019-05-31 13:24:52', NULL),
(8, 'Kosher', '', NULL, '2019-05-31 13:24:52', NULL);

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
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lecheparve`
--

CREATE TABLE `lecheparve` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fechaBaja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lecheparve`
--

INSERT INTO `lecheparve` (`id`, `nombre`, `codigo`, `fechaUltimaModificacion`, `fechaBaja`) VALUES
(1, 'Leche Común', 'LC', '2019-05-31 15:29:07', NULL),
(2, 'Leche en Polvo', 'LP', '2019-05-31 15:29:07', NULL),
(3, 'Jalav Israel', 'JI', '2019-05-31 15:29:07', NULL),
(4, 'Parve', 'P', '2019-05-31 15:29:07', NULL),
(5, 'Kelim Lácteo', 'KL', '2019-05-31 15:29:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `marca` varchar(255) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `rubroId` int(11) NOT NULL,
  `nivelId` int(11) NOT NULL,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fechaBaja` datetime DEFAULT NULL,
  `lecheparveId` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rubro`
--

CREATE TABLE `rubro` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(5000) DEFAULT NULL,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fechaBaja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `textos`
--

CREATE TABLE `textos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` longtext,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `textos`
--

INSERT INTO `textos` (`id`, `nombre`, `descripcion`, `fechaUltimaModificacion`) VALUES
(1, 'guiakosher', '<p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">¿CUAL ES EL OBJETIVO DE ESTA GUÍA DE CASHRUT?</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">El Proyecto Cashrut Abierto consiste en orientar a los miembros de la Comunidad Judía de la Argentina sobre aquellos productos de consumo común que se pueden adquirir en cualquier almacén o supermercado y se consideran Casher.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Nuestro fin es&nbsp;<b>facilitar la observancia del Cashrut</b>&nbsp;y<b>&nbsp;estimular su cumplimiento</b>, especialmente en los casos que por razones geográficas, económicas o por desconocimiento el Cashrut es casi imposible.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">En otros países del mundo existen varias formas de Cashrut Abierto: en los Estados Unidos, Canadá y algunos países de Europa cada producto Casher lleva una señal identificatoria pudiéndose adquirir en cualquier almacén o supermercado. En México y en ciertas Comunidades de Europa se elabora una lista con los productos autorizados. En la Argentina quien primero realizó esta lista fue el&nbsp;<b>Rab Iosef Oppenheimer z\"l</b>, y nuestra presente Guía, eje central del proyecto Cashrut Abierto, se inspira en este modelo.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">¿EN BASE A QUÉ CRITERIOS SE AUTORIZAN ESTOS PRODUCTOS?</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Los productos que aparecen en esta lista han sido autorizados en base a la información recibida desde la empresa elaboradora, la verificación de esta información por parte de nuestro Mashguiaj y por último el Pesak (determinación Rabínica) correspondiente.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">El Proyecto Cashrut Abierto, fue iniciado por los Rabinos&nbsp;<b>Daniel</b><b>&nbsp;Oppenheimer</b><b>&nbsp;y Iosef Bittón</b>, responsables por la autorización de estos productos.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">No obstante, cada Comunidad tiene sus propias costumbres que deben ser estrictamente respetadas por sus miembros. De manera que en cada Comunidad sus miembros deben someter la autorización total o parcial de esta lista a la consideración de sus autoridades rabínicas.</span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">¿QUÉ DIFERENCIA HAY ENTRE ESTOS PRODUCTOS Y LOS PRODUCTOS SUPERVISADOS?</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Los productos supervisados (con Hashgajá) cuentan durante todos los pasos de su elaboración con la presencia de un Mashguíaj (supervisor) ya sea para verificar directa y personalmente el proceso de su elaboración o para modificar alguno de sus componentes. En ambos casos la partida que se produce es especial y se comercializa como tal con la Hashgajá (responsabilidad Rabínica) del Rabino o la institución religiosa correspondiente.&nbsp;<b>Sin duda esta es la variable más segura del Cashrut</b>. No obstante, las exigencias halájicas no requieren esta supervisión personal en todos los casos. En los productos de consumo que aquí presentamos, halájicamente es suficiente con conocer sus componentes y el método de elaboración (Ver más adelante tema leche y pan).</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">¿POR QUÉ NO PODEMOS BASARNOS EN LA INFORMACIÓN QUE FIGURA EN LAS ETIQUETAS DE LOS PRODUCTOS?</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">En la Argentina las exigencias estatales actuales respecto a la descripción de los elementos que forman parte de un producto alimenticio (control de realidad) no son aún muy estrictas. A esto se suma que&nbsp;<b>en las etiquetas no siempre se exige la descripción exacta de todos los componentes del producto,&nbsp;</b>especialmente, en fábricas y compañías que no son de primera línea.&nbsp; Habitualmente&nbsp;<b>los aditivos son descriptos de una forma muy genérica&nbsp;</b>(colorantes, estabilizantes, etc.) y a veces deliberadamente ambigua, sin especificar el origen de los mismos.&nbsp; Por lo tanto,&nbsp;<b>a efectos del Cashrut, la descripción que aparece en la etiqueta del producto no es suficiente.</b></span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">¿QUIÉN AUSPICIA ESTA LISTA?</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">El proyecto Cashrut Abierto, del cual la Guía es su principal eje, es auspiciado por individuos de la Capital y el interior del país, quienes comprometidos con esta fundamental Mitzvá colaboran generosamente para su difusión.&nbsp;<b>A ellos nuestro mayor agradecimiento</b>.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">¿CUÁL ES LA VIGENCIA DE ESTA LISTA?</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Esta lista, D\"s mediante,&nbsp;<b>se actualiza cada año</b>&nbsp;para ratificar o modificar los productos autorizados dejando sin efecto a la lista del año anterior.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">También, en la medida de lo posible, se van agregando nuevos productos que cumplen con nuestros requerimientos de Cashrut.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">¿CÓMO PODEMOS SABER QUE EL PRODUCTO NO CAMBIA DE FORMULA?</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Es muy remoto que en grandes empresas, como la mayoría de las que aquí se mencionan, cambien arbitrariamente su fórmula o sus proveedores ya que quieren disponer de productos estables y los cambios de ingredientes pueden causarle más pérdidas que ganancias. Halájicamente&nbsp;<b>nos basamos en el principio de Jazaká</b>&nbsp;(o sea, el status quo que se mantiene hasta que se demuestre lo contrario) como lo hacen otros proyecto de Cashrut Abierto en el mundo entero.&nbsp; Asimismo, en casi todos los casos tenemos contacto con muchos de estos establecimientos en forma seguida lo cual nos permite seguir de cerca lo que ocurre en ellos.</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">No obstante, si alguien tiene algún dato&nbsp;<b>verificable</b>&nbsp;que rectifique lo expuesto en esta lista puede enviar su información<b>&nbsp;al correo electrónico&nbsp;<u><a href=\"mailto:rab@ajdut.com.ar\" target=\"_blank\" style=\"color: rgb(17, 85, 204);\">rab@ajdut.com.ar</a></u></b></span></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Esta lista se elabora con el máximo esmero y sacrificio para brindar una información lo más clara y actualizada posible.&nbsp; No obstante, agradecemos todas las observaciones que hemos recibido del público a lo largo de estos años, las cuales nos permitieron mejorar y perfeccionar esta tarea.</span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></b></p><p class=\"MsoNormal\" align=\"center\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: center; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">RUMORES</span></i></b></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">En mi tarea, no dejo de escuchar rumores acerca que ciertos productos estén permitidos o prohibidos.</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Ruego a todos los usuarios y consumidores, ser muy cuidadosos en aceptar como certeza absoluta o repetir estos rumores sin investigar su fuente.&nbsp; Estos chismes pueden tener repercusiones críticas.&nbsp; De terminar siendo no auténticos, corremos el riesgo que al momento de alertar al público de cuestiones concretas, tampoco se le dará a la noticia la credibilidad necesaria.&nbsp; De conocerse alguna duda genuina de Cashrut, es importante que esté substanciada y debidamente publicada.</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: center; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">CÓDIGOS DE PRESENTACIÓN</span></i></b></p><p class=\"MsoNormal\" align=\"center\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: center; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">DE LOS PRODUCTOS</span></i></b></p><p class=\"MsoNormal\" align=\"center\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: center; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">AUTORIZADOS</span></i></b></p><p class=\"MsoNormal\" align=\"center\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: center; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><i><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></i></b></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Para una mejor clasificación de los productos autorizados hemos agregado al lado de cada artículo una letra o código que indica ciertos detalles de su composición:</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">La letra&nbsp;<b>M</b>&nbsp;(por Mehadrín) indica que este producto no contiene leche y está autorizado (<b>según nuestro mejor entendimiento</b>) acorde a todas las opiniones rabínicas más exigentes.</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 15.6933px; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 14pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Cuando un producto&nbsp;<b>no posee ningún código</b>, e<b>sto no significa que el producto no sea</b>&nbsp;<b>?Mehadrín?,</b>&nbsp;sino que puede carecer de alguna condición o que desconocemos alguna información complementaria para ser totalmente aceptable para&nbsp; alguna Autoridad Rabínica, aunque estaría aprobado para la mayoría de las opiniones mundialmente reconocidas.</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Cuando un producto contiene leche se le agrega&nbsp;<b>LÁCTEO</b>, cuando no figura nada, significa que el alimento es&nbsp;<b>PARVE</b>.</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Las letras&nbsp;<b>LP</b>&nbsp;indican que el producto&nbsp;<b>LÁCTEO</b>&nbsp;está elaborado con leche en polvo (Ver \"Leche en polvo\" en la guía)</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Las letras&nbsp;<b>LC</b>&nbsp;después de&nbsp;<b>LÁCTEO</b>&nbsp;significan que el producto se elaboró con leche común líquida (Ver \"Leche\" en la guía)</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Cuando un artículo lleva el código&nbsp;<b>B60</b>&nbsp;se indica que lleva en su composición un elemento prohibido pero que, por su proporción (menos de 1 en 60 o 1,66\\\\\\%) y función (al no ser Maamid etc.), se considera nulo y el producto es Casher</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Hemos sumado a los códigos de las listas anteriores uno con la sigla&nbsp;<b>KL</b>.&nbsp; Esto significa que el producto, si bien no contiene leche, está elaborado en utensilios limpios de elaboración de lácteos, habitualmente de leche en polvo y no se trata de leche cuidada desde su ordeñe.&nbsp; La ley en estos casos, es que no se debe mezclar dichos productos dentro de una comida que contenga productos de carne, pero se pueden consumir después de carne (sin necesidad de esperar el tiempo que se acostumbra) o con vajilla de carne limpia (de restos de carne).</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">(Más que una vez fui consultado acerca de mi&nbsp; conducta personal en lo referente a estos códigos.&nbsp; La respuesta es que consumo todo aquello que es lácteo elaborado con leche en polvo y los demás alimentos aunque no estuvieran marcados por la letra M).</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">IMPORTANTE: NINGUNO DE ESTOS PRODUCTOS HA SIDO AUTORIZADO ESPECIALMENTE PARA PÉSAJ.</span></b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;VERIFICAR EN EL RABINATO DE SU COMUNIDAD.</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">MUY IMPORTANTE PARA TENER EN CUENTA:</span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 8pt 0.0001pt 9px; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; vertical-align: baseline; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">1.<span style=\"font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></b><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Existen productos alimenticios en plaza con certificaciones kosher dudosas del exterior.&nbsp; Al no reconocer los símbolos, consulte con su rabino antes de consumir dichos productos.</span></b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;&nbsp;<b>A continuación presentamos algunos de los símbolos de Cashrut más conocidos de EE.UU. e Israel.</b></span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 8pt 8pt 9px; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Dentro de este rubro quiero esclarecer que determinados productos tienen dos símbolos impresos en el envoltorio: cierta supervisión más acreditada para su consumo para todo el año y otra de menos reconocimiento para Pesaj.</span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 8pt 0.0001pt 9px; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; vertical-align: baseline; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">1.<span style=\"font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></b><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">De todos modos, es importante comentar que en ciertas cadenas de supermercados han importado productos casher del exterior.&nbsp; En las etiquetas adosadas por los importadores la información declarada&nbsp;<u>no coincide con la original que aparece en el paquete</u>.</span></b></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 8pt 0.0001pt 9px; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; vertical-align: baseline; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">1.<span style=\"font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Asimismo,&nbsp;<u>ciertos supermercados exponen en sus ?góndolas casher?, productos que no gozan de supervisión rabínica</u>.&nbsp; Suele suceder también que ciertos productos casher se elaboran en establecimientos cuya producción es casher solo para ciertas partidas y usan etiquetas muy similares en sus productos casher y los que no lo son, lo que se presta a confusiones frecuentes.</span></b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\"></span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 8pt 0.0001pt 9px; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; vertical-align: baseline; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">1.<span style=\"font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">A ciertos productos en plaza se los ha publicitado como ?alimento parve? por las empresas que los elaboran y así lo imprimen sobre el envase.&nbsp; Si bien esto significa que dichas empresas declaran por su cuenta que el producto no contiene leche,&nbsp;<u>esto NO significa automáticamente que el producto sea casher</u>.</span></b><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\"></span></p><p class=\"MsoNormal\" style=\"margin-top: 0cm; margin-right: 8pt; margin-bottom: 8pt; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">&nbsp;</span></p><p class=\"MsoNormal\" style=\"margin: 0cm 8pt 0.0001pt 9px; color: rgb(11, 83, 148); text-align: justify; line-height: 12pt; vertical-align: baseline; font-size: 11pt; font-family: Calibri, sans-serif;\"><span style=\"font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">1.<span style=\"font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: &quot;Times New Roman&quot;;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span style=\"font-size: 12pt; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-origin: initial; background-clip: initial;\">Frecuentemente escucho a personas decir que ?X? producto ?se puede? porque es de la empresa ?Y?.&nbsp; Como se darán cuenta, de casi todas las empresas que figuran en este libro, se mencionan únicamente algunos productos, y otros - no.&nbsp; ¿Por qué?&nbsp; Pues en la industria alimenticia hay tantos ingredientes, que es casi imposible ? salvo que una empresa se lo proponga por intereses comerciales ? que todos sus productos sean casher.&nbsp; Por lo tanto,&nbsp;<b>pido al lector que sea minucioso a la hora de consultar este libro y elegir únicamente los productos que aquí se señalan.</b></span></p>', '2019-06-13 16:44:40');

-- --------------------------------------------------------

--
-- Table structure for table `tipoestablecimiento`
--

CREATE TABLE `tipoestablecimiento` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(5000) DEFAULT NULL,
  `fechaUltimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipoestablecimiento`
--

INSERT INTO `tipoestablecimiento` (`id`, `nombre`, `descripcion`, `fechaUltimaModificacion`) VALUES
(1, 'Heladerías', NULL, '2019-06-12 14:18:30'),
(2, 'Locales', NULL, '2019-06-12 14:20:17'),
(3, 'Catering', NULL, '2019-06-12 14:20:25');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fechaBaja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `username`, `password`, `fechaBaja`) VALUES
(1, 'admin', '613mitzvot', NULL),
(2, 'dan', 'dan', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alertas`
--
ALTER TABLE `alertas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `codigo`
--
ALTER TABLE `codigo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indexes for table `establecimientos`
--
ALTER TABLE `establecimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_establecimientotipo` (`rubroId`);

--
-- Indexes for table `lecheparve`
--
ALTER TABLE `lecheparve`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_producto_categoria` (`rubroId`),
  ADD KEY `fk_producto_nivel` (`nivelId`),
  ADD KEY `fk_producto_lecheparveId` (`lecheparveId`);

--
-- Indexes for table `rubro`
--
ALTER TABLE `rubro`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `textos`
--
ALTER TABLE `textos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipoestablecimiento`
--
ALTER TABLE `tipoestablecimiento`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alertas`
--
ALTER TABLE `alertas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `codigo`
--
ALTER TABLE `codigo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `establecimientos`
--
ALTER TABLE `establecimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lecheparve`
--
ALTER TABLE `lecheparve`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rubro`
--
ALTER TABLE `rubro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `textos`
--
ALTER TABLE `textos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tipoestablecimiento`
--
ALTER TABLE `tipoestablecimiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `establecimientos`
--
ALTER TABLE `establecimientos`
  ADD CONSTRAINT `FK_establecimientotipo` FOREIGN KEY (`rubroId`) REFERENCES `tipoestablecimiento` (`id`);

--
-- Constraints for table `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_categoria` FOREIGN KEY (`rubroId`) REFERENCES `rubro` (`id`),
  ADD CONSTRAINT `fk_producto_lecheparveId` FOREIGN KEY (`lecheparveId`) REFERENCES `lecheparve` (`id`),
  ADD CONSTRAINT `fk_producto_nivel` FOREIGN KEY (`nivelId`) REFERENCES `codigo` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
