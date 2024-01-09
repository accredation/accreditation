<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_department = $_GET['id_department'];
$newDepartmentName = $_GET['new_department_name'];

$query = "SELECT name FROM z_list_tables_criteria WHERE id_list_tables_criteria = (SELECT id_list_tables_criteria FROM z_department WHERE id_subvision = '$id_sub' AND id_department = '$id_department')";
$result = mysqli_query($con, $query);
if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $departmentName = $row['name'];
$updatedDepartmentName = $newDepartmentName . " ($departmentName)";
}
else{
    $updatedDepartmentName = $newDepartmentName;
}
mysqli_query($con, "update z_department set name = '$updatedDepartmentName'  WHERE id_subvision = '$id_sub' AND id_department = '$id_department'");
mysqli_close($con);
echo $updatedDepartmentName;
?>