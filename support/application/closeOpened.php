<?php
include "../../ajax/connection.php";

$id_sub = $_GET['id_sub'];
$id_criteria = $_GET['id_criteria'];


mysqli_query($con, "UPDATE rating_criteria SET opened = 0 WHERE id_subvision = '$id_sub' AND id_criteria = '$id_criteria'");

?>