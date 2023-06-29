<?php
include "connection.php";

$id_application = $_GET['id_application'];

$query = "SELECT * FROM applications WHERE id_application='$id_application'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$data = array();
$cells = array();
if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $dov = $row['copy_rasp'];
    $naim = $row['naim'];
    $unp = $row['unp'];
}

array_push($cells,$naim);
array_push($cells,$dov);
array_push($cells,$unp);

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