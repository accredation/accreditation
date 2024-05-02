<?php

include "../../../ajax/connection.php";

$dateRkkReg = $_GET['dateRkkReg'];
$dateRkkReg_at = $_GET['dateRkkReg_at'];
$dateRkkReg_to = $_GET['dateRkkReg_to'];
$OblastsId = $_GET['OblastsId'];
$TypeId = $_GET['TypeId'];
$checkbox_adm_resh_1 = $_GET['checkbox_adm_resh_1'];
$checkbox_adm_resh_2 = $_GET['checkbox_adm_resh_2'];
$checkbox_adm_resh_3 = $_GET['checkbox_adm_resh_3'];
$adm_resh = $_GET['adm_resh'];
$guzo = $_GET['guzo'];
$checkbox_guzo_1 = $_GET['checkbox_guzo_1'];
$checkbox_guzo_2 = $_GET['checkbox_guzo_2'];
$type_report = $_GET['type_report']; 
$arrCriteria = $_GET['arrCriteria'];
$arrTable = $_GET['arrTableId'];


$date = date('d-m-y');

if($dateRkkReg == '0'){
    $dateRkkReg_at = $date;
    $dateRkkReg_to = $date;  
}

$adm = '';


 if($checkbox_adm_resh_1 === "true") {
    $adm = $adm  . "r.result='1'"; 
 } 

 
 if($checkbox_adm_resh_2=== "true") {
    if(strlen($adm)>0){
        $adm = $adm . ' or ';
     }
    $adm = $adm  . "r.result='2'"; 
 }

 if($checkbox_adm_resh_3=== "true") {
    if(strlen($adm)>0){
        $adm = $adm . ' or ';
     }
    $adm = $adm  . "r.result='3'"; 
 }

 if($adm === ''){
    $adm = '(' . 0 .'='. 0 . ')';
 }


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

/////////////////////////////////////////////////////////////////
//////////////// формирование условия по области
$oblastsIdStr2 = explode(',', $OblastsId);
$oblastsIdStr3 = '';

foreach($oblastsIdStr2 as $str1){
    $oblastsIdStr3 .= '(' . 'uz.oblast' . '=' . $str1 . ') or';
    //echo $str . "<br />";
}

if($OblastsId === ''){
    $oblastsIdStr3 = '0 = 0';
} else {
$oblastsIdStr3 = substr($oblastsIdStr3,0,-2);
$oblastsIdStr3 = '(' . $oblastsIdStr3 . ')';
}



//////////////////////////////////////////////////////////////
///////////// условие по типу ОЗ
$typeIdStr2 = explode(',', $TypeId);
$typeIdStr3 = '';

foreach($typeIdStr2 as $str3){
    $typeIdStr3 .= '(' . 'uz.id_type' . '=' . $str3 . ') or';
    //echo $str . "<br />";
}

if($TypeId === ''){
    $typeIdStr3 = '0 = 0';
} else {
$typeIdStr3 = substr($typeIdStr3,0,-2);
$typeIdStr3 = '(' . $typeIdStr3 . ')';
}

///////////////////////////

$criteriaIdStr2 = explode(',', $arrCriteria);
$criteriaIdStr3 = '';

foreach($criteriaIdStr2 as $strCrt){
    $criteriaIdStr3 .= '(' . $strCrt . ') ,';
    //echo $str . "<br />";
}

if($arrCriteria === ''){
    $criteriaIdStr3 = '0 = 0';
} else {
$criteriaIdStr3 = substr($criteriaIdStr3,0,-1);
}



$TableIdStr2 = explode(',', $arrTable);
$TableIdStr3 = '';

foreach($TableIdStr2 as $strTabl){
    $TableIdStr3 .= '(' . $strTabl . ') ,';
    //echo $str . "<br />";
}

if($arrTable === ''){
    $TableIdStr3 = '0 = 0';
} else {
$TableIdStr3 = substr($TableIdStr3,0,-1);
}


$query = "

CREATE TEMPORARY TABLE accreditation.`tmp_table_criteria`(
    id_critertia INT
    );

insert into accreditation.`tmp_table_criteria` 
values $criteriaIdStr3;

CREATE TEMPORARY TABLE accreditation.`tmp_table_list`(
    id_list_tables_criteria INT
    );

insert into accreditation.`tmp_table_list` 
values $TableIdStr3;    


CREATE TEMPORARY TABLE accreditation.`tmp_table_subvision`(
    id_uz INT, 
    username text, 
    id_subvision INT
    );
    
