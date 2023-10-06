-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 06 2023 г., 10:11
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
-- Структура таблицы `documents`
--

CREATE TABLE `documents` (
  `document_id` int NOT NULL,
  `doc_name` text COLLATE utf8mb4_bin,
  `doc_name_with_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `razdel` int DEFAULT NULL,
  `doc_type` text COLLATE utf8mb4_bin,
  `img_name` text COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Дамп данных таблицы `documents`
--

INSERT INTO `documents` (`document_id`, `doc_name`, `doc_name_with_type`, `razdel`, `doc_type`, `img_name`) VALUES
(1, 'График обучения для ОЗ', 'График обучения для ОЗ.doc', 1, 'Word', 'word-icon.png'),
(2, 'Перечень общих требований для оценки соответствия в области санитарно-эпидемиологического благополучия населения', 'Перечень общих требований для оценки соответствия в области санитарно-эпидемиологического благополучия населения.doc', 1, 'WORD', 'word-icon.png'),
(3, 'Письмо МЗ РБ от 27.09.2023  О проведении медицинской аккредитации', 'Письмо МЗ РБ от 27.09.2023  О проведении медицинской аккредитации.pdf', 1, 'PDF', 'pdf_icon.png'),
(4, 'Приказ МЗ от 15.09.2023 №1341 О проведении медицинской аккредитации', 'Приказ МЗ от 20.09.2023 №1341 О проведении медицинской аккредитации.pdf', 1, 'PDF', 'pdf_icon.png'),
(5, 'Приложения к приказу №1341', 'Приложения к приказу №1341.docx', 1, 'WORD', 'word-icon.png'),
(6, 'Приказ МЗ от 20.09.2023 №1353 О проведении оценки соответсвия', 'Приказ МЗ от 20.09.2023 №1353 О проведении оценки соответсвия.pdf', 1, 'PDF', 'pdf_icon.png'),
(7, 'проект Приказ О создании рабочей группы для самоаккредитации', 'проект Приказ О создании рабочей группы для самоаккредитации.docx', 1, 'WORD', 'word-icon.png'),
(8, 'Информация об используемой медицинской технике', 'Информация об используемой медицинской технике.docx', 2, 'WORD', 'word-icon.png'),
(9, 'Сопроводительное письмо образец', 'Сопроводительное письмо образец.docx', 2, 'WORD', 'word-icon.png'),
(10, 'Схема организационной структуры ОЗ образец', 'Схема_организационной_структуры_ОЗ_образец.pptx', 2, 'PDF', 'pptx-icon.png'),
(11, 'Показатели укомплектованности', 'Показатели укомплектованности.docx', 2, 'WORD', 'word-icon.png'),
(12, 'пользователя ИС Медицинская Аккредитация', 'пользователя ИС Медицинская Аккредитация.docx', 3, 'WORD', 'word-icon.png'),
(13, 'ИС Медицинская аккредитация', 'ИС Медицинская аккредитация.pdf', 3, 'PDF', 'pdf_icon.png'),
(14, 'Цели и организация проведения медицинской аккредитации', 'Цели и организация проведения медицинской аккредитации.pdf', 3, 'PDF', 'pdf_icon.png');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `documents`
--
ALTER TABLE `documents`
  MODIFY `document_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
