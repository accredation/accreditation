<?php
include "connection.php";

$id_application = $_GET['id_app'];

$query = "SELECT activ_cursor
FROM applications 
where id_application = '$id_application'";


$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $activ_cursor = $row['activ_cursor'];
}
echo $activ_cursor;
?>