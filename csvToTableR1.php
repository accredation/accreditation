
<?php
include "ajax/connection.php";

$input_file = fopen("csv/r26.txt", "r");
$output_file = fopen("csv/r26.csv", "w");

if ($input_file && $output_file) {
    while (($line = fgets($input_file)) !== false) {
        $line = preg_replace('/\s+/', ';', $line, 1);
        fwrite($output_file, $line);
    }
    fclose($input_file);
    fclose($output_file);

} else {
    echo "хуй";
}

$row = 1;
if (($handle = fopen("csv/r26.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1500,';')) !== FALSE) {

        echo $data[0] . "   " . $data[1] . "<br>";
        $insertquery = "INSERT INTO `z_criteria`(`pp`,
                                     `name`, `id_list_tables_criteria`)
                                     VALUES ('{$data[0]}', '{$data[1]}', '26')";
        $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));
    }
    echo "се ок";
    fclose($handle);
}
?>

