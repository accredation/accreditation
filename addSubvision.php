<?php
include "connection.php";

$id_application = $_POST['id_application'];
$name = $_POST['name'];

    $insertquery =
        "Insert into subvision(`name`,`id_application`) values ('$name','$id_application')";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

?>