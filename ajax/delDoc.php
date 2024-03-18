<?php

include "connection.php";
$idDoc = $_POST['idDoc'];

mysqli_query($con, "delete from `documents` where document_id = '$idDoc'");