<?php

include "connection.php";

$idCrit = $_GET['idCrit'];
$idDep = $_GET['idDep'];
$text = $_GET['text'];
$id_answer_criteria = $_GET['idAnswerCriteria'];


mysqli_query($con, "update z_answer_criteria set field5 = '$text' where id_answer_criteria = '$id_answer_criteria'");
mysqli_close($con);