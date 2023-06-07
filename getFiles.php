<?php
include "connection.php";

$login = $_COOKIE['login'];
$insertquery = "SELECT * FROM users WHERE login='$login'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_user'];
}


$query = "SELECT * FROM files where id_user='$id'";
$filesName = array();


$result=mysqli_query($con, $query) or die ( mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
foreach ($data as $user) {
    array_push($filesName, $user['file']);
}

echo 'filesName.push('.json_encode($filesName).');';

?>