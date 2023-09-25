<?php
header("Content-type: application/json");

include "connection.php";
    $app_id = $_GET['app_id'];

    $query = "SELECT
    COALESCE(app.date_send, '') AS date_send,
    COALESCE(app.date_accept, '') AS date_accept,
    COALESCE(app.date_complete, '') AS date_complete,
    COALESCE(app.date_council, '') AS date_council
FROM applications as app
WHERE app.id_application = '$app_id';";
    $result = mysqli_query($con, $query) or die (mysqli_error($con));

    $historyData = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $historyData[] = $row;
    }

    echo json_encode($historyData);

?>