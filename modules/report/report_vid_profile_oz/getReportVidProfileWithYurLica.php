<?php

include "../../../ajax/connection.php";

$dateRkkReg = $_GET['dateRkkReg'];
$dateRkkReg_at = $_GET['dateRkkReg_at'];
$dateRkkReg_to = $_GET['dateRkkReg_to'];
$dateRkkProtcol = $_GET['dateRkkProtcol'];
$dateRkkProtcol_at = $_GET['dateRkkProtcol_at'];
$dateRkkProtcol_to = $_GET['dateRkkProtcol_to'];
$dateRkkSved = $_GET['dateRkkSved'];
$dateRkkSved_at = $_GET['dateRkkSved_at'];
$dateRkkSved_to = $_GET['dateRkkSved_to'];
$guzo = $_GET['guzo'];
$checkbox_guzo_1 = $_GET['checkbox_guzo_1'];
$checkbox_guzo_2 = $_GET['checkbox_guzo_2'];
$checkbox_pervtor_1 = $_GET['checkbox_pervtor_1'];
$checkbox_pervtor_2 = $_GET['checkbox_pervtor_2'];
$pervtor = $_GET['pervtor'];

$checkbox_adm_resh_1 = $_GET['checkbox_adm_resh_1'];
$checkbox_adm_resh_2 = $_GET['checkbox_adm_resh_2'];
$checkbox_adm_resh_3 = $_GET['checkbox_adm_resh_3'];
$adm_resh = $_GET['adm_resh'];
$OblastsId = $_GET['OblastsId'];
$StatusId = $_GET['StatusId'];


$date = date('d-m-y');

if($dateRkkReg == '0'){
    $dateRkkReg_at = $date;
    $dateRkkReg_to = $date;  
}

if($dateRkkProtcol == '0'){
    $dateRkkProtcol_at = $date;
    $dateRkkProtcol_to = $date;  
}

if($dateRkkSved == '0'){
    $dateRkkSved_at = $date;
    $dateRkkSved_to = $date;  
}

