<?php
include "connection.php";

/*$query = "select id_subvision, name from subvision s
left join applications a on a.id_application=s.id_application where a.id_application = 807;";*/


$query = "select id_application from applications a where id_status in (1,2,3,4)";
$result = mysqli_query($con, $query);
while ($row = mysqli_fetch_assoc($result)) {
    $id_app = $row['id_application'];

    $query0 = "select id_subvision from subvision s where s.id_application = '$id_app'";
    $result0 = mysqli_query($con, $query0);
    while ($row0 = mysqli_fetch_assoc($result0)) {
        $id_sub = $row0['id_subvision'];

        $query1 = "select id_department, zd.name from z_department zd
left join subvision s on s.id_subvision=zd.id_subvision
left join z_list_tables_criteria zltc on zltc.id_list_tables_criteria = zd.id_list_tables_criteria
where s.id_subvision = '$id_sub' and zltc.level = 2 and zltc.id_list_tables_criteria not in (5,6,10,47)";
        $result1 = mysqli_query($con, $query1);

        $query2 = "select zc.id_criteria , zd.id_department, zd.name from z_department zd
left join z_list_tables_criteria zltc on zltc.id_list_tables_criteria = zd.id_list_tables_criteria
left join z_criteria zc on zltc.id_list_tables_criteria = zc.id_list_tables_criteria
left join subvision s on s.id_subvision = zd.id_subvision
where zc.name like '%Укомплектованность%'  and zltc.level = 1 and zd.id_subvision = '$id_sub'; ";


        $i = 1;
        while ($row1 = mysqli_fetch_assoc($result1)) {
            echo "номер: " . $i++ . "<br>";
//    $id_dep = $row['id_department'];
            $result2 = mysqli_query($con, $query2);
            while ($row2 = mysqli_fetch_assoc($result2)) {
                echo "crit: " . $row2['id_criteria'] . "<br>";
                $id_dep = $row2['id_department'];
                $id_criteria = $row2['id_criteria'];
                $dep_name = $row1['name'];
                $query3 = "INSERT INTO z_answer_criteria (id_criteria, id_department, field5) VALUES ('$id_criteria', '$id_dep', '$dep_name')";
                mysqli_query($con, $query3) or die("Ошибка " . mysqli_error($con));

//        echo "crit: ".$id_criteria;
            }
        }
    }
}