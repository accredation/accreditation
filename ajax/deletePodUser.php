<?php
include "connection.php";

$id_user = $_GET['id_user'];

    mysqli_query($con, "delete from users where id_user = '$id_user'");


?>