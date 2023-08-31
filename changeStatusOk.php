<?php
include "connection.php";
$id_applications = $_GET['id_application'];


mysqli_query($con, "Update applications set `id_status` = 4, `date_complete` = CURDATE() where `id_application` = '$id_applications'");

$text_notifications = "Ваше заявление в статусе завершено";

$query3 = "Insert into  notifications  (id_user,text_notifications,readornot,date_text)  SELECT id_user ,'$text_notifications',1,CURDATE()  FROM applications where  id_application = '$id_applications'";

$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));
?>