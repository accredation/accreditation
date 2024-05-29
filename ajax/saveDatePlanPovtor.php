<?php
include 'connection.php';

$date = $_POST['inputDate'];
$id_app = $_POST['id_app'];

mysqli_query($con,"update applications set data_zayav_otzyv='$date' where id_application='$id_app'");
