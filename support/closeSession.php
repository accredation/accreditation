<?php

include "../ajax/connection.php";

$id_user = $_GET['id_user'];


mysqli_query($con, "update users set online = '0', last_time_session = NULL where id_user = '$id_user'");



?>