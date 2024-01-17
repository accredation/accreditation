<?php
include "connection.php";
$login = $_COOKIE['login'];
if(!isset($login)){
    $login = $_COOKIE['login1'];
}
$id_application = $_POST['id_application'];


if (!file_exists('../docs/documents/'.$login.'/'.$id_application)) {
    mkdir('../docs/documents/'.$login.'/'.$id_application, 0777, true);
}



if (isset($_FILES['copyRasp']['name'])) {
    $file_name = $_FILES['copyRasp']['name'];
    $file_tmp = $_FILES['copyRasp']['tmp_name'];

    move_uploaded_file($file_tmp, "../docs/documents/" . $login.'/'.$id_application . "/" . $file_name);

    $insertquery =
        "UPDATE applications set copy_rasp = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>