<?php

include "connection.php";

$id_subvision = $_GET['id_sub'];

$rez = mysqli_query($con, "select sum(mark_percent) as sum, count(*) as coun from z_department where id_subvision='$id_subvision'");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_all = $row['coun'];
    $sum = $row['sum'];
    if($count_all === null){
        $count_all = 0.0;
    }
    mysqli_query($con, "update subvision set mark_percent = '$count_all' where id_subvision='$id_subvision'");
}

//$id_application = $_GET['id_application'];
//
//$rez = mysqli_query($con, "select avg(mark_percent) as coun from subvision where id_application='$id_application'");
//
//if (mysqli_num_rows($rez) == 1) //если получена одна строка
//{
//    $row = mysqli_fetch_assoc($rez); //она
//    $count_app = $row['coun'];
//    if($count_app === null){
//        $count_app = 0.0;
//    }
//    mysqli_query($con, "update applications set mark_percent = '$count_app' where id_application='$id_application'");
//}



echo $sum / $count_all;


mysqli_close($con);