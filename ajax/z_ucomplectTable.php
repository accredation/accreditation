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
.ucomp {
  width: 100%;
  border-collapse: collapse;
}

.ucomp th, .ucomp td {
  padding: 8px;
  text-align: center;
  border: 1px solid #ddd;
  font-size: 11px;
 
}

.ucomp th {
  background-color: #f2f2f2;
}

.ucomp tr:nth-child(even) {
  background-color: #f9f9f9;
}

.ucomp tr:hover {
  background-color: #f5f5f5;
}

.ucomp td[colspan="9"] {
  font-size: 20px;
  font-weight: 700;
}

.subdivision-cell {
  font-weight: bold;
}

.contenteditable {
  cursor: pointer;
}

.modal-body{overflow: auto;}
</style>';
echo '<div class = "complectText">СВЕДЕНИЯ </div>
 <div class = "complectText">
 о показателях укомплектованности специалистами с высшим и средним медицинским образованием
 </div>
 </br>
<table class = "ucomp"  style="width: 100%;">';
echo '<tr>
      <th style="width: 100%;">Структурное подразделение</th>
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
              <td class="subdivision-cell" style="width: 100%;    word-break: break-word; ">' . $departmentName . '</td>
              <td   contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this , 2)"> '.$field2.'</td>
              <td   contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 3)"> '.$field3.'</td>
              <td   contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 4)"> '.$field4.'</td>
              <td  contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 5)"> '.$field5.'</td>
              <td  contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 6)"> '.$field6.'</td>
              <td  contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 7)"> '.$field7.'</td>
              <td  contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 8)"> '.$field8.'</td>
              <td  contenteditable="true" onblur="saveUcompField(' . $subvisionId . ', ' . $departmentId . ', this, 9)"> '.$field9.'</td>
              
              </tr>';
    }
}

$query2 = "select field1,field2,field3,field4,field5,field6,field7,field8
           from applications  
           where  id_application  = '$id_app'";
$rez2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));
if(mysqli_num_rows($rez2) == 1) {
    $row = mysqli_fetch_assoc($rez2);
    $field1 = $row['field1'];
    $field2 = $row['field2'];
    $field3 = $row['field3'];
    $field4 = $row['field4'];
    $field5 = $row['field5'];
    $field6 = $row['field6'];
    $field7 = $row['field7'];
    $field8 = $row['field8'];
    echo '<tr>
              <td>Всего по учреждениям</td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 1)" >'.$field1.' </td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 2)" >'.$field2.' </td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 3)" >'.$field3.' </td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 4)" >'.$field4.' </td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 5)" >'.$field5.' </td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 6)" >'.$field6.' </td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 7)" >'.$field7.' </td>
              <td style="font-size: 10px;" contenteditable="true" onblur="saveCommon(' . $id_app . ', this , 8)" >'.$field8.' </td>
              
              </tr>';
}
echo '</table>';
