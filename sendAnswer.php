<?php
include "connection.php";

$id_question = $_GET['id_question'];
$answer = $_GET['answer'];

    mysqli_query($con, "update questions set answer = '$answer' where id_question = '$id_question'");



?>