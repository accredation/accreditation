<?php

include "../connection.php";

$id_user = $_POST['id_user'];
$id_type = $_POST['id_type'];


mysqli_query($con, "update users set users.id_type = '$id_type' where users.id_user = '$id_user'");



?>