<?php
include "connection.php";


$naim = $_GET['naim'];

$query = "SELECT * FROM applications, users WHERE naim='$naim' and users.id_user = applications.id_user";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$cells = array();
if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $dov = $row['copy_rasp'];
    $unp = $row['unp'];
    $login = $row['login'];
}

array_push($cells,$login);
array_push($cells,$naim);
array_push($cells,$dov);
array_push($cells,$unp);

echo json_encode($cells);
?>