-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-04-2024 a las 18:38:18
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
-- Base de datos: `blogging_platform`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `ID` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`ID`, `nombre`, `fecha_creacion`) VALUES
(1, 'Deportes', '2024-04-03 23:13:35'),
(2, 'Cultura', '2024-04-03 23:13:35'),
(3, 'Revistas', '2024-04-03 23:13:35'),
(4, 'Narrativa', '2024-04-03 23:13:35'),
(5, 'Empleo', '2024-04-03 23:15:06'),
(6, 'Ficción', '2024-04-04 00:17:01'),
(7, 'Ficcion', '2024-04-04 16:01:49'),
(8, 'Ficcion', '2024-04-04 16:04:26'),
(9, 'Ficcion', '2024-04-04 16:04:34'),
(10, 'Ficcion', '2024-04-04 16:06:03'),
(11, 'Ficcion', '2024-04-04 16:06:58'),
(12, 'Ficcion', '2024-04-04 16:35:57'),
(13, 'Ficcion', '2024-04-04 16:35:59'),
(14, 'Ficcion', '2024-04-04 16:36:33'),
(15, 'Ficcion', '2024-04-04 16:36:34'),
(16, 'Acapella', '2024-04-04 16:39:03'),
(17, 'Acapella', '2024-04-04 16:40:56'),
(18, 'Danza', '2024-04-04 16:41:04'),
(19, 'ARTE', '2024-04-04 16:41:14'),
(20, 'ARTE', '2024-04-04 16:56:18'),
(21, 'ARTE', '2024-04-04 17:04:37'),
(22, 'ARTE', '2024-04-04 17:04:39'),
(23, 'ARTE', '2024-04-04 17:11:37'),
(24, 'Ficcion', '2024-04-04 20:53:55'),
(25, 'Ficcion', '2024-04-04 20:59:01'),
(26, 'MANUALIDAD', '2024-04-04 20:59:51'),
(27, 'MANUALIDAD', '2024-04-04 21:00:26'),
(28, 'Lenguaje', '2024-04-05 15:55:35'),
(29, 'Lenguaje', '2024-04-05 15:55:38'),
(30, 'Lenguaje', '2024-04-05 15:57:48'),
(31, 'Folclor', '2024-04-05 15:57:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `ID` int(11) NOT NULL,
  `Contenido` text NOT NULL,
  `UsuarioID` int(11) NOT NULL,
  `PublicacionID` int(11) NOT NULL,
  `FechaCreacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones`
--

CREATE TABLE `publicaciones` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `contenido` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `publicaciones`
--

INSERT INTO `publicaciones` (`id`, `titulo`, `contenido`, `usuario_id`, `fecha_creacion`) VALUES
(2, 'La era del HIELO', 'Accion', NULL, '2024-04-04 22:54:00'),
(3, 'La era del HIELO', 'Accion', NULL, '2024-04-04 23:00:33'),
(4, NULL, NULL, NULL, '2024-04-05 02:01:17'),
(5, NULL, NULL, NULL, '2024-04-05 02:01:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `rol` enum('administrador','usuario') DEFAULT 'usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `rol_id`, `apellido`, `rol`) VALUES
(1, '', 'jorge@gmail.com', 'jorge123', 2, NULL, 'usuario'),
(2, '', 'admin@gmail.com', 'admin123', 1, NULL, 'usuario'),
(3, 'admin123', 'admin@gmail.com', 'admin123', 1, NULL, 'administrador'),
(4, 'juan', 'juan@gmail.com', 'juan123', 1, NULL, 'administrador'),
(5, NULL, 'pabloadmi@gmail.com', 'pablo123', 1, NULL, 'administrador'),
(6, '', 'admin3@gmail.com', 'admin123', 1, NULL, 'administrador');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UsuarioID` (`UsuarioID`),
  ADD KEY `PublicacionID` (`PublicacionID`);

--
-- Indices de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UsuarioID` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`UsuarioID`) REFERENCES `usuarios` (`ID`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`PublicacionID`) REFERENCES `publicaciones` (`id`);

--
-- Filtros para la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD CONSTRAINT `publicaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
