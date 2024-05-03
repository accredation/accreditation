<?php

include "../../../ajax/connection.php";


$datePeriod_at = $_GET['datePeriod_at'];
$datePeriod_to = $_GET['datePeriod_to'];
$year_schedule = $_GET['year_schedule'];
$OblastsId = $_GET['OblastsId'];

$guzo = $_GET['guzo'];
$checkbox_guzo_1 = $_GET['checkbox_guzo_1'];
$checkbox_guzo_2 = $_GET['checkbox_guzo_2'];

$checkbox_pervtor_1 = $_GET['checkbox_pervtor_1'];
$checkbox_pervtor_2 = $_GET['checkbox_pervtor_2'];
$pervtor = $_GET['pervtor'];

$otz = $_GET['otz'];
$otkaz = $_GET['otkaz'];
$type_report = $_GET['type_report']; 

$count_day_app = $_GET['count_day_app'];



//////////////// формирование условия по области
$oblastsIdStr2 = explode(',', $OblastsId);
$oblastsIdStr3 = '';

foreach($oblastsIdStr2 as $str1){
    $oblastsIdStr3 .= '(' . 'u.oblast' . '=' . $str1 . ') or';
    //echo $str . "<br />";
}

if($OblastsId === ''){
    $oblastsIdStr3 = '0 = 0';
} else {
$oblastsIdStr3 = substr($oblastsIdStr3,0,-2);
$oblastsIdStr3 = '(' . $oblastsIdStr3 . ')';
}

//////////////////////////////////////////////////////////////

$guzo = '';

 if($checkbox_guzo_1 === "true") {
    $guzo = $guzo  . "r.checkboxValueGuzo=1"; 
 } 

 if($checkbox_guzo_2 === "true") {
    if(strlen($guzo)>0){
        $guzo = $guzo . ' or ';
     }
    $guzo = $guzo  . "r.checkboxValueGuzo=0"; 
 } 

 if($guzo === ''){
    $guzo = '(' . 0 .'='. 0 . ')';
 }


 $perv_vtor = '';

 if($checkbox_pervtor_1 === "true") {
    $perv_vtor = $perv_vtor  . "r.perv_vtor=1"; 
 } 

 if($checkbox_pervtor_2 === "true") {
    if(strlen($perv_vtor)>0){
        $perv_vtor = $perv_vtor . ' or ';
     }
    $perv_vtor = $perv_vtor  . "r.perv_vtor=2"; 
 } 

 if($perv_vtor === ''){
    $perv_vtor = '(' . 0 .'='. 0 . ')';
 }


 $otz_str = '';

 if($otz === "true") {
    $otz_str = $otz_str  . "r.type_otzyv=1"; 
 }

 if($otkaz === "true") {
    if(strlen($otz_str)>0){
        $otz_str = $otz_str . ' or ';
     }
    $otz_str = $otz_str  . "r.type_otzyv=2"; 
 } 

 if($otz_str === ''){
    $otz_str = '(' . 0 .'='. 0 . ')';
 }


$query = "
 
select  rPov.id_rkk, u.username, a2.date_create_app, case when rPov.perv_vtor = 1 then 'первичное' when rPov.perv_vtor = 2 then 'повторное' else '' end as perv_vtor,
 s.name_status_report as name_status, rPov.date_reg, DATE_ADD(COALESCE(a.data_zayav_otzyv, r.date_protokol),INTERVAL $count_day_app MONTH) as schedule_date, 
 case when a2.sootvetstvie = 1 then 'Соответствует' when a2.sootvetstvie=2 then 'Не соответствует' else '' end as sootvetstvie,
 case when rPov.result='1' then 'Выдача свидетельства' when rPov.result='2' then 'Отказ в выдаче свидетельства' when rPov.result='3' then 'Отказ в приеме заявления'
 else '' end as adm_reah, rPov.date_protokol, rPov.date_admin_resh as info_uved ,
 a2.data_zayav_otzyv as num_rkk

from accreditation.rkk r 
left outer join accreditation.applications a on a.id_application=r.id_application  and a.id_status<>8
left outer join accreditation.applications a2 on a2.id_old_app=a.id_application 
left outer join accreditation.rkk rPov on a2.id_application=rPov.id_application 
left outer join accreditation.schedule_date_oz sdo on sdo.id_uz=a.id_user and sdo.year=$year_schedule
left outer join accreditation.uz u on sdo.id_uz=u.id_uz
left outer join accreditation.status s on a2.id_status=s.id_status
where (a.id_status>=6 ) 
and ( a.giveSvid=2 or r.result='2' or r.result='3')

and DATE_ADD(COALESCE(a.data_zayav_otzyv, r.date_protokol),INTERVAL $count_day_app MONTH) between '$datePeriod_at' and '$datePeriod_to' 

 and (rPov.date_reg is not null)
-- or (rPov.date_reg is not null and (rPov.date_reg > DATE_ADD(COALESCE(a.data_zayav_otzyv, r.date_protokol),INTERVAL $count_day_app MONTH)  )))
and $guzo
and $perv_vtor
and $otz_str
and $oblastsIdStr3
 
order by u.username
 ";



$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();


for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public $id_rkk, $username, $date_create_app , $perv_vtor, $name_status, $date_reg, $schedule_date, 
    $sootvetstvie, $adm_reah, $date_protokol, $info_uved, $num_rkk;
    
}


foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->id_rkk = $app['id_rkk'];
    $report->username = $app['username'];
    $report->date_create_app = $app['date_create_app'];
    $report->perv_vtor = $app['perv_vtor'];
    $report->name_status = $app['name_status'];
    $report->date_reg = $app['date_reg'];
    $report->schedule_date = $app['schedule_date'];
    $report->sootvetstvie = $app['sootvetstvie'];
    $report->adm_reah = $app['adm_reah'];
    $report->date_protokol = $app['date_protokol'];
    $report->info_uved = $app['info_uved'];
    $report->num_rkk = $app['num_rkk'];

    array_push($reports,$report);
}


echo json_encode($reports);
mysqli_close($con);