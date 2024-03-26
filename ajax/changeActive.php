<?php
include "connection.php";
$id_user = $_POST['id_user'];
$checked = $_POST['checked'];


mysqli_query($con, "Update users set `active` = '$checked' where id_user = '$id_user'");

//$text_notifications = "Ваше заявление в статусе рассмотрения";

//$query3 = "Insert into  notifications  (id_user,text_notifications,readornot,date_text)  SELECT id_user ,'$text_notifications',1,CURDATE()  FROM applications where  id_application = '$id_applications'";
//
//$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));
?>