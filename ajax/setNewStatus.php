<?php

include "connection.php";

$id_application = $_POST['id_app'];
$login = $_COOKIE['login'];

$query = "select id_status from applications where id_application = '$id_application'";

$res = mysqli_query($con, $query);

$row = mysqli_fetch_assoc($res);
$old_id_status = $row['id_status'];

$query = "update applications set id_status = 1 where id_application = '$id_application'";

mysqli_query($con, $query);

$text = $login . " зменил статус с ". $old_id_status ." на " . 1 . " у заявления " . $id_application;
$query = "insert into history_change_status (text) values('$text')";

mysqli_query($con, $query);

?>