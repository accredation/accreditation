<?php

include "../../../ajax/connection.php";

$date_create_at = $_GET['date_create_at'];
$date_create_to = $_GET['date_create_to'];
$oblastsIdStr = $_GET['oblastsId'];
$statusIdStr = $_GET['statusId'];
$typeIdStr = $_GET['typeId'];


$date = date('d-m-y');

if(empty($date_create_at)){
    $date_create_at = $date;
} 

if(empty($date_create_to)){
    $date_create_to = $date;
} 

/////////////////////////////////////////////////////////////////
//////////////// формирование условия по области
$oblastsIdStr2 = explode(',', $oblastsIdStr);
$oblastsIdStr3 = '';

foreach($oblastsIdStr2 as $str1){
    $oblastsIdStr3 .= '(' . 'uz.oblast' . '=' . $str1 . ') or';
    //echo $str . "<br />";
}

if($oblastsIdStr === ''){
    $oblastsIdStr3 = '0 = 0';
} else {
$oblastsIdStr3 = substr($oblastsIdStr3,0,-2);
$oblastsIdStr3 = '(' . $oblastsIdStr3 . ')';
}



//////////////////////////////////////////////////////////////
///////////// условие по статусу
$statusIdStr2 = explode(',', $statusIdStr);
$statusIdStr3 = '';
foreach($statusIdStr2 as $str2){
    if ($str2 == '1'){
        $statusIdStr3 .= '(' . 'app.id_status' . '=' . $str2 . ') or';
    }
    if($str2 !== '1'){
        $statusIdStr3 .= "(" . "app.id_status" . "=" . $str2 . " and (app.date_send >= '".$date_create_at."' and app.date_send <= '".$date_create_to."')) or";
    }
    
    //echo $str . "<br />";
}

if($statusIdStr === ''){
    $statusIdStr3 = "(app.id_status = 1 or (app.id_status <> 1 and (app.date_send >= '".$date_create_at."' and app.date_send <= '".$date_create_to."')))";
} else {
$statusIdStr3 = substr($statusIdStr3,0,-2);
$statusIdStr3 = '(' . $statusIdStr3 . ')';
} 
 

/////////////////////////////////////////////////////////////
//////////// условие по типу ОЗ
$typeIdStr2 = explode(',', $typeIdStr);
$typeIdStr3 = '';

foreach($typeIdStr2 as $str3){
    $typeIdStr3 .= '(' . 'uz.id_type' . '=' . $str3 . ') or';
    //echo $str . "<br />";
}

if($typeIdStr === ''){
    $typeIdStr3 = '0 = 0';
} else {
$typeIdStr3 = substr($typeIdStr3,0,-2);
$typeIdStr3 = '(' . $typeIdStr3 . ')';
}



$query = "
SELECT so.oblast as oblast_name, 
    CONCAT( app.naim, ' №', app.id_application) as naim, app.id_application, 
    st.name_status_report as name_status , app.date_send, sto.type_name as type_org, 
  count(dep.id_list_tables_criteria) as crit_all,
  count(zac.field3>0) as crit_otm
  
from accreditation.applications app
left outer join accreditation.users u on app.id_user=u.id_user
    left outer join accreditation.uz uz on uz.id_uz=u.id_uz
    left outer join accreditation.spr_oblast so on uz.oblast=so.id_oblast      
left outer join accreditation.status st on app.id_status=st.id_status
left outer join accreditation.subvision s on app.id_application=s.id_application
left outer join accreditation.z_department dep on s.id_subvision=dep.id_subvision
left outer join accreditation.z_list_tables_criteria ltc on dep.id_list_tables_criteria=ltc.id_list_tables_criteria
left outer join accreditation.z_types_tables tt on ltc.id_types_tables = tt.id_types_tables
left outer join accreditation.spr_type_organization sto on uz.id_type=sto.id_type
left outer join accreditation.z_answer_criteria zac on dep.id_department=zac.id_department
where app.id_status<>8
and $statusIdStr3
and $oblastsIdStr3
and $typeIdStr3

group by oblast_name,  CONCAT( app.naim, ' №', app.id_application), app.id_application,  name_status, app.date_send, type_org  
order by oblast_name, name_status, app.date_send, type_org,  CONCAT( app.naim, ' №', app.id_application)

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