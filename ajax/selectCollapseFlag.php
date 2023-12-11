<?php
include "connection.php";
$id_criteria = $_GET['id_criteria'];
$id_sub = $_GET['id_sub'];


// Проверка состояния
$result = mysqli_query($con, "SELECT opened FROM rating_criteria WHERE id_subvision = '$id_sub' AND id_criteria = '$id_criteria'");
$row = mysqli_fetch_assoc($result);

if (($row['opened'] === "0" ) || ($row['opened'] === null)) {
    //свободен
    echo "0";

} else if ($_COOKIE["PHPSESSID"] === $row['opened']){
    //открыто тобой

    echo "0";

}
else{
    //открыт другим
    echo "1";
}

?>