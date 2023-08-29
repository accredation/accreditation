<?php
include "connection.php";

$notificationId = $_POST['notificationId'];

$query = "UPDATE notifications SET readornot = 0 WHERE id_notifications = '$notificationId'";

mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
?>