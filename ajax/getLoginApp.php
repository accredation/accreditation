<?php
include 'connection.php';
    $id_app = $_GET['id_app'];
    $query = "SELECT login FROM users as us, applications as app WHERE app.id_application = '$id_app' and app.id_user = us.id_user;";

    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

    if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
    {
        $row = mysqli_fetch_assoc($rez);
        $responce['loginApp'] = $row['login'];
    }
    echo json_encode($responce);
    mysqli_close($con);
    ?>