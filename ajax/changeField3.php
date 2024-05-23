<?php

include "connection.php";

$idCrit = $_GET['idCrit'];
$idDep = $_GET['idDep'];
$val = $_GET['val'];

mysqli_query($con, "update z_answer_criteria set field3 = '$val' where id_criteria='$idCrit' and id_department='$idDep'");
$rez = mysqli_query($con, "select count(*) as coun from z_answer_criteria where id_department='$idDep'");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_all = $row['coun'];
}

$rez = mysqli_query($con, "select count(*) as coun from z_answer_criteria where id_department='$idDep' and field3 = 1");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_yes = $row['coun'];
}

$rez = mysqli_query($con, "select count(*) as coun from z_answer_criteria where id_department='$idDep' and field3 = 3");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_notneed = $row['coun'];
}

if($count_all - $count_notneed !== 0)
    $mark_department = ($count_yes / ($count_all - $count_notneed)) * 100;


if($count_yes === "0"){
    $mark_department = 0;
}
$mark_department = round ($mark_department,0);
if($count_all === $count_notneed ){
    $mark_department = "-";
}

mysqli_query($con, "update z_department set mark_percent = '$mark_department', mark_all = '$count_all', mark_yes='$count_yes', mark_not_need='$count_notneed' where id_department='$idDep'");

$id_subvision = $_GET['id_sub'];

$rez = mysqli_query($con, "select avg(mark_percent) as coun from z_department where id_subvision='$id_subvision'");

if (mysqli_num_rows($rez) == 1) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_all = $row['coun'];
    if($count_all === null){
        $count_all = 0.0;
    }
    $count_all = round ($count_all,0);
    mysqli_query($con, "update subvision set mark_percent = '$count_all' where id_subvision='$id_subvision'");
}


mysqli_close($con);