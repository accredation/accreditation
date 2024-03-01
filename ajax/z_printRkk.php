<?php
include "connection.php";
$id_app = $_GET['id_application'];

$query = "SELECT r.*, applications.*, r.ucomplect as ucomplect_rkk  FROM rkk as r, applications where r.id_application = '$id_app' and applications.id_rkk = r.id_rkk";

$result = mysqli_query($con, $query);

if (mysqli_num_rows($result) == 1) {
    $row = mysqli_fetch_array($result);
    $id_rkk = $row['id_rkk'];
    $date_reg = $row['date_reg'];
    $count_list_app = $row['count_list_app'];
    $tech_osn = $row['tech_osn'];
    $raspisanie = $row['raspisanie'];
    $ucomplect = $row['ucomplect_rkk'];
    $report_samoacred = $row['report_samoacred'];
    $dop_sved = $row['dop_sved'];
    $id_user = $row['id_user'];
    $predstavitel = $row['predstavitel'];
    $perv_vtor = $row['perv_vtor'];
    $date_index_povt_app = $row['date_index_povt_app'];
    $info_napr_zapr = $row['info_napr_zapr'];
    $info_sogl = $row['info_sogl'];
    $protokol_zased = $row['protokol_zased'];
    $date_protokol = $row['date_protokol'];
    $info_vozvr = $row['info_vozvr'];
    $info_otzyv = $row['info_otzyv'];
    $date_admin_resh = $row['date_admin_resh'];
    $count_list_admin = $row['count_list_admin'];
    $rezult = $row['result'];
    $svidetelstvo = $row['svidetelstvo'];
    $date_sved = $row['date_sved'];
    $count_list_sved = $row['count_list_sved'];
    $info_uved = $row['info_uved'];
    $count_list_report_medacr = $row['count_list_report_medacr'];
    $getter = $row['getter'];
    $delo = $row['delo'];
    $date_delo = $row['date_delo'];
    $dop_info = $row['dop_info'];
    $po_n = $row['po_n'];
    $delo_listov = $row['delo_listov'];
    $checkboxValueGuzo = $row['checkboxValueGuzo'];

    $naim = $row['naim'];
    $ur_adress = $row['ur_adress'];
    $fact_adress = $row['fact_adress'];
    $tel = $row['tel'];
    $email = $row['email'];
    $zaregal = $row['zaregal'];
}

$timestamp = strtotime($date_reg);
$dateTime = new DateTime();
$dateTime->setTimestamp($timestamp);
$months = [
    'January' => 'января',
    'February' => 'февраля',
    'March' => 'марта',
    'April' => 'апреля',
    'May' => 'мая',
    'June' => 'июня',
    'July' => 'июля',
    'August' => 'августа',
    'September' => 'сентября',
    'October' => 'октября',
    'November' => 'ноября',
    'December' => 'декабря'
];

$new_date_reg = $dateTime->format('j ') . $months[$dateTime->format('F')] . $dateTime->format(' Y');

//echo '<tr><td colspan="4" style="font-weight: 700; text-align: center">' . $name_sub . '</td></tr>';
echo '		
<body>
<style>
font-family:  "Times New Roman" ;
}
table {
  width: 100%;
  border-collapse: collapse;
  page-break-inside: avoid;
}

.page-break {
        page-break-before: always; /* или page-break-after: always; */
    }

