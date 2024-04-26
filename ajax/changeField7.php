<?php

include "connection.php";

$idCrit = $_POST['idCrit'];
$idDep = $_POST['idDep'];
$text = $_POST['text'];

mysqli_query($con, "update z_answer_criteria set field7 = '$text' where id_criteria='$idCrit' and id_department='$idDep'");
mysqli_close($con);