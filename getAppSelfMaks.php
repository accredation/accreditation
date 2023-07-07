<?php
include "connection.php";

$id_application = $_GET['id_application'];

$query = "SELECT otmetka_all, otmetka_class_1, otmetka_class_2, otmetka_class_3
FROM report_application_mark
where id_application='$id_application'
";

$arr = array();
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

foreach ($data as $app) {
    $otmetka_all = $app['otmetka_all'];
    $otmetka_class_1 = $app['otmetka_class_1'];
    $otmetka_class_2 = $app['otmetka_class_2'];
    $otmetka_class_3 = $app['otmetka_class_3'];


}

array_push($arr, $otmetka_all);
array_push($arr, $otmetka_class_1);
array_push($arr, $otmetka_class_2);
array_push($arr, $otmetka_class_3);
echo json_encode($arr);
?>

