<?php
include "connection.php";
echo "0";
$date = date('Y-m-d H:i:s');
$id_user = $_POST['id_user'];
$question = $_POST['question'];
$typeQuestion = $_POST['typeQuestion'];
$email = $_POST['email'];
echo "1";
if (!file_exists('docs/documents/Вопросы/'.$id_user)) {
    mkdir('docs/documents/Вопросы/'.$id_user, 0777, true);
}
if (isset($_FILES['screenQuestion']['name'])) {
    $file_name = $_FILES['screenQuestion']['name'];
    $file_tmp = $_FILES['screenQuestion']['tmp_name'];
    echo "2";
    $full_filename = $file_name.$id_user;
    move_uploaded_file($file_tmp, "./docs/documents/Вопросы/".$id_user. "/" . $file_name);

    $insertquery =
        "Insert into questions(`question`, `email`, `id_user`, `type_question`, `file`, `date_question`, `important`) values ('$question', '$email', '$id_user', '$typeQuestion', 'docs/documents/Вопросы/$id_user/$file_name', '$date', 0)";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
else {
    echo "3";
    mysqli_query($con, "Insert into questions(`question`, `email`, `id_user`, `type_question`, `date_question`, `important`) values ('$question', '$email', '$id_user', '$typeQuestion','$date', 0)");
}

$textSubj = "Поступил новый вопрос в ТП мед.аккредитации";
//$subj = iconv("utf-8","cp1251",$textSubj);
$subj = $textSubj;
$text = $question;
//$message=iconv("utf-8","cp1251",$text);
$message=$text;

$headers = 'From:'. $email . "\r\n" .
    'Content-type: text/html; charset=utf-8' . "\r\n".
    'X-Mailer: PHP/' . phpversion();

if (mail("support@rnpcmt.by", $subj, $message,$headers)){
    echo "Сообщение успешно отправлено";
} else {
    echo "При отправке сообщения возникли ошибки";
}


if($email !== "support@rnpcmt.by") {
    $textSubj1 = "От вас поступил вопрос в службу технической поддержки медаккредитации " . $question;
//$subj = iconv("utf-8","cp1251",$textSubj);
    $subj1 = $textSubj1;
//$message=iconv("utf-8","cp1251",$text);
    $message1 = "Это автоматический ответ, подтверждающий получение вашего обращения. \n
Ваш вопрос направлен службе технической поддержки. \n
Обработка осуществляется в порядке очередности поступивших запросов и может потребовать ожидания ответа (не позднее 3 рабочих дней со дня подачи обращения).\n\n\n
С уважением, служба технической поддержки ИС «Медицинская аккредитация».\n
ГУ «Республиканский научно-практический центр медицинских технологий, информатизации, управления и экономики здравоохранения»

";

    $headers1 = 'From:' . "support@rnpcmt.by" . "\r\n" .
        'Content-type: text/html; charset=utf-8' . "\r\n" .
        'X-Mailer: PHP/' . phpversion();

    if (mail($email, $subj1, $message1, $headers1)) {
        echo "Сообщение успешно отправлено";
    } else {
        echo "При отправке сообщения возникли ошибки";
    }
}

?>