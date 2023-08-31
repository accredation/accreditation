<?php

include "../../connection.php";

$id_cr = $_POST['id_cr'];
$id_userotv = $_POST['id_userotv'];


mysqli_query($con, "update rating_criteria cr set cr.id_otvetstvennogo = '$id_userotv' where cr.id_rating_criteria = '$id_cr'");

$text_notifications = "Назначение ответственным";

$query3 = "Insert into  notifications  (id_user,text_notifications,readornot,date_text)  SELECT id_otvetstvennogo ,'$text_notifications',1,CURDATE()  FROM rating_criteria WHERE id_otvetstvennogo = '$id_userotv' LIMIT 1; ";

$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));


?>