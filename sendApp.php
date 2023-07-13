<?php
include "connection.php";

$date = date('Y-m-d');
$id_applications = $_GET['id_application'];


$query = "SELECT m.id_mark, m.str_num, mr.id_mark_rating, m.mark_name, m.mark_class, mr.field4,mr.field5,mr.field6,mr.field7,mr.field8
FROM mark_rating mr 
left outer join `mark` m  on mr.id_mark=m.id_mark
left outer join rating_criteria rc on m.id_criteria=rc.id_criteria and rc.id_subvision='$id_sub'
left outer join subvision s on rc.id_subvision=s.id_subvision    
left outer join applications a on s.id_application = a.id_application
where rc.id_subvision = '$id_sub' and rc.id_criteria='$id_criteria'  and mr.id_subvision='$id_sub'
and (m.date_close is null or (m.date_close is not null and ( m.date_close < a.date_send)))
";
//
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));





mysqli_query($con, "Update applications set `id_status` = 2, `date_send`='$date' where `id_application` = '$id_applications'");

?>