<?php
include "connection.php";
$id_user = $_GET['id_user'];
$login = $_GET['login'];
$password = $_GET['password'];
$md5Pass = md5($password);
$rez1 = mysqli_query($con,  "select password from users where password = '$password'");
if (mysqli_num_rows($rez1) > 0){
    http_response_code(300);
}else{
    $rez2 = mysqli_query($con,  "select * from users where login = '$login' and id_user <> '$id_user'");
    if (mysqli_num_rows($rez2) > 0){
        http_response_code(400);
    }else {

        mysqli_query($con, "update users set login = '$login', password='$md5Pass', id_role = '15' where id_user = '$id_user'");
    }

}

?>