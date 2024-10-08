<?php

include "connection.php";

$idCrit = $_POST['idCrit'];
$idDep = $_POST['idDep'];
$text = $_POST['text'];
$idAnswerCriteria = $_POST['idAnswerCriteria'];


mysqli_query($con, "update z_answer_criteria set field7 = '$text' where id_answer_criteria = '$idAnswerCriteria'");
mysqli_close($con);