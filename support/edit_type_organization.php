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
$query = "SELECT u.id_user, u.`username` as usname, u.password, u.email, u.login, `name`, u.last_time_online, u.last_page, uz.`id_type`, type_name, u.last_time_session, u.online
FROM users u
left outer join roles r on u.id_role=r.id_role
left outer join uz uz on uz.id_uz=u.id_uz
left outer join spr_type_organization st on uz.id_type=st.id_type
where u.active = 1";
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
            <table id="example1" class="table table-striped table-bordered">

                <thead>
                <tr>
                    <th>Пользователь</th>
                    <th>Логин</th>
                    <th>Email</th>
                    <th>Роль</th>
                    <th>Тип</th>
                    <th>Пароль</th>
                </tr>
                </thead>
                <tbody>

                <?php

                foreach ($data as $user) {

                    ?>

                    <tr style="cursor: pointer;">

                        <td><?= $user['usname'] ?></td>
                        <td><?= $user['login'] ?></td>
                        <td><?= $user['email'] ?></td>
                        <td ><?= $user['name'] ?></td>
                        <td><select name="" id="types<?= $user['id_user'] ?>" onchange="changeType(this)">
                                <option value="<?= $user['id_type'] ?>"><?= $user['id_type'] ? $user['type_name'] : "Не выбрано" ?></option>
                                <?php foreach ($arrayTypes as $t){ ?>
                                    <option value="<?=$t->id_type?>"><?=$t->typeName?></option>
                                <?php } ?>
                            </select></td>
                        <td id="pass<?= $user['id_user'] ?>" contenteditable="true" oncontextmenu="changePassword(this)"><?= $user['password'] ?></td>

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
                </tr>
                </tfoot>
            </table>
        </div>
        <!-- /.card-body -->
    </div>


    <!-- /.card -->
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

    function closeSess(idUser){
        $.ajax({
            url: "closeSession.php",
            method: "GET",
            data: {id_user:idUser }

        }).done(function (response){
            alert("Сессия закрыта");
        })
    }
</script>


</body>
</html>
