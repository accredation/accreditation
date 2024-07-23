<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$login = $_COOKIE['login'];




$query_departments = "SELECT  z_department.* , us.login, a.id_application
FROM z_department 
left outer join subvision s on z_department.id_subvision=s.id_subvision
left outer join applications a on s.id_application=a.id_application
left outer join users us on a.id_user=us.id_uz and us.active=1 and us.id_role=3
WHERE z_department.ID_SUBVISION = '$id_sub'";
$result_departments = mysqli_query($con, $query_departments) or die("Ошибка " . mysqli_error($con));

while ($row_department = mysqli_fetch_assoc($result_departments)) {
    $id_department = $row_department['id_department'];
    $department_name = $row_department['name'];
    $mark_percent = $row_department['mark_percent'];
    $login_name = $row_department['login'];
    $id_app = $row_department['id_application'];
    $readyornot  = $row_department['readyornot'];
    $mark_all = $row_department['mark_all'];
    $mark_yes = $row_department['mark_yes'];
    $mark_not_need = $row_department['mark_not_need'];
    $mark_accred_percent = $row_department['mark_accred_percent'];
    if($mark_percent === null)
        $mark_percent = 0;
    if($mark_accred_percent === '-')
        $mark_accred_percent = '-';
    else
    $mark_accred_percent = round(doubleval($mark_accred_percent),0) . '%';
    echo '<div class="card-header" id="heading' . $id_department . '" style="justify-content: center; display: block; " onclick="newCollapseTable(this)">
       <div class = "actCont" style="display: flex;">
         <div class="actions-container" style = "width: 80%;">
        <button class="btn btn-link" style="width: 100%;color: black;font-size: 14px;font-weight: 700;" data-toggle="collapse"  aria-expanded="false" aria-controls="collapse' . $id_department . '" style="text-decoration: none; color: black; font-size: 0.9rem;">
        ' . $department_name . ' (самоаккредитация = ' . $mark_percent . '%)<div>(оценка соответствия = '.$mark_accred_percent. ')</div>
    </button>
        </div>
       ';
    $query = "SELECT id_role FROM users WHERE users.id_user = '{$_COOKIE['id_user']}'";
    $result = mysqli_query($con, $query) or die (mysqli_error($con));
    if (mysqli_num_rows($result) == 1) //если получена одна строка
    {
        $row = mysqli_fetch_assoc($result);
        if($row['id_role'] == 15){

        }
        else if($row['id_role'] == 14) {
                if($readyornot == '0') {
                    echo '
        <div class ="actions-container3" readyornot="'.$readyornot.'"  style = "width: 30%;"><button  onclick="updateReadyOrNot(' . $id_department . ', 1); event.stopPropagation();" class="ready0" data-id_department="' . $id_department . '">Готово</button>
        </div>';
                }
                else if ($readyornot == '1'){
                    echo '
        <div class ="actions-container3" readyornot="'.$readyornot.'" style = "width: 30%;"><button onclick="updateReadyOrNot(' . $id_department . ', 0); event.stopPropagation();" class="ready1" data-id_department="' . $id_department . '">Редактировать</button>
        </div>';
                }

        } else {
            echo'
        <div class ="actions-container2"  style = "width: 30%;">
        </div>';
        }
    }

    echo'
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
                Наименование критерия
            </td>
            <td style="border: 1px solid black; width: 10%; text-align: left;">
                Сведения по самоаккредитации (да, нет,
не применяется)
            </td>
            <td style="width: 350px; border: 1px solid black;">
                Документы и сведения, на основании которых проведена самоаккредитация
            </td>
            <td style="border: 1px solid black; max-width: 10vw;
  word-wrap: break-word;">
                Примечание
            </td>
            <td style="border: 1px solid black; width: 10%; text-align: left;" >
                Сведения по оценке соответствия критерию (да, нет, не применяется) 
            </td>
            <td style="width: 350px; border: 1px solid black;">
                Документы и сведения, на основании которых проведена оценка соответствия
            </td>
            <td style="border: 1px solid black; max-width: 10vw; word-wrap: break-word;">
                Выявленные несоответствия
            </td>
            
        </tr>
        <tbody>';

    $query_criteria = "SELECT zac.id_answer_criteria, zac.id_criteria, zac.field3, zac.field4, zac.field5, zac.field6, zac.field7, zac.defect, zc.pp, zc.`name`
                        FROM z_answer_criteria AS zac
                        left JOIN z_criteria AS zc ON zac.id_criteria = zc.id_criteria
                        WHERE zac.id_department = '$id_department' order by  CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(zc.pp, '.', 1), '.', -1) AS UNSIGNED), 
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(zc.pp, '.', 2), '.', -1) AS UNSIGNED), 
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(zc.pp, '.', 3), '.', -1) AS UNSIGNED);";
    $result_criteria = mysqli_query($con, $query_criteria) or die("Ошибка " . mysqli_error($con));

    while ($row_criteria = mysqli_fetch_assoc($result_criteria)) {
        $id_crit = $row_criteria["id_criteria"];
        $id_answer_criteria = $row_criteria["id_answer_criteria"];
        $field3 = $row_criteria["field3"];
        $field4 = $row_criteria["field4"];
        if ($field4 !== null) {
            $files = explode(";", $field4);
        } else {
            $files = array();
        }

        $field6 = $row_criteria["field6"];
        $field7 = $row_criteria["field7"];
        $defect = $row_criteria["defect"];

        echo '<tr>
                <td style="border: 1px solid black; text-align: center;">' . $row_criteria["pp"] . '</td>
                <td style="border: 1px solid black; padding: 0.2rem 0.75rem; text-align: left;">' . $row_criteria["name"] . '</td>
                <td style="border: 1px solid black;"><div style="display: flex; justify-content: center;">
                <select disabled="true" id="selpicker" onchange="changeField3(' . $id_answer_criteria . ',' . $id_crit . ', ' . $id_department . ', this)">
                <option ' . (($field3 === '0' || null) ? 'selected' : '') . 'value="0"></option>
                <option ' . ($field3 === '1' ? 'selected' : '') . ' value="1">Да</option>
                <option ' . ($field3 === '2' ? 'selected' : '') . ' value="2">Нет</option>
                <option ' . ($field3 === '3' ? 'selected' : '') . ' value="3">Не применяется</option>
                </select></div></td>
                <td style="border: 1px solid black;"><div id="' . $id_answer_criteria . '" style="width: 350px; ">';
        $count = count($files);
        foreach ($files as $key => $file) {
            if ($key < $count - 1) {
                echo '<div class="file-container" >';
                echo '<a target = "_blank" href="/docs/documents/' . $login_name . '/'.$id_app.'/' . $id_department . '/' . $file . '">' . $file . '</a>';
                echo '</div>';
            }
        }
        echo '</div></td>
                <td style="border: 1px solid black; max-width: 10vw;
  word-wrap: break-word;" >' . $row_criteria["field5"] . '</td>
            ';
        echo '
                
                <td style="border: 1px solid black;"><div style="display: flex; justify-content: center;">
                <select  id="selpickerAccred" onchange="changeField6(' . $id_answer_criteria . ',' . $id_crit . ', ' . $id_department . ', this)">
                <option ' . (($field6 === '0' || null) ? 'selected' : '') . 'value="0"></option>
                <option ' . ($field6 === '1' ? 'selected' : '') . ' value="1">Да</option>
                <option ' . ($field6 === '2' ? 'selected' : '') . ' value="2">Нет</option>
                <option ' . ($field6 === '3' ? 'selected' : '') . ' value="3">Не применяется</option>
                </select></div></td>
                <td style="border: 1px solid black; max-width: 10vw; word-wrap: break-word;" contenteditable="true" id="td7"
                        oninput="changeField7(' . $id_answer_criteria . ',' . $id_crit . ', ' . $id_department . ', this)">' . $field7 . '</td>
                <td style="border: 1px solid black; max-width: 10vw; word-wrap: break-word;" contenteditable="true"  id="tdDef"
                        oninput="changeFieldDefect(' . $id_answer_criteria . ',' . $id_crit . ', ' . $id_department . ', this)">' . $defect . '</td>
                ';


        echo '</tr>';
    }

    echo '</tbody></table></div></div>';
}

mysqli_close($con);
?>