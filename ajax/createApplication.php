<?php
include "connection.php";
$login = $_COOKIE['login'];


$insertquery = "SELECT uz.id_uz, uz.username  FROM accreditation.uz left outer join accreditation.users us on uz.id_uz = us.id_uz WHERE login='$login'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_uz'];
    $name = $row['username'];
}
$query = "Select count(id_application) as count_str from applications where id_user = '$id' and id_status not in (7,8)";
$rez1 = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


if (mysqli_num_rows($rez1) == 1) {
    $row1 = mysqli_fetch_assoc($rez1);
    $count_str = $row1['count_str'];

    if ($count_str == "0") {
            mysqli_query($con, "Insert into applications(`id_user`, `id_status`, `naim`, `date_create_app`) values ('$id', 1, '$name', CURDATE())");
    }
    else{
        $query1 = "Select * from applications where id_user = '$id' and id_status = 9 and pervtor = 1";
        $rez2 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));
        if (mysqli_num_rows($rez2) == 1) {
            $row = mysqli_fetch_assoc($rez2);
            $id_rkk = $row['id_rkk'];
            mysqli_query($con, "Insert into applications(`id_user`, `id_status`, `naim`, `date_create_app`, pervtor, id_rkk_perv ) values ('$id', 1, '$name', CURDATE(),2, '$id_rkk')");
        }
    }
//        mysqli_query($con, "Insert into subvision(`name`,`id_application`)  select '$name', id_application from applications where id_user='$id' and id_status=1");


}
?>