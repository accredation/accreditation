<?php

include "../../ajax/connection.php";

$id_application = $_GET['id_application'];
$id_user = $_COOKIE['id_user'];

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

class Otv{
    public $id_user, $username, $id_criteria;
}

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$otvetstv = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);
foreach ($data as $app) {
    $user = new Otv();
    $user->id_user = $app['id_user'];
    $user->username = $app['username'];
    $user->id_criteria = $app['id_criteria'];
    array_push($otvetstv,$user);
}

echo json_encode($otvetstv);
?>
