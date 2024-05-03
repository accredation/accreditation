<?php
include "connection.php";

$id_application = $_GET['id_application'];
$rez = mysqli_query($con, "select sum(dep.mark_accred_percent) as su, count(dep.mark_accred_percent) as coun from z_department as dep 
    left outer join subvision s on dep.id_subvision = s.id_subvision
    left outer join applications a on s.id_application = a.id_application
    where a.id_application = '$id_application'");

if (mysqli_num_rows($rez) >0) //если получена одна строка
{
    $row = mysqli_fetch_assoc($rez); //она
    $count_all = $row['coun'];
    $sum = $row['su'];
    if($count_all === null || $count_all === "0"){
        $reez = 0.0;
    }else{
        $reez = $sum / $count_all;
    }
    $reez  = round($reez,0);
    mysqli_query($con, "update applications set mark_accred_percent = '$reez' where id_application='$id_application'");
}




$query = "SELECT * FROM applications, users WHERE id_application='$id_application' and applications.id_user=users.id_user ";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$data = array();
$cells = array();
if (mysqli_num_rows($rez) >0) //если нашлась одна строка, значит такой юзер существует в базе данных
{
    $row = mysqli_fetch_assoc($rez);

    $naim = $row['naim'];
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
    $login = $row['login'];
    $report = $row['fileReport'];
    $reportSamoocenka = $row['fileReportSamoocenka'];
    $infDorabotkiFile = $row['infDorabotkiFile'];
    $dateInputDorabotki = $row['dateInputDorabotki'];
    $mark_percent = $row['mark_percent'];
    $doverennost = $row['doverennost'];
    $zakluchenieSootvetstviya = $row['zakluchenieSootvetstviya'];
    $prikazNaznach = $row['prikazNaznach'];
    $selected_lico_value = $row['selected_lico_value'];
    $mark_accred_percent = $row['mark_accred_percent'];
    $id_rkk = $row['id_rkk'];
    $response['id_rkk'] = $row['id_rkk'];
    $protokolKom = $row['protokolKom'];
    $adminResh = $row['adminResh'];
    $sootvetstvie  = $row['sootvetstvie'];
    $dateKom  = $row['date_council'];
    $plandenostatkov  = $row['plandenostatkov'];
    $plandatanedostatkov  = $row['plandatanedostatkov'];
    $zayav_otzyv  = $row['zayav_otzyv'];
    $data_zayav_otzyv  = $row['data_zayav_otzyv'];
    $data_zakluchenia  = $row['data_zakluchenia'];



}

array_push($cells,$naim);
array_push($cells,$sokr);
array_push($cells,$unp);
array_push($cells,$ur_adress);
array_push($cells,$tel);
array_push($cells,$email);
array_push($cells,$rukovoditel);
array_push($cells,$predstavitel);
array_push($cells,$soprovod_pismo);
array_push($cells,$copy_rasp);
array_push($cells,$org_structure);
array_push($cells,$ucomplect);
array_push($cells,$tech_osn);
array_push($cells,$login);
array_push($cells,$report);
array_push($cells,$reportSamoocenka);
array_push($cells,$infDorabotkiFile);
array_push($cells,$dateInputDorabotki);
array_push($cells,$fact_adress);
array_push($cells,$doverennost);
array_push($cells,$zakluchenieSootvetstviya);
array_push($cells,$prikazNaznach);
array_push($cells,$selected_lico_value);
array_push($cells,$protokolKom);//23
array_push($cells,$adminResh);//24
array_push($cells,$sootvetstvie);//25
array_push($cells,$dateKom);//26
array_push($cells,$plandenostatkov); //27
array_push($cells,$plandatanedostatkov); //28
array_push($cells,$zayav_otzyv); //29
array_push($cells,$data_zayav_otzyv); //30
array_push($cells,$data_zakluchenia); //31


$query = "SELECT * FROM subvision WHERE id_application = '$id_application'";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));

$subvis_names = array();
for ($names = []; $row = mysqli_fetch_assoc($rez); $names[] = $row);
foreach ($names as $name) {
    $subvis_obj = array();
    array_push($subvis_obj,$name['id_subvision']);
    array_push($subvis_obj,$name['name']);
    array_push($subvis_names,$subvis_obj);
}

array_push($data,$cells);
array_push($data,$subvis_names);
array_push($data,$mark_percent);
array_push($data,$mark_accred_percent);
array_push($data,$response['id_rkk']);
echo json_encode($data);


mysqli_close($con);
?>