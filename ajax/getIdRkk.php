<?php
include "connection.php";
$id_application = $_GET['id_application'];

$rez = mysqli_query($con, "select * from applications where id_application = '$id_application'");
if (mysqli_num_rows($rez) == 1) {
    $row = mysqli_fetch_assoc($rez);
    $responce['id_rkk'] = $row['id_rkk'];
    echo json_encode($responce);
}
else  {
    echo "no data";
}

?>