insert into accreditation.`tmp_table_subvision`
select  uz.id_uz, uz.username, s.id_subvision
from accreditation.rkk  r 
left outer join accreditation.applications a on r.id_application=a.id_application 
left outer join accreditation.subvision s on a.id_application=s.id_application
left outer join accreditation.uz uz on a.id_user=uz.id_uz
where a.id_status<>8
and (('$dateRkkReg' = 0) or ('$dateRkkReg'=1 and r.date_reg between '$dateRkkReg_at' and '$dateRkkReg_to'))
and (('$adm_resh' = 0) or ('$adm_resh'=1 and $adm))
and $guzo
and $oblastsIdStr3
and $typeIdStr3
;

CREATE TEMPORARY TABLE accreditation.`tmp_table_uz`( id_uz INT, username text ); 

insert into accreditation.`tmp_table_uz`
select distinct id_uz, username
from accreditation.`tmp_table_subvision`;


CREATE TEMPORARY TABLE accreditation.`tmp_table_department`(
    id_uz int, 
    id_department int, 
    id_list_tables_criteria int
    );
    
insert into accreditation.`tmp_table_department`
select id_uz, id_department, id_list_tables_criteria
from accreditation.`tmp_table_subvision` tts
left outer join accreditation.z_department d on tts.id_subvision=d.id_subvision
where d.id_list_tables_criteria in (select * from accreditation.`tmp_table_list`)
;
 

CREATE TEMPORARY TABLE accreditation.`tmp_table_report_criteria_count`(
    id_uz int, 
    id_list_tables_criteria int, 
    id_criteria int, 
    count_yes int, 
    count_no int, 
    count_not_need int,
    count_yes_accred int, 
    count_no_accred int, 
    count_not_need_accred int
    );
    
insert into accreditation.`tmp_table_report_criteria_count`    
select distinct id_uz, id_list_tables_criteria, ac.id_criteria, 
sum(if( field3=1 ,1,0)) as count_yes, sum(if( field3=2 ,1,0)) as count_no, sum(if( field3=3 ,1,0)) as count_not_need,
sum(if( field6=1 ,1,0)) as count_yes_accred, sum(if( field6=2 ,1,0)) as count_no_accred, sum(if( field6=3 ,1,0)) as count_not_need_accred
from accreditation.`tmp_table_department` ttd
left outer join accreditation.z_answer_criteria ac on ttd.id_department=ac.id_department
where ac.id_criteria in (select * from accreditation.`tmp_table_criteria`)
group by  id_uz, id_list_tables_criteria, ac.id_criteria
;


select ltc.name , c.id_criteria, c.pp, c.name as criteria_name,  
sum(count_yes) as count_yes, sum(count_no) as count_no, sum(count_not_need) as count_not_need,
sum(count_yes_accred) as count_yes_accred, sum(count_no_accred) as count_no_accred, sum(count_not_need_accred) as count_not_need_accred
from accreditation.`tmp_table_uz` tts
left outer join accreditation.`tmp_table_report_criteria_count` ttrcc on tts.id_uz=ttrcc.id_uz
left outer join accreditation.z_list_tables_criteria ltc on ttrcc.id_list_tables_criteria=ltc.id_list_tables_criteria
left outer join accreditation.z_criteria c on ttrcc.id_criteria=c.id_criteria
where ttrcc.id_uz  is not null
group by ltc.name, c.id_criteria, c.pp, c.name
order by ltc.name, c.id_criteria
;
";

mysqli_multi_query($con, $query);

class Report{
    public   $name, $id_criteria, $pp, $criteria_name, $count_yes, $count_no,
    $count_not_need, $count_yes_accred, $count_no_accred, $count_not_need_accred;
}

$reports = array();

do {
    /* сохранить набор результатов в PHP */
    if ($result =  mysqli_store_result($con)) {

        for ($data = []; $row = mysqli_fetch_row($result); $data[] = $row);
      
        foreach ($data as $app) {
            $obj = array();
            $report = new Report();
            $report->name = $app[0];
            $report->id_criteria = $app[1];
            $report->pp = $app[2];
            $report->criteria_name = $app[3];          
            $report->count_yes = $app[4];
            $report->count_no = $app[5];
            $report->count_not_need = $app[6];
            $report->count_yes_accred = $app[7];
            $report->count_no_accred = $app[8];
            $report->count_not_need_accred = $app[9];    
            array_push($reports,$report);
        } 
    }
   
} while (mysqli_next_result($con));



echo json_encode($reports);
mysqli_close($con);




