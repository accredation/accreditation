<?php
include 'connection.php';

$giveSvid = $_GET['giveSvid'];
$id_app = $_GET['id_app'];

mysqli_query($con,"update applications set giveSvid='$giveSvid' where id_application='$id_app'");
