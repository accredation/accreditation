<?php
include "connection.php";


$login = $_COOKIE['login'];
$query = "SELECT * FROM users WHERE login='$login'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_user'];
}

$naim = $_POST['naimUZ'];
$sokr = $_POST['sork'];
$unp = $_POST['unp'];
$adress = $_POST['adress'];
$tel = $_POST['tel'];
$email = $_POST['email'];
$rukovoditel = $_POST['rukovoditel'];
$predstavitel = $_POST['predstavitel'];
$id_application = $_POST['id_application'];



if (!file_exists('documents/'.$login)) {
    mkdir('documents/'.$login, 0777, true);
}


$insertquery =
    "UPDATE applications 
         set naim = '$naim', sokr_naim = '$sokr', unp = '$unp', ur_adress = '$adress',
             tel = '$tel', email = '$email', rukovoditel = '$rukovoditel', predstavitel = '$predstavitel'
where id_application='$id_application'";

$result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));



if (isset($_FILES['soprPismo']['name'])) {
    $file_name = $_FILES['soprPismo']['name'];
    $file_tmp = $_FILES['soprPismo']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/" . $file_name);

    $insertquery =
        "UPDATE applications set soprovod_pismo = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
if (isset($_FILES['copyRaspisanie']['name'])) {
    echo  '123';
    $file_name = $_FILES['copyRaspisanie']['name'];
    $file_tmp = $_FILES['copyRaspisanie']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/" . $file_name);
    $insertquery =
        "UPDATE applications set copy_rasp = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
if (isset($_FILES['orgStrukt']['name'])) {
    $file_name = $_FILES['orgStrukt']['name'];
    $file_tmp = $_FILES['orgStrukt']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/" . $file_name);
    $insertquery =
        "UPDATE applications set org_structure = '$file_name' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}


?>