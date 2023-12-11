<?php
include "connection.php";

$id_application = $_POST['id_application'];
$name = $_POST['name'];

    $insertquery =
        "Insert into subvision(`name`,`id_application`) values ('$name','$id_application')";

    mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));


$query = "SELECT * FROM subvision WHERE id_application = '$id_application' and name = '$name'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_subvision'];
}
echo $id;
?>