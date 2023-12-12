<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_list_tables_criteria =  $_GET['id_list_tables_criteria'];
$check =  $_GET['check'];



$query = "SELECT * from z_selected_tables where id_list_tables_criteria ='$id_list_tables_criteria' and id_subvision = '$id_sub' ";
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) > 0)
{
    $query = "UPDATE  z_selected_tables SET id_list_tables_criteria ='$id_list_tables_criteria' , id_subvision = '$id_sub',`count`='$check'
              where id_list_tables_criteria ='$id_list_tables_criteria' and id_subvision = '$id_sub'  ";
    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
}
else {
    $query = "insert  into z_selected_tables (id_list_tables_criteria,id_subvision, `count`) values  ('$id_list_tables_criteria' , '$id_sub' , '$check')";
    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
}

?>