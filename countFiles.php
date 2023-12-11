<?php
function countFilesInFolder($folder) {
$fileCount = 0;

// Открываем папку
$dir = opendir($folder);

// Перебираем содержимое папки
while (($file = readdir($dir)) !== false) {
// Игнорируем текущую и родительскую директории
if ($file == '.' || $file == '..') {
continue;
}

// Формируем полный путь к текущему файлу или папке
$path = $folder . '/' . $file;

// Если это файл, увеличиваем счетчик
if (is_file($path)) {
$fileCount++;
}

// Если это папка, вызываем функцию рекурсивно
if (is_dir($path)) {
$fileCount += countFilesInFolder($path);
}
}

// Закрываем папку
closedir($dir);

// Возвращаем общее количество файлов
return $fileCount;
}

// Задаем путь к папке "doc"
$folderPath = 'docs/documents/';

// Вызываем функцию для подсчета файлов в каждой папке
function countFilesInSubfolders($folderPath) {
// Открываем папку
$dir = opendir($folderPath);

// Перебираем содержимое папки
while (($file = readdir($dir)) !== false) {
// Игнорируем текущую и родительскую директории
if ($file == '.' || $file == '..') {
continue;
}

// Формируем полный путь к текущей папке
$subfolderPath = $folderPath . '/' . $file;

// Проверяем, является ли текущий элемент подпапкой
if (is_dir($subfolderPath)) {
// Вызываем функцию для подсчета файлов в подпапке
$fileCount = countFilesInFolder($subfolderPath);

// Выводим результат
    if($fileCount < 6)
echo "Количество файлов в папке {$subfolderPath}: {$fileCount}<br>";
}
}

// Закрываем папку
closedir($dir);
}

// Вызываем функцию для подсчета файлов в каждой папке
countFilesInSubfolders($folderPath);