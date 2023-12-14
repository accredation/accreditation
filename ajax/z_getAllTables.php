<?php
include "connection.php";
$id_sub = $_GET['id_sub'];


$query_departments = "SELECT * FROM z_department WHERE ID_SUBVISION = '$id_sub'";
$result_departments = mysqli_query($con, $query_departments) or die("Ошибка " . mysqli_error($con));

while ($row_department = mysqli_fetch_assoc($result_departments)) {
    $id_department = $row_department['id_department'];
    $department_name = $row_department['name'];

    echo '<div class="card-header" id="heading' . $id_department . '" style="justify-content: center; display: inline-grid; " onclick="newCollapseTable(this)">
        <button class="btn btn-link" data-toggle="collapse" data-target="#collapse' . $id_department . '" aria-expanded="false" aria-controls="collapse' . $id_department . '" style="text-decoration: none; color: black; font-size: 0.9rem;">
        ' . $department_name . '
        </button>
        </div>
        <div class="collapse" id="collapse' . $id_department . '" aria-labelledby="heading' . $id_department . '" data-parent="#accordion">
        <div class="card-body" id="cardBody' . $id_department . '" style="padding: 0px;">
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

    $query_criteria = "SELECT zac.id_criteria, zac.field3, zac.field4, zac.field5, zac.field6, zac.field7, zac.defect, zc.pp, zc.`name`
                        FROM z_answer_criteria AS zac
                        JOIN z_criteria AS zc ON zac.id_criteria = zc.id_criteria
                        WHERE zac.id_department = '$id_department'";
    $result_criteria = mysqli_query($con, $query_criteria) or die("Ошибка " . mysqli_error($con));

    while ($row_criteria = mysqli_fetch_assoc($result_criteria)) {
        echo '<tr>
                <td style="border: 1px solid black; text-align: center;">' . $row_criteria["pp"] . '</td>
                <td style="border: 1px solid black; padding: 0.2rem 0.75rem; text-align: left;">' . $row_criteria["name"] . '</td>
                <td style="border: 1px solid black;"><div style="display: flex; justify-content: center;"><select><option value="null"></option><option value="1">Да</option><option value="2">Нет</option><option value="3">Не требуется</option></select></div></td>
                <td style="border: 1px solid black;"><div style="height: 15rem;"><textarea style="width: 100%; height: 100%;">' . $row_criteria["field3"] . '</textarea></div></td>
                <td style="border: 1px solid black;"><div style="height: 15rem;"><textarea rows="3" style="width: 100%; height: 100%;">' . $row_criteria["field4"] . '</textarea></div></td>
            </tr>';
    }

    echo '</tbody></table></div></div>';
}

mysqli_close($con);
?>