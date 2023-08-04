<?php
include "connection.php";
echo "0";
$date = date('Y-m-d');
$id_user = $_POST['id_user'];
$question = $_POST['question'];
$typeQuestion = $_POST['typeQuestion'];
echo "1";
if (isset($_FILES['screenQuestion']['name'])) {
    $file_name = $_FILES['screenQuestion']['name'];
    $file_tmp = $_FILES['screenQuestion']['tmp_name'];
echo "2";
$full_filename = $file_name.$id_user;
    move_uploaded_file($file_tmp, "./documents/Вопросы/" . $file_name);

    $insertquery =
        "Insert into questions(`question`, `id_user`, `type_question`, `file`, `important`) values ('$question', '$id_user', '$typeQuestion', '$file_name.$id_user', 0)";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
else {
    echo "3";
    mysqli_query($con, "Insert into questions(`question`, `id_user`, `type_question`, `important`) values ('$question', '$id_user', '$typeQuestion', 0)");
}


?>