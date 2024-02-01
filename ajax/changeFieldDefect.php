<?php

include "connection.php";

$idCrit = $_GET['idCrit'];
$idDep = $_GET['idDep'];
$text = $_GET['text'];

mysqli_query($con, "update z_answer_criteria set defect = '$text' where id_criteria='$idCrit' and id_department='$idDep'");
mysqli_close($con);