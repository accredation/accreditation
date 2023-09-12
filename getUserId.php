<?php
include "connection.php";
$id_user = $_POST['id_user'];
$result = mysqli_query($con, "SELECT id_role FROM users WHERE id_user='$id_user'");
$row = mysqli_fetch_assoc($result);
$id_role = $row['id_role'];
echo $id_role;
?>