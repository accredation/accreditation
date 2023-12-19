<?php
include "connection.php";
$id_sub = $_GET['id_sub'];
$id_department = $_GET['id_department'];

$query = "SELECT * from z_department where id_department = '$id_department' and id_subvision = '$id_sub' ";
$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


if (mysqli_num_rows($rez) > 0)
{
    $row = mysqli_fetch_assoc($rez);
    $id_list_tables_criteria = $row['id_list_tables_criteria'];

    $query9 = "SELECT * FROM z_selected_tables as zst,  z_list_tables_criteria as zlt 
    WHERE zst.id_list_tables_criteria = zlt.id_list_tables_criteria
    AND zlt.level = 1 and zst.id_list_tables_criteria = '$id_list_tables_criteria' and zst.id_subvision = '$id_sub' ";
    $rez9 = mysqli_query($con, $query9) or die("Ошибка " . mysqli_error($con));
    if (mysqli_num_rows($rez9) > 0) {
echo "xuy";
        $query = "delete from  z_selected_tables 
              where id_list_tables_criteria = '$id_list_tables_criteria' 
                and id_subvision = '$id_sub'";
        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

        $query2 = "delete from  z_department
              where id_subvision = '$id_sub'";
        $rez2 = mysqli_query($con, $query2) or die("Ошибка " . mysqli_error($con));

        $query = "UPDATE  z_selected_tables SET `count`= 0
              where id_subvision = '$id_sub'";
        $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
    }
    else {
        echo "pizda";
        $query = "UPDATE  z_selected_tables SET `count`=`count`- 1 
              where id_list_tables_criteria = '$id_list_tables_criteria' and id_subvision = '$id_sub'";
        mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

        mysqli_query($con, "delete from z_department  WHERE id_subvision = '$id_sub' AND id_department = '$id_department'");
    }
}
mysqli_close($con);
?>