<?php

include "connection.php";

$idCrit = $_POST['idCrit'];
$idDep = $_POST['idDep'];
$id_application = $_POST['idApp'];
$id_answer_criteria = $_POST['idAnswerCriteria'];
$id_userOlys = $_POST['id_userOlys'];



$query = "SELECT u.login
FROM `applications` a 
left outer join uz on a.id_user=uz.id_uz
left outer join users u on uz.id_uz=u.id_uz and u.id_role=3
WHERE id_application= '$id_application'
";


$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));



if(mysqli_num_rows($rez) == 1){
    $row = mysqli_fetch_assoc($rez);
    $login = $row['login'];
}


if (!file_exists('../docs/documents/'.$login.'/'.$id_application.'/'.$idDep)) {
    mkdir('../docs/documents/'.$login.'/'.$id_application.'/'.$idDep, 0777, true);

}
if(substr(sprintf('%o', fileperms('../docs/documents/'.$login.'/'.$id_application.'/'.$idDep)), -4) != 0777)
    chmod('../docs/documents/'.$login.'/'.$id_application.'/'.$idDep, 0777);

if (isset($_FILES['addedFile']['name'])) {
    $file_name = $_FILES['addedFile']['name'];
    $file_tmp = $_FILES['addedFile']['tmp_name'];

    move_uploaded_file($file_tmp, "../docs/documents/" . $login.'/'.$id_application . "/".$idDep . "/". $file_name);

    $insertquery =
        "UPDATE z_answer_criteria SET field4 = CONCAT(IFNULL(field4, ''), '$file_name;') WHERE id_answer_criteria = '$id_answer_criteria';";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}

function getUserIpAddr() {
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        $ip = $_SERVER['HTTP_CLIENT_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else {
        $ip = $_SERVER['REMOTE_ADDR'];
    }
    return $ip;
}
$ip_address = getUserIpAddr();
$date_create = date('Y-m-d H:i:s');
$action = "Загрузка документа field4 с именем:  $file_name";
$id_subvision = 0;

$sqlinsert = "INSERT INTO Aalog1_actions (date_create, action, ip_adress, id_user, id_application, id_subvision, id_department, id_answer_criteria, id_crit) 
VALUES ('$date_create', '$action', '$ip_address', '$id_userOlys', '$id_application', '$id_subvision', '$idDep', '$id_answer_criteria' , '$idCrit')";
if (mysqli_query($con, $sqlinsert)) {
    echo "Запись успешно добавлена в логи.";
} else {
    echo "Ошибка: " . $sqlinsert . "<br>" . mysqli_error($con);
}


mysqli_close($con);