<?php
include "connection.php";
$newsContent = $_POST['newsContent'];
$newsDate = date('d.m.Y', strtotime($_POST['newsDate']));

mysqli_query($con, "insert into news (name_news,date_news) values ('$newsContent','$newsDate') ");
?>