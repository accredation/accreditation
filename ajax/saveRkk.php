<?php
include "connection.php";

$dateRegistr = $_POST['dateRegistr'];
$countlist = $_POST['countlist'];
$tech_osn_rkk = $_POST['tech_osn_rkk'];
$stat_rasp = $_POST['stat_rasp'];
$ucomp_rkk = $_POST['ucomp_rkk'];
$report_samoacred = $_POST['report_samoacred'];
$dop_sved = $_POST['dop_sved'];
$prinyal_zayav = $_POST['prinyal_zayav'];
$predst_rkk = $_POST['predst_rkk'];
$perv_vtor_zayav = $_POST['perv_vtor_zayav'];
$reg_index = $_POST['reg_index'];
$povtor_index = $_POST['povtor_index'];
$info_napr_zapr = $_POST['info_napr_zapr'];
$info_sogl = $_POST['info_sogl'];
$protolol_zasedanie = $_POST['protolol_zasedanie'];
$date_zasedanie = $_POST['date_zasedanie'];
$info_vozvrat = $_POST['info_vozvrat'];
$info_otzyv = $_POST['info_otzyv'];
$admin_resh = $_POST['admin_resh'];
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

$rez = mysqli_query($con, "select * from rkk where id_application = '$id_application'");
if (mysqli_num_rows($rez) == 1) {
    mysqli_query($con, "update rkk SET  
date_reg = '$dateRegistr', 
count_list_app = '$countlist', 
tech_osn = '$tech_osn_rkk', 
raspisanie = '$stat_rasp', 
ucomplect = '$ucomp_rkk', 
report_samoacred = '$report_samoacred', 
dop_sved = '$dop_sved', 
id_user = '$prinyal_zayav', 
predstavitel = '$predst_rkk', 
perv_vtor = '$perv_vtor_zayav', 
reg_index = '$reg_index', 
date_index_povt_app = '$povtor_index', 
info_napr_zapr = '$info_napr_zapr', 
info_sogl = '$info_sogl', 
protokol_zased = '$protolol_zasedanie', 
date_protokol = '$date_zasedanie', 
info_vozvr = '$info_vozvrat', 
info_otzyv = '$info_otzyv', 
admin_resh = '$admin_resh', 
date_admin_resh = '$date_admin_resh', 
count_list_admin = '$count_admin_resh', 
`result` = '$resultat', 
svidetelstvo = '$svidetelstvo', 
date_sved = '$date_svidetelstvo', 
count_list_sved = '$count_svidetelstvo', 
info_uved = '$info_uved', 
count_list_report_medacr = '$count_medacr', 
getter = '$getter', 
delo = '$delo', 
date_delo = '$date_delo', 
dop_info = '$dop_info' 
WHERE id_application = '$id_application';");
} else {
    mysqli_query($con, "insert into rkk (id_application, date_reg, count_list_app,tech_osn, raspisanie, ucomplect, 
                 report_samoacred, dop_sved,	id_user,	predstavitel,	perv_vtor,	reg_index,	date_index_povt_app,
                 info_napr_zapr,	info_sogl,	protokol_zased,	date_protokol	,info_vozvr,	info_otzyv,
                 admin_resh,	date_admin_resh	,count_list_admin,	`result`,	svidetelstvo,	date_sved	,
                 count_list_sved	,info_uved	,	count_list_report_medacr,	getter	,delo	,date_delo	,dop_info) 
                            values ('$id_application','$dateRegistr','$countlist','$tech_osn_rkk','$stat_rasp','$ucomp_rkk','$report_samoacred',
                                    '$dop_sved','$prinyal_zayav', '$predst_rkk', '$perv_vtor_zayav', '$reg_index','$povtor_index','$info_napr_zapr','$info_sogl',
                                    '$protolol_zasedanie', '$date_zasedanie','$info_vozvrat','$info_otzyv','$admin_resh','$date_admin_resh','$count_admin_resh',
                                    '$resultat','$svidetelstvo','$date_svidetelstvo','$count_svidetelstvo','$info_uved','$count_medacr','$getter','$delo','$dop_info')");

}

?>