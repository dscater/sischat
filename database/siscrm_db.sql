-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-05-2024 a las 18:53:48
-- Versión del servidor: 8.0.30
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `siscrm_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_maps`
--

CREATE TABLE `api_maps` (
  `id` bigint UNSIGNED NOT NULL,
  `google_maps` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `map_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `api_maps`
--

INSERT INTO `api_maps` (`id`, `google_maps`, `map_id`, `created_at`, `updated_at`) VALUES
(1, 'AIzaSyDhJquXCekb8guwEiX1aLHvPePi3SMkKis', '1fb896f332f7b53c', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campanias`
--

CREATE TABLE `campanias` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_ini` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_cliente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filtro_cliente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `producto_id` bigint UNSIGNED DEFAULT NULL,
  `cantidad_compra` double(10,2) DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catalogo_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `campanias`
--

INSERT INTO `campanias` (`id`, `nombre`, `fecha_ini`, `fecha_fin`, `tipo`, `tipo_cliente`, `filtro_cliente`, `producto_id`, `cantidad_compra`, `descripcion`, `catalogo_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(6, 'CAMPAÑA #1', '2024-04-28', '2024-05-05', 'GIFTCARD', 'TODOS', '', NULL, NULL, 'DESCRIPCION CAMPAÑA #1 TODOS LOS CLIENTES MOD', NULL, '2024-04-28', '2024-04-28 17:17:04', '2024-05-03 20:11:55'),
(7, 'CAMPAÑA #2', '2024-04-28', '2024-05-05', 'CATÁLOGO', 'PERSONALIZADO', 'CLIENTES ESPECIFICOS', 7, NULL, 'DESC. CAMPAÑA #2', 1, '2024-04-28', '2024-04-28 17:19:53', '2024-05-03 20:54:32'),
(8, 'CAMPAÑA #3', '2024-04-28', '2024-04-29', 'CATÁLOGO', 'PERSONALIZADO', 'PRODUCTO COMPRADO', 3, NULL, 'DESCRIPCION CAMP 3', 2, '2024-04-28', '2024-04-28 17:21:37', '2024-04-30 14:08:34'),
(9, 'CAMPAÑA 4', '2024-04-28', '2024-04-29', 'RECORDATORIO', 'PERSONALIZADO', 'CANTIDAD COMPRA', NULL, 3.00, 'DESC CAMP 4', NULL, '2024-04-28', '2024-04-28 17:23:27', '2024-04-28 17:23:28'),
(11, 'CAMPAÑA 5', '2024-04-28', '2024-04-29', 'RECORDATORIO', 'PERSONALIZADO', 'CLIENTES ESPECIFICOS', NULL, NULL, 'DESC. CAMPAÑA 5', NULL, '2024-04-28', '2024-04-28 17:24:49', '2024-04-28 17:24:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campania_automaticas`
--

CREATE TABLE `campania_automaticas` (
  `id` bigint UNSIGNED NOT NULL,
  `campania_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `fecha_ini` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `frecuencia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `campania_automaticas`
--

INSERT INTO `campania_automaticas` (`id`, `campania_id`, `tipo`, `fecha_registro`, `fecha_ini`, `fecha_fin`, `frecuencia`, `dias`, `created_at`, `updated_at`) VALUES
(1, 6, 'TODOS', '2024-04-28', '2024-04-28', '2024-04-29', 'RANGO DE FECHAS', '', '2024-04-28 19:46:30', '2024-04-28 19:46:30'),
(2, 7, 'CORREO', '2024-04-28', NULL, NULL, 'DÍAS', '5,30', '2024-04-28 19:51:31', '2024-04-28 19:53:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campania_detalles`
--

CREATE TABLE `campania_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `campania_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `campania_detalles`
--

INSERT INTO `campania_detalles` (`id`, `campania_id`, `cliente_id`, `created_at`, `updated_at`) VALUES
(7, 11, 7, '2024-04-28 17:33:03', '2024-04-28 17:33:03'),
(16, 7, 6, '2024-05-03 22:07:48', '2024-05-03 22:07:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campania_envios`
--

CREATE TABLE `campania_envios` (
  `id` bigint UNSIGNED NOT NULL,
  `campania_id` bigint UNSIGNED NOT NULL,
  `campania_automatico_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_envio` date NOT NULL,
  `total_fisicos` int NOT NULL,
  `total_ecommerce` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `campania_envios`
--

INSERT INTO `campania_envios` (`id`, `campania_id`, `campania_automatico_id`, `fecha_envio`, `total_fisicos`, `total_ecommerce`, `created_at`, `updated_at`) VALUES
(1, 6, NULL, '2024-04-28', 12, 6, '2024-04-28 21:00:31', '2024-04-28 21:06:08'),
(2, 6, NULL, '2024-04-29', 6, 3, '2024-04-29 16:11:10', '2024-04-29 16:42:44'),
(3, 7, NULL, '2024-04-29', 0, 2, '2024-04-29 16:12:19', '2024-04-29 16:45:43'),
(4, 6, NULL, '2024-05-03', 17, 7, '2024-05-03 20:12:06', '2024-05-03 20:54:02'),
(5, 7, NULL, '2024-05-03', 12, 44, '2024-05-03 20:22:07', '2024-05-03 22:08:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogos`
--

CREATE TABLE `catalogos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `catalogos`
--

INSERT INTO `catalogos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'CATALOGO #1', '2024-04-28 16:07:59', '2024-04-28 16:07:59'),
(2, 'CATALOGO #2', '2024-04-28 16:09:39', '2024-04-28 16:09:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_detalles`
--

CREATE TABLE `catalogo_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `catalogo_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `catalogo_detalles`
--

INSERT INTO `catalogo_detalles` (`id`, `catalogo_id`, `producto_id`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '2024-04-28 16:07:59', '2024-04-28 16:07:59'),
(2, 1, 7, '2024-04-28 16:07:59', '2024-04-28 16:07:59'),
(3, 2, 1, '2024-04-28 16:09:39', '2024-04-28 16:09:39'),
(4, 2, 2, '2024-04-28 16:09:39', '2024-04-28 16:09:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'CATEGORÍA 1', NULL, NULL),
(3, 'CATEGORIA 2', '2023-05-19 23:49:01', '2023-05-19 23:49:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `apellidos`, `ci`, `ci_exp`, `nit`, `fono`, `correo`, `dir`, `user_id`, `tipo`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'PEDRO MARTINEZ', NULL, '231231', 'LP', '', '', 'pedro@gmail.com', 'LOS OLIVOS', 3, 'FISICO', '2023-04-26', '2023-04-26 20:00:10', '2024-04-29 16:17:22'),
(2, 'MARIA GONZALES CASAS', NULL, '1231231', 'CB', '34324111', '666666; 7777777', 'maria@gmail.com', 'LOS OLIVOS', 7, 'FISICO', '2023-04-26', '2023-04-26 20:05:20', '2024-04-29 16:17:16'),
(6, 'PABLO SANCHEZ', NULL, '3223423', 'LP', '', '77575383', 'pablo@gmail.com', '', 9, 'FISICO', '2024-04-25', '2024-04-25 16:20:39', '2024-04-29 16:17:12'),
(7, 'MARCOS MAMANI', NULL, '434334', 'LP', '8888888888', '73594451', 'victorgonzalo.as@gmail.com', 'LOS OLIVOS', 10, 'ECOMMERCE', '2024-04-26', '2024-04-26 16:17:30', '2024-04-26 16:17:30'),
(8, 'SARA GONZALES', NULL, '32233', 'LP', '2323232', '', 'sara@gmail.com', 'LOS OLIVOS', 11, 'ECOMMERCE', '2024-04-30', '2024-04-30 16:38:31', '2024-04-30 16:38:31'),
(9, 'MARTIN', 'COLQUE MAMANI', '543543543', 'CB', '533234234234', '', 'martin@gmail.com', 'LOS OLIVOS', 12, 'FISICO', '2024-05-06', '2024-05-06 17:44:07', '2024-05-06 17:44:07'),
(10, 'MARISOL', 'GONZALES', '43343434', 'SC', '', '', 'marisol@gmail.com', '', 13, 'FISICO', '2024-05-06', '2024-05-06 17:44:47', '2024-05-06 17:44:47'),
(11, 'MARITZA', 'TAPIA', '4334343', 'SC', '', '', 'a', 'A', 14, 'FISICO', '2024-05-06', '2024-05-06 17:49:50', '2024-05-06 17:49:50'),
(12, 'ALVARO', 'CARDENAS', '343434', 'SC', '', '', 'alvaro@gmail.com', 'LOS OLIVOS', 15, 'FISICO', '2024-05-06', '2024-05-06 17:57:03', '2024-05-06 20:13:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `web` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `servicios` text COLLATE utf8mb4_unicode_ci,
  `servicios_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mision` text COLLATE utf8mb4_unicode_ci,
  `mision_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vision` text COLLATE utf8mb4_unicode_ci,
  `vision_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nosotros` text COLLATE utf8mb4_unicode_ci,
  `nosotros_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ubicacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `captcha_local` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `captcha_servidor` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `ciudad`, `dir`, `fono`, `web`, `actividad`, `correo`, `logo`, `servicios`, `servicios_img`, `mision`, `mision_img`, `vision`, `vision_img`, `nosotros`, `nosotros_img`, `facebook`, `instagram`, `twitter`, `youtube`, `ubicacion`, `captcha_local`, `captcha_servidor`, `created_at`, `updated_at`) VALUES
(1, 'SISTEMA DE INVENTARIO Y VENTAS', 'SISCRM', 'EMPRESA PRUEBA S.A.', '10000000000', 'LA PAZ', 'LA PAZ', '222222', '', 'ACTIVIDAD', 'SISCRM@GMAIL.COM', '1682712649_logo.jpg', 'SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT', '1714488423_servicios_img.jpg', 'MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT', '1714488027_mision_img.jpg', 'VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT', '1714488027_vision_img.jpg', 'NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT', '1714488027_nosotros_img.jpg', 'https://facebook.com', 'https://instagram.com', 'https://twitter.com', 'https://youtube.com', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', '6LfkRtMpAAAAABQY3vuOlTcnEV1J_4Siv4BFeIvw', '6LfkRtMpAAAAAHCjmLqiuAbZYSknU7wMaPoMuPj9', NULL, '2024-05-06 19:35:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_pagos`
--

CREATE TABLE `configuracion_pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `banco` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro_cuenta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion_pagos`
--

INSERT INTO `configuracion_pagos` (`id`, `banco`, `nro_cuenta`, `qr`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'BANCO UNION', '10000000222222', '1714484423_1.png', '2024-04-26', '2024-04-26 19:11:50', '2024-04-30 13:40:23'),
(2, 'BANCO #2', '22222222222', '1714158736_2.png', '2024-04-26', '2024-04-26 19:12:12', '2024-04-26 19:12:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cupons`
--

CREATE TABLE `cupons` (
  `id` bigint UNSIGNED NOT NULL,
  `texto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descuento` double(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cupons`
--

INSERT INTO `cupons` (`id`, `texto`, `descuento`, `created_at`, `updated_at`) VALUES
(1, 'C001', 5.00, '2024-04-30 16:13:32', '2024-05-06 20:34:53'),
(2, 'C002', 1.00, '2024-05-06 20:35:08', '2024-05-06 20:35:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` double NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `subtotal` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id`, `venta_id`, `producto_id`, `cantidad`, `precio`, `subtotal`, `created_at`, `updated_at`) VALUES
(5, 3, 1, 10, 20.00, 200.00, '2023-04-26 20:47:35', '2023-04-26 20:47:35'),
(6, 5, 1, 1, 20.00, 20.00, '2023-04-27 18:59:27', '2023-04-27 18:59:27'),
(8, 6, 1, 3, 20.00, 60.00, '2023-04-27 19:00:50', '2023-04-27 19:00:50'),
(9, 7, 7, 4, 12.00, 48.00, '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(10, 7, 2, 1, 35.00, 35.00, '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(11, 8, 3, 1, 100.00, 100.00, '2023-04-28 21:11:48', '2023-04-28 21:11:48'),
(23, 15, 7, 1, 12.00, 12.00, '2024-04-27 19:40:42', '2024-04-27 19:40:42'),
(24, 15, 3, 2, 100.00, 200.00, '2024-04-27 19:40:42', '2024-04-27 19:40:42'),
(25, 16, 7, 1, 12.00, 12.00, '2024-04-30 16:41:36', '2024-04-30 16:41:36'),
(26, 16, 3, 1, 100.00, 100.00, '2024-04-30 16:41:36', '2024-04-30 16:41:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envio_correos`
--

CREATE TABLE `envio_correos` (
  `id` bigint UNSIGNED NOT NULL,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `puerto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encriptado` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `envio_correos`
--

INSERT INTO `envio_correos` (`id`, `host`, `puerto`, `encriptado`, `email`, `nombre`, `password`, `driver`, `created_at`, `updated_at`) VALUES
(1, 'smtp.hostinger.com', '587', 'tls', 'web@emsytsrl.com', 'SISCRM', '10-Co20re30oS', 'smtp', '2024-04-27 16:28:23', '2024-04-27 16:28:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envio_whatsapps`
--

CREATE TABLE `envio_whatsapps` (
  `id` bigint UNSIGNED NOT NULL,
  `sid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `envio_whatsapps`
--

INSERT INTO `envio_whatsapps` (`id`, `sid`, `token`, `from`, `url_phone`, `created_at`, `updated_at`) VALUES
(1, 'cc391a2f', 'X3YWsIkHDjFs4gxR', '14157386102', 'Join ion ooze', NULL, '2024-05-03 20:18:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fecha_stocks`
--

CREATE TABLE `fecha_stocks` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `stock` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `fecha_stocks`
--

INSERT INTO `fecha_stocks` (`id`, `producto_id`, `fecha`, `stock`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-04-27', 93, '2023-04-27 18:59:01', '2023-04-27 19:00:50'),
(2, 7, '2023-04-28', 86, '2023-04-28 15:42:04', '2023-04-28 19:53:34'),
(3, 2, '2023-04-28', 99, '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(4, 3, '2023-04-28', 69, '2023-04-28 21:11:48', '2023-04-28 21:11:48'),
(6, 1, '2024-04-25', 93, '2024-04-25 15:36:55', '2024-04-25 15:37:03'),
(17, 7, '2024-04-27', 85, '2024-04-27 19:40:42', '2024-04-27 19:40:42'),
(18, 3, '2024-04-27', 67, '2024-04-27 19:40:42', '2024-04-27 19:40:42'),
(19, 7, '2024-04-30', 84, '2024-04-30 16:41:36', '2024-04-30 16:41:36'),
(20, 3, '2024-04-30', 66, '2024-04-30 16:41:36', '2024-04-30 16:41:36'),
(21, 1, '2024-05-06', 93, '2024-05-06 17:58:10', '2024-05-06 19:02:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1<br/>updated_at: 2023-04-17 11:04:22<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-17', '11:04:22', '2023-04-17 15:04:22', '2023-04-17 15:04:22'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1<br/>updated_at: 2023-04-17 11:04:22<br/>', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1ASD<br/>updated_at: 2023-04-17 11:04:25<br/>', 'TIPO DE INGRESOS', '2023-04-17', '11:04:25', '2023-04-17 15:04:25', '2023-04-17 15:04:25'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1ASD<br/>updated_at: 2023-04-17 11:04:25<br/>', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1<br/>updated_at: 2023-04-17 11:04:30<br/>', 'TIPO DE INGRESOS', '2023-04-17', '11:04:30', '2023-04-17 15:04:30', '2023-04-17 15:04:30'),
(4, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: VENDEDOR<br/>foto: default.png<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>acceso: 1<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 16:23:30<br/>updated_at: 2023-04-24 16:23:30<br/>', NULL, 'USUARIOS', '2023-04-24', '16:23:31', '2023-04-24 20:23:31', '2023-04-24 20:23:31'),
(5, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PROVEEDOR', 'id: 1<br/>razon_social: PEPE S.A.<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:13<br/>', NULL, 'PROVEEDORES', '2023-04-24', '17:09:13', '2023-04-24 21:09:13', '2023-04-24 21:09:13'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'id: 1<br/>razon_social: PEPE S.A.<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:13<br/>', 'id: 1<br/>razon_social: PEPE S.A.S<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:17<br/>', 'PROVEEDORES', '2023-04-24', '17:09:17', '2023-04-24 21:09:17', '2023-04-24 21:09:17'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'id: 1<br/>razon_social: PEPE S.A.S<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:17<br/>', 'id: 1<br/>razon_social: PEPE S.A.<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:20<br/>', 'PROVEEDORES', '2023-04-24', '17:09:20', '2023-04-24 21:09:20', '2023-04-24 21:09:20'),
(8, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 1<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>nombre: PASTILLAS A<br/>descripcion: <br/>precio: 20<br/>stock_min: 10<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:36:20<br/>updated_at: 2023-04-24 17:36:20<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:36:20', '2023-04-24 21:36:20', '2023-04-24 21:36:20'),
(9, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 2<br/>codigo_almacen: A001<br/>codigo_producto: P002<br/>nombre: GEL ANTIBACTERIAL<br/>descripcion: <br/>precio: 35<br/>stock_min: 5<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:44:24<br/>updated_at: 2023-04-24 17:44:24<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:44:24', '2023-04-24 21:44:24', '2023-04-24 21:44:24'),
(10, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 3<br/>codigo_almacen: A001<br/>codigo_producto: P003<br/>nombre: PRODUCTO 3<br/>descripcion: <br/>precio: 100<br/>stock_min: 10<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:45:17<br/>updated_at: 2023-04-24 17:45:17<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:45:17', '2023-04-24 21:45:17', '2023-04-24 21:45:17'),
(11, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 4<br/>codigo_almacen: ASD<br/>codigo_producto: ADS<br/>nombre: ASD<br/>descripcion: <br/>precio: 12<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372735_4.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:45:35<br/>updated_at: 2023-04-24 17:45:35<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:45:35', '2023-04-24 21:45:35', '2023-04-24 21:45:35'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 5<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASDAS<br/>descripcion: <br/>precio: 12<br/>stock_min: 2<br/>stock_actual: 0<br/>imagen: 1682372808_5.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:46:48<br/>updated_at: 2023-04-24 17:46:48<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:46:48', '2023-04-24 21:46:48', '2023-04-24 21:46:48'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 6<br/>codigo_almacen: AS<br/>codigo_producto: DASD<br/>nombre: ASD<br/>descripcion: AS<br/>precio: 12<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372843_6.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:23<br/>updated_at: 2023-04-24 17:47:23<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:47:23', '2023-04-24 21:47:23', '2023-04-24 21:47:23'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 6<br/>codigo_almacen: AS<br/>codigo_producto: DASD<br/>nombre: ASD<br/>descripcion: AS<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372843_6.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:23<br/>updated_at: 2023-04-24 17:47:23<br/>', 'id: 6<br/>codigo_almacen: AS<br/>codigo_producto: DASD<br/>nombre: ASD<br/>descripcion: AS<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372848_6.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:23<br/>updated_at: 2023-04-24 17:47:28<br/>', 'PRODUCTOS', '2023-04-24', '17:47:28', '2023-04-24 21:47:28', '2023-04-24 21:47:28'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372874_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:54<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:47:54', '2023-04-24 21:47:54', '2023-04-24 21:47:54'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372874_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:54<br/>', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372879_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:59<br/>', 'PRODUCTOS', '2023-04-24', '17:47:59', '2023-04-24 21:47:59', '2023-04-24 21:47:59'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:37:56<br/>descripcion: <br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:37:56<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-25', '10:37:57', '2023-04-25 14:37:57', '2023-04-25 14:37:57'),
(18, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:37:56<br/>descripcion: <br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:37:56<br/>', 'created_at: 2023-04-25 10:37:56<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:38:00<br/>', 'TIPO DE INGRESOS', '2023-04-25', '10:38:00', '2023-04-25 14:38:00', '2023-04-25 14:38:00'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:37:56<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:38:00<br/>', 'created_at: 2023-04-25 10:37:56<br/>descripcion: <br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:38:04<br/>', 'TIPO DE INGRESOS', '2023-04-25', '10:38:04', '2023-04-25 14:38:04', '2023-04-25 14:38:04'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:38:08<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:08<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-25', '10:38:08', '2023-04-25 14:38:08', '2023-04-25 14:38:08'),
(21, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:38:08<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:08<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-25', '10:38:10', '2023-04-25 14:38:10', '2023-04-25 14:38:10'),
(22, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:16<br/>descripcion: <br/>id: 1<br/>nombre: SALIDA 1<br/>updated_at: 2023-04-25 10:38:16<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:16', '2023-04-25 14:38:16', '2023-04-25 14:38:16'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:21<br/>descripcion: <br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:21<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:21', '2023-04-25 14:38:21', '2023-04-25 14:38:21'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:21<br/>descripcion: <br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:21<br/>', 'created_at: 2023-04-25 10:38:21<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:23<br/>', 'TIPO DE SALIDAS', '2023-04-25', '10:38:23', '2023-04-25 14:38:23', '2023-04-25 14:38:23'),
(25, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:27<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:27<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:27', '2023-04-25 14:38:27', '2023-04-25 14:38:27'),
(26, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:27<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:27<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:31', '2023-04-25 14:38:31', '2023-04-25 14:38:31'),
(27, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:21<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:23<br/>', 'created_at: 2023-04-25 10:38:21<br/>descripcion: <br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:35<br/>', 'TIPO DE SALIDAS', '2023-04-25', '10:38:35', '2023-04-25 14:38:35', '2023-04-25 14:38:35'),
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 100<br/>created_at: 2023-04-25 11:23:41<br/>descripcion: <br/>fecha_caducidad: 2025-02-02<br/>fecha_fabricacion: 2023-02-02<br/>fecha_registro: 2023-04-25<br/>id: 1<br/>lote: 1<br/>precio_compra: 20<br/>producto_id: 1<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:23:41<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-25', '11:23:41', '2023-04-25 15:23:41', '2023-04-25 15:23:41'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 100<br/>created_at: 2023-04-25 11:25:58<br/>descripcion: <br/>fecha_caducidad: 2024-04-25<br/>fecha_fabricacion: 2023-04-25<br/>fecha_registro: 2023-04-25<br/>id: 2<br/>lote: 2<br/>precio_compra: 30<br/>producto_id: 2<br/>proveedor_id: 1<br/>tipo_ingreso_id: 2<br/>updated_at: 2023-04-25 11:25:58<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-25', '11:25:58', '2023-04-25 15:25:58', '2023-04-25 15:25:58'),
(30, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 50<br/>created_at: 2023-04-25 11:28:29<br/>descripcion: <br/>fecha_caducidad: 2026-03-03<br/>fecha_fabricacion: 2023-03-03<br/>fecha_registro: 2023-04-25<br/>id: 3<br/>lote: 3<br/>precio_compra: 100<br/>producto_id: 3<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:28:29<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-25', '11:28:30', '2023-04-25 15:28:30', '2023-04-25 15:28:30'),
(31, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN INGRESO DE PRODUCTO', 'cantidad: 50<br/>created_at: 2023-04-25 11:28:29<br/>descripcion: <br/>fecha_caducidad: 2026-03-03<br/>fecha_fabricacion: 2023-03-03<br/>fecha_registro: 2023-04-25<br/>id: 3<br/>lote: 3<br/>precio_compra: 100.00<br/>producto_id: 3<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:28:29<br/>', 'cantidad: 70<br/>created_at: 2023-04-25 11:28:29<br/>descripcion: <br/>fecha_caducidad: 2026-03-03<br/>fecha_fabricacion: 2023-03-03<br/>fecha_registro: 2023-04-25<br/>id: 3<br/>lote: 3<br/>precio_compra: 100.00<br/>producto_id: 3<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:31:20<br/>', 'INGRESO DE PRODUCTOS', '2023-04-25', '11:31:20', '2023-04-25 15:31:20', '2023-04-25 15:31:20'),
(32, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:36<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:43:36', '2023-04-25 19:43:36', '2023-04-25 19:43:36'),
(33, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:36<br/>', 'cantidad: 5<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:51<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:43:51', '2023-04-25 19:43:51', '2023-04-25 19:43:51'),
(34, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 5<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:51<br/>', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:45:43<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:45:43', '2023-04-25 19:45:43', '2023-04-25 19:45:43'),
(35, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:46:09<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 2<br/>producto_id: 1<br/>tipo_salida_id: 2<br/>updated_at: 2023-04-25 15:46:09<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:09', '2023-04-25 19:46:09', '2023-04-25 19:46:09'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:45:43<br/>', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:12<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:12', '2023-04-25 19:46:12', '2023-04-25 19:46:12'),
(37, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:12<br/>', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:26<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:26', '2023-04-25 19:46:26', '2023-04-25 19:46:26'),
(38, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:46:09<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 2<br/>producto_id: 1<br/>tipo_salida_id: 2<br/>updated_at: 2023-04-25 15:46:09<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:51', '2023-04-25 19:46:51', '2023-04-25 19:46:51'),
(39, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:47:12<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 3<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:47:12<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:47:12', '2023-04-25 19:47:12', '2023-04-25 19:47:12'),
(40, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:26<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:47:17', '2023-04-25 19:47:17', '2023-04-25 19:47:17'),
(41, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'ci: 231231<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-26 16:00:10<br/>dir: <br/>fecha_registro: 2023-04-26<br/>fono: <br/>id: 1<br/>nit: <br/>nombre: PEDRO MARTINEZ<br/>updated_at: 2023-04-26 16:00:10<br/>', NULL, 'CLIENTES', '2023-04-26', '16:00:10', '2023-04-26 20:00:10', '2023-04-26 20:00:10'),
(42, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777; 22222<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:20<br/>', NULL, 'CLIENTES', '2023-04-26', '16:05:20', '2023-04-26 20:05:20', '2023-04-26 20:05:20'),
(43, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777; 22222<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:20<br/>', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:32<br/>', 'CLIENTES', '2023-04-26', '16:05:32', '2023-04-26 20:05:32', '2023-04-26 20:05:32'),
(44, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:32<br/>', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:38<br/>', 'CLIENTES', '2023-04-26', '16:05:38', '2023-04-26 20:05:38', '2023-04-26 20:05:38'),
(45, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:38<br/>', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:42<br/>', 'CLIENTES', '2023-04-26', '16:05:42', '2023-04-26 20:05:42', '2023-04-26 20:05:42'),
(46, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:42<br/>', 'ci: 1231231<br/>ci_exp: CB<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:45<br/>', 'CLIENTES', '2023-04-26', '16:05:45', '2023-04-26 20:05:45', '2023-04-26 20:05:45'),
(47, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: CB<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:45<br/>', 'ci: 1231231<br/>ci_exp: CB<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES CASAS<br/>updated_at: 2023-04-26 16:05:50<br/>', 'CLIENTES', '2023-04-26', '16:05:50', '2023-04-26 20:05:50', '2023-04-26 20:05:50'),
(48, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'ci: 43434<br/>ci_exp: CB<br/>correo: <br/>created_at: 2023-04-26 16:07:17<br/>dir: <br/>fecha_registro: 2023-04-26<br/>fono: <br/>id: 3<br/>nit: 111111<br/>nombre: PABLO SANCHEZ<br/>updated_at: 2023-04-26 16:07:17<br/>', NULL, 'CLIENTES', '2023-04-26', '16:07:17', '2023-04-26 20:07:17', '2023-04-26 20:07:17'),
(49, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', '', NULL, 'ORDEN DE VENTA', '2023-04-26', '16:29:21', '2023-04-26 20:29:21', '2023-04-26 20:29:21'),
(50, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:37:59<br/>user_id: 1<br/>', NULL, 'ORDEN DE VENTA', '2023-04-26', '16:37:59', '2023-04-26 20:37:59', '2023-04-26 20:37:59'),
(51, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:37:59<br/>user_id: 1<br/>', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 330.00<br/>total_final: 297.00<br/>updated_at: 2023-04-26 16:43:06<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:43:06', '2023-04-26 20:43:06', '2023-04-26 20:43:06'),
(52, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 330.00<br/>total_final: 297.00<br/>updated_at: 2023-04-26 16:43:06<br/>user_id: 1<br/>', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:43:28<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:43:28', '2023-04-26 20:43:28', '2023-04-26 20:43:28'),
(53, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:43:28<br/>user_id: 1<br/>', NULL, 'ORDEN DE VENTA', '2023-04-26', '16:45:18', '2023-04-26 20:45:18', '2023-04-26 20:45:18'),
(54, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:47:12<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 3<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:47:12<br/>', 'cantidad: 3<br/>created_at: 2023-04-25 15:47:12<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 3<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-26 16:46:46<br/>', 'SALIDA DE PRODUCTOS', '2023-04-26', '16:46:46', '2023-04-26 20:46:46', '2023-04-26 20:46:46'),
(55, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 80.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:29:21<br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 0.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:13<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:47:13', '2023-04-26 20:47:13', '2023-04-26 20:47:13'),
(56, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 0.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:13<br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 200.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:35<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:47:35', '2023-04-26 20:47:35', '2023-04-26 20:47:35'),
(57, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'id: 4<br/>producto_id: 1<br/>proveedor_id: 1<br/>precio_compra: 20<br/>cantidad: 10<br/>lote: 10<br/>fecha_fabricacion: 2023-04-27<br/>fecha_caducidad: 2025-04-27<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 14:59:01<br/>updated_at: 2023-04-27 14:59:01<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-27', '14:59:01', '2023-04-27 18:59:01', '2023-04-27 18:59:01'),
(58, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>nit: 231231<br/>total: 20.00<br/>descuento: 0<br/>total_final: 20.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 14:59:27<br/>updated_at: 2023-04-27 14:59:27<br/>', NULL, 'ORDEN DE VENTA', '2023-04-27', '14:59:27', '2023-04-27 18:59:27', '2023-04-27 18:59:27'),
(59, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'id: 6<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 43434<br/>total: 120.00<br/>descuento: 0<br/>total_final: 120.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 15:00:19<br/>updated_at: 2023-04-27 15:00:19<br/>', NULL, 'ORDEN DE VENTA', '2023-04-27', '15:00:19', '2023-04-27 19:00:19', '2023-04-27 19:00:19'),
(60, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'id: 6<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 43434<br/>total: 120.00<br/>descuento: 0<br/>total_final: 120.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 15:00:19<br/>updated_at: 2023-04-27 15:00:19<br/>', 'id: 6<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 43434<br/>total: 60.00<br/>descuento: 0<br/>total_final: 120.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 15:00:19<br/>updated_at: 2023-04-27 15:00:50<br/>', 'ORDEN DE VENTA', '2023-04-27', '15:00:50', '2023-04-27 19:00:50', '2023-04-27 19:00:50'),
(61, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PROVEEDOR', 'id: 2<br/>razon_social: PROVEEDOR SRL<br/>nit: 34343<br/>dir: <br/>fono: 2222<br/>nombre_contacto: <br/>descripcion: <br/>fecha_registro: 2023-04-28<br/>created_at: 2023-04-28 11:22:08<br/>updated_at: 2023-04-28 11:22:08<br/>', NULL, 'PROVEEDORES', '2023-04-28', '11:22:08', '2023-04-28 15:22:08', '2023-04-28 15:22:08'),
(62, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372879_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:59<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'PRODUCTOS', '2023-04-28', '11:40:58', '2023-04-28 15:40:58', '2023-04-28 15:40:58'),
(63, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'PRODUCTOS', '2023-04-28', '11:41:05', '2023-04-28 15:41:05', '2023-04-28 15:41:05'),
(64, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696491_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:31<br/>', 'PRODUCTOS', '2023-04-28', '11:41:31', '2023-04-28 15:41:31', '2023-04-28 15:41:31'),
(65, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696491_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:31<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696493_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:33<br/>', 'PRODUCTOS', '2023-04-28', '11:41:33', '2023-04-28 15:41:33', '2023-04-28 15:41:33'),
(66, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696493_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:33<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696496_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:36<br/>', 'PRODUCTOS', '2023-04-28', '11:41:36', '2023-04-28 15:41:36', '2023-04-28 15:41:36'),
(67, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'id: 5<br/>producto_id: 7<br/>proveedor_id: 2<br/>precio_compra: 11<br/>cantidad: 90<br/>lote: 322323<br/>fecha_fabricacion: 2023-01-01<br/>fecha_caducidad: 2025-01-01<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-28<br/>created_at: 2023-04-28 11:42:04<br/>updated_at: 2023-04-28 11:42:04<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-28', '11:42:04', '2023-04-28 15:42:04', '2023-04-28 15:42:04'),
(68, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-28 15:53:34<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-28<br/>id: 7<br/>nit: 1231231<br/>total: 83.00<br/>total_final: 83.00<br/>updated_at: 2023-04-28 15:53:34<br/>user_id: 1<br/>', NULL, 'ORDEN DE VENTA', '2023-04-28', '15:53:34', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(69, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1681583846_logo.webp<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA NUEVAERA<br/>updated_at: 2023-04-15 14:39:44<br/>web: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1681583846_logo.webp<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA FARMACIA<br/>updated_at: 2023-04-28 16:08:46<br/>web: <br/>', 'CONFIGURACIÓN', '2023-04-28', '16:08:46', '2023-04-28 20:08:46', '2023-04-28 20:08:46'),
(70, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1681583846_logo.webp<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA FARMACIA<br/>updated_at: 2023-04-28 16:08:46<br/>web: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1682712649_logo.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA FARMACIA<br/>updated_at: 2023-04-28 16:10:49<br/>web: <br/>', 'CONFIGURACIÓN', '2023-04-28', '16:10:49', '2023-04-28 20:10:49', '2023-04-28 20:10:49'),
(71, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: VENDEDOR<br/>updated_at: 2023-04-24 16:23:30<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: GERENCIA<br/>updated_at: 2023-04-28 17:05:08<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:05:08', '2023-04-28 21:05:08', '2023-04-28 21:05:08'),
(72, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: GERENCIA<br/>updated_at: 2023-04-28 17:05:08<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: SUPERVISOR<br/>updated_at: 2023-04-28 17:06:13<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:06:13', '2023-04-28 21:06:13', '2023-04-28 21:06:13'),
(73, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PROVEEDOR', 'created_at: 2023-04-28 17:07:52<br/>descripcion: <br/>dir: ASD<br/>fecha_registro: 2023-04-28<br/>fono: ASD<br/>id: 3<br/>nit: ASD<br/>nombre_contacto: <br/>razon_social: ASD<br/>updated_at: 2023-04-28 17:07:52<br/>', NULL, 'PROVEEDORES', '2023-04-28', '17:07:52', '2023-04-28 21:07:52', '2023-04-28 21:07:52'),
(74, 2, 'ELIMINACIÓN', 'EL USUARIO JPERES ELIMINÓ UN PROVEEDOR', 'created_at: 2023-04-28 17:07:52<br/>descripcion: <br/>dir: ASD<br/>fecha_registro: 2023-04-28<br/>fono: ASD<br/>id: 3<br/>nit: ASD<br/>nombre_contacto: <br/>razon_social: ASD<br/>updated_at: 2023-04-28 17:07:52<br/>', NULL, 'PROVEEDORES', '2023-04-28', '17:07:54', '2023-04-28 21:07:54', '2023-04-28 21:07:54'),
(75, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: SUPERVISOR<br/>updated_at: 2023-04-28 17:06:13<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: VENDEDOR<br/>updated_at: 2023-04-28 17:11:20<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:11:20', '2023-04-28 21:11:20', '2023-04-28 21:11:20'),
(76, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-28 17:11:48<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-28<br/>id: 8<br/>nit: 1231231<br/>total: 100.00<br/>total_final: 100.00<br/>updated_at: 2023-04-28 17:11:48<br/>user_id: 2<br/>', NULL, 'ORDEN DE VENTA', '2023-04-28', '17:11:48', '2023-04-28 21:11:48', '2023-04-28 21:11:48'),
(77, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: VENDEDOR<br/>updated_at: 2023-04-28 17:11:20<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: SUPERVISOR<br/>updated_at: 2023-04-28 17:12:44<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:12:44', '2023-04-28 21:12:44', '2023-04-28 21:12:44'),
(78, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'codigo_almacen: A002<br/>codigo_producto: P00SIN<br/>created_at: 2023-05-19 19:26:32<br/>descripcion: DEC<br/>fecha_registro: 2023-05-19<br/>id: 8<br/>imagen: <br/>nombre: SIN DEPENDENCIA<br/>precio: 100<br/>stock_actual: 0<br/>stock_min: 50<br/>updated_at: 2023-05-19 19:26:32<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:26:33', '2023-05-19 23:26:33', '2023-05-19 23:26:33'),
(79, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINO UN PRODUCTO', 'codigo_almacen: A002<br/>codigo_producto: P00SIN<br/>created_at: 2023-05-19 19:26:32<br/>descripcion: DEC<br/>fecha_registro: 2023-05-19<br/>id: 8<br/>imagen: <br/>nombre: SIN DEPENDENCIA<br/>precio: 100.00<br/>stock_actual: 0<br/>stock_min: 50<br/>updated_at: 2023-05-19 19:26:32<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:29:41', '2023-05-19 23:29:41', '2023-05-19 23:29:41'),
(80, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'codigo_almacen: ASDA<br/>codigo_producto: ASDASD<br/>created_at: 2023-05-19 19:31:12<br/>descripcion: ASD<br/>fecha_registro: 2023-05-19<br/>id: 9<br/>imagen: <br/>nombre: ASDASD<br/>precio: 100<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:31:12<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:31:12', '2023-05-19 23:31:12', '2023-05-19 23:31:12'),
(81, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 900<br/>created_at: 2023-05-19 19:31:58<br/>descripcion: <br/>fecha_caducidad: 2025-02-22<br/>fecha_fabricacion: 2023-05-19<br/>fecha_registro: 2023-05-19<br/>id: 6<br/>lote: 9090<br/>precio_compra: 100<br/>producto_id: 9<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-05-19 19:31:58<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-05-19', '19:31:58', '2023-05-19 23:31:58', '2023-05-19 23:31:58'),
(82, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINO UN PRODUCTO', 'codigo_almacen: ASDA<br/>codigo_producto: ASDASD<br/>created_at: 2023-05-19 19:31:12<br/>descripcion: ASD<br/>fecha_registro: 2023-05-19<br/>id: 9<br/>imagen: <br/>nombre: ASDASD<br/>precio: 100.00<br/>stock_actual: 900<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:31:58<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:32:12', '2023-05-19 23:32:12', '2023-05-19 23:32:12'),
(83, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2<br/>updated_at: 2023-05-19 19:47:02<br/>', NULL, 'TIPO DE INGRESOS', '2023-05-19', '19:47:02', '2023-05-19 23:47:02', '2023-05-19 23:47:02'),
(84, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2<br/>updated_at: 2023-05-19 19:47:02<br/>', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2ASDSA<br/>updated_at: 2023-05-19 19:47:11<br/>', 'TIPO DE INGRESOS', '2023-05-19', '19:47:11', '2023-05-19 23:47:11', '2023-05-19 23:47:11'),
(85, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2ASDSA<br/>updated_at: 2023-05-19 19:47:11<br/>', NULL, 'TIPO DE INGRESOS', '2023-05-19', '19:47:21', '2023-05-19 23:47:21', '2023-05-19 23:47:21'),
(86, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:49:01<br/>id: 3<br/>nombre: CATEGORIA 2<br/>updated_at: 2023-05-19 19:49:01<br/>', NULL, 'TIPO DE INGRESOS', '2023-05-19', '19:49:01', '2023-05-19 23:49:01', '2023-05-19 23:49:01'),
(87, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', 'categoria_id: 1<br/>codigo_almacen: A002222<br/>codigo_producto: P0044<br/>created_at: 2023-05-19 19:55:04<br/>descripcion: DESC<br/>fecha_registro: 2023-05-19<br/>id: 10<br/>imagen: <br/>nombre: PRODUCTO NUEVO P0044<br/>precio: 99<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:04<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:55:04', '2023-05-19 23:55:04', '2023-05-19 23:55:04'),
(88, 2, 'MODIFICACIÓN', 'EL USUARIO JPERES MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_almacen: A002222<br/>codigo_producto: P0044<br/>created_at: 2023-05-19 19:55:04<br/>descripcion: DESC<br/>fecha_registro: 2023-05-19<br/>id: 10<br/>imagen: <br/>nombre: PRODUCTO NUEVO P0044<br/>precio: 99.00<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:04<br/>', 'categoria_id: 3<br/>codigo_almacen: A002222<br/>codigo_producto: P0044<br/>created_at: 2023-05-19 19:55:04<br/>descripcion: DESC<br/>fecha_registro: 2023-05-19<br/>id: 10<br/>imagen: <br/>nombre: PRODUCTO NUEVO P0044<br/>precio: 99.00<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:13<br/>', 'PRODUCTOS', '2023-05-19', '19:55:13', '2023-05-19 23:55:13', '2023-05-19 23:55:13'),
(89, 2, 'MODIFICACIÓN', 'EL USUARIO JPERES MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>created_at: 2023-04-24 17:36:20<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 1<br/>imagen: <br/>nombre: PASTILLAS A<br/>precio: 20.00<br/>stock_actual: 93<br/>stock_min: 10<br/>updated_at: 2023-04-27 15:00:50<br/>', 'categoria_id: 3<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>created_at: 2023-04-24 17:36:20<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 1<br/>imagen: <br/>nombre: PASTILLAS A<br/>precio: 20.00<br/>stock_actual: 93<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:53<br/>', 'PRODUCTOS', '2023-05-19', '19:55:53', '2023-05-19 23:55:53', '2023-05-19 23:55:53'),
(90, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN INGRESO DE PRODUCTO', 'id: 1<br/>producto_id: 1<br/>proveedor_id: 1<br/>precio_compra: 20.00<br/>cantidad: 100<br/>lote: 1<br/>fecha_fabricacion: 2023-02-02<br/>fecha_compra: 2025-02-02<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>created_at: 2023-04-25 11:23:41<br/>updated_at: 2023-04-25 11:23:41<br/>', 'id: 1<br/>producto_id: 1<br/>proveedor_id: 1<br/>precio_compra: 20.00<br/>cantidad: 100<br/>lote: 1<br/>fecha_fabricacion: 2023-02-02<br/>fecha_compra: 2025-02-02<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>created_at: 2023-04-25 11:23:41<br/>updated_at: 2023-04-25 11:23:41<br/>', 'INGRESO DE PRODUCTOS', '2024-04-25', '11:36:55', '2024-04-25 15:36:55', '2024-04-25 15:36:55'),
(91, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN INGRESO DE PRODUCTO', 'id: 1<br/>producto_id: 1<br/>proveedor_id: 1<br/>precio_compra: 20.00<br/>cantidad: 100<br/>lote: 1<br/>fecha_fabricacion: 2023-02-02<br/>fecha_compra: 2025-02-02<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>created_at: 2023-04-25 11:23:41<br/>updated_at: 2023-04-25 11:23:41<br/>', 'id: 1<br/>producto_id: 1<br/>proveedor_id: 1<br/>precio_compra: 20.00<br/>cantidad: 100<br/>lote: 1<br/>fecha_fabricacion: 2023-02-02<br/>fecha_compra: 2024-02-02<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>created_at: 2023-04-25 11:23:41<br/>updated_at: 2024-04-25 11:37:03<br/>', 'INGRESO DE PRODUCTOS', '2024-04-25', '11:37:03', '2024-04-25 15:37:03', '2024-04-25 15:37:03'),
(92, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: <br/>dir: <br/>user_id: <br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2023-04-26 16:00:10<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: <br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'CLIENTES', '2024-04-25', '12:12:18', '2024-04-25 16:12:18', '2024-04-25 16:12:18'),
(93, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'CLIENTES', '2024-04-25', '12:17:41', '2024-04-25 16:17:41', '2024-04-25 16:17:41'),
(94, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'CLIENTES', '2024-04-25', '12:17:45', '2024-04-25 16:17:45', '2024-04-25 16:17:45');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(95, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'CLIENTES', '2024-04-25', '12:17:54', '2024-04-25 16:17:54', '2024-04-25 16:17:54'),
(96, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:12:18<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:18:49<br/>', 'CLIENTES', '2024-04-25', '12:18:49', '2024-04-25 16:18:49', '2024-04-25 16:18:49'),
(97, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 2<br/>nombre: MARIA GONZALES CASAS<br/>ci: 1231231<br/>ci_exp: CB<br/>nit: 34324111<br/>fono: 666666; 7777777<br/>correo: MARIA@GMAIL.COM<br/>dir: LOS OLIVOS<br/>user_id: <br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:05:20<br/>updated_at: 2023-04-26 16:05:50<br/>', 'id: 2<br/>nombre: MARIA GONZALES CASAS<br/>ci: 1231231<br/>ci_exp: CB<br/>nit: 34324111<br/>fono: 666666; 7777777<br/>correo: maria@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 7<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:05:20<br/>updated_at: 2024-04-25 12:19:01<br/>', 'CLIENTES', '2024-04-25', '12:19:01', '2024-04-25 16:19:01', '2024-04-25 16:19:01'),
(98, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 3<br/>nombre: PABLO SANCHEZ<br/>ci: 43434<br/>ci_exp: CB<br/>nit: 111111<br/>fono: <br/>correo: <br/>dir: <br/>user_id: <br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:07:17<br/>updated_at: 2023-04-26 16:07:17<br/>', 'id: 3<br/>nombre: PABLO SANCHEZ<br/>ci: 43434<br/>ci_exp: CB<br/>nit: 111111<br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 8<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:07:17<br/>updated_at: 2024-04-25 12:19:14<br/>', 'CLIENTES', '2024-04-25', '12:19:14', '2024-04-25 16:19:14', '2024-04-25 16:19:14'),
(99, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN CLIENTE', 'id: 3<br/>nombre: PABLO SANCHEZ<br/>ci: 43434<br/>ci_exp: CB<br/>nit: 111111<br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 8<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:07:17<br/>updated_at: 2024-04-25 12:19:14<br/>', NULL, 'CLIENTES', '2024-04-25', '12:19:24', '2024-04-25 16:19:24', '2024-04-25 16:19:24'),
(100, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-25 12:20:39<br/>', NULL, 'CLIENTES', '2024-04-25', '12:20:39', '2024-04-25 16:20:39', '2024-04-25 16:20:39'),
(101, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:18:49<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:21:51<br/>', 'CLIENTES', '2024-04-25', '12:21:51', '2024-04-25 16:21:51', '2024-04-25 16:21:51'),
(102, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:21:51<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:22:00<br/>', 'CLIENTES', '2024-04-25', '12:22:00', '2024-04-25 16:22:00', '2024-04-25 16:22:00'),
(103, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:22:00<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:22:17<br/>', 'CLIENTES', '2024-04-25', '12:22:17', '2024-04-25 16:22:17', '2024-04-25 16:22:17'),
(104, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 2<br/>nombre: MARIA GONZALES CASAS<br/>ci: 1231231<br/>ci_exp: CB<br/>nit: 34324111<br/>fono: 666666; 7777777<br/>correo: maria@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 7<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:05:20<br/>updated_at: 2024-04-25 12:19:01<br/>', 'id: 2<br/>nombre: MARIA GONZALES CASAS<br/>ci: 1231231<br/>ci_exp: CB<br/>nit: 34324111<br/>fono: 666666; 7777777<br/>correo: maria@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 7<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:05:20<br/>updated_at: 2024-04-25 12:22:20<br/>', 'CLIENTES', '2024-04-25', '12:22:20', '2024-04-25 16:22:20', '2024-04-25 16:22:20'),
(105, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-25 12:20:39<br/>', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-25 12:22:21<br/>', 'CLIENTES', '2024-04-25', '12:22:21', '2024-04-25 16:22:21', '2024-04-25 16:22:21'),
(106, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-25 12:22:21<br/>', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-25 12:22:23<br/>', 'CLIENTES', '2024-04-25', '12:22:23', '2024-04-25 16:22:23', '2024-04-25 16:22:23'),
(107, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111<br/>qr: 1714158455_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:07:35<br/>', NULL, 'CONFIGURACION DE PAGOS', '2024-04-26', '15:07:35', '2024-04-26 19:07:35', '2024-04-26 19:07:35'),
(108, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111<br/>qr: 1714158455_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:07:35<br/>', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: <br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:09:24<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:09:24', '2024-04-26 19:09:24', '2024-04-26 19:09:24'),
(109, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: <br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:09:24<br/>', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: <br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:09:24<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:10:47', '2024-04-26 19:10:47', '2024-04-26 19:10:47'),
(110, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: <br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:09:24<br/>', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: 1714158657_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:10:57<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:10:57', '2024-04-26 19:10:57', '2024-04-26 19:10:57'),
(111, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: 1714158657_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:10:57<br/>', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: 1714158673_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:11:13<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:11:13', '2024-04-26 19:11:13', '2024-04-26 19:11:13'),
(112, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: 1714158673_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:11:13<br/>', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: 1714158676_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:11:16<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:11:16', '2024-04-26 19:11:16', '2024-04-26 19:11:16'),
(113, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNION<br/>nro_cuenta: 100000001111SS<br/>qr: 1714158676_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:11:16<br/>', 'id: 1<br/>banco: BANCO #UNIONS<br/>nro_cuenta: 100000001111<br/>qr: 1714158681_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:11:21<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:11:21', '2024-04-26 19:11:21', '2024-04-26 19:11:21'),
(114, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO #UNIONS<br/>nro_cuenta: 100000001111<br/>qr: 1714158681_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:07:35<br/>updated_at: 2024-04-26 15:11:21<br/>', NULL, 'CONFIGURACION DE PAGOS', '2024-04-26', '15:11:35', '2024-04-26 19:11:35', '2024-04-26 19:11:35'),
(115, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO UNION<br/>nro_cuenta: 10000000222222<br/>qr: 1714158710_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:11:50<br/>updated_at: 2024-04-26 15:11:50<br/>', NULL, 'CONFIGURACION DE PAGOS', '2024-04-26', '15:11:50', '2024-04-26 19:11:50', '2024-04-26 19:11:50'),
(116, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO UNION<br/>nro_cuenta: 10000000222222<br/>qr: 1714158710_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:11:50<br/>updated_at: 2024-04-26 15:11:50<br/>', 'id: 1<br/>banco: BANCO UNION<br/>nro_cuenta: 10000000222222S<br/>qr: 1714158714_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:11:50<br/>updated_at: 2024-04-26 15:11:54<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:11:54', '2024-04-26 19:11:54', '2024-04-26 19:11:54'),
(117, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 1<br/>banco: BANCO UNION<br/>nro_cuenta: 10000000222222S<br/>qr: 1714158714_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:11:50<br/>updated_at: 2024-04-26 15:11:54<br/>', 'id: 1<br/>banco: BANCO UNION<br/>nro_cuenta: 10000000222222<br/>qr: 1714158718_1.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:11:50<br/>updated_at: 2024-04-26 15:11:58<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:11:58', '2024-04-26 19:11:58', '2024-04-26 19:11:58'),
(118, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA CONFIGURACION DE PAGO', 'id: 2<br/>banco: BANCO #2<br/>nro_cuenta: 22222222222<br/>qr: 1714158732_2.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:12:12<br/>updated_at: 2024-04-26 15:12:12<br/>', NULL, 'CONFIGURACION DE PAGOS', '2024-04-26', '15:12:12', '2024-04-26 19:12:12', '2024-04-26 19:12:12'),
(119, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'id: 2<br/>banco: BANCO #2<br/>nro_cuenta: 22222222222<br/>qr: 1714158732_2.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:12:12<br/>updated_at: 2024-04-26 15:12:12<br/>', 'id: 2<br/>banco: BANCO #2<br/>nro_cuenta: 22222222222<br/>qr: 1714158736_2.png<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:12:12<br/>updated_at: 2024-04-26 15:12:16<br/>', 'CONFIGURACION DE PAGOS', '2024-04-26', '15:12:16', '2024-04-26 19:12:16', '2024-04-26 19:12:16'),
(120, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'id: 1<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>alias: SISTEMABI<br/>razon_social: EMPRESA FARMACIA<br/>nit: 10000000000<br/>ciudad: LA PAZ<br/>dir: LA PAZ<br/>fono: 222222<br/>web: <br/>actividad: ACTIVIDAD<br/>correo: <br/>logo: 1682712649_logo.jpg<br/>created_at: <br/>updated_at: 2023-04-28 16:10:49<br/>', 'id: 1<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>alias: SISCRM<br/>razon_social: EMPRESA PRUEBA S.A.<br/>nit: 10000000000<br/>ciudad: LA PAZ<br/>dir: LA PAZ<br/>fono: 222222<br/>web: <br/>actividad: ACTIVIDAD<br/>correo: <br/>logo: 1682712649_logo.jpg<br/>created_at: <br/>updated_at: 2024-04-26 15:13:00<br/>', 'CONFIGURACIÓN', '2024-04-26', '15:13:00', '2024-04-26 19:13:00', '2024-04-26 19:13:00'),
(123, 10, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ORDEN DE PEDIDO', 'id: 3<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 77777777<br/>comprobante: C:\\USERS\\VICTO\\APPDATA\\LOCAL\\TEMP\\PHPCEB2.TMP<br/>lat: -16.49712657103268<br/>lng: -68.13191764351133<br/>total: 136.00<br/>estado: PENDIENTE<br/>user_id: 10<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 15:55:40<br/>updated_at: 2024-04-26 15:55:40<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-04-26', '15:55:40', '2024-04-26 19:55:40', '2024-04-26 19:55:40'),
(124, 10, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ORDEN DE PEDIDO', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 77575373<br/>comprobante: C:\\USERS\\VICTO\\APPDATA\\LOCAL\\TEMP\\PHP2AAC.TMP<br/>lat: -16.496808823347422<br/>lng: -68.13268932180621<br/>total: 324.00<br/>estado: PEDIDO PENDIENTE<br/>user_id: 10<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 16:39:45<br/>updated_at: 2024-04-26 16:39:45<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-04-26', '16:39:45', '2024-04-26 20:39:45', '2024-04-26 20:39:45'),
(125, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ORDEN DE PEDIDO', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 77575373<br/>comprobante: 1714163985_1.pdf<br/>lat: -16.496808823347422<br/>lng: -68.13268932180621<br/>total: 324.00<br/>estado: PEDIDO PENDIENTE<br/>user_id: 10<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 16:39:45<br/>updated_at: 2024-04-26 16:39:45<br/>', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 77575373<br/>comprobante: 1714163985_1.pdf<br/>lat: -16.496808823347422<br/>lng: -68.13268932180621<br/>total: 324.00<br/>estado: ORDEN PROCESADA<br/>user_id: 10<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 16:39:45<br/>updated_at: 2024-04-26 17:13:26<br/>', 'ORDEN DE PEDIDOS', '2024-04-26', '17:13:26', '2024-04-26 21:13:26', '2024-04-26 21:13:26'),
(126, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ORDEN DE PEDIDO', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 77575373<br/>comprobante: 1714163985_1.pdf<br/>lat: -16.496808823347422<br/>lng: -68.13268932180621<br/>total: 324.00<br/>estado: PEDIDO PENDIENTE<br/>user_id: 10<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 16:39:45<br/>updated_at: 2024-04-26 17:13:26<br/>', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 77575373<br/>comprobante: 1714163985_1.pdf<br/>lat: -16.496808823347422<br/>lng: -68.13268932180621<br/>total: 324.00<br/>estado: ORDEN PROCESADA<br/>user_id: 10<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 16:39:45<br/>updated_at: 2024-04-26 17:14:03<br/>', 'ORDEN DE PEDIDOS', '2024-04-26', '17:14:03', '2024-04-26 21:14:03', '2024-04-26 21:14:03'),
(127, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA ORDEN DE PEDIDO', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 77575373<br/>comprobante: 1714163985_1.pdf<br/>lat: -16.496808823347422<br/>lng: -68.13268932180621<br/>total: 324.00<br/>estado: PEDIDO PENDIENTE<br/>user_id: 10<br/>fecha_registro: 2024-04-26<br/>created_at: 2024-04-26 16:39:45<br/>updated_at: 2024-04-26 17:14:03<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-04-26', '17:14:14', '2024-04-26 21:14:14', '2024-04-26 21:14:14'),
(128, 10, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ORDEN DE PEDIDO', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 73594451<br/>comprobante: C:\\USERS\\VICTO\\APPDATA\\LOCAL\\TEMP\\PHP87F5.TMP<br/>lat: -16.496059<br/>lng: -68.133345<br/>total: 212.00<br/>estado: PEDIDO PENDIENTE<br/>user_id: 10<br/>fecha_registro: 2024-04-27<br/>created_at: 2024-04-27 15:27:40<br/>updated_at: 2024-04-27 15:27:40<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-04-27', '15:27:40', '2024-04-27 19:27:40', '2024-04-27 19:27:40'),
(129, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ORDEN DE PEDIDO', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 73594451<br/>comprobante: 1714246060_1.pdf<br/>lat: -16.496059<br/>lng: -68.133345<br/>total: 212.00<br/>estado: PEDIDO PENDIENTE<br/>user_id: 10<br/>fecha_registro: 2024-04-27<br/>created_at: 2024-04-27 15:27:40<br/>updated_at: 2024-04-27 15:27:40<br/>', 'id: 1<br/>codigo: ORD.1<br/>nro: 1<br/>configuracion_pago_id: 1<br/>celular: 73594451<br/>comprobante: 1714246060_1.pdf<br/>lat: -16.496059<br/>lng: -68.133345<br/>total: 212.00<br/>estado: ORDEN PROCESADA<br/>user_id: 10<br/>fecha_registro: 2024-04-27<br/>created_at: 2024-04-27 15:27:40<br/>updated_at: 2024-04-27 15:40:42<br/>', 'ORDEN DE PEDIDOS', '2024-04-27', '15:40:47', '2024-04-27 19:40:47', '2024-04-27 19:40:47'),
(130, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CATALOGO', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', NULL, 'CATALOGOS', '2024-04-28', '11:51:03', '2024-04-28 15:51:03', '2024-04-28 15:51:03'),
(131, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CATALOGO', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', 'CATALOGOS', '2024-04-28', '12:05:19', '2024-04-28 16:05:19', '2024-04-28 16:05:19'),
(132, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CATALOGO', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', 'CATALOGOS', '2024-04-28', '12:06:12', '2024-04-28 16:06:12', '2024-04-28 16:06:12'),
(133, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CATALOGO', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', 'CATALOGOS', '2024-04-28', '12:06:18', '2024-04-28 16:06:18', '2024-04-28 16:06:18'),
(134, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN CATALOGO', 'created_at: 2024-04-28 11:51:03<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 11:51:03<br/>', NULL, 'CATALOGOS', '2024-04-28', '12:07:10', '2024-04-28 16:07:10', '2024-04-28 16:07:10'),
(135, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CATALOGO', 'created_at: 2024-04-28 12:07:59<br/>id: 1<br/>nombre: CATALOGO #1<br/>updated_at: 2024-04-28 12:07:59<br/>', NULL, 'CATALOGOS', '2024-04-28', '12:07:59', '2024-04-28 16:07:59', '2024-04-28 16:07:59'),
(136, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CATALOGO', 'created_at: 2024-04-28 12:09:39<br/>id: 2<br/>nombre: CATALOGO #2<br/>updated_at: 2024-04-28 12:09:39<br/>', NULL, 'CATALOGOS', '2024-04-28', '12:09:39', '2024-04-28 16:09:39', '2024-04-28 16:09:39'),
(142, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:17:04<br/>descripcion: DESCRIPCION CAMPAÑA #1 TODOS LOS CLIENTES<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 6<br/>nombre: CAMPAÑA #1<br/>producto_id: <br/>tipo: GIFTCARD<br/>tipo_cliente: TODOS<br/>updated_at: 2024-04-28 13:17:04<br/>', NULL, 'CAMPAÑAS', '2024-04-28', '13:17:04', '2024-04-28 17:17:04', '2024-04-28 17:17:04'),
(143, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:17:04<br/>descripcion: DESCRIPCION CAMPAÑA #1 TODOS LOS CLIENTES<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 6<br/>nombre: CAMPAÑA #1<br/>producto_id: <br/>tipo: GIFTCARD<br/>tipo_cliente: TODOS<br/>updated_at: 2024-04-28 13:17:04<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:17:04<br/>descripcion: DESCRIPCION CAMPAÑA #1 TODOS LOS CLIENTES MOD<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 6<br/>nombre: CAMPAÑA #1<br/>producto_id: <br/>tipo: GIFTCARD<br/>tipo_cliente: TODOS<br/>updated_at: 2024-04-28 13:19:18<br/>', 'CAMPAÑAS', '2024-04-28', '13:19:18', '2024-04-28 17:19:18', '2024-04-28 17:19:18'),
(144, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', NULL, 'CAMPAÑAS', '2024-04-28', '13:19:53', '2024-04-28 17:19:53', '2024-04-28 17:19:53'),
(145, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:21:37<br/>descripcion: DESCRIPCION CAMP 3<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 8<br/>nombre: CAMPAÑA #3<br/>producto_id: <br/>tipo: DESCUENTO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:21:37<br/>', NULL, 'CAMPAÑAS', '2024-04-28', '13:21:37', '2024-04-28 17:21:37', '2024-04-28 17:21:37'),
(146, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:21:37<br/>descripcion: DESCRIPCION CAMP 3<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 8<br/>nombre: CAMPAÑA #3<br/>producto_id: <br/>tipo: DESCUENTO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:21:37<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:21:37<br/>descripcion: DESCRIPCION CAMP 3<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 8<br/>nombre: CAMPAÑA #3<br/>producto_id: 3<br/>tipo: DESCUENTO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:22:34<br/>', 'CAMPAÑAS', '2024-04-28', '13:22:34', '2024-04-28 17:22:34', '2024-04-28 17:22:34'),
(147, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CAMPAÑA', 'cantidad_compra: 3<br/>catalogo_id: <br/>created_at: 2024-04-28 13:23:27<br/>descripcion: DESC CAMP 4<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CANTIDAD COMPRA<br/>id: 9<br/>nombre: CAMPAÑA 4<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:23:28<br/>', NULL, 'CAMPAÑAS', '2024-04-28', '13:23:28', '2024-04-28 17:23:28', '2024-04-28 17:23:28'),
(148, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:24:49<br/>descripcion: DESC. CAMPAÑA 5<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 11<br/>nombre: CAMPAÑA 5<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:24:49<br/>', NULL, 'CAMPAÑAS', '2024-04-28', '13:24:49', '2024-04-28 17:24:49', '2024-04-28 17:24:49'),
(149, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:24:49<br/>descripcion: DESC. CAMPAÑA 5<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 11<br/>nombre: CAMPAÑA 5<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:24:49<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:24:49<br/>descripcion: DESC. CAMPAÑA 5<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 11<br/>nombre: CAMPAÑA 5<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:24:49<br/>', 'CAMPAÑAS', '2024-04-28', '13:29:01', '2024-04-28 17:29:01', '2024-04-28 17:29:01'),
(150, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:24:49<br/>descripcion: DESC. CAMPAÑA 5<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 11<br/>nombre: CAMPAÑA 5<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:24:49<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:24:49<br/>descripcion: DESC. CAMPAÑA 5<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 11<br/>nombre: CAMPAÑA 5<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:24:49<br/>', 'CAMPAÑAS', '2024-04-28', '13:32:54', '2024-04-28 17:32:54', '2024-04-28 17:32:54'),
(151, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:24:49<br/>descripcion: DESC. CAMPAÑA 5<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 11<br/>nombre: CAMPAÑA 5<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:24:49<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:24:49<br/>descripcion: DESC. CAMPAÑA 5<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 11<br/>nombre: CAMPAÑA 5<br/>producto_id: <br/>tipo: RECORDATORIO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:24:49<br/>', 'CAMPAÑAS', '2024-04-28', '13:33:03', '2024-04-28 17:33:03', '2024-04-28 17:33:03'),
(152, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ENVIO DE CAMPAÑA AUTOMATICA', 'campania_id: 6<br/>created_at: 2024-04-28 15:46:30<br/>dias: <br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>frecuencia: RANGO DE FECHAS<br/>id: 1<br/>tipo: TODOS<br/>updated_at: 2024-04-28 15:46:30<br/>', NULL, 'ENVIO DE CAMPAÑAS AUTOMATICAS', '2024-04-28', '15:46:30', '2024-04-28 19:46:30', '2024-04-28 19:46:30'),
(153, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ENVIO DE CAMPAÑA AUTOMATICA', 'campania_id: 7<br/>created_at: 2024-04-28 15:51:31<br/>dias: 5,10<br/>fecha_fin: <br/>fecha_ini: <br/>fecha_registro: 2024-04-28<br/>frecuencia: DÍAS<br/>id: 2<br/>tipo: CORREO<br/>updated_at: 2024-04-28 15:51:31<br/>', NULL, 'ENVIO DE CAMPAÑAS AUTOMATICAS', '2024-04-28', '15:51:31', '2024-04-28 19:51:31', '2024-04-28 19:51:31'),
(154, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN ENVIO DE CAMPAÑA AUTOMATICA', 'campania_id: 7<br/>created_at: 2024-04-28 15:51:31<br/>dias: 5,10<br/>fecha_fin: <br/>fecha_ini: <br/>fecha_registro: 2024-04-28<br/>frecuencia: DÍAS<br/>id: 2<br/>tipo: CORREO<br/>updated_at: 2024-04-28 15:51:31<br/>', 'campania_id: 7<br/>created_at: 2024-04-28 15:51:31<br/>dias: 5,15,10<br/>fecha_fin: <br/>fecha_ini: <br/>fecha_registro: 2024-04-28<br/>frecuencia: DÍAS<br/>id: 2<br/>tipo: CORREO<br/>updated_at: 2024-04-28 15:51:56<br/>', 'ENVIO DE CAMPAÑAS AUTOMATICAS', '2024-04-28', '15:51:56', '2024-04-28 19:51:56', '2024-04-28 19:51:56'),
(155, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN ENVIO DE CAMPAÑA AUTOMATICA', 'campania_id: 7<br/>created_at: 2024-04-28 15:51:31<br/>dias: 5,15,10<br/>fecha_fin: <br/>fecha_ini: <br/>fecha_registro: 2024-04-28<br/>frecuencia: DÍAS<br/>id: 2<br/>tipo: CORREO<br/>updated_at: 2024-04-28 15:51:56<br/>', 'campania_id: 7<br/>created_at: 2024-04-28 15:51:31<br/>dias: 5<br/>fecha_fin: <br/>fecha_ini: <br/>fecha_registro: 2024-04-28<br/>frecuencia: DÍAS<br/>id: 2<br/>tipo: CORREO<br/>updated_at: 2024-04-28 15:53:43<br/>', 'ENVIO DE CAMPAÑAS AUTOMATICAS', '2024-04-28', '15:53:43', '2024-04-28 19:53:43', '2024-04-28 19:53:43'),
(156, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN ENVIO DE CAMPAÑA AUTOMATICA', 'campania_id: 7<br/>created_at: 2024-04-28 15:51:31<br/>dias: 5<br/>fecha_fin: <br/>fecha_ini: <br/>fecha_registro: 2024-04-28<br/>frecuencia: DÍAS<br/>id: 2<br/>tipo: CORREO<br/>updated_at: 2024-04-28 15:53:43<br/>', 'campania_id: 7<br/>created_at: 2024-04-28 15:51:31<br/>dias: 5,30<br/>fecha_fin: <br/>fecha_ini: <br/>fecha_registro: 2024-04-28<br/>frecuencia: DÍAS<br/>id: 2<br/>tipo: CORREO<br/>updated_at: 2024-04-28 15:53:49<br/>', 'ENVIO DE CAMPAÑAS AUTOMATICAS', '2024-04-28', '15:53:49', '2024-04-28 19:53:49', '2024-04-28 19:53:49'),
(157, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', 'CAMPAÑAS', '2024-04-28', '16:53:00', '2024-04-28 20:53:00', '2024-04-28 20:53:00'),
(158, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', 'CAMPAÑAS', '2024-04-28', '16:54:13', '2024-04-28 20:54:13', '2024-04-28 20:54:13'),
(159, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', 'CAMPAÑAS', '2024-04-28', '16:54:21', '2024-04-28 20:54:21', '2024-04-28 20:54:21'),
(160, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 13:19:53<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 16:55:24<br/>', 'CAMPAÑAS', '2024-04-28', '16:55:24', '2024-04-28 20:55:24', '2024-04-28 20:55:24'),
(161, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>tipo: FISICO<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-25 12:22:23<br/>', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>tipo: FISICO<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-29 12:17:07<br/>', 'CLIENTES', '2024-04-29', '12:17:07', '2024-04-29 16:17:07', '2024-04-29 16:17:07'),
(162, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>tipo: FISICO<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-29 12:17:07<br/>', 'id: 6<br/>nombre: PABLO SANCHEZ<br/>ci: 3223423<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pablo@gmail.com<br/>dir: <br/>user_id: 9<br/>tipo: FISICO<br/>fecha_registro: 2024-04-25<br/>created_at: 2024-04-25 12:20:39<br/>updated_at: 2024-04-29 12:17:12<br/>', 'CLIENTES', '2024-04-29', '12:17:12', '2024-04-29 16:17:12', '2024-04-29 16:17:12'),
(163, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 2<br/>nombre: MARIA GONZALES CASAS<br/>ci: 1231231<br/>ci_exp: CB<br/>nit: 34324111<br/>fono: 666666; 7777777<br/>correo: maria@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 7<br/>tipo: FISICO<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:05:20<br/>updated_at: 2024-04-25 12:22:20<br/>', 'id: 2<br/>nombre: MARIA GONZALES CASAS<br/>ci: 1231231<br/>ci_exp: CB<br/>nit: 34324111<br/>fono: 666666; 7777777<br/>correo: maria@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 7<br/>tipo: FISICO<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:05:20<br/>updated_at: 2024-04-29 12:17:16<br/>', 'CLIENTES', '2024-04-29', '12:17:17', '2024-04-29 16:17:17', '2024-04-29 16:17:17'),
(164, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>tipo: FISICO<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-25 12:22:17<br/>', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 231231<br/>ci_exp: LP<br/>nit: <br/>fono: <br/>correo: pedro@gmail.com<br/>dir: LOS OLIVOS<br/>user_id: 3<br/>tipo: FISICO<br/>fecha_registro: 2023-04-26<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-04-29 12:17:22<br/>', 'CLIENTES', '2024-04-29', '12:17:22', '2024-04-29 16:17:22', '2024-04-29 16:17:22'),
(165, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714158718_1.png<br/>updated_at: 2024-04-26 15:11:58<br/>', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: <br/>updated_at: 2024-04-30 09:39:26<br/>', 'CONFIGURACION DE PAGOS', '2024-04-30', '09:39:26', '2024-04-30 13:39:26', '2024-04-30 13:39:26'),
(166, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: <br/>updated_at: 2024-04-30 09:39:26<br/>', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714484412_1.png<br/>updated_at: 2024-04-30 09:40:12<br/>', 'CONFIGURACION DE PAGOS', '2024-04-30', '09:40:12', '2024-04-30 13:40:12', '2024-04-30 13:40:12'),
(167, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714484412_1.png<br/>updated_at: 2024-04-30 09:40:12<br/>', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714484414_1.png<br/>updated_at: 2024-04-30 09:40:14<br/>', 'CONFIGURACION DE PAGOS', '2024-04-30', '09:40:14', '2024-04-30 13:40:14', '2024-04-30 13:40:14'),
(168, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714484414_1.png<br/>updated_at: 2024-04-30 09:40:14<br/>', 'banco: BANCO UNIONS<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714484416_1.png<br/>updated_at: 2024-04-30 09:40:16<br/>', 'CONFIGURACION DE PAGOS', '2024-04-30', '09:40:16', '2024-04-30 13:40:16', '2024-04-30 13:40:16'),
(169, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA CONFIGURACION DE PAGO', 'banco: BANCO UNIONS<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714484416_1.png<br/>updated_at: 2024-04-30 09:40:16<br/>', 'banco: BANCO UNION<br/>created_at: 2024-04-26 15:11:50<br/>fecha_registro: 2024-04-26<br/>id: 1<br/>nro_cuenta: 10000000222222<br/>qr: 1714484423_1.png<br/>updated_at: 2024-04-30 09:40:23<br/>', 'CONFIGURACION DE PAGOS', '2024-04-30', '09:40:23', '2024-04-30 13:40:23', '2024-04-30 13:40:23'),
(170, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:21:37<br/>descripcion: DESCRIPCION CAMP 3<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 8<br/>nombre: CAMPAÑA #3<br/>producto_id: 3<br/>tipo: DESCUENTO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-28 13:22:34<br/>', 'cantidad_compra: <br/>catalogo_id: 2<br/>created_at: 2024-04-28 13:21:37<br/>descripcion: DESCRIPCION CAMP 3<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 8<br/>nombre: CAMPAÑA #3<br/>producto_id: 3<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-30 10:08:34<br/>', 'CAMPAÑAS', '2024-04-30', '10:08:34', '2024-04-30 14:08:34', '2024-04-30 14:08:34'),
(171, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: <br/>tipo: CATÁLOGO<br/>tipo_cliente: ECOMMERCE<br/>updated_at: 2024-04-28 16:55:24<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 3<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-30 10:09:41<br/>', 'CAMPAÑAS', '2024-04-30', '10:09:41', '2024-04-30 14:09:41', '2024-04-30 14:09:41'),
(172, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 3<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-30 10:09:41<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-30 10:10:45<br/>', 'CAMPAÑAS', '2024-04-30', '10:10:45', '2024-04-30 14:10:45', '2024-04-30 14:10:45'),
(173, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: <br/>mision_img: <br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: <br/>nosotros_img: <br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: <br/>servicios_img: <br/>twitter: <br/>ubicacion: <br/>updated_at: 2024-04-26 15:13:00<br/>vision: <br/>vision_img: <br/>web: <br/>youtube: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: <br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: <br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <br/>updated_at: 2024-04-30 10:30:15<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: <br/>web: <br/>youtube: <br/>', 'CONFIGURACIÓN', '2024-04-30', '10:30:15', '2024-04-30 14:30:15', '2024-04-30 14:30:15');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(174, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: <br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: <br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 10:30:15<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: <br/>web: <br/>youtube: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:40:27<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'CONFIGURACIÓN', '2024-04-30', '10:40:27', '2024-04-30 14:40:27', '2024-04-30 14:40:27'),
(175, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:40:27<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:40:27<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'CONFIGURACIÓN', '2024-04-30', '10:45:44', '2024-04-30 14:45:44', '2024-04-30 14:45:44'),
(176, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:40:27<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:40:27<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'CONFIGURACIÓN', '2024-04-30', '10:46:39', '2024-04-30 14:46:39', '2024-04-30 14:46:39'),
(177, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: <br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:40:27<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:47:03<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'CONFIGURACIÓN', '2024-04-30', '10:47:03', '2024-04-30 14:47:03', '2024-04-30 14:47:03'),
(178, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: <br/>ubicacion: <IFRAME SRC=\"HTTPS://WWW.GOOGLE.COM/MAPS/EMBED?PB=!1M21!1M12!1M3!1D15302.44340797871!2D-68.13196529479978!3D-16.495230895308648!2M3!1F0!2F0!3F0!3M2!1I1024!2I768!4F13.1!4M6!3E0!4M0!4M3!3M2!1D-16.497514656468287!2D-68.12797416816427!5E0!3M2!1SES-419!2SBO!4V1697748242821!5M2!1SES-419!2SBO\" WIDTH=\"600\" HEIGHT=\"450\" STYLE=\"BORDER:0;\" ALLOWFULLSCREEN=\"\" LOADING=\"LAZY\" REFERRERPOLICY=\"NO-REFERRER-WHEN-DOWNGRADE\"></IFRAME><br/>updated_at: 2024-04-30 10:47:03<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: <br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 10:50:51<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'CONFIGURACIÓN', '2024-04-30', '10:50:51', '2024-04-30 14:50:51', '2024-04-30 14:50:51'),
(179, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: <br/>fono: 222222<br/>id: 1<br/>instagram: <br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: <br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 10:50:51<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: HTTPS://FACEBOOK.COM<br/>fono: 222222<br/>id: 1<br/>instagram: HTTPS://INSTAGRAM.COM<br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: HTTPS://TWITTER.COM<br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 10:52:42<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: HTTPS://YOUTUBE.COM<br/>', 'CONFIGURACIÓN', '2024-04-30', '10:52:42', '2024-04-30 14:52:42', '2024-04-30 14:52:42'),
(180, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: HTTPS://FACEBOOK.COM<br/>fono: 222222<br/>id: 1<br/>instagram: HTTPS://INSTAGRAM.COM<br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: HTTPS://TWITTER.COM<br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 10:52:42<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: HTTPS://YOUTUBE.COM<br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: https://facebook.com<br/>fono: 222222<br/>id: 1<br/>instagram: https://instagram.com<br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: https://twitter.com<br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 10:53:26<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: https://youtube.com<br/>', 'CONFIGURACIÓN', '2024-04-30', '10:53:26', '2024-04-30 14:53:26', '2024-04-30 14:53:26'),
(181, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>facebook: https://facebook.com<br/>fono: 222222<br/>id: 1<br/>instagram: https://instagram.com<br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: https://twitter.com<br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 10:53:26<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: https://youtube.com<br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: VICTORGONZALO.AS@GMAIL.COM<br/>created_at: <br/>dir: LA PAZ<br/>facebook: https://facebook.com<br/>fono: 222222<br/>id: 1<br/>instagram: https://instagram.com<br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: https://twitter.com<br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 12:00:56<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: https://youtube.com<br/>', 'CONFIGURACIÓN', '2024-04-30', '12:00:56', '2024-04-30 16:00:56', '2024-04-30 16:00:56'),
(182, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: VICTORGONZALO.AS@GMAIL.COM<br/>created_at: <br/>dir: LA PAZ<br/>facebook: https://facebook.com<br/>fono: 222222<br/>id: 1<br/>instagram: https://instagram.com<br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: https://twitter.com<br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 12:00:56<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: https://youtube.com<br/>', 'actividad: ACTIVIDAD<br/>alias: SISCRM<br/>ciudad: LA PAZ<br/>correo: SISCRM@GMAIL.COM<br/>created_at: <br/>dir: LA PAZ<br/>facebook: https://facebook.com<br/>fono: 222222<br/>id: 1<br/>instagram: https://instagram.com<br/>logo: 1682712649_logo.jpg<br/>mision: MISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>mision_img: 1714488027_mision_img.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>nosotros: NOSOTROS.THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>nosotros_img: 1714488027_nosotros_img.jpg<br/>razon_social: EMPRESA PRUEBA S.A.<br/>servicios: SERVICIOS. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>servicios_img: 1714488423_servicios_img.jpg<br/>twitter: https://twitter.com<br/>ubicacion: <iframe src=\"https://www.google.com/maps/embed?pb=!1m21!1m12!1m3!1d15302.44340797871!2d-68.13196529479978!3d-16.495230895308648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m6!3e0!4m0!4m3!3m2!1d-16.497514656468287!2d-68.12797416816427!5e0!3m2!1ses-419!2sbo!4v1697748242821!5m2!1ses-419!2sbo\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe><br/>updated_at: 2024-04-30 12:02:18<br/>vision: VISION. THERE ARE MANY VARIATIONS OF PASSAGES OF LOREM IPSUM AVAILABLE, BUT THE MAJORITY HAVE SUFFERED ALTERATION IN SOME FORM, BY INJECTED HUMOUR, OR RANDOMISED WORDS WHICH DON\'T LOOK EVEN SLIGHTLY BELIEVABLE. IF YOU ARE GOING TO USE A PASSAGE OF LOREM IPSUM, YOU NEED TO BE SURE THERE ISN\'T ANYTHING EMBARRASSING HIDDEN IN THE MIDDLE OF TEXT<br/>vision_img: 1714488027_vision_img.jpg<br/>web: <br/>youtube: https://youtube.com<br/>', 'CONFIGURACIÓN', '2024-04-30', '12:02:18', '2024-04-30 16:02:18', '2024-04-30 16:02:18'),
(183, 10, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ORDEN DE PEDIDO', 'celular: 666666666<br/>codigo: ORD.2<br/>comprobante: C:\\USERS\\VICTO\\APPDATA\\LOCAL\\TEMP\\PHP907F.TMP<br/>configuracion_pago_id: 1<br/>created_at: 2024-04-30 12:28:52<br/>cupon: C001<br/>descuento: 105.28<br/>entrega: DOMICILIO<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-04-30<br/>id: 2<br/>lat: -16.496059<br/>lng: -68.133345<br/>nro: 2<br/>total: 112.00<br/>total_final: 6.72<br/>updated_at: 2024-04-30 12:28:52<br/>user_id: 10<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-04-30', '12:28:52', '2024-04-30 16:28:52', '2024-04-30 16:28:52'),
(184, 11, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ORDEN DE PEDIDO', 'celular: 67676767<br/>codigo: ORD.3<br/>comprobante: C:\\USERS\\VICTO\\APPDATA\\LOCAL\\TEMP\\PHP9552.TMP<br/>configuracion_pago_id: 2<br/>created_at: 2024-04-30 12:39:49<br/>cupon: C001<br/>descuento: 0.06<br/>entrega: TIENDA<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-04-30<br/>id: 3<br/>lat: -16.498088388840433<br/>lng: -68.13366216194534<br/>nro: 3<br/>total: 82.00<br/>total_final: 77.08<br/>updated_at: 2024-04-30 12:39:49<br/>user_id: 11<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-04-30', '12:39:49', '2024-04-30 16:39:49', '2024-04-30 16:39:49'),
(185, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ORDEN DE PEDIDO', 'celular: 666666666<br/>codigo: ORD.2<br/>comprobante: 1714494532_2.pdf<br/>configuracion_pago_id: 1<br/>created_at: 2024-04-30 12:28:52<br/>cupon: C001<br/>descuento: 6<br/>entrega: DOMICILIO<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-04-30<br/>id: 2<br/>lat: -16.496059<br/>lng: -68.133345<br/>nro: 2<br/>total: 112.00<br/>total_final: 105.28<br/>updated_at: 2024-04-30 12:28:52<br/>user_id: 10<br/>', 'celular: 666666666<br/>codigo: ORD.2<br/>comprobante: 1714494532_2.pdf<br/>configuracion_pago_id: 1<br/>created_at: 2024-04-30 12:28:52<br/>cupon: C001<br/>descuento: 6<br/>entrega: DOMICILIO<br/>estado: ORDEN PROCESADA<br/>fecha_registro: 2024-04-30<br/>id: 2<br/>lat: -16.496059<br/>lng: -68.133345<br/>nro: 2<br/>total: 112.00<br/>total_final: 105.28<br/>updated_at: 2024-04-30 12:41:36<br/>user_id: 10<br/>', 'ORDEN DE PEDIDOS', '2024-04-30', '12:41:40', '2024-04-30 16:41:40', '2024-04-30 16:41:40'),
(186, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:17:04<br/>descripcion: DESCRIPCION CAMPAÑA #1 TODOS LOS CLIENTES MOD<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 6<br/>nombre: CAMPAÑA #1<br/>producto_id: <br/>tipo: GIFTCARD<br/>tipo_cliente: TODOS<br/>updated_at: 2024-04-28 13:19:18<br/>', 'cantidad_compra: <br/>catalogo_id: <br/>created_at: 2024-04-28 13:17:04<br/>descripcion: DESCRIPCION CAMPAÑA #1 TODOS LOS CLIENTES MOD<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: <br/>id: 6<br/>nombre: CAMPAÑA #1<br/>producto_id: <br/>tipo: GIFTCARD<br/>tipo_cliente: TODOS<br/>updated_at: 2024-05-03 16:11:55<br/>', 'CAMPAÑAS', '2024-05-03', '16:11:55', '2024-05-03 20:11:55', '2024-05-03 20:11:55');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(187, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-04-29<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-04-30 10:10:45<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:19:24<br/>', 'CAMPAÑAS', '2024-05-03', '16:19:24', '2024-05-03 20:19:24', '2024-05-03 20:19:24'),
(188, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:19:24<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:47:28<br/>', 'CAMPAÑAS', '2024-05-03', '16:47:28', '2024-05-03 20:47:28', '2024-05-03 20:47:28'),
(189, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:47:28<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:47:35<br/>', 'CAMPAÑAS', '2024-05-03', '16:47:35', '2024-05-03 20:47:35', '2024-05-03 20:47:35'),
(190, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: PRODUCTO COMPRADO<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:47:35<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'CAMPAÑAS', '2024-05-03', '16:54:32', '2024-05-03 20:54:32', '2024-05-03 20:54:32'),
(191, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'CAMPAÑAS', '2024-05-03', '17:03:06', '2024-05-03 21:03:06', '2024-05-03 21:03:06'),
(192, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'CAMPAÑAS', '2024-05-03', '17:11:55', '2024-05-03 21:11:55', '2024-05-03 21:11:55'),
(193, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'CAMPAÑAS', '2024-05-03', '18:07:41', '2024-05-03 22:07:41', '2024-05-03 22:07:41'),
(194, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CAMPAÑA', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'cantidad_compra: <br/>catalogo_id: 1<br/>created_at: 2024-04-28 13:19:53<br/>descripcion: DESC. CAMPAÑA #2<br/>fecha_fin: 2024-05-05<br/>fecha_ini: 2024-04-28<br/>fecha_registro: 2024-04-28<br/>filtro_cliente: CLIENTES ESPECIFICOS<br/>id: 7<br/>nombre: CAMPAÑA #2<br/>producto_id: 7<br/>tipo: CATÁLOGO<br/>tipo_cliente: PERSONALIZADO<br/>updated_at: 2024-05-03 16:54:32<br/>', 'CAMPAÑAS', '2024-05-03', '18:07:48', '2024-05-03 22:07:48', '2024-05-03 22:07:48'),
(195, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'apellidos: COLQUE MAMANI<br/>ci: 543543543<br/>ci_exp: CB<br/>correo: martin@gmail.com<br/>created_at: 2024-05-06 13:44:07<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 9<br/>nit: 533234234234<br/>nombre: MARTIN<br/>tipo: FISICO<br/>updated_at: 2024-05-06 13:44:07<br/>user_id: 12<br/>', NULL, 'CLIENTES', '2024-05-06', '13:44:07', '2024-05-06 17:44:07', '2024-05-06 17:44:07'),
(196, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'apellidos: GONZALES<br/>ci: 43343434<br/>ci_exp: SC<br/>correo: marisol@gmail.com<br/>created_at: 2024-05-06 13:44:47<br/>dir: <br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 10<br/>nit: <br/>nombre: MARISOL<br/>tipo: FISICO<br/>updated_at: 2024-05-06 13:44:47<br/>user_id: 13<br/>', NULL, 'CLIENTES', '2024-05-06', '13:44:47', '2024-05-06 17:44:47', '2024-05-06 17:44:47'),
(197, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'apellidos: TAPIA<br/>ci: 4334343<br/>ci_exp: SC<br/>correo: a<br/>created_at: 2024-05-06 13:49:50<br/>dir: A<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 11<br/>nit: <br/>nombre: MARITZA<br/>tipo: FISICO<br/>updated_at: 2024-05-06 13:49:50<br/>user_id: 14<br/>', NULL, 'CLIENTES', '2024-05-06', '13:49:50', '2024-05-06 17:49:50', '2024-05-06 17:49:50'),
(198, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'apellidos: CARDENAS<br/>ci: 343434<br/>ci_exp: SC<br/>correo: alvaro@gmail.com<br/>created_at: 2024-05-06 13:57:03<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 12<br/>nit: <br/>nombre: ALVARO<br/>tipo: FISICO<br/>updated_at: 2024-05-06 13:57:03<br/>user_id: 15<br/>', NULL, 'CLIENTES', '2024-05-06', '13:57:03', '2024-05-06 17:57:03', '2024-05-06 17:57:03'),
(199, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>orden_pedido_id: <br/>tipo: FISICO<br/>total: 200.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:35<br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>orden_pedido_id: <br/>tipo: FISICO<br/>total: 200.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:35<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2024-05-06', '13:58:10', '2024-05-06 17:58:10', '2024-05-06 17:58:10'),
(200, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>orden_pedido_id: <br/>tipo: FISICO<br/>total: 200.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:35<br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>orden_pedido_id: <br/>tipo: FISICO<br/>total: 200.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:35<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2024-05-06', '14:36:43', '2024-05-06 18:36:43', '2024-05-06 18:36:43'),
(201, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: <br/>nit: 3333<br/>nombre_contacto: JOSE PAREDES<br/>paterno: <br/>razon_social: PEPE S.A.<br/>updated_at: 2023-04-24 17:09:20<br/>', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: <br/>nit: 333312312312<br/>nombre_contacto: JOSE PAREDES<br/>paterno: <br/>razon_social: PEPE S.A.<br/>updated_at: 2024-05-06 14:43:39<br/>', 'PROVEEDORES', '2024-05-06', '14:43:39', '2024-05-06 18:43:39', '2024-05-06 18:43:39'),
(202, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: <br/>nit: 333312312312<br/>nombre_contacto: JOSE PAREDES<br/>paterno: <br/>razon_social: PEPE S.A.<br/>updated_at: 2024-05-06 14:43:39<br/>', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: MAMANI<br/>nit: 333312312312<br/>nombre_contacto: JOSE<br/>paterno: PERES<br/>razon_social: PEPE S.A.<br/>updated_at: 2024-05-06 14:43:49<br/>', 'PROVEEDORES', '2024-05-06', '14:43:49', '2024-05-06 18:43:49', '2024-05-06 18:43:49'),
(203, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: MAMANI<br/>nit: 333312312312<br/>nombre_contacto: JOSE<br/>paterno: PERES<br/>razon_social: PEPE S.A.<br/>updated_at: 2024-05-06 14:43:49<br/>', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: MAMANI<br/>nit: 333312312312<br/>nombre_contacto: JOSES<br/>paterno: PERES<br/>razon_social: PEPE S.A.<br/>updated_at: 2024-05-06 14:43:55<br/>', 'PROVEEDORES', '2024-05-06', '14:43:55', '2024-05-06 18:43:55', '2024-05-06 18:43:55'),
(204, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: MAMANI<br/>nit: 333312312312<br/>nombre_contacto: JOSES<br/>paterno: PERES<br/>razon_social: PEPE S.A.<br/>updated_at: 2024-05-06 14:43:55<br/>', 'created_at: 2023-04-24 17:09:13<br/>descripcion: <br/>dir: <br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>id: 1<br/>materno: MAMANI<br/>nit: 333312312312<br/>nombre_contacto: JOSE<br/>paterno: PERES<br/>razon_social: PEPE S.A.<br/>updated_at: 2024-05-06 14:43:58<br/>', 'PROVEEDORES', '2024-05-06', '14:43:58', '2024-05-06 18:43:58', '2024-05-06 18:43:58'),
(205, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 3<br/>created_at: 2023-04-27 15:00:19<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>id: 6<br/>nit: 43434<br/>orden_pedido_id: <br/>tipo: FISICO<br/>total: 60.00<br/>total_final: 120.00<br/>updated_at: 2023-04-27 15:00:50<br/>user_id: 1<br/>', 'cliente_id: 6<br/>created_at: 2023-04-27 15:00:19<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>id: 6<br/>nit: 43434<br/>orden_pedido_id: <br/>tipo: FISICO<br/>total: 60.00<br/>total_final: 120.00<br/>updated_at: 2024-05-06 15:02:06<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2024-05-06', '15:02:06', '2024-05-06 19:02:06', '2024-05-06 19:02:06'),
(206, 15, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ORDEN DE PEDIDO', 'celular: <br/>codigo: ORD.4<br/>comprobante: C:\\USERS\\VICTO\\APPDATA\\LOCAL\\TEMP\\PHP5899.TMP<br/>configuracion_pago_id: 1<br/>created_at: 2024-05-06 16:10:05<br/>cupon: <br/>descuento: 0<br/>entrega: TIENDA<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-05-06<br/>id: 4<br/>lat: -16.496059<br/>lng: -68.133345<br/>nro: 4<br/>total: 12.00<br/>total_final: 12<br/>updated_at: 2024-05-06 16:10:05<br/>user_id: 15<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-05-06', '16:10:05', '2024-05-06 20:10:05', '2024-05-06 20:10:05'),
(207, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'apellidos: CARDENAS<br/>ci: 343434<br/>ci_exp: SC<br/>correo: alvaro@gmail.com<br/>created_at: 2024-05-06 13:57:03<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 12<br/>nit: <br/>nombre: ALVARO<br/>tipo: FISICO<br/>updated_at: 2024-05-06 13:57:03<br/>user_id: 15<br/>', 'apellidos: CARDENAS<br/>ci: 343434<br/>ci_exp: SC<br/>correo: alvaro@gmail.com<br/>created_at: 2024-05-06 13:57:03<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 12<br/>nit: <br/>nombre: ALVARO<br/>tipo: FISICO<br/>updated_at: 2024-05-06 16:12:00<br/>user_id: 15<br/>', 'CLIENTES', '2024-05-06', '16:12:00', '2024-05-06 20:12:00', '2024-05-06 20:12:00'),
(208, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'apellidos: CARDENAS<br/>ci: 343434<br/>ci_exp: SC<br/>correo: alvaro@gmail.com<br/>created_at: 2024-05-06 13:57:03<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 12<br/>nit: <br/>nombre: ALVARO<br/>tipo: FISICO<br/>updated_at: 2024-05-06 16:12:00<br/>user_id: 15<br/>', 'apellidos: CARDENAS<br/>ci: 343434<br/>ci_exp: SC<br/>correo: alvaro@gmail.com<br/>created_at: 2024-05-06 13:57:03<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 12<br/>nit: <br/>nombre: ALVARO<br/>tipo: FISICO<br/>updated_at: 2024-05-06 16:12:46<br/>user_id: 15<br/>', 'CLIENTES', '2024-05-06', '16:12:46', '2024-05-06 20:12:46', '2024-05-06 20:12:46'),
(209, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'apellidos: CARDENAS<br/>ci: 343434<br/>ci_exp: SC<br/>correo: alvaro@gmail.com<br/>created_at: 2024-05-06 13:57:03<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 12<br/>nit: <br/>nombre: ALVARO<br/>tipo: FISICO<br/>updated_at: 2024-05-06 16:12:46<br/>user_id: 15<br/>', 'apellidos: CARDENAS<br/>ci: 343434<br/>ci_exp: SC<br/>correo: alvaro@gmail.com<br/>created_at: 2024-05-06 13:57:03<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-06<br/>fono: <br/>id: 12<br/>nit: <br/>nombre: ALVARO<br/>tipo: FISICO<br/>updated_at: 2024-05-06 16:13:25<br/>user_id: 15<br/>', 'CLIENTES', '2024-05-06', '16:13:25', '2024-05-06 20:13:25', '2024-05-06 20:13:25'),
(210, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA ORDEN DE PEDIDO', 'celular: <br/>codigo: ORD.4<br/>comprobante: 1715026205_4.pdf<br/>configuracion_pago_id: 1<br/>created_at: 2024-05-06 16:10:05<br/>cupon: <br/>descuento: 0<br/>entrega: TIENDA<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-05-06<br/>id: 4<br/>lat: -16.496059<br/>lng: -68.133345<br/>nro: 4<br/>status: 1<br/>total: 12.00<br/>total_final: 12.00<br/>updated_at: 2024-05-06 16:10:05<br/>user_id: 15<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-05-06', '16:22:31', '2024-05-06 20:22:31', '2024-05-06 20:22:31'),
(211, 1, 'ELIMINACIÓN', 'EL USUARIO  HABILITO UNA ORDEN DE PEDIDO', 'celular: <br/>codigo: ORD.4<br/>comprobante: 1715026205_4.pdf<br/>configuracion_pago_id: 1<br/>created_at: 2024-05-06 16:10:05<br/>cupon: <br/>descuento: 0<br/>entrega: TIENDA<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-05-06<br/>id: 4<br/>lat: -16.496059<br/>lng: -68.133345<br/>nro: 4<br/>status: 0<br/>total: 12.00<br/>total_final: 12.00<br/>updated_at: 2024-05-06 16:22:31<br/>user_id: 15<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-05-06', '16:26:30', '2024-05-06 20:26:30', '2024-05-06 20:26:30'),
(212, 1, 'ELIMINACIÓN', 'EL USUARIO  ANULÓ UNA ORDEN DE PEDIDO', 'celular: <br/>codigo: ORD.4<br/>comprobante: 1715026205_4.pdf<br/>configuracion_pago_id: 1<br/>created_at: 2024-05-06 16:10:05<br/>cupon: <br/>descuento: 0<br/>entrega: TIENDA<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-05-06<br/>id: 4<br/>lat: -16.496059<br/>lng: -68.133345<br/>nro: 4<br/>status: 1<br/>total: 12.00<br/>total_final: 12.00<br/>updated_at: 2024-05-06 16:26:30<br/>user_id: 15<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-05-06', '16:26:44', '2024-05-06 20:26:44', '2024-05-06 20:26:44'),
(213, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CUPON', 'created_at: 2024-04-30 12:13:32<br/>descuento: 6<br/>id: 1<br/>texto: C001<br/>updated_at: 2024-04-30 12:14:05<br/>', 'created_at: 2024-04-30 12:13:32<br/>descuento: 5<br/>id: 1<br/>texto: C001<br/>updated_at: 2024-05-06 16:34:53<br/>', 'CUPONES', '2024-05-06', '16:34:53', '2024-05-06 20:34:53', '2024-05-06 20:34:53'),
(214, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CUPON', 'created_at: 2024-05-06 16:35:08<br/>descuento: 1<br/>id: 2<br/>texto: C002<br/>updated_at: 2024-05-06 16:35:08<br/>', NULL, 'CUPONES', '2024-05-06', '16:35:08', '2024-05-06 20:35:08', '2024-05-06 20:35:08'),
(215, 10, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ORDEN DE PEDIDO', 'celular: <br/>codigo: ORD.5<br/>comprobante: C:\\USERS\\VICTO\\APPDATA\\LOCAL\\TEMP\\PHPB402.TMP<br/>configuracion_pago_id: 1<br/>created_at: 2024-05-07 14:12:07<br/>cupon: C001<br/>descuento: 5<br/>entrega: DOMICILIO<br/>estado: PEDIDO PENDIENTE<br/>fecha_registro: 2024-05-07<br/>id: 5<br/>lat: -16.4969333667204<br/>lng: -68.13183491643645<br/>nro: 5<br/>status: <br/>total: 94.00<br/>total_final: 89.3<br/>updated_at: 2024-05-07 14:12:07<br/>user_id: 10<br/>', NULL, 'ORDEN DE PEDIDOS', '2024-05-07', '14:12:07', '2024-05-07 18:12:07', '2024-05-07 18:12:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso_productos`
--

CREATE TABLE `ingreso_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `proveedor_id` bigint UNSIGNED NOT NULL,
  `precio_compra` decimal(8,2) NOT NULL,
  `cantidad` double NOT NULL,
  `lote` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_fabricacion` date NOT NULL,
  `fecha_compra` date NOT NULL,
  `tipo_ingreso_id` bigint UNSIGNED NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingreso_productos`
--

INSERT INTO `ingreso_productos` (`id`, `producto_id`, `proveedor_id`, `precio_compra`, `cantidad`, `lote`, `fecha_fabricacion`, `fecha_compra`, `tipo_ingreso_id`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 20.00, 100, '1', '2023-02-02', '2023-02-02', 1, '', '2023-04-25', '2023-04-25 15:23:41', '2024-04-25 15:37:03'),
(2, 2, 1, 30.00, 100, '2', '2023-04-25', '2023-04-25', 2, '', '2023-04-25', '2023-04-25 15:25:58', '2023-04-25 15:25:58'),
(3, 3, 1, 100.00, 70, '3', '2023-03-03', '2023-03-03', 1, '', '2023-04-25', '2023-04-25 15:28:29', '2023-04-25 15:31:20'),
(4, 1, 1, 20.00, 10, '10', '2023-04-27', '2023-04-27', 1, '', '2023-04-27', '2023-04-27 18:59:01', '2023-04-27 18:59:01'),
(5, 7, 2, 11.00, 90, '322323', '2023-01-01', '2023-01-01', 1, '', '2023-04-28', '2023-04-28 15:42:04', '2023-04-28 15:42:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex_productos`
--

CREATE TABLE `kardex_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `lugar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_registro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registro_id` bigint UNSIGNED DEFAULT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `detalle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `tipo_is` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_ingreso` double DEFAULT NULL,
  `cantidad_salida` double DEFAULT NULL,
  `cantidad_saldo` double NOT NULL,
  `cu` decimal(24,2) NOT NULL,
  `monto_ingreso` decimal(24,2) DEFAULT NULL,
  `monto_salida` decimal(24,2) DEFAULT NULL,
  `monto_saldo` decimal(24,2) NOT NULL,
  `fecha` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `kardex_productos`
--

INSERT INTO `kardex_productos` (`id`, `lugar`, `tipo_registro`, `registro_id`, `producto_id`, `detalle`, `precio`, `tipo_is`, `cantidad_ingreso`, `cantidad_salida`, `cantidad_saldo`, `cu`, `monto_ingreso`, `monto_salida`, `monto_saldo`, `fecha`, `created_at`, `updated_at`) VALUES
(1, NULL, 'INGRESO', 1, 1, 'VALOR INICIAL', 20.00, 'INGRESO', 100, NULL, 100, 20.00, 2000.00, NULL, 2000.00, '2023-04-25', '2023-04-25 15:23:41', '2024-04-25 15:37:03'),
(2, NULL, 'INGRESO', 2, 2, 'VALOR INICIAL', 35.00, 'INGRESO', 100, NULL, 100, 35.00, 3500.00, NULL, 3500.00, '2023-04-25', '2023-04-25 15:25:58', '2023-04-26 20:45:18'),
(3, NULL, 'INGRESO', 3, 3, 'VALOR INICIAL', 100.00, 'INGRESO', 70, NULL, 70, 100.00, 7000.00, NULL, 7000.00, '2023-04-25', '2023-04-25 15:28:29', '2023-04-26 20:45:18'),
(6, NULL, 'SALIDA', 3, 1, 'SALIDA DE PRODUCTO', 20.00, 'EGRESO', NULL, 3, 97, 20.00, NULL, 60.00, 1940.00, '2023-04-25', '2023-04-25 19:47:12', '2024-04-25 15:37:03'),
(11, NULL, 'VENTA', 5, 1, 'VENTA DE PRODUCTO', 20.00, 'EGRESO', NULL, 10, 87, 20.00, NULL, 200.00, 1740.00, '2023-04-26', '2023-04-26 20:47:35', '2024-05-06 18:36:43'),
(12, NULL, 'INGRESO', 4, 1, 'INGRESO DE PRODUCTO', 20.00, 'INGRESO', 10, NULL, 97, 20.00, 200.00, NULL, 1940.00, '2023-04-27', '2023-04-27 18:59:01', '2024-05-06 18:36:43'),
(13, NULL, 'VENTA', 6, 1, 'VENTA DE PRODUCTO', 20.00, 'EGRESO', NULL, 1, 96, 20.00, NULL, 20.00, 1920.00, '2023-04-27', '2023-04-27 18:59:27', '2024-05-06 18:36:43'),
(15, NULL, 'VENTA', 8, 1, 'VENTA DE PRODUCTO', 20.00, 'EGRESO', NULL, 3, 93, 20.00, NULL, 60.00, 1860.00, '2023-04-27', '2023-04-27 19:00:50', '2024-05-06 19:02:06'),
(16, NULL, 'INGRESO', 5, 7, 'VALOR INICIAL', 12.00, 'INGRESO', 90, NULL, 90, 12.00, 1080.00, NULL, 1080.00, '2023-04-28', '2023-04-28 15:42:04', '2023-04-28 15:42:04'),
(17, NULL, 'VENTA', 9, 7, 'VENTA DE PRODUCTO', 12.00, 'EGRESO', NULL, 4, 86, 12.00, NULL, 48.00, 1032.00, '2023-04-28', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(18, NULL, 'VENTA', 10, 2, 'VENTA DE PRODUCTO', 35.00, 'EGRESO', NULL, 1, 99, 35.00, NULL, 35.00, 3465.00, '2023-04-28', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(19, NULL, 'VENTA', 11, 3, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 69, 100.00, NULL, 100.00, 6900.00, '2023-04-28', '2023-04-28 21:11:48', '2023-04-28 21:11:48'),
(31, NULL, 'VENTA', 23, 7, 'VENTA DE PRODUCTO', 12.00, 'EGRESO', NULL, 1, 85, 12.00, NULL, 12.00, 1020.00, '2024-04-27', '2024-04-27 19:40:42', '2024-04-27 19:40:42'),
(32, NULL, 'VENTA', 24, 3, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 2, 67, 100.00, NULL, 200.00, 6700.00, '2024-04-27', '2024-04-27 19:40:42', '2024-04-27 19:40:42'),
(33, NULL, 'VENTA', 25, 7, 'VENTA DE PRODUCTO', 12.00, 'EGRESO', NULL, 1, 84, 12.00, NULL, 12.00, 1008.00, '2024-04-30', '2024-04-30 16:41:36', '2024-04-30 16:41:36'),
(34, NULL, 'VENTA', 26, 3, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 66, 100.00, NULL, 100.00, 6600.00, '2024-04-30', '2024-04-30 16:41:36', '2024-04-30 16:41:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2023_04_27_123517_create_fecha_stocks_table', 1),
(2, '2023_05_19_193721_create_categorias_table', 2),
(3, '2024_04_25_122801_create_envio_correos_table', 3),
(4, '2024_04_25_122820_create_api_maps_table', 4),
(5, '2024_04_25_151628_create_configuracion_pagos_table', 5),
(6, '2024_04_25_151629_create_orden_pedidos_table', 6),
(7, '2024_04_25_152115_create_orden_detalles_table', 7),
(8, '2024_04_27_130820_create_campanias_table', 8),
(9, '2024_04_27_131001_create_campania_automaticas_table', 9),
(10, '2024_04_27_131611_create_campania_detalles_table', 10),
(11, '2024_04_27_131620_create_campania_envios_table', 11),
(12, '2024_04_27_144424_create_envio_whatsapps_table', 12),
(13, '2024_04_28_101519_create_catalogos_table', 13),
(14, '2024_04_28_101708_create_catalogo_detalles_table', 14),
(15, '2024_04_28_104529_create_recuperacions_table', 15),
(16, '2024_04_30_120533_create_cupons_table', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_detalles`
--

CREATE TABLE `orden_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_pedido_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` double(8,2) NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `precio_total` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orden_detalles`
--

INSERT INTO `orden_detalles` (`id`, `orden_pedido_id`, `producto_id`, `cantidad`, `precio`, `precio_total`, `created_at`, `updated_at`) VALUES
(1, 1, 7, 1.00, 12.00, 12.00, '2024-04-27 19:27:40', '2024-04-27 19:27:40'),
(2, 1, 3, 2.00, 100.00, 200.00, '2024-04-27 19:27:40', '2024-04-27 19:27:40'),
(3, 2, 7, 1.00, 12.00, 12.00, '2024-04-30 16:28:52', '2024-04-30 16:28:52'),
(4, 2, 3, 1.00, 100.00, 100.00, '2024-04-30 16:28:52', '2024-04-30 16:28:52'),
(5, 3, 7, 1.00, 12.00, 12.00, '2024-04-30 16:39:49', '2024-04-30 16:39:49'),
(6, 3, 2, 2.00, 35.00, 70.00, '2024-04-30 16:39:49', '2024-04-30 16:39:49'),
(7, 4, 7, 1.00, 12.00, 12.00, '2024-05-06 20:10:05', '2024-05-06 20:10:05'),
(8, 5, 2, 2.00, 35.00, 70.00, '2024-05-07 18:12:07', '2024-05-07 18:12:07'),
(9, 5, 7, 2.00, 12.00, 24.00, '2024-05-07 18:12:07', '2024-05-07 18:12:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_pedidos`
--

CREATE TABLE `orden_pedidos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro` bigint NOT NULL,
  `configuracion_pago_id` bigint UNSIGNED NOT NULL,
  `celular` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comprobante` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `entrega` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cupon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descuento` double(8,2) DEFAULT NULL,
  `total_final` decimal(24,2) NOT NULL,
  `estado` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orden_pedidos`
--

INSERT INTO `orden_pedidos` (`id`, `codigo`, `nro`, `configuracion_pago_id`, `celular`, `comprobante`, `lat`, `lng`, `total`, `entrega`, `cupon`, `descuento`, `total_final`, `estado`, `user_id`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'ORD.1', 1, 1, '73594451', '1714246060_1.pdf', '-16.496059', '-68.133345', 212.00, 'TIENDA', NULL, 0.00, 212.00, 'ORDEN PROCESADA', 10, '2024-04-27', 1, '2024-04-27 19:27:40', '2024-04-27 19:40:42'),
(2, 'ORD.2', 2, 1, '666666666', '1714494532_2.pdf', '-16.496059', '-68.133345', 112.00, 'DOMICILIO', 'C001', 6.00, 105.28, 'ORDEN PROCESADA', 10, '2024-04-30', 1, '2024-04-30 16:28:52', '2024-04-30 16:41:36'),
(3, 'ORD.3', 3, 2, '67676767', '1714495189_3.pdf', '-16.498088388840433', '-68.13366216194534', 82.00, 'TIENDA', 'C001', 6.00, 77.08, 'PEDIDO PENDIENTE', 11, '2024-04-30', 1, '2024-04-30 16:39:49', '2024-04-30 16:39:49'),
(4, 'ORD.4', 4, 1, '', '1715026205_4.pdf', '-16.496059', '-68.133345', 12.00, 'TIENDA', '', 0.00, 12.00, 'PEDIDO PENDIENTE', 15, '2024-05-06', 0, '2024-05-06 20:10:05', '2024-05-06 20:26:44'),
(5, 'ORD.5', 5, 1, '', '1715105527_5.pdf', '-16.4969333667204', '-68.13183491643645', 94.00, 'DOMICILIO', 'C001', 5.00, 89.30, 'PEDIDO PENDIENTE', 10, '2024-05-07', 1, '2024-05-07 18:12:07', '2024-05-07 18:12:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo_almacen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_producto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `precio` decimal(24,2) NOT NULL,
  `stock_min` double NOT NULL,
  `stock_actual` double NOT NULL,
  `imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo_almacen`, `codigo_producto`, `nombre`, `descripcion`, `precio`, `stock_min`, `stock_actual`, `imagen`, `categoria_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'A001', 'P001', 'PASTILLAS A', '', 20.00, 10, 93, '', 3, '2023-04-24', '2023-04-24 21:36:20', '2024-05-06 19:02:06'),
(2, 'A001', 'P002', 'GEL ANTIBACTERIAL', '', 35.00, 5, 99, NULL, 1, '2023-04-24', '2023-04-24 21:44:24', '2023-04-28 19:53:34'),
(3, 'A001', 'P003', 'PRODUCTO 3', '', 100.00, 10, 66, NULL, 1, '2023-04-24', '2023-04-24 21:45:17', '2024-04-30 16:41:36'),
(7, 'A00111', 'P004', 'PRODUCTO 4', '', 12.00, 12, 84, '1682696496_7.jpg', 1, '2023-04-24', '2023-04-24 21:47:54', '2024-04-30 16:41:36'),
(10, 'A002222', 'P0044', 'PRODUCTO NUEVO P0044', 'DESC', 99.00, 10, 0, '', 3, '2023-05-19', '2023-05-19 23:55:04', '2023-05-19 23:55:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedors`
--

CREATE TABLE `proveedors` (
  `id` bigint UNSIGNED NOT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_contacto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedors`
--

INSERT INTO `proveedors` (`id`, `razon_social`, `nit`, `dir`, `fono`, `nombre_contacto`, `paterno`, `materno`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'PEPE S.A.', '333312312312', '', '777777', 'JOSE', 'PERES', 'MAMANI', '', '2023-04-24', '2023-04-24 21:09:13', '2024-05-06 18:43:58'),
(2, 'PROVEEDOR SRL', '34343', '', '2222', '', NULL, NULL, '', '2023-04-28', '2023-04-28 15:22:08', '2023-04-28 15:22:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recuperacions`
--

CREATE TABLE `recuperacions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `recuperado` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `recuperacions`
--

INSERT INTO `recuperacions` (`id`, `user_id`, `recuperado`, `created_at`, `updated_at`) VALUES
(1, 10, 1, '2024-04-28 14:55:50', '2024-04-28 15:07:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida_productos`
--

CREATE TABLE `salida_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `fecha_salida` date NOT NULL,
  `tipo_salida_id` bigint UNSIGNED NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `salida_productos`
--

INSERT INTO `salida_productos` (`id`, `producto_id`, `cantidad`, `fecha_salida`, `tipo_salida_id`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(3, 1, 3, '2023-04-25', 1, '', '2023-04-25', '2023-04-25 19:47:12', '2023-04-26 20:46:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_ingresos`
--

CREATE TABLE `tipo_ingresos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_ingresos`
--

INSERT INTO `tipo_ingresos` (`id`, `nombre`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'INGRESO TIPO 1', '', '2023-04-17 15:04:22', '2023-04-17 15:04:30'),
(2, 'TIPO INGRESO 2', '', '2023-04-25 14:37:56', '2023-04-25 14:38:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_salidas`
--

CREATE TABLE `tipo_salidas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_salidas`
--

INSERT INTO `tipo_salidas` (`id`, `nombre`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'SALIDA 1', '', '2023-04-25 14:38:16', '2023-04-25 14:38:16'),
(2, 'TIPO DE SALIDA 2', '', '2023-04-25 14:38:21', '2023-04-25 14:38:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('ADMINISTRADOR','GERENCIA','SUPERVISOR','VENDEDOR','CLIENTE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '', '', '', NULL, '', 'ADMINISTRADOR', NULL, '$2y$10$RrCZZySOwPej2gMFWsrjMe6dLzfaL5Q88h4J75I1FesEBRNPwq1x.', 1, '2023-01-11', NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1234', 'LP', 'LOS OLIVOS', '', '777777', 'SUPERVISOR', 'default.png', '$2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS', 1, '2023-04-24', '2023-04-24 20:23:30', '2023-04-28 21:12:44'),
(3, 'pedro@gmail.com', 'PEDRO MARTINEZ', NULL, NULL, '231231', 'LP', 'LOS OLIVOS', 'pedro@gmail.com', '', 'CLIENTE', NULL, '$2y$10$7n65zh2iGSJOPqlYbx8n5eG7/o7xUDIAfrne7ywoe4VTt5wv9KwRy', 1, '2024-04-25', '2024-04-25 16:12:18', '2024-04-29 16:17:22'),
(7, 'maria@gmail.com', 'MARIA GONZALES CASAS', NULL, NULL, '1231231', 'CB', 'LOS OLIVOS', 'maria@gmail.com', '666666; 7777777', 'CLIENTE', NULL, '$2y$10$VqF1FkJs6TSBBG4QaDoYoOKxKxC6dG7yGIJPdNrG5APEJ01jtMSja', 1, '2024-04-25', '2024-04-25 16:19:01', '2024-04-29 16:17:17'),
(9, 'pablo@gmail.com', 'PABLO SANCHEZ', NULL, NULL, '3223423', 'LP', '', 'pablo@gmail.com', '', 'CLIENTE', NULL, '$2y$10$JsubxYFiltQvLc9IWt5jlOyJMe.Cqfgg.zwwQwuRWHjc9LDEI1BWa', 1, '2024-04-25', '2024-04-25 16:20:39', '2024-04-29 16:17:12'),
(10, 'marcos@gmail.com', 'MARCOS MAMANI', NULL, NULL, '434334', 'LP', 'LOS OLIVOS', 'victorgonzalo.as@gmail.com', '77777777', 'CLIENTE', NULL, '$2y$10$pE1D7.CBmB4.vhYzmXSInev5QIavUIR.r3FH2DStqf8fu2Nbj1Pj.', 1, '2024-04-26', '2024-04-26 16:17:30', '2024-04-28 15:08:21'),
(11, 'sara@gmail.com', 'SARA GONZALES', NULL, NULL, '32233', 'LP', 'LOS OLIVOS', 'sara@gmail.com', '', 'CLIENTE', NULL, '$2y$10$pKtBP1v.6mPUAKK29yChsOVFZ4KZqvdJdYlpFCz7W0dFgn1xemrJ2', 1, '2024-04-30', '2024-04-30 16:38:31', '2024-04-30 16:38:31'),
(12, 'martin@gmail.com', 'MARTIN', NULL, NULL, '543543543', 'CB', 'LOS OLIVOS', 'martin@gmail.com', '', 'CLIENTE', NULL, '$2y$10$CSWAbZ.PIkqZMtF6CstM9uSNenajGLEMHgLel10UTPBEqPhmWE6ze', 1, '2024-05-06', '2024-05-06 17:44:07', '2024-05-06 17:44:07'),
(13, 'marisol@gmail.com', 'MARISOL', NULL, NULL, '43343434', 'SC', '', 'marisol@gmail.com', '', 'CLIENTE', NULL, '$2y$10$Y3hXkWECiArmANPC3vItJe6atLiAHEBWgD2FkfAxvFVX/xfvw0mRu', 0, '2024-05-06', '2024-05-06 17:44:47', '2024-05-06 17:44:47'),
(14, 'a', 'MARITZA', NULL, NULL, '4334343', 'SC', 'A', 'a', '', 'CLIENTE', NULL, '$2y$10$GngeMKbI.3Nda8kfOtWoiuKejhRPcW3qFpZNWllJcsiSIJsgqbpYS', 1, '2024-05-06', '2024-05-06 17:49:50', '2024-05-06 17:49:50'),
(15, 'ALVARO@GMAIL.COM', 'ALVARO', 'CARDENAS', NULL, '343434', 'SC', 'LOS OLIVOS', 'ALVARO@GMAIL.COM', '', 'CLIENTE', NULL, '$2y$10$yu2bVe673t3j82.Jwo0FbelyIIQ6w8q.rw47GcgvQihCqYS.U1i7e', 1, '2024-05-06', '2024-05-06 17:57:03', '2024-05-06 20:13:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `nit` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `descuento` double(8,2) NOT NULL,
  `total_final` decimal(24,2) NOT NULL,
  `estado` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orden_pedido_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `user_id`, `cliente_id`, `nit`, `total`, `descuento`, `total_final`, `estado`, `tipo`, `orden_pedido_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(3, 1, 1, '231231', 200.00, 0.00, 80.00, 'CANCELADO', 'FISICO', NULL, '2023-04-26', '2023-04-26 20:29:21', '2023-04-26 20:47:35'),
(5, 1, 1, '231231', 20.00, 0.00, 20.00, 'CANCELADO', 'FISICO', NULL, '2023-04-27', '2023-04-27 18:59:27', '2023-04-27 18:59:27'),
(6, 1, 6, '43434', 60.00, 0.00, 120.00, 'CANCELADO', 'FISICO', NULL, '2023-04-27', '2023-04-27 19:00:19', '2024-05-06 19:02:06'),
(7, 1, 2, '1231231', 83.00, 0.00, 83.00, 'CANCELADO', 'FISICO', NULL, '2023-04-28', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(8, 2, 2, '1231231', 100.00, 0.00, 100.00, 'CANCELADO', 'FISICO', NULL, '2023-04-28', '2023-04-28 21:11:48', '2023-04-28 21:11:48'),
(15, 1, 7, '8888888888', 212.00, 0.00, 212.00, 'CANCELADO', 'ECOMMERCE', 1, '2024-04-27', '2024-04-27 19:40:42', '2024-04-27 19:40:42'),
(16, 1, 7, '8888888888', 112.00, 6.00, 105.28, 'CANCELADO', 'ECOMMERCE', 2, '2024-04-30', '2024-04-30 16:41:36', '2024-04-30 16:41:36');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `api_maps`
--
ALTER TABLE `api_maps`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `campanias`
--
ALTER TABLE `campanias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `campania_automaticas`
--
ALTER TABLE `campania_automaticas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `campania_detalles`
--
ALTER TABLE `campania_detalles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `campania_envios`
--
ALTER TABLE `campania_envios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `catalogos`
--
ALTER TABLE `catalogos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `catalogo_detalles`
--
ALTER TABLE `catalogo_detalles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracion_pagos`
--
ALTER TABLE `configuracion_pagos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cupons`
--
ALTER TABLE `cupons`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ordens_orden_id_foreign` (`venta_id`),
  ADD KEY `detalle_ordens_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `envio_correos`
--
ALTER TABLE `envio_correos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `envio_whatsapps`
--
ALTER TABLE `envio_whatsapps`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fecha_stocks_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingreso_productos_producto_id_foreign` (`producto_id`),
  ADD KEY `ingreso_productos_proveedor_id_foreign` (`proveedor_id`),
  ADD KEY `ingreso_productos_tipo_ingreso_id_foreign` (`tipo_ingreso_id`);

--
-- Indices de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kardex_productos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `orden_detalles`
--
ALTER TABLE `orden_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orden_detalles_orden_pedido_id_foreign` (`orden_pedido_id`),
  ADD KEY `orden_detalles_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `orden_pedidos`
--
ALTER TABLE `orden_pedidos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orden_pedidos_codigo_unique` (`codigo`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proveedors`
--
ALTER TABLE `proveedors`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recuperacions`
--
ALTER TABLE `recuperacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salida_productos_producto_id_foreign` (`producto_id`),
  ADD KEY `salida_productos_tipo_salida_id_foreign` (`tipo_salida_id`);

--
-- Indices de la tabla `tipo_ingresos`
--
ALTER TABLE `tipo_ingresos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_salidas`
--
ALTER TABLE `tipo_salidas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orden_ventas_cliente_id_foreign` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `api_maps`
--
ALTER TABLE `api_maps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `campanias`
--
ALTER TABLE `campanias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `campania_automaticas`
--
ALTER TABLE `campania_automaticas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `campania_detalles`
--
ALTER TABLE `campania_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `campania_envios`
--
ALTER TABLE `campania_envios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `catalogos`
--
ALTER TABLE `catalogos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `catalogo_detalles`
--
ALTER TABLE `catalogo_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `configuracion_pagos`
--
ALTER TABLE `configuracion_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cupons`
--
ALTER TABLE `cupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `envio_correos`
--
ALTER TABLE `envio_correos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `envio_whatsapps`
--
ALTER TABLE `envio_whatsapps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `orden_detalles`
--
ALTER TABLE `orden_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `orden_pedidos`
--
ALTER TABLE `orden_pedidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `proveedors`
--
ALTER TABLE `proveedors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `recuperacions`
--
ALTER TABLE `recuperacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_ingresos`
--
ALTER TABLE `tipo_ingresos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_salidas`
--
ALTER TABLE `tipo_salidas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  ADD CONSTRAINT `fecha_stocks_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `orden_detalles`
--
ALTER TABLE `orden_detalles`
  ADD CONSTRAINT `orden_detalles_orden_pedido_id_foreign` FOREIGN KEY (`orden_pedido_id`) REFERENCES `orden_pedidos` (`id`),
  ADD CONSTRAINT `orden_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
