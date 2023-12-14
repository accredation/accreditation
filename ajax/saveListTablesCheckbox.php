<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_list_tables_criteria = $_GET['id_list_tables_criteria'];
$check = $_GET['check'];

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
        $id_dep = $row3['id_department'];

        $query5 = "SELECT id_criteria, pp, z_criteria.`name` FROM z_criteria WHERE id_list_tables_criteria = '$id_list_tables_criteria'";
        $rez5 = mysqli_query($con, $query5) or die("Ошибка " . mysqli_error($con));

        while ($row5 = mysqli_fetch_assoc($rez5)) {
            $id_crit = $row5['id_criteria'];
            $query4 = "INSERT INTO z_answer_criteria (id_department, id_criteria) 
                       SELECT '$id_dep', '$id_crit'
                       WHERE NOT EXISTS (
                           SELECT 1
                           FROM z_answer_criteria
                           WHERE id_department = '$id_dep'
                           AND id_criteria = '$id_crit'
                       )";
            mysqli_query($con, $query4) or die("Ошибка " . mysqli_error($con));
        }
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
        </tr><tbody>';

    $query1 = "SELECT id_criteria, pp, z_criteria.`name` FROM z_criteria WHERE id_list_tables_criteria = '$id_list_tables_criteria'";
    $rez1 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));

    while ($row1 = mysqli_fetch_assoc($rez1)) {
        echo '<tr ><td style="border: 1px solid black; text-align: center;">'.$row1["pp"].'</td>
                <td style="border: 1px solid black; padding: 0.2rem 0.75rem; text-align: left;">'.$row1["name"].'</td>
                <td style="border: 1px solid black;"><div style="display: flex; justify-content: center;"><select ><option value="null"></option><option value="1">Да</option><option value="2">Нет</option><option value="3">Не требуется</option></select></div></td>
                <td style="border: 1px solid black;"><div style="height: 15rem;"><textarea style="width: 100%; height: 100%;"></textarea></div></td>
                <td style="border: 1px solid black;"><div style="height: 15rem;"><textarea rows="3" style="width: 100%; height: 100%;"></textarea></div></td>
                </tr>';
    }

    echo '</tbody></table></div></div>';
}

?>