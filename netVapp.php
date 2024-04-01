<?php
echo "This functionality has not been used for a long time, so we had to disable it.";
//include 'ajax/connection.php';
//
//$id_app = $_GET['id_app'];
//
//$query = "SELECT u.login, a.id_application, zac.id_department, zac.field4, zd.name, zc.pp
//FROM users u
//LEFT OUTER JOIN applications a ON u.id_user = a.id_user
//LEFT OUTER JOIN subvision s ON a.id_application = s.id_application
//LEFT OUTER JOIN z_department zd ON s.id_subvision = zd.id_subvision
//LEFT OUTER JOIN accreditation.z_answer_criteria zac ON zd.id_department = zac.id_department
//LEFT OUTER JOIN z_criteria zc ON zc.id_criteria = zac.id_criteria
//WHERE a.id_application = '$id_app' AND zac.field4 IS NOT NULL;";
//
//$result = mysqli_query($con, $query);
//$i = 0;
//echo "<table border='1'><tbody>";
//if (mysqli_num_rows($result) > 0) {
//    // output data of each row
//    $i = 0;
//    while ($row = mysqli_fetch_assoc($result)) {
//        $arrFiles = explode(";", $row['field4']);
//        $tmpName = "";
//        $tmpPp = "";
//        foreach ($arrFiles as $file) {
//            if ($file != '') {
//
//
//                $subPath = "/" . $row['login'] . "/" . $row['id_application'] . "/" . $row['id_department'] . "/" . $file;
//                $filePath = 'docs/documents' . $subPath;
//$i++;
//                if (file_exists($filePath)) {
//                    echo "";
//                } else {
//                    if ($tmpName != $row['name']) {
//                        echo "<tr><td>" . $row['name'] . "</td></tr>";
//                    }
//                    if ($tmpPp != $row['pp']) {
//                        echo "<tr><td>" . $row['pp'] . "</td></tr>";
//                    }
//                    echo "<tr><td>".$file."</td><td>Файл не существует</td></tr>";
//                    $tmpName = $row['name'];
//                    $tmpPp = $row['pp'];
////                    echo $filePath . "<br/> Файл не существует.<br/>";
//                }
//
//            }
//        }
//    }
//}
//echo "</tbody></table>";
//echo "Общее количество файлов: " . $i;