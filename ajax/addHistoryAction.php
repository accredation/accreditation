<?php
include "connection.php";

$id_application	 = $_GET['id_application'];
$id_user	 = $_GET['id_user'];
$type_action	 = $_GET['type_action'];
$action	 = $_GET['action'];
if(isset($_GET['id_subvision'])){
    $id_subvision	 = $_GET['id_subvision'];
    if($id_subvision == '') $id_subvision = 0;
}
else {
    $id_subvision = 0;
}
if(isset($_GET['id_department'])){
    $id_department	 = $_GET['id_department'];
    if($id_department == '') $id_department = 0;
}
else
    $id_department = 0;


mysqli_query($con, "insert into history_actions (id_application, id_user, date_action, time_action,	type_action, action, id_subvision, id_department)
  values('$id_application', '$id_user', CURRENT_DATE(), CURRENT_TIME(), '$type_action', '$action', '$id_subvision', '$id_department')");

?>