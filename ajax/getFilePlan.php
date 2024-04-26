<?php

include "connection.php";

$id_application = $_GET['id_application'];

$rez = mysqli_query($con, "SELECT plandenostatkov FROM applications WHERE id_application = '$id_application'");

$row = mysqli_fetch_assoc($rez);
$plandenostatkov = $row['plandenostatkov'];

echo $plandenostatkov;
