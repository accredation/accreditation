<?php
include "connection.php";
$date = date('Y-m-d H:i:s');
$id_question = $_GET['id_question'];
$question = $_GET['question'];
$answer = $_GET['answer'];

    mysqli_query($con, "update questions set answer = '$answer', question='$question', important=1  where id_question = '$id_question'");


?>