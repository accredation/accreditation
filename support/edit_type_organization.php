<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="../assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="../assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="../assets/vendors/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="../assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../dist/css/global.css" >
    <!-- End layout styles -->
    <link rel="shortcut icon" href="../assets/images/logo-rnpcmt.png" />

    <link rel="stylesheet" href="../dist/css/dataTables.bootstrap4.min.css">

    <script src="../dist/js/jquery-3.5.1.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    <style>
        .hiden{
            display: none;
        }
    </style>
</head>

<body >

<?php
include '../ajax/connection.php';
class Types{
    public $id_type, $typeName;
}
$query = "SELECT * FROM spr_type_organization";
$result=mysqli_query($con, $query) or die ( mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
$arrayTypes = array();

foreach ($data as $type) {
    $newType = new Types();
    $newType->id_type = $type['id_type'];
    $newType->typeName = $type['type_name'];
    array_push($arrayTypes, $newType);
}
$query = "SELECT u.id_user, u.`username` as usname, u.password, u.email, u.login, `name`, u.last_time_online, u.last_page, uz.`id_type`, type_name, u.last_time_session, u.online, u.active, u.kod, uz.oblast as obl
FROM users u
left outer join roles r on u.id_role=r.id_role
left outer join uz uz on uz.id_uz=u.id_uz
left outer join spr_type_organization st on uz.id_type=st.id_type";

$result=mysqli_query($con, $query) or die ( mysqli_error($con));
for ($data = []; $row = mysqli_fetch_assoc($result); $data[] = $row);
?>


<div class="col-12">

    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Пользователи</h3>
        </div>
        <!-- /.card-header -->
        <div class="card-body">
            <button type="button" class="btn btn-light mb-4" data-toggle="modal" data-target="#modalAddUser">Добавить пользователя</button>
            <table id="example1" class="table table-striped table-bordered">

                <thead>
                <tr>
                    <th>Пользователь</th>
                    <th>Логин</th>
                    <th>Email</th>
                    <th>Роль</th>
                    <th>Тип</th>
                    <th>Пароль</th>
                    <th>Статус</th>
                    <th>Код</th>
                    <th>Регион</th>
                </tr>
                </thead>
                <tbody>

                <?php

                foreach ($data as $user) {

                    ?>

                    <tr style="cursor: pointer;">

                        <td><?= $user['usname'] ?></td>
                        <td id="log<?= $user['id_user'] ?>" contenteditable="true" oncontextmenu="changeLogin(this)"><?= $user['login'] ?></td>
                        <td id="mail<?= $user['id_user'] ?>" contenteditable="true" oncontextmenu="changeMail(this)"><?= $user['email'] ?></td>
                        <td ><?= $user['name'] ?></td>
                        <td><select name="" id="types<?= $user['id_user'] ?>" onchange="changeType(this)">
                                <option value="<?= $user['id_type'] ?>"><?= $user['id_type'] ? $user['type_name'] : "Не выбрано" ?></option>
                                <?php foreach ($arrayTypes as $t){ ?>
                                    <option value="<?=$t->id_type?>"><?=$t->typeName?></option>
                                <?php } ?>
                            </select></td>
                        <td id="pass<?= $user['id_user'] ?>" contenteditable="true" oncontextmenu="changePassword(this)"><?= $user['password'] ?></td>
                        <td id="active<?= $user['id_user'] ?>"  ><input onchange="changeActive(this)" type="checkbox" <?= $user['active'] === "1" ? 'checked' : ''?>></td>
                        <td ><?= $user['kod'] ?></td>
                        <td > <?php

                            switch ($user['obl']) {
                                case 0:
                                    echo "Все";
                                    break;
                                case 1:
                                    echo "Администратор";
                                    break;
                                case 2:
                                    echo "Аккредитатор";
                                    break;
                                case 3:
                                    echo "Пользователь";
                                    break;
                                case 4:
                                    echo "Минздрав";
                                    break;
                                case 5:
                                    echo "Аккредитация Минск";
                                    break;
                                case 6:
                                    echo "Аккредитация Минская область";
                                    break;
                                case 7:
                                    echo "Аккредитация Гомель";
                                    break;
                                case 8:
                                    echo "Аккредитация Могилев";
                                    break;
                                case 9:
                                    echo "Аккредитация Витебск";
                                    break;
                                case 10:
                                    echo "Аккредитация Гродно";
                                    break;
                                case 11:
                                    echo "Аккредитация Брест";
                                    break;
                                case 12:
                                    echo "Техподдержка";
                                    break;
                                case 14:
                                    echo "ГУЗО_МИНЗДРАВ";
                                    break;
                                case 15:
                                    echo "подпользователь";
                                    break;
                                default:
                                    echo "Неизвестное значение";
                            }
                            ?>
                        </td>
                    </tr>
                    <?php
                }
                ?>

                </tbody>
                <tfoot>
                <tr>
                    <th>Пользователь</th>
                    <th>Логин</th>
                    <th>Email</th>
                    <th>Роль</th>
                    <th>Тип</th>
                    <th>Пароль</th>
                    <th>Статус</th>
                    <th>Код</th>

                </tr>
                </tfoot>
            </table>
        </div>
        <!-- /.card-body -->
    </div>


    <!-- /.card -->
</div>

<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="modalAddUser" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Добавить пользователя</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="user-name" class="col-form-label">Имя пользователя</label>
                    <input type="text" class="form-control" id="user-name">
                </div>
                <div class="form-group">
                    <label for="login-name" class="col-form-label">Логин</label>
                    <input type="text" class="form-control" id="login-name">
                </div>
                <div class="form-group">
                    <label for="password" class="col-form-label">Пароль</label>
                    <input type="text" class="form-control" id="password">
                </div>
                <div class="form-group">
                    <label for="email" class="col-form-label">Почта</label>
                    <input type="email" class="form-control" id="email" placeholder="name@example.com">
                </div>
                <div class="form-group">
                    <label for="roles">Роль</label>
                    <select class="form-control" id="roles">
                        <?php
                            $res = mysqli_query($con, "select * from roles where id_role = 14");
                            while($row = mysqli_fetch_assoc($res)){
                                echo "<option value='{$row['id_role']}'>{$row['name']}</option>";
                            }
                        ?>
                    </select>
                </div>


            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                <button type="button" class="btn btn-primary" onclick="addUser()">Добавить</button>
            </div>
        </div>
    </div>
</div>

<script src="../assets/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="../assets/vendors/chart.js/Chart1.min.js"></script>
<script src="../assets/vendors/jquery-circle-progress/js/circle-progress.min.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="../assets/js/off-canvas.js"></script>
<script src="../assets/js/hoverable-collapse.js"></script>
<script src="../assets/js/misc.js"></script>
<!-- endinject -->
<!-- Custom js for this page -->
<script src="../assets/js/dashboard.js"></script>
<script src="../dist/js/add_history_action.js"></script>


<script src="../dist/js/jquery.dataTables.min.js"></script>
<script>
    function addUser(){
        let name = $("#user-name").val();
        let login = $("#login-name").val();
        let password = $("#password").val();
        let email = $("#email").val();
        let role = $("#roles").val();

        $.ajax({
            url:"../ajax/addUser.php",
            method:"POST",
            data:{name:name, login:login, password:password, email:email, role:role}

        }).done(function (response){
            console.log(response);
            alert("Пользователь добавлен!");
            location.reload();
        }).fail(function(jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 501) {
                alert("Пользователь с таким логином уже существует");
            } else {
                console.error("Ошибка при выполнении запроса: " + textStatus, errorThrown);
                alert("Произошла ошибка при выполнении запроса. Пожалуйста, попробуйте позже.");
            }
        });
    }

    function getCookie(name) {
        let matches = document.cookie.match(new RegExp("(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    if (getCookie("login") === "hancharou@rnpcmt.by") {
        let card = document.getElementsByClassName("card hiden")[0];
        let card1 = document.getElementsByClassName("card hiden")[1];
        card.classList.remove("hiden");
        card1.classList.remove("hiden");
    }

    function changeType(el){
        let id = el.id.substring(5);
        let id_type = el.options[el.selectedIndex].value;
        $.ajax({
            url:"update_type_organization.php",
            method:"POST",
            data:{id_user:id, id_type:id_type}

        }).done(function (response){
            console.log("id_us", id);
            console.log("id_type", id_type);
        })
    }

    function changePassword(thisTd){
        let tr = thisTd.parentElement;
        let login = tr.children[1].innerText;
        let newPass = thisTd.innerText;
        let confirmation = confirm("Вы уверены, что хотите изменить пароль пользователя " + login + " на " + newPass + "?");
        if(confirmation) {
            let id = thisTd.id.substring(4);
            console.log("newPass", newPass);
            console.log("id", id);
            addHistoryChangePassword(id, newPass, 1, "Изменение пароля у " + login + " на пароль " + newPass);
        }else{
            return false;
        }
    }

    function changeLogin(thisTd){
        let tr = thisTd.parentElement;
        let login = tr.children[1].innerText;
        let confirmation = confirm("Вы уверены, что хотите изменить логин пользователя на " + login + "?");
        if(confirmation) {
            let id = thisTd.id.substring(3);
            addHistoryChangeLogin(id, login, 1, "Изменение логина у " + login);
        }else{
            return false;
        }
    }

    function changeMail(thisTd){
        let tr = thisTd.parentElement;
        let login = tr.children[1].innerText;
        let mail = tr.children[2].innerText;
        let confirmation = confirm("Вы уверены, что хотите изменить email пользователя " + login + "?");
        if(confirmation) {
            let id = thisTd.id.substring(4);
            addHistoryChangeMail(id, mail, 1, "Изменение email у " + login);
        }else{
            return false;
        }
    }

    function closeSess(idUser){
        $.ajax({
            url: "closeSession.php",
            method: "GET",
            data: {id_user:idUser }

        }).done(function (response){
            alert("Сессия закрыта");
        })
    }

    function changeActive(el){
        let idUser = el.parentElement.id.substring(6);
        let checked = el.checked ? 1 : 0;
        $.ajax({
            url: "../ajax/changeActive.php",
            method: "POST",
            data: {id_user:idUser, checked: checked }

        }).done(function (response){

        })
    }
</script>


</body>
</html>
