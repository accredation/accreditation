<?php
include "connection.php";
$date = date('Y-m-d');
$id_sub = $_POST['id_sub'];
$id_criteria = $_POST['id_criteria'];
$status = $_POST['value'];
mysqli_query($con, "update rating_criteria as rc set status = '$status' , date_complete = '$date' where  id_subvision = '$id_sub' and id_criteria = '$id_criteria' and rc.value = 1");

$text_notifications = "Ваше заявление принято в работу";

$query3 = "Insert into  notifications  (id_user,text_notifications,readornot,date_text)  SELECT id_otvetstvennogo ,'$text_notifications',1,CURDATE()  FROM rating_criteria as rc where  id_subvision = '$id_sub' and id_criteria = '$id_criteria' and rc.value = 1";

$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));

?>