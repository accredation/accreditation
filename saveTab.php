<?php
include "connection.php";

$id_sub = $_POST['id_sub'];
$arr_id_criterias = $_POST['arr_id_criterias'];
$count = $_POST['count'];


//echo $arr_id_criterias;


$insertquery = "delete from rating_criteria where id_subvision ='$id_sub'";

mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

foreach($arr_id_criterias as $k=>$v){
   // echo $v['id_criteria'].': '. $v['value'] ."<br/>";
    $id_criteria = $v['id_criteria'];
//    $value= $v['value'];
    $insertquery = "Insert into rating_criteria(id_subvision, id_criteria, `value`) values ('$id_sub','$id_criteria', 1)";

  mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
}
//$insertquery = "delete from rating_criteria where id_subvision ='$id_sub'";

//mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

//for ($i = 0; $i < $count; $i++){
////    $insertquery = "Insert into rating_criteria(id_subvision, id_criteria, `value`) values ('$id_sub','$arr_id_criterias[$i].id_criteria')";
//        echo $arr_id_criterias[$i] . "<br/>";
//  //  mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
//}
//$insertquery =
//    "";
//
//mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));


?>