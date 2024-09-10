<?php
include "connection.php";
$id_user = $_POST['id_user'];
$checked = $_POST['checked'];


mysqli_query($con, "Update users set `active` = '$checked' where id_user = '$id_user'");

$sql = "CREATE TEMPORARY TABLE temp_users AS
SELECT id_user
FROM users
WHERE id_uz IN (
    SELECT us.id_uz
    FROM users us
    LEFT JOIN uz uz ON uz.id_uz = us.id_uz
    WHERE us.active = '$checked' and id_user  = '$id_user'
)
AND id_role = 15;

UPDATE users
SET active = '$checked'
WHERE id_user IN (SELECT id_user FROM temp_users);

DROP TEMPORARY TABLE temp_users;"
//$text_notifications = "Ваше заявление в статусе рассмотрения";

//$query3 = "Insert into  notifications  (id_user,text_notifications,readornot,date_text)  SELECT id_user ,'$text_notifications',1,CURDATE()  FROM applications where  id_application = '$id_applications'";
//
//$result3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));
?>