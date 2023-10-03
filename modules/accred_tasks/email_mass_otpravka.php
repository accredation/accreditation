<?php
include "../../connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userIds = $_POST['userIds'] ?? '';

    $query = "SELECT login FROM users WHERE id_user IN ($userIds)";
    $result = mysqli_query($con, $query) or die(mysqli_error($con));

    $addresses = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $addresses[] = $row['login'];
    }


    $textSubj = "Это автоматическое уведомление подтверждающее действие в информационной системе";
    $text = "В ИС «Медицинская аккредитация» внесены данные в график работы медицинской аккредитации.\n
        Вы включены в состав комиссии по медицинской аккредитации. \n
      Для ознакомления необходимо открыть страницу «График работы» в ИС «Медицинская аккредитация»";
    $email = "medaccr@rnpcmt.by";
    $headers = 'From:'. $email . "\r\n" .
        'Content-type: text/html; charset=utf-8' . "\r\n".
        'X-Mailer: PHP/' . phpversion();
    foreach ($addresses as $address) {
        if (mail($address, $textSubj, $text,$headers)){
            echo "Сообщение успешно отправлено";
        } else {
            echo "При отправке сообщения возникли ошибки";
        }
    }

    echo count($addresses);
}

?>
