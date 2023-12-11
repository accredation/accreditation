<?php
include "connection.php";
$id_user = $_POST['id_user'];

$selectedCriteria = Array();
$criteriaQuery = "SELECT id_criteria FROM spr_doctor_expert_for_criteria WHERE id_user = '$id_user'";
$criteriaResult = mysqli_query($con, $criteriaQuery) or die(mysqli_error($con));
while ($criteriaRow = mysqli_fetch_assoc($criteriaResult)) {
    array_push($selectedCriteria, $criteriaRow['id_criteria'] );
}
echo json_encode($selectedCriteria);

?>