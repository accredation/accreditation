<?php
include "connection.php";
$login = $_COOKIE['login'];
if(!isset($login)){
    $login = $_COOKIE['login1'];
}
$id_application = $_POST['id_application'];
$new_id_application = $id_application;
$query = "SELECT * FROM applications WHERE id_application = '$id_application'";
$result = mysqli_query($con, $query);
$row = mysqli_fetch_assoc($result);
$selPervtor = $row['sel_pervtor'];
$idOldApp = $row['id_old_app'];
$id_applicationnew = $row['id_application'];
if ($idOldApp !== null && $idOldApp !== '')
{
    $id_application = $idOldApp;
}
else{
    $id_application = $id_applicationnew;
}

if (!file_exists('../docs/documents/'.$login.'/'.$id_application)) {
    mkdir('../docs/documents/'.$login.'/'.$id_application, 0777, true);
}



if (isset($_FILES['techOsn']['name'])) {
    $file_name = $_FILES['techOsn']['name'];
    $file_tmp = $_FILES['techOsn']['tmp_name'];

    move_uploaded_file($file_tmp, "../docs/documents/" . $login.'/'.$id_application . "/" . $file_name);

    $insertquery =
        "UPDATE applications set tech_osn = '$file_name' where id_application='$new_id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>