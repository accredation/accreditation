<?php

include "connection.php";

$idSub = $_GET['idSub'];
$idDep = $_GET['idDep'];
$fieldNum = $_GET['fieldNum'];
$text = $_GET['text'];

$query = "UPDATE z_department SET ";
switch ($fieldNum) {
    case 2:
        $query .= "field2 = '$text'";
        break;
    case 3:
        $query .= "field3 = '$text'";
        break;
    case 4:
        $query .= "field4 = '$text'";
        break;
    case 5:
        $query .= "field5 = '$text'";
        break;
    case 6:
        $query .= "field6 = '$text'";
        break;
    case 7:
        $query .= "field7 = '$text'";
        break;
    case 8:
        $query .= "field8 = '$text'";
        break;
    case 9:
        $query .= "field9 = '$text'";
        break;
}

$query .= " WHERE id_subvision = '$idSub' AND id_department = '$idDep'";
mysqli_query($con, $query);
mysqli_close($con);
?>