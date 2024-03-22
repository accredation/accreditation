<?php
include "connection.php";
$razdel = $_POST['razdel'];
$fileName = $_POST['fileName'];
$fileExtension = $_POST['fileExtension'];

$nameRazdel = "";
switch ($razdel) {
    case 1:
        $nameRazdel = "Регламентирующие документы";
        break;
    case 2:
        $nameRazdel = "Формы обязательных документов";
        break;
    case 3:
        $nameRazdel = "Обучающие материалы и видео";
        break;
}

switch ($fileExtension) {
    case "docx":
        $fileExtension = "WORD";
        $imgName = "word-icon.png";
        break;
    case "doc":
        $fileExtension = "WORD";
        $imgName = "word-icon.png";
        break;
    case "pdf":
        $fileExtension = "PDF";
        $imgName = "pdf_icon.png";
        break;
    case "xls":
        $fileExtension = "EXEL";
        $imgName = "excel.png";
        break;
    case "xlsx":
        $fileExtension = "EXEL";
        $imgName = "excel.png";
        break;
    case "ppt":
        $fileExtension = "PPTX";
        $imgName = "pptx-icon.png";
        break;
    case "pptx":
        $fileExtension = "PPTX";
        $imgName = "pptx-icon.png";
        break;
    case "zip":
        $fileExtension = "ZIP";
        $imgName = "zip-file.png";
        break;
}
if (!file_exists("../documentation/".$nameRazdel."/")) {
    mkdir("../documentation/".$nameRazdel."/", 0777, true);
}
if (isset($_FILES['docFile']['name'])) {
    $file_name = $_FILES['docFile']['name'];
    $file_tmp = $_FILES['docFile']['tmp_name'];

    move_uploaded_file($file_tmp, "../documentation/".$nameRazdel."/" . $file_name);

    $insertquery =
        "Insert into documents(doc_name, doc_name_with_type, razdel, doc_type, img_name, str_num) values('$fileName', '$file_name', '$razdel', '$fileExtension', '$imgName', '20')";

    $result = mysqli_query($con, $insertquery) or die("Ошибка " . mysqli_error($con));


}
?>