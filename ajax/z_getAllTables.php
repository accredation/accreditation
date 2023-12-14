<?php
include "connection.php";
$id_sub = $_GET['id_sub'];


$query = "SELECT zst.id_subvision, zac.id_answer_criteria, 
       zac.id_criteria, zac.field3, zac.field4, zac.field5, 
       zac.field6, zac.field7, zac.defect, zac.id_department, 
       zst.id_list_tables_criteria, zltc.name
FROM `z_answer_criteria` as zac
JOIN z_department as zd ON zac.id_department = zd.id_department
JOIN z_selected_tables as zst ON zd.id_subvision = zst.id_subvision
JOIN z_list_tables_criteria as zltc ON zst.id_list_tables_criteria = zltc.id_list_tables_criteria
WHERE zst.count > 0 and zst.id_subvision = '$id_sub';";
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$prev_id_list_tables_criteria = null;

while ($row = mysqli_fetch_assoc($rez)) {
    $id_list_tables_criteria = $row['id_list_tables_criteria'];
    $id_subvision = $row['id_subvision'];
    $id_answer_criteria = $row['id_answer_criteria'];
    $id_criteria = $row['id_criteria'];
    $name = $row['name'];
    $field3 = $row['field3'];
    $field4 = $row['field4'];
    $field5 = $row['field5'];
    $field6 = $row['field6'];
    $field7 = $row['field7'];
    $defect = $row['defect'];
    $id_department = $row['id_department'];


    if ($id_list_tables_criteria != $prev_id_list_tables_criteria) {

        if ($prev_id_list_tables_criteria != null) {
            echo '</tbody></table></div></div>';
        }
        echo '<div class="card-header" id="heading' . $id_list_tables_criteria . '" style="justify-content: center; display: inline-grid; " onclick="newCollapseTable(this)">
        <button class="btn btn-link" data-toggle="collapse" data-target="#collapse' . $id_list_tables_criteria . '" aria-expanded="false" aria-controls="collapse' . $id_list_tables_criteria . '" style="text-decoration: none; color: black; font-size: 0.9rem;">
        ' . $name . '
        </button>
        </div>
        <div class="collapse" id="collapse' . $id_list_tables_criteria . '" aria-labelledby="heading' . $id_list_tables_criteria . '" data-parent="#accordion">
        <div class="card-body" id="cardBody' . $id_list_tables_criteria . '" style="padding: 0px;">
        <table style="border: 1px solid black; width: 100%;">
        <tr>
            <th rowspan="2" style="border: 1px solid black; text-align: center;">
                № п/п
            </th>
            <td style="border: 1px solid black; width: 25%; text-align: center;">
                Критерий
            </td>
            <td style="border: 1px solid black; width: 10%; text-align: left;">
                Сведения по самооценке ОЗ
            </td>
            <td style="width: 350px; border: 1px solid black;">
                Документы и сведения, на основании которых проведена самооценка
            </td>
            <td style="border: 1px solid black;">
                Примечание
            </td>
        </tr>
        <tbody>';
    }


    $query1 = "SELECT id_criteria, pp, z_criteria.`name` FROM z_criteria WHERE id_list_tables_criteria = '$id_list_tables_criteria'";
    $rez1 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));

    while ($row1 = mysqli_fetch_assoc($rez1)) {
        echo '<tr>
                <td style="border: 1px solid black; text-align: center;">' . $row1["pp"] . '</td>
                <td style="border: 1px solid black; padding: 0.2rem 0.75rem; text-align: left;">' . $row1["name"] . '</td>
                <td style="border: 1px solid black;"><div style="display: flex; justify-content: center;"><select><option value="null"></option><option value="1">Да</option><option value="2">Нет</option><option value="3">Не требуется</option></select></div></td>
                <td style="border: 1px solid black;"><div style="height: 15rem;"><textarea style="width: 100%; height: 100%;"></textarea></div></td>
                <td style="border: 1px solid black;"><div style="height: 15rem;"><textarea rows="3" style="width: 100%; height: 100%;"></textarea></div></td>
            </tr>';
    }

    $prev_id_list_tables_criteria = $id_list_tables_criteria;
}

if ($prev_id_list_tables_criteria != null) {
    echo '</tbody></table></div></div>';
}

mysqli_close($con);
?>