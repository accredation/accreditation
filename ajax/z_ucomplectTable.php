<?php
include "connection.php";

$id_app = $_GET['id_application'];

$query1  = "
SELECT s.name, s.id_subvision
FROM subvision s 
where  s.id_application = '$id_app' ";
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
font-size: 13px;
}
th {
border: solid;
border-width: 1px;
}

.modal-body{overflow: auto;}
</style>';
echo '<div class = "complectText">СВЕДЕНИЯ </div>
 <div class = "complectText">
 о показателях укомплектованности специалистами с высшим и средним медицинским образованием
 </div>
 </br>
<table class = "ucomp" >';
echo '<tr>
      <th>Структурное подразделение</th>
      <th>Число основных работников врачей на занятых должностях, человек</th>
      <th>Укомплектованность врачами-специалистами, %</th>
      <th>Укомплектованность должностей врачей физическими лицами (основные работники), %</th>
      <th>Коэффициент совместительства врачей</th>
      <th>Число средних медицинских работников (основных) на занятых должностях, человек</th>
      <th>Укомплектованность средними медицинскими работниками, %</th>
      <th>Укомплектованность должностей средних медицинских работников физическими лицами (основные работники), %</th>
      <th>Коэффициент совместительства средних медицинских работников</th>
      </tr>';

while ($row1 = mysqli_fetch_assoc($rez1)) {
    $subvisionName = $row1['name'];
    $subvisionId = $row1['id_subvision'];
    $subvisions[$subvisionId] = $subvisionName;

    $query2 = "select *
           from z_department as dep 
           where  dep.id_subvision  = '$subvisionId'";
    $rez2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
    echo '<tr ><td colspan="9" style="    font-size: 20px;  font-weight: 700;">' . $subvisionName . '</td></tr>';

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
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this , 2)"> '.$field2.'</td>
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 3)"> '.$field3.'</td>
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 4)"> '.$field4.'</td>
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 5)"> '.$field5.'</td>
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 6)"> '.$field6.'</td>
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 7)"> '.$field7.'</td>
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 8)"> '.$field8.'</td>
              <td contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 9)"> '.$field9.'</td>
              
              </tr>';
    }
}

$query3 = "select sum(field2) as sum2, avg(field3) as sum3, avg(field4) as sum4, avg(field5) as sum5,
                sum(field6) as sum6, avg(field7) as sum7, avg(field8) as sum8, avg(field9) as sum9
           from z_department 
            left join subvision s on z_department.id_subvision = s.id_subvision
            where s.id_application = '$id_app'
         ";

$rez3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));

if(mysqli_num_rows($rez3) == 1){
    $row = mysqli_fetch_assoc($rez3);
    $sum2 = $row['sum2'];
    $sum3 = $row['sum3'];
    $sum4 = $row['sum4'];
    $sum5 = $row['sum5'];
    $sum6 = $row['sum6'];
    $sum7 = $row['sum7'];
    $sum8 = $row['sum8'];
    $sum9 = $row['sum9'];


echo '<tr>
              <td>Всего</td>
              <td id="sum2" > '.$sum2.'</td>
              <td id="sum3"> '.round($sum3,2).'</td>
              <td id="sum4"> '.round($sum4,2).'</td>
              <td id="sum5"> '.round($sum5,2).'</td>
              <td id="sum6"> '.$sum6.'</td>
              <td id="sum7"> '.round($sum7,2).'</td>
              <td id="sum8"> '.round($sum8,2).'</td>
              <td id="sum9"> '.round($sum9,2).'</td>
              
              </tr>';
}
echo '</table>';
