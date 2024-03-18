<?php
include "connection.php";
$id_app = $_GET['id_application'];


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
  font-size: 21pt;
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

<div style=" font-size: 22pt;
    position: relative;
    text-align: center;
    margin-left: 5%;
">
<!-- Преамбула заявления -->
	Свидетельство<br>
    о соответствии государственной  организации здравоохранения базовым<br>
    критериям медицинской аккредитации<br></div>

<div style="font-size: 22pt;
    position: relative;
    left: 10%;
">
<!-- Поля для заполнения данных о юр. лице -->
<br>
Дата регистрации___________________________20____г.___ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;№___________________</div>
	<div style="font-size: 22pt;
    position: relative;
    left: 10%;
">
<!-- Поля для заполнения данных о юр. лице -->
<br>
Настоящее свидетельство выдано___________________________________________________________________________________</div>
      <div style="
    position: relative;
    left: 10%;
    font-size: 22pt;
    margin-top: 3%;
}
">______________________________________________________________________________________________________________________________________________________</div>
      <div style="font-style: italic;
    position: relative;
    left: 17%;
    font-size: 18pt;
">наименование заинтересованного лица</div>
      <div style="
    position: relative;
    left: 10%;
    font-size: 22pt;
    line-height: 90px;
">______________________________________________________________________________________________________________________________________________________</div>
 <div style="
    position: relative;
    left: 10%;
    font-size: 22pt;
    line-height: 90px;
">______________________________________________________________________________________________________________________________________________________</div>
<br>
       <div style="
    width: 89%;
    font-size: 22pt;
    position: relative;
    left: 9%;
    text-align: justify;
">о соответствии государственной организации здравоохранения базовым критериям медицинской аккредитации по следующим видам оказываемой медицинской помощи по профилям заболеваний, состояниям, синдромам:</div>
     

 <div style="display: flex; justify-content: center; margin-top: 20px;margin-left: 3%">
<table style="border-collapse: collapse; border: 1px solid black; width: 98%;">
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
</div>';?>

<br>
<br>
<!-- Подпись -->
<div style=" page-break-before: avoid; ">
    <div style="
	page-break-before: avoid;
    position: relative;
    left: 8%;
    font-size: 22pt;
	">Свидетельство действительно до ___ ______________________20___г.
    </div>
    <br>    <br>
    <div style="
	page-break-before: avoid;
    position: relative;
    left: 8%;
    font-size: 22pt;
	">Основание:
    </div>
    <div style="
	page-break-before: avoid;
    position: relative;
    left: 8%;
    font-size: 22pt;
	">Решение уполномоченного органа от ___ ______________________20___г. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;№___________________
    </div>
    <br>

    <br><br>
    <div style="
	page-break-before: avoid;
    position: relative;
    left: 8%;
    font-size: 22pt;
	">Руководитель (представитель)<br>
        заинтересованного лица:
    </div>
    <br>
    <br>
    <div style="
    position: relative;
    left: 8%;
    font-size: 17pt;
">_________________________________
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        _______________
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        __________________________
    </div>

    <div style="page-break-before: avoid;
	font-style: italic;
    	position: relative;
    	left: 8%;
    	font-size: 17pt;
">	(наименование должности служащего)

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        (подпись)
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        (инициалы,фамилия)
    </div>
</div>

</body>
