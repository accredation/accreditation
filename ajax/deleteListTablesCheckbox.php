<?php
include "connection.php";
$id_sub = $_GET['id_sub'];

mysqli_query($con, "DELETE FROM z_department WHERE id_subvision = '$id_sub'");
mysqli_query($con, "DELETE FROM z_answer_criteria 
                   WHERE id_department NOT IN (SELECT id_department FROM z_department)");
mysqli_query($con, "DELETE FROM z_selected_tables WHERE id_subvision = '$id_sub'");


?>