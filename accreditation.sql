-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 07 2023 г., 12:10
-- Версия сервера: 8.0.30
-- Версия PHP: 8.0.22

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

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`%` PROCEDURE `count_mark_cursor` (IN `id_app` INTEGER)   BEGIN

DECLARE is_done integer default 0;
DECLARE id_sub_temp integer default 0;

DECLARE mark_cursor CURSOR FOR
SELECT id_subvision from subvision where id_application=id_app;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done = 1;
OPEN mark_cursor;

get_Sub: LOOP
FETCH mark_cursor INTO id_sub_temp;
IF is_done = 1 THEN 
LEAVE get_Sub;
END IF;

INSERT INTO report_mark(id_subvision, id_application) VALUES(id_sub_temp, id_app);

END LOOP get_Sub;
CLOSE mark_cursor;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `cursor_for_subvision` (IN `id_app` INT)   BEGIN

DECLARE is_done integer default 0;
DECLARE id_sub_temp integer default 0;

DECLARE mark_cursor CURSOR FOR
SELECT id_subvision from subvision where id_application=id_app;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done = 1;
OPEN mark_cursor;

get_Sub: LOOP
FETCH mark_cursor INTO id_sub_temp;
IF is_done = 1 THEN 
LEAVE get_Sub;
END IF;


CREATE TEMPORARY table temp_mark_sub (id_sub int, mark_class int, id_criteria int, id_mark int, field4 int);

insert into temp_mark_sub (id_sub , mark_class , id_criteria , id_mark , field4)
SELECT sub.id_subvision, m.mark_class, m.id_criteria, m.id_mark, mr.field4
FROM `subvision` sub
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision
left outer join mark m on mr.id_mark=m.id_mark
WHERE sub.id_subvision= id_sub_temp;


set @all_mark = (select count(*)
from temp_mark_sub);


set @all_mark_3 = ( select count(*)
from temp_mark_sub
where field4 =3);

set  @all_mark_1 =( select count(*)
from temp_mark_sub
where field4 =1);

set @otmetka_all =  (@all_mark_1/(@all_mark-@all_mark_3))*100;





set @all_mark_class_1 = (select  count(*)
from temp_mark_sub
where mark_class=1);


set @all_mark_3_class_1=(select count(*)
from temp_mark_sub
where field4 =3 and  mark_class=1);

set @all_mark_1_class_1 =(select  count(*)
from temp_mark_sub
where field4 =1 and  mark_class=1);

set @otmetka_all_class_1 = (@all_mark_1_class_1/(@all_mark_class_1-@all_mark_3_class_1))*100;


set @all_mark_class_2 = (select  count(*)
from temp_mark_sub
where mark_class=2);


set @all_mark_3_class_2 = (select count(*)
from temp_mark_sub
where field4 =3 and  mark_class=2);

set @all_mark_1_class_2 = (select count(*) 
from temp_mark_sub
where field4 =1 and  mark_class=2);

set @otmetka_all_class_2 = (@all_mark_1_class_2/(@all_mark_class_2-@all_mark_3_class_2))*100;

set @all_mark_class_3 = (select count(*)
from temp_mark_sub
where mark_class=3);


set @all_mark_3_class_3 =(select  count(*)
from temp_mark_sub
where field4 =3 and  mark_class=3);

set @all_mark_1_class_3= (select  count(*)
from temp_mark_sub
where field4 =1 and  mark_class=3);

set @otmetka_all_class_3 = (@all_mark_1_class_3/(@all_mark_class_3-@all_mark_3_class_3))*100;

INSERT INTO report_subvision_mark(id_application, id_subvision, otmetka_all, otmetka_class_1, otmetka_class_2, otmetka_class_3) 
VALUES(id_app, id_sub_temp, @otmetka_all, @otmetka_all_class_1, @otmetka_all_class_2, @otmetka_all_class_3);

DROP TEMPORARY TABLE temp_mark_sub;

END LOOP get_Sub;
CLOSE mark_cursor;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `applications`
--

