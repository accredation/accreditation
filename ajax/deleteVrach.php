<?php
include "connection.php";
$id_user = $_POST['id_user'];

mysqli_query($con, "DELETE FROM spr_doctor_expert_for_criteria WHERE id_user = '$id_user'");
mysqli_query($con, "UPDATE USERS SET doctor_expert = '0' WHERE id_user = '$id_user'");

?>