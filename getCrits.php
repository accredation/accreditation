<?php
include "connection.php";

$id_sub = $_GET['id_sub'];

$query = "SELECT criteria.id_criteria, criteria.name, criteria.type_criteria, conditions.conditions, rating_criteria.value
FROM criteria
left outer join conditions on criteria.conditions_id=conditions.conditions_id 
left outer join rating_criteria on criteria.id_criteria=rating_criteria.id_criteria and rating_criteria.id_subvision='$id_sub' 
where rating_criteria.id_subvision is null or rating_criteria.id_subvision='$id_sub'
";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$crits = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

foreach ($data as $app) {
    $obj = array();
    array_push($obj,$app['id_criteria']);
    array_push($obj,$app['name']);
    array_push($obj,$app['type_criteria']);
    array_push($obj,$app['conditions']);
    array_push($obj,$app['value']);
    array_push($crits,$obj);
}


echo json_encode($crits);
?>