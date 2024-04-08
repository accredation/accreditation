<?php
include "connection.php";

if ($_POST['dateRegistr'] !== "" && $_POST['countlist'] !== "" && $_POST['tech_osn_rkk'] !== "" && $_POST['stat_rasp'] !== "" && $_POST['ucomp_rkk'] !== ""
    && $_POST['report_samoacred'] !== "" && $_POST['predst_rkk'] !== "" && $_POST['perv_vtor_zayav'] !== "") {
    $dateRegistr = $_POST['dateRegistr'];
    $countlist = $_POST['countlist'];
    $tech_osn_rkk = $_POST['tech_osn_rkk'];
    $stat_rasp = $_POST['stat_rasp'];
    $ucomp_rkk = $_POST['ucomp_rkk'];
    $report_samoacred = $_POST['report_samoacred'];
    $dop_sved = $_POST['dop_sved'];
    $predst_rkk = $_POST['predst_rkk'];
    $perv_vtor_zayav = $_POST['perv_vtor_zayav'];
    $povtor_index = $_POST['povtor_index'];
    $info_napr_zapr = $_POST['info_napr_zapr'];
    $info_sogl = $_POST['info_sogl'];
    $protolol_zasedanie = $_POST['protolol_zasedanie'];
    $date_zasedanie = $_POST['date_zasedanie'];
    $info_vozvrat = $_POST['info_vozvrat'];
    $info_otzyv = $_POST['info_otzyv'];
    $date_admin_resh = $_POST['date_admin_resh'];
    $count_admin_resh = $_POST['count_admin_resh'];
    $resultat = $_POST['resultat'];
    $svidetelstvo = $_POST['svidetelstvo'];
    $date_svidetelstvo = $_POST['date_svidetelstvo'];
    $po_n = $_POST['po_n'];
    $count_svidetelstvo = $_POST['count_svidetelstvo'];
    $info_uved = $_POST['info_uved'];
    $count_medacr = $_POST['count_medacr'];
    $getter = $_POST['getter'];
    $delo = $_POST['delo'];
    $delo_listov = $_POST['delo_listov'];
    $date_delo = $_POST['date_delo'];
    $dop_info = $_POST['dop_info'];
    $id_application = $_POST['id_application'];
    $checkboxValue = $_POST['checkboxValue'];

    $formatted_dateRegistr = date("Y-m-d", strtotime($dateRegistr));
    $formatted_date_zasedanie = date("Y-m-d", strtotime($date_zasedanie));
    $formatted_date_admin_resh = date("Y-m-d", strtotime($date_admin_resh));
    $formatted_date_delo = date("Y-m-d", strtotime($date_delo));
    $formatted_date_svidetelstvo = date("Y-m-d", strtotime($date_svidetelstvo));
    $rez = mysqli_query($con, "select * from rkk where id_application = '$id_application'");
    if (mysqli_num_rows($rez) == 1) {

        mysqli_query($con, "update rkk SET  
date_reg = '$formatted_dateRegistr', 
count_list_app = '$countlist', 
tech_osn = '$tech_osn_rkk', 
raspisanie = '$stat_rasp', 
ucomplect = '$ucomp_rkk', 
report_samoacred = '$report_samoacred', 
dop_sved = '$dop_sved', 
predstavitel = '$predst_rkk', 
perv_vtor = '$perv_vtor_zayav', 
date_index_povt_app = '$povtor_index', 
info_napr_zapr = '$info_napr_zapr', 
info_sogl = '$info_sogl', 
protokol_zased = '$protolol_zasedanie', 
date_protokol = '$formatted_date_zasedanie', 
info_vozvr = '$info_vozvrat', 
info_otzyv = '$info_otzyv', 
date_admin_resh = '$formatted_date_admin_resh', 
count_list_admin = '$count_admin_resh', 
`result` = '$resultat', 
svidetelstvo = '$svidetelstvo', 
date_sved = '$formatted_date_svidetelstvo', 
count_list_sved = '$count_svidetelstvo', 
info_uved = '$info_uved', 
count_list_report_medacr = '$count_medacr', 
getter = '$getter', 
delo = '$delo', 
date_delo = '$formatted_date_delo', 
dop_info = '$dop_info', 
delo_listov = '$delo_listov', 
po_n = '$po_n',
 checkboxValueGuzo = '$checkboxValue'
WHERE id_application = '$id_application';");

        mysqli_query($con, "update rkk SET
 checkboxValueGuzo = '$checkboxValue'
WHERE id_application = '$id_application';");
    } else {
        mysqli_query($con, "insert into rkk (id_application, date_reg, count_list_app,tech_osn, raspisanie, ucomplect, 
                 report_samoacred, dop_sved,		predstavitel,	perv_vtor,	reg_index,	date_index_povt_app,
                 info_napr_zapr,	info_sogl,	protokol_zased,	date_protokol	,info_vozvr,	info_otzyv,
                 admin_resh,	date_admin_resh	,count_list_admin,	`result`,	svidetelstvo,	date_sved	,
                 count_list_sved	,info_uved	,	count_list_report_medacr,	getter	,delo	,date_delo	,dop_info, delo_listov, po_n , checkboxValueGuzo ) 
                            values ('$id_application','$formatted_dateRegistr','$countlist','$tech_osn_rkk','$stat_rasp','$ucomp_rkk','$report_samoacred',
                                    '$dop_sved', '$predst_rkk', '$perv_vtor_zayav', '$povtor_index','$info_napr_zapr','$info_sogl',
                                    '$protolol_zasedanie', '$formatted_date_zasedanie','$info_vozvrat','$info_otzyv','$formatted_date_admin_resh','$count_admin_resh',
                                    '$resultat','$svidetelstvo','$formatted_date_svidetelstvo','$count_svidetelstvo','$info_uved',
                                    '$count_medacr','$getter','$delo','$formatted_date_delo', '$dop_info', '$delo_listov', '$po_n' , '$checkboxValue' )");

        mysqli_query($con, "update rkk SET
 checkboxValueGuzo = '$checkboxValue'
WHERE id_application = '$id_application';");
    }
} else {
    echo "0";
}


?>