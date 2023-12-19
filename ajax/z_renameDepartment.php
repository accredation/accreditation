<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_department = $_GET['id_department'];
$newDepartmentName = $_GET['new_department_name'];
mysqli_query($con, "update z_department set name = '$newDepartmentName'  WHERE id_subvision = '$id_sub' AND id_department = '$id_department'");
mysqli_close($con);
?>