-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Сен 18 2023 г., 12:57
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `accreditation`
--

-- --------------------------------------------------------

--
-- Структура таблицы `spr_type_organization`
--

CREATE TABLE `spr_type_organization` (
  `id_type` int NOT NULL,
  `type_name` text COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Дамп данных таблицы `spr_type_organization`
--

INSERT INTO `spr_type_organization` (`id_type`, `type_name`) VALUES
(1, 'НПЦ (научно-практический центр)'),
(2, 'Центр'),
(3, 'Детский центр'),
(4, 'Диспансер'),
(5, 'Больница'),
(6, 'Детская Больница'),
(7, 'Поликлиника'),
(8, 'Лечебно-консультативная поликлиника'),
(9, 'Детская поликлиника'),
(10, 'Родильный дом'),
(11, 'Женская консультация'),
(12, 'Стоматологическая клиника'),
(13, 'Стоматологическая поликлиника'),
(14, 'Детская стоматологическая поликлиника'),
(15, 'Дом ребенка'),
(16, 'Госпиталь'),
(18, 'КУП (Коммунальное унитраное предприятие)'),
(19, 'Служба гражданской авиации'),
(20, 'Станция переливания крови'),
(21, 'ССМП (станция скорой мед помощи)'),
(22, 'Университетская клиника'),
(23, 'Участковая больница'),
(24, 'Больница паллиативного ухода'),
(25, 'ОАО (Открытое акционерное общество)');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
