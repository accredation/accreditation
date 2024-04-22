<?php

include "../../ajax/connection.php";


$query = "select * from accreditation.spr_profile order by profile_name
";



$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

class ScheduleDate{
    public $id_profile, $profile_name;
    
}

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

    
    
    foreach ($data as $app) {
        $obj = array();
        $report = new ScheduleDate();
        $report->id_profile = $app['id_profile'];
        $report->profile_name = $app['profile_name'];
    
        array_push($reports,$report);
    }

    



echo json_encode($reports);
mysqli_close($con);