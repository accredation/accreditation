<?php
include 'connection.php';

$giveSvid = $_GET['giveSvid'];
$id_app = $_GET['id_app'];
echo "giveSvid: " . $giveSvid . "<br>";
echo "id_app: " . $id_app . "<br>";
$query ="update applications set giveSvid='$giveSvid' where id_application='$id_app'";
if (mysqli_query($con, $query)) {
    echo "Record updated successfully";
} else {
    echo "Error updating record: " . mysqli_error($con);
}