<?php
include "connection.php";

$username = $_GET['naim'];

$query = "SELECT * FROM applications, users WHERE applications.id_user = users.id_user and username = '$username'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$apps = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);
foreach ($data as $app) {
    array_push($apps,$app['naim']);
}


echo json_encode($apps);
?>