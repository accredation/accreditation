<?php
include "connection.php";

$id_application = $_GET['id_application'];
$id_user = $_COOKIE['id_user'];

$queryUs = "SELECT username from users WHERE id_user = '$id_user'";
  $rezUs =  mysqli_query($con, $queryUs);

  if(mysqli_num_rows($rezUs) == 1){
      $rowUs = mysqli_fetch_assoc($rezUs);
      $username = $rowUs['username'];
  }

// пометка 2 найти предыдущее заявление если оно есть
//SELECT * FROM (
//    SELECT * FROM accreditation.applications
//    WHERE id_user = 185
//    ORDER BY date_create_app DESC
//    LIMIT 2
//) AS subquery
//ORDER BY date_create_app
//LIMIT 1;
$rez = mysqli_query($con, "select * from rkk where id_application = '$id_application'");
if (mysqli_num_rows($rez) == 1) {

}
else {
    mysqli_query($con, "insert into rkk (id_application) 
                            values ('$id_application')");
}


$rez = mysqli_query($con, "select * from rkk where id_application = '$id_application'");
if (mysqli_num_rows($rez) == 1) {
    $row = mysqli_fetch_array($rez);
    $id_rkk = $row['id_rkk'];
    if ($id_rkk !== "0") {
        mysqli_query($con, "update applications set id_rkk = '$id_rkk', zaregal = '$username' where id_application = '$id_application'");
        echo "000";
    }
    else{
        echo "111";
    }
}
else {

}


?>