CREATE TABLE `applications` (
  `id_application` int NOT NULL,
  `naim` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sokr_naim` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `unp` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ur_adress` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tel` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rukovoditel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `predstavitel` text COLLATE utf8mb4_general_ci,
  `soprovod_pismo` text COLLATE utf8mb4_general_ci,
  `copy_rasp` text COLLATE utf8mb4_general_ci,
  `org_structure` text COLLATE utf8mb4_general_ci,
  `id_user` int NOT NULL,
  `id_status` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `applications`
--

INSERT INTO `applications` (`id_application`, `naim`, `sokr_naim`, `unp`, `ur_adress`, `tel`, `email`, `rukovoditel`, `predstavitel`, `soprovod_pismo`, `copy_rasp`, `org_structure`, `id_user`, `id_status`) VALUES
(35, '1', '2', '3', '4', '5', '6', '7', '81', 'Пояснение.docx', 'Столинский район_26-06-2023_12-23-40.xlsx', NULL, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `cells`
--

CREATE TABLE `cells` (
  `id_cell` int NOT NULL,
  `id_criteria` int NOT NULL,
  `id_column` int NOT NULL,
  `cell` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_application` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `columns`
--

CREATE TABLE `columns` (
  `id_column` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `conditions`
--

CREATE TABLE `conditions` (
  `conditions_id` int NOT NULL,
  `conditions` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `conditions`
--

INSERT INTO `conditions` (`conditions_id`, `conditions`) VALUES
(1, 'Амбулаторная'),
(2, 'Стационарная');

-- --------------------------------------------------------

--
-- Структура таблицы `criteria`
--

CREATE TABLE `criteria` (
  `id_criteria` int NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `type_criteria` int NOT NULL COMMENT '1 - общий 2 - по видам оказания 3 - вспомогательные подразделения',
  `conditions_id` int DEFAULT NULL COMMENT '1-амбулаторно 2 - стационарно'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `criteria`
--

INSERT INTO `criteria` (`id_criteria`, `name`, `type_criteria`, `conditions_id`) VALUES
(3, 'Фельдшерско-акушерский пункт', 1, 1),
(4, 'Врачебная амбулатория общей практики', 1, 1),
(5, 'Городская поликлиника (Районная поликлиника)', 1, 1),
(6, 'Больница сестринского ухода', 1, 2),
(7, 'Участковая больница', 1, 2),
(8, 'Центральная районная больница', 1, 2),
(9, 'Хирургия', 2, 1),
(10, 'Хирургия', 2, 2),
(11, 'Анестезиология и реаниматология', 2, 1),
(12, 'Анестезиология и реаниматология', 2, 2),
(13, 'Акушерство и гинекология', 2, 1),
(14, 'Акушерство и гинекология', 2, 2),
(15, 'Травматология', 2, 1),
(16, 'Травматология', 2, 2),
(17, 'Кардиология', 2, 1),
(18, 'Кардиология', 2, 2),
(19, 'Лабораторная диагностика', 3, 1),
(20, 'Лабораторная диагностика', 3, 2),
(21, 'Рентгенодиагностика', 3, 1),
(22, 'Рентгенодиагностика', 3, 2),
(23, 'Компьютерная диагностика', 3, 1),
(24, 'Компьютерная диагностика', 3, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `mark`
--

CREATE TABLE `mark` (
  `id_mark` int NOT NULL,
  `mark_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `mark_class` int NOT NULL,
  `id_criteria` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `mark`
--

INSERT INTO `mark` (`id_mark`, `mark_name`, `mark_class`, `id_criteria`) VALUES
(1, 'В учреждении здравоохранения определены ответственные лица за  организацию оказания медицинской помощи, в том числе  специализированной	3					', 1, 3),
(2, 'В  учреждении  здравоохранения положения о структурных подразделениях соответствуют деятельности подразделений, их структуре. Деятельность структурных подразделений осуществляется в соответствии с положениями', 2, 3),
(3, 'Проведение анализа деятельности учреждения здравоохранения по достигнутым результатам, ежеквартальное рассмотрение на медицинских советах, производственных совещаниях, принятие мер по устранению недостатков', 1, 3),
(4, 'Организация и осуществление контроля за выполнением доведенных объемных показателей деятельности учреждения здравоохранения (региональный комплекс мероприятий)', 2, 3),
(5, 'Организация и осуществление контроля за выполнением  управленческих решений по  улучшению качества медицинской помощи в учреждении здравоохранения за  последний отчетный период или год, анализ  выполнения решений', 3, 3),
(6, 'критерий 1', 1, 4),
(7, 'критерий 2', 1, 4),
(8, 'критерий 3', 2, 4),
(9, 'критерий 4', 2, 4),
(10, 'критерий 5', 3, 4),
(11, 'критерий 6', 3, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `mark_rating`
--

CREATE TABLE `mark_rating` (
  `id_mark_rating` int NOT NULL,
  `id_mark` int NOT NULL,
  `field4` int DEFAULT NULL COMMENT '1 - да 2 - нет 3 - не требуется',
  `field5` text COLLATE utf8mb4_general_ci,
  `field6` text COLLATE utf8mb4_general_ci,
  `field7` int DEFAULT NULL COMMENT '1 - да 2 - нет 3 - не требуется',
  `field8` text COLLATE utf8mb4_general_ci,
  `id_subvision` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `mark_rating`
--

INSERT INTO `mark_rating` (`id_mark_rating`, `id_mark`, `field4`, `field5`, `field6`, `field7`, `field8`, `id_subvision`) VALUES
(1, 1, 1, 'hfhgfh121', '556667789e', NULL, NULL, 6),
(2, 2, 1, '1e', 'fff', NULL, NULL, 6),
(3, 3, 1, '2', 'asdfasdf', NULL, NULL, 6),
(4, 4, 1, 'g', 'erty', NULL, NULL, 6),
(5, 5, 1, '1112', '1', NULL, NULL, 6),
(6, 6, 0, 'r1', 'r', NULL, NULL, 6),
(7, 7, 0, 'r', 'f', NULL, NULL, 6),
(8, 8, 0, 'r', '551', NULL, NULL, 6),
(9, 9, 0, '0', '', NULL, NULL, 6),
(10, 10, 0, '11', '11', NULL, NULL, 6),
(11, 11, 0, 'r', '', NULL, NULL, 6),
(22, 1, 3, '1', '1', NULL, NULL, 49),
(23, 2, 2, '2', '12', NULL, NULL, 49),
(24, 3, 1, '5', '', NULL, NULL, 49),
(25, 4, 0, '', '', NULL, NULL, 49),
(26, 5, 0, '', '', NULL, NULL, 49),
(27, 6, 0, '2', '2', NULL, NULL, 49),
(28, 7, 0, '0', '0', NULL, NULL, 49),
(29, 8, 0, '4', '4', NULL, NULL, 49),
(30, 9, 0, '3', '3', NULL, NULL, 49),
(31, 10, 0, '', '', NULL, NULL, 49),
(32, 11, 0, '', '', NULL, NULL, 49);

-- --------------------------------------------------------

--
-- Структура таблицы `rating_criteria`
--

CREATE TABLE `rating_criteria` (
  `id_rating_criteria` int NOT NULL,
  `id_subvision` int NOT NULL,
  `id_criteria` int NOT NULL,
  `value` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `rating_criteria`
--

INSERT INTO `rating_criteria` (`id_rating_criteria`, `id_subvision`, `id_criteria`, `value`) VALUES
(95, 6, 3, 1),
(96, 6, 4, 1),
(97, 6, 5, 1),
(98, 6, 24, 1),
(102, 49, 3, 1),
(103, 49, 5, 1),
(104, 49, 11, 1),
(105, 49, 20, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `report_mark`
--

CREATE TABLE `report_mark` (
  `id_subvision` int NOT NULL,
  `id_application` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `report_mark`
--

INSERT INTO `report_mark` (`id_subvision`, `id_application`) VALUES
(6, 35),
(49, 35);

-- --------------------------------------------------------

--
-- Структура таблицы `report_subvision_mark`
--

CREATE TABLE `report_subvision_mark` (
  `id_application` int NOT NULL,
  `id_subvision` int NOT NULL,
  `otmetka_all` int NOT NULL,
  `otmetka_class_1` int NOT NULL,
  `otmetka_class_2` int NOT NULL,
  `otmetka_class_3` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `report_subvision_mark`
--

INSERT INTO `report_subvision_mark` (`id_application`, `id_subvision`, `otmetka_all`, `otmetka_class_1`, `otmetka_class_2`, `otmetka_class_3`) VALUES
(35, 6, 45, 50, 50, 33),
(35, 49, 10, 33, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id_role` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id_role`, `name`) VALUES
(1, 'Администратор'),
(2, 'Аккредитатор'),
(3, 'Пользователь');

-- --------------------------------------------------------

--
-- Структура таблицы `status`
--

CREATE TABLE `status` (
  `id_status` int NOT NULL,
  `name_status` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `status`
--

INSERT INTO `status` (`id_status`, `name_status`) VALUES
(1, 'создано'),
(2, 'новое'),
(3, 'проверяется'),
(4, 'проверено'),
(5, 'отклонено');

-- --------------------------------------------------------

--
-- Структура таблицы `subvision`
--

CREATE TABLE `subvision` (
  `id_subvision` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_application` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `subvision`
--

INSERT INTO `subvision` (`id_subvision`, `name`, `id_application`) VALUES
(6, '36gp', 35),
(49, 'qwe', 35);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id_user` int NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `login` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_role` int NOT NULL,
  `online` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_act` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_time_online` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_page` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id_user`, `username`, `login`, `password`, `id_role`, `online`, `last_act`, `last_time_online`, `last_page`) VALUES
(1, 'Аккредитация', 'accred@mail.ru', '6534cb7340066e972846eaf508de6224', 2, 'cgj0s63tdridqq0sb73k6cn340nvooho', 'cgj0s63tdridqq0sb73k6cn340nvooho', '2023-06-28 15:48:28', '/index.php?users'),
(2, '36gp', '36gp@mail.ru', 'ba258829bb23dce283867bb2f8b78d7f', 3, 'v7f49fc47e1ml0ecn4a3g6pgveqiobr4', 'v7f49fc47e1ml0ecn4a3g6pgveqiobr4', '2023-07-07 12:04:07', '/index.php?application'),
(3, 'Брестская городская поликлиника №1', 'brestgp1', 'ddd415ac66e91cf20c63792ffe88eb70', 3, NULL, NULL, NULL, NULL),
(4, 'Брестская городская поликлиника №2', 'brestgp2', '8bc25d7d934f31bca3a27442355caade', 3, NULL, NULL, NULL, NULL),
(5, 'Брестская городская поликлиника №3', 'brestgp3', 'dab4e30dcda1b14af1e11730e7597579', 3, NULL, NULL, NULL, NULL),
(6, 'Брестская городская поликлиника №5', 'brestgp5', '336e3f80e6a5d322384fffda3acf3493', 3, '0', '0ss8lrpf0cgljb62ptktlmibqncud4f8', '2023-06-21 16:14:17', '/index.php?logout'),
(7, 'Брестская городская поликлиника №6', 'brestgp6', 'c724f414397c5a9c719bfb0b63201032', 3, NULL, NULL, NULL, NULL),
(8, 'Брестская городская детская поликлиника №1', 'brestgdp1', '0fb809774404c914cdafda26f72cbd9c', 3, NULL, NULL, NULL, NULL),
(9, 'Бешенковичская центральная районная больница', 'beshcrb', 'e1bc2f88ab5562e1439bf60d25211f93', 3, NULL, NULL, NULL, NULL),
(10, 'Браславская центральная районная больница', 'braslcrb', 'bf186232d83e58890be306d60717d843', 3, NULL, NULL, NULL, NULL),
(11, 'Верхнедвинская центральная районная больница', 'verhcrb', '403ccfa28911929bde4e52485cb98b53', 3, NULL, NULL, NULL, NULL),
(12, 'Глубокская центральная районная больница', 'glybcrb', 'f3ff1be20a2b86abb56f73d32631eaab', 3, NULL, NULL, NULL, NULL),
(13, 'Городокская центральная районная больница', 'gorodcrb', '7cd53feb18eee6e8a138ec60982c3ce4', 3, NULL, NULL, NULL, NULL),
(14, 'Докшицкая центральная районная больница', 'dokcrb', '1a62538b0857b31bc75a778c7ac3358d', 3, NULL, NULL, NULL, NULL),
(15, 'Дубровенская центральная районная больница', 'dybcrb', 'c186cb708c45e863c714797a496d0cd6', 3, NULL, NULL, NULL, NULL),
(16, 'Лепельская центральная районная больница', 'lepcrb', '0245734f6adf781a9de274be8da2b969', 3, NULL, NULL, NULL, NULL),
(17, 'Лиозненская центральная районная больница', 'liozcrb', '43e35343bf1651d80079b2b39fc4406c', 3, NULL, NULL, NULL, NULL),
(18, 'Миорская центральная районная больница', 'miorcrb', 'ff294cc19bd38b979b07969cddb0312f', 3, NULL, NULL, NULL, NULL),
(19, 'Поставская центральная районная больница', 'postcrb', 'a5ec6b65fb4510d214b8a7132e691431', 3, NULL, NULL, NULL, NULL),
(20, 'Россонская центральная районная больница', 'roscrb', '064cb197795cd6b4bea5712f8971676a', 3, NULL, NULL, NULL, NULL),
(21, 'Сенненская центральная районная больница', 'senncrb', 'dd49b45fcf533467ae8e9a1f6d66aa56', 3, NULL, NULL, NULL, NULL),
(22, 'Толочинская центральная районная больница', 'tolochcrb', 'f8e610671d2fa15a7d1d2ba82c8811a1', 3, NULL, NULL, NULL, NULL),
(23, 'Ушачская центральная районная больница', 'yshachcrb', 'be2b9d92d96a58d02b3c25635956c4bd', 3, NULL, NULL, NULL, NULL),
(24, 'Новолукомльская центральная районная больница', 'novlykcrb', '70097c4f984055d2216dc5181258115c', 3, NULL, NULL, NULL, NULL),
(25, 'Шарковщинская центральная районная больница', 'sharkcrb', '46a85981b9dcfa630c5c3761f514e793', 3, NULL, NULL, NULL, NULL),
(26, 'Шумилинская центральная районная больница', 'shymcrb', '4bdd355b77e2c79518f948ad836bab3d', 3, NULL, NULL, NULL, NULL),
(27, 'Новополоцкая центральная городская больница', 'novopolcrb', 'fcb28017e0818defa1561021f78ed8d2', 3, NULL, NULL, NULL, NULL),
(28, 'Полоцкая центральная городская больница', 'polcrb', 'b94783aae60e04217a215186681c20a8', 3, NULL, NULL, NULL, NULL),
(29, 'Витебская областная клиническая больница', 'vitoblkb', '146cd0e39d24a5e66047eb3737aed046', 3, NULL, NULL, NULL, NULL),
(30, 'Витебский областной клинический специализированный центр', 'vitoblklin', '687a924c3e0c52609d30c895cf9115d3', 3, NULL, NULL, NULL, NULL),
(31, 'Витебский областной детский специализированный центр', 'vitobldetklin', '1b120db4189edd4b35c85fb7c73f84a5', 3, NULL, NULL, NULL, NULL),
(32, 'Витебский областной клинический центр дерматовенерологии и косметологии', 'vitoblcdk', '5cec8181dd3cd0d6c713784696a0972b', 3, NULL, NULL, NULL, NULL),
(33, 'Витебский областной клинический онкологический диспансер', 'vitoblkod', '7a60a486d1d251b590a61ad9b64cfd7e', 3, NULL, NULL, NULL, NULL),
(34, 'Витебский областной клинический центр пульмонологии и фтизиатрии', 'vitoblcpf', '62133d304bb6d38dac29e8832d49f097', 3, NULL, NULL, NULL, NULL),
(35, 'Витебская областная клиническая инфекционная больница', 'vitoblkib', 'b5a435188ada2a8851dc160ff82449f7', 3, NULL, NULL, NULL, NULL),
(36, 'Витебский областной клинический кардиологический центр', 'vitoblkkc', '0ed3a3e3955341333ad9f7ec8bd867e4', 3, NULL, NULL, NULL, NULL),
(37, 'Витебский областной клинический центр психиатрии и наркологии', 'vitoblkcpn', '08b8bd551ae3358ec635e479ae6f83fd', 3, NULL, NULL, NULL, NULL),
(38, 'Витебский областной клинический родильный дом', 'vitoblkrd', 'd2f53c6d5623a2077c52e6024d742e59', 3, NULL, NULL, NULL, NULL),
(39, 'Витебский городской клинический родильный дом №2', 'vitoblkrd2', 'b9b88531884ace07d9c27d6dabd1054d', 3, NULL, NULL, NULL, NULL),
(40, 'Витебский областной центр медицинской реабилитации для инвалидов и ветеранов боевых действий на территории других государств', 'vitoblcmridbd', '13d7c339af883ada411f286d644f6727', 3, NULL, NULL, NULL, NULL),
(41, 'Витебская городская клиническая больница №1', 'vitgkb1', '83ef936afc811a17ba8ae6fbd438226d', 3, NULL, NULL, NULL, NULL),
(42, 'Витебская городская клиническая больница скорой медицинской помощи', 'vitgkbsmp', '73fd8b2895f36dff590a23d6d2fdf872', 3, NULL, NULL, NULL, NULL),
(43, 'Витебский областной центр паллиативной медицинской помощи', 'vitoblcpmp', '4bde58af7703f1fe24860bbeed712843', 3, NULL, NULL, NULL, NULL),
(44, 'Областной детский реабилитационный оздоровительный центр «Ветразь»', 'vetrazod', 'd81cd1d728c6c27f0fa8f4f5dfc99921', 3, NULL, NULL, NULL, NULL),
(45, 'Полоцкая областная психиатрическая больница', 'polopb', '0ee7794db47b4cc3cc234f86f2d03eb3', 3, NULL, NULL, NULL, NULL),
(46, 'Лепельская областная психиатрическая больница', 'lepopb', 'ffccc296a790b92bf3712e6503ed3e36', 3, NULL, NULL, NULL, NULL),
(47, 'Областной госпиталь ИВОВ «Юрцево»', 'yurcevoog', 'c2e8d915ebe34bebf3a537197e9fc604', 3, NULL, NULL, NULL, NULL),
(48, 'Витебская центральная городская поликлиника', 'vitcgp', 'c87fe86209f0789dd0ef81aa5b57758a', 3, NULL, NULL, NULL, NULL),
(49, 'Оршанская центральная поликлиника', 'orshcp', '7ee0e3337806e5bd93ffb91526158165', 3, NULL, NULL, NULL, NULL),
(50, 'Оршанская городская стоматологическая поликлиника', 'orshgsp', '9b913d3e45cbdaff897b6c9f370c8dfa', 3, NULL, NULL, NULL, NULL),
(51, 'Витебский областной клинический стоматологический центр', 'vitobksc', '81349d9cf6bf362d961ede71a0a42caf', 3, NULL, NULL, NULL, NULL),
(52, 'Витебский областной клинический диагностический центр', 'vitokdc', '7c71982c64e1ae1087115c49208fb0ee', 3, NULL, NULL, NULL, NULL),
(53, 'Витебский областной эндокринологический диспансер', 'vitoed', '0f63c7a8ef31d0d9b232670bb45759be', 3, NULL, NULL, NULL, NULL),
(54, 'Брагинская центральная районная больница', 'bragcrb', '9de226275a9907927dd4edf772b5d988', 3, NULL, NULL, NULL, NULL),
(55, 'Буда-Кошелевская центральная районная больница', 'budkoshcrb', '241f315a37acf051f0433af0e007cc8f', 3, NULL, NULL, NULL, NULL),
(56, 'Ветковская центральная районная больница', 'vetcrb', '88336152ee912acc9e02b8c474a4d385', 3, NULL, NULL, NULL, NULL),
(57, 'Добрушская центральная районная больница', 'dobrcrd', 'c7e54637ff7d573933f1129f53deabca', 3, NULL, NULL, NULL, NULL),
(58, 'Ельская центральная районная больница', 'elcrb', 'c7e54637ff7d573933f1129f53deabca', 3, NULL, NULL, NULL, NULL),
(59, 'Житковичская центральная районная больница', 'zhitcrb', 'f7378eb29111b141ee77e70a29ac767a', 3, NULL, NULL, NULL, NULL),
(60, 'Жлобинская центральная районная больница', 'zhlocrb', '8ce967b00c03784aff5787ff3663e508', 3, NULL, NULL, NULL, NULL),
(61, 'Калинковичская центральная районная больница', 'kalinkcrb', '0d672a5b748a9682a2847c16cde60ae6', 3, NULL, NULL, NULL, NULL),
(62, 'Кормянская центральная районная больница', 'kormcrb', 'f3a45ad8de92cee0b25233f8edbae35f', 3, NULL, NULL, NULL, NULL),
(63, 'Лельчицкая центральная районная больница', 'lelchcrb', '271f377ff8dd8b6ab821d532a90fc8ad', 3, NULL, NULL, NULL, NULL),
(64, 'Лоевская центральная районная больница', 'loevcrb', '52e0172a09671db5b36ed1b247632a51', 3, NULL, NULL, NULL, NULL),
(65, 'Мозырский городской родильный дом', 'mozgrd', '4e56ed8004fec8cf31f3e5aa48a6eddf', 3, NULL, NULL, NULL, NULL),
(66, 'Мозырская городская детская больница', 'mozgdb', '84c26ee6f9f7cd8b33f7b2341c9f211d', 3, NULL, NULL, NULL, NULL),
(67, 'Мозырская городская больница', 'mozgb', '0ca21a650ac81626647a2b796755f64e', 3, NULL, NULL, NULL, NULL),
(68, 'Наровлянская центральная районная больница', 'narovlcrb', '5289c04cd9526c0058a102a70d77f45f', 3, NULL, NULL, NULL, NULL),
(69, 'Октябрьская центральная районная больница', 'oktcrb', 'e54c0270ff9edc0bbcc94de22ecf348c', 3, NULL, NULL, NULL, NULL),
(70, 'Петриковская центральная районная больница', 'petrcrb', '9beee53aa2492b20f99df2c762a504b1', 3, NULL, NULL, NULL, NULL),
(71, 'Речицкая центральная районная больница', 'rechcrb', 'd07a5bb5fca5018438713760409dddde', 3, NULL, NULL, NULL, NULL),
(72, 'Рогачевская центральная районная больница', 'rogcrb', '89b7e268451534a8ab900eb670e1307b', 3, NULL, NULL, NULL, NULL),
(73, 'Светлогорская центральная районная больница', 'svetlcrb', '21363eb5e758051e8de2c9fae7f154d3', 3, NULL, NULL, NULL, NULL),
(74, 'Хойникская центральная районная больница', 'hoincrb', 'b26ecf515d89360d9b761ca354fd9d35', 3, NULL, NULL, NULL, NULL),
(75, 'Чечерская центральная районная больница', 'chechercrb', '8ffee210aa0f1b723ce3082df6898048', 3, NULL, NULL, NULL, NULL),
(76, 'Гомельская областная клиническая больница', 'gomokb', '29d867b5638c83e84a1d8a0f79544ee1', 3, NULL, NULL, NULL, NULL),
(77, 'Гомельская областная  детская клиническая больница', 'gomodkb', '3c06c1a037c4bedc0088050f299317c3', 3, NULL, NULL, NULL, NULL),
(78, 'Университетская клиника - областной клинический Госпиталь ИОВ', 'yniverkokg', '52c1a14001b2fa3e936defdb0625a51f', 3, NULL, NULL, NULL, NULL),
(79, 'Гомельская областная туберкулезная клиническая больница', 'gomotkb', '0664e398747ba28fbb9083c3f332c58d', 3, NULL, NULL, NULL, NULL),
(80, 'Гомельская областная клиническая психиатрическая больница', 'gomokpb', 'b6b4cab295435ce24729f91714e3b23f', 3, NULL, NULL, NULL, NULL),
(81, 'Гомельский областной наркологический диспансер', 'gomond', '930af4de3996b17175dcb78eddfee5b1', 3, NULL, NULL, NULL, NULL),
(82, 'Гомельский областной клинический онкологический диспансер', 'gomokod', '2cef0da657f424bfebb3849efd0e89a5', 3, NULL, NULL, NULL, NULL),
(83, 'Гомельский областной клинический кожно-венерологический диспансер', 'gomokkvd', 'fc328b6afc8d9137c6a42fb82894c948', 3, NULL, NULL, NULL, NULL),
(84, 'Гомельский областной клинический кардиологический центр', 'gomokkc', 'fb60fbfaad20ee373615d7d61ec8c965', 3, NULL, NULL, NULL, NULL),
(85, 'Гомельская областная специализированная клиническая больница', 'gomoskb', 'ac68352db67443cee67579183b7a09ac', 3, NULL, NULL, NULL, NULL),
(86, 'Гомельская областная инфекционная клиническая больница', 'gomoikb', '2469186e66104fe0ddb09ceed39796a6', 3, NULL, NULL, NULL, NULL),
(87, 'Гомельский областной детский центр медицинской реабилитации «Верасок»', 'verasokodcmr', '26ee1267ac2d81305bfe8fc992e4d468', 3, NULL, NULL, NULL, NULL),
(88, 'Гомельская областная детская больница медицинской реабилитации «Живица»', 'zhivicaodbmr', '5ae2a95bdde58927cd6e59924a742441', 3, NULL, NULL, NULL, NULL),
(89, 'Гомельская городская клиническая больница №1', 'ggkb1', 'b8dfd62cf58e73260c5b1e234e13cf88', 3, NULL, NULL, NULL, NULL),
(90, 'Гомельская городская клиническая больница №2', 'ggkb2', '37ec5983e06d52a9ead3da6ee4e162d6', 3, NULL, NULL, NULL, NULL),
(91, 'Гомельская городская клиническая больница №3', 'ggkb3', '48b69ceab52f444028bcfccc93c35790', 3, NULL, NULL, NULL, NULL),
(92, 'Гомельская городская больница №4', 'ggb4', '78d243d40d574fd9cdeba204f2dcae92', 3, NULL, NULL, NULL, NULL),
(93, 'Больница скорой медицинской помощи', 'gombsmp', '6f8f2fe6397ef9f9215a04ac04184078', 3, NULL, NULL, NULL, NULL),
(94, 'Гомельская областная стоматологическая поликлиника', 'gomosp', '0919bdc127a8eb3da86cd94bc982367a', 3, NULL, NULL, NULL, NULL),
(95, 'Гомельский областной эндокринологический диспансер', 'gomoed', '85662eab542f47496f03419754870207', 3, NULL, NULL, NULL, NULL),
(96, 'Гомельский областной медико-генетический центр с консультацией «Брак и семья»', 'gomomgckbs', '203cfb04d7cd1c54c4b85cc0557581a0', 3, NULL, NULL, NULL, NULL),
(97, 'Гомельская областная клиническая поликлиника', 'gomokp', 'fa46ce4a5fec5c66a3599d36a779ddd4', 3, NULL, NULL, NULL, NULL),
(98, 'Гомельская центральная городская клиническая поликлиника', 'gomcgkp', '8a8f35aed306251a4a0e5f3425d326d4', 3, NULL, NULL, NULL, NULL),
(99, 'Гомельская городская клиническая поликлиника № 2', 'gomgkp2', '0691677773ba4d1ec8aefdb896017c07', 3, NULL, NULL, NULL, NULL),
(100, 'Гомельская городская клиническая поликлиника № 3', 'gomgkp3', '490bfea2d429766a5145953e99d125e8', 3, NULL, NULL, NULL, NULL),
(101, 'Гомельская городская клиническая поликлиника № 4', 'gomgkp4', '1693c3f3734d9d016039512f495326b3', 3, NULL, NULL, NULL, NULL),
(102, 'Гомельская городская клиническая поликлиника № 5 им. С.В. Голуховой', 'gomgkp5', 'be17e8734d31da1ccf36b598e01c7478', 3, NULL, NULL, NULL, NULL),
(103, 'Гомельская городская клиническая поликлиника № 6', 'gomgkp6', 'eaa6e8fec6220de57eae164f8b7c07b3', 3, NULL, NULL, NULL, NULL),
(104, 'Гомельская городская клиническая поликлиника № 8', 'gomgkp8', '7996b5ae76ded183a3db5a985e209d35', 3, NULL, NULL, NULL, NULL),
(105, 'Гомельская городская клиническая поликлиника № 9', 'gomgkp9', '2e1f0ebd3a963afd77efce78ec699a07', 3, NULL, NULL, NULL, NULL),
(106, 'Гомельская городская клиническая поликлиника № 10', 'gomgkp10', 'f3e2e3fa1dce833133867f225d15ea6c', 3, NULL, NULL, NULL, NULL),
(107, 'Гомельская городская клиническая поликлиника № 11', 'gomgkp11', '81f0dcd793db9f2b0b2fffb2584bc304', 3, NULL, NULL, NULL, NULL),
(108, 'Гомельская городская поликлиника №13', 'gomgp13', 'bae495cf230b4ca7c017de7977a82e64', 3, NULL, NULL, NULL, NULL),
(109, 'Гомельская городская клиническая поликлиника № 14', 'gomgkp14', '0122d770cc542cacb20b7293b245dc92', 3, '0vgff6u46s0sn13e96m5jtafjbelto6j', '0vgff6u46s0sn13e96m5jtafjbelto6j', '2023-06-23 16:42:49', '/index.php?application'),
(110, 'Гомельская городская поликлиника № 1', 'gomgp1', 'f4e7f83bd04cbcb3eff3d05119b974d4', 3, '0', 'ga4egbgb4e9g18ud6ak3oq8c2q5mkpjh', '2023-06-23 11:23:18', '/index.php?logout'),
(111, 'Поликлиника № 7', 'gomp7', 'd4ea3910789bf7de1c5c0907042f0254', 3, NULL, NULL, NULL, NULL),
(112, 'Гомельская центральная городская детская клиническая поликлиника', 'gomcgdkp', 'c34b63c78150c7eac48ec2620ae53a26', 3, NULL, NULL, NULL, NULL),
(113, 'Гомельская центральная городская стоматологическая поликлиника', 'gomcgsp', '4de0c63e1f0c0e98040b7ae2b25dfc75', 3, NULL, NULL, NULL, NULL),
(114, 'Мозырская центральная городская поликлиника', 'mozcgp', '62d97280f28e55d52ffa173c6e63da25', 3, NULL, NULL, NULL, NULL),
(115, 'Центр медицинской реабилитации для детей-инвалидов и молодых инвалидов с психоневрологическими заболеваниями «Радуга»', 'radugacmrdi', 'ee25f4b10557e264ae0c6cd4930460df', 3, '0', 'ga4egbgb4e9g18ud6ak3oq8c2q5mkpjh', '2023-06-23 11:23:41', '/index.php?logout'),
(116, 'Мозырская городская стоматологическая поликлиника', 'mozgsp', '9b8073512100f57a6136f2ef1d85b1b1', 3, NULL, NULL, NULL, NULL),
(117, 'Мозырская городская поликлиника №4', 'mozgp4', 'aa60a09bb93dc5b20cd68bbf6a05d72c', 3, NULL, NULL, NULL, NULL),
(118, 'Белыничская центральная районная больница', 'belincrb', 'd98beb62c8136ddb15fcb039d0094435', 3, NULL, NULL, NULL, NULL),
(119, 'Быховская центральная районная больница', 'bihovcrb', '2dcddc92c2f429dbcdaeaaf5918558b7', 3, NULL, NULL, NULL, NULL),
(120, 'Глусская центральная районная больница', 'glusscrb', '49ac3166fc1abcc2926d3e799a6a11cb', 3, NULL, NULL, NULL, NULL),
(121, 'Горецкая центральная районная больница', 'goreccrb', '4c7f7e68f06ba02e475ce9ae4702b3a7', 3, NULL, NULL, NULL, NULL),
(122, 'Дрибинская центральная районная больница', 'dribincrb', '7c0b274e6ecb2b97bb23d559d3805d7d', 3, NULL, NULL, NULL, NULL),
(123, 'Кировская центральная районная больница', 'kirovcrb', '08c76e848b9f9dc6abf60be006dc4024', 3, NULL, NULL, NULL, NULL),
(124, 'Климовичская центральная районная больница', 'klimovichcrb', 'a33ea18ea1b2784e148a5ebbf72c509c', 3, NULL, NULL, NULL, NULL),
(125, 'Кличевская центральная районная больница', 'klichevcrb', '93e19cc0c7605075eb0b8c739c08ebc3', 3, NULL, NULL, NULL, NULL),
(126, 'Костюковичская центральная районная больница', 'kostukovcrb', '3704c60d53abc0988b1d187650f0ff3c', 3, NULL, NULL, NULL, NULL),
(127, 'Краснопольская центральная районная больница', 'krasnopolcrb', 'a67a88d49a646679a7f9de64cb043668', 3, NULL, NULL, NULL, NULL),
(128, 'Кричевская центральная районная больница', 'krichevcrb', '8346958473175887d4675dbf89a5f8aa', 3, NULL, NULL, NULL, NULL),
(129, 'Круглянская центральная районная больница', 'kruglyancrb', 'fb7344836d0389c7815f7b2fe553c30e', 3, NULL, NULL, NULL, NULL),
(130, 'Мстиславская центральная районная больница', 'msticlavcrb', '10ad9237b2ecce48936351d56ec079f6', 3, NULL, NULL, NULL, NULL),
(131, 'Осиповичская центральная районная больница', 'osipcrb', '4c594dceae3cad87571f07c6c6ef237e', 3, NULL, NULL, NULL, NULL),
(132, 'Славгородская центральная районная больница', 'slavogorodcrb', 'd232950f2b7b12b7fc8368a8f8792ec1', 3, NULL, NULL, NULL, NULL),
(133, 'Хотимская центральная районная больница', 'hotimcrb', 'f81dc864af5f9f01f46f28d37402b82c', 3, NULL, NULL, NULL, NULL),
(134, 'Чаусская центральная районная больница', 'chausscrb', 'c40b7ceea1c02fa233df6a728caa67c4', 3, NULL, NULL, NULL, NULL),
(135, 'Чериковская центральная районная больница', 'cherikovcrb', 'c80fbb7b82422e6665dd7817114cfbbe', 3, NULL, NULL, NULL, NULL),
(136, 'Шкловская центральная районная больница', 'sklovcrb', '211d442e54b2acdd170f804641bcab21', 3, NULL, NULL, NULL, NULL),
(137, 'Могилёвская областная клиническая  больница', 'mogokb', '486e547dfb4fcc28144a2037892601ef', 3, NULL, NULL, NULL, NULL),
(138, 'Могилёвская областная детская больница', 'mogodb', 'f365d108355a142f65d49d95694e7e1b', 3, NULL, NULL, NULL, NULL),
(139, 'Могилёвская областная больница медицинской реабилитации', 'mogobmr', '1103a126eabcc91c3c3a88206305daa9', 3, NULL, NULL, NULL, NULL),
(140, 'Могилёвский областной госпиталь ИОВ', 'mogogivov', '8164b499d12fe3a6d3ce0b667bb64349', 3, NULL, NULL, NULL, NULL),
(141, 'Могилёвская областная психиатрическая больница', 'mogopb', 'dc237af45503726c26c699e709f56323', 3, NULL, NULL, NULL, NULL),
(142, 'Областной детский центр медицинской реабилитации «Космос»', 'cosmosodcmr', '738e980f080a2e1ebc55dc748dae3791', 3, NULL, NULL, NULL, NULL),
(143, 'Могилёвский областной противотуберкулёзный диспансер', 'mogopd', 'e0d4126bf985ecce9950d78a2bf3c692', 3, NULL, NULL, NULL, NULL),
(144, 'Могилёвский областной онкологический диспансер', 'mogood', 'a2b943f49935193bad8d9e9f5134af98', 3, NULL, NULL, NULL, NULL),
(145, 'Могилёвский областной наркологический диспансер', 'mogond', '70ca6e4e5006b9d26922bdda1b7a5495', 3, NULL, NULL, NULL, NULL),
(146, 'Могилёвский областной кожно-венерологический диспансер', 'mogokvd', 'abbd4bbf1b5aeca11e0ae8b6b968ba8b', 3, NULL, NULL, NULL, NULL),
(147, 'Могилёвская больница № 1', 'mogb1', 'bf9c32958eaa9f07bcc1a3598be311f2', 3, NULL, NULL, NULL, NULL),
(148, 'Могилёвская городская больница скорой медицинской помощи', 'moggbsmp', '5159fb359c757ac48b77449a1f106f29', 3, NULL, NULL, NULL, NULL),
(149, 'Бобруйская городская больница скорой медицинской помощи', 'bobrgbsmp', '550488c69d7a9acbefa5f7f5d6d25ffc', 3, NULL, NULL, NULL, NULL),
(150, 'Бобруйский межрайонный онкологический диспансер', 'bobrmod', '77f0272eca8370fb9b11b7f3387d27be', 3, NULL, NULL, NULL, NULL),
(151, 'Бобруйская центральная больница', 'bobrcb', '7746e779512e99d3ff90e9bb785330d4', 3, NULL, NULL, NULL, NULL),
(152, 'Бобруйский родильный дом', 'bobrrd', '27818311fc5358e9ba01b83c7649edc1', 3, NULL, NULL, NULL, NULL),
(153, 'Могилёвская центральная поликлиника', 'mogcp1', '5a9fb59ba618d436080508c3fdf60edb', 3, NULL, NULL, NULL, NULL),
(154, 'Могилёвская поликлиника № 2', 'mogp2', '3cab5ff32ec52df602947045bf14012d', 3, NULL, NULL, NULL, NULL),
(155, 'Могилёвская поликлиника № 3', 'mogp3', '7d5f08679f61ef3e08d653607d1c553f', 3, NULL, NULL, NULL, NULL),
(156, 'Могилёвская поликлиника № 4', 'mogp4', '4116ce97f7447f14f7e58b0799ce0af1', 3, NULL, NULL, NULL, NULL),
(157, 'Могилёвская поликлиника № 5', 'mogp5', 'e279f5420f5e760d1e382b67dffa9c7f', 3, NULL, NULL, NULL, NULL),
(158, 'Могилёвская поликлиника № 6', 'mogp6', '609cfc5b4d8ba49853ccb60e19d94c87', 3, NULL, NULL, NULL, NULL),
(159, 'Могилёвская поликлиника № 7', 'mogp7', '9ffb6a4095c8bda4ff8416764ebc9ac3', 3, NULL, NULL, NULL, NULL),
(160, 'Могилёвская поликлиника № 8', 'mogp8', '9daa1b1206856818fe11a29205a5e6c0', 3, NULL, NULL, NULL, NULL),
(161, 'Могилёвская поликлиника № 9', 'mogp9', '539e58c857080de06853d18db0b38e06', 3, NULL, NULL, NULL, NULL),
(162, 'Могилёвская поликлиника № 10', 'mogp10', 'bc7ee77c8e31bf55c24f02abd3e32fc9', 3, NULL, NULL, NULL, NULL),
(163, 'Могилёвская поликлиника № 11', 'mogp11', '271a367f3b83e17c75f1365f3e57a697', 3, NULL, NULL, NULL, NULL),
(164, 'Могилёвская поликлиника № 12', 'mogp12', '31c3e7c375d4b11841e11d1fe3e224c8', 3, '0', 'dhsoakom76qva8of8ug4jnu1jmnr8mla', '2023-06-29 12:06:00', '/index.php?logout'),
(165, 'Могилёвская детская поликлиника', 'mogdp', 'e0979a51dd440eef0cb52a6df30c3b0e', 3, NULL, NULL, NULL, NULL),
(166, 'Могилёвская детская поликлиника № 1', 'mogdp1', '19c6645444fffadcbcb83b1b8524fc81', 3, NULL, NULL, NULL, NULL),
(167, 'Могилёвская детская поликлиника № 2', 'mogdp2', '2495cdf58a095b31c3f376e9663017c4', 3, NULL, NULL, NULL, NULL),
(168, 'Могилёвская детская поликлиника № 4', 'mogdp4', '4843b42ed8b5b2ae6941acafb38a588f', 3, NULL, NULL, NULL, NULL),
(169, 'Могилёвский областной лечебно- диагностический центр', 'mogoldc', '53c1274b108a0ae5a41495eb5c088af5', 3, NULL, NULL, NULL, NULL),
(170, 'Могилёвская стоматологическая поликлиника', 'mogsp', 'df9c42c006c19ece734aa8618f4a8713', 3, NULL, NULL, NULL, NULL),
(171, 'Могилёвская стоматологическая поликлиника № 2', 'mogsp2', 'd4fc2f53edc254075fd3d36d160b5f1e', 3, NULL, NULL, NULL, NULL),
(172, 'Могилёвская детская стоматологическая поликлиника', 'mogdsp', '7217f72d02b4331c342bc96de932438e', 3, NULL, NULL, NULL, NULL),
(173, 'Могилёвская областная стоматологическая поликлиника', 'mogosp', '41f015fdccc037bd5955fd28d0d3ab8e', 3, NULL, NULL, NULL, NULL),
(174, 'Могилёвская областная детская стоматологическая поликлиника', 'mogodsp', '57c3f174417faaca51209e66ed6f57ad', 3, NULL, NULL, NULL, NULL),
(175, 'Бобруйская городская поликлиника № 1', 'bobrgp1', 'f9e18e747119c6e6d2bb27c9765da958', 3, NULL, NULL, NULL, NULL),
(176, 'Бобруйская городская поликлиника № 2', 'bobrgp2', '71ac274039cea15946a3cd7b3d732e9c', 3, NULL, NULL, NULL, NULL),
(177, 'Бобруйская городская поликлиника № 3', 'bobrgp3', 'aa8cb999e958ecd02747865152ff6548', 3, NULL, NULL, NULL, NULL),
(178, 'Бобруйская городская поликлиника № 6', 'bobrgp6', '7f7768f182635a14ac722cb1cf7e7752', 3, NULL, NULL, NULL, NULL),
(179, 'Бобруйская городская поликлиника № 7', 'bobrgp7', 'd735cbfd33fa153e93b171ebc94b25eb', 3, NULL, NULL, NULL, NULL),
(180, 'Бобруйская городская детская больница', 'bobrgdb', 'f7aacd19a8fb9b4dcd1229a2bbb15194', 3, NULL, NULL, NULL, NULL),
(181, 'Бобруйская городская стоматологическая поликлиника № 1', 'bobrgsp1', '8c7ac16dbfb15d21ba42438d257cf30a', 3, NULL, NULL, NULL, NULL),
(182, 'Бобруйская лечебно-консультативная поликлиника', 'bobrlkp', '8da55ad0bfb7019c125a53e8915dba9d', 3, NULL, NULL, NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id_application`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_status` (`id_status`);

--
-- Индексы таблицы `cells`
--
ALTER TABLE `cells`
  ADD PRIMARY KEY (`id_cell`),
  ADD KEY `id_application` (`id_application`),
  ADD KEY `id_column` (`id_column`),
  ADD KEY `id_criteria` (`id_criteria`);

--
-- Индексы таблицы `columns`
--
ALTER TABLE `columns`
  ADD PRIMARY KEY (`id_column`);

--
-- Индексы таблицы `conditions`
--
ALTER TABLE `conditions`
  ADD PRIMARY KEY (`conditions_id`);

--
-- Индексы таблицы `criteria`
--
ALTER TABLE `criteria`
  ADD PRIMARY KEY (`id_criteria`),
  ADD KEY `conditions_id` (`conditions_id`);

--
-- Индексы таблицы `mark`
--
ALTER TABLE `mark`
  ADD PRIMARY KEY (`id_mark`),
  ADD KEY `id_criteria` (`id_criteria`);

--
-- Индексы таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  ADD PRIMARY KEY (`id_mark_rating`),
  ADD KEY `id_mark` (`id_mark`),
  ADD KEY `id_subvision` (`id_subvision`);

--
-- Индексы таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  ADD PRIMARY KEY (`id_rating_criteria`),
  ADD KEY `id_criteria` (`id_criteria`),
  ADD KEY `id_subvision` (`id_subvision`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`);

--
-- Индексы таблицы `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id_status`);

--
-- Индексы таблицы `subvision`
--
ALTER TABLE `subvision`
  ADD PRIMARY KEY (`id_subvision`),
  ADD KEY `id_application` (`id_application`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_role` (`id_role`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `applications`
--
ALTER TABLE `applications`
  MODIFY `id_application` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT для таблицы `cells`
--
ALTER TABLE `cells`
  MODIFY `id_cell` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `columns`
--
ALTER TABLE `columns`
  MODIFY `id_column` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `conditions`
--
ALTER TABLE `conditions`
  MODIFY `conditions_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `criteria`
--
ALTER TABLE `criteria`
  MODIFY `id_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `mark`
--
ALTER TABLE `mark`
  MODIFY `id_mark` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  MODIFY `id_mark_rating` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  MODIFY `id_rating_criteria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `status`
--
ALTER TABLE `status`
  MODIFY `id_status` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `subvision`
--
ALTER TABLE `subvision`
  MODIFY `id_subvision` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `cells`
--
ALTER TABLE `cells`
  ADD CONSTRAINT `cells_ibfk_1` FOREIGN KEY (`id_application`) REFERENCES `applications` (`id_application`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cells_ibfk_2` FOREIGN KEY (`id_column`) REFERENCES `columns` (`id_column`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cells_ibfk_3` FOREIGN KEY (`id_criteria`) REFERENCES `criteria` (`id_criteria`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `criteria`
--
ALTER TABLE `criteria`
  ADD CONSTRAINT `criteria_ibfk_1` FOREIGN KEY (`conditions_id`) REFERENCES `conditions` (`conditions_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `mark`
--
ALTER TABLE `mark`
  ADD CONSTRAINT `mark_ibfk_1` FOREIGN KEY (`id_criteria`) REFERENCES `criteria` (`id_criteria`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `mark_rating`
--
ALTER TABLE `mark_rating`
  ADD CONSTRAINT `mark_rating_ibfk_1` FOREIGN KEY (`id_mark`) REFERENCES `mark` (`id_mark`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `mark_rating_ibfk_2` FOREIGN KEY (`id_subvision`) REFERENCES `subvision` (`id_subvision`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `rating_criteria`
--
ALTER TABLE `rating_criteria`
  ADD CONSTRAINT `rating_criteria_ibfk_1` FOREIGN KEY (`id_criteria`) REFERENCES `criteria` (`id_criteria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `rating_criteria_ibfk_2` FOREIGN KEY (`id_subvision`) REFERENCES `subvision` (`id_subvision`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `subvision`
--
ALTER TABLE `subvision`
  ADD CONSTRAINT `subvision_ibfk_1` FOREIGN KEY (`id_application`) REFERENCES `applications` (`id_application`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
