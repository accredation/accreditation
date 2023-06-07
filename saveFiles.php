<?php
include "connection.php";
include "getIdUser.php";

$idUser = getIdUser();
//move_uploaded_file($_FILES["fil"]["tmp_name"],$_FILES["fil"]["name"]);
//
//sleep(2);
//echo "Данные: цифра - ".$_POST['number'];
//    $count = $_POST['number'];
//    for ($i = 0; $i < $count; $i++)
//        move_uploaded_file($_FILES["filPril_" . $i]["tmp_name"], $_FILES["filPril_" . $i]["name"]);
//foreach($_FILES as $file)
//    move_uploaded_file($file["tmp_name"], $file["name"]);

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
                "INSERT INTO files(`file`,`cell`,`id_user`) VALUES('$file_name','$cell','$idUser')";

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