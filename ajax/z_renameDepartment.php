<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_department = $_GET['id_department'];


$query = "SELECT name FROM z_list_tables_criteria WHERE id_list_tables_criteria = (SELECT id_list_tables_criteria FROM z_department WHERE id_subvision = '$id_sub' AND id_department = '$id_department')";
$result = mysqli_query($con, $query);
$row = mysqli_fetch_assoc($result);
$departmentName = $row['name'];

$newDepartmentName = $_GET['new_department_name'];
$updatedDepartmentName = $newDepartmentName . " ($departmentName)";
mysqli_query($con, "update z_department set name = '$updatedDepartmentName'  WHERE id_subvision = '$id_sub' AND id_department = '$id_department'");
mysqli_close($con);
?>