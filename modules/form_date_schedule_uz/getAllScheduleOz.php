<?php

include "../../ajax/connection.php";
$year = $_GET['year'];

$query = "SELECT *
from accreditation.schedule_date_oz sch_oz
left outer join accreditation.uz u on sch_oz.id_uz=u.id_uz

where sch_oz.year='$year'
order by schedule_date, username 
";



$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

class ScheduleDate{
    public $id_schedule, $username, $schedule_date;
    
}

if (mysqli_num_rows($rez) == 0){

    $query1 = "insert  into accreditation.schedule_date_oz (id_uz,year) select id_uz, '$year'  from accreditation.uz where uz_flag=1 ";
    $rez1 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));

    $query2 = "SELECT *
    from accreditation.schedule_date_oz sch_oz
    left outer join accreditation.uz u on sch_oz.id_uz=u.id_uz
    
    where sch_oz.year='$year'
	order by schedule_date, username 
    ";
    
    
    
    $rez2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
    $reports = array();   

    for ($data2 = []; $row2 = mysqli_fetch_assoc($rez2); $data2[] = $row2); 
    
    foreach ($data2 as $app) {
        $obj = array();
        $report = new ScheduleDate();
        $report->id_schedule = $app['id_schedule'];
        $report->username = $app['username'];
        $report->schedule_date = $app['schedule_date'];
    
        array_push($reports,$report);
    }

} else {

    for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

    
    
    foreach ($data as $app) {
        $obj = array();
        $report = new ScheduleDate();
        $report->id_schedule = $app['id_schedule'];
        $report->username = $app['username'];
        $report->schedule_date = $app['schedule_date'];
    
        array_push($reports,$report);
    }


    
}




echo json_encode($reports);
mysqli_close($con);