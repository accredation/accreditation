<?php
include 'connection.php';

$id_app = $_POST['id_app'];
$id_status = $_POST['id_status'];
$login = $_COOKIE['login'];

$query = "select id_status from applications where id_application = '$id_app'";

$res = mysqli_query($con, $query);

$row = mysqli_fetch_assoc($res);
$old_id_status = $row['id_status'];

$query = "update applications set id_status = '$id_status' where id_application = '$id_app'";

mysqli_query($con, $query);

$text = $login . " зменил статус с ". $old_id_status ." на " . $id_status . " у заявления " . $id_app;
$query = "insert into history_change_status (text) values('$text')";

mysqli_query($con, $query);
