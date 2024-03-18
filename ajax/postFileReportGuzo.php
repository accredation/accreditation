<?php
include "connection.php";
$id_application = $_POST['id_application'];
$login = $_POST['login'];
if (!file_exists('../docs/documents/' . $login . '/' . $id_application . '/')) {
    mkdir('../docs/documents/' . $login . '/' . $id_application . '/', 0777, true);
}
if (isset($_FILES['fileReport']['name'])) {
    $fileNames = array();
    foreach ($_FILES['fileReport']['name'] as $key => $value) {
        $file_name = $_FILES['fileReport']['name'][$key];
        $file_tmp = $_FILES['fileReport']['tmp_name'][$key];
        move_uploaded_file($file_tmp, '../docs/documents/' . $login . '/' . $id_application . '/' . $file_name);
        $fileNames[] = $file_name;
    }

    $fileNamesString = implode(";", $fileNames);

    $insertquery = "UPDATE applications set fileReport = '$fileNamesString' where id_application='$id_application'";
    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>