td {
   border: 1px solid black;
  padding: 8px;
  text-align: center;
  font-size: 12pt;
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

<div style=" font-size: 18pt;
    position: relative;
    text-align: center;
    margin-left: 5%;
">
<!-- Преамбула заявления -->
    Регистрационно-контрольная карточка <br> регистрации заявления заинтересованного лица</div>
    <div style="display: block; margin-top: 30px">
<div style="display: flex; font-size: 15pt;
     margin-bottom: 30px; margin-left: 5%;  justify-content: space-between;
">
<div style="float: left">'.$new_date_reg.' <br> <span style="font-size: 9pt; font-weight: normal;">(дата регистрации)</span></div>
<!-- Шапка заявления -->
	<div ><span style="float: right">№ ' . $id_rkk . '</span><br>
	<span style="font-size: 9pt; font-weight: normal;">(регистрационный индекс)</span></div>
	
	</div>

<div style="display: block; font-size: 15pt;">
<!-- Поля для заполнения данных о юр. лице -->

 <div style=" justify-content: center; margin-top: 20px;margin-left: 3%;  ">
<table style="border-collapse: collapse; border: 1px solid black; width: 98%; ">
    <tr>
        <td colspan="2" style=" text-align: center; width: 50%">
            Наименование документов и (или) сведений
        </td>
        <td style=" width: 50%; text-align: center;">
            Информация
        </td>
       
        </tr>
        <tr > <td colspan="3">Этап 1. Прием документов и сведений</td></tr>
        <tbody>';


echo ' <tr>
 
        <td style = " width: 10%; text-align: center;">1</td>
        <td style = "width: 40%; text-align: left;">Наименование юридического лица</td>
        <td style="width: 50%;    word-break: break-word; text-align: left;">'.$naim.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">2</td>
        <td style = "width: 40%; text-align: left;">Юридический адрес</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$ur_adress.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">3</td>
        <td style = "width: 40%; text-align: left;">Фактический адрес</td>
        <td style="width: 50%; text-align: left;   word-break: break-word;">'.$fact_adress.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">4</td>
        <td style = "width: 40%; text-align: left;">Контактная информация (телефон (факс), электронный адрес)</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$tel. " " . $email . '</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">5</td>
        <td style = "width: 40%; text-align: left;">Заявление</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$new_date_reg. " ". $count_list_app . '</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">6</td>
        <td style = "width: 40%; text-align: left;">Документы и сведения, представленных заинтересованным лицом:</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;"></td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">6.1</td>
        <td style = "width: 40%; text-align: left;">сведения об используемой медицинской технике по форме, устанавливаемой Министерством здравоохранения;</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;"></td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">6.2</td>
        <td style = "width: 40%; text-align: left;">копия штатного расписания;</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$raspisanie.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">6.3</td>
        <td style = "width: 40%; text-align: left;">сведения о показателях укомплектованности специалистами с высшим и средним специальным медицинским образованием (по штатным должностям, физическим лицам, коэффициенту совместительства) по форме, устанавливаемой Министерством здравоохранения;</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$ucomplect.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">6.4</td>
        <td style = "width: 40%; text-align: left;">отчет о результатах самоаккредитации в произвольной форме;</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$report_samoacred.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">6.5</td>
        <td style = "width: 40%; text-align: left;">дополнительные документы и сведения</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$dop_sved.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">7</td>
        <td style = "width: 40%; text-align: left;">Информация о работнике, принявшем заявление и прилагаемые к нему документы и сведения</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$zaregal.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">8</td>
        <td style = "width: 40%; text-align: left;">Заинтересованному лицу разъяснены права и обязанности</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">3</td>
    </tr>
    
    <tr class="page-break">
 
        <td style = " width: 10%; text-align: center;">9</td>
        <td style = "width: 40%; text-align: left;">Срок исполнения</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">3</td>
    </tr>
    <tr > <td colspan="3">Этап 2. Ход рассмотрения</td></tr>
    <tr>
 
        <td style = " width: 10%; text-align: center;">10</td>
        <td style = "width: 40%; text-align: left;">Информация о направлении запросов в другие государственные органы, иные организации</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$info_napr_zapr.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">11</td>
        <td style = "width: 40%; text-align: left;">Информация о согласии заинтересованного лица на представление документов и (или) сведений</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$info_sogl.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">12</td>
        <td style = "width: 40%; text-align: left;">Номер и дата протокола заседания комиссии</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">№'.$protokol_zased.' '. $date_protokol .'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">13</td>
        <td style = "width: 40%; text-align: left;">Информация о возврате заявления и прилагаемых к нему документов и сведений в случае принятия решения об отказе в принятии заявления заинтересованного лица</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$info_vozvr.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">14</td>
        <td style = "width: 40%; text-align: left;">Информация об отзыве заявления</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$info_otzyv.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">15</td>
        <td style = "width: 40%; text-align: left;">Дата и номер принятого административного решения</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">№'.$id_rkk.' '. $date_admin_resh .'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">16</td>
        <td style = "width: 40%; text-align: left;">Результат принятого административного решения</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$rezult.'</td>
    </tr>
    
     <tr>
 
        <td style = " width: 10%; text-align: center;">17</td>
        <td style = "width: 40%; text-align: left;">Информация об уведомлении заинтересованного лица о принятом административном решении</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$info_uved.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">18</td>
        <td style = "width: 40%; text-align: left;">Документы и сведения, выданные заинтересованному лицу (указать количество листов):</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">3</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">18.1</td>
        <td style = "width: 40%; text-align: left;">административное решение;</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$count_list_admin.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">18.2</td>
        <td style = "width: 40%; text-align: left;">свидетельство о медицинской аккредитации;</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$po_n.' '. $date_sved .' '. $count_list_sved. '</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">18.3</td>
        <td style = "width: 40%; text-align: left;">отчет о проведении медицинской аккредитации</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$count_list_report_medacr.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">19</td>
        <td style = "width: 40%; text-align: left;">Информация о получении заинтересованным лицом документов и сведений</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">3</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">20</td>
        <td style = "width: 40%; text-align: left;">Даты, индексы повторных заявлений</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$date_index_povt_app.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">21</td>
        <td style = "width: 40%; text-align: left;">Отметка о снятии с контроля</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$date_delo.'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">22</td>
        <td style = "width: 40%; text-align: left;">Документ подшит в дело</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$delo. ' '. $delo_listov .'</td>
    </tr>
    
    <tr>
 
        <td style = " width: 10%; text-align: center;">23</td>
        <td style = "width: 40%; text-align: left;">Дополнительная информация</td>
        <td style="width: 50%;  text-align: left;  word-break: break-word;">'.$dop_info.'</td>
    </tr>    
    ';

echo '</tbody></table>
</div>';
?>
</div>
</body>

