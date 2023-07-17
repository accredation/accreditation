<?php
include "connection.php";
$id_sub = $_POST['id_sub'];
$marks = $_POST['marks'];
$id_criteria = $_POST['id_criteria'];
$id_application = $_POST['id_application'];
$date = date('Y-m-d');

echo $id_criteria;

$insertquery = "delete from mark_rating where id_mark in (select id_mark from mark where id_criteria = '$id_criteria' and (date_close is not null and ( date_close < '$date')) ) and id_subvision='$id_sub'";
mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

foreach($marks as $k=>$v){

  //  echo json_encode($v);

    $id_mark = $v['id_mark'];
    $field4 = (integer)$v['field4'];

    $field5 = $v['field5'];
    $field6 = $v['field6'];
    $id_mark_rating = $v['id_mark_rating'];

 //   echo $id_mark_rating;



       if($id_mark_rating != '') {
            $insertquery = "update mark_rating
            set id_mark = '$id_mark', field4='$field4', field5='$field5', field6='$field6', id_subvision='$id_sub'
            where id_mark_rating='$id_mark_rating'";
        } else {
            $insertquery = "Insert into mark_rating(id_mark, field4, field5, field6, id_subvision)
                                values ('$id_mark','$field4', '$field5', '$field6', '$id_sub')";
        }


        mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));



}


$query = "call callc_criteria('$id_application','$id_sub','$id_criteria')";
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


?>