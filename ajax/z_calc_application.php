<?php

include "connection.php";

$id_application = $_GET['id_application'];

$rez = mysqli_query($con, "select avg(mark_percent) as coun from subvision where id_application='$id_application'");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_all = $row['coun'];
    if($count_all === null){
        $count_all = 0.0;
    }
    mysqli_query($con, "update applications set mark_percent = '$count_all' where id_application='$id_application'");
}


echo $count_all;


mysqli_close($con);