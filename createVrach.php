<?php
include "connection.php";
$id_users = $_POST['id_users'];

mysqli_query($con, "UPDATE USERS SET doctor_expert = '1' where id_user = '$id_users'");
?>