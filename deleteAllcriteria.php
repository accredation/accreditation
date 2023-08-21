<?php
include "connection.php";
$id_users = $_POST['id_user'];

mysqli_query($con, "UPDATE USERS SET doctor_expert = '0' where id_user = '$id_users'");

?>