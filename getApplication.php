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

    $naim = $row['naim'];
    $sokr = $row['sokr_naim'];
    $unp = $row['unp'];
    $ur_adress = $row['ur_adress'];
    $tel = $row['tel'];
    $email = $row['email'];
    $rukovoditel = $row['rukovoditel'];
    $predstavitel = $row['predstavitel'];
    $soprovod_pismo = $row['soprovod_pismo'];
    $copy_rasp = $row['copy_rasp'];
    $org_structure = $row['org_structure'];
    $login = $row['login'];
    $report = $row['fileReport'];
}

array_push($cells,$naim);
array_push($cells,$sokr);
array_push($cells,$unp);
array_push($cells,$ur_adress);
array_push($cells,$tel);
array_push($cells,$email);
array_push($cells,$rukovoditel);
array_push($cells,$predstavitel);
array_push($cells,$soprovod_pismo);
array_push($cells,$copy_rasp);
array_push($cells,$org_structure);
array_push($cells,$login);
array_push($cells,$report);

$query = "SELECT * FROM subvision WHERE id_application = '$id_application'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

$subvis_names = array();
for ($names = []; $row = mysqli_fetch_assoc($rez); $names[] = $row);
foreach ($names as $name) {
    $subvis_obj = array();
    array_push($subvis_obj,$name['id_subvision']);
    array_push($subvis_obj,$name['name']);
    array_push($subvis_names,$subvis_obj);
}

array_push($data,$cells);
array_push($data,$subvis_names);
echo json_encode($data);
?>