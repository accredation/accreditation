<?php

include "../../ajax/connection.php";
$date_reg_ = $_GET['date_reg'];
$date_reg_at_ = $_GET['date_reg_at'];
$date_reg_to_ = $_GET['date_reg_to']; 
$date_protokol_at_ = $_GET['date_protokol_at']; 
$date_protokol_to_ = $_GET['date_protokol_to']; 
$date_admin_resh_at_ = $_GET['date_admin_resh_at']; 
$date_admin_resh_to_ = $_GET['date_admin_resh_to']; 
$date_sved_at_ = $_GET['date_sved_at']; 
$date_sved_to_ = $_GET['date_sved_to']; 
$date_delo_at_ = $_GET['date_delo_at']; 
$date_delo_to_ = $_GET['date_delo_to']; 

$date_protokol_ = $_GET['date_protokol'];
$date_admin_resh_ = $_GET['date_admin_resh'];
$date_sved_ = $_GET['date_sved']; 
$date_delo_ = $_GET ['date_delo'];

$checkbox_adm_resh_1_ = $_GET['checkbox_adm_resh_1']; 
$checkbox_adm_resh_2_ = $_GET['checkbox_adm_resh_2']; 
$checkbox_adm_resh_3_ = $_GET['checkbox_adm_resh_3']; 
$adm_resh_ = $_GET['adm_resh'];


$checkbox_pervtor_1_ = $_GET['checkbox_pervtor_1'];
$checkbox_pervtor_2_ = $_GET['checkbox_pervtor_2'];
$pervtor_ = $_GET['pervtor'];

$checkAllOblast_ = $_GET['checkAllOblast'];
$checkOblasts_ = $_GET['checkOblasts'];
$checkOblastsId_ = $_GET['checkOblastsId'];

$otz_ = $_GET['otz'];
$otkaz_ = $_GET['otkaz'];

$checkbox_guzo_1_ = $_GET['checkbox_guzo_1'];
$checkbox_guzo_2_ = $_GET['checkbox_guzo_2'];

$search_check = $_GET['search_check'];
$radio_search_1 = $_GET['radio_search_1'];
$radio_search_2 = $_GET['radio_search_2'];
$text_search = $_GET['text_search'];



$date = date('d-m-y');
if($date_reg_ == '0'){
    $date_reg_at_ = $date;
    $date_reg_to_ = $date;  
}

if($date_protokol_ =='0'){
    $date_protokol_at_ = $date;
    $date_protokol_to_ = $date;  
}

if($date_admin_resh_ == '0'){
    $date_admin_resh_at_ = $date;
    $date_admin_resh_to_ = $date;  
}

if($date_sved_ == '0'){
    $date_sved_at_ = $date;
    $date_sved_to_ = $date;  
}

if($date_delo_ == '0'){
    $date_delo_at_ = $date;
    $date_delo_to_ = $date;  
}

$adm = '';


 if($checkbox_adm_resh_1_ === "true") {
    $adm = $adm  . "rkk.result='1'"; 
 } 

 
 if($checkbox_adm_resh_2_=== "true") {
    if(strlen($adm)>0){
        $adm = $adm . ' or ';
     }
    $adm = $adm  . "rkk.result='2'"; 
 }

 if($checkbox_adm_resh_3_=== "true") {
    if(strlen($adm)>0){
        $adm = $adm . ' or ';
     }
    $adm = $adm  . "rkk.result='3'"; 
 }

 if($adm === ''){
    $adm = '(' . 0 .'='. 0 . ')';
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
 }




 $otz_str = '';

 if($otz_ === "true") {
    $otz_str = $otz_str  . "rkk.type_otzyv=1"; 
 }

 if($otkaz_ === "true") {
    if(strlen($otz_str)>0){
        $otz_str = $otz_str . ' or ';
     }
    $otz_str = $otz_str  . "rkk.type_otzyv=2"; 
 } 

 if($otz_str === ''){
    $otz_str = '(' . 0 .'='. 0 . ')';
 }


$checkOblastsId_2 = explode(',', $checkOblastsId_);
$checkOblastsId_3 = '';

foreach($checkOblastsId_2 as $str){
    $checkOblastsId_3 .= '(' . 'u.oblast' . '=' . $str . ') or';

}

if($checkOblastsId_ === ''){
    $checkOblastsId_3 = '0 = 0';
} else {
$checkOblastsId_3 = substr($checkOblastsId_3,0,-2);
$checkOblastsId_3 = '(' . $checkOblastsId_3 . ')';
}



$search = '';

if($radio_search_1 === "true"){
   $search =  " rkk.svidetelstvo like('".$text_search."')";  
};

if($radio_search_2 === "true"){
   $search =  " a.naim like('%".$text_search."%')";  
}; 



if($search_check === "false"){  
   $search = "0 = 0";   
}



