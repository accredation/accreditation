<?php
include "../ajax/connection.php";
if (isset($_COOKIE['login'])) {
    echo "
<style>
td{
text-align: center;
}
</style>
<table border='1'>
<thead>
<tr>
    <td>Заявление</td>
    <td>Статус</td>
</tr>
</thead>
<tbody>";
    $query = "select id_application, a.id_status, name_status_report from applications a left join status s on a.id_status=s.id_status";
    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
    while ($row = mysqli_fetch_assoc($rez)) {
        echo "<tr>";
        echo "<td>" . $row['id_application'] . "</td>";
        echo "<td><select id='app" . $row['id_application'] . "'  onchange='changeStatus(this)'>";

        $status_query = "SELECT * FROM status";
        $status_result = mysqli_query($con, $status_query);

        while ($status_row = mysqli_fetch_assoc($status_result)) {
            $selected = ($row['id_status'] == $status_row['id_status']) ? "selected" : "";
            echo "<option value='" . $status_row['id_status'] . "' " . $selected . ">" . $status_row['name_status_report'] . "</option>";
        }

        echo "</select></td>";
        echo "</tr>";
    }
    echo "</tbody>
</table>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script >
let originalValue;
function changeStatus(select) {
    originalValue = select.options[select.selectedIndex].value;
    if(confirm('Вы точно хотите поменять статус этому заявлению?')){
    let val = select.options[select.selectedIndex].value;
    $.ajax({
        url: '../ajax/changeStatusSupport.php',
        method: 'POST',
        data: {
            id_app: select.id.substring(3),
            id_status: val
        }
    }).then(() => {
        alert('Status changed');
    })
    }else {
        location.reload();
        return false;
        
    }
}
</script>";
} else {
    echo "Вам недоступна эта страница";
}