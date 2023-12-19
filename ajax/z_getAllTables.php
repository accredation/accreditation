<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$login = $_COOKIE['login'];


$query_departments = "SELECT * FROM z_department WHERE ID_SUBVISION = '$id_sub'";
$result_departments = mysqli_query($con, $query_departments) or die("Ошибка " . mysqli_error($con));

while ($row_department = mysqli_fetch_assoc($result_departments)) {
    $id_department = $row_department['id_department'];
    $department_name = $row_department['name'];
    $mark_percent = $row_department['mark_percent'];

    echo '<div class="card-header" id="heading' . $id_department . '" style="justify-content: center; display: inline-grid; " onclick="newCollapseTable(this)">
         <div class="actions-container">
        <button class="btn btn-link" data-toggle="collapse"  aria-expanded="false" aria-controls="collapse' . $id_department . '" style="text-decoration: none; color: black; font-size: 0.9rem;">
        ' . $department_name . ' (самооценка = ' . $mark_percent . '%)
        </button>
          <button class="btn-rename" onclick="renameDepartment(' . $id_department . ')">&#9998;</button>
          <span class="delete-icon" onclick="deleteDepartment(' . $id_department . ')">&times;</span>
        </div>

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
        $id_crit = $row_criteria["id_criteria"];
        $field3 = $row_criteria["field3"];
        $field4 = $row_criteria["field4"];
        if ($field4 !== null) {
            $files = explode(";", $field4);
        } else {
            $files = array();
        }
        echo '<tr>
                <td style="border: 1px solid black; text-align: center;">' . $row_criteria["pp"] . '</td>
                <td style="border: 1px solid black; padding: 0.2rem 0.75rem; text-align: left;">' . $row_criteria["name"] . '</td>
                <td style="border: 1px solid black;"><div style="display: flex; justify-content: center;">
                <select onchange="changeField3(' . $id_crit . ', ' . $id_department . ', this)">
                <option ' . (($field3 === '0' || null) ? 'selected' : '') . 'value="null"></option>
                <option ' . ($field3 === '1' ? 'selected' : '') . ' value="1">Да</option>
                <option ' . ($field3 === '2' ? 'selected' : '') . ' value="2">Нет</option>
                <option ' . ($field3 === '3' ? 'selected' : '') . ' value="3">Не требуется</option>
                </select></div></td>
                <td style="border: 1px solid black;"><div id="' . $id_crit . '_' . $id_department . '" style="width: 100%; ">';
        $count = count($files);
        foreach ($files as $key => $file) {
            if ($key < $count - 1) {
                echo '<div class="file-container">';
                echo '<a href="/docs/documents/' . $login . '/' . $id_department . '/' . $file . '">' . $file . '</a>';
                echo '<span class="delete-file" id="delete_'.$id_crit.'_'.$id_department.'_' . $file . '" onclick="z_deleteFile(\'' . $file . '\',' . $id_crit . ',' . $id_department . ')" style="cursor:pointer; padding-left:10px;">×</span>';
                echo '</div>';
            }
        }
        echo '</div><input accept="application/pdf" onchange="addFile(' . $id_crit . ', ' . $id_department . ', this)" type="file"/></td>
                <td style="border: 1px solid black;" contenteditable="true" onblur="changeField5(' . $id_crit . ', ' . $id_department . ', this)">' . $row_criteria["field5"] . '</td>
            </tr>';
    }

    echo '</tbody></table></div></div>';
}

mysqli_close($con);
?>