<?php

include "../../connection.php";

$id_application = $_POST['id_application'];
$date_accept = $_POST['date_accept'];
$date_complete = $_POST['date_complete'];

$date_council = $_POST['date_council'];
if(empty($date_accept)){
    $date_accept = `null`;
    $query_srt = "Update applications set date_accept = null";
} else {
    $query_srt = "Update applications set date_accept = '$date_accept'";
}


echo "\"$date_accept\"";

if(empty($date_complete)){
    $date_complete = `null`;

    $query_srt .=  ", date_complete = null";
} else {
    $query_srt .=  ", date_complete = '$date_complete'";
}


if(empty($date_council)){
    $date_council = null;
    $query_srt .=  ", date_council = null";
} else {
    $query_srt .=  ", date_council = '$date_council'";
}

$query_srt .= " WHERE id_application = '$id_application'";
//$query = "Update applications set date_accept = '$date_accept', date_complete = '$date_complete', date_council = '$date_council' WHERE id_application = '$id_application'"
//$query = $query_srt;

echo $query_srt;

mysqli_query($con, $query_srt) or die("Ошибка " . mysqli_error($con));

echo "OK";
?>