<?php
include "connection.php";

$login = $_COOKIE['login'];
$insertquery = "SELECT * FROM users WHERE login='$login'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_user'];
}

$id_application = $_GET['id_application'];

$query = "SELECT * FROM applications WHERE id_application='$id_application'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$cells = array();
if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $dov = $row['copy_rasp'];
    $naim = $row['naim'];
    $unp = $row['unp'];
}

array_push($cells,$naim);
array_push($cells,$dov);
array_push($cells,$unp);

echo json_encode($cells);
?>