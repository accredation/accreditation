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


$query = "

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
    
    
    CREATE TEMPORARY TABLE accreditation.`tmp_table_uz_not_vid`( 
    id_uz int
    );
    
    insert into accreditation.`tmp_table_uz_not_vid`(id_uz)
    select distinct uv.id_uz 
    from accreditation.uz_vid uv
    left outer join accreditation.`tmp_table_vid_all` ttva on uv.id_uz=ttva.id_uz and uv.id_vid=ttva.id_types_tables
    where ttva.id_uz is null 
    ;
    
    
    -- оз которые подались с дополнительными видами по перечню
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_lishn`( 
    id_uz int
    );
    insert into  accreditation.`tmp_table_report_vid_lishn`
    select distinct(ttva.id_uz)
    from accreditation.`tmp_table_vid_all` ttva
    left outer join  accreditation.uz_vid uv on ttva.id_uz=uv.id_uz and ttva.id_types_tables=uv.id_vid
    where  uv.id_uz is null;
    
    
    -- оз которые подались по перечню
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_vid`
    select distinct(uv.id_uz)
    from accreditation.uz_vid uv
    where uv.id_uz not in (select id_uz from accreditation.`tmp_table_uz_not_vid`);
    
    
    -- оз которые подались не по перечню
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_not`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_vid_not`
    select distinct(id_uz) 
    from accreditation.`tmp_table_uz_not_vid`;
    
    
    -- оз со свидетельствами
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_sved`( 
    id_uz int
    );
    
    
    insert into accreditation.`tmp_table_report_sved`
    select distinct id_uz
    from accreditation.`tmp_table_uz`
    where sved is not null;
    
    
    
    
    CREATE TEMPORARY TABLE accreditation.`tmp_table_uz_not_vid_sved`( 
    id_uz int
    );
    
    insert into accreditation.`tmp_table_uz_not_vid_sved`(id_uz)
    select distinct uv.id_uz 
    from accreditation.uz_vid uv
    left outer join accreditation.`tmp_table_vid_all` ttva on uv.id_uz=ttva.id_uz and uv.id_vid=ttva.id_types_tables and ttva.accred_svid=1 and ttva.sved is not null
    where ttva.id_uz is null
    ;
    
    
    
    -- оз которые подались с дополнительными видами по перечню со свидетельством
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_lishn_sved`( 
    id_uz int
    );
    insert into  accreditation.`tmp_table_report_vid_lishn_sved`
    select distinct(ttva.id_uz)
    from accreditation.`tmp_table_vid_all` ttva
    left outer join  accreditation.uz_vid uv on ttva.id_uz=uv.id_uz and ttva.id_types_tables=uv.id_vid
    where  uv.id_uz is null and ttva.accred_svid=1;
    
    
    -- оз которые подались по перечню  со свидетельством
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_sved`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_vid_sved`
    select distinct(uv.id_uz)
    from accreditation.uz_vid uv
    where uv.id_uz not in (select id_uz from accreditation.`tmp_table_uz_not_vid_sved`);
    
    
    -- оз которые подались не по перечню  со свидетельством
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_vid_not_sved`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_vid_not_sved`
    select distinct(id_uz) 
    from accreditation.`tmp_table_uz_not_vid_sved`;
    
    
    
    
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
    
    
    
    
    CREATE TEMPORARY TABLE accreditation.`tmp_table_uz_not_profile`( 
    id_uz int
    );
    
    insert into accreditation.`tmp_table_uz_not_profile`(id_uz)
    select distinct uv.id_uz 
    from accreditation.uz_profile uv
    left outer join accreditation.`tmp_table_profile_all` ttva on uv.id_uz=ttva.id_uz and uv.id_profile=ttva.id_profile
    where ttva.id_uz is null 
    ;
    
    
    
    -- оз которые подались с дополнительными профилю по перечню
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_lishn`( 
    id_uz int
    );
    insert into  accreditation.`tmp_table_report_profile_lishn`
    select distinct(ttva.id_uz)
    from accreditation.`tmp_table_profile_all` ttva
    left outer join  accreditation.uz_profile uv on ttva.id_uz=uv.id_uz and ttva.id_profile=uv.id_profile
    where  uv.id_uz is null;
    
    
    -- оз которые подались по перечню профилю
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_profile`
    select distinct(uv.id_uz)
    from accreditation.uz_profile uv
    where uv.id_uz not in (select id_uz from accreditation.`tmp_table_uz_not_profile`);
    
    
    -- оз которые подались не по перечню профилю
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_not`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_profile_not`
    select distinct(id_uz) 
    from accreditation.`tmp_table_uz_not_profile`;
    
    
    CREATE TEMPORARY TABLE accreditation.`tmp_table_uz_not_profile_sved`( 
    id_uz int
    );
    
    insert into accreditation.`tmp_table_uz_not_profile_sved`(id_uz)
    select distinct uv.id_uz 
    from accreditation.uz_profile uv
    left outer join accreditation.`tmp_table_profile_all` ttva on uv.id_uz=ttva.id_uz and uv.id_profile=ttva.id_profile and ttva.accred_svid=1 and ttva.sved is not null
    where ttva.id_uz is null
    ;
    
    
    
    -- оз которые подались с дополнительными видами по перечню со свидетельством
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_lishn_sved`( 
    id_uz int
    );
    insert into  accreditation.`tmp_table_report_profile_lishn_sved`
    select distinct(ttva.id_uz)
    from accreditation.`tmp_table_profile_all` ttva
    left outer join  accreditation.uz_profile uv on ttva.id_uz=uv.id_uz and ttva.id_profile=uv.id_profile
    where  uv.id_uz is null and ttva.accred_svid=1;
    
    
    -- оз которые подались по перечню  со свидетельством
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_sved`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_profile_sved`
    select distinct(uv.id_uz)
    from accreditation.uz_profile uv
    where uv.id_uz not in (select id_uz from accreditation.`tmp_table_uz_not_profile_sved`);
    
    
    -- оз которые подались не по перечню  со свидетельством
    CREATE TEMPORARY TABLE accreditation.`tmp_table_report_profile_not_sved`( 
    id_uz int
    );
    
    insert into  accreditation.`tmp_table_report_profile_not_sved`
    select distinct(id_uz) 
    from accreditation.`tmp_table_uz_not_profile_sved`;
    
    
    select so.oblast, so.order_num, count(ttru.id_uz) as count_uz, 
    sum(if(ttrv.id_uz is not null ,1,0)) as count_vid, sum(if(ttrvn.id_uz is not null ,1,0)) as count_vid_not,
    sum(if(ttrvl.id_uz is not null ,1,0)) as count_vid_lishn, 
    sum(if(ttrp.id_uz is not null ,1,0)) as count_profile, sum(if(ttrpn.id_uz is not null ,1,0)) as count_profile_not,
    sum(if(ttrpl.id_uz is not null ,1,0)) as count_profile_lishn, 
    sum(if(ttrs.id_uz is not null ,1,0)) as count_sved,
    sum(if(ttrvs.id_uz is not null ,1,0)) as count_vid_sved, sum(if(ttrvns.id_uz is not null ,1,0)) as count_vid_not_sved,
    sum(if(ttrvls.id_uz is not null ,1,0)) as count_vid_lishn_sved,
    sum(if(ttrps.id_uz is not null ,1,0)) as count_profile_sved, sum(if(ttrpns.id_uz is not null ,1,0)) as count_profile_not_sved,
    sum(if(ttrpls.id_uz is not null ,1,0)) as count_profile_lishn_sved
    
    from accreditation.`tmp_table_report_uz` ttru
    left outer join accreditation.`tmp_table_report_vid` ttrv on ttru.id_uz=ttrv.id_uz
    left outer join accreditation.`tmp_table_report_vid_not` ttrvn on ttru.id_uz=ttrvn.id_uz
    left outer join accreditation.`tmp_table_report_vid_lishn` ttrvl on ttru.id_uz=ttrvl.id_uz
    left outer join accreditation.`tmp_table_report_sved` ttrs on ttru.id_uz=ttrs.id_uz
    left outer join accreditation.`tmp_table_report_vid_sved` ttrvs on ttru.id_uz=ttrvs.id_uz and ttru.sved_count>0
    left outer join accreditation.`tmp_table_report_vid_not_sved` ttrvns on ttru.id_uz=ttrvns.id_uz and ttru.sved_count>0
    left outer join accreditation.`tmp_table_report_vid_lishn_sved` ttrvls on ttru.id_uz=ttrvls.id_uz and ttru.sved_count>0
    left outer join accreditation.`tmp_table_report_profile` ttrp on ttru.id_uz=ttrp.id_uz
    left outer join accreditation.`tmp_table_report_profile_not` ttrpn on ttru.id_uz=ttrpn.id_uz
    left outer join accreditation.`tmp_table_report_profile_lishn` ttrpl on ttru.id_uz=ttrpl.id_uz
    left outer join accreditation.`tmp_table_report_profile_sved` ttrps on ttru.id_uz=ttrps.id_uz and ttru.sved_count>0
    left outer join accreditation.`tmp_table_report_profile_not_sved` ttrpns on ttru.id_uz=ttrpns.id_uz and ttru.sved_count>0
    left outer join accreditation.`tmp_table_report_profile_lishn_sved` ttrpls on ttru.id_uz=ttrpls.id_uz and ttru.sved_count>0
    left outer join accreditation.spr_oblast so on ttru.id_oblast=so.id_oblast 
    group by so.oblast, so.order_num
    order by so.order_num
    ;
";


mysqli_multi_query($con, $query);

class Report{
    public   $oblast, $order_num, $count_uz, $count_vid, $count_vid_not,
    $count_vid_lishn, $count_profile, $count_profile_not, $count_profile_lishn, 
    $count_sved, $count_vid_sved, $count_vid_not_sved, $count_vid_lishn_sved,
    $count_profile_sved, $count_profile_not_sved, $count_profile_lishn_sved;
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
            $report->order_num = $app[1];
            $report->count_uz = $app[2];          
            $report->count_vid = $app[3];
            $report->count_vid_not = $app[4];
            $report->count_vid_lishn = $app[5];
            $report->count_profile = $app[6];
            $report->count_profile_not = $app[7];
            $report->count_profile_lishn = $app[8];
            $report->count_sved = $app[9];
            $report->count_vid_sved = $app[10];
            $report->count_vid_not_sved = $app[11];
            $report->count_vid_lishn_sved = $app[12];
            $report->count_profile_sved = $app[13];
            $report->count_profile_not_sved = $app[14];
            $report->count_profile_lishn_sved = $app[15];        
            array_push($reports,$report);
        } 
    }
   
} while (mysqli_next_result($con));



echo json_encode($reports);
mysqli_close($con);




