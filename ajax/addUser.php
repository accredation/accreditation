<?php
include "connection.php";

$username = $_POST['name'];
$login = $_POST['login'];
$password = $_POST['password'];
$email = $_POST['email'];
$role = $_POST['role'];
$hashPassword = md5($password);

$query = "select * from users where login='$login'";
$result = mysqli_query($con, $query);
if(mysqli_num_rows($result) == 0){
    $query = "INSERT INTO users (username, id_uz, login, password, email, id_role) VALUES ('$username', 695, '$login', '$hashPassword', '$email', '$role')";
    mysqli_query($con, $query);
    echo "User added successfully!";
}else{
    http_response_code(501);
}
