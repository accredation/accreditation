<?php
include "connection.php";
$id_app = $_GET['id_app'];

$query = "SELECT id_rkk FROM rkk WHERE id_application = '$id_app'";
$result = mysqli_query($con, $query);

if (mysqli_num_rows($result) > 0) {
    echo "000";
} else {
    echo "111";
}

mysqli_close($con);
?>