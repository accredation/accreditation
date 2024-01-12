<?php
include "connection.php";

$id_application	 = $_GET['id_application'];
$id_user	 = $_GET['id_user'];
$type_action	 = $_GET['type_action'];
$action	 = $_GET['action'];

mysqli_query($con, "insert into history_actions (id_application, id_user, date_action, time_action,	type_action, action)
  values('$id_application', '$id_user', CURRENT_DATE(), CURRENT_TIME(), '$type_action', '$action')");

?>