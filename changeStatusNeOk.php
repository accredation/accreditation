<?php
include "connection.php";
$id_applications = $_GET['id_application'];


mysqli_query($con, "Update applications set `id_status` = 5 where `id_application` = '$id_applications'");

?>