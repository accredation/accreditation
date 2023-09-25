<?php
header("Content-type: application/json");

include "connection.php";
$app_id = $_GET['app_id'];

$query = " SELECT
    sub.name AS subvision_name,
    c.name AS criteria_name,
    CASE rc.status
        WHEN 1 THEN 'Готово'
        ELSE 'Не готово'
    END AS status_name,
    u.username AS username,
    rc.date_complete
FROM rating_criteria rc
JOIN subvision sub ON rc.id_subvision = sub.id_subvision
LEFT JOIN criteria c ON rc.id_criteria = c.id_criteria
LEFT JOIN users u ON rc.id_otvetstvennogo = u.id_user
WHERE sub.id_application = '$app_id'
AND rc.id_otvetstvennogo IS NOT NULL
AND rc.date_complete IS NOT NULL;";

$result = mysqli_query($con, $query) or die(mysqli_error($con));

$criteriaData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $criteriaData[] = $row;
}

echo json_encode($criteriaData);
?>