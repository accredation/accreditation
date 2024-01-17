<?php
include "connection.php";

class ErrorItem{
    public $id_sub, $sub_name, $dep_name, $pp, $id_department;

    /**
     * ErrorItem constructor.
     * @param $sub_name
     * @param $dep_name
     * @param $pp
     */
    public function __construct($id_sub, $sub_name, $dep_name, $pp, $id_department)
    {
        $this->id_sub = $id_sub;
        $this->sub_name = $sub_name;
        $this->dep_name = $dep_name;
        $this->pp = $pp;
        $this->id_department = $id_department;
    }


}

$id_app = $_GET['id_application'];

$query = "SELECT a.id_application, s.name as sub_name, s.id_subvision, zd.name as dep_name, zd.id_department, zc.pp 
FROM `applications` a  
left outer join `subvision` s on a.id_application=s.id_application
left outer join `z_department` zd on s.id_subvision=zd.id_subvision
left outer join `z_answer_criteria` zac on zd.id_department=zac.id_department
left outer join `z_criteria` zc on zac.id_criteria=zc.id_criteria
WHERE a.id_application = '$id_app' 
  and (((zac.field3 = 1 and zac.field4 is null ) or ((zac.field3 = 2 or  zac.field3 = 3) and Ltrim(Rtrim(Isnull(zac.field5)))<>'' ) 
            or zac.field3 is null) or zd.id_department is null )
order by  sub_name,   dep_name, zc.pp          
            ";


$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$apps = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);
foreach ($data as $app) {
  $errItem = new ErrorItem($app['id_subvision'], $app['sub_name'], $app['dep_name'], $app['pp'], $app['id_department']);
  array_push($apps, $errItem);
}


echo json_encode($apps);
?>