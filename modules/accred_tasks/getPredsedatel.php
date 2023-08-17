<?php

include "../../connection.php";

$id_application = $_GET['id_application'];
$id_role = $_GET['id_role'];
$query = "SELECT u.id_user, u.username
FROM users u 
WHERE u.predsedatel = 1 and 
(('$id_role' < 3 ) 
or ('$id_role' > 2 and '$id_role'=u.id_role )) ";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$data = array();
if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);

    $date_accept = $row['date_accept'];
    $date_complete = $row['date_complete'];
    $date_council = $row['date_council'];
}
array_push($data,$date_accept);
array_push($data,$date_complete);
array_push($data,$date_council);
echo json_encode($data);
?>
