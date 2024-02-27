<?php

include "connection.php";

$id_application = $_POST['id_app'];

$query = "delete from applications where id_application = '$id_application'";

$result = mysqli_query($con, $query);

if ($result) {
    echo "success";
} else {
    echo "error";
}
