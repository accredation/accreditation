<?php
include "connection.php";
$id_userMain = $_GET['id_userMain'];
$login = $_GET['login'];
$password = $_GET['password'];

    mysqli_query($con, "Insert into users(`login`, `password`, `id_role`, id_uz) values('$login','$password', 15, '$id_userMain') ");


?>