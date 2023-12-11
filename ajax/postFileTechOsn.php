<?php
include "connection.php";
$login = $_COOKIE['login'];
if(!isset($login)){
    $login = $_COOKIE['login1'];
}
$id_application = $_POST['id_application'];

if (!file_exists('../docs/documents/'.$login)) {
    mkdir('../docs/documents/'.$login, 0777, true);
}



if (isset($_FILES['techOsn']['name'])) {
    $file_name = $_FILES['techOsn']['name'];
    $file_tmp = $_FILES['techOsn']['tmp_name'];

    move_uploaded_file($file_tmp, "../docs/documents/" . $login . "/" . $file_name);

    $insertquery =
        "UPDATE applications set tech_osn = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>