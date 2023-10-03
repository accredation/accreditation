<?php header("Content-Type: text/html; charset=utf-8");?>
<?php
include "connection.php";

$date = date('Y-m-d H:i:s');
$id_question = $_GET['id_question'];
$answer = $_GET['answer'];

    mysqli_query($con, "update questions set answer = '$answer', date_answer = '$date' where id_question = '$id_question'");

$textSubj = "Ответ от Технической поддержки медаккредитации";
//$subj = iconv("utf-8","cp1251",$textSubj);
$text = $answer;

$text_notifications = "Пришел ответ от поддержки";

$query3 = "Insert into  notifications  (id_user,text_notifications,readornot,date_text)  SELECT id_user ,'$text_notifications',1,CURDATE()  FROM questions WHERE id_question = '$id_question'; ";

$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));



//$message=iconv("utf-8","cp1251",$text);
$message=$text;
$rez = mysqli_query($con, "select email from questions where id_question = '$id_question'");
$row = mysqli_fetch_assoc($rez);
$msg = "На Ваш вопрос поступил ответ: " . $answer . "\nОзнакомиться с ответом также можно в личном кабинете на сайте ИС «Медицинская аккредитация» (http://medaccr.rnpcmt.by/).
\n\n\n
С уважением, служба технической поддержки ИС «Медицинская аккредитация».\n
ГУ «Республиканский научно-практический центр медицинских технологий, информатизации, управления и экономики здравоохранения»
";
$headers = 'From: support@rnpcmt.by' . "\r\n" .
    'Content-type: text/html; charset=utf-8' . "\r\n".
    'X-Mailer: PHP/' . phpversion();

    if (mail($row['email'], $textSubj, $msg, $headers)) {
//    if (mail($row['email'], $textSubj, "Уважаемый, пользователь. На Ваш вопрос по работе в информационной системе «Медицинская аккредитация» поступил ответ:\n ". $message. "\nПри необходимости дополнительной информации предлагаем обратиться по телефону (тел. +375 17 311-50-92, +375 17 311-50-88 График работы: Понедельник - Четверг: 8:30 - 17:30, Пятница: 8:30 - 17:00). Рекомендуем ознакомиться с ответами на часто задаваемые вопросы на сайте информационной системы ссылка. Спасибо за Ваше обращение!  Данное сообщение сформировано автоматически и не требует ответа.", $headers)) {
    //if (mail($row['email'], $textSubj, "Уважаемый, пользователь. На Ваш вопрос по работе в информационной системе «Медицинская аккредитация» поступил ответ:\n ". $message. "\nПри необходимости дополнительной информации предлагаем обратиться по телефону (тел. Колл-центр и график работы). Рекомендуем ознакомиться с ответами на часто задаваемые вопросы на сайте информационной системы ссылка. Спасибо за Ваше обращение!  Данное сообщение сформировано автоматически и не требует ответа.", "From:  support@rnpcmt.by \r\n")) {
        echo "Сообщение успешно отправлено";
    } else {
        echo "При отправке сообщения возникли ошибки";
    }


?>
