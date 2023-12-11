<?php
include "connection.php";

if(isset($_COOKIE['login'])) {
    $login = $_COOKIE['login'];
    $query = "SELECT * FROM users where login = '$login'";

    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
    {
        $row = mysqli_fetch_assoc($rez);
        $role = $row['id_role'];
    }
}