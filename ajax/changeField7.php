<?php

include "connection.php";

$idCrit = $_POST['idCrit'];
$idDep = $_POST['idDep'];
$text = $_POST['text'];
$id_answer_criteria = $_POST['idAnswerCriteria'];


mysqli_query($con, "update z_answer_criteria set field7 = '$text' where id_answer_criteria = '$id_answer_criteria'");
mysqli_close($con);