<?php

include "connection.php";

if (isset($_POST['idCrit'], $_POST['idDep'], $_POST['text'], $_POST['idAnswerCriteria'])) {
    $idCrit = $_POST['idCrit'];
    $idDep = $_POST['idDep'];
    $text = $_POST['text'];
    $idAnswerCriteria = $_POST['idAnswerCriteria'];


$result = mysqli_query($con, "UPDATE z_answer_criteria SET field7 = '$text' WHERE id_answer_criteria = '$idAnswerCriteria'");

echo 1;
} else {
    echo 0;
}
mysqli_close($con);
?>