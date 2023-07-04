<?php
$id_sub = $_POST['id_sub'];
$marks = $_POST['marks'];
/*
echo $id_sub;

*/



echo json_decode($marks);

//for($i = 0; $i < count($marks); $i++){
//    $id_mark = $marks[$i]['id_mark'];
//    $field4 = $marks[$i]['field4'];
//    $field5 = $marks[$i]['field5'];
//    $field6 = $marks[$i]['field6'];
//    $id_mark_rating = $marks[$i]['id_mark_rating'];
//
//    echo $id_mark;
//    /*
//        if($id_mark_rating != 0) {
//            $insertquery = "UPdate into mark_rating
//            set id_mark = '$id_mark', field4='$field4', field5='$field5', field6='$field6', id_sub='$id_sub'
//            where id_mark_rating='$id_mark_rating'";
//        } else {
//            $insertquery = "Insert into mark_rating(id_mark, field4, field5, field6, id_sub)
//                                values ('$id_mark','$field4', '$field5', '$field6', '$id_sub')";
//        }
//
//        mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
//    */
//}

?>