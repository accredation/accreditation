-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 08 2023 г., 16:42
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

-- --------------------------------------------------------

--
-- Структура таблицы `container_chats`
--

CREATE TABLE `container_chats` (
  `id_container_chat` int NOT NULL,
  `id_user_sendler` int NOT NULL,
  `id_user_receiver` int NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `files`
--

CREATE TABLE `files` (
  `id_file` int NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cell` int DEFAULT NULL,
  `id_user` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `files`
--

INSERT INTO `files` (`id_file`, `file`, `cell`, `id_user`) VALUES
(1, 'пркз№48_2013.doc', 0, 1),
(2, 'ТЗ GIVBY (на отправку).docx', 0, 1),
(3, 'прмз№90_2007 (1).rtf', 1, 1),
(4, 'Доработки от 12.05.docx', 0, 2),
(5, 'пркз№48_2013.doc', 0, 2),
(6, 'описание задачи справочник.docx', 0, 2),
(7, 'постановление_МЗ_2023_59.pdf', 0, 1),
(8, 'Заявление (7).docx', 1, 1),
(9, 'Заявление (6).docx', 1, 1),
(10, 'Доработки от 12.05.docx', 2, 1),
(11, 'Лаб. Windows Forms и C++.docx', 2, 1),
(12, 'пмз№84_2008 (1).doc', 2, 1),
(13, 'пркз№48_2013.doc', 2, 1),
(14, 'Заявление.docx.pdf', 1, 1),
(15, 'Оглавление номера 4 2019 (2).docx', 2, 2),
(16, 'Пояснение (2).docx', 2, 2),
(17, 'прмз№90_2007.rtf', 2, 2),
(18, 'пркз№48_2013.doc', 2, 2),
(19, 'тз_сайт.docx', 4, 2),
(20, 'Пояснение (2).docx', 4, 1);

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
(1, 'Аккредитация', 'accred@mail.ru', '6534cb7340066e972846eaf508de6224', 2, 'c8qg153oamvjtalur6c3lh725md2q54s', 'c8qg153oamvjtalur6c3lh725md2q54s', '2023-06-08 15:58:25', '/index.php?application'),
(2, '36gp', '36gp@mail.ru', 'ba258829bb23dce283867bb2f8b78d7f', 3, '0', 'c8qg153oamvjtalur6c3lh725md2q54s', '2023-06-08 15:57:54', '/index.php?logout');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `container_chats`
--
ALTER TABLE `container_chats`
  ADD PRIMARY KEY (`id_container_chat`),
  ADD KEY `id_user_receiver` (`id_user_receiver`),
  ADD KEY `id_user_sendler` (`id_user_sendler`);

--
-- Индексы таблицы `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id_file`),
  ADD KEY `id_user` (`id_user`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`);

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
-- AUTO_INCREMENT для таблицы `container_chats`
--
ALTER TABLE `container_chats`
  MODIFY `id_container_chat` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `files`
--
ALTER TABLE `files`
  MODIFY `id_file` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `container_chats`
--
ALTER TABLE `container_chats`
  ADD CONSTRAINT `container_chats_ibfk_1` FOREIGN KEY (`id_user_receiver`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `container_chats_ibfk_2` FOREIGN KEY (`id_user_sendler`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
