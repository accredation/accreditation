<?php
include '../../ajax/connection.php';

$query = "SELECT id_application as appId, color_app as color FROM applications where id_status in (3,4)";
$result = mysqli_query($con, $query) or die(mysqli_error($con));

$colors = [];
while ($row = mysqli_fetch_assoc($result)) {

    $colors[] = $row;
}

header('Content-Type: application/json');
echo json_encode($colors);
?>
