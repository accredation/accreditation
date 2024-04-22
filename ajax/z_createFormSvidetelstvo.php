<?php
include "connection.php";
$id_app = $_GET['id_application'];

function convertDate($date) {
    $dateObj = date_create_from_format('Y-m-d', $date);
    return date_format($dateObj, 'd.m.Y');
}

// Пример использования
$queryN = "SELECT naim from applications 
                        WHERE id_application = '$id_app'";
$resultN = mysqli_query($con, $queryN) or die("Ошибка " . mysqli_error($con));
$row = mysqli_fetch_array($resultN);
$naim = $row['naim'];

$queryDates = "SELECT date_protokol, date_sved, date_admin_resh, protokol_zased from rkk 
                        WHERE id_application = '$id_app'";
$resultDates = mysqli_query($con, $queryDates) or die("Ошибка " . mysqli_error($con));
$row = mysqli_fetch_array($resultDates);

$dateReg = convertDate($row['date_protokol']);
$dateSved = convertDate($row['date_sved']);
$dateAdminResh = convertDate($row['date_admin_resh']);
$po_n = $row['protokol_zased'];
//echo '<tr><td colspan="4" style="font-weight: 700; text-align: center">' . $name_sub . '</td></tr>';
echo '		
<body>
<style>
font-family:  "Times New Roman" ;
}
table {
  width: 100%;
  border-collapse: collapse;
}

td {
   border: 1px solid black;
  padding: 8px;
  text-align: center;
  font-size: 15pt;
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
</body>        

<br>

<div style="font-size: 22pt;
    position: relative;
    left: 10%;
">
<!-- Поля для заполнения данных о юр. лице -->


<br>
Дата регистрации &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'.$dateReg.'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div style="font-size: 22pt;
    position: relative;
    left: 10%; width: 81%; text-align: justify;
">
<!-- Поля для заполнения данных о юр. лице -->
<br>
Настоящее свидетельство выдано '.$naim.'</div>
      <div style="
    position: relative;
    left: 10%;
    font-size: 8pt;
    font-weight: 900;
}">_______________________________________________________________________________________________________________________________________________________</div>
      <div style="font-style: italic;
    position: relative;
    left: 35%;
    font-size: 18pt;
">наименование заинтересованного лица</div>

<br>
        <div style="
    width: 81%;
    font-size: 22pt;
    position: relative;
    left: 10%;
    text-align: justify;
">о соответствии государственной организации здравоохранения базовым критериям медицинской аккредитации по следующим видам оказываемой медицинской помощи по профилям заболеваний, состояниям, синдромам:</div>
     

 <div style="display: flex; justify-content: center; margin-top: 20px;margin-left: 0.6%">
<table style="border-collapse: collapse; border: 1px solid black; width: 81%; ">
    <tr>
        <td  style=" text-align: center; width: 5%">
            № п/п
        </td>
        <td style=" width: 25%; text-align: center;">
            Наименование вида медицинской помощи
        </td>
        <td style="  width: 25%; text-align: center;">
            Наименование профиля заболеваний, состояния, синдрома, метода их исследования
        </td>
        <td style="width: 25%;    word-break: break-word; text-align: center;">
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

    $query_tds = "select tt.name as namet, ltc.name_profile as namel, dep.name as named FROM z_department AS dep
                        JOIN z_list_tables_criteria AS ltc ON ltc.id_list_tables_criteria = dep.id_list_tables_criteria  
                        JOIN z_types_tables AS tt ON tt.id_types_tables = ltc.id_types_tables
                        where dep.id_subvision = '$id_sub' and dep.accred_svid = 1";
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
</div>
<br>
<br>
<!-- Подпись -->
<div style="position: absolute; page-break-before: avoid; ">
    <div style="
	page-break-before: avoid;
    position: relative;
    left: 12.5%;
    font-size: 20pt;
	">Свидетельство действительно до '.$dateSved.
    '</div>
    <br>
    <br>
    <div style="
	page-break-before: avoid;
    position: relative;
    left: 12.5%;
    font-size: 20pt;
	">Основание:
    </div>
    <div style="
	page-break-before: avoid;
    position: relative;
    left: 12.5%;
    font-size: 20pt;
	">Решение уполномоченного органа от '.$dateReg.' &nbsp;&nbsp;&nbsp;№'.$po_n.'
    </div>
    <br>
    <br>
<!--    <div style="-->
<!--	page-break-before: avoid;-->
<!--    position: relative;-->
<!--    left: 8%;-->
<!--    font-size: 20pt;-->
<!--    margin-top: 50px;-->
<!--	">Директор-->
<!--    </div>-->
    <div style="
    position: relative;
    left: 12.5%;
    font-size: 20pt;
">Директор&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        &nbsp;&nbsp;&nbsp;____________
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        А.А.Щербинский
    </div>

    <div style="page-break-before: avoid;
	font-style: italic;
    	position: relative;
    	left: 12%;
    	font-size: 14pt;

">	(Руководитель уполномоченного органа)

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        (подпись)
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(инициалы,фамилия)
    </div>
</div>

</body>'
;?>