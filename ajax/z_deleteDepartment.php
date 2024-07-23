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
    $nameMainDep = $row['name'];
    echo $id_list_tables_criteria;
    $query9 = "SELECT * FROM z_selected_tables as zst,  z_list_tables_criteria as zlt 
    WHERE zst.id_list_tables_criteria = zlt.id_list_tables_criteria
    AND zlt.level = 1 and zst.id_list_tables_criteria = '$id_list_tables_criteria' and zst.id_subvision = '$id_sub' ";
    $rez9 = mysqli_query($con, $query9) or die("Ошибка " . mysqli_error($con));
    if (mysqli_num_rows($rez9) > 0) {

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

        $query = "UPDATE  z_selected_tables SET `count`=`count`- 1 
              where id_list_tables_criteria = '$id_list_tables_criteria' and id_subvision = '$id_sub'";
        mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

        mysqli_query($con, "delete from z_department  WHERE id_subvision = '$id_sub' AND id_department = '$id_department'");
    }
    $query = "SELECT * FROM accreditation.z_department zd 
left join subvision zs on zd.id_subvision=zs.id_subvision
left join z_list_tables_criteria zltc on zltc.id_list_tables_criteria=zd.id_list_tables_criteria
where zs.id_subvision = '$id_sub' and zltc.level = 1";
    $rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
    $row = mysqli_fetch_assoc($rez);
    $mainDep = $row['id_department'];

    $mainIdListCrit= $row['id_list_tables_criteria'];
    $querydel = "delete from z_answer_criteria where id_department = '$mainDep' and field5 like '%$nameMainDep%'";
    mysqli_query($con, $querydel) or die("Ошибка ". mysqli_error($con));
}
mysqli_close($con);
?>