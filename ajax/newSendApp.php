<?php
include "connection.php";

$date = date('Y-m-d');
$id_applications = $_GET['id_application'];



    mysqli_query($con, "Update applications set `id_status` = 2, `date_send`='$date' where `id_application` = '$id_applications'");
    echo "";


?>