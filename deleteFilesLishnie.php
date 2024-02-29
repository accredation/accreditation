<?php
include 'ajax/connection.php';
$query = "SELECT u.login, a.id_application, zac.id_department, zac.field4, zd.name, zc.pp
FROM users u
LEFT OUTER JOIN applications a ON u.id_user = a.id_user
LEFT OUTER JOIN subvision s ON a.id_application = s.id_application
LEFT OUTER JOIN z_department zd ON s.id_subvision = zd.id_subvision
LEFT OUTER JOIN accreditation.z_answer_criteria zac ON zd.id_department = zac.id_department
LEFT OUTER JOIN z_criteria zc ON zc.id_criteria = zac.id_criteria
WHERE zac.field4 IS NOT NULL;";
$result = mysqli_query($con, $query);
echo "<table border='1'><tbody>";
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $arrFiles = explode(";", $row['field4']);
        $subPath = "/" . $row['login'] . "/" . $row['id_application'] . "/" . $row['id_department'];
        $filePath = 'docs/documents' . $subPath;
        foreach ($arrFiles as $file) {
            $fileName = trim($file); // Удаляем лишние пробелы
            if (!empty($fileName)) {
                $fileFullPath = $filePath . "/" . $fileName;
                if (!file_exists($fileFullPath)) {
                    echo $subPath . " такого файла нет - " . $fileName . "<br>";
                    // Дополнительные действия при несоответствии файла
                    // Например, удаление файла: unlink($fileFullPath);
                }
            }
        }
    }
}
echo "</tbody></table>";
?>