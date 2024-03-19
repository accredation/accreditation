<?php

include "connection.php";

$id_user = $_POST['id_user'];
$password = $_POST['newPass'];
$name_action = $_POST['name_action'];
$login = $_COOKIE['login'];

$passMd5 = md5($password);

mysqli_query($con, "update users set password = '$passMd5' where id_user='$id_user'");
mysqli_query($con, "insert into changes_password_accred(id_user, date_action, time_action, whoChange, name_action)
  values('$id_user', CURRENT_DATE(), CURRENT_TIME(), '$login', '$name_action')");

