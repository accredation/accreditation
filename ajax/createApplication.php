<?php
include "connection.php";
$login = $_COOKIE['login'];


$insertquery = "SELECT uz.id_uz, uz.username  FROM accreditation.uz left outer join accreditation.users us on uz.id_uz = us.id_uz WHERE login='$login'";

$rez = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));

if (mysqli_num_rows($rez) == 1) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);
    $id = $row['id_uz'];
    $name = $row['username'];
}
$query = "Select count(id_application) as count_str from applications where id_user = '$id' and id_status not in (7,8)";
$rez1 = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));


if (mysqli_num_rows($rez1) == 1) {
    $row1 = mysqli_fetch_assoc($rez1);
    $count_str = $row1['count_str'];

    if ($count_str == "0") {
            mysqli_query($con, "Insert into applications(`id_user`, `id_status`, `naim`, `date_create_app`) values ('$id', 1, '$name', CURDATE())");
    }
    else{
        $query1 = "Select * from applications where id_user = '$id' and (id_status = 9 or id_status = 6)"; // and pervtor = 1
        $rez2 = mysqli_query($con, $query1) or die("Ошибка " . mysqli_error($con));
        if (mysqli_num_rows($rez2) > 0) {
            $row = mysqli_fetch_assoc($rez2);
            $id_rkk = $row['id_rkk'];
            $id_old_app = $row['id_application'];

            $sokr = $row['sokr_naim'];
            $unp = $row['unp'];
            $ur_adress = $row['ur_adress'];
            $fact_adress = $row['fact_adress'];
            $tel = $row['tel'];
            $email = $row['email'];
            $rukovoditel = $row['rukovoditel'];
            $predstavitel = $row['predstavitel'];
            $soprovod_pismo = $row['soprovod_pismo'];
            $copy_rasp = $row['copy_rasp'];
            $org_structure = $row['org_structure'];
            $ucomplect = $row['ucomplect'];
            $tech_osn = $row['tech_osn'];
            $report = $row['fileReport'];
            $reportSamoocenka = $row['fileReportSamoocenka'];
            $infDorabotkiFile = $row['infDorabotkiFile'];
            $mark_percent = $row['mark_percent'];
            $doverennost = $row['doverennost'];
            $zakluchenieSootvetstviya = $row['zakluchenieSootvetstviya'];
            $prikazNaznach = $row['prikazNaznach'];
            $selected_lico_value = $row['selected_lico_value'];
            mysqli_query($con, "Insert into applications(`id_user`, `id_status`, `naim`, `date_create_app`, pervtor, id_rkk_perv,
                         sokr_naim, unp, ur_adress, fact_adress, tel, email, rukovoditel,predstavitel,soprovod_pismo, copy_rasp, org_structure, ucomplect,
                         tech_osn, fileReport, fileReportSamoocenka, infDorabotkiFile, doverennost, zakluchenieSootvetstviya, prikazNaznach, 
                         selected_lico_value, id_old_app) values ('$id', 1, '$name', CURDATE(), 2, '$id_rkk', '$sokr', '$unp', '$ur_adress', '$fact_adress','$tel', '$email', '$rukovoditel',
                                                      '$predstavitel', '$soprovod_pismo', '$copy_rasp', '$org_structure', '$ucomplect', '$tech_osn',
                                                      '$report', '$reportSamoocenka', '$infDorabotkiFile', '$doverennost', '$zakluchenieSootvetstviya',
                                                      '$prikazNaznach', '$selected_lico_value', $id_old_app)");
        }
    }
//        mysqli_query($con, "Insert into subvision(`name`,`id_application`)  select '$name', id_application from applications where id_user='$id' and id_status=1");


}
?>