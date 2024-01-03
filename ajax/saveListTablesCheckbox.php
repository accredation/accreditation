<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_list_tables_criteria = $_GET['id_list_tables_criteria'];
$check = $_GET['check'];
$login = $_COOKIE['login'];

$query = "SELECT * FROM z_selected_tables WHERE id_list_tables_criteria ='$id_list_tables_criteria' AND id_subvision = '$id_sub'";
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) > 0) {
    $query = "UPDATE z_selected_tables SET id_list_tables_criteria ='$id_list_tables_criteria', id_subvision = '$id_sub', `count`='$check' WHERE id_list_tables_criteria ='$id_list_tables_criteria' AND id_subvision = '$id_sub'";
    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
} else {
    $query = "INSERT INTO z_selected_tables (id_list_tables_criteria, id_subvision, `count`) VALUES ('$id_list_tables_criteria', '$id_sub', '$check')";
    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
}

$rez = mysqli_query($con, "SELECT `name` FROM z_list_tables_criteria WHERE id_list_tables_criteria ='$id_list_tables_criteria'");
if (mysqli_num_rows($rez) == 1) {
    $row = mysqli_fetch_assoc($rez);
    $name = $row['name'];

    $query2 = "INSERT INTO z_department (id_list_tables_criteria, `name`, id_subvision) VALUES ('$id_list_tables_criteria', '$name', '$id_sub') 
               ON DUPLICATE KEY UPDATE `name` = '$name'";
    $rez2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));

    $query3 = "SELECT * FROM z_department WHERE z_department.id_list_tables_criteria ='$id_list_tables_criteria' AND id_subvision = '$id_sub'";
    $rez3 = mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));

    if (mysqli_num_rows($rez3) == 1) {
        $row3 = mysqli_fetch_assoc($rez3);
        $id_department = $row3['id_department'];

        $query5 = "SELECT id_criteria, pp, z_criteria.`name` FROM z_criteria WHERE id_list_tables_criteria = '$id_list_tables_criteria'";
        $rez5 = mysqli_query($con, $query5) or die("Ошибка " . mysqli_error($con));

        while ($row5 = mysqli_fetch_assoc($rez5)) {
            $id_crit = $row5['id_criteria'];
            $query4 = "INSERT INTO z_answer_criteria (id_department, id_criteria) 
                       SELECT '$id_department', '$id_crit'
                       WHERE NOT EXISTS (
                           SELECT 1
                           FROM z_answer_criteria
                           WHERE id_department = '$id_department'
                           AND id_criteria = '$id_crit'
                       )";
            mysqli_query($con, $query4) or die("Ошибка " . mysqli_error($con));
        }
    }

    echo '<div class="card-header" id="heading' . $id_department . '" style="justify-content: center; display: inline-grid; " onclick="newCollapseTable(this)">
          <div class = "actCont" style="display: flex;">
         <div class="actions-container" style = "width: 70%;">
    <button class="btn btn-link" data-toggle="collapse"  aria-expanded="false" aria-controls="collapse' . $id_list_tables_criteria . '" style="text-decoration: none; color: black; font-size: 0.9rem;">
    ' . $name . '
    </button>
     </div>
        ';
$query = "SELECT id_role FROM users WHERE users.id_user = '{$_COOKIE['id_user']}'";
$result = mysqli_query($con, $query) or die (mysqli_error($con));
if (mysqli_num_rows($result) == 1) //если получена одна строка
{
$row = mysqli_fetch_assoc($result);
if($row['id_role'] == 15){  }

       else {
           echo'
        <div class ="actions-container2"  style = "width: 30%;">
          <button class="btn-rename" onclick="renameDepartment(' . $id_department . ')">&#9998;</button>
          <button class="delete-icon" onclick="deleteDepartment(' . $id_department . ')">&times;</button>
        </div>';
           }
       }

    echo' </div>
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
        </tr><tbody>';

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
                <td style="border: 1px solid black;"><div id="' . $id_crit . '_' . $id_department . '" style="width: 350px; ">';
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

?>