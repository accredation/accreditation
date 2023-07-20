<?php
include "connection.php";

$id_application = $_GET['id_application'];

$query = "SELECT s.id_subvision, s.name, rc.id_rating_criteria,  CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria
FROM applications a
left outer join subvision s on a.id_application=s.id_application
left outer join rating_criteria rc on s.id_subvision=rc.id_subvision
left outer join criteria c on rc.id_criteria=c.id_criteria
left outer join conditions con on c.conditions_id=con.conditions_id
where a.id_application = '$id_application'
order by s.id_subvision, c.id_criteria";


$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$marks = array();
$report_sub_marks = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class ReportSub{
    public $id_subvision, $name, $id_rating_criteria, $name_criteria;
}

foreach ($data as $app) {
    $obj = array();
    $mark = new ReportSub();
    $mark->id_subvision = $app['id_subvision'];
    $mark->name = $app['name'];
    $mark->id_rating_criteria = $app['id_rating_criteria'];
    $mark->name_criteria = $app['name_criteria'];
   
    array_push($report_sub_marks,$mark);
}


echo json_encode($report_sub_marks);