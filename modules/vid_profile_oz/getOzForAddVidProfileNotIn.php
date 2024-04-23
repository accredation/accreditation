<?php

include "../../ajax/connection.php";


$query = "select * from accreditation.uz where uz_flag=1 and  uz.id_uz not in (select id_uz from accreditation.uz_vid_profile ) order by username 
";



$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

class ScheduleDate{
    public $id_uz, $username;
    
}

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

    
    
    foreach ($data as $app) {
        $obj = array();
        $report = new ScheduleDate();
        $report->id_uz = $app['id_uz'];
        $report->username = $app['username'];
    
        array_push($reports,$report);
    }

    



echo json_encode($reports);
mysqli_close($con);