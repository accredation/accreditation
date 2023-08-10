<?php
include "connection.php";

$id_question = $_GET['id_question'];

    mysqli_query($con, "delete from questions where id_question = '$id_question'");


?>