<?php
include "connection.php";

class Notify{
    public $id_notifications, $text_notifications;
}
$id_user = $_GET['id_user'];

$query = "SELECT * FROM notifications WHERE readornot=1 and id_user = '$id_user'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

$cells = array();



for ($names = []; $row = mysqli_fetch_assoc($rez); $names[] = $row);
foreach ($names as $name) {
    $not = new Notify();
    $not->id_notifications = $name['id_notifications'];
    $not->text_notifications = $name['text_notifications'];
    array_push($cells,$not);
}




echo json_encode($cells);
?>