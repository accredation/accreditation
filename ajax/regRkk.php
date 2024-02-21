<?php
include "connection.php";

$id_application = $_GET['id_application'];


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
    if ($id_rkk !== "") {
        mysqli_query($con, "update applications set id_rkk = '$id_rkk' where id_application = '$id_application'");
        echo "000";
    }
    else{
        echo "111";
    }
}
else {

}


?>