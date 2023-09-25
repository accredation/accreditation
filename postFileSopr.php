<?php
include "connection.php";
$login = $_COOKIE['login'];
if(!isset($login)){
    $login = $_COOKIE['login1'];
}
$id_application = $_POST['id_application'];

if (!file_exists('documents/'.$login)) {
    mkdir('documents/'.$login, 0777, true);
}



if (isset($_FILES['soprPismo']['name'])) {
    $file_name = $_FILES['soprPismo']['name'];
    $file_tmp = $_FILES['soprPismo']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/" . $file_name);

    $insertquery =
        "UPDATE applications set soprovod_pismo = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>