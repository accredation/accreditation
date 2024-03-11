<?php

include 'connection.php';

$id_app = $_POST['id_application'];
$pervtor= $_POST['pervtor'];

$query = "update applications set id_status = '9' , pervtor '$pervtor' where id_application = '$id_app'";

mysqli_query($con, $query);

