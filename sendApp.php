<?php
include "connection.php";

$date = date('Y-m-d');
$id_applications = $_GET['id_application'];


$query = "SELECT sub.id_subvision, sub.name, CONCAT(c.name, IFNUll(CONCAT(' (', con.conditions,')'),'') ) as name_criteria, m.mark_name, m.str_num, mr.*
FROM `subvision` sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
left outer join mark m on rc.id_criteria=m.id_criteria
left outer join mark_rating mr on sub.id_subvision=mr.id_subvision and m.id_mark=mr.id_mark
left outer join criteria c on m.id_criteria=c.id_criteria
left outer join conditions con on c.conditions_id=con.conditions_id
WHERE sub.id_application= '$id_applications' and m.id_mark is not null and (m.date_close is null or (m.date_close is not null and ( m.date_close > CURDATE() ) ))
and (mr.field4 =0 or mr.field4 is null )
order by sub.id_subvision, c.id_criteria, m.str_num
";
//
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

$str_name = '';
$str_criteria = '';
$name_1 = '';
$name_criteria_1 ='';
$str_num_1 = '';
foreach ($data as $app) {
    $name = $app['name'];
    $name_criteria = $app['name_criteria'];
    $str_num = $app['str_num'];

    if($name_1 !== $name){
        $str_name =  "\nВ подразделении " . $name;
    }

    if(($name_criteria !== $name_criteria_1) || ($name_1 !== $name)){
        $str_criteria = " в таблице " . $name_criteria . " не заполнен критерий №";
    }

    echo $str_name . $str_criteria . $str_num . "," ;

    $name_1 = $name;
    $name_criteria_1 = $name_criteria;
    $str_num_1 =$str_num;
    $str_name="";
    $str_criteria="";
}
if(mysqli_num_rows($rez) == 0){
    mysqli_query($con, "Update applications set `id_status` = 2, `date_send`='$date' where `id_application` = '$id_applications'");
    echo "";
}

?>