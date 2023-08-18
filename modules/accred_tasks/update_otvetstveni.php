<?php

include "../../connection.php";

$id_cr = $_POST['id_cr'];
$id_userotv = $_POST['id_userotv'];


mysqli_query($con, "update rating_criteria cr set cr.id_otvetstvennogo = '$id_userotv' where cr.id_rating_criteria = '$id_cr'");




?>