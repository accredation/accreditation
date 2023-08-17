<?php

include "../../connection.php";

$id_application = $_GET['id_application'];
$id_user = $_GET['id_user'];

$query = "SELECT u.id_user, u.username, sd.id_criteria
FROM spr_doctor_expert_for_criteria sd 
left outer join users u on sd.id_user=u.id_user
left outer join users u2 on u2.id_user='$id_user'
WHERE u.doctor_expert = 1 and 
 ((u2.id_role < 3 ) 
or (u2.id_role > 2 and u.id_role=u2.id_role ))
and sd.id_user is not null

and sd.id_criteria in (select id_criteria
from rating_criteria rc
left outer join subvision sub on rc.id_subvision=sub.id_subvision
where sub.id_application = '$id_application')";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$data = array();
if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);

    $date_accept = $row['date_accept'];
    $date_complete = $row['date_complete'];
    $date_council = $row['date_council'];
}
array_push($data,$date_accept);
array_push($data,$date_complete);
array_push($data,$date_council);
echo json_encode($data);
?>
