<?php
include "connection.php";
echo "0";
$date = date('Y-m-d H:i:s');
$id_user = $_POST['id_user'];
$question = $_POST['question'];
$typeQuestion = $_POST['typeQuestion'];
$email = $_POST['email'];
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
        "Insert into questions(`question`, `email`, `id_user`, `type_question`, `file`, `date_question`, `important`) values ('$question', '$email', '$id_user', '$typeQuestion', 'documents/Вопросы/$id_user/$file_name', '$date', 0)";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
else {
    echo "3";
    mysqli_query($con, "Insert into questions(`question`, `email`, `id_user`, `type_question`, `date_question`, `important`) values ('$question', '$email', '$id_user', '$typeQuestion','$date', 0)");
}
$textSubj = "Поступил новый вопрос в ТП мед.аккредитации";
$subj = iconv("utf-8","cp1251",$textSubj);
$text = $question;
$message=iconv("utf-8","cp1251",$text);
if (mail("hancharou@rnpcmt.by", $subj, $message,"From:". $email. "\r\n")){
    echo "Сообщение успешно отправлено";
} else {
    echo "При отправке сообщения возникли ошибки";
}

?>