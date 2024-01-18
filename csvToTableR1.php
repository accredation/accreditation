
<?php
include "ajax/connection.php";

$row = 1;
if (($handle = fopen("csv/r1.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1500, ";")) !== FALSE) {
        $num = count($data);
        $row++;
        $insertquery = "INSERT INTO `z_criteria`(`pp`,
                                     `name`, `id_list_tables_criteria`)
                                     VALUES ('{$data[0]}', '{$data[1]}', '1')";
        $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
    }
    echo "се ок";
    fclose($handle);
}
?>

