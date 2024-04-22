<?php

include "../../ajax/connection.php";
$id_uz = $_POST['id_uz'];
$idProfileStr = $_POST['idProfileStr'];
$idVidStr =  $_POST['idVidStr'];

$query = "insert into accreditation.uz_vid_profile (id_uz, date_create, id_profile_str, id_vid_str) values ('$id_uz', CURRENT_DATE(), '$idProfileStr', '$idVidStr')";
mysqli_query($con, $query);


$idProfileStr2 = explode(',', $idProfileStr);
$idVidStr2 = explode(',', $idVidStr);

foreach ($idProfileStr2 as $app) { 
    $query1 = "insert into accreditation.uz_profile (id_uz, id_profile) values ('$id_uz', '$app')";
    mysqli_query($con, $query1);
}

foreach ($idVidStr2 as $app1) { 
    $query2 = "insert into accreditation.uz_vid (id_uz, id_vid) values ('$id_uz', '$app1')";
    mysqli_query($con, $query2);
}


mysqli_close($con);
