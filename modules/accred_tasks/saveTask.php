<?php

include "../../connection.php";

$id_application = $_POST['id_application'];
$date_accept = $_POST['date_accept'];
$date_complete = $_POST['date_complete'];
$date_council = $_POST['date_council'];
$query = "Update applications set date_accept = '$date_accept', date_complete = '$date_complete', date_council = '$date_council' WHERE id_application = '$id_application'";

mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

echo "OK";
?>