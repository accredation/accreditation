<?php
include "../../connection.php";
$crit = $_GET['id_criteria'];
$sub = $_GET['id_sub'];

$insertquery = "SELECT opened FROM rating_criteria WHERE id_criteria='$crit' and id_subvision='$sub'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $opened = $row['opened'];
}
echo $opened;