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



$query = "SELECT count(cell) as kol, cell FROM files where id_user='$id' group by cell ";
$result=mysqli_query($con, $query) or die ( mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
$i = 0;
foreach ($data as $line) {
    $cell = $line['cell'];

    $filesName = array();

    while($i < 5) {
        if ($i != $cell) {
            echo 'filesName.push(new Array());';

        } else {
            $query1 = "SELECT file FROM files where id_user='$id' and cell='$cell'";
            $result1 = mysqli_query($con, $query1) or die (mysqli_error($con));
            for ($data1 = []; $row1 = mysqli_fetch_assoc($result1); $data1[] = $row1) ;
            foreach ($data1 as $line1) {
                array_push($filesName, $line1['file']);
            }

            echo 'filesName.push(' . json_encode($filesName) . ');';

        }
        $i++;
    }

}


?>