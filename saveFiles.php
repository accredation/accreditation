<?php
include "connection.php";

$login = $_COOKIE['login'];
$insertquery = "SELECT * FROM users WHERE login='$login'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_user'];
}


$total_cell = $_POST["cell"];
$id_application = $_POST["id_application"];


echo $total_cell;
if (!file_exists('documents/'.$login)) {
    mkdir('documents/'.$login, 0777, true);
}
for ($cell = 0; $cell < $total_cell; $cell++) {
    $total_files = $_POST['index_'.$cell];
    echo $total_files;
    for ($key = 0; $key < $total_files; $key++) {
        if (isset($_FILES['filesPril_'.$cell.'_' . $key]['name'])) {

            $file_name = $_FILES['filesPril_'.$cell.'_' . $key]['name'];
            $file_tmp = $_FILES['filesPril_'.$cell.'_' . $key]['tmp_name'];

            move_uploaded_file($file_tmp, "./documents/".$login."/" . $file_name);


            $insertquery = "SELECT * FROM tablica WHERE id_application='$id_application' and id_type='1'";
            $rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
            if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
            {
                $row = mysqli_fetch_assoc($rez);
                $tablica = $row['id_tablica'];
            }

            $insertquery =
                "INSERT INTO files(`file`,`cell`,`id_user`,`id_application`) VALUES('$file_name','$cell','$id','$id_application')";

            $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
            if ($result) {
                header("Location: " . $_SERVER['REQUEST_URI']);
            }
        } else {
            echo "zxc";
        }
    }
}
?>