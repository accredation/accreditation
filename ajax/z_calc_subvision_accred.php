<?php

include "connection.php";

$id_subvision = $_GET['id_sub'];
$rez = mysqli_query($con, "select sum(mark_accred_percent) as sum, count(*) as coun from z_department where id_subvision='$id_subvision' and mark_accred_percent <> '-'");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_all = $row['coun'];
    $sum = $row['sum'];
    if($sum === null){
        $sum = 0;
    }
    if ($sum === 0 || $count_all ===0){
        $avg = 0;
    } else {
        $avg = $sum / $count_all;
    }

    if($count_all === null){
        $count_all = 0.0;
    }
    $avg  = round($avg,0);
    mysqli_query($con, "update subvision set mark_accred_percent = '$avg' where id_subvision='$id_subvision'");
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



//echo $sum / $count_all;

$rez1 = mysqli_query($con, "select mark_percent from subvision where id_subvision='$id_subvision'");
if (mysqli_num_rows($rez1) == 1) //если получена одна строка
{
    $row1 = mysqli_fetch_assoc($rez1); //она
    $mark_percent = $row1['mark_percent'];
    if($mark_percent === null){
        $mark_percent = 0.0;
    }

}

$response['mark_accred_percent'] = $avg;
$response['mark_percent'] = $mark_percent;
echo json_encode($response);

mysqli_close($con);