<?php

include "../ajax/connection.php";

$id_user = $_POST['id_user'];
$id_type = $_POST['id_type'];


mysqli_query($con, "update uz set uz.id_type = '$id_type' where uz.id_uz = '$id_user'");



?>