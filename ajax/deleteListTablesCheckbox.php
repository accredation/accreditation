<?php
include "connection.php";
$id_sub = $_GET['id_sub'];

mysqli_query($con, "DELETE FROM z_department WHERE id_subvision = '$id_sub'");
mysqli_query($con, "DELETE FROM z_selected_tables WHERE id_subvision = '$id_sub'");


?>