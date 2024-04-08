<?php

include "../../../ajax/connection.php";

$date_create_at = $_GET['date_create_at'];
$date_create_to = $_GET['date_create_to'];
$oblastsIdStr = $_GET['oblastsId'];
$statusIdStr = $_GET['statusId'];
$typeIdStr = $_GET['typeId'];
$criteriaAll = $_GET['criteriaAll'];
$criteriaIdStr = $_GET['criteriaIdStr'];



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


////////////////////////////////////////////////////////////
/////////// условие по критериям
$criteriaIdStr2 = explode(',', $criteriaIdStr);
$criteriaIdStr3 = '';

foreach($criteriaIdStr2 as $str){
    $criteriaIdStr3 .= '(' . 'dep.id_list_tables_criteria' . '=' . $str . ') or';
    //echo $str . "<br />";
}

if($criteriaIdStr === ''){
    $criteriaIdStr3 = '0 = 0';
} else {
$criteriaIdStr3 = substr($criteriaIdStr3,0,-2);
$criteriaIdStr3 = '(' . $criteriaIdStr3 . ')';
}


//echo $ur_lica_value;

$query = "
SELECT st.name_status_report as name_status , app.date_send, sto.type_name as type_org, 
    CONCAT( app.naim, ' №', app.id_application) as naim, app.id_application, 
    
  ltc.name as name_criteria , tt.id_types_tables, tt.name as type_criteria, 
  count(dep.id_list_tables_criteria) as crit_count,
  Round(SUM(dep.mark_accred_percent)/count(dep.id_list_tables_criteria)) as crit_src,
  app.mark_accred_percent as app_ocenka
from accreditation.applications app
left outer join accreditation.users u on app.id_user=u.id_user
    left outer join accreditation.uz uz on uz.id_uz=u.id_uz
    
left outer join accreditation.status st on app.id_status=st.id_status
left outer join accreditation.subvision s on app.id_application=s.id_application
left outer join accreditation.z_department dep on s.id_subvision=dep.id_subvision
left outer join accreditation.z_list_tables_criteria ltc on dep.id_list_tables_criteria=ltc.id_list_tables_criteria
left outer join accreditation.z_types_tables tt on ltc.id_types_tables = tt.id_types_tables
left outer join accreditation.spr_type_organization sto on uz.id_type=sto.id_type
where app.id_status<>8
and dep.id_list_tables_criteria is not null

and $statusIdStr3
and $oblastsIdStr3
and $typeIdStr3
and (('$criteriaAll' = 0) or ('$criteriaAll'=1 and $criteriaIdStr3 )  )
group by  name_status, app.date_send, type_org, naim, app.id_application, tt.id_types_tables, type_criteria, name_criteria, app_ocenka 
order by  name_status_report, app.date_send, type_org, naim, app.id_application, tt.id_types_tables, type_criteria, name_criteria, app_ocenka

";

// ('$id_scriteria_str'='' or ('$id_scriteria_str'<>'' and 

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

//  echo $con;

//echo json_encode($query);

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public $id_application, $status , $date_send, $type_org_name, $naim, $name_criteria, $crit_count, $type_criteria, $id_types_tables, $crit_src, $app_ocenka;
    
}

foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->id_application = $app['id_application'];
    $report->status = $app['name_status'];
    $report->date_send = $app['date_send'];
    $report->type_org_name = $app['type_org'];
    $report->naim = $app['naim'];
    $report->name_criteria = $app['name_criteria'];
    $report->crit_count = $app['crit_count'];
    $report->id_types_tables = $app['id_types_tables'];
    $report->type_criteria = $app['type_criteria'];
    $report->crit_src = $app['crit_src'];
    $report->app_ocenka = $app['app_ocenka'];

    array_push($reports,$report);
}
//echo $reports;

echo json_encode($reports);