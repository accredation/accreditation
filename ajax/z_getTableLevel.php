<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_department = $_GET['id_department'];

$query = "SELECT * FROM z_list_tables_criteria as zlt , z_department as zd WHERE zlt.id_list_tables_criteria = zd.id_list_tables_criteria and zd.id_department = '$id_department';";
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


if (mysqli_num_rows($rez) > 0) {
    $row = mysqli_fetch_assoc($rez);
    $level = $row['level'];
    $id_list_tables_criteria = $row['id_list_tables_criteria'];
    $response = array(
        'level' => $level,
        'id_list_tables_criteria' => $id_list_tables_criteria
    );
    echo json_encode($response);
} else {
    echo 'no data';
}

mysqli_close($con);
?>