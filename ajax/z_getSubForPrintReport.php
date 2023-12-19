<?php
include "connection.php";

$id_application = $_GET['id_application'];

$query = "SELECT DISTINCT s.id_subvision, s.name ,  rc.id_department , rc.name
FROM applications a
left outer join subvision s on a.id_application=s.id_application
left outer join z_department rc on s.id_subvision=rc.id_subvision
left outer join z_list_tables_criteria c on rc.id_list_tables_criteria=c.id_list_tables_criteria
where a.id_application = '$id_application'";


$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$marks = array();
$report_sub_marks = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class ReportSub{
    public $id_subvision, $name, $id_department, $name_otdel;
}

foreach ($data as $app) {
    $obj = array();
    $mark = new ReportSub();
    $mark->id_subvision = $app['id_subvision'];
    $mark->name = $app['name'];
    $mark->id_department = $app['id_department'];
    $mark->name_otdel = $app['name'];
   
    array_push($report_sub_marks,$mark);
}


echo json_encode($report_sub_marks);