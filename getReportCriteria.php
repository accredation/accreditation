<?php
include "connection.php";

$id_application = $_GET['id_application'];
$id_subvision = $_GET['id_sub'];
$id_criteria = $_GET['id_criteria'];

$query = "SELECT IFNULL(otmetka_all,0) as otmetka_all, 
IFNULL(otmetka_all_count_yes,0) as otmetka_all_count_yes,
IFNULL(otmetka_all_count_all,0) as otmetka_all_count_all,
IFNULL(otmetka_all_count_not_need,0) as otmetka_all_count_not_need,
IFNULL(otmetka_class_1,0) as otmetka_class_1, 
IFNULL(otmetka_class_1_count_yes,0) as otmetka_class_1_count_yes,
IFNULL(otmetka_class_1_count_all,0) as otmetka_class_1_count_all,
IFNULL(otmetka_class_1_count_not_need,0) as otmetka_class_1_count_not_need,
IFNULL(otmetka_class_2,0) as otmetka_class_2, 
IFNULL(otmetka_class_2_count_yes,0) as otmetka_class_2_count_yes,
IFNULL(otmetka_class_2_count_all,0) as otmetka_class_2_count_all,
IFNULL(otmetka_class_2_count_not_need,0) as otmetka_class_2_count_not_need,
IFNULL(otmetka_class_3,0) as otmetka_class_3,
IFNULL(otmetka_class_3_count_yes,0) as otmetka_class_3_count_yes,
IFNULL(otmetka_class_3_count_all,0) as otmetka_class_3_count_all,
IFNULL(otmetka_class_3_count_not_need,0) as otmetka_class_3_count_not_need,
IFNULL(otmetka_verif,0) as otmetka_verif,
IFNULL(otmetka_verif_count_yes,0) as otmetka_verif_count_yes,
IFNULL(otmetka_verif_count_all,0) as otmetka_verif_count_all,
IFNULL(otmetka_verif_count_not_need,0) as otmetka_verif_count_not_need,

IFNULL(otmetka_accred_all,0) as otmetka_accred_all, 
IFNULL(otmetka_accred_all_count_yes,0) as otmetka_accred_all_count_yes,
IFNULL(otmetka_accred_all_count_all,0) as otmetka_accred_all_count_all,
IFNULL(otmetka_accred_all_count_not_need,0) as otmetka_accred_all_count_not_need, 

IFNULL(otmetka_accred_class_1,0) as otmetka_accred_class_1, 
IFNULL(otmetka_accred_class_1_count_yes,0) as otmetka_accred_class_1_count_yes,
IFNULL(otmetka_accred_class_1_count_all,0) as otmetka_accred_class_1_count_all,
IFNULL(otmetka_accred_class_1_count_not_need,0) as otmetka_accred_class_1_count_not_need,

IFNULL(otmetka_accred_class_2,0) as otmetka_accred_class_2, 
IFNULL(otmetka_accred_class_2_count_yes,0) as otmetka_accred_class_2_count_yes,
IFNULL(otmetka_accred_class_2_count_all,0) as otmetka_accred_class_2_count_all,
IFNULL(otmetka_accred_class_2_count_not_need,0) as otmetka_accred_class_2_count_not_need,

IFNULL(otmetka_accred_class_3,0) as otmetka_accred_class_3,
IFNULL(otmetka_accred_class_3_count_yes,0) as otmetka_accred_class_3_count_yes,
IFNULL(otmetka_accred_class_3_count_all,0) as otmetka_accred_class_3_count_all,
IFNULL(otmetka_accred_class_3_count_not_need,0) as otmetka_accred_class_3_count_not_need

FROM report_criteria_mark
where id_application='$id_application' and id_subvision='$id_subvision' and id_criteria='$id_criteria'
";

