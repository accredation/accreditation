<?php
include "connection.php";

$id_sub = $_GET['id_sub'];

$query = "SELECT rc.id_criteria, CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria,
 IFNULL(m.mark_name,'') as mark_name, IFNULL(m.mark_class,'') as mark_class, 
 case when IFNULL(mr.field4,'')=1 then 'Да' when IFNULL(mr.field4,'')=2 then 'Нет' when IFNULL(mr.field4,'')=3 then 'Не требуется' else '' end as field4,
 IFNULL(mr.field5,'') as field5, IFNULL(mr.field6,'') as field6,
 case when IFNULL(mr.field7,'')=1 then 'Да' when IFNULL(mr.field7,'')=2 then 'Нет' when IFNULL(mr.field7,'')=3 then 'Не требуется' else '' end as field7,
 IFNULL(mr.field8,'') as field8

FROM rating_criteria rc
left outer join criteria c on rc.id_criteria=c.id_criteria
left outer join conditions con on c.conditions_id=con.conditions_id
left outer join mark m on rc.id_criteria=m.id_criteria 
left outer join mark_rating mr on m.id_mark=mr.id_mark and mr.id_subvision='$id_sub'
left outer join applications a on s.id_application=a.id_application
where rc.id_subvision = '$id_sub'
--------
and (m.date_close is null or (m.date_close is not null and ( m.date_close > a.date_send)))
and (m.date_open is null or (m.date_open is not null and (m.date_open < a.date_send )))
order by s.id_subvision, c.id_criteria, IFNULL(m.str_num, 100000), m.id_mark";



$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$marks = array();
$report_sub_marks = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class ReportSub{
    public $id_criteria , $name_criteria, $mark_name, $mark_class, $field4, $field5, $field6, $field7, $field8;
}

foreach ($data as $app) {
    $obj = array();
    $mark = new ReportSub();
    $mark->id_criteria = $app['id_criteria'];
    $mark->name_criteria = $app['name_criteria'];
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