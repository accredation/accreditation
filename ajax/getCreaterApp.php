<?php
include "connection.php";


$id_application = $_GET['id_application'];

$query = "SELECT us.login FROM applications a 
    left outer join uz u on a.id_user = u.id_uz
    left outer join users us on u.id_uz = us.id_uz
where a.id_application = '$id_application' and us.id_role = 3"
;

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $login = $row['login'];
}


echo $login;
?>