<?php

include "connection.php";

$sel_pervtor = $_POST['sel_pervtor'];
$id_app = $_POST['id_app'];

mysqli_query($con, "update applications set sel_pervtor = '$sel_pervtor' where id_application = '$id_app'");
