<?php
include "connection.php";
$id_user = $_GET['id_user'];
$login = $_GET['login'];
$email = $_GET['email'];
$password = $_GET['password'];
$id_role = $_GET['id_role'];
$md5Pass = md5($password);
$rez1 = mysqli_query($con,  "select password from users where password = '$md5Pass'");
if (mysqli_num_rows($rez1) > 0){
    http_response_code(300);
}else{
    $rez2 = mysqli_query($con,  "select * from users where login = '$login' and id_user <> '$id_user'");
    if (mysqli_num_rows($rez2) > 0){
        http_response_code(400);
    }else {

        mysqli_query($con, "update users set login = '$login', email = '$email', password='$md5Pass', id_role = '$id_role' where id_user = '$id_user'");
    }

}

?>