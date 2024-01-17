<?php
include "connection.php";

$id_app = $_GET['id_app'];

$query = "SELECT s.name, s.id_subvision, rc.id_criteria, CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria, IFNULL(m.str_num,'') as str_num,
IFNULL(m.mark_name,'') as mark_name, IFNULL(m.mark_class,'') as mark_class, 
case when IFNULL(mr.field4,'')=1 then 'Да' when IFNULL(mr.field4,'')=2 then 'Нет' when IFNULL(mr.field4,'')=3 then 'Не требуется' else '' end as field4,
IFNULL(mr.field5,'') as field5, IFNULL(mr.field6,'') as field6,
case when IFNULL(mr.field7,'')=1 then 'Да' when IFNULL(mr.field7,'')=2 then 'Нет' when IFNULL(mr.field7,'')=3 then 'Не требуется' else '' end as field7,
IFNULL(mr.field8,'') as field8

FROM subvision s
left outer join rating_criteria rc on rc.id_subvision=s.id_subvision
left outer join criteria c on rc.id_criteria=c.id_criteria
left outer join conditions con on c.conditions_id=con.conditions_id
left outer join mark m on rc.id_criteria=m.id_criteria 
left outer join mark_rating mr on m.id_mark=mr.id_mark and mr.id_subvision=s.id_subvision 
left outer join applications a on s.id_application=a.id_application
where  s.id_application = '$id_app' and mr.field4 = 2
and (m.date_close is null or (m.date_close is not null and ( m.date_close > IFNULL(a.date_send, CURDATE()))))
and ((a.id_status = 1) or (a.id_status > 1 and (m.date_open is null or (m.date_open is not null and (m.date_open <= IFNULL(a.date_send, CURDATE()) )))))

order by s.id_subvision, c.id_criteria, IFNULL(m.str_num, 100000), m.id_mark
";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$marks = array();
$report_sub_marks = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class ReportSub{
    public $name, $id_subvision, $id_criteria , $name_criteria, $str_num, $mark_name, $mark_class, $field4, $field5, $field6, $field7, $field8;
}

$marks = array();
$report_sub_marks = array();
foreach ($data as $app) {
    $obj = array();
    $mark = new ReportSub();
    $mark->name = $app['name'];
    $mark->id_subvision = $app['id_subvision'];
    $mark->id_criteria = $app['id_criteria'];
    $mark->name_criteria = $app['name_criteria'];
    $mark->str_num = $app['str_num'];
    
    $mark->mark_name = $app['mark_name'];
    $mark->mark_class = $app['mark_class'];
    $mark->field4 = $app['field4'];
    $mark->field5 = $app['field5'];
    $mark->field6 = $app['field6'];
    $mark->field7 = $app['field7'];
    $mark->field8 = $app['field8'];
    array_push($report_sub_marks,$mark);
}


echo json_encode($report_sub_marks);