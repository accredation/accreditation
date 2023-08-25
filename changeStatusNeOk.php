<?php
include "connection.php";
$login = $_COOKIE['login'];
$id_application = $_POST['id_application'];
$dateInputDorabotki = $_POST['dateInputDorabotki'];


$query1 = "Update applications  set `id_status` = 5,  `date_complete` = CURDATE() , dateInputDorabotki = '$dateInputDorabotki'  where id_application = '$id_application'";

$result1 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));

if (!file_exists('documents/' . 'dorabotka/'. $id_application )) {
    mkdir('documents/'  . 'dorabotka/'. $id_application , 0777, true);
}

if (isset($_FILES['fileDorabotka']['name'])) {
    $file_name = $_FILES['fileDorabotka']['name'];
    $file_tmp = $_FILES['fileDorabotka']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . "dorabotka/". $id_application  . "/". $file_name);

    $query2 =
        "UPDATE applications set infDorabotkiFile = '$file_name' where id_application='$id_application'";

    $result2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
}

echo ("Данные сохранены");
?>