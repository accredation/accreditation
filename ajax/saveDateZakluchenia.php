<?php
include 'connection.php';

$date = $_POST['date'];
$id_app = $_POST['id_app'];

mysqli_query($con,"update applications set data_zakluchenia='$date' where id_application='$id_app'");
