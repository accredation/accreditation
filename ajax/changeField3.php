<?php

include "connection.php";

$idCrit = $_GET['idCrit'];
$idDep = $_GET['idDep'];
$val = $_GET['val'];

mysqli_query($con, "update z_answer_criteria set field3 = '$val' where id_criteria='$idCrit' and id_department='$idDep'");
mysqli_close($con);