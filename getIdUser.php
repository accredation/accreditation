<?php

function getIdUser()
{
    $login = $_COOKIE['login'];
    $insertquery = "SELECT * FROM users WHERE login='$login'";

    $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
    {
        $row = mysqli_fetch_assoc($rez);
        $id = $row['id_user'];
    }
    return $id;
}