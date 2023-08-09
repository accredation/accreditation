<?php
include "connection.php";

$id_application = $_GET['id_application'];

$rez = mysqli_query($con, "SELECT count(*) as cou
FROM subvision sub
left outer join rating_criteria rc on sub.id_subvision=rc.id_subvision
wHERE sub.id_application='$id_application'
and rc.id_rating_criteria is null");

$row = mysqli_fetch_assoc($rez);

if (mysqli_num_rows($rez) == 1){
    $check = $row['cou'];
}
echo $check;
?>