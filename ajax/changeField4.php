<?php

include "connection.php";

$idCrit = $_POST['idCrit'];
$idDep = $_POST['idDep'];

include "connection.php";
$login = $_COOKIE['login'];

if(!isset($login)){
    $login = $_COOKIE['login1'];
}

if (!file_exists('../docs/documents/'.$login.'/'.$idDep)) {
    mkdir('../docs/documents/'.$login.'/'.$idDep, 0777, true);
}



if (isset($_FILES['addedFile']['name'])) {
    $file_name = $_FILES['addedFile']['name'];
    $file_tmp = $_FILES['addedFile']['tmp_name'];

    move_uploaded_file($file_tmp, "../docs/documents/" . $login . "/".$idDep . "/". $file_name);

    $insertquery =
        "UPDATE z_answer_criteria SET field4 = CONCAT(IFNULL(field4, ''), '$file_name;') WHERE id_criteria = '$idCrit' AND id_department = '$idDep';";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
mysqli_close($con);