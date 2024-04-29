<?php

include "../../../ajax/connection.php";

$id_list_tables_criteria = $_GET['id_list_tables_criteria'];


$query = "select *
from accreditation.z_criteria
where id_list_tables_criteria = $id_list_tables_criteria
";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$reports = array();

//  echo $con;

//echo json_encode($query);

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Report{
    public $id_criteria, $pp, $name;
}

foreach ($data as $app) {
    $obj = array();
    $report = new Report();
    $report->id_criteria = $app['id_criteria'];
    $report->pp = $app['pp'];
    $report->name = $app['name'];
    array_push($reports,$report);
}
//echo $reports;

echo json_encode($reports);
mysqli_close($con);