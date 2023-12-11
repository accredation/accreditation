<?php
include "connection.php";

$id_sub = $_POST['id_sub'];

$query = "delete from subvision where id_subvision = '$id_sub'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

?>