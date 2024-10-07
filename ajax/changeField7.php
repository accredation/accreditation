<?php

include "connection.php";

$idCrit = $_GET['idCrit'];
$idDep = $_GET['idDep'];
$text = $_GET['text'];
$idAnswerCriteria = $_GET['idAnswerCriteria'];


mysqli_query($con, "update z_answer_criteria set field7 = '$text' where id_answer_criteria = '$idAnswerCriteria'");
mysqli_close($con);