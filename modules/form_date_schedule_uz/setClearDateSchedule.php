<?php

include "../../ajax/connection.php";
$id_schedule = $_POST['id_schedule'];


$query = "update accreditation.schedule_date_oz  set schedule_date = null where id_schedule = '$id_schedule'";

mysqli_query($con, $query);
mysqli_close($con);