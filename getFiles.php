
<?php
//move_uploaded_file($_FILES["fil"]["tmp_name"],$_FILES["fil"]["name"]);
//
//if(isset($_GET['count'])) {
//    $count = $_GET['count'];
//    for ($i = 0; $i < $count; $i++)
//        move_uploaded_file($_FILES["filPril_" . $i]["tmp_name"], $_FILES["filPril_" . $i]["name"]);
//}

if($_POST['distance'])
echo $_POST['distance'];
else
    echo "xyu";

?>