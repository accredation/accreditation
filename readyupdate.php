<?php
include "connection.php";
$date = date('Y-m-d');
$id_sub = $_POST['id_sub'];
$id_criteria = $_POST['id_criteria'];
$status = $_POST['value'];
mysqli_query($con, "update rating_criteria as rc set status = '$status' , date_complete = '$date' where  id_subvision = '$id_sub' and id_criteria = '$id_criteria' and rc.value = 1");
?>