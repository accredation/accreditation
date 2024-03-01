<?php
include 'ajax/connection.php';


$query = "SELECT u.login, a.id_application, zac.id_department, zac.field4, zd.name, zc.pp, zac.id_criteria
FROM users u
LEFT OUTER JOIN applications a ON u.id_user = a.id_user
LEFT OUTER JOIN subvision s ON a.id_application = s.id_application
LEFT OUTER JOIN z_department zd ON s.id_subvision = zd.id_subvision
LEFT OUTER JOIN accreditation.z_answer_criteria zac ON zd.id_department = zac.id_department
LEFT OUTER JOIN z_criteria zc ON zc.id_criteria = zac.id_criteria
WHERE zac.field4 IS NOT NULL;";
$result = mysqli_query($con, $query);


$uniquePaths = [];

while ($row = mysqli_fetch_assoc($result)) {
    $subPath = "/" . $row['login'] . "/" . $row['id_application'] . "/" . $row['id_department'];
    $directory = 'docs/documents' . $subPath;
    if (!in_array($subPath, $uniquePaths)) {
        $uniquePaths[] = $subPath;
        $files = scandir($directory);
        $filesFromDB = explode(";", $row['field4']);
        $extraFiles = array_diff($files, $filesFromDB);

//        foreach ($extraFiles as $extraFile) {
//            if ($extraFile !== '..' && $extraFile !== '.') {
//                echo "Extra file $extraFile at path $directory<br>";
//            }
//        }
    }
    else{
        $uniquePaths[] = $subPath;
        $files = scandir($directory);
        $filesFromDB = explode(";", $row['field4']);
        $extraFiles = array_diff($files, $filesFromDB);
        foreach ($extraFiles as $extraFile) {
            if ($extraFile !== '..' && $extraFile !== '.') {
                echo "Extra file $extraFile at path $directory<br>";
            }
        }
    }
}

echo "</tbody></table>";
?>