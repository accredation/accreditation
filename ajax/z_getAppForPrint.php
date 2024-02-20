<?php
include "connection.php";

$id_app = $_GET['id_app'];

$query = "SELECT s.name, s.id_subvision, dep.id_department, dep.name as name_criteria, IFNULL(c.pp,'') as pp,
IFNULL(c.name,'') as mark_name,
case when IFNULL(ac.field3,'')=1 then 'Да' when IFNULL(ac.field3,'')=2 then 'Нет' when IFNULL(ac.field3,'')=3 then 'Не требуется' else '' end as field3,
IFNULL(ac.field4,'') as field4, IFNULL(ac.field5,'') as field5,
case when IFNULL(ac.field6,'')=1 then 'Да' when IFNULL(ac.field6,'')=2 then 'Нет' when IFNULL(ac.field6,'')=3 then 'Не требуется' else '' end as field6,
IFNULL(ac.field7,'') as field7, IFNULL(ac.defect,'') as field8

FROM subvision s
left outer join z_department dep on s.id_subvision=dep.id_subvision
left outer join z_list_tables_criteria ltc on ltc.id_list_tables_criteria=dep.id_list_tables_criteria
left outer join z_criteria c on c.id_list_tables_criteria =ltc.id_list_tables_criteria 
left outer join z_answer_criteria ac on c.id_criteria=ac.id_criteria and ac.id_department = dep.id_department
left outer join applications a on s.id_application=a.id_application
where  s.id_application = '$id_app' 
 

order by s.id_subvision, dep.id_department, IFNULL(c.pp, 100000), c.id_criteria

";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$marks = array();
$report_sub_marks = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class ReportSub{
    public $name, $id_subvision, $id_criteria , $name_criteria, $str_num, $mark_name, $mark_class, $field4, $field5, $field6, $field7, $field8, $field9;
}

foreach ($data as $app) {
    $obj = array();
    $mark = new ReportSub();
    $mark->name = $app['name'];
    $mark->id_subvision = $app['id_subvision'];
    $mark->id_criteria = $app['id_department'];
    $mark->name_criteria = $app['name_criteria'];
    $mark->str_num = $app['pp'];
    
    $mark->mark_name = $app['mark_name'];
    $mark->field4 = $app['field3'];
    $mark->field5 = $app['field4'];
    $mark->field6 = $app['field5'];
    $mark->field7 = $app['field6'];
    $mark->field8 = $app['field7'];
    $mark->field9 = $app['field8'];
    array_push($report_sub_marks,$mark);
}


echo json_encode($report_sub_marks);