<?php

                include '../ajax/connection.php';
                $id = $_POST['id_user'];
                echo "id_USER: ". $id;
                mysqli_query($con, "UPDATE users SET online=0, last_time_session = null WHERE id_user='$id'"); //обнуляется поле online, говорящее, что пользователь вышел с сайта (пригодится в будущем)

                SetCookie("login", ""); //удаляются cookie с логином
                SetCookie("isMA", ""); //удаляются cookie с логином
                SetCookie("id_user", ""); //удаляются cookie с логином
                SetCookie("expert", ""); //удаляются cookie с логином
                SetCookie("predsedatel", ""); //удаляются cookie с логином
                SetCookie("secretar", ""); //удаляются cookie с логином
                SetCookie("ageSession", ""); //удаляются cookie с логином

                SetCookie("password", ""); //удаляются cookie с паролем
//                header('Location: http://'.$_SERVER['HTTP_HOST'].'/login.php'); //перенаправление на главную страницу сайта
