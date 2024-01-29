<?php
function phpAlert($msg)
{
    echo '<script type="text/javascript">alert("' . $msg . '")</script>';
}

?>

<?php

function lastAct($id, $sesId)
{
    include 'ajax/connection.php';
    $time = date('Y-m-d H:i:s');
    $timeSession = mktime(date("H") + 2, date("i") , date("s"), date("m"), date("d"), date("Y"));
    $timeSession1 = date("Y-m-d H:i:s", $timeSession);
    $page = $_SERVER['REQUEST_URI'];
    setcookie("ageSession", $timeSession1);
    mysqli_query($con, "UPDATE users SET online='$sesId', last_act='$sesId', last_time_online='$time', last_page='$page', last_time_session='$timeSession1' WHERE id_user='$id'");
}

function login()
{
    include 'ajax/connection.php';

    ini_set("session.use_trans_sid", true);
    session_start();

    if (isset($_SESSION['id_user'])) //если сесcия есть
    {

        if (isset($_COOKIE['login']) && isset($_COOKIE['password'])) //если cookie есть, обновляется время их жизни и возвращается true
        {
            $id = $_SESSION['id_user'];

            $sesId = $_COOKIE['PHPSESSID'];

            setcookie("login", $_COOKIE['login'], time() + 1800, "/");
            setcookie("password", $_COOKIE['password'], time() + 1800, "/");
            if ($_COOKIE['isMA'] == 1) {
                setcookie("isMA", 1, time() + 1800, "/");
            } else {
                setcookie("isMA", 0, time() + 1800, "/");
            }
            if ($_COOKIE['secretar'] == 1) {
                setcookie("secretar", 1, time() + 1800, "/");
            } else {
                setcookie("secretar", 0, time() + 1800, "/");
            }
            if ($_COOKIE['predsedatel'] == 1) {
                setcookie("predsedatel", 1, time() + 1800, "/");
            } else {
                setcookie("predsedatel", 0, time() + 1800, "/");
            }
            if ($_COOKIE['expert'] == 1) {
                setcookie("expert", 1, time() + 1800, "/");
            } else {
                setcookie("expert", 0, time() + 1800, "/");
            }
            lastAct($id, $sesId);

            return true;

        } else //иначе добавляются cookie с логином и паролем, чтобы после перезапуска браузера сессия не слетала
        {
            $rez = mysqli_query($con, "SELECT * FROM users WHERE id_user='{$_SESSION['id_user']}'"); //запрашивается строка с искомым id

            if (mysqli_num_rows($rez) == 1) //если получена одна строка
            {
                $row = mysqli_fetch_assoc($rez); //она записывается в ассоциативный массив

                setcookie("login", $row['login'], time() + 10, "/");

                setcookie("password", md5($row['login'] . $row['password']), time() + 1800, "/");

                $id = $_SESSION['id_user'];
                setcookie("id_user", $id);
                if ($row['sotrudnik_MA'] == "1") {
                    setcookie("isMA", 1, time() + 1800, "/");
                } else {
                    setcookie("isMA", 0, time() + 1800, "/");
                }
                if ($row['secretar'] == 1) {
                    setcookie("secretar", 1, time() + 1800, "/");
                } else {
                    setcookie("secretar", 0, time() + 1800, "/");
                }
                if ($row['predsedatel'] == 1) {
                    setcookie("predsedatel", 1, time() + 1800, "/");
                } else {
                    setcookie("predsedatel", 0, time() + 1800, "/");
                }
                if ($row['doctor_expert'] == 1) {
                    setcookie("expert", 1, time() + 1800, "/");
                } else {
                    setcookie("expert", 0, time() + 1800, "/");
                }
                $sesId = $_COOKIE['PHPSESSID'];
                if ($row['online'] == "0") {
                    lastAct($id, $sesId);
                } else if ($row['online'] == $sesId) {
                    lastAct($id, $sesId);
                }
                return true;
            } else
                return false;
        }
    }
    return true;
}


?>
