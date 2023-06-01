<?php
function out(){
if(isset($_GET['logout'])) {
        include 'connection.php'; 
        $id = $_SESSION['id_user'];

        mysqli_query($con, "UPDATE users SET online=0 WHERE id_user='$id'"); //обнуляется поле online, говорящее, что пользователь вышел с сайта (пригодится в будущем)
        unset($_SESSION['id_user']); //удалятся переменная сессии
        SetCookie("login", ""); //удаляются cookie с логином

        SetCookie("password", ""); //удаляются cookie с паролем
        header('Location: http://'.$_SERVER['HTTP_HOST'].'/index.php'); //перенаправление на главную страницу сайта
    }
}
?>