<?php

include '../ajax/connection.php';
$error = array(); //массив для ошибок


if ($_POST['login'] != "" && $_POST['password'] != "") //если поля заполнены
{
    $login = $_POST['login'];
    $password = $_POST['password'];
    $insertquery = "SELECT * FROM users WHERE login='$login' and active = 1";

    $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
    {


        $row = mysqli_fetch_assoc($rez);

        if (md5($password) == $row['password']) //сравнивается хэшированный пароль из базы данных с хэшированным паролем, введенным пользователем
        {

                    $time = date('Y-m-d H:i:s');


                       //////////////////////

                        $kod = rand(1000, 9999);
                        $insertquery = "update users set kod = '$kod' WHERE login='$login' ";

                        $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

                        $textSubj = "Код для авторизации в мед.аккредитации";
                        $msg = "Ваш код авторизации:\n
                        $kod для логина $login";
                        $headers = 'From: support@rnpcmt.by' . "\r\n" .
                            'Content-type: text/html; charset=utf-8' . "\r\n" .
                            'X-Mailer: PHP/' . phpversion();

                        mail($row['email'], $textSubj, $msg, $headers);
                            echo "1";


                        return;
                       ///////////////////////




        } else //если пароли не совпали
        {
            $error[] = "Неверный пароль";
            echo json_encode($error);
        }
    } else //если такого пользователя не найдено в базе данных
    {
        $error[] = "Неверный логин и пароль";
        echo json_encode($error);
    }
} else {
    $error[] = "Поля не должны быть пустыми!";
    echo json_encode($error);
}

