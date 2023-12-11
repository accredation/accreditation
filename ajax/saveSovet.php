<?php
include "connection.php";
$login = $_COOKIE['login'];
$id_application = $_POST['id_application'];

$dateInputPlan = isset($_POST['dateInputPlan']) ? $_POST['dateInputPlan'] : null;
$resolution = isset($_POST['resolution']) ? $_POST['resolution'] : null;
$dateInputSrok = isset($_POST['dateInputSrok']) ? $_POST['dateInputSrok'] : null;

if ($dateInputPlan) {
    $query =
        "UPDATE applications SET PlanDateSoveta = '$dateInputPlan' WHERE id_application = '$id_application'";
    $result = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
}

if ($resolution) {
    $query =
        "UPDATE applications SET ReshenieSoveta = '$resolution' WHERE id_application = '$id_application'";
    $result = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
}

if ($dateInputSrok) {
    $query =
        "UPDATE applications SET SrokResheniaSoveta = '$dateInputSrok' WHERE id_application = '$id_application'";
    $result = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
}

if (!file_exists('../docs/documents/'.$login . "/" . 'sovets/'. $id_application )) {
    mkdir('../docs/documents/'.$login . "/" . 'sovets/'. $id_application , 0777, true);
}

if (isset($_FILES['protokolsoveta']['name'])) {
    $file_name = $_FILES['protokolsoveta']['name'];
    $file_tmp = $_FILES['protokolsoveta']['tmp_name'];

    move_uploaded_file($file_tmp, "../docs/documents/" . $login . "/sovets/". $id_application  . "/". $file_name);

    $query2 =
        "UPDATE applications set ProtokolSoveta = '$file_name' where id_application='$id_application'";

    $result2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
}

if (isset($_FILES['zaklsoveta']['name'])) {
    $file_name = $_FILES['zaklsoveta']['name'];
    $file_tmp = $_FILES['zaklsoveta']['tmp_name'];

    move_uploaded_file($file_tmp, "./docs/documents/" . $login . "/sovets/". $id_application . "/" .  $file_name);

    $query3 =
        "UPDATE applications set ZaklSoveta = '$file_name' where id_application='$id_application'";

    $result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));
}
echo ("Данные сохранены");

?>