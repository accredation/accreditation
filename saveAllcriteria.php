<?php
include "connection.php";
$id_user = $_POST['id_user'];
$id_criteria = $_POST['id_criteria'];


mysqli_query($con, "INSERT INTO spr_doctor_expert_for_criteria (id_user, id_criteria) VALUES ('$id_user', '$id_criteria')");

?>