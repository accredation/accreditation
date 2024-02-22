<?php
include '../ajax/connection.php';
$id = $_GET['id'];
SetCookie("login1", $_COOKIE["login"]);
mysqli_query($con, "UPDATE users SET online=0, last_time_session=null WHERE id_user='$id'"); //обнуляется поле online, говорящее, что пользователь вышел с сайта (пригодится в будущем)
unset($_SESSION['id_user']); //удалятся переменная сессии

SetCookie("login", "", time() - (86400 * 30), "/");
SetCookie("PHPSESSID", "", time() - (86400 * 30), "/");
SetCookie("isMA", "", time() - (86400 * 30), "/");
SetCookie("id_user", "", time() - (86400 * 30), "/");
SetCookie("expert", "", time() - (86400 * 30), "/");
SetCookie("predsedatel", "", time() - (86400 * 30), "/");
SetCookie("secretar", "", time() - (86400 * 30), "/");
SetCookie("password", "", time() - (86400 * 30), "/");

//header('Location: http://'.$_SERVER['HTTP_HOST'].'/index.php'); //перенаправление на главную страницу сайта


