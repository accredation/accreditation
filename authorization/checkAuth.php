<?php
include '../ajax/connection.php';
$error = array(); //массив для ошибок

$ip = $_SERVER['REMOTE_ADDR'];
if ($ip == "80.94.166.115" || $ip == "212.98.179.59") {
    echo '1';
    return;
}

    $login = $_POST['login'];
    $kod = $_POST['kod'];

    $insertquery = "SELECT * FROM users WHERE login='$login' and active = 1 and kod = '$kod'";

    $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
    {
        $row = mysqli_fetch_assoc($rez);
        echo "Да";

    } else //если такого пользователя не найдено в базе данных
    {
        $error[] = "Неверный логин и пароль";
        echo json_encode($error);
    }


