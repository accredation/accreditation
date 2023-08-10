<?php
include "connection.php";
echo "0";
$date = date('Y-m-d');
$id_user = $_POST['id_user'];
$question = $_POST['question'];
$typeQuestion = $_POST['typeQuestion'];
echo "1";
if (!file_exists('documents/Вопросы/'.$id_user)) {
    mkdir('documents/Вопросы/'.$id_user, 0777, true);
}
if (isset($_FILES['screenQuestion']['name'])) {
    $file_name = $_FILES['screenQuestion']['name'];
    $file_tmp = $_FILES['screenQuestion']['tmp_name'];
    echo "2";
    $full_filename = $file_name.$id_user;
    move_uploaded_file($file_tmp, "./documents/Вопросы/".$id_user. "/" . $file_name);

    $insertquery =
        "Insert into questions(`question`, `id_user`, `type_question`, `file`, `important`) values ('$question', '$id_user', '$typeQuestion', 'documents/Вопросы/$id_user/$file_name', 0)";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
else {
    echo "3";
    mysqli_query($con, "Insert into questions(`question`, `id_user`, `type_question`, `important`) values ('$question', '$id_user', '$typeQuestion', 0)");
}
$textSubj = "Вопрос принят medaccr.rnpcmt.by";
$subj = iconv("utf-8","cp1251",$textSubj);
$text = "Ваш вопрос принят в работу";
$message=iconv("utf-8","cp1251",$text);
if (mail("hancharou@rnpcmt.by", $subj, $message,"From: medaccred@rnpcmt.by \r\n")){
    echo "Сообщение успешно отправлено";
} else {
    echo "При отправке сообщения возникли ошибки";
}

?>