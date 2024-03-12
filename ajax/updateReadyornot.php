<?php
include "connection.php";

    $id_department = $_POST['id_department'];
    $value = $_POST['value'];

    $query_update = "UPDATE z_department SET readyornot = '$value' WHERE id_department = '$id_department'";
    $result_update = mysqli_query($con, $query_update);

    if ($result_update) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false]);
}
mysqli_close($con);
?>