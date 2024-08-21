<?php
include "connection.php";
$newsContent = $_POST['newsContent'];
$newsDate = date('d.m.Y', strtotime($_POST['newsDate']));

mysqli_query($con, "insert into news (name_news,date_news) values ('$newsContent','$newsDate') ");

$text_notifications = "Важная новость!";

$query3 = "Insert into  notifications  (text_notifications,readornot,date_text) values ('$text_notifications', 1, CURDATE()) ";

$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));
?>