$adm = '';


 if($checkbox_adm_resh_1 === "true") {
    $adm = $adm  . "rkk.result='1'"; 
 } 

 
 if($checkbox_adm_resh_2=== "true") {
    if(strlen($adm)>0){
        $adm = $adm . ' or ';
     }
    $adm = $adm  . "rkk.result='2'"; 
 }

 if($checkbox_adm_resh_3=== "true") {
    if(strlen($adm)>0){
        $adm = $adm . ' or ';
     }
    $adm = $adm  . "rkk.result='3'"; 
 }

 if($adm === ''){
    $adm = '(' . 0 .'='. 0 . ')';
 }else {
   $adm = '(' . $adm . ')';
}

 $perv_vtor = '';

 if($checkbox_pervtor_1 === "true") {
    $perv_vtor = $perv_vtor  . "rkk.perv_vtor=1"; 
 } 

 if($checkbox_pervtor_2 === "true") {
    if(strlen($perv_vtor)>0){
        $perv_vtor = $perv_vtor . ' or ';
     }
    $perv_vtor = $perv_vtor  . "rkk.perv_vtor=2"; 
 } 

 if($perv_vtor === ''){
    $perv_vtor = '(' . 0 .'='. 0 . ')';
 }else {
   $perv_vtor = '(' . $perv_vtor . ')';
}


 $guzo = '';

 if($checkbox_guzo_1 === "true") {
    $guzo = $guzo  . "rkk.checkboxValueGuzo=1"; 
 } 

 if($checkbox_guzo_2 === "true") {
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
///////////// условие по статусу
$statusIdStr2 = explode(',', $StatusId);
$statusIdStr3 = '';
foreach($statusIdStr2 as $str2){
    $statusIdStr3 .= '(' . 'a.id_status' . '=' . $str2 . ') or';
}

if($StatusId === ''){
    $statusIdStr3 = '0 = 0';
} else {
$statusIdStr3 = substr($statusIdStr3,0,-2);
$statusIdStr3 = '(' . $statusIdStr3 . ')';
} 


 /*
-- drop TEMPORARY TABLE accreditation.`tmp_table_uz`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_vid_all`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_vid`;



-- drop TEMPORARY TABLE accreditation.`tmp_table_report_uz`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_report_vid`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_report_vid_not_in`;

-- drop TEMPORARY TABLE accreditation.`tmp_table_vid_sved`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_report_vid_sved`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_report_vid_sved_not_in`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_profile_all`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_profile`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_profile_sved`;

-- drop TEMPORARY TABLE accreditation.`tmp_table_report_profile`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_report_profile_not_in`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_report_profile_sved`;
-- drop TEMPORARY TABLE accreditation.`tmp_table_report_profile_sved_not_in`;
 */


$query = "

SET SESSION  group_concat_max_len =100000;

CREATE TEMPORARY TABLE accreditation.`tmp_table_uz`(
id_oblast INT, 
id_uz int, 
id_application int, 
id_rkk int,
sved varchar(500) 
);

insert into accreditation.`tmp_table_uz`
select uz.oblast, uz.id_uz, a.id_application, rkk.id_rkk, case when trim(rkk.svidetelstvo)='' then null else rkk.svidetelstvo end  
from accreditation.rkk rkk
join accreditation.applications a on rkk.id_application=a.id_application
left outer join accreditation.uz uz on a.id_user=uz.id_uz
where a.id_status not in (5,8)
and a.date_create_app is not null
and (('$dateRkkReg' = 0) or ('$dateRkkReg'=1 and rkk.date_reg between '$dateRkkReg_at' and '$dateRkkReg_to'))
and (('$dateRkkProtcol' = 0) or ('$dateRkkProtcol'=1 and rkk.date_protokol between '$dateRkkProtcol_at' and '$dateRkkProtcol_to'))
and (('$dateRkkSved' = 0) or ('$dateRkkSved'=1 and rkk.date_sved between '$dateRkkSved_at' and '$dateRkkSved_to'))
and (('$adm_resh' = 0) or ('$adm_resh'=1 and $adm))
and (('$pervtor' = 0) or ('$pervtor'=1 and $perv_vtor)) 
and $guzo
and $statusIdStr3
and $oblastsIdStr3

;



CREATE TEMPORARY TABLE accreditation.`tmp_table_report_uz`( 
id_oblast int,  
id_uz int  , 
count_app int,
sved_count int,
sved_name text
);

insert into accreditation.`tmp_table_report_uz`(id_oblast, id_uz, count_app, sved_count , sved_name)
select id_oblast, id_uz, count(id_application) as count_app, sum(if(sved is not null,1,0)) as count_sved, GROUP_CONCAT(' ',sved) as sved_name  
from accreditation.`tmp_table_uz` 
group by id_oblast, id_uz
;


CREATE TEMPORARY TABLE accreditation.`tmp_table_vid_all`( 
id_uz int,  
id_types_tables int,
vid_in_journal int,
accred_svid int,
sved varchar(500) 
);

insert into accreditation.`tmp_table_vid_all`(id_types_tables, id_uz, vid_in_journal, sved, accred_svid)
select distinct l.id_types_tables, tmp.id_uz, 
case when l.id_types_tables in (select id_vid from accreditation.uz_vid where tmp.id_uz=id_uz) then 1 else 0 end vid_in_jou,
tmp.sved, d.accred_svid
from accreditation.`tmp_table_uz` tmp
left outer join accreditation.applications a on tmp.id_application=a.id_application
left outer join accreditation.subvision s on a.id_application=s.id_application
left outer join accreditation.z_department d on s.id_subvision=d.id_subvision
left outer join accreditation.z_list_tables_criteria l on d.id_list_tables_criteria=l.id_list_tables_criteria;


CREATE TEMPORARY TABLE accreditation.`tmp_table_vid`( 
id_uz int,  
id_types_tables int,
vid_in_journal int
);

insert into accreditation.`tmp_table_vid`(id_types_tables, id_uz, vid_in_journal)
select distinct id_types_tables, id_uz, vid_in_journal
from accreditation.`tmp_table_vid_all` tmp;




CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid`( 
id_uz int  , 
vid_count int,
vid_name text,
vid_lishn_count int,
vid_lishn_name text
);

insert into accreditation.`tmp_table_report_vid`(id_uz, vid_count, vid_lishn_count, vid_name, vid_lishn_name)
select id_uz, sum(if(vid_in_journal=1,1,0)) as vid_count, sum(if(vid_in_journal=0,1,0)) as vid_lishn_count, 
GROUP_CONCAT(if(vid_in_journal=1,concat(' ',t.name),null)) as vid_name, GROUP_CONCAT(if(vid_in_journal=0,concat(' ',t.name),null)) as vid_lishn_name 
from accreditation.`tmp_table_vid` tmp
left outer join accreditation.z_types_tables t on tmp.id_types_tables=t.id_types_tables
group by id_uz;



CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_not_in`( 
id_uz int,  
count_vid_not_in int,
name_vid_not_in text
);

insert into accreditation.`tmp_table_report_vid_not_in`(id_uz, count_vid_not_in, name_vid_not_in)
select distinct uv.id_uz, count(id_vid), GROUP_CONCAT(' ',t.name) 
from accreditation.uz_vid uv
left outer join accreditation.z_types_tables t on uv.id_vid=t.id_types_tables
where id_vid not in (select id_types_tables from accreditation.`tmp_table_vid` tmp where uv.id_uz=tmp.id_uz)
group by uv.id_uz;


CREATE TEMPORARY TABLE accreditation.`tmp_table_vid_sved`( 
id_uz int,  
id_types_tables int,
vid_in_journal int
);


insert into accreditation.`tmp_table_vid_sved`(id_types_tables, id_uz, vid_in_journal)
select  distinct tmp.id_types_tables, tmp.id_uz, tmp.vid_in_journal 
from accreditation.`tmp_table_vid_all` tmp
where tmp.sved is not null
and tmp.accred_svid=1;


CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_sved`( 
id_uz int  , 
vid_sved_count int,
vid_sved_name text,
vid_sved_lishn_count int,
vid_sved_lishn_name text
);

insert into accreditation.`tmp_table_report_vid_sved`(id_uz, vid_sved_count, vid_sved_lishn_count, vid_sved_name, vid_sved_lishn_name)
select id_uz, sum(if(vid_in_journal=1,1,0)) as vid_count, sum(if(vid_in_journal=0,1,0)) as vid_lishn_count, 
GROUP_CONCAT(if(vid_in_journal=1,concat(' ',t.name),null)) as vid_name, GROUP_CONCAT(if(vid_in_journal=0,concat(' ',t.name),null)) as vid_lishn_name 
from accreditation.`tmp_table_vid_sved` tmp
left outer join accreditation.z_types_tables t on tmp.id_types_tables=t.id_types_tables
group by id_uz;



CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_sved_not_in`( 
id_uz int,  
count_vid_sved_not_in int,
name_vid_sved_not_in text
);

insert into accreditation.`tmp_table_report_vid_sved_not_in`(id_uz, count_vid_sved_not_in, name_vid_sved_not_in)
select distinct uv.id_uz, count(id_vid), GROUP_CONCAT(' ',t.name) 
from accreditation.uz_vid uv
left outer join accreditation.z_types_tables t on uv.id_vid=t.id_types_tables
where id_vid not in (select id_types_tables from accreditation.`tmp_table_vid_sved` tmp where uv.id_uz=tmp.id_uz)
group by uv.id_uz;


CREATE TEMPORARY TABLE accreditation.`tmp_table_profile_all`( 
id_uz int,  
id_profile int,
profile_in_journal int,
sved text,
accred_svid int
);


insert into accreditation.`tmp_table_profile_all`(id_profile, id_uz, profile_in_journal,sved, accred_svid)
select  distinct l.id_profile, tmp.id_uz, 
case when l.id_profile in (select id_profile from accreditation.uz_profile where tmp.id_uz=id_uz) then 1 else 0 end vid_in_jou, 
tmp.sved, d.accred_svid
from accreditation.`tmp_table_uz` tmp
left outer join accreditation.applications a on tmp.id_application=a.id_application
left outer join accreditation.subvision s on a.id_application=s.id_application
left outer join accreditation.z_department d on s.id_subvision=d.id_subvision
left outer join accreditation.z_list_tables_criteria l on d.id_list_tables_criteria=l.id_list_tables_criteria
where l.id_profile is not null
;


CREATE TEMPORARY TABLE accreditation.`tmp_table_profile`( 
id_uz int,  
id_profile int,
profile_in_journal int
);


insert into accreditation.`tmp_table_profile`(id_profile, id_uz, profile_in_journal)
select  distinct tmp.id_profile, tmp.id_uz, profile_in_journal 
from accreditation.`tmp_table_profile_all` tmp
;


CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile`( 
id_uz int  , 
profile_count int,
profile_name text,
profile_lishn_count int,
profile_lishn_name text
);

insert into accreditation.`tmp_table_report_profile`(id_uz, profile_count, profile_lishn_count, profile_name, profile_lishn_name)
select id_uz, sum(if(profile_in_journal=1,1,0)) as profile_count, sum(if(profile_in_journal=0,1,0)) as profile_lishn_count, 
GROUP_CONCAT(if(profile_in_journal=1,concat(' ',t.profile_name),null)) as profile_name, GROUP_CONCAT(if(profile_in_journal=0,concat(' ',t.profile_name),null)) as profile_lishn_name 
from accreditation.`tmp_table_profile` tmp
left outer join accreditation.spr_profile t on tmp.id_profile=t.id_profile
group by id_uz;


CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_not_in`( 
id_uz int,  
count_profile_not_in int,
name_profile_not_in text
);

insert into accreditation.`tmp_table_report_profile_not_in`(id_uz, count_profile_not_in, name_profile_not_in)
select distinct uv.id_uz, count(uv.id_profile), GROUP_CONCAT(' ',t.profile_name) 
from accreditation.uz_profile uv
left outer join accreditation.spr_profile t on uv.id_profile=t.id_profile
where uv.id_profile not in (select id_profile from accreditation.`tmp_table_profile` tmp where uv.id_uz=tmp.id_uz)
group by uv.id_uz;





CREATE TEMPORARY TABLE accreditation.`tmp_table_profile_sved`( 
id_uz int,  
id_profile int,
profile_in_journal int
);

insert into accreditation.`tmp_table_profile_sved`(id_profile, id_uz, profile_in_journal)
select  distinct tmp.id_profile, tmp.id_uz, tmp.profile_in_journal
from accreditation.`tmp_table_profile_all` tmp
where tmp.sved is not null
and tmp.accred_svid=1
;


CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_sved`( 
id_uz int  , 
profile_sved_count int,
profile_sved_name text,
profile_sved_lishn_count int,
profile_sved_lishn_name text
);

insert into accreditation.`tmp_table_report_profile_sved`(id_uz, profile_sved_count, profile_sved_lishn_count, profile_sved_name, profile_sved_lishn_name)
select id_uz, sum(if(profile_in_journal=1,1,0)) as profile_count, sum(if(profile_in_journal=0,1,0)) as profile_lishn_count, 
GROUP_CONCAT(if(profile_in_journal=1,concat(' ',t.profile_name),null)) as vid_name, GROUP_CONCAT(if(profile_in_journal=0,concat(' ',t.profile_name),null)) as profile_lishn_name 
from accreditation.`tmp_table_profile_sved` tmp
left outer join accreditation.spr_profile t on tmp.id_profile=t.id_profile
group by id_uz;



CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_sved_not_in`( 
id_uz int,  
count_profile_sved_not_in int,
name_profile_sved_not_in text
);

insert into accreditation.`tmp_table_report_profile_sved_not_in`(id_uz, count_profile_sved_not_in, name_profile_sved_not_in)
select distinct uv.id_uz, count(uv.id_profile), GROUP_CONCAT(' ',t.profile_name) 
from accreditation.uz_profile uv
left outer join accreditation.spr_profile t on uv.id_profile=t.id_profile
where uv.id_profile not in (select id_profile from accreditation.`tmp_table_profile_sved` tmp where uv.id_uz=tmp.id_uz)
group by uv.id_uz;


select 
so.oblast, uz.username, count_app, sved_count, sved_name, 
vid_count, vid_name, vid_lishn_count, vid_lishn_name, count_vid_not_in,name_vid_not_in, 
vid_sved_count, vid_sved_name, vid_sved_lishn_count, vid_sved_lishn_name, count_vid_sved_not_in,name_vid_sved_not_in,
profile_count, profile_name, profile_lishn_count, profile_lishn_name, count_profile_not_in, name_profile_not_in,
profile_sved_count, profile_sved_name, profile_sved_lishn_count, profile_sved_lishn_name, count_profile_sved_not_in, name_profile_sved_not_in

from accreditation.`tmp_table_report_uz` ttz 
left outer join accreditation.`tmp_table_report_vid` ttrv on ttz.id_uz=ttrv.id_uz
left outer join accreditation.`tmp_table_report_vid_not_in` ttrvn on ttz.id_uz=ttrvn.id_uz 
left outer join accreditation.`tmp_table_report_vid_sved` ttrvs on ttz.id_uz=ttrvs.id_uz and ttz.sved_count>0
left outer join accreditation.`tmp_table_report_vid_sved_not_in` ttrvsn on ttz.id_uz=ttrvsn.id_uz and ttz.sved_count>0

left outer join accreditation.`tmp_table_report_profile` ttrp on ttz.id_uz=ttrp.id_uz
left outer join accreditation.`tmp_table_report_profile_not_in` ttrpn on ttz.id_uz=ttrpn.id_uz
left outer join accreditation.`tmp_table_report_profile_sved` ttrps on ttz.id_uz=ttrps.id_uz and ttz.sved_count>0
left outer join accreditation.`tmp_table_report_profile_sved_not_in` ttrpsn on ttz.id_uz=ttrpsn.id_uz and ttz.sved_count>0

left outer join accreditation.spr_oblast so on ttz.id_oblast=so.id_oblast
left outer join accreditation.uz uz on ttz.id_uz=uz.id_uz

order by so.order_num, uz.username
;





";

/*
drop TEMPORARY TABLE accreditation.`tmp_table_uz`;

drop TEMPORARY TABLE accreditation.`tmp_table_vid`;
drop TEMPORARY TABLE accreditation.`tmp_table_vid_all`;
drop TEMPORARY TABLE accreditation.`tmp_table_vid_sved`;
drop TEMPORARY TABLE accreditation.`tmp_table_profile`;
drop TEMPORARY TABLE accreditation.`tmp_table_profile_sved`;

drop TEMPORARY TABLE accreditation.`tmp_table_report_uz`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_vid`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_vid_not_in`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_vid_sved`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_vid_sved_not_in`;
drop TEMPORARY TABLE accreditation.`tmp_table_profile_all`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_profile`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_profile_not_in`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_profile_sved`;
drop TEMPORARY TABLE accreditation.`tmp_table_report_profile_sved_not_in`;
*/


// echo $query;

// ('$id_scriteria_str'='' or ('$id_scriteria_str'<>'' and 

// $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
// $rez = mysqli_multi_query($con, $query) or die("Ошибка " . mysqli_error($con));


mysqli_multi_query($con, $query);

class Report{
    public  $oblast, $username, $count_app, $sved_count, $sved_name, $vid_count, $vid_name, $vid_lishn_count, $vid_lishn_name, 
    $count_vid_not_in, $name_vid_not_in, $vid_sved_count, $vid_sved_name, $vid_sved_lishn_count, $vid_sved_lishn_name, 
    $count_vid_sved_not_in, $name_vid_sved_not_in, $profile_count, $profile_name, $profile_lishn_count, $profile_lishn_name, 
    $count_profile_not_in, $name_profile_not_in, $profile_sved_count, $profile_sved_name, $profile_sved_lishn_count, 
    $profile_sved_lishn_name, $count_profile_sved_not_in, $name_profile_sved_not_in;


}

$reports = array();

do {
    /* сохранить набор результатов в PHP */
    if ($result =  mysqli_store_result($con)) {

        for ($data = []; $row = mysqli_fetch_row($result); $data[] = $row);
      

        foreach ($data as $app) {
            $obj = array();
            $report = new Report();
            $report->oblast = $app[0];
            $report->username = $app[1];
            $report->count_app = $app[2];
            $report->sved_count = $app[3];
            $report->sved_name = $app[4];
            $report->vid_count = $app[5];
            $report->vid_name = $app[6];
        
            $report->vid_lishn_count = $app[7];
            $report->vid_lishn_name = $app[8];
            $report->count_vid_not_in = $app[9];
            $report->name_vid_not_in = $app[10];
            $report->vid_sved_count = $app[11];
            $report->vid_sved_name = $app[12];
            $report->vid_sved_lishn_count = $app[13];
            $report->vid_sved_lishn_name = $app[14];
            $report->count_vid_sved_not_in = $app[15];
            $report->name_vid_sved_not_in = $app[16];
            $report->profile_count = $app[17];
            $report->profile_name = $app[18];
            $report->profile_lishn_count = $app[19];
            $report->profile_lishn_name = $app[20];
            $report->count_profile_not_in = $app[21];
            $report->name_profile_not_in = $app[22];
            $report->profile_sved_count = $app[23];
            $report->profile_sved_name = $app[24];
        
            $report->profile_sved_lishn_count = $app[25];
            $report->profile_sved_lishn_name = $app[26];
            $report->count_profile_sved_not_in = $app[27];
            $report->name_profile_sved_not_in = $app[28];
        
        
            array_push($reports,$report);
        
        }

        
    }
   
} while (mysqli_next_result($con));



echo json_encode($reports);
mysqli_close($con);




