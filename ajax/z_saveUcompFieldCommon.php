<?php

include "connection.php";

$idApp = $_GET['idApp'];
$fieldNum = $_GET['fieldNum'];
$text = $_GET['text'];

$query = "UPDATE applications SET ";
switch ($fieldNum) {
    case 1:
        $query .= "field1 = '$text'";
        break;
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
}

$query .= " WHERE id_application = '$idApp'";
mysqli_query($con, $query);
mysqli_close($con);
?>