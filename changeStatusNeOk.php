<?php
include "connection.php";
$login = $_COOKIE['login'];
$id_application = $_POST['id_application'];
$dateInputDorabotki = $_POST['dateInputDorabotki'];
$notifyByEmail =  $_POST['notifyByEmail'];
$email =  $_POST['email'];

$query1 = "Update applications  set `id_status` = 5,  `date_complete` = CURDATE() , dateInputDorabotki = '$dateInputDorabotki'  where id_application = '$id_application'";

$result1 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));
$text_notifications = "Необходимо доработать заявление";

$query3 = "Insert into  notifications  (id_user,text_notifications,readornot,date_text)  SELECT id_user ,'$text_notifications',1,CURDATE()  FROM applications WHERE id_application = '$id_application'; ";

$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));
if (!file_exists('documents/' . 'dorabotka/'. $id_application )) {
    mkdir('documents/'  . 'dorabotka/'. $id_application , 0777, true);
}

if (isset($_FILES['fileDorabotka']['name'])) {
    $file_name = $_FILES['fileDorabotka']['name'];
    $file_tmp = $_FILES['fileDorabotka']['tmp_name'];

    move_uploaded_file($file_tmp, "./documents/" . "dorabotka/". $id_application  . "/". $file_name);

    $query2 =
        "UPDATE applications set infDorabotkiFile = '$file_name' where id_application='$id_application'";

    $result2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
}

echo ("Данные сохранены");

if ($notifyByEmail === "true") {
    $textSubj = "Информация о доработке";
    //  $subj = iconv("utf-8", "cp1251", $textSubj);
      $subj =  $textSubj;
      $text = "Необходимо доработать заявление";
   //   $message = iconv("utf-8", "cp1251", $text);
      $message =  $text;
  
      $headers = 'From: support@rnpcmt.by' . "\r\n" .
          'Content-type: text/html; charset=utf-8' . "\r\n".
          'X-Mailer: PHP/' . phpversion();
  
      if (mail($email, $subj, $message, $headers)) {
          echo "Сообщение успешно отправлено";
      } else {
          echo "При отправке сообщения возникли ошибки";
      }
}
?>