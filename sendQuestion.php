<?php
include "connection.php";

$date = date('Y-m-d');
$id_user = $_GET['id_user'];
$question = $_GET['question'];

mysqli_query($con, "Insert into questions(`question`, `id_user`, `important`) values ('$question', '$id_user', 0)");

?>