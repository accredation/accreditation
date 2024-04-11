<?php

include 'connection.php';

$id_app = $_POST['id_app'];

$rez = mysqli_query($con, "SELECT giveSvid FROM applications WHERE id_application = '$id_app'");

$row = mysqli_fetch_assoc($rez);
$giveSvid = $row['giveSvid'];

echo $giveSvid;
