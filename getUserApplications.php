<?php
include "connection.php";



$username = $_GET['username'];

$query = "SELECT * FROM applications, users WHERE applications.id_user = users.id_user and username = '$username'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$apps = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);
foreach ($data as $app) {
    array_push($apps,$app['naim']);
    array_push($apps,$app['sokr_naim']);
    array_push($apps,$app['unp']);
    array_push($apps,$app['ur_adress']);
    array_push($apps,$app['tel']);
    array_push($apps,$app['email']);
    array_push($apps,$app['rukovoditel']);
    array_push($apps,$app['predstavitel']);
    array_push($apps,$app['soprovod_pismo']);
    array_push($apps,$app['copy_rasp']);
    array_push($apps,$app['org_structure']);
}


echo json_encode($apps);
?>