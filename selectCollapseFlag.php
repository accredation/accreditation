<?php
include "connection.php";
$id_criteria = $_GET['id_criteria'];
$id_sub = $_GET['id_sub'];


// Проверка состояния
$result = mysqli_query($con, "SELECT opened FROM rating_criteria WHERE id_subvision = '$id_sub' AND id_criteria = '$id_criteria'");
$row = mysqli_fetch_assoc($result);
if ($row['opened'] == 1) {
    // Колапс уже открыт другим пользователем
    echo "1";

} else {
    // Обновление состояния

    echo "0";

}

?>