<?php

include "../../../ajax/connection.php";

$date_create_at = $_GET['date_create_at'];
$date_create_to = $_GET['date_create_to'];
$oblastsIdStr = $_GET['oblastsId'];
$statusIdStr = $_GET['statusId'];
$typeIdStr = $_GET['typeId'];
$checkbox_pervtor_1_ = $_GET['checkbox_pervtor_1'];
$checkbox_pervtor_2_ = $_GET['checkbox_pervtor_2'];
$pervtor_ = $_GET['pervtor'];


$checkbox_guzo_1_ = $_GET['checkbox_guzo_1'];
$checkbox_guzo_2_ = $_GET['checkbox_guzo_2'];

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

$perv_vtor = '';

 if($checkbox_pervtor_1_ === "true") {
    $perv_vtor = $perv_vtor  . "rkk.perv_vtor=1"; 
 } 

 if($checkbox_pervtor_2_ === "true") {
    if(strlen($perv_vtor)>0){
        $perv_vtor = $perv_vtor . ' or ';
     }
    $perv_vtor = $perv_vtor  . "rkk.perv_vtor=2"; 
 } 

 if($perv_vtor === ''){
    $perv_vtor = '(' . 0 .'='. 0 . ')';
 } else {
   $perv_vtor = '(' . $perv_vtor . ')';
}


 $guzo = '';

 if($checkbox_guzo_1_ === "true") {
    $guzo = $guzo  . "rkk.checkboxValueGuzo=1"; 
 } 

 if($checkbox_guzo_2_ === "true") {
    if(strlen($guzo)>0){
        $guzo = $guzo . ' or ';
     }
    $guzo = $guzo  . "rkk.checkboxValueGuzo=0"; 
 } 

 if($guzo === ''){
    $guzo = '(' . 0 .'='. 0 . ')';
 }else {
   $guzo = '(' . $guzo . ')';
}


$query = "

select so.oblast as oblast_name, count(app.id_application) as app_count 
from accreditation.applications app
left outer join accreditation.users u on app.id_user=u.id_user
 left outer join accreditation.uz uz on uz.id_uz=u.id_uz
 left outer join accreditation.spr_oblast so on uz.oblast=so.id_oblast   
left outer join accreditation.status st on app.id_status=st.id_status
left outer join accreditation.rkk rkk on app.id_application=rkk.id_application
where app.id_status<>8
and $statusIdStr3
and $oblastsIdStr3
and $typeIdStr3
and (('$pervtor_' = 0) or ('$pervtor_'=1 and $perv_vtor)) 
and $guzo
group by oblast_name
order by oblast_name

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