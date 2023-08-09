<?php
include "connection.php";
echo "0";
$date = date('Y-m-d');
$id_user = $_POST['id_user'];
$question = $_POST['question'];
$typeQuestion = $_POST['typeQuestion'];
echo "1";

//$email = $_POST['email'];
//$email = htmlspecialchars($email);
//$email = urldecode($email);
//$email = trim($email);
//$textSubj = "Письмо МЗРБ №10-42/3942 о форме заявления";
//$subj = iconv("utf-8","cp1251",$textSubj);
//$text = "Для учета в работе заместителю директора по экономическим технологиям и международным проектам Шарало В.В.\n Форма заявления:";
//$message=iconv("utf-8","cp1251",$text);
//if (mail("sharalo@rnpcmt.by", $subj, $message." https://vagcom.com.ua/upload/medialibrary/6fd/028.webp?1650639229" ,"From: medaccred@rnpcmt.by \r\n")){
//    echo "Сообщение успешно отправлено";
//} else {
//    echo "При отправке сообщения возникли ошибки";
//}

if (isset($_FILES['screenQuestion']['name'])) {
    $file_name = $_FILES['screenQuestion']['name'];
    $file_tmp = $_FILES['screenQuestion']['tmp_name'];
echo "2";
$full_filename = $file_name.$id_user;
    move_uploaded_file($file_tmp, "./documents/Вопросы/" . $file_name);

    $insertquery =
        "Insert into questions(`question`, `id_user`, `type_question`, `file`, `important`) values ('$question', '$id_user', '$typeQuestion', '/documents/Вопросы/$file_name', 0)";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
else {
    echo "3";
    mysqli_query($con, "Insert into questions(`question`, `id_user`, `type_question`, `important`) values ('$question', '$id_user', '$typeQuestion', 0)");
}


?>