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

 


$query = "SELECT REPLACE(r.name, 'Аккредитация', '')  as oblast_name, CONCAT( a.naim, ' №', a.id_application) as naim, 
st.name_status, a.date_send, sto.type_name as type_org , count(m.id_criteria) as crit_all, count(rm.field4>0) as crit_otm
FROM accreditation.applications a
left outer join accreditation.users u on a.id_user=u.id_user
left outer join uz uz on uz.id_uz=u.id_uz
left outer join accreditation.roles r on u.oblast=r.id_role
left outer join accreditation.status st on a.id_status=st.id_status
left outer join accreditation.spr_type_organization sto on uz.id_type=sto.id_type
left outer join accreditation.subvision s on a.id_application=s.id_application
left outer join accreditation.rating_criteria rc on s.id_subvision=rc.id_subvision
left outer join accreditation.mark m on rc.id_criteria =m.id_criteria
left outer join accreditation.mark_rating rm on m.id_mark=rm.id_mark and s.id_subvision=rm.id_subvision
where u.id_role=3 
    
    and (('$id_type_org' = 0) or ('$id_type_org'<>0 and uz.id_type='$id_type_org' ))
    and (('$id_oblast' = 0) or ('$id_oblast'<>0 and uz.oblast='$id_oblast' ))
    and (('$id_status' = 0) or ('$id_status'<>0 and a.id_status='$id_status' ))
    and ((('$id_status' <> 1) and ((a.date_send is null) or (a.date_send is not null and (a.date_send >= '$dateAccept' and a.date_send <= '$dateComplete'))))
    or (('$id_status' = 1) ))

group by oblast_name, CONCAT( a.naim, ' №', a.id_application), st.name_status, a.date_send, type_org  
order by oblast_name, st.name_status, a.date_send, type_org, CONCAT( a.naim, ' №', a.id_application)
";

// ('$id_scriteria_str'='' or ('$id_scriteria_str'<>'' and 

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

//  echo $con;

//echo json_encode($query);

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public $oblast_name, $naim, $status , $date_send, $type_org_name, $crit_all, $crit_otm;
    
}

foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->oblast_name = $app['oblast_name'];
    $report->naim = $app['naim'];
    $report->status = $app['name_status'];
    $report->date_send = $app['date_send'];
    $report->type_org_name = $app['type_org'];
    $report->crit_all = $app['crit_all'];
    $report->crit_otm = $app['crit_otm'];
    array_push($reports,$report);
}
//echo $reports;

echo json_encode($reports);