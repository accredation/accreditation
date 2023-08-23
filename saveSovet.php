<?php
include "connection.php";
$login = $_COOKIE['login'];
$id_application = $_POST['id_application'];
//$protokolsoveta = $_FILES['protokolsoveta'];
//$zaklsoveta = $_FILES['zaklsoveta'];
$dateInputPlan = $_POST['dateInputPlan'];
$resolution = $_POST['resolution'];
$dateInputSrok = $_POST['dateInputSrok'];

$query1 = "Update applications set PlanDateSoveta = '$dateInputPlan',  ReshenieSoveta = '$resolution',  SrokResheniaSoveta = '$dateInputSrok' where id_application = '$id_application'";

$result1 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));

if (!file_exists('documents/'.$login . "/" . 'sovets/'. $id_application )) {
    mkdir('documents/'.$login . "/" . 'sovets/'. $id_application , 0777, true);
}

if (isset($_FILES['protokolsoveta']['name'])) {
    $file_name = $_FILES['protokolsoveta']['name'];
    $file_tmp = $_FILES['protokolsoveta']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/sovets/". $id_application  . "/". $file_name);

    $query2 =
        "UPDATE applications set ProtokolSoveta = '$file_name' where id_application='$id_application'";

    $result2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
}




if (isset($_FILES['zaklsoveta']['name'])) {
    $file_name = $_FILES['zaklsoveta']['name'];
    $file_tmp = $_FILES['zaklsoveta']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/sovets/". $id_application . "/" .  $file_name);

    $query3 =
        "UPDATE applications set ZaklSoveta = '$file_name' where id_application='$id_application'";

    $result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));
}
echo ("Данные сохранены");

?>