<?php

include "connection.php";

$id_application = $_GET['id_application'];

$rez = mysqli_query($con, "select sum(dep.mark_accred_percent) as su, count(dep.mark_accred_percent) as coun , a.mark_percent from z_department as dep 
    left outer join subvision s on dep.id_subvision = s.id_subvision
    left outer join applications a on s.id_application = a.id_application
    where a.id_application = '$id_application'");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_all = $row['coun'];
    $sum = $row['su'];
    $mark_percent = $row['mark_percent'];
    if($count_all === null){
        $count_all = 0.0;
    }else{
        $reez = $sum / $count_all;
    }
    $reez  = round($reez,0);
    mysqli_query($con, "update applications set mark_accred_percent = '$reez' where id_application='$id_application'");
}

$response['mark_accred_percent'] = $reez;
$response['mark_percent'] = $mark_percent;

echo json_encode($response);

mysqli_close($con);