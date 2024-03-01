<?php
if (isset($_GET['file_name']) && isset($_GET['id_criteria']) && isset($_GET['id_department'])) {
    include "connection.php";

    $fileName = $_GET['file_name'];
    $id_application = $_GET['id_application'];
    $idCrit = $_GET['id_criteria'];
    $idDepartment = $_GET['id_department'];
    $login  =$_COOKIE["login"];
    $fileName = mysqli_real_escape_string($con, $fileName);
    $idCrit = (int)$idCrit;
    $idDepartment = (int)$idDepartment;
    $query = "SELECT field4 FROM z_answer_criteria WHERE id_criteria = '$idCrit' AND id_department = '$idDepartment'";
    $result = mysqli_query($con, $query);
    $row = mysqli_fetch_assoc($result);
    $filesString = $row['field4'];
    $filesArray = explode(';', $filesString);
//    if(file_exists("../docs/documents/".$login. "/".$id_application. "/". $idDepartment. "/" . $fileName))
//        unlink("../docs/documents/".$login. "/".$id_application. "/". $idDepartment. "/" . $fileName);
    if (($key = array_search($fileName, $filesArray)) !== false) {
        unset($filesArray[$key]);
    }
    $newFilesString = implode(';', $filesArray);
    $updateQuery = "UPDATE z_answer_criteria SET field4 = '$newFilesString' WHERE id_criteria = '$idCrit' AND id_department = '$idDepartment'";
    $updateResult = mysqli_query($con, $updateQuery);
    if ($updateResult) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false]);
    }
    mysqli_close($con);
}
?>