$arr = array();
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);
class Mark{
    public $otmetka_all, $otmetka_all_count_yes, $otmetka_all_count_all, $otmetka_all_count_not_need, 
    $otmetka_class_1, $otmetka_class_1_count_yes, $otmetka_class_1_count_all, $otmetka_class_1_count_not_need, 
    $otmetka_class_2, $otmetka_class_2_count_yes, $otmetka_class_2_count_all, $otmetka_class_2_count_not_need,
    $otmetka_class_3, $otmetka_class_3_count_yes, $otmetka_class_3_count_all, $otmetka_class_3_count_not_need, 
    $otmetka_accred_all, $otmetka_accred_all_count_yes, $otmetka_accred_all_count_all, $otmetka_accred_all_count_not_need, 
    $otmetka_accred_class_1, $otmetka_accred_class_1_count_yes, $otmetka_accred_class_1_count_all, $otmetka_accred_class_1_count_not_need, 
    $otmetka_accred_class_2, $otmetka_accred_class_2_count_yes, $otmetka_accred_class_2_count_all, $otmetka_accred_class_2_count_not_need, 
    $otmetka_accred_class_3, $otmetka_accred_class_3_count_yes, $otmetka_accred_class_3_count_all, $otmetka_accred_class_3_count_not_need, 
    $otmetka_verif, $otmetka_verif_count_yes, $otmetka_verif_count_all, $otmetka_verif_count_not_need;
}
foreach ($data as $app) {
    $mark = new Mark();
    $mark->otmetka_all = $app['otmetka_all'];
    $mark->otmetka_all_count_yes = $app['otmetka_all_count_yes'];
    $mark->otmetka_all_count_all = $app['otmetka_all_count_all'];
    $mark->otmetka_all_count_not_need = $app['otmetka_all_count_not_need'];
    $mark->otmetka_class_1 = $app['otmetka_class_1'];
    $mark->otmetka_class_1_count_yes = $app['otmetka_class_1_count_yes'];
    $mark->otmetka_class_1_count_all = $app['otmetka_class_1_count_all'];
    $mark->otmetka_class_1_count_not_need = $app['otmetka_class_1_count_not_need'];
    $mark->otmetka_class_2 = $app['otmetka_class_2'];
    $mark->otmetka_class_2_count_yes = $app['otmetka_class_2_count_yes'];
    $mark->otmetka_class_2_count_all = $app['otmetka_class_2_count_all'];
    $mark->otmetka_class_2_count_not_need = $app['otmetka_class_2_count_not_need'];
    $mark->otmetka_class_3 = $app['otmetka_class_3'];
    $mark->otmetka_class_3_count_yes = $app['otmetka_class_3_count_yes'];
    $mark->otmetka_class_3_count_all = $app['otmetka_class_3_count_all'];
    $mark->otmetka_class_3_count_not_need = $app['otmetka_class_3_count_not_need'];
    $mark->otmetka_accred_all = $app['otmetka_accred_all'];
    $mark->otmetka_accred_all_count_yes = $app['otmetka_accred_all_count_yes'];
    $mark->otmetka_accred_all_count_all = $app['otmetka_accred_all_count_all'];
    $mark->otmetka_accred_all_count_not_need = $app['otmetka_accred_all_count_not_need'];
    $mark->otmetka_accred_class_1 = $app['otmetka_accred_class_1'];
    $mark->otmetka_accred_class_1_count_yes = $app['otmetka_accred_class_1_count_yes'];
    $mark->otmetka_accred_class_1_count_all = $app['otmetka_accred_class_1_count_all'];
    $mark->otmetka_accred_class_1_count_not_need = $app['otmetka_accred_class_1_count_not_need'];
    $mark->otmetka_accred_class_2 = $app['otmetka_accred_class_2'];
    $mark->otmetka_accred_class_2_count_yes = $app['otmetka_accred_class_2_count_yes'];
    $mark->otmetka_accred_class_2_count_all = $app['otmetka_accred_class_2_count_all'];
    $mark->otmetka_accred_class_2_count_not_need = $app['otmetka_accred_class_2_count_not_need'];
    $mark->otmetka_accred_class_3 = $app['otmetka_accred_class_3'];
    $mark->otmetka_accred_class_3_count_yes = $app['otmetka_accred_class_3_count_yes'];
    $mark->otmetka_accred_class_3_count_all = $app['otmetka_accred_class_3_count_all'];
    $mark->otmetka_accred_class_3_count_not_need = $app['otmetka_accred_class_3_count_not_need'];
    $mark->otmetka_verif = $app['otmetka_verif'];
    $mark->otmetka_verif_count_yes = $app['otmetka_verif_count_yes'];
    $mark->otmetka_verif_count_all = $app['otmetka_verif_count_all'];
    $mark->otmetka_verif_count_not_need = $app['otmetka_verif_count_not_need'];
}
if(isset($mark->otmetka_all))
{
    echo json_encode($mark);
}
else{
    echo "0";
}

?>