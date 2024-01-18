
<?php
$host = 'localhost';
$user = 'f0770416_database';
$password = 'root';
$database = 'f0770416_database';
$link = mysqli_connect($host, $user, $password, $database) or die ("Ошибка подключения " . mysqli_error($link));


$row = 1;
if (($handle = fopen("archive_common-question.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        $num = count($data);
        echo "<p> $num полей в строке $row: <br /></p>\n";
        $row++;
        $insertquery = "INSERT INTO `archive_common-question`(`id_akt`,
                                     `num_akt`, `name`, `date_prik`, `type`, `file`, `url`)
                                     VALUES ('{$data[0]}', '{$data[1]}', '{$data[2]}', '{$data[3]}',
                                       '{$data[4]}', '{$data[5]}', '/index.php?common-question')";

        $result = mysqli_query($link, $insertquery) or die("Ошибка " . mysqli_error($link));

    }
    echo "се ок";
    fclose($handle);
}
?>

