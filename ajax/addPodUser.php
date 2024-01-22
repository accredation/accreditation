<?php
include "connection.php";
$id_userMain = $_COOKIE['id_user'];
$login = $_GET['login'];
$password = $_GET['password'];
$email = $_GET['email'];
$md5Pass = md5($password);

$rez = mysqli_query($con, "select id_uz from users where id_user = '$id_userMain'"); //запрашивается строка с искомым id
$rez2 = mysqli_query($con,  "select * from users where login = '$login'");
if (mysqli_num_rows($rez2) > 0){
    http_response_code(400);
}else {
    if (mysqli_num_rows($rez) == 1) //если получена одна строка
    {

        $row = mysqli_fetch_assoc($rez); //она записывается в ассоциативный массив
        $id_uz = $row['id_uz'];
        mysqli_query($con, "Insert into users(`login`, `email`,`password`, `id_role`, `id_uz`) values('$login','$email','$md5Pass', '15', '$id_uz') ");
    }
}
?>