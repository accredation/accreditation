<?php
include "connection.php";

$id_application = $_POST['id_app'];
$value = $_POST['value'];

$query =
    "UPDATE applications SET sootvetstvie = '$value' WHERE id_application = '$id_application'";
$result = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

echo ("Данные сохранены");

?>