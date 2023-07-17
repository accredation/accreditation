<?php
include "connection.php";

$id_application = $_POST['id_application'];

if (!file_exists('documents/Отчеты/')) {
    mkdir('documents/Отчеты/', 0777, true);
}



if (isset($_FILES['fileReport']['name'])) {
    $file_name = $_FILES['fileReport']['name'];
    $file_tmp = $_FILES['fileReport']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/Отчеты/" . $file_name);

    $insertquery =
        "UPDATE applications set fileReport = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>