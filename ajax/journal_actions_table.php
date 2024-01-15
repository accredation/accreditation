<?php
include "connection.php";

$id_app = $_GET['id_app'];


$query = "select 1 as id, a.id_application as id_application, u.id_user as id_user, date_create_app as date_action, '' as time_action,
       1 as type_action,'Заявление создано' as `action`,null,null, u.login as login
from applications a
left outer join users u on a.id_user=u.id_user
where id_application = '$id_app'
union
SELECT ha.*, u.login
from history_actions ha
left outer join users u on ha.id_user=u.id_user
where ha.id_application = '$id_app'
";

//SELECT ha.*, u.login
//from history_actions ha
//left outer join users u on ha.id_user=u.id_user
//where id_application = '$id_app'
//order by ha.date_action, ha.time_action

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public $id, $login , $date_action, $time_action, $type_action, $action;
    
}

foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->id = $app['id'];
    $report->login = $app['login'];
    $report->date_action = $app['date_action'];
    $report->time_action = $app['time_action'];
    $report->type_action = $app['type_action'];
    $report->action = $app['action'];

    array_push($reports,$report);
}

echo json_encode($reports);

