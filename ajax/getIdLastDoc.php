<?php

include "connection.php";

$result1 = mysqli_query($con, "SELECT document_id FROM documents ORDER BY document_id DESC LIMIT 1");


$row = mysqli_fetch_assoc($result1);
$lastInsertedId = $row['document_id'];
echo $lastInsertedId;
