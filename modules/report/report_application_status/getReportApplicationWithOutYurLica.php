<?php

include "../../../connection.php";

$id_oblast = $_GET['id_oblast'];
$id_status = $_GET['id_status'];
$dateAccept = $_GET['dateAccept'];
$dateComplete = $_GET['dateComplete'];
$id_type_org = $_GET['id_type_org'];

$date = date('d-m-y');

if(empty($dateAccept)){
    $dateAccept = $date;
} /*else {
    $dateAccept = "'$dateAccept'";
}
*/

// echo "\"$date_accept\"";

if(empty($dateComplete)){
    $dateComplete = $date;

} /*else {
    $dateComplete = "'$dateComplete'";
}*/

$query = "
SELECT REPLACE(r.name, 'Аккредитация', '') as oblast_name, count(a.id_application) as app_count 
FROM accreditation.applications a
left outer join accreditation.users u on a.id_user=u.id_user
left outer join accreditation.roles r on u.oblast=r.id_role
where u.id_role=3 and u.id_user not in(2,642) 
    and (('$id_type_org' = 0) or ('$id_type_org'<>0 and u.id_type='$id_type_org' ))
    and (('$id_oblast' = 0) or ('$id_oblast'<>0 and u.oblast='$id_oblast' ))
    and (('$id_status' = 0) or ('$id_status'<>0 and a.id_status='$id_status' ))
    and ((('$id_status' <> 1) and ((a.date_send is null) or (a.date_send is not null and (a.date_send >= '$dateAccept' and a.date_send <= '$dateComplete'))))
    or (('$id_status' = 1) ))

group by r.name
order by r.name
";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();


for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public /*$status , $date_send, $type_org_name,*/ $oblast_name, $app_count;
}

foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->oblast_name = $app['oblast_name'];
    $report->app_count = $app['app_count'];


    array_push($reports,$report);
}
//echo $reports;

echo json_encode($reports);