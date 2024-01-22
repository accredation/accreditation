<?php
include "connection.php";

class Crit{
    public $id, $name, $id_type, $level;

    function __construct($id, $name, $id_type, $level) {
        $this->id = $id;
        $this->name = $name;
        $this->id_type = $id_type;
        $this->level = $level;
    }
}

$id_sub = $_GET['id_sub'];

$query = " select * from z_list_tables_criteria order by level, name";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$crits = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);

foreach ($data as $app) {
    $crit = new Crit($app['id_list_tables_criteria'], $app['name'],$app['id_types_tables'], $app['level']);
    array_push($crits,$crit);
}


echo json_encode($crits);
?>