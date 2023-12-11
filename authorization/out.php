<?php
    function out(){
        if(isset($_GET['logout'])) {
                include 'ajax/connection.php';
                $id = $_SESSION['id_user'];
                SetCookie("login1", $_COOKIE["login"]);
                mysqli_query($con, "UPDATE users SET online=0, last_time_session=null WHERE id_user='$id'"); //обнуляется поле online, говорящее, что пользователь вышел с сайта (пригодится в будущем)
                unset($_SESSION['id_user']); //удалятся переменная сессии

                SetCookie("login", ""); //удаляются cookie с логином
                SetCookie("isMA", ""); //удаляются cookie с логином
                SetCookie("id_user", ""); //удаляются cookie с логином
                SetCookie("expert", ""); //удаляются cookie с логином
                SetCookie("predsedatel", ""); //удаляются cookie с логином
                SetCookie("secretar", ""); //удаляются cookie с логином
                SetCookie("ageSession", ""); //удаляются cookie с логином

                SetCookie("password", ""); //удаляются cookie с паролем
                header('Location: http://'.$_SERVER['HTTP_HOST'].'/index.php'); //перенаправление на главную страницу сайта
            }
    }
?>