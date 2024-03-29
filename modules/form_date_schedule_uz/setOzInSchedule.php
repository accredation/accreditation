<?php

include "../../ajax/connection.php";
$id_uz = $_POST['id_uz'];
$year = $_POST['year'];
$schedule_date =  $_POST['schedule_date'];


$query = "insert into accreditation.schedule_date_oz (id_uz, year, schedule_date) values ('$id_uz','$year', '$schedule_date')";

mysqli_query($con, $query);
mysqli_close($con);
