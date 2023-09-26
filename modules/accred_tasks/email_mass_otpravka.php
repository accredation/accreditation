<?php
include "../../connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userIds = $_POST['userIds'] ?? '';

    $query = "SELECT login FROM users WHERE id_user IN ($userIds)";
    $result = mysqli_query($con, $query) or die(mysqli_error($con));

    $addresses = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $addresses[] = $row['email'];
    }




    foreach ($addresses as $address) {
        $textSubj = "Поступил новый вопрос в ТП мед.аккредитации";
        $text = "ММММ";
        $email = "Sydykav@rnpcmt.by";
        $headers = 'From:'. $email . "\r\n" .
            'Content-type: text/html; charset=utf-8' . "\r\n".
            'X-Mailer: PHP/' . phpversion();

        if (mail($address, $textSubj, $text,$headers)){
            echo "Сообщение успешно отправлено";
        } else {
            echo "При отправке сообщения возникли ошибки";
        }
    }

    echo count($addresses);
}

?>
