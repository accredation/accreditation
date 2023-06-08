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


echo $total_cell;
for ($cell = 0; $cell < $total_cell; $cell++) {
    $total_files = $_POST['index_'.$cell];
    echo $total_files;
    for ($key = 0; $key < $total_files; $key++) {
        if (isset($_FILES['filesPril_'.$cell.'_' . $key]['name'])) {

            $file_name = $_FILES['filesPril_'.$cell.'_' . $key]['name'];
            $file_tmp = $_FILES['filesPril_'.$cell.'_' . $key]['tmp_name'];

            move_uploaded_file($file_tmp, "./documents/" . $file_name);

            $insertquery =
                "INSERT INTO files(`file`,`cell`,`id_user`) VALUES('$file_name','$cell','$id')";

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