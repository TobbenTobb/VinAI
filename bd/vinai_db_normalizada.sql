-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-11-2025 a las 03:13:45
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
-- Base de datos: `vinai_db_normalizada`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(80) NOT NULL,
  `password_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `admins`
--

INSERT INTO `admins` (`id`, `username`, `password_hash`) VALUES
(2, 'EnoturismoAD', 'scrypt:32768:8:1$R9SxrURVHeVz4L9p$933331d86cbd51acc043a808f07ccfd8129508092cabd553d0fce7a5f9611d4c7fd4c1db996bb5cf44a4ef235cd58e889b95ef1d25c705e48f8ad338f4d1a6ab');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caracteristicas`
--

CREATE TABLE `caracteristicas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caracteristicas`
--

INSERT INTO `caracteristicas` (`id`, `nombre`) VALUES
(9, 'Biodinámico'),
(4, 'Dulce'),
(2, 'Fresco'),
(10, 'Joven'),
(7, 'Ligero'),
(8, 'Mineral'),
(5, 'Orgánico'),
(6, 'Reserva'),
(1, 'Robusto'),
(3, 'Seco');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maridajes`
--

CREATE TABLE `maridajes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `maridajes`
--

INSERT INTO `maridajes` (`id`, `nombre`) VALUES
(3, 'Charcutería'),
(6, 'Comida Asiatica'),
(10, 'Ensaladas'),
(9, 'Mariscos'),
(1, 'Parrillada'),
(8, 'Pastas con Salsa Roja'),
(4, 'Pescado Blanco'),
(7, 'Pizza'),
(5, 'Postres'),
(2, 'Sushi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas_sabor`
--

CREATE TABLE `notas_sabor` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notas_sabor`
--

INSERT INTO `notas_sabor` (`id`, `nombre`) VALUES
(15, 'Arándano'),
(12, 'Café'),
(7, 'Cereza'),
(6, 'Chocolate'),
(14, 'Ciruela'),
(5, 'Cítrico'),
(8, 'Durazno'),
(13, 'Frambuesa'),
(2, 'Guinda'),
(11, 'Hierba'),
(4, 'Manzana'),
(9, 'Miel'),
(3, 'Pimienta'),
(10, 'Tabaco'),
(1, 'Vainilla');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preferencias_usuario`
--

CREATE TABLE `preferencias_usuario` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_preferencia` enum('cepa','tipo_vino','valle','maridaje','caracteristica') NOT NULL,
  `valor_preferencia` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `preferencias_usuario`
--

INSERT INTO `preferencias_usuario` (`id`, `usuario_id`, `tipo_preferencia`, `valor_preferencia`) VALUES
(1, 1, 'cepa', 'Carmenere'),
(2, 1, 'tipo_vino', 'Tinto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `email`, `password_hash`, `fecha_registro`) VALUES
(1, 'david', 'david.cabezas.armando@gmail.com', 'scrypt:32768:8:1$4TmrZoGwW4JukvzW$e458a7536ce0737c11619fd0e776a3d0cbacd00582c16224dc6963494c97c1eb0f40f3ba87e0fc29b9baf3e844dd311bbc760d6dbadf7d1e83037fb5177a89ac', '2025-11-07 22:58:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoraciones_tour`
--

CREATE TABLE `valoraciones_tour` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `vina_id` int(11) NOT NULL,
  `rating` tinyint(1) NOT NULL COMMENT 'Rating del 1 al 5',
  `comentario` text DEFAULT NULL,
  `fecha_valoracion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `valoraciones_tour`
--

INSERT INTO `valoraciones_tour` (`id`, `usuario_id`, `vina_id`, `rating`, `comentario`, `fecha_valoracion`) VALUES
(1, 1, 2, 5, 'quiero valorar Santa Rita con 5 estrellas', '2025-11-07 23:27:04'),
(2, 1, 3, 5, 'quiero valorar Montes con 5 estrellas', '2025-11-08 00:16:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vinas`
--

CREATE TABLE `vinas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `valle` varchar(255) DEFAULT NULL,
  `comuna` varchar(100) DEFAULT NULL COMMENT 'Comuna específica donde se ubica la viña',
  `descripcion_tour` text DEFAULT NULL,
  `horario_tour` varchar(255) DEFAULT NULL,
  `duracion_tour` varchar(50) DEFAULT NULL COMMENT 'Duración estimada del tour (ej: 90 min)',
  `precio_tour` varchar(50) DEFAULT NULL COMMENT 'Precio o rango de precio del tour (ej: $25.000 CLP, Desde $15.000)',
  `tipo_tour` varchar(255) DEFAULT NULL COMMENT 'Categorías del tour (ej: Clásico, Premium, Gastronómico, Bicicleta)',
  `link_web` varchar(255) DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `imagen_url` varchar(512) DEFAULT NULL COMMENT 'URL de una imagen representativa de la viña/tour'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vinas`
--

INSERT INTO `vinas` (`id`, `nombre`, `valle`, `comuna`, `descripcion_tour`, `horario_tour`, `duracion_tour`, `precio_tour`, `tipo_tour`, `link_web`, `latitud`, `longitud`, `imagen_url`) VALUES
(1, 'Concha y Toro', 'Valle del Maipo', 'Pirque', 'Tour Leyenda del Casillero del Diablo y degustación de reserva.', 'Lunes a Domingo (10:00 - 17:00)', '60 min', '$24.000 CLP', 'Clásico, Leyenda', 'https://www.conchaytoro.com/tours/', NULL, NULL, 'https://ejemplo.com/imagen_vina_conchaytoro.jpg'),
(2, 'Santa Rita', 'Valle del Maipo', 'Buin', 'Tour Histórico de la Hacienda, Museo Andino y cata de 3 vinos.', 'Martes a Domingo (9:30 - 18:00)', '90 min', 'Desde $28.000 CLP', 'Histórico, Museo, Jardín', 'https://www.santarita.com/tour-en-vina-santa-rita/', NULL, NULL, NULL),
(3, 'Montes', 'Valle de Colchagua', 'Santa Cruz', 'Tour Icono \"Folly\" con vista panorámica y degustación premium.', 'Lunes a Sábado (10:00 - 16:30)', '75 min', 'Desde $35.000 CLP', 'Premium, Ícono, Arquitectura', 'https://monteswines.com/tours/', NULL, NULL, NULL),
(4, 'Viña Errázuriz', 'Valle de Aconcagua', 'Panquehue', 'Tour Don Maximiano, enfocado en la historia y el terroir de Aconcagua.', 'Lunes a Viernes (10:30 y 14:30)', NULL, NULL, NULL, 'https://errazuriz.com/turismo/', NULL, NULL, NULL),
(5, 'Casas del Bosque', 'Valle de Casablanca', 'Casablanca', 'Degustación de vinos blancos y gastronomía.', 'Martes a Domingo (9:30 - 18:00)', NULL, NULL, NULL, 'https://casasdelbosque.cl', NULL, NULL, NULL),
(6, 'Viña Montes', 'Valle de Colchagua', 'Santa Cruz', 'Tour \"Alpha\" con visita a la bodega de gravedad y cata de reserva.', 'Lunes a Sábado (10:00 - 16:30)', NULL, NULL, NULL, 'https://monteswines.com/tours/', NULL, NULL, NULL),
(7, 'Lapostolle', 'Valle de Colchagua', 'Santa Cruz', 'Tour \"Clos Apalta\", experiencia de lujo y arquitectura impresionante.', 'Miércoles a Domingo (11:00 y 15:00)', NULL, NULL, NULL, 'https://www.lapostolle.com/visit-us/', NULL, NULL, NULL),
(8, 'Viña Undurraga', 'Valle del Maipo', 'Buin', 'Tour Founder\'s Cellar con cata en el corazón de la bodega.', 'Lunes a Domingo (10:00 - 17:30)', NULL, NULL, NULL, 'https://www.undurragaturismo.cl/', NULL, NULL, NULL),
(9, 'Casa Silva', 'Valle de Colchagua', 'San Fernando', 'Tour y cabalgata, ideal para amantes de la naturaleza.', 'Lunes a Domingo (9:00 - 18:00)', NULL, NULL, NULL, 'https://casasilva.cl/es/turismo/', NULL, NULL, NULL),
(10, 'Viña Indómita', 'Valle de Casablanca', 'Casablanca', 'Tour en terraza con vista al valle, especial para Sauvignon Blanc.', 'Jueves a Martes (10:00 - 18:00)', NULL, NULL, NULL, 'https://www.indomita.cl/turismo/', NULL, NULL, NULL),
(11, 'Viña Cousiño Macul', 'Valle del Maipo', 'Pirque', 'Tour Histórico y visita a las bodegas originales del siglo XIX.', 'Martes a Sábado (10:30 - 15:30)', NULL, NULL, NULL, 'https://www.cousinomacul.com/enoturismo/', NULL, NULL, NULL),
(12, 'Viña Matetic', 'Valle de San Antonio', 'Santo Domingo', 'Tour Biodinámico y degustación de vinos orgánicos.', 'Miércoles a Domingo (11:00 y 15:00)', NULL, NULL, NULL, 'https://matetic.com/enoturismo/', NULL, NULL, NULL),
(13, 'Viña Vik', 'Valle de Millahue', 'San Vicente de Tagua Tagua', 'Tour de Arte, Diseño y Cata en el hotel de lujo.', 'Lunes a Domingo (10:00 - 17:00)', '120 min', '$$$', 'Premium, Lujo, Hotel, Arte', 'https://vikchile.com/es/vina-vik/', NULL, NULL, NULL),
(14, 'Viña Koyle', 'Valle de Colchagua', 'Santa Cruz', 'Tour de Viñedos y cata de vinos \'Koyle Royale\'.', 'Lunes a Viernes (10:00 - 16:00)', NULL, NULL, NULL, 'https://koyle.cl/tours/', NULL, NULL, NULL),
(15, 'Viña Leyda', 'Valle de Leyda', 'San Antonio', 'Tour Enfriamiento Costero, enfocado en el clima frío.', 'Miércoles a Domingo (11:00 y 15:00)', NULL, NULL, NULL, 'https://www.vinosdechile.cl/vi%C3%B1as/vi%C3%B1a-leyda/', NULL, NULL, NULL),
(16, 'Viña Sutil', 'Valle de Colchagua', 'Santa Cruz', 'Tour Clásico Sutil y cata en la bodega.', 'Lunes a Sábado (10:00 - 17:00)', NULL, NULL, NULL, 'https://www.sutil.com/turismo/', NULL, NULL, NULL),
(17, 'Viña Morandé', 'Valle del Maipo', 'Buin', 'Tour de la Casona Morandé y cata de vinos premium.', 'Martes a Sábado (10:30 - 15:00)', NULL, NULL, NULL, 'https://morande.cl/turismo/', NULL, NULL, NULL),
(18, 'Viña Emiliana', 'Valle de Casablanca', 'Casablanca', 'Tour Orgánico y biodinámico, con visita a los animales de granja.', 'Martes a Domingo (10:00 - 17:00)', '90 min', '$$', 'Orgánico, Biodinámico, Granja', 'https://emiliana.cl/visitanos/', NULL, NULL, NULL),
(19, 'Viña Veramonte', 'Valle de Casablanca', 'Casablanca', 'Tour de la Bodega y Cata en el jardín con vista.', 'Lunes a Domingo (10:00 - 17:30)', NULL, NULL, NULL, 'https://veramonte.cl/enoturismo/', NULL, NULL, NULL),
(20, 'Viña Perez Cruz', 'Valle del Maipo', 'Huelquen', 'Tour Arquitectónico y cata de sus Cabernet Sauvignon.', 'Lunes a Viernes (10:00 y 14:00)', NULL, NULL, NULL, 'https://perezcruz.com/es/turismo/', NULL, NULL, NULL),
(21, 'Viña Almaviva', 'Valle del Maipo', 'Puente Alto', 'Tour de alta gama enfocado en nuestro vino ícono y el terroir de Puente Alto.', 'Lunes a Viernes (10:00 y 15:00)', NULL, NULL, NULL, 'https://www.almavivawinery.com/', NULL, NULL, NULL),
(22, 'Viña Ventisquero', 'Valle de Colchagua', 'Requínoa', 'Explora nuestros viñedos en Apalta y degusta la línea premium Grey.', 'Martes a Sábado (10:30, 12:30, 15:30)', NULL, NULL, NULL, 'https://www.ventisquero.com/enoturismo/', NULL, NULL, NULL),
(23, 'Viña Tarapacá', 'Valle del Maipo', 'Isla de Maipo', 'Visita nuestra histórica casona y bodega, con una cata de la línea Gran Reserva.', 'Martes a Domingo (10:00 - 17:00)', NULL, NULL, NULL, 'https://www.tarapaca.cl/nuestros-tours/', NULL, NULL, NULL),
(24, 'Bodegas RE', 'Valle de Casablanca', 'Casablanca', 'Una experiencia de vinificación creativa y ancestral, con degustación de tinajas.', 'Miércoles a Lunes (11:00 - 18:00)', NULL, NULL, NULL, 'https://bodegasre.cl/pages/tours-y-degustaciones', NULL, NULL, NULL),
(25, 'Seña', 'Valle de Aconcagua', NULL, 'Una experiencia íntima y biodinámica, centrada en nuestro vino ícono de clase mundial.', 'Solo con reserva previa', NULL, NULL, NULL, 'https://sena.cl/', NULL, NULL, NULL),
(26, 'Viñedo Chadwick', 'Valle del Maipo', 'Puente Alto', 'Tour privado por el viñedo histórico de Puente Alto, cuna de uno de los vinos más premiados de Chile.', 'Solo con reserva previa', NULL, NULL, NULL, 'https://vinedochadwick.cl/', NULL, NULL, NULL),
(27, 'Neyen', 'Valle de Colchagua', 'Palmilla', 'Visita nuestras parras centenarias en Apalta y descubre el espíritu del lugar en cada copa.', 'Martes a Domingo (10:30, 15:30)', NULL, NULL, NULL, 'https://neyen.cl/', NULL, NULL, NULL),
(28, 'Von Siebenthal', 'Valle de Aconcagua', 'Calle Larga', 'Un recorrido por nuestra bodega de estilo clásico y una cata de vinos de inspiración europea.', 'Lunes a Sábado (11:00, 15:00)', NULL, NULL, NULL, 'https://www.vinavonsiebenthal.com/', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vinos`
--

CREATE TABLE `vinos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `cepa` varchar(100) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `cuerpo` enum('Ligero','Medio','Completo') DEFAULT NULL COMMENT 'Cuerpo del vino',
  `acidez` enum('Baja','Media','Alta') DEFAULT NULL COMMENT 'Nivel de acidez',
  `taninos` enum('Bajos','Medios','Altos') DEFAULT NULL COMMENT 'Nivel de taninos (principalmente tintos)',
  `dulzor` enum('Seco','Semi-Seco','Dulce') DEFAULT NULL COMMENT 'Nivel de dulzor percibido',
  `vina_id` int(11) DEFAULT NULL,
  `link_compra` varchar(255) DEFAULT NULL,
  `imagen_url` varchar(512) DEFAULT NULL COMMENT 'URL de la imagen de la botella/etiqueta',
  `precio_aproximado` enum('$','$$','$$$') DEFAULT NULL COMMENT 'Rango de precio ($: Económico, $$: Medio, $$$: Premium/Ícono)',
  `potencial_guarda` varchar(50) DEFAULT 'Beber ahora' COMMENT 'Estimación de guarda (ej: Beber ahora, 3-5 años, 10+ años)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vinos`
--

INSERT INTO `vinos` (`id`, `nombre`, `cepa`, `ano`, `tipo`, `cuerpo`, `acidez`, `taninos`, `dulzor`, `vina_id`, `link_compra`, `imagen_url`, `precio_aproximado`, `potencial_guarda`) VALUES
(1, 'Don Melchor', 'Cabernet Sauvignon', 2020, 'Tinto', 'Completo', 'Media', 'Altos', 'Seco', 1, 'https://ejemplo.com/don-melchor', 'https://ejemplo.com/imagen_don_melchor.jpg', '$$$', '10+ años'),
(2, 'Lote D', 'Carmenere', 2021, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 9, 'https://ejemplo.com/lote-d', NULL, '$$', '5-10 años'),
(3, 'Alpha', 'Pinot Noir', 2022, 'Tinto', NULL, NULL, NULL, NULL, 3, 'https://ejemplo.com/montes-alpha', NULL, NULL, 'Beber ahora'),
(4, 'Max Reserva', 'Sauvignon Blanc', 2023, 'Blanco', 'Ligero', 'Alta', NULL, 'Seco', 4, 'https://ejemplo.com/max-sb', NULL, '$', 'Beber ahora'),
(5, 'Pequeñas Producciones', 'Chardonnay', 2022, 'Blanco', NULL, NULL, NULL, NULL, 5, 'https://ejemplo.com/pp-ch', NULL, NULL, 'Beber ahora'),
(6, 'Gran Reserva', 'Merlot', 2021, 'Tinto', NULL, NULL, NULL, NULL, 2, 'https://ejemplo.com/sr-merlot', NULL, NULL, 'Beber ahora'),
(7, 'Frontera', 'Sauvignon Blanc', 2023, 'Blanco', 'Ligero', 'Alta', NULL, 'Seco', 1, 'https://ejemplo.com/frontera-sb', NULL, '$', 'Beber ahora'),
(8, 'Carmenere Peumo', 'Carmenere', 2020, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 8, 'https://ejemplo.com/und-carm', NULL, '$$', '5-10 años'),
(9, 'Viña Leyda Lot 21', 'Pinot Noir', 2022, 'Tinto', NULL, NULL, NULL, NULL, 15, 'https://ejemplo.com/leyda-pn', NULL, NULL, 'Beber ahora'),
(10, 'Clos Apalta', 'Carmenere', 2019, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 7, 'https://ejemplo.com/clos-apalta', NULL, '$$', '5-10 años'),
(11, 'Cool Coast', 'Sauvignon Blanc', 2023, 'Blanco', 'Ligero', 'Alta', NULL, 'Seco', 9, 'https://ejemplo.com/cool-coast', NULL, '$', 'Beber ahora'),
(12, '1865 Single Vineyard', 'Syrah', 2021, 'Tinto', NULL, NULL, NULL, NULL, 2, 'https://ejemplo.com/1865-syrah', NULL, NULL, 'Beber ahora'),
(13, 'Organic Cabernet Sauvignon', 'Cabernet Sauvignon', 2022, 'Tinto', NULL, NULL, NULL, NULL, 18, 'https://ejemplo.com/emiliana-cs', NULL, NULL, 'Beber ahora'),
(14, 'Coastal Reserva', 'Sauvignon Blanc', 2023, 'Blanco', 'Ligero', 'Alta', NULL, 'Seco', 19, 'https://ejemplo.com/veramonte-sb', NULL, '$', 'Beber ahora'),
(15, 'Liguai', 'Cabernet Sauvignon', 2020, 'Tinto', NULL, NULL, NULL, NULL, 20, 'https://ejemplo.com/liguai', NULL, NULL, 'Beber ahora'),
(16, 'Antiguas Reservas', 'Chardonnay', 2022, 'Blanco', NULL, NULL, NULL, NULL, 11, 'https://ejemplo.com/cm-chard', NULL, NULL, 'Beber ahora'),
(17, 'Gran Tarapacá', 'Malbec', 2021, 'Tinto', NULL, NULL, NULL, NULL, 2, 'https://ejemplo.com/gt-malbec', NULL, NULL, 'Beber ahora'),
(18, 'Koyle Gran Reserva', 'Cabernet Sauvignon', 2021, 'Tinto', NULL, NULL, NULL, NULL, 14, 'https://ejemplo.com/koyle-gr', NULL, NULL, 'Beber ahora'),
(19, 'Matetic EQ', 'Sauvignon Blanc', 2022, 'Blanco', NULL, NULL, NULL, NULL, 12, 'https://ejemplo.com/matetic-sb', NULL, NULL, 'Beber ahora'),
(20, 'Vik', 'Cabernet Sauvignon', 2019, 'Tinto', NULL, NULL, NULL, NULL, 13, 'https://ejemplo.com/vik', NULL, NULL, 'Beber ahora'),
(21, 'Almaviva', 'Cabernet Sauvignon', 2019, 'Tinto', NULL, NULL, NULL, NULL, 21, 'https://ejemplo.com/almaviva', NULL, NULL, 'Beber ahora'),
(22, 'Herú', 'Pinot Noir', 2022, 'Tinto', NULL, NULL, NULL, NULL, 22, 'https://ejemplo.com/heru', NULL, NULL, 'Beber ahora'),
(23, 'Grey Glacier', 'Sauvignon Blanc', 2023, 'Blanco', 'Ligero', 'Alta', NULL, 'Seco', 22, 'https://ejemplo.com/grey-sb', NULL, '$', 'Beber ahora'),
(24, 'Gran Reserva Etiqueta Negra', 'Cabernet Sauvignon', 2020, 'Tinto', NULL, NULL, NULL, NULL, 23, 'https://ejemplo.com/tarapaca-en', NULL, NULL, 'Beber ahora'),
(25, 'Renacido', 'Garnacha', 2021, 'Tinto', NULL, NULL, NULL, NULL, 24, 'https://ejemplo.com/re-garnacha', NULL, NULL, 'Beber ahora'),
(26, 'Tara', 'Chardonnay', 2022, 'Blanco', NULL, NULL, NULL, NULL, 5, 'https://ejemplo.com/tara-ch', NULL, NULL, 'Beber ahora'),
(27, 'Coyam', 'Syrah', 2019, 'Tinto', NULL, NULL, NULL, NULL, 18, 'https://ejemplo.com/coyam', NULL, NULL, 'Beber ahora'),
(28, 'Marques de Casa Concha', 'Merlot', 2021, 'Tinto', NULL, NULL, NULL, NULL, 1, 'https://ejemplo.com/marques-merlot', NULL, NULL, 'Beber ahora'),
(29, 'Edición Limitada', 'Malbec', 2020, 'Tinto', NULL, NULL, NULL, NULL, 9, 'https://ejemplo.com/cs-malbec', NULL, NULL, 'Beber ahora'),
(30, 'Rosé', 'Pinot Noir', 2023, 'Rosado', NULL, NULL, NULL, NULL, 5, 'https://ejemplo.com/casas-rose', NULL, NULL, 'Beber ahora'),
(31, 'Doña Bernarda', 'Cabernet Sauvignon', 2018, 'Tinto', NULL, NULL, NULL, NULL, 2, 'https://ejemplo.com/dona-bernarda', NULL, NULL, 'Beber ahora'),
(32, 'Queulat', 'Sauvignon Blanc', 2022, 'Blanco', NULL, NULL, NULL, NULL, 22, 'https://ejemplo.com/queulat-sb', NULL, NULL, 'Beber ahora'),
(33, 'Vértice', 'Carmenere', 2020, 'Tinto', NULL, NULL, NULL, NULL, 22, 'https://ejemplo.com/vertice', NULL, NULL, 'Beber ahora'),
(34, 'Cinsault', 'Cinsault', 2022, 'Tinto', NULL, NULL, NULL, NULL, 24, 'https://ejemplo.com/re-cinsault', NULL, NULL, 'Beber ahora'),
(35, 'Finis Terrae', 'Cabernet Sauvignon', 2019, 'Tinto', NULL, NULL, NULL, NULL, 11, 'https://ejemplo.com/finis-terrae', NULL, NULL, 'Beber ahora'),
(36, 'Amelia', 'Chardonnay', 2021, 'Blanco', NULL, NULL, NULL, NULL, 1, 'https://ejemplo.com/amelia', NULL, NULL, 'Beber ahora'),
(37, 'La Piu Belle', 'Carmenere', 2020, 'Tinto', NULL, NULL, NULL, NULL, 13, 'https://ejemplo.com/la-piu-belle', NULL, NULL, 'Beber ahora'),
(38, 'Auma', 'Carmenere', 2018, 'Tinto', NULL, NULL, NULL, NULL, 18, 'https://ejemplo.com/auma', NULL, NULL, 'Beber ahora'),
(39, 'Ritual', 'Pinot Noir', 2022, 'Tinto', NULL, NULL, NULL, NULL, 19, 'https://ejemplo.com/ritual-pn', NULL, NULL, 'Beber ahora'),
(40, 'House of Morandé', 'Cabernet Sauvignon', 2017, 'Tinto', NULL, NULL, NULL, NULL, 17, 'https://ejemplo.com/house-morande', NULL, NULL, 'Beber ahora'),
(41, 'ARMO', 'Cabernet Franc', 2020, 'Tinto', NULL, NULL, NULL, NULL, 20, 'https://ejemplo.com/armo-cf', NULL, NULL, 'Beber ahora'),
(42, 'Gê', 'Syrah', 2019, 'Tinto', NULL, NULL, NULL, NULL, 18, 'https://ejemplo.com/ge-syrah', NULL, NULL, 'Beber ahora'),
(43, 'Cipreses Vineyard', 'Sauvignon Blanc', 2023, 'Blanco', 'Ligero', 'Alta', NULL, 'Seco', 5, 'https://ejemplo.com/cipreses-sb', NULL, '$', 'Beber ahora'),
(44, 'Don Reca', 'Merlot', 2021, 'Tinto', NULL, NULL, NULL, NULL, 2, 'https://ejemplo.com/don-reca', NULL, NULL, 'Beber ahora'),
(45, 'Las Pizarras', 'Chardonnay', 2020, 'Blanco', NULL, NULL, NULL, NULL, 4, 'https://ejemplo.com/las-pizarras', NULL, NULL, 'Beber ahora'),
(46, 'Don Melchor', 'Cabernet Sauvignon', 1987, 'Tinto', 'Completo', 'Media', 'Altos', 'Seco', 1, 'https://ejemplo.com/dm-1987', NULL, '$$$', '10+ años'),
(47, 'Casa Real Reserva Especial', 'Cabernet Sauvignon', 1989, 'Tinto', NULL, NULL, NULL, NULL, 2, 'https://ejemplo.com/cr-1989', NULL, NULL, 'Beber ahora'),
(48, 'Don Maximiano Founder\'s Reserve', 'Cabernet Sauvignon', 1995, 'Tinto', NULL, NULL, NULL, NULL, 4, 'https://ejemplo.com/dm-1995', NULL, NULL, 'Beber ahora'),
(49, 'Viñedo Chadwick', 'Cabernet Sauvignon', 1999, 'Tinto', 'Completo', 'Media', 'Altos', 'Seco', 26, 'https://ejemplo.com/vc-1999', NULL, '$$$', '10+ años'),
(50, 'Seña', 'Carmenere', 2001, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 25, 'https://ejemplo.com/sena-2001', NULL, '$$', '5-10 años'),
(51, 'Almaviva', 'Cabernet Sauvignon', 2005, 'Tinto', 'Completo', 'Media', 'Altos', 'Seco', 21, 'https://ejemplo.com/almaviva-2005', NULL, '$$$', '10+ años'),
(52, 'Folly', 'Syrah', 2008, 'Tinto', NULL, NULL, NULL, NULL, 3, 'https://ejemplo.com/folly-2008', NULL, NULL, 'Beber ahora'),
(53, 'Neyen Espíritu de Apalta', 'Carmenere', 2011, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 27, 'https://ejemplo.com/neyen-2011', NULL, '$$', '5-10 años'),
(54, 'Tatay de Cristobal', 'Carmenere', 2013, 'Tinto', NULL, NULL, NULL, NULL, 28, 'https://ejemplo.com/tatay-2013', NULL, NULL, 'Beber ahora'),
(55, 'Purple Angel', 'Carmenere', 2015, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 3, 'https://ejemplo.com/purple-angel-2015', NULL, '$$', '5-10 años'),
(56, 'Kai', 'Carmenere', 2017, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 4, 'https://ejemplo.com/kai-2017', NULL, '$$', '5-10 años'),
(57, 'Viñedo Chadwick', 'Cabernet Sauvignon', 2018, 'Tinto', 'Completo', 'Media', 'Altos', 'Seco', 26, 'https://ejemplo.com/vc-2018', NULL, '$$$', '10+ años'),
(58, 'Seña', 'Carmenere', 2019, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 25, 'https://ejemplo.com/sena-2019', NULL, '$$', '5-10 años'),
(59, 'The Real Chardonnay', 'Chardonnay', 2020, 'Blanco', NULL, NULL, NULL, NULL, 14, 'https://ejemplo.com/koyle-chard', NULL, NULL, 'Beber ahora'),
(60, 'Montes Alpha M', 'Cabernet Sauvignon', 2020, 'Tinto', NULL, NULL, NULL, NULL, 3, 'https://ejemplo.com/alpha-m-2020', NULL, NULL, 'Beber ahora'),
(61, 'Gravas del Maipo', 'Syrah', 2021, 'Tinto', NULL, NULL, NULL, NULL, 1, 'https://ejemplo.com/gravas-syrah', NULL, NULL, 'Beber ahora'),
(62, 'Herencia', 'Carmenere', 2021, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 2, 'https://ejemplo.com/herencia-2021', NULL, '$$', '5-10 años'),
(63, 'Las Pizarras', 'Pinot Noir', 2022, 'Tinto', NULL, NULL, NULL, NULL, 4, 'https://ejemplo.com/pizarras-pn', NULL, NULL, 'Beber ahora'),
(64, 'Cipreses Vineyard', 'Sauvignon Blanc', 2023, 'Blanco', 'Ligero', 'Alta', NULL, 'Seco', 5, 'https://ejemplo.com/cipreses-sb-23', NULL, '$', 'Beber ahora'),
(65, 'REnaissance', 'Syrah', 2023, 'Tinto', NULL, NULL, NULL, NULL, 24, 'https://ejemplo.com/re-renaissance', NULL, NULL, 'Beber ahora'),
(66, 'Don Melchor', 'Cabernet Sauvignon', 1999, 'Tinto', NULL, NULL, NULL, NULL, 1, 'https://ejemplo.com/dm-1999', NULL, NULL, 'Beber ahora'),
(67, 'Almaviva', 'Cabernet Sauvignon', 2010, 'Tinto', 'Completo', 'Media', 'Altos', 'Seco', 21, 'https://ejemplo.com/almaviva-2010', NULL, '$$$', '10+ años'),
(68, 'Casa Real Reserva Especial', 'Cabernet Sauvignon', 1997, 'Tinto', NULL, NULL, NULL, NULL, 2, 'https://ejemplo.com/cr-1997', NULL, NULL, 'Beber ahora'),
(69, 'Seña', 'Carmenere', 2014, 'Tinto', NULL, NULL, NULL, NULL, 25, 'https://ejemplo.com/sena-2014', NULL, NULL, 'Beber ahora'),
(70, 'Viñedo Chadwick', 'Cabernet Sauvignon', 2014, 'Tinto', 'Completo', 'Media', 'Altos', 'Seco', 26, 'https://ejemplo.com/vc-2014', NULL, '$$$', '10+ años'),
(71, 'Cenit', 'Cabernet Sauvignon', 2016, 'Tinto', NULL, NULL, NULL, NULL, 28, 'https://ejemplo.com/cenit-2016', NULL, NULL, 'Beber ahora'),
(72, 'Signos de Origen', 'Syrah', 2022, 'Tinto', NULL, NULL, NULL, NULL, 18, 'https://ejemplo.com/signos-syrah', NULL, NULL, 'Beber ahora'),
(73, 'Terrunyo', 'Carmenere', 2020, 'Tinto', 'Medio', 'Media', 'Medios', 'Seco', 1, 'https://ejemplo.com/terrunyo-carm', NULL, '$$', '5-10 años'),
(74, 'Altura', 'Syrah', 2018, 'Tinto', NULL, NULL, NULL, NULL, 4, 'https://ejemplo.com/altura-2018', NULL, NULL, 'Beber ahora'),
(75, 'Lota', 'Cabernet Sauvignon', 2017, 'Tinto', NULL, NULL, NULL, NULL, 9, 'https://ejemplo.com/lota-2017', NULL, NULL, 'Beber ahora'),
(77, 'Joseph Parra', 'Copia', 2020, 'Tinto', NULL, NULL, NULL, NULL, 1, 'https://www.enoturismochile.cl/', NULL, NULL, 'Beber ahora'),
(78, 'joseph', 'parra', 2025, 'Rosado', NULL, NULL, NULL, NULL, 15, 'https://www.google.com/search?q=rasa+lenguaje+de+programacion&sxsrf=AE3TifMjdoo5hsOSv9pqUSl8Ck6nQ5ei8A%3A1761062315301', NULL, NULL, 'Beber ahora');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vino_caracteristica`
--

CREATE TABLE `vino_caracteristica` (
  `vino_id` int(11) NOT NULL,
  `caracteristica_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vino_caracteristica`
--

INSERT INTO `vino_caracteristica` (`vino_id`, `caracteristica_id`) VALUES
(1, 1),
(1, 6),
(2, 1),
(2, 6),
(3, 6),
(3, 7),
(4, 2),
(4, 8),
(5, 3),
(5, 6),
(6, 1),
(6, 6),
(7, 2),
(7, 10),
(8, 1),
(8, 6),
(9, 2),
(9, 7),
(10, 1),
(10, 6),
(11, 2),
(11, 8),
(12, 1),
(12, 6),
(13, 1),
(13, 5),
(14, 2),
(14, 8),
(15, 1),
(15, 6),
(16, 3),
(16, 6),
(17, 1),
(17, 6),
(18, 1),
(18, 5),
(19, 2),
(19, 9),
(20, 1),
(20, 6),
(21, 1),
(21, 6),
(22, 6),
(22, 7),
(23, 2),
(23, 3),
(23, 8),
(24, 1),
(24, 6),
(25, 7),
(25, 10),
(26, 2),
(26, 8),
(27, 1),
(27, 5),
(27, 9),
(28, 1),
(28, 6),
(29, 1),
(29, 6),
(30, 2),
(30, 10),
(31, 1),
(31, 6),
(32, 2),
(32, 3),
(33, 1),
(34, 7),
(34, 10),
(35, 1),
(35, 6),
(36, 3),
(36, 6),
(36, 8),
(37, 1),
(37, 4),
(38, 1),
(38, 5),
(38, 9),
(39, 6),
(39, 7),
(40, 1),
(40, 6),
(41, 1),
(42, 1),
(42, 5),
(42, 9),
(43, 2),
(43, 8),
(44, 1),
(45, 2),
(45, 6),
(45, 8),
(46, 1),
(46, 6),
(47, 1),
(47, 6),
(48, 1),
(48, 6),
(49, 1),
(49, 6),
(50, 1),
(50, 6),
(50, 9),
(51, 1),
(51, 6),
(52, 1),
(52, 6),
(53, 1),
(53, 6),
(54, 1),
(54, 6),
(55, 1),
(55, 6),
(56, 1),
(56, 6),
(57, 1),
(57, 6),
(58, 1),
(58, 6),
(58, 9),
(59, 3),
(59, 8),
(60, 1),
(60, 6),
(61, 1),
(61, 8),
(62, 1),
(62, 6),
(63, 7),
(63, 8),
(64, 2),
(64, 3),
(65, 10),
(66, 1),
(66, 6),
(67, 1),
(67, 6),
(68, 1),
(68, 6),
(69, 1),
(69, 6),
(69, 9),
(70, 1),
(70, 6),
(71, 1),
(71, 6),
(72, 1),
(72, 5),
(73, 1),
(73, 6),
(74, 1),
(74, 8),
(75, 1),
(75, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vino_maridaje`
--

CREATE TABLE `vino_maridaje` (
  `vino_id` int(11) NOT NULL,
  `maridaje_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vino_maridaje`
--

INSERT INTO `vino_maridaje` (`vino_id`, `maridaje_id`) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 5),
(3, 2),
(3, 10),
(4, 4),
(4, 9),
(5, 4),
(5, 6),
(6, 1),
(6, 7),
(7, 9),
(7, 10),
(8, 1),
(8, 3),
(9, 2),
(9, 4),
(10, 1),
(10, 3),
(11, 4),
(11, 9),
(12, 1),
(12, 5),
(13, 1),
(13, 3),
(14, 9),
(14, 10),
(15, 1),
(15, 3),
(16, 4),
(16, 6),
(17, 1),
(17, 5),
(18, 1),
(18, 3),
(19, 4),
(19, 9),
(20, 1),
(20, 3),
(21, 1),
(21, 8),
(22, 2),
(22, 4),
(23, 9),
(23, 10),
(24, 1),
(24, 3),
(25, 3),
(25, 7),
(26, 4),
(26, 9),
(27, 1),
(27, 7),
(28, 7),
(28, 8),
(29, 1),
(30, 2),
(30, 6),
(30, 10),
(31, 1),
(32, 9),
(33, 1),
(33, 8),
(34, 3),
(34, 7),
(35, 1),
(36, 4),
(36, 8),
(37, 3),
(37, 5),
(38, 1),
(39, 2),
(39, 4),
(40, 1),
(40, 3),
(41, 1),
(41, 8),
(42, 1),
(43, 9),
(44, 7),
(44, 8),
(45, 4),
(45, 9),
(46, 1),
(46, 3),
(47, 1),
(47, 8),
(48, 1),
(49, 1),
(49, 3),
(50, 1),
(50, 8),
(51, 1),
(52, 1),
(53, 1),
(53, 8),
(54, 1),
(55, 1),
(55, 7),
(56, 1),
(56, 8),
(57, 1),
(58, 1),
(58, 8),
(59, 4),
(59, 9),
(60, 1),
(61, 1),
(62, 1),
(62, 8),
(63, 2),
(63, 4),
(64, 9),
(64, 10),
(65, 7),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(69, 8),
(70, 1),
(71, 1),
(72, 1),
(72, 7),
(73, 1),
(73, 3),
(74, 1),
(75, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vino_nota`
--

CREATE TABLE `vino_nota` (
  `vino_id` int(11) NOT NULL,
  `nota_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vino_nota`
--

INSERT INTO `vino_nota` (`vino_id`, `nota_id`) VALUES
(1, 6),
(1, 7),
(1, 10),
(2, 3),
(2, 6),
(2, 14),
(3, 2),
(3, 13),
(4, 5),
(4, 11),
(5, 1),
(5, 4),
(6, 3),
(6, 14),
(7, 5),
(7, 11),
(8, 3),
(8, 14),
(9, 13),
(9, 15),
(10, 6),
(10, 10),
(11, 5),
(11, 11),
(12, 3),
(12, 15),
(13, 6),
(13, 7),
(14, 5),
(14, 11),
(15, 7),
(15, 10),
(16, 1),
(16, 4),
(17, 14),
(17, 15),
(18, 6),
(18, 7),
(19, 5),
(19, 11),
(20, 6),
(20, 7),
(21, 6),
(21, 7),
(21, 10),
(22, 7),
(22, 13),
(23, 5),
(23, 11),
(24, 1),
(24, 14),
(25, 3),
(25, 13),
(26, 4),
(26, 9),
(27, 3),
(27, 6),
(27, 15),
(28, 1),
(28, 14),
(29, 1),
(29, 14),
(30, 7),
(30, 13),
(31, 7),
(31, 10),
(32, 5),
(33, 3),
(33, 14),
(34, 2),
(34, 13),
(35, 1),
(35, 7),
(35, 10),
(36, 1),
(36, 4),
(36, 9),
(37, 6),
(37, 14),
(38, 6),
(38, 12),
(38, 14),
(39, 7),
(39, 11),
(39, 13),
(40, 7),
(40, 10),
(41, 3),
(41, 11),
(42, 3),
(42, 15),
(43, 5),
(43, 11),
(44, 1),
(44, 14),
(45, 4),
(45, 5),
(45, 9),
(46, 6),
(46, 7),
(46, 10),
(47, 6),
(47, 10),
(47, 14),
(48, 7),
(48, 10),
(49, 6),
(49, 7),
(49, 14),
(50, 3),
(50, 6),
(50, 14),
(51, 7),
(51, 10),
(52, 3),
(52, 6),
(52, 15),
(53, 6),
(53, 14),
(54, 3),
(54, 14),
(55, 1),
(55, 14),
(55, 15),
(56, 3),
(56, 7),
(56, 14),
(57, 7),
(57, 10),
(58, 3),
(58, 6),
(58, 14),
(59, 4),
(59, 5),
(59, 9),
(60, 7),
(60, 10),
(60, 15),
(61, 3),
(61, 15),
(62, 6),
(62, 14),
(63, 7),
(63, 13),
(64, 5),
(64, 11),
(65, 2),
(65, 13),
(66, 7),
(66, 10),
(67, 7),
(67, 10),
(68, 10),
(68, 14),
(69, 3),
(69, 14),
(70, 7),
(70, 14),
(71, 7),
(71, 10),
(72, 3),
(72, 15),
(73, 3),
(73, 6),
(73, 14),
(74, 3),
(74, 15),
(75, 6),
(75, 7),
(75, 10);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `caracteristicas`
--
ALTER TABLE `caracteristicas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `maridajes`
--
ALTER TABLE `maridajes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `notas_sabor`
--
ALTER TABLE `notas_sabor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `preferencias_usuario`
--
ALTER TABLE `preferencias_usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `valoraciones_tour`
--
ALTER TABLE `valoraciones_tour`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `vina_id` (`vina_id`);

--
-- Indices de la tabla `vinas`
--
ALTER TABLE `vinas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vinos`
--
ALTER TABLE `vinos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vina_id` (`vina_id`);

--
-- Indices de la tabla `vino_caracteristica`
--
ALTER TABLE `vino_caracteristica`
  ADD PRIMARY KEY (`vino_id`,`caracteristica_id`),
  ADD KEY `caracteristica_id` (`caracteristica_id`);

--
-- Indices de la tabla `vino_maridaje`
--
ALTER TABLE `vino_maridaje`
  ADD PRIMARY KEY (`vino_id`,`maridaje_id`),
  ADD KEY `maridaje_id` (`maridaje_id`);

--
-- Indices de la tabla `vino_nota`
--
ALTER TABLE `vino_nota`
  ADD PRIMARY KEY (`vino_id`,`nota_id`),
  ADD KEY `nota_id` (`nota_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `caracteristicas`
--
ALTER TABLE `caracteristicas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `maridajes`
--
ALTER TABLE `maridajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `notas_sabor`
--
ALTER TABLE `notas_sabor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `preferencias_usuario`
--
ALTER TABLE `preferencias_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `valoraciones_tour`
--
ALTER TABLE `valoraciones_tour`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vinas`
--
ALTER TABLE `vinas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `vinos`
--
ALTER TABLE `vinos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `preferencias_usuario`
--
ALTER TABLE `preferencias_usuario`
  ADD CONSTRAINT `preferencias_usuario_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `valoraciones_tour`
--
ALTER TABLE `valoraciones_tour`
  ADD CONSTRAINT `valoraciones_tour_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `valoraciones_tour_ibfk_2` FOREIGN KEY (`vina_id`) REFERENCES `vinas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `vinos`
--
ALTER TABLE `vinos`
  ADD CONSTRAINT `vinos_ibfk_1` FOREIGN KEY (`vina_id`) REFERENCES `vinas` (`id`);

--
-- Filtros para la tabla `vino_caracteristica`
--
ALTER TABLE `vino_caracteristica`
  ADD CONSTRAINT `vino_caracteristica_ibfk_1` FOREIGN KEY (`vino_id`) REFERENCES `vinos` (`id`),
  ADD CONSTRAINT `vino_caracteristica_ibfk_2` FOREIGN KEY (`caracteristica_id`) REFERENCES `caracteristicas` (`id`);

--
-- Filtros para la tabla `vino_maridaje`
--
ALTER TABLE `vino_maridaje`
  ADD CONSTRAINT `vino_maridaje_ibfk_1` FOREIGN KEY (`vino_id`) REFERENCES `vinos` (`id`),
  ADD CONSTRAINT `vino_maridaje_ibfk_2` FOREIGN KEY (`maridaje_id`) REFERENCES `maridajes` (`id`);

--
-- Filtros para la tabla `vino_nota`
--
ALTER TABLE `vino_nota`
  ADD CONSTRAINT `vino_nota_ibfk_1` FOREIGN KEY (`vino_id`) REFERENCES `vinos` (`id`),
  ADD CONSTRAINT `vino_nota_ibfk_2` FOREIGN KEY (`nota_id`) REFERENCES `notas_sabor` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
