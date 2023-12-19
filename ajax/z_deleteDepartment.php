<?php
include "connection.php";

$id_sub = $_GET['id_sub'];
$id_department = $_GET['id_department'];
mysqli_query($con, "delete from z_department  WHERE id_subvision = '$id_sub' AND id_department = '$id_department'");
mysqli_close($con);
?>