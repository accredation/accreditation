<?php
include "connection.php";

$id_user	 = $_POST['id_user'];
$name_action	 = $_POST['name_action'];
$login	 = $_COOKIE['login'];

mysqli_query($con, "insert into changes_password_accred (id_user, date_action, time_action, whoChange, name_action)
  values('$id_user', CURRENT_DATE(), CURRENT_TIME(), '$login', '$name_action')");

?>