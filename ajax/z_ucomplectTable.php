<?php
include "connection.php";

$id_app = 545;

$query1  = "
SELECT s.name, s.id_subvision
FROM subvision s 
where  s.id_application = '545' ";
$rez1 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));

$subvisions = array();
echo '<style> 
td{
border: solid;
border-width: 1px;
}
.ucomp{
border: solid;
border-width: 1px;
}
th {
border: solid;
border-width: 1px;
}
</style>

<table class = "ucomp" >';
echo '<tr>
      <th>Структурное подразделение</th>
      <th>Число основных работников врачей на занятых должностях, человек</th>
      <th>Укомплектованность врачами-специалистами</th>
      <th>Укомплектованность должностей врачей физическими лицами (основные работники)</th>
      <th>Заголовок 5</th>
      <th>Заголовок 6</th>
      <th>Заголовок 6</th>
      <th>Заголовок 6</th>
      <th>Заголовок 6</th>
      </tr>';
echo '<tr>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      </tr>';

while ($row1 = mysqli_fetch_assoc($rez1)) {
    $subvisionName = $row1['name'];
    $subvisionId = $row1['id_subvision'];
    $subvisions[$subvisionId] = $subvisionName;

    $query2 = "select *
           from z_department as dep 
           where  dep.id_subvision  = '$subvisionId'";
    $rez2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
    echo '<tr ><td >' . $subvisionName . '</td></tr>';

    $departments = array();
    while ($row2 = mysqli_fetch_assoc($rez2)) {
        $departmentId = $row2['id_department'];
        $departmentName = $row2['name'];
        $subvisionId = $row2['id_subvision'];
        $field2= $row2['field2'];
        $field3= $row2['field3'];
        $field4= $row2['field4'];
        $field5= $row2['field5'];
        $field6= $row2['field6'];
        $field7= $row2['field7'];
        $field8= $row2['field8'];
        $field9= $row2['field9'];
        $subvisionName = $subvisions[$subvisionId];
        $departments[$subvisionName][] = array('id' => $departmentId, 'name' => $departmentName);
        echo '<tr>
              <td>' . $departmentName . '</td>
              <td> '.$field2.'</td>
              <td> '.$field3.'</td>
              <td> '.$field4.'</td>
              <td> '.$field5.'</td>
              <td> '.$field6.'</td>
              <td> '.$field7.'</td>
              <td> '.$field8.'</td>
              <td> '.$field9.'</td>
              
              </tr>';
    }
}
echo '</table>';
