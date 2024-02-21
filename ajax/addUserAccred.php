<?php
include "connection.php";

$login = $_GET['login'];
$password = $_GET['password'];
$email = $_GET['email'];
$md5Pass = md5($password);


$rez2 = mysqli_query($con,  "select * from users where login = '$login'");
if (mysqli_num_rows($rez2) > 0){
    http_response_code(400);
}else {


        mysqli_query($con, "Insert into users(`login`, `email`,`password`, `id_role`, `id_uz`) values('$login','$email','$md5Pass', '2', '1') ");

}
?>