<?php

include "../../ajax/connection.php";

class User{
    public $id_user ,$username;

}

$id_user = $_COOKIE['id_user'];
$query = "SELECT u.id_user, u.username, u.id_role
FROM users u 
left outer join users u2 on u2.id_user='$id_user'
WHERE 
u.predsedatel = 1 
and ((u2.id_role < 3 ) 
or (u2.id_role > 2 and u.id_role=u2.id_role )) ";

$rez = mysqli_query($con, $query) or die("Ошибка " . mysqli_error($con));
$predsedateli = array();
for ($data = []; $row = mysqli_fetch_assoc($rez); $data[] = $row);
foreach ($data as $app) {
    $user = new User();
    $user->id_user = $app['id_user'];
    $user->username = $app['username'];
    array_push($predsedateli,$user);
}

echo json_encode($predsedateli);
?>
