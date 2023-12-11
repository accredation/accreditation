<?php
include "connection.php";
$id_user = $_GET['id_user'];
$login = $_GET['login'];
$password = $_GET['password'];

    mysqli_query($con, "update users set login = '$login', password='$password', id_role = '15' where id_user = '$id_user'");


?>