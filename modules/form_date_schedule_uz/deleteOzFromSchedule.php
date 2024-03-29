<?php

include "../../ajax/connection.php";
$id_schedule = $_GET['id_schedule'];


$query = "delete from accreditation.schedule_date_oz where id_schedule = '$id_schedule'";

mysqli_query($con, $query);
mysqli_close($con);