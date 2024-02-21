<?php
include "connection.php";
$id_app = $_GET['id_app'];

$query = "SELECT id_rkk FROM applications WHERE id_application = '$id_app'";
$result = mysqli_query($con, $query);

if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_array($result);
    $rkk = $row['id_rkk'];
    if ($rkk !== "0")
        echo "000";
    else
        echo "111";
}

mysqli_close($con);
?>