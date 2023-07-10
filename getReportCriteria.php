<?php
include "connection.php";

$id_application = $_GET['id_application'];
$id_subvision = $_GET['id_sub'];
$id_criteria = $_GET['id_criteria'];

$query = "SELECT IFNULL(otmetka_all,0) as otmetka_all, IFNULL(otmetka_class_1,0) as otmetka_class_1, 
       IFNULL(otmetka_class_2,0) as otmetka_class_2, IFNULL(otmetka_class_3,0) as otmetka_class_3,
       IFNULL(otmetka_verif,0) as otmetka_verif,
       IFNULL(otmetka_accred_all,0) as otmetka_accred_all, IFNULL(otmetka_accred_class_1,0) as otmetka_accred_class_1, 
       IFNULL(otmetka_accred_class_2,0) as otmetka_accred_class_2, IFNULL(otmetka_accred_class_3,0) as otmetka_accred_class_3
FROM report_criteria_mark
where id_application='$id_application' and id_subvision='$id_subvision' and id_criteria='$id_criteria'
";

$arr = array();
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

foreach ($data as $app) {
    $otmetka_all = $app['otmetka_all'];
    $otmetka_class_1 = $app['otmetka_class_1'];
    $otmetka_class_2 = $app['otmetka_class_2'];
    $otmetka_class_3 = $app['otmetka_class_3'];

    $otmetka_accred_all = $app['otmetka_accred_all'];
    $otmetka_verif = $app['otmetka_verif'];
    $otmetka_accred_class_1 = $app['otmetka_accred_class_1'];
    $otmetka_accred_class_2 = $app['otmetka_accred_class_2'];
    $otmetka_accred_class_3 = $app['otmetka_accred_class_3'];
}

array_push($arr, $otmetka_all);
array_push($arr, $otmetka_class_1);
array_push($arr, $otmetka_class_2);
array_push($arr, $otmetka_class_3);

array_push($arr, $otmetka_accred_all);
array_push($arr, $otmetka_verif);
array_push($arr, $otmetka_accred_class_1);
array_push($arr, $otmetka_accred_class_2);
array_push($arr, $otmetka_accred_class_3);
echo json_encode($arr);


?>