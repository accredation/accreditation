<?php
include "connection.php";

$id_application = $_GET['id_application'];
$query = "SELECT * FROM applications, users WHERE id_application='$id_application' and applications.id_user=users.id_user ";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$data = array();
$cells = array();
if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $login = $row['login'];
    $plandatesoveta = $row['PlanDateSoveta'];
    $resheniesoveta = $row['ReshenieSoveta'];
    $srokresheniasoveta = $row['SrokResheniaSoveta'];
    $protokolsoveta = $row['ProtokolSoveta'];
    $zaklsoveta = $row['ZaklSoveta'];


}
array_push($cells,$login);
array_push($cells,$plandatesoveta);
array_push($cells,$resheniesoveta);
array_push($cells,$srokresheniasoveta);
array_push($cells,$protokolsoveta);
array_push($cells,$zaklsoveta);




array_push($data,$cells);

echo json_encode($data);
?>