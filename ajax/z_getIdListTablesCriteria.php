<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_department = $_GET['id_department'];
$id_list_tables_criteria = '';

$query = "SELECT * from z_department where id_department = '$id_department' and id_subvision = '$id_sub' ";
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
while($row = mysqli_fetch_array($rez)) {
    $id_list_tables_criteria = $row['id_list_tables_criteria'];
}

echo $id_list_tables_criteria;
?>