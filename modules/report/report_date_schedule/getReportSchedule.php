<?php

include "../../../ajax/connection.php";

$period = $_GET['period'];
$period_at = $_GET['period_at'];
$period_to = $_GET['period_to']; 
$type_report = $_GET['type_report']; 
$year_schedule = $_GET['year_schedule']; 
$count_day = $_GET['count_day']; 
$checkAllOblast = $_GET['checkAllOblast']; 
$checkOblasts = $_GET['checkOblasts']; 
$checkOblastsId = $_GET['checkOblastsId']; 

$date = date('d-m-y');
if($period == '0'){
    $period_at = $date;
    $period_to = $date;  
}

$checkOblastsId_2 = explode(',', $checkOblastsId);
$checkOblastsId_3 = '';
$checkOblastsId_3_ = '';

foreach($checkOblastsId_2 as $str){
    $checkOblastsId_3 .= '(' . 'u.oblast' . '=' . $str . ') or';
    $checkOblastsId_3_ .= '(' . 'u2.oblast' . '=' . $str . ') or';
}

if($checkOblastsId === ''){
    $checkOblastsId_3 = '0 = 0';
    $checkOblastsId_3_ = '0 = 0';
} else {
$checkOblastsId_3 = substr($checkOblastsId_3,0,-2);
$checkOblastsId_3 = '(' . $checkOblastsId_3 . ')';

$checkOblastsId_3_ = substr($checkOblastsId_3_,0,-2);
$checkOblastsId_3_ = '(' . $checkOblastsId_3_ . ')';
}


$query = "SELECT a.id_application, u.username, a.date_create_app, s.name_status, a.date_send, sdo.schedule_date, DATE_ADD(sdo.schedule_date ,INTERVAL @count_day DAY) as date_on_schedule,
a.ur_adress, a.fact_adress, a.tel, a.email, so.oblast
FROM accreditation.schedule_date_oz sdo 
left outer join accreditation.uz u on sdo.id_uz=u.id_uz
left outer join accreditation.applications a on a.id_user=u.id_uz  and a.id_status <>8
left outer join accreditation.spr_type_organization sto on u.id_type=sto.id_type
left outer join accreditation.spr_oblast so on u.oblast=so.id_oblast
left outer join accreditation.status s on a.id_status=s.id_status
where 
	('$type_report' = 1  -- все созданные
		and sdo.year='$year_schedule' 
        and a.date_create_app between '$period_at' and '$period_to' 
        and (('$checkAllOblast' = 'true') or ('$checkAllOblast'='false' and $checkOblastsId_3 )  )
	) 
or ('$type_report' = 2  -- Подавшие заявление по графику
		and sdo.year='$year_schedule' 
        and a.date_create_app between '$period_at' and '$period_to' 
        and ( a.date_send >= sdo.schedule_date and a.date_send <= DATE_ADD(sdo.schedule_date ,INTERVAL '$count_day' DAY) )
        and (('$checkAllOblast' = 'true') or ('$checkAllOblast'='false' and $checkOblastsId_3 )  )
        ) 
or ('$type_report' = 3 -- Подавшие заявление не по графику
		and sdo.year='$year_schedule' 
        and a.date_create_app between '$period_at' and '$period_to' 
        and ( a.date_send < sdo.schedule_date or a.date_send > DATE_ADD(sdo.schedule_date ,INTERVAL '$count_day' DAY) )
        and (('$checkAllOblast' = 'true') or ('$checkAllOblast'='false' and $checkOblastsId_3 )  )
        ) 
or ('$type_report' = 4 -- Не подавшие заявление по графику
		and sdo.year='$year_schedule' 
        and a.date_create_app between '$period_at' and '$period_to' 
        and a.date_send is null
        and (('$checkAllOblast' = 'true') or ('$checkAllOblast'='false' and $checkOblastsId_3 )  )
        )
or ('$type_report' = 6 -- Организации здравоохранения с пустой датой в графике
		and sdo.year='$year_schedule' 
        and sdo.schedule_date is null 
        and (('$checkAllOblast' = 'true') or ('$checkAllOblast'='false' and $checkOblastsId_3 )  )
       -- and a.date_create_app between '$period_at' and '$period_to' 
        )       
union
SELECT null as id_application, u2.username,  null as date_create_app,  null as name_status,  null as date_send, sdo2.schedule_date,  DATE_ADD(sdo2.schedule_date ,INTERVAL '$count_day' DAY) as date_on_schedule,
null as  ur_adress, null as fact_adress, null as tel, null as email, so2.oblast
FROM accreditation.schedule_date_oz sdo2 
left outer join accreditation.uz u2 on sdo2.id_uz=u2.id_uz
left outer join accreditation.spr_type_organization sto2 on u2.id_type=sto2.id_type
left outer join accreditation.spr_oblast so2 on u2.oblast=so2.id_oblast
where  
	('$type_report' = 5 -- Не создавшие заявление в отчетный период
	and sdo2.year='$year_schedule' 
    and (sdo2.id_uz not in (select id_user from accreditation.applications where date_create_app between '$period_at' and '$period_to'))    
    and (('$checkAllOblast' = 'true') or ('$checkAllOblast'='false' and $checkOblastsId_3_ )  )
    )

order by username
";


//echo $query;

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();


for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public $id_application, $username, $date_create_app , $name_status, $date_send, $schedule_date, $date_on_schedule, 
    $ur_adress, $fact_adress, $tel, $email, $oblast;
    
}

foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->id_application = $app['id_application'];
    $report->username = $app['username'];
    $report->date_create_app = $app['date_create_app'];
    $report->name_status = $app['name_status'];
    $report->date_send = $app['date_send'];
    $report->schedule_date = $app['schedule_date'];
    $report->date_on_schedule = $app['date_on_schedule'];
    $report->ur_adress = $app['ur_adress'];
    $report->fact_adress = $app['fact_adress'];
    $report->tel = $app['tel'];
    $report->email = $app['email'];
    $report->oblast = $app['oblast'];

    array_push($reports,$report);
}


echo json_encode($reports);
mysqli_close($con);

