<?php

include "connection.php";

$sel_pervtor = $_POST['sel_pervtor'];

mysqli_query($con, "update applications set sel_pervtor = $sel_pervtor");
