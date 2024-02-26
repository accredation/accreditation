<?php

include "connection.php";

$id_application = $_POST['id_app'];

$query = "update applications set id_status = 1 where id_application = '$id_application'";

mysqli_query($con, $query);

?>