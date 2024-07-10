-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-07-2024 a las 20:53:09
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calidad`
--

CREATE TABLE `calidad` (
  `IDCalidad` int(1) NOT NULL,
  `Nivel` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calidad`
--

INSERT INTO `calidad` (`IDCalidad`, `Nivel`) VALUES
(0, 'Buena'),
(1, 'Media'),
(3, 'Mala');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flor`
--

CREATE TABLE `flor` (
  `IDFlor` int(11) NOT NULL,
  `Ubicacion` text NOT NULL,
  `IDUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mediciones`
--

CREATE TABLE `mediciones` (
  `IDMedicion` int(11) NOT NULL,
  `Valores(ppm)` int(11) NOT NULL,
  `IDTipo` int(1) NOT NULL,
  `IDCalidad` int(1) NOT NULL,
  `Sensor` varchar(20) NOT NULL,
  `IDFlor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `IDMensaje` int(11) NOT NULL,
  `Contenido` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensaje`
--

INSERT INTO `mensaje` (`IDMensaje`, `Contenido`) VALUES
(0, 'Se recomienda ventilar'),
(1, 'El nivel de su aire es bueno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `IDNotificacion` int(11) NOT NULL,
  `IDUsuario` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `IDMensaje` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `IDTipo` int(1) NOT NULL,
  `Gas` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`IDTipo`, `Gas`) VALUES
(0, 'CO'),
(1, 'GAS INFLAMABLE'),
(2, 'PL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `IDUsuario` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Correo` text NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Telefono` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calidad`
--
ALTER TABLE `calidad`
  ADD PRIMARY KEY (`IDCalidad`);

--
-- Indices de la tabla `flor`
--
ALTER TABLE `flor`
  ADD PRIMARY KEY (`IDFlor`),
  ADD KEY `FK_usuario_flor` (`IDUsuario`);

--
-- Indices de la tabla `mediciones`
--
ALTER TABLE `mediciones`
  ADD PRIMARY KEY (`IDMedicion`),
  ADD KEY `FK_Tipo_mediciones` (`IDTipo`),
  ADD KEY `FK_Calidad_mediciones` (`IDCalidad`),
  ADD KEY `FK_flor_mediciones` (`IDFlor`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`IDMensaje`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`IDNotificacion`),
  ADD KEY `FK_mensaje_notificaciones` (`IDMensaje`),
  ADD KEY `FK_usuario_notificaciones` (`IDUsuario`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`IDTipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`IDUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `flor`
--
ALTER TABLE `flor`
  MODIFY `IDFlor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IDUsuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `flor`
--
ALTER TABLE `flor`
  ADD CONSTRAINT `FK_usuario_flor` FOREIGN KEY (`IDUsuario`) REFERENCES `usuario` (`IDUsuario`);

--
-- Filtros para la tabla `mediciones`
--
ALTER TABLE `mediciones`
  ADD CONSTRAINT `FK_Calidad_mediciones` FOREIGN KEY (`IDCalidad`) REFERENCES `calidad` (`IDCalidad`),
  ADD CONSTRAINT `FK_Tipo_mediciones` FOREIGN KEY (`IDTipo`) REFERENCES `tipo` (`IDTipo`),
  ADD CONSTRAINT `FK_flor_mediciones` FOREIGN KEY (`IDFlor`) REFERENCES `flor` (`IDFlor`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `FK_mensaje_notificaciones` FOREIGN KEY (`IDMensaje`) REFERENCES `mensaje` (`IDMensaje`),
  ADD CONSTRAINT `FK_usuario_notificaciones` FOREIGN KEY (`IDUsuario`) REFERENCES `usuario` (`IDUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
