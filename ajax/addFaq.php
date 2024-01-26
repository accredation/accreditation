<?php
include "connection.php";
$question = $_GET['question'];
$answer = $_GET['answer'];

    mysqli_query($con, "Insert into questions(`answer`, `question`, `important`, `id_user`) values('$answer','$question', 1, 3) ");


?>