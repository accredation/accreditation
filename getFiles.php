<?php
include "connection.php";

$login = $_COOKIE['login'];
$insertquery = "SELECT * FROM users WHERE login='$login'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_user'];
}

$id_application = $_GET['id_application'];

$query = "SELECT count(cell) as kol, cell FROM files where id_user='$id' and id_application='$id_application' group by cell ";
$result=mysqli_query($con, $query) or die ( mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
$i = 0;
$j = 0;
$files = array();
$cells = array();
$cells = array_pad($cells,5,-1);
foreach ($data as $line) {
    $cell = $line['cell'];
    $cells[$cell] = $cell;
}


foreach ($cells as $item) {
    $filesName = array();
        if (-1 == $item) {
            array_push($files,array()); //filesName.push(new Array());

        } else {

            $query1 = "SELECT file FROM files where id_user='$id' and cell='$item' and id_application='$id_application'";
            $result1 = mysqli_query($con, $query1) or die (mysqli_error($con));
            for ($data1 = []; $row1 = mysqli_fetch_assoc($result1); $data1[] = $row1) ;
            foreach ($data1 as $line1) {
                array_push($filesName, $line1['file']);
            }

            array_push($files,$filesName);

        }
        $i++;
    }



echo json_encode($files);

?>