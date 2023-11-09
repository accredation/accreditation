<?php
include "connection.php";

$id_sub = $_POST['id_sub'];
$arr_id_criterias = $_POST['arr_id_criterias'];


//echo $arr_id_criterias;


$query = "select * from rating_criteria where id_subvision ='$id_sub'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

class Rat{
    public $id_criteria, $opened;
}
$ar = array();
foreach ($data as $app) {
 $rat = new Rat();
 $rat->opened = $app['opened'];
 $rat->id_criteria = $app['id_criteria'];
 array_push($ar, $rat);
}




$insertquery = "delete from rating_criteria where id_subvision ='$id_sub'";

mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

foreach($arr_id_criterias as $k=>$v){
   // echo $v['id_criteria'].': '. $v['value'] ."<br/>";
    $id_criteria = $v['id_criteria'];
    $op = 0;


    for ($i = 0; $i< count($ar); $i++){
        if($ar[$i]->id_criteria == $id_criteria){
            $op = $ar[$i]->opened;
            break;
        }

    }

    $insertquery = "Insert into rating_criteria(id_subvision, id_criteria, `value`, `opened`) values ('$id_sub','$id_criteria', 1, '$op' )";

  mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}



?>