<?php

include "../../ajax/connection.php";


$query = "select * from accreditation.z_types_tables
";



$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

class ScheduleDate{
    public $id_types_tables, $name;
    
}

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

    
    
    foreach ($data as $app) {
        $obj = array();
        $report = new ScheduleDate();
        $report->id_types_tables = $app['id_types_tables'];
        $report->name = $app['name'];
    
        array_push($reports,$report);
    }

    



echo json_encode($reports);
mysqli_close($con);