<?php
include "connection.php";
$id_app = $_GET['id_application'];



echo '
<style>
body{

font-family:  \'Times New Roman\' ;
}
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
}
td {
  word-break: break-word;
}
th {
  background-color: #f2f2f2;
}

tr:nth-child(even) {
  background-color: #f9f9f9;
}

tr:hover {
  background-color: #f5f5f5;
}

</style>

      <div style="font-size: 14pt;
    position: relative;
    left: 75%;
    
">Директору РНПЦ МТ</div>
      <div style=" font-size: 14pt;
    position: relative;
    left: 75%;
">Щербинскому А.А.</div>
<br><br><br>
      <div style=" font-size: 14pt;
    position: relative;
    text-align: center;
">ЗАЯВЛЕНИЕ</div>
      <div style=" font-size: 15pt;
    position: relative;
    text-align: center;
">о получении свидетельства о соответствии государственной</div>
      <div style=" font-size: 15pt;
    position: relative;
    text-align: center;
">организации здравоохранения базовым критериям медицинской</div>
      <div style=" font-size: 15pt;
    position: relative;
   text-align: center;
">аккредитации, внесении в него изменений</div>
      <div style="font-size: 14pt;
    position: relative;
    left: 10%;
">
<br>
Прошу выдать____________________________________________________________________________________</div>
      <div style="font-style: italic;
    position: relative;
    left: 35%;
    font-size: 9pt;
">(наименование заинтересованного лица,</div>
      <div style="
    position: relative;
    left: 10%;
">________________________________________________________________________________________________________________</div>
      <div style="font-style: italic;
    position: relative;
    left: 34%;
    font-size: 9pt;
">его местонахождения, юридический адрес,</div>
      <div style="
    position: relative;
    left: 10%;
">________________________________________________________________________________________________________________</div>
      <div style="font-style: italic;
    position: relative;
    left: 30%;
    font-size: 9pt;
">контактная информация (телефон(факс), электронный адрес)</div>
      <div style="
    position: relative;
    left: 10%;
">________________________________________________________________________________________________________________</div>
<br>
       <div style="width: 80%; font-size: 15pt;
    position: relative;
    left: 10%; text-align: justify;
">свидетельство о соответствии государственной организации здравоохранения базовым критериям медицинской аккредитации по видам оказываемой медицинской помощи по профилям заболеваний, состояний, синдромов, методов их исследования:</div>
     


 <div style="display: flex; justify-content: center; margin-top: 20px">
<table style="border: 1px solid black; width: 80%;">
    <tr>
        <th  style=" text-align: center; width: 3%">
            № п/п
        </th>
        <td style=" width: 25%; text-align: center;">
            Наименование вида медицинской помощи
        </td>
        <td style="  width: 25%; text-align: left;">
            Наименование профиля заболеваний, состояния, синдрома
        </td>
        <td style="width: 25%;    word-break: break-word;">
            Наименование подразделения
        </td>
        </tr><tbody>';

$query_subs = "SELECT id_subvision, s.name from subvision s 
                        WHERE s.id_application = '$id_app'";
$result_subs = mysqli_query($con, $query_subs) or die("Ошибка " . mysqli_error($con));
$ind = 1;
while ($row_subs = mysqli_fetch_assoc($result_subs)) {
    $name_sub = $row_subs["name"];
    $id_sub = $row_subs["id_subvision"];
    echo '
    <tr><td colspan="4" style="font-weight: 700; text-align: center">' . $name_sub . '</td></tr>';
    $query_tds = "select tt.name as namet, ltc.name_profile as namel, dep.name as named FROM z_department AS dep
                        JOIN z_list_tables_criteria AS ltc ON ltc.id_list_tables_criteria = dep.id_list_tables_criteria  
                        JOIN z_types_tables AS tt ON tt.id_types_tables = ltc.id_types_tables
                        where dep.id_subvision = '$id_sub'";
    $result_tds = mysqli_query($con, $query_tds) or die("Ошибка " . mysqli_error($con));
    while ($row_tds = mysqli_fetch_assoc($result_tds)) {
        echo ' <tr>
 
        <td style = "text-align: center;">'.$ind.'</td>
        <td style="width: 25%;    word-break: break-word;">'.$row_tds["namet"].'</td>
        <td>'.$row_tds["namel"].'</td>
        <td>'.$row_tds["named"].'</td>
    </tr>
    ';
        $ind++;
    }
}
echo '</tbody></table>
</div>';

$query_rukovod = "SELECT ap.rukovoditel, ap.predstavitel from applications ap 
                        WHERE ap.id_application = '$id_app'";
$result_rukovod = mysqli_query($con, $query_rukovod) or die("Ошибка " . mysqli_error($con));
if ($row_rukovod = mysqli_fetch_assoc($result_rukovod)) {
    $rukovod = $row_rukovod['rukovoditel'] ?? 'Руководитель (представитель)';
    $predstavitel = $row_rukovod['predstavitel'] ?? 'заинтересованного лица';
}
else{
    $rukovod = 'Руководитель (представитель)';
    $predstavitel = 'заинтересованного лица';
}
echo '</br></br>
<div style="
    position: relative;
    left: 10%;font-size: 14pt;
">Руководитель (представитель)</div>
<div style="
    position: relative;
    left: 10%;font-size: 14pt;
">заинтересованного лица: </div>
<br>
<br>
<div style="
    position: relative;
    left: 10%;
">___________________________
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;
____________
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

____________________</div>
<div class = "podpiska" style="display: flex;">
 <div style="
    position: relative;
    left: 10%;
    font-size: 9pt;
">(наименование должности служащего)</div>
 <div style="
    position: relative;
    left: 31%;
    font-size: 9pt;
">(подпись)</div>
 <div style="
    position: relative;
    left: 54%;
    font-size: 9pt;
">(инициалы,фамилия)</div>
</div>
';

?>