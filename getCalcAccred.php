<?php
include "connection.php";

$id_application = $_GET['id_application'];

$query = "call cursor_for_application_acred('$id_application')";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

?>