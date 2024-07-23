<?php

include "connection.php";

$idCrit = $_POST['idCrit'];
$idDep = $_POST['idDep'];
$id_application = $_POST['idApp'];
$id_answer_criteria = $_POST['idAnswerCriteria'];



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
mysqli_close($con);