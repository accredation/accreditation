<?php

include "../../ajax/connection.php";

$id_application = $_GET['id_application'];
$query = "SELECT * FROM applications, users WHERE id_application='$id_application' and applications.id_user=users.id_user ";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$data = array();
if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);

    $date_accept = $row['date_begin_prov'];
    $date_complete = $row['date_end_prov'];
    $date_council = $row['date_council'];
}
array_push($data,$date_accept);
array_push($data,$date_complete);
array_push($data,$date_council);
echo json_encode($data);
?>