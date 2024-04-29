<?php

include "../../ajax/connection.php";
$id_uz_vid_profile = $_POST['id_uz_vid_profile'];
$idProfileStr = $_POST['idProfileStr'];
$idVidStr =  $_POST['idVidStr'];
$id_uz =  $_POST['id_uz'];



$idProfileStr2 = explode(',', $idProfileStr);
$idVidStr2 = explode(',', $idVidStr);

mysqli_query($con, "delete from accreditation.uz_profile where id_uz = '$id_uz'");
mysqli_query($con, "delete from accreditation.uz_vid where uz_vid.id_uz = '$id_uz'");

$query = "update accreditation.uz_vid_profile set id_profile_str = '$idProfileStr', id_vid_str = '$idVidStr' where id_uz_vid_profile='$id_uz_vid_profile' ";

mysqli_query($con, $query);

foreach ($idProfileStr2 as $app) { 
    $query1 = "insert into accreditation.uz_profile (id_uz, id_profile) values ('$id_uz', '$app')";
    mysqli_query($con, $query1);
}

foreach ($idVidStr2 as $app1) { 
    $query2 = "insert into accreditation.uz_vid (id_uz, id_vid) values ('$id_uz', '$app1')";
    mysqli_query($con, $query2);
}




mysqli_close($con);
