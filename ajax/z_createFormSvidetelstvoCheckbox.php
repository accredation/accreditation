<?php
include "connection.php";
$id_app = $_GET['id_application'];
$status = $_GET['status'];


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
  font-size: 13pt;
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

    $query_tds = "select tt.name as namet, ltc.name_profile as namel, dep.name as named, dep.accred_svid , dep.id_department FROM z_department AS dep
                        JOIN z_list_tables_criteria AS ltc ON ltc.id_list_tables_criteria = dep.id_list_tables_criteria  
                        JOIN z_types_tables AS tt ON tt.id_types_tables = ltc.id_types_tables
                        where dep.id_subvision = '$id_sub'";
    $result_tds = mysqli_query($con, $query_tds) or die("Ошибка " . mysqli_error($con));
    while ($row_tds = mysqli_fetch_assoc($result_tds)) {
        $checkbox = ($row_tds["accred_svid"] == 1) ? 'checked' : '';
        $disabled = $status == 6 || $status == 7 ? "disabled" : "";
        echo ' <tr>
        <td style = "text-align: center;">'.$ind.'</td>
        <td style="width: 25%;    word-break: break-word;">'.$row_tds["namet"].'</td>
        <td>'.$row_tds["namel"].'</td>
        <td>'.$row_tds["named"].'</td>
        <td><input onchange="svidCheckbox(this)"'. $disabled .' type="checkbox" '.$checkbox.' data-id="'.$row_tds["id_department"].'"></td>
    </tr>
    ';
        $ind++;
    }
}
echo '</tbody></table>
</div>';?>


<br>
<br>


</body>
