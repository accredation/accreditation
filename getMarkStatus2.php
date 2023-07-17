<?php
include "connection.php";

$id_sub = $_GET['id_sub'];
$id_criteria = $_GET['id_criteria'];

// $query = "SELECT m.id_mark, m.str_num, mr.id_mark_rating, m.mark_name, m.mark_class, mr.field4,mr.field5,mr.field6,mr.field7,mr.field8
// FROM mark_rating mr 
// left outer join `mark` m  on mr.id_mark=m.id_mark
// left outer join rating_criteria rc on m.id_criteria=rc.id_criteria and rc.id_subvision='$id_sub'
// left outer join subvision s on rc.id_subvision=s.id_subvision    
// left outer join applications a on s.id_application = a.id_application
// where rc.id_subvision = '$id_sub' and rc.id_criteria='$id_criteria'  and mr.id_subvision='$id_sub'
// and (m.date_close is null or (m.date_close is not null and ( m.date_close > a.date_send)))
// order by IFNULL(m.str_num, 100000), m.id_mark
// ";

$query = "SELECT m.id_mark, m.str_num, mr.id_mark_rating, m.mark_name, m.mark_class, mr.field4,mr.field5,mr.field6,mr.field7,mr.field8
FROM `mark` m
left outer join mark_rating mr on m.id_mark=mr.id_mark and mr.id_subvision='$id_sub'
left outer join rating_criteria rc on m.id_criteria=rc.id_criteria and rc.id_subvision='$id_sub'
left outer join subvision s on rc.id_subvision=s.id_subvision    
left outer join applications a on s.id_application = a.id_application
where rc.id_subvision = '$id_sub' and rc.id_criteria='$id_criteria' -- and m.date_close is null
and (m.date_close is null or (m.date_close is not null and ( m.date_close > a.date_send)))
and (m.date_open is null or (m.date_open is not null and (m.date_open <= a.date_send )))
order by  m.str_num
";
//order by IFNULL(m.str_num, 100000), m.id_mark

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$marks = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Mark{
    public $id_mark , $str_num, $id_mark_rating, $mark_name, $mark_class, $field4, $field5, $field6, $field7, $field8;
}

foreach ($data as $app) {
    $obj = array();
    $mark = new Mark();
    $mark->id_mark = $app['id_mark'];
    $mark->str_num = $app['str_num'];
    
    $mark->id_mark_rating = $app['id_mark_rating'];
    $mark->mark_name = $app['mark_name'];
    $mark->mark_class = $app['mark_class'];
    $mark->field4 = $app['field4'];
    $mark->field5 = $app['field5'];
    $mark->field6 = $app['field6'];
    $mark->field7 = $app['field7'];
    $mark->field8 = $app['field8'];
//    array_push($obj,$app['id_mark']);
//    array_push($obj,$app['mark_name']);
//    array_push($obj,$app['mark_class']);
//    array_push($obj,$app['field4']);
//    array_push($obj,$app['field5']);
//    array_push($obj,$app['field6']);
//    array_push($obj,$app['field7']);
//    array_push($obj,$app['field8']);
//    array_push($marks,$obj);
    array_push($marks,$mark);
}


echo json_encode($marks);
?>