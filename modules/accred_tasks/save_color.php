<?php
include '../../connection.php';

$app_id = $_POST['app_id'];
$color = $_POST['color'];

$query = "UPDATE applications SET color_app = '$color' WHERE id_application = '$app_id'";
$result = mysqli_query($con, $query) or die(mysqli_error($con));

echo "Цвет успешно сохранён!";
?>