$query = "SELECT rkk.id_rkk, case when a.id_rkk_perv is not null then rkk.id_rkk +'/' + id_rkk_perv else rkk.id_rkk end as num_rkk, rkk.id_application, a.naim, 
case when rkk.perv_vtor = 1 then 'первичное' when rkk.perv_vtor = 2 then 'повторное' else '' end as perv_vtor,
case when rkk.date_reg = '1970-01-01' then '' else DATE_FORMAT(rkk.date_reg, '%d-%m-%Y')  end  as date_reg, a.ur_adress, a.fact_adress, a.tel, a.email, 
case when rkk.result='1' then 'Выдача свидетельства' when rkk.result='2' then 'Отказ в выдаче свидетельства' when rkk.result='3' then 'Отказ в приеме заявления'
else '' end as adm_reah,  rkk.id_rkk as adm_resh_num,
case when rkk.date_admin_resh = '1970-01-01' then '' else DATE_FORMAT(rkk.date_admin_resh, '%d-%m-%Y')  end  as date_admin_resh, rkk.svidetelstvo, 
case when rkk.date_sved = '1970-01-01' then '' else  DATE_FORMAT(rkk.date_sved, '%d-%m-%Y')  end  as date_sved, 
'пока хз' as sved_srok_deist,
case when rkk.date_delo = '1970-01-01' then '' else DATE_FORMAT(rkk.date_delo, '%d-%m-%Y')  end  as date_delo, rkk.delo, 
a.zaregal, CONCAT( CONVERT(case when rkk.date_sved = '1970-01-01' then '' else DATE_FORMAT(rkk.date_sved, '%d-%m-%Y')   end, char), ' ', rkk.info_uved) as info_uved , 
rkk.getter, so.oblast, case when rkk.date_protokol = '1970-01-01' then '' else DATE_FORMAT(rkk.date_protokol, '%d-%m-%Y')  end  as date_protokol,
rkk.dop_info
from accreditation.rkk 
left outer join accreditation.applications a on rkk.id_application=a.id_application
left outer join accreditation.uz u on a.id_user=u.id_uz
left outer join accreditation.spr_oblast so on u.oblast=so.id_oblast

where (('$date_reg_' = 0) or ('$date_reg_'=1 and rkk.date_reg between '$date_reg_at_' and '$date_reg_to_'))
and (('$date_protokol_' = 0) or ('$date_protokol_'=1 and rkk.date_protokol between '$date_protokol_at_' and '$date_protokol_to_'))
and (('$date_admin_resh_' = 0) or ('$date_admin_resh_'=1 and rkk.date_admin_resh between '$date_admin_resh_at_' and '$date_admin_resh_to_'))
and (('$date_sved_' = 0) or ('$date_sved_'=1 and rkk.date_sved between '$date_sved_at_' and '$date_sved_to_'))
and (('$date_delo_' = 0) or ('$date_delo_'=1 and rkk.date_delo between '$date_delo_at_' and '$date_delo_to_'))
and (('$adm_resh_' = 0) or ('$adm_resh_'=1 and $adm))
and (('$pervtor_' = 0) or ('$pervtor_'=1 and $perv_vtor)) 
and $otz_str
and $guzo
and (('$checkAllOblast_' = 'true') or ('$checkAllOblast_'='false' and $checkOblastsId_3 )  )
and $search
";


//echo $query;

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();


for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public $id_rkk, $num_rkk, $id_application , $naim, $perv_vtor, $date_reg, $ur_adress, $fact_adress, $tel, $email,
     $adm_reah, $adm_resh_num , $date_admin_resh, $svidetelstvo, $date_sved, $sved_srok_deist, $date_delo, $delo,
     $zaregal, $info_uved, $getter, $oblast, $dop_info, $date_protokol;
    
}

foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->id_rkk = $app['id_rkk'];
    $report->num_rkk = $app['num_rkk'];
    $report->id_application = $app['id_application'];
    $report->naim = $app['naim'];
    $report->perv_vtor = $app['perv_vtor'];
    $report->date_reg = $app['date_reg'];
    $report->ur_adress = $app['ur_adress'];
    $report->fact_adress = $app['fact_adress'];
    $report->tel = $app['tel'];
    $report->email = $app['email'];
    $report->adm_reah = $app['adm_reah'];
    $report->adm_resh_num = $app['adm_resh_num'];
    $report->date_admin_resh = $app['date_admin_resh'];
    $report->svidetelstvo = $app['svidetelstvo'];
    $report->date_sved = $app['date_sved'];
    $report->sved_srok_deist = $app['sved_srok_deist'];
    $report->date_delo = $app['date_delo'];
    $report->delo = $app['delo'];
    $report->zaregal = $app['zaregal'];
    $report->info_uved = $app['info_uved'];
    $report->getter = $app['getter'];
    $report->oblast = $app['oblast'];
    $report->dop_info = $app['dop_info'];
    $report->date_protokol = $app['date_protokol'];
    

    array_push($reports,$report);
}


echo json_encode($reports);
mysqli_close($con);

