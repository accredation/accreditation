<?php
include "connection.php";
$login = $_COOKIE['login'];
$insertquery = "SELECT * FROM users WHERE login='$login'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_user'];
    $name = $row['username'];
}


mysqli_query($con, "Insert into applications(`id_user`, `id_status`, `naim`) values ('$id', 1, '$name')");
mysqli_query($con, "Insert into subvision(`name`,`id_application`)  select '$name', id_application from applications where id_user='$id' and id_status=1");
?>