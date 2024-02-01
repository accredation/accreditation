
<?php
include "ajax/connection.php";

$input_file = fopen("csv/rr1.txt", "r");
$output_file = fopen("csv/rr1.csv", "w");

if ($input_file && $output_file) {
    while (($line = fgets($input_file)) !== false) {
    //    $line = preg_replace('/\s+/', ';', $line, 1);
        fwrite($output_file, $line);
    }
    fclose($input_file);
    fclose($output_file);

} else {
    echo "хуй";
}

$row = 1;
if (($handle = fopen("csv/rr1.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1500,';')) !== FALSE) {

        echo $data[0] . "   " . $data[1] . "<br>";
        $insertquery = "INSERT INTO `new_table111`(`id_uz`,
                                     `username`)
                                     VALUES ('{$data[0]}', '{$data[1]}')";
        $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
    }
    echo "се ок";
    fclose($handle);
}
?>

Государственное учреждение здравоохранения «Гродненский областной специализированный дом ребенка для детей с органическим поражением центральной нервной системы и нарушением психики»

