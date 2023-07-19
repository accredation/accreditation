<?php
include "connection.php";
$login = $_COOKIE['login'];

$id_application = $_POST['id_application'];

if (!file_exists('documents/'.$login)) {
    mkdir('documents/'.$login, 0777, true);
}



if (isset($_FILES['reportSamoocenka']['name'])) {
    $file_name = $_FILES['reportSamoocenka']['name'];
    $file_tmp = $_FILES['reportSamoocenka']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/" . $file_name);

    $insertquery =
        "UPDATE applications set fileReportSamoocenka = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>