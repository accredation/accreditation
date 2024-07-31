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
$criteria_list = [62, 106, 96, 123, 171, 187, 914, 924, 1063, 1072, 1088, 1097, 1107, 1115, 1127, 1138, 1147, 1155, 1171, 1184, 1214, 1222, 1264, 1284, 1303, 1236, 1247, 1197, 1203, 1035, 1047, 1011, 1021, 986, 999, 973, 963, 941, 950, 885, 895, 853, 867, 203, 789, 776, 741, 758, 703, 683, 691, 331, 348, 317, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331];
$criteria_list_str = implode(',', $criteria_list);

$query = "SELECT a.id_application, s.name as sub_name, s.id_subvision, zd.name as dep_name, zd.id_department, zc.pp , zc.id_criteria 
FROM `applications` a  
left outer join `subvision` s on a.id_application=s.id_application
left outer join `z_department` zd on s.id_subvision=zd.id_subvision
left outer join `z_answer_criteria` zac on zd.id_department=zac.id_department
left outer join `z_criteria` zc on zac.id_criteria=zc.id_criteria
WHERE a.id_application = '$id_app' 
  and (((zac.field3 = 1 and ((Ltrim(Rtrim(zac.field4))='') or zac.field4 is null)))
 or ((zac.field3 = 2 or  zac.field3 = 3) and (( Ltrim(Rtrim(zac.field5))='' ) or (zac.field5 is null)) or (zac.field3 is null or zac.field3=0))or zd.id_department is null )
order by  sub_name,   dep_name, zc.pp          
            ";


$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$apps = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);
foreach ($data as $app) {
    $id_criteria = $app['id_criteria'];
    $id_department = $app['id_department'];

    $criteriaQuery = "SELECT id_criteria FROM accreditation.z_answer_criteria WHERE id_department = '$id_department' AND id_criteria IN ($criteria_list_str)";
    $criteriaResult = mysqli_query($con, $criteriaQuery) or die("Ошибка " . mysqli_error($con));

    while ($criteriaRow = mysqli_fetch_assoc($criteriaResult)) {
        $id_criteria = $criteriaRow['id_criteria'];
        $updateQuery = "UPDATE `z_answer_criteria` SET field3 = 3, field5 = 'критерий исключен' WHERE id_criteria = '$id_criteria'";
        mysqli_query($con, $updateQuery) or die("Ошибка " . mysqli_error($con));
    }

  $errItem = new ErrorItem($app['id_subvision'], $app['sub_name'], $app['dep_name'], $app['pp'], $app['id_department']);
  array_push($apps, $errItem);
}
echo json_encode($apps);
?>