<?php
function phpAlert($msg) {
    echo '<script type="text/javascript">alert("' . $msg . '")</script>';
}
?>
<?php

function enter($sesId)
{
  include 'connection.php';
      $error = array(); //массив для ошибок
    if ($_POST['login'] != "" && $_POST['password'] != "") //если поля заполнены
        {
        $login       = $_POST['login'];
        $password    = $_POST['password'];
        $insertquery = "SELECT * FROM users WHERE login='$login'";

        $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

        if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
            {
            $row = mysqli_fetch_assoc($rez);
            if (md5($password) == $row['password']) //сравнивается хэшированный пароль из базы данных с хэшированными паролем, введённым пользователем
                {
                //пишутся логин и хэшированный пароль в cookie, также создаётся переменная сессии
                setcookie("login", $row['login'], time() + 50000);
                setcookie("password", md5($row['login'] . $row['password']), time() + 50000);
                $_SESSION['id_user'] = $row['id_user']; //записываем в сессию id пользователя

                $id = $_SESSION['id_user'];

                if($row['online'] == "0"){
                    lastAct($id,$sesId);
                }
                else if($sesId != $row['online']){
                    lastAct($id,$sesId);
                }


                return $error;
            } else //если пароли не совпали
                {
                $error[] = "Неверный пароль";
                return $error;
            }
        } else //если такого пользователя не найдено в базе данных
            {
            $error[] = "Неверный логин и пароль";
            return $error;
        }
    }


    else {
        $error[] = "Поля не должны быть пустыми!";
        return $error;
    }
    $con.close();
}

function lastAct($id, $sesId)
{
   include 'connection.php';
    $time = date('Y-m-d H:i:s');
    $page =  $_SERVER['REQUEST_URI'];
    mysqli_query($con, "UPDATE users SET online='$sesId', last_act='$sesId', last_time_online='$time', last_page='$page' WHERE id_user='$id'");
}

function login()
{
    include 'connection.php';
    ini_set("session.use_trans_sid", true);
    session_start();


                    if (isset($_SESSION['id_user'])) //если сесcия есть
                        {
                        if (isset($_COOKIE['login']) && isset($_COOKIE['password'])) //если cookie есть, обновляется время их жизни и возвращается true
                            {
                                $id = $_SESSION['id_user'];
                                $rez = mysqli_query($con, "SELECT * FROM users WHERE id_user='{$_SESSION['id_user']}'"); //запрашивается строка с искомым id

                                if (mysqli_num_rows($rez) == 1) //если получена одна строка
                                    {
                                        $sesId = $_COOKIE['PHPSESSID'];
                                        $row = mysqli_fetch_assoc($rez); //она записывается в ассоциативный массив
                                        if($row['online'] != $sesId){
                                            phpAlert("В аккаунт кто то вошел");
                                            SetCookie("login", ""); //удаляются cookie с логином

                                            SetCookie("password", ""); //удаляются cookie с паролем
                                            SetCookie("PHPSESSID", ""); //удаляются cookie с паролем
                                            header('Location: http://'.$_SERVER['HTTP_HOST'].'/login.php');

                                            return false;
                                        }
                                        lastAct($id,$sesId);
                                    }
                            return true;

                        } else //иначе добавляются cookie с логином и паролем, чтобы после перезапуска браузера сессия не слетала
                            {
                                $rez = mysqli_query($con,"SELECT * FROM users WHERE id_user='{$_SESSION['id_user']}'"); //запрашивается строка с искомым id

                                if (mysqli_num_rows($rez) == 1) //если получена одна строка
                                    {
                                    $row = mysqli_fetch_assoc($rez); //она записывается в ассоциативный массив

                                    setcookie("login", $row['login'], time() + 360000, '/');

                                    setcookie("password", md5($row['login'] . $row['password']), time() + 360000, '/');

                                    $id = $_SESSION['id_user'];
                                    $sesId = $_COOKIE['PHPSESSID'];
                                    if($row['online'] == "0"){
                                        lastAct($id, $sesId);
                                    }
                                    else if($row['online'] == $sesId){
                                        lastAct($id, $sesId);
                                    }
                                    return true;
                                } else
                                    return false;
                            }
                    } else //если сессии нет, проверяется существование cookie. Если они существуют, проверяется их валидность по базе данных
                        {
                        if (isset($_COOKIE['login']) && isset($_COOKIE['password'])) //если куки существуют
                            {

                            $rez = mysqli_query($con, "SELECT * FROM users WHERE login='{$_COOKIE['login']}'"); //запрашивается строка с искомым логином и паролем
                            @$row = mysqli_fetch_assoc($rez);

                            if (@mysqli_num_rows($rez) == 1 && md5($row['login'] . $row['password']) == $_COOKIE['password'] && isset($_COOKIE['PHPSESSID'])) //если логин и пароль нашлись в базе данных
                                {
                                $_SESSION['id_user'] = $row['id_user']; //записываем в сесиию id
                                $id                  = $_SESSION['id_user'];

                                $sesId = $_COOKIE['PHPSESSID'];
                                if($row['online'] == "0"){
                                    lastAct($id, $sesId);
                                }
                                else if($row['online'] == $sesId){
                                    lastAct($id, $sesId);
                                }
                                else{
                                    phpAlert("Уже занято");
                                    SetCookie("login", ""); //удаляются cookie с логином

                                    SetCookie("password", ""); //удаляются cookie с паролем
                                    header('Location: http://'.$_SERVER['HTTP_HOST'].'/login.php');
                                }
                                return true;
                            } else //если данные из cookie не подошли, эти куки удаляются
                                {
                                SetCookie("login", "", time() - 360000, '/');

                                SetCookie("password", "", time() - 360000, '/');
                                return false;
                            }
                        } else //если куки не существуют
                            {
                            return false;
                        }
                    }
                }


?>
