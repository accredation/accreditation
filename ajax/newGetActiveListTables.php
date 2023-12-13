<?php
include "connection.php";

class ActiveCrit{
    public $id_list_tables, $coun, $lev;

    function __construct( $id_list_tables, $coun, $lev) {
        $this->id_list_tables = $id_list_tables;
        $this->coun = $coun;
        $this->lev = $lev;
    }
}

$id_sub = $_GET['id_sub'];

$query = " select z_selected_tables.id_list_tables_criteria, `count`, `level` from z_selected_tables,z_list_tables_criteria where z_selected_tables.id_list_tables_criteria = z_list_tables_criteria.id_list_tables_criteria and id_subvision = '$id_sub'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$activeCrits = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

foreach ($data as $app) {
    $activeCrit = new ActiveCrit($app['id_list_tables_criteria'], $app['count'], $app['level']);
    array_push($activeCrits,$activeCrit);
}


echo json_encode($activeCrits);
?>