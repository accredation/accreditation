<?php
include "connection.php";

$date_create_filter = isset($_GET['date_create']) ? $_GET['date_create'] : '';
$action_filter = isset($_GET['action']) ? $_GET['action'] : '';
$ip_address_filter = isset($_GET['ip_adress']) ? $_GET['ip_adress'] : '';
$id_user_filter = isset($_GET['id_user']) ? $_GET['id_user'] : '';
$id_application_filter = isset($_GET['id_application']) ? $_GET['id_application'] : '';
$id_subvision_filter = isset($_GET['id_subvision']) ? $_GET['id_subvision'] : '';
$id_department_filter = isset($_GET['id_department']) ? $_GET['id_department'] : '';
$id_answer_criteria_filter = isset($_GET['id_answer_criteria']) ? $_GET['id_answer_criteria'] : '';
$id_crit_filter = isset($_GET['id_crit']) ? $_GET['id_crit'] : '';

$query = "SELECT * FROM Aalog1_actions WHERE 1=1";

if ($date_create_filter) {
    $query .= " AND date_create LIKE '%$date_create_filter%'";
}
if ($action_filter) {
    $query .= " AND action LIKE '%$action_filter%'";
}
if ($ip_address_filter) {
    $query .= " AND ip_adress LIKE '%$ip_address_filter%'";
}
if ($id_user_filter) {
    $query .= " AND id_user LIKE '%$id_user_filter%'";
}
if ($id_application_filter) {
    $query .= " AND id_application LIKE '%$id_application_filter%'";
}
if ($id_subvision_filter) {
    $query .= " AND id_subvision LIKE '%$id_subvision_filter%'";
}
if ($id_department_filter) {
    $query .= " AND id_department LIKE '%$id_department_filter%'";
}
if ($id_answer_criteria_filter) {
    $query .= " AND id_answer_criteria LIKE '%$id_answer_criteria_filter%'";
}
if ($id_crit_filter) {
    $query .= " AND id_crit LIKE '%$id_crit_filter%'";
}

$result = mysqli_query($con, $query);

if (!$result) {
    echo json_encode(['error' => mysqli_error($con)]);
    exit;
}

$data = [];
while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

header('Content-Type: application/json');
echo json_encode($data);
mysqli_close($con);
?>