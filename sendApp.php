<?php
include "connection.php";

$date = date('Y-m-d');
$id_applications = $_GET['id_application'];


$query = "SELECT sub.id_subvision, sub.name, CONCAT(c.name,' (', con.conditions,')') as name_criteria, m.mark_name, mr.*
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join criteria c on m.id_criteria=c.id_criteria
left outer join conditions con on c.conditions_id=con.conditions_id
WHERE sub.id_application= '$id_applications' and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > CURDATE() ) ))
and (mr.field4 =0 or mr.field4 is null )
LIMIT 1
";
//
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $name = $row['name'];
    $name_criteria = $row['name_criteria'];
    $mark_name = $row['mark_name'];
    echo "В подразделении " . $name . " в критерии " . $name_criteria . " не заполнен пункт " . $mark_name;
}
else {

    mysqli_query($con, "Update applications set `id_status` = 2, `date_send`='$date' where `id_application` = '$id_applications'");
    echo "";
}

?>