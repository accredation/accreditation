<?php include "connection.php";

//move_uploaded_file($_FILES["fil"]["tmp_name"],$_FILES["fil"]["name"]);
//
//sleep(2);
//echo "Данные: цифра - ".$_POST['number'];
//    $count = $_POST['number'];
//    for ($i = 0; $i < $count; $i++)
//        move_uploaded_file($_FILES["filPril_" . $i]["tmp_name"], $_FILES["filPril_" . $i]["name"]);
//foreach($_FILES as $file)
//    move_uploaded_file($file["tmp_name"], $file["name"]);

$total_files = $_POST["index"];
echo $total_files;
for($key = 0; $key < $total_files; $key++) {
    if (isset($_FILES['filesPril_'.$key]['name'])) {

                $file_name = $_FILES['filesPril_'.$key]['name'] ;
                $file_tmp = $_FILES['filesPril_'.$key]['tmp_name'];

                move_uploaded_file($file_tmp, "./documents/" . $file_name);

                $insertquery =
                    "INSERT INTO files(`file`) VALUES('$file_name')";

                $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
                if ($result) {
                    header("Location: " . $_SERVER['REQUEST_URI']);
                }
        }
    else{
        echo "zxc";
    }
}
?>