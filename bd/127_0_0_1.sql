-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-10-2025 a las 04:40:26
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
-- Base de datos: `bitware`
--
CREATE DATABASE IF NOT EXISTS `bitware` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bitware`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carritos_guardados`
--

CREATE TABLE `carritos_guardados` (
  `id_carrito` int(11) NOT NULL,
  `id_usuario` int(10) NOT NULL,
  `id_producto` int(10) NOT NULL,
  `cantidad` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chatbot`
--

CREATE TABLE `chatbot` (
  `id_chat` int(10) NOT NULL,
  `id_usuario` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chatbot_respuestas`
--

CREATE TABLE `chatbot_respuestas` (
  `id` int(11) NOT NULL,
  `pregunta_clave` varchar(255) NOT NULL,
  `respuestas` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `chatbot_respuestas`
--

INSERT INTO `chatbot_respuestas` (`id`, `pregunta_clave`, `respuestas`) VALUES
(1, 'métodos de pago', 'Aceptamos tarjetas de crédito, débito y transferencias bancarias.;Puedes pagar con Webpay o PayPal.'),
(2, 'envío', 'Los envíos en Santiago tardan de 2 a 3 días hábiles.;Para regiones, el tiempo de envío es de 3 a 5 días hábiles.'),
(3, 'garantía', 'Sí, todos nuestros productos tienen una garantía de 1 año.;Claro, la garantía cubre fallos de fábrica por 12 meses.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto_mensajes`
--

CREATE TABLE `contacto_mensajes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `asunto` varchar(255) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` timestamp NOT NULL DEFAULT current_timestamp(),
  `leido` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contacto_mensajes`
--

INSERT INTO `contacto_mensajes` (`id`, `nombre`, `email`, `asunto`, `mensaje`, `fecha_envio`, `leido`) VALUES
(1, 'a', 'Andres.M.A@gmail.com', 'a', 'a', '2025-10-13 00:31:25', 0),
(2, 'AdoLuche', 'd@gmail.com', 'a', 'a', '2025-10-13 00:37:28', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cupones`
--

CREATE TABLE `cupones` (
  `id_cupon` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `tipo_descuento` enum('porcentaje','fijo') NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `fecha_expiracion` date DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cupones`
--

INSERT INTO `cupones` (`id_cupon`, `codigo`, `tipo_descuento`, `valor`, `fecha_expiracion`, `activo`) VALUES
(1, 'DILANPUTO', 'porcentaje', 99.00, '2029-11-18', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dashboard`
--

CREATE TABLE `dashboard` (
  `id_dashboard` bigint(20) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `contenido` text DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `id_usuario` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devoluciones`
--

CREATE TABLE `devoluciones` (
  `id_devolucion` int(11) NOT NULL,
  `id_pedido` int(10) NOT NULL,
  `id_usuario` int(10) NOT NULL,
  `motivo` text NOT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Pendiente',
  `fecha_solicitud` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id_favorito` int(11) NOT NULL,
  `id_usuario` int(10) NOT NULL,
  `id_producto` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `favoritos`
--

INSERT INTO `favoritos` (`id_favorito`, `id_usuario`, `id_producto`) VALUES
(2, 2, 14),
(1, 69, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id_marca` int(10) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`id_marca`, `nombre`, `descripcion`) VALUES
(1, 'NVIDIA', 'NVIDIA Corporation es una empresa estadounidense de tecnología, con sede en Santa Clara, California, conocida por diseñar y fabricar unidades de procesamiento gráfico (GPU). Su ascenso se vio impulsado por el auge de la inteligencia artificial (IA)'),
(2, 'AMD', 'Advanced Micro Devices, Inc. (AMD) es una empresa estadounidense de tecnología, con sede en Santa Clara, California, conocida por diseñar y desarrollar procesadores para computadoras (CPU), unidades de procesamiento gráfico (GPU) y soluciones para servidores, consolas de videojuegos y centros de datos'),
(3, 'INTEL', 'Intel Corporation es una empresa estadounidense líder en la fabricación de semiconductores y tecnología, con sede en Santa Clara, California. Conocida principalmente por inventar la arquitectura de microprocesadores x86, que ha sido el estándar para la mayoría de los ordenadores personales durante décadas, Intel diseña y fabrica procesadores, chipsets, unidades de procesamiento gráfico (GPU) y otros componentes tecnológicos.'),
(4, 'MSI', 'MSI (Micro-Star International Co., Ltd.) es una corporación multinacional taiwanesa, fundada en 1986, líder en el diseño y la fabricación de hardware de alta gama para los mercados de videojuegos, creación de contenido, negocios y soluciones de IA e IoT. A lo largo de su historia, MSI se ha posicionado como una de las marcas de confianza en la industria, especialmente entre los gamers'),
(5, 'GENERICO', 'Marcas Genericas'),
(6, 'OTROS', 'Marcas no categorizadas como genérico ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id_mensaje` int(10) NOT NULL,
  `mensaje` text DEFAULT NULL,
  `id_chat` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_pago`
--

CREATE TABLE `metodo_pago` (
  `id_met_pag` int(10) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodo_pago`
--

INSERT INTO `metodo_pago` (`id_met_pag`, `descripcion`) VALUES
(1, 'Tarjeta de Crédito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `id_moneda` int(10) NOT NULL,
  `tipo_moneda` varchar(25) DEFAULT NULL,
  `descripcion` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`id_moneda`, `tipo_moneda`, `descripcion`) VALUES
(1, 'CLP', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones_stock`
--

CREATE TABLE `notificaciones_stock` (
  `id_notificacion` int(11) NOT NULL,
  `id_usuario` int(10) NOT NULL,
  `id_producto` int(10) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `notificado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_solicitud` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` bigint(20) NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `id_met_pag` int(10) DEFAULT NULL,
  `id_moneda` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(10) NOT NULL,
  `fecha_pedido` date DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Pendiente',
  `id_usuario` int(10) DEFAULT NULL,
  `id_pago` bigint(20) DEFAULT NULL,
  `id_cupon` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `fecha_pedido`, `total`, `estado`, `id_usuario`, `id_pago`, `id_cupon`) VALUES
(86, '2025-10-22', 4990.00, 'Pendiente', 90, NULL, 1),
(87, '2025-10-22', 4990.00, 'Pagado', 90, NULL, NULL),
(88, '2025-10-22', 4990.00, 'Pagado', 69, NULL, NULL),
(89, '2025-10-22', 4990.00, 'Pendiente', 69, NULL, NULL),
(90, '2025-10-22', 4990.00, 'Pendiente', 69, NULL, NULL),
(91, '2025-10-22', 4990.00, 'Pendiente', 69, NULL, NULL),
(92, '2025-10-22', 4990.00, 'Pendiente', 69, NULL, NULL),
(93, '2025-10-22', 1999990.00, 'Pendiente', 69, NULL, NULL),
(94, '2025-10-22', 4990.00, 'Pendiente', 69, NULL, NULL),
(95, '2025-10-22', 4990.00, 'Pendiente', 69, NULL, 1),
(96, '2025-10-22', 4990.00, 'Pendiente', 69, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_productos`
--

CREATE TABLE `pedidos_productos` (
  `id_detalle` int(11) NOT NULL,
  `id_pedido` int(10) NOT NULL,
  `id_producto` int(10) NOT NULL,
  `cantidad` int(5) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos_productos`
--

INSERT INTO `pedidos_productos` (`id_detalle`, `id_pedido`, `id_producto`, `cantidad`, `precio_unitario`) VALUES
(30, 86, 14, 1, 1999990.00),
(31, 87, 14, 1, 1999990.00),
(32, 88, 14, 1, 1999990.00),
(33, 89, 14, 1, 1999990.00),
(34, 90, 14, 1, 1999990.00),
(35, 91, 14, 1, 1999990.00),
(36, 92, 14, 1, 1999990.00),
(37, 93, 14, 1, 1999990.00),
(38, 94, 14, 1, 1999990.00),
(39, 95, 14, 1, 1999990.00),
(40, 96, 14, 1, 1999990.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(10) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(10) DEFAULT NULL,
  `id_marca` int(10) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `imagen_principal` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_marca`, `categoria`, `imagen_principal`, `activo`) VALUES
(1, 'RTX 3060 8GB', 'a', 360000.00, 64, 1, 'gpu', '68e2f152c8a85_rtx4090.jpg', 1),
(7, 'Producto de Prueba', 'Esta es una descripción de prueba.', 99990.00, 46, 1, 'cpu', NULL, 1),
(14, 'AdoLuche', 'AdoLuche', 1999990.00, 19, 6, 'otros', '68e5aa800cd7b_AdoLuche.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_eliminados`
--

CREATE TABLE `productos_eliminados` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(10) DEFAULT NULL,
  `id_marca` int(10) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_eliminacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_eliminados`
--

INSERT INTO `productos_eliminados` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_marca`, `categoria`, `imagen`, `activo`, `fecha_eliminacion`) VALUES
(12, 'AdoLuche', 'Ado', 1.00, 1, 6, '0', '68e5a4ac98d43_Ado.jpg', 1, '2025-10-07 23:39:29'),
(11, 'AdoLuche', 'Ado', 1.00, 1, 6, '0', '68e5a34b33fb5_Ado.jpg', 1, '2025-10-07 23:53:55'),
(13, 'AdoLuche', 'Ado', 1.00, 1, 6, '0', '68e5a80caf190_Ado.jpg', 1, '2025-10-07 23:54:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_imagenes`
--

CREATE TABLE `producto_imagenes` (
  `id_imagen` int(11) NOT NULL,
  `id_producto` int(10) NOT NULL,
  `nombre_archivo` varchar(255) NOT NULL,
  `orden` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto_imagenes`
--

INSERT INTO `producto_imagenes` (`id_imagen`, `id_producto`, `nombre_archivo`, `orden`) VALUES
(3, 14, '68f0569a86b3f_AdoLuche2.jpg', 1),
(4, 14, '68f056a12fadd_AdoLuche3.jpg', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reseñas`
--

CREATE TABLE `reseñas` (
  `id_reseña` int(11) NOT NULL,
  `id_producto` int(10) NOT NULL,
  `id_usuario` int(10) NOT NULL,
  `calificacion` int(1) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `comentario` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `aprobado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reseñas`
--

INSERT INTO `reseñas` (`id_reseña`, `id_producto`, `id_usuario`, `calificacion`, `titulo`, `comentario`, `fecha`, `aprobado`) VALUES
(1, 14, 2, 5, 'AdoLuche', 'AdoLuche', '2025-10-21 01:05:45', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas_chat`
--

CREATE TABLE `respuestas_chat` (
  `id_respuesta` int(10) NOT NULL,
  `respuesta` text DEFAULT NULL,
  `id_chat` int(10) DEFAULT NULL,
  `id_mensaje_original` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_servicio`
--

CREATE TABLE `solicitudes_servicio` (
  `id` int(11) NOT NULL,
  `id_usuario` int(10) NOT NULL,
  `nombre_cliente` varchar(100) NOT NULL,
  `email_cliente` varchar(100) NOT NULL,
  `tipo_servicio` varchar(50) NOT NULL,
  `descripcion_solicitud` text NOT NULL,
  `presupuesto_estimado` decimal(10,2) DEFAULT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Pendiente',
  `fecha_solicitud` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitudes_servicio`
--

INSERT INTO `solicitudes_servicio` (`id`, `id_usuario`, `nombre_cliente`, `email_cliente`, `tipo_servicio`, `descripcion_solicitud`, `presupuesto_estimado`, `estado`, `fecha_solicitud`) VALUES
(5, 69, 'Tobben', 'TobbenT@gmail.com', 'ensamblaje_pc', 'Hola', 1.00, 'En Revisión', '2025-10-11 21:06:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(10) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `codigo_verificacion` varchar(255) DEFAULT NULL,
  `verificado` tinyint(1) NOT NULL DEFAULT 0,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `rut` varchar(12) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `permisos` char(1) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `id_chat` int(10) DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `email`, `password`, `codigo_verificacion`, `verificado`, `reset_token`, `reset_token_expiry`, `rut`, `telefono`, `direccion`, `region`, `permisos`, `activo`, `id_chat`, `foto_perfil`) VALUES
(1, 'Andres Miranda Aguilar', 'andres.m.a@gmail.com', '$2y$10$8cSv27AMMA2CWPuK8cgwKuEam1yLa5cWEVEvVKizAiuabo1yddQDi', NULL, 1, NULL, NULL, '21542967-9', '+56959731240', 'a', 'Metropolitana', 'A', 1, NULL, '68e83faccc7c8_Andres Miranda Aguilar.png'),
(2, 'd', 'd@gmail.com', '$2y$10$tu2Lrv5RFPvNM8DpVRFf8.Q.88KbX2YEZYazAcYcxK4/dEodfjFTS', NULL, 1, NULL, NULL, '21542967-9', '932490076', 'Puente alto', 'Metropolitana', 'U', 1, NULL, NULL),
(69, 'Tobben', 'tobbent@gmail.com', '$2y$10$Tfpu3yq.ruI4krQRizURVONwi9jCbQbicVthhnszrG1wPqVEMbDZu', NULL, 1, NULL, NULL, '21542967-9', '911111111', 'Puente alto', 'Metropolitana', 'A', 1, NULL, '68e1b3d5917c0_Ado.jpg'),
(73, 'Carla Nuñez', 'carla.n@email.com', '$2y$10$K.v9gH6.qJ/hG8.rJ3fL/./p.o./N6.xR2.y.gJ8.b.k.e.o.k.s', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'Valparaíso', 'U', 1, NULL, NULL),
(89, 'AdoLuche', 'da@gmail.com', '$2y$10$WbXnCBkrn2JPCtT8PMZbduaCyA328Zb58HB/m97qnRvWfz.gdr/b6', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'U', 1, NULL, NULL),
(90, 'Darcko', 'darcko@gmail.com', '$2y$10$nHlFfb4A2j/lOwv0R1FEiuq8cKFZKs/4qwrCIQasGOZQkV0sZMz2m', NULL, 1, NULL, NULL, '21542967-9', '516546546', 'Puente alto', 'Metropolitana', 'U', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_eliminados`
--

CREATE TABLE `usuarios_eliminados` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `permisos` char(1) DEFAULT NULL,
  `id_chat` int(10) DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `fecha_eliminacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios_eliminados`
--

INSERT INTO `usuarios_eliminados` (`id_usuario`, `nombre`, `email`, `password`, `telefono`, `direccion`, `region`, `permisos`, `id_chat`, `foto_perfil`, `fecha_eliminacion`) VALUES
(3, 'Felipe', 'f@gmail.com', '$2y$10$sSpM/Eu/YYLHYhJJUDhcj.GFdfsB7a4g9G0tx//4Lq11dFkz4eAey', NULL, NULL, NULL, 'U', NULL, NULL, '2025-10-08 00:09:41'),
(82, 'Sofia Castillo', 'sofia.c@email.com', '$2y$10$K.v9gH6.qJ/hG8.rJ3fL/./p.o./N6.xR2.y.gJ8.b.k.e.o.k.s', NULL, NULL, NULL, 'U', NULL, NULL, '2025-10-16 16:42:24');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carritos_guardados`
--
ALTER TABLE `carritos_guardados`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `chatbot`
--
ALTER TABLE `chatbot`
  ADD PRIMARY KEY (`id_chat`),
  ADD KEY `Chatbot_Usuario_FK` (`id_usuario`);

--
-- Indices de la tabla `chatbot_respuestas`
--
ALTER TABLE `chatbot_respuestas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `contacto_mensajes`
--
ALTER TABLE `contacto_mensajes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cupones`
--
ALTER TABLE `cupones`
  ADD PRIMARY KEY (`id_cupon`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indices de la tabla `dashboard`
--
ALTER TABLE `dashboard`
  ADD PRIMARY KEY (`id_dashboard`),
  ADD KEY `Dashboard_Usuario_FK` (`id_usuario`);

--
-- Indices de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD PRIMARY KEY (`id_devolucion`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id_favorito`),
  ADD UNIQUE KEY `usuario_producto_unico` (`id_usuario`,`id_producto`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id_marca`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id_mensaje`),
  ADD KEY `Mensajes_Chatbot_FK` (`id_chat`);

--
-- Indices de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`id_met_pag`);

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`id_moneda`);

--
-- Indices de la tabla `notificaciones_stock`
--
ALTER TABLE `notificaciones_stock`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `Pagos_Metodo_FK` (`id_met_pag`),
  ADD KEY `Pagos_Moneda_FK` (`id_moneda`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `Pedidos_Usuario_FK` (`id_usuario`),
  ADD KEY `Pedidos_Pagos_FK` (`id_pago`),
  ADD KEY `fk_pedido_cupon` (`id_cupon`);

--
-- Indices de la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `Producto_Marca_FK` (`id_marca`);

--
-- Indices de la tabla `productos_eliminados`
--
ALTER TABLE `productos_eliminados`
  ADD KEY `Producto_Marca_FK` (`id_marca`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `producto_imagenes`
--
ALTER TABLE `producto_imagenes`
  ADD PRIMARY KEY (`id_imagen`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `reseñas`
--
ALTER TABLE `reseñas`
  ADD PRIMARY KEY (`id_reseña`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `respuestas_chat`
--
ALTER TABLE `respuestas_chat`
  ADD PRIMARY KEY (`id_respuesta`),
  ADD KEY `Respuestas_Chatbot_FK` (`id_chat`),
  ADD KEY `Respuestas_Mensajes_FK` (`id_mensaje_original`);

--
-- Indices de la tabla `solicitudes_servicio`
--
ALTER TABLE `solicitudes_servicio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `Usuario_Chatbot_FK` (`id_chat`);

--
-- Indices de la tabla `usuarios_eliminados`
--
ALTER TABLE `usuarios_eliminados`
  ADD KEY `Usuario_Chatbot_FK` (`id_chat`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carritos_guardados`
--
ALTER TABLE `carritos_guardados`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `chatbot`
--
ALTER TABLE `chatbot`
  MODIFY `id_chat` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `chatbot_respuestas`
--
ALTER TABLE `chatbot_respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `contacto_mensajes`
--
ALTER TABLE `contacto_mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cupones`
--
ALTER TABLE `cupones`
  MODIFY `id_cupon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `dashboard`
--
ALTER TABLE `dashboard`
  MODIFY `id_dashboard` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  MODIFY `id_devolucion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id_favorito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id_marca` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id_mensaje` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  MODIFY `id_met_pag` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `moneda`
--
ALTER TABLE `moneda`
  MODIFY `id_moneda` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `notificaciones_stock`
--
ALTER TABLE `notificaciones_stock`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT de la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `producto_imagenes`
--
ALTER TABLE `producto_imagenes`
  MODIFY `id_imagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `reseñas`
--
ALTER TABLE `reseñas`
  MODIFY `id_reseña` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `respuestas_chat`
--
ALTER TABLE `respuestas_chat`
  MODIFY `id_respuesta` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes_servicio`
--
ALTER TABLE `solicitudes_servicio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carritos_guardados`
--
ALTER TABLE `carritos_guardados`
  ADD CONSTRAINT `fk_carrito_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `chatbot`
--
ALTER TABLE `chatbot`
  ADD CONSTRAINT `Chatbot_Usuario_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `dashboard`
--
ALTER TABLE `dashboard`
  ADD CONSTRAINT `Dashboard_Usuario_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `fk_favorito_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_favorito_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `Mensajes_Chatbot_FK` FOREIGN KEY (`id_chat`) REFERENCES `chatbot` (`id_chat`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `Pagos_Metodo_FK` FOREIGN KEY (`id_met_pag`) REFERENCES `metodo_pago` (`id_met_pag`),
  ADD CONSTRAINT `Pagos_Moneda_FK` FOREIGN KEY (`id_moneda`) REFERENCES `moneda` (`id_moneda`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `Pedidos_Pagos_FK` FOREIGN KEY (`id_pago`) REFERENCES `pagos` (`id_pago`),
  ADD CONSTRAINT `Pedidos_Usuario_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `fk_pedido_cupon` FOREIGN KEY (`id_cupon`) REFERENCES `cupones` (`id_cupon`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
  ADD CONSTRAINT `fk_detalle_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `Producto_Marca_FK` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id_marca`);

--
-- Filtros para la tabla `producto_imagenes`
--
ALTER TABLE `producto_imagenes`
  ADD CONSTRAINT `fk_producto_imagenes` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reseñas`
--
ALTER TABLE `reseñas`
  ADD CONSTRAINT `fk_reseña_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reseña_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas_chat`
--
ALTER TABLE `respuestas_chat`
  ADD CONSTRAINT `Respuestas_Chatbot_FK` FOREIGN KEY (`id_chat`) REFERENCES `chatbot` (`id_chat`),
  ADD CONSTRAINT `Respuestas_Mensajes_FK` FOREIGN KEY (`id_mensaje_original`) REFERENCES `mensajes` (`id_mensaje`);

--
-- Filtros para la tabla `solicitudes_servicio`
--
ALTER TABLE `solicitudes_servicio`
  ADD CONSTRAINT `solicitudes_servicio_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `Usuario_Chatbot_FK` FOREIGN KEY (`id_chat`) REFERENCES `chatbot` (`id_chat`);
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"vinai_db_normalizada\",\"table\":\"vinos\"},{\"db\":\"vinai_db_normalizada\",\"table\":\"admins\"},{\"db\":\"vinai_db_normalizada\",\"table\":\"vinas\"},{\"db\":\"bitware\",\"table\":\"usuario\"},{\"db\":\"bitware\",\"table\":\"pagos\"},{\"db\":\"bitware\",\"table\":\"pedidos_productos\"},{\"db\":\"bitware\",\"table\":\"pedidos\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-10-22 02:37:52', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Base de datos: `vinai_db_normalizada`
--
CREATE DATABASE IF NOT EXISTS `vinai_db_normalizada` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `vinai_db_normalizada`;

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
(2, 'EnoturismoAD', 'scrypt:32768:8:1$VqRSH1iosKp8PwXm$83b69442d80d2b9fb28c4076da4d6feab068b9f789e0afaa46cc6aa14117fc94e3b9dce148a84d69dfd79aa08f90743885afcbf8b0920cf6643d3a10de4a5b77');

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
  `imagen_url` varchar(512) DEFAULT NULL COMMENT 'URL de una imagen representativa de la viña/tour'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vinas`
--

INSERT INTO `vinas` (`id`, `nombre`, `valle`, `comuna`, `descripcion_tour`, `horario_tour`, `duracion_tour`, `precio_tour`, `tipo_tour`, `link_web`, `imagen_url`) VALUES
(1, 'Concha y Toro', 'Valle del Maipo', 'Pirque', 'Tour Leyenda del Casillero del Diablo y degustación de reserva.', 'Lunes a Domingo (10:00 - 17:00)', '60 min', '$24.000 CLP', 'Clásico, Leyenda', 'https://www.conchaytoro.com/tours/', 'https://ejemplo.com/imagen_vina_conchaytoro.jpg'),
(2, 'Santa Rita', 'Valle del Maipo', 'Buin', 'Tour Histórico de la Hacienda, Museo Andino y cata de 3 vinos.', 'Martes a Domingo (9:30 - 18:00)', '90 min', 'Desde $28.000 CLP', 'Histórico, Museo, Jardín', 'https://www.santarita.com/tour-en-vina-santa-rita/', NULL),
(3, 'Montes', 'Valle de Colchagua', 'Santa Cruz', 'Tour Icono \"Folly\" con vista panorámica y degustación premium.', 'Lunes a Sábado (10:00 - 16:30)', '75 min', 'Desde $35.000 CLP', 'Premium, Ícono, Arquitectura', 'https://monteswines.com/tours/', NULL),
(4, 'Viña Errázuriz', 'Valle de Aconcagua', 'Panquehue', 'Tour Don Maximiano, enfocado en la historia y el terroir de Aconcagua.', 'Lunes a Viernes (10:30 y 14:30)', NULL, NULL, NULL, 'https://errazuriz.com/turismo/', NULL),
(5, 'Casas del Bosque', 'Valle de Casablanca', 'Casablanca', 'Degustación de vinos blancos y gastronomía.', 'Martes a Domingo (9:30 - 18:00)', NULL, NULL, NULL, 'https://casasdelbosque.cl', NULL),
(6, 'Viña Montes', 'Valle de Colchagua', 'Santa Cruz', 'Tour \"Alpha\" con visita a la bodega de gravedad y cata de reserva.', 'Lunes a Sábado (10:00 - 16:30)', NULL, NULL, NULL, 'https://monteswines.com/tours/', NULL),
(7, 'Lapostolle', 'Valle de Colchagua', 'Santa Cruz', 'Tour \"Clos Apalta\", experiencia de lujo y arquitectura impresionante.', 'Miércoles a Domingo (11:00 y 15:00)', NULL, NULL, NULL, 'https://www.lapostolle.com/visit-us/', NULL),
(8, 'Viña Undurraga', 'Valle del Maipo', 'Buin', 'Tour Founder\'s Cellar con cata en el corazón de la bodega.', 'Lunes a Domingo (10:00 - 17:30)', NULL, NULL, NULL, 'https://www.undurragaturismo.cl/', NULL),
(9, 'Casa Silva', 'Valle de Colchagua', 'San Fernando', 'Tour y cabalgata, ideal para amantes de la naturaleza.', 'Lunes a Domingo (9:00 - 18:00)', NULL, NULL, NULL, 'https://casasilva.cl/es/turismo/', NULL),
(10, 'Viña Indómita', 'Valle de Casablanca', 'Casablanca', 'Tour en terraza con vista al valle, especial para Sauvignon Blanc.', 'Jueves a Martes (10:00 - 18:00)', NULL, NULL, NULL, 'https://www.indomita.cl/turismo/', NULL),
(11, 'Viña Cousiño Macul', 'Valle del Maipo', 'Pirque', 'Tour Histórico y visita a las bodegas originales del siglo XIX.', 'Martes a Sábado (10:30 - 15:30)', NULL, NULL, NULL, 'https://www.cousinomacul.com/enoturismo/', NULL),
(12, 'Viña Matetic', 'Valle de San Antonio', 'Santo Domingo', 'Tour Biodinámico y degustación de vinos orgánicos.', 'Miércoles a Domingo (11:00 y 15:00)', NULL, NULL, NULL, 'https://matetic.com/enoturismo/', NULL),
(13, 'Viña Vik', 'Valle de Millahue', 'San Vicente de Tagua Tagua', 'Tour de Arte, Diseño y Cata en el hotel de lujo.', 'Lunes a Domingo (10:00 - 17:00)', '120 min', '$$$', 'Premium, Lujo, Hotel, Arte', 'https://vikchile.com/es/vina-vik/', NULL),
(14, 'Viña Koyle', 'Valle de Colchagua', 'Santa Cruz', 'Tour de Viñedos y cata de vinos \'Koyle Royale\'.', 'Lunes a Viernes (10:00 - 16:00)', NULL, NULL, NULL, 'https://koyle.cl/tours/', NULL),
(15, 'Viña Leyda', 'Valle de Leyda', 'San Antonio', 'Tour Enfriamiento Costero, enfocado en el clima frío.', 'Miércoles a Domingo (11:00 y 15:00)', NULL, NULL, NULL, 'https://www.vinosdechile.cl/vi%C3%B1as/vi%C3%B1a-leyda/', NULL),
(16, 'Viña Sutil', 'Valle de Colchagua', 'Santa Cruz', 'Tour Clásico Sutil y cata en la bodega.', 'Lunes a Sábado (10:00 - 17:00)', NULL, NULL, NULL, 'https://www.sutil.com/turismo/', NULL),
(17, 'Viña Morandé', 'Valle del Maipo', 'Buin', 'Tour de la Casona Morandé y cata de vinos premium.', 'Martes a Sábado (10:30 - 15:00)', NULL, NULL, NULL, 'https://morande.cl/turismo/', NULL),
(18, 'Viña Emiliana', 'Valle de Casablanca', 'Casablanca', 'Tour Orgánico y biodinámico, con visita a los animales de granja.', 'Martes a Domingo (10:00 - 17:00)', '90 min', '$$', 'Orgánico, Biodinámico, Granja', 'https://emiliana.cl/visitanos/', NULL),
(19, 'Viña Veramonte', 'Valle de Casablanca', 'Casablanca', 'Tour de la Bodega y Cata en el jardín con vista.', 'Lunes a Domingo (10:00 - 17:30)', NULL, NULL, NULL, 'https://veramonte.cl/enoturismo/', NULL),
(20, 'Viña Perez Cruz', 'Valle del Maipo', 'Huelquen', 'Tour Arquitectónico y cata de sus Cabernet Sauvignon.', 'Lunes a Viernes (10:00 y 14:00)', NULL, NULL, NULL, 'https://perezcruz.com/es/turismo/', NULL),
(21, 'Viña Almaviva', 'Valle del Maipo', 'Puente Alto', 'Tour de alta gama enfocado en nuestro vino ícono y el terroir de Puente Alto.', 'Lunes a Viernes (10:00 y 15:00)', NULL, NULL, NULL, 'https://www.almavivawinery.com/', NULL),
(22, 'Viña Ventisquero', 'Valle de Colchagua', 'Requínoa', 'Explora nuestros viñedos en Apalta y degusta la línea premium Grey.', 'Martes a Sábado (10:30, 12:30, 15:30)', NULL, NULL, NULL, 'https://www.ventisquero.com/enoturismo/', NULL),
(23, 'Viña Tarapacá', 'Valle del Maipo', 'Isla de Maipo', 'Visita nuestra histórica casona y bodega, con una cata de la línea Gran Reserva.', 'Martes a Domingo (10:00 - 17:00)', NULL, NULL, NULL, 'https://www.tarapaca.cl/nuestros-tours/', NULL),
(24, 'Bodegas RE', 'Valle de Casablanca', 'Casablanca', 'Una experiencia de vinificación creativa y ancestral, con degustación de tinajas.', 'Miércoles a Lunes (11:00 - 18:00)', NULL, NULL, NULL, 'https://bodegasre.cl/pages/tours-y-degustaciones', NULL),
(25, 'Seña', 'Valle de Aconcagua', NULL, 'Una experiencia íntima y biodinámica, centrada en nuestro vino ícono de clase mundial.', 'Solo con reserva previa', NULL, NULL, NULL, 'https://sena.cl/', NULL),
(26, 'Viñedo Chadwick', 'Valle del Maipo', 'Puente Alto', 'Tour privado por el viñedo histórico de Puente Alto, cuna de uno de los vinos más premiados de Chile.', 'Solo con reserva previa', NULL, NULL, NULL, 'https://vinedochadwick.cl/', NULL),
(27, 'Neyen', 'Valle de Colchagua', 'Palmilla', 'Visita nuestras parras centenarias en Apalta y descubre el espíritu del lugar en cada copa.', 'Martes a Domingo (10:30, 15:30)', NULL, NULL, NULL, 'https://neyen.cl/', NULL),
(28, 'Von Siebenthal', 'Valle de Aconcagua', 'Calle Larga', 'Un recorrido por nuestra bodega de estilo clásico y una cata de vinos de inspiración europea.', 'Lunes a Sábado (11:00, 15:00)', NULL, NULL, NULL, 'https://www.vinavonsiebenthal.com/', NULL);

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
