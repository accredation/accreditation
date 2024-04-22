<?php

include "../../ajax/connection.php";
$id_uz_vid_profile = $_GET['id_uz_vid_profile'];
$id_uz = $_GET['id_uz'];


mysqli_query($con, "delete from accreditation.uz_vid_profile where id_uz_vid_profile = '$id_uz_vid_profile'");
mysqli_query($con, "delete from accreditation.uz_profile where id_uz = '$id_uz'");
mysqli_query($con, "delete from accreditation.uz_vid where uz_vid.id_uz = '$id_uz'");
mysqli_close($con);