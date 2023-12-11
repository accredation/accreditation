<?php
include "connection.php";
$id_users = $_POST['id_users'];

mysqli_query($con, "UPDATE `users` SET doctor_expert = 1 where id_user = '$id_users'");
?>