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
$unp = $_POST['unp'];
$id_application = $_POST['id_application'];

echo $naim;
echo $id_application;
if (!file_exists('documents/'.$login)) {
    mkdir('documents/'.$login, 0777, true);
}
if (isset($_FILES['doverennost']['name'])) {

    $file_name = $_FILES['doverennost']['name'];
    $file_tmp = $_FILES['doverennost']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . $login . "/" . $file_name);
    $insertquery =
        "UPDATE applications set copy_rasp = '$file_name', naim = '$naim', unp = '$unp' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}else {

    $insertquery =
        "UPDATE applications set naim = '$naim', unp = '$unp' where id_application='$id_application'";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
?>