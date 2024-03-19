<?php
include "connection.php";

    $id_dept = $_POST['id_dept'];
    $checked = $_POST['checked'];

    $query_update = "UPDATE z_department SET accred_svid = '$checked' WHERE id_department = '$id_dept'";
    $result_update = mysqli_query($con, $query_update);

    if ($result_update) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false]);
}
mysqli_close($con);
?>