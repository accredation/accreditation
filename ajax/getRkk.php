<?php
include "connection.php";
$id_application = $_GET['id_application'];

$rez = mysqli_query($con, "select * from rkk where id_application = '$id_application'");
if (mysqli_num_rows($rez) == 1) {
   $row = mysqli_fetch_assoc($rez);
    $date_reg = $row['date_reg']; // Предположим, что $row['date_reg'] содержит дату в формате "гггг-мм-дд"
    $formatted_date_reg = date("d.m.Y", strtotime($date_reg)); // Преобразование формата даты
    $responce['date_reg'] = $formatted_date_reg; // Присваиваем отформатированную дату обратно в $responce['date_reg']
    $responce['id_rkk'] = $row['id_rkk'];
   $responce['date_reg'] = $row['date_reg'];
   $responce['count_list_app'] = $row['count_list_app'];
   $responce['tech_osn'] = $row['tech_osn'];
   $responce['raspisanie'] = $row['raspisanie'];
   $responce['ucomplect'] = $row['ucomplect'];
   $responce['report_samoacred'] = $row['report_samoacred'];
   $responce['dop_sved'] = $row['dop_sved'];
   $responce['id_user'] = $row['id_user'];
   $responce['predstavitel'] = $row['predstavitel'];
   $responce['perv_vtor'] = $row['perv_vtor'];
   $responce['date_index_povt_app'] = $row['date_index_povt_app'];
   $responce['info_napr_zapr'] = $row['info_napr_zapr'];
   $responce['info_sogl'] = $row['info_sogl'];
   $responce['protokol_zased'] = $row['protokol_zased'];
   $responce['date_protokol'] = $row['date_protokol'];
   $responce['info_vozvr'] = $row['info_vozvr'];
   $responce['info_otzyv'] = $row['info_otzyv'];
   $responce['date_admin_resh'] = $row['date_admin_resh'];
   $responce['count_list_admin'] = $row['count_list_admin'];
   $responce['result'] = $row['result'];
   $responce['svidetelstvo'] = $row['svidetelstvo'];
   $responce['date_sved'] = $row['date_sved'];
   $responce['count_list_sved'] = $row['count_list_sved'];
   $responce['info_uved'] = $row['info_uved'];
   $responce['count_list_report_medacr'] = $row['count_list_report_medacr'];
   $responce['getter'] = $row['getter'];
   $responce['delo'] = $row['delo'];
   $responce['date_delo'] = $row['date_delo'];
   $responce['dop_info'] = $row['dop_info'];
   $responce['po_n'] = $row['po_n'];
   $responce['delo_listov'] = $row['delo_listov'];
   $responce['checkboxValueGuzo'] = $row['checkboxValueGuzo'];

   echo json_encode($responce);
}
else  {
    echo "no data";
}

?>